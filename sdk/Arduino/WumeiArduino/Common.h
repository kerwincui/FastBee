/***********************************************************
 * function： 设备交互
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1
 * source:    https://github.com/kerwincui/wumei-smart
 ***********************************************************/
 
#ifndef _COMMON_H
#define _COMMON_H

#include "Base64.h"
#include <ESP8266WiFi.h>
#include <Ethernet.h>
#include <ESP8266HTTPClient.h>
#include <PubSubClient.h>      // 版本2.8.0
#include <ArduinoJson.h>       // 版本6.19.1

extern WiFiClient wifiClient;
extern PubSubClient mqttClient;

extern String deviceNum ;      // 设备编号（重要，同时是Mqtt的clientId）
extern String userId;          // 用户ID
extern String productId;       // 产品ID
extern float rssi;             // 信号强度（信号极好4格[-55— 0]，信号好3格[-70— -55]，信号一般2格[-85— -70]，信号差1格[-100— -85]）
extern float firmwareVersion;  // 固件版本
extern float latitude;         // 设备精度
extern float longitude;        // 设备维度
extern char *wifiSsid;         // WIFI的SSID
extern char *wifiPwd;          // WIFI的密码
extern char *mqttHost;         // Mqtt消息服务器地址
extern int mqttPort;           // Mqtt消息服务器端口
extern char *mqttUserName;     // Mqtt消息服务器账号
extern char *mqttPwd;          // Mqtt消息服务器密码
extern char mqttSecret[17];    // Mqtt秘钥,16位
extern char wumei_iv[17];      // AES加密偏移量，固定值16位
extern String authCode;        // 产品授权码，产品未启用时为空字符串
extern String ntpServer;       // NTP服务地址，用于获取当前时间
extern int monitorCount;       // 发布监测数据的最大次数
extern long monitorInterval;   // 发布监测数据的间隔，默认1000毫秒

// 连接WIFI
void connectWifi();
// 随机生成监测值
String randomPropertyData();
//打印提示信息
void printMsg(String tips);
// 控制指示灯闪烁
void blink();

#endif 
