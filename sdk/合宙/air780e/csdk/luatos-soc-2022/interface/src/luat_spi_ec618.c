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


#include "luat_base.h"
#include "luat_spi.h"

#include "common_api.h"
#include <stdio.h>
#include <string.h>
#include "bsp_custom.h"
#include "soc_spi.h"
#include "driver_gpio.h"

static uint8_t g_s_luat_spi_mode[SPI_MAX] ={0};

static int spi_exist(int id) {
	if (id < SPI_MAX) return 1;
    return 0;
}

#ifdef __LUATOS__
int luat_spi_device_config(luat_spi_device_t* spi_dev) {
    if (!spi_exist(spi_dev->bus_id))
        return -1;
    uint8_t spi_mode = SPI_MODE_0;
    if(spi_dev->spi_config.CPHA&&spi_dev->spi_config.CPOL)spi_mode = SPI_MODE_3;
    else if(spi_dev->spi_config.CPOL)spi_mode = SPI_MODE_2;
    else if(spi_dev->spi_config.CPHA)spi_mode = SPI_MODE_1;
    SPI_SetNewConfig(spi_dev->bus_id, spi_dev->spi_config.bandrate, spi_mode);
    return 0;
}

int luat_spi_bus_setup(luat_spi_device_t* spi_dev){
    if (!spi_exist(spi_dev->bus_id))
        return -1;
    uint8_t spi_mode = SPI_MODE_0;
	if(spi_dev->spi_config.CPHA&&spi_dev->spi_config.CPOL)spi_mode = SPI_MODE_3;
	else if(spi_dev->spi_config.CPOL)spi_mode = SPI_MODE_2;
	else if(spi_dev->spi_config.CPHA)spi_mode = SPI_MODE_1;
	if (spi_dev->bus_id)
	{
		GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_13, 0), 1, 0, 0);
		GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_14, 0), 1, 0, 0);
		GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_15, 0), 1, 0, 0);
	}
	else
	{
		GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_9, 0), 1, 0, 0);
		GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_10, 0), 1, 0, 0);
		GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_11, 0), 1, 0, 0);
	}
	g_s_luat_spi_mode[spi_dev->bus_id] = spi_dev->spi_config.mode;
	// LLOGD("SPI_MasterInit luat_bus_%d:%d dataw:%d spi_mode:%d bandrate:%d ",bus_id,luat_spi[bus_id].id, spi_dev->spi_config.dataw, spi_mode, spi_dev->spi_config.bandrate);
	SPI_MasterInit(spi_dev->bus_id, spi_dev->spi_config.dataw, spi_mode, spi_dev->spi_config.bandrate, NULL, NULL);
	return 0;
}

#endif

int luat_spi_setup(luat_spi_t* spi) {
    if (!spi_exist(spi->id))
        return -1;
    uint8_t spi_mode = SPI_MODE_0;
    if(spi->CPHA&&spi->CPOL)spi_mode = SPI_MODE_3;
    else if(spi->CPOL)spi_mode = SPI_MODE_2;
    else if(spi->CPHA)spi_mode = SPI_MODE_1;
	if (spi->id)
	{
		if (HAL_GPIO_12 == spi->cs)
		{
			GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_12, 0), 1, 0, 0);
		}
		GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_13, 0), 1, 0, 0);
		GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_14, 0), 1, 0, 0);
		GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_15, 0), 1, 0, 0);
	}
	else
	{
		if (HAL_GPIO_8 == spi->cs)
		{
			GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_8, 0), 1, 0, 0);
		}
		GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_9, 0), 1, 0, 0);
		GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_10, 0), 1, 0, 0);
		GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_11, 0), 1, 0, 0);
	}
	g_s_luat_spi_mode[spi->id] = spi->mode;
//    LLOGD("SPI_MasterInit luat_spi%d:%d dataw:%d spi_mode:%d bandrate:%d ",spi_id,luat_spi[spi_id].id, spi->dataw, spi_mode, spi->bandrate);
    SPI_MasterInit(spi->id, spi->dataw, spi_mode, spi->bandrate, NULL, NULL);
    return 0;
}

//关闭SPI，成功返回0
int luat_spi_close(int spi_id) {
    return 0;
}

//收发SPI数据，返回接收字节数
int luat_spi_transfer(int spi_id, const char* send_buf, size_t send_length, char* recv_buf, size_t recv_length) {
    if (!spi_exist(spi_id))
        return -1;
    if(g_s_luat_spi_mode[spi_id])
    {
    	if (SPI_BlockTransfer(spi_id, send_buf, recv_buf, recv_length))
    	{
    		return 0;
    	}
    	else
    	{
    		return recv_length;
    	}
    }
    else
    {
    	if (SPI_FlashBlockTransfer(spi_id, send_buf, send_length, recv_buf, recv_length))
    	{
    		return 0;
    	}
    	else
    	{
    		return recv_length;
    	}
    }
    return 0;
}

//收SPI数据，返回接收字节数
int luat_spi_recv(int spi_id, char* recv_buf, size_t length) {
    if (!spi_exist(spi_id))
        return -1;
    if (SPI_BlockTransfer(spi_id, recv_buf, recv_buf, length))
    {
    	return 0;
    }
    else
    {
    	return length;
    }
}
//发SPI数据，返回发送字节数
int luat_spi_send(int spi_id, const char* send_buf, size_t length) {
    if (!spi_exist(spi_id))
        return -1;
    if (SPI_BlockTransfer(spi_id, send_buf, send_buf, length))
    {
    	return 0;
    }
    else
    {
    	return length;
    }
}

int luat_spi_no_block_transfer(int spi_id, uint8_t *tx_buff, uint8_t *rx_buff, size_t len, void *CB, void *pParam)
{
	if (SPI_IsTransferBusy(spi_id)) return -1;
	SPI_SetCallbackFun(spi_id, CB, pParam);
	SPI_SetNoBlock(spi_id);
	return SPI_TransferEx(spi_id, tx_buff, rx_buff, len, 0, 1);
}
