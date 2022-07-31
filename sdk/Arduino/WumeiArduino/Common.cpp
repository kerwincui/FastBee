/***********************************************************
 * function： 设备交互
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1
 * source:    https://github.com/kerwincui/wumei-smart
 ***********************************************************/

#include "Common.h"

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

// NTP地址（用于获取时间,修改为自己部署项目的接口地址）
String ntpServer = "http://wumei.live:8080/iot/tool/ntp?deviceSendTime=";


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
  int led=15;
  pinMode(led, OUTPUT);
  for (int i = 0; i < 2; i++)
  {
    digitalWrite(led, HIGH);
    delay(100);
    digitalWrite(led, LOW);
    delay(100);
  }
}
