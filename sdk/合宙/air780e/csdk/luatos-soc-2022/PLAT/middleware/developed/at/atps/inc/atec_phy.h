/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename:
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _ATEC_PHY_H
#define _ATEC_PHY_H

#include <stdint.h>
#include "at_util.h"

#include DEBUG_LOG_HEADER_FILE
#include "debug_trace.h"

/* AT^PHYDEBUG */
#define ATC_PHYDBG_0_STR_DEFAULT               NULL
#define ATC_PHYDBG_0_STR_MAX_LEN               16
#define ATC_PHYDBG_1_VAL_MIN                   0
#define ATC_PHYDBG_1_VAL_MAX                   2
#define ATC_PHYDBG_1_VAL_DEFAULT               0
#define ATC_PHYDBG_2_VAL_MIN                   -70
#define ATC_PHYDBG_2_VAL_MAX                   23
#define ATC_PHYDBG_2_VAL_DEFAULT               0
#define ATC_PHYDBG_3_VAL_MIN                   -70
#define ATC_PHYDBG_3_VAL_MAX                   23
#define ATC_PHYDBG_3_VAL_DEFAULT               0
#define ATC_PHYDBG_VAL_MIN                   0
#define ATC_PHYDBG_VAL_MAX                   255
#define ATC_PHYDBG_VAL_DEFAULT               0x7f


CmsRetId phyECPHYCFG(const AtCmdInputContext *pAtCmdReq);

#endif

/* END OF FILE */
