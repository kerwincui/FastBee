/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: sntp.c
 *
 *  Description: sntp
 *
 *  Notes:
 *
******************************************************************************/
#include "lwip/opt.h"


#include "lwip/def.h"
#include "lwip/inet.h"
#include "lwip/sockets.h"
#include "posix/netdb.h"
#include "lwip/api.h"
#include "lwip/priv/api_msg.h"
#include "lwip/udp.h"
#include "lwip/dns.h"
#include "lwip/ip_addr.h"

#include "appmgr.h"
#include "networkmgr.h"

#include DEBUG_LOG_HEADER_FILE
#if (defined CHIP_EC618) || (defined CHIP_EC718)
#include "slpman.h"
#elif defined CHIP_EC617
#include "slpman_ec617.h"
#endif
#include "sntp.h"



#define SNTP_THREAD_STACKSIZE 2048
#define SNTP_THREAD_PRIO 16

#define SNTP_ERR_KOD  1

/* SNTP protocol defines */
#define SNTP_MSG_LEN                48

#define SNTP_OFFSET_LI_VN_MODE      0
#define SNTP_LI_MASK                0xC0
#define SNTP_LI_NO_WARNING          0x00
#define SNTP_LI_LAST_MINUTE_61_SEC  0x01
#define SNTP_LI_LAST_MINUTE_59_SEC  0x02
#define SNTP_LI_ALARM_CONDITION     0x03 /* (clock not synchronized) */

#define SNTP_VERSION_MASK           0x38
#define SNTP_VERSION                (4/* NTP Version 4*/<<3)

/* SNTP operating modes: default is to poll using unicast.
   The mode has to be set before calling sntp_init(). */
#define SNTP_OPMODE_POLL            0
#define SNTP_OPMODE_LISTENONLY      1

#define SNTP_MODE_MASK              0x07
#define SNTP_MODE_CLIENT            0x03
#define SNTP_MODE_SERVER            0x04
#define SNTP_MODE_BROADCAST         0x05

#define SNTP_OFFSET_STRATUM         1
#define SNTP_STRATUM_KOD            0x00

#define SNTP_OFFSET_ORIGINATE_TIME  24
#define SNTP_OFFSET_RECEIVE_TIME    32
#define SNTP_OFFSET_TRANSMIT_TIME   40

/* number of seconds between 1900 and 1970 (MSB=1)*/
#define DIFF_SEC_1900_1970         (2208988800UL)
/* number of seconds between 1970 and Feb 7, 2036 (6:28:16 UTC) (MSB=0) */
#define DIFF_SEC_1970_2036         (2085978496UL)

#define SNTP_GET_SYSTEM_TIME(sec, us)     do { (sec) = 0; (us) = 0; } while(0)


/**
 * SNTP packet format (without optional fields)
 * Timestamps are coded as 64 bits:
 * - 32 bits seconds since Jan 01, 1970, 00:00
 * - 32 bits seconds fraction (0-padded)
 * For future use, if the MSB in the seconds part is set, seconds are based
 * on Feb 07, 2036, 06:28:16.
 */

#ifdef PACK_STRUCT_USE_INCLUDES
#include "arch/bpstruct.h"
#endif
PACK_STRUCT_BEGIN
struct SntpMsg {
  PACK_STRUCT_FLD_8(u8_t  li_vn_mode);
  PACK_STRUCT_FLD_8(u8_t  stratum);
  PACK_STRUCT_FLD_8(u8_t  poll);
  PACK_STRUCT_FLD_8(u8_t  precision);
  PACK_STRUCT_FIELD(u32_t root_delay);
  PACK_STRUCT_FIELD(u32_t root_dispersion);
  PACK_STRUCT_FIELD(u32_t reference_identifier);
  PACK_STRUCT_FIELD(u32_t reference_timestamp[2]);
  PACK_STRUCT_FIELD(u32_t originate_timestamp[2]);
  PACK_STRUCT_FIELD(u32_t receive_timestamp[2]);
  PACK_STRUCT_FIELD(u32_t transmit_timestamp[2]);
} PACK_STRUCT_STRUCT;
PACK_STRUCT_END
#ifdef PACK_STRUCT_USE_INCLUDES
#include "arch/epstruct.h"
#endif

typedef struct SntpConfig_Tag{
	CBFuncEx_t callback;
	void *user_param;
    UINT16  serverPort;
    UINT16  autoSync;
    UINT8 cid;
    UINT8 rsvd;
    CHAR serverAddr[DNS_MAX_NAME_LENGTH];
}SntpConfig;


static BOOL   sntpIsOngoing = FALSE;
static sys_thread_t sntpThread = NULL;
static BOOL  sntpTerminalFlag = FALSE;
static SntpConfig gSntpConfig;

/** Saves the last timestamp sent (which is sent back by the server)
 * to compare against in response */
static UINT32 sntpLastTimeStampSent[2];


void SntpCallResultCallback(UINT32 result, UINT32 seconds, UINT32 us)
{
	sntp_result_t ntp_result = {
			.succ = !result,
			.sec = seconds,
			.us = us};
    DBG("result %u", result);
    if (gSntpConfig.callback)
    {
    	gSntpConfig.callback(&ntp_result, gSntpConfig.user_param);
    }
}


BOOL SntpRecvResponse(struct SntpMsg *response, UINT32 *seconds, UINT32 *useconds)
{
    UINT8 mode;
    UINT8 stratum;
    UINT32 rxSecs;
    int is1900Based;

    if(response == NULL || seconds == NULL || useconds == NULL)
    {
        DBG("invalid parameter");
        return FALSE;
    }

    //init seconds and useconds
    *seconds = 0;
    *useconds = 0;

    //parse the sntp response message
    mode = response->li_vn_mode;
    mode &= SNTP_MODE_MASK;

    /* if this is a SNTP response... */
    if (mode == SNTP_MODE_SERVER || mode == SNTP_MODE_BROADCAST)
    {

        stratum = response->stratum;

        if (stratum == SNTP_STRATUM_KOD)
        {
       /* Kiss-of-death packet. Use another server or increase UPDATE_DELAY. */
        	DBG("Received Kiss-of-Death");
        }
        else
        {
          /* check originate_timetamp against sntp_last_timestamp_sent */
            if ((response->originate_timestamp[0] != sntpLastTimeStampSent[0]) ||
                (response->originate_timestamp[1] != sntpLastTimeStampSent[1]))
            {
            	DBG("Invalid originate timestamp in response");

            }
            else
            {
               /* correct answer */
                rxSecs = ntohl(response->receive_timestamp[0]);
                is1900Based = ((rxSecs & 0x80000000) != 0);
                *seconds = is1900Based ? (rxSecs - DIFF_SEC_1900_1970) : (rxSecs + DIFF_SEC_1970_2036);
                *useconds = ntohl(response->receive_timestamp[1]) / 4295;
                DBG("correct response seconds %u,useconds %u", *seconds, *useconds);
                return TRUE;
            }
       }
    }
    else
    {
    	DBG("Invalid mode in response: %u", mode);

    }

    return FALSE;
}


BOOL SntpSendRequest(INT32 sockFd, ip_addr_t *serverAddr, UINT16 ServerPort)
{
    struct sockaddr_storage to;
    INT32 ret;
    struct SntpMsg sntpReq;
    UINT32 sntpTimeSec;
    UINT32 sntpTimeUs;

    //check paramter
    if(sockFd < 0 || serverAddr == NULL)
    {
    	DBG("parameter invalid");
        return FALSE;
    }

    if (IP_IS_V4(serverAddr))
    {
        struct sockaddr_in *to4 = (struct sockaddr_in*)&to;
        to4->sin_len    = sizeof(struct sockaddr_in);
        to4->sin_family = AF_INET;
        to4->sin_port = htons(ServerPort);
        inet_addr_from_ip4addr(&to4->sin_addr, ip_2_ip4(serverAddr));
    }
    else if(IP_IS_V6(serverAddr))
    {
        struct sockaddr_in6 *to6 = (struct sockaddr_in6*)&to;
        to6->sin6_len    = sizeof(struct sockaddr_in6);
        to6->sin6_family = AF_INET6;
        to6->sin6_port = htons(ServerPort);
        inet6_addr_from_ip6addr(&to6->sin6_addr, ip_2_ip6(serverAddr));
    }
    else
    {
    	DBG("parameter invalid");
        return FALSE;
    }

    //prepare sntp request message

    memset(&sntpReq, 0, SNTP_MSG_LEN);
    sntpReq.li_vn_mode = SNTP_LI_NO_WARNING | SNTP_VERSION | SNTP_MODE_CLIENT;

    /* fill in transmit timestamp and save it in 'sntp_last_timestamp_sent' */
    SNTP_GET_SYSTEM_TIME(sntpTimeSec, sntpTimeUs);
    sntpLastTimeStampSent[0] = htonl(sntpTimeSec + DIFF_SEC_1900_1970);
    sntpReq.transmit_timestamp[0] = sntpLastTimeStampSent[0];
    /* we send/save us instead of fraction to be faster... */
    sntpLastTimeStampSent[1] = htonl(sntpTimeUs);
    sntpReq.transmit_timestamp[1] = sntpLastTimeStampSent[1];

    //send sntp client reqeust
    ret = sendto(sockFd, &sntpReq, SNTP_MSG_LEN, 0, (struct sockaddr*)&to, sizeof(to));
    if(ret == SNTP_MSG_LEN)
    {
    	DBG("send sntp request success");
        return TRUE;
    }
    else
    {
        DBG("send sntp request fail");
    }

    return FALSE;

}


static void SntpTask(void *arg)
{
    INT32 ret;
    UINT32 result = SNTP_RESULT_FAIL;
    slpManRet_t pmuRet = RET_UNKNOW_FALSE;
    UINT8 sntpPmuHdr = 0;
    ip_addr_t sntpServerAddr;
    INT32 sockFd = -1;
    UINT8 retryTimes = 0;
    UINT32 secondsResponse;
    UINT32 usecondsResponse;
    struct SntpMsg sntpResponse;
    NmAtiNetifInfo  netInfo;

    struct addrinfo hints, *target_address = PNULL;

    SntpConfig *sntpParam = PNULL;

    sntpParam = (SntpConfig*)arg;


    //check sntp parameter
    if (!sntpParam)
    {
    	DBG("start error, as sntp parameter invalid");
        sntpIsOngoing = FALSE;
        sntpThread = NULL;
        sntpTerminalFlag = FALSE;
        SntpCallResultCallback(SNTP_RESULT_PARAMTER_INVALID, 0, 0);
        osThreadExit();
    }

    //check pdp context status
    if(NetMgrGetNetInfo(sntpParam->cid, &netInfo) != NM_SUCCESS)
    {
        //ECOMM_TRACE(UNILOG_ATCMD_SOCK, sntp_netinfo_check_1, P_INFO, 1, "sntp get cid %d net info fail", sntpParam->cid);
        sntpIsOngoing = FALSE;
        sntpThread = NULL;
        sntpTerminalFlag = FALSE;
        SntpCallResultCallback(SNTP_RESULT_PDP_CONTEXT_STATUS_INVALID, 0, 0);
        osThreadExit();
    }
    else
    {
        if(netInfo.netStatus <= NM_NO_NETIF_OR_DEACTIVATED)
        {
            //ECOMM_TRACE(UNILOG_ATCMD_SOCK, sntp_netinfo_check_2, P_INFO, 2, "sntp get cid %d net status %d is invalid ", sntpParam->cid, netInfo.netStatus);
            sntpIsOngoing = FALSE;
            sntpThread = NULL;
            sntpTerminalFlag = FALSE;
            SntpCallResultCallback(SNTP_RESULT_PDP_CONTEXT_STATUS_INVALID, 0, 0);
            osThreadExit();
        }
    }


    /*
     * start sntp, sntp task don't allow to enter HIB/Sleep2 state before ping terminated
    */
    pmuRet = slpManApplyPlatVoteHandle("sntp", &sntpPmuHdr);
    OsaCheck(pmuRet == RET_TRUE, pmuRet, 0, 0);

    pmuRet = slpManPlatVoteDisableSleep(sntpPmuHdr, SLP_SLP2_STATE);
    OsaCheck(pmuRet == RET_TRUE, pmuRet, 0, 0);

    //get ping target address if target is url type
    if(ipaddr_aton((const char*)sntpParam->serverAddr, &sntpServerAddr) == 0)
    {
        memset(&hints, 0, sizeof(hints));
        hints.ai_family = AF_UNSPEC;
        //    hints.ai_socktype = SOCK_DGRAM;
        //    hints.ai_protocol = IPPROTO_UDP;
        if (getaddrinfowithcid(sntpParam->serverAddr, NULL, &hints, &target_address, sntpParam->cid) != 0)
        {
            //      OsaPrintf(P_ERROR, "Ping thread start error, can not get ip from url");
        	DBG("start error, can not get ip from url");

            result = SNTP_RESULT_URL_RESOLVE_FAIL;

            goto failAction;
        }
        else
        {
            if (target_address->ai_family == AF_INET)
            {
            	DBG("resolve url success, it is ipv4 type");
                struct sockaddr_in *to = (struct sockaddr_in *)target_address->ai_addr;
                IP_SET_TYPE(&sntpServerAddr, IPADDR_TYPE_V4);
                inet_addr_to_ip4addr(ip_2_ip4(&sntpServerAddr), &to->sin_addr);
            }
            else if (target_address->ai_family == AF_INET6)
            {
            	DBG("resolve url success, it is ipv6 type");
                struct sockaddr_in6 *to = (struct sockaddr_in6 *)target_address->ai_addr;
                IP_SET_TYPE(&sntpServerAddr, IPADDR_TYPE_V6);
                inet6_addr_to_ip6addr(ip_2_ip6(&sntpServerAddr),&to->sin6_addr);
            }
            else
            {
            	DBG("start error, get ip from url is invalid");

                freeaddrinfo(target_address);

                result = SNTP_RESULT_URL_RESOLVE_FAIL;

                goto failAction;

            }
            freeaddrinfo(target_address);
        }
    }

#if LWIP_SO_SNDRCVTIMEO_NONSTANDARD
    int timeout = SNTP_RCV_TIMEOUT;
#else
    struct timeval timeout;
    timeout.tv_sec = SNTP_RCV_TIMEOUT;
    timeout.tv_usec = 0;
#endif

    if (IP_IS_V4(&sntpServerAddr))
    {
        sockFd = lwip_socket(AF_INET, SOCK_DGRAM, IP_PROTO_UDP);
    }
    else
    {
        sockFd = lwip_socket(AF_INET6, SOCK_DGRAM, IP_PROTO_UDP);
    }

    if (sockFd < 0)
    {
    	DBG("socket create error");

        result = SNTP_RESULT_CREATE_CLIENT_SOCK_FAIL;

        goto failAction;
    }

    if(sntpParam->cid != LWIP_PS_INVALID_CID)
    {
        if(lwip_bind_cid(sockFd, sntpParam->cid) != 0)
        {
        	DBG("socket create with cid fail");

            result = SNTP_RESULT_CREATE_CLIENT_SOCK_FAIL;

            goto failAction;
        }
    }

    ret = lwip_setsockopt(sockFd, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout));

    if (ret != 0)
    {
    	DBG("setting receive timeout failed");

        result = SNTP_RESULT_CREATE_CLIENT_SOCK_FAIL;

        goto failAction;
    }

    LWIP_UNUSED_ARG(ret);

    while ((retryTimes < SNTP_RETRY_TIMES) && (sntpTerminalFlag == FALSE))
    {

        if (SntpSendRequest(sockFd, &sntpServerAddr, sntpParam->serverPort) == TRUE)
        {

        	DBG("send request success");

            memset(&sntpResponse, 0, sizeof(struct SntpMsg));
            ret = recv(sockFd, &sntpResponse, SNTP_MSG_LEN, 0);
            if(ret == SNTP_MSG_LEN)
            {

                if(SntpRecvResponse(&sntpResponse, &secondsResponse, &usecondsResponse) == TRUE)
                {
                	DBG("rcv response success");
                    result = SNTP_RESULT_OK;
                    break;
                }
                else
                {
                	DBG("rcv response, but process fail");
                }
            }
            else
            {
            	DBG("rcv response fail");
            }

         }
         else // send request fail, try again
         {
        	 DBG("send fail, need rty again");
            sys_msleep(SNTP_RESEND_REQUEST_DELAY);

        }

        retryTimes ++;

    }

    if(retryTimes >= SNTP_RETRY_TIMES)
    {
        result = SNTP_RESULT_RETRY_REACH_MAX_TIMES;
    }

    DBG("terminal");


failAction:

    sntpIsOngoing = FALSE;
    sntpThread = NULL;
    sntpTerminalFlag = FALSE;
    if(sockFd >= 0)
    {
        lwip_close(sockFd);
    }

    if(result != SNTP_RESULT_OK)
    {
        SntpCallResultCallback(result, 0, 0);
    }
    else
    {
        SntpCallResultCallback(SNTP_RESULT_OK, secondsResponse, usecondsResponse);
    }

    /* before ping task exit, should allow to enter HIB/Sleep2, and release hander */
    pmuRet = slpManPlatVoteEnableSleep(sntpPmuHdr, SLP_SLP2_STATE);
    OsaCheck(pmuRet == RET_TRUE, pmuRet, 0, 0);

    pmuRet = slpManGivebackPlatVoteHandle(sntpPmuHdr);
    OsaCheck(pmuRet == RET_TRUE, pmuRet, 0, 0);

    osThreadExit();
}

void SntpTerminat(void)
{
    if(sntpThread)
    {
        sntpTerminalFlag = TRUE;
    }
    return;
}


BOOL SntpInit(CHAR* serverAddr, UINT16 serverPort, BOOL autoSync, UINT8 cid, CBFuncEx_t callback, void *user_param)
{
    /* check the input */
    if(!serverAddr || strlen(serverAddr) > DNS_MAX_NAME_LENGTH || strlen(serverAddr) == 0)
    {
        DBG("PARAMETER invalid");
        return FALSE;
    }

    if (sntpIsOngoing)
    {
    	DBG("has run");

        return FALSE;
    }

    /* if set it in "sntp" task, maybe modify gSntpConfig for mutiple sntp request */
    sntpIsOngoing = TRUE;

    gSntpConfig.serverPort = serverPort?serverPort:SNTP_DEFAULT_PORT;
    gSntpConfig.cid = cid;
    gSntpConfig.autoSync = (UINT16)autoSync;
    gSntpConfig.callback = callback;
    gSntpConfig.user_param = user_param;
    //ping target setting
    strcpy((char *)gSntpConfig.serverAddr, serverAddr);

    sntpThread = sys_thread_new("sntp_task", SntpTask, (void*)&gSntpConfig, SNTP_THREAD_STACKSIZE, SNTP_THREAD_PRIO);

    if (sntpThread == NULL)
    {
        sntpIsOngoing = FALSE;
        return FALSE;
    }

    return TRUE;
}

//check sntp whether running,TRUE->running, FALSE->not run
BOOL SntpChkStatus(CHAR *serverAddr, UINT16 *serverPort, UINT8 *cid)
{
   if (sntpIsOngoing)
   {
        strcpy(serverAddr, gSntpConfig.serverAddr);
        *serverPort = gSntpConfig.serverPort;
        *cid = gSntpConfig.cid;
        return TRUE;
   }

   return FALSE;
}

