/*********************************************************************
 * function： 设备配置和系统功能
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: FastBee and kerwincui all rights reserved.
 ********************************************************************/

#include "Config.h"
#define LED 15  // LED指示灯引脚

WiFiClient wifiClient;
PubSubClient mqttClient;

float rssi = 0;
char wumei_iv[17] = "wumei-smart-open";
int monitorCount = 0;
long monitorInterval = 1000;
bool isApMode = false;

// Mqtt订阅的主题，前缀格式为： /productId/devicenumber
String prefix = "";
String sInfoTopic = "/info/get";
String sOtaTopic = "/ota/get";
String sNtpTopic = "/ntp/get";
String sPropertyTopic = "/property/get";
String sFunctionTopic = "/function/get";
String sPropertyOnline = "/property-online/get";
String sFunctionOnline = "/function-online/get";
String sMonitorTopic = "/monitor/get";
// Mqtt发布的主题
String pInfoTopic = "/info/post";
String pNtpTopic = "/ntp/post";
String pPropertyTopic = "/property/post";
String pFunctionTopic = "/function/post";
String pMonitorTopic = "/monitor/post";
String pEventTopic = "/event/post";

/********************************** begin 可配置的项 **********************************/
// wifi信息
char *wifiSsid = "";
char *wifiPwd = "";
char *userId = "1";
// 产品启用授权码，则授权码不能为空
char *authCode = "";

// 设备信息配置
char *deviceNum = "D1FJTWOT3HIB";
char *productId = "588";
float firmwareVersion = 1.0;
// 经度和纬度可选，如果产品使用设备定位，则必须传
float latitude = 0;
float longitude = 0;

// Mqtt配置
char *mqttHost = "fastbee.cn";
int mqttPort = 1883;
char *mqttUserName = "FastBee";
char *mqttPwd = "P63653937TRQ8F27";
char mqttSecret[17] = "KV52PPZ813EFCQD8";

// NTP地址（用于获取时间,修改为自己部署项目的接口地址）
String ntpServer = "http://fastbee.cn:8080/iot/tool/ntp?deviceSendTime=";

/********************************** end 可配置的项 **********************************/

// 连接wifi
void connectWifi() {
  if (isApMode) {
    // 关闭AP配网模式，延迟2秒确保返回状态码给手机
    isApMode = false;
    delay(2000);
    server.stop();
    ledStatus(false);
  }
  printMsg("连接Wifi： ");
  Serial.print(wifiSsid);
  WiFi.mode(WIFI_STA);
  WiFi.begin(wifiSsid, wifiPwd);
}

// 存储配置
void saveConfig(config_type config) {
  // 标识为已经存储数据
  config.flag = 1;
  EEPROM.begin(240);
  printMsg("存储配置...");
  uint8_t *p = (uint8_t *)(&config);
  for (int i = 0; i < sizeof(config); i++) {
    EEPROM.write(i, *(p + i));
  }
  EEPROM.end();
}

// 加载配置
void loadConfig() {
  config_type config;
  EEPROM.begin(240);
  printMsg("加载配置...");
  uint8_t *p = (uint8_t *)(&config);
  for (int i = 0; i < sizeof(config); i++) {
    *(p + i) = EEPROM.read(i);
  }
  if (config.flag != 1) {
    printMsg("flash暂无数据");
    return;
  }
  // wifi名称
  if (strlen(config.stassid) != 0) {
    wifiSsid = (char *)malloc(32 * sizeof(char));
    strcpy(wifiSsid, config.stassid);
  }
  // wifi密码
  if (strlen(config.stapsw) != 0) {
    wifiPwd = (char *)malloc(64 * sizeof(char));
    strcpy(wifiPwd, config.stapsw);
  }
  // 设备编号
  if (strlen(config.deviceNum) != 0) {
    deviceNum = (char *)malloc(32 * sizeof(char));
    strcpy(deviceNum, config.deviceNum);
  }
  // 用户编号
  if (strlen(config.userId) != 0) {
    userId = (char *)malloc(16 * sizeof(char));
    strcpy(userId, config.userId);
  }
  // 授权码
  if (strlen(config.authCode) != 0) {
    authCode = (char *)malloc(32 * sizeof(char));
    strcpy(authCode, config.authCode);
  }
  // 统一设置Mqtt消息主题前缀
  prefix = "/" + (String)productId + "/" + (String)deviceNum;
}

// 清空配置
void clearConfig() {
  EEPROM.begin(240);
  for (int i = 0; i < 240; i++) {
    EEPROM.write(i, 0);
  }
  EEPROM.end();
}

//打印提示信息
void printMsg(String msg) {
  Serial.print("\r\n[");
  Serial.print(millis());
  Serial.print("ms]");
  Serial.print(msg);
}

// 控制指示灯闪烁
void blink() {
  printMsg("指示灯闪烁...");
  pinMode(LED, OUTPUT);
  for (int i = 0; i < 2; i++) {
    digitalWrite(LED, HIGH);
    delay(100);
    digitalWrite(LED, LOW);
    delay(100);
  }
}

// 控制指示灯状态
void ledStatus(bool status) {
  printMsg("更改指示灯状态");
  pinMode(LED, OUTPUT);
  if (status) {
    digitalWrite(LED, HIGH);
  } else {
    digitalWrite(LED, LOW);
  }
}
