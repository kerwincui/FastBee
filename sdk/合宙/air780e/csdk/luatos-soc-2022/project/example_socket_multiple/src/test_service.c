#include "luat_debug.h"
#include "luat_rtos.h"
#include "socket_service.h"


typedef enum
{
	DEV_LOGIN,
	DEV_HEART,
}DEV_PACKET_E;

static luat_rtos_timer_t g_s_socket0_send_heart_timer;

static void socket0_send_heart_timer_callback(void)
{
	LUAT_DEBUG_PRINT("send request");

	int result = socket_send(0, 13, "socket0 heart", DEV_HEART);

	if (0 != result)
	{
		LUAT_DEBUG_PRINT("sync result %d", result);
		luat_rtos_timer_start(g_s_socket0_send_heart_timer, 3000, 0, socket0_send_heart_timer_callback, NULL);
	}
}

static void socket0_send_heart()
{
	if (g_s_socket0_send_heart_timer)
	{
		luat_rtos_timer_delete(g_s_socket0_send_heart_timer);
	}
	
	luat_rtos_timer_create(&g_s_socket0_send_heart_timer);
	luat_rtos_timer_start(g_s_socket0_send_heart_timer, 3000, 0, socket0_send_heart_timer_callback, NULL);
}


static void socket0_event_callback(int app_id, SOCKET_EVENT_E event, socket_event_param_t param)
{
	LUAT_DEBUG_PRINT("[app_id %d]: %d", app_id, event);

	switch (event)
	{
	case SOCKET_EVENT_CONNECT:
		if (param.connect_result >= 0)
		{
			LUAT_DEBUG_PRINT("[app_id %d]: connect ok", app_id);
			socket_send(app_id, 13, "socket0 login", DEV_LOGIN);
		}
		else
		{
			LUAT_DEBUG_PRINT("[app_id %d]: connect fail, result %d", param.connect_result);
		}
		break;
	
	case SOCKET_EVENT_SEND:
		if (DEV_LOGIN == param.send_cnf_t.user_param)
		{
			LUAT_DEBUG_PRINT("[app_id %d]: send DEV_LOGIN %s", app_id, (param.send_cnf_t.result > 0) ? "OK" : "FAIL");

			if (param.send_cnf_t.result > 0)
			{
				socket0_send_heart();
			}
			else
			{

			}
		}
		else if (DEV_HEART == param.send_cnf_t.user_param)
		{
			LUAT_DEBUG_PRINT("[app_id %d]: send DEV_HEART %s", app_id, (param.send_cnf_t.result > 0) ? "OK" : "FAIL");

			if (param.send_cnf_t.result > 0)
			{
				socket0_send_heart();
			}
			else
			{

			}
		}
		else
		{
			/* code */
		}	
		
		break;

	case SOCKET_EVENT_RECEIVE:
		LUAT_DEBUG_PRINT("[app_id %d]: receive data len %d", app_id, param.recv_ind_t.len);
		break;

	default:
		break;
	}	
}


static luat_rtos_task_handle g_s_socket1_send_heart_task_handle;
static luat_rtos_semaphore_t g_s_socket1_send_heart_semaphore_handle;


static void socket1_send_heart_task_proc(void *arg)
{
	int result;

	luat_rtos_semaphore_create(&g_s_socket1_send_heart_semaphore_handle, 1);

	while (1)
	{
		LUAT_DEBUG_PRINT("send request");

		result = socket_send(1, 13, "socket1 heart", DEV_HEART);

		if (0 == result)
		{
			luat_rtos_semaphore_take(g_s_socket1_send_heart_semaphore_handle, LUAT_WAIT_FOREVER);
		}
		else
		{
			LUAT_DEBUG_PRINT("sync result %d", result);
		}		

		luat_rtos_task_sleep(3000);
	}
	
}

static void socket1_send_heart()
{
	if (!g_s_socket1_send_heart_task_handle)
	{
		luat_rtos_task_create(&g_s_socket1_send_heart_task_handle, 2048, 30, "socket1_send_heart", socket1_send_heart_task_proc, NULL, 0);
	}
}


static void socket1_event_callback(int app_id, SOCKET_EVENT_E event, socket_event_param_t param)
{
	LUAT_DEBUG_PRINT("[app_id %d]: %d", app_id, event);

	switch (event)
	{
	case SOCKET_EVENT_CONNECT:
		if (param.connect_result >= 0)
		{
			LUAT_DEBUG_PRINT("[app_id %d]: connect ok", app_id);
			socket_send(app_id, 13, "socket1 login", DEV_LOGIN);
		}
		else
		{
			LUAT_DEBUG_PRINT("[app_id %d]: connect fail, result %d", param.connect_result);
		}
		break;
	
	case SOCKET_EVENT_SEND:
		if (DEV_LOGIN == param.send_cnf_t.user_param)
		{
			LUAT_DEBUG_PRINT("[app_id %d]: send DEV_LOGIN %s", app_id, (param.send_cnf_t.result > 0) ? "OK" : "FAIL");

			if (param.send_cnf_t.result > 0)
			{
				socket1_send_heart();
			}
			else
			{

			}
		}
		else if (DEV_HEART == param.send_cnf_t.user_param)
		{
			LUAT_DEBUG_PRINT("[app_id %d]: send DEV_HEART %s", app_id, (param.send_cnf_t.result > 0) ? "OK" : "FAIL");

			luat_rtos_semaphore_release(g_s_socket1_send_heart_semaphore_handle);
		}
		else
		{
			/* code */
		}	
		
		break;

	case SOCKET_EVENT_RECEIVE:
		LUAT_DEBUG_PRINT("[app_id %d]: receive data len %d", app_id, param.recv_ind_t.len);
		break;

	default:
		break;
	}	
}

void test_service_init(void)
{
	socket_connect(0, 0, "112.125.89.8", 35894, socket0_event_callback);
	socket_connect(1, 0, "112.125.89.8", 33080, socket1_event_callback);
}

