/*********************************************************************
 * function： 设备交互
 * board:     esp8266,esp32,esp32s2,esp32s3 core for esp-idf v4.4.7
 * source:    https://gitee.com/zhuangpengli/IOTDeviceSDK
 * copyright: zhuangpeng.li all rights reserved.
 ********************************************************************/
#include "Mqtt.h"
#include "Config.h"
#include "cJSON.h"
#include "esp_log.h"
#include "dm_wrapper.h"

char *sInfoTopic = "/info/get";
char *sOtaTopic = "/ota/get";
char *sNtpTopic = "/ntp/get";
char *sPropertyTopic = "/property/get";
char *sFunctionTopic = "/function/get";
char *sPropertyOnline = "/property-online/get";
char *sFunctionOnline = "/function-online/get";
char *sMonitorTopic = "/monitor/get";
// Mqtt发布的主题
char *pInfoTopic = "/info/post";
char *pNtpTopic = "/ntp/post";
char *pPropertyTopic = "/property/post";
char *pFunctionTopic = "/function/post";
char *pMonitorTopic = "/monitor/post";
char *pEventTopic = "/event/post";

static const char *TAG = "FASTBEE_MQTT";
// 订阅系统主题
void subscribeTopic(esp_mqtt_client_handle_t client) {
    char topic[128] = {0};
    int msg_id;
    HAL_Snprintf(topic, sizeof(topic), "%s%s", g_mqtt_prefix, sInfoTopic);
    msg_id = esp_mqtt_client_subscribe(client, topic, 0);
    ESP_LOGI(TAG, "sent subscribe successful, msg_id=%d", msg_id);

    memset(topic, 0, sizeof(topic));
    HAL_Snprintf(topic, sizeof(topic), "%s%s", g_mqtt_prefix, sOtaTopic);
    msg_id = esp_mqtt_client_subscribe(client, topic, 0);
    ESP_LOGI(TAG, "sent subscribe successful, msg_id=%d", msg_id);

    memset(topic, 0, sizeof(topic));
    HAL_Snprintf(topic, sizeof(topic), "%s%s", g_mqtt_prefix, sNtpTopic);
    msg_id = esp_mqtt_client_subscribe(client, topic, 0);
    ESP_LOGI(TAG, "sent subscribe successful, msg_id=%d", msg_id);

    memset(topic, 0, sizeof(topic));
    HAL_Snprintf(topic, sizeof(topic), "%s%s", g_mqtt_prefix, sPropertyTopic);
    msg_id = esp_mqtt_client_subscribe(client, topic, 0);
    ESP_LOGI(TAG, "sent subscribe successful, msg_id=%d", msg_id);

    memset(topic, 0, sizeof(topic));
    HAL_Snprintf(topic, sizeof(topic), "%s%s", g_mqtt_prefix, sFunctionTopic);
    msg_id = esp_mqtt_client_subscribe(client, topic, 0);
    ESP_LOGI(TAG, "sent subscribe successful, msg_id=%d", msg_id);

    memset(topic, 0, sizeof(topic));
    HAL_Snprintf(topic, sizeof(topic), "%s%s", g_mqtt_prefix, sPropertyOnline);
    msg_id = esp_mqtt_client_subscribe(client, topic, 0);
    ESP_LOGI(TAG, "sent subscribe successful, msg_id=%d", msg_id);

    memset(topic, 0, sizeof(topic));
    HAL_Snprintf(topic, sizeof(topic), "%s%s", g_mqtt_prefix, sFunctionOnline);
    msg_id = esp_mqtt_client_subscribe(client, topic, 0);
    ESP_LOGI(TAG, "sent subscribe successful, msg_id=%d", msg_id);

    memset(topic, 0, sizeof(topic));
    HAL_Snprintf(topic, sizeof(topic), "%s%s", g_mqtt_prefix, sMonitorTopic);
    msg_id = esp_mqtt_client_subscribe(client, topic, 0);
    ESP_LOGI(TAG, "sent subscribe successful, msg_id=%d", msg_id);
}

// 1.发布设备信息
void publishInfo(esp_mqtt_client_handle_t client) {
    char topic[128] = {0};
    int msg_id;
    cJSON *json = cJSON_CreateObject();
    HAL_Snprintf(topic, sizeof(topic), "%s%s", g_mqtt_prefix, pInfoTopic);
    // 向JSON对象中添加数据
    cJSON_AddNumberToObject(json, "rssi", 3);
    cJSON_AddNumberToObject(json, "firmwareVersion", firmwareVersion);
    cJSON_AddNumberToObject(json, "status", 3);
    cJSON_AddStringToObject(json, "userId", g_userId);
    cJSON_AddNumberToObject(json, "longitude", longitude);
    cJSON_AddNumberToObject(json, "latitude", latitude);

    cJSON *summary = cJSON_CreateObject();
    cJSON_AddStringToObject(summary, "name", "fastbee");
    cJSON_AddStringToObject(summary, "chip", "esp32");
    cJSON_AddStringToObject(summary, "author", "zhuangpeng.li");
    cJSON_AddNumberToObject(summary, "version", 1.6);
    cJSON_AddStringToObject(summary, "create", "2024-07-07");

    cJSON_AddItemToObject(json, "summary", summary);
    char *json_string = cJSON_Print(json);
    msg_id = esp_mqtt_client_publish(client, topic, json_string, 0, 0, 0);
    ESP_LOGI(TAG, "sent publish %s, msg_id= %d, msg: %s", topic, msg_id, json_string);

    cJSON_Delete(json);
    free(json_string);
}

// 2.发布时钟同步信，用于获取当前时间(可选)
void publishNtp(esp_mqtt_client_handle_t client) {
    char topic[128] = {0};
    int msg_id;
    cJSON *json = cJSON_CreateObject();
    HAL_Snprintf(topic, sizeof(topic), "%s%s", g_mqtt_prefix, pNtpTopic);
    cJSON_AddStringToObject(json, "deviceSendTime", "test");
    char *json_string = cJSON_Print(json);
    msg_id = esp_mqtt_client_publish(client, topic, json_string, 0, 0, 0);
    ESP_LOGI(TAG, "sent publish %s, msg_id= %d, msg: %s", topic, msg_id, json_string);

    cJSON_Delete(json);
    free(json_string);
}

// 3.发布属性
void publishProperty(esp_mqtt_client_handle_t client, const char *msg) {
    char topic[128] = {0};
    int msg_id;
    HAL_Snprintf(topic, sizeof(topic), "%s%s", g_mqtt_prefix, pPropertyTopic);
    msg_id = esp_mqtt_client_publish(client, topic, msg, 0, 0, 0);
    ESP_LOGI(TAG, "发布属性主题: %s", topic);
    ESP_LOGI(TAG, "消息id= %d, 消息: %s", msg_id, msg);
}

// 4.发布功能
void publishFunction(esp_mqtt_client_handle_t client, const char *msg) {
    char topic[128] = {0};
    int msg_id;
    HAL_Snprintf(topic, sizeof(topic), "%s%s", g_mqtt_prefix, pFunctionTopic);
    msg_id = esp_mqtt_client_publish(client, topic, msg, 0, 0, 0);
    ESP_LOGI(TAG, "发布功能主题: %s", topic);
    ESP_LOGI(TAG, "消息id= %d, 消息: %s", msg_id, msg);
}

// 5.发布事件
void publishEvent(esp_mqtt_client_handle_t client, const char *msg) {
    char topic[128] = {0};
    int msg_id;
    HAL_Snprintf(topic, sizeof(topic), "%s%s", g_mqtt_prefix, pEventTopic);
    msg_id = esp_mqtt_client_publish(client, topic, msg, 0, 0, 0);
    ESP_LOGI(TAG, "发布事件主题: %s", topic);
    ESP_LOGI(TAG, "消息id= %d, 消息: %s", msg_id, msg);
}

// 6.发布实时监测数据
void publishMonitor(esp_mqtt_client_handle_t client, const char *msg) {
    char topic[128] = {0};
    int msg_id;
    HAL_Snprintf(topic, sizeof(topic), "%s%s", g_mqtt_prefix, pMonitorTopic);
    // 发布实时监测数据（不会存储，需要实时存储则发布为属性）
    msg_id = esp_mqtt_client_publish(client, topic, msg, 0, 0, 0);
    ESP_LOGI(TAG, "发布实时监测主题: %s", topic);
    ESP_LOGI(TAG, "消息id= %d, 消息: %s", msg_id, msg);
}
