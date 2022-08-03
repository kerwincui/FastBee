/*********************************************************************
 * function： 用户自定义功能
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: wumei-smart and kerwincui all rights reserved.
 ********************************************************************/

#ifndef _USER_H
#define _USER_H

#include "Config.h"
#include "Mqtt.h"
#include <OneButton.h> // 版本2.0.4

extern OneButton button;

// 初始化用户配置
void initUser();
// Mqtt回调
void mqttCallback(char *topic, byte *payload, unsigned int length);
// 属性处理（物模型）
void processProperty(String msg);
// 功能处理（物模型）
void processFunction(String msg);
// 事件处理（无模型）
void processEvent();
// 模拟监测值
String randomPropertyData();
// 控制继电器状态
void relayStatus(bool status);

#endif
