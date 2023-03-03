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
#include "luat_debug.h"
#include "luat_rtos.h"
#include "luat_mobile.h"
#include "slpman.h"
#include "time.h"
#include "sntp.h"
#include "luat_rtc.h"
typedef struct
{
	uint8_t is_link_up;
	uint8_t ipv4_cid;
} demo_ctrl_t;

static demo_ctrl_t g_s_demo;
luat_rtos_task_handle task_test_ntp_handler,rtc_get_task_handler;
static void mobile_event_cb(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status)
{

	switch (event)
	{
	case LUAT_MOBILE_EVENT_SIM:
		LUAT_DEBUG_PRINT("SIM卡消息，卡槽%d", index);
		switch (status)
		{
		case LUAT_MOBILE_SIM_READY:
			LUAT_DEBUG_PRINT("SIM卡正常工作");
			break;
		case LUAT_MOBILE_NO_SIM:
			LUAT_DEBUG_PRINT("SIM卡不存在");
			break;
		}
		break;
	case LUAT_MOBILE_EVENT_PDP:
		LUAT_DEBUG_PRINT("CID %d PDP激活状态变更为 %d", index, status);
		g_s_demo.ipv4_cid = index;
		break;
	case LUAT_MOBILE_EVENT_NETIF:
		LUAT_DEBUG_PRINT("internet工作状态变更为 %d", status);
		switch (status)
		{
		case LUAT_MOBILE_NETIF_LINK_ON:
			LUAT_DEBUG_PRINT("可以上网");
			g_s_demo.is_link_up = 1;
			break;
		default:
			LUAT_DEBUG_PRINT("不能上网");
			g_s_demo.is_link_up = 0;
			break;
		}
		break;
	default:
		break;
	}
}

static int32_t ntp_callback(void *data, void *param)
{
	sntp_result_t *result = (sntp_result_t *)data;
	// succ 为1 成功 sec时间戳
	LUAT_DEBUG_PRINT("ntp:%d,%d,%d", result->succ, result->sec, result->us);
	if (result->succ)
    {
        time_t _t = result->sec;
        struct tm *tm_gmt = localtime(&_t);
		if (luat_rtc_set(tm_gmt)==0)
		{
			LUAT_DEBUG_PRINT("ntp done");
		}	
    }
	return 0;
}

static void task_test_ntp(void *param)
{
	while (!g_s_demo.is_link_up)
	{
		luat_rtos_task_sleep(1000);
	}
	SntpInit("ntp1.aliyun.com", SNTP_DEFAULT_PORT, 1, g_s_demo.ipv4_cid, ntp_callback, NULL);
	while (1)
	{
		if (g_s_demo.is_link_up)
		{
			SntpInit("ntp1.aliyun.com", SNTP_DEFAULT_PORT, 1, g_s_demo.ipv4_cid, ntp_callback, NULL);
		}
		luat_rtos_task_sleep(20000);
	}

	luat_rtos_task_delete(NULL);
}
static void rtc_get_task_demo(void *param)
{
	struct tm tblock = {0};
	while (1)
	{
		luat_rtc_get(&tblock);
		LUAT_DEBUG_PRINT("%04d/%02d/%02d/ %02d:%02d:%02d %02d", tblock.tm_year + 1900, tblock.tm_mon + 1, tblock.tm_mday, tblock.tm_hour, tblock.tm_min, tblock.tm_sec, tblock.tm_wday);
		luat_rtos_task_sleep(2000);
	}
	luat_rtos_task_delete(NULL);
}
static void task_demo_ntp(void)
{
	luat_rtos_task_create(&task_test_ntp_handler, 4 * 1024, 50, "ntp_demo", task_test_ntp, NULL, NULL);
}
static void mobile_callback_event(void)
{
	luat_mobile_event_register_handler(mobile_event_cb);
}
static void rtc_get_task(void)
{
	luat_rtos_task_create(&rtc_get_task_handler, 4 * 1024, 20, "RTC_GET", rtc_get_task_demo, NULL, NULL);
}
// 启动task_demoF_init，启动位置任务2级
INIT_HW_EXPORT(mobile_callback_event, "0");
INIT_TASK_EXPORT(task_demo_ntp, "1");
INIT_TASK_EXPORT(rtc_get_task, "2");
