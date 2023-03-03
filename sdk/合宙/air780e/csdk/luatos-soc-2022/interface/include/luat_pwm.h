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
#ifndef LUAT_PWM_H
#define LUAT_PWM_H
/**
 *@version V1.0
 *@attention
   1.在使用int luat_pwm_open(int channel, size_t period, size_t freq, int pnum);
    函数时依次依次设置PWM通道，设置PWM频率，设置占空比，PWM个数
    若需要使用设置PWM个数时，PWM频率不宜高于50K,若高于50K可能会多出几个个数的现象

   2.int luat_pwm_capture(int channel,int freq); 获取pwm 频率
    此函数获取PWM频率功能尚未实现
 */
/**
 * @ingroup luatos_device 外设接口
 * @{
 */

/**
 * @defgroup luatos_device_PWM PWM接口
 * @{
*/
#include "luat_base.h"
/**
 * @brief PWM控制参数
*/
typedef struct luat_pwm_conf {
    int channel;       /**<PWM通道 可选通道为 0 / 1 / 2 / 4 总计4个通道*/
    size_t period;   /**<频率, 1Hz - 13MHz*/
    size_t pulse;    /**<占空比，0-100  如将pulse设为50时输出高电平时间占周期50%时间 */
    size_t pnum;     /**<输出周期 0为持续输出, 1为单次输出, 其他为指定脉冲数输出*/
    size_t precision;  /**<分频精度, 100/256/1000, 默认为100, 若设备不支持会有日志提示*/
} luat_pwm_conf_t;


/**
 * @brief 配置pwm 参数
 *
 * @param conf->channel: 选择PWM通道 可选通道为 0 / 1 / 2 / 4 总计4个通道
 *        conf->period : 设置产生的PWM频率
 *        conf->pulse  : 设置产生的PWM占空比
 *        conf->pnum   : 设置产生的PWM个数，若pnum设为0将一直输出PWM
 * @return int
 *         返回值为 0 : 配置PWM成功
 *         返回值为 -1: PWM通道选择错误
 *         返回值为 -2: PWM频率设置错误
 *         返回值为 -3：PWM占空比设置错误
 *         返回值为 -4: 该PWM通道已被使用
 */

int luat_pwm_setup(luat_pwm_conf_t* conf);

/**
 * @brief 打开pwm 通道
 *
 * @param channel: 选择PWM通道 可选通道为 0 / 1 / 2 / 4 总计4个通道
 *        period : 设置产生的PWM频率
 *        pulse  : 设置产生的PWM占空比
 *        pnum   ：设置产生的PWM个数，若pnum设为0将一直输出PWM
 * @return int
 *         返回值为 0 : 配置PWM成功
 *         返回值为 -1: PWM通道选择错误
 *         返回值为 -2: PWM频率设置错误
 *         返回值为 -3：PWM占空比设置错误
 *         返回值为 -4: 该PWM通道已被使用
 */

int luat_pwm_open(int channel, size_t period, size_t pulse, int pnum);

/**
 * @brief 获取pwm 频率  本功能暂未实现
 *
 * @param id i2c_id
 * @return int
 */

int luat_pwm_capture(int channel,int freq);

/**
 * @brief 关闭pwm 接口
 *
 * @param channel: 选择PWM通道 可选通道为 0 / 1 / 2 / 4 总计4个通道
 * @return int
 */
int luat_pwm_close(int channel);

/**
 * @brief 修改占空比
 * @param channel: 选择pwm通道 可选通道为 0 / 1 / 2 / 4 总计4个通道
 *        pulse  ：修改pwm占空比值
 * @return int
 */
/*int luat_pwm_update_dutycycle(int channel,size_t pulse);函数使用方法*/
/*此函数为修改PWM占空比函数，可在完成配置并打开PWM输出后，根据使用者需求改变PWM输出占空比*/
/*可用于whiile 循环中，int channel 参数为要修改的PWM通道，size_t pulse 参数为将要输出的目标占空比*/
/*使用者根据自身使用需求填入相应参数数值即可*/
int luat_pwm_update_dutycycle(int channel,size_t pulse);


/** @}*/

/** @}*/
/** @}*/
#endif
