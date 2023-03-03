#ifndef __MW_AON_INFO_H__
#define __MW_AON_INFO_H__
/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    mw_aon_info.h
 * Description:
 * History:      Rev1.0
 *
 ****************************************************************************/
#include "commontypedef.h"
#include "mw_common.h"
#include "cms_sock_mgr.h"
#include "psdial.h"

/*
 * Differences between these MW config/AON files:
 * 1> mw_nvm_config.h
 *   a) parameter value is still VALID, after reboot.
 *   b) parameter value is still VALID, after FOTA (SW upgrading) if not erase the NVM in flash.
 *   c) if not configed in NVM/flash, use the default value.
 * 2> mw_nvm_info.h
 *   a) parameter value is still VALID, after reboot.
 *   b) parameter value is not VALID (reset to default value), after FOTA (SW upgrading), if:
 *       i> NVM in flash is erased, or
 *       ii> NVM info structure size is changed, or
 *       ii> NVM file version is changed.
 *   c) if not configed in NVM/flash, use the default value.
 * 3> mw_aon_info.h
 *   a) parameter value is still VALID, after wakeup from deep sleep
 *   b) parameter value is not VALID, after reboot
 * 4> mw_common.h
 *   a) middleware common header file, which included by "mw_nvm_config.h"&"mw_nvm_info.h"&"mw_aon_info.h"
 *   b) As customers maybe have different requirements about how to maintain the config,
 *      here could set the common structure in this file
*/



/******************************************************************************
 *****************************************************************************
 * MARCO/ENUM
 *****************************************************************************
******************************************************************************/
#define MID_WARE_AON_MAGIC_WORDS    0xA3B5C7D9
#define MID_WARE_AON_DNS_CFG_MAGIC  0xAB

/*
* option param for netdevctl
*/
typedef enum MWAonNetDevCtlOp_Tag
{
    MW_AON_NET_DEV_CTL_OP_BIND_CID_CANCEL   = 0, //cancel cid band for lwip
    MW_AON_NET_DEV_CTL_OP_BIND_CID_ONCE     = 1, //bind cid once for lwip, no retry after pdn deactivated/re-activated
    MW_AON_NET_DEV_CTL_OP_BIND_CID_REPEAT   = 2, //bind cid repeat for lwip if pdn deactivated/re-activated
    MW_AON_NET_DEV_CTL_OP_BIND_CID_AUTO     = 3, //auto dial to activate PDN with cid and bind it for lwip
    MW_AON_NET_DEV_CTL_OP_BIND_CID_UNKNOWN  = 15 //unknown
}MWAonNetDevCtlOp;

/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

typedef struct MidWareSockAonInfo_Tag
{
    CmsSockMgrHibContext sockContext;
#ifdef  FEATURE_REF_AT_ENABLE
    CmsRefSockCfgParam   refSockConfig;
    UINT32               refSockErr;//CmsRefSockErrorCode
#endif
}MidWareSockAonInfo;

typedef struct MidWareSimSmsAddress_Tag
{
    UINT8      typeOfNumber;
    UINT8      numberPlanId;
    UINT8      reserved;
    UINT8      length;
    UINT8      addressDigits[MID_WARE_SMS_SCA_LEN];
}
MidWareSimSmsAddress;

/*
 * SIM SMS parameters read from SIM or set by +CSCA/+CSMP
*/
typedef struct MidWareSimSmsParamsAonInfo_Tag
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
    MidWareSimSmsAddress       destAddr;
    MidWareSimSmsAddress       scAddr;
}MidWareSimSmsParamsAonInfo;    // 92 bytes

typedef struct MidWareDefaultAonDnsCfg_Tag
{
    UINT8           cid;
    UINT8           bValid;
    UINT8           magic; //MID_WARE_AON_DNS_CFG_MAGIC
    ip4_addr_t      ipv4Dns[MID_WARE_DEFAULT_DNS_NUM];
    ip6_addr_t      ipv6Dns[MID_WARE_DEFAULT_DNS_NUM];
}MidWareDefaultAonDnsCfg;     //48 bytes


typedef MWCfgAtChanConfig   MWAonAtChanConfig;

typedef struct MWAonNetParamCfg_Tag
{
    UINT32      netDevCtlOp     :4; //MWAonNetDevCtlOp
    UINT32      bNetDevCtlUrc   :1; //whether report netdevctl urc or not
    UINT32      bNatEnable      :1; //whether enable NAT(network address translation) or not, host uses local address if nat enable, or else use global address
    UINT32      bBindStateSucc  :1; //whenter the state of bind cid for lwip is success or not
    UINT32      bBindStateReported    :1; //whether the bind state urc reported or not

    UINT32      cid             :8; /* RNDIS/ECM bind CID */
    UINT32      resvd2          :16;

    UINT8       localHostAddr[MID_WARE_IPV4_ADDR_LEN];
}MWAonNetParamCfg;  // 8 bytes


/*
 * ppp link state
*/
typedef enum MWAonPppLinkState_Tag
{
    MW_AON_PPP_LINK_STATE_NO_CARRIER     = 0,    // ppp link is no carrier.
    MW_AON_PPP_LINK_STATE_CONNECTING     = 1,    // ppp link is connecting.
    MW_AON_PPP_LINK_STATE_CONNECTED      = 2,    // ppp link is connected.
}MWAonPppLinkState;

typedef struct MWAonPppParamCfg_Tag
{
    UINT8        reqCid;      // cid: 1- 15 or 0xFF
    UINT8        pppLinkState;      // MWAonPppLinkState
    UINT16       atHandle;
    UINT32       bPppNeedActBearer : 1; // records whether ppp need to active the bearer.
    UINT32       rsvd : 31;
}MWAonPppParamCfg;     // 4 bytes


typedef struct MWAonUrcCacheParamCfg_Tag
{
    /* Wehther URC need to be suspended/cached. If enable, all URC should be cached in URC FIFO list and RI should be cached. */
    UINT8        urcCacheEnableFlag[MID_WARE_USED_AT_CHAN_NUM];
}MWAonUrcCacheParamCfg;     // 4 bytes


/******************************************************************************
 *
 * Middleware info stored in AON memory, limited size: PMU_AON_MID_WARE_MEM_SIZE
 *
******************************************************************************/
typedef struct MidWareAonInfo_Tag
{
    UINT32      bUtcTimeSync : 1;   /* set 1 when time sync trigger after power on(by NITZ or SNTP) */
    UINT32      rsvd : 31;

    /*
     * AT channel Aon config, ParamId: MW_CFG_AT_CHAN_1_CONFIG/...
    */
    MWAonAtChanConfig       atChanConfig[MID_WARE_USED_AT_CHAN_NUM];  //8*4 bytes

    /*
     * PS DIAL AON Info
    */
    PsDialAonInfo           psDialAonInfo;

    /*
     * socket aon info
    */
    MidWareSockAonInfo      mwSockAonInfo;

    /*
     * SIM SMS parameters aon info
    */
    MidWareSimSmsParamsAonInfo    mwSimSmspAonInfo;

    /*
    * mw aon dns server
    */
    MidWareDefaultAonDnsCfg mwDefaultAonDns[MID_WARE_AON_DNS_CID_NUM]; //152 bytes

    /*
    * mw net cfg param
    */
    MWAonNetParamCfg        mwNetParamCfgAonInfo;


    /*
    * mw aon ppp param cfg
    */
    MWAonPppParamCfg        mwPppParamCfgAonInfo;

    /*
    * mw aon urc cache param cfg
    */
    MWAonUrcCacheParamCfg   mwUrcCacheParamCfgAonInfo;

}MidWareAonInfo;



/******************************************************************************
 *****************************************************************************
 * API
 *****************************************************************************
******************************************************************************/

/*
 * INIT
*/
void mwAonInfoInit(void);

void mwAonSaveConfig(void);

/*
 * used for SOCK task
*/
MidWareSockAonInfo* mwGetSockAonInfo(void);
void mwSetSockAonInfo(MidWareSockAonInfo *pSockAonInfo);
void mwAonSockInfoChanged(void);

/**
  \fn           void mwAonTaskRecovery(void)
  \brief        Need recovery some middle ware task, after wakeup from HIB/Sleep2
  \param[in]    void
  \returns      void
  \ Called in CMS task, when task wakeup from deep sleep
*/
void mwAonTaskRecovery(void);

/**
  \fn           BOOL mwAonBeUtcTimeSync(void)
  \brief        Whether UTC time already synced/set
  \param[in]    void
  \returns      BOOL
  \ Note: Only could be called after CMS task start up
*/
BOOL mwAonBeUtcTimeSync(void);


/**
  \fn           void mwAonSetUtcTimeSyncFlag(BOOL bSync)
  \brief        Set UTC time sync flag, be syned or not
  \param[in]    bSync   BOOL
  \returns      void
  \ Note: Only could be called after CMS task start up
*/
void mwAonSetUtcTimeSyncFlag(BOOL bSync);


/**
  \fn           void mwAonPsDialInfoChanged(void)
  \brief        PS DAIL AON info changed, need to write to flash
  \returns      void
*/
void mwAonPsDialInfoChanged(void);

/**
  \fn           mwGetSimSmspAonInfo
  \brief        Get middle ware SIM smsp AON info
  \param[out]   MidWareSimSmsParamsAonInfo *pSimSmspAonInfo
  \returns      void *
*/
void mwGetSimSmspAonInfo(MidWareSimSmsParamsAonInfo *pSimSmspAonInfo);

/**
  \fn           mwSetSimSmspAonInfo
  \brief        Set middle ware SIM smsp AON info
  \param[in]    MidWareSimSmsParamsAonInfo *pSimSmspAonInfo
  \returns      void
*/
void mwSetSimSmspAonInfo(MidWareSimSmsParamsAonInfo *pSimSmspAonInfo);


/**
  \fn           void mwAonSetDefaultAonDnsCfgAndSave((MidWareDefaultAonDnsCfg *mwDefaultAonDnsCfg))
  \brief        Set default AON dns cfg
  \param[in]    mwDefaultAonDnsCfg  default AON dns cfg
  \returns      void
*/
void mwAonSetDefaultAonDnsCfgAndSave(MidWareDefaultAonDnsCfg *mwDefaultAonDnsCfg);

/**
  \fn           void mwAonGetDefaultAonDnsCfg(UINT8 cid, MidWareDefaultAonDnsCfg *mwDefaultAonDnsCfg)
  \brief        get default AON dns cfg by cid
  \param[in]    mwDefaultAonDnsCfg  default AON dns cfg
  \returns      void
*/
void mwAonGetDefaultAonDnsCfg(UINT8 cid, MidWareDefaultAonDnsCfg *mwDefaultAonDnsCfg);

/**
  \fn           void mwAonGetAllAtChanConfig(MWAonAtChanConfig *pAtChanConfig)
  \brief        get AON atChanConfig
  \param[out]   MWAonAtChanConfig  *pAtChanConfig
  \returns      void
*/
void mwAonGetAllAtChanConfig(MWAonAtChanConfig *pAtChanConfig);

/**
  \fn           void mwAonSetAndSaveAtChanConfig(MWAonAtChanConfig *pAtChanConfig)
  \brief        Set and save atChanConfig
  \param[in]    MWAonAtChanConfig *pAtChanConfig
  \Return       void
*/
void mwAonSetAndSaveAllAtChanConfig(MWAonAtChanConfig *pAtChanConfig);

/*
 * get one AT channel config item value
*/
UINT32 mwAonGetAtChanConfigItemValue(UINT8 chanId, MidWareATChanCfgEnum cfgEnum);

/*
 * set and save one AT channel config item value
*/
void mwAonSetAndSaveAtChanConfigItemValue(UINT8 chanId, MidWareATChanCfgEnum cfgEnum, UINT32 value);

/*
 * set one AT channel config item value, need call API: mwAonSaveConfig()
*/
void mwAonSetAtChanConfigItemValue(UINT8 chanId, MidWareATChanCfgEnum cfgEnum, UINT32 value, BOOL *bChanged);

/**
  \fn           void mwAonSetNetParamCfgAndSave((MWAonNetParamCfg *mwAonNetParamCfg))
  \brief        Set AON net param cfg
  \param[in]    MWAonNetParamCfg  AON net param cfg
  \returns      void
*/
void mwAonSetNetParamCfgAndSave(MWAonNetParamCfg *pMwAonNetParamCfg);

/**
  \fn           MWAonNetParamCfg * mwAonGetNetParamCfg(void)
  \brief        get net param cfg
  \param[in]    MWAonNetParamCfg  AON net param cfg
  \returns      void
*/
void mwAonGetNetParamCfg(MWAonNetParamCfg *pMwAonNetParamCfg);

/**
  \fn           MWAonPppParamCfg * mwAonGetPppParamCfg(void)
  \brief        get Ppp param cfg
  \param[in]    MWAonPppParamCfg  AON Ppp param cfg
  \returns      void
*/
void mwAonGetPppParamCfg(MWAonPppParamCfg *pMwAonPppParamCfg);

/**
  \fn           void mwAonSetPppParamCfgAndSave((MWAonPppParamCfg *pMwAonPppParamCfg))
  \brief        Set AON Ppp param cfg
  \param[in]    MWAonPppParamCfg  AON net param cfg
  \returns      void
*/
void mwAonSetPppParamCfgAndSave(MWAonPppParamCfg *pMwAonPppParamCfg);

/**
  \fn           void mwAonGetUrcCacheEnableItemValue(UINT8 *val)
  \brief        get the AON urcCache Enable configuration value
  \param[in]    UINT8 *val : the get aon cache enable pointer
  \returns      void
*/
void  mwAonGetUrcCacheEnableItemValue(UINT8 *val);

/**
  \fn           void mwAonSetUrcCacheEnableItemValue(UINT8 val)
  \brief        set the AON urcCache Enable value
  \param[in]    UINT8 val : the setting urcCache Enable value
  \returns      void
*/
void  mwAonSetUrcCacheEnableItemValue(UINT8 val);

UINT8 mwAonGetUrcCacheParamCfg(UINT8 chanId);

void mwAonSetUrcCacheParamCfgAndSave(UINT8 chanId, UINT8 urcCacheEnableFlag);


#endif


