/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_general.h
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_PLAT_H__
#define __ATEC_PLAT_H__


#include <stdint.h>
#include "at_util.h"

#include DEBUG_LOG_HEADER_FILE
#include "debug_trace.h"

/* ATE */
#define ATC_E_0_VAL_MIN                     0
#define ATC_E_0_VAL_MAX                     1
#define ATC_E_0_VAL_DEFAULT                 0

/* ATQ */
#define ATC_Q_0_VAL_MIN                     0
#define ATC_Q_0_VAL_MAX                     1
#define ATC_Q_0_VAL_DEFAULT                 0

/* ATV */
#define ATC_V_0_VAL_MIN                     1
#define ATC_V_0_VAL_MAX                     1
#define ATC_V_0_VAL_DEFAULT                 1

/* ATL */
#define ATC_L_0_VAL_MIN                     0
#define ATC_L_0_VAL_MAX                     3
#define ATC_L_0_VAL_DEFAULT                 0

/* ATM */
#define ATC_M_0_VAL_MIN                     0
#define ATC_M_0_VAL_MAX                     2
#define ATC_M_0_VAL_DEFAULT                 0

/* ATS0 */
#define ATC_S0_0_VAL_MIN                     0
#define ATC_S0_0_VAL_MAX                     255
#define ATC_S0_0_VAL_DEFAULT                 0

/* AT&C */
#define ATC_AND_C_0_VAL_MIN                  0
#define ATC_AND_C_0_VAL_MAX                  1
#define ATC_AND_C_0_VAL_DEFAULT              1

/* AT&D */
#define ATC_AND_D_0_VAL_MIN                  0
#define ATC_AND_D_0_VAL_MAX                  2
#define ATC_AND_D_0_VAL_DEFAULT              2


/* ATD */
#define ATC_D_ALL_STR_MAX_LEN                 64
#define ATC_D_GPRS_SC_STR_MAX_LEN             2
#define ATC_D_CALLED_ADDR_STR_MAX_LEN         15
#define ATC_D_L2P_STR_MAX_LEN                 3
#define ATC_D_CID_STR_MAX_LEN                 2
#define ATC_D_STR_DEFAULT                     NULL

/* ATO */
#define ATC_O_0_VAL_MIN                     0
#define ATC_O_0_VAL_MAX                     0
#define ATC_O_0_VAL_DEFAULT                 0

/* ATH */
#define ATC_H_0_VAL_MIN                     0
#define ATC_H_0_VAL_MAX                     0
#define ATC_H_0_VAL_DEFAULT                 0


/* AT+CGMI */
#define ATC_CGMI_0_VAL_MIN                  0
#define ATC_CGMI_0_VAL_MAX                  2
#define ATC_CGMI_0_VAL_DEFAULT              0

/* AT+CGMM */
#define ATC_CGMM_0_VAL_MIN                  0
#define ATC_CGMM_0_VAL_MAX                  2
#define ATC_CGMM_0_VAL_DEFAULT              0

/* AT+CSCS */
#define ATC_CSCS_0_VAL_MIN                  0
#define ATC_CSCS_0_VAL_MAX                  2
#define ATC_CSCS_0_VAL_DEFAULT              0

/* AT+CMUX */
#define ATC_CMUX_0_VAL_MIN                  0
#define ATC_CMUX_0_VAL_MAX                  2
#define ATC_CMUX_0_VAL_DEFAULT              0

/* AT+CMEE */
#define ATC_CMEE_0_VAL_MIN                  0
#define ATC_CMEE_0_VAL_MAX                  2
#define ATC_CMEE_0_VAL_DEFAULT              0

/* AT+CSCS */
#define ATC_CSCS_0_STR_MAX_LEN              10
#define ATC_CSCS_0_STR_DEFAULT              NULL

/* AT+ECURC */
#define ATC_ECURC_0_MAX_PARM_STR_LEN        16
#define ATC_ECURC_0_MAX_PARM_STR_DEFAULT    NULL
#define ATC_ECURC_1_VAL_MIN                 0
#define ATC_ECURC_1_VAL_MAX                 1
#define ATC_ECURC_1_VAL_DEFAULT             0
#define ATC_ECURC_GET_RSP_STR_LEN           128

/* AT+ECURCCFG */
#define ATC_ECURCCFG_0_MAX_PARM_STR_LEN             32
#define ATC_ECURCCFG_0_MAX_PARM_STR_DEFAULT         NULL
#define ATC_ECURCCFG_1_TYPE_VAL_MIN                 0
#define ATC_ECURCCFG_1_TYPE_VAL_MAX                 1
#define ATC_ECURCCFG_1_TYPE_VAL_DEFAULT             1
#define ATC_ECURCCFG_1_DELAY_VAL_MIN                0
#define ATC_ECURCCFG_1_DELAY_VAL_MAX                10000
#define ATC_ECURCCFG_1_DELAY_VAL_DEFAULT            0
#define ATC_ECURCCFG_1_CACHE_VAL_MIN                0
#define ATC_ECURCCFG_1_CACHE_VAL_MAX                1
#define ATC_ECURCCFG_1_CACHE_VAL_DEFAULT            0
#define ATC_ECURCCFG_2_PULSE_DURATION_VAL_MIN       1
#define ATC_ECURCCFG_2_PULSE_DURATION_VAL_MAX       2000
#define ATC_ECURCCFG_2_PULSE_DURATION_VAL_DEFAULT   120
#define ATC_ECURCCFG_3_PULSE_COUNT_VAL_MIN          1
#define ATC_ECURCCFG_3_PULSE_COUNT_VAL_MAX          5
#define ATC_ECURCCFG_3_PULSE_COUNT_VAL_DEFAULT      1


CmsRetId gcAT(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcATE(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcATQ(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcATT(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcATV(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcATL(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcATM(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcATS0(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcCGMI(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcCGMM(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcCSCS(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcCMUX(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcCMEE(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcATANDC(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcATANDD(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcECURC(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcECURCCFG(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcATD(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcATO(const AtCmdInputContext *pAtCmdReq);
CmsRetId gcATH(const AtCmdInputContext *pAtCmdReq);

#endif

/* END OF FILE */
