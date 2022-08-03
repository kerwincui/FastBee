/*********************************************************************
 * function： 设备配置和系统功能
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: wumei-smart and kerwincui all rights reserved.
 ********************************************************************/

#ifndef _CONFIG_H
#define _CONFIG_H

#include "Apconfig.h"
#include "Base64.h"
#include <ESP8266WiFi.h>
#include <EEPROM.h>
#include <PubSubClient.h> // 版本2.8.0
#include <ArduinoJson.h>  // 版本6.19.1

// 存储的配置类型结构
struct config_type
{
  char flag;          // 是否有数据标识，等于1表示有数据
  char stassid[32];   // SSID配置项
  char stapsw[64];    // Password配置项
  char deviceNum[32]; // 设备编号配置项
  char userId[16];    // 用户ID配置项
  char authCode[32];  // 授权码配置项
};

extern WiFiClient wifiClient;
extern PubSubClient mqttClient;

// 全局变量
extern char *deviceNum;       // 设备编号（重要，同时是Mqtt的clientId）
extern char *userId;          // 用户ID
extern char *productId;       // 产品ID
extern float rssi;            // 信号强度（信号极好4格[-55— 0]，信号好3格[-70— -55]，信号一般2格[-85— -70]，信号差1格[-100— -85]）
extern float firmwareVersion; // 固件版本
extern float latitude;        // 设备精度
extern float longitude;       // 设备维度
extern char *wifiSsid;        // WIFI的SSID
extern char *wifiPwd;         // WIFI的密码
extern char *mqttHost;        // Mqtt消息服务器地址
extern int mqttPort;          // Mqtt消息服务器端口
extern char *mqttUserName;    // Mqtt消息服务器账号
extern char *mqttPwd;         // Mqtt消息服务器密码
extern char mqttSecret[17];   // Mqtt秘钥,16位
extern char wumei_iv[17];     // AES加密偏移量，固定值16位
extern char *authCode;        // 产品授权码，产品未启用时为空字符串
extern String ntpServer;      // NTP服务地址，用于获取当前时间
extern int monitorCount;      // 发布监测数据的最大次数
extern long monitorInterval;  // 发布监测数据的间隔，默认1000毫秒
extern bool isApMode;         // 是否进入AP配网模式

// 订阅的主题
extern String prefix;          // Mqtt消息主题前缀
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

// 连接WIFI
void connectWifi();
// 加载配置
void loadConfig();
// 保存配置
void saveConfig(config_type config);
// 清空配置
void clearConfig();
//打印提示信息
void printMsg(String msg);
// 控制指示灯闪烁
void blink();
// 控制指示灯状态
void ledStatus(bool status);

#endif
