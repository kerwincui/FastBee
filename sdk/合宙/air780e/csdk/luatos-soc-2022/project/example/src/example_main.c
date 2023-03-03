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
#include "luat_mem.h"
#include "luat_debug.h"

luat_rtos_task_handle task1_handle;
luat_rtos_task_handle task2_handle;


static void hw_demoA_init(void)
{
	LUAT_DEBUG_PRINT("this hw demo1");
}

static void hw_demoB_init(void)
{
	LUAT_DEBUG_PRINT("this hw demo2");
}

static void dr_demoC_init(void)
{
	LUAT_DEBUG_PRINT("this dr demo1");
}

static void dr_demoD_init(void)
{
	LUAT_DEBUG_PRINT("this dr demo2");
}

static void task1(void *param)
{
	while(1)
	{
		luat_rtos_task_sleep(1000);
		LUAT_DEBUG_PRINT("task1 loop");
	}
}

static void task2(void *param)
{
	while(1)
	{
		luat_rtos_task_sleep(1000);
		LUAT_DEBUG_PRINT("task2 loop");
	}
}

static void task_demoE_init(void)
{
	luat_rtos_task_create(&task1_handle, 2*1024, 50, "task1", task1, NULL, 0);
}

static void task_demoF_init(void)
{
	luat_rtos_task_create(&task2_handle, 2*1024, 50, "task2", task2, NULL, 0);
}

//启动hw_demoA_init，启动位置硬件初始1级
INIT_HW_EXPORT(hw_demoA_init, "1");
//启动hw_demoB_init，启动位置硬件初始2级
INIT_HW_EXPORT(hw_demoB_init, "2");
//启动dr_demoC_init，启动位置驱动1级
INIT_DRV_EXPORT(dr_demoC_init, "1");
//启动dr_demoD_init，启动位置驱动2级
INIT_DRV_EXPORT(dr_demoD_init, "2");
//启动task_demoE_init，启动位置任务1级
INIT_TASK_EXPORT(task_demoE_init, "1");
//启动task_demoF_init，启动位置任务2级
INIT_TASK_EXPORT(task_demoF_init, "2");

