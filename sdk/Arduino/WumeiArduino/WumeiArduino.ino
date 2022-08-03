/*********************************************************************
 * function： 程序入口
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: wumei-smart and kerwincui all rights reserved.
 ********************************************************************/

#include "Config.h"
#include "Auth.h"
#include "Apconfig.h"
#include "User.h"

long lastWifiConn;            // 上次wifi连接时间
long lastMqttConn;            // 上次mqtt连接时间
long lastPublishMonitor;      // 上次发布监测数据时间
long lastPublishSimulateData; // 上次发布测试数据时间

/**
 * 启动
 */
void setup()
{
  //打开串行端口：
  Serial.begin(115200);
  printMsg("wumei smart device starting...");
  // 加载配置
  loadConfig();
  // 初始化用户配置
  initUser();

  if (strcmp(wifiSsid, "") == 0)
  {
    // 启动配网
    startApConfig();
  }
  else
  {
    // 连接Wifi
    connectWifi();
  }
}

/**
 * 循环执行
 */
void loop()
{
  // 监测按钮
  button.tick();

  if (isApMode)
  {
    // 配网时的Web服务
    server.handleClient();
  }
  else
  {
    // Wifi重连
    wifiReconnectionClient();
    // Mqtt连接
    mqttReconnectionClient();
    // 发布实时监测数据
    publicMonitorClient();
    // 发布模拟数据，测试用
    publishSimulateDataClient();
  }
}

/*
 *  Wifi掉线重连(非阻塞，间隔5s)
 */
void wifiReconnectionClient()
{
  long now = millis();
  if (WiFi.status() != WL_CONNECTED)
  {
    if (now - lastWifiConn > 5000)
    {
      lastWifiConn = now;
      WiFi.reconnect();
    }
  }
}

/*
 *  mqtt连接(非阻塞、间隔5s)
 */
void mqttReconnectionClient()
{
  if (WiFi.status() == WL_CONNECTED)
  {
    long now = millis();
    if (!mqttClient.connected())
    {
      if (now - lastMqttConn > 5000)
      {
        lastMqttConn = now;
        connectMqtt();
      }
    }
    else
    {
      mqttClient.loop();
    }
  }
}

/*
 *  发布实时监测数据（非阻塞、间隔默认1秒）
 */
void publicMonitorClient()
{
  if (WiFi.status() == WL_CONNECTED && monitorCount > 0)
  {
    long now = millis();
    if (now - lastPublishMonitor > monitorInterval)
    {
      lastPublishMonitor = now;
      monitorCount--;
      String msg = randomPropertyData();
      publishMonitor(msg);
    }
  }
}

/*
 *  发布模拟数据（非阻塞、仅用于测试，间隔60秒）
 */
void publishSimulateDataClient()
{
  if (WiFi.status() == WL_CONNECTED)
  {
    long now = millis();
    if (now - lastPublishSimulateData > 60000)
    {
      lastPublishSimulateData = now;
      printMsg("执行定时上报");
      // 发布事件
      processEvent();
      // 发布时钟同步
      publishNtp();

      // 发布属性(监测值)
      String msg = randomPropertyData();
      publishProperty(msg);
    }
  }
}
