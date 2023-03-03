#ifndef __MW_NVM_CONFIG_H__
#define __MW_NVM_CONFIG_H__
/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    mw_nvm_config.h
 * Description:  middleware NVM configuration header file
 * History:      2021/04/12, Originated by Jason
 ****************************************************************************/
#include "osacfgnvm.h"
#include "mw_common.h"

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
 * MARCO/MARCO
 *****************************************************************************
******************************************************************************/

/*
 *
*/
#define MID_WARE_NVM_CFG_FILE_NAME      "mwconfig.nvm"

#define MID_WARE_NVM_CFG_FILE_VER       0x1


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
typedef enum _EPAT_MidWareCfgParamId_Enum
{
    MW_CFG_PARAM_BASE     = 1024,
    MW_CFG_AT_CHAN_1_CONFIG,        /* TLV,  MWNvmCfgAtChanConfig, AT channel 1 */
    MW_CFG_AT_CHAN_2_CONFIG,        /* TLV,  MWNvmCfgAtChanConfig, AT channel 2 */
    MW_CFG_AT_CHAN_3_CONFIG,        /* TLV,  MWNvmCfgAtChanConfig, AT channel 3 */
    MW_CFG_AT_CHAN_4_CONFIG,        /* TLV,  MWNvmCfgAtChanConfig, AT channel 4 */
                                    /* Now, MAX support 4 AT channel */
    MW_CFG_CSCS_PARAM,              /* TLV, MWNvmCfgCSCSParam */
    MW_CFG_SMS_TEXT_CSMP_PARAM,     /* TLV, MWNvmCfgCSMPParam */

    MW_CFG_SMS_MEM_CPMS_PARAM,      /* TLV, MWNvmCfgCPMSParam */

    MW_CFG_SMS_SCA_CSCA_PARAM,      /* TLV, MWNvmCfgCSCAParam */

    MW_CFG_SMS_URC_CNMI_PARAM,      /* TLV, MWNvmCfgCNMIParam */

    MW_CFG_POWER_ON_CFUN,           /* TLV, MWNvmCfgPowerOnCfun */

    MW_CFG_DEFAULT_DNS,             /* TLV, MWNvmCfgDefaultDns */
    MW_CFG_AT_SOCKET_PARAM,         /* TLV, MWNvmCfgAtSocketParam */

    MW_CFG_DM_CTCC_PARAM,           /* TLV, MWNvmCfgDmCtccParam */
    MW_CFG_DM_CMCC_PARAM,           /* TLV, MWNvmCfgDmCmccParam */
    MW_CFG_DM_CUCC_PARAM,           /* TLV, MWNvmCfgDmCuccParam */

    MW_CFG_ALARM_PARAM,             /* TLV, MWNvmCfgAlarmParam */

    MW_CFG_NET_PARAM,               /* TLV, MWNvmCfgNetParam */

    MW_CFG_URCCACHE_PARAM,          /* useless NVM, but can't delete it! */

    MW_CFG_CTW_CFG_PARAM,           /* TLV, MWNvmCfgCtwParamCfg */
    MW_CFG_CTW_HTTP_PARAM,          /* TLV, MWNvmCfgCtwHttpParam */
    MW_CFG_CTW_MQTT_PARAM,          /* TLV, MWNvmCfgCtwMqttParam */
    MW_CFG_CTW_TCP_PARAM,           /* TLV, MWNvmCfgCtwTcpParam */

    MW_CFG_AT_PEND_URC_PARAM,           /* TLV, MWNvmCfgAtPendUrcParam */
    MW_CFG_URC_DELAY_PARAM,             /* TLV, MWNvmCfgUrcDelayParam */
    MW_CFG_URC_RI_SMS_INCOMING_PARAM,   /* TLV, MWNvmCfgUrcRISmsIncomingParam * MID_WARE_USED_AT_CHAN_NUM */
    MW_CFG_URC_RI_OTHER_PARAM,          /* TLV, MWNvmCfgUrcRIOtherParam * MID_WARE_USED_AT_CHAN_NUM */
    MW_CFG_PPP_AUTH_SELECT_PARAM,       /* TV, UINT8 pppAuthSelectMode */

    MW_CFG_PARAM_END,
    /* As need a bitmap to record which CFG is set/configed, here limit the MAX ID to 256, than 8 words bitmap is enough  */
    MW_CFG_PARAM_MAX    =   MW_CFG_PARAM_BASE + 0x100   //1280
}MidWareCfgParamId;


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/
typedef MWCfgAtChanConfig   MWNvmCfgAtChanConfig;



typedef struct _SIG_EPAT_MW_CFG_CSCS_PARAM
{
    CHAR    characterSet[MID_WARE_CSCS_MAX_LEN];
}MWNvmCfgCSCSParam;

/*
 * SMS Text Mode Parameters, set by: AT+CSMP=[<fo>[,<vp>[,<pid>[,<dcs>]]]]
 * Validity-Period comprises 1 or 7 octets refer TS 23.040,9.2.3.12
 * paramId: MW_CFG_SMS_TEXT_CSMP_PARAM/...
*/
typedef struct _SIG_EPAT_MW_CFG_SMS_TEXT_CSMP_PARAM
{
    UINT8   fo;                             // First octet +CSMP=
    UINT8   pid;                            // Protocol Identifier
    UINT8   dcs;                            // Data coding scheme
    UINT8   vpf;                            // Validity-Period Format;
    UINT8   vp[MID_WARE_SMS_VP_MAX_LEN];    // Validity Period value
    UINT8   rsvd;
}MWNvmCfgCSMPParam;    // 8 bytes

/*
 * Select Preferred memory storage Parameters, set by: AT+CPMS=<mem1>[,<mem2>[,<mem3>]]
 * paramId: MW_CFG_SMS_MEM_CPMS_PARAM/...
*/
typedef struct _SIG_EPAT_MW_CFG_SMS_MEM_CPMS_PARAM
{
    UINT8   mem1;               // <mem1>
    UINT8   mem2;               // <mem2>
    UINT8   mem3;               // <mem3>
    UINT8   rsvd;
}MWNvmCfgCPMSParam;    // 4 bytes

/*
 * save the Service Centre Address
 * paramId: MW_CFG_SMS_SCA_CSCA_PARAM/...
*/
typedef struct _SIG_EPAT_MW_CFG_SMS_SCA_CSCA_PARAM
{
    UINT8       scaPresent;
    /* CmiSmsAddressType Address Type Information */
    UINT8       typeOfNumber;                               /* Type of Number  CmiSmsTypeOfNumberEnum */
    UINT8       numberPlanId;                               /* Number Plan Identification  CmiSmsNumberPlanIdEnum */
    /* CmiSmsAddressType Address digits Information */
    UINT8       digitlen;                                   /* Address Length in digits */
    UINT8       addressDigits[MID_WARE_SMS_SCA_LEN];        /* Address digits length */
}MWNvmCfgCSCAParam;    // 44 bytes

/*
 * SMS Text Mode Parameters, set by: AT+CNMI=[<mode>[,<mt>[,<bm>[,<ds>[,<bfr>]]]]]
 * paramId: MW_CFG_SMS_URC_CNMI_PARAM/...
*/
typedef struct _SIG_EPAT_MW_CFG_SMS_URC_CNMI_PARAM
{
    UINT8   mode;           /* <mode>:the control mode for buffering URC */
    UINT8   mt;             /* <mt>:SMS-DELIVER URC mode */
    UINT8   bm;             /* <bm>:CBMs */
    UINT8   ds;             /* <ds>:SMS-STATUS-REPORTs */
    UINT8   bfr;            /* <bfr>:buffered result codes */
    UINT8   rsvd0;
    UINT16  rsvd1;
}MWNvmCfgCNMIParam;    // 8 bytes


/*
 * default DNS config
 * paramId: MW_CFG_DEFAULT_DNS
*/
typedef struct _SIG_EPAT_MW_CFG_DEFAULT_DNS
{
    UINT8   ipv4Dns[MID_WARE_DEFAULT_DNS_NUM][MID_WARE_IPV4_ADDR_LEN];
    UINT8   ipv6Dns[MID_WARE_DEFAULT_DNS_NUM][MID_WARE_IPV6_ADDR_LEN];
}MWNvmCfgDefaultDns;     //40 bytes

/*
 * net param config
 * paramId: MW_CFG_NET_PARAM
*/
typedef struct _SIG_EPAT_MW_CFG_NET_PARAM
{
    BOOL    bAutoDial;      /* whether auto activate PDN context with cid and RNDIS/ECM LAN to this WAN when power on */
    UINT8   cid;            /* pdn context Id, if "bAutoDial" set to TRUE, specify the bind CID, else set to 0xFF */
    BOOL    bNetDevCtlUrc;  /* whether report netdevctl urc: +ECNETDEVCTL, broadcast URC */
    BOOL    bNatEnable;     /* whether enable NAT(network address translation) or not,
                             * 1> host uses local address if nat enable,
                             * 2> or else use global address
                            */
    UINT8   localHostAddr[MID_WARE_IPV4_ADDR_LEN];  /* if "bNatEnable" set to TRUE, RNDIS/ECM host using this V4 ADDR: 192.168.x.x */
}MWNvmCfgNetParam;     //8 bytes


/*
 * AT socket config parameter
 * MW_CFG_AT_SOCKET_PARAM
*/
typedef struct _SIG_EPAT_MW_CFG_AT_SOCKET_PARAM
{
    UINT8   mode;
    UINT8   publicDlPkgNumMax;
    UINT16  publicDlBufferToalSize;
}MWNvmCfgAtSocketParam;

/*
 * MW_CFG_POWER_ON_CFUN
*/
typedef struct _SIG_EPAT_MW_CFG_POWER_ON_CFUN
{
    UINT8       cfun;       /* CFUN: 0/1/4 */
    UINT8       rsvd;
    UINT16      maxDelayS;  /* default random delay value(seconds) before triggering PS power on in CMS */
}MWNvmCfgPowerOnCfun;

/*
 * DM CUCC parameter
*/
typedef struct _SIG_EPAT_MW_CFG_DM_CUCC_PARAM
{
    UINT8   enableFlag;       /*enableFlag  0:disable register 1: enable register*/
    UINT8   hasReg;           /*hasReg 0:has not register  1:has regiestered*/
    UINT8   imsi[MID_WARE_DM_SIM_IMSI_LEN];  /* imsi */
    UINT8   ccid[MID_WARE_DM_SIM_CCID_LEN];  /* ccid */
    UINT8   imei[MID_WARE_DM_IMEI_LEN];      /* imei */
    UINT8   manufacture[MID_WARE_DM_MANUFACTURE_LEN];  /* parameter MODEL set by vendor */
    UINT8   moduleType[MID_WARE_DM_MODULE_TYPE_LEN];   /* parameter MODEL set by vendor */
    UINT8   moduleSWVer[MID_WARE_DM_MODULE_SW_LEN];    /* parameter SWVER set by vendor */
    UINT8   moduleHWVer[MID_WARE_DM_MODULE_HW_LEN];    /* parameter SWVER set by vendor */

    UINT8   productKey[MID_WARE_DM_PRODUCT_KEY_LEN];        /* cucc mqtt product key */
    UINT8   productSecret[MID_WARE_DM_PRODUCT_SECRET_LEN];  /* cucc mqtt product secret */
    UINT8   deviceKey[MID_WARE_DM_DEVICE_KEY_LEN];          /* cucc mqtt device key */
}MWNvmCfgDmCuccParam;

/*
 * DM CTCC parameter
*/
typedef struct _SIG_EPAT_MW_CFG_DM_CTCC_PARAM
{
    UINT8   enableFlag;       /*enableFlag  0:disable register 1: enable register*/
    UINT8   hasReg;           /*hasReg 0:has not register  1:has regiestered*/
    UINT8   ccid[MID_WARE_DM_SIM_CCID_LEN];  /* ccid */
    UINT8   model[MID_WARE_DM_MODEL_LEN];  /* parameter MODEL set by vendor */
    UINT8   swver[MID_WARE_DM_SWVER_LEN];  /* parameter SWVER set by vendor */
}MWNvmCfgDmCtccParam;

/*
 * DM CMCC parameter
*/
typedef struct _SIG_EPAT_MW_CFG_DM_CMCC_PARAM
{
    UINT8   enableFlag;       /*enableFlag  0:disable register 1: enable register*/
    UINT8   bConnected;       /*bConnected  0:no register 1: has register 2: register fail*/
    UINT8   platform;         /*platform    0:test platform  1:commercial platform*/
    UINT16  lifeTime;         /* lifeTime   unit:minute*/
    CHAR    appKey[MID_WARE_DM_APPKEY_LEN];  /* appkey string like "M100000364" */
    CHAR    secret[MID_WARE_DM_SECRET_LEN];  /* secret string like "j5MOg7I6456971aQN7z6Bl36Xk5wYA5Q"*/
    CHAR    location[MID_WARE_DM_LOCATION_LEN]; /* loacation */
}MWNvmCfgDmCmccParam;

/*
 * Voltage low and thermal high alarm
 */
typedef struct _SIG_EPAT_MW_CFG_ALARM_PARAM
{
    UINT8   voltUrcEnable  : 1;
    UINT8   thermUrcEnable : 1;
    UINT8   rsvd           : 6;
    UINT8   voltThd;        /* voltage alarm threshold */
    UINT8   thermThd;       /* thermal alarm threshold */
    UINT8   hysterThd;      /* thermal alarm hysteresis config */
}MWNvmCfgAlarmParam;

/*
 * CTWING HTTP parameter
*/
typedef struct _SIG_EPAT_MW_CFG_CTW_CFG_PARAM
{
    CHAR    softVersion[MID_WARE_CTW_SOFTVERSION_LEN+1];  /* softVersion string */
    CHAR    module[MID_WARE_CTW_MODULE_LEN+1];  /* module string */
    CHAR    chipType[MID_WARE_CTW_CHIPTYPR_LEN+1]; /* chipType */
}MWNvmCfgCtwParamCfg;

/*
 * CTWING HTTP parameter
*/
typedef struct _SIG_EPAT_MW_CFG_CTW_HTTP_PARAM
{
    UINT8   enableFlag;   /*enableFlag  0:disable 1: enable bit:0 autoreg; bit:1 tls; bit:2 masterkey/diviceid/password; bit:3 token; bit:4 dereg; bit:5 register status */
    CHAR    masterKey[MID_WARE_CTW_MASTERKEY_LEN+1];  /* masterkey string */
    CHAR    deviceId[MID_WARE_CTW_DEVICEID_LEN+1];  /* deviceid string like "15143624device1"*/
    CHAR    password[MID_WARE_CTW_PASSWD_LEN+1]; /* password */
    CHAR    token[33];  /* accessToken */
    UINT32  productId;  /* productid int like 15143624*/
}MWNvmCfgCtwHttpParam;

/*
 * CTWING TCP parameter
*/
typedef struct _SIG_EPAT_MW_CFG_CTW_TCP_PARAM
{
    UINT8   enableFlag;   /*enableFlag  0:enable 1: disable bit:0 autoreg; bit:1 diviceid/password; */
    CHAR    deviceId[MID_WARE_CTW_DEVICEID_LEN+1];  /* deviceid string like "15143624device1"*/
    CHAR    password[MID_WARE_CTW_PASSWD_LEN+1]; /* password */
}MWNvmCfgCtwTcpParam;

/*
 * CTWING MQTT parameter
*/
typedef struct _SIG_EPAT_MW_CFG_CTW_MQTT_PARAM
{
    UINT8   autoRegEnableFlag;   /*autoRegEnableFlag  0:disable    1:enable */
    UINT8   mqttsFlag;           /*mqttsFlag  0:mqtt    1:mqtts */
    UINT8   autoRegStatus;       /*autoRegStatus  0:not regist    1:have regist */
    CHAR    uri[MID_WARE_CTW_MQTT_URI_LEN+1];  /* uri */
    UINT32  port;       /*default */
    CHAR    clientId[MID_WARE_CTW_MQTT_CLIENT_ID_LEN+1];  /* clientId */
    CHAR    userName[MID_WARE_CTW_MQTT_USER_NAME_LEN+1];  /* userName */
    CHAR    password[MID_WARE_CTW_MQTT_PASSWD_LEN+1];     /* password */
    UINT32  keepAlive;       /*default 300s */
}MWNvmCfgCtwMqttParam;


/*
 * at pend urc param config
 * paramId: MW_CFG_AT_PEND_URC_PARAM
*/
typedef struct _SIG_EPAT_MW_CFG_AT_PEND_URC_PARAM
{
    /* Whether URC need to be pended/delayed after current AT cmd all processed.(RI don't need to delayed) */
    UINT8    atPendUrcEnableFlag[MID_WARE_USED_AT_CHAN_NUM];
}MWNvmCfgAtPendUrcParam;         //4 bytes


/*
 * urc delay param config
 * paramId: MW_CFG_URC_DELAY_PARAM
*/
typedef struct _SIG_EPAT_MW_CFG_URC_DELAY_PARAM
{
    /* Urc delay time after RI pulse done, in unit of ms. */
    UINT16      urcDelayMs[MID_WARE_USED_AT_CHAN_NUM];
}MWNvmCfgUrcDelayParam;         //8 bytes

/*
 * URC RI SMS incoming param config
 * paramId: MW_CFG_URC_RI_SMS_INCOMING_PARAM
*/
typedef struct _SIG_EPAT_MW_CFG_URC_RI_SMS_INCOMING_PARAM
{
    UINT8       type;           // RI behavior when URCs are present. 0 - off, 1 - pulse.
    UINT8       pulseCount;     // The count of pulse, when type is 1.
    UINT16      pulseDuration;  // in unit of ms, The duration/width of pulse, when type is 1.
}MWNvmCfgUrcRISmsIncomingParam; //4 bytes


/*
 * URC RI other param config
 * paramId: MW_CFG_URC_RI_OTHER_PARAM
*/
typedef struct _SIG_EPAT_MW_CFG_URC_RI_OTHER_PARAM
{
    UINT8       type;           // RI behavior when URCs are present. 0 - off, 1 - pulse.
    UINT8       pulseCount;     // The count of pulse, when type is 1,
    UINT16      pulseDuration;  // in unit of ms, The duration/width of pulse, when type is 1.
}MWNvmCfgUrcRIOtherParam;       //4 bytes



/*
 * Middle ware NVM file structure
 * Note:
 * 1> This structure is allowed to changed, without limitation.
 * 2> !!! but each element struct is not allowed to change. !!!!
 * 3> Only one exception: MWNvmCfgAtChanConfig, as the reserved default value is set to 0, this allowed for extension using,
 *    if default value of this new extension is set to 0.
 *
*/
typedef struct MidWareNvmConfig_Tag
{
    /*
     * AT channel NVM config, ParamId: MW_CFG_AT_CHAN_1_CONFIG/...
    */
    MWNvmCfgAtChanConfig    atChanConfig[MID_WARE_USED_AT_CHAN_NUM];  //8*4 bytes

    /*
    * used for ppp auth select parameters, paramId: MW_CFG_PPP_AUTH_SELECT_PARAM
    * 0 - select pre-defined by AT+CGAUTH, 1 - select the AUTH parameter in PPP LCP procedure.
    */
    UINT8                   pppAuthSelectMode;
    UINT8                   resv0[3];

    /*
    * Character set, ParamId: MW_CFG_CSCS_PARAM
    */
    MWNvmCfgCSCSParam       characterCscsCfg;   //4 bytes

    /*
     * AT channel SMS CSMP config, ParamId: MW_CFG_SMS_TEXT_CSMP_PARAM/...
    */
    MWNvmCfgCSMPParam       smsTextCfgCSMP;   //12 bytes
    /*
    *  SMS CPMS config, ParamId: MW_CFG_SMS_MEM_CPMS_PARAM/...
    */
    MWNvmCfgCPMSParam       smsMemCfgCPMS;   //4 bytes

    /*
    * SMS Service Centre Address, ParamId: MW_CFG_SMS_SCA_CSCA_PARAM/...
    */
    MWNvmCfgCSCAParam       smsScaCfgCSCA;   //44 bytes

    /*
    *  SMS CNMI config, ParamId: MW_CFG_SMS_URC_CNMI_PARAM/...
    */
    MWNvmCfgCNMIParam       smsUrcCfgCNMI;   //8 bytes

    /*
     * used for CMS other sub-mode, ParamId: MW_CFG_DEFAULT_DNS
    */
    MWNvmCfgDefaultDns      defaultDnsCfg;      //40 bytes

    /*
    * used for EC socket public setting, paramId: MW_CFG_AT_SOCKET_PARAM
    */
    MWNvmCfgAtSocketParam   ecSocketCfg;        // 8 bytes

    /*
     * paramId: MW_CFG_POWER_ON_CFUN
    */
    MWNvmCfgPowerOnCfun     powerCfun;          // 4 bytes

    /*
    * used for cucc dm, paramId: MW_CFG_DM_CTCC_PARAM
    */
    MWNvmCfgDmCuccParam     dmCuccParam;        // 104 bytes

    /*
    * used for ctcc dm, paramId: MW_CFG_DM_CTCC_PARAM
    */
    MWNvmCfgDmCtccParam     dmCtccParam;        // 116 bytes

    /*
    * used for cmcc dm, paramId: MW_CFG_DM_CMCC_PARAM
    */
    MWNvmCfgDmCmccParam     dmCmccParam;        // 68 bytes

    /*
    * used for cmcc dm, paramId: MW_CFG_DM_CMCC_PARAM
    */
    MWNvmCfgAlarmParam      almParam;

    /*
    * used for ctwing, paramId: MW_CFG_CTW_PARAM
    */
    MWNvmCfgCtwParamCfg     ctwParamCfg;        // bytes

    /*
    * used for ctwing http, paramId: MW_CFG_CTW_HTTP_PARAM
    */
    MWNvmCfgCtwHttpParam     ctwHttpParam;        //188 bytes

    /*
    * used for ctwing tcp, paramId: MW_CFG_CTW_TCP_PARAM
    */
    MWNvmCfgCtwTcpParam     ctwTcpParam;        //118 bytes

    /*
    * used for ctwing mqtt, paramId: MW_CFG_CTW_MQTT_PARAM
    */
    MWNvmCfgCtwMqttParam     ctwMqttParam;        //  bytes

    /*
     * used for CMS other sub-mode, ParamId: MW_CFG_NET_PARAM
    */
    MWNvmCfgNetParam        netParamCfg;      // 8 bytes

    /*
    * used for pend URC when at cmd is processing, paramId: MW_CFG_AT_PEND_URC_PARAM
    */
    MWNvmCfgAtPendUrcParam  atPendUrcParamCfg;     // 4 bytes

    /*
    * used for URC delay after RI pulse done, paramId: MW_CFG_URC_DELAY_PARAM
    */
    MWNvmCfgUrcDelayParam   urcDelayParamCfg;      // 8 bytes

    /*
    * used for RI behavior when sms incoming URCS are presented, paramId: MW_CFG_URC_RI_SMS_INCOMING_PARAM
    */
    MWNvmCfgUrcRISmsIncomingParam   urcRISmsIncomingParamCfg[MID_WARE_USED_AT_CHAN_NUM];    // 16 bytes

    /*
    * used for RI behavior when other URCs are presented, paramId: MW_CFG_URC_RI_OTHER_PARAM
    */
    MWNvmCfgUrcRIOtherParam         urcRIOtherParamCfg[MID_WARE_USED_AT_CHAN_NUM];      // 16 bytes
}MidWareNvmConfig;


/*
 * Bitmap used to record which parameter configed in "mwconfig.nvm".
 * as now, limited 256 parameters, here, 8 UINT32 is enough.
*/
#define MID_WARE_NVM_CFG_BIT_MAP_WORD_NUM    8
typedef struct MwNvmCfgBitmap_Tag
{
    UINT32      bitmap[MID_WARE_NVM_CFG_BIT_MAP_WORD_NUM];
}MwNvmCfgBitmap;    //32 bytes



/*
 * Middleware NVM config, operation context
*/
typedef struct MwNvmCfgContext_Tag
{
    BOOL                bRead;
    UINT8               rsvd0;
    UINT16              rsvd1;

    osMutexId_t         mutexId;    /* As MW NVM config, maybe called by multi task, here, involved a mutex for safe access */

    MwNvmCfgBitmap      cfgBitmap;
}MwNvmCfgContext;



/*
 * Set CSMP config
*/
typedef struct MWNvmCfgSetCSMPParam_Tag
{
    BOOL    foPresent;
    BOOL    vpPresent;
    BOOL    pidPresent;
    BOOL    dcsPresent;

    MWNvmCfgCSMPParam  csmpParam;
}MWNvmCfgSetCSMPParam;

/*
 * Set CPMS config
*/
typedef struct MWNvmCfgSetCPMSParam_Tag
{
    BOOL    mem1Present;
    BOOL    mem2Present;
    BOOL    mem3Present;
    UINT8   rsvd;

    MWNvmCfgCPMSParam  cpmsParam;
}MWNvmCfgSetCPMSParam;

/*
 * Set CSMP config
*/
typedef struct MWNvmCfgSetCNMIParam_Tag
{
    BOOL        modePresent;
    BOOL        mtPresent;
    BOOL        bmPresent;
    BOOL        dsPresent;
    BOOL        bfrPresent;
    UINT8       rsvd0;
    UINT16      rsvd1;

    MWNvmCfgCNMIParam  cnmiParam;
}MWNvmCfgSetCNMIParam;


/******************************************************************************
 *****************************************************************************
 * API
 *****************************************************************************
******************************************************************************/
void mwCfgDefaultAtChanConfig(UINT8 atChanId, MWNvmCfgAtChanConfig *pATChanConfig);

/**
  \fn           void mwNvmCfgInit(void)
  \brief        Called in CMS task, when task start up
  \param[in]    void
  \returns      void
*/
void mwNvmCfgInit(void);

/**
  \fn           void mwNvmCfgGetAllAtChanConfig(MWNvmCfgAtChanConfig *pAtChanConfig)
  \brief        Get atChanConfig
   \param[out]   MWNvmCfgAtChanConfig *pAtChanConfig
  \returns      config value
*/
void mwNvmCfgGetAllAtChanConfig(MWNvmCfgAtChanConfig *pAtChanConfig);

/**
  \fn           UINT32 mwNvmCfgSetAndSaveAllAtChanConfig(MWNvmCfgAtChanConfig *pAtChanConfig)
  \brief        Set And Save atChanConfig
   \param[in]   MWNvmCfgAtChanConfig *pAtChanConfig
  \returns      config value
*/
void mwNvmCfgSetAndSaveAllAtChanConfig(MWNvmCfgAtChanConfig *pAtChanConfig);

/**
  \fn           UINT32 mwNvmCfgGetAtChanConfigItemValue(UINT8 chanId, MidWareATChanCfgEnum cfgEnum)
  \brief        Get/return one AT channel config value
  \param[in]    chanId      AT channel ID
  \param[in]    cfgEnum     which item value need to return
  \returns      config value
*/
UINT32 mwNvmCfgGetAtChanConfigItemValue(UINT8 chanId, MidWareATChanCfgEnum cfgEnum);

/**
  \fn           void mwNvmCfgSetAtChanConfigItemValue(UINT8 chanId, MidWareATChanCfgEnum cfgEnum, UINT32 value)
  \brief        Set one AT channel config item value, but not save to flash,
  \              need caller call mwNvmCfgSaveAtChanConfig() to write to flash
  \param[in]    chanId      AT channel ID
  \param[in]    cfgEnum     which item
  \param[in]    value       item value
  \param[out]   bChanged    return value, whether NVM changed, if return TRUE, caller need to write to flash
  \returns      void
*/
void mwNvmCfgSetAtChanConfigItemValue(UINT8 chanId, MidWareATChanCfgEnum cfgEnum, UINT32 value, BOOL *bChanged);

/**
  \fn           void mwNvmCfgSetAndSaveAtChanConfigItemValue(UINT8 chanId, MidWareATChanCfgEnum cfgEnum, UINT32 value)
  \brief        Set one AT channel config item value, and save into NVM (flash)
  \param[in]    chanId      AT channel ID
  \param[in]    cfgEnum     which item
  \param[in]    value       item value
  \returns      void
*/
void mwNvmCfgSetAndSaveAtChanConfigItemValue(UINT8 chanId, MidWareATChanCfgEnum cfgEnum, UINT32 value);


/**
  \fn           void mwNvmCfgSaveAtChanConfig(UINT8 chanId)
  \brief        Save AT channel config parameter into NVM (flash), if caller know it changed
  \param[in]    chanId      AT channel ID
  \returns      void
*/
void mwNvmCfgSaveAtChanConfig(UINT8 chanId);

/**
  \fn           void mwNvmCfgSetAndSaveCscsParam(MWNvmCfgCSCSParam *pCscsParam)
  \brief        Set CSCS parameter
  \param[in]    MWNvmCfgCSCSParam        CSCS parameter
  \Return       void
*/
void mwNvmCfgSetAndSaveCscsParam(MWNvmCfgCSCSParam *pCscsParam);

/**
  \fn           void mwNvmCfgGetCscsParam(MWNvmCfgCSCSParam *pCscsParam)
  \brief        Get CSCS parameter
  \param[out]   MWNvmCfgCSCSParam *pCscsParam
  \Return       void
*/
void mwNvmCfgGetCscsParam(MWNvmCfgCSCSParam *pCscsParam);

/**
  \fn           BOOL mwNvmCfgGetCsmpConfig(MWNvmCfgCSMPParam *config)
  \brief        Get/return all csmp config value
  \param[in]    chanId      channel ID
  \param[out]   config      CSMP parameters
  \returns      BOOL
*/
BOOL mwNvmCfgGetCsmpConfig(MWNvmCfgCSMPParam *config);

/**
  \fn           void mwNvmCfgSetAndSaveCsmpConfig(UINT8 chanId, MWNvmCfgSetCSMPParam *pSetCsmp)
  \brief        Set/save all CSMP config value
  \param[in]    chanId      channel ID
  \param[out]   pSetCsmp    CSMP parameters
*/
void mwNvmCfgSetAndSaveCsmpConfig(MWNvmCfgSetCSMPParam *pSetCsmp);

/**
  \fn           BOOL mwNvmCfgGetCpmsConfig(MWNvmCfgCPMSParam *config)
  \brief        Get/return all cpms config value
  \param[out]   config      CPMS parameters
  \returns      BOOL
*/
BOOL mwNvmCfgGetCpmsConfig( MWNvmCfgCPMSParam *config);

/**
  \fn           void mwNvmCfgSetAndSaveCpmsConfig(MWNvmCfgSetCPMSParam *pSetCpms)
  \brief        Set/save all CPMS config value
  \param[out]   pSetCpms    CPMS parameters
*/
void mwNvmCfgSetAndSaveCpmsConfig( MWNvmCfgSetCPMSParam *pSetCpms);
/**
  \fn           BOOL mwNvmCfgGetCscaConfig(MWNvmCfgCSCAParam *config)
  \brief        Get/return all cpms config value
  \param[out]   config      CSCA parameters
  \returns      BOOL
*/
BOOL mwNvmCfgGetCscaConfig( MWNvmCfgCSCAParam *config);

/**
  \fn           BOOL mwNvmCfgGetCnmiConfig(MWNvmCfgCSMPParam *config)
  \brief        Get/return all cnmi config value
  \param[out]   config      cnmi parameters
  \returns      BOOL
*/
BOOL mwNvmCfgGetCnmiConfig( MWNvmCfgCNMIParam *config);

/**
  \fn           void mwNvmCfgSetAndSaveCnmiConfig(MWNvmCfgSetCNMIParam *pSetCnmi)
  \brief        Set/save all CSMP config value
  \param[out]   pSetCsmp    CSMP parameters
*/
void mwNvmCfgSetAndSaveCnmiConfig(MWNvmCfgSetCNMIParam *pSetCnmi);

/**
  \fn           void mwNvmCfgSetAndSaveCscaConfig(MWNvmCfgCSCAParam *pSetCsca)
  \brief        Set/save SC address
  \param[IN]   pSetCpms    CSCA parameters
*/
void mwNvmCfgSetAndSaveCscaConfig( MWNvmCfgCSCAParam *pSetCsca);

/**
  \fn           void mwNvmCfgResetAndSaveCscaConfig( )
  \brief        Reset SC address which has been saved into NVRAM
  \param[IN]   NULL
*/
void mwNvmCfgResetAndSaveCscaConfig( void );

/**
  \fn           void mwNvmCfgSetAndSaveDefaultDnsConfig(MWNvmCfgDefaultDns *pDnsCfg)
  \brief        Set/save all default DNS config
  \param[in]    pDnsCfg   value
*/
void mwNvmCfgSetAndSaveDefaultDnsConfig(MWNvmCfgDefaultDns *pDnsCfg);

/**
  \fn           void mwNvmCfgGetDefaultDnsConfig(MWNvmCfgDefaultDns *pDnsCfg)
  \brief        Get/Read default DNS config info
  \param[out]   pDnsCfg   value
*/
void mwNvmCfgGetDefaultDnsConfig(MWNvmCfgDefaultDns *pDnsCfg);

/**
  \fn           void mwNvmCfgGetEcSocketConfig(UINT8 *mode, UINT8 *publicDlPkgNumMax, UINT16 *publicDlBufferToalSize)
  \brief        Get/Read EC socket configuration parameters
  \param[out]   mode                socket mode
  \param[out]   publicDlPkgNumMax
  \param[out]   publicDlBufferToalSize
*/
void mwNvmCfgGetEcSocketConfig(UINT8 *mode, UINT8 *publicDlPkgNumMax, UINT16 *publicDlBufferToalSize);

/**
  \fn           void mwNvmCfgSetAndSaveEcSocketConfig(UINT8 mode, UINT8 publicDlPkgNumMax, UINT16 publicDlBufferToalSize)
  \brief        Set and save EC socket configuration parameters
  \param[out]   mode                socket mode
  \param[out]   publicDlPkgNumMax
  \param[out]   publicDlBufferToalSize
*/
void mwNvmCfgSetAndSaveEcSocketConfig(UINT8 mode, UINT8 publicDlPkgNumMax, UINT16 publicDlBufferToalSize);


/**
  \fn           void mwNvmCfgGetPowerOnCfun(MWNvmCfgPowerOnCfun *pPowerOnCfun)
  \brief        Get power cfun setting
  \param[out]   pPowerOnCfun        power on cfun config
  \Return       void
*/
void mwNvmCfgGetPowerOnCfun(MWNvmCfgPowerOnCfun *pPowerOnCfun);


/**
  \fn           void mwNvmCfgSetAndSavePowerOnCfun(MWNvmCfgPowerOnCfun *pPowerOnCfun)
  \brief        Set power on cfun
  \param[in]    pPowerOnCfun        power on cfun config
  \Return       void
*/
void mwNvmCfgSetAndSavePowerOnCfun(MWNvmCfgPowerOnCfun *pPowerOnCfun);

/**
  \fn           void mwNvmCfgGetDmCuccParam(MWNvmCfgDmCuccParam *pDmCuccParam)
  \brief        Get DM cucc parameter
  \param[out]   pDmCuccParam        DM cucc parameter
  \Return       void
*/
void mwNvmCfgGetDmCuccParam(MWNvmCfgDmCuccParam *pDmCuccParam);


/**
  \fn           void mwNvmCfgSetAndSaveDmCuccParam(MWNvmCfgDmCuccParam *pDmCuccParam)
  \brief        Set DM cucc parameter
  \param[in]    pDmCuccParam        DM cucc parameter
  \Return       void
*/
void mwNvmCfgSetAndSaveDmCuccParam(MWNvmCfgDmCuccParam *pDmCuccParam);

/**
  \fn           void mwNvmCfgGetDmCtccParam(MWNvmCfgDmCtccParam *pDmCtccParam)
  \brief        Get DM ctcc parameter
  \param[out]   pDmCtccParam        DM ctcc parameter
  \Return       void
*/
void mwNvmCfgGetDmCtccParam(MWNvmCfgDmCtccParam *pDmCtccParam);


/**
  \fn           void mwNvmCfgSetAndSaveDmCtccParam(MWNvmCfgDmCtccParam *pDmCtccParam)
  \brief        Set DM ctcc parameter
  \param[in]    pDmCtccParam        DM ctcc parameter
  \Return       void
*/
void mwNvmCfgSetAndSaveDmCtccParam(MWNvmCfgDmCtccParam *pDmCtccParam);

/**
  \fn           void mwNvmCfgGetDmCmccParam(MWNvmCfgDmCmccParam *pDmCmccParam)
  \brief        Get DM cmcc parameter
  \param[out]   pDmCmccParam        DM cmcc parameter
  \Return       void
*/
void mwNvmCfgGetDmCmccParam(MWNvmCfgDmCmccParam *pDmCmccParam);


/**
  \fn           void mwNvmCfgSetAndSaveDmCmccParam(MWNvmCfgDmCmccParam *pDmCmccParam)
  \brief        Set DM cmcc parameter
  \param[in]    pDmCmccParam        DM cmcc parameter
  \Return       void
*/
void mwNvmCfgSetAndSaveDmCmccParam(MWNvmCfgDmCmccParam *pDmCmccParam);

void mwNvmCfgGetCtwParamConfig(MWNvmCfgCtwParamCfg *pCtwParam);
void mwNvmCfgSetAndSaveCtwParamConfig(MWNvmCfgCtwParamCfg *pCtwParam);
void mwNvmCfgGetCtwHttpParam(MWNvmCfgCtwHttpParam *pCtwHttpParam);
void mwNvmCfgSetAndSaveCtwHttpParam(MWNvmCfgCtwHttpParam *pCtwHttpParam);
void mwNvmCfgGetCtwTcpParam(MWNvmCfgCtwTcpParam *pCtwTcpParam);
void mwNvmCfgSetAndSaveCtwTcpParam(MWNvmCfgCtwTcpParam *pCtwTcpParam);
void mwNvmCfgGetCtwMqttParam(MWNvmCfgCtwMqttParam*pCtwMqttParam);
void mwNvmCfgSetAndSaveCtwMqttParam(MWNvmCfgCtwMqttParam*pCtwMqttParam);


void mwGetEcSocPublicConfig(UINT8 *mode, UINT8 *publicDlPkgNumMax, UINT16 *publicDlBufferToalSize);
UINT8 mwSetEcSocPublicConfig(UINT8 mode, UINT8 publicDlPkgNumMax, UINT16 publicDlBufferToalSize);
void mwNvmCfgGetAlarmParam(MWNvmCfgAlarmParam *pAlarmParam);
void mwNvmCfgSetAndSaveAlarmParam(MWNvmCfgAlarmParam *pAlarmParam);

/**
  \fn           void mwNvmCfgSetAndSaveNetParamConfig(MWNvmCfgnet *pDnsCfg)
  \brief        Set/save all net param config
  \param[in]    pDnsCfg   value
*/
void mwNvmCfgSetAndSaveNetParamConfig(MWNvmCfgNetParam *pNetParamCfg);

/**
  \fn           void mwNvmCfgGetNetParamConfig(MWNvmCfgNetParam *pNetParamCfg)
  \brief        Get/Read net param config info
  \param[out]   pDnsCfg   value
*/
void mwNvmCfgGetNetParamConfig(MWNvmCfgNetParam *pNetParamCfg);

void mwNvmCfgSetAndSaveAtPendUrcParam(UINT8 chanId, UINT8 atPendUrcEnableFlag);
UINT8 mwNvmCfgGetAtPendUrcParam(UINT8 chanId);
void mwNvmCfgSetAndSaveUrcDelayParam(UINT8 chanId, UINT16 urcDelayMs);
UINT16 mwNvmCfgGetUrcDelayParam(UINT8 chanId);
void mwNvmCfgSetAndSaveUrcRISmsIncomingParam(UINT8 chanId, const MWNvmCfgUrcRISmsIncomingParam *pSmsIncomingRiCfg);
void mwNvmCfgGetUrcRISmsIncomingParam(UINT8 chanId, MWNvmCfgUrcRISmsIncomingParam *pSmsIncomingRiCfg);
void mwNvmCfgSetAndSaveUrcRIOtherParam(UINT8 chanId, const MWNvmCfgUrcRIOtherParam *pOtherUrcRiCfg);
void mwNvmCfgGetUrcRIOtherParam(UINT8 chanId, MWNvmCfgUrcRIOtherParam *pOtherUrcRiCfg);
void mwNvmCfgGetPppAuthSelectMode(UINT8 *pPppAuthSelectMode);
void mwNvmCfgSetAndSavePppAuthSelectMode(UINT8 *pPppAuthSelectMode);



#endif

