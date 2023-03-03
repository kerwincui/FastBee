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


#ifndef LUAT_GPIO_LEGACY_H
#define LUAT_GPIO_LEGACY_H


#include "luat_base.h"
#ifdef __LUATOS__
#include "luat_msgbus.h"
int l_gpio_handler(lua_State *L, void* ptr);
#endif
typedef int (*luat_gpio_irq_cb)(int pin, void* args);


#define Luat_GPIO_LOW                 0x00 ///< GPIO配置为低电平
#define Luat_GPIO_HIGH                0x01 ///< GPIO配置为高电平

#define Luat_GPIO_OUTPUT         0x00 ///< GPIO配置为输出模式
#define Luat_GPIO_INPUT          0x01 ///< GPIO配置为输入模式
#define Luat_GPIO_IRQ            0x02 ///< GPIO配置为中断模式

#define Luat_GPIO_DEFAULT        0x00 ///< GPIO配置为默认模式
#define Luat_GPIO_PULLUP         0x01 ///< GPIO配置为上拉模式
#define Luat_GPIO_PULLDOWN       0x02 ///< GPIO配置为下拉模式

#define Luat_GPIO_RISING             0x00 ///<上升沿中断
#define Luat_GPIO_FALLING            0x01 ///< 下降沿中断
#define Luat_GPIO_BOTH               0x02 ///< 上升沿 下降沿都中断 
#define Luat_GPIO_HIGH_IRQ			0x03	///< GPIO配置为高电平中断模式
#define Luat_GPIO_LOW_IRQ			0x04	///< GPIO配置为低电平模式

#define Luat_GPIO_MAX_ID             255 ///< 最大GPIO序号

/**
 * @brief GPIO控制参数
*/
typedef struct luat_gpio
{
    int pin;/**<引脚*/
    int mode;/**<GPIO模式*/
    int pull;/**<GPIO上下拉模式*/
    int irq;/**<GPIO中断模式*/
    int lua_ref;
    luat_gpio_irq_cb irq_cb;/**<中断处理函数*/
    void* irq_args;
} luat_gpio_t;
/**
 * @brief GPIO初始化
 * @param gpio gpio初始化结构体参数
 */
int luat_gpio_setup(luat_gpio_t* gpio);
/**
 * @brief GPIO_Mode 配置函数
 * @param pin GPIO引脚序号
 * @param mode GPIO模式
 * @param pull GPIO上下拉选择
 * @param initOutput 初始输出模式
 */
void luat_gpio_mode(int pin, int mode, int pull, int initOutput);


#endif
