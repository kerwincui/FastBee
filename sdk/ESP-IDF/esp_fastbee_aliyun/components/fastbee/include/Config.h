/*********************************************************************
 * function： 设备交互
 * board:     esp8266,esp32,esp32s2,esp32s3 core for esp-idf v4.4.7
 * source:    https://gitee.com/zhuangpengli/IOTDeviceSDK
 * copyright: zhuangpeng.li all rights reserved.
 ********************************************************************/
#ifndef _CONFIG_H
#define _CONFIG_H
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#define MQTT_URL_LEN                 (64)
#define MQTT_USERNAME_LEN            (64)
#define MQTT_PASSWORD_LEN            (64)
#define MQTT_CLIENTID_LEN            (64)
#define USER_ID_LEN                  (16)
#define DEVICE_SN_LEN                (64)
#define PRODUCT_ID_LEN               (16)
#define MQTT_PREFIX_LEN              (128)

#define MFG_FASTBEE_PARTITION_NAME "fctry"
#define NVS_FASTBEE_PRODUCT "fastbee-key"

extern char g_userId[USER_ID_LEN + 1];            // 用户ID
extern char g_productId[PRODUCT_ID_LEN + 1];      // 产品ID
extern char g_deviceSN[DEVICE_SN_LEN + 1];        // 设备编号（重要，同时是Mqtt的clientId）

// Mqtt配置
extern char g_mqtt_url[MQTT_URL_LEN + 1];
extern char g_mqtt_username[MQTT_USERNAME_LEN + 1];
extern char g_mqtt_password[MQTT_PASSWORD_LEN + 1];
extern char g_mqtt_clientid[MQTT_CLIENTID_LEN + 1];
extern char g_mqtt_prefix[MQTT_PREFIX_LEN + 1];

extern float rssi;             // 信号强度（信号极好4格[-55— 0]，信号好3格[-70— -55]，信号一般2格[-85— -70]，信号差1格[-100— -85]）
extern char wumei_iv[17];      // AES加密偏移量，固定值16位
extern int monitorCount;       // 发布监测数据的最大次数
extern long monitorInterval;   // 发布监测数据的间隔，默认1000毫秒
extern bool isApMode;          // 是否进入AP配网模式

/********************************** begin 可配置的项 **********************************/
extern char *wifiSsid;         // WIFI的SSID
extern char *wifiPwd;          // WIFI的密码

extern char *authCode;         // 产品授权码，产品未启用时为空字符串

extern float firmwareVersion;  // 固件版本
extern float latitude;         // 设备精度
extern float longitude;        // 设备维度

extern char mqttSecret[17];    // Mqtt秘钥,16位
extern char *ntpServer;       // NTP服务地址，用于获取当前时间
/********************************** end 可配置的项 **********************************/

// 加载配置
void loadConfig();
#endif
