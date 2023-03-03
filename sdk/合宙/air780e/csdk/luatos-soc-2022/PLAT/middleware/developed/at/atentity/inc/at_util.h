/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: at_util.h
 *
 *  Description: AT utility
 *
 *  History:
 *
 *  Notes:
 *
******************************************************************************/

#ifndef __AT_UTIL_H__
#define __AT_UTIL_H__

#include "cms_util.h"
#include "cms_comm.h"
#include "at_def.h"
#include "atc_reply.h"
#include "atc_decoder.h"

#define ALI_SHA1_KEY_IOPAD_SIZE (64)
#define ALI_SHA1_DIGEST_SIZE    (20)

#define ALI_SHA256_KEY_IOPAD_SIZE   (64)
#define ALI_SHA256_DIGEST_SIZE      (32)

#define ALI_MD5_KEY_IOPAD_SIZE  (64)
#define ALI_MD5_DIGEST_SIZE     (16)

#define ALI_HMAC_USED           (1)
#define ALI_HMAC_NOT_USED       (0)

typedef enum
{
    AT_PARA_OK = 0,
    AT_PARA_ERR,
    AT_PARA_DEFAULT,
    AT_PARA_MAX,
}_AtParaRet;

typedef INT32   AtParaRet;


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/******************************************************************************
 * CmiCnfFuncMapList
 * "CamCmiCnf" handler table
******************************************************************************/
typedef CmsRetId (*CmiCnfHandler)(UINT16 reqHandle, UINT16 rc, void *paras);
typedef struct CmiCnfFuncMapList_Tag
{
    UINT16          primId;
    CmiCnfHandler   cmiCnfHdr;
}CmiCnfFuncMapList;

/******************************************************************************
 * CmiIndFuncMapList
 * "CamCmiInd" handler table
******************************************************************************/
typedef void (*CmiIndHandler)(void *paras);
typedef struct CmiIndFuncMapList_Tag
{
    UINT16          primId;
    CmiIndHandler   cmiIndHdr;
}CmiIndFuncMapList;

/******************************************************************************
 * ApplCnfFuncMapList
 * "applCmsCnf" handler table
******************************************************************************/
typedef CmsRetId (*ApplCnfHandler)(UINT16 reqHandle, UINT16 rc, void *paras);
typedef struct CmsCnfFuncMapList_Tag
{
    UINT16          primId;
    ApplCnfHandler  applCnfHdr;
}ApplCnfFuncMapList;

/******************************************************************************
 * ApplIndFuncMapList
 * "applCmsInd" handler table
******************************************************************************/
typedef CmsRetId (*ApplIndHandler)(UINT16 indHandle, void *paras);
typedef struct CmsIndFuncMapList_Tag
{
    UINT16          primId;
    ApplIndHandler  applIndHdr;
}ApplIndFuncMapList;

/******************************************************************************
 *****************************************************************************
 * FUNCTION/API
 *****************************************************************************
******************************************************************************/
void atByteToBitString(UINT8 *outString, UINT8 n, UINT8 strlen);
BOOL atDataToHexString(UINT8* outString, UINT8* rawData, INT32 rawDataLen);
void atDataToDecString(UINT8 *outString, UINT8 outStringLen, INT64 rawData);

AtParaRet atGetNumValue(AtParamValueCP pAtParaList,
                        UINT32 index,
                        INT32 *pOutValue,
                        INT32 minValue,
                        INT32 maxValue,
                        INT32 defaultValue);

AtParaRet atGetStrValue(AtParamValueCP pAtParaList,
                        UINT32 index,
                        UINT8  *pOutStr,
                        UINT16 maxOutBufLen,
                        UINT16 *pOutStrLen,
                        const CHAR *pDefaultStr);

BOOL atBeEmptyStrParam(AtParamValueCP pAtParaList, UINT32 index);

AtParaRet atGetJsonStrValue(AtParamValueCP pAtParaList,
                            UINT32 index,
                            UINT8  *pOutStr,
                            UINT16 maxOutBufLen,
                            UINT16 *pOutStrLen,
                            const CHAR *pDefaultStr);

AtParaRet atGetMixValue(AtParamValueCP pAtParaList,
                        UINT32  index,
                        UINT32  *extValType,
                        UINT8   *pOutStr,
                        UINT16  maxOutBufLen,
                        UINT16  *pOutStrLen,
                        const CHAR *pDefaultStr,
                        INT32  *pOutValue,
                        INT32  minValue,
                        INT32  maxValue,
                        INT32  defaultValue);

AtParaRet atGetLastMixStrValue(AtParamValueCP pAtParaList,
                               UINT32 index,
                               UINT8  *pOutStr,
                               UINT16 maxOutBufLen,
                               UINT16 *pOutStrLen,
                               const CHAR *pDefaultStr);

AtParaRet atGetStrLength(AtParamValueCP pAtParaList,
                        UINT32 index,
                        UINT16 *pOutStrLen);

BOOL atBeNumericString(const UINT8 *password);

AtParaRet atCheckParaDefaultFlag(const AtCmdInputContext *pAtCmdReqParaPtr, UINT32 index);

BOOL atCheckBitFormat(const UINT8 *input);

/*
 * safe strncat
*/
BOOL atStrnCat(CHAR *pDest, UINT32 destBufSize, CHAR *pNew, UINT32 catLen);

void atSha256(const unsigned char *input, int ilen, unsigned char *output);

void atAliHmacSha1(const unsigned char *input, int ilen, unsigned char *output,const unsigned char *key, int keylen);
void atAliHmacSha256(const unsigned char *input, int ilen, unsigned char *output,const unsigned char *key, int keylen);
void atAliHmacMd5(const unsigned char *input, int ilen, unsigned char *output,const unsigned char *key, int keylen);
BOOL atCheckApnName(UINT8 *apn,UINT16  len);

/*
 *
*/
BOOL atPduInit(AtOutPdu *pAtPdu, UINT16 outSize);

/*
 *
*/
BOOL atPduInitTryHeap(AtOutPdu *pAtPdu, UINT16 outSize);


/*
*/
void atPduPrintf(AtOutPdu *pAtPdu, const CHAR *fmt, ...);

/*
 *
*/
void atPduMemcat(AtOutPdu *pAtPdu, const UINT8 *pData, UINT16 dataLen);



AtParaRet atGetDynamicHexStrValue(AtParamValueCP pAtParaList,
                        UINT32         index,
                        UINT8         **pOutStr,
                        UINT16         *OutLen);


#endif

