/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: atec_tcpip.h
 *
 *  Description:
 *
 *  History:
 *
 *  Notes:
 *
******************************************************************************/
#ifndef _ATEC_TCPIP_H
#define _ATEC_TCPIP_H

#include "at_util.h"



/* AT+SKTCREATE */
#define SKTCREATE_0_MIN                   1
#define SKTCREATE_0_MAX                   2
#define SKTCREATE_0_DEF                   1
#define SKTCREATE_1_MIN                1
#define SKTCREATE_1_MAX                3
#define SKTCREATE_1_DEF                1
#define SKTCREATE_2_MIN                   0
#define SKTCREATE_2_MAX                   0xff
#define SKTCREATE_2_DEF                   0

/* AT+SKTSEND */
#define SKTSEND_0_MIN                   AT_SOC_FD_MIN
#define SKTSEND_0_MAX                   AT_SOC_FD_MAX
#define SKTSEND_0_DEF                   AT_SOC_FD_DEF
#define SKTSEND_1_MIN                1
#define SKTSEND_1_MAX                SUPPORT_MAX_SOCKET_RAW_DATA_LENGTH
#define SKTSEND_1_DEF                1
#define SKTSEND_2_STR_MAX_LEN           6
#define SKTSEND_2_STR_DEF               NULL
#define SKTSEND_3_MIN                0
#define SKTSEND_3_MAX                2
#define SKTSEND_3_DEF                0
#define SKTSEND_4_MIN                0
#define SKTSEND_4_MAX                1
#define SKTSEND_4_DEF                0

#define SKTSENDT_0_MIN                   AT_SOC_FD_MIN
#define SKTSENDT_0_MAX                   AT_SOC_FD_MAX
#define SKTSENDT_0_DEF                   AT_SOC_FD_DEF
#define SKTSENDT_1_MIN                1
#define SKTSENDT_1_MAX                SUPPORT_MAX_SOCKET_RAW_DATA_LENGTH
#define SKTSENDT_1_DEF                -1
#define SKTSENDT_2_MIN                0
#define SKTSENDT_2_MAX                2
#define SKTSENDT_2_DEF                0
#define SKTSENDT_3_MIN                0
#define SKTSENDT_3_MAX                1
#define SKTSENDT_3_DEF                0

/* AT+SKTCONNECT */
#define SKTCONNECT_0_SEQ_MIN                AT_SOC_FD_MIN
#define SKTCONNECT_0_SEQ_MAX                AT_SOC_FD_MAX//max socket fd
#define SKTCONNECT_0_SEQ_DEF                AT_SOC_FD_DEF
#define SKTCONNECT_1_ADDR_STR_MAX_LEN       AT_SOC_IP_ADDR_STRING_LENGTH_MAX
#define SKTCONNECT_1_ADDR_STR_DEF           NULL
#define SKTCONNECT_2_PORT_MIN               AT_SOC_PORT_MIN
#define SKTCONNECT_2_PORT_MAX               AT_SOC_PORT_MAX
#define SKTCONNECT_2_PORT_DEF               0

/* AT+SKTBIND */
#define SKTBIND_0_SEQ_MIN                   AT_SOC_FD_MIN
#define SKTBIND_0_SEQ_MAX                   AT_SOC_FD_MAX//max socket fd
#define SKTBIND_0_SEQ_DEF                   AT_SOC_FD_DEF
#define SKTBIND_1_ADDR_STR_MAX_LEN             AT_SOC_IP_ADDR_STRING_LENGTH_MAX
#define SKTBIND_1_ADDR_STR_DEF                 NULL
#define SKTBIND_2_PORT_MIN                  0
#define SKTBIND_2_PORT_MAX                  AT_SOC_PORT_MAX
#define SKTBIND_2_PORT_DEF                  0

/* AT+SKTSTATUS */
#define SKTSTATUS_0_SEQ_MIN                   AT_SOC_FD_MIN
#define SKTSTATUS_0_SEQ_MAX                   AT_SOC_FD_MAX//max socket fd
#define SKTSTATUS_0_SEQ_DEF                   0

/* AT+SKTDELETE */
#define SKTDELETE_0_SEQ_MIN                   AT_SOC_FD_MIN
#define SKTDELETE_0_SEQ_MAX                   AT_SOC_FD_MAX//max socket fd
#define SKTDELETE_0_SEQ_DEF                   AT_SOC_FD_DEF

#define MAX_URL_IPADDR_LEN                    255


/*AT+ECSNTP*/
#define SNTP_0_STR_MAX_LEN              MAX_URL_IPADDR_LEN
#define SNTP_0_STR_DEF                  NULL
#define SNTP_DEC_1_MIN                  0
#define SNTP_DEC_1_MAX                  AT_SOC_PORT_MAX
#define SNTP_DEC_1_DEF                  0
#define SNTP_DEC_2_MIN                  0
#define SNTP_DEC_2_MAX                  1
#define SNTP_DEC_2_DEF                  0

/* AT+ECPING */
#define PING_DEC_0_MIN                  0
#define PING_DEC_0_MAX                  0
#define PING_DEC_0_DEF                  0
#define PING_0_STR_MAX_LEN              MAX_URL_IPADDR_LEN
#define PING_0_STR_DEF                  NULL
#define PING_1_COUNT_MIN                1
#define PING_1_COUNT_MAX                255
#define PING_1_COUNT_DEF                4
#define PING_2_PAYLOAD_MIN           1
#define PING_2_PAYLOAD_MAX           1500
#define PING_2_PAYLOAD_DEF           32
#define PING_3_TIMEOUT_MIN              1
#define PING_3_TIMEOUT_MAX              10*60*1000
#define PING_3_TIMEOUT_DEF              20000
#define PING_4_RAI_FLAG_MIN              0
#define PING_4_RAI_FLAG_MAX              1
#define PING_4_RAI_FLAG_DEF              0


/* AT+CMDNS */
#define CMDNS_0_STR_MAX_LEN              MAX_URL_IPADDR_LEN
#define CMDNS_0_STR_DEF                  NULL

/* AT+ECIPERF */
#define ECIPERF_0_ACT_MIN                 0
#define ECIPERF_0_ACT_MAX                 5
#define ECIPERF_0_ACT_DEF                 0

#define ECIPERF_1_PROTO_MIN               0   //UDP
#define ECIPERF_1_PROTO_MAX               1   //TCP
#define ECIPERF_1_PROTO_DEF               0   //UDP

#define ECIPERF_2_PORT_MIN                AT_SOC_PORT_MIN
#define ECIPERF_2_PORT_MAX                AT_SOC_PORT_MAX
#define ECIPERF_2_PORT_DEF                5001

#define ECIPERF_3_STR_MAX_LEN              64
#define ECIPERF_3_STR_DEF                  NULL

#define ECIPERF_4_TPT_MIN                 1
#define ECIPERF_4_TPT_MAX                 12000000  //12M bps
#define ECIPERF_4_TPT_DEF                 20000   //20kbps

#define ECIPERF_5_PAYLOAD_MIN             36
#define ECIPERF_5_PAYLOAD_MAX             1472
#define ECIPERF_5_PAYLOAD_DEF             940

#define ECIPERF_6_PKG_NUM_MIN             1
#define ECIPERF_6_PKG_NUM_MAX             65000
#define ECIPERF_6_PKG_NUM_DEF             0

#define ECIPERF_7_DURATION_MIN            1
#define ECIPERF_7_DURATION_MAX            65000
#define ECIPERF_7_DURATION_DEF            65000

#define ECIPERF_8_RPT_INTERVAL_MIN        1
#define ECIPERF_8_RPT_INTERVAL_MAX        65000
#define ECIPERF_8_RPT_INTERVAL_DEF        10

/* AT+ECDNSCFG */
#define ECDNSCFG_DNS_NUM                      4

#define ECDNSCFG_DNS_STR_MAX_LEN              64
#define ECDNSCFG_DNS_STR_DEF                  PNULL
#define ATEC_ECDNSCFG_GET_CNF_STR_LEN        256
#define ATEC_ECDNSCFG_GET_CNF_TMP_STR_LEN    50

/* AT+ECNETCFG */
#define ECNETCFG_0_MAX_PARM_STR_LEN         32
#define ECNETCFG_0_MAX_PARM_STR_DEFAULT     NULL
#define ECNETCFG_1_PPP_AUTH_SELECT_MIN      0
#define ECNETCFG_1_PPP_AUTH_SELECT_MAX      1
#define ECNETCFG_1_PPP_AUTH_SELECT_DEF      0
#define ECNETCFG_1_NAT_MIN                  0
#define ECNETCFG_1_NAT_MAX                  1
#define ECNETCFG_1_NAT_DEF                  0
#define ECNETCFG_2_HOST_ADDR_STR_MAX_LEN    64
#define ECNETCFG_2_HOST_ADDR_STR_DEFAULT    NULL

/* AT+ECNETDEVCTL */
#define ECNETDEVCTL_0_OP_MIN                  0
#define ECNETDEVCTL_0_OP_MAX                  3
#define ECNETDEVCTL_0_OP_DEF                  0
#define ECNETDEVCTL_1_CID_MIN                 1
#define ECNETDEVCTL_1_CID_MAX                 15
#define ECNETDEVCTL_1_CID_DEF                 1
#define ECNETDEVCTL_2_URCEN_MIN               0
#define ECNETDEVCTL_2_URCEN_MAX               1
#define ECNETDEVCTL_2_URCEN_DEF               0


/* AT+ECSOCR*/
#define ECSOCR_0_TYPE_STR_MAX_LEN              6
#define ECSOCR_0_TYPE_STR_DEF                  NULL
#define ECSOCR_1_PROTOCOL_MIN                  6
#define ECSOCR_1_PROTOCOL_MAX                  17
#define ECSOCR_1_PROTOCOL_DEF                  17
#define ECSOCR_2_LISTEN_PORT_MIN               0
#define ECSOCR_2_LISTEN_PORT_MAX               AT_SOC_PORT_MAX
#define ECSOCR_2_LISTEN_PORT_DEF               0
#define ECSOCR_3_RECEIVE_CONTROL_MIN           0
#define ECSOCR_3_RECEIVE_CONTROL_MAX           1
#define ECSOCR_3_RECEIVE_CONTROL_DEF           1
#define ECSOCR_4_AF_TYPE_STR_MAX_LEN           8
#define ECSOCR_4_AF_TYPE_STR_DEF               NULL
#define ECSOCR_5_IP_ADDR_STR_MAX_LEN           AT_SOC_IP_ADDR_STRING_LENGTH_MAX
#define ECSOCR_5_IP_ADDR_STR_DEF               NULL

/*AT+ECSOST*/
#define ECSOST_0_SOCKET_ID_MIN                 AT_SOC_FD_MIN
#define ECSOST_0_SOCKET_ID_MAX                 AT_SOC_FD_MAX
#define ECSOST_0_SOCKET_ID_DEF                 AT_SOC_FD_DEF
#define ECSOST_1_IP_ADDR_STR_MAX_LEN           AT_SOC_IP_ADDR_STRING_LENGTH_MAX
#define ECSOST_1_IP_ADDR_STR_DEF               NULL
#define ECSOST_2_REMOTE_PORT_MIN               AT_SOC_PORT_MIN
#define ECSOST_2_REMOTE_PORT_MAX               AT_SOC_PORT_MAX
#define ECSOST_2_REMOTE_PORT_DEF               0
#define ECSOST_3_LENGTH_MIN                    AT_SOC_UL_LENGTH_MIN
#define ECSOST_3_LENGTH_MAX                    AT_SOC_UL_LENGTH_MAX
#define ECSOST_3_LENGTH_DEF                    0
#define ECSOST_4_DATA_MAX_LEN                  AT_SOC_UL_LENGTH_MAX
#define ECSOST_4_DATA_DEF                      NULL
#define ECSOST_5_SEQUENCE_MIN                  AT_SOC_UL_DATA_SEQUENCE_MIN
#define ECSOST_5_SEQUENCE_MAX                  AT_SOC_UL_DATA_SEQUENCE_MAX
#define ECSOST_5_SEQUENCE_DEF                  0
#define ECSOST_6_SEGMENT_ID_MIN                AT_SOC_UL_SEGMENT_ID_MIN
#define ECSOST_6_SEGMENT_ID_MAX                AT_SOC_UL_SEGMENT_ID_MAX
#define ECSOST_6_SEGMENT_ID_DEF                0
#define ECSOST_7_SEGMENT_NUM_MIN               AT_SOC_UL_SEGMENT_NUM_MIN
#define ECSOST_7_SEGMENT_NUM_MAX               AT_SOC_UL_SEGMENT_NUM_MAX
#define ECSOST_7_SEGMENT_NUM_DEF               0

#define ECSOSTT_0_SOCKET_ID_MIN                 AT_SOC_FD_MIN
#define ECSOSTT_0_SOCKET_ID_MAX                 AT_SOC_FD_MAX
#define ECSOSTT_0_SOCKET_ID_DEF                 AT_SOC_FD_DEF
#define ECSOSTT_1_IP_ADDR_STR_MAX_LEN           AT_SOC_IP_ADDR_STRING_LENGTH_MAX
#define ECSOSTT_1_IP_ADDR_STR_DEF               NULL
#define ECSOSTT_2_REMOTE_PORT_MIN               AT_SOC_PORT_MIN
#define ECSOSTT_2_REMOTE_PORT_MAX               AT_SOC_PORT_MAX
#define ECSOSTT_2_REMOTE_PORT_DEF               0
#define ECSOSTT_3_LENGTH_MIN                    AT_SOC_UL_LENGTH_MIN
#define ECSOSTT_3_LENGTH_MAX                    AT_SOC_UL_LENGTH_MAX
#define ECSOSTT_3_LENGTH_DEF                    -1
#define ECSOSTT_4_SEQUENCE_MIN                  AT_SOC_UL_DATA_SEQUENCE_MIN
#define ECSOSTT_4_SEQUENCE_MAX                  AT_SOC_UL_DATA_SEQUENCE_MAX
#define ECSOSTT_4_SEQUENCE_DEF                  0
/*AT+ECSOSTF*/
#define ECSOSTF_0_SOCKET_ID_MIN                 AT_SOC_FD_MIN
#define ECSOSTF_0_SOCKET_ID_MAX                 AT_SOC_FD_MAX
#define ECSOSTF_0_SOCKET_ID_DEF                 AT_SOC_FD_DEF
#define ECSOSTF_1_IP_ADDR_STR_MAX_LEN           AT_SOC_IP_ADDR_STRING_LENGTH_MAX
#define ECSOSTF_1_IP_ADDR_STR_DEF               NULL
#define ECSOSTF_2_REMOTE_PORT_MIN               AT_SOC_PORT_MIN
#define ECSOSTF_2_REMOTE_PORT_MAX               AT_SOC_PORT_MAX
#define ECSOSTF_2_REMOTE_PORT_DEF               0
#define ECSOSTF_3_FLAG_STR_MAX_LEN              5
#define ECSOSTF_3_FLAG_STR_DEF                  NULL
#define ECSOSTF_4_LENGTH_MIN                    AT_SOC_UL_LENGTH_MIN
#define ECSOSTF_4_LENGTH_MAX                    AT_SOC_UL_LENGTH_MAX
#define ECSOSTF_4_LENGTH_DEF                    0
#define ECSOSTF_5_DATA_MAX_LEN                  AT_SOC_UL_LENGTH_MAX
#define ECSOSTF_5_DATA_DEF                      NULL
#define ECSOSTF_6_SEQUENCE_MIN                  AT_SOC_UL_DATA_SEQUENCE_MIN
#define ECSOSTF_6_SEQUENCE_MAX                  AT_SOC_UL_DATA_SEQUENCE_MAX
#define ECSOSTF_6_SEQUENCE_DEF                  0
#define ECSOSTF_7_SEGMENT_ID_MIN                AT_SOC_UL_SEGMENT_ID_MIN
#define ECSOSTF_7_SEGMENT_ID_MAX                AT_SOC_UL_SEGMENT_ID_MAX
#define ECSOSTF_7_SEGMENT_ID_DEF                0
#define ECSOSTF_8_SEGMENT_NUM_MIN               AT_SOC_UL_SEGMENT_NUM_MIN
#define ECSOSTF_8_SEGMENT_NUM_MAX               AT_SOC_UL_SEGMENT_NUM_MAX
#define ECSOSTF_8_SEGMENT_NUM_DEF               0
#define ECSOSTFT_0_SOCKET_ID_MIN                 AT_SOC_FD_MIN
#define ECSOSTFT_0_SOCKET_ID_MAX                 AT_SOC_FD_MAX
#define ECSOSTFT_0_SOCKET_ID_DEF                 AT_SOC_FD_DEF
#define ECSOSTFT_1_IP_ADDR_STR_MAX_LEN           AT_SOC_IP_ADDR_STRING_LENGTH_MAX
#define ECSOSTFT_1_IP_ADDR_STR_DEF               NULL
#define ECSOSTFT_2_REMOTE_PORT_MIN               AT_SOC_PORT_MIN
#define ECSOSTFT_2_REMOTE_PORT_MAX               AT_SOC_PORT_MAX
#define ECSOSTFT_2_REMOTE_PORT_DEF               0
#define ECSOSTFT_3_FLAG_STR_MAX_LEN              5
#define ECSOSTFT_3_FLAG_STR_DEF                  NULL
#define ECSOSTFT_4_LENGTH_MIN                    AT_SOC_UL_LENGTH_MIN
#define ECSOSTFT_4_LENGTH_MAX                    AT_SOC_UL_LENGTH_MAX
#define ECSOSTFT_4_LENGTH_DEF                    -1
#define ECSOSTFT_5_SEQUENCE_MIN                  AT_SOC_UL_DATA_SEQUENCE_MIN
#define ECSOSTFT_5_SEQUENCE_MAX                  AT_SOC_UL_DATA_SEQUENCE_MAX
#define ECSOSTFT_5_SEQUENCE_DEF                  0

/*AT+ECQSOS*/
#define ECQSOS_0_SOCKET1_ID_MIN                 AT_SOC_FD_MIN
#define ECQSOS_0_SOCKET1_ID_MAX                 AT_SOC_FD_MAX
#define ECQSOS_0_SOCKET1_ID_DEF                 AT_SOC_FD_DEF
#define ECQSOS_1_SOCKET2_ID_MIN                 AT_SOC_FD_MIN
#define ECQSOS_1_SOCKET2_ID_MAX                 AT_SOC_FD_MAX
#define ECQSOS_1_SOCKET2_ID_DEF                 AT_SOC_FD_DEF
#define ECQSOS_2_SOCKET3_ID_MIN                 AT_SOC_FD_MIN
#define ECQSOS_2_SOCKET3_ID_MAX                 AT_SOC_FD_MAX
#define ECQSOS_2_SOCKET3_ID_DEF                 AT_SOC_FD_DEF
#define ECQSOS_3_SOCKET4_ID_MIN                 AT_SOC_FD_MIN
#define ECQSOS_3_SOCKET4_ID_MAX                 AT_SOC_FD_MAX
#define ECQSOS_3_SOCKET4_ID_DEF                 AT_SOC_FD_DEF
#define ECQSOS_4_SOCKET5_ID_MIN                 AT_SOC_FD_MIN
#define ECQSOS_4_SOCKET5_ID_MAX                 AT_SOC_FD_MAX
#define ECQSOS_4_SOCKET5_ID_DEF                 AT_SOC_FD_DEF

/*AT+ECSORF*/
#define ECSORF_0_SOCKET_ID_MIN                 AT_SOC_FD_MIN
#define ECSORF_0_SOCKET_ID_MAX                 AT_SOC_FD_MAX
#define ECSORF_0_SOCKET_ID_DEF                 AT_SOC_FD_DEF
#define ECSORF_1_LENGTH_ID_MIN                 AT_SOC_DL_LENGTH_MIN
#define ECSORF_1_LENGTH_ID_MAX                 AT_SOC_DL_LENGTH_MAX
#define ECSORF_1_LENGTH_ID_DEF                 0

/*AT+ECSOCO*/
#define ECSOCO_0_SOCKET_ID_MIN                 AT_SOC_FD_MIN
#define ECSOCO_0_SOCKET_ID_MAX                 AT_SOC_FD_MAX
#define ECSOCO_0_SOCKET_ID_DEF                 AT_SOC_FD_DEF
#define ECSOCO_1_IP_ADDR_STR_MAX_LEN           AT_SOC_IP_ADDR_STRING_LENGTH_MAX
#define ECSOCO_1_IP_ADDR_STR_DEF               NULL
#define ECSOCO_2_REMOTE_PORT_MIN               AT_SOC_PORT_MIN
#define ECSOCO_2_REMOTE_PORT_MAX               AT_SOC_PORT_MAX
#define ECSOCO_2_REMOTE_PORT_DEF               0

/*AT+ECSOSD*/
#define ECSOSD_0_SOCKET_ID_MIN                 AT_SOC_FD_MIN
#define ECSOSD_0_SOCKET_ID_MAX                 AT_SOC_FD_MAX
#define ECSOSD_0_SOCKET_ID_DEF                 AT_SOC_FD_DEF
#define ECSOSD_1_LENGTH_MIN                    AT_SOC_UL_LENGTH_MIN
#define ECSOSD_1_LENGTH_MAX                    AT_SOC_UL_LENGTH_MAX
#define ECSOSD_1_LENGTH_DEF                    0
#define ECSOSD_2_DATA_MAX_LEN                  AT_SOC_UL_LENGTH_MAX
#define ECSOSD_2_DATA_DEF                      NULL
#define ECSOSD_3_FLAG_STR_MAX_LEN              5
#define ECSOSD_3_FLAG_STR_DEF                  NULL
#define ECSOSD_3_FLAG_DEF                      0
#define ECSOSD_4_SEQUENCE_MIN                  AT_SOC_UL_DATA_SEQUENCE_MIN
#define ECSOSD_4_SEQUENCE_MAX                  AT_SOC_UL_DATA_SEQUENCE_MAX
#define ECSOSD_4_SEQUENCE_DEF                  0

#define ECSOSDT_0_SOCKET_ID_MIN                 AT_SOC_FD_MIN
#define ECSOSDT_0_SOCKET_ID_MAX                 AT_SOC_FD_MAX
#define ECSOSDT_0_SOCKET_ID_DEF                 AT_SOC_FD_DEF
#define ECSOSDT_1_LENGTH_MIN                    AT_SOC_UL_LENGTH_MIN
#define ECSOSDT_1_LENGTH_MAX                    AT_SOC_UL_LENGTH_MAX
#define ECSOSDT_1_LENGTH_DEF                    -1
#define ECSOSDT_2_FLAG_STR_MAX_LEN              5
#define ECSOSDT_2_FLAG_STR_DEF                  NULL
#define ECSOSDT_2_FLAG_DEF                      0
#define ECSOSDT_3_SEQUENCE_MIN                  AT_SOC_UL_DATA_SEQUENCE_MIN
#define ECSOSDT_3_SEQUENCE_MAX                  AT_SOC_UL_DATA_SEQUENCE_MAX
#define ECSOSDT_3_SEQUENCE_DEF                  0
/*AT+ECSOCL*/
#define ECSOCL_0_SOCKET_ID_MIN                 AT_SOC_FD_MIN
#define ECSOCL_0_SOCKET_ID_MAX                 AT_SOC_FD_MAX
#define ECSOCL_0_SOCKET_ID_DEF                 AT_SOC_FD_DEF

/*AT+ECSONMI*/
#define ECSONMI_0_MODE_MIN                 AT_SOC_NOTIFY_MODE_MIN
#define ECSONMI_0_MODE_MAX                 AT_SOC_NOTIFY_MODE_MAX
#define ECSONMI_0_MODE_DEF                 AT_SOC_NOTIFY_MODE_IGNORE
#define ECSONMI_1_DL_BUFFER_MAX            AT_SOC_PUBLIC_DL_BUFFER_MAX
#define ECSONMI_1_DL_BUFFER_MIN            AT_SOC_PUBLIC_DL_BUFFER_MIN
#define ECSONMI_1_DL_BUFFER_DEF            AT_SOC_PUBLIC_DL_BUFFER_IGNORE
#define ECSONMI_2_DL_PKG_NUM_MAX           AT_SOC_PUBLIC_DL_PKG_NUM_MAX
#define ECSONMI_2_DL_PKG_NUM_MIN           AT_SOC_PUBLIC_DL_PKG_NUM_MIN
#define ECSONMI_2_DL_PKG_NUM_DEF           AT_SOC_PUBLIC_DL_PKG_NUM_IGNORE

/*AT+ECSONMIE*/
#define ECSONMIE_0_SOCKET_ID_MIN            AT_SOC_FD_MIN
#define ECSONMIE_0_SOCKET_ID_MAX            AT_SOC_FD_MAX
#define ECSONMIE_0_SOCKET_ID_DEF            AT_SOC_FD_DEF
#define ECSONMIE_1_MODE_MIN                 AT_SOC_NOTIFY_MODE_MIN
#define ECSONMIE_1_MODE_MAX                 AT_SOC_NOTIFY_MODE_PRIVATE_DISABLE
#define ECSONMIE_1_MODE_DEF                 AT_SOC_NOTIFY_MODE_IGNORE
#define ECSONMIE_2_DL_BUFFER_MAX            AT_SOC_PRIVATE_DL_BUFFER_MAX
#define ECSONMIE_2_DL_BUFFER_MIN            AT_SOC_PRIVATE_DL_BUFFER_MIN
#define ECSONMIE_2_DL_BUFFER_DEF            AT_SOC_PRIVATE_DL_BUFFER_IGNORE
#define ECSONMIE_3_DL_PKG_NUM_MAX           AT_SOC_PRIVATE_DL_PKG_NUM_MAX
#define ECSONMIE_3_DL_PKG_NUM_MIN           AT_SOC_PRIVATE_DL_PKG_NUM_MIN
#define ECSONMIE_3_DL_PKG_NUM_DEF           AT_SOC_PRIVATE_DL_PKG_NUM_IGNORE

#define ECSOSTATUS_0_SOCKET_ID_MIN                 AT_SOC_FD_MIN
#define ECSOSTATUS_0_SOCKET_ID_MAX                 AT_SOC_FD_MAX
#define ECSOSTATUS_0_SOCKET_ID_DEF                 AT_SOC_FD_DEF
#define ECSRVSOCRTCP_0_LISTEN_PORT_MIN               10000 // tcpip port manager limited
#define ECSRVSOCRTCP_0_LISTEN_PORT_MAX               10015
#define ECSRVSOCRTCP_0_LISTEN_PORT_DEF               10000
#define ECSRVSOCRTCP_1_AF_TYPE_STR_MAX_LEN           8
#define ECSRVSOCRTCP_1_AF_TYPE_STR_DEF               NULL
#define ECSRVSOCRTCP_2_IP_ADDR_STR_MAX_LEN           AT_SOC_IP_ADDR_STRING_LENGTH_MAX
#define ECSRVSOCRTCP_2_IP_ADDR_STR_DEF               NULL
#define ECSRVSOCLLISTEN_0_SERVER_FD_MIN     AT_SOC_FD_MIN
#define ECSRVSOCLLISTEN_0_SERVER_FD_MAX     AT_SOC_FD_MAX
#define ECSRVSOCLLISTEN_0_SERVER_FD_DEF     AT_SOC_FD_DEF
#define ECSRVSOCLCLIENT_0_SERVER_FD_MIN     AT_SOC_FD_MIN
#define ECSRVSOCLCLIENT_0_SERVER_FD_MAX     AT_SOC_FD_MAX
#define ECSRVSOCLCLIENT_0_SERVER_FD_DEF     AT_SOC_FD_DEF
#define ECSRVSOCLCLIENT_1_CLIENT_FD_MIN     AT_SOC_FD_MIN
#define ECSRVSOCLCLIENT_1_CLIENT_FD_MAX     AT_SOC_FD_MAX
#define ECSRVSOCLCLIENT_1_CLIENT_FD_DEF     AT_SOC_FD_ALL
#define ECCRVSOTCPSENDCLT_0_MIN             AT_SOC_FD_MIN
#define ECCRVSOTCPSENDCLT_0_MAX             AT_SOC_FD_MAX
#define ECCRVSOTCPSENDCLT_0_DEF             AT_SOC_FD_DEF
#define ECCRVSOTCPSENDCLT_1_MIN             1
#define ECCRVSOTCPSENDCLT_1_MAX             SUPPORT_MAX_SOCKET_RAW_DATA_LENGTH
#define ECCRVSOTCPSENDCLT_1_DEF             1
#define ECCRVSOTCPSENDCLT_2_STR_MAX_LEN     6
#define ECCRVSOTCPSENDCLT_2_STR_DEF         NULL
#define ECCRVSOTCPSENDCLT_3_MIN             0
#define ECCRVSOTCPSENDCLT_3_MAX             2
#define ECCRVSOTCPSENDCLT_3_DEF             0
#define ECCRVSOTCPSENDCLT_4_MIN             0
#define ECCRVSOTCPSENDCLT_4_MAX             1
#define ECCRVSOTCPSENDCLT_4_DEF             0
#define ECSRVSOTCPLISTENSTATUS_0_SERVER_FD_MIN     AT_SOC_FD_MIN
#define ECSRVSOTCPLISTENSTATUS_0_SERVER_FD_MAX     AT_SOC_FD_MAX
#define ECSRVSOTCPLISTENSTATUS_0_SERVER_FD_DEF     AT_SOC_FD_DEF
#define ECCRVSOTCPSENDCLTT_0_MIN             AT_SOC_FD_MIN
#define ECCRVSOTCPSENDCLTT_0_MAX             AT_SOC_FD_MAX
#define ECCRVSOTCPSENDCLTT_0_DEF             AT_SOC_FD_DEF
#define ECCRVSOTCPSENDCLTT_1_MIN             1
#define ECCRVSOTCPSENDCLTT_1_MAX             SUPPORT_MAX_SOCKET_RAW_DATA_LENGTH
#define ECCRVSOTCPSENDCLTT_1_DEF             -1
#define ECCRVSOTCPSENDCLTT_2_MIN             0
#define ECCRVSOTCPSENDCLTT_2_MAX             2
#define ECCRVSOTCPSENDCLTT_2_DEF             0
#define ECCRVSOTCPSENDCLTT_3_MIN             0
#define ECCRVSOTCPSENDCLTT_3_MAX             1
#define ECCRVSOTCPSENDCLTT_3_DEF             0

#define ECSOCR_NAME  "+ECSOCR"
#define ECSOST_NAME  "+ECSOST"
#define ECSOSTT_NAME  "+ECSOSTT"
#define ECSOSTF_NAME  "+ECSOSTF"
#define ECSOSTFT_NAME  "+ECSOSTFT"
#define ECQSOS_NAME  "+ECQSOS"
#define ECSORF_NAME  "+ECSORF"
#define ECSOCO_NAME  "+ECSOCO"
#define ECSOSD_NAME  "+ECSOSD"
#define ECSOSDT_NAME  "+ECSOSDT"
#define ECSOCL_NAME  "+ECSOCL"
#define ECSONMI_NAME  "+ECSONMI"
#define ECSONMIE_NAME  "+ECSONMIE"
#define ECSOSTATUS_NAME  "+ECSOSTATUS"
#define ECSOCLI_NAME  "+ECSOCLI"
#define ECSOSTR_NAME  "+ECSOSTR"
#define ECQSOSR_NAME  "+ECQSOSR"

//#else
#if 0
#define ECSOCR_NAME  "+NSOCR"
#define ECSOST_NAME  "+NSOST"
#define ECSOSTT_NAME  "+NSOSTT"
#define ECSOSTF_NAME  "+NSOSTF"
#define ECSOSTFT_NAME  "+NSOSTFT"
#define ECQSOS_NAME  "+NQSOS"
#define ECSORF_NAME  "+NSORF"
#define ECSOCO_NAME  "+NSOCO"
#define ECSOSD_NAME  "+NSOSD"
#define ECSOSDT_NAME  "+NSOSDT"
#define ECSOCL_NAME  "+NSOCL"
#define ECSONMI_NAME  "+NSONMI"
#define ECSONMIE_NAME  "+NSONMIE"
#define ECSOSTATUS_NAME  "+NSOSTATUS"
#define ECSOCLI_NAME  "+NSOCLI"
#define ECSOSTR_NAME  "+NSOSTR"
#define ECQSOSR_NAME  "+NQSOSR"
#endif
CmsRetId  nmSNTP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmPING(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECDNS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECIPERF(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmSKTCREATE(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmSKTSEND(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmSKTSENDT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmSKTSTATUS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmSKTCONNECT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmSKTBIND(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmSKTDELETE(const AtCmdInputContext *pAtCmdReq);

CmsRetId  nmECSOCR(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSOST(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSOSTT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSOSTF(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSOSTFT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECQSOS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSORF(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSOCO(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSOSD(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSOSDT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSOCL(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSONMI(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSONMIE(const AtCmdInputContext *pAtCmdReq);

CmsRetId  nmECSOSTATUS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECDNSCFG(const AtCmdInputContext *pAtCmdReq);

CmsRetId  nmECSRVSOCRTCP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSRVSOCLLISTEN(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSRVSOCLCLIENT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSRVSOTCPSENDCLT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSRVSOTCPLISTENSTATUS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECSRVSOTCPSENDCLTT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmSocketInputData(UINT8 chanId, UINT8 *pInput, UINT16 length);
void      nmSocketFreeSendInfo(void);
CmsRetId  nmECNETCFG(const AtCmdInputContext *pAtCmdReq);
CmsRetId  nmECNETDEVCTL(const AtCmdInputContext *pAtCmdReq);

#endif

