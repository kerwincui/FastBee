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

#include <stdio.h>
#include <string.h>
#include "nvs_flash.h"
#include "nvs.h"

#include "esp_err.h"
#include "esp_log.h"

#define NVS_PARTITION_NAME  "nvs"
#define NVS_KV              "iotkit-kv"

static const char *TAG = "wrapper_kv";

static bool s_kv_init_flag;

esp_err_t HAL_Kv_Init(void)
{
    esp_err_t ret = ESP_OK;

    do {
        if (s_kv_init_flag == false) {
            ret = nvs_flash_init_partition(NVS_PARTITION_NAME);

            if (ret == ESP_ERR_NVS_NO_FREE_PAGES) {
                ESP_ERROR_CHECK(nvs_flash_erase_partition(NVS_PARTITION_NAME));
                ret = nvs_flash_init_partition(NVS_PARTITION_NAME);
            } else if (ret != ESP_OK) {
                ESP_LOGE(TAG, "NVS Flash init %s failed!", NVS_PARTITION_NAME);
                break;
            }

            s_kv_init_flag = true;
        }
    } while (0);

    return ret;
}

int HAL_Kv_Del(const char *key)
{
    nvs_handle handle;
    esp_err_t ret;

    char key_name[16] = {0};

    if (key == NULL) {
        ESP_LOGE(TAG, "HAL_Kv_Del Null key");
        return ESP_FAIL;
    }

    if (HAL_Kv_Init() != ESP_OK) {
        return ESP_FAIL;
    }

    ret = nvs_open_from_partition(NVS_PARTITION_NAME, NVS_KV, NVS_READWRITE, &handle);

    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "nvs open %s failed with %x", NVS_KV, ret);
        return ESP_FAIL;
    }

    /*max key name is 15UL*/
    memcpy(key_name, key, sizeof(key_name) - 1);

    ret = nvs_erase_key(handle, key_name);

    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "nvs erase key %s failed with %x", key_name, ret);
    } else {
        nvs_commit(handle);
    }

    nvs_close(handle);

    return ret;
}

int HAL_Kv_Get(const char *key, void *val, int *buffer_len)
{
    nvs_handle handle;
    esp_err_t ret;

    char key_name[16] = {0};

    if (key == NULL || val == NULL || buffer_len == NULL) {
        ESP_LOGE(TAG, "HAL_Kv_Get Null params");
        return ESP_FAIL;
    }

    if (HAL_Kv_Init() != ESP_OK) {
        return ESP_FAIL;
    }

    ret = nvs_open_from_partition(NVS_PARTITION_NAME, NVS_KV, NVS_READONLY, &handle);

    if (ret != ESP_OK) {
        ESP_LOGW(TAG, "nvs open %s failed with %x", NVS_KV, ret);
        return ESP_FAIL;
    }
    /*max key name is 15UL*/
    memcpy(key_name, key, sizeof(key_name) - 1);

    ret = nvs_get_blob(handle, key_name, val, (size_t *) buffer_len);

    if (ret != ESP_OK) {
        ESP_LOGW(TAG, "nvs get blob %s failed with %x", key_name, ret);
    }

    nvs_close(handle);

    return ret;
}

int HAL_Kv_Set(const char *key, const void *val, int len, int sync)
{
    nvs_handle handle;
    esp_err_t ret;

    char key_name[16] = {0};

    if (key == NULL || val == NULL || len <= 0) {
        ESP_LOGE(TAG, "HAL_Kv_Set NULL params");
        return ESP_FAIL;
    }

    if (HAL_Kv_Init() != ESP_OK) {
        return ESP_FAIL;
    }

    ret = nvs_open_from_partition(NVS_PARTITION_NAME, NVS_KV, NVS_READWRITE, &handle);

    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "nvs open %s failed with %x", NVS_KV, ret);
        return ESP_FAIL;
    }
    /*max key name is 15UL*/
    memcpy(key_name, key, sizeof(key_name) - 1);
    ESP_LOGE(TAG, "Set %s blob value", key_name);
    ret = nvs_set_blob(handle, key_name, val, len);

    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "nvs erase key %s failed with %x", key_name, ret);
    } else {
        nvs_commit(handle);
    }

    nvs_close(handle);

    return ret;
}
