#include "bsp.h"
//#include "bsp_custom.h"
#ifndef USB_DRV_SMALL_IMAGE
#include "plat_config.h"
#include DEBUG_LOG_HEADER_FILE
#endif
#include "string.h"

#include "rndis_protocol.h"
#include "usbmst_external.h"

#define INFBUF ((uint32_t *)((uint8_t *)&(m->RequestId) + m->InformationBufferOffset))
#define CFGBUF ((rndis_config_parameter_t *) INFBUF)
#define PARMNAME  ((uint8_t *)CFGBUF + CFGBUF->ParameterNameOffset)
#define PARMVALUE ((uint8_t *)CFGBUF + CFGBUF->ParameterValueOffset)
#define PARMVALUELENGTH	CFGBUF->ParameterValueLength
#define PARM_NAME_LENGTH 25 /* Maximum parameter name length */

#define MAC_OPT NDIS_MAC_OPTION_COPY_LOOKAHEAD_DATA | \
			NDIS_MAC_OPTION_RECEIVE_SERIALIZED  | \
			NDIS_MAC_OPTION_TRANSFERS_NOT_PEND  | \
			NDIS_MAC_OPTION_NO_LOOPBACK

static const char *rndis_vendor = RNDIS_VENDOR;


const uint32_t OIDSupportedList[] = 
{
    OID_GEN_SUPPORTED_LIST,
    OID_GEN_HARDWARE_STATUS,
    OID_GEN_MEDIA_SUPPORTED,
    OID_GEN_MEDIA_IN_USE,
    OID_GEN_MAXIMUM_FRAME_SIZE,
    OID_GEN_LINK_SPEED,
    OID_GEN_TRANSMIT_BLOCK_SIZE,
    OID_GEN_RECEIVE_BLOCK_SIZE,
    OID_GEN_VENDOR_ID,
    OID_GEN_VENDOR_DESCRIPTION,
    OID_GEN_VENDOR_DRIVER_VERSION,
    OID_GEN_CURRENT_PACKET_FILTER,
    OID_GEN_MAXIMUM_TOTAL_SIZE,
    OID_GEN_PROTOCOL_OPTIONS,
    OID_GEN_MAC_OPTIONS,
    OID_GEN_MEDIA_CONNECT_STATUS,
    OID_GEN_MAXIMUM_SEND_PACKETS,
    OID_802_3_PERMANENT_ADDRESS,
    OID_802_3_CURRENT_ADDRESS,
    OID_802_3_MULTICAST_LIST,
    OID_802_3_MAXIMUM_LIST_SIZE,
    OID_802_3_MAC_OPTIONS
};

#define OID_LIST_LENGTH (sizeof(OIDSupportedList) / sizeof(*OIDSupportedList))
#define ENC_BUF_SIZE    (OID_LIST_LENGTH * 4 + 32)

static const uint8_t station_hwaddr[6] = { RNDIS_HWADDR };
static const uint8_t permanent_hwaddr[6] = { RNDIS_HWADDR };
extern uint32_t connect_status;

//used for malloc buffer
uint32_t RndisGetEncBufSize(void)
{
    return ENC_BUF_SIZE;
}

void FuncRndisInitNotify(void)
{
#if (!defined(USB_DRV_SMALL_IMAGE))
    usbDevNotifyRndisEvent(NOTIFY_MSG_INIT, NULL);
#endif
}

void FuncRndisHaltNotify(void)
{
#if (!defined(USB_DRV_SMALL_IMAGE))
    usbDevNotifyRndisEvent(NOTIFY_MSG_HALT, NULL);
#endif
}

void FuncRndisResetNotify(void)
{
#if (!defined(USB_DRV_SMALL_IMAGE))
    usbDevNotifyRndisEvent(NOTIFY_MSG_RESET, NULL);
#endif
}


void RdsProInitalMsgHdl(rndis_generic_msg_t *msgIn)
{
    rndis_initialize_cmplt_t *m;
    m = ((rndis_initialize_cmplt_t *)msgIn);
    /* m->MessageID is same as before */
    m->MessageType = REMOTE_NDIS_INITIALIZE_CMPLT;
    m->MessageLength = sizeof(rndis_initialize_cmplt_t);
    m->MajorVersion = RNDIS_MAJOR_VERSION;
    m->MinorVersion = RNDIS_MINOR_VERSION;
    m->Status = RNDIS_STATUS_SUCCESS;
    m->DeviceFlags = RNDIS_DF_CONNECTIONLESS;
    m->Medium = RNDIS_MEDIUM_802_3;
    m->MaxPacketsPerTransfer = RNDIS_MAX_PACK_PER_XFER;
    m->MaxTransferSize = RNDIS_RX_BUFFER_SIZE;
    m->PacketAlignmentFactor = 0;
    m->AfListOffset = 0;
    m->AfListSize = 0;
}

void RdsProQueryCmplt(rndis_query_msg_t *m, int status, const void *data, int size)
{
    rndis_query_cmplt_t *c = (rndis_query_cmplt_t *)m;

    c->MessageType = REMOTE_NDIS_QUERY_CMPLT;
    c->MessageLength = sizeof(rndis_query_cmplt_t) + size;
    c->InformationBufferLength = size;
    c->InformationBufferOffset = 16;
    c->Status = status;
    memcpy(c + 1, data, size);
}

void RdsProQueryCmplt32(rndis_query_msg_t *m, int status, uint32_t data)
{
    rndis_query_cmplt_t *c = (rndis_query_cmplt_t *)m;

    c->MessageType = REMOTE_NDIS_QUERY_CMPLT;
    c->MessageLength = sizeof(rndis_query_cmplt_t) + 4;
    c->InformationBufferLength = 4;
    c->InformationBufferOffset = 16;
    c->Status = status;
    *(uint32_t *)(c + 1) = data;
}

void RdsProQueryHdl(rndis_query_msg_t *m, rndis_ctrl_data_st *p_ctrl_data)
{
    switch (m->Oid)
    {
    	case OID_GEN_SUPPORTED_LIST:         RdsProQueryCmplt(m,RNDIS_STATUS_SUCCESS, OIDSupportedList, 4 * OID_LIST_LENGTH); return;
    	case OID_GEN_VENDOR_DRIVER_VERSION:  RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, 0x00001000);  return;
    	case OID_802_3_CURRENT_ADDRESS:      RdsProQueryCmplt(m,RNDIS_STATUS_SUCCESS, &station_hwaddr, 6); return;
    	case OID_802_3_PERMANENT_ADDRESS:    RdsProQueryCmplt(m,RNDIS_STATUS_SUCCESS, &permanent_hwaddr, 6); return;
    	case OID_GEN_MEDIA_SUPPORTED:        RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, NDIS_MEDIUM_802_3); return;
    	case OID_GEN_MEDIA_IN_USE:           RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, NDIS_MEDIUM_802_3); return;
    	case OID_GEN_PHYSICAL_MEDIUM:        RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, NDIS_MEDIUM_802_3); return;
    	case OID_GEN_HARDWARE_STATUS:        RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, 0); return;
    	case OID_GEN_LINK_SPEED:             RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, RNDIS_LINK_SPEED / 100); return;
    	case OID_GEN_VENDOR_ID:              RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, 0x00FFFFFF); return;
    	case OID_GEN_VENDOR_DESCRIPTION:     RdsProQueryCmplt(m,RNDIS_STATUS_SUCCESS, rndis_vendor, strlen(rndis_vendor) + 1); return;
    	case OID_GEN_CURRENT_PACKET_FILTER:  RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, p_ctrl_data->oid_packet_filter); return;
    	case OID_GEN_MAXIMUM_FRAME_SIZE:     RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, ETH_MAX_PACKET_SIZE - ETH_HEADER_SIZE); return;
    	case OID_GEN_MAXIMUM_TOTAL_SIZE:     RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, ETH_MAX_PACKET_SIZE); return;
    	case OID_GEN_TRANSMIT_BLOCK_SIZE:    RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, ETH_MAX_PACKET_SIZE); return;
    	case OID_GEN_RECEIVE_BLOCK_SIZE:     RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, ETH_MAX_PACKET_SIZE); return;
    	case OID_GEN_MEDIA_CONNECT_STATUS:   RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, connect_status); return;
    	case OID_GEN_RNDIS_CONFIG_PARAMETER: RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, 0); return;
    	case OID_802_3_MAXIMUM_LIST_SIZE:    RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, 1); return;
    	case OID_802_3_MULTICAST_LIST:       RdsProQueryCmplt32(m,RNDIS_STATUS_NOT_SUPPORTED, 0); return;
    	case OID_802_3_MAC_OPTIONS:          RdsProQueryCmplt32(m,RNDIS_STATUS_NOT_SUPPORTED, 0); return;
    	case OID_GEN_MAC_OPTIONS:            RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, 0); return;
    	case OID_802_3_RCV_ERROR_ALIGNMENT:  RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, 0); return;
    	case OID_802_3_XMIT_ONE_COLLISION:   RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, 0); return;
    	case OID_802_3_XMIT_MORE_COLLISIONS: RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, 0); return;
    	case OID_GEN_XMIT_OK:                RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, p_ctrl_data->usb_eth_stat.txok); return;
    	case OID_GEN_RCV_OK:                 RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, p_ctrl_data->usb_eth_stat.rxok); return;
    	case OID_GEN_RCV_ERROR:              RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, p_ctrl_data->usb_eth_stat.rxbad); return;
    	case OID_GEN_XMIT_ERROR:             RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, p_ctrl_data->usb_eth_stat.txbad); return;
    	case OID_GEN_RCV_NO_BUFFER:          RdsProQueryCmplt32(m,RNDIS_STATUS_SUCCESS, 0); return;
    	default:                             RdsProQueryCmplt(m,RNDIS_STATUS_FAILURE, NULL, 0); return;
    }
}



void RdsProCfgParaHdl(const char *data, int keyoffset, int valoffset, int keylen, int vallen)
{
    (void)data;
    (void)keyoffset;
    (void)valoffset;
    (void)keylen;
    (void)vallen;
}

void RdsProPktFilter(uint32_t newfilter)
{
    (void)newfilter;
}

void RdsProSetMsgHdl(rndis_set_msg_t *msgIn, rndis_ctrl_data_st *p_ctrl_data)
{
    rndis_set_cmplt_t *c;
    rndis_set_msg_t *m;
    rndis_Oid_t oid;

    c = (rndis_set_cmplt_t *)msgIn;
    m = (rndis_set_msg_t *)msgIn;

    oid = m->Oid;
    c->MessageType = REMOTE_NDIS_SET_CMPLT;
    c->MessageLength = sizeof(rndis_set_cmplt_t);
    c->Status = RNDIS_STATUS_SUCCESS;

    switch (oid)
    {
        case OID_GEN_RNDIS_CONFIG_PARAMETER:
        {
            rndis_config_parameter_t *p;
            char *ptr = (char *)m;
            ptr += sizeof(rndis_generic_msg_t);
            ptr += m->InformationBufferOffset;
            p = (rndis_config_parameter_t *)ptr;
            RdsProCfgParaHdl(ptr, p->ParameterNameOffset, p->ParameterValueOffset, p->ParameterNameLength, p->ParameterValueLength);
        }
        break;

        case OID_GEN_CURRENT_PACKET_FILTER:
            p_ctrl_data->oid_packet_filter = *INFBUF;
            if (p_ctrl_data->oid_packet_filter)
            {
                RdsProPktFilter(p_ctrl_data->oid_packet_filter);
                p_ctrl_data->rndis_state = rndis_data_initialized;
            } 
            else 
            {
                p_ctrl_data->rndis_state = rndis_initialized;
            }
        break;

        case OID_GEN_CURRENT_LOOKAHEAD:
            break;

        case OID_GEN_PROTOCOL_OPTIONS:
            break;

        case OID_802_3_MULTICAST_LIST:
            break;
        case OID_PNP_ADD_WAKE_UP_PATTERN:
        case OID_PNP_REMOVE_WAKE_UP_PATTERN:
        case OID_PNP_ENABLE_WAKE_UP:
        default:
            c->Status = RNDIS_STATUS_FAILURE;
        break;
    }

    return;
}

void RdsProResetMsgHdl(rndis_reset_cmplt_t *m, rndis_ctrl_data_st *p_ctrl_data)
{
    p_ctrl_data->rndis_state = rndis_uninitialized;
    m->MessageType = REMOTE_NDIS_RESET_CMPLT;
    m->MessageLength = sizeof(rndis_reset_cmplt_t);
    m->Status = RNDIS_STATUS_SUCCESS;
    m->AddressingReset = 1; 
}

void RdsProKeepAliveMsgHdl(rndis_keepalive_cmplt_t *m, uint32_t RequestId, rndis_ctrl_data_st *p_ctrl_data)
{
    (void)p_ctrl_data;
    m->RequestId = RequestId;

    m->MessageType = REMOTE_NDIS_KEEPALIVE_CMPLT;
    m->MessageLength = sizeof(rndis_keepalive_cmplt_t);
    m->Status = RNDIS_STATUS_SUCCESS;
}

