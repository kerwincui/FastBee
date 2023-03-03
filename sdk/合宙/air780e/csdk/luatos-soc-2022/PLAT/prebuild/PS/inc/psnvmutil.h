#ifndef __PS_NVM_UTIL_H__
#define __PS_NVM_UTIL_H__
/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017- Copyrights of AirM2M Ltd.
 File name:      - psnvmutil.h
 Description:    - Protocol Stack NVM basic utility
 History:        - 13/09/2020, Originated by Jason
 ******************************************************************************
******************************************************************************/
#include "pssys.h"

#define PS_USE_OSA_NVM_FUNC     1

typedef enum PsNvmFileIdEnum_Tag
{
    //PS_BASE_NVM = 0,
    /*
     * PS info NVM, maintained in psinfonvm.c
    */
    PS_CCM_INFO_NVM = 0,
    PS_CEMM_EMM_INFO_NVM,
    PS_CEMM_COMM_INFO_NVM,
    PS_CEMM_PLMN_INFO_NVM,
    PS_CESM_INFO_NVM,
    PS_UICCCTRL_INFO_NVM,
    PS_CERRC_INFO_NVM,

    PS_INFO_NVM_MAX,

    /*
     * PS config NVM, maintained in psnvm.c
    */
    PS_CESM_PDP_CONFIG_NVM  = PS_INFO_NVM_MAX,
    PS_CESM_PDP_AUTH_CONFIG_NVM,

    PS_MAX_NVM
}PsNvmFileIdEnum;


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/******************************************************************************
 * PS NVM filer header structure
 * by now: 36 bytes
******************************************************************************/
#define PS_NVM_FILE_NAME_SIZE 32

#if (PS_USE_OSA_NVM_FUNC != 1)
typedef struct PsNvmFileHeader_Tag
{
    UINT8  fName[PS_NVM_FILE_NAME_SIZE];
    UINT16 fileBodySize; //file body size, not include size of header;
    UINT8  version;
    UINT8  checkSum;
}PsNvmFileHeader;   //36 bytes
#endif

/*
 * if no NVM file found, use the default value.
*/
typedef void (*PsNvmSetDefaultValueFunc)(void *ctxBuf, UINT16 bufSize);
/*
 * adjust NVM file, from OLD VERSION -> CUR/Latest verion
*/
typedef BOOL (*PsNvmAdjustVersionFunc)(UINT8 oldVer, void *oldCtx, UINT16 oldCtxSize, void *curCtx, UINT16 curCtxSize);
/*
 * 44 bytes
*/
typedef struct PsNvmFileOper_Tag
{
    UINT8   fileId;   //PsNvmFileIdEnum
    UINT8   curVersion;
    UINT16  fileSize;

    UINT8   fileName[PS_NVM_FILE_NAME_SIZE];

    PsNvmSetDefaultValueFunc setDefaultFunc;
    PsNvmAdjustVersionFunc   adjustVerFunc;
}PsNvmFileOper;


/******************************************************************************
 *****************************************************************************
 * Functions
 *****************************************************************************
******************************************************************************/
BOOL PsNvmRead(PsNvmFileIdEnum fileId, void *dataBuf, UINT16 bufSize);
BOOL PsNvmWrite(PsNvmFileIdEnum fileId, void *dataBuf, UINT16 bufSize);
#define PsNvmUpdate(fileId, dataBuf, bufSize) \
    PsNvmWrite(fileId, dataBuf, bufSize)
void PsNvmSaveAll(void);
BOOL PsNvmSave(PsNvmFileIdEnum fileId);


#endif

