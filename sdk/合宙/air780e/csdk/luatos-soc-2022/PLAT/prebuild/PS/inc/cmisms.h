#ifndef __CMI_SMS_H__
#define __CMI_SMS_H__
/******************************************************************************
Copyright:      - 2017- Copyrights of AirM2M Ltd.
File name:      - cmisms.h
Description:    - CMI (CIoT modem interface) SMS handling interface defination
History:        - 10/12/2017, Originated by xpliu
******************************************************************************/
#include "cmicomm.h"


typedef enum CMI_SMS_PRIM_ID_TAG
{
    CMI_SMS_PRIM_BASE = 0,

    CMI_SMS_SEND_MSG_REQ,//AT+CMGS=...<ctrl+z>
    CMI_SMS_SEND_MSG_CNF,

    CMI_SMS_SEND_STORED_MSG_REQ,//AT+CMSS=<index>
    CMI_SMS_SEND_STORED_MSG_CNF,

    CMI_SMS_SEND_COMMAND_REQ,//AT+CMGC=...<ctrl+z>
    CMI_SMS_SEND_COMMAND_CNF,

    CMI_SMS_NEW_MSG_MEM_LOCATION_IND,//+CMTI
    CMI_SMS_NEW_MSG_IND,//+CMT
    CMI_SMS_NEW_MSG_RSP,//+CNMA

    CMI_SMS_GET_SMSC_ADDR_REQ = 10,//AT+CSCA? //10
    CMI_SMS_GET_SMSC_ADDR_CNF,
    CMI_SMS_SET_SMSP_REQ,//AT+CSCA/CSMP
    CMI_SMS_SET_SMSP_CNF,

    CMI_SMS_SELECT_MESSAGE_SERVICE_REQ,   //AT+CSMS=
    CMI_SMS_SELECT_MESSAGE_SERVICE_CNF,
    CMI_SMS_GET_CURRENT_SMS_SERVICE_REQ,      //AT+CSMS?
    CMI_SMS_GET_CURRENT_SMS_SERVICE_CNF,
    CMI_SMS_GET_SUPPORTED_SMS_SERVICE_REQ,      //AT+CSMS=?
    CMI_SMS_GET_SUPPORTED_SMS_SERVICE_CNF,

    CMI_SMS_SET_MORE_MESSAGE_MODE_REQ = 20,  //AT+CMMS=  //20
    CMI_SMS_SET_MORE_MESSAGE_MODE_CNF,
    CMI_SMS_GET_MORE_MESSAGE_MODE_REQ,  //AT+CMMS?
    CMI_SMS_GET_MORE_MESSAGE_MODE_CNF,

    CMI_SMS_GET_CSCB_SETTING_REQ,//AT+CSCB?
    CMI_SMS_GET_CSCB_SETTING_CNF,
    CMI_SMS_SET_CSCB_SETTING_REQ,//AT+CSCB=
    CMI_SMS_SET_CSCB_SETTING_CNF,

    CMI_SMS_GET_SMS_MSG_RECORD_REQ, //+CMSS/+CMGR get SMS storaged message from SIM.
    CMI_SMS_GET_SMS_MSG_RECORD_CNF,

    CMI_SMS_SET_SMS_MSG_RECORD_REQ = 30, //+CMGW save the SMS message to SIM //30
    CMI_SMS_SET_SMS_MSG_RECORD_CNF,

    CMI_SMS_DEL_SMS_MSG_RECORD_REQ, //+CMGD, delet SMS message record in SIM
    CMI_SMS_DEL_SMS_MSG_RECORD_CNF,

    CMI_SMS_LIST_SMS_MSG_RECORD_REQ, //+CMGL, List all SMS message record in SIM, +CPMS get statistics info of the SMS storage in SIM
    CMI_SMS_LIST_SMS_MSG_RECORD_CNF,

    CMI_SMS_GET_SMS_STORAGE_STATUS_REQ, // +CPMS get statistics info of the SMS storage in SIM
    CMI_SMS_GET_SMS_STORAGE_STATUS_CNF,

    CMI_SMS_SEND_SMMA_REQ,  //send RP-SMMA
    CMI_SMS_SEND_SMMA_CNF,

    CMI_SMS_MEM_CAP_IND = 40, //Report SMS Memory Capacity Exceeded flag

    CMI_SMS_SET_MEM_CAP_REQ, //Setting SMS "Memory Capacity Exceeded" Notification Flag
    CMI_SMS_SET_MEM_CAP_CNF,

    CMI_SMS_IDLE_STATUS_IND,

    CMI_SMS_PRIM_END = 0x0fff
}CMI_SMS_PRIM_ID;


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/******************************************************************************
 * CMI_SMS_SEND_MSG_REQ
******************************************************************************/
#define CMI_SMS_MAX_PDU_SIZE                180
#define CMI_SMS_MAX_LENGTH_OF_ADDRESS_VALUE 40

/* Refer to TS-27.005 3.1 Parameter definitions Parameter <Stat> for PDU mode */
typedef enum CmiSmsRecStorStatus_Enum
{
    CMI_SMS_STOR_STATUS_REC_UNREAD = 0,  /* Received unread message, i.e new message */
    CMI_SMS_STOR_STATUS_REC_READ   = 1,  /* Received read message */
    CMI_SMS_STOR_STATUS_STO_UNSENT = 2,  /* Stored unsent message only applicable to SMs */
    CMI_SMS_STOR_STATUS_STO_SENT   = 3,  /* Stored sent message only applicable to SMs */
    CMI_SMS_STOR_STATUS_ALL        = 4,  /* All message, only applicable to +CGML command */
    CMI_SMS_STOR_STATUS_END
}CmiSmsRecStorStatus;

/*
 * enum to record current MSG/SMS operation
 */
typedef enum
{
    CMI_SMS_OPER_NULL,
    CMI_SMS_OPER_LIST_MSG_WITH_STATUS = 1,  /* List all storaged SMS msg, +CMGL */
    CMI_SMS_OPER_STORE_INFO_GETTING,        /* Get the SMS storaged memory information. for +CPMS? */
    CMI_SMS_OPER_STORE_INFO_SETTING,        /* Set the SMS storaged memory information. for +CPMS= */
    CMI_SMS_OPER_READ_MSG,                  /* Read a SMS message, for +CMGR */
    CMI_SMS_OPER_READ_SEND_MSG,             /* Read a SMS message and send it, for +CMSS */
    CMI_SMS_OPER_STORE_MT_MSG,              /* Store the received SMS msg for MT SMS (+CMT/+CMTI) */
    CMI_SMS_OPER_STORE_MT_MSG_NO_RSP,       /* Store the received SMS msg for MT SMS and no need send indication for Mem index. */
    CMI_SMS_OPER_STORE_CBM,                 /* Store the received Cell Broadcast msg for CBM (+CBM/+CBMI) */
    CMI_SMS_OPER_STORE_UNSENT_MSG,          /* Store the Unsend message, for +CMGW */
    CMI_SMS_OPER_STORE_STATUS_RPT,          /* Store the SMS status report, for (+CDS/+CDSI) */
    CMI_SMS_OPER_STORE_STATUS_RPT_NO_RSP,   /* Store the SMS status report and no need send indication for Mem index */
    CMI_SMS_OPER_DEL_MSG_WITH_INDEX,        /* Deleted a SMS messag with index, for +CMGD and delflag is NULL. */
    CMI_SMS_OPER_DEL_MSG_WITH_STATE,        /* Deleted somes message with the status of SMS message, for +CMGD and delflag is not NULL */
    CMI_SMS_OPER_DEL_ALL_MSG,               /* Deleted all SMS message. for +GMGD, and the delflag is 4. */
    CMI_SMS_OPER_DEL_INFO_GETTING,          /* Get the SMS storaged memory information. for +CMGD=? */
    CMI_SMS_OPER_IS_SMSFULL,                /* Get the SMS storaged memory information. for +ECSMSFULL */
    CMI_SMS_OPER_END
}CmiSmsOperationMode;

/*
 * the result of read/write SMS message from/to Preferred storage memory. for API read/write SMS message
*/
typedef enum CmiSmsAccessMemRet_enum
{
    CMS_ACC_MEM_RET_SUCC             = 0,
    CMS_ACC_MEM_RET_CONTINUE         = 1,

    CMS_ACC_MEM_RET_FAIL             = 100,
    CMS_ACC_MEM_RET_INVALID_PARAM    = 101,
    CMS_ACC_MEM_RET_LIST_FULL        = 102,
    CMS_ACC_MEM_RET_LIST_NOT_FOUND   = 103,
    CMS_ACC_MEM_RET_OPER_NOT_SUPPROT = 104,   /* operation not supported */
    CMS_ACC_MEM_RET_NO_MEM           = 105,

    CMS_ACC_MEM_RET_END
}CmiSmsAccMemRet;

typedef struct _EPAT_CmiSmsPdu_Tag
{
    UINT16   pduLength;
    UINT16   reserved0;
    UINT8    pduData[CMI_SMS_MAX_PDU_SIZE];
}CmiSmsPdu;

/* Refer to TS 23.040-9.1.2.5 Address fields */
typedef enum CmiSmsTypeOfNumberEnum_Tag
{
    CMI_SMS_TYPE_OF_NUM_UNKNOWN          = 0,  /* Unknown */
    CMI_SMS_TYPE_OF_NUM_INTERNATIONAL    = 1,  /* Internation Number */
    CMI_SMS_TYPE_OF_NUM_NATIONAL         = 2,  /* National Number */
    CMI_SMS_TYPE_OF_NUM_NETWORK_SPECIFIC = 3,  /* Network Specific */
    CMI_SMS_TYPE_OF_NUM_SUBSCRIBER       = 4,  /* Subscriber number */
    CMI_SMS_TYPE_OF_NUM_ALPHANUMERIC     = 5,  /* Alphanumeric, GSM 7-bit */
    CMI_SMS_TYPE_OF_NUM_EXTENSION        = 7   /* Reserved for Extension */

}CmiSmsTypeOfNumberEnum;

typedef enum CmiSmsNumberPlanIdEnum_Tag
{
    CMI_SMS_NUM_PLAN_ID_UNKNOWN                = 0,     /* Unknown */
    CMI_SMS_NUM_PLAN_ID_ISDN_TELEPHONY         = 1,     /* ISDN/telephony numbering plan */
    CMI_SMS_NUM_PLAN_ID_DATA                   = 3,     /* Data Numbering Plan(X.121) */
    CMI_SMS_NUM_PLAN_ID_TELEX                  = 4,     /* Telex Numbering Plan */
    CMI_SMS_NUM_PLAN_SERVICE_CENTRE_SPECIFIC   = 5,     /* Service Centre Specific plan */
    CMI_SMS_NUM_PLAN_ID_NATIONAL               = 8,     /* National Number Plan */
    CMI_SMS_NUM_PLAN_ID_PRIVATE                = 9,     /* Private Numbering Plan */
    CMI_SMS_NUM_PLAN_ID_ERMES                  = 10,    /* ERMES numbering plan */
    CMI_SMS_NUM_PLAN_ID_RESERVED_FOR_EXTENSION = 15     /* Reserved for Extension */

}CmiSmsNumberPlanIdEnum;

typedef struct _EPAT_CmiSmsAddressType_Tag
{
    UINT8    typeOfNumber;   /* Type of Number  CmiSmsTypeOfNumberEnum */
    UINT8    numberPlanId;   /* Number Plan Identification  CmiSmsNumberPlanIdEnum */
    UINT16   reserved0;
}CmiSmsAddressType;

typedef struct _EPAT_CmiSmsAddressInfo_Tag
{
    CmiSmsAddressType    addressType;       /* Address Type Information */
    UINT8                addressLength;     /* Address Length in digits */
    UINT8                reserved0;
    UINT16               reserved1;
    UINT8                addressDigits[CMI_SMS_MAX_LENGTH_OF_ADDRESS_VALUE];    /* Address digits */
}CmiSmsAddressInfo;

typedef struct CmiSmsOptAddressInfo_Tag
{
    BOOL                 present;   /* Address info present or not */
    UINT8                reserved0;
    UINT16               reserved1;
    CmiSmsAddressInfo    addressInfo;
}CmiSmsOptAddressInfo;

typedef enum CmiSmsRPCause_Tag
{
    CMI_SMS_RP_CAUSE_UNASSIGNED_NUMBER          = 1,
    CMI_SMS_RP_CAUSE_OPERATOR_DETERMIN_BARRING  = 8,
    CMI_SMS_RP_CAUSE_BARRED                     = 10,
    CMI_SMS_RP_CAUSE_RESERVD                    = 11,
    CMI_SMS_RP_CAUSE_TRANSFER_REJECTED          = 21,
    CMI_SMS_RP_CAUSE_NEMORY_EXCEED              = 22,
    CMI_SMS_RP_CAUSE_DESTION_OUT_OF_ORDER       = 27,
    CMI_SMS_RP_CAUSE_UNIDENTIFIED_FORMAT        = 28,
    CMI_SMS_RP_CAUSE_FACILITY_REJECTED          = 29,
    CMI_SMS_RP_CAUSE_UNKNOWN_SUBSCRIBER         = 30,
    CMI_SMS_RP_CAUSE_NETWORK_OUT_OF_ORDER       = 38,
    CMI_SMS_RP_CAUSE_TEMP_FAILURE               = 41,
    CMI_SMS_RP_CAUSE_CONGETION                  = 42,
    CMI_SMS_RP_CAUSE_RESOURCE_UNAVAILABLE       = 47,
    CMI_SMS_RP_CAUSE_REQ_FAC_NOT_SUBSCR         = 50,
    CMI_SMS_RP_CAUSE_REQ_FACILITY_NOT_IMPLEMENT = 69,
    CMI_SMS_RP_CAUSE_INVALID_TI_VALUE           = 81,
    CMI_SMS_RP_CAUSE_INVALID_MSG_SEMANTICALLY   = 95,
    CMI_SMS_RP_CAUSE_MANDATORY_IE_ERROR         = 96,
    CMI_SMS_RP_CAUSE_MSG_TYPE_NO_EXISTENT       = 97,
    CMI_SMS_RP_CAUSE_MSG_NOT_COMPATIABLE        = 98,
    CMI_SMS_RP_CAUSE_IE_NON_EXISTENT            = 99,
    CMI_SMS_RP_CAUSE_PROTOCOL_ERROR             = 111,
    CMI_SMS_RP_CAUSE_INTERWORKING               = 127

}CmiSmsRPCause;

typedef struct CmiSmsSendMsgReq_Tag
{
    CmiSmsOptAddressInfo     optSca;
    CmiSmsPdu                pdu;
}CmiSmsSendMsgReq,CmiSmsSendStoredMsgReq;

typedef struct CmiSmsSendMsgCnf_Tag
{
    UINT8           msgReference;   /* Message Reference */
    UINT8           rpCause;        /* RP cause */
    UINT8           tpCause;        /* TP cause */
    BOOL            ackPduPresent;
    UINT16          errorCode;
    UINT16          reserved1;
    CmiSmsPdu       pdu;
}CmiSmsSendMsgCnf, CmiSmsSendStoredMsgCnf, CmiSmsSendSMMACnf;

typedef struct CmiSmsRspInfo_Tag
{
    CmiSmsErrorCode     errorCode;      /* Error code */
    UINT8               msgReference;   /* Message Reference */
    UINT8               rpCause;        /* RP cause */
    UINT8               tpCause;        /* TP cause */
    CmiSmsPdu           pdu;
}CmiSmsRspInfo;

/******************************************************************************
 * CMI_SMS_SEND_COMMAND_REQ
******************************************************************************/

typedef struct CmiSmsCmdRspInfo_Tag
{
    CmiSmsErrorCode     errorCode;
    UINT8               msgReference;   /* Message Reference */
}CmiSmsCmdRspInfo;

typedef struct CmiSmsSendCommandReq_Tag
{
    CmiSmsPdu           pdu;
}CmiSmsSendCommandReq;

typedef struct CmiSmsSendCommandCnf_Tag
{
    UINT8           msgReference;       /* Message Reference */
    BOOL            ackPduPresent;
    CmiSmsPdu       pdu;
}CmiSmsSendCommandCnf;


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/******************************************************************************
 * CMI_SMS_NEWMSG_IND
******************************************************************************/
typedef enum CmiSmsMsgCoding_Tag
{
    CMI_SMS_CODING_DEFAULT_ALPHABET = 0,    /* Default 7 bit coding */
    CMI_SMS_CODING_8_BIT_DATA = 1,          /* 8bit coding */
    CMI_SMS_CODING_UCS2_ALPHABET = 3,       /* UCS2 coding */

}CmiSmsMsgCoding;

typedef enum CmiSmsMessageType_Tag
{
    CMI_SMS_TYPE_DELIVER = 0,       /* SMS-Deliver PDU */
    CMI_SMS_TYPE_DELIVER_REPORT,    /* SMS-Deliver Report PDU */
    CMI_SMS_TYPE_STATUS_REPORT,     /* SMS-Status Report PDU */
    CMI_SMS_TYPE_CB_ETWS_CMAS,      /* CB SMS */
    CMI_SMS_TYPE_SUBMIT,            /* SMS-SUBMIT */
    CMI_SMS_TYPE_COMMAND,           /* SMS-COMMAND */

    CMI_SMS_TYPE_RESERVE
}CmiSmsMessageType;

typedef enum CmiSmsMessageClass_Tag
{
    CMI_SMS_MESSAGE_CLASS0          = 0x00,
    CMI_SMS_MESSAGE_CLASS1          = 0x01,
    CMI_SMS_MESSAGE_CLASS2          = 0x02,
    CMI_SMS_MESSAGE_CLASS3          = 0x03,
    CMI_SMS_NO_MESSAGE_CLASS,
}CmiSmsMessageClass;

/* Refer to TS-27.005 3.4.1 <mt> SMS-DELIVER report mode configured by +CNMI
 * spec 27.005 Table 3.4.1-2 <mt> parameter
 */
typedef enum CmiSmsDeliverRptMode_Tag
{
    CMI_SMS_DELIVER_RPT_MODE_0 = 0,
    CMI_SMS_DELIVER_RPT_MODE_1 = 1,
    CMI_SMS_DELIVER_RPT_MODE_2 = 2,
    CMI_SMS_DELIVER_RPT_MODE_3 = 3,
    CMI_SMS_DELIVER_RPT_RESERVE
}CmiSmsDeliverRptMode;

/* Refer to TS-27.005 3.4.1 <bm> CBM(Cell Broadcast Message) report mode configured by +CNMI
 * spec 27.005 Table 3.4.1-4 <bm> parameter
 */
typedef enum CmiSmsCbmRptMode_Tag
{
    CMI_SMS_CBM_RPT_MODE_0 = 0,
    CMI_SMS_CBM_RPT_MODE_1 = 1,
    CMI_SMS_CBM_RPT_MODE_2 = 2,
    CMI_SMS_CBM_RPT_MODE_3 = 3,
    CMI_SMS_CBM_RPT_RESERVE
}CmiSmsCbmRptMode;

/* Refer to TS-27.005 3.4.1 <ds> SMS-STATUS-REPORTs report mode configured by +CNMI
 * spec 27.005 Table 3.4.1-5 <ds> parameter
 */
typedef enum CmiSmsStatusRptMode_Tag
{
    CMI_SMS_STATUS_RPT_MODE_0 = 0,
    CMI_SMS_STATUS_RPT_MODE_1 = 1,
    CMI_SMS_STATUS_RPT_MODE_2 = 2,
    CMI_SMS_STATUS_RPT_RESERVE
}CmiSmsStatusRptMode;

/* Refer to TS-27.005 3.1 Parameter definitions Parameter <mem1>/<mem2>/<mem3> */
typedef enum CmiSmsStorage_Tag
{
    CMI_SMS_STORAGE_BM = 0,     /* BM(Broadcast Message) Storage */
    CMI_SMS_STORAGE_ME = 1,     /* ME Storage */
    CMI_SMS_STORAGE_MT = 2,     /* MT Storage */
    CMI_SMS_STORAGE_SM = 3,     /* SIM Storage */
    CMI_SMS_STORAGE_TA = 4,     /* TA message storage */
    CMI_SMS_STORAGE_SR = 5      /* SMS-Status Report Storage */

}CmiSmsStorage;

/* Display SMS content AT command */
typedef enum CmiSmsDisplayCmd_Tag
{
    CMI_SMS_SHOW_CMGR   = 0,    //+CMGR
    CMI_SMS_SHOW_CMGL   = 1,    //+CMGL
    CMI_SMS_SHOW_CMT    = 2,    //+CMT
    CMI_SMS_SHOW_CMTI   = 3,    //+CMTI
    CMI_SMS_SHOW_CBM    = 4,    //+CBM
    CMI_SMS_SHOW_CBMI   = 5,    //+CBMI
    CMI_SMS_SHOW_CDS    = 6,    //+CDS
    CMI_SMS_SHOW_CDSI   = 7,    //+CDSI
    CMI_SMS_SHOW_ECCMGR = 8,    //+ECMGR
    CMI_SMS_DISPLAY_END

} CmiSmsDisplayCmd;

typedef struct CmiNewSmsInfo_Tag
{
    UINT8               smsType;       /* CmiSmsMessageType */
    UINT8               smsId;
    UINT8               smsCoding;     /* CmiSmsMsgCoding */
    UINT8               smsClass;      /* SmsMessageClass */
}CmiNewSmsInfo;

typedef struct CmiSmsNewMsgInd_Tag
{
    UINT8               smsType;       /* CmiSmsMessageType */
    UINT8               smsId;
    UINT8               smsCoding;     /* CmiSmsMsgCoding */
    UINT8               smsClass;      /* SmsMessageClass */
    BOOL                smscPresent;
    UINT8               reserved0;
    UINT16              reserved1;
    CmiSmsAddressInfo   smscAddress;
    CmiSmsPdu           pdu;
}CmiSmsNewMsgInd;

/******************************************************************************
 * CMI_SMS_NEW_MSG_MEM_LOCATION_IND
******************************************************************************/
typedef struct CmiSmsNewMsgMemLocationInd_Tag
{
    UINT16       rc;
    UINT8        index;
    UINT8        operatmode;  /* CmiSmsOperationMode */
}CmiSmsNewMsgMemLocationInd;

/******************************************************************************
 * CMI_SMS_NEW_MSG_RSP
******************************************************************************/
typedef struct CmiSmsNewMsgRsp_Tag
{
    BOOL         bRPAck;
    UINT8        smsId;
    UINT8        tpCause;
    BOOL         pduPresent;
    CmiSmsPdu    pdu;
}CmiSmsNewMsgRsp;

typedef CamCmiEmptySig CmiSmsGetScAddressRequest;

typedef struct CmiSmsGetScAddressConfirm_Tag
{
    BOOL                       smscPresent;
    UINT8                      reserved0;
    UINT16                     reserved1;
    CmiSmsAddressInfo          smscAddress;    /* Service center address */
}CmiSmsGetScAddressConfirm;

typedef struct CmiSmsSetSmspRequest_Tag
{
    BOOL                       destAddrPresent;
    BOOL                       protocolIdPresent;
    BOOL                       codingSchemePresent;
    BOOL                       validityPeriodPresent;
    CmiSmsAddressInfo          destAddr;
    CmiSmsAddressInfo          smscAddress;    /* Service center address */
    UINT8                      smsProtocolId;
    UINT8                      smsDataCodingScheme;
    UINT8                      validityPeriod;
    BOOL                       scAddrPresent;
}CmiSmsSetSmspRequest;

typedef CamCmiEmptySig CmiSmsSetSmspCnfonfirm;

#define SMS_SERVICE_NUM     3

typedef enum CmiSmsMessageService_Tag
{
    CMI_SMS_MESSAGE_SERVICE_NO_ACKNOWLEDGEMENT    = 0,  /* no acknowledgement */
    CMI_SMS_MESSAGE_SERVICE_ACKNOWLEDGEMENT       = 1,  /* acknowledgement */
    /* 2...127 reserved */
    CMI_SMS_MESSAGE_SERVICE_MANUFACTURER_SPECIFIC = 128 /* manufacturer specific */

}CmiSmsMessageService;

typedef struct CmiSmsTypesOfMessages_Tag
{
    BOOL                    mtTypeSupported;
    BOOL                    moTypeSupported;
    BOOL                    bmTypeSupported;
}CmiSmsTypesOfMessages;

typedef CamCmiEmptySig CmiSmsGetSupportedSmsServiceReq;

typedef struct CmiSmsGetSupportedSmsServiceCnf_Tag
{
    CmiSmsErrorCode         errorCode;
    UINT8                   length;
    CmiSmsMessageService    serviceList[SMS_SERVICE_NUM];
}CmiSmsGetSupportedSmsServiceCnf;

typedef struct CmiSmsSelectMessageServiceReq_Tag
{
    CmiSmsMessageService    smsMsgService;
}CmiSmsSelectMessageServiceReq;

typedef struct CmiSmsSelectMessageServiceCnf_Tag
{
    CmiSmsErrorCode             errorCode;
    CmiSmsTypesOfMessages       typeOfMessage;
}CmiSmsSelectMessageServiceCnf;

typedef CamCmiEmptySig CmiSmsGetCurrentSmsServiceReq;

typedef struct CmiSmsGetCurrentSmsServiceCnf_Tag
{
    CmiSmsErrorCode             errorCode;
    CmiSmsMessageService        smsMsgService;
    CmiSmsTypesOfMessages       typeOfMessage;
}CmiSmsGetCurrentSmsServiceCnf;

typedef enum _SIG_EPAT_CCM_CFG_SMS_MORE_MSG_MODE
{
    CMI_SMS_DISABLE_MORE_MESSAGE_SEND = 0,      /* disable more message send */
    CMI_SMS_TEMP_MORE_MESSAGE_SEND    = 1,      /* keep enabled until UE close the link */
    CMI_SMS_ALWAYS_MORE_MESSAGE_SEND  = 2,      /* keep enabled until UE set AT+CMMS=0 or 1 */
    CMI_SMS_ERROR_MORE_MESSAGE_SEND   = 255

}CmiSmsMoreMessage;

typedef struct CmiSmsSetMoreMessageReq_Tag
{
    CmiSmsMoreMessage           smsMoreMsgMode;
}CmiSmsSetMoreMessageReq;

typedef CamCmiEmptySig CmiSmsSetMoreMessageModeCnf;

typedef CamCmiEmptySig CmiSmsGetMoreMessageModeReq;

typedef struct CmiSmsGetMoreMessageModeCnf_Tag
{
    UINT8                       smsMoreMsgMode;
}CmiSmsGetMoreMessageModeCnf;

#define CI_SMS_SIGNAL_NUM_MAX                   5
#define CI_SMS_RANGE_LIST_MAX                   5


typedef struct CmiSmsNumberRange_Tag
{
    UINT32                          min;
    UINT32                          max;
}CmiSmsNumberRange;

typedef struct CmiSmsNumberList_Tag
{
    BOOL                            bSignalNum;
    BOOL                            bRangeNum;
    UINT8                           rangeLen;
    UINT8                           signalNum;
    UINT32                          signalNumList[CI_SMS_SIGNAL_NUM_MAX];
    CmiSmsNumberRange               rangeList[CI_SMS_RANGE_LIST_MAX];
}CmiSmsNumberList;

typedef struct CmiSmsSetCscbSettingReq_Tag
{
    BOOL                            mode;
    UINT8                           rsv0;
    UINT16                          rsv1;
    CmiSmsNumberList                mids;
    CmiSmsNumberList                dcss;
}CmiSmsSetCscbSettingReq;

typedef CamCmiEmptySig CmiSmsGetCscbSettingReq;

typedef struct CmiSmsSetCscbSettingCnf_Tag
{
    CmiSmsErrorCode                 errorCode;
    UINT16                          reserved;
}CmiSmsSetCscbSettingCnf;

typedef struct CmiSmsGetCscbSettingCnf_Tag
{
    CmiSmsErrorCode                 errorCode;
    BOOL                            mode;
    CmiSmsNumberList                mids;
    CmiSmsNumberList                dcss;
}CmiSmsGetCscbSettingCnf;

/******************************************************************************
 * CMI_SMS_GET_SMS_MSG_RECORD_REQ
******************************************************************************/
typedef struct CmiSmsGetSmsMsgRecReq_Tag
{
    UINT8               index;      /* the specified index to read SIM */
    UINT8               operatmode; /* CmiSmsOperationMode */
    UINT16              reserved;
}CmiSmsGetSmsMsgRecReq;

/******************************************************************************
 * CMI_SMS_GET_SMS_MSG_RECORD_CNF
******************************************************************************/

typedef struct CmiSmsReadSmsRecRspInfo_Tag
{
    INT8                    index;          /* The index which was provided by SIM */
    UINT8                   smsStatus;      /* SMS record status. CmiSmsRecStorStatus */
    BOOL                    scAddrPresent;  /* SC Address info present or not */
    UINT8                   operatmode;     /* CmiSmsOperationMode */
    CmiSmsAddressInfo       scAddrInfo;     /* SC address info */
    CmiSmsPdu               smsPduData;     /* SMS PDU contents */
}CmiSmsReadSmsRecRspInfo;

typedef struct CmiSmsGetSmsMsgRecCnf_Tag
{
    CmiSmsErrorCode         errorCode;      /* Response result */
    UINT8                   operatmode;     /* CmiSmsOperationMode */
    UINT8                   smsStatus;      /* SMS record status. CmiSmsRecStorStatus */
    UINT8                   smsMsgType;     /* SMS message type, defined type CmiSmsMessageType */
    BOOL                    scAddrPresent;  /* SC Address info present or not */
    UINT16                  reserved;
    CmiSmsAddressInfo       scAddrInfo;     /* SC address info */
    CmiSmsPdu               smsPduData;     /* SMS PDU contents */
}CmiSmsGetSmsMsgRecCnf;

/******************************************************************************
 * CMI_SMS_SET_SMS_MSG_RECORD_REQ
******************************************************************************/
typedef struct CmiSmsSetSmsMsgRecReq_Tag
{
    UINT8                   operatmode;     /* CmiSmsOperationMode */
    UINT8                   smsStatus;      /* SMS record status. CmiSmsRecStorStatus */
    UINT16                  reserved;
    CmiSmsAddressInfo       scAddrInfo;     /* SC address info */
    CmiSmsPdu               smsPduData;     /* SMS PDU contents */

}CmiSmsSetSmsMsgRecReq;

/******************************************************************************
 * CMI_SMS_SET_SMS_MSG_RECORD_CNF
******************************************************************************/
typedef struct CmiSmsSetSmsMsgRecCnf_Tag
{
    CmiSmsErrorCode         errorCode;      /* response result */
    UINT8                   index;          /* the index which was provided by SIM */
    UINT8                   operatmode;     /* CmiSmsOperationMode */

}CmiSmsSetSmsMsgRecCnf;

/******************************************************************************
 * CMI_SMS_DEL_SMS_MSG_RECORD_REQ
******************************************************************************/

/*for AT+CMGD, <delflag> see TS-27.005 3.5.4 */
typedef enum CmiSmsDelFlag_Tag
{
    CMI_SMS_DEL_FLAG_INDEX    = 0,  /* delete the message specified in index*/
    CMI_SMS_DEL_FLAG_STATUS_1 = 1,  /* delete all Read message from the message storage */
    CMI_SMS_DEL_FLAG_STATUS_2 = 2,  /* delete all Read message and sent mobile originated message */
    CMI_SMS_DEL_FLAG_STATUS_3 = 3,  /* delete all read message, sent MO message and unsent mobile originated message */
    CMI_SMS_DEL_FLAG_ALL      = 4,  /* delete all message */

    CMI_SMS_DEL_FLAG_UNKNOWN
}CmiSmsDelFlag;

/******************************************************************************
 * CMI_SMS_DEL_SMS_MSG_RECORD_REQ
******************************************************************************/

typedef struct CmiSmsDelSmsMsgRecReq_Tag
{
    UINT8                   index;    /* the specified index to delete SIM */
    UINT8                   delFlag;  /* CmiSmsDelFlag */
    UINT16                  reserved;
}CmiSmsDelSmsMsgRecReq;

/******************************************************************************
 * CMI_SMS_DEL_SMS_MSG_RECORD_CNF
******************************************************************************/

typedef struct CmiSmsDelSmsMsgRecCnf_Tag
{
    CmiSmsErrorCode          errorCode;
    UINT16                   reserved;
}CmiSmsDelSmsMsgRecCnf;

/******************************************************************************
 * CMI_SMS_LIST_SMS_MSG_RECORD_REQ
******************************************************************************/
typedef struct CmiSmsListSmsMsgRecReq_Tag
{
    UINT8                   listStuts;    /* CmiSmsRecStorStatus the specified status which need to list */
    UINT8                   reserved0;
    UINT16                  reserved1;
}CmiSmsListSmsMsgRecReq;

/******************************************************************************
 * CMI_SMS_LIST_SMS_MSG_RECORD_CNF
******************************************************************************/
typedef struct CmiSmsListSmsMsgRecCnf_Tag
{
    CmiSmsErrorCode         errorCode;
    UINT8                   endStatus;          /* where or not is the last item */
    BOOL                    scAddrPresent;      /* SC Address info present or not */

    UINT8                   index;              /* the index of the SMS reocord in SIM */
    UINT8                   smsStatus;          /* SMS record status. CmiSmsRecStorStatus */
    UINT8                   smsMsgType;         /* SMS message type, defined type CmiSmsMessageType */
    UINT8                   reserved0;

    CmiSmsAddressInfo       scAddrInfo;         /* SC address info */
    CmiSmsPdu               smsPduData;         /* SMS PDU contents */

}CmiSmsListSmsMsgRecCnf;

/******************************************************************************
 * CMI_SMS_GET_SMS_STORAGE_STATUS_REQ
******************************************************************************/
typedef struct CmiSmsGetStorageStatusReq_Tag
{
    UINT8                   operatmode;  /* CmiSmsOperationMode */
    UINT8                   reserved0;
    UINT16                  reserved1;
}CmiSmsGetStorageStatusReq;

#define CI_SMS_RECORD_MAX_NUMBER       254        /* The total number of the saved SMS message in SIM */

/******************************************************************************
 * CMI_SMS_GET_SMS_STORAGE_STATUS_CNF
******************************************************************************/
typedef struct CmiSmsGetStorageStatusCnf_Tag
{
    UINT8                   operatmode;  /* CmiSmsOperationMode */
    UINT8                   usedNumOfSim;
    UINT8                   totalNumOfSim;
    UINT8                   reserved;
    UINT8                   usedIndexOfSim[CI_SMS_RECORD_MAX_NUMBER];
}CmiSmsGetStorageStatusCnf;


typedef CamCmiEmptySig CmiSmsSendSMMARequest;

/******************************************************************************
 * CMI_SMS_MEM_CAP_IND
******************************************************************************/
typedef struct CmiSmsMemCapInd_Tag
{
    BOOL                    smsMemCapExceed;
    UINT8                   reserved0;
    UINT16                  reserved1;
}CmiSmsMemCapInd;

/******************************************************************************
 * CMI_SMS_SET_MEM_CAP_REQ, CMI_SMS_SET_MEM_CAP_CNF
******************************************************************************/
typedef struct CmiSmsSetMemCapReq_Tag
{
    BOOL                    isMemCapExceed;
    UINT8                   reserved0;
    UINT16                  reserved1;
}CmiSmsSetMemCapReq, CmiSmsSetMemCapCnf;

/******************************************************************************
 * CMI_SMS_IDLE_STATUS_IND
******************************************************************************/
typedef CamCmiEmptySig CmiSmsIdleStatusInd;

#endif



