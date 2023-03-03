#ifndef __CMI_COMM_H__
#define __CMI_COMM_H__
/******************************************************************************
Copyright:      - 2017, All rights reserved by AirM2M Ltd.
File name:      - cmicomm.h
Description:    - CMI (CIoT modem interface) common interface defination
History:        - 08/09/2020, Originated by Jason
******************************************************************************/
#ifdef WIN32
#include "pssys.h"
#else
#include "osasys.h"
#endif


/*
 * Same defination in: cms_def.h
*/
#define PS_BROADCAST_IND_HANDLER        0x0001

/*
 * used in CAM, this reserved for CAM SYNC API
 * Same defination in: cms_def.h: CAM_CMI_SYNC_REQ_START_HANDLER
*/
#define CMI_SYNC_REQ_NUM                16
#define CMI_SYNC_REQ_START_HANDLER      0x0030
#define CMI_SYNC_REQ_END_HANDLER        (CMI_SYNC_REQ_START_HANDLER + CMI_SYNC_REQ_NUM - 1)



/******************************************************************************
 ******************************************************************************
 * STRUCT definition
 ******************************************************************************
******************************************************************************/

/******************************************************************************
 * MT error result code
 * refer: 27.007 9.2
******************************************************************************/
typedef enum MtErrorResultCode_TAG
{
    CME_SUCC = 0,
    /*
     * 0 - 100 are reserved for general errors
    */
    //CME_PHONE_FAILURE = 0, error 0 should not support for easy process
    CME_MT_NO_CONNECTION = 1,
    CME_MT_LINK_RESERVED,
    CME_OPERATION_NOT_ALLOW,
    CME_OPERATION_NOT_SUPPORT,
    CME_PH_SIM_PIN_REQ,
    CME_PH_FSIM_PIN_REQ,
    CME_PH_FSIM_PUK_REQ,

    CME_SIM_NOT_INSERT = 10,
    CME_SIM_PIN_REQ,
    CME_SIM_PUK_REQ,
    CME_SIM_FAILURE,
    CME_SIM_BUSY,
    CME_SIM_WRONG,
    CME_INCORRECT_PASSWORD,
    CME_SIM_PIN2_REQ,
    CME_SIM_PUK2_REQ,
    CME_MEMORY_FULL = 20,   /*accroding to 27.007 9.2.1*/
    CME_INVALID_INDEX,
    CME_NOT_FOUND,
    CME_MEMORY_FAILURE,
    CME_TEXT_STR_TOO_LONG,
    CME_INVALID_CHAR_IN_TXT_STR,
    CME_DIAL_STR_TOO_LONG,
    CME_INVALID_CHAR_IN_DIAL_STR = 27,
    CME_NO_NW_SERVICE = 30,
    CME_NW_TIMEOUT,
    CME_NW_NOT_ALLOWED_EC_ONLY,     /*network not allowed - emergency calls only*/
    CME_NW_PERSONAL_PIN_REQ = 40,   /*40 network personalization PIN required */
    CME_NW_PERSONAL_PUK_REQ,        /*41 network personalization PUK required*/
    CME_NW_SUBSET_PERSONAL_PIN_REQ, /*42 network subset personalization PIN required*/
    CME_NW_SUBSET_PERSONAL_PUK_REQ, /*43 network subset personalization PUK required*/
    CME_SRV_PROVIDER_PERSONAL_PIN_REQ,  /*44 service provider personalization PIN required*/
    CME_SRV_PROVIDER_PERSONAL_PUK_REQ,  /*45 service provider personalization PUK required*/
    CME_CORPORATE_PERSONAL_PIN_REQ,     /*46 corporate personalization PIN required*/
    CME_CORPORATE_PERSONAL_PUK_REQ,     /*47 corporate personalization PUK required*/
    CME_HIDDEN_KEY_REQ,                 /*48 hidden key required (See NOTE 2)*/
    CME_EAP_METHOD_NOT_SUPPORT,         /*49 EAP method not supported*/
    CME_INCORRECT_PARAM = 50,           /*50 Incorrect parameters*/
    CME_CMD_IMPLEMENTED_BUT_CUR_DISABLED,   /*51 command implemented but currently disabled*/
    CME_CMD_ABORT_BY_USER,              /*52 command aborted by user*/
    CME_NOT_ATTACHED_DUE_TO_RESTRICT,   /*53 not attached to network due to MT functionality restrictions*/
    CME_MODEM_NOT_ALLOWED_EC_ONLY,      /*54 modem not allowed - MT restricted to emergency calls only*/
    CME_OPER_NOT_ALLOWED_DUE_TO_RESTRICT,   /*55 operation not allowed because of MT functionality restrictions*/
    CME_FIXED_DIAL_NUM_ONLY,        /*56 fixed dial number only allowed - called number is not a fixed dial number (refer 3GPP TS 22.101 [147])*/
    CME_TEMP_OOS_DUE_TO_OTHER_USAGE,    /*57 temporarily out of service due to other MT usage*/
    CME_LANG_NOT_SUPPORT,           /*58 language/alphabet not supported*/
    CME_UNEXPECTED_DATA_VALUE,      /*59 unexpected data value*/
    CME_SYS_FAIL = 60,              /*60 system failure*/
    CME_DATA_MISSING,               /*61 data missing*/
    CME_CALL_BARRED,                /*62 call barred*/
    CME_MSG_WAIT_IND_SUB_FAIL,      /*63 message waiting indication subscription failure*/

    /* ... */
    CME_UNKNOWN = 100,
    /*
     * 101 - 150 are reserved for use by GPRS and EPS
    */
    CME_ILLEGAL_MS = 103,//#3
    CME_ILLEGAL_ME = 106,//#6
    CME_GPRS_SERVICES_NOT_ALLOWED = 107,//#7
    CME_GPRS_SERVICES_AND_NON_GPRS_SERVICES_NOT_ALLOWED = 108,//#8
    CME_PLMN_NOT_ALLOWED = 111,//#11
    CME_LOCATION_AREA_NOT_ALLOWED,//#12
    CME_ROAMING_NOT_ALLOWED_IN_THIS_LOCATION_AREA,//#13
    CME_GPRS_SERVICES_NOT_ALLOWED_IN_THIS_PLMN,//#14
    CME_NO_SUITABLE_CELLS_IN_LOCATION_AREA,//#15
    CME_PTI_MISMATCH = 121,                     /*121 PTI mismatch (#47)*/
    CME_CONGESTION = 122,//#22
    CME_INSUFFICIENT_RESOURCES = 126,           /*126 Insufficient resources (#26)*/
    CME_MISSING_OR_UNKNOWN_APN,                 /*127 Missing or unknown APN (#27)*/
    CME_UNKNOWN_PDP_ADDRESS_OR_PDP_TYPE,        /*128 Unknown PDN type (#28)*/
    CME_USER_AUTHENTICATION_FAILED,             /*129 User authentication or authorization failed (#29)*/
    CME_ACTIVATE_REJECT_BY_GGSN_SERVING_GW_OR_PDN_GW,   /*130 Activation rejected by Serving GW or PDN GW (#30)*/
    CME_ACTIVATE_REJECT_UNSPECIFIED,            /*131 Request rejected, unspecified (#31)*/
    CME_SERVICE_OPTION_NOT_SUPPORTED,           /*132 Service option not supported (#32)*/
    CME_REQUESTED_SERVICE_OPTION_NOT_SUBSCRIBED,    /*133 Requested service option not subscribed (#33)*/
    CME_SERVICE_OPTION_TEMPORATILY_OUT_OF_ORDER,    /*134 Service option temporarily out of order (#34)*/
    CME_PTI_ALREADY_IN_USE = 135,               /*135 PTI already in use (#35)*/
    CME_REGULAR_DEACTIVATION,                   /*136 Regular deactivation (#36) NOTE 2*/
    CME_EPS_QOS_NOT_ACCEPT,                     /*137 EPS QoS not accepted (#37) NOTE 2*/
    CME_FEATURE_NOT_SUPPORTED = 140,            /*140 Feature not supported (#40) -for UMTS */
    CME_SEMANTIC_ERRORS_IN_THE_TFT_OPERATION,   /*141 Semantic error in the TFT operation (#41)*/
    CME_SYNTACTICAL_ERRORS_IN_THE_TFT_OPERATION,/*142 Syntactical error in the TFT operation (#42)*/
    CME_INVALID_EPS_ID,                         /*143 Invalid EPS bearer identity (#43)*/
    CME_SEMANTIC_ERRORS_IN_PACKET_FILTERS,      /*144 Semantic errors in packet filter(s) (#44)*/
    CME_SYNTACTICAL_ERRORS_IN_PACKET_FILTERS,   /*145 Syntactical errors in packet filter(s) (#45)*/
    CME_PDP_CONTEXT_WITHOUT_TFT_ALREADY_ACTIVATED,  /*146 PDP context without TFT already activated (#46), -for UMTS*/
    CME_UNSPECIFIED_GPRS_ERROR = 148,           /*148 Unspecified GPRS error, -for UMTS*/
    CME_PDP_AUTHENTICATION_FAILURE = 149,       /*149 PDP authentication failure*/
    CME_INVALID_MOBILE_CLASS = 150,             /*150 Invalid mobile class*/


    /*
     * 151 - 170 are reserved for use by VBS/VGCS and eMLPP
    */

    /*
     * 171 - 256 are reserved for use by GPRS or EPS
    */
    CME_LAST_PDN_DISCONNECTION_NOT_ALLOWED = 171,   /*171 Last PDN disconnection not allowed (#49)*/
    CME_SEMANTICALLY_INCORECT_MESSAGE,              /*172 Semantically incorrect message (#95)*/
    CME_MANDATORY_INFORMATION_ELEMENT_ERROR,        /*173 Invalid mandatory information (#96) NOTE 2*/
    CME_INFORMATION_ELEMENT_NON_EXISTENT_OR_NOT_IMPLEMENTED,    /*174 Message type non-existent or not implemented (#97) NOTE 2*/
    CME_CONDITIONAL_IE_ERROR,                       /*175 Conditional IE error (#100) NOTE 2*/
    CME_PROTOCOL_ERROR_UNSPECIFIED,                 /*176 Protocol error, unspecified (#111) NOTE 2*/
    CME_OPERATOR_DETERMINED_BARRING,                /*177 Operator determined barring (#8)*/
    CME_MAX_NUMBER_OF_PDP_CONTEXTS_REACHED,         /*178 Maximum number of EPS bearers reached (#65)*/
    CME_REQUESTED_APN_NOT_SUPPORTED_IN_CURRENT_RAT_AND_PLMN_COMBINATION,    /*179 Requested APN not supported in current RAT and PLMN combination (#66)*/
    CME_REQUEST_REJECTED_BEARER_CONTROL_MODE_VIOLATION,     /*180 Request rejected, bearer control mode violation (#48) (UMTS)*/
    CME_UNSUPPORTED_QCI_VALUE = 181,                /*181 unsupported QCI value (#59)*/
    CME_USER_DATA_TRANSMISSION_VIA_CONTROL_PLANE_IS_CONGESTED,  /*182 User data transmission via control plane is congested*/

    CME_INVALID_PTI_VALUE = 184,                    /*184 Invalid PTI value (#81)*/
    CME_MSG_NOT_COMPATIBLE_WITH_PROTOCOL_STATE = 186,   /*186 Message not compatible with protocol state (#101) NOTE 2*/
    CME_NETWORK_FAILURE = 190,                      /*190 Network failure (#38) NOTE 2*/
    CME_REACTIVATION_REQUESTED,                     /*191 Reactivation requested (#39) NOTE 2*/
    CME_PDN_IPV4_ONLY_ALLOWED,                      /*192 PDN type IPv4 only allowed (#50) NOTE 2*/
    CME_PDN_IPV6_ONLY_ALLOWED,                      /*193 PDN type IPv6 only allowed (#51) NOTE 2*/
    CME_SINGLE_ADDRESS_BEARERS_ONLY_ALLOWED,        /*194 Single address bearers only allowed (#52) NOTE 2*/
    CME_COLLISION_WITH_NETWORK_INITIATED_REQUEST,   /*195 Collision with network initiated request (#56) NOTE 2*/
    CME_PDN_IPV4V6_ONLY_ALLOWED,                    /*196 PDN type IPv4v6 only allowed (#57) NOTE 2*/
    CME_PDN_NON_IP_ONLY_ALLOWED,                    /*197 PDN type non IP only allowed (#58) NOTE 2*/
    CME_BEARER_HANDLING_NOT_SUPPORTED,              /*198 Bearer handling not supported (#60) NOTE 2*/
    CME_APN_RESTRICTION_VALUE_INCOMPATIBLE_WITH_ACTIVATE_PDP_CTX,   /*199 APN restriction value incompatible with active PDP context (#112) NOTE 2*/
    CME_MULTIPLE_ACCESS_TO_A_PDN_NOW_ALLOWED = 200,     /*200 Multiple accesses to a PDN connection not allowed (#113) NOTE 2*/
    CME_ESM_INFORMATION_NOT_RECEIVED,               /*201 ESM information not received (#53) NOTE 2*/
    CME_PDN_CONNECTION_NOT_EXIST,                   /*202 PDN connection does not exist (#54) NOTE 2*/
    CME_MULTIPLE_PDN_CONNECTION_FOR_A_GIVEN_APN_NOT_ALLOWED,    /*203 Multiple PDN connections for a given APN not allowed (#55) NOTE 2*/
    CME_MSG_TYPE_NOT_COMPATIBLE_WITH_PROTOCOL_STATE,    /*208 Message type not compatible with protocol state (#98) NOTE 2*/
    CME_INFO_ELEMENT_NOT_EXIST_OR_NOT_IMPLEMENTED = 209,    /*209 Information element non-existent or not implemented (#99) NOTE 2*/

    /*
     * 257 - 300 are reserved for general errors
    */

    /*
     * 301 - 0xFFFF are reserved for internal
    */
    CME_INTERNAL_ERROR_BASE = 301,
    CME_UE_BUSY,
    //CME_OPERATION_NOT_SUPPORT,
    //CME_INVALID_INPUT_PARM,
    CME_NOT_POWER_ON,
    CME_PDN_NOT_ACTIVED,
    CME_PDN_NOT_VALID,
    CME_PDN_INVALID_TYPE,   /* request default/dedicated bearer, but bearer is dedicated/default */
    CME_PDN_NO_PARAM,

    CME_UE_FAIL,
    CME_PDP_APN_AND_PDN_TYPE_DUPLICATE_USED,//#309
    CME_PDP_PAP_AND_EITF_NOT_MATCHED,

    CME_SIM_PIN_DISABLED,
    CME_SIM_PIN_ALREADY_ENABLED,
    //CME_SIM_PIN_BLOCKED,
    CME_SIM_PIN_WRONG_FORMAT,

    CME_PS_INTERNAL_ERROR_MAX1 = 400,

    /*
     * 401 - 500 are reserved for socket error.
     *  Defined in: cms_sock_mgr.h
    */

    /*
     * 500 - 600 is reserved for REF error
    */
    CME_REF_START_ERROR = 501,
    CME_REQ_PARAM_NOT_CFG = 512,        //512 Required parameter not configured
    CME_TUP_NOT_REGISTERED = 513,       //513 TUP not registered
    CME_AT_INTERNAL_ERROR,              //514 AT internal error
    CME_CID_IS_ACT,                     //515 CID is active
    CME_INCORRECT_STATE_FOR_CMD,        //516 Incorrect state for command
    CME_CID_INVALID,                    //517 CID is invalid
    CME_CID_NOT_ACT,                    //518 CID is not active
    CME_DEACT_LAST_ACT_CID = 520,       //520 Deactivate the last active CID
    CME_CID_NOT_DEFINED,                //521 CID is not defined
    CME_UART_PARITY_ERROR,              //522 UART parity error
    CME_UART_FRAME_ERROR,               //523 UART frame error
    CME_IN_CFUN0_STATE,                 //524 UE is in minimal function mode
    CME_CMD_ABORT_ONGOING,              //525 AT command aborted: in processing
    CME_CMD_ABORT_ERROR,                //526 AT command aborted: error
    CME_CMD_INTERRUPT,                  //527 Command interrupted
    CME_CFG_CONFLICT,                   //528 Configuration conflicts
    CME_DURING_FOTA_UPDATING,           //529 During FOTA updating
    CME_NOT_AT_ALLOC_SOCKET = 530,      //530 Not the AT allocated socket
    CME_USIM_PIN_BLOCKED,               //531 USIM PIN is blocked
    CME_SIM_PIN_BLOCKED = CME_USIM_PIN_BLOCKED,
    CME_USIM_PUK_BLOCKED,               //532 USIM PUK is blocked
    CME_NOT_MIPI_MODE,                  //533 Not mipi module
    CME_FILE_NOT_FOUND,                 //534 File not found
    CME_CONDITION_NOT_SATISFIED,        //535 conditions of use not satisfied
    CME_AT_UART_BUF_ERROR,              //536 AT UART buffer error
    CME_BACK_OFF_TIME_RUNNING,          //537 Back off timer is running
    //...
    CME_REF_END_ERROR = 600,




    CME_MAX_ERROR = 0xFFFF
}MtErrorResultCode;

typedef UINT16 CmiRcCode;       //MtErrorResultCode/SmsErrorResultCode

/******************************************************************************
 * SMS error result code
 * refer: 27.005 3.2.5
******************************************************************************/
typedef enum SmsErrorResultCode_TAG
{
    CMS_SMS_SUCC = 0,

    /*
     * 300 - 500 are reserved for SMS errors
    */
    CMS_SMS_ME_FAILURE = 300,
    CMS_SMS_SERVICE_OF_ME_RESV,
    CMS_SMS_OPERATION_NOT_ALLOWED,
    CMS_SMS_OPERATION_NOT_SUPPORTED,
    CMS_SMS_INVALID_PDU_MODE_PARAMETER,
    CMS_SMS_INVALID_TEXT_MODE_PARAMETER,
    CMS_SMS_USIM_NOT_INSERTED = 310,
    CMS_SMS_USIM_PIN_REQUIRED,
    CMS_SMS_PHSIM_PIN_REQUIRED,
    CMS_SMS_USIM_FAILURE,
    CMS_SMS_USIM_BUSY,
    CMS_SMS_USIM_WRONG,
    CMS_SMS_USIM_PUK_REQUIRED,
    CMS_SMS_USIM_PIN2_REQUIRED,
    CMS_SMS_USIM_PUK2_REQUIRED,
    CMS_SMS_MEMORY_FAILURE = 320,
    CMS_SMS_INVALID_MEM_INDEX,
    CMS_SMS_MEM_FULL,
    CMS_SMS_SMSC_ADDR_UNKNOWN = 330,
    CMS_SMS_NO_NETWORK_SERVICE,
    CMS_SMS_NETWORK_TIMEOUT,
    CMS_SMS_NO_CNMA_ACK_EXPECTED = 340,

    CMS_SMS_UNKNOWN_ERROR = 500,
    CMS_SMS_INVALID_DATA  = 550,

    CMS_MAX_ERROR = 0xFFFF
}SmsErrorResultCode;

typedef UINT16 CmiSmsErrorCode;

/******************************************************************************
 * CAM service group enum definition
******************************************************************************/
typedef enum CamSgIdEnum_Tag
{
    CAM_BASE = 1,//basic/common
    CAM_DEV = 2,
    CAM_MM = 3,
    CAM_PS = 4,
    CAM_SIM = 5,
    CAM_SMS = 6,

    CAM_MAX = 15
}CamSgIdEnum;

/*
 * CMI SIGNAL ID, between AtCmdSrv Task & CAM/CCM Task
*/
typedef enum _SIG_EPAT_CAMCMISIGID_enum
{
    SIG_CAM_CMI_BASE = 0x11F0,
    SIG_CAM_CMI_REQ,
    SIG_CAM_CMI_CNF,
    SIG_CAM_CMI_IND,
    SIG_CAM_CMI_RSP,
    SIG_CAM_CMI_SYNC_REQ,   /* CamCmiSyncReq */
    SIG_CAM_CMI_END = 0x11FF,
}CAMCMISIGID;

/*
 * Numberic PLMN format, 4 bytes,
 * example: CMCC: 46000; mcc = 0x0460, mnc = 0xf000
*/
typedef struct CmiNumericPlmn_Tag
{
    UINT16 mcc;
    UINT16 mncWithAddInfo; // if 2-digit MNC type, the 4 MSB bits should set to 'F',
}CmiNumericPlmn;

#define CAM_GET_PURE_MNC(mncWithAddInfo) ((mncWithAddInfo)&0xFFF)
#define CAM_IS_2_DIGIT_MNC(mncWithAddInfo) (((mncWithAddInfo)>>12) == 0x0F)

#define CAM_SET_MNC_WITH_ADD_INFO(twoDigitType, pureMnc) ((twoDigitType)?((pureMnc)|0xF000):((pureMnc)&0xFFF))


/*
 * IP address info
*/
#define CMI_IPV4_ADDR_LEN           4

#if 0
typedef struct CmiIpv4Addr_Tag
{
    UINT8   addr[CMI_IPV4_ADDR_LEN];
}CmiIpv4Addr;
#endif
#define CMI_IPV6_ADDR_LEN           16

#if 0
typedef struct CmiIpv6Addr_Tag
{
    UINT8   addr[CMI_IPV6_ADDR_LEN];
}CmiIpv6Addr;
#endif

#define CMI_IPV6_INTERFACE_LEN      8

/*
 * IP address info
*/
#define CMI_MAX_IP_ADDR_LEN         16

/*
 * Address IP type
*/
typedef enum CmiIpAddrTypeTag
{
    CMI_INVALID_IP_ADDR = 0,
    CMI_IPV4_ADDR,          //4 bytes length
    CMI_IPV6_INTERFACE_ADDR,//8 bytes length
    CMI_FULL_IPV6_ADDR      //16 bytes length
}CmiIpAddrType;

typedef struct CmiIpAddrTag
{
    UINT8   addrType;       //CmiIpAddrType
    UINT8   subnetMaskLen;  //if not set, set to 0
    UINT16  reserved0;

    union {
        UINT8   ipv4[CMI_IPV4_ADDR_LEN];
        UINT8   ipv6If[CMI_IPV6_INTERFACE_LEN];
        UINT8   ipv6[CMI_IPV6_ADDR_LEN];
        UINT8   addr[CMI_MAX_IP_ADDR_LEN];
    }ip;
}CmiIpAddr;    //20 bytes


#define CMI_SIM_MAX_IMSI_STRING_LENGTH        16
/*
 * IMSI string structure, 20 bytes
*/
typedef struct CmiSimImsiStrTag
{
    UINT8       length;
    BOOL        bThreeDigitalMnc;
    UINT16      reserved0;
    /*example: IMSI: "460002343454245" */
    CHAR        contents[CMI_SIM_MAX_IMSI_STRING_LENGTH];
}CmiSimImsiStr;


/******************************************************************************
 * CamCmiReq - SIG_CAM_CMI_REQ
 * CMI interface request, all other module (AT CMD server) use this signal to
 *  access the CIOT modem
 * Int16 reqId; 4 MSB bits SG ID | 12 bits PRIM ID;
 * Int16 srcHandler; ID use to identify which module send this request
 * Int8 body[0]; request PRIM entity
******************************************************************************/
typedef struct CamCmiReqTag
{
    struct {
        UINT16 reqId;
        UINT16 srcHandler;
    }header;

    UINT8 body[];
}CamCmiReq;

#define CAM_GET_SG_ID(reqId) (((reqId)>>12)&0x000f)
#define CAM_GET_PRIM_ID(reqId) ((reqId)&0x0fff)
#define CAM_SET_REQ_CNF_ID(sgId, primId) ((UINT16)(((sgId)<<12)|((primId)&0x0fff)))

/******************************************************************************
 * CamCmiCnf - SIG_CAM_CMI_CNF
******************************************************************************/
typedef struct CamCmiCnfTag
{
    struct {
        UINT16      cnfId;      //4 MSB bits SG ID | 12 bits PRIM ID
        UINT16      srcHandler; //Handler from CamCmiReq
        UINT16      rc;
        UINT16      reserved;
    }header;

    UINT8 body[];
}CamCmiCnf;

#define CAM_GET_CMICNF_FROM_BODY(pCmiBody) (CamCmiCnf *)(((UINT8 *)(pCmiBody)) - (UINT32)(OFFSETOF(CamCmiCnf, body)))

/******************************************************************************
 * CamCmiInd - SIG_CAM_CMI_IND
******************************************************************************/
typedef struct CamCmiIndTag
{
    struct {
        UINT16      indId;      //4 MSB bits SG ID | 12 bits PRIM ID
        /*
         * As some indication is triggered by some AT request, in such as need to fill this "reqHandler",
         *  otherwise set to "PS_BROADCAST_IND_HANDLER".
        */
        UINT16      reqHandler;
    }header;

    UINT8 body[];
}CamCmiInd;


/******************************************************************************
 * CamCmiRsp - SIG_CAM_CMI_RSP
******************************************************************************/
typedef struct CamCmiRspTag
{
    struct {
        UINT16      rspId;      //4 MSB bits SG ID | 12 bits PRIM ID
        UINT16      rspHandler;
    }header;

    UINT8 body[];
}CamCmiRsp;


#define CAM_GET_CMIIND_FROM_BODY(pCmiBody) (CamCmiInd *)(((UINT8 *)(pCmiBody)) - (UINT32)(OFFSETOF(CamCmiInd, body)))


/******************************************************************************
 * CamCmiReq - SIG_CAM_CMI_SYNC_REQ
 * CMI interface request, all other module (AT CMD server) use this signal to
 *  access the CIOT modem, and syn confirm
******************************************************************************/
typedef struct CamCmiSyncReqTag
{
    osSemaphoreId_t     sem;

    /* output info */
    UINT32              *pCmiRc;            /* MtErrorResultCode/SmsErrorResultCode */
    UINT16              cnfBufSize;
    UINT16              rsvd0;
    void                *pOutCmiCnf;        /* CMI confirm struct, CMI CNF, copy to here */

    /* input info */
    CamCmiReq           cmiReq;
}CamCmiSyncReq;


/******************************************************************************
 * If no parameters carried in signal, just pass a reserved Int32
******************************************************************************/
typedef UINT32 CamCmiEmptySig;
//typedef UINT8 CamCmiEmptySig[]; // sizeof it == 0


/******************************************************************************
 ******************************************************************************
 * API definition
 ******************************************************************************
******************************************************************************/
/*
 * SIG_CAM_CMI_REQ to CAM task
*/
//void CamCmiRequest(UINT16 srcHdr, UINT8 sgId, UINT16 primId, UINT16 primSize, void *primBody);

/******************************************************************************
 * CamCmiSynReq
 * Description: Send "SIG_CAM_CMI_SYNC_REQ" to CAM task
 * input: UINT16 srcHdr;
 *        UINT8 sgId;   // CamSgIdEnum
 *        UINT16 primId;// prim ID
 *        UINT16 primSize; //prim body size
 *        void *primBody;  //prim body
 * output: UINT32   //MtErrorResultCode/SmsErrorResultCode
 * Comment:
******************************************************************************/
UINT32 CamCmiSynReq(UINT8 sgId, UINT16 primId, UINT16 primSize, const void *primBody, UINT16 outCnfSize, void *pOutCnfBody);


/******************************************************************************
 * CamMmGetCurCELevel
 * Description: return current UE (NB/EMTC) Coverage Enhancement level
 * input: UINT8 *pAct;  //output, current ACT: NB/EMTC
 *        UINT8 *pCeLevel;  //output, current CE level
 * output: void
 * Comment:
 * Return:
 * *pAct:
 *  0 CMI_MM_CES_NO_CE_ACT //UE not attached;
 *  1 CMI_MM_CES_EUTRAN_EMTC
 *  2 CMI_MM_CES_EC_GSM //not support
 *  3 CMI_MM_CES_EUTRAN_NB
 * *pCeLevel:
 *  0 No Coverage Enhancement in the serving cell
 *  1 Coverage Enhancement level 0
 *  2 Coverage Enhancement level 1
 *  3 Coverage Enhancement level 2
 *  4 Coverage Enhancement level 3   // for EMTC
******************************************************************************/
void CamMmGetCurCELevel(UINT8 *pAct, UINT8 *pCeLevel);

#endif

