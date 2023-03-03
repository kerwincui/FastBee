#include "luat_network_adapter.h"
#include "common_api.h"
#include "luat_rtos.h"
#include "luat_mobile.h"
static luat_rtos_task_handle g_s_task_handle;
static network_ctrl_t *g_s_network_ctrl;
static int32_t luat_test_socket_callback(void *pdata, void *param)
{
	OS_EVENT *event = (OS_EVENT *)pdata;
	DBG("%x", event->ID);
	return 0;
}

static void luatos_mobile_event_callback(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status)
{
	if (LUAT_MOBILE_EVENT_NETIF == event)
	{
		if (LUAT_MOBILE_NETIF_LINK_ON == status)
		{
			ip_addr_t dns_ip[2];
			uint8_t type, dns_num;
			dns_num = 2;
			soc_mobile_get_default_pdp_part_info(&type, NULL, NULL, &dns_num, dns_ip);
			if (dns_num > 0)
			{
				network_set_dns_server(NW_ADAPTER_INDEX_LWIP_GPRS, 2, &dns_ip[0]);
				if (dns_num > 1)
				{
					network_set_dns_server(NW_ADAPTER_INDEX_LWIP_GPRS, 3, &dns_ip[1]);
				}
			}
			net_lwip_set_link_state(NW_ADAPTER_INDEX_LWIP_GPRS, 1);
		}
	}
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
		result = network_connect(g_s_network_ctrl, remote_ip, sizeof(remote_ip), NULL, 36036, 30000);
		if (!result)
		{
			result = network_tx(g_s_network_ctrl, hello, sizeof(hello), 0, NULL, 0, &tx_len, 15000);
			if (!result)
			{
				while(!result)
				{
					result = network_wait_rx(g_s_network_ctrl, 30000, &is_break, &is_timeout);
					if (!result)
					{
						if (!is_timeout && !is_break)
						{
							do
							{
								result = network_rx(g_s_network_ctrl, rx_data, 1024, 0, NULL, NULL, &rx_len);
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
		DBG("网络断开，5秒后重试");
		network_close(g_s_network_ctrl, 5000);
		luat_rtos_task_sleep(15000);
	}
}

static void luat_test_init(void)
{
	luat_mobile_event_register_handler(luatos_mobile_event_callback);
	net_lwip_init();
	net_lwip_register_adapter(NW_ADAPTER_INDEX_LWIP_GPRS);
	network_register_set_default(NW_ADAPTER_INDEX_LWIP_GPRS);
	luat_rtos_task_create(&g_s_task_handle, 2 * 1024, 10, "test", luat_test_task, NULL, 16);
}

INIT_TASK_EXPORT(luat_test_init, "1");
