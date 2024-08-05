/*
 * ESPRESSIF MIT License
 *
 * Copyright (c) 2019 <ESPRESSIF SYSTEMS (SHANGHAI) PTE LTD>
 *
 * Permission is hereby granted for use on all ESPRESSIF SYSTEMS products, in which case,
 * it is free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the Software is furnished
 * to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 */

#include <stdlib.h>
#include <stdlib.h>
#include <ctype.h>
#include <unistd.h>
#include <limits.h>
#include <string.h>

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"

#include "esp_err.h"
#include "esp_event_loop.h"
#include "esp_log.h"
#include "esp_wifi.h"

#include "lwip/apps/sntp.h"

#include "wifi_provision_api.h"
#include "dm_wrapper.h"

#include "conn_mgr.h"

static const char *TAG = "conn_mgr";

static system_event_cb_t hal_wifi_system_cb;

static esp_err_t conn_mgr_wifi_connect(void)
{
    wifi_config_t wifi_config = {0};
    int ssid_len = sizeof(wifi_config.sta.ssid);
    int password_len = sizeof(wifi_config.sta.password);

    int ret = HAL_Kv_Get(STA_SSID_KEY, wifi_config.sta.ssid, &ssid_len);
    ESP_LOGI(TAG, "HAL_Kv_Get STA_SSID_KEY: %s ", wifi_config.sta.ssid);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to get stored SSID");
        return ESP_FAIL;
    }

    /* Even if the password is not found, it is not an error, as it could be an open network */
    ret = HAL_Kv_Get(STA_PASSWORD_KEY, wifi_config.sta.password, &password_len);
    ESP_LOGI(TAG, "HAL_Kv_Get STA_PASSWORD_KEY: %s ", wifi_config.sta.password);
    if (ret != ESP_OK) {
        ESP_LOGW(TAG, "Failed to get stored Password");
        password_len = 0;
    }

    esp_wifi_set_mode(WIFI_MODE_STA);
    esp_wifi_set_config(ESP_IF_WIFI_STA, &wifi_config);
    esp_wifi_start();
    esp_wifi_connect();

    return ESP_OK;
}

static esp_err_t conn_mgr_save_wifi_config(void)
{
    wifi_config_t wifi_config = {0};

    esp_wifi_get_config(ESP_IF_WIFI_STA, &wifi_config);

    /* Do not save hotspot or router APs. */
    if (strcmp((char *)(wifi_config.sta.ssid), HOTSPOT_AP) == 0 ||
        strcmp((char *)(wifi_config.sta.ssid), ROUTER_AP) == 0) {
        ESP_LOGI(TAG, "Do not save hotspot or router APs: %s", wifi_config.sta.ssid);
        return ESP_FAIL;
    }

    int ret = HAL_Kv_Set(STA_SSID_KEY, wifi_config.sta.ssid, sizeof(wifi_config.sta.ssid), 0);

    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "%s key store failed with %d", STA_SSID_KEY, ret);
        return ESP_FAIL;
    }

    /* Password may be NULL. Save, only if it is given */
    if (wifi_config.sta.password[0] != 0) {
        ret = HAL_Kv_Set(STA_PASSWORD_KEY, wifi_config.sta.password, sizeof(wifi_config.sta.password), 0);

        if (ret != ESP_OK) {
            ESP_LOGE(TAG, "%s key store failed with %d", STA_PASSWORD_KEY, ret);
            return ESP_FAIL;
        }
    }

    return ESP_OK;
}

static esp_err_t conn_mgr_obtain_time(void)
{
    static bool get_time_flag = false;
    if (get_time_flag) {
        return ESP_OK;
    }

    sntp_setoperatingmode(SNTP_OPMODE_POLL);
    sntp_setservername(0, "ntp1.aliyun.com");
    sntp_setservername(1, "ntp2.aliyun.com");
    sntp_setservername(2, "ntp3.aliyun.com");
    sntp_init();

    time_t now = 0;
    struct tm timeinfo = { 0 };
    int sntp_retry_cnt = 0;
    int sntp_retry_time = 0;
    while (1) {
        for (int32_t i = 0; (i < (SNTP_RECV_TIMEOUT / 100)) && timeinfo.tm_year < (2019 - 1900); i ++) {
            vTaskDelay(100 / portTICK_RATE_MS);
            time(&now);
            localtime_r(&now, &timeinfo);
        }

        if (timeinfo.tm_year < (2019 - 1900) && sntp_retry_cnt < (SNTP_RECV_TIMEOUT / 100)) {
            sntp_retry_time = SNTP_RECV_TIMEOUT << sntp_retry_cnt;

            if (SNTP_RECV_TIMEOUT << (sntp_retry_cnt + 1) < SNTP_RETRY_TIMEOUT_MAX) {
                sntp_retry_cnt ++;
            }

            ESP_LOGI(TAG,"SNTP get time failed, retry after %d ms\n", sntp_retry_time);
            vTaskDelay(sntp_retry_time / portTICK_RATE_MS);
        } else {
            ESP_LOGI(TAG,"SNTP get time success\n");
            break;
        }
    }

    get_time_flag = true;

    return ESP_OK;
}

static esp_err_t conn_mgr_wifi_event_loop_handler(void *ctx, system_event_t *event)
{
    system_event_info_t *info = &event->event_info;
    switch (event->event_id) {
        case SYSTEM_EVENT_STA_GOT_IP:
            conn_mgr_save_wifi_config();
#ifdef CONFIG_ESP_TLS_USING_WOLFSSL
            conn_mgr_obtain_time();
#endif
            break;

        case SYSTEM_EVENT_STA_DISCONNECTED:
            ESP_LOGE(TAG, "Disconnect reason : %d", info->disconnected.reason);
#ifdef CONFIG_IDF_TARGET_ESP8266
            if (info->disconnected.reason == WIFI_REASON_BASIC_RATE_NOT_SUPPORT) {
                /*Switch to 802.11 bgn mode */
                esp_wifi_set_protocol(ESP_IF_WIFI_STA, WIFI_PROTOCOL_11B | WIFI_PROTOCOL_11G | WIFI_PROTOCOL_11N);
            }
#endif
            esp_wifi_connect();
            break;

        default:
            break;
    }

    /** The application loop event handle */
    if (hal_wifi_system_cb) {
        hal_wifi_system_cb(ctx, event);
    }

    return ESP_OK;
}

void conn_mgr_register_wifi_event(system_event_cb_t cb)
{
    hal_wifi_system_cb = cb;
}

esp_err_t conn_mgr_reset_wifi_config(void)
{
    HAL_Kv_Del(STA_SSID_KEY);
    HAL_Kv_Del(STA_PASSWORD_KEY);

    return ESP_OK;
}

esp_err_t conn_mgr_init_wifi_config(void)
{
    wifi_config_t wifi_config = {
        .sta = {
            .ssid = CONFIG_ESP_WIFI_SSID,
            .password = CONFIG_ESP_WIFI_PASSWORD,
        },
    };
    int ret = HAL_Kv_Set(STA_SSID_KEY, wifi_config.sta.ssid, sizeof(wifi_config.sta.ssid), 0);

    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "%s key store failed with %d", STA_SSID_KEY, ret);
        return ESP_FAIL;
    }

    ret = HAL_Kv_Set(STA_PASSWORD_KEY, wifi_config.sta.password, sizeof(wifi_config.sta.password), 0);

    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "%s key store failed with %d", STA_PASSWORD_KEY, ret);
        return ESP_FAIL;
    }
    return ESP_OK;
}

static esp_err_t conn_mgr_is_configured(bool *configured)
{
    if (!configured) {
        return ESP_ERR_INVALID_ARG;
    }

    *configured = false;

    int ssid_len = 32;
    uint8_t ssid[32];

    int ret = HAL_Kv_Get(STA_SSID_KEY, ssid, &ssid_len);

    if (ret == ESP_OK && ssid_len) {
        *configured = true;
        ESP_LOGI(TAG, "Found ssid %s", ssid);
    }

    return ESP_OK;
}

esp_err_t conn_mgr_set_wifi_config_ext(const uint8_t *ssid, size_t ssid_len, const uint8_t *password, size_t password_len)
{
    wifi_config_t wifi_config = {0};

    if (!ssid || ssid_len > sizeof(wifi_config.sta.ssid) || password_len > sizeof(wifi_config.sta.password))
        return ESP_ERR_INVALID_ARG;
    
    memcpy(wifi_config.sta.ssid, ssid, ssid_len); 
    if (password) {
        memcpy(wifi_config.sta.password, password, password_len); 
    }
    esp_wifi_set_config(ESP_IF_WIFI_STA, &wifi_config);

    conn_mgr_save_wifi_config();

    return ESP_OK;
}

esp_err_t conn_mgr_get_wifi_config(wifi_config_t *wifi_cfg)
{
    return esp_wifi_get_config(ESP_IF_WIFI_STA, wifi_cfg);
}

esp_err_t conn_mgr_init(void)
{
    extern esp_err_t HAL_Kv_Init(void);
    HAL_Kv_Init();

    tcpip_adapter_init();

    wifi_init_config_t cfg = WIFI_INIT_CONFIG_DEFAULT();
    ESP_ERROR_CHECK(esp_event_loop_init(conn_mgr_wifi_event_loop_handler, NULL));
    ESP_ERROR_CHECK(esp_wifi_init(&cfg));
    ESP_ERROR_CHECK(esp_wifi_set_storage(WIFI_STORAGE_RAM));
    ESP_ERROR_CHECK(esp_wifi_set_mode(WIFI_MODE_STA));
    ESP_ERROR_CHECK(esp_wifi_start());

    return ESP_OK;
}

esp_err_t conn_mgr_start(void)
{
    bool ret = true;
    bool configured = false;
    uint8_t mode = 0;
    int mode_len = sizeof(uint8_t);
    conn_sc_mode_t awss_mode = CONN_SC_ZERO_MODE;

    // Let's find out if the device is configured.
    if (conn_mgr_is_configured(&configured) != ESP_OK) {
        return ESP_FAIL;
    }

    // Get SC mode and decide to start which awss service
    HAL_Kv_Get(SC_MODE, &mode, &mode_len);
    if (mode_len && mode == CONN_SOFTAP_MODE) {
        ESP_LOGI(TAG, "CONN_SOFTAP_MODE");
        awss_mode = CONN_SOFTAP_MODE;
    } else {
        ESP_LOGI(TAG, "mode: %d ", mode);
    }

    // If the device is not yet configured, start awss service.
    if (!configured) {
        do {
            if (awss_config_press() != 0) {
                ret = false;
                break;
            }
            if (awss_mode == CONN_SOFTAP_MODE) {
                if (awss_dev_ap_start() != 0) {
                    ret = false;
                    break;
                }
            } else {
                if (awss_start() != 0) {
                    ret = false;
                    break;
                }
            }
        } while (0);
    } else {
        if (conn_mgr_wifi_connect() != ESP_OK) {
            ret = false;
        }
    }

    return ret == true ? ESP_OK : ESP_FAIL;
}

esp_err_t conn_mgr_stop(void)
{
    bool ret = true;
    bool configured = false;
    uint8_t mode = 0;
    int mode_len = sizeof(uint8_t);
    conn_sc_mode_t awss_mode = CONN_SC_ZERO_MODE;

    // Let's find out if the device is configured.
    if (conn_mgr_is_configured(&configured) != ESP_OK) {
        return ESP_FAIL;
    }

    // Get SC mode and decide to start which awss service
    HAL_Kv_Get(SC_MODE, &mode, &mode_len);
    if (mode_len && mode == CONN_SOFTAP_MODE) {
        awss_mode = CONN_SOFTAP_MODE;
    }

    // If the device is not yet configured, stop awss service.
    if (!configured) {
        if (awss_mode == CONN_SOFTAP_MODE) {
            if (awss_dev_ap_stop() != 0) {
                ret = false;
            }
        } else {
            if (awss_stop() != 0) {
                ret = false;
            }
        }
    }

    return ret == true ? ESP_OK : ESP_FAIL;
}

esp_err_t conn_mgr_set_ap_ssid(uint8_t *ssid, int len)
{
    int ret = ESP_FAIL;
    uint8_t ssid_kv[32] = {0};
    int len_kv = 32;

    if (!ssid || !len) {
        ESP_LOGI(TAG, "input ssid and len error");
        return ret;
    }
    ret = HAL_Kv_Get(AP_SSID_KEY, ssid_kv, &len_kv);
    if (ret == ESP_OK && len_kv == len) {
        if (!memcmp(ssid, ssid_kv, len)) {
            return ESP_OK;
        }
    }

    ret = HAL_Kv_Set(AP_SSID_KEY, ssid, len, 0);
    ESP_LOGI(TAG, "%s %s", __FUNCTION__, (ret == ESP_OK) ? "success" : "fail");

    return ret;
}

esp_err_t conn_mgr_set_sc_mode(uint8_t mode)
{
    int ret = ESP_FAIL;
    uint8_t mode_kv = 0;
    int len_kv = sizeof(uint8_t);

    ret = HAL_Kv_Get(SC_MODE, &mode_kv, &len_kv);
    if (ret == ESP_OK) {
        if (mode == mode_kv) {
            return ESP_OK;
        }
    }

    ret = HAL_Kv_Set(SC_MODE, &mode, sizeof(uint8_t), 0);
    ESP_LOGI(TAG, "%s %s", __FUNCTION__, (ret == ESP_OK) ? "success" : "fail");

    return ret;
}
