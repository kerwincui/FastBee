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

#ifndef LUAT_I2C_H
#define LUAT_I2C_H

#include "luat_base.h"
#include "luat_i2c_legacy.h"

/**
 * @ingroup luatos_device 外设接口
 * @{
 */
/**
 * @defgroup luatos_device_i2c I2C接口
 * @{
*/

/**
 * @brief 检查i2c是否存在
 * 
 * @param id i2c_id
 * @return int 
 */
int luat_i2c_exist(int id);

/**
 * @brief 初始化i2c
 * 
 * @param id i2c_id
 * @param speed i2c 速度
 * @param slaveaddr i2c 从地址
 * @return int 
 */
int luat_i2c_setup(int id, int speed);

/**
 * @brief 关闭 i2c
 * 
 * @param id i2c_id
 * @return int 
 */
int luat_i2c_close(int id);

/**
 * @brief I2C 发送数据
 * 
 * @param id i2c_id
 * @param addr 7位设备地址
 * @param buff 数据buff
 * @param len 数据长度
 * @param stop 是否发送停止位
 * @return int 
 */
int luat_i2c_send(int id, int addr, void* buff, size_t len, uint8_t stop);
/**
 * @brief I2C 接受数据
 * 
 * @param id i2c_id
 * @param addr 7位设备地址
 * @param buff 数据buff
 * @param len 数据长度
 * @return int 
 */
int luat_i2c_recv(int id, int addr, void* buff, size_t len);
/**
 * @brief I2C 收发数据
 * 
 * @param id i2c_id
 * @param addr 7位设备地址
 * @param reg 发送数据
 * @param reg_len 发送数据长度
 * @param buff 数据buff
 * @param len 数据长度
 * @return int 
 */
int luat_i2c_transfer(int id, int addr, uint8_t *reg, size_t reg_len, uint8_t *buff, size_t len);
/** @}*/
/** @}*/
#endif
