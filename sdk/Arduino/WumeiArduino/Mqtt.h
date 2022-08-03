/*********************************************************************
 * function： 设备交互
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: wumei-smart and kerwincui all rights reserved.
 ********************************************************************/

#ifndef _MQTT_H
#define _MQTT_H

#include "Config.h"

// 订阅系统主题
void subscribeTopic();
// 发布设备信息
void publishInfo();
// 发布时钟同步信息
void publishNtp();
// 发布事件
void publishEvent(String msg);
// 发布实时监测数据（不会存储，需要实时存储则发布属性）
void publishMonitor(String msg);
// 发布属性
void publishProperty(String msg);
// 发布功能
void publishFunction(String msg);

#endif
