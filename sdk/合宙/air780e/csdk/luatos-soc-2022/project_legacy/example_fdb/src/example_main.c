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

#include "am_kv.h"

static void fdb_demo(void *param)
{
	int ret = 0;
	char value[256];

	vTaskDelay(3000);

	DBG("am_kv demo");
	

	// 设置一个key-value
	// key 最大长度是 255, 建议不超过64
	// value 最大长度是 4096 - 1

	// 设置方式1, \0结尾的数据,直接来
	ret = am_kv_set("my123", "123", strlen("123"));
	DBG("kv_set my123 ret %d", ret);
	memset(value, 0x21, 32);
	ret = am_kv_set("my456", value, 32);
	DBG("kv_set my456 ret %d", ret);

	// am_kv_get("my123", value, 255);
	// am_kv_get("my456", value, 255);
	
	// 同理, 获取value也有两种, fdb_kv_get 和 fdb_kv_get_blob
	ret = am_kv_get("my123", value, 255); // 注意留一个字节放0x00
	DBG("kv_get ret %d", ret);
	if (ret > 0) {
		value[ret] = 0x00;
		DBG("fdb read value %s", value);
		// 写进入的值应该等于写出的值
		if (memcmp("123", value, strlen("123"))) {
			DBG("fdb value NOT match");
		}
	}
	else {
		// 前面的逻辑写入字符串"123", 获取时肯定大于0,除非底层出错了
		DBG("fdb read failed");
	}

	vTaskDelay(1000);
	// 清空整个fdb数据, 慎用
	// 这里只是演示有这个API, 并非使用后要调用该API
	//am_kv_clear();
	
	// 演示结束, task退出.
	vTaskDelete(NULL);
}

static void task_demo_fdb_init(void)
{
	xTaskCreate(fdb_demo, "fdb", 4*1024, NULL, 20, NULL);
	// xTaskCreate(fdb_demo2, "fdb", 8*1024, NULL, 20, NULL);
}

static void dr_fdb_init(void)
{
	int ret = 0;
	ret = am_kv_init();
	DBG("am_kv_init ret %d", ret);
}

//启动hw_demoA_init，启动位置硬件初始1级
// INIT_HW_EXPORT(hw_demoA_init, "1");
//启动hw_demoB_init，启动位置硬件初始2级
// INIT_HW_EXPORT(hw_demoB_init, "2");
// 启动dr_demoC_init，启动位置驱动1级
// INIT_DRV_EXPORT(dr_demo_fdb_init, "1");
//启动dr_demoD_init，启动位置驱动2级
INIT_DRV_EXPORT(dr_fdb_init, "2");
//启动task_demoE_init，启动位置任务1级
// INIT_TASK_EXPORT(task_demoE_init, "1");
//启动task_demoF_init，启动位置任务2级
INIT_TASK_EXPORT(task_demo_fdb_init, "2");

