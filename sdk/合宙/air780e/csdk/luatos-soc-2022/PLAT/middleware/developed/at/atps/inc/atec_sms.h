/******************************************************************************

*(C) Copyright 2018 AirM2M Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_sms.h
*
*  Description: SMS AT commands implementation
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _ATEC_SMS_H
#define _ATEC_SMS_H

#include "commontypedef.h"
#include "ps_sms_if.h"

/******************************************************************************
 *****************************************************************************
 * AT SMS COMMON MARCO
 *****************************************************************************
******************************************************************************/
#define ATC_MAX_SMS_TDPU_SIZE           (232)
#define ATC_SMS_RECORD_MAX_NUMBER       254        /* The total number of the saved SMS message in SIM */


typedef enum atecMtSmsType_enum
{
    ATEC_MT_DELIVER_SMS       = 0,
    ATEC_MT_SUBMIT_REPORT_SMS = 1,
    ATEC_MT_STATUS_REPORT_SMS = 2
}atecMtSmsType;

typedef enum atecMoSmsType_enum
{
    ATEC_MO_DELIVER_REPORT_SMS = 0,
    ATEC_MO_SUBMIT_SMS         = 1,
    ATEC_MO_COMMAND_SMS        = 2,
}atecMoSmsType;


#define ATEC_MT_SMS_TYPE_MASK                   0x03       /* SMS MT Message-Type Indicator mask */
#define ATEC_M0_SMS_TYPE_MASK                   0x03       /* SMS MO Message-Type Indicator mask */


/* AT+CSMS */
#define ATC_CSMS_0_SERVICE_VAL_MIN              0
#define ATC_CSMS_0_SERVICE_VAL_MAX              127
#define ATC_CSMS_0_SERVICE_VAL_DEFAULT          0

/* AT+CPMS */
#define ATC_CPMS_0_MEM1_STR_MAX_LEN             3
#define ATC_CPMS_0_MEM1_STR_DEFAULT             NULL
#define ATC_CPMS_1_MEM2_STR_MAX_LEN             3
#define ATC_CPMS_1_MEM2_STR_DEFAULT             NULL
#define ATC_CPMS_2_MEM3_STR_MAX_LEN             3
#define ATC_CPMS_2_MEM3_STR_DEFAULT             NULL

/* Ref TS-27.005, 3.1 parameter Definitions for <mem1>/<mem2>/<mem3> */
#define ATC_CPMS_PARAM_STR_BM                   "BM"
#define ATC_CPMS_PARAM_STR_ME                   "ME"
#define ATC_CPMS_PARAM_STR_MT                   "MT"
#define ATC_CPMS_PARAM_STR_SM                   "SM"
#define ATC_CPMS_PARAM_STR_TA                   "TA"
#define ATC_CPMS_PARAM_STR_SR                   "SR"

/* AT+CSCA */
#define ATC_CSCA_0_ADDR_STR_MAX_LEN             ((CMI_SMS_MAX_LENGTH_OF_ADDRESS_VALUE + 1) * 4)
#define ATC_CSCA_0_ADDR_STR_DEFAULT             NULL
#define ATC_CSCA_1_TYPE_VAL_MIN                 0
#define ATC_CSCA_1_TYPE_VAL_MAX                 255
#define ATC_CSCA_1_TYPE_VAL_DEFAULT             PSIL_SMS_TOA_NUMBER_INTERNATIONAL

/* AT+CNMI */
#define ATC_CNMI_0_MODE_VAL_MIN                 0
#define ATC_CNMI_0_MODE_VAL_MAX                 3
#define ATC_CNMI_0_MODE_VAL_DEFAULT             0
#define ATC_CNMI_1_MT_VAL_MIN                   0
#define ATC_CNMI_1_MT_VAL_MAX                   3
#define ATC_CNMI_1_MT_VAL_DEFAULT               0
#define ATC_CNMI_2_BM_VAL_MIN                   0
#define ATC_CNMI_2_BM_VAL_MAX                   3
#define ATC_CNMI_2_BM_VAL_DEFAULT               0
#define ATC_CNMI_3_DS_VAL_MIN                   0
#define ATC_CNMI_3_DS_VAL_MAX                   2
#define ATC_CNMI_3_DS_VAL_DEFAULT               0
#define ATC_CNMI_4_BFR_VAL_MIN                  0
#define ATC_CNMI_4_BFR_VAL_MAX                  1
#define ATC_CNMI_4_BFR_VAL_DEFAULT              0

/* AT+CMGF */
#define ATC_CMGF_0_MODE_VAL_MIN                 0
#define ATC_CMGF_0_MODE_VAL_MAX                 1
#define ATC_CMGF_0_MODE_VAL_DEFAULT             0

/* AT+CMGL */
#define ATC_CMGL_0_MODE_STR_MAX_LEN             11
#define ATC_CMGL_0_MODE_STR_DEFAULT             "REC UNREAD"
#define ATC_CMGL_0_STATE_VAL_MIN                0
#define ATC_CMGL_0_STATE_VAL_MAX                4
#define ATC_CMGL_0_STATE_VAL_DEFAULT            0

/* AT+CMGR */
#define ATC_CMGR_0_MSG_VAL_MIN                  0
#define ATC_CMGR_0_MSG_VAL_MAX                  ATC_SMS_RECORD_MAX_NUMBER
#define ATC_CMGR_0_MSG_VAL_DEFAULT              0

/* AT+CMGS */
#define ATC_CMGS_0_PDU_LENGTH_MIN               1
#define ATC_CMGS_0_PDU_LENGTH_MAX               PSIL_SMS_MAX_PDU_SIZE
#define ATC_CMGS_0_PDU_LENGTH_DEFAULT           1


#define ATC_ADDR_STR_MAX_LEN                    ((CMI_SMS_MAX_LENGTH_OF_ADDRESS_VALUE + 1) * 4)
#define ATC_ADDR_STR_DEFAULT                    PNULL
#define ATC_ADDR_TYPE_OCT_MIN                   0
#define ATC_ADDR_TYPE_OCT_MAX                   255
#define ATC_ADDR_TYPE_OCT_DEFAULT               PSIL_SMS_TOA_NUMBER_UNKNOWN

/* AT+CMGW for PDU mode */
#define ATC_CMGW_0_PDU_LENGTH_MIN               1
#define ATC_CMGW_0_PDU_LENGTH_MAX               PSIL_SMS_MAX_PDU_SIZE
#define ATC_CMGW_0_PDU_LENGTH_DEFAULT           1
#define ATC_CMGW_1_STAT_VAL_MIN                 CMI_SMS_STOR_STATUS_REC_UNREAD
#define ATC_CMGW_1_STAT_VAL_MAX                 CMI_SMS_STOR_STATUS_STO_SENT
#define ATC_CMGW_1_STAT_VAL_DEFAULT             CMI_SMS_STOR_STATUS_STO_UNSENT
/* AT+CMGW for Text mode */
#define ATC_CMGW_0_ADDR_LENGTH_MAX              ATC_ADDR_STR_MAX_LEN
#define ATC_CMGW_0_ADDR_LENGTH_DEFAULT          ATC_ADDR_STR_DEFAULT
#define ATC_CMGW_1_STAT_STR_MAX_LEN             20
#define ATC_CMGW_1_STAT_STR_DEFAULT             PSIL_SMS_STATUS_STRING_STO_UNSENT

/* AT+CMGD */
#define ATC_CMGD_0_DEL_INDEX_MIN                0
#define ATC_CMGD_0_DEL_INDEX_MAX                (ATC_SMS_RECORD_MAX_NUMBER - 1)
#define ATC_CMGD_0_DEL_INDEX_DEFAULT            0
#define ATC_CMGD_1_DEL_STATE_MIN                0
#define ATC_CMGD_1_DEL_STATE_MAX                4
#define ATC_CMGD_1_DEL_STATE_DEFAULT            0

/* AT+CMMS */
#define ATC_CMMS_0_MODE_VAL_MIN                 0
#define ATC_CMMS_0_MODE_VAL_MAX                 2
#define ATC_CMMS_0_MODE_VAL_DEFAULT             0

/* AT+CNMA */
#define ATC_CNMA_0_REPLY_VAL_MIN                0
#define ATC_CNMA_0_REPLY_VAL_MAX                2
#define ATC_CNMA_0_REPLY_VAL_DEFAULT            0

#define ATC_CNMA_1_REPLY_VAL_MIN                0
#define ATC_CNMA_1_REPLY_VAL_MAX                PSIL_SMS_MAX_PDU_SIZE_OF_DELIVER_REPORT
#define ATC_CNMA_1_REPLY_VAL_DEFAULT            0

/* AT+CSMP */
#define ATC_CSMP_0_FO_VAL_MIN                   0
#define ATC_CSMP_0_FO_VAL_MAX                   255
#define ATC_CSMP_1_VP_RELATIVE_VAL_MIN          0
#define ATC_CSMP_1_VP_RELATIVE_VAL_MAX          255
#define ATC_CSMP_1_VP_RELATIVE_VAL_DEFAULT      PSIL_MSG_VP_DEFAULT
#define ATC_CSMP_1_VP_ABSOLUTE_STR_MAX_LEN      22      /* Time string:yy/MM/dd/,hh:mm:ss+zz */
#define ATC_CSMP_1_VP_ABSOLUTE_STR_DEFAULT      NULL
#define ATC_CSMP_1_VP_ENHANCED_STR_MAX_LEN      15      /* (PSIL_SMS_VP_OCTET_MAX_LENGTH *2) + 1 */
#define ATC_CSMP_1_VP_ENHANCED_STR_DEFAULT      NULL
#define ATC_CSMP_2_PID_VAL_MIN                  0
#define ATC_CSMP_2_PID_VAL_MAX                  1
#define ATC_CSMP_2_PID_VAL_DEFAULT              0
#define ATC_CSMP_3_DCS_VAL_MIN                  0
#define ATC_CSMP_3_DCS_VAL_MAX                  255
#define ATC_CSMP_3_DCS_VAL_DEFAULT              0

/* AT+CSDH */
#define ATC_CSDH_0_SHOW_VAL_MIN                 0
#define ATC_CSDH_0_SHOW_VAL_MAX                 1
#define ATC_CSDH_0_SHOW_VAL_DEFAULT             0

/* AT+CSAS */
#define ATC_CSAS_0_PROFILE_VAL_MIN              0
#define ATC_CSAS_0_PROFILE_VAL_MAX              255
#define ATC_CSAS_0_PROFILE_VAL_DEFAULT          0

/* AT+CRES */
#define ATC_CRES_0_PROFILE_VAL_MIN              0
#define ATC_CRES_0_PROFILE_VAL_MAX              255
#define ATC_CRES_0_PROFILE_VAL_DEFAULT          0

/* AT+CMSS */
#define ATC_CMSS_0_INDEX_VAL_MIN                0
#define ATC_CMSS_0_INDEX_VAL_MAX                (ATC_SMS_RECORD_MAX_NUMBER - 1)
#define ATC_CMSS_0_INDEX_VAL_DEFAULT            0
#define ATC_CMSS_1_ADDR_LENGTH_MIN              ATC_ADDR_STR_MAX_LEN
#define ATC_CMSS_1_ADDR_LENGTH_MAX              ATC_ADDR_STR_MAX_LEN
#define ATC_CMSS_1_ADDR_LENGTH_DEFAULT          0
#define ATC_CMSS_2_TODA_VAL_MIN                 ATC_ADDR_TYPE_OCT_MIN
#define ATC_CMSS_2_TODA_VAL_MAX                 ATC_ADDR_TYPE_OCT_MAX
#define ATC_CMSS_2_TODA_VAL_DEFAULT             ATC_ADDR_TYPE_OCT_DEFAULT

/* AT+ECSMSSEND */
#define ATC_ECSMSSEND_0_MODE_VAL_MIN            0
#define ATC_ECSMSSEND_0_MODE_VAL_MAX            1
#define ATC_ECSMSSEND_0_MODE_VAL_DEFAULT        0

/* AT+CSCB */
#define ATC_CSCB_0_MODE_VAL_MIN                 0
#define ATC_CSCB_0_MODE_VAL_MAX                 1
#define ATC_CSCB_0_MODE_VAL_DEFAULT             0
#define ATC_CSCB_STR_LEN                        100

/* AT+ECCMGS */
#define ATC_ECCMGS_2_MSG_ID_VAL_MIN                 0
#define ATC_ECCMGS_2_MSG_ID_VAL_MAX                 255
#define ATC_ECCMGS_2_MSG_ID_VAL_DEFAULT             0
#define ATC_ECCMGS_3_MSG_PARTS_VAL_MIN              0
#define ATC_ECCMGS_3_MSG_PARTS_VAL_MAX              255
#define ATC_ECCMGS_3_MSG_PARTS_VAL_DEFAULT          0
#define ATC_ECCMGS_4_MSG_PART_NUM_VAL_MIN           0
#define ATC_ECCMGS_4_MSG_PART_NUM_VAL_MAX           255
#define ATC_ECCMGS_4_MSG_PART_NUM_VAL_DEFAULT       0

/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/
typedef struct AtecSmsCMSSinfo_TAG
{
    UINT8                 sendIndex;
    UINT8                 mem2Type;
    PsilSmsStoreItemInfo  *pReadSmsInfo;
    BOOL                  isSmsSendPending;
    CmiSmsAddressInfo     *pDestAddrInfo;
}AtecSmsCMSSinfo;

#define CONCAT_SMS_MAX_BUFFER_SIZE 5

typedef struct AtecConcatSmsSegment_TAG
{
    UINT8                           seqNum;     /* Sequence number of the current segment */
    CHAR                            *strBuf;    /* Buffered +CMT report */
    struct AtecConcatSmsSegment_TAG *next;      /* Pointer to the next segment*/
}AtecConcatSmsSegment;

typedef struct AtecConcatSmsBuf_TAG
{
    UINT8                   refNum;             /* Concatenated SMS reference number */
    UINT8                   maxNum;             /* Maximum number of segments */
    UINT8                   lastSeqNumRpt;      /* Last sequence number of segment reported */
    UINT8                   segmentCount;       /* Count of segments bufferted */
    AtecConcatSmsSegment    *segmentListHead;   /* Head of buffered SMS segments list  */
}AtecConcatSmsBuf;

/******************************************************************************
 *****************************************************************************
 * API
 *****************************************************************************
******************************************************************************/
CmsRetId  smsCSCA(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCMGS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCMGC(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCMGF(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCMGW(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCMGR(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCMGL(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCMGD(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCMSS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsECSMSSEND(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCSMP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCSMS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCSDH(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCPMS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCNMA(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCNMAInputData(UINT8 chanId, UINT8 *pInput, UINT16 length);
void smsCNMACancel(void);
CmsRetId  smsCNMI(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsECCMGS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsECCMGR(const AtCmdInputContext *pAtCmdReq);
CmsRetId smsCMGSCMGCInputData(UINT8 chanId, UINT8 *pInput, UINT16 length);
void smsCMGSCMGCCancel(void);
CmsRetId smsCMGWInputData(UINT8 chanId, UINT8 * pInput, UINT16 length);
void smsCMGWCancel(void);

CmsRetId  smsCMMS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  smsCSCB(const AtCmdInputContext *pAtCmdReq);
BOOL smsCPMSPrefMemIntConvStr( UINT8 perfMemInt, CHAR *pPerfMemString);
BOOL smsCPMSPrefMemStrConvInt(CHAR *pPerfMemString, UINT8 *pPrefMemInt);

BOOL SmsDeliverDisplayFormat(UINT8 chanId, UINT8 smsFormat, CmiSmsDisplayCmd showCmd, PsilSmsStoreItemInfo *pSmsReadInfo, AtOutPdu *pAtRspPdu);
BOOL SmsSubmitDisplayFormat(UINT8 chanId, UINT8 smsFormat, CmiSmsDisplayCmd showCmd, PsilSmsStoreItemInfo *pSmsReadInfo, AtOutPdu *pAtRspPdu);

BOOL *smsECCMGRWaitSimFlag(void);

BOOL SmsCbmDisplayFormat(UINT8 chanId, UINT8 smsFormat, CmiSmsDisplayCmd showCmd, PsilSmsStoreItemInfo *pSmsReadInfo, AtOutPdu *pAtRspPdu);
BOOL SmsStatusRptDisplayFormat(UINT8 chanId, UINT8 smsFormat, CmiSmsDisplayCmd showCmd, PsilSmsStoreItemInfo *pSmsReadInfo, AtOutPdu *pAtRspPdu);

#endif

