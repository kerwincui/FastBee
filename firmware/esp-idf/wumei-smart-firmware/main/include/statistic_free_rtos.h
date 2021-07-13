/************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ************************************************************************/
#ifndef _STATISTIC_FREE_RTOS_H_ 
#define _STATISTIC_FREE_RTOS_H_


#include <stdio.h>
#include <stdlib.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/semphr.h"
#include "esp_err.h"

#define NUM_OF_SPIN_TASKS   6
#define SPIN_ITER           500000               //实际使用的CPU周期取决于编译器优化
#define SPIN_TASK_PRIO      2
#define STATS_TASK_PRIO     3
#define STATS_TICKS         pdMS_TO_TICKS(1000)
#define ARRAY_SIZE_OFFSET   5                    //如果print_real_time返回ESP_ERR_INVALID_SIZE则增加此值

void free_rtos_start(void);


#endif
