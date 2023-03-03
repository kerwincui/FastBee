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
#include "cms_api.h"
#include "slpman.h"
#include "driver_gpio.h"

//AIR780E+TM8211开发板配置
#define CODEC_PWR_PIN HAL_GPIO_12
#define CODEC_PWR_PIN_ALT_FUN	4
#define PA_PWR_PIN HAL_GPIO_25
#define PA_PWR_PIN_ALT_FUN	0


#define LED2_PIN	HAL_GPIO_24
#define LED2_PIN_ALT_FUN	0
#define LED3_PIN	HAL_GPIO_23
#define LED3_PIN_ALT_FUN	0
#define LED4_PIN	HAL_GPIO_27
#define LED4_PIN_ALT_FUN	0
#define CHARGE_EN_PIN	HAL_GPIO_2
#define CHARGE_EN_PIN_ALT_FUN	0
//AIR600EAC开发板配置


static void usb_serial_input_dummy_cb(uint8_t channel, uint8_t *input, uint32_t len)
{
	DBG("usb serial get %dbyte, test mode, send back", len);
	usb_serial_output(channel, input, len);
}


static void hw_demoA_init(void)
{
	DBG("this hw demo1");
	set_usb_serial_input_callback(usb_serial_input_dummy_cb);
	GPIO_GlobalInit(NULL);
	GPIO_ConfigWithPullEC618(CODEC_PWR_PIN, 0, 0, CODEC_PWR_PIN_ALT_FUN);
	GPIO_ConfigWithPullEC618(PA_PWR_PIN, 0, 0, PA_PWR_PIN_ALT_FUN);
	GPIO_ConfigWithPullEC618(LED2_PIN, 0, 0, LED2_PIN_ALT_FUN);
	GPIO_ConfigWithPullEC618(LED3_PIN, 0, 0, LED3_PIN_ALT_FUN);
	GPIO_ConfigWithPullEC618(LED4_PIN, 0, 0, LED4_PIN_ALT_FUN);
	GPIO_ConfigWithPullEC618(CHARGE_EN_PIN, 0, 0, CHARGE_EN_PIN_ALT_FUN);
}

//启动hw_demoA_init，启动位置硬件初始1级
INIT_HW_EXPORT(hw_demoA_init, "1");

static void demo_task(void *param)
{
	soc_require_lowpower_state(0);
	while(1)
	{
		soc_require_lowpower_state(0);
		vTaskDelay(30000);
		soc_require_lowpower_state(1);
		vTaskDelay(30000);
		soc_require_lowpower_state(2);
		vTaskDelay(30000);
	}
}

static void test_audio_demo_init(void)
{
	xTaskCreate(demo_task, "test", 1024, NULL, 20, NULL);
}

INIT_TASK_EXPORT(test_audio_demo_init, "1");
