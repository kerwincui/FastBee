/***********************************************************
 * author: kerwincui [物美智能 wumei-smart]
 * create: 2022-02-20
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 * board:esp8266 core for arduino v3.0.2
 ***********************************************************/

#include "Helper.h"

WiFiClient wifiClient;
PubSubClient mqttClient;
float rssi = 0;
char wumei_iv[17] = "wumei-smart-open";
int monitorCount = 0;
long monitorInterval = 1000;

//==================================== 这是需要配置的项 ===============================
// Wifi配置
char *wifiSsid = "wumei";
char *wifiPwd = "wumei-smart";

// 设备信息配置
String deviceNum = "D6329VL548866";
String userId = "1";
String productId = "41";
float firmwareVersion = 1.0;
// 经度和纬度可选，如果产品使用设备定位，则必须传
float latitude=0;
float longitude=0;

// Mqtt配置
char *mqttHost = "wumei.live";
int mqttPort = 1883;
char *mqttUserName = "wumei-smart";
char *mqttPwd = "PHYFED93WSFF1DAS";
char mqttSecret[17] = "K2V5DE28XNUU3497";
// 产品启用授权码，则授权码不能为空
String authCode="";

// NTP地址（用于获取时间,可选的修改为自己部署项目的地址）
String ntpServer = "http://wumei.live:8080/iot/tool/ntp?deviceSendTime=";
//====================================================================================

// 订阅的主题
String prefix = "/" + productId + "/" + deviceNum;
String sInfoTopic = prefix + "/info/get";
String sOtaTopic = prefix + "/ota/get";
String sNtpTopic = prefix + "/ntp/get";
String sPropertyTopic = prefix + "/property/get";
String sFunctionTopic = prefix + "/function/get";
String sPropertyOnline = prefix + "/property-online/get";
String sFunctionOnline = prefix + "/function-online/get";
String sMonitorTopic = prefix + "/monitor/get";
// 发布的主题
String pInfoTopic = prefix + "/info/post";
String pNtpTopic = prefix + "/ntp/post";
String pPropertyTopic = prefix + "/property/post";
String pFunctionTopic = prefix + "/function/post";
String pMonitorTopic = prefix + "/monitor/post";
String pEventTopic = prefix + "/event/post";

// 物模型-属性处理
void processProperty(String payload)
{
  StaticJsonDocument<1024> doc;
  DeserializationError error = deserializeJson(doc, payload);
  if (error) {
    Serial.print(F("deserializeJson() failed: "));
    Serial.println(error.f_str());
    return;
  }
  for (JsonObject object : doc.as<JsonArray>())
  {
    // 匹配云端定义的属性（不包含属性中的监测数据）
    const char* id = object["id"];
    const char* value = object["value"];
    printMsg((String)id + "：" + (String)value);
  }
  // 最后发布属性，服务端订阅存储（重要）
  publishProperty(payload);
}

// 物模型-功能处理
void processFunction(String payload)
{
  StaticJsonDocument<1024> doc;
  DeserializationError error = deserializeJson(doc, payload);
  if (error) {
    Serial.print(F("deserializeJson() failed: "));
    Serial.println(error.f_str());
    return;
  }
  for (JsonObject object : doc.as<JsonArray>())
  {
    // 匹配云端定义的功能
    const char* id = object["id"];
    const char* value = object["value"];
    if (strcmp(id, "switch") == 0)
    {
      printMsg("开关 switch：" + (String) value);
    }
    else if (strcmp(id, "gear") == 0)
    {
      printMsg("档位 gear：" + (String)value);
    }
    else if (strcmp(id, "light_color") == 0)
    {
      printMsg("灯光颜色 light_color：" + (String)value);
    }
    else if (strcmp(id, "message") == 0)
    {
      printMsg("屏显消息 message：" + (String)value);
    }else if(strcmp(id,"report_monitor")==0){
      String msg=randomPropertyData();
      printMsg("订阅到上报监测数据指令，上报数据：");
      printMsg(msg);
      publishProperty(msg);
    }
  }
  // 最后发布功能,服务端订阅存储（重要）
  publishFunction(payload);
}

// Mqtt回调
void callback(char *topic, byte *payload, unsigned int length)
{
  blink();
  printMsg("接收数据：");
  String data = "";
  for (int i = 0; i < length; i++)
  {
    Serial.print((char)payload[i]);
    data += (char)payload[i];
  }

  if (strcmp(topic, sOtaTopic.c_str()) == 0)
  {
    printMsg("订阅到设备升级指令...");
    StaticJsonDocument<256> doc;
    DeserializationError error = deserializeJson(doc, payload);
    if (error)
    {
      Serial.print(F("deserializeJson() failed: "));
      Serial.println(error.f_str());
      return;
    }
    String newVersion = doc["version"];
    String downloadUrl = doc["downloadUrl"];
    printMsg("固件版本："+newVersion);
    printMsg("下载地址："+downloadUrl);
  }
  else if (strcmp(topic, sInfoTopic.c_str()) == 0)
  {
    printMsg("订阅到设备信息...");
    // 发布设备信息
    publishInfo();
  }
  else if (strcmp(topic, sNtpTopic.c_str()) == 0)
  {
    printMsg("订阅到NTP时间...");
    StaticJsonDocument<256> doc;
    DeserializationError error = deserializeJson(doc, payload);
    if (error)
    {
      Serial.print(F("deserializeJson() failed: "));
      Serial.println(error.f_str());
      return;
    }
    // 计算设备当前时间：(${serverRecvTime} + ${serverSendTime} + ${deviceRecvTime} - ${deviceSendTime}) / 2
    float deviceSendTime = doc["deviceSendTime"];
    float serverSendTime = doc["serverSendTime"];
    float serverRecvTime = doc["serverRecvTime"];
    float deviceRecvTime = millis();
    float now = (serverSendTime + serverRecvTime + deviceRecvTime - deviceSendTime) / 2;
    printMsg("当前时间：" + String(now, 0));
  }
  else if (strcmp(topic, sPropertyTopic.c_str()) == 0 || strcmp(topic, sPropertyOnline.c_str()) == 0)
  {
    printMsg("订阅到属性指令...");
    processProperty(data);
  }
  else if (strcmp(topic, sFunctionTopic.c_str()) == 0 || strcmp(topic, sFunctionOnline.c_str()) == 0)
  {
    printMsg("订阅到功能指令...");
    processFunction(data);
  }
  else if (strcmp(topic, sMonitorTopic.c_str()) == 0)
  {
    printMsg("订阅到实时监测指令...");
    StaticJsonDocument<128> doc;
    DeserializationError error = deserializeJson(doc, payload);
    if (error)
    {
      Serial.print(F("deserializeJson() failed: "));
      Serial.println(error.f_str());
      return;
    }
    monitorCount = doc["count"];
    monitorInterval = doc["interval"];
  }  
}

// 连接wifi
void connectWifi()
{
  printMsg("连接 ");
  Serial.print(wifiSsid);
  WiFi.mode(WIFI_STA);
  WiFi.begin(wifiSsid, wifiPwd);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  printMsg("WiFi连接成功");
  printMsg("IP地址: ");
  Serial.print(WiFi.localIP());
}

// 连接mqtt
void connectMqtt()
{
  printMsg("连接Mqtt服务器...");
  // 生成mqtt认证密码(设备加密认证，密码加密格式为：mqtt密码 & 过期时间 & 授权码，其中授权码为可选)
  String password = generationPwd();
  String encryptPassword = encrypt(password, mqttSecret, wumei_iv);
  printMsg("密码(已加密)：" + encryptPassword);
  mqttClient.setClient(wifiClient);
  mqttClient.setServer(mqttHost, mqttPort);
  mqttClient.setCallback(callback);
  mqttClient.setBufferSize(1024);
  mqttClient.setKeepAlive(10);
  //连接 设备mqtt客户端Id格式为：认证类型(E=加密、S=简单) & 设备编号 & 产品ID & 用户ID
  String clientId = "E&" + deviceNum + "&" + productId +"&" + userId;
  bool connectResult = mqttClient.connect(clientId.c_str(), mqttUserName, encryptPassword.c_str());
  if (connectResult)
  {
    printMsg("连接成功");
    // 订阅(OTA、NTP、属性、功能、实时监测、信息)
    mqttClient.subscribe(sInfoTopic.c_str(), 1);
    mqttClient.subscribe(sOtaTopic.c_str(), 1);
    mqttClient.subscribe(sNtpTopic.c_str(), 1);
    mqttClient.subscribe(sPropertyTopic.c_str(), 1);
    mqttClient.subscribe(sFunctionTopic.c_str(), 1);
    mqttClient.subscribe(sPropertyOnline.c_str(), 1);
    mqttClient.subscribe(sFunctionOnline.c_str(), 1);
    mqttClient.subscribe(sMonitorTopic.c_str(), 1);
    printMsg("订阅主题：" + sInfoTopic);
    printMsg("订阅主题：" + sOtaTopic);
    printMsg("订阅主题：" + sNtpTopic);
    printMsg("订阅主题：" + sPropertyTopic);
    printMsg("订阅主题：" + sFunctionTopic);
    printMsg("订阅主题：" + sPropertyOnline);
    printMsg("订阅主题：" + sFunctionOnline);
    printMsg("订阅主题：" + sMonitorTopic);
    // 发布设备信息
    publishInfo();
  }
  else
  {
    printMsg("连接失败, rc=");
    Serial.print(mqttClient.state());
  }
}

// 1.发布设备信息
void publishInfo()
{
  StaticJsonDocument<256> doc;
  doc["rssi"] = WiFi.RSSI();
  doc["firmwareVersion"] = firmwareVersion;
  doc["status"] = 3; // （1-未激活，2-禁用，3-在线，4-离线）
  doc["userId"] = (String)userId;
  doc["longitude"] = longitude;  //经度 可选
  doc["latitude"] = latitude;    // 纬度 可选
  // 设备摘要,可选（自定义配置信息）
  JsonObject summary = doc.createNestedObject("summary");
  summary["name"]="wumei-smart";
  summary["chip"]="esp8266";
  summary["author"]="kerwincui";
  summary["version"]=1.6;
  summary["create"]="2022-06-06";

  printMsg("发布设备信息:");
  serializeJson(doc, Serial);
  String output;
  serializeJson(doc, output);
  mqttClient.publish(pInfoTopic.c_str(), output.c_str());
}

// 2.发布时钟同步信，用于获取当前时间(可选)
void publishNtp()
{
  StaticJsonDocument<128> doc;
  doc["deviceSendTime"] = millis();

  printMsg("发布NTP信息:");
  serializeJson(doc, Serial);
  String output;
  serializeJson(doc, output);
  mqttClient.publish(pNtpTopic.c_str(), output.c_str());
}

// 3.发布属性
void publishProperty(String msg)
{
  printMsg("发布属性:" + msg);
  mqttClient.publish(pPropertyTopic.c_str(), msg.c_str());
}

// 4.发布功能
void publishFunction(String msg)
{
  printMsg("发布功能:" + msg);
  mqttClient.publish(pFunctionTopic.c_str(), msg.c_str());
}

// 5.发布事件
void publishEvent()
{
  // 匹配云端的事件
  StaticJsonDocument<512> doc;
  JsonObject objTmeperature = doc.createNestedObject();
  objTmeperature["id"] = "height_temperature";
  objTmeperature["value"] = "40";
  objTmeperature["remark"] = "温度过高警告";

  JsonObject objException = doc.createNestedObject();
  objException["id"] = "exception";
  objException["value"] = "异常消息，消息内容XXXXXXXX";
  objException["remark"] = "设备发生错误";

  printMsg("发布事件:");
  serializeJson(doc, Serial);
  String output;
  serializeJson(doc, output);
  mqttClient.publish(pEventTopic.c_str(), output.c_str());
}

// 6.发布实时监测数据
void publishMonitor()
{
  String msg=randomPropertyData();
  // 发布为实时监测数据，不会存储
  printMsg("发布实时监测数据:"+msg);
  mqttClient.publish(pMonitorTopic.c_str(), msg.c_str());
}

// 随机生成监测值
String randomPropertyData(){
  // 匹配云端定义的监测数据，随机数代替监测结果
  float randFloat = 0;
  int randInt=0;
  StaticJsonDocument<1024> doc;
  JsonObject objTmeperature = doc.createNestedObject();
  objTmeperature["id"] = "temperature";
  randFloat = random(1000, 3000) ;
  objTmeperature["value"] = (String)(randFloat/100);
  objTmeperature["remark"] = (String)millis();

  JsonObject objHumidity   = doc.createNestedObject();
  objHumidity["id"] = "humidity";
  randFloat = random(3000, 6000);
  objHumidity["value"] = (String)(randFloat/100);
  objHumidity["remark"] = (String)millis();

  JsonObject objCo2 = doc.createNestedObject();
  objCo2["id"] = "co2";
  randInt = random(400, 1000);
  objCo2["value"] = (String)(randInt);
  objCo2["remark"] = (String)millis();

  JsonObject objBrightness = doc.createNestedObject();
  objBrightness["id"] = "brightness";
  randInt = random(1000, 10000);
  objBrightness["value"] = (String)(randInt);
  objBrightness["remark"] = (String)millis();

  printMsg("随机生成监测数据值:");
  serializeJson(doc, Serial);
  String output;
  serializeJson(doc, output);
  return output;
}

// 生成密码
String generationPwd()
{
  String jsonTime = getTime();
  // 128字节内存池容量
  StaticJsonDocument<128> doc;
  // 解析JSON
  DeserializationError error = deserializeJson(doc, jsonTime);
  if (error)
  {
    printMsg("Json解析失败：");
    Serial.print(error.f_str());
    return "";
  }
  // 获取当前时间
  float deviceSendTime = doc["deviceSendTime"];
  float serverSendTime = doc["serverSendTime"];
  float serverRecvTime = doc["serverRecvTime"];
  float deviceRecvTime = millis();
  float now = (serverSendTime + serverRecvTime + deviceRecvTime - deviceSendTime) / 2;
  // 过期时间 = 当前时间 + 1小时
  float expireTime = now + 1 * 60 * 60 * 1000;
  // 密码加密格式为：mqtt密码 & 过期时间 & 授权码（可选），如果产品启用了授权码就必须加上
  String password="";
  if(authCode==""){
    password = (String)mqttPwd + "&" + String(expireTime, 0);
  }else{
    password = (String)mqttPwd + "&" + String(expireTime, 0)+ "&" + authCode;
  }
  printMsg("密码(未加密):" + password);
  return password;
}

//  HTTP获取时间
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
  return "1672524366000"; 
}

//打印提示信息
void printMsg(String msg)
{
  Serial.print("\r\n[");
  Serial.print(millis());
  Serial.print("ms]");
  Serial.print(msg);
}

// 控制指示灯闪烁
void blink()
{
  printMsg("指示灯闪烁...");
  pinMode(15, OUTPUT);
  for (int i = 0; i < 2; i++)
  {
    digitalWrite(15, HIGH);
    delay(200);
    digitalWrite(15, LOW);
    delay(200);
  }
}

// 加密 (AES-CBC-128-pkcs5padding)
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

// 解密 (AES-CBC-128-pkcs5padding)
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
