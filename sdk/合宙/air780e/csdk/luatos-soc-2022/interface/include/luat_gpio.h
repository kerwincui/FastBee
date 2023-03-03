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


#ifndef LUAT_GPIO_H
#define LUAT_GPIO_H


#include "luat_base.h"
#include "luat_gpio_legacy.h"

/**
 * @defgroup luatos_device 外设接口
 * @{
 */

/**
 * @defgroup luatos_device_gpio GPIO接口
 * @{
 */

#define LUAT_GPIO_LOW                 (Luat_GPIO_LOW)  ///< GPIO配置为低电平
#define LUAT_GPIO_HIGH                (Luat_GPIO_HIGH) ///< GPIO配置为高电平

#define LUAT_GPIO_OUTPUT         (Luat_GPIO_OUTPUT) ///< GPIO配置为输出模式
#define LUAT_GPIO_INPUT          (Luat_GPIO_INPUT)  ///< GPIO配置为输入模式
#define LUAT_GPIO_IRQ            (Luat_GPIO_IRQ) ///< GPIO配置为中断模式

#define LUAT_GPIO_DEFAULT        (Luat_GPIO_DEFAULT) ///< GPIO配置为默认模式,EC618平台，普通的GPIO配置为LUAT_GPIO_DEFAULT，表示完全关闭上下拉；AGPIO软件上不支持配置上下拉，即使配置了也无效，一直是硬件开机或者复位时的默认状态
#define LUAT_GPIO_PULLUP         (Luat_GPIO_PULLUP) ///< GPIO配置为上拉模式
#define LUAT_GPIO_PULLDOWN       (Luat_GPIO_PULLDOWN)///< GPIO配置为下拉模式

#define LUAT_GPIO_RISING_IRQ             (Luat_GPIO_RISING) ///<上升沿中断
#define LUAT_GPIO_FALLING_IRQ            (Luat_GPIO_FALLING)///< 下降沿中断
#define LUAT_GPIO_BOTH_IRQ               (Luat_GPIO_BOTH) ///< 上升沿 下降沿都中断
#define LUAT_GPIO_HIGH_IRQ			(Luat_GPIO_HIGH_IRQ)	///< GPIO配置为高电平中断模式
#define LUAT_GPIO_LOW_IRQ			(Luat_GPIO_LOW_IRQ)	///< GPIO配置为低电平模式
#define LUAT_GPIO_NO_IRQ			(0xff) ///< GPIO没有中断模式

#define LUAT_GPIO_MAX_ID             (Luat_GPIO_MAX_ID) ///< 最大GPIO序号



/**
 * @brief GPIO控制参数
*/
typedef struct luat_gpio_cfg
{
    int pin; /**<引脚*/
    uint8_t mode;/**<GPIO模式*/
    uint8_t pull;/**<GPIO上下拉模式*/
    uint8_t irq_type;/**<GPIO中断模式*/
    uint8_t output_level;/**<GPIO输出高低电平选择*/
    luat_gpio_irq_cb irq_cb;/**<GPIO中断回调函数*/
    void* irq_args;/**<GPIO中断回调时用户参数*/
    uint8_t alt_fun;/**<有些SOC的GPIO会在不同引脚上被复用，通过alt_fun来确定具体用哪个*/
} luat_gpio_cfg_t;

/**
 * @brief GPIO上下拉\中断设置参数
 */
typedef enum
{
	LUAT_GPIO_CMD_SET_PULL_MODE,/**<上下拉模式*/
	LUAT_GPIO_CMD_SET_IRQ_MODE,/**<中断模式*/
}LUAT_GPIO_CTRL_CMD_E;

/**
 * @brief GPIO设置默认参数
 * @param luat_gpio_cfg_t
*/
void luat_gpio_set_default_cfg(luat_gpio_cfg_t* gpio);
/**
 * @brief 打开GPIO
 * @param luat_gpio_cfg_t
*/
int luat_gpio_open(luat_gpio_cfg_t* gpio);

/**
 * @brief GPIO输出电平
 * @param Pin Pin序号
 * @param Level 1高电平，0低电平
 */

int luat_gpio_set(int pin, int level);
/**
 * @brief 读取GPIO输入电平
 * @param Pin Pin序号
 * @return 1高电平， 0低电平，其他无效
 */
int luat_gpio_get(int pin);
/**
 * @brief 关闭GPIO
 * @param Pin Pin序号
 */
void luat_gpio_close(int pin);
/**
 * @brief 设置GPIO中断回调函数
 * @param Pin Pin序号
 * @param cb  中断处理函数
 * @param args 中断函数参数
 * @return -1 失败 0 成功
 */
int luat_gpio_set_irq_cb(int pin, luat_gpio_irq_cb cb, void* args);
/**
 * @brief GPIO模拟单线输出模式
 * @param Pin Pin序号
 * @param Data 输出电平序列
 * @param BitLen 输出电平序列中一共有几个bit
 * @param Delay 每个bit之间的delay
 * @return 无
 * @attention 在同一个GPIO输出一组脉冲, 注意, len的单位是bit, 高位在前.
 */
void luat_gpio_pulse(int pin, uint8_t *level, uint16_t len, uint16_t delay_ns);
/**
 * @brief GPIO上下拉\中断单独设置函数
 * @param pin Pin序号
 * @param LUAT_GPIO_CTRL_CMD_E 设置命令 LUAT_GPIO_CMD_SET_PULL_MODE 设置上下拉命令 LUAT_GPIO_CMD_SET_IRQ_MODE
 * @param param 设置参数 参数取自上下拉、以及中断的宏定义
 * @return -1 失败 0 成功
 */
int luat_gpio_ctrl(int pin, LUAT_GPIO_CTRL_CMD_E cmd, int param);
/** @}*/
/** @}*/
#endif
