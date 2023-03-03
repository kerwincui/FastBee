#include "common_api.h"
#include "sockets.h"
#include "dns.h"
#include "lwip/ip4_addr.h"
#include "netdb.h"
#include "luat_debug.h"
#include "luat_rtos.h"
#include "luat_mobile.h"

#define DEMO_SERVER_TCP_IP "112.125.89.8"
#define DEMO_SERVER_TCP_PORT 34019

#define DEMO_SERVER_UDP_IP "112.125.89.8"
#define DEMO_SERVER_UDP_PORT 35690

typedef struct
{
	uint8_t is_link_up;
}demo_ctrl_t;

static demo_ctrl_t g_s_demo;


static void demo_tcp_task(void *arg)
{
	ip_addr_t remote_ip;
	char *rxbuf;
    struct sockaddr_in name;
    socklen_t sockaddr_t_size = sizeof(name);
    fd_set write_set, read_set, error_set;
    int ret;
    struct timeval to;
    uint8_t is_connect, is_read;
    int socket_id = -1;
    struct hostent dns_result;
    struct hostent *p_result;
	int h_errnop, read_len;
    while(1)
    {
		while(!g_s_demo.is_link_up)
		{
			luat_rtos_task_sleep(1000);
		}
		char buf[128] = {0};
		ret = lwip_gethostbyname_r(DEMO_SERVER_TCP_IP, &dns_result, buf, 128, &p_result, &h_errnop);
		if (!ret)
		{
			remote_ip = *((ip_addr_t *)dns_result.h_addr_list[0]);
		}
		else
		{
			luat_rtos_task_sleep(1000);
			LUAT_DEBUG_PRINT("dns fail");
			continue;
		}

		socket_id = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    	fcntl(socket_id, F_SETFL, O_NONBLOCK);
		memset(&name, 0, sizeof(name));
		name.sin_family = AF_INET;
		name.sin_addr.s_addr = IPADDR_ANY;
		name.sin_port = 0;
            //LUAT_DEBUG_PRINT("%x", name.sin_addr.s_addr);
        bind(socket_id, (const struct sockaddr *)&name, sockaddr_t_size);
		name.sin_family = AF_INET;
		name.sin_addr.s_addr = remote_ip.u_addr.ip4.addr;
		name.sin_port = htons(DEMO_SERVER_TCP_PORT);
        ret = connect(socket_id, (const struct sockaddr *)&name, sockaddr_t_size);

		to.tv_sec = 30;
		to.tv_usec = 0;
		FD_ZERO(&write_set);
		FD_ZERO(&error_set);
		FD_SET(socket_id,&write_set);
		FD_SET(socket_id,&error_set);
		ret = select(socket_id+1, NULL, &write_set, &error_set, &to);
		if(ret < 0)
		{
			is_connect = 0;
		}
		else if(ret == 0)
		{
			is_connect = 0;
		}
		else
		{
			if(FD_ISSET(socket_id, &error_set))
			{
				is_connect = 0;
			}
			else if(FD_ISSET(socket_id, &write_set))
			{
				is_connect = 1;
			}
		}

		if (is_connect)
		{
			LUAT_DEBUG_PRINT("socket connect ok");
			rxbuf = malloc(1024);
			send(socket_id, "helloworld", 10, 0);
			is_read = 0;
			while(is_connect)
			{
				FD_ZERO(&read_set);
				FD_ZERO(&error_set);
				FD_SET(socket_id,&read_set);
				FD_SET(socket_id,&error_set);
				to.tv_sec = 60;
				to.tv_usec = 0;
				ret = select(socket_id+1, &read_set, NULL, &error_set, &to);
				if(ret < 0)
				{
					is_connect = 0;
				}
				else if(ret == 0)
				{
					is_read = 0;
				}
				else
				{
					if(FD_ISSET(socket_id, &error_set))
					{
						is_connect = 0;
					}
					else if(FD_ISSET(socket_id, &read_set))
					{
						is_read = 1;
					}
				}
				if (is_connect)
				{
					if (is_read)
					{
						do
						{
							read_len = recv(socket_id, rxbuf, 1024, 0);
							if (read_len > 0)
							{
								send(socket_id, rxbuf, read_len, 0);
							}
						}while(read_len > 0);
					}
					else
					{
						send(socket_id, "heart", 5, 0);
					}
				}
			}
			free(rxbuf);
		}
		LUAT_DEBUG_PRINT("socket quit");
		close(socket_id);
		socket_id = -1;
		luat_rtos_task_sleep(5000);
    }
}

static void demo_udp_task(void *arg)
{
	ip_addr_t remote_ip;
	char *rxbuf;
    struct sockaddr_in name;
    struct sockaddr_in from;
    socklen_t from_len;
    socklen_t sockaddr_t_size = sizeof(name);
    fd_set write_set, read_set, error_set;
    int ret;
    struct timeval to;
    uint8_t is_connect, is_read;
    int socket_id = -1;
    struct hostent dns_result;
    struct hostent *p_result;
	int h_errnop, read_len;
    while(1)
    {
		while(!g_s_demo.is_link_up)
		{
			luat_rtos_task_sleep(1000);
		}
		char buf[128] = {0};
		ret = lwip_gethostbyname_r(DEMO_SERVER_UDP_IP, &dns_result, buf, 128, &p_result, &h_errnop);
		if (!ret)
		{
			remote_ip = *((ip_addr_t *)dns_result.h_addr_list[0]);
		}
		else
		{
			luat_rtos_task_sleep(1000);
			LUAT_DEBUG_PRINT("dns fail");
			continue;
		}

		socket_id = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    	fcntl(socket_id, F_SETFL, O_NONBLOCK);
		memset(&name, 0, sizeof(name));
		name.sin_family = AF_INET;
		name.sin_addr.s_addr = IPADDR_ANY;
		name.sin_port = 0;
            //LUAT_DEBUG_PRINT("%x", name.sin_addr.s_addr);
        bind(socket_id, (const struct sockaddr *)&name, sockaddr_t_size);
		name.sin_family = AF_INET;
		name.sin_addr.s_addr = remote_ip.u_addr.ip4.addr;
		name.sin_port = htons(DEMO_SERVER_UDP_PORT);

		is_connect = 1;
		if (is_connect)
		{
			LUAT_DEBUG_PRINT("socket connect ok");
			rxbuf = malloc(1024);
			sendto(socket_id, "helloworld", 10, 0, (const struct sockaddr *)&name, sockaddr_t_size);
			is_read = 0;
			while(is_connect)
			{
				FD_ZERO(&read_set);
				FD_ZERO(&error_set);
				FD_SET(socket_id,&read_set);
				FD_SET(socket_id,&error_set);
				to.tv_sec = 60;
				to.tv_usec = 0;
				ret = select(socket_id+1, &read_set, NULL, &error_set, &to);
				if(ret < 0)
				{
					is_connect = 0;
				}
				else if(ret == 0)
				{
					is_read = 0;
				}
				else
				{
					if(FD_ISSET(socket_id, &error_set))
					{
						is_connect = 0;
					}
					else if(FD_ISSET(socket_id, &read_set))
					{
						is_read = 1;
					}
				}
				if (is_connect)
				{
					if (is_read)
					{
						do
						{
							read_len = recvfrom(socket_id, rxbuf, 1024, 0, &from, &from_len);
							if (read_len > 0)
							{
								sendto(socket_id, rxbuf, read_len, 0, (const struct sockaddr *)&name, sockaddr_t_size);
							}
						}while(read_len > 0);
					}
					else
					{
						sendto(socket_id, "heart", 5, 0, (const struct sockaddr *)&name, sockaddr_t_size);
					}
				}
			}
			free(rxbuf);
		}
		LUAT_DEBUG_PRINT("socket quit");
		close(socket_id);
		socket_id = -1;
		luat_rtos_task_sleep(5000);
    }
}



static void demo_tcp_init(void)
{
	luat_rtos_task_handle tcp_task_handle;
	luat_rtos_task_create(&tcp_task_handle, 2048, 20, "tcp", demo_tcp_task, NULL, NULL);
}

static void demo_udp_init(void)
{
	luat_rtos_task_handle tcp_task_handle;
	luat_rtos_task_create(&tcp_task_handle, 2048, 20, "udp", demo_udp_task, NULL, NULL);
}

static void mobile_event_cb(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status)
{
	switch(event)
	{
	case LUAT_MOBILE_EVENT_CFUN:
		LUAT_DEBUG_PRINT("CFUN消息，status %d", status);
		break;
	case LUAT_MOBILE_EVENT_SIM:
		LUAT_DEBUG_PRINT("SIM卡消息");
		switch(status)
		{
		case LUAT_MOBILE_SIM_READY:
			LUAT_DEBUG_PRINT("SIM卡正常工作");
			break;
		case LUAT_MOBILE_NO_SIM:
			LUAT_DEBUG_PRINT("SIM卡不存在");
			break;
		case LUAT_MOBILE_SIM_NEED_PIN:
			LUAT_DEBUG_PRINT("SIM卡需要输入PIN码");
			break;
		}
		break;
	case LUAT_MOBILE_EVENT_REGISTER_STATUS:
		LUAT_DEBUG_PRINT("移动网络服务状态变更，当前为%d", status);
		break;
	case LUAT_MOBILE_EVENT_CELL_INFO:
		switch(status)
		{
		case LUAT_MOBILE_CELL_INFO_UPDATE:
			break;
		case LUAT_MOBILE_SIGNAL_UPDATE:
			break;
		}
		break;
	case LUAT_MOBILE_EVENT_PDP:
		LUAT_DEBUG_PRINT("CID %d PDP激活状态变更为 %d", index, status);
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
	case LUAT_MOBILE_EVENT_TIME_SYNC:
		LUAT_DEBUG_PRINT("通过移动网络同步了UTC时间");
		break;
	case LUAT_MOBILE_EVENT_CSCON:
		LUAT_DEBUG_PRINT("RRC状态 %d", status);
		break;
	default:
		break;
	}
}

void task_init(void)
{
	luat_mobile_event_register_handler(mobile_event_cb);
}

INIT_HW_EXPORT(task_init, "0");
INIT_TASK_EXPORT(demo_tcp_init, "1");
INIT_TASK_EXPORT(demo_udp_init, "2");
