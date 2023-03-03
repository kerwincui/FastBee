/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_ctwing.h
*
*  Description: Process ctwing access test related AT commands
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_CTWING_H__
#define __ATEC_CTWING_H__

#include "at_util.h"



#define CTW_PARAM_0_SOFT_STR_LEN                 32
#define CTW_PARAM_0_SOFT_STR_DEF                 NULL
#define CTW_PARAM_1_MODULE_STR_LEN             32
#define CTW_PARAM_1_MODULE_STR_DEF             NULL
#define CTW_PARAM_2_CHIPTYPE_STR_LEN             32
#define CTW_PARAM_2_CHIPTYPE_STR_DEF             NULL

#define CTW_PARAM_0_CLIENTID_STR_LEN                 64
#define CTW_PARAM_0_CLIENTID_STR_DEF                 NULL
#define CTW_PARAM_1_USERNAME_STR_LEN             64
#define CTW_PARAM_1_USERNAME_STR_DEF             NULL
#define CTW_PARAM_2_PWD_STR_LEN             72
#define CTW_PARAM_2_PWD_STR_DEF             NULL

#define CTW_PARAM_0_TOPIC_STR_LEN                 128
#define CTW_PARAM_0_TOPIC_STR_DEF                 NULL
#define CTW_PARAM_1_PAYLOAD_STR_LEN             1024
#define CTW_PARAM_1_PAYLOAD_STR_DEF             NULL


CmsRetId ctwPARAM(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwHTTPCFG(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwHTTPREGPARAM(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwHTTPREG(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwHTTPDEREG(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwHTTPSEND(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwTCPCFG(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwTCPREGPARAM(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwTCPREG(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwTCPDEREG(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwTCPSEND(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwMQTTCFG(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwMQTTREGPARAM(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwMQTTREG(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwMQTTDEREG(const AtCmdInputContext *pAtCmdReq);
CmsRetId ctwMQTTSEND(const AtCmdInputContext *pAtCmdReq);


#endif

/* END OF FILE */
