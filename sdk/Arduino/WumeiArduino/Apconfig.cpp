/*********************************************************************
 * function： 程序入口
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: wumei-smart and kerwincui all rights reserved.
 ********************************************************************/

#include "ApConfig.h"

String randomName="wumei-device"+(String)random(1000);
const char *ap_ssid =randomName.c_str();
const char *ap_password = ""; //开放式网络

char sta_ssid[32] = {0};
char sta_password[64] = {0};
char sta_user_id[32] = {0};

IPAddress local_IP(192, 168, 4, 1);
IPAddress gateway(192, 168, 4, 1);
IPAddress subnet(255, 255, 255, 0);

ESP8266WebServer server(80);

/**
 * 启动AP配网
 */
void startApConfig()
{
  WiFi.mode(WIFI_AP_STA);
  WiFi.softAPConfig(local_IP, gateway, subnet);
  WiFi.softAP(ap_ssid, ap_password);
  printMsg("已启动AP配网，IP地址：" + WiFi.softAPIP().toString()+"， 热点名称："+(String)ap_ssid);
  // 启动web服务
  startWebServer();
}

/**
 * 启动Web服务
 */
void startWebServer()
{
  isApMode=true;
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
 void handleStatus(){
   server.send(200, "text/plain;charset=utf-8", "AP配网已准备就绪");
 }
 
/**
 * AP配网接口
 */
void handleConfig()
{
  printMsg("进入配网......");
  // wifi名称、wifi密码、用户编号
  if (server.hasArg("SSID") && server.hasArg("password") && server.hasArg("userId"))
  {
    strcpy(sta_ssid, server.arg("SSID").c_str());
    strcpy(sta_password, server.arg("password").c_str());
    strcpy(sta_user_id, server.arg("userId").c_str());
    printMsg("收到WIFI名称：" + (String)sta_ssid);
    printMsg("收到WIFI密码：" + (String)sta_password);
    printMsg("收到用户编号：" + (String)sta_user_id);
  }
  else
  {
    printMsg("配网必须传递用户编号、WIFI名称和WIFI密码,配网失败");
    server.send(500, "text/plain;charset=utf-8", "配网必须传递用户编号、WIFI名称和WIFI密码，配网失败");
    return;
  }
  // 可选字段
  if (server.hasArg("deviceNum"))
  {
    printMsg("收到设备编号：" + server.arg("deviceNum"));
  }
  if (server.hasArg("authCode"))
  {
    printMsg("收到产品授权码：" + server.arg("authCode"));
  }
  if (server.hasArg("extra"))
  {
    printMsg("收到补充信息：" + server.arg("extra"));
  }  
  server.send(200, "text/plain;charset=utf-8", "设备已更新WIFI配置，开始连接WIFI...");

  // 连接Wifi，关闭web服务
  isApMode=false;
  connectWifi();
  server.close();
}

/**
 * 找不到页面和跨域处理
 */
void handleNotFound()
{
  printMsg("进入预检请求或请求地址找不到");
  if (server.method() == HTTP_OPTIONS)
  {
    // 处理浏览器跨域问题
    server.sendHeader("Access-Control-Max-Age", "10000");
    server.sendHeader("Access-Control-Allow-Methods", "PUT,POST,GET,OPTIONS");
    server.sendHeader("Access-Control-Allow-Headers", "*");
    server.send(204);
  }
  else
  {
    server.send(404, "text/plain;charset=utf-8", "请求的地址找不到或无法访问");
  }
}

