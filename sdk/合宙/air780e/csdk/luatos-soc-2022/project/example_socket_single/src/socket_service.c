#include "sockets.h"
#include "dns.h"
#include "lwip/ip4_addr.h"
#include "netdb.h"
#include "luat_debug.h"
#include "luat_rtos.h"
#include "luat_mem.h"
#include "network_service.h"
#include "socket_service.h"

/*
功能模块名称：socket长连接、数据收发框架；
主体业务逻辑为：
1、上电开机后，启动一个task，等待network_service功能模块中检测到IP网络准备就绪；
   然后通过tcp去连接地址为REMOTE_SERVER_ADDRESS、端口为g_s_remote_server_port的服务器；
2、服务器连接成功后，创建一个数据发送的task，tcp_send_task_proc；
   在这个task中，从存储待发送数据的队列中读取每条数据，依次发送到服务器；
3、服务器连接成功后，创建一个数据接收的task，tcp_recv_task_proc；
   在这个task中，使用select机制监听可读和异常事件；
4、在数据发送和数据接收的task中，出现任何异常，都会主动断开socket连接，5秒钟之后，再去重连

用户如果没有自己的测试服务器，可以访问https://netlab.luatos.com/，打开一个TCP服务，TCP服务的端口号随机分配；
端口号确定好之后，直接修改本文件中的g_s_remote_server_port变量值；
也可以不修改，直接烧录本example，设备运行起来之后，通过usb_service功能模块，和PC端串口工具通信，来动态修改端口号
*/

typedef struct socket_service_send_data
{
    char *data;
    uint32_t len;
    socket_service_send_data_callback_t callback_func;
    uint32_t callback_param;
}socket_service_send_data_t;



#define REMOTE_SERVER_ADDRESS "112.125.89.8"
// #define REMOTE_SERVER_PORT 34410
static int g_s_remote_server_port = 37954;

static luat_rtos_task_handle g_s_tcp_connect_task_handle, g_s_tcp_send_task_handle, g_s_tcp_recv_task_handle;
static luat_rtos_semaphore_t g_s_connect_ok_semaphore;

//socket id、连接状态、连接task存在状态
static int g_s_socket_id = -1;
static uint8_t g_s_is_connected = 0;
static uint8_t g_s_is_tcp_connect_task_exist = 0;



//socket数据发送task mailbox长度
#define TCP_SEND_TASK_MAILBOX_EVENT_MAX_SIZE 50


void socket_service_set_remote_port(int port)
{
	g_s_remote_server_port = port;
}


static void close_socket(void)
{
	LUAT_DEBUG_PRINT("enter");
	close(g_s_socket_id);
	g_s_socket_id = -1;
	g_s_is_connected = 0;
}


#define RECV_BUF_LEN 1024

static void tcp_recv_task_proc(void *arg)
{	
	fd_set read_set, error_set;
	struct timeval timeout;
	int ret, read_len;
	char * recv_buf = NULL;

	LUAT_DEBUG_PRINT("enter");

	while(1)
	{
		if(g_s_is_connected)
		{
			luat_rtos_semaphore_take(g_s_connect_ok_semaphore, LUAT_NO_WAIT);

			if(NULL == recv_buf)
			{
				recv_buf = (char *)LUAT_MEM_MALLOC(RECV_BUF_LEN);
				LUAT_DEBUG_ASSERT(recv_buf != NULL,"malloc recv_buf fail");
			}

			timeout.tv_sec = 60;
			timeout.tv_usec = 0;

			while(1)
			{
				FD_ZERO(&read_set);
				FD_ZERO(&error_set);
				FD_SET(g_s_socket_id,&read_set);
				FD_SET(g_s_socket_id,&error_set);

				LUAT_DEBUG_PRINT("before select");

				ret = select(g_s_socket_id+1, &read_set, NULL, &error_set, &timeout);

				if(ret < 0)
				{
					//失败
					LUAT_DEBUG_PRINT("select fail, ret %d",ret);
					break;
				}
				else if(ret == 0)
				{
					//超时
					LUAT_DEBUG_PRINT("select timeout");
				}
				else
				{
					if(FD_ISSET(g_s_socket_id, &error_set))
					{
						//出错
						LUAT_DEBUG_PRINT("select error event");
						break;
					}
					else if(FD_ISSET(g_s_socket_id, &read_set))
					{
						LUAT_DEBUG_PRINT("select read event");
						read_len = recv(g_s_socket_id, recv_buf, RECV_BUF_LEN, 0);
						//read event后，第一次读不到数据，表示出错
						//实测，在select时，服务器主动断开连接，会走到这里
						if(read_len <= 0)
						{
							LUAT_DEBUG_PRINT("select read event error");
							break;
						}
						else
						{
							do
							{
								LUAT_DEBUG_PRINT("recv %d bytes data from server",read_len);
								if(read_len > 0)
								{
									//读到了数据，在recv_buf中，长度为read_len
								}

								read_len = recv(g_s_socket_id, recv_buf, RECV_BUF_LEN, 0);
							}while(read_len > 0);
						}					

					}
					else
					{
						LUAT_DEBUG_PRINT("select other socket event");
					}
				}
			}

			close_socket();			

			luat_rtos_task_sleep(5000);
			socket_service_init();					
		}
		else
		{
			//等待connect ok
			LUAT_DEBUG_PRINT("wait connect ok semaphore");
			luat_rtos_semaphore_take(g_s_connect_ok_semaphore, 1000);
		}
	}
	
}

//同步插入队列结果通过返回值判断：0成功，其他失败
//插入成功后，异步发送结果通过callback_func(int result, void *callback_param)中的result判断：0成功，其他失败
int socket_service_send_data(const char *data, uint32_t len, socket_service_send_data_callback_t callback_func, uint32_t callback_param)
{
	if(data==NULL || len==0)
	{
		return -1;
	}
	socket_service_send_data_t *data_item = (socket_service_send_data_t *)LUAT_MEM_MALLOC(sizeof(socket_service_send_data_t));
	LUAT_DEBUG_ASSERT(data_item != NULL,"malloc data_item fail");;

	data_item->data = LUAT_MEM_MALLOC(len);
	LUAT_DEBUG_ASSERT(data_item->data != NULL, "malloc data_item.data fail");
	memcpy(data_item->data, data, len);
	data_item->len = len;
	data_item->callback_func = callback_func;
	data_item->callback_param = callback_param;

	int ret = luat_rtos_message_send(g_s_tcp_send_task_handle, 0, data_item);

	if(ret != 0)
	{
		LUAT_MEM_FREE(data_item->data);
		data_item->data = NULL;
		LUAT_MEM_FREE(data_item);
		data_item = NULL;
	}

	return ret;
}

static void tcp_send_task_proc(void *arg)
{
	uint32_t message_id;
	socket_service_send_data_t *data_item;
	int ret = -1;
	uint32_t sent_len = 0;

	while(1)
	{
		if(luat_rtos_message_recv(g_s_tcp_send_task_handle, &message_id, (void **)&data_item, LUAT_WAIT_FOREVER) == 0)
		{
			if(g_s_is_connected)
			{
				sent_len = 0;
				// LUAT_DEBUG_PRINT("total len %d, sent len %d", data_item->len, sent_len);
				while (sent_len < data_item->len)
				{
					ret = send(g_s_socket_id, data_item->data+sent_len, data_item->len-sent_len, 0);
					if (ret >= 0)
					{
						LUAT_DEBUG_PRINT("send %d bytes", ret);
						sent_len += ret;
						if (sent_len >= data_item->len)
						{
							if(data_item->callback_func)
							{
								data_item->callback_func(0, data_item->callback_param);
							}
						}						
					}
					else
					{
						if (errno == EWOULDBLOCK)
						{
							LUAT_DEBUG_PRINT("block, wait send buffer ok");
							luat_rtos_task_sleep(1000);
						}
						else
						{
							close_socket();
							if(data_item->callback_func)
							{
								data_item->callback_func(ret, data_item->callback_param);
							}
							luat_rtos_task_sleep(5000);
							socket_service_init();

							break;
						}
					}					
				}				
			}
			else
			{
				if(data_item->callback_func)
				{
					data_item->callback_func(1, data_item->callback_param);
				}
			}

			LUAT_MEM_FREE(data_item->data);
			data_item->data = NULL;
			LUAT_MEM_FREE(data_item);
			data_item = NULL;
		}
	}
}


static void tcp_connect_task_proc(void *arg)
{
	ip_addr_t remote_ip;
    struct sockaddr_in name;
    socklen_t sockaddr_t_size = sizeof(name);
    int ret, h_errnop;
    struct hostent dns_result;
    struct hostent *p_result;

	LUAT_DEBUG_PRINT("enter");

	while(1)
    {
		//检查网络是否准备就绪，如果尚未就绪，等待1秒后循环重试
		while(!network_service_is_ready())
		{
			LUAT_DEBUG_PRINT("wait network_service_is_ready");
			luat_rtos_task_sleep(1000);
		}

		//执行DNS，如果失败，等待1秒后，返回检查网络逻辑，重试
		char buf[128] = {0};
		ret = lwip_gethostbyname_r(REMOTE_SERVER_ADDRESS, &dns_result, buf, sizeof(buf), &p_result, &h_errnop);
		if(ret == 0)
		{
			remote_ip = *((ip_addr_t *)dns_result.h_addr_list[0]);
		}
		else
		{
			luat_rtos_task_sleep(1000);
			LUAT_DEBUG_PRINT("dns fail");
			continue;
		}

		//创建套接字，如果创建失败，等待3秒后循环重试
		g_s_socket_id = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
		while(g_s_socket_id < 0)
		{
			LUAT_DEBUG_PRINT("create socket fail");
			luat_rtos_task_sleep(3000);
		}
		
		//连接服务器，如果失败，关闭套接字，等待5秒后，返回检查网络逻辑，重试
		name.sin_family = AF_INET;
		name.sin_addr.s_addr = remote_ip.u_addr.ip4.addr;
		name.sin_port = htons(g_s_remote_server_port);
        ret = connect(g_s_socket_id, (const struct sockaddr *)&name, sockaddr_t_size);
		if(ret < 0)
		{
			LUAT_DEBUG_PRINT("connect fail, ret %d",ret);
			close_socket();
			luat_rtos_task_sleep(5000);
			continue;
		}
		LUAT_DEBUG_PRINT("connect ok");
		g_s_is_connected = 1;
		
		fcntl(g_s_socket_id, F_SETFL, O_NONBLOCK);		

		if (NULL == g_s_connect_ok_semaphore)
		{
			luat_rtos_semaphore_create(&g_s_connect_ok_semaphore, 1);
		}
		luat_rtos_semaphore_release(g_s_connect_ok_semaphore);
		   

		if(g_s_tcp_send_task_handle == NULL)
		{
			luat_rtos_task_create(&g_s_tcp_send_task_handle, 2048, 20, "tcp_send", tcp_send_task_proc, NULL, TCP_SEND_TASK_MAILBOX_EVENT_MAX_SIZE);
		}
		if(g_s_tcp_recv_task_handle == NULL)
		{
			luat_rtos_task_create(&g_s_tcp_recv_task_handle, 2048, 20, "tcp_recv", tcp_recv_task_proc, NULL, 0);
		}			

		break;				
    }

	// 打印出来该任务自启动起来最小剩余栈空间大小
	//然后我们就可以计算出最大使用的大小，一般可以再乘以1.5左右作为最终分配的值，必须是4的倍数
	// LUAT_DEBUG_PRINT("before luat_rtos_task_delete, %d", luat_rtos_task_get_high_water_mark());

	LUAT_DEBUG_PRINT("exit");
	g_s_is_tcp_connect_task_exist = 0;
	luat_rtos_task_delete(g_s_tcp_connect_task_handle);	
}


void socket_service_init(void)
{
	if(!g_s_is_tcp_connect_task_exist)
	{
		g_s_is_tcp_connect_task_exist = (luat_rtos_task_create(&g_s_tcp_connect_task_handle, 2560, 30, "tcp_connect", tcp_connect_task_proc, NULL, 0)==0);
	}	
}


