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

#ifndef LUAT_MCU_H
#define LUAT_MCU_H
#include "luat_base.h"

/**
 * @defgroup luatos_mcu MCU特殊操作
 * @{
 */

/**
 * @brief 设置主频
 * 
 * @param mhz 时钟频率,单位MHz, 仅Air101/Air103支持, EC618不支持
 * @return int <= 0错误 >0实际传出的大小
 */
int luat_mcu_set_clk(size_t mhz);
/**
 * @brief 获取主频
 * 
 * @return int 时钟频率,单位MHz
 */
int luat_mcu_get_clk(void);

/**
 * @brief 获取唯一id
 * 
 * @param t id的长度,若失败设置为0
 * @return char* 唯一id, 不需要释放!!
 */
const char* luat_mcu_unique_id(size_t* t);

/**
 * @brief 获取系统tick计数
 * 
 * @return long tick计数值
 */
long luat_mcu_ticks(void);

/**
 * @brief 获取系统tick频率
 * 
 * @return long tick频率,通常为1000, 即每个tick占1ms, 频率1000hz
 */
uint32_t luat_mcu_hz(void);

/**
 * @brief 获取tick计数,64位的
 * 
 * @return uint64_t tick计数
 */
uint64_t luat_mcu_tick64(void);

/**
 * @brief 对应tick64的频率数据
 * 
 * @return int 每us对应的tick数量
 */
int luat_mcu_us_period(void);

/**
 * @brief 开机至今的毫秒数
 * 
 * @return uint64_t 毫秒数,休眠后会继续累计,但精度比其他tick要低
 */
uint64_t luat_mcu_tick64_ms(void);

/**
 * @brief 设置时钟源(仅Air105支持)
 * 
 * @param source_main 主时钟源
 * @param source_32k  32k时钟源
 * @param delay 设置之后延时多久
 */
void luat_mcu_set_clk_source(uint8_t source_main, uint8_t source_32k, uint32_t delay);

#endif

