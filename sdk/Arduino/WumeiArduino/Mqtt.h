/***********************************************************
 * function： 设备交互
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1
 * source:    https://github.com/kerwincui/wumei-smart
 ***********************************************************/
 
#ifndef _MQTT_H
#define _MQTT_H

#include "Common.h"
#include <ESP8266WiFi.h>
#include <Ethernet.h>
#include <ESP8266HTTPClient.h>
#include <PubSubClient.h>      // 版本2.8.0
#include <ArduinoJson.h>       // 版本6.19.1

// 订阅的主题
extern String sInfoTopic;      // 订阅设备信息
extern String sOtaTopic;       // 订阅OTA升级
extern String sNtpTopic;       // 订阅NTP时间
extern String sPropertyTopic;  // 订阅属性
extern String sFunctionTopic;  // 订阅功能
extern String sPropertyOnline; // 订阅属性-在线模式
extern String sFunctionOnline; // 订阅功能-在线模式
extern String sMonitorTopic;   // 订阅实时监测
// 发布的主题
extern String pInfoTopic;      // 发布设备信息
extern String pNtpTopic;       // 发布NTP时间
extern String pPropertyTopic;  // 发布属性
extern String pFunctionTopic;  // 发布功能
extern String pMonitorTopic;   // 发布实时监测数据
extern String pEventTopic;     // 发布事件

// 发布设备信息
void publishInfo();
// 发布时钟同步信息
void publishNtp();
// 发布事件
void publishEvent();
// 发布实时监测数据
void publishMonitor();
// 发布属性
void publishProperty(String msg);
// 发布功能
void publishFunction(String msg);

// Mqtt回调
void mqttCallback(char *topic, byte *payload, unsigned int length);
// 属性处理
void processProperty(String payload);
// 功能处理
void processFunction(String payload);

#endif 
