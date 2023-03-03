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
#include "luat_rtos.h"
#include "luat_debug.h"
#include "luat_gpio.h"
#include "platform_define.h"

/*
移芯618平台上GPIO使用有如下注意事项：

系统有几种工作模式：ACTIVE、IDLE、SLEEP1、SLEEP2、HIBERNATE，几种模式的区别，参考example_pm的说明；

1、IO分为normal IO和retention/AON IO两种
   normal IO：普通IO
              在ACTIVE和IDLE工作模式下，可以正常控制使用；
			  在SLEEP1、SLEEP2、HIBERNATE工作模式下，IO电源被强制关闭，无法使用；
   retention/AON IO：保持IO
              在ACTIVE和IDLE工作模式下，可以正常控制使用；
			  在SLEEP1、SLEEP2、HIBERNATE工作模式下，只能作为输出使用，而且只能维持一种输出电平状态，无法翻转控制；

2、带AON功能的引脚，做retention/AON IO功能或者其他外设功能使用时，做软件配置上拉无效，只能使用默认的上下拉；

3、系统进入SLEEP1、SLEEP2、HIBERNATE休眠模式后，除了软件运行代码调用唤醒接口可以主动唤醒外，可以唤醒的外部事件有以下几种：
   (1). 配置为wakeup软件功能的wakeup pad引脚；
   (2). low power uart，如果波特率为9600，唤醒时数据也不会丢失，其他波特率会丢失前面的部分数据；
   (3). low power usb
   (4). power key；
   (5). charge pad；
   (6). rtc；
   详情参考example_pm的说明。

4、所有IO都支持中断：
   GPIO20、GPIO21、GPIO22三个IO支持同时配置为双边沿中断或者同时配置为高低电平中断；

   其余GPIO仅支持单边沿、单电平中断；如果这些GPIO配置了双边沿或者双电平中断，则会被系统自动调整配置为上升沿或者高电平中断；
   所以为了防止被系统自动调整配置，其余的这些GPIO，使用中断时仅配置为单边沿或者单电平中断。
*/

//本example基于EVB_Air780E_V1.5硬件

#define NET_LED_PIN HAL_GPIO_27
#define LCD_RST_PIN HAL_GPIO_1

#define LCD_RS_PIN HAL_GPIO_10
#define LCD_CS_PIN HAL_GPIO_8

#define DTR_PIN HAL_GPIO_22
#define LCD_DATA_PIN HAL_GPIO_9

#define DEMO_IRQ_PIN HAL_GPIO_20

//控制NET指示灯闪烁
static void task_gpio_output_run(void *param)
{	
	luat_gpio_cfg_t gpio_cfg;
	luat_gpio_set_default_cfg(&gpio_cfg);

	gpio_cfg.pin = NET_LED_PIN;
	luat_gpio_open(&gpio_cfg);
	while(1)
	{
		luat_gpio_set(NET_LED_PIN, 1);
		LUAT_DEBUG_PRINT("net led on");
		luat_rtos_task_sleep(1000);
		luat_gpio_set(NET_LED_PIN, 0);
		LUAT_DEBUG_PRINT("net led off");
		luat_rtos_task_sleep(1000);
	}	
}

void task_gpio_output_init(void)
{
	luat_rtos_task_handle task_gpio_output_handle;
	luat_rtos_task_create(&task_gpio_output_handle, 4 * 1204, 50, "gpio_output_test", task_gpio_output_run, NULL, 32);
}


//LCD_RST引脚和NET引脚短接
//NET引脚：通过task_gpio_output_run函数每隔一秒翻转一次输出高低电平
//LCD_RST引脚：每隔一秒读取一次输入电平
void task_gpio_input_run(void)
{
	luat_gpio_cfg_t gpio_cfg;
	luat_gpio_set_default_cfg(&gpio_cfg);

	gpio_cfg.pin = LCD_RST_PIN;
	gpio_cfg.mode = LUAT_GPIO_INPUT;
	luat_gpio_open(&gpio_cfg);

	int level = 0;

	while(1)
	{
		level = luat_gpio_get(LCD_RST_PIN);
		LUAT_DEBUG_PRINT("get lcd rst pin %d",level);
		luat_rtos_task_sleep(1000);
		level = luat_gpio_get(LCD_RST_PIN);
		LUAT_DEBUG_PRINT("get lcd rst pin %d",level);
		luat_rtos_task_sleep(1000);
	}
}

void task_gpio_input_init(void)
{
	luat_rtos_task_handle task_gpio_input_handle;
	luat_rtos_task_create(&task_gpio_input_handle, 4 * 1204, 50, "gpio_input_test", task_gpio_input_run, NULL, 32);
}

int single_interrupt_cnt = 0;
int both_interrupt_cnt = 0;
int gpio_irq(int pin, void* args)
{
	if (pin == LCD_CS_PIN)
	{
		single_interrupt_cnt++;
	}
	else if (pin == DTR_PIN)
	{
		both_interrupt_cnt++;
	}	
	
	//注意：中断服务程序中的一行LUAT_DEBUG_PRINT日志，如果通过Luatools查看，最多仅支持64字节
	LUAT_DEBUG_PRINT("pin:%d, level:%d,", pin, luat_gpio_get(pin));
}

//GPIO单边沿中断测试
void task_gpio_single_interrupt_run(void)
{
	luat_gpio_cfg_t gpio_cfg;

	//配置LCD_CS_PIN为中断引脚
	luat_gpio_set_default_cfg(&gpio_cfg);
	gpio_cfg.pin = LCD_CS_PIN;
	gpio_cfg.mode = LUAT_GPIO_IRQ;

	//LCD_CS_PIN引脚仅支持单边沿或者单电平类型的中断；
	//此处仅演示单边沿中断，配置为LUAT_GPIO_RISING_IRQ、LUAT_GPIO_FALLING_IRQ
	//不要配置为LUAT_GPIO_BOTH_IRQ，因为配置为LUAT_GPIO_BOTH_IRQ会被系统自动修改为LUAT_GPIO_RISING_IRQ；
	gpio_cfg.irq_type = LUAT_GPIO_RISING_IRQ; 

	gpio_cfg.pull = LUAT_GPIO_PULLUP;
	gpio_cfg.irq_cb = gpio_irq;	
	luat_gpio_open(&gpio_cfg);

	//配置LCD_RS_PIN为输出引脚
	luat_gpio_set_default_cfg(&gpio_cfg);
	gpio_cfg.pin = LCD_RS_PIN;
	luat_gpio_open(&gpio_cfg);

	while(1)
	{
		luat_gpio_set(LCD_RS_PIN, 1);
		LUAT_DEBUG_PRINT("LCD_RS output %d, LCD_CS input %d",luat_gpio_get(LCD_RS_PIN), luat_gpio_get(LCD_CS_PIN));
		luat_rtos_task_sleep(1000);
		LUAT_DEBUG_PRINT("after high input, number of single interrupts %d", single_interrupt_cnt);

		luat_gpio_set(LCD_RS_PIN, 0);
		LUAT_DEBUG_PRINT("LCD_RS output %d, LCD_CS input %d",luat_gpio_get(LCD_RS_PIN), luat_gpio_get(LCD_CS_PIN));
		luat_rtos_task_sleep(1000);
		LUAT_DEBUG_PRINT("after low input, number of single interrupts %d", single_interrupt_cnt);		
	}	

}

void task_gpio_single_interrupt_init(void)
{
	luat_rtos_task_handle task_gpio_single_interrupt_handle;
	luat_rtos_task_create(&task_gpio_single_interrupt_handle, 4 * 1204, 50, "gpio_single_interrupt_test", task_gpio_single_interrupt_run, NULL, 32);
}


//GPIO双边沿中断测试
void task_gpio_both_interrupt_run(void)
{
	luat_gpio_cfg_t gpio_cfg;

	//配置DTR为中断引脚
	luat_gpio_set_default_cfg(&gpio_cfg);
	gpio_cfg.pin = DTR_PIN;
	gpio_cfg.mode = LUAT_GPIO_IRQ;

	//DTR_PIN引脚支持双边沿或者高低电平类型的中断；
	//此处仅演示双边沿中断，可以配置为LUAT_GPIO_BOTH_IRQ、LUAT_GPIO_RISING_IRQ、LUAT_GPIO_FALLING_IRQ
	gpio_cfg.irq_type = LUAT_GPIO_BOTH_IRQ; 

	gpio_cfg.pull = LUAT_GPIO_PULLUP;
	gpio_cfg.irq_cb = gpio_irq;	
	luat_gpio_open(&gpio_cfg);

	//配置LCD_DATA_PIN为输出引脚
	luat_gpio_set_default_cfg(&gpio_cfg);
	gpio_cfg.pin = LCD_DATA_PIN;
	luat_gpio_open(&gpio_cfg);

	while(1)
	{
		luat_gpio_set(LCD_DATA_PIN, 1);
		LUAT_DEBUG_PRINT("LCD_DATA output %d, DTR input %d",luat_gpio_get(LCD_DATA_PIN), luat_gpio_get(DTR_PIN));
		luat_rtos_task_sleep(1000);
		LUAT_DEBUG_PRINT("after high input, number of both interrupts %d", both_interrupt_cnt);

		luat_gpio_set(LCD_DATA_PIN, 0);
		LUAT_DEBUG_PRINT("LCD_DATA output %d, DTR input %d",luat_gpio_get(LCD_DATA_PIN), luat_gpio_get(DTR_PIN));
		luat_rtos_task_sleep(1000);
		LUAT_DEBUG_PRINT("after low input, number of both interrupts %d", both_interrupt_cnt);		
	}	

}

void task_gpio_both_interrupt_init(void)
{
	luat_rtos_task_handle task_gpio_both_interrupt_handle;
	luat_rtos_task_create(&task_gpio_both_interrupt_handle, 4 * 1204, 50, "gpio_both_interrupt_test", task_gpio_both_interrupt_run, NULL, 32);
}
int gpio_level_irq(void *data, void* args)
{
	int pin = (int)data;
	LUAT_DEBUG_PRINT("pin:%d, level:%d,", pin, luat_gpio_get(pin));
	luat_gpio_ctrl(DEMO_IRQ_PIN, LUAT_GPIO_CMD_SET_IRQ_MODE, LUAT_GPIO_NO_IRQ);
}
//GPIO电平中断测试
void task_gpio_level_interrupt_run(void)
{
	luat_gpio_cfg_t gpio_cfg;

	//配置HAL_GPIO_20为中断引脚
	luat_gpio_set_default_cfg(&gpio_cfg);
	gpio_cfg.pin = DEMO_IRQ_PIN;
	gpio_cfg.mode = LUAT_GPIO_IRQ;

	//DTR_PIN引脚支持双边沿或者高低电平类型的中断；
	//所以此处可以配置为LUAT_GPIO_BOTH_IRQ、LUAT_GPIO_RISING_IRQ、LUAT_GPIO_FALLING_IRQ、LUAT_GPIO_HIGH_IRQ、LUAT_GPIO_LOW_IRQ、
	gpio_cfg.irq_type = LUAT_GPIO_HIGH_IRQ;

	gpio_cfg.pull = LUAT_GPIO_PULLUP;
	gpio_cfg.irq_cb = gpio_level_irq;
	luat_gpio_open(&gpio_cfg);

	while(1)
	{
		if (!luat_gpio_get(DEMO_IRQ_PIN))
		{
			LUAT_DEBUG_PRINT("IO已经低电平，可以再次开启高电平中断");
			luat_gpio_ctrl(DEMO_IRQ_PIN, LUAT_GPIO_CMD_SET_IRQ_MODE, LUAT_GPIO_HIGH_IRQ);
		}
		luat_rtos_task_sleep(1000);

	}

}

void task_gpio_level_interrupt_init(void)
{
	luat_rtos_task_handle task_gpio_level_interrupt_handle;
	luat_rtos_task_create(&task_gpio_level_interrupt_handle, 1024, 50, "gpio_level_interrupt_test", task_gpio_level_interrupt_run, NULL, 0);
}



INIT_TASK_EXPORT(task_gpio_output_init, "0");
INIT_TASK_EXPORT(task_gpio_input_init, "1");
INIT_TASK_EXPORT(task_gpio_single_interrupt_init, "2");
INIT_TASK_EXPORT(task_gpio_both_interrupt_init, "3");
INIT_TASK_EXPORT(task_gpio_level_interrupt_init, "4");
