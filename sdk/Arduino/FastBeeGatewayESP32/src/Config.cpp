/*********************************************************************
 * function： 设备配置和系统功能
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: FastBee and kerwincui all rights reserved.
 ********************************************************************/

#include "Config.h"
#define LED 2             // LED指示灯引脚

WiFiClient wifiClient;
PubSubClient mqttClient;

float rssi = 0;
char wumei_iv[17] = "wumei-smart-open";                 //不能改    
int monitorCount = 0;
long monitorInterval = 1000;
bool isApMode = false;

// Mqtt订阅subscribe的主题，前缀格式为： /productId/devicenumber
String prefix = "/153/D1J5VX6P04L1";                   //这里需要自己加，2023-5-4

String sInfoTopic = "/info/get";
String sOtaTopic = "/ota/get";
String sNtpTopic = "/ntp/get";
String sPropertyTopic = "/property/get";
String sFunctionTopic = "/function/get";                //测试ok
String sPropertyOnline = "/property-online/get";
String sFunctionOnline = "/function-online/get";
String sMonitorTopic = "/monitor/get";

// Mqtt发布publish的主题
String pInfoTopic = "/info/post";                       //测试OK
String pNtpTopic = "/ntp/post";                         //测试ok
String pPropertyTopic = "/property/post";               //测试ok
String pFunctionTopic = "/function/post";
String pMonitorTopic = "/monitor/post";                 //测试ok
String pEventTopic = "/event/post";                     //测试ok

/********************************** begin 可配置的项 **********************************/
// wifi信息
// char *wifiSsid = "seetic";
// char *wifiPwd = "seetic@6698";

char *wifiSsid = "Tenda88";
char *wifiPwd = "hfh2002340336";


char *userId = "1";                               //用户编号ID，可通过查看平台中“用户管理”查看用户编号，这里使用的是admin的ID。

// 产品配置
char *mqttHost = "47.108.226.28";                 //为我们自己平台
int mqttPort = 1883;                              //需要阿里云开安全策略，centos中开防火墙

// char *mqttHost = "43.143.82.218";              //wumei.live 平台的参数
// int mqttPort = 1883;
// char *mqttUserName = "FastBee";
// char *mqttPwd = "P467433O1MT8MXS2";
// char mqttSecret[17] = "KWF32S3H95LH14LO";

char *authCode = "";                              //产品管理->基本信息，查看是否启动授权,产品启用授权码，则授权码不能为空
char *productId = "153";                          //点击菜单“产品管理”->“详情”->“产品编号”获取
char *mqttUserName = "myChargingSpot";            //产品管理->基本信息->mqtt账号
char *mqttPwd = "PPWFKRV28D06M50N";               //产品管理->基本信息->mqtt密码
char mqttSecret[17] = "K8J7726I58KRYA7B";         //产品管理->基本信息-产品秘钥

// 设备信息配置
// char *deviceNum = "D1PGLPG58KZ2";              //设备编号，这个是原来wumei.live平台的设备
char *deviceNum = "D1J5VX6P04L1";                 //点击设备管理->查看->基本信息-设备编号  中可以查看到
float firmwareVersion = 1.0;                      //设备内置的固件版本号

// 经度和纬度可选，如果产品使用设备定位，则必须传
float latitude = 0;
float longitude = 0;

// NTP地址（用于获取时间,修改为自己部署项目的接口地址）
//String ntpServer = "http://wumei.live:8080/iot/tool/ntp?deviceSendTime=";            //wumei.live平台的数据
String ntpServer = "http://47.108.226.28:8080/iot/tool/ntp?deviceSendTime=";            //为我们自己平台，ok
// 发送到fastBee平台获取时间值：http://wumei.live:8080/iot/tool/ntp?deviceSendTime=8501

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
