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
#include "FreeRTOS.h"
#include "task.h"
#include "luat_base.h"
#include "luat_mcu.h"

long luat_mcu_ticks(void) {
    return xTaskGetTickCount();
}

int luat_mcu_set_clk(size_t mhz) {
    return 0;
}

int luat_mcu_get_clk(void) {
    return 204;
}


// 隐藏API, 头文件里没有
uint8_t QSPI_FLASH_ReadUUID(uint8_t* uuid, uint32_t* validlen);
uint8_t unique_id[16];
uint32_t unique_id_len;
const char* luat_mcu_unique_id(size_t* t) {
    if (unique_id[0] == 0) {
        QSPI_FLASH_ReadUUID(unique_id, &unique_id_len);
        if (unique_id_len == 16) {
            for (size_t i = 0; i < 6; i++)
            {
                if (unique_id[unique_id_len - 1] == 0xFF) {
                    unique_id_len --;
                }
                else {
                    break;
                }
            }
        }
    }
    *t = unique_id_len;
    return (const char*)unique_id;
}

uint32_t luat_mcu_hz(void) {
    return 1000;
}

uint64_t luat_mcu_tick64(void) {
    return soc_get_poweron_time_tick();
}
int luat_mcu_us_period(void) {
    return 26;
}
uint64_t luat_mcu_tick64_ms(void) {
    return soc_get_poweron_time_ms();
}

void luat_mcu_set_clk_source(uint8_t source_main, uint8_t source_32k, uint32_t delay) {
    // nop
}
