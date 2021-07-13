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
#ifndef _BUTTON_H_ 
#define _BUTTON_H_


#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_system.h"
#include "nvs_flash.h"
#include "nvs.h"
#include "freertos/queue.h"
#include "freertos/timers.h"
#include <freertos/semphr.h>
#include "driver/gpio.h"
#include "driver/ledc.h"
#include "unity.h"
#include "iot_button.h"
#include "esp_system.h"
#include "esp_log.h"
#include "esp_err.h"

bool is_open;

void button_start(void);
void rf_receiver_start(void);
void radar_start(void);


#endif
