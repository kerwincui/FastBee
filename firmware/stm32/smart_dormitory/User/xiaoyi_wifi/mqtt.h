#ifndef __MQTT_H
#define __MQTT_H 

#include "main.h"
#include "esp8266.h"

/*
*以下参数需要用户自行修改才能测试用过
*/


#define User_ESP8266_SSID     "brown"    //wifi名
#define User_ESP8266_PWD      "123456789a"      //wifi密码

#define User_ESP8266_client_id    "50fccfefb50a48b98a93ce27bb04591f"   //MQTTclientID 用于标志client身份  最长256字节
#define User_ESP8266_username     "admin"						//用于登录 MQTT 服务器 的 username, 最长 64 字节	
#define User_ESP8266_password			"admin13"          //用于登录 MQTT 服务器 的 password, 最长 64 字节
#define User_ESP8266_MQTTServer_IP     "106.12.9.213"     //MQTT本地服务器IP
#define User_ESP8266_MQTTServer_PORT   1883     //服务器端口号
#define User_ESP8266_MQTTServer_Topic_PUB  "status"    //发布MQTT主题
#define User_ESP8266_MQTTServer_Topic_SUB  "status/set/E8DB84933089"    //订阅MQTT主题


void ESP8266_STA_MQTTClient_Init(void);

#endif
