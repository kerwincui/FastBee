#ifndef __PS_COMM_TYPE_H__
#define __PS_COMM_TYPE_H__

/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017, All rights reserved by AirM2M Ltd.
 File name:      - pscommtype.h
 Description:    - PS common typedef structure
 History:        - 10/19/2018, Originated by Jason
 ******************************************************************************
******************************************************************************/
#include "pssys.h"
#include "psl1commtype.h"



/******************************************************************************
 *****************************************************************************
 * MACRO
 *****************************************************************************
******************************************************************************/
#define SUPPORT_MAX_FREQ_NUM            8
#define MAX_PLMN_LIST_SIZE              6       //this value is max number of plmn Id in SIB1, maxPLMN-r11
#define CE_INVALID_MCC                  0xFFFF
#define SUPPORT_MAX_PLMN_NUM            20      //TBD
#define CEMM_PLMN_LIST_MAX_NUM          16
#define MAX_BAND_MASK_NUM               3       //the max number of UINT32 bandmask, i.e. the max supported band num is 32*MAX_BAND_MASK_NUM
#define MAX_NAS_MSG_BITMAP_NUM          8       // equal to 256/32

#define PS_INVALID_PHY_CELL_ID          0xFFFF
#define PS_MAX_PHY_CELL_ID              503

//SHA-256 MACROS
#define SHA256_HASH_WORDS               8       /* number of words in H(0) */
#define SHA256_OUTPUT_SIZE              32      /* Block size (in bytes) of the output of the Approved hash function. */
#define SHA256_BLOCK_SIZE               64      /* Block size (in bytes) of the input to the Approved hash function. */

#ifndef MAX
#define MAX(a,b)                        (((a) > (b)) ? (a) : (b))
#endif

#ifndef MIN
#define MIN(a,b)                        (((a) < (b)) ? (a) : (b))
#endif

#define NB_DRB_NUM                      2
#define CAT_DRB_NUM                     11

#define MAX_DRB_NUM                     CAT_DRB_NUM

/* PAP/CHAP ID and pwd max length */
#define CESM_MAX_AUTH_STR_LEN           64

/* CID is max to 15, and valid value: [0:15], in PS layer */
#define PS_MAX_PDP_CID                  15
#define PS_PDP_CID_NUM                  16      /* [0:15] */
#define PS_INVALID_PDP_CID              255
#define MAX_EPS_BEARER_CONTEXT_NUM      11
#define PS_APN_MAX_LEN                  100



/*
 * Part of MARCO used to parse IP header
*/
#define PS_IP_HDR_GET_VER(ptr)      ((*(UINT8*)(ptr)) >> 4)

#define PS_IP_PROTO_UDP         17
#define PS_IP_PROTO_TCP         6
#define PS_IP_PROTO_ESP         50

#define LITTLE_ENDIAN_BITFIELD

#if defined(LITTLE_ENDIAN_BITFIELD)
#define PS_HTONS(x)     ((((x) & 0x00ffUL) << 8) | (((x) & 0xff00UL) >> 8))
#define PS_HTONL(x)     ((((x) & 0x000000ffUL) << 24) | \
                        (((x) & 0x0000ff00UL) <<  8) | \
                        (((x) & 0x00ff0000UL) >>  8) | \
                        (((x) & 0xff000000UL) >> 24))
#else
#define PS_HTONS(x)  (x)
#define PS_HTONL(x)  (x)
#endif

#define PS_NTOHS(x)     PS_HTONS((x))
#define PS_NTOHL(x)     PS_HTONL((x))

/* Get ipv6 header value */
#define PS_IP6H_V(hdr)      ((PS_NTOHL((hdr)->ver_tc_fl) >> 28) & 0x0f)
#define PS_IP6H_TC(hdr)     ((PS_NTOHL((hdr)->ver_tc_fl) >> 20) & 0xff)
#define PS_IP6H_FL(hdr)     (PS_NTOHL((hdr)->ver_tc_fl) & 0x000fffff)




/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

typedef UINT16 AccessClass;
typedef UINT16 AccessTechnologyId;

#define PLMN_GET_PURE_MNC(mncWithAddInfo) ((mncWithAddInfo)&0xFFF)
#define PLMN_IS_2_DIGIT_MNC(mncWithAddInfo) (((mncWithAddInfo)>>12) == 0x0F)

#define PLMN_SET_MNC_WITH_ADD_INFO(twoDigitType, pureMnc) ((twoDigitType)?((pureMnc)|0xF000):((pureMnc)&0xFFF))

#define IS_VALID_PLMN(plmn) (((plmn).mcc != 0) ? TRUE : FALSE)

#define IS_SAME_PLMN(plmn1, plmn2)  (((plmn1).mcc == (plmn2).mcc) && ((plmn1).mncWithAddInfo == (plmn2).mncWithAddInfo))

typedef enum PlmnMncDigitType_enum
{
    PLMN_UNKNOW_DIGIT_MNC = 0,
    PLMN_2_DIGIT_MNC = 2,
    PLMN_3_DIGIT_MNC = 3
}PlmnMncDigitType;

/******************************************************************************
 * NwMode
 * NB_IOT, EMTC, etc...
******************************************************************************/
typedef enum _SIG_EPAT_CCM_CFG_NW_MODE
{
    NB_IOT = 0,
    CAT1,
    EMTC_IOT
}NwMode;

/******************************************************************************
 * UeService
 * EPS/NON_EPS/EPS AND NON_EPS
******************************************************************************/
typedef enum _SIG_EPAT_CCM_CFG_UE_SERVICE
{
    EPS_ONLY        = 0, // NB
    NON_EPS         = 1,
    EPS_AND_NON_EPS = 2,
    NON_SERVICE
}UeService;

typedef UINT8   UeServiceT;

/******************************************************************************
 * UeUsageSetting
 * VOICE_CENTRIC/DATA_CENTRIC
******************************************************************************/
typedef enum UeUsageSetting_Tag
{
    VOICE_CENTRIC = 0,
    DATA_CENTRIC
}UeUsageSetting;

typedef UINT8   UeUsageSettingT;

/******************************************************************************
 * VoiceDomainPreference
 * CS_VOICE_ONLY/IMS_PS_VOICE_ONLY
 * CS_VOICE_PREFERRED_IMS_PS_VOICE_SECONDARY
 * IMS_PS_VOICE_PREFERRED_CS_VOICE_SECONDARY
******************************************************************************/
typedef enum VoiceDomainPreference_Tag
{
    CS_VOICE_ONLY                             = 0,
    IMS_PS_VOICE_ONLY                         = 1,
    CS_VOICE_PREFERRED_IMS_PS_VOICE_SECONDARY = 2,
    IMS_PS_VOICE_PREFERRED_CS_VOICE_SECONDARY
}VoiceDomainPreference;

typedef UINT8   VoiceDomainPreferenceT;

/******************************************************************************
 * UE modes of operation for EPS
 * PS_MODE_2_OF_OPERATION
 * CSPS_MODE_1_OF_OPERATION
 * CSPS_MODE_2_OF_OPERATION
 * PS_MODE_1_OF_OPERATION
******************************************************************************/
typedef enum _SIG_EPAT_CCM_CFG_UE_OPERATION_MODE
{
    PS_MODE_2_OF_OPERATION   = 0,
    CSPS_MODE_1_OF_OPERATION = 1,
    CSPS_MODE_2_OF_OPERATION = 2,
    PS_MODE_1_OF_OPERATION   = 3
}PsUeOperationModeEnum;

typedef UINT8   UeOperationModeT;

/******************************************************************************
 * PlmnType
 * HPLMN/EHPLMN/RPLMN/EPLMN.....
******************************************************************************/
typedef enum _EPAT_PlmnTypeEnum_Tag
{
    HPLMN = 0, //home PLMN, derived from IMSI
    EHPLMN,    //equivalent home PLMN
    //RPLMN,     //registered PLMN, not the same level meaning
    //EPLMN,     //equivalent PLMN, not the same level meaning
    VPLMN,     //visited PLMN
    UPLMN,     //user controlled PLMN
    OPLMN,     //operator controlled PLMN
    FPLMN,     //forbidden PLMN
    APLMN,     //available PLMN
}PlmnType;

/******************************************************************************
 * CipheringAlgorithm
 * EEA0/EEA1/EEA2/EEA3
******************************************************************************/
typedef enum CipheringAlgorithmTag
{
    // see TS 34.401 5.1.3.2
    EEA0 = 0,
    EEA1 = 1,
    EEA2 = 2,
    EEA3 = 3,
}CipheringAlgorithm;

/******************************************************************************
 * IntegrityAlgorithm
 * EIA0/EIA1/EIA2/EIA3
******************************************************************************/
typedef enum _EPAT_IntegrityAlgorithmTag
{
    // see TS 34.401 5.1.4.2
    EIA0 = 0,
    EIA1 = 1,
    EIA2 = 2,
    EIA3 = 3
}IntegrityAlgorithm;

/*
 * 24.301: 9.9.4.25 Release assistance indication
 * 0 0  No information regarding DDX is conveyed by the information element. If
 *      received it shall be interpreted as 'neither value "01" nor "10" applies'
 * 0 1  No further uplink or downlink data transmission subsequent to the uplink data
 *      transmission is expected
 * 1 0  Only a single downlink data transmission and no further uplink data
 *      transmission subsequent to the uplink data transmission is expected
 * 1 1  reserved
*/
typedef enum DataRelAssistIndEnum_Tag
{
    DATA_RAI_NO_INFO           = 0,
    DATA_RAI_NO_UL_DL_FOLLOWED = 1,
    DATA_RAI_ONLY_DL_FOLLOWED  = 2,
    DATA_RAI_RESERVED          = 3
}DataRelAssistIndEnum;

/******************************************************************************
 * Tai
 * Tai = mcc + mnc + tac
******************************************************************************/
typedef struct Tai_Tag
{
    Plmn    plmn;
    UINT16  tac;
    UINT16  reserved;
}Tai;

/******************************************************************************
 * Lai
 * Lai = mcc + mnc + lac
******************************************************************************/
typedef struct LocationAreaIdTag
{
    Plmn    plmn;
    UINT16  lac;
    UINT16  reserved;
}
LocationAreaId;

/******************************************************************************
 * Kasme
******************************************************************************/
#define KASME_SIZE 32
typedef struct AsmeKey_Tag
{
    UINT8  data[KASME_SIZE];
}AsmeKey;

/******************************************************************************
 * NAS COUNT
******************************************************************************/
#define NAS_COUNT_SIZE 4
typedef struct NasCount_Tag
{
    UINT8  data[NAS_COUNT_SIZE];
}NasCount;

/******************************************************************************
 * IMSI
******************************************************************************/
#define MAX_IMSI_LENGTH     8
typedef struct Imsi_Tag
{
    UINT8               length;
    UINT8               mncType;    //PlmnMncDigitType
    AccessTechnologyId  accessTech;
    UINT8               contents[MAX_IMSI_LENGTH];
}Imsi;

/******************************************************************************
 * Additional Update Result
******************************************************************************/
typedef enum AdditionalUpdateResultTag
{
    NO_ADDITIONAL_INFORMATION = 0,
    CS_FALLBACK_NOT_PREFERRED = 1,
    SMS_ONLY                  = 2,
    RESERVED_VALUE            = 3
}
AdditionalUpdateResult;

/******************************************************************************
 * DCN ID
******************************************************************************/
typedef struct DedicatedCoreNetworkId_Tag
{
    Plmn    plmn;
    UINT16  dcnIdWithinPlmn;
}DedicatedCoreNetworkId;

typedef enum TimerUnitTag
{
    TIMER1_MULTIPLES_OF_TWO_SECONDS = 0,
    TIMER1_MULTIPLES_OF_ONE_MINUTE  = 1,
    TIMER1_MULTIPLES_OF_DECIHOURS   = 2,
    TIMER1_TIMER_DEACTIVATED        = 7
}
TimerUnit;

typedef UINT8       TimerUnitT;
typedef TimerUnit   Timer2Unit;
typedef UINT8       Timer2UnitT;


typedef enum Timer3UnitTag
{
    TIMER3_MULTIPLES_OF_TEN_MINUTES    = 0,
    TIMER3_MULTIPLES_OF_ONE_HOUR       = 1,
    TIMER3_MULTIPLES_OF_TEN_HOURS      = 2,
    TIMER3_MULTIPLES_OF_TWO_SECONDS    = 3,
    TIMER3_MULTIPLES_OF_THIRTY_SECONDS = 4,
    TIMER3_MULTIPLES_OF_ONE_MINUTE     = 5,
    TIMER3_MULTIPLES_OF_320_HOURS      = 6,
    TIMER3_TIMER_DEACTIVATED           = 7
}
Timer3Unit;

typedef UINT8       Timer3UnitT;

typedef struct GprsTimerTag
{
    UINT8           timerValue;
    TimerUnitT      unit;
}
GprsTimer;

typedef struct _EPAT_GprsTimer2Tag
{
    UINT8           timerValue;
    Timer2UnitT     unit;
}
GprsTimer2; // 2 bytes

typedef struct _EPAT_GprsTimer3Tag
{
    UINT8           timerValue;
    Timer3UnitT     unit;
}
GprsTimer3;

/* The field contains the PTW value in seconds for WB-S1 mode */
typedef enum PagingTimeWindowForWBModeTag
{
    PAGING_TIME_WINDOW_WB_1_SEC_280_MS  = 0,
    PAGING_TIME_WINDOW_WB_2_SEC_560_MS  = 1,
    PAGING_TIME_WINDOW_WB_3_SEC_840_MS  = 2,
    PAGING_TIME_WINDOW_WB_5_SEC_120_MS  = 3,
    PAGING_TIME_WINDOW_WB_6_SEC_400_MS  = 4,
    PAGING_TIME_WINDOW_WB_7_SEC_680_MS  = 5,
    PAGING_TIME_WINDOW_WB_8_SEC_960_MS  = 6,
    PAGING_TIME_WINDOW_WB_10_SEC_240_MS = 7,
    PAGING_TIME_WINDOW_WB_11_SEC_520_MS = 8,
    PAGING_TIME_WINDOW_WB_12_SEC_800_MS = 9,
    PAGING_TIME_WINDOW_WB_14_SEC_80_MS  = 10,
    PAGING_TIME_WINDOW_WB_15_SEC_360_MS = 11,
    PAGING_TIME_WINDOW_WB_16_SEC_640_MS = 12,
    PAGING_TIME_WINDOW_WB_17_SEC_920_MS = 13,
    PAGING_TIME_WINDOW_WB_19_SEC_200_MS = 14,
    PAGING_TIME_WINDOW_NB_20_SEC_480_MS = 15
}PagingTimeWindowForWBMode;

typedef UINT8   PagingTimeWindowForWBModeT;

/* The field contains the eDRX value for S1 mode */

/* -------------------------------------------------------------------------
    NOTE 4: The value is applicable only in WB-S1 mode. If received in NB-S1
    mode it is interpreted as if the Extended DRX parameters IE were not
    included in the message by this version of the protocol.

    NOTE 5: The value is applicable only in WB-S1 mode. If received in NB-S1
    mode it is interpreted as 0010 by this version of the protocol.

    NOTE 6: The value is applicable only in NB-S1 mode. If received in WB-S1
    mode it is interpreted as 1101 by this version of the protocol.
    --------------------------------------------------------------------------*/
typedef enum EdrxValueForS1ModeTag
{
    EDRX_CYCLE_LEN_5_SEC_120_MS     = 0,  /* Rfer to NOTE 4 */
    EDRX_CYCLE_LEN_10_SEC_240_MS    = 1,  /* Rfer to NOTE 4 */
    EDRX_CYCLE_LEN_20_SEC_480_MS    = 2,
    EDRX_CYCLE_LEN_40_SEC_960_MS    = 3,
    EDRX_CYCLE_LEN_61_SEC_440_MS    = 4,  /* Rfer to NOTE 5 */
    EDRX_CYCLE_LEN_81_SEC_920_MS    = 5,
    EDRX_CYCLE_LEN_102_SEC_400_MS   = 6,  /* Rfer to NOTE 5 */
    EDRX_CYCLE_LEN_122_SEC_880_MS   = 7,  /* Rfer to NOTE 5 */
    EDRX_CYCLE_LEN_143_SEC_360_MS   = 8,  /* Rfer to NOTE 5 */
    EDRX_CYCLE_LEN_163_SEC_840_MS   = 9,
    EDRX_CYCLE_LEN_327_SEC_680_MS   = 10,
    EDRX_CYCLE_LEN_655_SEC_360_MS   = 11,
    EDRX_CYCLE_LEN_1310_SEC_720_MS  = 12,
    EDRX_CYCLE_LEN_2621_SEC_440_MS  = 13,
    EDRX_CYCLE_LEN_5242_SEC_880_MS  = 14,  /* Rfer to NOTE 6 */
    EDRX_CYCLE_LEN_10485_SEC_760_MS = 15,  /* Rfer to NOTE 6 */
    EDRX_CYCLE_LEN_INVALID          = 0xFF /* Set to this value while AT+CEDRX=0(disable the use of eDRX and discard all parameters for eDRX) */
}EdrxValueForS1Mode;

typedef UINT8 EdrxValueForS1ModeT;

typedef struct _EPAT_ExtendedDrxParametersTag
{
    EdrxValueForS1ModeT         edrxValue;
    PagingTimeWindowForWBModeT  ptw;
}ExtendedDrxParameters; // 2 bytes

typedef enum CemmCiotOptTypeEnum_Tag
{
    CEMM_NO_CIOT_OPT   = 0, // not support CIOT OPT, for NB, CP OPT is must, useless, but for CAT1, this is set to default value
    CEMM_CP_CIOT_OPT   = 1,
    CEMM_UP_CIOT_OPT   = 2,
    CEMM_CP_AND_UP_OPT = 3
}CemmCiotOptTypeEnum;

typedef enum CemmPsmReqModeEnum_Tag
{
    CEMM_DISABLE_PSM = 0,
    CEMM_ENABLE_PSM  = 1,
    CEMM_DISCARD_PSM = 2 /* disable PSM, and discard PSM PARMs */
}CemmPsmReqModeEnum;

typedef enum CemmEdrxReqModeEnum_Tag
{
    CEMM_DISABLE_EDRX = 0,
    CEMM_ENABLE_EDRX  = 1,
    CEMM_DISCARD_EDRX = 2 /* disable EDRX, and discard EDRX PARMs */
}CemmEdrxReqModeEnum;

/******************************************************************************
 * EPS update status
******************************************************************************/
typedef enum EpsUpdateStatus_Tag
{
    USIM_EUS_UPDATED             = 0,
    USIM_EUS_NOT_UPDATED         = 1,
    USIM_EUS_ROAMING_NOT_ALLOWED = 2,
    USIM_EUS_RESERVED            = 7
}EpsUpdateStatus;

/******************************************************************************
 * NAS key set identifier
******************************************************************************/
typedef enum NasKsiTag
{
    NAS_KSI_0           = 0,
    NAS_KSI_1           = 1,
    NAS_KSI_2           = 2,
    NAS_KSI_3           = 3,
    NAS_KSI_4           = 4,
    NAS_KSI_5           = 5,
    NAS_KSI_6           = 6,
    NO_KEY_IS_AVAILABLE = 7     /* no key is available(UE to network);reserved(network to UE) */
}NasKsi;

typedef enum CemmPlmnSelectTypeEnum_Tag
{
    CEMM_DEFAULT_PLMN_REG = 0,  // CEMM PLMN module decide by self
    CEMM_AUTO_PLMN_REG,
    CEMM_MANUAL_PLMN_REG,
    CEMM_MANUAL_THEN_AUTO_PLMN_REG, //if manual selection fails, automatic mode
}CemmPlmnSelectTypeEnum;

typedef enum _SIG_EPAT_CEPLMN_CFG_PLMN_SEARCH_LEVEL
{
    /*
     * OOS PLMN interval: 5s, 10s, 20s
    */
    PLMN_SEARCH_POWER_LEVEL_NOT_CARE    = 0,
    /*
     * OOS PLMN interval: 15s, 30s, 1 min (default setting)
    */
    PLMN_SEARCH_POWER_LEVEL_NORMAL_CARE = 1,
    /*
     * OOS PLMN interval: 5 mins, 10 mins, 15 mins
    */
    PLMN_SEARCH_POWER_LEVEL_MORE_CARE   = 2,
    /*
     * OOS PLMN interval: 30s, then stop PLMN search, and let AT: AT+ECPLMNS to start PLMN search
    */
    PLMN_SEARCH_POWER_LEVEL_STRICT_CARE = 3,
    /*
     * Don't trigger PLMN search after OOS, let user decide to start PLMN search or not
    */
    PLMN_SEARCH_POWER_LEVEL_USER_CONTROL = 4
}PlmnSearchPowerLevel;

/******************************************************************************
 * Access Point Name
******************************************************************************/
#define MAX_APN_NAME            100
typedef struct AccessPointNameTag
{
    UINT8       length;
    UINT8       reserved0;
    UINT16      reserved1;
    UINT8       name[MAX_APN_NAME];
}AccessPointName;   //104 byte

typedef enum ConfigurationProtocolTag
{
    CONFIG_PROTOCOL_PPP       = 0,
    CONFIG_PROTOCOL_OSP_IHOSS = 1
}ConfigurationProtocol;

typedef enum PdnTypeTag
{
    PDN_IP_V4        = 0x01,
    PDN_IP_V6        = 0x02,
    PDN_IP_V4V6      = 0x03,
    PDN_UNUSED       = 0x04,
    PDN_NON_IP       = 0x05
}PdnType;

typedef UINT8   PdnTypeT;


/******************************************************************************
 * MSGADDRESS
******************************************************************************/
#define     MAX_SMS_ADDRESS_LENGTH          20
#define     MAX_SMS_LEN                     160
#define     UICC_MAX_ADDR_LEN               20

typedef struct MsgAddress_Tag
{
    UINT8      length;
    UINT8      typeOfNumber;    //TypeOfNumber
    UINT8      numberPlanId;    //NumberingPlanId
    UINT8      reserved;
    UINT8      addressValue[MAX_SMS_ADDRESS_LENGTH];
}MsgAddress;

typedef struct UsatAddressTag
{
    UINT8                        TON; //UsatBcdTON
    UINT8                        NPI; //UsatBcdNPI
    UINT8                        len;
    UINT8                        addrValue[UICC_MAX_ADDR_LEN]; //Bcd number
}
UsatAddress;

typedef enum UsatSmsTpduType_Tag
{
    USAT_SMTPDU_DELIVER         = 0,
    USAT_SMTPDU_SUBMIT          = 1,
    USAT_SMTPDU_COMMAND         = 2
}UsatSmsTpduType;


/******************************************************************************
 * SMS Protocol ID
*****************************************************************************/
typedef struct SmsProtocolIdentifier_Tag
{
   UINT8                  smsPidType;  //SmsPidType
   union
   {
        UINT8               smAlProtocolid;         /* NO_INTERWORKING */
        UINT8               interWorkingProtocolId; /* TELEMATIC_INTERWORKING */
        UINT8               scCommandProtocolId;    /* SHORT_MESSAGE_RELATED */
        UINT8               meCommandProtocolId;    /* ME_RELATED */
        UINT8               reservedProtocolId;     /* RESERVED */
        UINT8               scSpecificProtocolId;   /* SC_SPECIFIC_USE */
        UINT8               pId;
   }protocolId;
   UINT16                   reserved;
}SmsProtocolIdentifier;

/******************************************************************************
 * SMS Data Coding
*****************************************************************************/

typedef enum MessageWaitingIndicationType_Tag
{
    VOICEMAIL_MESSAGE_WAITING       = 0x00, /* Voicemail Message Waiting */
    FAX_MESSAGE_WAITING             = 0x01, /* Fax Message Waiting */
    ELECTRONIC_MAIL_MESSAGE_WAITING = 0x02, /* Electronic Mail Message Waiting */
    OTHER_MESSAGE_WAITING           = 0x03  /* Other Message Waiting */
}MessageWaitingIndicationType;

typedef struct MessageWaitingIndication_Tag
{
    BOOL            discardMessage;     /* Discard Message */
    BOOL            storeMessage;       /* Store Message */
    BOOL            setIndActive;       /* Set Indication Active(TRUE)/Inactive(FALSE) */
    UINT8           waitingIndType;     /* MessageWaitingIndicationType */
}MessageWaitingIndication;

typedef struct SmsDataCodingSchemeTag
{
    UINT8                       smsCoding;          /* SmsCoding */
    UINT8                       smsClass;           /* SmsMessageClass */
    BOOL                        bCompressed;        /* the text is compressed */
    BOOL                        bCodingAndClass;    /* Data coding/message class */
    BOOL                        bMessageWait;       /* Message Waiting Indication Group */
    MessageWaitingIndication    waitIndication;     /* Message Waiting Indication Group content */
}SmsDataCodingScheme;

/*
 * Uicc Pin status
*/
typedef struct UiccPinStatusTag
{
    UINT8                       keyRef; /* UiccKeyRefValue */
    UINT8                       numRemainingAttempts;/* the number of remianing PIN attempts */
    UINT8                       bEnabled:1; /* indicate whether the status of PIN is enable or not (disabled) */
    UINT8                       bVerified:1; /* indicate whether the status of PIN is verified or not */
    UINT8                       bUsed:1; /* TS102.221 9.5.2 The usage qualifier indicates whether an enabled PIN need to be verfied for access */
    UINT8                       reserved1:5;
    UINT8                       reserved2;
}
UiccPinStatus;

/*
* Uicc File path
*/
#define MAX_FILE_PATH_ELEMENTS  10
typedef struct UiccFilePathTag
{
    UINT8     len;
    UINT8     reserved;
    UINT8     path[MAX_FILE_PATH_ELEMENTS];
}
UiccFilePath;

typedef struct EmmEventStatisNvmInfo_Tag
{
    UINT16  numAttachSucc;      /* count of Attach Success */
    UINT16  numAttachFail;
    UINT16  numTauSucc;         /* count of TAU Success */
    UINT16  numTauFail;
    UINT16  numSrSucc;          /* count of Service request Success */
    UINT16  numSrFail;
    UINT16  numAuthFail;        /* count of Authentication Success */
    UINT16  numDetach;          /* count of Detach */
}
EmmEventStatisNvmInfo;


/**
 *
 *    ---------------------ipv4 header format--------------------
 *   0                   1                   2                   3
 *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
 *   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *   |Version|  IHL  |Type of Service|          Total Length         |
 *   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *   |         Identification        |Flags|      Fragment Offset    |
 *   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *   |  Time to Live |    Protocol   |         Header Checksum       |
 *   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *   |                       Source Address                          |
 *   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *   |                    Destination Address                        |
 *   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *   |                    Options                    |    Padding    |
 *   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *                   Example Internet Datagram Header
*/
typedef struct PsIp4Hdr_Tag
{
    #if defined (LITTLE_ENDIAN_BITFIELD)
    UINT8       ihl :4;
    UINT8       version :4;
    #else
    UINT8       version :4;
    UINT8       ihl :4;
    #endif
    UINT8       tos;
    UINT16      tot_len;
    UINT16      id;
    UINT16      frag_off;
    UINT8       ttl;
    UINT8       protocol;
    UINT16      check_sum;
    UINT8       saddr[4];
    UINT8       daddr[4];
}PsIp4Hdr;

/*
 * IPv6 Header Format
 *
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |Version| Traffic Class |           Flow Label                  |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |         Payload Length        |  Next Header  |   Hop Limit   |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |                                                               |
 *  +                                                               +
 *  |                                                               |
 *  +                         Source Address                        +
 *  |                                                               |
 *  +                                                               +
 *  |                                                               |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |                                                               |
 *  +                                                               +
 *  |                                                               |
 *  +                      Destination Address                      +
 *  |                                                               |
 *  +                                                               +
 *  |                                                               |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *
*/
typedef struct PsIp6Hdr_Tag
{
    UINT32      ver_tc_fl;
    UINT16      payload_len;
    UINT8       protocol; //next header
    UINT8       hop_limit;

    UINT8       saddr[16];
    UINT8       daddr[16];
}PsIp6Hdr;

/*
 * ------ User Datagram Header Format
 *  0      7 8     15 16    23 24    31
 * +--------+--------+--------+--------+
 * |   SourcePort    | DestinationPort |
 * +--------+--------+--------+--------+
 * |     Length      |    Checksum     |
 * +--------+--------+--------+--------+
 * |
 * |          data octets ...
 * +---------------- ...
*/
typedef struct PsUdpHdr_Tag
{
    UINT16      sport;
    UINT16      dport;
    UINT16      length;
    UINT16      check_sum;
}PsUdpHdr;

/*
*/
typedef struct PsTcpHdr_Tag
{
    UINT16      sport;
    UINT16      dport;
    UINT32      seq;        /* sequence number */
    UINT32      ack;        /* ack number */
    #if defined (LITTLE_ENDIAN_BITFIELD)
    UINT8       rsvd0 : 4;
    UINT8       thl : 4;    /* tcp header length */
    UINT8       flag : 6;
    UINT8       rsvd1 : 2;
    #else
    UINT8       thl : 4;    /* tcp header length */
    UINT8       rsvd0 : 4;
    UINT8       rsvd1: 2;
    UINT8       flag : 6;
    #endif
    UINT16      window;     /* window size */
    UINT16      cks;        /* check sum */
    UINT16      urgt;       /* urgent */
}PsTcpHdr;


/*
 *   ----IPSEC_HEADER  format ----
 *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
 *   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *   |                      Security parameter index                 |
 *   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *   |                          Sequence number                      |
 *   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *   |                                                               |
 *   |                    Authentication data....                    |
 *   +------------------------------------ ...
 *
 */
typedef struct PsIpSecEspHdr_Tag
{
    UINT32      spi;
    UINT32      sn;
}PsIpSecEspHdr;


typedef UINT8 LocationType_r10_t;
typedef enum _EPAT_LocationType_r10_Tag
{
    LocationInfo_r10_ellipsoid_Point_r10,
    LocationInfo_r10_ellipsoidPointWithAltitude_r10,
    LocationInfo_r10_ellipsoidPointWithUncertaintyCircle_r11,
    LocationInfo_r10_ellipsoidPointWithUncertaintyEllipse_r11,
    LocationInfo_r10_ellipsoidPointWithAltitudeAndUncertaintyEllipsoid_r11,
    LocationInfo_r10_ellipsoidArc_r11,
    LocationInfo_r10_r10_polygon_r11,
}LocationType_r10;

typedef struct LocationOcteStringTag
{
    UINT8                                   data[22]; //temp data size
    UINT16                                  size;
}LocationOcteString;

//LocationInfo_r10 provided for cerrc
typedef struct LocationInformationTag
{
    LocationType_r10_t                      locationInfoType; //LocationType_r10
    LocationOcteString                      locationCoordinates;

    UINT8                                   horizontalVelocity_r10Present;
    UINT8                                   gnss_TOD_msec_r10Present;
    UINT8                                   reserved;
    LocationOcteString                      horizontalVelocity_r10;
    LocationOcteString                      gnss_TOD_msec_r10;
}LocationInformation;


typedef struct Psmd5HashContextTag
{
    UINT32 total[2];
    UINT32 state[4];
    UINT8  buffer[64];  /*temp buffer*/
}
Psmd5HashContext;


#endif

