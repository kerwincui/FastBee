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

#include <netinet/in.h>
#include <string.h>

#include "infra_defs.h"
#include "iot_import_awss.h"
#include "dev_bind_wrapper.h"

#include "esp_log.h"
#include "esp_wifi.h"
#ifdef CONFIG_IDF_TARGET_ESP8266
#include "esp_task_wdt.h"
#endif

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

static awss_recv_80211_frame_cb_t s_sniffer_cb;

static const char *TAG = "awss";

static void HAL_Awss_Monitor_callback(void *recv_buf, wifi_promiscuous_pkt_type_t type)
{
    int with_fcs = 0;
    int link_type = AWSS_LINK_TYPE_NONE;
    uint16_t len = 0;
    wifi_promiscuous_pkt_t *pkt = (wifi_promiscuous_pkt_t *)recv_buf;
    int8_t rssi;

    if (type != WIFI_PKT_DATA && type != WIFI_PKT_MGMT) {
        return;
    }

    rssi = pkt->rx_ctrl.rssi;

#ifdef CONFIG_IDF_TARGET_ESP8266
    uint8_t total_num = 1;
    uint16_t seq_buf;
    len = pkt->rx_ctrl.sig_mode ? pkt->rx_ctrl.HT_length : pkt->rx_ctrl.legacy_length;

    esp_task_wdt_reset();

    if (pkt->rx_ctrl.aggregation) {
        total_num = pkt->rx_ctrl.ampdu_cnt;
    }

    for (uint8_t count = 0; count < total_num; count++) {
        if (total_num > 1) {
            len = *(uint16_t *)(pkt->payload + 40 + 2 * count);
        }

        if (type == WIFI_PKT_MISC && pkt->rx_ctrl.aggregation == 1) {
            len -= 4;
        }

        if (s_sniffer_cb) {
            s_sniffer_cb((char *)pkt->payload, len - 4, link_type, with_fcs, rssi);
        }

        if (total_num > 1) {
            seq_buf = *(uint16_t *)(pkt->payload + 22) >> 4;
            seq_buf++;
            *(uint16_t *)(pkt->payload + 22) = (seq_buf << 4) | (*(uint16_t *)(pkt->payload + 22) & 0xF);
        }
    }

#else

    if (s_sniffer_cb) {
        len = pkt->rx_ctrl.sig_len;
        s_sniffer_cb((char *)pkt->payload, len - 4, link_type, with_fcs, rssi);
    }

#endif
}

void HAL_Awss_Open_Monitor(_IN_ awss_recv_80211_frame_cb_t cb)
{
    if (!cb) {
        return;
    }

    s_sniffer_cb = cb;

    ESP_ERROR_CHECK(esp_wifi_set_mode(WIFI_MODE_STA));
    ESP_ERROR_CHECK(esp_wifi_start());
    ESP_ERROR_CHECK(esp_wifi_set_promiscuous(true));
    ESP_ERROR_CHECK(esp_wifi_set_channel(6, 0));
    ESP_ERROR_CHECK(esp_wifi_set_promiscuous_rx_cb(HAL_Awss_Monitor_callback));

#ifdef CONFIG_IDF_TARGET_ESP8266
    extern void esp_wifi_set_promiscuous_data_len(uint32_t);
    esp_wifi_set_promiscuous_data_len(512);
#endif

    ESP_LOGI(TAG, "Open monitor mode");
}

void HAL_Awss_Close_Monitor(void)
{
    if (!s_sniffer_cb) {
        return;
    }

    ESP_ERROR_CHECK(esp_wifi_set_promiscuous(false));
    ESP_ERROR_CHECK(esp_wifi_set_promiscuous_rx_cb(NULL));

    s_sniffer_cb = NULL;

    ESP_LOGI(TAG, "Close monitor mode");

}

int HAL_Awss_Connect_Ap(
    _IN_ uint32_t connection_timeout_ms,
    _IN_ char ssid[HAL_MAX_SSID_LEN],
    _IN_ char passwd[HAL_MAX_PASSWD_LEN],
    _IN_OPT_ enum AWSS_AUTH_TYPE auth,
    _IN_OPT_ enum AWSS_ENC_TYPE encry,
    _IN_OPT_ uint8_t bssid[ETH_ALEN],
    _IN_OPT_ uint8_t channel)
{
    uint32_t connect_ms = 0;
    wifi_config_t wifi_config = { 0 };

    if (ssid) {
        memcpy(wifi_config.sta.ssid, ssid, HAL_MAX_SSID_LEN - 1);
    }

    if (passwd) {
        memcpy(wifi_config.sta.password, passwd, HAL_MAX_PASSWD_LEN - 1);
    }

    if (bssid != NULL && strlen((char *)bssid)) {
        memcpy(wifi_config.sta.bssid, bssid, ETH_ALEN);
        wifi_config.sta.bssid_set = false;
    }

    wifi_config.sta.channel = channel;

    ESP_LOGI(TAG, "ssid: %s, password: %s, channel: %d",
             wifi_config.sta.ssid, "******", channel);

    ESP_LOGD(TAG, "password: %s", wifi_config.sta.password);

    ESP_ERROR_CHECK(esp_wifi_set_mode(WIFI_MODE_STA));
    ESP_ERROR_CHECK(esp_wifi_set_config(WIFI_IF_STA, &wifi_config));
    ESP_ERROR_CHECK(esp_wifi_start());
    ESP_ERROR_CHECK(esp_wifi_connect());

    while (connect_ms < connection_timeout_ms) {
        if (HAL_Sys_Net_Is_Ready() == 1) {
            ESP_LOGI(TAG, "AP connected");
            return SUCCESS_RETURN;
        } else {
            ESP_LOGI(TAG, "Connecting AP");
            vTaskDelay(500 / portTICK_PERIOD_MS);
            connect_ms += 500;
        }
    }

        return FAIL_RETURN;

}

int HAL_Awss_Get_Channelscan_Interval_Ms(void)
{
    return CONFIG_AWSS_CHANNELSCAN_INTERVAL_MS;
}

int HAL_Awss_Get_Timeout_Interval_Ms(void)
{
    return CONFIG_AWSS_TIMEOUT_INTERVAL_MS;
}

int HAL_Awss_Open_Ap(const char *ssid, const char *passwd, int beacon_interval, int hide)
{
    if (!ssid || !passwd) {
        ESP_LOGI(TAG, "ssid or passwd is NULL");
        return FAIL_RETURN;
    }

    wifi_config_t wifi_config = {
        .ap = {
            .max_connection = 5,
            .beacon_interval = beacon_interval,
            .ssid_hidden = hide,
        },
    };
#ifdef CONFIG_HAL_USE_CUSTOMER_AP_SSID
    uint8_t ssid_kv[32] = {0};
    int len_kv = 32;
    #define AP_SSID_KEY CONFIG_AP_SSID_KEY
    int ret = HAL_Kv_Get(AP_SSID_KEY, ssid_kv, &len_kv);
    if (ret == ESP_OK) {
        memcpy(wifi_config.ap.ssid, ssid_kv, len_kv);
        wifi_config.ap.ssid_len = len_kv;
    } else {
        ESP_LOGI(TAG, "Can't get customer softap ssid, so use default");
        strncpy((char *) wifi_config.ap.ssid, ssid, sizeof(wifi_config.ap.ssid));
        wifi_config.ap.ssid_len = strlen(ssid);
    }
#else
    strncpy((char *) wifi_config.ap.ssid, ssid, sizeof(wifi_config.ap.ssid));
    wifi_config.ap.ssid_len = strlen(ssid);
#endif
    if (strlen(passwd) == 0) {
        memset(wifi_config.ap.password, 0, sizeof(wifi_config.ap.password));
        wifi_config.ap.authmode = WIFI_AUTH_OPEN;
    } else {
        strncpy((char *) wifi_config.ap.password, passwd, sizeof(wifi_config.ap.password));
        wifi_config.ap.authmode = WIFI_AUTH_WPA_WPA2_PSK;
    }
    ESP_LOGI(TAG, "ssid: %s", (char *) wifi_config.ap.ssid);
    ESP_ERROR_CHECK(esp_wifi_set_mode(WIFI_MODE_AP));
    ESP_ERROR_CHECK(esp_wifi_set_config(ESP_IF_WIFI_AP, &wifi_config));
    ESP_ERROR_CHECK(esp_wifi_start());

    return SUCCESS_RETURN;
}

int HAL_Awss_Close_Ap(void)
{
    wifi_mode_t mode;
    ESP_ERROR_CHECK(esp_wifi_get_mode(&mode));
    if (mode == WIFI_MODE_AP) {
        ESP_ERROR_CHECK(esp_wifi_stop());
    }
    return SUCCESS_RETURN;
}

void HAL_Awss_Switch_Channel(char primary_channel, char secondary_channel, uint8_t bssid[ETH_ALEN])
{
    if (esp_wifi_set_channel(primary_channel, secondary_channel) != ESP_OK) {
        ESP_LOGW(TAG, "HAL_Awss_Switch_Channel primary %d, second %d", primary_channel, secondary_channel);
    }
}

int HAL_Awss_Get_Encrypt_Type() {
    return 3;
}

int HAL_Awss_Get_Conn_Encrypt_Type() {
    return 3;
}
