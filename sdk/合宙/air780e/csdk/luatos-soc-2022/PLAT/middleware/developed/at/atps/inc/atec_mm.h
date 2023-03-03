/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_mm.h
*
*  Description: Macro definition for network service related AT commands
*
*  History:
*
*  Notes:
*
******************************************************************************/

#ifndef _ATEC_MM_H
#define _ATEC_MM_H

/* AT+CREG */
#define ATC_CREG_0_VAL_MIN                      0
#define ATC_CREG_0_VAL_MAX                      3
#define ATC_CREG_0_VAL_DEFAULT                  0


/* AT+CSQ */
#define ATC_CSQ_0_VAL_MIN                       0
#define ATC_CSQ_0_VAL_MAX                       2
#define ATC_CSQ_0_VAL_DEFAULT                   0

/* AT+COPS */
#define ATC_COPS_0_MODE_VAL_MIN                 0
#define ATC_COPS_0_MODE_VAL_MAX                 4
#define ATC_COPS_0_MODE_VAL_DEFAULT             0   /* auto */
#define ATC_COPS_1_FORMAT_VAL_MIN               0
#define ATC_COPS_1_FORMAT_VAL_MAX               2
#define ATC_COPS_1_FORMAT_VAL_DEFAULT           3   /* invalid */
#define ATC_COPS_2_OPER_STR_DEFAULT             NULL
#define ATC_COPS_2_OPER_STR_MAX_LEN             16
#define ATC_COPS_3_ACT_VAL_MIN                  7
#define ATC_COPS_3_ACT_VAL_MAX                  7
#define ATC_COPS_3_ACT_VAL_DEFAULT              7   /* E-UTRAN */
#define ATC_COPS_GUARD_TIMER                    60  /* second */

/* save parameters for Manual PLMN select: AT+COPS=<mode>,<format>,<plmnName>,<act> */
typedef struct AtcCopsManulSelectInfo_Tag
{
    UINT8           mode;
    UINT8           format;
    UINT8           act;
    UINT8           plmnName[ATC_COPS_2_OPER_STR_MAX_LEN + CMS_NULL_CHAR_LEN];
}AtcCopsManulSelectInfo;

typedef struct AtcCopsInfo_Tag
{
    UINT8                   plmnNum;
    BOOL                    bPendingManulPlmnSelect;
    AtcCopsManulSelectInfo  manulSelectInfo;
    CmiNumericPlmn          *plmnList;
}AtcCopsInfo;

/* AT+CESQ */
#define ATC_CESQ_0_VAL_MIN                      0
#define ATC_CESQ_0_VAL_MAX                      2
#define ATC_CESQ_0_VAL_DEFAULT                  0

/* AT+CPSMS */
#define ATC_CPSMS_0_MODE_VAL_MIN                0
#define ATC_CPSMS_0_MODE_VAL_MAX                2
#define ATC_CPSMS_0_MODE_VAL_DEFAULT            0
#define ATC_CPSMS_1_PRAU_STR_DEFAULT            NULL
#define ATC_CPSMS_1_PRAU_STR_MAX_LEN            8
#define ATC_CPSMS_2_GPRS_STR_DEFAULT            NULL
#define ATC_CPSMS_2_GPRS_STR_MAX_LEN            8
#define ATC_CPSMS_3_PTAU_STR_DEFAULT            "00110100"  /* default 20 hours */
#define ATC_CPSMS_3_PTAU_STR_MAX_LEN            8
#define ATC_CPSMS_4_ACT_STR_DEFAULT             "00100101"  /* default 5 minutes */
#define ATC_CPSMS_4_ACT_STR_MAX_LEN             8

/* AT+CEDRXS */
#define ATC_CEDRXS_0_MODE_VAL_MIN               0
#define ATC_CEDRXS_0_MODE_VAL_MAX               3
#define ATC_CEDRXS_0_MODE_VAL_DEFAULT           0
#define ATC_CEDRXS_1_VAL_MIN                    0
#define ATC_CEDRXS_1_VAL_MAX                    4
#define ATC_CEDRXS_1_VAL_DEFAULT                4
#define ATC_CEDRXS_2_STR_DEFAULT                NULL
#define ATC_CEDRXS_2_STR_MAX_LEN                4

/* AT+CEDRXRDP */
#define ATC_CEDRXRDP_0_VAL_MIN                  0
#define ATC_CEDRXRDP_0_VAL_MAX                  2
#define ATC_CEDRXRDP_0_VAL_DEFAULT              0

/* AT+CCIOTOPT */
#define ATC_CCIOTOPT_0_VAL_MIN                  0
#define ATC_CCIOTOPT_0_VAL_MAX                  3
#define ATC_CCIOTOPT_0_VAL_DEFAULT              7   //CMI_MM_CIOT_OPT_RPT_MODE_NOT_PRESENT
#define ATC_CCIOTOPT_1_VAL_MIN                  0   /* 0 - NO OPT, 1- CP, 2 - UP, 3-UP&CP */
#define ATC_CCIOTOPT_1_VAL_MAX                  3
#define ATC_CCIOTOPT_1_VAL_DEFAULT              0
#define ATC_CCIOTOPT_2_VAL_MIN                  0
#define ATC_CCIOTOPT_2_VAL_MAX                  2
#define ATC_CCIOTOPT_2_VAL_DEFAULT              0

/* AT+CCLK */
#define ATC_CCLK_0_STR_DEFAULT                  NULL
#define ATC_CCLK_0_STR_MAX_LEN                  32

/* AT+CTZR */
#define ATC_CTZR_0_VAL_MIN                      0
#define ATC_CTZR_0_VAL_MAX                      3
#define ATC_CTZR_0_VAL_DEFAULT                  0

/*
 * 0 disable time zone change event reporting.
 * 1 Enable time zone change event reporting by unsolicited result code +CTZV: <tz>.
 * 2 Enable extended time zone and local time reporting by unsolicited result code
 *   +CTZE: <tz>,<dst>,[<time>].
 * 3 Enable extended time zone and universal time reporting by unsolicited result code
 *   +CTZEU: <tz>,<dst>,[<utime>].
*/
typedef enum AtcCTZRRptValue_Enum
{
    ATC_CTZR_DISABLE_RPT = 0,
    ATC_CTZR_RPT_TZ,
    ATC_CTZR_RPT_LOCAL_TIME,
    ATC_CTZR_RPT_UTC_TIME
}AtcCTZRRptValue;

/* AT+CTZU */
#define ATC_CTZU_0_VAL_MIN                   0
#define ATC_CTZU_0_VAL_MAX                   1
#define ATC_CTZU_0_VAL_DEFAULT               0

/*
 * <onoff>: integer type value indicating
 * 0 Disable automatic time zone update via NITZ.
 * 1 Enable automatic time zone update via NITZ.
*/
typedef enum AtcCTZUUpdateValue_Enum
{
    ATC_CTZU_DISABLE_UPDATE_TZ_VIA_NITZ = 0,
    ATC_CTZU_ENABLE_UPDATE_TZ_VIA_NITZ
}AtcCTZUUpdateValue;

/*AT+ECCESQ*/
#define ATC_ECCESQ_0_VAL_MIN                0
#define ATC_ECCESQ_0_VAL_MAX                2
#define ATC_ECCESQ_0_VAL_DEFAULT            0

/*
 * AT+ECCESQ=<n>
 * <n>, report level
 * 0: disable URC (unsolicited result code)
 * 1: report, +CESQ: <rxlev>,<ber>,<rscp>,<ecno>,<rsrq>,<rsrp>, as 27.007
 * 2: report, +ECCESQ: RSRP,<rsrp>,RSRQ,<rsrq>,SNR,<snr>
*/
typedef enum AtcECCESQRptValue_Enum
{
    ATC_ECCESQ_DISABLE_RPT = 0,
    ATC_ECCESQ_RPT_CESQ,
    ATC_ECCESQ_RPT_ECCESQ
}AtcECCESQRptValue;


/*AT+ECPSMR*/
#define ATC_ECPSMR_0_VAL_MIN                0
#define ATC_ECPSMR_0_VAL_MAX                1
#define ATC_ECPSMR_0_VAL_DEFAULT            0

/*
 * AT+ECPSMR=<n>
 * <n>, bitmap of report level
 * bit[0]: 1 enable unsolicited result code +ECPSMR
 *         0 disable unsolicited result code
*/
typedef enum AtcECPSMRValue_Enum
{
    ATC_ECPSMR_DISABLE = 0,
    ATC_ECPSMR_ENABLE,
}AtcECPSMRValue;

/*
 * AT+ECPTWEDRXS=2,XX,XX
 * <n>, bitmap of report level
 * bit[0]: 1 enable unsolicited result code +ECPTWEDRXP
 *         0 disable unsolicited result code
*/
typedef enum AtcECPTWEDRXSValue_Enum
{
    ATC_ECPTWEDRXS_DISABLE = 0,
    ATC_ECPTWEDRXS_ENABLE
}AtcNPTWEDRXSValue;


/*AT+ECEMMTIME*/
#define ATC_ECEMMTIME_0_VAL_MIN                0
#define ATC_ECEMMTIME_0_VAL_MAX                7
#define ATC_ECEMMTIME_VAL_DEFAULT              0

/*
 * AT+ECEMMTIME=<n>
 * <n>, bitmap of report level
 * bit[0]: 1 enable unsolicited result code T3346
 *           0 disable unsolicited result code T3346
 * bit[1]: 1 enable unsolicited result code T3448
 *           0 disable unsolicited result code T3448
 * bit[2]: 1 enable unsolicited result code T3412&extT3412
 *           0 disable unsolicited result code T3412&extT3412
*/
#define ATC_ECEMMTIME_T3346_BIT_OFFSET         0
#define ATC_ECEMMTIME_T3448_BIT_OFFSET         1
#define ATC_ECEMMTIME_T3412_BIT_OFFSET         2



/* AT+ECPTWEDRXS */
#define ATC_ECPTWEDRXS_0_MODE_VAL_MIN                0
#define ATC_ECPTWEDRXS_0_MODE_VAL_MAX                3
#define ATC_ECPTWEDRXS_0_MODE_VAL_DEFAULT            0
#define ATC_ECPTWEDRXS_1_VAL_MIN                     0
#define ATC_ECPTWEDRXS_1_VAL_MAX                     5
#define ATC_ECPTWEDRXS_1_VAL_DEFAULT                 4
#define ATC_ECPTWEDRXS_2_STR_DEFAULT                 NULL
#define ATC_ECPTWEDRXS_2_STR_MAX_LEN                 4
#define ATC_ECPTWEDRXS_3_STR_DEFAULT                 NULL
#define ATC_ECPTWEDRXS_3_STR_MAX_LEN                 4




CmsRetId  mmCREG(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmCOPS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmCSQ(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmCESQ(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmCPSMS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmCEDRXS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmCEDRXRDP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmCCIOTOPT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmCCIOTOPTI(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmCRCES(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmCCLK(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmCTZR(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmCTZU(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmECPLMNS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmECCESQS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmECPSMR(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmECPTWEDRXS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmECEMMTIME(const AtCmdInputContext *pAtCmdReq);
CmsRetId  mmECPLMNRESELECT(const AtCmdInputContext *pAtCmdReq);
AtcCopsInfo  *mmGetCopsInfo(void);
CmsRetId  mmGetPlmnNumericStr(UINT8 plmnFormat, UINT8 *plmnName, UINT8 *plmnNumericStr);

#endif

