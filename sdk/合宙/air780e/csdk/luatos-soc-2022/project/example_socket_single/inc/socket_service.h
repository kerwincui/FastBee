#ifndef SOCKET_SERVICE_H
#define SOCKET_SERVICE_H

//result：0成功，1 socket未连接；其余错误值是lwip send接口返回的错误原因值
typedef void (*socket_service_send_data_callback_t)(int result, uint32_t callback_param);


void socket_service_init(void);
void socket_service_set_remote_port(int port);
//同步插入队列结果通过返回值判断：0成功，其他失败
//插入成功后，异步发送结果通过callback_func(int result, void *callback_param)中的result判断：0成功，其他失败
int socket_service_send_data(const char *data, uint32_t len, socket_service_send_data_callback_t callback_func, uint32_t callback_param);


#endif