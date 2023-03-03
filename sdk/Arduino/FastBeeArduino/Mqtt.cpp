/*********************************************************************
 * function： 设备交互
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: FastBee and kerwincui all rights reserved.
 ********************************************************************/

#include "Mqtt.h"

// 订阅系统主题
void subscribeTopic() {
  mqttClient.subscribe((prefix + sInfoTopic).c_str(), 1);
  mqttClient.subscribe((prefix + sOtaTopic).c_str(), 1);
  mqttClient.subscribe((prefix + sNtpTopic).c_str(), 1);
  mqttClient.subscribe((prefix + sPropertyTopic).c_str(), 1);
  mqttClient.subscribe((prefix + sFunctionTopic).c_str(), 1);
  mqttClient.subscribe((prefix + sPropertyOnline).c_str(), 1);
  mqttClient.subscribe((prefix + sFunctionOnline).c_str(), 1);
  mqttClient.subscribe((prefix + sMonitorTopic).c_str(), 1);
  printMsg("订阅主题完成");
}

// 1.发布设备信息
void publishInfo() {
  StaticJsonDocument<256> doc;
  doc["rssi"] = WiFi.RSSI();
  doc["firmwareVersion"] = firmwareVersion;
  doc["status"] = 3;  // （1-未激活，2-禁用，3-在线，4-离线）
  doc["userId"] = (String)userId;
  doc["longitude"] = longitude;  //经度 可选
  doc["latitude"] = latitude;    // 纬度 可选
  // 设备摘要,可选（自定义配置信息）
  JsonObject summary = doc.createNestedObject("summary");
  summary["name"] = "wumei-smart";
  summary["chip"] = "esp8266";
  summary["author"] = "kerwincui";
  summary["version"] = 1.6;
  summary["create"] = "2022-06-06";

  printMsg("发布设备信息:");
  serializeJson(doc, Serial);
  String output;
  serializeJson(doc, output);
  printMsg("主题为:" + prefix + pInfoTopic);
  mqttClient.publish((prefix + pInfoTopic).c_str(), output.c_str());
}

// 2.发布时钟同步信，用于获取当前时间(可选)
void publishNtp() {
  StaticJsonDocument<128> doc;
  doc["deviceSendTime"] = millis();
  printMsg("发布主题:" + prefix + pNtpTopic);
  printMsg("信息:");
  serializeJson(doc, Serial);
  String output;
  serializeJson(doc, output);
  mqttClient.publish((prefix + pNtpTopic).c_str(), output.c_str());
}

// 3.发布属性
void publishProperty(String msg) {
  printMsg("发布属性:" + prefix + pPropertyTopic);
  printMsg("消息:" + msg);
  mqttClient.publish((prefix + pPropertyTopic).c_str(), msg.c_str());
}

// 4.发布功能
void publishFunction(String msg) {
  printMsg("发布功能:" + prefix + pFunctionTopic);
  printMsg("消息:" + msg);
  mqttClient.publish((prefix + pFunctionTopic).c_str(), msg.c_str());
}

// 5.发布事件
void publishEvent(String msg) {
  printMsg("发布事件:" + prefix + pEventTopic);
  printMsg("消息:" + msg);
  mqttClient.publish((prefix + pEventTopic).c_str(), msg.c_str());
}

// 6.发布实时监测数据
void publishMonitor(String msg) {
  // 发布实时监测数据（不会存储，需要实时存储则发布为属性）
  printMsg("发布实时监测消息:" + msg);
  mqttClient.publish((prefix + pMonitorTopic).c_str(), msg.c_str());
}
