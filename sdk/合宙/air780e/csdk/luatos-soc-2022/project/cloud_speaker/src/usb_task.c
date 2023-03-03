#include "luat_uart.h"
#include "luat_debug.h"

void luat_uart_recv_cb(int uart_id, uint32_t data_len){
    char* data_buff = malloc(data_len+1);
    memset(data_buff,0,data_len+1);
    luat_uart_read(uart_id, data_buff, data_len);
    LUAT_DEBUG_PRINT("luat_uart_cb uart_id:%d data:%s data_len:%d",uart_id,data_buff,data_len);
    if (strcmp("AT+CLIENTID?\r\n", data_buff) == 0)
    {
        char clientId[32] = {0};
        int ret = luat_kv_get("clientId", clientId, 16);
        if(ret > 0 )
        {
           luat_uart_write(LUAT_VUART_ID_0, clientId, strlen(clientId));
        }
        else
        {
            luat_uart_write(LUAT_VUART_ID_0, "OK", strlen("OK"));
        }
    }
    else if (strstr(data_buff, "AT+CLIENTID=") != NULL)
    {
        char *flag = NULL;
        flag = strstr(data_buff, "=");
        if(flag != NULL)
        {
            flag++;
            char *flag2 = NULL;
            flag2 = strstr(flag, "\r\n");
            if (flag2 != NULL)
            {
                int ret = luat_kv_set("clientId", flag, strlen(flag) - 2);              //减去末尾的\r\n
                luat_uart_write(LUAT_VUART_ID_0, "OK", strlen("OK"));
            }
            
        }
    }
    else if (strcmp("AT+USERNAME?\r\n", data_buff) == 0)
    {
        int ret = 0;
        char name[32] = {0};
        ret = luat_kv_get("username", name, 31);
        if (ret > 0)
        {
            luat_uart_write(LUAT_VUART_ID_0, name, strlen(name));
        }
        else
        {
            luat_uart_write(LUAT_VUART_ID_0, "OK", strlen("OK"));
        }
    }
    else if (strstr(data_buff, "AT+USERNAME=")  != NULL)
    {
        char *flag = NULL;
        flag = strstr(data_buff, "=");
        if(flag != NULL)
        {
            flag++;
            char *flag2 = NULL;
            flag2 = strstr(flag, "\r\n");
            if (flag2 != NULL)
            {
                int ret = luat_kv_set("username", flag, strlen(flag) - 2);              //减去末尾的\r\n
                luat_uart_write(LUAT_VUART_ID_0, "OK", strlen("OK"));
            }
            
        }
    }
    else if (strcmp("AT+PASSWORD?\r\n", data_buff) == 0)
    {
        int ret = 0;
        char name[32] = {0};
        ret = luat_kv_get("password", name, 31);
        if (ret > 0)
        {
            luat_uart_write(LUAT_VUART_ID_0, name, strlen(name));
        }
        else
        {
            luat_uart_write(LUAT_VUART_ID_0, "OK", strlen("OK"));
        }
    }
    else if (strstr(data_buff, "AT+PASSWORD=") != NULL)
    {
        char *flag = NULL;
        flag = strstr(data_buff, "=");
        if(flag != NULL)
        {
            flag++;
            char *flag2 = NULL;
            flag2 = strstr(flag, "\r\n");
            if (flag2 != NULL)
            {
                int ret = luat_kv_set("password", flag, strlen(flag) - 2);              //减去末尾的\r\n
                luat_uart_write(LUAT_VUART_ID_0, "OK", strlen("OK"));
            }
            
        }
    }
    free(data_buff);
}

void usb_uart_init(void)
{
    char send_buff[] = "hello LUAT!!!\n";
    luat_uart_t uart = {
        .id = LUAT_VUART_ID_0,
    };
    luat_uart_setup(&uart);
    luat_uart_ctrl(LUAT_VUART_ID_0, LUAT_UART_SET_RECV_CALLBACK, luat_uart_recv_cb);
}
