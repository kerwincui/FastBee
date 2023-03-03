#ifndef __PS_CFG_NVM_H__
#define __PS_CFG_NVM_H__
/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017- Copyrights of AirM2M Ltd.
 File name:      - pscfgnvm.h
 Description:    - Protocol Stack configuration NVM operation
 History:        - 2020/11/03, Originated by Jason
 ******************************************************************************
******************************************************************************/
#include "pssys.h"
#include "pscommtype.h"
#include "osacfgnvm.h"

/******************************************************************************
 ******************************************************************************
 1. "NVMCFG" use the struture:
   a> TV: LF: Length Flag: 0, T: Parameter Type, V: Value
    15  14    12 11              0
    +-----+-----+----------------+
    |LF(0)|RSVD |ParamId(12 bits)|
    +-----+-----+----------------+
    |     Value (16 bits)        |
    +----------------------------+
   b> TLV: LF: Length Flag: 1, T: Value type, L: Value byte length, V: Value
    15  14    12 11              0
    +-----+-----+----------------+
    |LF(1)|RSVD |ParamId(12 bits)|
    +-----+-----+----------------+
    |Value byte length (16 bits) |
    +----------------------------+
    \           Value            \
    +----------------------------+
 2. The 3 "RSVD" bits must set to 0, and used for future;
 3. The "paramId" is 12 bits, with the range: [0 ~ 4095]
   a> [0 ~ 1023], reserved for PS
   b> [1024 ~ 1535], reserved for middle ware
 ******************************************************************************
******************************************************************************/


/*
 * !!!!  PARAM ID !!!!
 * 1> Only allowed
 *   a) add into the end
 * 2> Not allow
 *   a) insert
 *   b) delete
 *   c) change the struct
 * !!!!
*/
typedef enum _EPAT_PsConfigParamId_Enum
{
    PS_CFG_PARAM_BASE       = 0,
    CCM_CFG_NW_MODE,                                /* TV,  NwMode */
    CCM_CFG_UE_SERVICE,                             /* TV,  UeService */
    CCM_CFG_UE_OPERATION_MODE,                      /* TV,  PsUeOperationModeEnum */
    CCM_CFG_ROHC_ENABLE,                            /* TV,  BOOL bRohc */
    CCM_CFG_IPV6_RS_FOR_TEST_SIM_ENABLE,            /* TV,  BOOL bIpv6RsForTestSim */
    CCM_CFG_TCP_TPT_OPT_ENABLE,                     /* TV,  UINT8 bTcpTptOpt */
    CCM_CFG_SMS_SERVICE_TYPE,                       /* TV,  MsgService, AT+CSMS=<service> not used in CCM now */
    CCM_CFG_IPV6_GET_PREFIX_DELAY,                  /* TV,  UINT16 ipv6GetPrefixTime, the maximum time of getting IPv6 prefix Unit: second. */
    CCM_CFG_PS_SOFT_RESET,                          /* TV,  BOOL bEnablePsSoftReset */
    CCM_CFG_SMS_MORE_MSG_MODE = 10,                 /* TV,  CmiSmsMoreMessage, AT+CMMS */

    UICC_CFG_SIM_POWER_SAVE_ENABLE,                 /* TV,  BOOL bSimPowerSave, whether enable USIM card power save mode */
    UICC_CFG_SIM_PRESENCE_DETECTION_ENABLE,         /* TV,  BOOL bSimPreDetect, whether enable SIM presence detection */
    UICC_CFG_SOFT_SIM_ENABLE,                       /* TV,  BOOL bSoftSim, whether use softSIM */

    CEPLMN_CFG_PLMN_SELECT_TYPE,                    /* TLV, PsCfgPlmnSelectType */
    CEPLMN_CFG_CELL_LOCK_INFO,                      /* TLV, PsCfgCellLockInfo */
    CEPLMN_CFG_BAND_INFO,                           /* TLV, PsCfgPlmnBandInfo */
    CEPLMN_CFG_PLMN_SEARCH_LEVEL,                   /* TV,  PlmnSearchPowerLevel */

    CESM_CFG_EPCO_ENABLE,                           /* TV,  bEpco */
    CESM_CFG_ATT_EPS_CID,                           /* TV,  attEpsCid */
    CESM_CFG_USER_DEFINED_T3482 = 20,               /* TLV, PsCfgCesmUserDefinedT3482 */
    CESM_CFG_USER_DEFINED_T3492,                    /* TLV, PsCfgCesmUserDefinedT3492 */
    CESM_CFG_ACL_ENABLE,                            /* TV,  bAclEnable, one byte */

    CEPLMN_CFG_USER_DEFINED_HIGH_PRI_PLMN_TIMER,    /* TLV, PsCfgUserDefinedHighPriPlmnTimer */
    CEPLMN_CFG_ENABLE_ROAM,                         /* TV,  BOOL */
    CEPLMN_CFG_SAVE_PLMN_SEL_MODE,                  /* TV,  BOOL */
    CEPLMN_CFG_UPDATE_FREQ_CTRL,                    /* TV,  BOOL */

    CEMM_CFG_UE_NW_CAPA = 30,                       /* TLV, PsCfgCemmUeNwCapa */
    CEMM_CFG_MS_CLASSMARK2,                         /* TLV, PsCfgCemmMsClassMark2 */
    CEMM_CFG_PSM_SETTING,                           /* TLV, PsCfgCemmPsmSetting */
    CEMM_CFG_EDRX_SETTING,                          /* TLV, PsCfgCemmEdrxSetting */
    CEMM_CFG_TAU_FOR_SMS_CTRL,                      /* TV,  BOOL tauForSmsControl */
    CEMM_CFG_ATTACH_WITHOUT_PDN,                    /* TV,  BOOL attachWithoutPdn */
    CEMM_CFG_USER_MAX_T3324_SETTING,                /* TLV, PsCfgCemmUserMaxT3324Setting */
    CEMM_CFG_CIOT_SETTING,                          /* TV,  PsCfgCemmCiotSetting */
    CEMM_CFG_SMS_ONLY_CTRL,                         /* TV,  BOOL */
    CEMM_CFG_NONIP_NO_SMS_CTRL,                     /* TV,  BOOL */
    CEMM_CFG_VOICE_DOMAIN_UE_USAGE = 40,            /* TLV, PsCfgCemmVoiceDomainUeUsage */
    CEMM_CFG_USER_SIB14_BAR_SECOND,                 /* TV,  UINT16 */
    CEMM_CFG_ENABLE_EAB,                            /* TV,  BOOL */
    CEMM_CFG_ATTACH_WITH_IMSI_CTRL,                 /* TV,  UINT8 */
    CEMM_CFG_POWER_ATTACH_WITHOUT_EIA,              /* TV,  BOOL */
    CEMM_CFG_UPDATE_LOCI_CTRL,                      /* TV,  BOOL */

    CERRC_CFG_AS_RELEASE_TYPE = 50,                 /* TV,  AsReleaseType_t */
    CERRC_CFG_UE_CATEGORY_TYPE,                     /* TV,  UeCategoryType_t */

    CERRC_CFG_DISABLE_NCELL_MEAS,                   /* TV,  BOOL bDisableNCellMeas */
    CERRC_CFG_DEFALT_RELAX_MONITOR_DELTA_P,         /* TV,  UINT8 sSearchDeltaP */
    CERRC_CFG_DEFALT_DATA_INACT_TIMER,              /* TV,  UINT8 dataInactivityTimer */
    CERRC_CFG_DEFALT_ENABLE_AB_CHECK,               /* TV,  BOOL enableABCheck */
    CERRC_CFG_DEFALT_WEAK_CELL_OPT = 56,            /* TV,  BOOL weakCellOpt */
    CERRC_CFG_DEFALT_Q_RX_LEV_MIN = 57,             /* TV,  INT16 qRxLevMin */
    CERRC_CFG_DEFALT_RESEL_TO_WEAK_NCELL_OPT = 58,  /* TV,  UINT8 reselToWeakNcellOpt */
    CERRC_CFG_DEFALT_QUALITY_FIRST = 59,            /* TV,  BOOL qualityFirst */

    CCM_CFG_DATA_COUNTER_CTRL = 60,                 /* TV,  BOOL bEnableDataCounter */
    L2_CFG_DATA_COUNTER_INFO,                       /* TLV, PsCfgL2DataCounterInfo */
    CCM_CFG_SMS_CSCB_SETTING,                       /* TLV, CcmCscbNvmConfig, AT+CSCB */
    CCM_CFG_EMERGENCY_CAMP,                         /* TV,  BOOL bEnableEmergencyCamp */

    UICC_CFG_SIM_SLOT,                              /* TV,  UINT8 simSlot */

    CESM_CFG_PDP_REMAP,                             /* TV,  UINT8 bPdpRemap
                                                     * 0 - disabled,
                                                     * 1 - remap once for attached bearer,
                                                     * 2 - always remap if APN/IP type is same
                                                    */
    CESM_CFG_PDP_REACT,                             /* TV,  UINT8 bPdpReact, 0/1,
                                                     * 1 - default bearer/PDP is need to re-act if APN/IP type changes, when CGACT
                                                    */
    CERRC_CFG_DEFALT_STATIC_CONFIG,                 /* TV,  BOOL staticConfig */
    /*
     * !!!!  PARAM ID !!!!
     * 1> Only allowed
     *   a) add into the end
     * 2> Not allow
     *   a) insert
     *   b) delete
     *   c) change the struct
     * !!!!
    */

    PS_CFG_PARAM_END,
    /* As need a bitmap to record which CFG is set/configed, here limit the MAX ID to 256, than 8 words bitmap is enough */
    PS_CFG_PARAM_MAX    = 0x100
}PsConfigParamId;


typedef enum PsCfgType_Enum
{
    PS_CFG_TV_TYPE  = OSA_CFG_TV_TYPE,
    PS_CFG_TLV_TYPE = OSA_CFG_TLV_TYPE //OsaCfgParam->lf = 1
}PsCfgType;


/*
*/
#define PS_CFG_DEFAULT_TV_VALUE(paramId, value)         {(paramId), (value)}


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/*
*/
typedef OsaCfgParam         PsCfgParam;
typedef OsaCfgParseInfo     PsCfgParseInfo;
typedef OsaCfgTVTypeValue   PsCfgTVTypeValue;




/******************************************************************************
 *****************************************************************************
 * Parameter STRUCT start here
 *****************************************************************************
******************************************************************************/

/*
 * Type: CEPLMN_CFG_PLMN_SELECT_TYPE
 * 0                                                      31
 * +-+---------------------------+-------------------------+
 * |1|CEPLMN_CFG_PLMN_SELECT_TYPE|        Len = 8          |
 * +-+---------------------------+-------------------------+
 * |                  PsCfgPlmnSelectType0                 |
 * |                  PsCfgPlmnSelectType1                 |
 * +-------------------------------------------------------+
*/
typedef struct _SIG_EPAT_CEPLMN_CFG_PLMN_SELECT_TYPE
{
    UINT8   plmnSelectType;     //CemmPlmnSelectTypeEnum
    UINT8   rsvd0;
    UINT16  rsvd1;

    Plmn    manualPlmn;         //if plmnSelectType == CEMM_MANUAL_PLMN_REG/CEMM_MANUAL_THEN_AUTO_PLMN_REG, specify the PLMN
}PsCfgPlmnSelectType;   // 8 bytes

/*
 * CEPLMN_CFG_CELL_LOCK_INFO
*/
typedef struct _SIG_EPAT_CEPLMN_CFG_CELL_LOCK_INFO
{
    UINT8   bCellLock;
    UINT8   rsvd0;

    UINT16  phyCellId;      //range(0..503), 0xFFFF means invalid
    /* EARFCN locked by AT+ECFREQ=2,earfcn */
    UINT32  lockedFreq;
}PsCfgCellLockInfo;     // 8 bytes


/*
 * CEPLMN_CFG_BAND_INFO
*/
typedef struct _SIG_EPAT_CEPLMN_CFG_BAND_INFO
{
    UINT8   band[SUPPORT_MAX_BAND_NUM];
}PsCfgPlmnBandInfo;     // 32 bytes

/*
 * CEMM_CFG_UE_NW_CAPA
*/
typedef struct _SIG_EPAT_CEMM_CFG_UE_NW_CAPA
{
    UINT8   capaLen;

    UINT8   rsvd0;
    UINT8   rsvd1;

    union {
        struct {
            /* here Little-endian */
            UINT8   eea7 : 1;
            UINT8   eea6 : 1;
            UINT8   eea5 : 1;
            UINT8   eea4 : 1;
            UINT8   eea3 : 1;
            UINT8   eea2 : 1;
            UINT8   eea1 : 1;
            UINT8   eea0 : 1;

            UINT8   eia7 : 1;
            UINT8   eia6 : 1;
            UINT8   eia5 : 1;
            UINT8   eia4 : 1;
            UINT8   eia3 : 1;
            UINT8   eia2 : 1;
            UINT8   eia1 : 1;
            UINT8   eia0 : 1;

            UINT8   uea7 : 1;
            UINT8   uea6 : 1;
            UINT8   uea5 : 1;
            UINT8   uea4 : 1;
            UINT8   uea3 : 1;
            UINT8   uea2 : 1;
            UINT8   uea1 : 1;
            UINT8   uea0 : 1;

            UINT8   uia7 : 1;
            UINT8   uia6 : 1;
            UINT8   uia5 : 1;
            UINT8   uia4 : 1;
            UINT8   uia3 : 1;
            UINT8   uia2 : 1;
            UINT8   uia1 : 1;
            UINT8   ucs2 : 1;

            UINT8   nf : 1;
            UINT8   oneXSRVCC : 1;
            UINT8   lcs : 1;
            UINT8   lpp : 1;
            UINT8   accCsfb : 1;
            UINT8   h245Ash : 1;
            UINT8   proSe : 1;
            UINT8   proSeDd : 1;

            UINT8   proSeDc : 1;
            UINT8   proseRelay : 1;
            UINT8   cpCiot : 1;
            UINT8   upCiot : 1;
            UINT8   S1UData : 1;
            UINT8   erWoPdn : 1;
            UINT8   hcCpCiot : 1;
            UINT8   ePco : 1;

            UINT8   multiDrb : 1;
            UINT8   v2xPc5 : 1;
            UINT8   restrictEc : 1;
            UINT8   cpBackoff : 1;
            UINT8   rsvd0 : 4;

            UINT8   rsvd1[6];
        }capaBitmap;

        UINT8   capaByte[13];
    }ueCapa;
}PsCfgCemmUeNwCapa;  //16 bytes

/*
 * CEMM_CFG_MS_CLASSMARK2
*/
typedef struct _SIG_EPAT_CEMM_CFG_MS_CLASSMARK2
{
    UINT8   classmark2Len;

    union {
        struct {
            /* here Little-endian */
            UINT8   rfCap    : 3;
            UINT8   a51      : 1;
            UINT8   esInd    : 1;
            UINT8   revLev   : 2;
            UINT8   spare1   : 1;

            UINT8   fc       : 1;
            UINT8   vgcs     : 1;
            UINT8   vbs      : 1;
            UINT8   smCap    : 1;
            UINT8   ssScreen : 2;
            UINT8   psCap    : 1;
            UINT8   spare2   : 1;

            UINT8   a52      : 1;
            UINT8   a53      : 1;
            UINT8   cmsp     : 1;
            UINT8   soLsa    : 1;
            UINT8   ucs2     : 1;
            UINT8   lcsvaCap : 1;
            UINT8   spare3   : 1;
            UINT8   cm3      : 1;
        }classmark2Bitmap;

        UINT8   classmark2Byte[3];
    }classmark2;

}PsCfgCemmMsClassMark2;  //4 bytes


/*
 * CEMM_CFG_PSM_SETTING
*/
typedef struct _SIG_EPAT_CEMM_CFG_PSM_SETTING
{
    UINT8           mode;           //CemmPsmReqModeEnum, 0/1/2
    UINT8           rsvd0;
    UINT16          rsvd1;

    GprsTimer2      t3324Value;     //2 bytes
    GprsTimer3      t3412ExtendedValue; //2 bytes
}PsCfgCemmPsmSetting;   // 8 bytes


/*
 * CEMM_CFG_EDRX_SETTING
*/
typedef struct _SIG_EPAT_CEMM_CFG_EDRX_SETTING
{
    UINT8           edrxMode;       //CemmEdrxReqModeEnum, 0/1/2
    UINT8           rsvd0;
    ExtendedDrxParameters   extendedDrxParameters;  //maybe 2 bytes, note eDRX paramaters need EURAN parameter
}PsCfgCemmEdrxSetting;  // 4 bytes

/*
 * CEMM_CFG_USER_MAX_T3324_SETTING
*/
typedef struct _SIG_EPAT_CEMM_CFG_USER_MAX_T3324_SETTING
{
    UINT32          userSetT3324Value;  //in unit of second
}PsCfgCemmUserMaxT3324Setting;

/*
 * CEMM_CFG_CIOT_SETTING
*/
#pragma pack(2)
typedef struct _SIG_EPAT_CEMM_CFG_CIOT_SETTING
{
    UINT8           ciotOptimization;   //CemmCiotOptTypeEnum
    UINT8           preferedCiotOptimization;   //CemmCiotOptTypeEnum
}PsCfgCemmCiotSetting;
#pragma pack()

/*
 * CEMM_CFG_VOICE_DOMAIN_UE_USAGE
*/
typedef struct _SIG_EPAT_CEMM_CFG_VOICE_DOMAIN_UE_USAGE
{
    BOOL            present;
    UINT8           rsvd;

    VoiceDomainPreferenceT  voiceDomainPreference;
    UeUsageSettingT         usageSetting;
}PsCfgCemmVoiceDomainUeUsage;

/*
 * CESM_CFG_USER_DEFINED_T3482
 * T3482 used for "PDN CONNECTIVITY REQUEST" procedure, 3GPP value: Cat1: 8s, NB: 188s
*/
typedef struct _SIG_EPAT_CESM_CFG_USER_DEFINED_T3482
{
    BOOL            present;    /* whether user define/cfg the T3482 parameter. if not, using 3GPP timer */

    UINT8           tryCount;   /* "PDN CONNECTIVITY REQUEST" try count, 3GPP value: 5 */
    UINT16          tValueS;    /* Timer value in seconds */
}PsCfgCesmUserDefinedT3482;

/*
 * CESM_CFG_USER_DEFINED_T3492
 * T3492 used for "PDN DISCONNECT REQUEST" procedure, 3GPP value: Cat1: 6s, NB: 186s
*/
typedef struct _SIG_EPAT_CESM_CFG_USER_DEFINED_T3492
{
    BOOL            present;    /* whether user define/cfg the T3492 parameter. if not, using 3GPP timer */
    UINT8           tryCount;   /* "PDN DISCONNECT REQUEST" try count, 3GPP value: 5 */
    UINT16          tValueS;    /* Timer value in seconds */
}PsCfgCesmUserDefinedT3492;


/*
 * CEPLMN_CFG_USER_DEFINED_HIGH_PRI_PLMN_TIMER
 * Higher Priority PLMN search timer
*/
typedef struct _SIG_EPAT_CEPLMN_CFG_USER_DEFINED_HIGH_PRI_PLMN_TIMER
{
    UINT32          present     : 1;    /* whether user define/cfg the high Priority PLMN search timer. if not, using 3GPP timer */
    UINT32          revd        : 3;
    UINT32          tryCount    : 8;    /* [1-255], if set to 255, means try all the time, 0 - not try high priority plmn search */
    UINT32          tValueS     : 20;   /* in second, MAX: 0xFFFFFseconds ~= 290 hours, is enough*/
}PsCfgUserDefinedHighPriPlmnTimer;  // 4 bytes


/*
 * CCM_CFG_DATA_COUNTER_INFO
*/
typedef struct _SIG_EPAT_L2_CFG_DATA_COUNTER_INFO
{
    UINT64  pkgSentBytes;            /* ul sent bytes save in nvm */
    UINT64  pkgRecvBytes;            /* dl recv bytes save in nvm */
}PsCfgL2DataCounterInfo;      // 16 bytes


/******************************************************************************
 *****************************************************************************
 * Functions
 *****************************************************************************
******************************************************************************/

/**
  \fn           OsaNvmRet OsaCfgNvmGetNextParam(OsaCfgParam **pCfgParam, OsaCfgParseInfo *pNvmParseInfo)
  \brief        Get next config parameters info from NVM body info, used when parse all CFG NVM file
  \param[out]   pCfgParam       return cfg parameter info
  \param[in]    pNvmParseInfo   CFG NVM parse info
  \returns      OsaNvmRet
  \ Note: a) if all parsed, return OSA_NVM_SUCC, and "*pCfgParam" set to PNULL
  \       b) if CFG NVM file error, return ERR, and caller should delete this cfg file
*/
#define PsCfgNvmGetNextParam                OsaCfgNvmGetNextParam


/**
  \fn           void OsaCfgNvmRemoveParamFromParseInfo(OsaCfgParam *pRmCfg, OsaCfgParseInfo *pNvmParseInfo)
  \brief        Remove config parameters info from NVM body info, and update the parse offset
  \param[out]   pRmCfg          config parameter info which need remove
  \param[in]    pNvmParseInfo   CFG NVM parse info
  \returns      void
*/
#define PsCfgNvmRemoveParamFromParseInfo    OsaCfgNvmRemoveParamFromParseInfo


/**
  \fn           OsaCfgNvmUpdateParam(UINT16 paramId, UINT8 cfgType, UINT16 paramLen, void *pParamValue, OsaNvmBodyInfo *pNvmBufInfo)
  \brief        Update one configuration into NVM body, note: not write to flash in this API
  \param[in]    paramId         12 bits parameter ID
  \param[in]    cfgType         TV or TLV type
  \param[in]    paramLen        parameter length
  \param[in]    pParamValue     parameter value
  \param[in]    pNvmBodyInfo    NVM body buffer info
  \returns      INT32   //OsaNvmRet
*/
#define PsCfgNvmUpdateParam                 OsaCfgNvmUpdateParam


/**
  \fn           OsaNvmRet OsaCfgNvmAddParam(UINT16 paramId, UINT8 cfgType, UINT16 paramLen, void *pParamValue, OsaNvmBodyInfo *pNvmBodyInfo)
  \brief        Add one configuration into end of NVM body
  \param[in]    paramId         12 bits parameter ID
  \param[in]    cfgType         TV or TLV type
  \param[in]    paramLen        parameter length
  \param[in]    pParamValue     parameter value
  \param[in]    pNvmBodyInfo    NVM body buffer info
  \returns      INT32   //OsaNvmRet
  \Note: The caller must make sure no this cfg already in the NVM
*/
#define PsCfgNvmAddParam                    OsaCfgNvmAddParam


/*
 * Get default setting
*/
UINT16 PsCfgGetTVTypeDefaultValue(PsConfigParamId paramId);
void PsCfgDefaultPlmnSelectType(PsCfgPlmnSelectType *pPlmnSelectType);
void PsCfgDefaultPlmnCellLockInfo(PsCfgCellLockInfo *pCellLockInfo);
void PsCfgDefaultPlmnBandInfo(PsCfgPlmnBandInfo *pBandInfo);
void PsCfgDefaultCemmUeNwCapability(PsCfgCemmUeNwCapa *pCemmUeNwCapability);
void PsCfgDefaultCemmMsClassmark2(PsCfgCemmMsClassMark2 *pCemmMsClassMark2);
void PsCfgDefaultCemmPsmSetting(PsCfgCemmPsmSetting *pCemmPsmSetting);
void PsCfgDefaultCemmEdrxSetting(PsCfgCemmEdrxSetting *pCemmEdrxSetting);
void PsCfgDefaultCemmUserMaxT3324Setting(PsCfgCemmUserMaxT3324Setting *pUserMaxT3324Setting);
void PsCfgDefaultCemmCiotSetting(PsCfgCemmCiotSetting *pCemmCiotSetting);
void PsCfgDefaultCemmVoiceDomainUeUsage(PsCfgCemmVoiceDomainUeUsage *pCemmVoiceDomainUeUsage);
void PsCfgDefaultCerrcUePowerClassSetting(PsCfgCerrcUePowerClassSetting *pCerrcUePowerClassSetting);


/*
 * Initial checking
*/
void PsCfgInitCheck(void);
/*
 * Read UE config
*/
void PsCfgReadUeConfig(PsNvmBodyInfo *pRetInfo, UINT32 rsvdLen);

/*
 * reset all config, when detect config parameter not right
*/
void PsCfgResetAllUeConfig(void);

/*
 * SAVE UE config
*/
void PsCfgSaveUeConfig(OsaNvmBodyInfo *pCfgInfo);



/* to Set the HighPriPlmn TIMER default value */
void PsCfgDefaultCemmHighPriPlmnTm(PsCfgUserDefinedHighPriPlmnTimer *pCmmHighPlmnTmSetting);

/* to Set the esm3482 TIMER default value */

void PsCfgDefaultCesm3482Tm(PsCfgCesmUserDefinedT3482 *pCesm3482TmSetting);

/* to Set the esm3492 TIMER default value */
void PsCfgDefaultCesm3492Tm(PsCfgCesmUserDefinedT3492 *pCesm3492TmSetting);

/*to Set the L2 Data Counter Info default value*/
void PsCfgDefaultL2DataCounterInfoSetting(PsCfgL2DataCounterInfo *pL2DataCounterInfo);

#endif

