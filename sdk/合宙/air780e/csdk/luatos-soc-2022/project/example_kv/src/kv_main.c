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
#include "luat_kv.h"

static void kv_demo(void *param)
{
	int ret = 0;
	char value[256];

	luat_rtos_task_sleep(3000);

	LUAT_DEBUG_PRINT("luat_kv demo");

	// 设置一个key-value
	// key 最大长度是   64
	// value 最大长度是 255

	// 设置方式, \0结尾的数据,直接来
	ret = luat_kv_set("my123", "123", strlen("123"));
	LUAT_DEBUG_PRINT("kv_set my123 ret %d", ret);
	memset(value, 0x21, 32);
	ret = luat_kv_set("my456", value, 32);
	LUAT_DEBUG_PRINT("kv_set my456 ret %d", ret);

	// luat_kv_get("my123", value, 255);
	// luat_kv_get("my456", value, 255);

	// 同理, 获取value, kv_kv_get
	ret = luat_kv_get("my123", value, 255); // 注意留一个字节放0x00
	LUAT_DEBUG_PRINT("kv_get ret %d", ret);
	if (ret > 0) {
		value[ret] = 0x00;
		LUAT_DEBUG_PRINT("kv read value %s", value);
		// 写进入的值应该等于写出的值
		if (memcmp("123", value, strlen("123"))) {
			LUAT_DEBUG_PRINT("kv value NOT match");
		}
	}
	else {
		// 前面的逻辑写入字符串"123", 获取时肯定大于0,除非底层出错了
		LUAT_DEBUG_PRINT("kv read failed");
	}

	luat_rtos_task_sleep(1000);
	// 清空整个kv数据, 慎用
	// 这里只是演示有这个API, 并非使用后要调用该API
	//luat_kv_clear();
	
	// 演示结束, task退出.
	while (1) {
		luat_rtos_task_sleep(1000);
	}
}

static void task_demo_kv(void)
{
	
	luat_rtos_task_handle handle;
	luat_rtos_task_create(&handle, 8*1024, 50, "kv", kv_demo, NULL, 0);
}

static void demo_kv_init(void)
{
	int ret = 0;
	ret = luat_kv_init();
	LUAT_DEBUG_PRINT("luat_kv_init ret %d", ret);
}

//启动hw_demoA_init，启动位置硬件初始1级
// INIT_HW_EXPORT(hw_demoA_init, "1");
//启动hw_demoB_init，启动位置硬件初始2级
// INIT_HW_EXPORT(hw_demoB_init, "2");
// 启动dr_demoC_init，启动位置驱动1级
// INIT_DRV_EXPORT(dr_demo_kv_init, "1");
//启动dr_demoD_init，启动位置驱动2级
INIT_DRV_EXPORT(demo_kv_init, "2");
//启动task_demoE_init，启动位置任务1级
// INIT_TASK_EXPORT(task_demoE_init, "1");
//启动task_demoF_init，启动位置任务2级
INIT_TASK_EXPORT(task_demo_kv, "2");

