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
#include "luat_mcu.h"
#include "luat_malloc.h"
#include "luat_spi.h"
#include "luat_fota.h"
#include "FreeRTOS.h"
#include "bsp_common.h"
#include "platform_define.h"
#define LUAT_LOG_TAG "fota"
#include "luat_log.h"
#include "mbedtls/md5.h"
#include "fota_nvm.h"
extern void fotaNvmNfsPeInit(uint8_t isSmall);
#define __SOC_OTA_COMMON_DATA_LOAD_ADDRESS__	(LUA_SCRIPT_OTA_ADDR + AP_FLASH_XIP_ADDR)
#define __SOC_OTA_COMMON_DATA_SAVE_ADDRESS__	(LUA_SCRIPT_OTA_ADDR)
#define __SOC_OTA_SDK_DATA_LOAD_ADDRESS__	(FLASH_FOTA_REGION_START + AP_FLASH_XIP_ADDR)
#define __SOC_OTA_SDK_DATA_SAVE_ADDRESS__	(FLASH_FOTA_REGION_START)
typedef struct
{
	Buffer_Struct data_buffer;
	mbedtls_md5_context *md5_ctx;
	CoreUpgrade_FileHeadCalMD5Struct *p_fota_file_head;
	uint32_t *crc32_table;
	uint32_t ota_done_len;
	uint8_t ota_state;
}luat_fota_ctrl_t;

enum
{
	OTA_STATE_IDLE,
	OTA_STATE_WRITE_COMMON_DATA,
	OTA_STATE_WRITE_SDK_DATA,
	OTA_STATE_OK,
};

static luat_fota_ctrl_t g_s_fota;

static void luat_fota_finish(void)
{
	CoreUpgrade_HeadCalMD5Struct Head = {0};
	PV_Union uPV;
	Head.MaigcNum = __APP_START_MAGIC__;
	Head.DataStartAddress = __SOC_OTA_COMMON_DATA_LOAD_ADDRESS__;
	uPV.u8[0] = CORE_OTA_MODE_FULL;
	uPV.u8[1] = CORE_OTA_IN_FLASH;
	Head.Param1 = uPV.u32;
	Head.DataLen = g_s_fota.p_fota_file_head->CommonDataLen;
	memcpy(Head.CommonMD5, g_s_fota.p_fota_file_head->CommonMD5, 16);
	Head.CRC32 = CRC32_Cal(g_s_fota.crc32_table, (uint8_t *)&Head.Param1, sizeof(Head) - 8, 0xffffffff);
	BSP_QSPI_Erase_Safe(__SOC_OTA_INFO_DATA_SAVE_ADDRESS__, __FLASH_SECTOR_SIZE__);
	BSP_QSPI_Write_Safe((uint8_t *)&Head, __SOC_OTA_INFO_DATA_SAVE_ADDRESS__, sizeof(Head));
	g_s_fota.ota_state = OTA_STATE_OK;
	luat_heap_free(g_s_fota.crc32_table);
	g_s_fota.crc32_table = NULL;
	luat_heap_free(g_s_fota.md5_ctx);
	g_s_fota.md5_ctx = NULL;
	luat_heap_free(g_s_fota.p_fota_file_head);
	g_s_fota.p_fota_file_head = NULL;
	OS_DeInitBuffer(&g_s_fota.data_buffer);
	LLOGI("fota ok!, wait reboot");
}

int luat_fota_init(uint32_t start_address, uint32_t len, luat_spi_device_t* spi_device, const char *path, uint32_t pathlen)
{
	if (!g_s_fota.crc32_table)
	{
		g_s_fota.p_fota_file_head = luat_heap_malloc(sizeof(CoreUpgrade_FileHeadCalMD5Struct));
		g_s_fota.crc32_table = luat_heap_malloc(256 * sizeof(uint32_t));
		memset(g_s_fota.crc32_table, 0, 1024);
		g_s_fota.md5_ctx = luat_heap_malloc(sizeof(mbedtls_md5_context));
		CRC32_CreateTable(g_s_fota.crc32_table, CRC32_GEN);
	}
	memset(g_s_fota.p_fota_file_head, 0, sizeof(CoreUpgrade_FileHeadCalMD5Struct));
	g_s_fota.ota_state = OTA_STATE_IDLE;
	BSP_QSPI_Erase_Safe(__SOC_OTA_INFO_DATA_SAVE_ADDRESS__, __FLASH_SECTOR_SIZE__);
	OS_ReInitBuffer(&g_s_fota.data_buffer, __FLASH_SECTOR_SIZE__ * 4);
	return 0;
}

int luat_fota_write(uint8_t *data, uint32_t len)
{
	uint32_t save_len;
	OS_BufferWrite(&g_s_fota.data_buffer, data, len);
REPEAT:
	switch(g_s_fota.ota_state)
	{
	case OTA_STATE_IDLE:
		if (g_s_fota.data_buffer.Pos > sizeof(CoreUpgrade_FileHeadCalMD5Struct))
		{
			memcpy(g_s_fota.p_fota_file_head, g_s_fota.data_buffer.Data, sizeof(CoreUpgrade_FileHeadCalMD5Struct));
			OS_BufferRemove(&g_s_fota.data_buffer, sizeof(CoreUpgrade_FileHeadCalMD5Struct));
			if (g_s_fota.p_fota_file_head->MaigcNum != __APP_START_MAGIC__)
			{
				LLOGI("magic num error %x", g_s_fota.p_fota_file_head->MaigcNum);
				g_s_fota.data_buffer.Pos = 0;
				return -1;
			}
			uint32_t crc32 = CRC32_Cal(g_s_fota.crc32_table, g_s_fota.p_fota_file_head->MainVersion, sizeof(CoreUpgrade_FileHeadCalMD5Struct) - 8, 0xffffffff);
			if (crc32 != g_s_fota.p_fota_file_head->CRC32)
			{
				LLOGI("file head crc32 error %x,%x", crc32, g_s_fota.p_fota_file_head->CRC32);
				g_s_fota.data_buffer.Pos = 0;
				return -1;
			}
			g_s_fota.ota_done_len = 0;
			mbedtls_md5_init(g_s_fota.md5_ctx);
			mbedtls_md5_starts_ret(g_s_fota.md5_ctx);
			if (g_s_fota.p_fota_file_head->CommonDataLen)
			{
				g_s_fota.ota_state = OTA_STATE_WRITE_COMMON_DATA;
				fotaNvmNfsPeInit(1);
				LLOGI("write stript data");
				goto REPEAT;
			}
			else
			{
				g_s_fota.ota_state = OTA_STATE_WRITE_SDK_DATA;
				LLOGI("write core data");
				goto REPEAT;
			}
		}
		break;
	case OTA_STATE_WRITE_COMMON_DATA:
		save_len = ((g_s_fota.ota_done_len + __FLASH_SECTOR_SIZE__) < g_s_fota.p_fota_file_head->CommonDataLen)?__FLASH_SECTOR_SIZE__:(g_s_fota.p_fota_file_head->CommonDataLen - g_s_fota.ota_done_len);
		if (g_s_fota.data_buffer.Pos >= save_len)
		{
			BSP_QSPI_Erase_Safe(__SOC_OTA_COMMON_DATA_SAVE_ADDRESS__ + g_s_fota.ota_done_len, __FLASH_SECTOR_SIZE__);
			BSP_QSPI_Write_Safe(g_s_fota.data_buffer.Data, __SOC_OTA_COMMON_DATA_SAVE_ADDRESS__ + g_s_fota.ota_done_len, save_len);
			mbedtls_md5_update_ret(g_s_fota.md5_ctx, (uint8_t *)(__SOC_OTA_COMMON_DATA_LOAD_ADDRESS__ + g_s_fota.ota_done_len), save_len );
			OS_BufferRemove(&g_s_fota.data_buffer, save_len);
		}
		else
		{
			break;
		}
		g_s_fota.ota_done_len += save_len;
		if (g_s_fota.ota_done_len >= g_s_fota.p_fota_file_head->CommonDataLen)
		{
			LLOGI("stript data done, now checking");
			fotaNvmNfsPeInit(0);
			uint8_t md5[16];
			mbedtls_md5_finish_ret(g_s_fota.md5_ctx, md5);
			if (memcmp(md5, g_s_fota.p_fota_file_head->CommonMD5, 16))
			{
				LLOGI("stript data md5 check failed");
				g_s_fota.ota_state = OTA_STATE_IDLE;
				g_s_fota.data_buffer.Pos = 0;
				return -1;
			}
			else
			{
				LLOGI("stript data md5 ok");
				if (g_s_fota.p_fota_file_head->SDKDataLen)
				{
					g_s_fota.ota_state = OTA_STATE_WRITE_SDK_DATA;
					g_s_fota.ota_done_len = 0;
					LLOGI("write core data");
					goto REPEAT;
				}
				else
				{
					LLOGI("stript data md5 ok");
					luat_fota_finish();
					return 0;
				}
			}
		}
		else
		{
			goto REPEAT;
		}
		break;
	case OTA_STATE_WRITE_SDK_DATA:
		save_len = ((g_s_fota.ota_done_len + __FLASH_SECTOR_SIZE__) < (g_s_fota.p_fota_file_head->SDKDataLen))?__FLASH_SECTOR_SIZE__:(g_s_fota.p_fota_file_head->SDKDataLen - g_s_fota.ota_done_len);
		if (g_s_fota.data_buffer.Pos >= save_len)
		{
			BSP_QSPI_Erase_Safe(__SOC_OTA_SDK_DATA_SAVE_ADDRESS__ + g_s_fota.ota_done_len, __FLASH_SECTOR_SIZE__);
			BSP_QSPI_Write_Safe(g_s_fota.data_buffer.Data, __SOC_OTA_SDK_DATA_SAVE_ADDRESS__ + g_s_fota.ota_done_len, save_len);
			OS_BufferRemove(&g_s_fota.data_buffer, save_len);
			//			mbedtls_md5_update_ret(g_s_fota.md5_ctx, (uint8_t *)(__SOC_OTA_COMMON_DATA_SAVE_ADDRESS__ + g_s_fota.ota_done_len), save_len );
		}
		else
		{
			break;
		}
		g_s_fota.ota_done_len += save_len;
		if (g_s_fota.ota_done_len >= g_s_fota.p_fota_file_head->SDKDataLen)
		{
			fotaNvmInit();
		    FotaDefChkDeltaState_t    chkDelta = {0};
		    FotaDefChkBaseImage_t      chkBase = {0};

			fotaNvmDoExtension(FOTA_DEF_CHK_DELTA_STATE, (void*)&chkDelta);
			if(!chkDelta.isValid)
			{
				LLOGI("validate delta err! errno(%d)", chkDelta.state);
				g_s_fota.ota_state = OTA_STATE_IDLE;
				g_s_fota.data_buffer.Pos = 0;
				return -1;
			}
			else
			{
				LLOGI("validate delta ok!");
				fotaNvmDoExtension(FOTA_DEF_CHK_BASE_IMAGE, (void*)&chkBase);
				if(!chkBase.isMatched)
				{
					LLOGI("however, base fw is unmatched!");
					fotaNvmClearDelta(0, 4096);
					g_s_fota.ota_state = OTA_STATE_IDLE;
					g_s_fota.data_buffer.Pos = 0;
					return -1;
				}
			}
			LLOGI("sdk data ok!");
			luat_fota_finish();
			return 0;
		}
		else
		{
			goto REPEAT;
		}
		break;
	default:
		return 0;
		break;
	}
	return 1;
}

int luat_fota_done(void)
{
	switch(g_s_fota.ota_state)
	{
	case OTA_STATE_IDLE:
		return -1;
	case OTA_STATE_OK:
		return 0;
	default:
		return 1;
	}
	return 1;
}

int luat_fota_end(uint8_t is_ok)
{
	if (g_s_fota.ota_state != OTA_STATE_OK)
	{
		luat_heap_free(g_s_fota.crc32_table);
		g_s_fota.crc32_table = NULL;
		luat_heap_free(g_s_fota.md5_ctx);
		g_s_fota.md5_ctx = NULL;
		luat_heap_free(g_s_fota.p_fota_file_head);
		g_s_fota.p_fota_file_head = NULL;
		OS_DeInitBuffer(&g_s_fota.data_buffer);
		OS_DeInitBuffer(&g_s_fota.data_buffer);
		BSP_QSPI_Erase_Safe(__SOC_OTA_INFO_DATA_SAVE_ADDRESS__, __FLASH_SECTOR_SIZE__);
		LLOGI("fota failed");
	}
	return 0;
}

uint8_t luat_fota_wait_ready(void)
{
	return 1;
}
