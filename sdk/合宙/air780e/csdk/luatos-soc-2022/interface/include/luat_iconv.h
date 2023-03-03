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

#ifndef LUAT_ICONV_H
#define LUAT_ICONV_H

#include "luat_base.h"

/**
 * @defgroup luatos_iconv 字符编码转换接口
 * @{
 */
typedef void *luat_iconv_t;

/**
 * @brief 开启iconv转换流，分配内存
 * @param to_code 待转换编码
 * @param from_code 目标编码
 * @return cionv转换流
 */
luat_iconv_t luat_iconv_open (const char *to_code, const char *from_code);

/**
 * @brief 转换编码格式
 * @param cd cionv转换流
 * @param inbuf 输入缓冲区
 * @param in_bytes_left 输入缓冲区长度
 * @param outbuf 输出缓冲区
 * @param out_bytes_left 输出缓冲区长度
 * @return 0为成功，-1为失败
 */
size_t luat_iconv_convert (luat_iconv_t cd, char ** inbuf, size_t * in_bytes_left, char ** outbuf, size_t * out_bytes_left);

/**
 * @brief 关闭iconv转换流，释放内存
 * @param cd cionv转换流
 * @return 1成功，0失败
 */
int luat_iconv_close (luat_iconv_t cd);

/**@}*/

#endif