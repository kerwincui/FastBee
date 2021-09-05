#ifndef _MQTT_H_
#define _MQTT_H_

#include "stm32f10x.h"

#include "esp8266_uart2.h"

#include "stdio.h"

#include "string.h"

#include "stdarg.h"

#include "cJSON.h"

typedef enum
{
	CONNECT     = 1, 
    CONNACK     = 2,
    
    PUBLISH     = 3,
    PUBACK      = 4,
    PUBREC      = 5, 
    PUBREL      = 6,
	PUBCOMP     = 7, 
    
    SUBSCRIBE   = 8, 
    SUBACK      = 9, 
    UNSUBSCRIBE = 10,
    UNSUBACK    = 11,
	
    PINGREQ     = 12, 
    PINGRESP    = 13, 
    DISCONNECT  = 14
}msgTypes;

typedef struct
{
	unsigned short keepAlive;
    
    char clientID[50];
	char username[50];
	char password[50];
} MQTT_ConnectData_t;
extern MQTT_ConnectData_t MQTT_ConnectData;

uint8_t MQTTSCode_Connect(void);
/*订阅 服务质量*/
uint8_t MQTTSCode_Subscribe(char *topic, uint8_t qos, uint8_t bsf);
/*发布，暂定负载小于100字节*/
uint8_t MQTTSCode_Publish(char *topic, char *payload, uint16_t payloadLen, uint8_t dup, uint8_t qos, uint16_t bsf);
uint8_t MQTTSCode_KeepAlive(void); // 心跳 服务质量
uint8_t MQTTSCode_DisConnect(void);// 断开连接
#endif


