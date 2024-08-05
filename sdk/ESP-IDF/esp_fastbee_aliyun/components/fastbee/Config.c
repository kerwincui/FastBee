/*********************************************************************
 * function： 设备交互
 * board:     esp8266,esp32,esp32s2,esp32s3 core for esp-idf v4.4.7
 * source:    https://gitee.com/zhuangpengli/IOTDeviceSDK
 * copyright: zhuangpeng.li all rights reserved.
 ********************************************************************/
#include "Config.h"
#include "esp_err.h"
#include "esp_log.h"

#include "nvs_flash.h"
#include "nvs.h"
#include "dm_wrapper.h"

// 设备信息配置
char g_userId[USER_ID_LEN + 1] = {0};
char g_productId[PRODUCT_ID_LEN + 1] = {0};
char g_deviceSN[DEVICE_SN_LEN + 1] = {0};

// Mqtt配置
char g_mqtt_url[MQTT_URL_LEN + 1] = {0};
char g_mqtt_username[MQTT_USERNAME_LEN + 1] = {0};
char g_mqtt_password[MQTT_PASSWORD_LEN + 1] = {0};
char g_mqtt_clientid[MQTT_CLIENTID_LEN + 1] = {0};
char g_mqtt_prefix[MQTT_PREFIX_LEN + 1] = {0};

float rssi = 0;
char wumei_iv[17] = "wumei-smart-open";
int monitorCount = 0;
long monitorInterval = 1000;
bool isApMode = false;
/********************************** begin 可配置的项 **********************************/
// wifi信息
char *wifiSsid = "";
char *wifiPwd = "";
// 产品启用授权码，则授权码不能为空
char *authCode = "";
// 设备信息配置
float firmwareVersion = 1.0;
// 经度和纬度可选，如果产品使用设备定位，则必须传
float latitude = 0;
float longitude = 0;
// Mqtt配置
char mqttSecret[17] = "KV52PPZ813EFCQD8";
// NTP地址（用于获取时间,修改为自己部署项目的接口地址）
char *ntpServer = "http://fastbee.cn:8080/iot/tool/ntp?deviceSendTime=";
/********************************** end 可配置的项 **********************************/

static const char *TAG = "FASTBEE_CONFIG";
static bool s_part_init_flag;

static esp_err_t HAL_ProductParam_init(void)
{
    esp_err_t ret = ESP_OK;

    do {
        if (s_part_init_flag == false) {
            if ((ret = nvs_flash_init_partition(MFG_FASTBEE_PARTITION_NAME)) != ESP_OK) {
                ESP_LOGE(TAG, "NVS Flash init %s failed, Please check that you have flashed fctry partition!!!", MFG_FASTBEE_PARTITION_NAME);
                break;
            }

            s_part_init_flag = true;
        }
    } while (0);

    return ret;
}

static int HAL_GetProductParam(char *param_name, const char *param_name_str)
{
    esp_err_t ret;
    size_t read_len = 0;
    nvs_handle handle;

    do {
        if (HAL_ProductParam_init() != ESP_OK) {
            break;
        }

        if (param_name == NULL) {
            ESP_LOGE(TAG, "%s param %s NULL", __func__, param_name);
            break;
        }

        ret = nvs_open_from_partition(MFG_FASTBEE_PARTITION_NAME, NVS_FASTBEE_PRODUCT, NVS_READONLY, &handle);

        if (ret != ESP_OK) {
            ESP_LOGE(TAG, "%s nvs_open failed with %x", __func__, ret);
            break;
        }

        ret = nvs_get_str(handle, param_name_str, NULL, (size_t *)&read_len);

        if (ret != ESP_OK) {
            ESP_LOGE(TAG, "%s nvs_get_str get %s failed with %x", __func__, param_name_str, ret);
            break;
        }

        ret = nvs_get_str(handle, param_name_str, param_name, (size_t *)&read_len);

        if (ret != ESP_OK) {
            ESP_LOGE(TAG, "%s nvs_get_str get %s failed with %x", __func__, param_name_str, ret);
        } else {
            ESP_LOGV(TAG, "%s %s %s", __func__, param_name_str, param_name);
        }

        nvs_close(handle);
    } while (0);

    return read_len;
}

int HAL_GetMqttUrl(char mqtt_url[MQTT_URL_LEN + 1])
{
    return HAL_GetProductParam(mqtt_url, "MQTTUrl");
}
int HAL_GetMqttUsername(char mqtt_username[MQTT_USERNAME_LEN + 1])
{
    return HAL_GetProductParam(mqtt_username, "MQTTUsername");
}
int HAL_GetMqttPassword(char mqtt_password[MQTT_PASSWORD_LEN + 1])
{
    return HAL_GetProductParam(mqtt_password, "MQTTPassword");
}
int HAL_GetMqttClientId(char mqtt_clientid[MQTT_CLIENTID_LEN + 1])
{
    return HAL_GetProductParam(mqtt_clientid, "MQTTClientId");
}
int HAL_GetUserId(char userid[USER_ID_LEN + 1])
{
    return HAL_GetProductParam(userid, "UserId");
}
int HAL_GetDeviceSN(char deviceSN[DEVICE_SN_LEN + 1])
{
    return HAL_GetProductParam(deviceSN, "DeviceSN");
}
int HAL_GetProductId(char productId[PRODUCT_ID_LEN + 1])
{
    return HAL_GetProductParam(productId, "ProductId");
}

void loadConfig() {
    HAL_GetMqttUrl(g_mqtt_url);
    if (strlen(g_mqtt_url) == 0) {
        //加载默认配置
        memcpy(g_mqtt_url, CONFIG_ESP_MQTT_PLATFORM_FASTBEE_URL, strlen(CONFIG_ESP_MQTT_PLATFORM_FASTBEE_URL));
    }
    HAL_GetMqttUsername(g_mqtt_username);
    if (strlen(g_mqtt_username) == 0) {
        memcpy(g_mqtt_username, CONFIG_ESP_MQTT_PLATFORM_FASTBEE_USERNAME, strlen(CONFIG_ESP_MQTT_PLATFORM_FASTBEE_USERNAME));
    }
    HAL_GetMqttPassword(g_mqtt_password);
    if (strlen(g_mqtt_password) == 0) {
        memcpy(g_mqtt_password, CONFIG_ESP_MQTT_PLATFORM_FASTBEE_PASSWORD, strlen(CONFIG_ESP_MQTT_PLATFORM_FASTBEE_PASSWORD));
    }
    HAL_GetMqttClientId(g_mqtt_clientid);
    if (strlen(g_mqtt_clientid) == 0) {
        HAL_Snprintf(g_mqtt_clientid, sizeof(g_mqtt_clientid), "S&%s&%s&%s", CONFIG_ESP_MQTT_PLATFORM_FASTBEE_DEVICESN,CONFIG_ESP_MQTT_PLATFORM_FASTBEE_PRODICTID,CONFIG_ESP_MQTT_PLATFORM_FASTBEE_USERID);
    }
    HAL_GetUserId(g_userId);
    if (strlen(g_userId) == 0) {
        memcpy(g_userId, CONFIG_ESP_MQTT_PLATFORM_FASTBEE_USERID, strlen(CONFIG_ESP_MQTT_PLATFORM_FASTBEE_USERID));
    }
    HAL_GetDeviceSN(g_productId);
    if (strlen(g_productId) == 0) {
        memcpy(g_productId, CONFIG_ESP_MQTT_PLATFORM_FASTBEE_PRODICTID, strlen(CONFIG_ESP_MQTT_PLATFORM_FASTBEE_PRODICTID));
    }
    HAL_GetProductId(g_deviceSN);
    if (strlen(g_deviceSN) == 0) {
        memcpy(g_deviceSN, CONFIG_ESP_MQTT_PLATFORM_FASTBEE_DEVICESN, strlen(CONFIG_ESP_MQTT_PLATFORM_FASTBEE_DEVICESN));
    }
    HAL_Snprintf(g_mqtt_prefix, sizeof(g_mqtt_prefix), "/%s/%s", g_productId,g_deviceSN);
}