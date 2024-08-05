/*********************************************************************
 * function： 设备交互
 * board:     esp8266,esp32,esp32s2,esp32s3 core for esp-idf v4.4.7
 * source:    https://gitee.com/zhuangpengli/IOTDeviceSDK
 * copyright: zhuangpeng.li all rights reserved.
 ********************************************************************/
#ifndef _FASTBEE_MQTT_H
#define _FASTBEE_MQTT_H

#include "mqtt_client.h"
// 订阅的主题
extern char *sInfoTopic;       // 订阅设备信息
extern char *sOtaTopic;        // 订阅OTA升级
extern char *sNtpTopic;        // 订阅NTP时间
extern char *sPropertyTopic;   // 订阅属性
extern char *sFunctionTopic;   // 订阅功能
extern char *sPropertyOnline;  // 订阅属性-在线模式
extern char *sFunctionOnline;  // 订阅功能-在线模式
extern char *sMonitorTopic;    // 订阅实时监测
// 发布的主题
extern char *pInfoTopic;      // 发布设备信息
extern char *pNtpTopic;       // 发布NTP时间
extern char *pPropertyTopic;  // 发布属性
extern char *pFunctionTopic;  // 发布功能
extern char *pMonitorTopic;   // 发布实时监测数据
extern char *pEventTopic;     // 发布事件

// 订阅系统主题
void subscribeTopic(esp_mqtt_client_handle_t client);
// 发布设备信息
void publishInfo(esp_mqtt_client_handle_t client);
// 发布时钟同步信息
void publishNtp(esp_mqtt_client_handle_t client);
// 发布事件
void publishEvent(esp_mqtt_client_handle_t client, const char *msg);
// 发布实时监测数据（不会存储，需要实时存储则发布属性）
void publishMonitor(esp_mqtt_client_handle_t client, const char *msg);
// 发布属性
void publishProperty(esp_mqtt_client_handle_t client, const char *msg);
// 发布功能
void publishFunction(esp_mqtt_client_handle_t client, const char *msg);

#endif
