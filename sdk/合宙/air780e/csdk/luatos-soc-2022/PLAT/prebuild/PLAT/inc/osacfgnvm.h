#ifndef __OSA_CFG_NVM_H__
#define __OSA_CFG_NVM_H__

/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017, All rights reserved by AirM2M Ltd.
 File name:      - osacfgnvm.h
 Description:    - OSA EC config NVM file operation code
 History:        - 2021/04/06, Originated by Jason
 ******************************************************************************
******************************************************************************/
#ifdef WIN32
#include "winsys.h"
#else
#include "commontypedef.h"
#endif

#include "osanvm.h"

/******************************************************************************
 ******************************************************************************
 1. "NVMCFG" use the struture:
   a> TV: LF: Length Flag: 0, T: Parameter Type, V: Value
    15  14    12 11              0
    +-----+-----+----------------+
    |LF(0)|RSVD |ParamId(12 bits)|
    +-----+-----+----------------+
    |     Value (16 bits)        |
    +----------------------------+
   b> TLV: LF: Length Flag: 1, T: Value type, L: Value byte length, V: Value
    15  14    12 11              0
    +-----+-----+----------------+
    |LF(1)|RSVD |ParamId(12 bits)|
    +-----+-----+----------------+
    |Value byte length (16 bits) |
    +----------------------------+
    \           Value            \
    +----------------------------+
 2. The 3 "RSVD" bits must set to 0, and used for future;
 3. The "paramId" is 12 bits, with the range: [0 ~ 4095]
   a> [0 ~ 1023], reserved for PS
   b> [1024 ~ 1535], reserved for middle ware
 ******************************************************************************
******************************************************************************/



/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/

/*
 * 12 bits parameter ID
*/
#define OSA_CFG_NVM_MAX_PARAM_ID        0xFFF

/*
 * TV type, paramter value max size, 2 bytes
*/
#define OSA_CFG_TV_PARAM_VALUE_MAX_SIZE     2

/*
 * update config NVM, when read/update, need to reserve some more buffer
*/
#define OSA_CFG_UPDATE_NVM_RSVD_LEN     128


/*
*/
#define OSA_CFG_SET_DEFAULT_TV_VALUE(paramId, value)    {(paramId), (value)}



/******************************************************************************
 *****************************************************************************
 * STRUCT/ENUM
 *****************************************************************************
******************************************************************************/

typedef enum OsaCfgType_Enum
{
    OSA_CFG_TV_TYPE     = 0,
    OSA_CFG_TLV_TYPE    = 1 //OsaCfgParam->lf = 1
}OsaCfgType;


/******************************************************************************
 1. "NVMCFG" use the struture:
   a> TV: LF: Length Flag: 0, T: Parameter Type, V: Value
    15  14    12 11              0
    +-----+-----+----------------+
    |LF(0)|RSVD |ParamId(12 bits)|
    +-----+-----+----------------+
    |     Value (16 bits)        |
    +----------------------------+
   b> TLV: LF: Length Flag: 1, T: Value type, L: Value byte length, V: Value
    15  14    12 11              0
    +-----+-----+----------------+
    |LF(1)|RSVD |ParamId(12 bits)|
    +-----+-----+----------------+
    |Value byte length (16 bits) |
    +----------------------------+
    \           Value            \
    +----------------------------+
******************************************************************************/
typedef struct OsaCfgParam_Tag
{
    UINT16  paramId : 12;
    UINT16  rsvd    : 3;    //must set to 0
    UINT16  lf      : 1;    //length flag

    union
    {
        UINT8   tvVal[2];
        UINT16  tlvLen;
    }valOrLen;              /* if lf == OSA_CFG_TV_TYPE, this is the value, and must limited in 2 bytes
                             * if lf == OSA_CFG_TLV_TYPE, this is the value length
                            */

    UINT8   tlvVal[];       /* if lf == OSA_CFG_TLV_TYPE, this is the value of this parameter */
}OsaCfgParam;

typedef struct OsaCfgTVTypeValue_Tag
{
    UINT16  paramId;
    UINT16  val;
}OsaCfgTVTypeValue;


/*
 * Read/parse every parameter in the CFG NVM file
*/
typedef struct OsaCfgParseInfo_Tag
{
    OsaNvmBodyInfo  *pBodyInfo;

    UINT16          parseOffset;       /* parse position */
    UINT16          rsvd;
}OsaCfgParseInfo;

/******************************************************************************
 *****************************************************************************
 * FUNC
 *****************************************************************************
******************************************************************************/

/**
  \fn           OsaNvmRet OsaCfgNvmGetNextParam(OsaCfgParam **pCfgParam, OsaCfgParseInfo *pNvmParseInfo)
  \brief        Get next config parameters info from NVM body info, used when parse all CFG NVM file
  \param[out]   pCfgParam       return cfg parameter info
  \param[in]    pNvmParseInfo   CFG NVM parse info
  \returns      OsaNvmRet
  \ Note: a) if all parsed, return OSA_NVM_SUCC, and "*pCfgParam" set to PNULL
  \       b) if CFG NVM file error, return ERR, and caller should delete this cfg file
*/
OsaNvmRet OsaCfgNvmGetNextParam(OsaCfgParam **pCfgParam, OsaCfgParseInfo *pNvmParseInfo);

/**
  \fn           void OsaCfgNvmRemoveParamFromParseInfo(OsaCfgParam *pRmCfg, OsaCfgParseInfo *pNvmParseInfo)
  \brief        Remove config parameters info from NVM body info, and update the parse offset
  \param[out]   pRmCfg          config parameter info which need remove
  \param[in]    pNvmParseInfo   CFG NVM parse info
  \returns      void
*/
void OsaCfgNvmRemoveParamFromParseInfo(OsaCfgParam *pRmCfg, OsaCfgParseInfo *pNvmParseInfo);


/**
  \fn           OsaCfgNvmUpdateParam(UINT16 paramId, UINT8 cfgType, UINT16 paramLen, void *pParamValue, OsaNvmBodyInfo *pNvmBufInfo)
  \brief        Update one configuration into NVM body, note: not write to flash in this API
  \param[in]    paramId         12 bits parameter ID
  \param[in]    cfgType         TV or TLV type
  \param[in]    paramLen        parameter length
  \param[in]    pParamValue     parameter value
  \param[in]    pNvmBodyInfo    NVM body buffer info
  \returns      INT32   //OsaNvmRet
*/
OsaNvmRet OsaCfgNvmUpdateParam(UINT16 paramId, UINT8 cfgType, UINT16 paramLen, void *pParamValue, OsaNvmBodyInfo *pNvmBodyInfo);


/**
  \fn           OsaNvmRet OsaCfgNvmAddParam(UINT16 paramId, UINT8 cfgType, UINT16 paramLen, void *pParamValue, OsaNvmBodyInfo *pNvmBodyInfo)
  \brief        Add one configuration into end of NVM body
  \param[in]    paramId         12 bits parameter ID
  \param[in]    cfgType         TV or TLV type
  \param[in]    paramLen        parameter length
  \param[in]    pParamValue     parameter value
  \param[in]    pNvmBodyInfo    NVM body buffer info
  \returns      INT32   //OsaNvmRet
  \Note: The caller must make sure no this cfg already in the NVM
*/
OsaNvmRet OsaCfgNvmAddParam(UINT16 paramId, UINT8 cfgType, UINT16 paramLen, void *pParamValue, OsaNvmBodyInfo *pNvmBodyInfo);



#endif

