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

#include <arpa/inet.h>
#include <string.h>

#include "iot_import_awss.h"

#include "esp_log.h"
#include "esp_wifi.h"

static const char *TAG = "wifi";

static awss_wifi_mgmt_frame_cb_t s_awss_mgmt_frame_cb = NULL;
static uint8_t s_esp_oui[3] = { 0 };

typedef void (*wifi_sta_rx_probe_req_t)(const uint8_t *frame, int len, int rssi);
extern esp_err_t esp_wifi_set_sta_rx_probe_req(wifi_sta_rx_probe_req_t cb);
extern void *HAL_Malloc(uint32_t size);
extern void *HAL_Realloc(void *ptr, uint32_t size);
extern void HAL_Free(void *ptr);

static void wifi_sta_rx_probe_req(const uint8_t *frame, int len, int rssi)
{
    //Notice: The number must be sync to function awss_init_enrollee_info logic to decode data format
    //42 = ZC_PROBE_LEN - FCS_SIZE;
    vendor_ie_data_t *awss_ie_info = (vendor_ie_data_t *)(frame + 42);
    // vendor_oui is {0xD8, 0x96, 0xE0}
    if (awss_ie_info->element_id == WIFI_VENDOR_IE_ELEMENT_ID && awss_ie_info->length != 0 && !memcmp(awss_ie_info->vendor_oui, s_esp_oui, 3)) {
        if (awss_ie_info->vendor_oui_type == 171) { // 171 = WLAN_OUI_TYPE_ENROLLEE
            ESP_LOGW(TAG, "frame is no support, awss_ie_info->type: %d", awss_ie_info->vendor_oui_type);
            return;
        }
        if (s_awss_mgmt_frame_cb) {
            s_awss_mgmt_frame_cb((uint8_t *)awss_ie_info, awss_ie_info->length + 2, rssi, 1);
        }
    }
}

int HAL_Wifi_Enable_Mgmt_Frame_Filter(
    _IN_ uint32_t filter_mask,
    _IN_OPT_ uint8_t vendor_oui[3],
    _IN_ awss_wifi_mgmt_frame_cb_t callback)
{
    if (!callback || filter_mask != (FRAME_PROBE_REQ_MASK | FRAME_BEACON_MASK)) {
        return NULL_VALUE_ERROR;
    }

    s_awss_mgmt_frame_cb = callback;
    memcpy(s_esp_oui, vendor_oui, sizeof(s_esp_oui));
    esp_err_t ret = esp_wifi_set_sta_rx_probe_req(wifi_sta_rx_probe_req);

    return ret == ESP_OK ? SUCCESS_RETURN : FAIL_RETURN;
}

int HAL_Wifi_Get_Ap_Info(char ssid[HAL_MAX_SSID_LEN], char passwd[HAL_MAX_PASSWD_LEN], uint8_t bssid[ETH_ALEN])
{
    esp_err_t ret = ESP_FAIL;
    wifi_ap_record_t ap_info;

    do {
        memset(&ap_info, 0, sizeof(wifi_ap_record_t));
        ret = esp_wifi_sta_get_ap_info(&ap_info);

        if (ret != ESP_OK) {
            ESP_LOGE(TAG, "Get AP info fail, err=0x%x", ret);
            break;
        }

        if (ssid) {
            memcpy(ssid, ap_info.ssid, HAL_MAX_SSID_LEN);
        }

        if (bssid) {
            memcpy(bssid, ap_info.bssid, ETH_ALEN);
        }

        if (ap_info.authmode != WIFI_AUTH_OPEN && passwd) {
            wifi_config_t wifi_cfg;
            if (esp_wifi_get_config(ESP_IF_WIFI_STA, &wifi_cfg) == ESP_OK) {
                if (wifi_cfg.sta.password) {
                    memcpy(passwd, wifi_cfg.sta.password, HAL_MAX_PASSWD_LEN);
                }
            }

        }
    } while (0);

    return (ret == ESP_OK) ? SUCCESS_RETURN : FAIL_RETURN;
}

uint32_t HAL_Wifi_Get_IP(char ip_str[NETWORK_ADDR_LEN], const char *ifname)
{
    esp_err_t ret = 0;
    tcpip_adapter_ip_info_t info;
    wifi_mode_t mode;

    ret = esp_wifi_get_mode(&mode);

    if (ret != ESP_OK) {
        return 0;
    }

    ret = tcpip_adapter_get_ip_info((mode == WIFI_MODE_STA) ? TCPIP_ADAPTER_IF_STA : TCPIP_ADAPTER_IF_AP, &info);

    if (ret != ESP_OK) {
        return 0;
    }

    memcpy(ip_str, inet_ntoa(info.ip.addr), NETWORK_ADDR_LEN);

    return info.ip.addr;
}

char *HAL_Wifi_Get_Mac(char mac_str[HAL_MAC_LEN])
{
    esp_err_t ret = 0;
    uint8_t mac[6] = {0};
    wifi_mode_t mode;

    ret = esp_wifi_get_mode(&mode);

    if (ret != ESP_OK) {
        return NULL;
    }

    ret = esp_wifi_get_mac((mode == WIFI_MODE_AP) ? WIFI_MODE_AP - 1 : WIFI_MODE_STA - 1, mac);

    if (ret != ESP_OK) {
        return NULL;
    }

    snprintf(mac_str, HAL_MAC_LEN, MACSTR, MAC2STR(mac));
    return (char *)mac_str;
}

int HAL_Wifi_Scan(awss_wifi_scan_result_cb_t cb)
{
    esp_err_t ret = ESP_OK;
    uint16_t wifi_ap_num = 0;
    wifi_ap_record_t *ap_info = NULL;
    wifi_scan_config_t scan_config = {
            .show_hidden = 0,
            .scan_type = 0,
            .scan_time = {
                 .passive = 0,
                 .active = {
                      .min = 100,
                      .max = 200
                 }
            }
    };

    ret = esp_wifi_scan_start(&scan_config, true);
    ret |= esp_wifi_scan_get_ap_num(&wifi_ap_num);
    if (wifi_ap_num) {
        ap_info = (wifi_ap_record_t *)HAL_Malloc(sizeof(wifi_ap_record_t) * wifi_ap_num);
        ret |= esp_wifi_scan_get_ap_records(&wifi_ap_num, ap_info);
        if (ret == ESP_OK && cb) {
            for (int i = 0; i < wifi_ap_num; ++i) {
                cb((char *)ap_info[i].ssid, (uint8_t *)ap_info[i].bssid, ap_info[i].authmode, AWSS_ENC_TYPE_INVALID,
                           ap_info[i].primary, ap_info[i].rssi, 1);
            }
        }
        HAL_Free(ap_info);
    }

    esp_wifi_scan_stop();

    return (ret == ESP_OK) ? SUCCESS_RETURN : FAIL_RETURN;
}

int HAL_Wifi_Send_80211_Raw_Frame(_IN_ enum HAL_Awss_Frame_Type type,
                                  _IN_ uint8_t *buffer, _IN_ int len)
{
    esp_err_t ret = ESP_OK;

    if (!buffer) {
        return NULL_VALUE_ERROR;
    }

    ret = esp_wifi_80211_tx(ESP_IF_WIFI_STA, buffer, len, true);

    return (ret == ESP_OK) ? SUCCESS_RETURN : FAIL_RETURN;
}