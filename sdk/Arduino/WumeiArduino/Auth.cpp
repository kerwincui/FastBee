/*********************************************************************
 * function： 设备认证
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: wumei-smart and kerwincui all rights reserved.
 ********************************************************************/

#include "Auth.h"

/*
 * 连接MQTT，加密认证
 */
void connectMqtt()
{
  printMsg("连接Mqtt服务器...");
  mqttClient.setClient(wifiClient);
  mqttClient.setServer(mqttHost, mqttPort);
  mqttClient.setBufferSize(1024);
  mqttClient.setKeepAlive(5);
  // 设置Mqtt回调函数
  mqttClient.setCallback(mqttCallback);

  // 生成mqtt加密密码
  String aesPassword = generationAESPwd();
  // 连接 设备mqtt客户端Id格式为：认证类型(E=加密、S=简单) & 设备编号 & 产品ID & 用户ID
  String clientId = "E&" + (String)deviceNum + "&" + (String)productId + "&" + (String)userId;
  printMsg("客户端ID：" + clientId);
  bool connectResult = mqttClient.connect(clientId.c_str(), mqttUserName, aesPassword.c_str());
  if (connectResult)
  {
    printMsg("连接Mqtt成功");
    // 订阅系统主题
    subscribeTopic();
    // 发布设备信息,设备上电都需要发布一次
    publishInfo();
  }
  else
  {
    printMsg("连接失败, rc=");
    Serial.print(mqttClient.state());
  }
}

/*
 * 生成加密密码
 */
String generationAESPwd()
{
  // 获取NTP时间
  String jsonTime = getTime();
  StaticJsonDocument<128> doc;
  DeserializationError error = deserializeJson(doc, jsonTime);
  if (error)
  {
    printMsg("Json解析失败：");
    Serial.print(error.f_str());
    return "";
  }
  // 获取NTP时间=（设备发送消息时间 + 服务器接收消息时间 + 服务器发送消息时间 - 设备接收时间 最后除于2 ）
  float deviceSendTime = doc["deviceSendTime"];
  float serverSendTime = doc["serverSendTime"];
  float serverRecvTime = doc["serverRecvTime"];
  float deviceRecvTime = millis();
  float now = (serverSendTime + serverRecvTime + deviceRecvTime - deviceSendTime) / 2;
  // 过期时间 = 当前时间 + 1小时
  float expireTime = now + 1 * 60 * 60 * 1000;
  // 加密认证，密码格式为：mqtt密码 & 过期时间 & 授权码（可选），如果产品启用了授权码就必须加上
  String password = "";
  if (authCode == "")
  {
    password = (String)mqttPwd + "&" + String(expireTime, 0);
  }
  else
  {
    password = (String)mqttPwd + "&" + String(expireTime, 0) + "&" + authCode;
  }
  // 密码加密
  printMsg("密码(未加密):" + password);
  String encryptPassword = encrypt(password, mqttSecret, wumei_iv);
  printMsg("密码(已加密)：" + encryptPassword);
  return encryptPassword;
}

/*
 * 通过HTTP获取NTP时间
 */
String getTime()
{
  while (WiFi.status() == WL_CONNECTED)
  {
    HTTPClient http;
    printMsg("获取时间...");
    if (http.begin(wifiClient, (ntpServer + (String)millis()).c_str()))
    {
      // 发送请求
      int httpCode = http.GET();
      if (httpCode > 0)
      {
        if (httpCode == HTTP_CODE_OK || httpCode == HTTP_CODE_MOVED_PERMANENTLY)
        {
          printMsg("获取时间成功，data:");
          Serial.print(http.getString());
          return http.getString();
        }
      }
      else
      {
        printMsg("获取时间失败，error:");
        Serial.printf(http.errorToString(httpCode).c_str());
      }
      http.end();
    }
    else
    {
      printMsg("连接Http失败");
    }
    delay(500);
  }
  return "";
}

/*
 * AES加密 (AES-CBC-128-pkcs5padding)
 */
String encrypt(String plain_data, char *wumei_key, char *wumei_iv)
{
  int i;
  // pkcs7padding填充 Block Size : 16
  int len = plain_data.length();
  int n_blocks = len / 16 + 1;
  uint8_t n_padding = n_blocks * 16 - len;
  uint8_t data[n_blocks * 16];
  memcpy(data, plain_data.c_str(), len);
  for (i = len; i < n_blocks * 16; i++)
  {
    data[i] = n_padding;
  }
  uint8_t key[16], iv[16];
  memcpy(key, wumei_key, 16);
  memcpy(iv, wumei_iv, 16);
  // 加密
  br_aes_big_cbcenc_keys encCtx;
  br_aes_big_cbcenc_init(&encCtx, key, 16);
  br_aes_big_cbcenc_run(&encCtx, iv, data, n_blocks * 16);
  // Base64编码
  len = n_blocks * 16;
  char encoded_data[base64_enc_len(len)];
  base64_encode(encoded_data, (char *)data, len);
  return String(encoded_data);
}

/*
 * AES解密 (AES-CBC-128-pkcs5padding)
 */
String decrypt(String encoded_data_str, char *wumei_key, char *wumei_iv)
{
  int input_len = encoded_data_str.length();
  char *encoded_data = const_cast<char *>(encoded_data_str.c_str());
  int len = base64_dec_len(encoded_data, input_len);
  uint8_t data[len];
  base64_decode((char *)data, encoded_data, input_len);
  uint8_t key[16], iv[16];
  memcpy(key, wumei_key, 16);
  memcpy(iv, wumei_iv, 16);
  int n_blocks = len / 16;
  br_aes_big_cbcdec_keys decCtx;
  br_aes_big_cbcdec_init(&decCtx, key, 16);
  br_aes_big_cbcdec_run(&decCtx, iv, data, n_blocks * 16);
  // PKCS#7 Padding 填充
  uint8_t n_padding = data[n_blocks * 16 - 1];
  len = n_blocks * 16 - n_padding;
  char plain_data[len + 1];
  memcpy(plain_data, data, len);
  plain_data[len] = '\0';
  return String(plain_data);
}
