/*
 * Copyright (c) 2022 OpenLuat & AirM2M
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#include "common_api.h"
#include "luat_rtos.h"
#include "luat_debug.h"

#include "luat_uart.h"

static luat_rtos_task_handle uart_task_handle;

void luat_usb_recv_cb(int uart_id, uint32_t data_len){
    char* data_buff = malloc(data_len);
    luat_uart_read(uart_id, data_buff, data_len);
    LUAT_DEBUG_PRINT("luat_uart_cb uart_id:%d data:%.*s data_len:%d",uart_id, data_len, data_buff,data_len);
    free(data_buff);
}

static void task_test_uart(void *param)
{
    char send_buff[] = "hello LUAT!!!\n";
    luat_uart_t uart = {
        .id = LUAT_VUART_ID_0,
    };

    luat_uart_setup(&uart);

    luat_uart_ctrl(LUAT_VUART_ID_0, LUAT_UART_SET_RECV_CALLBACK, luat_usb_recv_cb);

    while (1)
    {
        luat_rtos_task_sleep(1000);
        luat_uart_write(LUAT_VUART_ID_0, send_buff, strlen(send_buff));
    }
    luat_rtos_task_delete(uart_task_handle);
}

static void task_demo_uart(void)
{
    luat_rtos_task_create(&uart_task_handle, 2048, 20, "uart", task_test_uart, NULL, NULL);
}

INIT_TASK_EXPORT(task_demo_uart,"1");



