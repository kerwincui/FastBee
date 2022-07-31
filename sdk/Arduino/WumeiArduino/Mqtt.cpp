/***********************************************************
 * function： 设备交互
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1
 * source:    https://github.com/kerwincui/wumei-smart
 ***********************************************************/

#include "Mqtt.h"

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
void mqttCallback(char *topic, byte *payload, unsigned int length)
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
