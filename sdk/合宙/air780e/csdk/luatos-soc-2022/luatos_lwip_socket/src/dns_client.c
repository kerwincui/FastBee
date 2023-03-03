
#include "luat_mcu.h"
#include "common_api.h"
#include "platform_def.h"
#include "dns_def.h"
#include "ctype.h"
#include "luat_network_adapter.h"
#define dnsONE_QUESTION                 0x0001
#define dnsFLAG_QUERY_RESPONSE_BIT      0x8000
#define dnsFLAG_OPERATION_CODE_BITS     0x7800
#define dnsFLAG_TRUNCATION_BIT          0x0200
#define dnsFLAG_RESPONSE_CODE_BITS      0x000f
#define dnsOUTGOING_FLAGS               0x0100 /* Standard query. */
#define dnsTYPE_IPV4                    0x0001 /* A record (host address. */
#define dnsCLASS                        0x0001 /* IN */
#define dnsRX_FLAGS_MASK                0x800f /* The bits of interest in the flags field of incoming DNS messages. */
#define dnsEXPECTED_RX_FLAGS            0x8000 /* Should be a response, without any errors. */
#define dnsTYPE_IPV6                    0x001C
#define dnsNAME_IS_OFFSET               ( ( uint8_t ) 0xc0 )
#define MAX_DOMAIN_LEN 255
#define MAX_CHARACTER_NUM_PER_LABEL  63
#define DNS_TO_BASE (900)
#define DNS_TRY_MAX	(3)
#ifdef LUAT_USE_LWIP
#define GetSysTickMS luat_mcu_tick64_ms
#endif

//extern void DBG_Printf(const char* format, ...);
//extern void DBG_HexPrintf(void *Data, unsigned int len);
//#ifdef LUAT_LOG_NO_NEWLINE
//#define DBG(x,y...)		DBG_Printf("%s %d:"x, __FUNCTION__,__LINE__,##y)
//#define DBG_ERR(x,y...)		DBG_Printf("%s %d:"x, __FUNCTION__,__LINE__,##y)
//#else
//#define DBG(x,y...)		DBG_Printf("%s %d:"x"\r\n", __FUNCTION__,__LINE__,##y)
//#define DBG_ERR(x,y...)		DBG_Printf("%s %d:"x"\r\n", __FUNCTION__,__LINE__,##y)
//#endif


typedef struct
{
	llist_head node;
	Buffer_Struct uri_buf;	//静态不用释放
	luat_dns_ip_result ip_result[MAX_DNS_IP];
	uint64_t timeout_ms;
	uint16_t session_id;
	uint8_t retry_cnt;
	uint8_t dns_cnt;
	uint8_t ip_nums;
	uint8_t is_done;
	uint8_t is_ipv6;
}dns_process_t;

typedef struct xDNSMessage
{
    uint16_t usIdentifier;
    uint16_t usFlags;
    uint16_t usQuestions;
    uint16_t usAnswers;
    uint16_t usAuthorityRRs;
    uint16_t usAdditionalRRs;
}xDNSMessage_t;

static int32_t dns_find_process(void *pData, void *pParam)
{
	uint16_t session_id = (uint32_t)pParam;
	dns_process_t *process = (dns_process_t *)pData;
	if (process->session_id == session_id)
	{
		return LIST_FIND;
	}
	return LIST_PASS;
}

static int32_t dns_skip_name_field(Buffer_Struct *buf)
{

	if( ( buf->Data[buf->Pos] & dnsNAME_IS_OFFSET ) == dnsNAME_IS_OFFSET )
	{
		/* Jump over the two byte offset. */
		buf->Pos += sizeof( uint16_t );
	}
	else
	{
		/* pucByte points to the full name.  Walk over the string. */
		while( buf->Data[buf->Pos] != 0x00 )
		{
			/* The number of bytes to jump for each name section is stored in the byte
			before the name section. */
			buf->Pos += ( buf->Data[buf->Pos] + 1 );
			if (buf->Pos >= buf->MaxLen)
			{
				return -1;
			}
		}
		buf->Pos++;
	}
	if (buf->Pos >= buf->MaxLen)
	{
		return -1;
	}
	return 0;
}

static int32_t dns_set_result(void *pData, void *pParam)
{
	int i;
	dns_process_t *process = (dns_process_t *)pParam;
	luat_dns_require_t *require = (luat_dns_require_t *)pData;
	if (!require->result)
	{
		if (process->uri_buf.Pos == require->uri.Pos)
		{
			if (!memcmp(process->uri_buf.Data, require->uri.Data, require->uri.Pos))
			{
				require->result = -1;
				if (process->ip_nums)
				{
					for(i = 0; i < process->ip_nums; i++)
					{
						require->ip_result[i] = process->ip_result[i];
					}
					require->result = process->ip_nums;
				}
			}
		}
	}

	return LIST_PASS;
}

int32_t dns_get_ip(dns_client_t *client, Buffer_Struct *buf, uint16_t answer_num, dns_process_t *process)
{
	uint16_t i, usTemp;
	luat_ip_addr_t ip_addr = {0};

	uint32_t ttl;
	uint8_t error = 0;
	if (process)
	{
		process->ip_nums = 0;
	}
	for(i = 0; i < answer_num; i++)
	{
		if (dns_skip_name_field(buf) != ERROR_NONE)
		{
			error = 1;
			goto NET_DNSGETIP_DONE;
		}
		usTemp = BytesGetBe16(buf->Data + buf->Pos);
		switch (usTemp)
		{
		case dnsTYPE_IPV4:
			if ( (buf->Pos + 14) > buf->MaxLen)
			{
				error = 1;
				goto NET_DNSGETIP_DONE;
			}
			buf->Pos += 4;
			ttl = BytesGetBe32FromBuf(buf);
			usTemp = BytesGetBe16FromBuf(buf);
			if ( (buf->Pos + usTemp) > buf->MaxLen)
			{
				error = 1;
				goto NET_DNSGETIP_DONE;
			}
#ifdef LUAT_USE_LWIP
			ip_addr.type = IPADDR_TYPE_V4;
			ip_addr.u_addr.ip4.addr = BytesGetLe32(buf->Data + buf->Pos);
#else
			ip_addr.ipv4 = BytesGetLe32(buf->Data + buf->Pos);
			ip_addr.is_ipv6 = 0;
#endif
			buf->Pos += usTemp;
			if (ttl > 0)
			{
				if (process && (process->ip_nums < MAX_DNS_IP))
				{
					process->ip_result[process->ip_nums].ip = ip_addr;
					process->ip_result[process->ip_nums].ttl_end = ttl + ((uint32_t)(GetSysTickMS()/1000));
					process->ip_nums++;
				}
			}
			break;
		case dnsTYPE_IPV6:
			if ( (buf->Pos + 14) > buf->MaxLen)
			{
				error = 1;
				goto NET_DNSGETIP_DONE;
			}
			buf->Pos += 4;
			ttl = BytesGetBe32FromBuf(buf);
			usTemp = BytesGetBe16FromBuf(buf);
			if ( (buf->Pos + usTemp) > buf->MaxLen)
			{
				error = 1;
				goto NET_DNSGETIP_DONE;
			}
#ifdef LUAT_USE_LWIP
			memcpy(ip_addr.u_addr.ip6.addr, buf->Data + buf->Pos, sizeof( uint32_t ) * 4);
//			ip_addr.u_addr.ip6.zone = 0;
			ip_addr.type = IPADDR_TYPE_V6;
#else
			memcpy(ip_addr.ipv6_u8_addr, buf->Data + buf->Pos, sizeof( uint32_t ) * 4);
			ip_addr.is_ipv6 = 1;
#endif
			if (ttl > 0)
			{
				if (process && (process->ip_nums < MAX_DNS_IP))
				{
					process->ip_result[process->ip_nums].ip = ip_addr;
					process->ip_result[process->ip_nums].ttl_end = ttl + ((uint32_t)(GetSysTickMS()/1000));
					process->ip_nums++;
				}
			}
			buf->Pos += usTemp;
			break;
		default:
			//DBG("%04x",usTemp);
			buf->Pos += 8;
			usTemp = BytesGetBe16FromBuf(buf);
			buf->Pos += usTemp;
			//OS(Dump)(buf->Data + buf->Pos, usTemp);
			break;
		}
	}
NET_DNSGETIP_DONE:
	if (error)
	{

		return -1;
	}
	else
	{
		if (process)
		{
			process->is_done = 1;
			llist_traversal(&client->require_head, dns_set_result, process);
		}
		return 0;
	}


}



uint8_t dns_check_uri(const char *uri, uint32_t uri_len)
{
    uint32_t dot_num = 0;

    uint32_t i = 0;
    uint32_t label_len = 0;
    char uri_last = 0;

    if(uri ==NULL)
    {
        return 0;
    }

    if(uri_len == 0 || uri_len > MAX_DOMAIN_LEN)  //domain must less than 255
    {
         return 0;
    }

    if (!isalpha((int)uri[0])) // domain must start with a letter
    {
        return 0;
    }

    uri_last = uri[uri_len - 1];
    if (!isalnum((int)uri_last))//end with a letter or digit
    {
         return 0;
    }

    for(i = 0; i < uri_len ; i++)
    {
        if(!(isalnum((int)uri[i]) || uri[i]== '.' || uri[i] == '-'))//must a~z or A~Z or 0~9 or . or -
        {
            return 0;
        }

        if( uri [i] == '.')
        {
             dot_num++;
             if((label_len > MAX_CHARACTER_NUM_PER_LABEL) || (0 == label_len)) //Label must be 63 characters or less
                 return 0;
             label_len = 0;
        }
        else
        {
            label_len++;
        }
    }
    if((label_len > MAX_CHARACTER_NUM_PER_LABEL) || (0 == dot_num))//the last label must be 63 characters or less
        return 0;

    return 1;

}


int32_t dns_make(dns_client_t *client, dns_process_t *process, Buffer_Struct *out)
{
	int Result;
	xDNSMessage_t MsgHead;
    uint8_t *pucStart, *pucByte;
//    uint16_t usRecordType;
//    uint16_t usClass = BSP_Swap16(dnsCLASS);
	if (process->dns_cnt >= MAX_DNS_SERVER)
	{
		return -ERROR_PERMISSION_DENIED;
	}
	out->Pos = sizeof(xDNSMessage_t) + 6 + process->uri_buf.Pos;


	memset(&MsgHead, 0, sizeof(MsgHead));
	MsgHead.usIdentifier = BSP_Swap16(process->session_id);
	MsgHead.usFlags = BSP_Swap16(dnsOUTGOING_FLAGS);
	MsgHead.usQuestions = BSP_Swap16(dnsONE_QUESTION);
	memcpy(out->Data, &MsgHead, sizeof(MsgHead));

    pucStart = out->Data + sizeof( MsgHead );

    /* Leave a gap for the first length bytes. */
    pucByte = pucStart + 1;

    /* Copy in the host name. */
    memcpy( ( char * ) pucByte, process->uri_buf.Data, process->uri_buf.Pos );

    /* Mark the end of the string. */
    pucByte += process->uri_buf.Pos;
    *pucByte = 0x00;

    /* Walk the string to replace the '.' characters with byte counts.
    pucStart holds the address of the byte count.  Walking the string
    starts after the byte count position. */
    pucByte = pucStart;

    do
    {
        pucByte++;

        while( ( *pucByte != 0x00 ) && ( *pucByte != '.' ) )
        {
            pucByte++;
        }

        /* Fill in the byte count, then move the pucStart pointer up to
        the found byte position. */
        *pucStart = ( uint8_t ) ( ( uint32_t ) pucByte - ( uint32_t ) pucStart );
        ( *pucStart )--;

        pucStart = pucByte;

    } while( *pucByte != 0x00 );
    pucByte++;
    /* Finish off the record. */

    if (process->is_ipv6)
    {
    	BytesPutBe16(pucByte, dnsTYPE_IPV6);
    }
    else
    {
    	BytesPutBe16(pucByte, dnsTYPE_IPV4);
    }
    pucByte += sizeof( uint16_t );
    BytesPutBe16(pucByte, dnsCLASS);
	process->timeout_ms = GetSysTickMS() + DNS_TO_BASE * (process->retry_cnt + 1);
    return ERROR_NONE;
}


static int32_t dns_check_process(void *pData, void *pParam)
{
	dns_process_t *process = (dns_process_t *)pData;
	Buffer_Struct *uri_buf = (Buffer_Struct *)pParam;
	if (uri_buf->Pos == process->uri_buf.Pos)
	{
		if (!memcmp(uri_buf->Data, process->uri_buf.Data, uri_buf->Pos))
		{
			return LIST_FIND;
		}
	}
	return LIST_PASS;
}

void dns_require(dns_client_t *client, const char *domain_name, uint32_t len, void *param)
{
	luat_dns_require_t *require = zalloc(sizeof(luat_dns_require_t));
	require->uri.Data = domain_name;
	require->uri.Pos = len;
	require->uri.MaxLen = len;
	require->param = param;
	dns_process_t *process = llist_traversal(&client->process_head, dns_check_process, &require->uri);
	// if no same proc
	if (!process)
	{
		process = zalloc(sizeof(dns_process_t));
		Buffer_StaticInit(&process->uri_buf, require->uri.Data, require->uri.Pos);
		process->uri_buf.Pos = require->uri.Pos;
		client->session_id++;
		if (!client->session_id)
		{
			client->session_id++;
		}
		process->session_id = client->session_id;
		llist_add_tail(&process->node, &client->process_head);
	}
	llist_add_tail(&require->node, &client->require_head);
}

void dns_require_ex(dns_client_t *client, const char *domain_name, void *param, uint8_t adapter_index)
{
	luat_dns_require_t *require = zalloc(sizeof(luat_dns_require_t));
	require->uri.Data = domain_name;
	require->uri.Pos = strlen(domain_name);
	require->uri.MaxLen = strlen(domain_name);
	require->param = param;
	require->adapter_index = adapter_index;
	dns_process_t *process = llist_traversal(&client->process_head, dns_check_process, &require->uri);
	// if no same proc
	if (!process)
	{
		process = zalloc(sizeof(dns_process_t));
		Buffer_StaticInit(&process->uri_buf, require->uri.Data, require->uri.Pos);
		process->uri_buf.Pos = require->uri.Pos;
		client->session_id++;
		if (!client->session_id)
		{
			client->session_id++;
		}
		process->session_id = client->session_id;
		llist_add_tail(&process->node, &client->process_head);
	}
	llist_add_tail(&require->node, &client->require_head);
}

static int32_t dns_clear_require(void *pData, void *pParam)
{
	luat_dns_require_t *require = (luat_dns_require_t *)pData;
	free(require->uri.Data);
	return LIST_DEL;
}


static int32_t dns_clear_process(void *pData, void *pParam)
{
	dns_process_t *process = (dns_process_t *)pData;
	if (pParam)
	{
		return process->is_done?LIST_DEL:LIST_PASS;
	}
	return LIST_DEL;
}


void dns_clear(dns_client_t *client)
{
//	uint64_t now_time = GetSysTickMS();
	llist_traversal(&client->process_head, dns_clear_process, NULL);
	llist_traversal(&client->require_head, dns_clear_require, NULL);
}

static int32_t dns_find_need_tx_process(void *pData, void *pParam)
{
	dns_process_t *process = (dns_process_t *)pData;
	if (!process->is_done && (process->timeout_ms < GetSysTickMS()))
	{
		return LIST_FIND;
	}
	return LIST_PASS;
}

void dns_run(dns_client_t *client, Buffer_Struct *in, Buffer_Struct *out, int *server_cnt)
{
	dns_process_t *process;
	int i;
	if (llist_empty(&client->process_head) && !llist_empty(&client->require_head))
	{
		dns_clear(client);
		if (client->is_run)
		{
			DBG("dns stop");
		}
		client->is_run = 0;
		return;
	}
	if (in)
	{
		xDNSMessage_t MsgHead;
		while ( (in->Pos + sizeof(MsgHead)) < in->MaxLen)
		{
			memcpy(&MsgHead, in->Data + in->Pos, sizeof(MsgHead));
			MsgHead.usIdentifier = BSP_Swap16(MsgHead.usIdentifier);
			MsgHead.usFlags = BSP_Swap16(MsgHead.usFlags);
			in->Pos += sizeof(MsgHead);
			process = llist_traversal(&client->process_head, dns_find_process, MsgHead.usIdentifier);
			if (process)
			{
				if ( MsgHead.usFlags & 0x8000)
				{
					MsgHead.usQuestions = BSP_Swap16(MsgHead.usQuestions);
					MsgHead.usAnswers = BSP_Swap16(MsgHead.usAnswers);
					MsgHead.usAuthorityRRs = BSP_Swap16(MsgHead.usAuthorityRRs);
					MsgHead.usAdditionalRRs = BSP_Swap16(MsgHead.usAdditionalRRs);

					for(i = 0; i < MsgHead.usQuestions; i++)
					{
						if (dns_skip_name_field(in) != ERROR_NONE)
						{
							goto NET_DNS_RX_OUT;
						}
						in->Pos += 4;
						if (in->Pos >= in->MaxLen)
						{
							goto NET_DNS_RX_OUT;
						}
					}
					if (!(MsgHead.usFlags & 0x000f))
					{
						if (dns_get_ip(client, in, MsgHead.usAnswers, process))
						{
							goto NET_DNS_RX_OUT;
						}
					}
					else
					{
						if (dns_get_ip(client, in, MsgHead.usAnswers, NULL))
						{
							goto NET_DNS_RX_OUT;
						}
					}

					if (dns_get_ip(client, in, MsgHead.usAuthorityRRs, NULL))
					{
						goto NET_DNS_RX_OUT;
					}

					if (dns_get_ip(client, in, MsgHead.usAdditionalRRs, NULL))
					{
						goto NET_DNS_RX_OUT;
					}
				}
				else
				{
					goto NET_DNS_RX_OUT;
				}

			}
		}
	}
	else if (out)
	{
NET_DNS_TX:

		process = llist_traversal(&client->process_head, dns_find_need_tx_process, NULL);
		if (!process)
		{
			goto NET_DNS_RX_OUT;
		}
		if (process->timeout_ms)
		{
			process->retry_cnt++;
			if (process->retry_cnt >= DNS_TRY_MAX)
			{
				process->retry_cnt = 0;
				process->dns_cnt++;
				if (process->dns_cnt >= MAX_DNS_SERVER)
				{
					process->ip_nums = 0;
					process->is_done = 1;
					llist_traversal(&client->require_head, dns_set_result, process);
					llist_del(&process->node);
					free(process);
					goto NET_DNS_TX;
				}
			}
		}
#ifdef LUAT_USE_LWIP
		while(0xff == client->dns_server[process->dns_cnt].type)
#else
		while(0xff == client->dns_server[process->dns_cnt].is_ipv6)
#endif
		{
			process->dns_cnt++;
			if (process->dns_cnt >= MAX_DNS_SERVER)
			{
				process->ip_nums = 0;
				llist_traversal(&client->require_head, dns_set_result, process);
				llist_del(&process->node);
				free(process);
				goto NET_DNS_TX;
			}
		}
		DBG("%.*s state %d use dns server%d, try %d", process->uri_buf.Pos, process->uri_buf.Data, process->is_done, process->dns_cnt, process->retry_cnt);
		process->is_done = 0;
		OS_InitBuffer(out, 512);
		dns_make(client, process, out);
		*server_cnt = process->dns_cnt;
	}

NET_DNS_RX_OUT:
	if (!llist_empty(&client->process_head))
	{
		llist_traversal(&client->process_head, dns_clear_process, 1);
	}

	if (llist_empty(&client->process_head) && llist_empty(&client->require_head))
	{
		if (client->is_run)
		{
			DBG("dns stop");
		}
		client->is_run = 0;
		return;
	}
	else
	{
		client->is_run = 1;
	}
	return ;
}

void dns_init_client(dns_client_t *client)
{
	int i;
	INIT_LLIST_HEAD(&client->process_head);
	INIT_LLIST_HEAD(&client->require_head);
	for(i = 0; i < MAX_DNS_SERVER; i++)
	{
		if (!client->is_static_dns[i])
		{
#ifdef LUAT_USE_LWIP
			client->dns_server[i].type = 0xff;
#else
			client->dns_server[i].is_ipv6 = 0xff;
#endif
		}
	}
}




