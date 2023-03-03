/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_adc.h
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_FILE_H__
#define __ATEC_FILE_H__

#include "at_util.h"

#define EC_FILE_NAME_OFFSET               12
#define EC_FILE_NAME_HEAD_OFFSET          5
#define EC_FILE_NAME_HEAD                 "EcFs_00_f_"  /*00 is handle, f is flag*/

#define EC_FINFO_PRINT_BUF_LEN     (128)

#define EC_FOPEN_0_NAME_STR_LEN             63
#define EC_FOPEN_0_NAME_STR_DEF             NULL
#define EC_FOPEN_1_MODE_MIN               0
#define EC_FOPEN_1_MODE_MAX               2
#define EC_FOPEN_1_MODE_DEF               0

#define EC_FREAD_0_HANDLE_LEN_MIN               1
#define EC_FREAD_0_HANDLE_LEN_MAX               33
#define EC_FREAD_0_HANDLE_LEN_DEF               0
#define EC_FREAD_1_LEN_MIN               0
#define EC_FREAD_1_LEN_MAX               6000
#define EC_FREAD_1_LEN_DEF               0

#define EC_FWRITE_0_HANDLE_LEN_MIN               1
#define EC_FWRITE_0_HANDLE_LEN_MAX               33
#define EC_FWRITE_0_HANDLE_LEN_DEF               0
#define EC_FWRITE_1_LEN_MIN               0
#define EC_FWRITE_1_LEN_MAX               (10*1024)
#define EC_FWRITE_1_LEN_DEF               (1000)
#define EC_FWRITE_2_TIMEOUT_MIN               0
#define EC_FWRITE_2_TIMEOUT_MAX               100
#define EC_FWRITE_2_TIMEOUT_DEF               5

#define EC_FSEEK_0_HANDLE_LEN_MIN               1
#define EC_FSEEK_0_HANDLE_LEN_MAX               33
#define EC_FSEEK_0_HANDLE_LEN_DEF               0
#define EC_FSEEK_1_LEN_MIN               0
#define EC_FSEEK_1_LEN_MAX               0x7fffffff
#define EC_FSEEK_1_LEN_DEF               0
#define EC_FSEEK_2_POSITION_MIN               0
#define EC_FSEEK_2_POSITION_MAX               2
#define EC_FSEEK_2_POSITION_DEF               0

#define EC_FPOSITION_0_HANDLE_LEN_MIN               1
#define EC_FPOSITION_0_HANDLE_LEN_MAX               33
#define EC_FPOSITION_0_HANDLE_LEN_DEF               0

#define EC_FTUCAT_0_HANDLE_LEN_MIN               1
#define EC_FTUCAT_0_HANDLE_LEN_MAX               33
#define EC_FTUCAT_0_HANDLE_LEN_DEF               0

#define EC_FCLOSE_0_HANDLE_LEN_MIN               1
#define EC_FCLOSE_0_HANDLE_LEN_MAX               33
#define EC_FCLOSE_0_HANDLE_LEN_DEF               0

#define EC_FERASE_0_HANDLE_LEN_MIN               1
#define EC_FERASE_0_HANDLE_LEN_MAX               33
#define EC_FERASE_0_HANDLE_LEN_DEF               0
#define EC_FERASE_0_NAME_STR_LEN             81
#define EC_FERASE_0_NAME_STR_DEF             NULL

#define EC_FDELETE_0_HANDLE_LEN_MIN               1
#define EC_FDELETE_0_HANDLE_LEN_MAX               33
#define EC_FDELETE_0_HANDLE_LEN_DEF               0
#define EC_FDELETE_0_NAME_STR_LEN             81
#define EC_FDELETE_0_NAME_STR_DEF             NULL

#define EC_FRENAME_0_NAME_STR_LEN             81
#define EC_FRENAME_0_NAME_STR_DEF             NULL
#define EC_FRENAME_1_NAME_STR_LEN             81
#define EC_FRENAME_1_NAME_STR_DEF             NULL

#define EC_FDEL_0_NAME_STR_LEN             81
#define EC_FDEL_0_NAME_STR_DEF             NULL

#define EC_FLDS_0_NAME_STR_LEN             81
#define EC_FDEL_0_NAME_STR_DEF             NULL

#define EC_FLST_0_NAME_STR_LEN             81
#define EC_FLST_0_NAME_STR_DEF             NULL

#define EC_FUPL_0_NAME_STR_LEN             81
#define EC_FUPL_0_NAME_STR_DEF             NULL
#define EC_FUPL_1_SIZE_MIN               0
#define EC_FUPL_1_SIZE_MAX               0xffff
#define EC_FUPL_1_SIZE_DEF               0
#define EC_FUPL_2_TIMEOUT_MIN               0
#define EC_FUPL_2_TIMEOUT_MAX               2
#define EC_FUPL_2_TIMEOUT_DEF               0
#define EC_FUPL_3_ACK_MIN               0
#define EC_FUPL_3_ACK_MAX               0xffff
#define EC_FUPL_3_ACK_DEF               0

#define EC_FDWL_0_NAME_STR_LEN             81
#define EC_FDWL_0_NAME_STR_DEF             NULL

typedef struct
{
    uint32_t reqhandle;
    uint32_t cmdType;
    char *fileName;
    char *filePattern;
    char *fileHandle;
    uint32_t mode;
    uint32_t length;
    uint32_t timeout;
    uint32_t offset;
    uint32_t position;
    
}fileWriteTempInfo;

CmsRetId fileOPEN(const AtCmdInputContext *pAtCmdReq);
CmsRetId fileREAD(const AtCmdInputContext *pAtCmdReq);
CmsRetId fileWRITE(const AtCmdInputContext *pAtCmdReq);
CmsRetId fileWriteInputData(UINT8 chanId, UINT8 *pData, INT16 dataLength);
CmsRetId fileWriteCancel(void);
CmsRetId fileSEEK(const AtCmdInputContext *pAtCmdReq);
CmsRetId filePOSITION(const AtCmdInputContext *pAtCmdReq);
CmsRetId fileTUCAT(const AtCmdInputContext *pAtCmdReq);
CmsRetId fileCLOSE(const AtCmdInputContext *pAtCmdReq);
CmsRetId fileRENAME(const AtCmdInputContext *pAtCmdReq);
CmsRetId fileERASE(const AtCmdInputContext *pAtCmdReq);
CmsRetId fileDELETE(const AtCmdInputContext *pAtCmdReq);

CmsRetId fileMOV(const AtCmdInputContext *pAtCmdReq);
CmsRetId fileMsLDS(const AtCmdInputContext *pAtCmdReq);
CmsRetId fileMsLST(const AtCmdInputContext *pAtCmdReq);
CmsRetId fileMsDEL(const AtCmdInputContext *pAtCmdReq);
CmsRetId fileMsUPL(const AtCmdInputContext *pAtCmdReq);
CmsRetId fileMsDWL(const AtCmdInputContext *pAtCmdReq);

#endif

/* END OF FILE */

