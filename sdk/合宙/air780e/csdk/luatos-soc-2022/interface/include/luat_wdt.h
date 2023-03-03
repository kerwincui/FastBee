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

#ifndef LUAT_WDT_H
#define LUAT_WDT_H

#include "luat_base.h"
/**
 * @brief 开启看门狗
 * @param timeout 看门狗超时时间
 * @return int =0成功，其他失败
 */
int luat_wdt_setup(size_t timeout);

/**
 * @brief 重新设置看门狗超时时间
 * @param timeout 看门狗超时时间
 * @return int =0成功，其他失败
 */
int luat_wdt_set_timeout(size_t timeout);

/**
 * @brief 喂狗
 * @return int =0成功，其他失败
 */
int luat_wdt_feed(void);

/**
 * @brief 关闭看门狗
 * @return int =0成功，其他失败
 */
int luat_wdt_close(void);

#endif
