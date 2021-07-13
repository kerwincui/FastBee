/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
#include "button.h"
#include "common.h"
#include "smart_config.h"
#include "led.h"
#include "wifi.h"
#include "http_server.h"
#include "native_ota.h"
#include "mqtt.h"
#include "lwip_sntp.h"
#include "nvs_storage.h"


static const char* TAG = "button";
bool is_open=false;

//单击开关按钮(回调函数)
static void button_single_click_cb(void* arg)
{
    ESP_EARLY_LOGI(TAG, "tab switch button\n");
    if(relay_status==1)
    {
        close_relay();
        relay_status=0;
    }else{ 
        open_relay();
        relay_status=1;
    }
    write_relay_status();
    
    // mqtt发布状态
    if(is_wifi_offline==0 && wifi_status==1 ){
        publishStatus();
    }
}

//长按开关按钮
static void button_long_press_start_cb(void* arg)
{
    ESP_LOGI(TAG, "begin smargconfig\n"); 
    //蓝灯闪烁
    led_rgb_blink(0,0,255,2,0,0,0,0);
    //智能配网        
    smart_config_start();

}

// 连续短按开关按钮
static void button_press_repeat_cb(void *arg)
{    
    ESP_LOGI(TAG, "BUTTON_PRESS_REPEAT[%d]", iot_button_get_repeat((button_handle_t)arg));
    uint8_t num=iot_button_get_repeat((button_handle_t)arg);
    ESP_LOGI(TAG, "press repeat num: %d\n",num);
    
    switch (num)
    {
    case 7:
        ESP_LOGI(TAG, "native ota...\n");
        led_rgb_blink(255,0,0,2,0,0,0,0);
        native_ota_start();
        break;
    case 6:
        //打开/关闭雷达        
        led_rgb_blink(0,0,255,2,0,6,0,0);
        is_radar=is_radar==1 ? 0:1;
        write_is_radar();
        break;
    case 5:
        //遥控清码
        ESP_LOGI(TAG, "rf clear code ...\n");
        led_rgb_blink(0,0,255,2,0,5,0,0);
        is_rf_clear=1;
        rf_clear_code();
        break;
    case 4:    
        //遥控学习    
        ESP_LOGI(TAG, "rf learning... \n");
        led_rgb_blink(0,0,255,2,0,4,0,0);
        is_rf_learn=1;
        rf_learn();
        break;
    case 3:                
        if(is_ap!=1){
            // 打开ap
            ESP_LOGI(TAG, "open access point \n");
            is_ap=1;
            ap_start(); 
        }else{
            //重启
            device_restart();
        }        
        break;   
    case 2:                
        ESP_EARLY_LOGI(TAG, "switch light \n");
        light_status=light_status==0?1:0;
        led_status();
        write_light_status();
        break; 
    default:
        break;
    }

    // mqtt发布状态
    if(is_wifi_offline==0 && wifi_status==1 ){
        publishSetting();
        publishStatus();
    }
}




void button_start()
{
    printf("before btn init, heap: %d\n", esp_get_free_heap_size());    

    //初始化继电器引脚
    gpio_pad_select_gpio(IO_RELAY);
    gpio_set_direction(IO_RELAY,GPIO_MODE_OUTPUT);

    //初始化按键
    button_config_t cfg = {
        .type = BUTTON_TYPE_GPIO,
        .gpio_button_config = {
            .gpio_num = IO_SWITCH_BUTTON,
            .active_level = 0,
        },
    };
    button_handle_t gpio_btn = iot_button_create(&cfg);
    if(NULL == gpio_btn) { ESP_LOGE(TAG, "Button create failed"); }
    iot_button_register_cb(gpio_btn, BUTTON_SINGLE_CLICK, button_single_click_cb);            //短按
    iot_button_register_cb(gpio_btn, BUTTON_LONG_PRESS_START, button_long_press_start_cb);    //长按
    iot_button_register_cb(gpio_btn, BUTTON_PRESS_REPEAT, button_press_repeat_cb);            //连续短按
}




/************************************* begin RF接收信号 ***************************************/

static void process_rf_func(uint8_t function){
    if(function==1){
        //打开关闭继电器
        ESP_LOGI(TAG, "switch relay\n");
        if(relay_status==0){
            open_relay();
            relay_status=1;
        }else if(relay_status==1){
            close_relay();
            relay_status=0;
        }
        write_relay_status();
    }else if(function==2){
        //打开关闭灯
        ESP_LOGI(TAG, "switch light\n");
        light_status=light_status==0?1:0;
        led_status();
    }else if(function==3){
        //打开关闭雷达
        ESP_LOGI(TAG, "switch radar\n");
        if(is_radar==0){
            is_radar=1;
        }else if(is_radar==1){
            is_radar=0;
        }
        write_is_radar();
    }else if(function==4){
        //打开关闭报警
        ESP_LOGI(TAG, "switch alarm\n");
        if(is_alarm==0){
            is_alarm=1;
        }else if(is_alarm==1){
            is_alarm=0;
        }
        write_is_alarm();
    }else if(function==5){
        ESP_LOGI(TAG, "smart config\n"); 
        if(is_smart_config==0){
                ESP_LOGI(TAG, "begin smargconfig\n"); 
                // wifi_mqtt_stop();
                is_smart_config=1;
                //蓝灯闪烁
                // led_rgb_blink(0,0,255,2,0,0,0,0);
                //智能配网        
                smart_config_start();
        }else{            
            is_smart_config=0;
            ESP_LOGI(TAG, "device restart\n");
            device_restart();
            
        }
    }

    // mqtt发布状态
    if(is_wifi_offline==0 && wifi_status==1 ){
        publishStatus();
        publishSetting();
    }
}

//RF接收任务
static void rf_receiver_task(void *arg) {
    ESP_LOGI(TAG, "begin rf receiver");
    // uint32_t gpio_num = (uint32_t) arg;
    while(true)
    {
        if(gpio_get_level(IO_RF_RECEIVER_A)==1)
        {
            process_rf_func(rf_one_func);
        }else if(gpio_get_level(IO_RF_RECEIVER_B)==1)
        {
            process_rf_func(rf_two_func);

        }else if(gpio_get_level(IO_RF_RECEIVER_C)==1)
        {
            process_rf_func(rf_three_func);
        }else if(gpio_get_level(IO_RF_RECEIVER_D)==1)
        {
            process_rf_func(rf_four_func);
        }
        vTaskDelay(pdMS_TO_TICKS(250));
    }
}

void rf_receiver_start(void)
{
    // 初始化射频引脚
    gpio_pad_select_gpio(IO_RF_RECEIVER_D);
    gpio_pad_select_gpio(IO_RF_RECEIVER_C);
    gpio_pad_select_gpio(IO_RF_RECEIVER_B);
    gpio_pad_select_gpio(IO_RF_RECEIVER_A);
    gpio_pad_select_gpio(IO_RF_LEARN_KEY);

    gpio_set_direction(IO_RF_RECEIVER_D,GPIO_MODE_INPUT);
    gpio_set_direction(IO_RF_RECEIVER_C,GPIO_MODE_INPUT);
    gpio_set_direction(IO_RF_RECEIVER_B,GPIO_MODE_INPUT);
    gpio_set_direction(IO_RF_RECEIVER_A,GPIO_MODE_INPUT);
    gpio_set_direction(IO_RF_LEARN_KEY,GPIO_MODE_OUTPUT);

    // gpio_set_pull_mode(IO_RF_RECEIVER_D,GPIO_PULLDOWN_ONLY);
    // gpio_set_pull_mode(IO_RF_RECEIVER_C,GPIO_PULLDOWN_ONLY);
    // gpio_set_pull_mode(IO_RF_RECEIVER_B,GPIO_PULLDOWN_ONLY);
    // gpio_set_pull_mode(IO_RF_RECEIVER_A,GPIO_PULLDOWN_ONLY);


    //创建接收信号任务
    xTaskCreate(rf_receiver_task, "rf_receiver_task", 2048, (void*) IO_RF_RECEIVER_A, 10, NULL); 

}

/************************************* end RF接信号 ***************************************/






/************************************* begin 雷达感应 ***************************************/

//雷达感应任务
static void radar_sense(void *arg) {
    ESP_LOGI(TAG, "begin radar sense");
    uint16_t num=0;
    while(true){ 
        // if(is_radar==1 && is_alarm==1){
        //     if(gpio_get_level(IO_RADAR_OUT)==1){
        //         if(relay_status==0) { 
        //             open_relay(); 
        //             led_rgb_blink(255,0,0,100,0,0,3,1000); //红灯闪烁
        //         }
        //     }
        //     else{
        //         //超过指定时间后关闭
        //         if(relay_status==1 && num >5*radar_interval){
        //             close_relay();
        //             light_status=0;
        //             led_status();
        //             num=0;
        //         }
        //         num++;
        //     }
        // } else if(is_radar==1) {
        //     if(gpio_get_level(IO_RADAR_OUT)==1){
        //         if(relay_status==0) { 
        //             open_relay(); 
        //             light_status=1;
        //             led_status();
        //         }
        //     }
        //     else{
        //         //超过指定时间后关闭
        //         if(relay_status==1 && num >5*radar_interval){
        //             close_relay();
        //             light_status=0;
        //             led_status();
        //             num=0;
        //         }
        //         num++;
        //     }
        // }
        vTaskDelay(pdMS_TO_TICKS(200));
    }

}

// void radar_cds_enable(void){
//     gpio_set_level(IO_RADAR_CDS,1);
// }

// void radar_cds_disable(void){
//     gpio_set_level(IO_RADAR_CDS,0);
// }

void radar_start(void){
    // 初始化射频引脚
    gpio_pad_select_gpio(IO_RADAR_OUT);    
    gpio_set_direction(IO_RADAR_OUT,GPIO_MODE_INPUT);    
    gpio_set_pull_mode(IO_RADAR_OUT, GPIO_PULLDOWN_ONLY);

    // gpio_pad_select_gpio(IO_RADAR_CDS);
    // gpio_set_direction(IO_RADAR_CDS,GPIO_MODE_INPUT_OUTPUT);
    // gpio_set_pull_mode(IO_RADAR_OUT, GPIO_PULLUP_ONLY);

    xTaskCreate(radar_sense,"radar_sense", 2048,NULL,10,NULL);
}


/************************************* end 雷达感应 ***************************************/