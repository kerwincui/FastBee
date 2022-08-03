/*********************************************************************
 * function： 设备认证
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: wumei-smart and kerwincui all rights reserved.
 ********************************************************************/

#ifndef _AUTH_H
#define _AUTH_H

#include "Config.h"
#include "User.h"
#include "Mqtt.h"
#include <Ethernet.h>
#include <ESP8266HTTPClient.h>

// 连接mqtt, AES加密认证
void connectMqtt();
// 生成加密密码
String generationAESPwd();
// 获取时间
String getTime();
// AES加密
String encrypt(String plain_data, char *wumei_key, char *wumei_iv);
// AES解密
String decrypt(String encoded_data_str, char *wumei_key, char *wumei_iv);

#endif
