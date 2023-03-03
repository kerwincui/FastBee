/*
 * Copyright (c) 2022 OpenLuat & AirM2M
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


#include "common_api.h"
#include "FreeRTOS.h"
#include "task.h"
#include "timer.h"
#include "bsp.h"


#define TIMER_INSTANCE                   (1)

/** \brief TIMER clock id for clock configuration */
#define TIMER_CLOCK_ID                   (FCLK_TIMER1)

/** \brief TIMER clock source select */
#define TIMER_CLOCK_SOURCE               (FCLK_TIMER1_SEL_26M)

/** \brief TIMER instance IRQ number */
#define TIMER_INSTANCE_IRQ               (PXIC0_TIMER1_IRQn)


/// @brief 定时器中断服务函数
void Timer_ISR()
{
    if (TIMER_getInterruptFlags(TIMER_INSTANCE) & TIMER_MATCH0_INTERRUPT_FLAG)
    {
        DBG("timer demo interrupt is running");
        TIMER_clearInterruptFlags(TIMER_INSTANCE, TIMER_MATCH0_INTERRUPT_FLAG);
    }
}
static void Timer_Init(void *param)
{
	TIMER_driverInit();//定时器内部初始化
	CLOCK_setClockSrc(TIMER_CLOCK_ID, TIMER_CLOCK_SOURCE);//选择定时器时钟来源
    CLOCK_setClockDiv(TIMER_CLOCK_ID, 1);//设置时钟分频
	TimerConfig_t timer1_config;
	TIMER_getDefaultConfig(&timer1_config);
	timer1_config.reloadOption=TIMER_RELOAD_ON_MATCH0;//重装通道选项 可以选择MATCH0，MATCH1，MATCH2
	timer1_config.match0=0xc65d40;//重装值 500ms ,定时器频率为26MHZ，13000000=0xc65d40
	TIMER_init(TIMER_INSTANCE, &timer1_config);
	TIMER_interruptConfig(TIMER_INSTANCE, TIMER_MATCH0_SELECT, TIMER_INTERRUPT_LEVEL);//中断配置
    TIMER_interruptConfig(TIMER_INSTANCE, TIMER_MATCH1_SELECT, TIMER_INTERRUPT_DISABLED);
    TIMER_interruptConfig(TIMER_INSTANCE, TIMER_MATCH2_SELECT, TIMER_INTERRUPT_DISABLED);
	XIC_SetVector(TIMER_INSTANCE_IRQ, Timer_ISR);
    XIC_EnableIRQ(TIMER_INSTANCE_IRQ);
	TIMER_start(TIMER_INSTANCE);
	while (1)
	{
		DBG("timer demo is running");
		vTaskDelay(500);
	}
	
}

void Timer_task_init(void)
{
	xTaskCreate(Timer_Init,"timer_demo",1*1024,NULL,3,NULL);
}

INIT_TASK_EXPORT(Timer_task_init,"1");
