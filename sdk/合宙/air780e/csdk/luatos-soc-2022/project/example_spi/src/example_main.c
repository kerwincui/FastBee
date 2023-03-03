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

#include "luat_spi.h"


luat_rtos_task_handle spi_task_handle;

static void task_test_spi(void *param)
{
    luat_spi_t spi_conf = {
        .id = 0,
        .CPHA = 0,
        .CPOL = 0,
        .dataw = 8,
        .bit_dict = 0,
        .master = 1,
        .mode = 1,             // mode设置为1，全双工
        .bandrate = 25600000,
        .cs = 8
    };

    luat_spi_setup(&spi_conf);

    static uint8_t send_buf[] = {0x90,0x80,0x70,0x60};
    static uint8_t recv_buf[4] = {0};

    while (1)
    {
        luat_rtos_task_sleep(1000);
        luat_spi_transfer(0, send_buf, 4,recv_buf, 4);
        for (size_t i = 0; i < 4; i++){
            LUAT_DEBUG_PRINT("send_buf[%d]: 0x%02X",i,send_buf[i]);
        }
        for (size_t i = 0; i < 4; i++){
            LUAT_DEBUG_PRINT("recv_buf[%d]: 0x%02X",i,recv_buf[i]);
        }
    }
}

static void task_demo_spi(void)
{
    luat_rtos_task_create(&spi_task_handle, 1024, 20, "spi", task_test_spi, NULL, NULL);
}

INIT_TASK_EXPORT(task_demo_spi,"1");



