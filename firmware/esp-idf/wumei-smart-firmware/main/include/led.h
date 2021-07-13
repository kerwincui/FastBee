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
#ifndef _LED_H_ 
#define _LED_H_

#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/ledc.h"
#include "esp_err.h"
#include "common.h"

#define LEDC_LS_TIMER          LEDC_TIMER_1
#define LEDC_LS_MODE           LEDC_LOW_SPEED_MODE
#define LEDC_LS_CH0_CHANNEL    LEDC_CHANNEL_0
#define LEDC_LS_CH1_CHANNEL    LEDC_CHANNEL_1
#define LEDC_LS_CH2_CHANNEL    LEDC_CHANNEL_2


// 颜色枚举
typedef enum {
    RED = 0,
    YELLOW,
    GREEN,
    CYAN,
    BLUE,    
    PURPLE,    
    WHITE,
} led_color;

// led灯闪烁的参数
struct led_blink_parameter
{           
    uint32_t red;
    uint32_t green;
    uint32_t blue;
    uint32_t brightness;
    uint8_t times;         //0-无限 
    uint32_t fade_time;    //渐变时间
    uint8_t mode;          //0-固定颜色 1-七彩渐变 2-七彩动感 3-单色渐变 4-白光 5-暖光
    uint32_t interval;     //渐变、动感模式闪烁间隔 毫秒
} blink_parameter;


void led_start(void);
/**
 * @brief 设置灯闪烁
 * 
 * @param red 红色0-255
 * @param green 绿色0-255
 * @param blue 蓝色0-255
 * @param brightness 亮度0-100
 * @param fade_tiime 渐变时间 毫秒
 * @param times 闪烁次数，0-无限次
 * @param mode 模式 0-固定颜色 1-七彩渐变 2-七彩动感 3-单色渐变 4-白光 5-暖光
 * @param interval 渐变、动感模式闪烁间隔 毫秒
 */
void led_rgb_blink(uint32_t red,uint32_t green,uint32_t blue, uint32_t brightness,uint32_t fade_tiime,uint8_t times,uint8_t mode,uint32_t interval);

/**
 * @brief 设置灯颜色
 * 
 * @param red 红色
 * @param green 绿色
 * @param blue 蓝色
 * @param brightness 亮度
 * @param fade_time 渐变时间
 */
void led_rgb(uint32_t red,uint32_t green,uint32_t blue, uint32_t brightness,uint32_t fade_time);

/**
 * @brief 设置led灯实时状态
 * 
 */
void led_status();




#endif
