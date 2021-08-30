#ifndef __MQTT_H
#define __MQTT_H 

#include "main.h"
#include "esp8266.h"

/*
*以下参数需要用户自行修改才能测试用过
*/


#define WIFI_SSID     "DianJing"    //wifi名
#define WIFI_PWD      "wzry6666"      //wifi密码

#define WIFI_client_id    "50fccfefb50a48b98a93ce27bb04591f"   //MQTTclientID 用于标志client身份  最长256字节
#define WIFI_username     "admin"						//用于登录 MQTT 服务器 的 username, 最长 64 字节	
#define WIFI_password			"admin13"          //用于登录 MQTT 服务器 的 password, 最长 64 字节
#define WIFI_MQTTServer_IP     "106.12.9.213"     //MQTT本地服务器IP
#define WIFI_MQTTServer_PORT   1883     //服务器端口号
#define WIFI_MQTTServer_Topic_PUB  "status"    //发布MQTT主题
#define WIFI_MQTTServer_Topic_SUB  "status/set/863488052352477"    //订阅MQTT主题


void ESP8266_STA_MQTTClient_Init(void);

#endif
