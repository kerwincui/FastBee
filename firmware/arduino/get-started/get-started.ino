/******************************************************************************
 * author: kerwincui
 * create: 2021-07-09
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
#include "EspMQTTClient.h"
#include <ArduinoJson.h>

char *deviceNum = "8CCGA1049ADA";  // 设备编号，唯一标识
char *ownerId="1";                 // 用户ID,后端查看，默认为amdin,ID为1
long categoryId=1;                 // 设备分类，后端查看，默认为wifi通断器，ID为1

EspMQTTClient client(
  "wifi-ssid",                     // WIFI的SSID
  "wifi-password",                 // WIFI的密码
  "192.168.0.100",                 // Mqtt消息服务器地址
  "admin",                         // Mqtt消息服务器账号
  "admin123",                      // Mqtt消息服务器密码
  deviceNum,                       // Mqtt客户端名称
  1883                             // Mqtt消息服务器端口
);

/**
 * 启动
 *
 */
void setup()
{
  Serial.begin(115200);
  client.enableDebuggingMessages();     // 打印调试信息
  client.setMaxPacketSize(1024);        // 设置Mqtt数据包最大值
  client.setKeepAlive(5);               // 保活时间间隔
  //遗嘱消息
  publishLastWill();  
}

/**
 * 循环执行
 * 
 */
void loop()
{
  client.loop();
}

/**
* WIFI和MQTT连接成功后执行的回调函数
*/
void onConnectionEstablished()
{
  // 订阅消息
  subscribeUpdateStatus();
  subscribeGetStatus();
  subscribeUpdateSetting();
  subscribeGetSetting();
  // 发布消息
  publishDeviceInfo();
}

/**
 * 1.更新设备状态
 * 
 */
void subscribeUpdateStatus(){
  client.subscribe("status/set/"+(String)deviceNum, [](const String & payload) {  
    StaticJsonDocument<1024> doc; //1024字节内存池容量
    //解析JSON
    DeserializationError error = deserializeJson(doc, payload);
    if (error) {
      Serial.print(F("deserializeJson() failed: "));
      Serial.println(error.f_str());
      return;
    }
  
    // 获取状态
    const char* deviceNum = doc["deviceNum"];  
    Serial.println("deviceNum:"+(String)deviceNum);
    
    int relayStatus = doc["relayStatus"];  
    Serial.print("relayStatus:");
    Serial.println(relayStatus);

    int lightStatus = doc["lightStatus"]; 
    Serial.print("lightStatus:"); 
    Serial.println(lightStatus);

    int brightness = doc["brightness"]; 
    Serial.print("brightness:"); 
    Serial.println(brightness);

    int lightInterval = doc["lightInterval"];
    Serial.print("lightInterval:");  
    Serial.println(lightInterval);

    int lightMode = doc["lightMode"]; 
    Serial.print("lightMode:"); 
    Serial.println(lightMode);

    int fadeTime = doc["fadeTime"];  
    Serial.print("fadeTime:");
    Serial.println(fadeTime);

    int red = doc["red"];  
    Serial.print("red:");
    Serial.println(red);

    int green = doc["green"];  
    Serial.print("green:");
    Serial.println(green);

    int blue = doc["blue"];  
    Serial.print("blue:");    
    Serial.println(blue); 

    // 最后发布设备状态
    publishStatus();
  });
}


/**
 * 2.获取设备状态
 * 
 */
void subscribeGetStatus(){
  client.subscribe("status/get/"+(String)deviceNum, [](const String & payload) {
    // 发布设备状态
    publishStatus();
  });
}

/**
 * 3.更新设备配置
 * 
 */
void subscribeUpdateSetting(){
  client.subscribe("setting/set/"+(String)deviceNum, [](const String & payload) {
    StaticJsonDocument<1024> doc; //1024字节内存池容量
    //解析JSON
    DeserializationError error = deserializeJson(doc, payload);
    if (error) {
      Serial.print(F("deserializeJson() failed: "));
      Serial.println(error.f_str());
      return;
    }
  
    // 获取配置
    const char* deviceNum = doc["deviceNum"];  
    Serial.println("deviceNum:"+(String)deviceNum);

    int isAlarm = doc["isAlarm"];  
    Serial.print("isAlarm:");  
    Serial.println(isAlarm);  

    int isRadar = doc["isRadar"];  
    Serial.print("isRadar:");  
    Serial.println(isRadar);  

    int isHost = doc["isHost"]; 
    Serial.print("isHost:"); 
    Serial.println(isHost);  

    int isRfControl = doc["isRfControl"];  
    Serial.print("isRfControl:"); 
    Serial.println(isRfControl);  

    int rfOneFunc = doc["rfOneFunc"];  
    Serial.print("rfOneFunc:");  
    Serial.println(rfOneFunc);  

    int rfTwoFunc = doc["rfTwoFunc"]; 
    Serial.print("rfTwoFunc:");  
    Serial.println(rfTwoFunc);  

    int rfThreeFunc = doc["rfThreeFunc"];
    Serial.print("rfThreeFunc:");    
    Serial.println(rfThreeFunc);  

    int rfFourFunc = doc["rfFourFunc"];  
    Serial.print("rfFourFunc:");  
    Serial.println(rfFourFunc); 

    int isReset = doc["isReset"];  
    Serial.print("isReset:");  
    Serial.println(isReset);  

    int isAp = doc["isAp"];
    Serial.print("isAp:");  
    Serial.println(isAp);  

    int isRfLearn = doc["isRfLearn"];  
    Serial.print("isRfLearn:");  
    Serial.println(isRfLearn);  

    int isRfClear = doc["isRfClear"];  
    Serial.print("isRfClear:");  
    Serial.println(isRfClear);  

    int isSmartConfig = doc["isSmartConfig"];
    Serial.print("isSmartConfig:");    
    Serial.println(isSmartConfig);  

    int radarInterval = doc["radarInterval"];  
    Serial.print("radarInterval:"); 
    Serial.println(radarInterval);  

    int isWifiOffline = doc["isWifiOffline"]; 
    Serial.print("isWifiOffline:");   
    Serial.println(isWifiOffline);  

    int isOpenCertifi = doc["isOpenCertifi"];  
    Serial.print("isOpenCertifi:");  
    Serial.println(isOpenCertifi); 

    // 最后发布设备配置
    publishSetting();
  });

}

/*
 * 4.获取设备配置
 *
 */
void subscribeGetSetting(){
  client.subscribe("setting/get/"+(String)deviceNum, [](const String & payload) {
    // 发布设备配置
    publishSetting();
  });
}


/**
 * 1.发布设备信息
 * 
 */
void publishDeviceInfo(){
  StaticJsonDocument<300> doc;
  doc["deviceNum"] = (String)deviceNum;
  doc["categoryId"] = categoryId;
  doc["firmwareVersion"] = "1.0";
  doc["ownerId"]= (String)ownerId;
  Serial.print("publish device info:");
  serializeJson(doc, Serial);
  //发布  
  String output;
  serializeJson(doc, output);
  const char *msg=output.c_str();
  client.publish("device_info",msg); 
}

/**
 * 2.发布设备状态
 * 
 */
void publishStatus(){
  StaticJsonDocument<1024> doc;
  doc["deviceNum"] = (String)deviceNum;
  doc["relayStatus"] = 1;
  doc["lightStatus"] = 1;
  doc["isOnline"] = 1;
  doc["rssi"] = -73;
  doc["deviceTemperature"] = 28.68;
  doc["airTemperature"] = 24.66;
  doc["airHumidity"] = 46.8;
  doc["triggerSource"] = 0;
  doc["brightness"] = 100;
  doc["lightInterval"] = 500;
  doc["lightMode"] = 0;
  doc["fadeTime"] = 259;
  doc["red"] = 255;
  doc["green"] = 255;
  doc["blue"] = 255; 
  Serial.print("publish status:");
  serializeJson(doc, Serial); 
  // 发布  
  String output;
  serializeJson(doc, output);
  const char *msg=output.c_str();
  client.publish("status",msg); 
}

/**
 * 3.发布设备配置
 * 
 */
void publishSetting(){
  StaticJsonDocument<1024> doc;
  doc["deviceNum"] = (String)deviceNum;
  doc["isAlarm"] = 0;
  doc["isRadar"] = 0;
  doc["isHost"] = 0;
  doc["isRfControl"]= 1,
  doc["rfOneFunc"] = 1;
  doc["rfTwoFunc"] = 2;
  doc["rfThreeFunc"] = 3;
  doc["rfFourFunc"] = 4;
  doc["ownerId"] = (String)ownerId;
  doc["isReset"] = 0;
  doc["isAp"] = 0;
  doc["isRfLearn"] = 0;
  doc["isRfClear"] = 0;
  doc["isSmartConfig"] = 0;
  doc["radarInterval"] = 5;
  doc["isWifiOffline"] = 0;
  doc["isOpenCertifi"] = 0;
  Serial.print("publish setting:");
  serializeJson(doc, Serial);
  //发布
  String output;
  serializeJson(doc, output);
  const char *msg=output.c_str();
  client.publish("setting",msg); 
}

/**
 * 4.遗嘱消息
 * 
 */
void publishLastWill(){
  StaticJsonDocument<100> doc;
  doc["deviceNum"] = (String)deviceNum;
  doc["isOnline"] = 0;
  Serial.print("\npublish last will:");
  serializeJson(doc, Serial);
  // 发布
  String output;
  serializeJson(doc, output);
  int len = output.length();
  char *msg =new char[len+1];
  strcpy(msg,output.c_str());
  client.enableLastWillMessage("offline",msg); 
}
