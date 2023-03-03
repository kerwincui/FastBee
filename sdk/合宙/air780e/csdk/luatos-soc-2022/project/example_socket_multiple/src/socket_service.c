#include "sockets.h"
#include "dns.h"
#include "lwip/ip4_addr.h"
#include "netdb.h"
#include "luat_debug.h"
#include "luat_rtos.h"
#include "luat_mem.h"
#include "network_service.h"
#include "socket_service.h"


#define LUAT_SOCKET_SERVICE_PRINT(X, Y...) LUAT_DEBUG_PRINT("[app_id %d]: "X, app_id, ##Y)

#define SOCKET_CALLBACK(evt, param); do {  \
										{ \
											if(g_s_sockets[app_id].callback) \
											{ \
												g_s_sockets[app_id].callback(app_id, evt, param); \
											}\
										} \
									} while(0) 

#define USER_SOCKET_MAX_COUNT 6
//socket数据发送task mailbox长度
#define SEND_TASK_MAILBOX_EVENT_MAX_SIZE 50

typedef struct socket_item_info
{
	int app_id;
	int socket_id;
	int protocol; //0:tcp 1:udp
	char *address;
	int port;
	int is_connected;
	int connect_task_exist;
	socket_service_event_callback_t callback;
	luat_rtos_task_handle connect_task_handle;
	luat_rtos_task_handle send_task_handle;
	luat_rtos_task_handle recv_task_handle;
	luat_rtos_semaphore_t connect_ok_semaphore;
}socket_item_info_t;

typedef struct socket_send_data
{
    char *data;
    uint32_t len;
    int user_param;
}socket_send_data_t;


static socket_item_info_t g_s_sockets[USER_SOCKET_MAX_COUNT];

static int socket_exist(int id) 
{
    return (id >= 0 && id < USER_SOCKET_MAX_COUNT) ? 1 : 0;
}

static void close_socket(int app_id)
{
	LUAT_SOCKET_SERVICE_PRINT("enter");
	close(g_s_sockets[app_id].socket_id);
	g_s_sockets[app_id].socket_id = -1;
	g_s_sockets[app_id].is_connected = 0;
}

static void reconnect_socket(int app_id)
{
	socket_connect(app_id, 
		g_s_sockets[app_id].protocol, 
		g_s_sockets[app_id].address, 
		g_s_sockets[app_id].port, 
		g_s_sockets[app_id].callback);
}

static void send_task_proc(void *arg)
{
	uint32_t message_id;
	socket_send_data_t *data_item;
	int ret = -1;
	uint32_t sent_len = 0;
	int app_id = *(int*)(arg);
	socket_event_param_t event_param;

	while(1)
	{
		if(luat_rtos_message_recv(g_s_sockets[app_id].send_task_handle, &message_id, (void **)&data_item, LUAT_WAIT_FOREVER) == 0)
		{
			if(g_s_sockets[app_id].is_connected)
			{
				sent_len = 0;
				// LUAT_SOCKET_SERVICE_PRINT("total len %d, sent len %d", data_item->len, sent_len);
				while (sent_len < data_item->len)
				{
					ret = send(g_s_sockets[app_id].socket_id, data_item->data+sent_len, data_item->len-sent_len, 0);
					if (ret >= 0)
					{
						LUAT_SOCKET_SERVICE_PRINT("send %d bytes", ret);
						sent_len += ret;
						if (sent_len >= data_item->len)
						{
							event_param.send_cnf_t.result = sent_len;
							event_param.send_cnf_t.user_param = data_item->user_param;
							SOCKET_CALLBACK(SOCKET_EVENT_SEND, event_param);
						}						
					}
					else
					{
						if (errno == EWOULDBLOCK)
						{
							LUAT_SOCKET_SERVICE_PRINT("block, wait send buffer ok");
							luat_rtos_task_sleep(1000);
						}
						else
						{
							close_socket(app_id);

							event_param.send_cnf_t.result = ret;
							event_param.send_cnf_t.user_param = data_item->user_param;
							SOCKET_CALLBACK(SOCKET_EVENT_SEND, event_param);

							luat_rtos_task_sleep(5000);
							reconnect_socket(app_id);

							break;
						}
					}					
				}				
			}
			else
			{
				event_param.send_cnf_t.result = ret;
				event_param.send_cnf_t.user_param = data_item->user_param;
				SOCKET_CALLBACK(SOCKET_EVENT_SEND, event_param);
			}

			LUAT_MEM_FREE(data_item->data);
			data_item->data = NULL;
			LUAT_MEM_FREE(data_item);

			data_item = NULL;
		}
	}
}


#define RECV_BUF_LEN 1024

static void recv_task_proc(void *arg)
{	
	fd_set read_set, error_set;
	struct timeval timeout;
	int ret, read_len;
	char * recv_buf = NULL;
	int app_id = *(int*)(arg);
	socket_event_param_t event_param;

	LUAT_SOCKET_SERVICE_PRINT("enter");

	while(1)
	{
		if(g_s_sockets[app_id].is_connected)
		{
			luat_rtos_semaphore_take(g_s_sockets[app_id].connect_ok_semaphore, LUAT_NO_WAIT);

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
				FD_SET(g_s_sockets[app_id].socket_id,&read_set);
				FD_SET(g_s_sockets[app_id].socket_id,&error_set);

				LUAT_SOCKET_SERVICE_PRINT("before select");

				ret = select(g_s_sockets[app_id].socket_id+1, &read_set, NULL, &error_set, &timeout);

				if(ret < 0)
				{
					//失败
					LUAT_SOCKET_SERVICE_PRINT("select fail, ret %d",ret);
					break;
				}
				else if(ret == 0)
				{
					//超时
					LUAT_SOCKET_SERVICE_PRINT("select timeout");
				}
				else
				{
					if(FD_ISSET(g_s_sockets[app_id].socket_id, &error_set))
					{
						//出错
						LUAT_SOCKET_SERVICE_PRINT("select error event");
						break;
					}
					else if(FD_ISSET(g_s_sockets[app_id].socket_id, &read_set))
					{
						LUAT_SOCKET_SERVICE_PRINT("select read event");
						read_len = recv(g_s_sockets[app_id].socket_id, recv_buf, RECV_BUF_LEN, 0);
						//read event后，第一次读不到数据，表示出错
						//实测，在select时，服务器主动断开连接，会走到这里
						if(read_len <= 0)
						{
							LUAT_SOCKET_SERVICE_PRINT("select read event error");
							break;
						}
						else
						{
							do
							{
								LUAT_SOCKET_SERVICE_PRINT("recv %d bytes data from server",read_len);
								if(read_len > 0)
								{
									//读到了数据，在recv_buf中，长度为read_len
									event_param.recv_ind_t.len = read_len;
									event_param.recv_ind_t.data = recv_buf;
									SOCKET_CALLBACK(SOCKET_EVENT_RECEIVE, event_param);
								}

								read_len = recv(g_s_sockets[app_id].socket_id, recv_buf, RECV_BUF_LEN, 0);
							}while(read_len > 0);
						}					

					}
					else
					{
						LUAT_SOCKET_SERVICE_PRINT("select other socket event");
					}
				}
			}

			close_socket(app_id);			

			luat_rtos_task_sleep(5000);
			reconnect_socket(app_id);					
		}
		else
		{
			//等待connect ok
			LUAT_SOCKET_SERVICE_PRINT("wait connect ok semaphore");
			luat_rtos_semaphore_take(g_s_sockets[app_id].connect_ok_semaphore, 1000);
		}
	}
	
}


static void connect_task_proc(void *arg)
{
	ip_addr_t remote_ip;
    struct sockaddr_in name;
    socklen_t sockaddr_t_size = sizeof(name);
    int ret, h_errnop;
    struct hostent dns_result;
    struct hostent *p_result;
	int app_id = *(int*)(arg);
	socket_event_param_t event_param;

	LUAT_SOCKET_SERVICE_PRINT("enter");

	while(1)
    {
		//检查网络是否准备就绪，如果尚未就绪，等待1秒后循环重试
		while(!network_service_is_ready())
		{
			LUAT_SOCKET_SERVICE_PRINT("wait network_service_is_ready");
			luat_rtos_task_sleep(1000);
		}

		//执行DNS，如果失败，等待1秒后，返回检查网络逻辑，重试
		char buf[128] = {0};
		ret = lwip_gethostbyname_r(g_s_sockets[app_id].address, &dns_result, buf, sizeof(buf), &p_result, &h_errnop);
		if(ret == 0)
		{
			remote_ip = *((ip_addr_t *)dns_result.h_addr_list[0]);
		}
		else
		{
			luat_rtos_task_sleep(1000);
			LUAT_SOCKET_SERVICE_PRINT("dns fail");
			continue;
		}

		//创建套接字，如果创建失败，等待3秒后循环重试
		int socket_id = socket(AF_INET, 
							   (g_s_sockets[app_id].protocol)==1 ? SOCK_DGRAM : SOCK_STREAM, 
							   (g_s_sockets[app_id].protocol)==1 ? IPPROTO_UDP : IPPROTO_TCP);
		while(socket_id < 0)
		{
			LUAT_SOCKET_SERVICE_PRINT("create socket fail");
			luat_rtos_task_sleep(3000);
		}
		g_s_sockets[app_id].socket_id = socket_id;
		
		//连接服务器，如果失败，关闭套接字，等待5秒后，返回检查网络逻辑，重试
		name.sin_family = AF_INET;
		name.sin_addr.s_addr = remote_ip.u_addr.ip4.addr;
		name.sin_port = htons(g_s_sockets[app_id].port);
        ret = connect(socket_id, (const struct sockaddr *)&name, sockaddr_t_size);
		if(ret < 0)
		{
			LUAT_SOCKET_SERVICE_PRINT("connect fail, ret %d",ret);
			close_socket(app_id);
			event_param.connect_result = ret;
			SOCKET_CALLBACK(SOCKET_EVENT_CONNECT, event_param);			
			luat_rtos_task_sleep(5000);
			continue;
		}
		LUAT_SOCKET_SERVICE_PRINT("connect ok");
		g_s_sockets[app_id].is_connected = 1;
		
		fcntl(socket_id, F_SETFL, O_NONBLOCK);		

		if (NULL == g_s_sockets[app_id].connect_ok_semaphore)
		{
			luat_rtos_semaphore_create(&g_s_sockets[app_id].connect_ok_semaphore, 1);
		}
		luat_rtos_semaphore_release(g_s_sockets[app_id].connect_ok_semaphore);
		   

		if(g_s_sockets[app_id].send_task_handle == NULL)
		{
			char task_name[21] = {0};
			snprintf(task_name, sizeof(task_name-1), "%s_%d", "socket_send", app_id);

			luat_rtos_task_create(&g_s_sockets[app_id].send_task_handle, 2048, 20, task_name, send_task_proc, &g_s_sockets[app_id].app_id, SEND_TASK_MAILBOX_EVENT_MAX_SIZE);
		}
		if(g_s_sockets[app_id].recv_task_handle == NULL)
		{
			char task_name[21] = {0};
			snprintf(task_name, sizeof(task_name-1), "%s_%d", "socket_recv", app_id);

			luat_rtos_task_create(&g_s_sockets[app_id].recv_task_handle, 2048, 20, task_name, recv_task_proc, &g_s_sockets[app_id].app_id, 0);
		}

		event_param.connect_result = ret;
		SOCKET_CALLBACK(SOCKET_EVENT_CONNECT, event_param);	

		break;				
    }

	// 打印出来该任务自启动起来最小剩余栈空间大小
	//然后我们就可以计算出最大使用的大小，一般可以再乘以1.5左右作为最终分配的值，必须是4的倍数
	// LUAT_DEBUG_PRINT("before luat_rtos_task_delete, %d", luat_rtos_task_get_high_water_mark());

	LUAT_SOCKET_SERVICE_PRINT("exit");
	g_s_sockets[app_id].connect_task_exist = 0;
	luat_rtos_task_delete(g_s_sockets[app_id].connect_task_handle);	
}



int socket_connect(int app_id, int protocol, char *address, int port, socket_service_event_callback_t callback)
{
	if (!socket_exist(app_id))
	{
		return -1;
	}

	if(!g_s_sockets[app_id].connect_task_exist)
	{
		g_s_sockets[app_id].app_id = app_id;
		g_s_sockets[app_id].protocol = protocol;

		if (!g_s_sockets[app_id].address)
		{
			LUAT_MEM_FREE(g_s_sockets[app_id].address);
			g_s_sockets[app_id].address = NULL;
		}
		g_s_sockets[app_id].address = LUAT_MEM_MALLOC(strlen(address)+1);
		memset(g_s_sockets[app_id].address, 0, strlen(address)+1);
		memcpy(g_s_sockets[app_id].address, address, strlen(address));
		
		g_s_sockets[app_id].port = port;

		g_s_sockets[app_id].callback = callback;

		char task_name[21] = {0};
		snprintf(task_name, sizeof(task_name-1), "%s_%d", "socket_connect", app_id);

		g_s_sockets[app_id].connect_task_exist = (luat_rtos_task_create(&g_s_sockets[app_id].connect_task_handle, 2560, 30, task_name, connect_task_proc, &g_s_sockets[app_id].app_id , 0)==0);
	}

	return 	g_s_sockets[app_id].connect_task_exist ? 0 : -1;
}

//同步插入队列结果通过返回值判断：0成功，其他失败
//插入成功后，异步发送结果通过callback通知
int socket_send(int app_id, uint32_t len, const char *data, int user_param)
{
	if (!socket_exist(app_id))
	{
		return -1;
	}

	if(data==NULL || len==0)
	{
		return -1;
	}
	socket_send_data_t *data_item = (socket_send_data_t *)LUAT_MEM_MALLOC(sizeof(socket_send_data_t));
	LUAT_DEBUG_ASSERT(data_item != NULL,"malloc data_item fail");;

	data_item->data = LUAT_MEM_MALLOC(len);
	LUAT_DEBUG_ASSERT(data_item->data != NULL, "malloc data_item.data fail");
	memcpy(data_item->data, data, len);
	data_item->len = len;
	data_item->user_param = user_param;

	int ret = luat_rtos_message_send(g_s_sockets[app_id].send_task_handle, 0, data_item);

	if(ret != 0)
	{
		LUAT_MEM_FREE(data_item->data);
		data_item->data = NULL;
		LUAT_MEM_FREE(data_item);
		data_item = NULL;
	}

	return ret;
}


