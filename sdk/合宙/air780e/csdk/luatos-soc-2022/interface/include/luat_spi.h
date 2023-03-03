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

#ifndef LUAT_SPI_H
#define LUAT_SPI_H

#include "luat_base.h"
#include "luat_spi_legacy.h"

/**
 * @ingroup luatos_device 外设接口
 * @{
 */

/**
 * @defgroup luatos_device_spi SPI接口
 * @{
*/

/**
 * @brief SPI功能配置
 */
typedef struct luat_spi
{
    int  id;            /**< spi id        可选  1，0*/
    int  CPHA;          /**< CPHA          可选  1，0*/  
    int  CPOL;          /**< CPOL          可选  1，0*/  
    int  dataw;         /**< 数据宽度        8：8bit */
    int  bit_dict;      /**< 高低位顺序     可选  1：MSB，   0：LSB     */  
    int  master;        /**< 设置主从模式   可选  1：主机，  0：从机     */  
    int  mode;          /**< 设置全\半双工  可选  1：全双工，0：半双工    */  
    int bandrate;       /**< 频率           最小100000， 最大25600000*/  
    int cs;             /**< cs控制引脚     SPI0的片选为GPIO8, 当配置为8时，表示启用SPI0自带片选；其他配置时，需要自行编码控制片选*/  
} luat_spi_t;


/**
 * @brief 初始化配置SPI各项参数，并打开SPI
 * 
 * @param spi spi结构体
 * @return int 成功返回0
 */
int luat_spi_setup(luat_spi_t* spi);

/**
 * @brief 关闭SPI
 * 
 * @param spi_id spi id
 * @return int 成功返回0
 */
int luat_spi_close(int spi_id);

/**
 * @brief 收发SPI数据
 * 
 * @param spi_id spi id
 * @param send_buf 发送数据
 * @param send_length 发送数据长度
 * @param recv_buf 接收数据
 * @param recv_length 接收数据长度
 * @return int 返回接收字节数
 */
int luat_spi_transfer(int spi_id, const char* send_buf, size_t send_length, char* recv_buf, size_t recv_length);

/**
 * @brief 收SPI数据
 * 
 * @param spi_id spi id
 * @param recv_buf 接收数据
 * @param length 数据长度
 * @return int 返回接收字节数
 */
int luat_spi_recv(int spi_id, char* recv_buf, size_t length);

/**
 * @brief 发SPI数据
 * 
 * @param spi_id spi id
 * @param send_buf 发送数据
 * @param length 数据长度
 * @return int 返回发送字节数
 */
int luat_spi_send(int spi_id, const char* send_buf, size_t length);
/**@}*/
/**@}*/
#endif
