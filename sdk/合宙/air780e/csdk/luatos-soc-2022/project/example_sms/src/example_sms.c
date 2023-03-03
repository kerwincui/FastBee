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

#include "luat_sms.h"

luat_rtos_task_handle task_handle;

extern void luat_sms_proc(uint32_t event, void *param);


static void sms_recv_cb(uint8_t event,void *param)
{
	LUAT_DEBUG_PRINT("event:[%d]", event);
	LUAT_DEBUG_PRINT("Dcs:[%d]", ((LUAT_SMS_RECV_MSG_T*)param)->dcs_info.alpha_bet);
	LUAT_DEBUG_PRINT("Time:[\"%02d/%02d/%02d,%02d:%02d:%02d %c%02d\"]",
                ((LUAT_SMS_RECV_MSG_T*)param)->time.year, ((LUAT_SMS_RECV_MSG_T*)param)->time.month,
                ((LUAT_SMS_RECV_MSG_T*)param)->time.day, ((LUAT_SMS_RECV_MSG_T*)param)->time.hour,
                ((LUAT_SMS_RECV_MSG_T*)param)->time.minute, ((LUAT_SMS_RECV_MSG_T*)param)->time.second,
                ((LUAT_SMS_RECV_MSG_T*)param)->time.tz_sign, ((LUAT_SMS_RECV_MSG_T*)param)->time.tz);
	LUAT_DEBUG_PRINT("Phone:[%s]", ((LUAT_SMS_RECV_MSG_T*)param)->phone_address);
	LUAT_DEBUG_PRINT("ScAddr:[%s]", ((LUAT_SMS_RECV_MSG_T*)param)->sc_address);
	LUAT_DEBUG_PRINT("PDU len:[%d]", ((LUAT_SMS_RECV_MSG_T*)param)->sms_length);
	LUAT_DEBUG_PRINT("PDU: [%s]", ((LUAT_SMS_RECV_MSG_T*)param)->sms_buffer);
}

static void sms_send_cb(int ret)
{
	LUAT_DEBUG_PRINT("send ret:[%d]", ret);
}


static void demo_init_sms()
{
	uint8_t str[] = "abc123@qq.com";
	uint8_t str_pdu[] = "0001000D91688196457286F2000822606D559C53D18D22FF0C00610062003100320033004000710071002E0063006F006D";
	//初始化SMS, 初始化必须在最开始调用
	luat_sms_init();
    luat_sms_recv_msg_register_handler(sms_recv_cb);
    luat_sms_send_msg_register_handler(sms_send_cb);
	//等待注册网络
	luat_rtos_task_sleep(15000);
	//添加自己测试的手机号
	int ret = luat_sms_send_msg(str, "18695427682", false, 0);
	if (ret == 0)
	{
		luat_rtos_task_sleep(1000);
		luat_sms_send_msg(str_pdu, "", true, 54);
	}
}


static void task(void *param)
{
	LUAT_DEBUG_PRINT("==================sms is running==================");
	demo_init_sms();
	while(1)
	{
		luat_rtos_task_sleep(1000);
		LUAT_DEBUG_PRINT("==================sms is done==================");
	}
}


static void task_demoE_init(void)
{
	luat_rtos_task_create(&task_handle, 5*1024, 50, "task", task, NULL, 0);
}

//启动task_demoE_init，启动位置任务1级
INIT_TASK_EXPORT(task_demoE_init, "1");
