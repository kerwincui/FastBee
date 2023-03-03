/*
 * atec_mqtt_task.h
 *
 *  Created on: 
 *      Author:
 */
#ifndef _MQTT_TASK_H
#define _MQTT_TASK_H

#include "MQTTClient.h"
#ifdef FEATURE_MQTT_TLS_ENABLE
#include "mqtttls.h"
#endif

#define MQTT_SEND_Q_LENGTH      7

#define MQTT_SEND_TIMEOUT       2000
#define MQTT_RECV_TIMEOUT       5000
#define MQTT_TASK_CREATE   1 
#define MQTT_TASK_DELETE   2 

#define MQTT_SEMPHR_NOT_CREATE   1 
#define MQTT_SEMPHR_HAVE_CREATE   2 

#define MQTT_SEMPHR_MAX_NUMB   6 

#define MQTT_RECV_LOOP_TIMEOUT       2000

#define EC_TOPIC_LENGTH                     128
#define EC_BUFF_LENGTH                      128

#define MQTT_CONTEXT_NUMB_MAX      1
#define MQTT_ID_DEFAULT            0xff
#define MQTT_CLOUD_DEFAULT         0xff
#define MQTT_TCP_ID_DEFAULT        0xff

#define MQTT_CMD_TIMEOUT_DEFAULT        10000
#define MQTT_CMD_TIMEOUT_TX_DEFAULT        2
#define MQTT_CMD_TIMEOUT_RX_DEFAULT        20

#define MQTT_KEEPALIVE_DEFAULT        120

#define MQTT_TX_BUF_DEFAULT        (4+128+1024)    /*header+topic+payload*/
#define MQTT_RX_BUF_DEFAULT        (4+128+1024)    /*header+topic+payload*/

#define MQTT_PORT_DEFAULT        1883

#define MQTT_MSG_TIMEOUT        1000

#define MQTT_ERR_ABRT          (-13)
#define MQTT_ERR_RST           (-14)
#define MQTT_ERR_CLSD          (-15)
#define MQTT_ERR_BADE          (9)

#define MQTT_TAG_LEN          8
#define KEEPALIVE_RETRY_MAX    3
#define MQTT_RECONN_MAX       3

#define ALI_DYNAMIC_REGISTER_IS_NOT_USED       0
#define ALI_DYNAMIC_REGISTER_IS_USED           1

enum MQTT_PUB_TYPE
{
    MQTT_PUB_CTRLZ = 0,
    MQTT_PUB_AT = 1,
};

enum MQTT_INT_RET 
{ 
    MQTTSUCCESS = 0, 
    MQTTKEEPALIVE = 1 
};

enum MQTT_RET
{
    MQTT_OK = 200,
    MQTT_ERR,
    MQTT_NETWORK_ERR,
    MQTT_CONTEXT_ERR,
    MQTT_PARAM_ERR,
    MQTT_SOCKET_ERR,
    MQTT_SOCKET_TIME_ERR,
    MQTT_MQTT_CONN_ERR,
    MQTT_TASK_ERR,
    MQTT_RECONNECT,
    MQTT_CLIENT_ERR,
    MQTT_ALI_ENCRYP_ERR,
    MQTT_BUSY_ERR,
    MQTT_CONTINUE,

    MQTT_MAX_ERR,
};

enum MQTT_CONTEXT
{
    MQTT_CONTEXT_NOT_USED,
    MQTT_CONTEXT_USED,  
    MQTT_CONTEXT_IS_CREATING,
    MQTT_CONTEXT_OPENED,
    MQTT_CONTEXT_CONFIGED,
    
};

enum MQTT_CONNECT
{
    MQTT_CONN_DEFAULT,
    
    MQTT_CONN_NOT_OPEN,
    MQTT_CONN_IS_OPENING,
    MQTT_CONN_OPENED,
    MQTT_CONN_OPEN_FAIL,
    
    MQTT_CONN_IS_CONNECTING,
    MQTT_CONN_CONNECTED,
    MQTT_CONN_CONNECT_FAIL,
    
    MQTT_CONN_IS_CLOSING,
    MQTT_CONN_CLOSED,
    MQTT_CONN_CLOSED_FAIL,
    
    MQTT_CONN_IS_DISCONNECTING,
    MQTT_CONN_DISCONNECTED,
    MQTT_CONN_DISCONNECTED_FAIL,
    
    MQTT_CONN_RECONNECTING,
    MQTT_CONN_RECONNECTING_FAIL,
    
};

enum MQTT_MSG_CMD
{
    MSG_RESERVE,
    MQTT_MSG_OPEN,
    MQTT_MSG_CONNECT,
    MQTT_MSG_CLOSE,
    MQTT_MSG_DISCONNECT,
    MQTT_MSG_CREATE_CLINET,
    MQTT_MSG_KEEPALIVE, 
    MQTT_MSG_RECONNECT, 
    MQTT_MSG_DELETE_CLINET, 
    MQTT_MSG_PUBLISH, 
    MQTT_MSG_PUBLISH_REC, 
    MQTT_MSG_PUBLISH_REL, 
    MQTT_MSG_PUBLISH_ACK,
    MQTT_MSG_PUBLISH_COMP, 
    MQTT_MSG_SUB, 
    MQTT_MSG_UNSUB, 
    MQTT_MSG_CONNECT_DOWN, 
    MQTT_MSG_ALI_DYN_CONNECT,
    
};

enum MQTT_CMD
{
    ONENET_CMD,
    ALI_CMD,        
};
enum MQTT_DATA_TYPE
{
    MQTT_DATA_JSON = 0,
    MQTT_DATA_STR = 1,
    MQTT_DATA_HEX = 2,
    
    ONENET_DATA_TYPE1 = 1,
    ONENET_DATA_TYPE2 = 2,
    ONENET_DATA_TYPE3 = 3,
    ONENET_DATA_TYPE4 = 4,
    ONENET_DATA_TYPE5 = 5,
    ONENET_DATA_TYPE6 = 6,
    ONENET_DATA_TYPE7 = 7,
    ONENET_DATA_TYPE8 = 8,  //customer define data type
    ONENET_DATA_TYPE9 = 9,  //customer define data type

    MQTT_DATA_DEFAULT = 0xFF,
};

enum MQTT_CLOUD_TYPE
{
    CLOUD_TYPE_ONENET = 1,
    CLOUD_TYPE_ALI,
    CLOUD_TYPE_ECLIPSE,  /*not use client id, user name, passwd*/
    CLOUD_TYPE_NORMAL,   /*need client id, user name, passwd*/
    CLOUD_TYPE_MAX
};

enum MQTT_CONFIG_TYPE
{
    MQTT_CONFIG_BASE = 0,
    MQTT_CONFIG_ECHOMODE,
    MQTT_CONFIG_DATAFORMAT,
    MQTT_CONFIG_KEEPALIVE,
    MQTT_CONFIG_SEESION,
    MQTT_CONFIG_KEEPALIVE_CMD_TIMEOUT,
    MQTT_CONFIG_KEEPALIVE_CONN_TIMEOUT,
    MQTT_CONFIG_TIMEOUT,
    MQTT_CONFIG_CMD_TIMEOUT,
    MQTT_CONFIG_CONN_TIMEOUT,
    MQTT_CONFIG_WILL,
    MQTT_CONFIG_VERSION,
    MQTT_CONFIG_ALIAUTH,
    MQTT_CONFIG_OPEN,
    MQTT_CONFIG_CLOUD,
    MQTT_CONFIG_SSL,
    
    MQTT_CONFIG_MAX
};

enum MQTT_SSL_TYPE
{
    MQTT_SSL_NONE = 0,
    MQTT_SSL_HAVE = 1,
    MQTT_SSL_PSK = 2,
    MQTT_SSL_ECC,
    MQTT_SSL_CA,  
};

typedef struct
{
    int decParam1;
    int decParam2;
    int decParam3;
    char *strParam1;
    char *strParam2;
    char *strParam3;
    char *strParam4;
    char *strParam5;
    char *strParam6;
    char *strParam7;
    char *strParam8;
    char *strParam9;
    char *strParam10;
}mqtt_cfg_data;


typedef struct
{
    int    cmd_type;
    unsigned int reqhandle;
    void * context_ptr;
    void * client_ptr;
    int tcp_id;
    int msg_id;
    int pub_mode;
    int server_ack_mode;
    char *sub_topic;
    char *unsub_topic;
    char *topic;
    int qos;
    int rai;
    MQTTMessage message;
}mqtt_send_msg;

typedef struct
{
    int mqtt_id;
    char *mqtt_topic; 
    int  mqtt_topic_len; 
    char *mqtt_payload; 
    int  mqtt_payload_len; 
    int tcp_id;
    int msg_id;
    int ret;
    int conn_ret_code;
    int sub_ret_value;
    int pub_ret_value;
}mqtt_message;

typedef struct
{
    char *product_name;
    char *product_key; 
    char *product_secret; 
    char *device_name; 
    char *device_secret;
    char *device_token;
    char *auth_type;       /*register, regnwl*/  
    char *sign_method;     /*hmac_sha1, hmac_sha256, hmac_md5*/  
    char *auth_mode;       /*tls-psk, tls-ca*/
    char *secure_mode;     /*-2, 2*/
    char *instance_id;     /* */
    char *client_id;       /*for regnwl */
    int  dynamic_register_used;
}ali_auth;

typedef struct
{
    int is_used;
    int is_connected;
    int is_mqtts;
    int cloud_type;
    int tcp_id;
    int mqtt_id;
    UINT32 reqHandle;
    char *mqtt_uri; 
    unsigned int port;
    char *mqtt_send_buf;
    int mqtt_send_buf_len;
    char *mqtt_read_buf;
    int mqtt_read_buf_len;
    
    int reconnect_count;
    int (*reconnect) (void *c);
    MQTTPacket_connectData mqtt_connect_data;
    Network* mqtt_network;
    MQTTClient *mqtt_client;
    messageHandler mqtt_msg_handler;
#ifdef FEATURE_MQTT_TLS_ENABLE
    mqttsClientContext* mqtts_client;
#endif
    int echomode;
    int send_data_format;
    int recv_data_format;
    int keepalive;
    int session;
    int timeout;
    int version;
    int pkt_timeout;
    int retry_time;
    int timeout_notice;
    ali_auth aliAuth;
    
    char *sub_topic;
    char *unsub_topic;
    int qos;
    int retained;
    int payloadType;
    int ssl_type;
    char *ecc_key;
    char *ca_key;
    char *host_name;
    
}mqtt_context;

typedef struct
{
    unsigned char cleansession;
    unsigned char willFlag;
    MQTTPacket_willOptions will;
}mqtt_option;

typedef struct
{
    int dec_param1; /**/
    int dec_param2; /**/
    int dec_param3; /**/
    int dec_param4; /**/
    char *str_param1; /**/
    char *str_param2; /**/
    char *str_param3; /**/
    char *str_param4; /**/
    
}MQTT_CNF_STRUCT;

void check_tcpip_ready(void);
int mqttReconnect(void *v);
void MQTT_messageArrived(MessageData* data);
mqtt_context *mqttFindContext(int tcpId);

int mqtt_client_config(int cnfType, int tcpId, mqtt_cfg_data *cfgData);
int mqtt_client_open(UINT32 reqHandle, int tcpId, char *mqttUri, int mqttPort);
int mqtt_client_close(UINT32 reqHandle, int tcpId);
int mqtt_client_connect(UINT32 reqHandle, int tcpId, char *clientId, char *userName, char *passWord);
int mqtt_client_disconnect(UINT32 reqHandle, int tcpId);
int mqtt_client_sub(UINT32 reqHandle, int tcpId, int msgId, char *mqttSubTopic, int qos);
int mqtt_client_unsub(UINT32 reqHandle, int tcpId, int msgId, char *mqttSubTopic);
int mqtt_client_pub(UINT32 reqHandle, int tcpId, int msgId, int qos, int retained, int pubMode, char *mqttPubTopic, int msgLen, char *message, int cloudType, int msgType, int rai);

int mqtt_recv_task_Init(void);
int mqttCycle(mqtt_context* context, Timer* timer);
void mqttCloseSession(MQTTClient* c);


#endif



