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


#ifndef LUAT_flash_H
#define LUAT_flash_H
#include "luat_base.h"
/**
 * @defgroup luatos_flash 片上Flash操作
 * @{
 */

/**
 * @brief 读取指定区域的Flash数据
 * 
 * @param buff[OUT] 读出的数据
 * @param addr 偏移量, 与具体设备相关
 * @param len 读取长度
 * @return int <= 0错误 >0实际读取的大小
 */
int luat_flash_read(char* buff, size_t addr, size_t len);

/**
 * @brief 写入指定区域的flash数据
 * 
 * @param buff[IN] 写入的数据
 * @param addr 偏移量, 与具体设备相关
 * @param len 写入长度
 * @return int <= 0错误 >0实际写入的大小
 */
int luat_flash_write(char* buff, size_t addr, size_t len);

/**
 * @brief 抹除指定区域的flash数据
 * 
 * @param addr 偏移量, 与具体设备相关
 * @param len 抹除长度,通常为区域大小, 例如4096
 * @return int != 0错误 =0 正常
 */
int luat_flash_erase(size_t addr, size_t len);


/**
 * @}
 */
#endif
