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
#include "led.h"
#include "wifi.h"
#include "nvs_storage.h"

static TaskHandle_t led_blink_handle = NULL;

static ledc_channel_config_t ledc_channel[3];
static eTaskState state=eDeleted;
static const char* TAG = "led";

//灯颜色设置，颜色0-255，亮度0-100,fade_time>0则渐变
static void led_rgb_set(uint32_t red,uint32_t green,uint32_t blue, uint32_t brightness,uint32_t fade_time){
    uint32_t red_duty=0;
    uint32_t green_duty=0;
    uint32_t blue_duty=0;

    // 13位分辨率值为0-8191，倍数为32.121
    if(CATEGORY==2){
       red_duty=(uint32_t)(red*32.121*brightness/100);
       green_duty=(uint32_t)(green*32.121*brightness/100);
       blue_duty=(uint32_t)(blue*32.121*brightness/100);
    }else{
        red_duty=8191-(red*32.121*brightness/100);
        green_duty=8191-(green*32.121*brightness/100);
        blue_duty=8191-(blue*32.121*brightness/100);
    }
    if(red_duty>8191) {red_duty=8191;}
    if(red_duty<0) {red_duty=0;}
    if(green_duty>8191) {green_duty=8191;}
    if(green_duty<0) {green_duty=0;}
    if(blue_duty>8191) {blue_duty=8191;}
    if(blue_duty<0) {blue_duty=0;}

    ledc_set_fade_with_time(ledc_channel[0].speed_mode, ledc_channel[0].channel, red_duty, fade_time);
    ledc_fade_start(ledc_channel[0].speed_mode, ledc_channel[0].channel, LEDC_FADE_NO_WAIT); 

    ledc_set_fade_with_time(ledc_channel[1].speed_mode, ledc_channel[1].channel, green_duty, fade_time);
    ledc_fade_start(ledc_channel[1].speed_mode, ledc_channel[1].channel, LEDC_FADE_NO_WAIT);

    ledc_set_fade_with_time(ledc_channel[2].speed_mode, ledc_channel[2].channel, blue_duty, fade_time);
    ledc_fade_start(ledc_channel[2].speed_mode, ledc_channel[2].channel, LEDC_FADE_NO_WAIT);

}

//灯闪烁任务
static void led_blink_task(void *arg)
{
    ESP_LOGI(TAG, "led blink");
    uint32_t i=0;  
    while(i<blink_parameter.times || blink_parameter.times==0){
        switch (blink_parameter.mode)
        {
            //单色渐变
            case 3: 
                led_rgb_set(0,0,0,0,0);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(blink_parameter.red,blink_parameter.green,blink_parameter.blue,blink_parameter.brightness,blink_parameter.fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));            
                break;
            // 七彩渐变
            case 1:
                led_rgb_set(255,0,0,blink_parameter.brightness,blink_parameter.fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,255,0,blink_parameter.brightness,blink_parameter.fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,0,255,blink_parameter.brightness,blink_parameter.fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(255,255,0,blink_parameter.brightness,blink_parameter.fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,255,255,blink_parameter.brightness,blink_parameter.fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(255,0,255,blink_parameter.brightness,blink_parameter.fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(255,128,0,blink_parameter.brightness,blink_parameter.fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(128,255,0,blink_parameter.brightness,blink_parameter.fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(255,0,128,blink_parameter.brightness,blink_parameter.fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(255,85,0,blink_parameter.brightness,blink_parameter.fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(128,128,255,blink_parameter.brightness,blink_parameter.fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(255,170,0,blink_parameter.brightness,blink_parameter.fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                break;
            // 七彩动感
            case 2:
                //红色
                led_rgb_set(255,0,0,blink_parameter.brightness,fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,0,0,0,0);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                //绿色
                led_rgb_set(0,255,0,blink_parameter.brightness,fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,0,0,0,0);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                //蓝色
                led_rgb_set(0,0,255,blink_parameter.brightness,fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,0,0,0,0);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                //黄色
                led_rgb_set(255,255,0,blink_parameter.brightness,fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,0,0,0,0);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.fade_time));
                //青色
                led_rgb_set(0,255,255,blink_parameter.brightness,fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,0,0,0,0);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                //紫色
                led_rgb_set(255,0,255,blink_parameter.brightness,fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,0,0,0,0);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                //橙色
                led_rgb_set(255,128,0,blink_parameter.brightness,fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,0,0,0,0);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                //黄绿色
                led_rgb_set(128,255,0,blink_parameter.brightness,fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,0,0,0,0);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                //玫红
                led_rgb_set(255,0,128,blink_parameter.brightness,fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,0,0,0,0);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                //朱红
                led_rgb_set(255,85,0,blink_parameter.brightness,fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,0,0,0,0);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                //靛色
                led_rgb_set(128,128,255,blink_parameter.brightness,fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,0,0,0,0);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                //琥珀色
                led_rgb_set(255,170,0,blink_parameter.brightness,fade_time);
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));
                led_rgb_set(0,0,0,0,0);   
                vTaskDelay(pdMS_TO_TICKS(blink_parameter.interval));             
                break;
            default:                
                break;
        }
        vTaskDelay(pdMS_TO_TICKS(100));
        i++;
    }
    if(wifi_status==1)
    {
        led_rgb_set(0,255,0,2,0);
    }else{
        led_rgb_set(255,0,0,2,0);
    }
    vTaskDelete(led_blink_handle); 
}

//灯闪烁配置
static void led_blink_config(uint32_t red,uint32_t green,uint32_t blue, uint32_t brightness,uint32_t fade_time,uint8_t times,uint8_t mode,uint32_t interval){
    blink_parameter.red=red;
    blink_parameter.green=green;
    blink_parameter.blue=blue;
    blink_parameter.brightness=brightness;
    blink_parameter.fade_time=fade_time;
    blink_parameter.times=times;
    blink_parameter.mode=mode;
    blink_parameter.interval=interval;
}


// 设置灯颜色
void led_rgb(uint32_t red,uint32_t green,uint32_t blue, uint32_t brightness,uint32_t fade_time){
    // 删除闪烁任务
    if(led_blink_handle!=NULL){
        state=eTaskGetState(led_blink_handle);
        if(state==eBlocked )
        {
            vTaskDelete(led_blink_handle);
        }
    }  
    led_rgb_set(red,green,blue,brightness,fade_time);
}

//灯闪烁
void led_rgb_blink(uint32_t red,uint32_t green,uint32_t blue, uint32_t brightness,uint32_t fade_time,uint8_t times,uint8_t mode,uint32_t interval)
{
    led_blink_config(red,green,blue,brightness,fade_time,times,mode,interval);
    // 删除灯闪烁任务
    if(led_blink_handle!=NULL){
        state=eTaskGetState(led_blink_handle);
        if(state==eBlocked )
        {
            vTaskDelete(led_blink_handle);
        }
    }  
    xTaskCreate(led_blink_task,"led_blink_task",2048,NULL,10,&led_blink_handle);
}

//根据状态显示颜色(0-未连接，1-已连接)
void led_status(){
    if(CATEGORY!=2){
        // wifi通断器
        if(wifi_status==1)
        {
            led_rgb(0,255,0,2,0);
        }else{
            led_rgb(255,0,0,2,0);
        }
    }else{
        // 智能灯
        if(light_status==1){
            if(light_mode==1 || light_mode==2 || light_mode==3)
            {
                 led_rgb_blink(red,green,blue,brightness,fade_time,0,light_mode,light_interval);
            }else{
                led_rgb(red,green,blue,brightness,fade_time);
                ESP_LOGI(TAG,"red:%d,green:%d,blue:%d,brightness:%d,fade_time:%d",red,green,blue,brightness,fade_time);
            }
        }else{
            // 关灯
            led_rgb(0,0,0,0,0);
        }
    }
}



//led灯启动
void led_start(void)
{
    //初始化电源灯和状态灯
    ledc_timer_config_t ledc_timer = {
        .duty_resolution = LEDC_TIMER_13_BIT,  // PWM占空比分辨率
        .freq_hz = 5000,                       // PWM信号频率
        .speed_mode = LEDC_LOW_SPEED_MODE,     // 计时器模式
        .timer_num = LEDC_TIMER_1,             // 计时器索引
        .clk_cfg = LEDC_AUTO_CLK,              // 自动选择时钟源
    };

    ledc_timer_config(&ledc_timer);
    ledc_channel_config_t channel_0={
        .channel    = LEDC_CHANNEL_0,
        .duty       = 0,
        .gpio_num   = IO_LED_R,
        .speed_mode = LEDC_LOW_SPEED_MODE,
        .hpoint     = 0,
        .timer_sel  = LEDC_TIMER_1
    };
    ledc_channel_config_t channel_1={
        .channel    = LEDC_CHANNEL_1,
        .duty       = 0,
        .gpio_num   = IO_LED_G,
        .speed_mode = LEDC_LOW_SPEED_MODE,
        .hpoint     = 0,
        .timer_sel  = LEDC_TIMER_1
    };       
    ledc_channel_config_t channel_2={
        .channel    = LEDC_CHANNEL_2,
        .duty       = 0,
        .gpio_num   = IO_LED_B,
        .speed_mode = LEDC_LOW_SPEED_MODE,
        .hpoint     = 0,
        .timer_sel  = LEDC_TIMER_1
    };

    ledc_channel[0]=channel_0;    //电源灯-红色
    ledc_channel[1]=channel_1;    //电源灯-绿色
    ledc_channel[2]=channel_2;    //电源灯-蓝色

    ledc_channel_config(&ledc_channel[0]);
    ledc_channel_config(&ledc_channel[1]);
    ledc_channel_config(&ledc_channel[2]);
    ledc_fade_func_install(0);
    led_status();
}