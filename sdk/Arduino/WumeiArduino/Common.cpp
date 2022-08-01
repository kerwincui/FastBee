/*********************************************************************
 * function： 程序入口
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: wumei-smart and kerwincui all rights reserved.
 ********************************************************************/

#include "Common.h"

WiFiClient wifiClient;
PubSubClient mqttClient;

// 存储的配置类型
struct config_type
{
  char stassid[32];   // SSID配置项
  char stapsw[64];    // Password配置项
  char deviceNum[64]; // 设备编号配置项
  char userId[32];    // 用户ID配置项
  char authCode[32];  // 授权码配置项
};
config_type config;

OneButton button;
// 按钮单击事件
static void buttonClick();
// 按钮双击事件
static void buttonDoubleClick() ;
// 按钮长按事件
static void buttonLongPress() ;

float rssi = 0;
char wumei_iv[17] = "wumei-smart-open";
int monitorCount = 0;
long monitorInterval = 1000;
bool isApMode = false;

//==================================== begin 可配置的项 ===============================

// Wifi配置
char *wifiSsid = "";
char *wifiPwd = "";

String userId = "1";
// 产品启用授权码，则授权码不能为空
String authCode = "";

// 设备信息配置
String deviceNum = "D6329VL5668888";
String productId = "41";
float firmwareVersion = 1.0;
// 经度和纬度可选，如果产品使用设备定位，则必须传
float latitude = 0;
float longitude = 0;

// Mqtt配置
char *mqttHost = "wumei.live";
int mqttPort = 1883;
char *mqttUserName = "wumei-smart";
char *mqttPwd = "PHYFED93WSFF1DAS";
char mqttSecret[17] = "K2V5DE28XNUU3497";

// NTP地址（用于获取时间,修改为自己部署项目的接口地址）
String ntpServer = "http://wumei.live:8080/iot/tool/ntp?deviceSendTime=";

//==================================== end 可配置的项 ===============================

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

// 初始化项目
void initWumeiSmart()
{
  //打开串行端口：
  Serial.begin(115200);
  printMsg("wumei smart device starting...");

  // 初始化按键为GND，并添加单击、双击、长按事件
  button = OneButton(14, true, true);
  button.attachClick(buttonClick);
  button.attachDoubleClick(buttonDoubleClick);
  button.attachLongPressStart(buttonLongPress);

  saveConfig();
  loadConfig();
}

// 按钮单击事件
static void buttonClick() {
  Serial.println("Clicked!");
}

// 按钮双击事件
static void buttonDoubleClick() {
  Serial.println("double Clicked!");
}

// 按钮长按事件
static void buttonLongPress() {
  Serial.println("long Clicked!");
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

// 存储配置
void saveConfig()
{
  EEPROM.begin(240);
  strcpy(config.stassid, "tp-six");                                                //名称复制
  strcpy(config.stapsw, "clh15108665817");                                         //密码复制
  strcpy(config.userId, "1000");                                                   //密码复制
  strcpy(config.authCode, "8kjfsfjjkjfjljdfldjfsdlfjsdlfjl8");                     //密码复制
  strcpy(config.deviceNum, "6qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq6"); //密码复制
  printMsg("存储配置...");
  uint8_t *p = (uint8_t *)(&config);
  for (int i = 0; i < sizeof(config); i++)
  {
    EEPROM.write(i, *(p + i));
  }
  EEPROM.end();
}

// 加载配置
void loadConfig()
{
  EEPROM.begin(240);
  printMsg("加载配置...");
  uint8_t *p = (uint8_t *)(&config);
  for (int i = 0; i < sizeof(config); i++)
  {
    *(p + i) = EEPROM.read(i);
  }
  EEPROM.commit();
  wifiSsid = config.stassid;
  wifiPwd = config.stapsw;
  printMsg("SSID: " + (String)config.stassid);
  printMsg("SSID: " + (String)config.authCode);
  printMsg("SSID: " + (String)config.deviceNum);
  printMsg("SSID: " + (String)config.userId);
  printMsg("Password: " + (String)wifiPwd);
}

// 清空配置
void clearConfig()
{
  EEPROM.begin(240);
  for (int i = 0; i < 240; i++)
  {
    EEPROM.write(i, 0);
  }
  EEPROM.end();
}

// 随机生成监测值
String randomPropertyData()
{
  // 匹配云端定义的监测数据，随机数代替监测结果
  float randFloat = 0;
  int randInt = 0;
  StaticJsonDocument<1024> doc;
  JsonObject objTmeperature = doc.createNestedObject();
  objTmeperature["id"] = "temperature";
  randFloat = random(1000, 3000);
  objTmeperature["value"] = (String)(randFloat / 100);
  objTmeperature["remark"] = (String)millis();

  JsonObject objHumidity = doc.createNestedObject();
  objHumidity["id"] = "humidity";
  randFloat = random(3000, 6000);
  objHumidity["value"] = (String)(randFloat / 100);
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
  int led = 15;
  pinMode(led, OUTPUT);
  for (int i = 0; i < 2; i++)
  {
    digitalWrite(led, HIGH);
    delay(100);
    digitalWrite(led, LOW);
    delay(100);
  }
}
