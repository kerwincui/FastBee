/***********************************************************
 * function： 设备认证
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1
 * source:    https://github.com/kerwincui/wumei-smart
 ***********************************************************/
 
#ifndef _AUTH9_H
#define _AUTH9_H

#include "Common.h"
#include "Mqtt.h"
#include "Base64.h"
#include <Ethernet.h>
#include <ESP8266HTTPClient.h>

// 连接mqtt, AES加密认证
void connectMqtt();
// 生成加密密码
String generationAESPwd();
// 获取时间
String getTime();
// AES加密
String encrypt(String plain_data,char *wumei_key,char *wumei_iv);
// AES解密
String decrypt(String encoded_data_str,char *wumei_key,char *wumei_iv);

#endif 
