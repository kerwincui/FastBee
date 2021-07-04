
#include <stdio.h>
#include "nvs_flash.h"
#include "esp_event.h"
#include "example.h"
#include "mqtt.h"
#include "wifi.h"

/******************************************************************************
 * FunctionName : app_main
 * Description  : entry of user application, init user function here
 * Author       : kerwincui
 * SourceCode   : https://gitee.com/kerwincui/wumei-smart
*******************************************************************************/
void app_main()
{
    printf("Docking wumei-smart system demo \n");

    // 初始化NVS
    esp_err_t ret = nvs_flash_init();
    if (ret == ESP_ERR_NVS_NO_FREE_PAGES || ret == ESP_ERR_NVS_NEW_VERSION_FOUND) {
        ESP_ERROR_CHECK(nvs_flash_erase());
        ret = nvs_flash_init();
    }
    ESP_ERROR_CHECK( ret );

    // 创建默认时间循环
    ESP_ERROR_CHECK(esp_event_loop_create_default());

    //连接wifi
    wifi_start();

    // 启动mqtt
    mqtt_start();
}
