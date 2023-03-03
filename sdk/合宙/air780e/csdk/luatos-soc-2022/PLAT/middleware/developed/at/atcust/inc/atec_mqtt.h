/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_mqtt.h
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _ATEC_MQTT_H
#define _ATEC_MQTT_H

#include "at_util.h"

#define MQTT_ID_MIN                 0
#define MQTT_ID_MAX                 3
#define MQTT_ID_DEF                 0xff
#define MQTT_TCP_ID_MIN          0
#define MQTT_TCP_ID_MAX          0
#define MQTT_TCP_ID_DEF          0

/* AT+ECMTCFG */
#define MQTTCFG_CFG_MAX_LEN            17
#define MQTTCFG_CFG_STR_DEF             NULL
#define MQTTCFG_TCP_ID_MIN          MQTT_TCP_ID_MIN
#define MQTTCFG_TCP_ID_MAX          MQTT_TCP_ID_MAX
#define MQTTCFG_TCP_ID_DEF          MQTT_TCP_ID_DEF

#define MQTTCFG_2_ECHO_MIN              0
#define MQTTCFG_2_ECHO_MAX              1
#define MQTTCFG_2_ECHO_DEF              0

#define MQTTCFG_2_TXFORMAT_MIN              0
#define MQTTCFG_2_TXFORMAT_MAX              1
#define MQTTCFG_2_TXFORMAT_DEF              0
#define MQTTCFG_3_RXFORMAT_MIN                0
#define MQTTCFG_3_RXFORMAT_MAX                1
#define MQTTCFG_3_RXFORMAT_DEF                0

#define MQTTCFG_2_KEEPALIVE_MIN              0
#define MQTTCFG_2_KEEPALIVE_MAX              3600
#define MQTTCFG_2_KEEPALIVE_DEF              120

#define MQTTCFG_2_SESSION_MIN              0
#define MQTTCFG_2_SESSION_MAX              1
#define MQTTCFG_2_SESSION_DEF              0

#define MQTTCFG_2_PKT_MIN              1
#define MQTTCFG_2_PKT_MAX              60
#define MQTTCFG_2_PKT_DEF              10
#define MQTTCFG_3_RETRY_MIN              1
#define MQTTCFG_3_RETRY_MAX              10
#define MQTTCFG_3_RETRY_DEF              3
#define MQTTCFG_4_NOTICE_MIN               0
#define MQTTCFG_4_NOTICE_MAX               1
#define MQTTCFG_4_NOTICE_DEF               0

#define MQTTCFG_2_WILLFLAG_MIN              0
#define MQTTCFG_2_WILLFLAG_MAX              1
#define MQTTCFG_2_WILLFLAG_DEF              0
#define MQTTCFG_3_WILLQOS_MIN             0
#define MQTTCFG_3_WILLQOS_MAX             2
#define MQTTCFG_3_WILLQOS_DEF             0
#define MQTTCFG_4_WILLQRETAIN_MIN            0
#define MQTTCFG_4_WILLQRETAIN_MAX            1
#define MQTTCFG_4_WILLQRETAIN_DEF            0
#define MQTTCFG_5_WILLTOPIC_MAX_LEN               256
#define MQTTCFG_5_WILLTOPIC_STR_DEF               NULL
#define MQTTCFG_6_WILLMSG_MAX_LEN               256
#define MQTTCFG_6_WILLMSG_STR_DEF               NULL

#define MQTTCFG_2_VERSION_MIN              3
#define MQTTCFG_2_VERSION_MAX              4
#define MQTTCFG_2_VERSION_DEF              4

#define MQTTCFG_2_PRODKEY_MAX_LEN             33
#define MQTTCFG_2_PRODKEY_STR_DEF             NULL
#define MQTTCFG_3_DEVICENAME_MAX_LEN               33
#define MQTTCFG_3_DEVICENAME_STR_DEF               NULL
#define MQTTCFG_4_DEVICESECRET_MAX_LEN             65
#define MQTTCFG_4_DEVICESECRET_STR_DEF             NULL
#define MQTTCFG_5_PRODNAME_MAX_LEN             65
#define MQTTCFG_5_PRODNAME_STR_DEF             NULL
#define MQTTCFG_6_PRODSECRET_MAX_LEN             65
#define MQTTCFG_6_PRODSECRET_STR_DEF             NULL
#define MQTTCFG_7_AUTHTYPE_MAX_LEN             33
#define MQTTCFG_7_AUTHTYPE_STR_DEF             NULL
#define MQTTCFG_8_SIGNMETHOD_MAX_LEN             33
#define MQTTCFG_8_SIGNMETHOD_STR_DEF             NULL
#define MQTTCFG_9_AUTHMODE_MAX_LEN             33
#define MQTTCFG_9_AUTHMODE_STR_DEF             NULL
#define MQTTCFG_10_SECUREMODE_MAX_LEN             9
#define MQTTCFG_10_SECUREMODE_STR_DEF             NULL
#define MQTTCFG_11_INSTANCEID_MAX_LEN          33
#define MQTTCFG_11_INSTANCEID_STR_DEF          NULL
#define MQTTCFG_12_DYNREGUSED_MIN                  0
#define MQTTCFG_12_DYNREGUSED_MAX                  8
#define MQTTCFG_12_DYNREGUSED_DEF                  0

#define MQTTCFG_1_SSL_MAX_LEN             9
#define MQTTCFG_1_SSL_STR_DEF             NULL

#define MQTTCFG_2_PSK_MAX_LEN             129
#define MQTTCFG_2_PSK_STR_DEF             NULL
#define MQTTCFG_3_PSKID_MAX_LEN               256
#define MQTTCFG_3_PSKID_STR_DEF               NULL

#define MQTTCFG_2_ECC_MAX_LEN             4001
#define MQTTCFG_2_ECC_STR_DEF             NULL

#define MQTTCFG_2_CA_MAX_LEN             4001
#define MQTTCFG_2_CA_STR_DEF             NULL

#define MQTTCFG_3_NAME_MAX_LEN             65
#define MQTTCFG_3_NAME_STR_DEF             NULL

#define MQTTCFG_2_CLOUD_MIN              0
#define MQTTCFG_2_CLOUD_MAX              255
#define MQTTCFG_2_CLOUD_DEF              0
#define MQTTCFG_3_PAYLOADTYPE_MIN              0
#define MQTTCFG_3_PAYLOADTYPE_MAX              255
#define MQTTCFG_3_PAYLOADTYPE_DEF              1

/* AT+ECMTOPEN */
#define MQTTOPEN_TCP_ID_MIN          MQTT_TCP_ID_MIN
#define MQTTOPEN_TCP_ID_MAX          MQTT_TCP_ID_MAX
#define MQTTOPEN_TCP_ID_DEF          MQTT_TCP_ID_DEF
#define MQTTOPEN_1_HOST_MAX_LEN             128
#define MQTTOPEN_1_HOST_STR_DEF             NULL
#define MQTTOPEN_2_PORT_MIN          1
#define MQTTOPEN_2_PORT_MAX          65535
#define MQTTOPEN_2_PORT_DEF          1883

/* AT+ECMTCLOSE */
#define MQTTCLOSE_TCP_ID_MIN          MQTT_TCP_ID_MIN
#define MQTTCLOSE_TCP_ID_MAX          MQTT_TCP_ID_MAX
#define MQTTCLOSE_TCP_ID_DEF          MQTT_TCP_ID_DEF

/* AT+ECMTCONN*/
#define MQTTCONN_TCP_ID_MIN          MQTT_TCP_ID_MIN
#define MQTTCONN_TCP_ID_MAX          MQTT_TCP_ID_MAX
#define MQTTCONN_TCP_ID_DEF          MQTT_TCP_ID_DEF
#define MQTTCONN_1_CLIENTID_MAX_LEN             49//256
#define MQTTCONN_1_CLIENTID_STR_DEF             NULL
#define MQTTCONN_2_USERNAME_MAX_LEN           49//256
#define MQTTCONN_2_USERNAME_STR_DEF           NULL
#define MQTTCONN_3_PWD_MAX_LEN             129//256
#define MQTTCONN_3_PWD_STR_DEF             NULL

/* AT+ECMTDISC */
#define MQTTDISC_TCP_ID_MIN          MQTT_TCP_ID_MIN
#define MQTTDISC_TCP_ID_MAX          MQTT_TCP_ID_MAX
#define MQTTDISC_TCP_ID_DEF          MQTT_TCP_ID_DEF

/* AT+ECMTSUB */
#define MQTTSUB_TCP_ID_MIN          MQTT_TCP_ID_MIN
#define MQTTSUB_TCP_ID_MAX          MQTT_TCP_ID_MAX
#define MQTTSUB_TCP_ID_DEF          MQTT_TCP_ID_DEF
#define MQTTSUB_1_MSGID_MIN              1
#define MQTTSUB_1_MSGID_MAX              65535
#define MQTTSUB_1_MSGID_DEF              10
#define MQTTSUB_2_TOPIC_MAX_LEN          256
#define MQTTSUB_2_TOPIC_STR_DEF          NULL
#define MQTTSUB_3_QOS_MIN                    0
#define MQTTSUB_3_QOS_MAX                    2
#define MQTTSUB_3_QOS_DEF                    0

/* AT+ECMTUNSUB */
#define MQTTUNSUB_TCP_ID_MIN          MQTT_TCP_ID_MIN
#define MQTTUNSUB_TCP_ID_MAX          MQTT_TCP_ID_MAX
#define MQTTUNSUB_TCP_ID_DEF          MQTT_TCP_ID_DEF
#define MQTTUNSUB_1_MSGID_MIN              1
#define MQTTUNSUB_1_MSGID_MAX              65535
#define MQTTUNSUB_1_MSGID_DEF              10
#define MQTTUNSUB_2_TOPIC_MAX_LEN          256
#define MQTTUNSUB_2_TOPIC_STR_DEF          NULL

/* AT+ECMTPUB */
#define MQTTPUB_TCP_ID_MIN          MQTT_TCP_ID_MIN
#define MQTTPUB_TCP_ID_MAX          MQTT_TCP_ID_MAX
#define MQTTPUB_TCP_ID_DEF          MQTT_TCP_ID_DEF
#define MQTTPUB_1_MSGID_MIN              0
#define MQTTPUB_1_MSGID_MAX              65535
#define MQTTPUB_1_MSGID_DEF              10
#define MQTTPUB_2_QOS_MIN                    0
#define MQTTPUB_2_QOS_MAX                    2
#define MQTTPUB_2_QOS_DEF                    1
#define MQTTPUB_3_RETRAINED_MIN                  0
#define MQTTPUB_3_RETRAINED_MAX                  40
#define MQTTPUB_3_RETRAINED_DEF                  0
#define MQTTPUB_4_TOPIC_MAX_LEN              256
#define MQTTPUB_4_TOPIC_STR_DEF              NULL
#define MQTTPUB_5_MSG_MAX_LEN                    1027
#define MQTTPUB_5_MSG_STR_DEF                    NULL
#define MQTTPUB_6_CLOUD_MIN                  0
#define MQTTPUB_6_CLOUD_MAX                  128
#define MQTTPUB_6_CLOUD_DEF                  0xff
#define MQTTPUB_7_RETRAINED_MIN                  0
#define MQTTPUB_7_RETRAINED_MAX                  1
#define MQTTPUB_7_RETRAINED_DEF                  0xff
#define MQTTPUB_6_RAI_MIN                  0
#define MQTTPUB_6_RAI_MAX                  128
#define MQTTPUB_6_RAI_DEF                  0

#define MQTT_DATA_FORMAT_TXT                    0
#define MQTT_DATA_FORMAT_HEX                    1
#define MQTT_TLS_CA_SUB_SEQ_LEN                         64

typedef struct
{
    UINT32 reqHandle;
    int tcpId;
    int msgId;
    int qos;
    int retained;
    int rai;
    char *mqttTopic;
    
}mqtt_pub_data;

CmsRetId  mqttCFG(const AtCmdInputContext *AtCmdReqParaPtr);
CmsRetId  mqttOPEN(const AtCmdInputContext *AtCmdReqParaPtr);
CmsRetId  mqttCLOSE(const AtCmdInputContext *AtCmdReqParaPtr);
CmsRetId  mqttCONN(const AtCmdInputContext *AtCmdReqParaPtr);
CmsRetId  mqttDISC(const AtCmdInputContext *AtCmdReqParaPtr);
CmsRetId  mqttSUB(const AtCmdInputContext *AtCmdReqParaPtr);
CmsRetId  mqttUNS(const AtCmdInputContext *AtCmdReqParaPtr);
CmsRetId  mqttPUB(const AtCmdInputContext *AtCmdReqParaPtr);
CmsRetId  mqttPUBInputData(UINT8 chanId, UINT8 *pData, INT16 dataLength);
CmsRetId  mqttPUBCancel(void);

CmsRetId mqttOPENind(UINT16 primId, UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId mqttCLOSEind(UINT16 primId, UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId mqttCONNind(UINT16 primId, UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId mqttDISCind(UINT16 primId, UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId mqttSUBind(UINT16 primId, UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId mqttUNSind(UINT16 primId, UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId mqttPUBind(UINT16 primId, UINT16 reqHandle, UINT16 rc, void *paras);

CmsRetId  mqttSTATind(UINT16 primId, UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId  mqttRECVind(UINT16 primId, UINT16 reqHandle, UINT16 rc, void *paras);


#endif


