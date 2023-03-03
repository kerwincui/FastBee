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

// 本文件为入口函数
// 具体演示在 example_fs_osa.c 和 example_fs_lfs.c

#include "common_api.h"
#include "FreeRTOS.h"
#include "task.h"

extern void exmaple_fs_osa_main(void);
extern void exmaple_fs_lfs_main(void);

static void usb_serial_input_dummy_cb(uint8_t channel, uint8_t *input, uint32_t len)
{
	DBG("usb serial get %dbyte, test mode, send back", len);
	usb_serial_output(channel, input, len);
}

static void hw_demoA_init(void)
{
	DBG("this hw demo1");
	set_usb_serial_input_callback(usb_serial_input_dummy_cb);
}


static void fs_example(void *param)
{
	vTaskDelay(1500);
	exmaple_fs_osa_main();
	vTaskDelay(500);
	exmaple_fs_lfs_main();
	while(1)
	{
		vTaskDelay(1000);
		DBG("fs demo is done");
	}
	vTaskDelete(NULL);
}

static void task_demoE_init(void)
{
	xTaskCreate(fs_example, "", 8*1024, NULL, 20, NULL);
}

// static void task_demoF_init(void)
// {
// 	xTaskCreate(task2, "", 256, NULL, 20, NULL);
// }

//启动hw_demoA_init，启动位置硬件初始1级
INIT_HW_EXPORT(hw_demoA_init, "1");
//启动hw_demoB_init，启动位置硬件初始2级
// INIT_HW_EXPORT(hw_demoB_init, "2");
//启动dr_demoC_init，启动位置驱动1级
// INIT_DRV_EXPORT(dr_demoC_init, "1");
//启动dr_demoD_init，启动位置驱动2级
// INIT_DRV_EXPORT(dr_demoD_init, "2");
//启动task_demoE_init，启动位置任务1级
INIT_TASK_EXPORT(task_demoE_init, "1");
//启动task_demoF_init，启动位置任务2级
// INIT_TASK_EXPORT(task_demoF_init, "2");

