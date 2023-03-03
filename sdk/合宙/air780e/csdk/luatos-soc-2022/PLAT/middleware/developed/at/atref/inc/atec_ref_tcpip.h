/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_ref_tcpip.h
*
*  Description: Process TCP/IP related AT CMD
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _ATEC_REF_TCP_IP_H_
#define _ATEC_REF_TCP_IP_H_

#include "at_util.h"
#include "at_sock_entity.h"



#define MAX_REF_URL_IPADDR_LEN                    255
#define MAX_REF_IPADDR_LEN                        64

#define QISOCKET_CONNECT_ID_INVALID                255
/* AT+QIOPEN*/
#define QIOPEN_0_CID_MIN                         1
#define QIOPEN_0_CID_MAX                         15
#define QIOPEN_0_CID_DEF                         1
#define QIOPEN_1_CONNECT_ID_MIN                  0
#define QIOPEN_1_CONNECT_ID_MAX                  11
#define QIOPEN_1_CONNECT_ID_DEF                  0
#define QIOPEN_2_TYPE_STR_MAX_LEN                12
#define QIOPEN_2_TYPE_STR_DEF                    NULL
#define QIOPEN_3_REMOTE_ADDR_STR_MAX_LEN         MAX_REF_URL_IPADDR_LEN
#define QIOPEN_3_REMOTE_ADDR_STR_DEF             NULL
#define QIOPEN_4_REMOTE_PORT_MIN                 0
#define QIOPEN_4_REMOTE_PORT_MAX                 65535
#define QIOPEN_4_REMOTE_PORT_DEF                 0
#define QIOPEN_5_LOCAL_PORT_MIN                  0
#define QIOPEN_5_LOCAL_PORT_MAX                  65535
#define QIOPEN_5_LOCAL_PORT_DEF                  0
#define QIOPEN_6_ACCESS_MODE_MIN                 0
#define QIOPEN_6_ACCESS_MODE_MAX                 2
#define QIOPEN_6_ACCESS_MODE_DEF                 1

#define QIOPEN_SERVER_MODE_LOCAL_PORT_MIN        10000
#define QIOPEN_SERVER_MODE_LOCAL_PORT_MAX        10015


/* AT+QICLOSE*/
#define QICLOSE_0_CONNECT_ID_MIN                 0
#define QICLOSE_0_CONNECT_ID_MAX                 11
#define QICLOSE_0_CONNECT_ID_DEF                 0
#define QICLOSE_1_TIME_OUT_MIN                   0
#define QICLOSE_1_TIME_OUT_MAX                   65535
#define QICLOSE_1_TIME_OUT_DEF                   10


/*AT+QIRD*/
#define AT_QIRD_0_CONNECTID_MIN          (0)
#define AT_QIRD_0_CONNECTID_MAX          (11)
#define AT_QIRD_0_CONNECTID_DEF          (-1)

#define AT_QIRD_1_READ_LENGTH_MIN            (0)
#define AT_QIRD_1_READ_LENGTH_MAX            (1500)
#define AT_QIRD_1_READ_LENGTH_DEF            (0)

/* AT+QICFG */
#define ATC_QICFG_0_MAX_PARM_STR_LEN                 32
#define ATC_QICFG_0_MAX_PARM_STR_DEFAULT             NULL

#define AT_QICFG_1_TRANS_PKT_SIZE_MIN            (1)
#define AT_QICFG_1_TRANS_PKT_SIZE_MAX            (1460)
#define AT_QICFG_1_TRANS_PKT_SIZE_DEF            (0)

#define AT_QICFG_2_TRANS_WAIT_TM_MIN            (0)
#define AT_QICFG_2_TRANS_WAIT_TM_MAX            (20)
#define AT_QICFG_2_TRANS_WAIT_TM_DEF            (0)

#define AT_QICFG_3_SEND_DATA_FORMAT_MIN            (0)
#define AT_QICFG_3_SEND_DATA_FORMAT_MAX            (1)
#define AT_QICFG_3_SEND_DATA_FORMAT_DEF            (0)

#define AT_QICFG_4_RECV_DATA_FORMAT_MIN            (0)
#define AT_QICFG_4_RECV_DATA_FORMAT_MAX            (1)
#define AT_QICFG_4_RECV_DATA_FORMAT_DEF            (0)

#define AT_QICFG_5_VIEW_MODE_MIN            (0)
#define AT_QICFG_5_VIEW_MODE_MAX            (1)
#define AT_QICFG_5_VIEW_MODE_DEF            (0)

#define AT_QICFG_6_PASSIVE_CLOSE_MIN            (0)
#define AT_QICFG_6_PASSIVE_CLOSE_MAX            (1)
#define AT_QICFG_6_PASSIVE_CLOSE_DEF            (0)

#define AT_QICFG_7_UDP_READ_MODE_MIN            (0)
#define AT_QICFG_7_UDP_READ_MODE_MAX            (1)
#define AT_QICFG_7_UDP_READ_MODE_DEF            (0)

#define AT_QICFG_8_UDP_SEND_MODE_MIN            (0)
#define AT_QICFG_8_UDP_SEND_MODE_MAX            (1)
#define AT_QICFG_8_UDP_SEND_MODE_DEF            (0)

#define AT_QICFG_9_TCP_KEEPALIVE_ENABLE_MIN            (0)
#define AT_QICFG_9_TCP_KEEPALIVE_ENABLE_MAX            (1)
#define AT_QICFG_9_TCP_KEEPALIVE_ENABLE_DEF            (0)

#define AT_QICFG_10_TCP_KEEPALIVE_IDLE_TIME_MIN            (0)
#define AT_QICFG_10_TCP_KEEPALIVE_IDLE_TIME_MAX            (1800)
#define AT_QICFG_10_TCP_KEEPALIVE_IDLE_TIME_DEF            (0)

#define AT_QICFG_11_TCP_KEEPALIVE_INT_TIME_MIN            (24)
#define AT_QICFG_11_TCP_KEEPALIVE_INT_TIME_MAX            (100)
#define AT_QICFG_11_TCP_KEEPALIVE_INT_TIME_DEF            (0)

#define AT_QICFG_12_TCP_KEEPALIVE_PROBE_CNT_MIN            (3)
#define AT_QICFG_12_TCP_KEEPALIVE_PROBE_CNT_MAX            (10)
#define AT_QICFG_12_TCP_KEEPALIVE_PROBE_CNT_DEF            (0)

#define AT_QICFG_13_RECV_IND_MIN            (0)
#define AT_QICFG_13_RECV_IND_MAX            (1)
#define AT_QICFG_13_RECV_IND_DEF            (0)

#define AT_QICFG_14_TCP_ACCEPT_MIN            (0)
#define AT_QICFG_14_TCP_ACCEPT_MAX            (1)
#define AT_QICFG_14_TCP_ACCEPT_DEF            (0)

#define AT_QICFG_15_SENDINFO_MIN            (0)
#define AT_QICFG_15_SENDINFO_MAX            (1)
#define AT_QICFG_15_SENDINFO_DEF            (0)


/*AT+QISDE*/
#define AT_QISDE_0_ECHO_MIN            (0)
#define AT_QISDE_0_ECHO_MAX            (1)
#define AT_QISDE_0_ECHO_DEF            (0)


/*AT+QISWTMD parameters defined*/
#define AT_QISWTMD_0_CONNECTID_MIN          (0)
#define AT_QISWTMD_0_CONNECTID_MAX          (11)
#define AT_QISWTMD_0_CONNECTID_DEF          (-1)

#define AT_QISWTMD_1_ACCMODE_MIN            (0)
#define AT_QISWTMD_1_ACCMODE_MAX            (2)
#define AT_QISWTMD_1_ACCMODE_DEF            (0)


/*AT+QISTATE*/
#define AT_QISTATE_0_SERVICETYPE_MIN       (0)
#define AT_QISTATE_0_SERVICETYPE_MAX       (1)
#define AT_QISTATE_0_SERVICETYPE_DEF       (0)

#define AT_QISTATE_1_CONTEXTID_MIN       (1)
#define AT_QISTATE_1_CONTEXTID_MAX       (15)
#define AT_QISTATE_1_CONTEXTID_DEF       (1)

#define AT_QISTATE_1_CONNECTID_MIN       (0)
#define AT_QISTATE_1_CONNECTID_MAX       (11)
#define AT_QISTATE_1_CONNECTID_DEF       (0)


/*AT+QISENDEX parameters defined*/
#define AT_QISENDEX_0_CONNECTID_MIN          (0)
#define AT_QISENDEX_0_CONNECTID_MAX          (11)
#define AT_QISENDEX_0_CONNECTID_DEF          (-1)
#define QISENDEX_SEND_HEX_MAX        (512)

#define AT_QISENDEX_1_SENDHEXDATA_DEF   (PNULL)

/*AT+QISEND parameters defined*/
#define AT_QISEND_0_CONNECTID_MIN          (0)
#define AT_QISEND_0_CONNECTID_MAX          (11)
#define AT_QISEND_0_CONNECTID_DEF          (-1)

#define AT_QISEND_1_SENDLEN_MIN          (0)
#define AT_QISEND_1_SENDLEN_MAX          (1460)
#define AT_QISEND_1_SENDLEN_DEF          (0)

#define AT_QISEND_2_REMOTE_IP_DEF         (PNULL)

#define AT_QISEND_3_REMOTE_PORT_MIN         (0)
#define AT_QISEND_3_REMOTE_PORT_MAX         (65535)
#define AT_QISEND_3_REMOTE_PORT_DEF         (0)

/* AT+QPING */
#define QPING_DEFAULT_PAYLOAD_SIZE       35

#define QPING_0_CID_MIN                  1
#define QPING_0_CID_MAX                  15
#define QPING_0_CID_DEF                  1
#define QPING_1_STR_MAX_LEN              MAX_REF_URL_IPADDR_LEN
#define QPING_1_STR_DEF                  NULL
#define QPING_2_TIMEOUT_MIN              1
#define QPING_2_TIMEOUT_MAX              255
#define QPING_2_TIMEOUT_DEF              4
#define QPING_3_PING_NUM_MIN             1
#define QPING_3_PING_NUM_MAX             10
#define QPING_3_PING_NUM_DEF             4


/*AT +QSNTP*/
#define QSNTP_0_CID_MIN                  1
#define QSNTP_0_CID_MAX                  15
#define QSNTP_0_CID_DEF                  1
#define QSNTP_1_STR_MAX_LEN              MAX_REF_URL_IPADDR_LEN
#define QSNTP_1_STR_DEF                  NULL
#define QSNTP_2_PORT_MIN                  1
#define QSNTP_2_PORT_MAX                  65535
#define QSNTP_2_PORT_DEF                  123
#define QSNTP_3_AUTO_MIN                  0
#define QSNTP_3_AUTO_MAX                  1
#define QSNTP_3_AUTO_DEF                  0
#define QSNTP_GET_STATUS_CNF_STR_LEN      312

/*AT+QIDNSCFG*/
#define QIDNSCFG_DNS_NUM                  2

#define QIDNSCFG_GET_CNF_STR_LEN        256
#define QIDNSCFG_GET_CNF_TMP_STR_LEN    64

#define QIDNSCFG_0_CID_MIN                  1
#define QIDNSCFG_0_CID_MAX                  15
#define QIDNSCFG_0_CID_DEF                  1
#define QIDNSCFG_1_DNS_MAX_LEN              MAX_REF_IPADDR_LEN
#define QIDNSCFG_1_DNS_DEF                  NULL


/* AT+QIDNSGIP */
#define QIDNSGIP_0_CID_MIN                  1
#define QIDNSGIP_0_CID_MAX                  15
#define QIDNSGIP_0_CID_DEF                  1
#define QIDNSGIP_1_STR_MAX_LEN              MAX_REF_URL_IPADDR_LEN
#define QIDNSGIP_1_STR_DEF                  NULL

/* AT+ECNETDEVCTL */
#define QNETDEVCTL_0_OP_MIN                  0
#define QNETDEVCTL_0_OP_MAX                  3
#define QNETDEVCTL_0_OP_DEF                  0
#define QNETDEVCTL_1_CID_MIN                 1
#define QNETDEVCTL_1_CID_MAX                 15
#define QNETDEVCTL_1_CID_DEF                 1
#define QNETDEVCTL_2_URCEN_MIN               0
#define QNETDEVCTL_2_URCEN_MAX               1
#define QNETDEVCTL_2_URCEN_DEF               0


/**********************macro define****************************************/
#define  NM_TRANS_IPV4ADDR_TO_BYTE(ipAddr ,ipAddrCfg  )   \
   do{                                                      \
        ipAddrCfg.ipAddr[0] =  ip4_addr1(&(ipAddr.u_addr.ip4));   \
        ipAddrCfg.ipAddr[1] =  ip4_addr2(&(ipAddr.u_addr.ip4));   \
        ipAddrCfg.ipAddr[2] =  ip4_addr3(&(ipAddr.u_addr.ip4));   \
        ipAddrCfg.ipAddr[3] =  ip4_addr4(&(ipAddr.u_addr.ip4));   \
    }while(0)


#define  NM_TRANS_IPV6ADDR_TO_BYTE(ipAddr ,ipAddrCfg  )   \
  do{                                                     \
        UINT16  ipv6U16 = 0;                              \
        ipv6U16 = IP6_ADDR_BLOCK1(&(ipAddr.u_addr.ip6));   \
        ipAddrCfg.ipAddr[0] = (UINT8)((ipv6U16 >> 8)&0xFF);   \
        ipAddrCfg.ipAddr[1] = (UINT8)(ipv6U16 & 0xFF);        \
        ipv6U16 = IP6_ADDR_BLOCK2(&(ipAddr.u_addr.ip6));      \
        ipAddrCfg.ipAddr[2] = (UINT8)((ipv6U16 >> 8)&0xFF);   \
        ipAddrCfg.ipAddr[3] = (UINT8)(ipv6U16 & 0xFF);        \
        ipv6U16 = IP6_ADDR_BLOCK3(&(ipAddr.u_addr.ip6));      \
        ipAddrCfg.ipAddr[4] = (UINT8)((ipv6U16 >> 8)&0xFF);   \
        ipAddrCfg.ipAddr[5] = (UINT8)(ipv6U16 & 0xFF);         \
        ipv6U16 = IP6_ADDR_BLOCK4(&(ipAddr.u_addr.ip6));      \
        ipAddrCfg.ipAddr[6] = (UINT8)((ipv6U16 >> 8)&0xFF);  \
        ipAddrCfg.ipAddr[7] = (UINT8)(ipv6U16 & 0xFF);   \
        ipv6U16 = IP6_ADDR_BLOCK5(&(ipAddr.u_addr.ip6));   \
        ipAddrCfg.ipAddr[8] = (UINT8)((ipv6U16 >> 8)&0xFF);  \
        ipAddrCfg.ipAddr[9] = (UINT8)(ipv6U16 & 0xFF);   \
        ipv6U16 = IP6_ADDR_BLOCK6(&(ipAddr.u_addr.ip6));  \
        ipAddrCfg.ipAddr[10] = (UINT8)((ipv6U16 >> 8)&0xFF);   \
        ipAddrCfg.ipAddr[11] = (UINT8)(ipv6U16 & 0xFF);    \
        ipv6U16 = IP6_ADDR_BLOCK7(&(ipAddr.u_addr.ip6));   \
        ipAddrCfg.ipAddr[12] = (UINT8)((ipv6U16 >> 8)&0xFF);  \
        ipAddrCfg.ipAddr[13] = (UINT8)(ipv6U16 & 0xFF);    \
        ipv6U16 = IP6_ADDR_BLOCK8(&(ipAddr.u_addr.ip6));   \
        ipAddrCfg.ipAddr[14] = (UINT8)((ipv6U16 >> 8)&0xFF);  \
        ipAddrCfg.ipAddr[15] = (UINT8)(ipv6U16 & 0xFF);  \
    }while(0)



/**********************function api define****************************************/
CmsRetId  nmQIOPEN(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmQICLOSE(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmQIPING(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmQINTP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmQIDNSCFG(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmQIDNSGIP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmQIRD(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmQICFG(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmQISDE(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmQIGETERROR(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmQISTATE(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmQISEND(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmQISENDEX(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmQISWTMD(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmQISocInputData(UINT8 chanId, UINT8 *pInput, UINT16 length);
void      nmQISocFreeDataInfo(void);
void      nmQISocFreeDataBody(void);
CmsRetId  nmQISocInputPSTHData(UINT8 chanId, UINT8 *pInput, UINT16 length);
void      nmQISocPSTHdataInit(UINT8 connectId, UINT16 reqHander);
void      nmQISocPSTHdataDeInit(void);
void      nmQISocEnableUlfc(UINT8 chanId);
void      nmQISocDisableUlfc(UINT8 chanId);
CmsRetId  nmQNETDEVCTL(const AtCmdInputContext *pAtCmdReq);

AtRefSocketSendInfo *nmQISocGetSendMsgHander(void);




#endif

