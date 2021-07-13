/******************************************************************************
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
#include <stdio.h>
#include "nvs_flash.h"
#include "esp_log.h"
#include "driver/gpio.h"
#include "nvs.h"
#include "esp_pm.h"
#include "button.h"
#include "common.h"
#include "device_temp.h"
#include "i2c_temp.h"
#include "led.h"
#include "mqtt.h"
#include "smart_config.h"
#include "lwip_sntp.h"
#include "wifi.h"
#include "nvs_storage.h"
// #include "mqtt_ssl.h"
// #include "native_ota.h"
// #include "flash_encrypt.h"
// #include "statistic_free_rtos.h"
// #include "statistic_perfmon.h"

static const char *TAG = "wumei-open";

void app_main()
{
    esp_log_level_set("*", ESP_LOG_INFO);
    ESP_LOGI(TAG, "[wumei-open] Startup..");
    ESP_LOGI(TAG, "[APP] Free memory: %d bytes", esp_get_free_heap_size());
    ESP_LOGI(TAG, "[APP] IDF version: %s", esp_get_idf_version());
    
    // 初始化NVS
    esp_err_t ret = nvs_flash_init();
    if (ret == ESP_ERR_NVS_NO_FREE_PAGES || ret == ESP_ERR_NVS_NEW_VERSION_FOUND) {
        ESP_ERROR_CHECK(nvs_flash_erase());
        ret = nvs_flash_init();
    }
    ESP_ERROR_CHECK( ret );

    // 默认时间循环
    ESP_ERROR_CHECK(esp_event_loop_create_default());


#if CONFIG_PM_ENABLE
    // 配置动态频率变化，如果启用了无滴答空闲支持则会启用自动轻度睡眠
    esp_pm_config_esp32s2_t pm_config = {
        .max_freq_mhz = CONFIG_MAX_CPU_FREQ_MHZ,
        .min_freq_mhz = CONFIG_MIN_CPU_FREQ_MHZ,
    #if CONFIG_FREERTOS_USE_TICKLESS_IDLE
        .light_sleep_enable = true
    #endif
    };
    ESP_ERROR_CHECK( esp_pm_configure(&pm_config) );
#endif 

    // 读取配置信息
    read_config_data();
    // 获取设备编号
    get_device_num();
    // 启动led灯 
    led_start();

    // 启动按钮
    button_start();

    // 启动射频遥控接收
    rf_receiver_start(); 

    // 启动雷达感应
    // radar_start();

    // wifi
    if(is_wifi_offline==0){
        //连接wifi
        wifi_start();
        // 启动mqtt
        mqtt_start();
        //获取SNTP时间
        // sntp_start();
    }

    // 初始化设备温度
    device_temp_init();
    // 初始化空气温湿度
    // i2c_temp_start();
    
    //设备性能监测
    // ESP_LOGI(TAG, "start perfmon");
    // perfmon_start();

    //FreeRTOS监测
    // vTaskDelay(pdMS_TO_TICKS(2000));
    // ESP_LOGI(TAG, "start free rtos statistic");
    // free_rtos_start();
    
}
