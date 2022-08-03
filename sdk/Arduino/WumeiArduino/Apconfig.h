/*********************************************************************
 * function： 设备AP配网
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: wumei-smart and kerwincui all rights reserved.
 ********************************************************************/

#ifndef _APCONFIG_H
#define _APCONFIG_H

#include "Config.h"
#include <ESP8266WebServer.h>

extern ESP8266WebServer server;

// 启动AP配网
void startApConfig();
// 启动Web服务
void startWebServer();
// 配网接口
void handleConfig();
// 检测设备接口
void handleStatus();
// 找不到页面和浏览器跨域处理
void handleNotFound();

#endif
