#ifndef __MW_COMMON_H__
#define __MW_COMMON_H__
/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    mw_common.h
 * Description:  middleware common configuration header file
 * History:      Rev1.0   2019-04-10
 *
 ****************************************************************************/
#include "osasys.h"
#include "cms_def.h"

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
 * CMS/AT channel 0 is reserved for internal
*/

#define MID_WARE_DM_APPKEY_LEN              11      /*for cmcc dm model*/
#define MID_WARE_DM_SECRET_LEN              33      /*for cmcc dm model*/
#define MID_WARE_DM_LOCATION_LEN            15      /*for cmcc dm model*/

#define MID_WARE_AON_DNS_CID_NUM            3
#define MID_WARE_DEFAULT_DNS_NUM            2
#define MID_WARE_IPV4_ADDR_LEN              4
#define MID_WARE_IPV6_ADDR_LEN              16

#define MID_WARE_DM_SIM_CCID_LEN            24      /*for dm model*/
#define MID_WARE_DM_SIM_IMSI_LEN            18      /*for dm model*/
#define MID_WARE_DM_IMEI_LEN                18      /*for dm model*/

#define MID_WARE_DM_MODEL_LEN               24      /*for ctcc dm model*/
#define MID_WARE_DM_SWVER_LEN               64      /*for dm swver*/
#define MID_WARE_DM_HWVER_LEN               64      /*for dm swver*/

#define MID_WARE_DM_PRODUCT_KEY_LEN         (20)    /*for cucc dm mqtt product key*/
#define MID_WARE_DM_PRODUCT_SECRET_LEN      (36)    /*for cucc dm mqtt product secret*/
#define MID_WARE_DM_DEVICE_KEY_LEN          (36)    /*for cucc dm mqtt device key*/
#define MID_WARE_DM_DEVICE_SECRET_LEN       (100)   /*for cucc dm mqtt device secret*/

#define MID_WARE_DM_MANUFACTURE_LEN         (16)    /*for cucc dm mqtt product key*/
#define MID_WARE_DM_MODULE_TYPE_LEN         (24)    /*for cucc dm mqtt product key*/
#define MID_WARE_DM_MODULE_SW_LEN           (32)    /*for cucc dm mqtt product key*/
#define MID_WARE_DM_MODULE_HW_LEN           (32)    /*for cucc dm mqtt product key*/

#define MID_WARE_SMS_SCA_LEN                40      /*for SMS service centre address length*/
#define MID_WARE_SMS_VP_MAX_LEN             7       /*for SMS Validity-Period length*/

#define MID_WARE_CSCS_MAX_LEN               10      /*for CSCS character set*/

#define MID_WARE_CTW_SOFTVERSION_LEN        24      /*for ctwing materkey*/
#define MID_WARE_CTW_MODULE_LEN             24      /*for ctwing deviceid*/
#define MID_WARE_CTW_CHIPTYPR_LEN           24      /*for ctwing password*/

#define MID_WARE_CTW_MASTERKEY_LEN          32      /*for ctwing materkey*/
#define MID_WARE_CTW_DEVICEID_LEN           72      /*for ctwing deviceid*/
#define MID_WARE_CTW_PASSWD_LEN             43      /*for ctwing password*/

#define MID_WARE_CTW_MQTT_URI_LEN           128     /*for ctwing mqtt uri*/
#define MID_WARE_CTW_MQTT_CLIENT_ID_LEN     64      /*for ctwing mqtt client id*/
#define MID_WARE_CTW_MQTT_USER_NAME_LEN     72      /*for ctwing mqtt user name*/
#define MID_WARE_CTW_MQTT_PASSWD_LEN        72      /*for ctwing mqtt password*/


typedef enum MidWareATChanCfgEnum_Tag
{
    MID_WARE_AT_CHAN_ECHO_CFG,              //ATE0/ATE1
    MID_WARE_AT_CHAN_SUPPRESS_CFG,          //ATQ0/ATQ1
    MID_WARE_AT_CHAN_CREG_RPT_CFG,          //CmiMmCregModeEnum
    MID_WARE_AT_CHAN_CEREG_RPT_CFG,         //CmiPsCeregModeEnum
    MID_WARE_AT_CHAN_EDRX_RPT_CFG,          //TRUE/FALSE
    MID_WARE_AT_CHAN_CIOT_OPT_RPT_CFG,      //CmiMmCiotReportModeEnum
    MID_WARE_AT_CHAN_CSCON_RPT_CFG,         //CSCON
    MID_WARE_AT_CHAN_SMS_MODE_CFG,          //PDU mode/TEXT mode
    MID_WARE_AT_CHAN_TIME_ZONE_REP_CFG,     //CTZR
    MID_WARE_AT_CHAN_TIME_ZONE_UPD_CFG,     //CTZU
    MID_WARE_AT_CHAN_CMEE_CFG,              //CMEE
    MID_WARE_AT_CHAN_ECCESQ_RPT_CFG,        //ECCESQ
    MID_WARE_AT_CHAN_CGEREP_MODE_CFG,       //CGEREP
    MID_WARE_AT_CHAN_PSM_RPT_CFG,           //ECPSMR
    MID_WARE_AT_CHAN_EMM_TIME_RPT_CFG,      //ECEMMTIME
    MID_WARE_AT_CHAN_PTW_EDRX_RPT_CFG,      //ECPTWEDRXP
    MID_WARE_AT_CHAN_ECPIN_STATE_RPT_CFG,   //ECPIN
    MID_WARE_AT_CHAN_ECPADDR_RPT_CFG,       //ECPADDR
    MID_WARE_AT_CHAN_ECPCFUN_RPT_CFG,       //ECPCFUN
    MID_WARE_AT_CHAN_ECLED_MODE_CFG,        //ECLEDMODE
    MID_WARE_AT_CHAN_ECPURC_HIB_RPT_CFG,    //ECPURC HIB report
    MID_WARE_AT_CHAN_SMS_SERVICE_CFG,       //SMS select message service, for +CSMS
    MID_WARE_AT_CHAN_SMS_TEXT_SHOW_CFG,     //SMS whether header info in show in text mode result ode =-, for +CSMS
    MID_WARE_AT_CHAN_ECPURC_SLP2_RPT_CFG,   //ECPURC SLP2 report
    MID_WARE_AT_CHAN_ECPURC_SLP1_RPT_CFG,   //ECPURC SLP1 report
    MID_WARE_AT_CHAN_SMS_MEM_CAP_CFG,       //SMS Memory Capacity Exceeded flag
    MID_WARE_AT_CHAN_DCD_MODE_CFG,          //AT&C[value] DCD mode
    MID_WARE_AT_CHAN_DTR_MODE_CFG,          //AT&D[value] DTR mode
    MID_WARE_AT_CHAN_ECSMSFULL_RPT_CFG,     //ECSMSFULL

    MID_WARE_AT_CHAN_CFG_MAX
}MidWareATChanCfgEnum;

/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/
/*
 * AT CMD channel config
 * paramId: MW_CFG_AT_CHAN_1_CONFIG/...
*/
typedef struct _SIG_EPAT_MW_CFG_AT_CHAN_1_CONFIG
{
    UINT32  chanId           : 4;       //PSDecoderChann, currently, only one channel used for ATCMD: PS_CHANNEL_MODEM
    UINT32  echoValue        : 1;       //ATE0/ATE1, set whether need to echo each AT CMD REQ
    UINT32  suppressionValue : 1;       //ATQ0/ATQ1, whether suppress result code
    UINT32  cregRptMode      : 2;       //CmiMmCregModeEnum

    UINT32  ceregRptMode     : 3;       //CmiPsCeregModeEnum
    UINT32  needEdrxRpt      : 1;       //AT+CEDRXS, whether need to report EDRX value, when EDRX value changes
    UINT32  needCiotOptRpt   : 3;       //CmiMmCiotReportModeEnum
    UINT32  smsSendMode      : 1;       //+CMGF=[<n>] Pdu/Text mode, PsilSmsFormatMode

    UINT32  csconRptMode     : 2;       //+CSCON=[<n>], AtcCSCONRptLevel
    UINT32  cmeeMode         : 2;       //+CMEE, AtcCMEERetType
    UINT32  timeZoneRptMode  : 2;       //+CTZR, AtcCTZRRptValue
    UINT32  timeZoneUpdMode  : 1;       //+CTZU, AtcCTZUUpdateValue
    UINT32  cgerepMode       : 1;       //+CGEREP, AtcCGEREPMode

    UINT32  eccesqRptMode    : 2;       //+ECCESQ, AtcECCESQRptValue
    UINT32  ecpsmRptMode     : 1;       //+ECPSMR, AtcECPSMRValue
    UINT32  ecemmtimeRptMode : 3;       //+ECEMMTIME
    UINT32  ecPtwEdrxRpt     : 1;       //AT+ECPTWEDRXS, whether need to report PTW/EDRX value, when PTW/EDRX value changes
    UINT32  ecpinRptMode     : 1;       //+ECPIN,

    UINT32  ecpaddrRptMode   : 1;       //+ECPADDR
    UINT32  ecpcfunRptMode   : 1;       //+ECPCFUN
    UINT32  ecledMode        : 1;       //+ECLEDMODE
    UINT32  ecHibRptMode     : 1;       //+ECPURC=Hibnate,enable
    UINT32  smsService       : 1;       //+CSMS=<Service>, value is 0 or 1, and 128 not support currently.
    UINT32  smsShowMode      : 1;       //+CSDH 0, do not show header value, show header info in text mode result codes.
    UINT32  ecSlp2RptMode    : 1;       //+ECPURC=SLEEP2,enable
    UINT32  ecSlp1RptMode    : 1;       //+ECPURC=SLEEP1,enable

    UINT32  smsMemCapExceed  : 1;       //SMS Memory Capacity Exceeded flag
    UINT32  dcdMode          : 1;       //AT&C[value] Circuit 109 (Received line signal detector) behaviour
    UINT32  dtrMode          : 2;       //AT&D[value] Circuit 108 (Data terminal ready) behaviour
    UINT32  ecsmsfullRptMode : 1;       //+ECSMSFULL, 0: not report; 1: report when SMS memfull after bootup/+CMGW/+CMTI
    UINT32  rsvd0            : 19;      //VALUE is 0
}MWCfgAtChanConfig;   // 8 bytes

/******************************************************************************
 *****************************************************************************
 * API
 *****************************************************************************
******************************************************************************/



#endif

