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

#include "luat_base.h"
#include "luat_rtos.h"
#include "luat_mem.h"
#include "luat_debug.h"

#include "stdio.h"
#include "stdlib.h"

#include "flash_rt.h"

int luat_flash_read(char* buff, size_t addr, size_t len) {
    int ret = 0;
    if (len == 0)
        return 0;
    ret = BSP_QSPI_Read_Safe((uint8_t *)buff, addr, len);
    return ret == 0 ? len : -1;
}

int luat_flash_write(char* buff, size_t addr, size_t len) {
    int ret = 0;
    if (len == 0)
        return 0;
    // 注意, BSP_QSPI_Write_Safe 的buf不能是flash上的常量数据
    // 写入flash时XIP会关闭, 导致buf值肯定读不到
    // 下面的各种判断, 就是把常量数据拷贝到ram, 然后写入
    uint8_t tmp_small[128];
    uint8_t *tmp = NULL;
    uint32_t buff_addr = (uint32_t)buff;
    if (len <= 128) {
        // 对于较小的数据, 直接在栈内存里拷贝即可,不必判断
        memcpy(tmp_small, buff, len);
        ret = BSP_QSPI_Write_Safe((uint8_t *)tmp_small, addr, len);
    }
    else if (buff_addr >= 0x00400000 && buff_addr <= 0x00500000) {
        // 数据已经处于ram, 可以直接写入
        ret = BSP_QSPI_Write_Safe((uint8_t *)buff, addr, len);
    }
    else {
        // 超过128字节的常量数据, 应该是不存在的吧, 下面的逻辑主要是防御代码.
        tmp = malloc(len);
        if (tmp == NULL) {
            LUAT_DEBUG_PRINT("out of memory when malloc flash write buff");
            return -1;
        }
        memcpy(tmp, buff, len);
        ret = BSP_QSPI_Write_Safe((uint8_t *)tmp, addr, len);
        free(tmp);
    }
    return ret == 0 ? len : -1;
}

int luat_flash_erase(size_t addr, size_t len) {
    int ret = 0;
    ret = BSP_QSPI_Erase_Safe(addr, len);
    return ret == 0 ? 0 : -1;
}

