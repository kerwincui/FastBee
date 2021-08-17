#ifndef __MQTT_H
#define __MQTT_H 

#ifdef __cplusplus
extern "C" {
#endif

#include "main.h"
#include "esp8266.h"


#define User_ESP8266_SSID     "brown"    //wifi名
#define User_ESP8266_PWD      "123456789a"      //wifi密码

#define User_ESP8266_client_id    "50fccfefb50a48b98a93ce27bb04591f"   //MQTTclientID 用于标志client身份  最长256字节
#define User_ESP8266_username     "admin"						//用于登录 MQTT 服务器 的 username, 最长 64 字节	
#define User_ESP8266_password			"admin123"          //用于登录 MQTT 服务器 的 password, 最长 64 字节
#define User_ESP8266_MQTTServer_IP     "106.12.9.213"     //MQTT本地服务器IP
#define User_ESP8266_MQTTServer_PORT   1883     //服务器端口号
#define User_ESP8266_MQTTServer_Topic_PUB  "status"    //发布MQTT主题
#define User_ESP8266_MQTTServer_Topic_SUB  "status/set/E8DB84933089"    //订阅MQTT主题

enum{
	MQTT_NULL		=	0,
	MQTT_CONNECT	=	1 << 4,
	MQTT_CONNACK	=	2 << 4,
	MQTT_PUBLISH	=	3 << 4,
	MQTT_PUBACK		=	4 << 4,
	MQTT_PUBREC		=	5 << 4,
	MQTT_PUBREL		=	6 << 4,
	MQTT_PUBCOMP	=	7 << 4,
	MQTT_SUBSCRIBE  =	8 << 4,
	MQTT_SUBACK		=	9 << 4,
	MQTT_UNSUBSCRIBE=	10 << 4,
	MQTT_UNSUBACK	=	11 << 4,
	MQTT_PINGREQ	=	12 << 4,
	MQTT_PINGRESP	=	13 << 4,
	MQTT_DISCONNECT	=	14 << 4,
}MQTT_HEAD_T;

enum{
	CONNECT_FLAG	=	0,
	CONNECT_FLAG_NAME	=	1 << 7,
	CONNECT_FLAG_PWD	=	1 << 6,
	CONNECT_FLAG_RETAIN	=	1 << 5,
	CONNECT_FLAG_QOS	=	1 << 4,
	CONNECT_FLAG_FLAG	=	1 << 2,
	CONNECT_FLAG_CLS	=	1 << 1,
}CONNECT_T;

enum{
	PUBLISH_FLAG_RETN = 1,
	PUBLISH_FLAG_QOS0 = 0,
	PUBLISH_FLAG_QOS1 = 1 << 1,
	PUBLISH_FLAG_QOS2 = 1 << 2,
	PUBLISH_FLAG_DUP  = 1 << 3,
}PUBLISH_FLAG_T;

int mqtt_init(void);
int mqtt_handle(void);
int mqtt_beat(void);
int mqtt_publish_update(uint8_t *msg, uint16_t msg_len);


#ifdef __cplusplus
}
#endif

#endif /* __MQTT_H */

