#ifndef SOCKET_SERVICE_H
#define SOCKET_SERVICE_H

typedef enum SOCKET_EVENT
{
	SOCKET_EVENT_CONNECT,
    SOCKET_EVENT_SEND,
    SOCKET_EVENT_RECEIVE,
}SOCKET_EVENT_E;

typedef union socket_event_param
{	
	int connect_result; //>=0成功；其余值失败
	struct
    {
        int result;//>0成功；其余值失败
        int user_param;
    } send_cnf_t;
    struct
    {
        int len;
        char *data;
    } recv_ind_t;
    
} socket_event_param_t;

typedef void (*socket_service_event_callback_t)(int app_id, SOCKET_EVENT_E event, socket_event_param_t param);

// 创建一个socket并且去连接服务器
// 返回执行的同步结果：0表示成功，其余表示失败；
// 异步连接结果通过回调函数callback通知
// app_id：用户连接id，从0开始，最大值为USER_SOCKET_MAX_COUNT-1
int socket_connect(int app_id, int protocol, char *address, int port, socket_service_event_callback_t callback);

//同步插入队列结果通过返回值判断：0成功，其他失败
//插入成功后，异步发送结果通过callback通知
int socket_send(int app_id, uint32_t len, const char *data, int user_param);


#endif