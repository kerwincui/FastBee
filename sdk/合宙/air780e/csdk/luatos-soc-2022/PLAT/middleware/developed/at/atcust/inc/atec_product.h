/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_product.h
*
*  Description: production related command
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_PRODUCT_H__
#define __ATEC_PRODUCT_H__

#include "at_util.h"


/* AT+ECSLEEP */
#define ECSLEEP_HANDLE_CREATED      0x1
#define ECSLEEP_HANDLE_NOT_CREATED  0x0

#define ECSLEEP_HIB2  0x0
#define ECSLEEP_HIB1  0x1
#define ECSLEEP_SLP2  0x2
#define ECSLEEP_SLP1  0x3
#define ECSLEEP_OFF   0x4

#define  CC_ECSLEEP_VALUE_MIN   0
#define  CC_ECSLEEP_VALUE_MAX   4
#define  CC_ECSLEEP_VALUE_DEF   0

/* AT+ECSAVEFAC */
#define SAVEFAC_0_STR_LEN             16
#define SAVEFAC_0_STR_BUF_LEN         (SAVEFAC_0_STR_LEN +1)
#define SAVEFAC_0_STR_DEF             NULL

/* AT+ECIPR */
#define ATC_ECIPR_MAX_PARM_STR_LEN             32
#define ATC_ECIPR_MAX_PARM_STR_DEFAULT         NULL

/* AT+ECNPICFG */
#define ATC_ECNPICFG_MAX_PARM_STR_LEN             32
#define ATC_ECNPICFG_MAX_PARM_STR_DEFAULT         NULL

#define ATC_ECNPICFG_RFCALI_VAL_MIN                0
#define ATC_ECNPICFG_RFCALI_VAL_MAX                1
#define ATC_ECNPICFG_RFCALI_VAL_DEFAULT            0  /* full functionality */

#define ATC_ECNPICFG_RFNST_VAL_MIN                0
#define ATC_ECNPICFG_RFNST_VAL_MAX                1
#define ATC_ECNPICFG_RFNST_VAL_DEFAULT            0  /* full functionality */

/* AT+ECPRODMODE */
#define ATC_ECPRODMODE_MAX_PARM_STR_LEN             32

/* AT+ECATE */
#define ATC_ECATE_0_VAL_MIN                     0
#define ATC_ECATE_0_VAL_MAX                     1
#define ATC_ECATE_0_VAL_DEFAULT                 0

/* AT+ECVERSION */
#define ATC_ECVERSION_0_VAL_MIN                     0
#define ATC_ECVERSION_0_VAL_MAX                     0xffffffff
#define ATC_ECVERSION_0_VAL_DEFAULT                 0

/* AT+ECGMDATA */
#define ATC_ECGMDATA_MAX_PARM_STR_LEN             2048
#define ATC_ECGMDATA_MAX_PARM_STR_DEFAULT         NULL

CmsRetId pdECRFTEST(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdECSLEEP(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdECSAVEFAC(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdECIPR(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdNPICFG(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdECRFSTAT(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdECPRODMODE(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdECATE(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdECGMDATA(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdECVERSION(const AtCmdInputContext *pAtCmdReq);

#endif

/* END OF FILE */
