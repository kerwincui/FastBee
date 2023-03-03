#ifndef _NET_LED_TASK_H
#define _NET_LED_TASK_H



#include "common_api.h"
#include "luat_debug.h"
#include "luat_rtos.h"
#include "luat_gpio.h"
#include "luat_mobile.h"
#include "FreeRTOS.h"
#include "queue.h"

#define NET_LED_PIN HAL_GPIO_27


void Task_netinfo_call(void);

void NET_LED_Task(void);




#endif