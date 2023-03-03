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

#include <luat_fota.h>
#include "fota_nvm.h"
#include "luat_debug.h"



#define LUAT_OTA_HEAD 0x7e
#define LUAT_OTA_APP_HEAD 0X7c
#define LUAT_OTA_CORE_HEAD 0x7d
#define LUAT_OTA_HEAD_LEN (5)
#define LUAT_OTA_FILE_MAX (20)

typedef enum
{
	LUAT_OTA_FILE_NULL,
	LUAT_OTA_FILE_RFBIN,
	LUAT_OTA_FILE_APP,
	LUAT_OTA_FILE_CORE,
	
} E_LUAT_OTA_FILE_TYPE;

typedef struct
{
	unsigned char head[LUAT_OTA_HEAD_LEN];
	unsigned int readLen;
	unsigned int fileNum;
} T_LUAT_OTA_HEAD_CTX;

typedef struct
{
	E_LUAT_OTA_FILE_TYPE type;
	unsigned char head[LUAT_OTA_HEAD_LEN];
	unsigned int readLen;
	unsigned int size;
} T_LUAT_OTA_FILE_CTX;

typedef struct
{

	T_LUAT_OTA_HEAD_CTX head;
	T_LUAT_OTA_FILE_CTX file[LUAT_OTA_FILE_MAX];
	unsigned int readLen;
	unsigned int fileCur;
}openat_otaCtx;

static openat_otaCtx g_s_otaCtx = {0};

uint32_t fotaFirmwaresize = 0;

/**
 * @brief 用于初始化fota,创建写入升级包数据的上下文结构体
 * 
 * @param 
 * @return luat_fota_img_proc_ctx_ptr 
 */
luat_fota_img_proc_ctx_ptr luat_fota_init(void){
	static int luat_fota_core_write_size;
	luat_fota_core_write_size = 0;
    fotaNvmInit();
    if(0 != fotaNvmClearDelta(0, fotaNvmGetDeltaSize(0)))
    {
        LUAT_DEBUG_PRINT("clear flash: failure!");
        return NULL;
    }
    LUAT_DEBUG_PRINT("clear flash: success");
    fotaFirmwaresize = 0;
	memset(&g_s_otaCtx, 0, sizeof(g_s_otaCtx));
	return &luat_fota_core_write_size;
}

int luat_fota_write(luat_fota_img_proc_ctx_ptr context, void *data, int len)
{
	int offset = *(int*)context;
	LUAT_DEBUG_PRINT("offset:%d len:%d", offset, len);
	uint8_t result = fotaNvmWriteDelta(offset, (uint8_t*)data, len);
	if(result != 0)
	{
		LUAT_DEBUG_PRINT("write_flash error!");
		return -1;
	}
	*(int*)context += len;
	return 0;
}

int luat_fota_done(luat_fota_img_proc_ctx_ptr context)
{
    FotaDefChkDeltaState_t    chkDelta = {0};
    FotaDefChkBaseImage_t      chkBase = {0};
    do
    {
        fotaNvmDoExtension(FOTA_DEF_CHK_DELTA_STATE, (void*)&chkDelta);
        if(!chkDelta.isValid)
        {
            LUAT_DEBUG_PRINT("validate delta err! errno(%d)", chkDelta.state);
			return -1;
        }
        else
        {
            LUAT_DEBUG_PRINT("validate delta ok!");
            fotaNvmDoExtension(FOTA_DEF_CHK_BASE_IMAGE, (void*)&chkBase);
            if(!chkBase.isMatched)
            {
                LUAT_DEBUG_PRINT("however, base fw is unmatched!");
				return -1;
            }
        }
    }while(0);
	return 0;
}

