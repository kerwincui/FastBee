#include "luat_network_adapter.h"
#include "common_api.h"
#include "luat_rtos.h"

static luat_rtos_task_handle g_s_task_handle;
static network_ctrl_t *g_s_network_ctrl;
static int32_t luat_test_socket_callback(void *pdata, void *param)
{
	OS_EVENT *event = (OS_EVENT *)pdata;
	DBG("%x", event->ID);
	return 0;
}

static void luat_test_task(void *param)
{
	g_s_network_ctrl = network_alloc_ctrl(NW_ADAPTER_INDEX_LWIP_GPRS);
	network_init_ctrl(g_s_network_ctrl, g_s_task_handle, luat_test_socket_callback, NULL);
	network_set_base_mode(g_s_network_ctrl, 1, 15000, 1, 300, 5, 9);
	g_s_network_ctrl->is_debug = 1;
	const char remote_ip[] = "112.125.89.8";
	const char hello[] = "hello, luatos!";
	uint8_t *rx_data = malloc(1024);
	uint32_t tx_len, rx_len;
	int result;
	uint8_t is_break,is_timeout;
	while(1)
	{
		result = network_connect(g_s_network_ctrl, remote_ip, sizeof(remote_ip), NULL, 35948, 30000);
		DBG("%d", result);
		if (!result)
		{
			result = network_tx(g_s_network_ctrl, hello, sizeof(hello), 0, NULL, 0, &tx_len, 15000);
			DBG("%d", result);
			if (!result)
			{
				while(!result)
				{
					result = network_wait_rx(g_s_network_ctrl, 30000, &is_break, &is_timeout);
					DBG("%d", result);
					if (!result)
					{
						if (!is_timeout && !is_break)
						{
							do
							{
								result = network_rx(g_s_network_ctrl, rx_data, 1024, 0, NULL, NULL, &rx_len);
								DBG("%d", result);
								if (rx_len > 0)
								{
									network_tx(g_s_network_ctrl, rx_data, rx_len, 0, NULL, 0, &tx_len, 0);
								}
							}while(!result && rx_len > 0);

						}
					}
				}
			}
		}
		network_close(g_s_network_ctrl, 5000);
		luat_rtos_task_sleep(15000);
	}
}

static void luat_test_init(void)
{
	luat_rtos_task_create(&g_s_task_handle, 2 * 1024, 10, "test", luat_test_task, NULL, 16);
}

//INIT_TASK_EXPORT(luat_test_init, "1");
