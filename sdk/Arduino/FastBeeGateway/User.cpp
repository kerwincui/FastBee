/*********************************************************************
 * function： 用户自定义功能
 * board:     esp8266 core for arduino v3.0.2
 * library：  PubSubClient2.8.0  & ArduinoJson6.19.1 & OneButton2.0.4
 * source:    https://gitee.com/kerwincui/wumei-smart
 * copyright: FastBee and kerwincui all rights reserved.
 ********************************************************************/

#include "User.h"
#define BUTTON 14  // 按键引脚
#define RELAY 12   // 继电器引脚

OneButton button;
// 按钮单击事件
static void buttonClick();
// 按钮双击事件
static void buttonDoubleClick();
// 按钮长按事件
static void buttonLongPress();

// 初始化用户配置
void initUser() {
  // 初始化按键为低电平，并添加单击、双击、长按事件
  button = OneButton(BUTTON, true, true);
  button.attachClick(buttonClick);
  button.attachDoubleClick(buttonDoubleClick);
  button.attachLongPressStart(buttonLongPress);
}

// Mqtt回调
void mqttCallback(char *topic, byte *payload, unsigned int length) {
  blink();
  printMsg("接收数据：");
  String data = "";
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
    data += (char)payload[i];
  }

  if (strcmp(topic, (prefix + sOtaTopic).c_str()) == 0) {
    printMsg("订阅到设备升级指令...");
    StaticJsonDocument<256> doc;
    DeserializationError error = deserializeJson(doc, payload);
    if (error) {
      Serial.print(F("deserializeJson() failed: "));
      Serial.println(error.f_str());
      return;
    }
    String newVersion = doc["version"];
    String downloadUrl = doc["downloadUrl"];
    printMsg("固件版本：" + newVersion);
    printMsg("下载地址：" + downloadUrl);
  } else if (strcmp(topic, (prefix + sInfoTopic).c_str()) == 0) {
    printMsg("订阅到设备信息...");
    // 发布设备信息
    publishInfo();
  } else if (strcmp(topic, (prefix + sNtpTopic).c_str()) == 0) {
    printMsg("订阅到NTP时间...");
    StaticJsonDocument<256> doc;
    DeserializationError error = deserializeJson(doc, payload);
    if (error) {
      Serial.print(F("deserializeJson() failed: "));
      Serial.println(error.f_str());
      return;
    }
    // 计算设备当前时间：(${serverRecvTime} + ${serverSendTime} + ${deviceRecvTime} - ${deviceSendTime}) / 2
    float deviceSendTime = doc["deviceSendTime"];
    float serverSendTime = doc["serverSendTime"];
    float serverRecvTime = doc["serverRecvTime"];
    float deviceRecvTime = millis();
    float now = (serverSendTime + serverRecvTime + deviceRecvTime - deviceSendTime) / 2;
    printMsg("当前时间：" + String(now, 0));
  } else if (strcmp(topic, (prefix + sPropertyTopic).c_str()) == 0 || strcmp(topic, (prefix + sPropertyOnline).c_str()) == 0) {
    printMsg("订阅到属性指令...");
    processProperty(data);
  } else if (strcmp(topic, (prefix + sFunctionTopic).c_str()) == 0 || strcmp(topic, (prefix + sFunctionOnline).c_str()) == 0) {
    printMsg("订阅到功能指令...");
    processFunction(data);
  } else if (strcmp(topic, (prefix + sMonitorTopic).c_str()) == 0) {
    printMsg("订阅到实时监测指令...");
    StaticJsonDocument<128> doc;
    DeserializationError error = deserializeJson(doc, payload);
    if (error) {
      Serial.print(F("deserializeJson() failed: "));
      Serial.println(error.f_str());
      return;
    }
    monitorCount = doc["count"];
    monitorInterval = doc["interval"];
  }
}

// 随机生成属性值
String randomPropertyData() {
  // 匹配云端定义的数据，随机数代替传感器值
  float randFloat = 0;
  int randInt = 0;
  StaticJsonDocument<1024> doc;
  JsonObject objTmeperature = doc.createNestedObject();
  objTmeperature["id"] = "temperature";
  randFloat = random(1000, 3000);
  objTmeperature["value"] = (String)(randFloat / 100);
  objTmeperature["remark"] = (String)millis();

  JsonObject objBrightness = doc.createNestedObject();
  objBrightness["id"] = "brightness";
  randInt = random(1000, 10000);
  objBrightness["value"] = (String)(randInt);
  objBrightness["remark"] = (String)millis();

  JsonObject category_light = doc.createNestedObject();
  category_light["id"] = "category_light";
  randInt = random(0, 100);
  category_light["value"] = (String)(randInt);
  category_light["remark"] = (String)millis();

  JsonObject category_humidity = doc.createNestedObject();
  category_humidity["id"] = "category_humidity";
  randInt = random(0, 100);
  category_humidity["value"] = (String)(randInt);
  category_humidity["remark"] = (String)millis();

  JsonObject category_temperature = doc.createNestedObject();
  category_temperature["id"] = "category_temperature";
  randInt = random(0, 100);
  category_temperature["value"] = (String)(randInt);
  category_temperature["remark"] = (String)millis();

  // 子设备数据,使用前缀array_00标识
  JsonObject array_00_device_co2 = doc.createNestedObject();
  array_00_device_co2["id"] = "array_00_device_co2";
  randInt = random(100, 6000);
  array_00_device_co2["value"] = (String)(randInt);
  array_00_device_co2["remark"] = (String)millis();
  JsonObject array_00_device_temperature = doc.createNestedObject();
  array_00_device_temperature["id"] = "array_00_device_temperature";
  randInt = random(0, 100);
  array_00_device_temperature["value"] = (String)(randInt);
  array_00_device_temperature["remark"] = (String)millis();

  JsonObject array_01_device_co2 = doc.createNestedObject();
  array_01_device_co2["id"] = "array_01_device_co2";
  randInt = random(100, 6000);
  array_01_device_co2["value"] = (String)(randInt);
  array_01_device_co2["remark"] = (String)millis();
  JsonObject array_01_device_temperature = doc.createNestedObject();
  array_01_device_temperature["id"] = "array_01_device_temperature";
  randInt = random(0, 100);
  array_01_device_temperature["value"] = (String)(randInt);
  array_01_device_temperature["remark"] = (String)millis();

  JsonObject array_02_device_co2 = doc.createNestedObject();
  array_02_device_co2["id"] = "array_02_device_co2";
  randInt = random(100, 6000);
  array_02_device_co2["value"] = (String)(randInt);
  array_02_device_co2["remark"] = (String)millis();
  JsonObject array_02_device_temperature = doc.createNestedObject();
  array_02_device_temperature["id"] = "array_02_device_temperature";
  randInt = random(0, 100);
  array_02_device_temperature["value"] = (String)(randInt);
  array_02_device_temperature["remark"] = (String)millis();

  JsonObject array_03_device_co2 = doc.createNestedObject();
  array_03_device_co2["id"] = "array_03_device_co2";
  randInt = random(100, 6000);
  array_03_device_co2["value"] = (String)(randInt);
  array_03_device_co2["remark"] = (String)millis();
  JsonObject array_03_device_temperature = doc.createNestedObject();
  array_03_device_temperature["id"] = "array_03_device_temperature";
  randInt = random(0, 100);
  array_03_device_temperature["value"] = (String)(randInt);
  array_03_device_temperature["remark"] = (String)millis();

  JsonObject array_04_device_co2 = doc.createNestedObject();
  array_04_device_co2["id"] = "array_04_device_co2";
  randInt = random(100, 6000);
  array_04_device_co2["value"] = (String)(randInt);
  array_04_device_co2["remark"] = (String)millis();
  JsonObject array_04_device_temperature = doc.createNestedObject();
  array_04_device_temperature["id"] = "array_04_device_temperature";
  randInt = random(0, 100);
  array_04_device_temperature["value"] = (String)(randInt);
  array_04_device_temperature["remark"] = (String)millis();

  printMsg("模拟监测数据值:");
  serializeJson(doc, Serial);
  String output;
  serializeJson(doc, output);
  return output;
}

// 随机生成实时监测值
String randomMonitorData() {
  // 匹配云端定义的监测数据，随机数代替监测值
  float randFloat = 0;
  int randInt = 0;
  StaticJsonDocument<1024> doc;
  JsonObject objTmeperature = doc.createNestedObject();
  objTmeperature["id"] = "temperature";
  randFloat = random(1000, 3000);
  objTmeperature["value"] = (String)(randFloat / 100);
  objTmeperature["remark"] = (String)millis();

  JsonObject objBrightness = doc.createNestedObject();
  objBrightness["id"] = "brightness";
  randInt = random(1000, 10000);
  objBrightness["value"] = (String)(randInt);
  objBrightness["remark"] = (String)millis();

  JsonObject category_light = doc.createNestedObject();
  category_light["id"] = "category_light";
  randInt = random(0, 100);
  category_light["value"] = (String)(randInt);
  category_light["remark"] = (String)millis();

  JsonObject category_humidity = doc.createNestedObject();
  category_humidity["id"] = "category_humidity";
  randInt = random(0, 100);
  category_humidity["value"] = (String)(randInt);
  category_humidity["remark"] = (String)millis();

  // 子设备数据,使用前缀array_00标识
  JsonObject array_00_device_co2 = doc.createNestedObject();
  array_00_device_co2["id"] = "array_00_device_co2";
  randInt = random(100, 6000);
  array_00_device_co2["value"] = (String)(randInt);
  array_00_device_co2["remark"] = (String)millis();

  JsonObject array_01_device_co2 = doc.createNestedObject();
  array_01_device_co2["id"] = "array_01_device_co2";
  randInt = random(100, 6000);
  array_01_device_co2["value"] = (String)(randInt);
  array_01_device_co2["remark"] = (String)millis();

  JsonObject array_02_device_co2 = doc.createNestedObject();
  array_02_device_co2["id"] = "array_02_device_co2";
  randInt = random(100, 6000);
  array_02_device_co2["value"] = (String)(randInt);
  array_02_device_co2["remark"] = (String)millis();

  JsonObject array_03_device_co2 = doc.createNestedObject();
  array_03_device_co2["id"] = "array_03_device_co2";
  randInt = random(100, 6000);
  array_03_device_co2["value"] = (String)(randInt);
  array_03_device_co2["remark"] = (String)millis();

  JsonObject array_04_device_co2 = doc.createNestedObject();
  array_04_device_co2["id"] = "array_04_device_co2";
  randInt = random(100, 6000);
  array_04_device_co2["value"] = (String)(randInt);
  array_04_device_co2["remark"] = (String)millis();

  printMsg("模拟监测数据值:");
  serializeJson(doc, Serial);
  String output;
  serializeJson(doc, output);
  return output;
}

// 物模型-属性处理
void processProperty(String msg) {
  StaticJsonDocument<1024> doc;
  DeserializationError error = deserializeJson(doc, msg);
  if (error) {
    Serial.print(F("deserializeJson() failed: "));
    Serial.println(error.f_str());
    return;
  }
  for (JsonObject object : doc.as<JsonArray>()) {
    // 匹配云端定义的属性（不包含属性中的监测数据）
    const char *id = object["id"];
    const char *value = object["value"];
    printMsg((String)id + "：" + (String)value);
    // 处理子设备的数据上报
    processSubDeviceReport(id, value);
  }
  // 最后发布属性，服务端订阅存储（重要）
  publishProperty(msg);
}

// 处理子设备和功能分组数据上报
void processSubDeviceReport(const char *id, const char *value) {
  int number = atoi(value);
  number = number > 10 ? 10 : number;
  int randInt = 0;
  for (int i = 0; i < number; i++) {
    StaticJsonDocument<1024> doc;
    if (strcmp(id, "array_00_device_report_monitor") == 0) {
      JsonObject array_00_device_co2 = doc.createNestedObject();
      array_00_device_co2["id"] = "array_00_device_co2";
      randInt = random(100, 6000);
      array_00_device_co2["value"] = (String)(randInt);
      array_00_device_co2["remark"] = (String)millis();
      
      JsonObject array_00_device_temperature = doc.createNestedObject();
      array_00_device_temperature["id"] = "array_00_device_temperature";
      randInt = random(0, 100);
      array_00_device_temperature["value"] = (String)(randInt);
      array_00_device_temperature["remark"] = (String)millis();
      serializeJson(doc, Serial);
      String output;
      serializeJson(doc, output);
      publishProperty(output);
      delay(1000);
    } else if (strcmp(id, "array_01_device_report_monitor") == 0) {
      JsonObject array_01_device_co2 = doc.createNestedObject();
      array_01_device_co2["id"] = "array_01_device_co2";
      randInt = random(100, 6000);
      array_01_device_co2["value"] = (String)(randInt);
      array_01_device_co2["remark"] = (String)millis();

      JsonObject array_01_device_temperature = doc.createNestedObject();
      array_01_device_temperature["id"] = "array_01_device_temperature";
      randInt = random(0, 100);
      array_01_device_temperature["value"] = (String)(randInt);
      array_01_device_temperature["remark"] = (String)millis();
      serializeJson(doc, Serial);
      String output;
      serializeJson(doc, output);
      publishProperty(output);
      delay(1000);
    } else if (strcmp(id, "array_02_device_report_monitor") == 0) {
      JsonObject array_02_device_co2 = doc.createNestedObject();
      array_02_device_co2["id"] = "array_02_device_co2";
      randInt = random(100, 6000);
      array_02_device_co2["value"] = (String)(randInt);
      array_02_device_co2["remark"] = (String)millis();

      JsonObject array_02_device_temperature = doc.createNestedObject();
      array_02_device_temperature["id"] = "array_02_device_temperature";
      randInt = random(0, 100);
      array_02_device_temperature["value"] = (String)(randInt);
      array_02_device_temperature["remark"] = (String)millis();
      serializeJson(doc, Serial);
      String output;
      serializeJson(doc, output);
      publishProperty(output);
      delay(1000);
    } else if (strcmp(id, "array_03_device_report_monitor") == 0) {
      JsonObject array_03_device_co2 = doc.createNestedObject();
      array_03_device_co2["id"] = "array_03_device_co2";
      randInt = random(100, 6000);
      array_03_device_co2["value"] = (String)(randInt);
      array_03_device_co2["remark"] = (String)millis();

      JsonObject array_03_device_temperature = doc.createNestedObject();
      array_03_device_temperature["id"] = "array_03_device_temperature";
      randInt = random(0, 100);
      array_03_device_temperature["value"] = (String)(randInt);
      array_03_device_temperature["remark"] = (String)millis();
      serializeJson(doc, Serial);
      String output;
      serializeJson(doc, output);
      publishProperty(output);
      delay(1000);
    } else if (strcmp(id, "array_04_device_report_monitor") == 0) {
      JsonObject array_04_device_co2 = doc.createNestedObject();
      array_04_device_co2["id"] = "array_04_device_co2";
      randInt = random(100, 6000);
      array_04_device_co2["value"] = (String)(randInt);
      array_04_device_co2["remark"] = (String)millis();

      JsonObject array_04_device_temperature = doc.createNestedObject();
      array_04_device_temperature["id"] = "array_04_device_temperature";
      randInt = random(0, 100);
      array_04_device_temperature["value"] = (String)(randInt);
      array_04_device_temperature["remark"] = (String)millis();
      serializeJson(doc, Serial);
      String output;
      serializeJson(doc, output);
      publishProperty(output);
      delay(1000);
    } else if (strcmp(id, "category_report_monitor") == 0) {
      JsonObject category_light = doc.createNestedObject();
      category_light["id"] = "category_light";
      randInt = random(0, 100);
      category_light["value"] = (String)(randInt);
      category_light["remark"] = (String)millis();

      JsonObject category_humidity = doc.createNestedObject();
      category_humidity["id"] = "category_humidity";
      randInt = random(0, 100);
      category_humidity["value"] = (String)(randInt);
      category_humidity["remark"] = (String)millis();

      JsonObject category_temperature = doc.createNestedObject();
      category_temperature["id"] = "category_temperature";
      randInt = random(0, 100);
      category_temperature["value"] = (String)(randInt);
      category_temperature["remark"] = (String)millis();
      serializeJson(doc, Serial);
      String output;
      serializeJson(doc, output);
      publishProperty(output);
      delay(1000);
    }
  }
}

// 物模型-功能处理
void processFunction(String msg) {
  StaticJsonDocument<1024> doc;
  DeserializationError error = deserializeJson(doc, msg);
  if (error) {
    Serial.print(F("deserializeJson() failed: "));
    Serial.println(error.f_str());
    return;
  }
  for (JsonObject object : doc.as<JsonArray>()) {
    // 匹配云端定义的功能
    const char *id = object["id"];
    const char *value = object["value"];
    if (strcmp(id, "switch") == 0) {
      printMsg("开关 switch：" + (String)value);
      if (strcmp(value, "1") == 0) {
        // 打开继电器
        relayStatus(true);
      } else if (strcmp(value, "0") == 0) {
        // 关闭继电器
        relayStatus(false);
      }
    } else if (strcmp(id, "gear") == 0) {
      printMsg("档位 gear：" + (String)value);
    } else if (strcmp(id, "light_color") == 0) {
      printMsg("灯光颜色 light_color：" + (String)value);
    } else if (strcmp(id, "message") == 0) {
      printMsg("屏显消息 message：" + (String)value);
    } else if (strcmp(id, "report_monitor") == 0) {
      int number = atoi(value);
      number > 10 ? number = 10 : number;
      for (int i = 0; i < number; i++) {
        Serial.println(number);
        String msg = randomPropertyData();
        printMsg("订阅到上报监测数据指令，上报数据：");
        printMsg(msg);
        publishProperty(msg);
        delay(1000);
      }
    }
  }
  // 最后发布功能,服务端订阅存储（重要）
  publishFunction(msg);
}

// 物模型-事件上传
void processEvent() {
  // 匹配云端的事件
  StaticJsonDocument<512> doc;
  JsonObject objTmeperature = doc.createNestedObject();
  objTmeperature["id"] = "height_temperature";
  objTmeperature["value"] = "40";
  objTmeperature["remark"] = "温度过高警告";

  JsonObject objException = doc.createNestedObject();
  objException["id"] = "exception";
  objException["value"] = "异常消息，消息内容XXXXXXXX";
  objException["remark"] = "设备发生错误";

  printMsg("发布事件:");
  serializeJson(doc, Serial);
  String output;
  serializeJson(doc, output);

  // 最后发布功能,服务端订阅存储（重要）
  publishEvent(output);
}

//打开继电器A
void relayStatus(bool status) {
  pinMode(RELAY, OUTPUT);
  if (status) {
    digitalWrite(RELAY, HIGH);
  } else {
    digitalWrite(RELAY, LOW);
  }
}

// 按钮单击事件
static void buttonClick() {
  printMsg("检测到按键单击，打开继电器");
  relayStatus(true);
  // 匹配云端定义的开关，格式如：[{"id":"switch","value":"1"}]
  String msg = "[{\"id\":\"switch\",\"value\":\"1\"}]";
  publishProperty(msg);
}

// 按钮双击事件
static void buttonDoubleClick() {
  printMsg("检测到按键双击，关闭继电器");
  relayStatus(false);
  // 匹配云端定义的开关，格式如：[{"id":"switch","value":"0"}]
  String msg = "[{\"id\":\"switch\",\"value\":\"0\"}]";
  publishProperty(msg);
}

// 按钮长按事件,进入配网模式
static void buttonLongPress() {
  printMsg("检测到按键长按");
  if (isApMode) {
    printMsg("设备重启...");
    ESP.restart();
  } else {
    printMsg("开始AP配网");
    startApConfig();
  }
}
