/*********************************************************************
 * function： 设备AP配网
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: FastBee and kerwincui all rights reserved.
 ********************************************************************/

#include "ApConfig.h"

String randomName = "wumei-device" + (String)random(1000);
const char *ap_ssid = randomName.c_str();
//开放式网络，不设置密码
const char *ap_password = "";

IPAddress local_IP(192, 168, 4, 1);
IPAddress gateway(192, 168, 4, 1);
IPAddress subnet(255, 255, 255, 0);
ESP8266WebServer server(80);

/**
 * 启动AP配网
 */
void startApConfig() {
  ledStatus(true);
  WiFi.mode(WIFI_AP_STA);
  WiFi.softAPConfig(local_IP, gateway, subnet);
  WiFi.softAP(ap_ssid, ap_password);
  printMsg("已启动AP配网，IP地址：" + WiFi.softAPIP().toString() + "， 热点名称：" + (String)ap_ssid);
  // 启动web服务
  startWebServer();
}

/**
 * 启动Web服务
 */
void startWebServer() {
  isApMode = true;
  server.on("/status", HTTP_GET, handleStatus);
  server.on("/config", HTTP_POST, handleConfig);
  server.onNotFound(handleNotFound);
  server.enableCORS(true);
  server.begin();
  printMsg("HTTP服务已启动");
}

/**
 * 检测设备接口
 */
void handleStatus() {
  server.send(200, "text/plain;charset=utf-8", "AP配网已准备就绪");
}

/**
 * AP配网接口
 */
void handleConfig() {
  printMsg("进入配网......");
  config_type config;
  // wifi名称、wifi密码、用户编号
  if (server.hasArg("SSID") && server.hasArg("password") && server.hasArg("userId")) {
    // 分配空间
    wifiSsid = (char *)malloc(32 * sizeof(char));
    wifiPwd = (char *)malloc(64 * sizeof(char));
    userId = (char *)malloc(16 * sizeof(char));
    strcpy(config.stassid, server.arg("SSID").c_str());
    strcpy(wifiSsid, server.arg("SSID").c_str());
    strcpy(config.stapsw, server.arg("password").c_str());
    strcpy(wifiPwd, server.arg("password").c_str());
    strcpy(config.userId, server.arg("userId").c_str());
    strcpy(userId, server.arg("userId").c_str());

    printMsg("收到WIFI名称：" + (String)config.stassid);
    printMsg("收到WIFI密码：" + (String)config.stapsw);
    printMsg("收到用户编号：" + (String)config.userId);
  } else {
    printMsg("配网必须传递用户编号、WIFI名称和WIFI密码,配网失败");
    server.send(500, "text/plain;charset=utf-8", "配网必须传递用户编号、WIFI名称和WIFI密码，配网失败");
    return;
  }
  // 可选字段
  if (server.hasArg("deviceNum")) {
    deviceNum = (char *)malloc(32 * sizeof(char));
    strcpy(config.deviceNum, server.arg("deviceNum").c_str());
    strcpy(deviceNum, server.arg("deviceNum").c_str());
    printMsg("收到设备编号：" + server.arg("deviceNum"));
  }
  if (server.hasArg("authCode")) {
    authCode = (char *)malloc(32 * sizeof(char));
    strcpy(config.authCode, server.arg("authCode").c_str());
    strcpy(authCode, server.arg("authCode").c_str());
    printMsg("收到产品授权码：" + server.arg("authCode"));
  }
  if (server.hasArg("extra")) {
    printMsg("收到补充信息：" + server.arg("extra"));
  }
  server.send(200, "text/plain;charset=utf-8", "设备已更新WIFI配置，开始连接WIFI...");
  // 统一设置Mqtt消息主题前缀
  prefix = "/" + (String)productId + "/" + (String)deviceNum;
  // 存储配置
  saveConfig(config);
  // 连接Wifi
  connectWifi();
}

/**
 * 找不到页面和跨域处理
 */
void handleNotFound() {
  printMsg("进入预检请求或请求地址找不到");
  if (server.method() == HTTP_OPTIONS) {
    // 处理浏览器跨域问题
    server.sendHeader("Access-Control-Max-Age", "10000");
    server.sendHeader("Access-Control-Allow-Methods", "PUT,POST,GET,OPTIONS");
    server.sendHeader("Access-Control-Allow-Headers", "*");
    server.send(204);
  } else {
    server.send(404, "text/plain;charset=utf-8", "请求的地址找不到或无法访问");
  }
}
