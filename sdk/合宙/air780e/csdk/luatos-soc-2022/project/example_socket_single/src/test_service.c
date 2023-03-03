#include "luat_debug.h"
#include "luat_rtos.h"
#include "socket_service.h"

/*
功能模块名称：数据发送和模拟断网测试；

数据发送测试主体逻辑如下：
1、上电开机后，启动一个task，在task内部每隔3秒调用一次socket_service_send_data接口，发送数据"send data from test task"到服务器;
   发送结果通过回调函数send_data_from_task_callback通知本功能模块；
2、上电开机后，启动一个定时器，3秒后调用一次socket_service_send_data接口，发送数据"send data from test timer"到服务器;
   发送结果通过回调函数send_data_from_timer_callback通知本功能模块；之后再启动一个3秒的定时器，发送数据，如此循环；

模拟断网测试主体逻辑如下（此功能默认关闭，如需打开，请参考本文件末尾几行代码注释）：
1、上电开机后，启动一个task，在task内部进入飞行模式5秒后，然后退出飞行模式，30秒后，再进入飞行模式，如此循环；

*/

#define SEND_DATA_FROM_TASK "send data from test task"
#define SEND_DATA_FROM_TIMER "send data from test timer"

static luat_rtos_semaphore_t g_s_send_data_from_task_semaphore_handle;
static luat_rtos_timer_t g_s_send_data_timer;


//result：0成功，1 socket未连接；其余错误值是lwip send接口返回的错误原因值
static void send_data_from_task_callback(int result, uint32_t callback_param)
{
	LUAT_DEBUG_PRINT("async result %d, callback_param %d", result, callback_param);
	luat_rtos_semaphore_release(g_s_send_data_from_task_semaphore_handle);
}

static void test_send_data_task_proc(void *arg)
{
	int result;

	luat_rtos_semaphore_create(&g_s_send_data_from_task_semaphore_handle, 1);

	while (1)
	{
		LUAT_DEBUG_PRINT("send request");

		result = socket_service_send_data(SEND_DATA_FROM_TASK, strlen(SEND_DATA_FROM_TASK), send_data_from_task_callback, 0);

		if (0 == result)
		{
			luat_rtos_semaphore_take(g_s_send_data_from_task_semaphore_handle, LUAT_WAIT_FOREVER);
		}
		else
		{
			LUAT_DEBUG_PRINT("sync result %d", result);
		}		

		luat_rtos_task_sleep(3000);
	}
	
}

static void send_data_timer_callback(void);

//result：0成功，1 socket未连接；其余错误值是lwip send接口返回的错误原因值
static void send_data_from_timer_callback(int result, uint32_t callback_param)
{
	LUAT_DEBUG_PRINT("async result %d, callback_param %d", result, callback_param);
	luat_rtos_timer_start(g_s_send_data_timer, 3000, 0, send_data_timer_callback, NULL);
}

static void send_data_timer_callback(void)
{
	LUAT_DEBUG_PRINT("send request");

	int result = socket_service_send_data(SEND_DATA_FROM_TIMER, strlen(SEND_DATA_FROM_TIMER), send_data_from_timer_callback, 0);

	if (0 != result)
	{
		LUAT_DEBUG_PRINT("sync result %d", result);
		luat_rtos_timer_start(g_s_send_data_timer, 3000, 0, send_data_timer_callback, NULL);
	}
}

static void flymode_task_proc(void *arg)
{
	luat_rtos_task_sleep(5000);
	LUAT_DEBUG_PRINT("entry");
	while (1)
	{
		luat_rtos_task_sleep(30000);
		LUAT_DEBUG_PRINT("enter flymode");
		luat_mobile_set_flymode(0,1);
		luat_rtos_task_sleep(5000);
		luat_mobile_set_flymode(0,0);
		LUAT_DEBUG_PRINT("exit flymode");
	}
}

void test_service_init(void)
{
	luat_rtos_task_handle test_send_data_task_handle;
	luat_rtos_task_create(&test_send_data_task_handle, 2048, 30, "test_send_data", test_send_data_task_proc, NULL, 0);

	luat_rtos_timer_create(&g_s_send_data_timer);
	luat_rtos_timer_start(g_s_send_data_timer, 3000, 0, send_data_timer_callback, NULL);

	// 此task通过不断的进入和退出飞行模式，来模拟断网场景
	// 仅用模拟测试使用，有需要可以自行打开
	// luat_rtos_task_handle flymode_task_handle;
	// luat_rtos_task_create(&flymode_task_handle, 2048, 20, "flymode", flymode_task_proc, NULL, NULL);
}

