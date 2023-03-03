#include "luat_rtos.h"
#include "luat_debug.h"
#include "luat_uart.h"
#include "luat_mem.h"
#include "socket_service.h"

/*
功能模块名称：usb和上位机通信；
主体业务逻辑为：
1、设备上电开机后，在电脑端会枚举出三个端口，使用第3个端口可以和PC端的串口工具进行数据通信；
2、PC端串口工具发送port,<%d>\r\n命令来修改socket_service功能模块中的服务器端口号；
   例如port,1234\r\n表示修改要连接的服务器端口号为1234；
*/


// static luat_rtos_task_handle usb_task_handle;
//usb在电脑上枚举出的第3个口为数据通信口
//此端口的ID为4
#define USB_DATA_PORT_ID 4

//仅仅测试使用，写的不够健壮
#define USB_RECV_BUFFER_SIZE 256
static uint8_t g_s_recv_buff[USB_RECV_BUFFER_SIZE+1];
static uint32_t g_s_recved_len = 0;

static void parse_recv_data(char* data, uint32_t len)
{
    if(len > (USB_RECV_BUFFER_SIZE-g_s_recved_len))
    {
        LUAT_DEBUG_PRINT("recv len exceed max size, error");
        goto exit;
    }

    memcpy(g_s_recv_buff+g_s_recved_len, data, len);
    g_s_recved_len += len;
    *(g_s_recv_buff+len) = 0;

    if(strstr((const char *)g_s_recv_buff, "\r\n"))
    {
        int port;

        if(sscanf(g_s_recv_buff, "port,%d", &port))
        {
            socket_service_set_remote_port(port);
            luat_uart_write(USB_DATA_PORT_ID, "\r\nOK\r\n", 6);
        }
        else
        {
            luat_uart_write(USB_DATA_PORT_ID, "\r\nERROR\r\n", 9);
        }

        goto exit;
    }
    else
    {
        return;
    }

exit:
    memset(g_s_recv_buff, 0, sizeof(g_s_recv_buff));
    g_s_recved_len = 0;
    return;
}

static void usb_recv_cb(int uart_id, uint32_t data_len){
    char* data_buff = LUAT_MEM_MALLOC(data_len+1);
    memset(data_buff,0,data_len+1);
    luat_uart_read(uart_id, data_buff, data_len);
    LUAT_DEBUG_PRINT("uart_id:%d data:%s data_len:%d",uart_id,data_buff,data_len);
    parse_recv_data(data_buff, data_len);
    LUAT_MEM_FREE(data_buff);
}


void usb_service_init(void)
{
    luat_uart_t uart = {
        .id = USB_DATA_PORT_ID,
    };
    luat_uart_setup(&uart);
    luat_uart_ctrl(USB_DATA_PORT_ID, LUAT_UART_SET_RECV_CALLBACK, usb_recv_cb);
}


