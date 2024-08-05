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
#include <string.h>
#include <esp_log.h>

#include "freertos/FreeRTOS.h"
#include "freertos/semphr.h"
#include "freertos/timers.h"
#include "esp_sleep.h"
#include "dm_wrapper.h"
#include "conn_mgr.h"

#define FACTORY_QUICK_REBOOT_TIMEOUT        (CONFIG_FACTORY_QUICK_REBOOT_TIMEOUT * 1000)
#define FACTORY_QUICK_REBOOT_MAX_TIMES      CONFIG_FACTORY_QUICK_REBOOT_MAX_TIMES
#define FACTORY_QUICK_REBOOT_TIMES          "q_rt"

#define AWSS_KV_RST                         "awss.rst"

static const char *TAG = "factory_rst";

static esp_err_t factory_restore_handle(void)
{
    esp_err_t ret = ESP_OK;
    int quick_reboot_times = 0;

    /**< If the device restarts within the instruction time, the event_mdoe value will be incremented by one */
    int length = sizeof(int);
    ret = HAL_Kv_Get(FACTORY_QUICK_REBOOT_TIMES, &quick_reboot_times, &length);

    quick_reboot_times++;

    ret = HAL_Kv_Set(FACTORY_QUICK_REBOOT_TIMES, &quick_reboot_times, sizeof(int), 0);

    if (quick_reboot_times >= FACTORY_QUICK_REBOOT_MAX_TIMES) {
        char rst = 0x01;

        /*  since we cannot report reset status to cloud in this stage, just set the reset flag.
            when connects to cloud, awss will do the reset report. */
        ret = HAL_Kv_Set(AWSS_KV_RST, &rst, sizeof(rst), 0);  
        ret = HAL_Kv_Del(FACTORY_QUICK_REBOOT_TIMES);

        ESP_LOGW(TAG, "factory restore");
        conn_mgr_reset_wifi_config();
    } else {
        ESP_LOGI(TAG, "quick reboot times %d, don't need to restore", quick_reboot_times);
    }

    return ret;
}

static void factory_restore_timer_handler(void *timer)
{
    if (!xTimerStop(timer, 0)) {
        ESP_LOGE(TAG, "xTimerStop timer %p", timer);
    }

    if (!xTimerDelete(timer, 0)) {
        ESP_LOGE(TAG, "xTimerDelete timer %p", timer);
    }

    /* erase reboot times record */
    HAL_Kv_Del(FACTORY_QUICK_REBOOT_TIMES);

    ESP_LOGI(TAG, "Quick reboot timeout, clear reboot times");
}

esp_err_t factory_restore_init(void)
{
#ifndef CONFIG_IDF_TARGET_ESP8266
    if (esp_sleep_get_wakeup_cause() != ESP_SLEEP_WAKEUP_UNDEFINED) {
        HAL_Kv_Del(FACTORY_QUICK_REBOOT_TIMES);
        return ESP_OK;
    }
#endif

    TimerHandle_t timer = xTimerCreate("factory_clear", FACTORY_QUICK_REBOOT_TIMEOUT / portTICK_RATE_MS,
                                       false, NULL, factory_restore_timer_handler);

    xTimerStart(timer, portMAX_DELAY);

    return factory_restore_handle();
}
