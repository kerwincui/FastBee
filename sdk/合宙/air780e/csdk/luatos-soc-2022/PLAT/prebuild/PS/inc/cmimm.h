#ifndef __CMI_MM_H__
#define __CMI_MM_H__
/******************************************************************************
Copyright:      - 2017- Copyrights of AirM2M Ltd.
File name:      - cmimm.h
Description:    - CMI (CIoT modem interface) MM handling interface defination
History:        - 08/09/2020, Originated by Jason
******************************************************************************/
#include "cmicomm.h"

typedef enum CMI_MM_PRIM_ID_TAG
{
    CMI_MM_PRIM_BASE = 0,
    //CMI_MM_SET_CREG_MODE_REQ,   //CmiMmSetCregModeReq, AT+CREG=<n>, disabled, save in ATCMDSRV side
    //CMI_MM_SET_CREG_MODE_CNF,
    CMI_MM_GET_CREG_REQ,                            //CmiMmGetCregReq, AT+CREG?
    CMI_MM_GET_CREG_CNF,
    CMI_MM_GET_CREG_CAPA_REQ,                       //CmiMmGetCregCapaReq, AT+CREG=?
    CMI_MM_GET_CREG_CAPA_CNF,
    CMI_MM_CREG_IND,                                //CmiMmCregInd, +CREG: <stat>

    CMI_MM_SET_AUTO_PLMN_REQ,                       //CmiMmSetAutoPlmnReq, AT+COPS=0
    CMI_MM_SET_AUTO_PLMN_CNF,
    CMI_MM_MANUAL_PLMN_SELECT_REQ = 10,             //CmiMmManualPlmnSelectReq, AT+COPS=1/4
    CMI_MM_MANUAL_PLMN_SELECT_CNF,
    CMI_MM_DEREGISTER_REQ,                          //CmiMmDeregisterReq, AT+COPS=2
    CMI_MM_DEREGISTER_CNF,
    CMI_MM_SET_OPER_ID_FORMAT_REQ,                  //CmiMmSetOperIdFormatReq, AT+COPS=3,<format>
    CMI_MM_SET_OPER_ID_FORMAT_CNF,
    CMI_MM_GET_CURRENT_OPER_INFO_REQ,               //CmiMmGetCurOperInfoReq, AT+COPS?
    CMI_MM_GET_CURRENT_OPER_INFO_CNF,
    CMI_MM_MANUAL_PLMN_SEARCH_REQ,                  //CmiMmManualPlmnSearchReq, AT+COPS=?
    CMI_MM_MANUAL_PLMN_SEARCH_CNF,

    CMI_MM_EXTENDED_SIGNAL_QUALITY_IND = 20,        //CmiMmCesqInd, +CESQ

    CMI_MM_SET_REQUESTED_PSM_PARM_REQ,              //CmiMmSetPsmParmReq, AT+CPSMS=<mode>,
    CMI_MM_SET_REQUESTED_PSM_PARM_CNF,
    CMI_MM_GET_REQUESTED_PSM_PARM_REQ,              //CmiMmGetRequestedPsmParmReq, AT+CPSMS?
    CMI_MM_GET_REQUESTED_PSM_PARM_CNF,
    CMI_MM_GET_PSM_CAPA_REQ,                        //-TBD, AT+CPSMS=?
    CMI_MM_GET_PSM_CAPA_CNF,

    CMI_MM_SET_REQUESTED_EDRX_PARM_REQ,             //CmiMmSetEdrxParmReq, AT+CEDRXS=<mode>,...
    CMI_MM_SET_REQUESTED_EDRX_PARM_CNF,
    CMI_MM_GET_REQUESTED_EDRX_PARM_REQ,             //CmiMmGetRequestedEdrxParmReq, AT+CEDRXS?
    CMI_MM_GET_REQUESTED_EDRX_PARM_CNF = 30,
    CMI_MM_GET_EDRX_CAPA_REQ,                       //-TBD, AT+CEDRXS=?
    CMI_MM_GET_EDRX_CAPA_CNF,

    CMI_MM_EDRX_DYN_PARM_IND,                       //CmiMmEdrxDynParmInd, +CEDRXP: <AcT-type>[,<Requested_eDRX_value>[,<NWprovided_eDRX_value>[,<Paging_time_window>]]]

    CMI_MM_READ_EDRX_DYN_PARM_REQ,                  //CmiMmReadEdrxDynParmReq, AT+CEDRXRDP
    CMI_MM_READ_EDRX_DYN_PARM_CNF,

    CMI_MM_SET_CIOT_OPT_CFG_REQ,                    //CmiMmSetCiotOptCfgReq AT+CCIOTOPT=<n>
    CMI_MM_SET_CIOT_OPT_CFG_CNF,
    CMI_MM_GET_CIOT_OPT_CFG_REQ,                    //CmiMmGetCiotOptCfgReq AT+CCIOTOPT?
    CMI_MM_GET_CIOT_OPT_CFG_CNF,
    CMI_MM_GET_CIOT_OPT_CAPA_REQ = 40,              //CmiMmGetCiotOptCapaReq, AT+CCIOTOPT=?
    CMI_MM_GET_CIOT_OPT_CAPA_CNF,

    CMI_MM_NW_SUPPORTED_CIOT_OPT_IND,               //CmiMmNwSupportedCiotOptInd, +CCIOTOPTI

    CMI_MM_GET_COVERAGE_ENHANCEMENT_STATUS_REQ,     //CmiMmGetCEStatusReq, AT+CRCES
    CMI_MM_GET_COVERAGE_ENHANCEMENT_STATUS_CNF,

    CMI_MM_GET_EXTENDED_SIGNAL_QUALITY_REQ,         //CmiMmGetCesqReq, AT+CESQ
    CMI_MM_GET_EXTENDED_SIGNAL_QUALITY_CNF,         //CmiMmGetCesqCnf

    CMI_MM_EMM_TIMER_STATE_IND,                     //CmiMmEmmTimerStateInd, +ECEMMTIMERI: <timerId>, <state>[, <timer period>]

    CMI_MM_START_OOS_PLMN_SELECT_REQ,               //CmiMmStartOosPlmnSelectReq, AT+ECPLMNS
    CMI_MM_START_OOS_PLMN_SELECT_CNF,               //CmiMmStartOosPlmnSelectCnf

    CMI_MM_GET_PLMN_SELECT_STATE_REQ = 50,          //CmiMmGetPlmnSelectStateReq, AT+ECPLMNS?
    CMI_MM_GET_PLMN_SELECT_STATE_CNF,               //CmiMmGetPlmnSelectStateCnf

    CMI_MM_PLMN_SELECT_STATE_IND,                   //+ECPLMNSI: <state>[,<oosTimeStep>]

    CMI_MM_NITZ_IND,                                //CmiMmNITZInd, +NITZ: [<fullNwName>][,<shortNwName>][,<tz>][,<dst>][,<utime>]

    CMI_MM_COVERAGE_ENHANCEMENT_STATUS_IND,         //CmiMmCEStatusInd, +CRCES
    CMI_MM_GET_PSM_MODE_REQ,                        //CmiMmGetPsmModeReq, AT+ECPSMR?
    CMI_MM_GET_PSM_MODE_CNF,                        //CmiMmGetPsmModeCnf
    CMI_MM_PSM_CHANGE_IND,                          //CmiMmPsmChangeInd,  AT+ECPSMR:
    CMI_MM_SET_REQUESTED_PTW_EDRX_PARM_REQ,         //CmiMmSetPtwEdrxParmReq, AT+ECPTWEDRXS=<mode>,...
    CMI_MM_SET_REQUESTED_PTW_EDRX_PARM_CNF,         //CmiMmSetEdrxParmCnf
    CMI_MM_GET_REQUESTED_PTW_EDRX_PARM_REQ = 60,    //CmiMmGetRequestedPtwEdrxParmReq
    CMI_MM_GET_REQUESTED_PTW_EDRX_PARM_CNF,         //CmiMmGetRequestedEdrxParmCnf
    CMI_MM_GET_EMM_TIME_STATE_REQ,                  //CmiMmGetEmmTimeStateReq
    CMI_MM_GET_EMM_TIME_STATE_CNF,                  //CmiMmGetEmmTimeStateCnf
    CMI_MM_SET_USER_PLMN_RESELECTION_REQ,           //CmiMmSetUserPlmnReselectiontReq, AT+ECPLMNRESELECT
    CMI_MM_SET_USER_PLMN_RESELECTION_CNF,           //CmiMmSetUserPlmnReselectiontCnf
    CMI_MM_GET_CURRENT_OPER_NAME_REQ,               //CmiMmGetCurOperNameReq, AT+QSPN
    CMI_MM_GET_CURRENT_OPER_NAME_CNF,               //CmiMmGetCurOperNameCnf

    CMI_MM_TRIGGER_TAU_REQ,                         //CmiMmTriggerTauReq
    CMI_MM_TRIGGER_TAU_CNF,                         //CmiMmTriggerTauCnf
    CMI_MM_TRIGGER_RRC_RELEASE_REQ,                 //CmiMmTriggerRrcReleaseReq
    CMI_MM_TRIGGER_RRC_RELEASE_CNF,                 //CmiMmTriggerRrcReleaseCnf

    CMI_MM_PRIM_END = 0x0fff
}CMI_MM_PRIM_ID;


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/******************************************************************************
 * CMI_MM_SET_CREG_MODE_REQ
******************************************************************************/
typedef enum CmiMmCregModeEnum_TAG
{
    CMI_MM_DISABLE_CREG = 0,
    CMI_MM_ENABLE_CREG = 1,
    CMI_MM_CREG_LOC_INFO = 2,
    CMI_MM_CREG_LOC_REJ_INFO = 3
}CmiMmCregModeEnum;


/******************************************************************************
 * CMI_MM_GET_CREG_REQ
 * AT+CREG?
 * +CREG: <n>,<stat>[,[<lac>],[<ci>],[<AcT>][,<cause_type>,<reject_cause>]]
******************************************************************************/
typedef enum CmiCregStateEnum_Tag
{
    CMI_MM_NOT_REG = 0,
    CMI_MM_REG_HOME = 1, // not for NB, as NB SMS only
    CMI_MM_NOT_REG_SEARCHING = 2,
    CMI_MM_REG_DENIED = 3,
    CMI_MM_REG_UNKNOWN = 4,
    CMI_MM_REG_ROAMING = 5, // not for NB, as NB SMS only
    CMI_MM_REG_SMS_ONLY_HOME = 6,
    CMI_MM_REG_SMS_ONLY_ROAMING = 7,
    CMI_MM_REG_EMERGENCY = 8, // not for NB
    CMI_MM_REG_CSFB_NOT_PREFER_HOME = 9, // not for NB
    CMI_MM_REG_CSFB_NOT_PREFER_ROAMING = 10 // not for NB
}CmiCregStateEnum;

typedef enum CmiCregActEnum_Tag
{
    CMI_MM_GSM = 0,
    CMI_MM_GSM_COMPACT = 1,
    CMI_MM_UMTS = 2,
    CMI_MM_GSM_EGPRS = 3,
    CMI_MM_HSDPA = 4,
    CMI_MM_HSUPA = 5,
    CMI_MM_HSDPA_HSUPA = 6,
    CMI_MM_LTE = 7,
    CMI_MM_EC_GSM = 8,
    CMI_NB_IOT = 9 //NB only
}CmiCregActEnum;

typedef CamCmiEmptySig CmiMmGetCregReq;

typedef struct CmiMmGetCregCnf_Tag
{
    //UINT8 cregMode;     //CmiMmCregModeEnum   /*mode just saved in ATCMDSRV side*/
    UINT8   state;        //CmiCregStateEnum
    UINT8   reserved0;
    UINT16  reserved1;

    BOOL    locPresent;
    UINT8   act;          //CmiCregActEnum
    UINT16  tac;
    UINT32  celId;

    BOOL    rejCausePresent;
    UINT8   causeType; // only support 0 by now
    UINT16  rejCause;
}CmiMmGetCregCnf;


/******************************************************************************
 * CMI_MM_GET_CREG_CAPA_REQ
 * +CREG=? +CREG: (list of supported <n>s)
******************************************************************************/
typedef CamCmiEmptySig CmiMmGetCregCapaReq;

typedef struct CmiMmGetCregCapaCnf_Tag
{
    UINT8     bBitMap; // bit 0 set to 1, means suppurt n = 0;
    UINT8     reserved1;
    UINT16    reserved2;
}CmiMmGetCregCapaCnf;


/******************************************************************************
 * Note:
 * Change level should: CMI_CREG_STATE_CHANGED > CMI_CREG_LOC_INFO_CHANGED > CMI_CREG_REJECT_INFO_CHANGED
 * Just means:
 * 1> If "CMI_CREG_STATE_CHANGED" is set, just means registation state changed, and also LOC info changed,
 *    but can't set to low level: "CMI_CREG_LOC_INFO_CHANGED/CMI_CREG_REJECT_INFO_CHANGED"
 * 2> If "CMI_CREG_LOC_INFO_CHANGED" is set, just means registation state not changed, but location info changed,
 *     can't set to low level: "CMI_CREG_REJECT_INFO_CHANGED"
******************************************************************************/
typedef enum CmiCregChangedTypeEnum_Tag
{
    CMI_CREG_NONE_CHANGED = 0,
    CMI_CREG_STATE_CHANGED,
    CMI_CREG_LOC_INFO_CHANGED,      //location info changes
    CMI_CREG_REJECT_INFO_CHANGED,
}CmiCregChangedTypeEnum;


/******************************************************************************
 * CMI_MM_CREG_IND
 * +CREG: <stat>[,[<lac>],[<ci>],[<AcT>][,<cause_type>,<reject_cause>]]
******************************************************************************/
typedef struct CmiMmCregInd_Tag
{
    UINT8   state;
    UINT8   changedType;    //CmiCregChangedTypeEnum, which info in "CREG" changed
    UINT16  reserved2;

    BOOL    locPresent;
    UINT8   act;
    UINT16  tac;
    UINT32  celId;

    BOOL    rejCausePresent;
    UINT8   causeType; // only support 0 by now
    UINT16  rejCause;
}CmiMmCregInd;

/******************************************************************************
 * CMI_MM_SET_AUTO_PLMN_REQ
 * AT+COPS=0
******************************************************************************/
typedef CamCmiEmptySig CmiMmSetAutoPlmnReq;

typedef CamCmiEmptySig CmiMmSetAutoPlmnCnf;

/******************************************************************************
 * CMI_MM_MANUAL_PLMN_SELECT_REQ
 * AT+COPS=1,<format>, <oper> [,<AcT>]
 *        //manual (<oper> field shall be present, and <AcT> optionally)
 * AT+COPS=3,<format>, <oper> [,<AcT>]
 *        //manual/automatic (<oper> field shall be present);
 *          if manual selection fails, automatic mode (<mode>=0) is entered
 *
******************************************************************************/
typedef enum CmiPlmnFormatEnum_Tag
{
    CMI_MM_PLMN_LONG_ALPH = 0, /*max 16 chars*/
    CMI_MM_PLMN_SHORT_ALPH = 1, /*max 8 chars*/
    CMI_MM_PLMN_NUMERIC = 2
}CmiPlmnFormatEnum;

typedef enum CmiCopsModeEnum_Tag
{
    CMI_MM_AUTO_REG_MODE = 0,
    CMI_MM_MANUAL_REG_ONLY = 1,
    CMI_MM_DEREG_MODE = 2,
    CMI_MM_SET_FORMAT_MODE = 3,
    CMI_MM_MANUAL_THEN_AUTO_REG = 4
}CmiCopsModeEnum;


typedef struct CmiMmManualPlmnSelectReq_Tag
{
    UINT8 manualMode; //CmiCopsModeEnum, 1 - manual, 3 - manual than auto
    UINT8 plmnFormat; /*CmiPlmnFormatEnum, only numeric support by now for manual PLMN search*/
    UINT8 actPresent;
    UINT8 act;        // CmiCregActEnum, CMI_PS_LTE = 7 only

    CmiNumericPlmn plmn;
}CmiMmManualPlmnSelectReq;

typedef CamCmiEmptySig CmiMmManualPlmnSelectCnf;


/******************************************************************************
 * CMI_MM_DEREGISTER_REQ
 * AT+COPS=2
 *  deregister from network
******************************************************************************/
typedef CamCmiEmptySig CmiMmDeregisterReq;

typedef CamCmiEmptySig CmiMmDeregisterCnf;


/******************************************************************************
 * CMI_MM_SET_OPER_ID_FORMAT_REQ
 * AT+COPS=3,<format>
 *  set only <format> (for read command +COPS?)
******************************************************************************/
typedef struct CmiMmSetOperIdFormatReq_Tag
{
    UINT8 plmnFormat; //CmiPlmnFormatEnum
    UINT8 reserved1;
    UINT16 reserved2;
}CmiMmSetOperIdFormatReq;

typedef CamCmiEmptySig CmiMmSetOperIdFormatCnf;


/******************************************************************************
 * CMI_MM_GET_CURRENT_OPER_INFO_REQ
 * AT+COPS?
 *  +COPS: <mode>[,<format>,<oper>[,<AcT>]]
 * Read command returns the current mode, the currently selected operator and
 *  the current Access Technology. If no operator is selected, <format>, <oper>
 *  and <AcT> are omitted.
******************************************************************************/
typedef CamCmiEmptySig CmiMmGetCurOperInfoReq;

#define CMI_MM_STR_PLMN_MAX_LENGTH 32
typedef struct CmiStrPlmn_Tag
{
    UINT8 strPlmn[CMI_MM_STR_PLMN_MAX_LENGTH]; // end with '\0'
}CmiStrPlmn;

typedef union CmiMmPlmnUnion_Tag
{
    CmiNumericPlmn numPlmn;
    CmiStrPlmn     strPlmn;
}CmiMmPlmnUnion;

typedef struct CmiMmGetCurOperInfoCnf_Tag
{
    UINT8   mode;         //CmiCopsModeEnum, 0/1/2/4

    UINT8   plmnFormat;   //CmiPlmnFormatEnum
    BOOL    uniPlmnPresent;
    UINT8   act;          //CmiCregActEnum, CMI_MM_LTE = 7 only, valid when "numPlmn" is valid

    CmiMmPlmnUnion  uniPlmn;

    /*
     * if user get longPLMN/shortPLMN name, but PS don't have such info;
     * In such case:
     * 1> "plmnFormat" set to the right value;
     * 2> "uniPlmnPresent" set to FALSE;
     * then, if "numPlmn" is valid, ATCMDSRV could find the PLMN name from local table according to this "numPlmn"
    */
    CmiNumericPlmn  numPlmn;
}CmiMmGetCurOperInfoCnf;


/******************************************************************************
 * CMI_MM_MANUAL_PLMN_SEARCH_REQ
 * AT+COPS=?
 *  +COPS: list of supported:
 *  (<stat>,long alphanumeric <oper>,short alphanumeric <oper>, numeric <oper>[,<AcT>])s])
******************************************************************************/
typedef struct CmiMmManualPlmnSearchReq_Tag
{
    UINT32   gardTimer;        //gard timer for manual PLMN search, second
}CmiMmManualPlmnSearchReq;

#define CMI_MM_SHORT_STR_PLMN_MAX_LENGTH 8
#define CMI_MM_PLMN_SEARCH_NUM 10

/*
 * <stat>: integer type
 * 0 unknown
 * 1 available
 * 2 current
 * 3 forbidden
*/
typedef enum CmiMmPlmnStateEnum_Tag
{
    CMI_MM_PLMN_UNKNOWN = 0,
    CMI_MM_PLMN_AVAILABLE,
    CMI_MM_PLMN_CURRENT,
    CMI_MM_PLMN_FORBIDDEN
}CmiMmPlmnStateEnum;


typedef struct CmiMmManualPlmnInfo_Tag
{
    UINT8  plmnState;   //CmiMmPlmnStateEnum
    UINT8  act;         //CmiCregActEnum
    UINT16 reserved;

    UINT16 mcc;
    UINT16 mncWithAddInfo;
    UINT8  longPlmn[CMI_MM_STR_PLMN_MAX_LENGTH]; // end with '\0'
    UINT8  shortPlmn[CMI_MM_SHORT_STR_PLMN_MAX_LENGTH]; // end with '\0'
}CmiMmManualPlmnInfo;   //size = (4+4+32+8) = 48

typedef struct CmiMmManualPlmnSearchCnf_Tag
{
    UINT8     plmnNum;
    UINT8     reserved1;
    UINT16    reserved2;

    CmiMmManualPlmnInfo plmnList[CMI_MM_PLMN_SEARCH_NUM]; // size = (4+4+32+8)*10 = 480, max 10 PLMNs, if > 10, cut;
}CmiMmManualPlmnSearchCnf;


/******************************************************************************
 * CMI_MM_EXTENDED_SIGNAL_QUALITY_IND
 * 1> +CESQ: <rxlev>,<ber>,<rscp>,<ecno>,<rsrq>,<rsrp>
 * as not support GSM & UMTS, so:
 * +CESQ: 99,99,255,255,<rsrq>,<rsrp>
 * 2> AT CMD layer, just convert to CSQ:
 * +CSQ: <rssi>,<ber>:
 *  <rssi>: 0 - 31;99;
 *          rsrp < 28; rssi = 0;
 *          rsrp < 90; rssi = (rsrp - 28)/2
 *          rsrp < 97; rssi = 31;
 *          rsrp = 127; rssi = 99;
 *  <ber> : = dlBer
******************************************************************************/
#define CMI_MM_NOT_DETECT_RSRP  127
#define CMI_MM_NOT_DETECT_RSRQ  127

typedef struct CmiMmCesqInd_Tag
{
    /*
     * 1> AS NB extended the RSRQ value in TS 36.133-v14.5.0, Table 9.1.7-1/Table 9.1.24-1
     *   -30 rsrq < -34 dB
     *   -29 -34 dB <= rsrq < -33.5 dB
     *   ...
     *   -2 -20.5 dB <= rsrq < -20 dB
     *   -1 -20 dB <= rsrq < -19.5 dB
     *   0 rsrq < -19.5 dB
     *   1 -19.5 dB <= rsrq < -19 dB
     *   2 -19 dB <= rsrq < -18.5 dB
     *   ...
     *   32 -4 dB <= rsrq < -3.5 dB
     *   33 -3.5 dB <= rsrq < -3 dB
     *   34 -3 dB <= rsrq
     *   35 -3 dB <= rsrq < -2.5 dB
     *   36 -2.5 dB <= rsrq < -2
     *   ...
     *   45 2 dB <= rsrq < 2.5 dB
     *   46 2.5 dB <= rsrq
     * 2> If not valid, set to 127
    */
    INT8    rsrq;   /*-30 - 46, 127*/

    /*
     * 1> AS NB extended the RSRP value in: TS 36.133-v14.5.0, Table 9.1.4-1
     *   -17 rsrp < -156 dBm
     *   -16 -156 dBm <= rsrp < -155 dBm
     *    ...
     *   -3 -143 dBm <= rsrp < -142 dBm
     *   -2 -142 dBm <= rsrp < -141 dBm
     *   -1 -141 dBm <= rsrp < -140 dBm
     *   0 rsrp < -140 dBm
     *   1 -140 dBm <= rsrp < -139 dBm
     *   2 -139 dBm <= rsrp < -138 dBm
     *   ...
     *   95 -46 dBm <= rsrp < -45 dBm
     *   96 -45 dBm <= rsrp < -44 dBm
     *   97 -44 dBm <= rsrp
     * 2> If not valid, set to 127
    */
    INT8    rsrp;   /*-17 ~ 97, 127*/

    /*
     * REF: 45.008; 8.2.4
     * RXQUAL_0 BER < 0,2 % Assumed value = 0,14 %
     * RXQUAL_1 0,2 % < BER < 0,4 % Assumed value = 0,28 %
     * RXQUAL_2 0,4 % < BER < 0,8 % Assumed value = 0,57 %
     * RXQUAL_3 0,8 % < BER < 1,6 % Assumed value = 1,13 %
     * RXQUAL_4 1,6 % < BER < 3,2 % Assumed value = 2,26 %
     * RXQUAL_5 3,2 % < BER < 6,4 % Assumed value = 4,53 %
     * RXQUAL_6 6,4 % < BER < 12,8 % Assumed value = 9,05 %
     * RXQUAL_7 12,8 % < BER Assumed value = 18,10 %
    */
    UINT8   dlBer;  /* 0 - 7*/

    /*
     * SNR Signal-to-Noise Ratio
     * value in dB, value range: -30 ~ 30(NB) or -20 ~ 40(CAT1bis)
    */
    INT8    snr;

    /* the weighted value of RSSI measurement based on N*PRB's bandwidth
     * rssi value = (rsrp dBm Value - rsrq db value + rssiCompensation/100 + 113)/2
     * rsrp dBm vaule : mapping in TS36.133-v14.5.0, Table 9.1.4-1
     * rsrq db  value : mapping in TS36.133-v14.5.0, Table 9.1.7-1/Table 9.1.24-1
     *
     *    <rssi>     rssi value
     *      0        -113 dBm or less
     *      1        -111 dBm
     *      2...30   -109... -53 dBm
     *      31       -51 dBm or greater
     *      99       not known or not detectable
    */
    UINT16  rssiCompensation;
    UINT16  rsvd;
}CmiMmCesqInd;


/******************************************************************************
 * CMI_MM_SET_REQUESTED_PSM_PARM_REQ
 *  AT+CPSMS=[<mode>[,<Requested_Periodic-RAU>[,<Requested_GPRSREADYtimer>
 *             [,<Requested_PeriodicTAU>[,<Requested_ActiveTime>]]]]]
 *  <Requested_Periodic-TAU>: string type; one byte in an 8 bit format, the requested
 *   extended periodic TAU value is coded as one byte (octet 3) of the GPRS Timer 3 information
 *   element coded as bit format (e.g. "01000111" equals 70 hours).
******************************************************************************/
typedef enum CmiMmPsmReqModeEnum_Tag
{
    CMI_MM_DISABLE_PSM = 0,
    CMI_MM_ENABLE_PSM = 1,
    CMI_MM_DISCARD_PSM = 2 /*disable PSM, and discard PSM PARMs*/
}CmiMmPsmReqModeEnum;

#define CAC_PSM_IS_SET_PERIODIC_TAU(reqBitmap) (((reqBitmap)&0x04) != 0)
#define CAC_PSM_IS_SET_ACT_TIME(reqBitmap) (((reqBitmap)&0x08) != 0)
#define CAC_PSM_IS_SET_PERIODIC_TAU_S(reqBitmap) (((reqBitmap)&0x10) != 0)
#define CAC_PSM_IS_SET_ACT_TIME_S(reqBitmap) (((reqBitmap)&0x20) != 0)

#define CAC_PSM_SET_PERIODIC_TAU_BITMAP(reqBitmap) ((reqBitmap)|= 0x04)
#define CAC_PSM_SET_ACT_TIME_BITMAP(reqBitmap) ((reqBitmap)|=0x08)
#define CAC_PSM_SET_PERIODIC_TAU_S_BITMAP(reqBitmap) ((reqBitmap)|= 0x10)
#define CAC_PSM_SET_ACT_TIME_S_BITMAP(reqBitmap) ((reqBitmap)|=0x20)

typedef struct CmiMmSetPsmParmReq_Tag
{
    UINT8   mode;        // CmiMmPsmReqModeEnum

    /*
     * request bitmap,
     * bit 0 - reqPeriodicRau
     * bit 1 - reqGprsReadyTimer
     * bit 2 - reqPeriodicTau
     * bit 3 - reqActiveTime
     * bit 4 - reqPeriodicTauS
     * bit 5 - reqActiveTimeS
     */
    UINT8   reqBitmap;
    UINT16  reserved;

    UINT8   reqPeriodicRau;    /*useless*/
    UINT8   reqGprsReadyTimer; /*useless*/
    /*
     * <Requested_Periodic-TAU>: string type; one byte in an 8 bit format, the requested
     *   extended periodic TAU value is coded as one byte (octet 3) of the GPRS Timer 3 information
     *   element coded as bit format (e.g. "01000111" equals 70 hours).
     *   Here, reqPeriodicTau = 01000111 = 0x47 (1 byte)
    */
    UINT8   reqPeriodicTau;    /*T3412*/
    /*
     * <Requested_Active-Time>: string type; one byte in an 8 bit format. Requested Active Time value (T3324) to
     *  be allocated to the UE. The requested Active Time value is coded as one byte (octet 3) of the GPRS Timer 2
     *  information element coded as bit format (e.g. "00100100" equals 4 minutes)
     *  Here, reqActiveTime = 00100100 = 0x24
    */
    UINT8   reqActiveTime;     /*T3324*/

    /*
     * Request period TAU timer in second;
     *  In order to convenient for user, allow user to input the time in second;
     *  And, "reqPeriodicTau" && "reqPeriodicTauS" can't be all valid at the same time;
     * 600 = 600s = 10 mins
    */
    UINT32  reqPeriodicTauS;

    /*
     * Request active timer in second;
     * In order to convenient for user, allow user to input the time in second;
     *  And, "reqActiveTime" && "reqActiveTimeS" can't be all valid at the same time;
     * 600 = 600s = 10 mins
    */
    UINT32  reqActiveTimeS;
}CmiMmSetPsmParmReq;

typedef CamCmiEmptySig CmiMmSetPsmParmCnf;

/******************************************************************************
 * CMI_MM_GET_REQUESTED_PSM_PARM_REQ
 *  AT+CPSMS?
 *  +CPSMS: <mode>,[<Requested_PeriodicRAU>],[<Requested_GPRS-READYtimer>],
 *   [<Requested_PeriodicTAU>],[<Requested_Active-Time>]
******************************************************************************/
typedef CamCmiEmptySig CmiMmGetRequestedPsmParmReq;

typedef struct CmiMmGetRequestedPsmParmCnf_Tag
{
    UINT8   mode;   // CmiMmPsmReqModeEnum
    /*
     * request bitmap,
     * bit 0 - reqPeriodicRau
     * bit 1 - reqGprsReadyTimer
     * bit 2 - reqPeriodicTau
     * bit 3 - reqActiveTime
     * bit 4 - reqPeriodicTauS
     * bit 5 - reqActiveTimeS
     */
    UINT8   reqBitmap;
    UINT16  reserved;

    UINT8   reqPeriodicRau;     /*useless*/
    UINT8   reqGprsReadyTimer;  /*useless*/
    /*
     * The requested extended periodic TAU value is coded as one byte (octet 3) of the GPRS Timer 3 information
     *   element coded as bit format (e.g. "01000111" equals 70 hours).
    */
    UINT8   reqPeriodicTau;     /*T3412*/
    /*
     * The requested Active Time value is coded as one byte (octet 3) of the GPRS Timer 2
     *  information element coded as bit format (e.g. "00100100" equals 4 minutes)
    */
    UINT8   reqActiveTime;      /*T3324*/
    /*
     * The request extended periodic TAU value in seconds
    */
    UINT32  reqPeriodicTauS;    /*T3412 extended*/
    /*
     * The request Active Time value in seconds
    */
    UINT32  reqActiveTimeS;     /*T3324*/
}CmiMmGetRequestedPsmParmCnf;


/******************************************************************************
 * CMI_MM_GET_PSM_CAPA_REQ
 *  AT+CPSMS=?
 *  +CPSMS: (list of supported <mode>s),(list of supported
 *   <Requested_Periodic-RAU>s),(list of supported
 *   <Requested_GPRS-READY-timer>s),(list of supported
 *   <Requested_Periodic-TAU>s),(list of supported
 *   <Requested_Active-Time>s)
 * - TBD
******************************************************************************/

/******************************************************************************
 * CMI_MM_SET_REQUESTED_EDRX_PARM_REQ
 *  AT+CEDRXS=[<mode>,[,<AcTtype>[,<Requested_eDRX_value>]]]
******************************************************************************/
typedef enum CmiMmEdrxModeEnum_Tag
{
    CMI_MM_DISABLE_EDRX = 0,
    CMI_MM_ENABLE_EDRX_AND_DISABLE_IND = 1,
    CMI_MM_ENABLE_EDRX_AND_ENABLE_IND = 2,
    CMI_MM_DISCARD_EDRX = 3     /*Disable the use of eDRX and discard all parameters for eDRX*/
}CmiMmEdrxModeEnum;

typedef enum CmiMmEdrxActTypeEnum_Tag
{
    CMI_MM_EDRX_NO_ACT_OR_NOT_USE_EDRX = 0,
    CMI_MM_EDRX_EC_GSM_IOT = 1, //useless
    CMI_MM_EDRX_GSM = 2,        //useless
    CMI_MM_EDRX_UMTS = 3,       //useless
    CMI_MM_EDRX_LTE = 4,        //Cat1
    CMI_MM_EDRX_NB_IOT = 5
}CmiMmEdrxActTypeEnum;

typedef struct CmiMmSetEdrxParmReq_Tag
{
    UINT8   edrxMode; //CmiMmEdrxModeEnum
    UINT8   actType;  //CmiMmEdrxActTypeEnum 0 / 5 only

    UINT8   edrxValuePresent;
    UINT8   edrxMsValuePresent;

    /*
     * <Requested_eDRX_value>: string type; half a byte in a 4 bit format.
     *  The eDRX value refers to bit 4 to 1 of octet 3 of the Extended DRX parameters information element
     *  for NB, available value: 0x01 - 0x0F
     * eDRX     cycle parameter
     * 0 0 0 0  5,12 seconds
     * 0 0 0 1  10,24 seconds
     * 0 0 1 0  20,48 seconds
     * 0 0 1 1  40,96 seconds
     * 0 1 0 0  61,44 seconds
     * 0 1 0 1  81,92 seconds
     * 0 1 1 0  102,4 seconds
     * 0 1 1 1  122,88 seconds
     * 1 0 0 0  143,36 seconds
     * 1 0 0 1  163,84 seconds
     * 1 0 1 0  327,68 seconds
     * 1 0 1 1  655,36 seconds
     * 1 1 0 0  1310,72 seconds
     * 1 1 0 1  2621,44 seconds
     * 1 1 1 0  5242,88 seconds
     * 1 1 1 1  10485,76 seconds
    */
    UINT8   reqEdrxValue;
    UINT8   reserved0;
    UINT16  reserved1;

    /*
     * for easy using, allow to set the "Request EDRX value" in milli-second;
     *  but the "reqEdrxValue" and "reqEdrxValueMs" can't be all valid at the same time
    */
    UINT32  reqEdrxValueMs;
}CmiMmSetEdrxParmReq;

/*
 * CMI_MM_SET_REQUESTED_EDRX_PARM_CNF
 *  Note:
 *  !!!!!
 *   whether need to enable the unsolicited result code save in ATCMDSRV side, so here, need to CONF with "edrxMode" value
 *   +CEDRXP: <AcT-type>[,<Requested_eDRX_value>[,<NWprovided_eDRX_value>[,<Paging_time_window>]]]
 *  !!!!!
*/
typedef struct CmiMmSetEdrxParmCnf_Tag
{
    UINT8   edrxMode; //CmiMmEdrxModeEnum

    UINT8   reserved0;
    UINT16  reserved1;
}CmiMmSetEdrxParmCnf;


/******************************************************************************
 * CMI_MM_GET_REQUESTED_EDRX_PARM_REQ
 *  AT+CEDRXS?
 *  +CEDRXS: <AcT-type>,<Requested_eDRX_value>
******************************************************************************/
typedef CamCmiEmptySig CmiMmGetRequestedEdrxParmReq;

typedef enum CmiMmEdrxCfgEnum_Tag
{
    CMI_MM_DISABLE_EDRX_CFG = 0,
    CMI_MM_ENABLE_EDRX_CFG  = 1,
    CMI_MM_DISCARD_EDRX_CFG = 2     /*Disable the use of eDRX and discard all parameters for eDRX*/
}CmiMmEdrxCfgEnum;

typedef struct CmiMmGetRequestedEdrxParmCnf_Tag
{
    UINT8   edrxCfg;    //CmiMmEdrxCfgEnum
    UINT8   actType;    //CmiMmEdrxActTypeEnum 0 - 5 only

    /*if eDRX is disabled, reqEdrxValue should be set to 0x00, and actType should set to 0*/
    UINT8   reqPtwValue;
    UINT8   reqEdrxValue;

    /*
     * for easy reading, also return the "Request EDRX value" in milli-second;
    */
    UINT32  reqEdrxValueMs;
}CmiMmGetRequestedEdrxParmCnf;


/******************************************************************************
 * CMI_MM_GET_EDRX_CAPA_REQ, //AT+CEDRXS=?
 * CMI_MM_GET_EDRX_CAPA_CNF,
 * +CEDRXS: (list of supported <mode>s),(list of supported
 *   <AcT-type>s),(list of supported
 *   <Requested_eDRX_value>s)
 * TBD
******************************************************************************/

/******************************************************************************
 * CMI_MM_EDRX_DYN_PARM_IND
 *  +CEDRXP: <AcTtype>[,<Requested_eDRX_value>[,<NW-provided_eDRX_value>[,<Paging_time_window>]]]
******************************************************************************/
typedef struct CmiMmEdrxDynParmInd_Tag
{
    UINT8   actType; //CmiMmEdrxActTypeEnum 0/5 only
    BOOL    reqEdrxPresent;
    BOOL    reqPtwPresent;
    UINT8   reqEdrxValue;   /*NAS encoded value: 0x00 - 0x0F*/
    UINT32  reqEdrxValueMs; /*time value in MS*/

    UINT8   reqPtwValue;   /*NAS encoded value: 0x00 - 0x0F*/
    BOOL    nwEdrxPresent;  /*whether NW cfg/enable eDRX, if TRUE, nwEdrxValue & nwPtw should be valid*/
    UINT8   nwEdrxValue;    /*NAS encoded value: 0x00 - 0x0F*/
    /*
     * <Paging_time_window>: string type; half a byte in a 4 bit format. The paging time window referes
     *  to bit 8 to 5 of octet 3 of the Extended DRX parameters information element
    */
    UINT8   nwPtw;

    UINT32  nwEdrxValueMs;  /*time value in MS*/
    UINT32  nwPtwMs;        /*time value in MS*/
}CmiMmEdrxDynParmInd;   //20 bytes


/******************************************************************************
 * CMI_MM_READ_EDRX_DYN_PARM_REQ
 * CMI_MM_READ_EDRX_DYN_PARM_CNF
 * AT+CEDRXRDP
 * +CEDRXRDP: <AcTtype>[,<Requested_eDRX_value>[,<NWprovided_eDRX_value>[,<Paging_time_window>]]]
 * DRX is used for the cell that the MS is currently registered to.
******************************************************************************/
typedef CamCmiEmptySig CmiMmReadEdrxDynParmReq;

typedef struct CmiMmReadEdrxDynParmCnf_Tag
{
    UINT8   actType;      // CmiMmEdrxActTypeEnum 0 - 5 only

    UINT8   reqEdrxPresent;
    UINT8   nwEdrxPresent;  /*whether NW cfg/enable eDRX, if TRUE, nwEdrxValue & nwPtw should be valid*/

    UINT8   reqEdrxValue;   /*NAS encoded value: 0x00 - 0x0F*/
    UINT32  reqEdrxValueMs; /*time value in MS*/

    UINT8   nwEdrxValue;    /*NAS encoded value: 0x00 - 0x0F*/
    /*
     * <Paging_time_window>: string type; half a byte in a 4 bit format. The paging time window referes
     *  to bit 8 to 5 of octet 3 of the Extended DRX parameters information element
    */
    UINT8   nwPtw;
    UINT16  reserved;

    UINT32  nwEdrxValueMs;  /*time value in MS*/
    UINT32  nwPtwMs;        /*time value in MS*/
}CmiMmReadEdrxDynParmCnf;

/******************************************************************************
 * CMI_MM_SET_REQUESTED_PTW_EDRX_PARM_REQ
 *  AT+ECPTWEDRXS=[<mode>[,<AcT-type>[,<Requested_Paging_time_window>[,<Requested_eDRX_value>]]]]
******************************************************************************/
typedef struct CmiMmSetPtwEdrxParmReq_Tag
{
    UINT8   edrxMode; //CmiMmEdrxModeEnum
    UINT8   actType;  //CmiMmEdrxActTypeEnum 0 / 5 only

    UINT8   ptwValuePresent;
    UINT8   edrxValuePresent;

    /*
        NB-S1 mode
        The field contains the PTW value in seconds for NB-S1 mode.The PTW value is used
        as specified in 3GPP TS 23.682 [133a].The PTW value is derived as follows:
        bit
        8 7 6 5 Paging Time Window length
        0 0 0 0  2,56 seconds
        0 0 0 1  5,12 seconds
        0 0 1 0  7,68 seconds
        0 0 1 1  10,24 seconds
        0 1 0 0  12,8 seconds
        0 1 0 1  15,36 seconds
        0 1 1 0  17,92 seconds
        0 1 1 1  20,48 seconds
        1 0 0 0  23,04 seconds
        1 0 0 1  25,6 seconds
        1 0 1 0  28,16 seconds
        1 0 1 1  30,72 seconds
        1 1 0 0  33,28 seconds
        1 1 0 1  35,84 seconds
        1 1 1 0  38,4 seconds
        1 1 1 1  40,96 seconds
     */

    /*
     * <Requested_eDRX_value>: string type; half a byte in a 4 bit format.
     *  The eDRX value refers to bit 4 to 1 of octet 3 of the Extended DRX parameters information element
     *  for NB, available value: 0x01 - 0x0F
     * eDRX     cycle parameter
     * 0 0 0 0  5,12 seconds
     * 0 0 0 1  10,24 seconds
     * 0 0 1 0  20,48 seconds
     * 0 0 1 1  40,96 seconds
     * 0 1 0 0  61,44 seconds
     * 0 1 0 1  81,92 seconds
     * 0 1 1 0  102,4 seconds
     * 0 1 1 1  122,88 seconds
     * 1 0 0 0  143,36 seconds
     * 1 0 0 1  163,84 seconds
     * 1 0 1 0  327,68 seconds
     * 1 0 1 1  655,36 seconds
     * 1 1 0 0  1310,72 seconds
     * 1 1 0 1  2621,44 seconds
     * 1 1 1 0  5242,88 seconds
     * 1 1 1 1  10485,76 seconds
    */
    UINT8   reqPtwValue;
    UINT8   reqEdrxValue;
    UINT16  reserved1;

}CmiMmSetPtwEdrxParmReq;

/******************************************************************************
 * CMI_MM_GET_REQUESTED_PTW_EDRX_PARM_REQ
 *  AT+ECPTWEDRXS?
 *  +ECPTWEDRXS: <AcT-type>,<Requested_Paging_time_window>,<Requested_eDRX_value>
******************************************************************************/
typedef CamCmiEmptySig CmiMmGetRequestedPtwEdrxParmReq;


/******************************************************************************
 * CMI_MM_GET_EMM_TIME_STATE_REQ
 *  AT+ECEMMTIME?
 *  +ECEMMTIME: <time-id>,<state>[,<remainTimeValue>]
******************************************************************************/
typedef CamCmiEmptySig CmiMmGetEmmTimeStateReq;

#define CMI_MM_EMM_TIME_NUM     3

typedef struct CmiMmGetEmmTimeStateCnf_Tag
{
    UINT8   emmTimerId[CMI_MM_EMM_TIME_NUM];       //CmiMmEmmTimerEnum
    UINT8   timerState[CMI_MM_EMM_TIME_NUM];       //CmiMmEmmTimerStateEnum
    UINT16  rsvd0;
    UINT32  remainTimeValue[CMI_MM_EMM_TIME_NUM];
}CmiMmGetEmmTimeStateCnf;



/******************************************************************************
 * CMI_MM_SET_CIOT_OPT_CFG_REQ/
 * CMI_MM_SET_CIOT_OPT_CFG_CNF
 *  AT+CCIOTOPT=[<n>,[<supported_UE_opt>[,<preferred_UE_opt>]]]
******************************************************************************/
typedef enum CmiMmCiotReportModeEnum_Tag
{
    CMI_MM_CIOT_OPT_DISABLE_REPORT = 0,
    CMI_MM_CIOT_OPT_ENABLE_REPORT = 1,
    CMI_MM_CIOT_OPT_DISABLE_REPORT_RESET_CFG = 3,

    CMI_MM_CIOT_OPT_RPT_MODE_NOT_PRESENT = 7    // not carried in AT CMD
}CmiMmCiotReportModeEnum;

typedef enum CmiMmCiotOptTypeEnum_Tag
{
    CMI_MM_NO_OPT = 0, // not support CIOT OPT, for NB, CP OPT is must, useless
    CMI_MM_CP_OPT = 1,
    CMI_MM_UP_OPT = 2,
    CMI_MM_CP_AND_UP = 3
}CmiMmCiotOptTypeEnum;


typedef struct CmiMmSetCiotOptCfgReq_Tag
{
    //BOOL  modePresent;
    UINT8   reportMode;   // CmiMmCiotReportModeEnum
    UINT8   reserved0;

    BOOL    ueSuptOptPresent;
    UINT8   ueSuptOptType; // UE supported CIOT OPT: CmiMmCiotOptTypeEnum: 1 & 3

    UINT8   uePreferOptPresent;
    UINT8   uePreferOpt;  // CmiMmCiotOptTypeEnum: 0, 1, 2
    UINT16  reserved2;
}CmiMmSetCiotOptCfgReq;

//typedef CamCmiEmptySig CmiMmSetCiotOptCfgCnf;
typedef struct CmiMmSetCiotOptCfgCnf_Tag
{
    UINT8   reportMode;   // CmiMmCiotReportModeEnum
    UINT8   reserved0;
    UINT16  reserved1;
}CmiMmSetCiotOptCfgCnf;



/******************************************************************************
 * CMI_MM_GET_CIOT_OPT_CFG_REQ/
 * CMI_MM_GET_CIOT_OPT_CFG_CNF
 * AT+CCIOTOPT?
 *  +CCIOTOPT :<n>,<supported_UE_opt>,<preferred_UE_opt>
******************************************************************************/
typedef CamCmiEmptySig CmiMmGetCiotOptCfgReq;

typedef struct CmiMmGetCiotOptCfgCnf_Tag
{
    UINT8   ueSuptOptType;  //UE supported CIOT OPT type, CmiMmCiotOptTypeEnum: 1 & 3

    UINT8   uePreferOpt;    // CmiMmCiotOptTypeEnum: 0, 1, 2
    UINT16  reserved1;
}CmiMmGetCiotOptCfgCnf;

/******************************************************************************
 * CMI_MM_GET_CIOT_OPT_CAPA_REQ/
 * CMI_MM_GET_CIOT_OPT_CAPA_CNF
 *  AT+CCIOTOPT=?
 * +CCIOTOPT: (list of supported <n>s),(list of supported <supported_UE_opt>s),
 *  (list of supported <preferred_UE_opt>s)
 * // +CCIOTOPT: 0 1 3, 1 3, 0 1 2
******************************************************************************/
typedef CamCmiEmptySig CmiMmGetCiotOptCapaReq;

typedef struct CmiMmGetCiotOptCapaCnf_Tag
{
    //CmiRcCode rc;

    UINT8 reportModeBitMap; //0000 1011, 0x0B
    UINT8 utOptBitmap;      //0000 1111, 0x0F
    UINT8 preferOptBitmap;  //0000 0111, 0x07

    UINT8 reserved1;
    //UINT16 reserved2;
}CmiMmGetCiotOptCapaCnf;

/******************************************************************************
 * CMI_MM_NW_SUPPORTED_CIOT_OPT_IND
 *  +CCIOTOPTI: <supported_Network_opt>
******************************************************************************/
typedef struct CmiMmNwSupportedCiotOptInd_Tag
{
    UINT8 nwCiotOptType; //CmiMmCiotOptTypeEnum

    UINT8 reserved1;
    UINT16 reserved2;
}CmiMmNwSupportedCiotOptInd;


/******************************************************************************
 * CMI_MM_GET_COVERAGE_ENHANCEMENT_STATUS_REQ
 *  AT+CRCES
 *   +CRCES: <AcT>,<CE_level>,<CC>
******************************************************************************/
typedef CamCmiEmptySig CmiMmGetCEStatusReq;

/*
 * 0 Serving cell has no coverage enhancement
 * 1 E-UTRAN
 * 2 EC-GSM-IoT (A/Gb mode) (see NOTE 1)
 * 3 E-UTRAN (NB-S1 mode) (see NOTE 2)
*/
typedef enum CmiMmCeStatusActEnum_Tag
{
    CMI_MM_CES_NO_CE_ACT = 0,
    CMI_MM_CES_EUTRAN_EMTC,
    CMI_MM_CES_EC_GSM,
    CMI_MM_CES_EUTRAN_NB
}CmiMmCeStatusActEnum;

/*
 * 0 No Coverage Enhancement in the serving cell
 * 1 Coverage Enhancement level 0
 * 2 Coverage Enhancement level 1
 * 3 Coverage Enhancement level 2
 * 4 Coverage Enhancement level 3
*/
typedef enum CmiMmCeLevelEnum_Tag
{
    CMI_MM_NO_CE_LEVEL = 0,
    CMI_MM_CE_LEVEL_0,
    CMI_MM_CE_LEVEL_1,
    CMI_MM_CE_LEVEL_2,
    CMI_MM_CE_LEVEL_3   //CE LEVEL 3 is used for EMTC, not for NB
}CmiMmCeLevelEnum;

typedef struct CmiMmGetCEStatusCnf_Tag
{
    UINT8   act;        //CmiMmCeStatusActEnum
    UINT8   ceLevel;    //CmiMmCeLevelEnum
    UINT8   ccLevel;    //Coverage Class (CC), used for "EC-GSMIoT", set to 0 by default
    UINT8   reserved0;
}CmiMmGetCEStatusCnf;


typedef struct CmiMmCEStatusInd_Tag
{
    UINT8   ceLevel;    //CmiMmCeLevelEnum
    UINT8   reserved0;
    UINT16  reserved1;
}CmiMmCEStatusInd;

/******************************************************************************
 * CMI_MM_GET_EXTENDED_SIGNAL_QUALITY_REQ
 *  AT+CESQ
 *   +CESQ: <rxlev>,<ber>,<rscp>,<ecno>,<rsrq>,<rsrp>
 *  <rxlev>, is for GSM, set to 99: not known or not detectable
 *  <rscp>, <ecno>, are for UMTS, set to 255: not known or not detectable
******************************************************************************/
typedef CamCmiEmptySig CmiMmGetCesqReq;

typedef struct CmiMmGetCesqCnf_Tag
{
    /*
     * 1> AS NB extended the RSRP value in TS 36.133-v14.5.0, Table 9.1.7-1/Table 9.1.24-1
     *   -30 rsrq < -34 dB
     *   -29 -34 dB <= rsrq < -33.5 dB
     *   ...
     *   -2 -20.5 dB <= rsrq < -20 dB
     *   -1 -20 dB <= rsrq < -19.5 dB
     *   0 rsrq < -19.5 dB
     *   1 -19.5 dB <= rsrq < -19 dB
     *   2 -19 dB <= rsrq < -18.5 dB
     *   ...
     *   32 -4 dB <= rsrq < -3.5 dB
     *   33 -3.5 dB <= rsrq < -3 dB
     *   34 -3 dB <= rsrq
     *   35 -3 dB <= rsrq < -2.5 dB
     *   36 -2.5 dB <= rsrq < -2
     *   ...
     *   45 2 dB <= rsrq < 2.5 dB
     *   46 2.5 dB <= rsrq
     * 2> If not valid, set to 127
    */
    INT8    rsrq;   /*-30 - 46, 127*/

    /*
     * 1> AS NB extended the RSRP value in: TS 36.133-v14.5.0, Table 9.1.4-1
     *   -17 rsrp < -156 dBm
     *   -16 -156 dBm <= rsrp < -155 dBm
     *    ...
     *   -3 -143 dBm <= rsrp < -142 dBm
     *   -2 -142 dBm <= rsrp < -141 dBm
     *   -1 -141 dBm <= rsrp < -140 dBm
     *   0 rsrp < -140 dBm
     *   1 -140 dBm <= rsrp < -139 dBm
     *   2 -139 dBm <= rsrp < -138 dBm
     *   ...
     *   95 -46 dBm <= rsrp < -45 dBm
     *   96 -45 dBm <= rsrp < -44 dBm
     *   97 -44 dBm <= rsrp
     * 2> If not valid, set to 127
    */
    INT8    rsrp;   /*-17 ~ 97, 127*/

    /*
     * SNR Signal-to-Noise Ratio
     * value in dB, value range: -30 ~ 30(NB) or -20 ~ 40(CAT1bis)
    */
    INT8    snr;

    /*
     * REF: 45.008; 8.2.4
     * RXQUAL_0 BER < 0,2 % Assumed value = 0,14 %
     * RXQUAL_1 0,2 % < BER < 0,4 % Assumed value = 0,28 %
     * RXQUAL_2 0,4 % < BER < 0,8 % Assumed value = 0,57 %
     * RXQUAL_3 0,8 % < BER < 1,6 % Assumed value = 1,13 %
     * RXQUAL_4 1,6 % < BER < 3,2 % Assumed value = 2,26 %
     * RXQUAL_5 3,2 % < BER < 6,4 % Assumed value = 4,53 %
     * RXQUAL_6 6,4 % < BER < 12,8 % Assumed value = 9,05 %
     * RXQUAL_7 12,8 % < BER Assumed value = 18,10 %
    */
    UINT8   dlBer;  /* 0 - 7*/

    /* the weighted value of RSSI measurement based on N*PRB's bandwidth
     * rssi value = (rsrp dBm Value - rsrq db value + rssiCompensation/100 + 113)/2
     * rsrp dBm vaule : mapping in TS36.133-v14.5.0, Table 9.1.4-1
     * rsrq db  value : mapping in TS36.133-v14.5.0, Table 9.1.7-1/Table 9.1.24-1
     *
     *    <rssi>     rssi value
     *      0        -113 dBm or less
     *      1        -111 dBm
     *      2...30   -109... -53 dBm
     *      31       -51 dBm or greater
     *      99       not known or not detectable
    */
    UINT16  rssiCompensation;
    UINT8   rsvd[2];
}CmiMmGetCesqCnf;


/******************************************************************************
 * CMI_MM_PLMN_SELECT_STATE_IND
 * ^ECPLMNSI: <state>[,<oosTimeStep>]
******************************************************************************/
typedef enum CmiMmPlmnSelectStateEnum_Tag
{
    CMI_MM_PLMN_SELECT_DEACTIVATED  = 0,    //CE PLMN is deactived, no PLMN selecting is ongoing
    CMI_MM_PLMN_SELECT_FG_SEARCHING,        //Foreground PLMN selecting is ongoing
    CMI_MM_PLMN_SELECTED,                   //A PLMN already selected
    CMI_MM_PLMN_OOS_SLEEP                   //OOS, CE PLMN may start a OOS timer
}CmiMmPlmnSelectStateEnum;

typedef struct CmiMmPlmnSelectStateInd_Tag
{
    UINT8   plmnSelectState;    //CmiMmPlmnSelectStateEnum
    BOOL    oosTimerPresent;

    UINT16  oosTimerS;          //OOS timer value in seconds
}CmiMmPlmnSelectStateInd;

/******************************************************************************
 * CMI_MM_START_OOS_PLMN_SELECT_REQ/CMI_MM_START_OOS_PLMN_SELECT_CNF
 * CmiMmStartOosPlmnSelectReq
 * AT+ECPLMNS
******************************************************************************/
typedef CamCmiEmptySig CmiMmStartOosPlmnSelectReq;

typedef CamCmiEmptySig CmiMmStartOosPlmnSelectCnf;

/******************************************************************************
 * CMI_MM_GET_PLMN_SELECT_STATE_REQ/CMI_MM_GET_PLMN_SELECT_STATE_CNF
 * CmiMmGetPlmnSearchStateReq
 * +ECPLMNS: <state>[,<oosTimeStep>]
******************************************************************************/
typedef CamCmiEmptySig CmiMmGetPlmnSelectStateReq;

typedef struct CmiMmGetPlmnSelectStateCnf_Tag
{
    UINT8   plmnSelectState;    //CmiMmPlmnSelectStateEnum
    BOOL    oosTimerPresent;

    UINT16  oosTimerS;          //OOS timer value in seconds
}CmiMmGetPlmnSelectStateCnf;


/******************************************************************************
 * CMI_MM_EMM_TIMER_STATE_IND,
 * CmiMmEmmTimerStateInd
 * //+ECEMMTIME: <timeId>,<timeState>[,<timeValue>]
******************************************************************************/
typedef enum CmiMmEmmTimerEnum_Tag
{
    CMI_MM_EMM_T3346 = 0,   //connection blocked timer
    CMI_MM_EMM_T3448,       //CP data blocked timer
    CMI_MM_EMM_TAU_TIMER    //T3412, or extT3412
}CmiMmEmmTimerEnum;

typedef enum CmiMmEmmTimerStateEnum_Tag
{
    CMI_MM_EMM_TIMER_START,
    CMI_MM_EMM_TIMER_STOP,
    CMI_MM_EMM_TIMER_EXPIRY
}CmiMmEmmTimerStateEnum;

typedef struct CmiMmEmmTimerStateInd_Tag
{
    UINT8   emmTimer;       //CmiMmEmmTimerEnum
    UINT8   timerState;     //CmiMmEmmTimerStateEnum
    UINT8   tValuePst;      //whether "timerValueS" value valid
    UINT8   param0;         //reserved

    UINT32  timerValueS;
}CmiMmEmmTimerStateInd;

typedef enum CmiMmPsmModeEnum_Tag
{
    CMI_MM_NORMAL_MODE,
    CMI_MM_POWER_SAVING_MODE
}CmiMmPsmModeEnum;

/******************************************************************************
 * CMI_MM_GET_PSM_MODE_REQ,
 * CmiMmGetPsmModeReq
 *  AT+ECPSMR?
 * +ECPSMR: <n>, <mode>
******************************************************************************/
typedef CamCmiEmptySig CmiMmGetPsmModeReq;

typedef struct CmiMmGetPsmModeCnf_Tag
{
    UINT8   psmMode;       //CmiMmPsmModeEnum
    UINT16  reserved1;     //reserved
    UINT8   reserved2;     //reserved

}CmiMmGetPsmModeCnf;

/******************************************************************************
 * CMI_MM_PSM_CHANGE_IND,
 * CmiMmPsmChangeInd
 * +ECPSMR: <mode>
******************************************************************************/
typedef struct CmiMmPsmChangeInd_Tag
{
    UINT8   psmMode;       //CmiMmPsmModeEnum
    UINT16  reserved1;     //reserved
    UINT8   reserved2;     //reserved

}CmiMmPsmChangeInd;

/*******************************************************************************
 * CMI_MM_NITZ_IND,         //^NITZ: [<fullNwName>][,<shortNwName>][,<tz>][,<dst>][,<utime>]
 * CmiMmNITZInd
*******************************************************************************/
typedef enum CmiMmDSTEnum_Tag
{
    CMI_MM_NO_DST = 0,
    CMI_MM_1_HOUR_DST,
    CMI_MM_2_HOURS_DST,
    CMI_MM_RSVD_DST
}CmiMmDSTEnum;

#define CMI_MM_FULL_NW_NAME_LEN     32
#define CMI_MM_SHORT_NW_NAME_LEN    16

/*
 * "Universal time and local time zone" info in "EMM information"
 * UTC time info
*/
typedef struct CmiMmEmmUTCInfo_Tag
{
    UINT16  year;   //example: 2019
    UINT8   mon;    //1-12
    UINT8   day;    //1-31

    UINT8   hour;   //0-23
    UINT8   mins;   //0-59
    UINT8   sec;    //0-59
    INT8    tz;     //(-63 ~ 64)
}CmiMmEmmUTCInfo;   //8 bytes

typedef struct CmiMmNITZInd_Tag
{
    UINT8       fullNwNameLen;      //if no NW name, set to 0
    UINT8       shortNwNameLen;     //if no NW name, set to 0
    BOOL        localTZPst;
    /*
     * timeZone: time zone value; (-63 ~ 64)
     *  Offset between UTC and local time in units of 15 minutes;
     * Example: UTC+8hours, timeZone = 4*8 = 32
    */
    INT8        localTimeZone;

    UINT8       fullNwName[CMI_MM_FULL_NW_NAME_LEN]; //string type, already decoded in EMM
    UINT8       shortNwName[CMI_MM_SHORT_NW_NAME_LEN];

    BOOL        dstPst;             //whether "dst" present
    BOOL        utcInfoPst;         //whether "utcInfo" present
    UINT8       dst;                //CmiMmDSTEnum, Daylight saving time
    UINT8       rsvd0;

    CmiMmEmmUTCInfo     utcInfo;
}CmiMmNITZInd;  //56 bytes

/******************************************************************************
 * CMI_MM_SET_USER_PLMN_RESELECTION_REQ/CMI_MM_SET_USER_PLMN_RESELECTION_CNF
 * CmiMmSetUserPlmnReselectiontReq
 * AT+ECPLMNRESELECT
******************************************************************************/
typedef CamCmiEmptySig CmiMmSetUserPlmnReselectiontReq;

typedef CamCmiEmptySig CmiMmSetUserPlmnReselectiontCnf;

/******************************************************************************
 * CMI_MM_GET_CURRENT_OPER_NAME_REQ,
 * CmiMmGetCurOperNameReq
 *  AT+QSPN?
******************************************************************************/
typedef CamCmiEmptySig CmiMmGetCurOperNameReq;

typedef struct CmiMmGetCurOperNameCnf_Tag
{
    CmiNumericPlmn  rplmn;
    UINT8           fullNwName[CMI_MM_FULL_NW_NAME_LEN];   /* string type, fullname from EMM info */
    UINT8           shortNwName[CMI_MM_SHORT_NW_NAME_LEN]; /* string type, shortname from EMM info */
}CmiMmGetCurOperNameCnf;


typedef enum CmiMmTriggerTauTypeEnum_Tag
{
    CMI_MM_TA_UPDATING                              = 0,
    CMI_MM_COMBINED_TA_LA_UPDATING                  = 1,
    CMI_MM_COMBINED_TA_LA_UPDATING_WITH_IMSI_ATTACH = 2,
    CMI_MM_PERIODIC_TA_UPDATING                     = 3
}CmiMmTriggerTauTypeEnum;


/******************************************************************************
 * CMI_MM_TRIGGER_TAU_REQ,
 * CmiMmTriggerTauReq
******************************************************************************/
typedef struct CmiMmTriggerTauReq_Tag
{
    UINT8   updateType;         //CmiMmTriggerTauTypeEnum
    UINT8   rsvd0[3];
}CmiMmTriggerTauReq;

typedef struct CmiMmTriggerTauCnf_Tag
{
    BOOL    isTriggered;        //TRUE:  TAU is triggered, TAU procedure maybe fail
                                //FALSE: TAU is not triggered
    UINT8   rsvd0[3];
}CmiMmTriggerTauCnf;

/******************************************************************************
 * CMI_MM_TRIGGER_RRC_RELEASE_REQ,
 * CmiMmTriggerRrcReleaseReq
******************************************************************************/
typedef CamCmiEmptySig CmiMmTriggerRrcReleaseReq;

typedef struct CmiMmTriggerRrcReleaseCnf_Tag
{
    BOOL    isTriggered;        //TRUE:  RRC connection local release is triggered
                                //FALSE: RRC connection local release is not triggered
    UINT8   rsvd0[3];
}CmiMmTriggerRrcReleaseCnf;

#endif

