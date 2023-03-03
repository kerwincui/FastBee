/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_ref_ps.h
*
*  Description: Process protocol related AT CMD
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _ATEC_REF_PS_H_
#define _ATEC_REF_PS_H_

#include "at_util.h"

/* AT+QENG */
#define MAX_QENG_PARA_LEN                       20
#define ATC_QENG_STR_DEFAULT                    NULL

/* AT+QICSGP */
#define ATC_QICSGP_0_CONTEXTID_VAL_MIN          1
#define ATC_QICSGP_0_CONTEXTID_VAL_MAX          15
#define ATC_QICSGP_0_CONTEXTID_VAL_DEF          1

#define ATC_QICSGP_1_CONTEXTTYPE_VAL_MIN        1
#define ATC_QICSGP_1_CONTEXTTYPE_VAL_MAX        3
#define ATC_QICSGP_1_CONTEXTTYPE_VAL_DEF        1

#define ATC_QICSGP_2_APN_VAL_DEF                PNULL
#define ATC_QICSGP_2_APN_STR_MAX_LEN            100

#define ATC_QICSGP_3_UNAME_VAL_DEF              PNULL
#define ATC_QICSGP_3_UNAME_STR_MAX_LEN          (CMI_PS_MAX_AUTH_STR_LEN)

#define ATC_QICSGP_4_UPSWD_VAL_DEF              PNULL
#define ATC_QICSGP_4_UPSWD_STR_MAX_LEN          (CMI_PS_MAX_AUTH_STR_LEN)

#define ATC_QICSGP_5_AUTHTYPE_VAL_MIN           0
#define ATC_QICSGP_5_AUTHTYPE_VAL_MAX           3
#define ATC_QICSGP_5_AUTHTYPE_VAL_DEF           0

/* AT+QIACT */
#define ATC_QIACT_0_CONTEXTID_VAL_MIN           1
#define ATC_QIACT_0_CONTEXTID_VAL_MAX           15
#define ATC_QIACT_0_CONTEXTID_VAL_DEF           1

/* AT+QIDEACT */
#define ATC_QIDEACT_0_CONTEXTID_VAL_MIN         1
#define ATC_QIDEACT_0_CONTEXTID_VAL_MAX         15
#define ATC_QIDEACT_0_CONTEXTID_VAL_DEF         1

/* AT+QWIFISCAN */
#define ATC_QWIFISCAN_0_TIME_VAL_MIN            4000
#define ATC_QWIFISCAN_0_TIME_VAL_MAX            255000
#define ATC_QWIFISCAN_0_TIME_VAL_DEF            12000

#define ATC_QWIFISCAN_1_ROUND_VAL_MIN           1
#define ATC_QWIFISCAN_1_ROUND_VAL_MAX           3
#define ATC_QWIFISCAN_1_ROUND_VAL_DEF           1

#define ATC_QWIFISCAN_2_MAXBSSIDNUM_VAL_MIN     4
#define ATC_QWIFISCAN_2_MAXBSSIDNUM_VAL_MAX     10
#define ATC_QWIFISCAN_2_MAXBSSIDNUM_VAL_DEF     5

#define ATC_QWIFISCAN_3_SCANTIMEOUT_VAL_MIN     1
#define ATC_QWIFISCAN_3_SCANTIMEOUT_VAL_MAX     255
#define ATC_QWIFISCAN_3_SCANTIMEOUT_VAL_DEF     5

#define ATC_QWIFISCAN_4_PRIORITY_VAL_MIN        0   //data preferred
#define ATC_QWIFISCAN_4_PRIORITY_VAL_MAX        1   //wifiscan preferred
#define ATC_QWIFISCAN_4_PRIORITY_VAL_DEF        0

/* AT+QPOWD */
#define ATC_QPOWD_0_CONTEXTID_VAL_MIN           0
#define ATC_QPOWD_0_CONTEXTID_VAL_MAX           1
#define ATC_QPOWD_0_CONTEXTID_VAL_DEF           0


/* AT+QIREGAPP */
#define ATC_QIREGAPP_0_APN_VAL_DEF                PNULL
#define ATC_QIREGAPP_0_APN_VAL_MAX_LEN            100

#define ATC_QIREGAPP_1_UNAME_VAL_DEF              PNULL
#define ATC_QIREGAPP_1_UNAME_STR_MAX_LEN          (CMI_PS_MAX_AUTH_STR_LEN)

#define ATC_QIREGAPP_2_UPSWD_VAL_DEF              PNULL
#define ATC_QIREGAPP_3_UPSWD_STR_MAX_LEN          (CMI_PS_MAX_AUTH_STR_LEN)

/* AT+QGDCNT */
#define ATC_QGDCNT_0_VAL_MIN                   0
#define ATC_QGDCNT_0_VAL_MAX                   1
#define ATC_QGDCNT_0_VAL_DEFAULT               0


/* AT+QAUGDCNT */
#define ATC_QAUGDCNT_0_VAL_MIN                   0
#define ATC_QAUGDCNT_0_VAL_MAX                   65535
#define ATC_QAUGDCNT_0_VAL_DEFAULT               0

/* AT+QCFG */
#define  QCFG_0_TYPE_STR_MAX_LEN        32
#define  QCFG_0_TYPE_STR_DEF_VAL        NULL

#define  QCFG_1_TYPE_VAL_MIN            0
#define  QCFG_1_TYPE_VAL_MAX            1
#define  QCFG_1_TYPE_VAL_DEF            (QCFG_1_TYPE_VAL_MIN)



typedef enum QCFG_URCCACHE_STATE_Enum
{
    QCFG_URCCACHE_DISABLE = 0,
    QCFG_URCCACHE_ENABLE  = 1,
}QCFG_URCCACHE_STATE;


CmsRetId refPsQCCID(const AtCmdInputContext *pAtCmdReq);

CmsRetId  refPsQENG(const AtCmdInputContext *pAtCmdReq);
CmsRetId  refPsQCELL(const AtCmdInputContext *pAtCmdReq);
CmsRetId  refPsQWIFISCAN(const AtCmdInputContext *pAtCmdReq);
CmsRetId  refPsQPOWD(const AtCmdInputContext *pAtCmdReq);

CmsRetId  refPsACT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  refPsDEACT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  refPsQGDCNT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  refPsQAUGDCNT(const AtCmdInputContext *pAtCmdReq);

CmsRetId  refPsREGAPP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  refPsCSGP(const AtCmdInputContext *pAtCmdReq);

CmsRetId  refPsQSPN(const AtCmdInputContext *pAtCmdReq);

CmsRetId  refPsQCFG(const AtCmdInputContext *pAtCmdReq);

#endif

