#ifndef __CMI_SIM_H__
#define __CMI_SIM_H__
/******************************************************************************
Copyright:      - 2017- Copyrights of AirM2M Ltd.
File name:      - cmisim.h
Description:    - CMI (CIoT modem interface) SIM handling interface definition
History:        - 10/13/2017, Originated by xlhu
******************************************************************************/
/*********************************************************************************
* Includes
*********************************************************************************/
#include "cmicomm.h"


/*********************************************************************************
* Macros
*********************************************************************************/
#define CMI_SIM_MAX_PIN_CODE_LENGTH    8
#define CMI_SIM_MAX_FILE_PATH_LEN      8
#define CMI_SIM_MAX_CMD_APDU_LEN      261
#define CMI_SIM_MAX_CMD_DATA_LEN      255
#define CMI_SIM_ICCID_LEN           20
#define CMI_SIM_MAX_TEXT_STRING_LEN    22
#define CMI_SIM_MAX_BIP_DATA_BUF_LEN        1400
#define CMI_SIM_MAX_APN_NAME            100
#define CMI_SIM_USAT_MAX_ADDRESS_LEN        16
#define CMI_SIM_USAT_MAX_TP_LEN         39
#define CMI_SIM_MAX_AID_LEN             16
#define CMI_SIM_MAX_ALPHA_ID_STR_LEN     32
#define CMI_SIM_MAX_DAIL_NUMBER_STR_LEN    24
#define CMI_SIM_MAX_SMS_ADDRESS_LEN 40

/*********************************************************************************
* Type Definition
*********************************************************************************/

/******************************************************************************
 *****************************************************************************
 * Enums
 *****************************************************************************
******************************************************************************/

typedef enum CMI_SIM_PRIM_ID_TAG
{
    CMI_SIM_PRIM_BASE = 0,
    CMI_SIM_GET_SUBSCRIBER_ID_REQ,    /* at+cimi , --imsi */
    CMI_SIM_GET_SUBSCRIBER_ID_CNF,
    CMI_SIM_OPERATE_PIN_REQ,          /* at+cpwd
                                       * at+cpin
                                       */
    CMI_SIM_OPERATE_PIN_CNF,
    CMI_SIM_GET_PIN_STATE_REQ,        /* at+cpin? */
    CMI_SIM_GET_PIN_STATE_CNF,
    CMI_SIM_LOCK_FACILITY_REQ,        /* at+clck=<other facility except MEP>, enable/disable PIN1 */
    CMI_SIM_LOCK_FACILITY_CNF,
    CMI_SIM_PERSONALIZEME_REQ,        /* at+clck=<MEP facility>*/
    CMI_SIM_PERSONALIZEME_CNF = 10,
    CMI_SIM_GENERIC_ACCESS_REQ,       /* at+csim= */
    CMI_SIM_GENERIC_ACCESS_CNF,
    CMI_SIM_RESTRICTED_ACCESS_REQ,    /* at+crsm= */
    CMI_SIM_RESTRICTED_ACCESS_CNF,
    CMI_SIM_OPEN_LOGICAL_CHANNEL_REQ, /* at+ccho= */
    CMI_SIM_OPEN_LOGICAL_CHANNEL_CNF = 0x10,
    CMI_SIM_CLOSE_LOGICAL_CHANNEL_REQ, /* at+cchc= */
    CMI_SIM_CLOSE_LOGICAL_CHANNEL_CNF,
    CMI_SIM_GENERIC_LOGICAL_CHANNEL_ACCESS_REQ,       /* at+cgla= */
    CMI_SIM_GENERIC_LOGICAL_CHANNEL_ACCESS_CNF = 20,
    CMI_SIM_GET_TERMINAL_PROFILE_REQ, /* at+ecusatp? */
    CMI_SIM_GET_TERMINAL_PROFILE_CNF,
    CMI_SIM_SET_TERMINAL_PROFILE_REQ, /* at+ecusatp= */
    CMI_SIM_SET_TERMINAL_PROFILE_CNF,
    CMI_SIM_TERMINAL_RESPONSE_REQ,     /* at+usatt=<terminal_response> */
    CMI_SIM_TERMINAL_RESPONSE_CNF,
    CMI_SIM_ENVELOPE_CMD_REQ,          /* at+usate= */
    CMI_SIM_ENVELOPE_CMD_CNF,
    CMI_SIM_QUERY_REMIAN_PIN_RETRIES_REQ, /* at+cpinr*/
    CMI_SIM_QUERY_REMIAN_PIN_RETRIES_CNF = 30,

    CMI_SIM_GET_ICCID_REQ,          /* internal use for getting Iccid request */
    CMI_SIM_GET_ICCID_CNF,          /* internal use for getting Iccid confirm */
    CMI_SIM_SET_SIM_SLEEP_REQ, /* AT+ECSIMSLEEP=<mode>*/
    CMI_SIM_SET_SIM_SLEEP_CNF,
    CMI_SIM_GET_SIM_SLEEP_STATE_REQ, /* AT+ECSIMSLEEP?*/
    CMI_SIM_GET_SIM_SLEEP_STATE_CNF,
    CMI_SIM_SET_SIM_WRITE_COUNTER_REQ, /* AT+ECSWC=<mode>*/
    CMI_SIM_SET_SIM_WRITE_COUNTER_CNF,
    CMI_SIM_GET_SIM_WRITE_COUNTER_MODE_REQ, /*AT+ECSWC? */
    CMI_SIM_GET_SIM_WRITE_COUNTER_MODE_CNF = 40,
    CMI_SIM_GET_SUBSCRIBER_NUMBER_REQ,       /* AT+CNUM, get MSISDN */
    CMI_SIM_GET_SUBSCRIBER_NUMBER_CNF,
    CMI_SIM_SET_EXT_CFG_REQ,   //AT+ECSIMCFG
    CMI_SIM_SET_EXT_CFG_CNF,
    CMI_SIM_GET_EXT_CFG_REQ,
    CMI_SIM_GET_EXT_CFG_CNF,
    CMI_SIM_SET_SIM_REMOVAL_REQ,
    CMI_SIM_SET_SIM_REMOVAL_CNF,
    CMI_SIM_GET_SMS_PARAMS_REQ, //get SMS parameters from EFsmsp
    CMI_SIM_GET_SMS_PARAMS_CNF = 50,
    CMI_SIM_SET_HOT_SWAP_NOTIFY_REQ,
    CMI_SIM_SET_HOT_SWAP_NOTIFY_CNF,
    CMI_SIM_SET_PREFERRED_PLMN_LIST_REQ,
    CMI_SIM_SET_PREFERRED_PLMN_LIST_CNF,
    CMI_SIM_GET_PREFERRED_PLMN_LIST_REQ,
    CMI_SIM_GET_PREFERRED_PLMN_LIST_CNF,
    CMI_SIM_SET_SELECT_PLMN_LIST_REQ,
    CMI_SIM_SET_SELECT_PLMN_LIST_CNF,
    CMI_SIM_GET_SELECT_PLMN_LIST_REQ,
    CMI_SIM_GET_SELECT_PLMN_LIST_CNF,
    /*.... add new command here...*/

    /*unsolicited indication*/
    CMI_SIM_PROACTIVE_CMD_IND = 70,         /* +cusatp:<proactive_command> */
    CMI_SIM_PROACTIVE_CMD_END_IND,     /* +cusatend */
    CMI_SIM_UICC_STATE_IND,            /* +cusats:<UICC_STATE>, 'uicc removed' was not defined, maybe need extend*/
    /*unsolicited indication for internal use, non-standard AT command */
    CMI_SIM_UICC_PIN_STATE_IND,             /* +cpin: */


    CMI_SIM_USAT_OPEN_CHANNEL_IND = 80,
    CMI_SIM_USAT_OPEN_CHANNEL_RSP,
    CMI_SIM_USAT_CLOSE_CHANNEL_IND,
    CMI_SIM_USAT_CLOSE_CHANNEL_RSP,
    CMI_SIM_USAT_SEND_DATA_IND,
    CMI_SIM_USAT_SEND_DATA_RSP,
    CMI_SIM_USAT_DATA_AVAILABLE_REQ,
    CMI_SIM_USAT_DATA_AVAILABLE_CNF,
    CMI_SIM_USAT_CHANNEL_STATUS_EVENT_REQ,
    CMI_SIM_USAT_CHANNEL_STATUS_EVENT_CNF,
    CMI_SIM_USAT_PROACTIVE_CMD_SESSION_END_IND,

    CMI_SIM_PRIM_END = 0x0fff
}CMI_SIM_PRIM_ID;


typedef enum CmiSimStatusTag
{
    CMI_SIM_UICC_NOT_POWERED = 0,       /* the UICC is not powered on */
    CMI_SIM_UICC_START_BEFORE_PD,       /* UICC is inserted and start-up in progress before profile download */
    CMI_SIM_UICC_READY_FOR_PD,          /* UICC start-up halted and ready for profile download */
    CMI_SIM_UICC_PD_DONE_CONT_INIT,     /* Profile download cpmpleted, UICC startup continuing */
    CMI_SIM_UICC_AWAIT_PIN_VER,         /* UICC awaiting PIN verification */
    CMI_SIM_UICC_ACTIVE,                /* UICC active */
    CMI_SIM_UICC_ERROR,                 /* UICC is inserted, but error happens */
    CMI_SIM_UICC_REMOVED,               /* the UICC was removed */

    CMI_SIM_UICC_STATUS_UNKNOWN
}
CmiSimStatus;

/*
* CmiSimPinState defines the PIN state corresponded to +CPIN:<code> referred to TS27.007
*/
typedef enum CmiSimPinStateTag
{
    CMI_SIM_PIN_STATE_READY,                             /* <code>: READY, MT is not pending for any password, UICC is ready */
    CMI_SIM_PIN_STATE_PIN_REQUIRED,                      /* <code>: SIM PIN, MT is waiting for SIM PIN to be given */
    CMI_SIM_PIN_STATE_UNBLOCK_PIN_REQUIRED,              /* <code>: SIM PUK, MT is waiting for SIM PUK to be given */
    CMI_SIM_PIN_STATE_PIN2_REQUIRED,                     /* <code>: SIM PIN2, MT is waiting for SIM PIN2 to be given, return only when
                                                                  the last executed command resulted in PIN2 anthentication failure;
                                                                  don't block if PIN2 is not entered right */
    CMI_SIM_PIN_STATE_UNBLOCK_PIN2_REQUIRED,             /* <code>: SIM PUK2, MT is waiting for SIM PUK2 to be given, return only when
                                                                  the last executed command resulted in PUK2 anthentication failure;
                                                                  don't block if PUK2 is not entered right */

    /* MEP PIN --- TBD */
    CMI_SIM_PIN_STATE_PH_NET_PIN_REQUIRED,               /* <code>: PH-NET PIN, MT is waiting network personlization password to be given */
    CMI_SIM_PIN_STATE_UNBLOCK_PH_NET_PIN_REQUIRED,       /* <code>: PH-NET PUK, MT is waiting network personlization unblocking password to be given */
    CMI_SIM_PIN_STATE_PH_NETSUB_PIN_REQUIRED,            /* <code>: PH-NETSUB PIN, MT is waiting network subset personlization password to be given */
    CMI_SIM_PIN_STATE_UNBLOCK_PH_NETSUB_PIN_REQUIRED,    /* <code>: PH-NETSUB PUK, MT is waiting network subset personlization unblocking password to be given */
    CMI_SIM_PIN_STATE_PH_SP_PIN_REQUIRED,                /* <code>: PH-SP PIN, MT is waiting service provider personlization password to be given */
    CMI_SIM_PIN_STATE_UNBLOCK_PH_SP_PIN_REQUIRED,        /* <code>: PH-SP PUK, MT is waiting service provider network personlization unblocking password to be given */
    CMI_SIM_PIN_STATE_PH_CORP_PIN_REQUIRED,              /* <code>: PH-CORP PIN, MT is waiting corporate personlization password to be given */
    CMI_SIM_PIN_STATE_UNBLOCK_PH_CORP_PIN_REQUIRED,      /* <code>: PH-CORP PUK, MT is waiting corporate personlization unblocking password to be given */

    /*
    * extend state
    */
    CMI_SIM_PIN_STATE_UNBLOCK_PIN_BLOCKED,
    CMI_SIM_PIN_STATE_UNBLOCK_PIN2_BLOCKED,

    /*
    * extend for URC:+ECPIN:<code>
    */
    CMI_SIM_PIN_STATE_SIM_NOT_INSERTED,
    CMI_SIM_PIN_STATE_SIM_NOT_READY,

    CMI_SIM_PIN_STATE_UNKNOWN
}
CmiSimPinState;

/* PIN code operation */
typedef enum CmiSimPinOperTag
{
    CMI_SIM_PIN_VERIFY = 0,       /* verify pin code */
    CMI_SIM_PIN_CHANGE,       /* change pin code */
    CMI_SIM_PIN_ENABLE,       /* enable the pin1 state for verification */
    CMI_SIM_PIN_DISABLE,      /* disable the pin1 state */
    CMI_SIM_PIN_UNBLOCK,      /* unblock pin code */
    CMI_SIM_PIN_QUERY,        /* query pin1 state, enable or disable */
    CMI_SIM_PIN_NUM_OPERS
}
CmiSimPinOper;

typedef enum CmiSimPinNumTag
{
    CMI_SIM_PIN_1 = 0,
    CMI_SIM_PIN_2,
    CMI_SIM_PUK_1,
    CMI_SIM_PUK_2,
    CMI_SIM_PIN_ALL
}
CmiSimPinNum;



typedef enum CmiSimFacLockModeTag
{
    CMI_SIM_FAC_LOCK_MODE_UNLOCK,
    CMI_SIM_FAC_LOCK_MODE_LOCK,
    CMI_SIM_FAC_LOCK_MODE_QUERY,
    CMI_SIM_FAC_LOCK_MODE_UNKNOWN
}
CmiSimFacLockMode;

typedef enum CmiSimFacilityTag
{
    CMI_SIM_FACILITY_SIM,  /* lock SIM/UICC card, ask password (PIN1) in power on when this lock command issued */
    CMI_SIM_FACILITY_FDN,  /* enable FND feature, PIN2 is required if PIN2 has not been verified. */
    CMI_SIM_FACILITY_MEP,  /* network personalization/MEP feature */
    CMI_SIM_FACILITY_UNKNOWN
}
CmiSimFacility;

typedef enum CmiSimFacStatusTag
{
    CMI_SIM_FAC_STATUS_NOT_ACTIVE,
    CMI_SIM_FAC_STATUS_ACTIVE,
    CMI_SIM_FAC_STATUS_UNKNOWN
}
CmiSimFacStatus;

typedef enum CmiSimCmdTag
{
    CMI_SIM_CMD_SELECT             = 0xa4,
    CMI_SIM_CMD_STATUS             = 0xf2,
    CMI_SIM_CMD_READ_BINARY        = 0xb0,
    CMI_SIM_CMD_UPDATE_BINARY      = 0xd6,
    CMI_SIM_CMD_READ_RECORD        = 0xb2,
    CMI_SIM_CMD_UPDATE_RECORD      = 0xdc,
    CMI_SIM_CMD_INCREASE           = 0x32,
    CMI_SIM_CMD_VERIFY_PIN         = 0x20,
    CMI_SIM_CMD_CHANGE_PIN         = 0x24,
    CMI_SIM_CMD_DISABLE_PIN        = 0x26,
    CMI_SIM_CMD_ENABLE_PIN         = 0x28,
    CMI_SIM_CMD_UNBLOCK_PIN        = 0x2c,
    CMI_SIM_CMD_AUTHENTICATE       = 0x88,

    CMI_SIM_CMD_MANAGE_CHANNEL     = 0x70,
    CMI_SIM_CMD_GET_CHALLENGE      = 0x84,

    CMI_SIM_CMD_GET_RESPONSE       = 0xc0,
}
CmiSimCmd;

typedef enum CmiSimFileIdTag
{
    CMI_SIM_FID_KEYS_PS             =   0x6f09,
    CMI_SIM_FID_SMS                 =   0x6f3c,
    CMI_SIM_FID_SMSP                =   0x6f42,
    CMI_SIM_FID_SMSS                =   0x6f43,
    CMI_SIM_FID_SMSR                =   0x6f47,
    CMI_SIM_FID_PLMN_ACT            =   0x6f60,
    CMI_SIM_FID_FPLMN               =   0x6f7b,
    CMI_SIM_FID_EPSLOCI             =   0x6fe3,
    CMI_SIM_FID_EPSNSC              =   0x6fe4,
    CMI_SIM_FID_INVALID             =   0x0000
}
CmiSimFileId;


typedef enum CmiSimBearerTypeTag
{
    CMI_SIM_BEARER_TYPE_CSD                        = 0x01,
    CMI_SIM_BEARER_TYPE_GPRS                       = 0x02,
    CMI_SIM_BEARER_TYPE_DEFAULT                    = 0x03,
    CMI_SIM_BEARER_TYPE_PACKET_SERIVCE             = 0x09,
    CMI_SIM_BEARER_TYPE_EUTRAN_MAPPED_UTRAN_PS     = 0x0B
}
CmiSimBearerType;

typedef enum CmiSimTransportFormatTag
{
    CMI_SIM_UDP_UICC_IN_CLIENT_MODE_REMOTE_CONN = 0x01,
    CMI_SIM_TCP_UICC_IN_CLIENT_MODE_REMOTE_CONN = 0x02,
    CMI_SIM_TCP_UICC_IN_SERVER_MODE             = 0x03,
    CMI_SIM_UDP_UICC_IN_CLIENT_MODE_LOCAL_CONN  = 0x04,
    CMI_SIM_TCP_UICC_IN_CLIENT_MODE_LOCAL_CONN  = 0x05,
    CMI_SIM_DIRECT_COMMUNICATE_CHANNEL          = 0x06
}
CmiSimTransportFormat;

typedef enum CmiSimUsatGeneralResultTag
{
    CMI_SIM_USAT_GR_CMD_PERFORMED_OK               = 0x00,
    CMI_SIM_USAT_GR_CMD_PERFORMED_PARTIAL_COMPREHENSION      = 0x01,
    CMI_SIM_USAT_GR_CMD_PERFORMED_MISS_INFO        = 0x02,
    CMI_SIM_USAT_GR_REFRESH_ADDITIONAL_EF_READ      = 0x03,
    CMI_SIM_USAT_GR_CMD_PERFORMED_OK_NO_ICON       = 0x04,
    CMI_SIM_USAT_GR_CMD_PERFORMED_OK_MOD_BY_CC     = 0x05,
    CMI_SIM_USAT_GR_CMD_PERFORMED_OK_LIMIT_SERVICE      = 0x06,
    CMI_SIM_USAT_GR_CMD_PERFORMED_OK_WITH_MOD      = 0x07,
    CMI_SIM_USAT_GR_REFRESH_APP_INACTIVE           = 0x08,
    CMI_SIM_USAT_GR_PROAC_SESSION_TERMINATE_BY_USER          = 0x10,
    CMI_SIM_USAT_GR_USER_REQ_BACK_MOVE         = 0x11,
    CMI_SIM_USAT_GR_USER_NO_RESPONSE           = 0x12,
    CMI_SIM_USAT_GR_USER_REQ_HELP_INFO         = 0x13,
    CMI_SIM_USAT_GR_USSD_SS_TRANS_USER_TERMINATE    = 0x14,
    CMI_SIM_USAT_GR_ME_CANNOT_PROC_COMMAND     = 0x20,
    CMI_SIM_USAT_GR_NET_CANNOT_PROC_COMMAND    = 0x21,
    CMI_SIM_USAT_GR_USER_REJ_PROACTIVE_CMD     = 0x22,
    CMI_SIM_USAT_GR_USER_CLEAR_DOWN            = 0x23,
    CMI_SIM_USAT_GR_CONTRADICT_CURR_TIMER_STATE      = 0x24,
    CMI_SIM_USAT_GR_MOD_BY_CC_TEMP_PROB        = 0x25,
    CMI_SIM_USAT_GR_BROWSER_GEN_ERROR          = 0x26,
    CMI_SIM_USAT_GR_CMD_BEYOND_ME_CAP         = 0x30,
    CMI_SIM_USAT_GR_CMD_TYPE_UNKNOWN_BY_ME    = 0x31,
    CMI_SIM_USAT_GR_CMD_DATA_UNKNOWN_BY_ME    = 0x32,
    CMI_SIM_USAT_GR_CMD_NUM_UNKNOWN_BY_ME     = 0x33,
    CMI_SIM_USAT_GR_SS_RETURN_ERROR            = 0x34,
    CMI_SIM_USAT_GR_SMS_RP_ERROR               = 0x35,
    CMI_SIM_USAT_GR_ERR_REQ_VALUES_MISSING      = 0x36,
    CMI_SIM_USAT_GR_USSD_RETURN_ERROR          = 0x37,
    CMI_SIM_USAT_GR_CC_OR_MOSM_PERM_PROB       = 0x39,
    CMI_SIM_USAT_GR_BIP_ERROR      = 0x3A,
    CMI_SIM_USAT_GR_ACCESS_TECHNO_UNAVAILABLE  = 0x3B
}
CmiSimUsatGeneralResult;

typedef enum CmiSimUsatAddiInfoMeProblemTag
{
    CMI_SIM_USAT_ADDI_INFO_ME_NO_CAUSE_GIVEN        = 0x00,
    CMI_SIM_USAT_ADDI_INFO_SCREEN_BUSY              = 0x01,
    CMI_SIM_USAT_ADDI_INFO_ME_BUSY_ON_CALL          = 0x02,
    CMI_SIM_USAT_ADDI_INFO_ME_BUSY_ON_SS            = 0x03,
    CMI_SIM_USAT_ADDI_INFO_NO_SERVICE               = 0x04,
    CMI_SIM_USAT_ADDI_INFO_ACC_CONT_CLASS_BAR       = 0x05,
    CMI_SIM_USAT_ADDI_INFO_RADIO_RES_NOT_GRANTED    = 0x06,
    CMI_SIM_USAT_ADDI_INFO_NOT_IN_SPEECH_CALL       = 0x07,
    CMI_SIM_USAT_ADDI_INFO_ME_BUSY_ON_USSD          = 0x08,
    CMI_SIM_USAT_ADDI_INFO_ME_BUSY_ON_DTMF          = 0x09,
    CMI_SIM_USAT_ADDI_INFO_ME_NO_APP_ACTIVE         = 0x0a
}
CmiSimUsatAddiInfoMeProblem;

typedef enum CmiSimUsatAddiInfoBipProblemTag
{
    CMI_SIM_USAT_ADDI_INFO_BIP_NO_CAUSE_GIVEN           = 0x00,
    CMI_SIM_USAT_ADDI_INFO_BIP_NO_CHANNEL_AVAIL         = 0x01,
    CMI_SIM_USAT_ADDI_INFO_BIP_CHANNEL_CLOSED           = 0x02,
    CMI_SIM_USAT_ADDI_INFO_BIP_CHANNEL_ID_INVALID       = 0x03,
    CMI_SIM_USAT_ADDI_INFO_BIP_REQ_BUFFER_SIZE_UNAVAIL  = 0x04,
    CMI_SIM_USAT_ADDI_INFO_BIP_SECURITY_ERROR           = 0x05,
    CMI_SIM_USAT_ADDI_INFO_BIP_TRANS_LEVEL_UNAVAIL      = 0x06,
    CMI_SIM_USAT_ADDI_INFO_BIP_REMOTE_DEV_NOT_REACH     = 0x07,
    CMI_SIM_USAT_ADDI_INFO_BIP_SERVICE_ERROR            = 0x08,
    CMI_SIM_USAT_ADDI_INFO_BIP_SERVICE_ID_UNKNOWN       = 0x09,
    CMI_SIM_USAT_ADDI_INFO_BIP_PORT_UNAVAIL             = 0x10

}
CmiSimUsatAddiInfoBipProblem;

typedef enum CmiSimSleepModeTag
{
    CMI_SIM_SLEEP_DISABLE = 0,
    CMI_SIM_SLEEP_ENABLE = 1,
    CMI_SIM_SLEEP_NUM = 0xFF
}
CmiSimSleepMode;

typedef enum CmiSimWriteCounterModeTag
{
    CMI_SIM_WRITE_COUNTER_DISBALE = 0,
    CMI_SIM_WRITE_COUNTER_ENBALE = 1,
    CMI_SIM_WRITE_COUNTER_QUERY = 2,
    CMI_SIM_WRITE_COUNTER_CLEAR = 3,
    CMI_SIM_WRITE_COUNTER_UNDEF = 0xFF
}
CmiSimWriteCounterMode;

typedef enum CmiSimPresenceDetectModeTag
{
    CMI_SIM_PRESENCE_DETECT_DISBALE = 0,
    CMI_SIM_PRESENCE_DETECT_ENBALE = 1,
    CMI_SIM_PRESENCE_DETECT_UNDEF = 0xFF
}
CmiSimPresenceDetectMode;


typedef enum CmiSimPlmnFormatEnum_Tag
{
    CMI_SIM_PLMN_LONG_ALPH = 0,
    CMI_SIM_PLMN_SHORT_ALPH = 1,
    CMI_SIM_PLMN_NUMERIC = 2
}
CmiSimPlmnFormatEnum;

/*
* selection of preferred PLMN list +CPLS
*/
typedef enum CmiSimSelPreferPlmnListTag
{
    CMI_SIM_SELECT_USER_PLMN_ACT = 0,
    CMI_SIM_SELECT_OPLMN_ACT = 1,
    CMI_SIM_SELECT_HPLMN_ACT = 2
}
CmiSimSelPreferPlmnList;


/******************************************************************************
 *****************************************************************************
 * CMI STRUCT
 *****************************************************************************
******************************************************************************/
typedef struct CmiSimPinCodeTag
{
    UINT8       length;
    UINT8       reserved1;
    UINT16      reserved2;
    UINT8       data[CMI_SIM_MAX_PIN_CODE_LENGTH];
}
CmiSimPinCode;

typedef struct CmiSimIccidStrTag
{
    CHAR       data[CMI_SIM_ICCID_LEN];
}
CmiSimIccidStr;

typedef struct CmiSimFilePathTag
{
    UINT8            len;
    UINT8            reserved1;
    UINT16           reserved2;
    UINT8            filePath[CMI_SIM_MAX_FILE_PATH_LEN];
}
CmiSimFilePath;

typedef struct CmiSimUsatBipEqosTag
{
    UINT8               qci;
    UINT16              reserved;
    BOOL                gbrMbrPresent;  /* indicate the present of GBR/MBR */
    UINT32              ulMBR;          /* UL_MBR, kbit/s */
    UINT32              dlMBR;          /* DL_MBR, kbit/s */
    UINT32              ulGBR;          /* UL_GBR, kbit/s */
    UINT32              dlGBR;          /* DL_GBR, kbit/s */
}
CmiSimUsatBipEqos;

typedef struct CmiSimUsatBipQosTag
{
    UINT8               precedenceClass;
    UINT8               delayClass;
    UINT8               reliaClass;
    UINT8               peakTptClass;
    UINT8               meanTptClass;
    UINT8               rsvd1;
    UINT16              rsvd2;
}
CmiSimUsatBipQos;

typedef struct CmiSimTextStringTag
{
    UINT16                  length;
    UINT8                   textString[CMI_SIM_MAX_TEXT_STRING_LEN];//8-bit coding
}
CmiSimTextString;

typedef struct CmiSimUsatCmdResultTag
{
    UINT8                           generalResult;//CmiSimUsatGeneralResult
    BOOL                            addiInfoMeProblemPresent;
    UINT8                           addiInfoMeProblem;//CmiSimUsatAddiInfoMeProblem
    BOOL                            addiInfoBipProblemPresent;
    UINT8                           addiInfoBipProblem;//CmiSimUsatAddiInfoBipProblem
    UINT8                           reserved1;
    UINT16                          reserved2;
}
CmiSimUsatCmdResult;

typedef struct CmiSimUsatBipDataPduTag
{
    UINT8                               channelId;
    UINT8                               reserved;
    UINT16                              length;
    UINT8                               *ptr;
    struct CmiSimUsatBipDataPduTag      *pNext;
}
CmiSimUsatBipDataPdu;

typedef struct CmiSimEfWriteCnt_Tag
{
    UINT16      fileId;
    UINT16      reserved;
    UINT32      writeCnt;//SIM write counter
}
CmiSimEfWriteCnt;

#define    CMI_MAX_SWC_EF_LIST_NUM    20
typedef struct CmiSimWriteCntList_Tag
{
    UINT8               swcEfNum;
    UINT8               rsvd1;
    UINT16              rsvd2;
    CmiSimEfWriteCnt    swcCnt[CMI_MAX_SWC_EF_LIST_NUM];
}
CmiSimWriteCntList;

typedef struct CmiSimDialNumber_Tag
{
    UINT8                   resvd1;
    UINT16                  resvd2;
    UINT8                   type;
    CHAR                    alphaId[CMI_SIM_MAX_ALPHA_ID_STR_LEN];
    CHAR                    dialNumStr[CMI_SIM_MAX_DAIL_NUMBER_STR_LEN];
}
CmiSimDialNumber;

typedef struct CmiSimSmsAddress_Tag
{
    UINT8      typeOfNumber;
    UINT8      numberPlanId;
    UINT8      reserved;
    UINT8      length;
    UINT8      digitAddr[CMI_SIM_MAX_SMS_ADDRESS_LEN];
}
CmiSimSmsAddress;


/******************************************************************************
 * CMI_SIM_GET_SUBSCRIBER_ID_REQ
 * +CIMI
******************************************************************************/
typedef CamCmiEmptySig CmiSimGetSubscriberIdReq;

//CMI_SIM_GET_SUBSCRIBER_ID_CNF
typedef struct CmiSimGetSubscriberIdCnfTag
{
    CmiSimImsiStr         imsiStr;  /* IMSI string */
}
CmiSimGetSubscriberIdCnf;

/******************************************************************************
 * CMI_SIM_GET_ICCID_REQ
 * +ECICCID
******************************************************************************/
typedef CamCmiEmptySig CmiSimGetIccIdReq;

//CMI_SIM_GET_ICCID_CNF
typedef struct CmiSimGetIccIdCnfTag
{
    CmiSimIccidStr         iccidStr;  /* ICCID string */
}
CmiSimGetIccIdCnf;

/******************************************************************************
 * CMI_SIM_GET_SUBSCRIBER_NUMBER_REQ
 * +CNUM
******************************************************************************/
typedef CamCmiEmptySig CmiSimGetSubscriberNumReq;

//CMI_SIM_GET_SUBSCRIBER_NUMBER_CNF
#define     CMI_SIM_MAX_DIAL_NUMBER_LIST_SIZE 4
typedef struct CmiSimGetSubscriberNumCnfTag
{
    UINT8                   resvd1;
    UINT16                  resvd2;
    UINT8                   totalNum;//total numbers of dialling number list
    CmiSimDialNumber        dialNumberList[CMI_SIM_MAX_DIAL_NUMBER_LIST_SIZE];
}
CmiSimGetSubscriberNumCnf;


/******************************************************************************
 * CMI_SIM_OPERATE_PIN_REQ
 * +CPWD=<fac>,<oldpwd>,<newpwd> //<fac>:"SC" (change SIM PIN1)
 * +CPIN=<pin>[,<new pin>]       //verify/unblock pin
******************************************************************************/
typedef struct CmiSimOperatePinReqTag
{
    UINT8             pinOper; //CmiSimPinOper
    UINT8             pinNum; //CmiSimPinNum
    UINT16            reserved;
    CmiSimPinCode     pinCode;
    CmiSimPinCode     newPinCode;
}
CmiSimOperatePinReq;

//CMI_SIM_OPERATE_PIN_CNF
typedef struct CmiSimOperatePinCnfTag
{
    UINT8            pinOper; //CmiSimPinOper
    UINT8            remianRetries;
    UINT16           reserved;
}
CmiSimOperatePinCnf;

/*
* CMI_SIM_GET_PIN_STATE_REQ
* AT+CPIN?
*/
typedef CamCmiEmptySig CmiSimGetPinStateReq;

//CMI_SIM_GET_PIN_STATE_CNF
typedef struct CmiSimGetPinStateCnfTag
{
    //CmiRcCode          resultCode;
    UINT8                pinState;//CmiSimPinState
    UINT8                reserved1;
    UINT16               reserved2;
}
CmiSimGetPinStateCnf;

/******************************************************************************
 * CMI_SIM_LOCK_FACILITY_REQ
 * AT+CLCK=<fac>,<mode>[,<passwd>] //<fac>: "SC"
******************************************************************************/
typedef struct CmiSimFacilityLockReqTag
{
    UINT8                  mode;//CmiSimFacLockMode
    UINT8                  fac;//CmiSimFacility
    UINT16                 reserved;
    CmiSimPinCode          passwd;
}
CmiSimFacilityLockReq;

//CMI_SIM_LOCK_FACILITY_CNF
typedef struct CmiSimFacilityLockCnfTag
{
    UINT8            facStatus; //CmiSimFacStatus
    UINT8            mode;      //CmiSimFacLockMode
    UINT16           reserved2;
}
CmiSimFacilityLockCnf;

/******************************************************************************
 * CMI_SIM_GENERIC_ACCESS_REQ
 * AT+CSIM=<length>,<command>
******************************************************************************/
typedef struct CmiSimGenericAccessReqTag
{
    UINT16             reserved;
    UINT16             cmdReqLen;
    UINT8              cmdReqData[CMI_SIM_MAX_CMD_APDU_LEN];
}
CmiSimGenericAccessReq;

// CMI_SIM_GENERIC_ACCESS_CNF
typedef struct CmiSimGenericAccessCnfTag
{
    UINT16             reserved;
    UINT16             cmdRspLen;
    UINT8              *cmdRspData;
}
CmiSimGenericAccessCnf;

/******************************************************************************
 * CMI_SIM_RESTRICTED_ACCESS_REQ
 * AT+CRSM=<command>[,<fileid>[,<P1>,<P2>,<P3>[,<data>[,<pathid>]]]]
******************************************************************************/
typedef struct CmiSimRestrictedAccessReqTag
{
    CmiSimFilePath        filePath;
    UINT8                 uiccCmd;//CmiSimCmd
    UINT8                 p1;
    UINT8                 p2;
    UINT8                 dataLen;
    UINT8                 data[CMI_SIM_MAX_CMD_DATA_LEN];
    BOOL                  expResponse;    /* indicate if need expect response*/
    UINT8                 responseLen;
    UINT16                reserved;
}
CmiSimRestrictedAccessReq;

//CMI_SIM_RESTRICTED_ACCESS_CNF
typedef struct CmiSimRestrictedAccessCnfTag
{
    UINT8              sw1;
    UINT8              sw2;
    UINT16             cmdRspLen;
    UINT8              *cmdRspData;
}
CmiSimRestrictedAccessCnf;

/******************************************************************************
 * CMI_SIM_OPEN_LOGICAL_CHANNEL_REQ
 * +CCHO=<dfname>
******************************************************************************/
typedef struct CmiSimOpenLogicalChannelReqTag
{
    UINT8               length;
    UINT8               reserved1;
    UINT16              reserved2;
    UINT8               dfName[CMI_SIM_MAX_AID_LEN];
}
CmiSimOpenLogicalChannelReq;

//CMI_SIM_OPEN_LOGICAL_CHANNEL_CNF
typedef struct CmiSimOpenLogicalChannelCnfTag
{
    UINT8               sessionId;
    UINT8               reserved1;
    UINT16              reserved2;
}
CmiSimOpenLogicalChannelCnf;

/******************************************************************************
 * CMI_SIM_CLOSE_LOGICAL_CHANNEL_REQ
 * +CCHC=<sessionId>
******************************************************************************/
typedef struct CmiSimCloseLogicalChannelReqTag
{
    UINT8               sessionId;
    UINT8               reserved1;
    UINT16              reserved2;
}
CmiSimCloseLogicalChannelReq;

//CMI_SIM_CLOSE_LOGICAL_CHANNEL_CNF
typedef CamCmiEmptySig CmiSimCloseLogicalChannelCnf;

/******************************************************************************
 * CMI_SIM_GENERIC_LOGICAL_CHANNEL_ACCESS_REQ
 * +CGLA=<sessionId>,<length>,<command>
******************************************************************************/
typedef struct CmiSimGenLogicalChannelAccessReqTag
{
    UINT8              sessionId;
    UINT8              reserved;
    UINT16             cmdReqLen;
    UINT8              cmdReqData[CMI_SIM_MAX_CMD_APDU_LEN];
}
CmiSimGenLogicalChannelAccessReq;

//CMI_SIM_GENERIC_LOGICAL_CHANNEL_ACCESS_CNF
typedef struct CmiSimGenLogicalChannelAccessCnfTag
{
    UINT16             reserved;
    UINT16             cmdRspLen;
    UINT8              *cmdRspData;
}
CmiSimGenLogicalChannelAccessCnf;

/******************************************************************************
 * CMI_SIM_SET_EXT_CFG_REQ
 * AT+ECSIMCFG="SIMSIMULATOR",0/1,"SOFTSIM",0/1,"SIMPOWERSAVE",0/1,"SIMPRESENCEDETECT",0/1,"SIMSLOT",0/1
******************************************************************************/
typedef struct CmiSimSetExtCfgReq_Tag
{
    BOOL    simSimuPresent;     //whether enable SIM simulator or not
    BOOL    bSimSimulator;

    BOOL    softsimPresent;     //whether enable softsim or not
    BOOL    bSoftSim;

    BOOL    simPowerSavePresent; //whether enable SIM power save or not
    BOOL    bSimPowerSave;

    BOOL    simPreDetectPresent; //whether enable SIM presence detect or not
    BOOL    bSimPreDetect;

    BOOL    simSlotPresent;
    UINT8   simSlot; // SIM slot 0 or 1

    UINT16  resvd;

}CmiSimSetExtCfgReq;    // 8 bytes

typedef CamCmiEmptySig CmiSimSetExtCfgCnf;

/******************************************************************************
 * CMI_SIM_GET_EXT_CFG_REQ
 * AT+ECSIMCFG?
******************************************************************************/
typedef CamCmiEmptySig CmiSimGetExtCfgReq;

typedef struct CmiSimGetExtCfgCnf_Tag
{
    BOOL    bSimSimulator;
    BOOL    bSoftSim;
    BOOL    bSimPowerSave;
    BOOL    bSimPreDetect;

    UINT8   simSlot;
    UINT8   resvd1;
    UINT16  resvd2;
}
CmiSimGetExtCfgCnf;


/******************************************************************************
 * CMI_SIM_SET_SIM_SLEEP_REQ
 * +ECSIMSLEEP=<mode>
******************************************************************************/
typedef struct CmiSimSetSimSleepReqTag
{
    UINT8               mode;//CmiSimSleepMode
    UINT8               reserved1;
    UINT16              reserved2;
}
CmiSimSetSimSleepReq;

//CMI_SIM_SET_SIM_SLEEP_CNF
typedef CamCmiEmptySig CmiSimSetSimSleepCnf;

/******************************************************************************
 * CMI_SIM_GET_SIM_SLEEP_STATE_REQ
 * +ECSIMSLEEP?
******************************************************************************/
typedef CamCmiEmptySig CmiSimGetSimSleepStateReq;

//CMI_SIM_GET_SIM_SLEEP_STATE_CNF
typedef struct CmiSimGetSimSleepStateCnfTag
{
    UINT8               mode;//CmiSimSleepMode
    UINT8               reserved1;
    UINT16              reserved2;
}
CmiSimGetSimSleepStateCnf;

/******************************************************************************
 * CMI_SIM_QUERY_REMIAN_PIN_RETRIES_REQ
 * +CPINR[=<sel_code>]
******************************************************************************/
typedef struct CmiSimQueryRemianPinRetriesReqTag
{
    UINT8               pinCode;//CmiSimPinNum
    UINT8               reserved1;
    UINT16              reserved2;
}
CmiSimQueryRemianPinRetriesReq;

//CMI_SIM_QUERY_REMIAN_PIN_RETRIES_CNF
typedef struct CmiSimQueryRemianPinRetriesCnfTag
{
    UINT8               pinCode;//CmiSimPinNum
    UINT8               remianRetries[CMI_SIM_PIN_ALL];
    UINT8               defaultRetries[CMI_SIM_PIN_ALL];
    UINT8               reserved1;
    UINT16              reserved2;
}
CmiSimQueryRemianPinRetriesCnf;



/******************************************************************************
 * CMI_SIM_SET_SIM_WRITE_COUNTER_REQ
 * +ECSWC=<mode>
******************************************************************************/
typedef struct CmiSimSetSimWriteCounterReqTag
{
    UINT8               mode;//CmiSimWriteCounterMode
    UINT8               reserved1;
    UINT16              reserved2;
}
CmiSimSetSimWriteCounterReq;

//CMI_SIM_SET_SIM_WRITE_COUNTER_CNF
typedef struct CmiSimSetSimWriteCounterCnfTag
{
    UINT8                       mode;//CmiSimWriteCounterMode
    UINT8                       reserved1;
    UINT16                      reserved2;
    CmiSimWriteCntList          swcList;
}
CmiSimSetSimWriteCounterCnf;

/******************************************************************************
 * CMI_SIM_GET_SIM_WRITE_COUNTER_MODE_REQ
 * +ECSWC?
******************************************************************************/
typedef CamCmiEmptySig CmiSimGetSimWriteCounterModeReq;

//CMI_SIM_GET_SIM_WRITE_COUNTER_MODE_CNF
typedef struct CmiSimGetSimWriteCounterModeCnfTag
{
    UINT8               mode;//CmiSimWriteCounterMode
    UINT8               reserved1;
    UINT16              reserved2;
}
CmiSimGetSimWriteCounterModeCnf;


/******************************************************************************
 * CMI_SIM_SET_SIM_PRESENCE_DETECT_REQ
 * +ECSIMPD=<mode>
******************************************************************************/
typedef struct CmiSimSetSimPresenceDetectReqTag
{
    UINT8               mode;//CmiSimPresenceDetectMode
    UINT8               reserved1;
    UINT16              reserved2;
}
CmiSimSetSimPresenceDetectReq;

//CMI_SIM_SET_SIM_PRESENCE_DETECT_CNF
typedef CamCmiEmptySig CmiSimSetSimPresenceDetectCnf;

/******************************************************************************
 * CMI_SIM_GET_SIM_PRESENCE_DETECT_MODE_REQ
 * +ECSIMPD?
******************************************************************************/
typedef CamCmiEmptySig CmiSimGetSimPresenceDetectModeReq;

//CMI_SIM_GET_SIM_PRESENCE_DETECT_MODE_CNF
typedef struct CmiSimGetSimPresenceDetectModeCnfTag
{
    UINT8               mode;//CmiSimPresenceDetectMode
    UINT8               reserved1;
    UINT16              reserved2;
}
CmiSimGetSimPresenceDetectModeCnf;

/******************************************************************************
 * CMI_SIM_SET_TERMINAL_PROFILE_REQ
 * +ECUSATP=
******************************************************************************/
typedef struct CmiSimUsatSetTerminalProfileReqTag
{
    UINT8               resvd1;
    UINT16              resvd2;
    UINT8               tpLength;
    UINT8               tpData[CMI_SIM_USAT_MAX_TP_LEN];
}
CmiSimUsatSetTerminalProfileReq;

/*
* CMI_SIM_SET_TERMINAL_PROFILE_CNF
*/
typedef CamCmiEmptySig CmiSimUsatSetTerminalProfileCnf;

/******************************************************************************
 * CMI_SIM_GET_TERMINAL_PROFILE_REQ
 * +ECUSATP?
******************************************************************************/
typedef CamCmiEmptySig CmiSimUsatGetTerminalProfileReq;

//CMI_SIM_GET_TERMINAL_PROFILE_CNF
typedef struct CmiSimUsatGetTerminalProfileCnfTag
{
    UINT8               resvd1;
    UINT16              resvd2;
    UINT8               tpLength;
    UINT8               tpData[CMI_SIM_USAT_MAX_TP_LEN];
}
CmiSimUsatGetTerminalProfileCnf;


/******************************************************************************
 * CMI_SIM_SET_SIM_REMOVAL_REQ
 * +ECSIMRM
******************************************************************************/
typedef CamCmiEmptySig CmiSimSetSimRemovalReq;

//CMI_SIM_SET_SIM_REMOVAL_CNF
typedef CamCmiEmptySig CmiSimSetSimRemovalCnf;

/******************************************************************************
 * CMI_SIM_GET_SMS_PARAMS_REQ
******************************************************************************/
typedef CamCmiEmptySig CmiSimGetSmsParamsReq;

// CMI_SIM_GET_SMS_PARAMS_CNF
typedef struct CmiSimGetSmsParamsCnfTag
{
    UINT8                      bDestAddrPresent:1;
    UINT8                      bScAddrPresent:1;
    UINT8                      bProtocolIdPresent:1;
    UINT8                      bCodingSchemePresent:1;
    UINT8                      bValidityPeriodPresent:1;
    UINT8                      reserved:3;
    UINT8                      smsProtocolId;
    UINT8                      smsDataCodingScheme;
    UINT8                      validityPeriod;
    CmiSimSmsAddress           destAddr;
    CmiSimSmsAddress           scAddr;
}
CmiSimGetSmsParamsCnf;

/******************************************************************************
 * CMI_SIM_SET_HOT_SWAP_NOTIFY_REQ
******************************************************************************/
typedef struct CmiSimSetHotSwapNotifyReqTag
{
    BOOL        bSimPlugIn;// indicated whether the SIM card plugged in or out
    UINT8       reserved1;
    UINT16      reserved2;
}
CmiSimSetHotSwapNotifyReq;

/*
* CMI_SIM_SET_HOT_SWAP_NOTIFY_CNF
*/
typedef CamCmiEmptySig CmiSimSetHotSwapNotifyCnf;

/******************************************************************************
 * CMI_SIM_SET_PREFERRED_PLMN_LIST_REQ
******************************************************************************/
typedef struct CmiSimSetPreferredPlmnListReqTag
{
    UINT16               index; //0 means invalid
    UINT8                format;
    UINT8                resvd1;
    UINT16               resvd2;
    UINT16               accessTechnology; /* Access Technology, if no act, set to 0*/
    CmiNumericPlmn       plmn;
}
CmiSimSetPreferredPlmnListReq;

/*
* CMI_SIM_SET_PREFERRED_PLMN_LIST_CNF
*/
typedef CamCmiEmptySig CmiSimSetPreferredPlmnListCnf;

/******************************************************************************
 * CMI_SIM_GET_PREFERRED_PLMN_LIST_REQ
******************************************************************************/
typedef CamCmiEmptySig CmiSimGetPreferredPlmnListReq;

/*
* CMI_SIM_GET_PREFERRED_PLMN_LIST_CNF
*/
typedef struct CmiSimGetPreferredPlmnListCnfTag
{
    UINT16               index; //0 means invalid
    UINT8                format; //CmiSimPlmnFormatEnum
    BOOL                 bEndStatus; //whether it's end status
    UINT16               accessTechnology; /* Access Technology, if no act, set to 0*/
    UINT16               resvd;
    CmiNumericPlmn       plmn;
}
CmiSimGetPreferredPlmnListCnf;

/******************************************************************************
 * CMI_SIM_SET_SELECT_PLMN_LIST_REQ
******************************************************************************/
typedef struct CmiSimSetSelectPlmnListReqTag
{
    UINT8           plmnList;//CmiSimSelPreferPlmnList
    UINT8           resved1;
    UINT16          resved2;
}
CmiSimSetSelectPlmnListReq;

/*
* CMI_SIM_SET_SELECT_PLMN_LIST_CNF
*/
typedef CamCmiEmptySig CmiSimSetSelectPlmnListCnf;

/******************************************************************************
 * CMI_SIM_GET_SELECT_PLMN_LIST_REQ
******************************************************************************/
typedef CamCmiEmptySig CmiSimGetSelectPlmnListReq;

/*
* CMI_SIM_GET_SELECT_PLMN_LIST_CNF
*/
typedef struct CmiSimGetSelectPlmnListCnfTag
{
    UINT8           plmnList;//CmiSimSelPreferPlmnList
    UINT8           resved1;
    UINT16          resved2;
}
CmiSimGetSelectPlmnListCnf;



/*
* CMI_SIM_UICC_STATE_IND
*/
typedef struct CmiSimUiccStateIndTag
{
    UINT8              uiccState;//CmiSimStatus
    UINT8              reserved1;
    UINT16             reserved2;
    CmiSimImsiStr      imsiStr;  /* IMSI sting */
}
CmiSimUiccStateInd;

/*
* CMI_SIM_UICC_PIN_STATE_IND
*/
typedef struct CmiSimUiccPinStateIndTag
{
    UINT8              uiccPinState;//CmiSimPinState
    UINT8              reserved1;
    UINT16             reserved2;
}
CmiSimUiccPinStateInd;

/*
* CMI_SIM_USAT_OPEN_CHANNEL_IND
*/
typedef struct CmiSimUsatOpenChannelIndTag
{
    //UINT32                              cmdDetailsRef;
    CmiSimUsatBipEqos                   bipEqos;
    CmiSimUsatBipQos                    bipQos;
    UINT16                              reserved;
    UINT8                               bearerType;//CmiSimBearerType
    //UINT16                              bufferSize;
    UINT8                               apnLength;//if the length is not zero, the apn is present
    UINT8                               apnName[CMI_SIM_MAX_APN_NAME];
    CmiSimTextString                    userLogin;
    CmiSimTextString                    userPassword;
    UINT8                               transFormat;//CmiSimTransportFormat
    UINT16                              portNum;
    //UINT8                               addressType;
    //UINT16                              reserved;
    UINT8                               addressLength;//=0/4/16, 0 means this item is not present
    UINT8                               destAddress[CMI_SIM_USAT_MAX_ADDRESS_LEN];//destination address, IPV4--4bytes; IPV6--16bytes
}
CmiSimUsatOpenChannelInd;

/*
* CMI_SIM_USAT_OPEN_CHANNEL_RSP
*/
typedef struct CmiSimUsatOpenChannelRspTag
{
    //UINT32                          cmdDetailsRef;
    CmiSimUsatCmdResult             cmdResult;
    UINT8                           bearType;//CmiSimBearerType
    //UINT16                          bufferSize;
    UINT8                           channelId;
    BOOL                            linkEstOrPsActive;
    CmiSimUsatBipEqos               bipEqos;
    CmiSimUsatBipQos                bipQos;
}
CmiSimUsatOpenChannelRsp;

/*
* CMI_SIM_USAT_CLOSE_CHANNEL_IND
*/
typedef struct CmiSimUsatCloseChannelIndTag
{
    //UINT32                              cmdDetailsRef;
    UINT8                               channelId;
    UINT8                               reserved1;
    UINT16                              reserved2;
}
CmiSimUsatCloseChannelInd;

/*
* CMI_SIM_USAT_CLOSE_CHANNEL_RSP
*/
typedef struct CmiSimUsatCloseChannelRspTag
{
    //UINT32                          cmdDetailsRef;
    CmiSimUsatCmdResult             cmdResult;
}
CmiSimUsatCloseChannelRsp;

/*
* CMI_SIM_USAT_SEND_DATA_IND
*/
typedef struct CmiSimUsatSendDataIndTag
{
    CmiSimUsatBipDataPdu            *pBipData;
}
CmiSimUsatSendDataInd;

/*
* CMI_SIM_USAT_SEND_DATA_RSP
*/
typedef struct CmiSimUsatSendDataRspTag
{
    //UINT32                          cmdDetailsRef;
    CmiSimUsatCmdResult             cmdResult;
}
CmiSimUsatSendDataRsp;

/*
* CMI_SIM_USAT_DATA_AVAILABLE_REQ
*/
typedef struct CmiSimUsatDataAvailableReqTag
{
    CmiSimUsatBipDataPdu            *pBipData;
}
CmiSimUsatDataAvailableReq;

/*
* CMI_SIM_USAT_DATA_AVAILABLE_CNF
*/
typedef UINT32 CmiSimUsatDataAvailableCnf;//GosEmptySignal

/*
* CMI_SIM_USAT_CHANNEL_STATUS_EVENT_REQ
*/
typedef struct CmiSimUsatChannelStatusEventReqTag
{
    UINT8                           channelId;
    BOOL                            linkEstOrPsActive;
    UINT8                           addiInfo;//UsatAddiInfoChannlStatus
    UINT8                           reserved;
}
CmiSimUsatChannelStatusEventReq;

/*
* CMI_SIM_USAT_CHANNEL_STATUS_EVENT_CNF
*/
typedef UINT32 CmiSimUsatChannelStatusEventCnf;//GosEmptySignal


/*
* CMI_SIM_USAT_GET_CHANNEL_STATUS_IND
*/
typedef UINT32 CmiSimUsatGetChannelStatusInd;//GosEmptySignal

/*
* CMI_SIM_USAT_GET_CHANNEL_STATUS_Rsp
*/
typedef struct CmiSimUsatGetChannelStatusRspTag
{
    //UINT32                          cmdDetailsRef;
    CmiSimUsatCmdResult             cmdResult;
    UINT8                           channelId;
    BOOL                            linkEstOrPsActive;
    UINT16                          reserved;
}
CmiSimUsatGetChannelStatusRsp;




#endif

