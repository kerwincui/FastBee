/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: ec_mqtt_api.h
 *
 *  Description: MQTT interface layer header file
 *
 *  History:
 *
 *  Notes:
 *
******************************************************************************/
#ifndef __EC_MQTT_API_H__
#define __EC_MQTT_API_H__

#include "CommonTypedef.h"
#include "MQTTClient.h"

/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/
#define MQTT_TASK_CREATE   1
#define MQTT_TASK_DELETE   2


/******************************************************************************
 *****************************************************************************
 * ENUM
 *****************************************************************************
******************************************************************************/

/*
 * APPL SGID: APPL_MQTT, related PRIM ID
*/
typedef enum applMqttPrimId_Enum
{
    APPL_MQTT_PRIM_ID_BASE = 0,

	APPL_MQTT_OPEN_REQ, //
	APPL_MQTT_OPEN_CNF,
	APPL_MQTT_OPEN_IND,
	
	APPL_MQTT_CLOSE_REQ, //
	APPL_MQTT_CLOSE_CNF,
	APPL_MQTT_CLOSE_IND,

	APPL_MQTT_CONN_REQ, //
	APPL_MQTT_CONN_CNF,
	APPL_MQTT_CONN_IND,

	APPL_MQTT_DISC_REQ, //
	APPL_MQTT_DISC_CNF,
	APPL_MQTT_DISC_IND,

    APPL_MQTT_SUB_REQ,   //
    APPL_MQTT_SUB_CNF,
    APPL_MQTT_SUB_IND,

    APPL_MQTT_UNSUB_REQ,   //
    APPL_MQTT_UNSUB_CNF,
    APPL_MQTT_UNSUB_IND,
    
    APPL_MQTT_PUB_REQ,   //
    APPL_MQTT_PUB_CNF,
    APPL_MQTT_PUB_IND,
    
    APPL_MQTT_STAT_REQ,   //
    APPL_MQTT_STAT_CNF,
    APPL_MQTT_STAT_IND,
        
    APPL_MQTT_RECV_REQ,   //
    APPL_MQTT_RECV_CNF,
    APPL_MQTT_RECV_IND,

    APPL_MQTT_PRIM_ID_END = 0xFF
}applMqttPrimId;


/*
 * MQTT error code
*/
typedef enum AT_MQTT_ERROR
{
    MQTT_PARAM_ERROR = 1,                             /**/
    MQTT_CREATE_CLIENT_ERROR = 2,                     /**/
    MQTT_CREATE_SOCK_ERROR = 3,                       /**/
    MQTT_CONNECT_TCP_FAIL = 4,                        /**/
    MQTT_CONNECT_MQTT_FAIL = 5,                       /**/
    MQTT_SUB_FAIL = 6,                                /**/
    MQTT_UNSUB_FAIL = 7,                              /**/
    MQTT_SEND_FAIL = 8,                               /**/
    MQTT_DELETE_FAIL = 9,                             /**/
    MQTT_FIND_CLIENT_FAIL = 10,                       /**/
    MQTT_NOT_SUPPORT = 11,                            /**/
    MQTT_NOT_CONNECTED = 12,                          /**/
    MQTT_INFO_FAIL = 13,                              /**/
    MQTT_NETWORK_FAIL = 14,                           /**/
    MQTT_PARAM_FAIL = 15,                             /**/
    MQTT_TASK_FAIL = 16,                            /**/
    MQTT_RECV_FAIL = 17,
	MQTT_ALI_ENCRYP_FAIL = 18,

}atMqttError;



int mqtt_init(MQTTClient* client, Network* network, unsigned char** sendBuf, int sendBufLen, unsigned char** readBuf, int readBufLen);
int mqtt_create(MQTTClient* client, Network* network, char* clientID, char* username, char* password, char *serverAddr, int port, MQTTPacket_connectData* connData);
int mqtt_close(MQTTClient* client, Network* network);
int mqtt_sub(MQTTClient* client, const char* topic, enum QoS qos, messageHandler messageHandler);
int mqtt_unsub(MQTTClient* client, const char* topic);
int mqtt_pub(MQTTClient* client, const char* topic, MQTTMessage* message);



#endif


