/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_dm.h
*
*  Description: Device manager
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_DM_H__
#define __ATEC_DM_H__

#include "at_util.h"

#define AUTOREGCFG_STR_LEN              128
#define DMCONFIG_CET_RESP_STR_LEN       64
/* AT+AUTOREGCFG */
#define AUTOREGCFG_0_STR_LEN             32
#define AUTOREGCFG_0_STR_DEF             NULL
#define AUTOREGCFG_1_STR_LEN             66
#define AUTOREGCFG_1_STR_DEF             NULL
#define AUTOREGCFG_2_MIN               0
#define AUTOREGCFG_2_MAX               0x7fffffff
#define AUTOREGCFG_2_DEF               0
#define AUTOREGCFG_2_LIFETIME_MIN        1
#define AUTOREGCFG_2_LIFETIME_MAX        0xffff
#define AUTOREGCFG_2_LIFETIME_DEF        0
#define AUTOREGCFG_2_TEST_MIN          0
#define AUTOREGCFG_2_TEST_MAX          1
#define AUTOREGCFG_2_TEST_DEF          0
#define AUTOREGCFG_2_APPKEY_STR_LEN      11
#define AUTOREGCFG_2_APPKEY_STR_DEF      NULL
#define AUTOREGCFG_2_SECRET_STR_LEN    33
#define AUTOREGCFG_2_SECRET_STR_DEF    NULL

/* AT+DMCONFIG */
#define DMCONFIG_0_MIN                 0
#define DMCONFIG_0_MAX                 1
#define DMCONFIG_0_DEF                 0
#define DMCONFIG_1_MIN               0
#define DMCONFIG_1_MAX               0xFFFF//large than 24x60 minutes
#define DMCONFIG_1_DEF               0
#define DMCONFIG_2_STR_LEN             12
#define DMCONFIG_2_STR_DEF             NULL
#define DMCONFIG_3_STR_LEN           33
#define DMCONFIG_3_STR_DEF             NULL
#define DMCONFIG_4_MIN               0
#define DMCONFIG_4_MAX               1
#define DMCONFIG_4_DEF               0

CmsRetId dmAUTOREGCFG(const AtCmdInputContext *pAtCmdReq);

#endif

/* END OF FILE */
