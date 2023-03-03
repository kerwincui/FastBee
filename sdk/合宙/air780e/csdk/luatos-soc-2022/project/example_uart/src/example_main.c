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

// 注意：此处仅支持1和2，不要使用0
// 因为uart0被sdk内部占用为底层日志口，用来输出bootloader运行过程中的日志，此功能无法关闭；
// 除此之外，还可以用来作为系统的日志口，usb抓取日志受限于usb枚举时间，会丢失一部分日志，而uart0则不会丢失这部分日志
// 如果uart0被配置成应用使用，在开机过程中出现的异常，会因为无法抓取底层日志而无法分析定位问题
#define UART_ID 1

static luat_rtos_task_handle uart_task_handle;

void luat_uart_recv_cb(int uart_id, uint32_t data_len){
    char* data_buff = malloc(data_len+1);
    memset(data_buff,0,data_len+1);
    luat_uart_read(uart_id, data_buff, data_len);
    LUAT_DEBUG_PRINT("uart_id:%d data:%s data_len:%d",uart_id,data_buff,data_len);
    free(data_buff);
}

static void task_test_uart(void *param)
{
    char send_buff[] = "hello LUAT!!!\n";
    luat_uart_t uart = {
        .id = UART_ID,
        .baud_rate = 115200,
        .data_bits = 8,
        .stop_bits = 1,
        .parity    = 0
    };

    luat_uart_setup(&uart);

    luat_uart_ctrl(UART_ID, LUAT_UART_SET_RECV_CALLBACK, luat_uart_recv_cb);

    while (1)
    {
        luat_rtos_task_sleep(1000);
        luat_uart_write(UART_ID, send_buff, strlen(send_buff));
    }
    luat_rtos_task_delete(uart_task_handle);
}

static void task_demo_uart(void)
{
    luat_rtos_task_create(&uart_task_handle, 2048, 20, "uart", task_test_uart, NULL, NULL);
}

// 除非你已经非常清楚uart0作为普通串口给用户使用所带来的的后果，否则不要打开以下注释掉的代码
// static void uart0_init(void)
// {
//     soc_uart0_set_log_off(1);
// }

// INIT_TASK_EXPORT(uart0_init,"1");
INIT_TASK_EXPORT(task_demo_uart,"1");



