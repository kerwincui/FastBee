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


#ifndef LUAT_SPI_LEGACY_H
#define LUAT_SPI_LEGACY_H

#include "luat_base.h"

#ifdef __LUATOS__

typedef struct luat_spi_device
{
    uint8_t  bus_id;
    luat_spi_t spi_config;
    void* user_data;
} luat_spi_device_t;

typedef struct luat_fatfs_spi
{
	uint8_t type;
	uint8_t spi_id;
	uint8_t spi_cs;
	uint8_t nop;
	uint32_t fast_speed;
	luat_spi_device_t * spi_device;
}luat_fatfs_spi_t;

//收发SPI数据尝试启动DMA模式
int luat_spi_config_dma(int spi_id, uint32_t tx_channel, uint32_t rx_channel);

//非阻塞SPI收发数据
int luat_spi_no_block_transfer(int spi_id, uint8_t *tx_buff, uint8_t *rx_buff, size_t len, void *CB, void *pParam);

// 初始化总线
int luat_spi_bus_setup(luat_spi_device_t* spi_dev);
// 初始化设备
int luat_spi_device_setup(luat_spi_device_t* spi_dev);
// 配置设备
int luat_spi_device_config(luat_spi_device_t* spi_dev);
//关闭SPI设备，成功返回0
int luat_spi_device_close(luat_spi_device_t* spi_dev);
//收发SPI数据，返回接收字节数
int luat_spi_device_transfer(luat_spi_device_t* spi_dev, const char* send_buf, size_t send_length, char* recv_buf, size_t recv_length);
//收SPI数据，返回接收字节数
int luat_spi_device_recv(luat_spi_device_t* spi_dev, char* recv_buf, size_t length);
//发SPI数据，返回发送字节数
int luat_spi_device_send(luat_spi_device_t* spi_dev, const char* send_buf, size_t length);

#endif

#endif
