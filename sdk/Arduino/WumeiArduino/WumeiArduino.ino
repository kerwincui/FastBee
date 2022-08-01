/*********************************************************************
 * function： 程序入口
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: wumei-smart and kerwincui all rights reserved.
 ********************************************************************/

#include "Common.h"
#include "Auth.h"
#include "Apconfig.h"

long lastMqttConn;            // 上次mqtt连接时间
long lastPublishMonitor;      // 上次发布监测数据时间
long lastPublishSimulateData; // 上次发布测试数据时间

/**
 * 启动
 */
void setup()
{
  // 初始化配置
  initWumeiSmart();

  if(strcmp(wifiSsid, "") == 0){
    // 启动配网
    startApConfig();
  }else{
    // 连接Wifi
    connectWifi();
    // 连接Mqtt(加密认证)
    connectMqtt();
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

    // Mqtt重连
    mqttReconnectionClient();

    // 发布实时监测数据
    publicMonitorClient();

    // 发布模拟数据，测试用
    publishSimulateDataClient();
  }
}

/*
 *  Wifi掉线重连
 */
void wifiReconnectionClient()
{
  if (WiFi.status() != WL_CONNECTED)
  {
    connectWifi();
  }
}

/*
 *  mqtt掉线重连(非阻塞、间隔30s)
 */
void mqttReconnectionClient()
{
  if (WiFi.status() == WL_CONNECTED)
  {
    long now = millis();
    if (!mqttClient.connected())
    {
      if (now - lastMqttConn > 30000)
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
      publishMonitor();
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
      publishEvent();
      // 发布时钟同步
      publishNtp();

      // 发布属性(监测值)
      String msg = randomPropertyData();
      publishProperty(msg);
    }
  }
}
