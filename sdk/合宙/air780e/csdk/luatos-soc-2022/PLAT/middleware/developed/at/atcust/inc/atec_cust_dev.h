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
#ifndef _ATEC_CUST_DEV_H_
#define _ATEC_CUST_DEV_H_

#include <stdint.h>
#include "at_def.h"
#include DEBUG_LOG_HEADER_FILE
#include "debug_trace.h"


#define  CC_CGSN_VALUE_MIN   0
#define  CC_CGSN_VALUE_MAX   3
#define  CC_CGSN_VALUE_DEF   1

/* ATI */
#define CC_ATI_0_VAL_MIN                     0
#define CC_ATI_0_VAL_MAX                     255
#define CC_ATI_0_VAL_DEFAULT                 0

/* AT&W/AT&W0 */
#define CC_AND_W_0_VAL_MIN                     0
#define CC_AND_W_0_VAL_MAX                     0
#define CC_AND_W_0_VAL_DEFAULT                 0

/* AT&F/AT&F0 */
#define CC_AND_F_0_VAL_MIN                     0
#define CC_AND_F_0_VAL_MAX                     0
#define CC_AND_F_0_VAL_DEFAULT                 0


CmsRetId ccCGMI(const AtCmdInputContext *pAtCmdReq);
CmsRetId ccCGMM(const AtCmdInputContext *pAtCmdReq);
CmsRetId ccGMM(const AtCmdInputContext *pAtCmdReq);
CmsRetId ccCGMR(const AtCmdInputContext *pAtCmdReq);
CmsRetId ccCGSN(const AtCmdInputContext *pAtCmdReq);
CmsRetId ccATI(const AtCmdInputContext *pAtCmdReq);
CmsRetId ccATANDW(const AtCmdInputContext *pAtCmdReq);
CmsRetId ccATANDF(const AtCmdInputContext *pAtCmdReq);
CmsRetId ccATANDV(const AtCmdInputContext *pAtCmdReq);

#endif

/* END OF FILE */
