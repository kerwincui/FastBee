/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename:
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _ATEC__DEV_H
#define _ATEC__DEV_H

#include "at_util.h"

/* AT+CFUN */
#define ATC_CFUN_0_FUN_VAL_MIN                  0
#define ATC_CFUN_0_FUN_VAL_MAX                  4
#define ATC_CFUN_0_FUN_VAL_DEFAULT              1
#define ATC_CFUN_1_RST_VAL_MIN                  0
#define ATC_CFUN_1_RST_VAL_MAX                  1
#define ATC_CFUN_1_RST_VAL_DEFAULT              0


/* AT+ECBAND */
#define ATC_ECBAND_0_NW_MODE_VAL_DEFAULT            2
#define ATC_ECBAND_1_BAND_VAL_MIN                   0
#define ATC_ECBAND_1_BAND_VAL_MAX                   85
#define ATC_ECBAND_1_BAND_VAL_DEFAULT               0

/* AT+ECFREQ */
#define ATC_ECFREQ_0_NW_MODE_VAL_MIN                0
#define ATC_ECFREQ_0_NW_MODE_VAL_MAX                3
#define ATC_ECFREQ_0_NW_MODE_VAL_DEFAULT            0
#define ATC_ECFREQ_1_EARFCN_VAL_MIN                 0
#define ATC_ECFREQ_1_EARFCN_VAL_MAX                 0x7FFFFFFF
#define ATC_ECFREQ_1_EARFCN_VAL_DEFAULT             0
#define ATC_ECFREQ_2_PHYCELL_VAL_MIN                0
#define ATC_ECFREQ_2_PHYCELL_VAL_MAX                503
#define ATC_ECFREQ_2_PHYCELL_VAL_DEFAULT            0

/* AT+ECCGSN */
#define ATC_CGSN_0_MAX_PARM_STR_LEN                 16
#define ATC_CGSN_0_MAX_PARM_STR_DEFAULT             NULL
#define ATC_CGSN_1_MAX_PARM_STR_LEN                 32
#define ATC_CGSN_1_MAX_PARM_STR_DEFAULT             NULL

/* AT+ECCGSNLOCK */
#define ATC_ECCGSNLOCK_0_IMEI_STR_LEN               16
#define ATC_ECCGSNLOCK_0_IMEI_STR_DEFAULT           "imeiLock"
#define ATC_ECCGSNLOCK_0_SN_STR_LEN                 16
#define ATC_ECCGSNLOCK_0_SN_STR_DEFAULT             "snLock"


/* AT+CIOTPOWER */
#define ATC_CIOTPOWER_0_VAL_MIN                     0
#define ATC_CIOTPOWER_0_VAL_MAX                     2
#define ATC_CIOTPOWER_0_VAL_DEFAULT                 0


/* AT+ECCFG */
#define ATC_ECCFG_0_MAX_PARM_STR_LEN                 32
#define ATC_ECCFG_0_MAX_PARM_STR_DEFAULT             NULL
#define ATC_ECCFG_1_GCFTEST_VAL_MIN                  0
#define ATC_ECCFG_1_GCFTEST_VAL_MAX                  1
#define ATC_ECCFG_1_GCFTEST_VAL_DEFAULT              (-1)
#define ATC_ECCFG_1_AUTOAPN_VAL_MIN                  0
#define ATC_ECCFG_1_AUTOAPN_VAL_MAX                  1
#define ATC_ECCFG_1_AUTOAPN_VAL_DEFAULT              (-1)
#define ATC_ECCFG_1_SUPPORTSMS_VAL_MIN               0
#define ATC_ECCFG_1_SUPPORTSMS_VAL_MAX               1
#define ATC_ECCFG_1_SUPPORTSMS_VAL_DEFAULT           (-1)
#define ATC_ECCFG_1_TAUFORSMS_VAL_MIN                0
#define ATC_ECCFG_1_TAUFORSMS_VAL_MAX                1
#define ATC_ECCFG_1_TAUFORSMS_VAL_DEFAULT            (-1)
#define ATC_ECCFG_1_T3324_VAL_MIN                    0
#define ATC_ECCFG_1_T3324_VAL_MAX                    0xFFFFFF
#define ATC_ECCFG_1_T3324_VAL_DEFAULT                0xFFFFFF
#define ATC_ECCFG_1_BAR_VAL_MIN                      1
#define ATC_ECCFG_1_BAR_VAL_MAX                      600
#define ATC_ECCFG_1_BAR_VAL_DEFAULT                  120
#define ATC_ECCFG_1_SIMTEST_VAL_MIN                  0
#define ATC_ECCFG_1_SIMTEST_VAL_MAX                  1
#define ATC_ECCFG_1_SIMTEST_VAL_DEFAULT              (-1)
#define ATC_ECCFG_1_USIMSIMULATOR_VAL_MIN            0
#define ATC_ECCFG_1_USIMSIMULATOR_VAL_MAX            1
#define ATC_ECCFG_1_USIMSIMULATOR_VAL_DEFAULT        (-1)
#define ATC_ECCFG_1_SUPPORTUPRAI_VAL_MIN             0
#define ATC_ECCFG_1_SUPPORTUPRAI_VAL_MAX             1
#define ATC_ECCFG_1_SUPPORTUPRAI_VAL_DEFAULT         (-1)
#define ATC_ECCFG_1_DIT_VAL_MIN                      0
#define ATC_ECCFG_1_DIT_VAL_MAX                      0xff
#define ATC_ECCFG_1_DIT_VAL_DEFAULT                  (-1)
#define ATC_ECCFG_1_RMD_VAL_MIN                      0
#define ATC_ECCFG_1_RMD_VAL_MAX                      17
#define ATC_ECCFG_1_RMD_VAL_DEFAULT                  (-1)
#define ATC_ECCFG_1_POWERLEVEL_VAL_MIN               0
#define ATC_ECCFG_1_POWERLEVEL_VAL_MAX               4
#define ATC_ECCFG_1_POWERLEVEL_VAL_DEFAULT           (-1)
#define ATC_ECCFG_1_REL_VERSION_VAL_MIN              13
#define ATC_ECCFG_1_REL_VERSION_VAL_MAX              14
#define ATC_ECCFG_1_REL_VERSION_VAL_DEFAULT          13
#define ATC_ECCFG_1_ROHC_VAL_MIN                     0
#define ATC_ECCFG_1_ROHC_VAL_MAX                     1
#define ATC_ECCFG_1_ROHC_VAL_DEFAULT                 (-1)
#define ATC_ECCFG_1_EPCO_VAL_MIN                     0
#define ATC_ECCFG_1_EPCO_VAL_MAX                     1
#define ATC_ECCFG_1_EPCO_VAL_DEFAULT                 (-1)
#define ATC_ECCFG_1_MULTICARRIER_VAL_MIN             0
#define ATC_ECCFG_1_MULTICARRIER_VAL_MAX             1
#define ATC_ECCFG_1_MULTICARRIER_VAL_DEFAULT         (-1)
#define ATC_ECCFG_1_MULTITONE_VAL_MIN                0
#define ATC_ECCFG_1_MULTITONE_VAL_MAX                1
#define ATC_ECCFG_1_MULTITONE_VAL_DEFAULT            (-1)
#define ATC_ECCFG_1_IPV6RSFORTESTSIM_VAL_MIN         0
#define ATC_ECCFG_1_IPV6RSFORTESTSIM_VAL_MAX         1
#define ATC_ECCFG_1_IPV6RSFORTESTSIM_VAL_DEFAULT     (-1)
#define ATC_ECCFG_1_POWERCFUN_VAL_MIN                0
#define ATC_ECCFG_1_POWERCFUN_VAL_MAX                4
#define ATC_ECCFG_1_POWERCFUN_VAL_DEFAULT            1   //CFUN1
#define ATC_ECCFG_1_PSPOWERONMAXDEALY_VAL_MIN        0
#define ATC_ECCFG_1_PSPOWERONMAXDEALY_VAL_MAX        0xFFFF
#define ATC_ECCFG_1_PSPOWERONMAXDEALY_VAL_DEFAULT    0
#define ATC_ECCFG_1_IPV6RSDELAY_VAL_MIN              0
#define ATC_ECCFG_1_IPV6RSDELAY_VAL_MAX              65535
#define ATC_ECCFG_1_IPV6RSDELAY_VAL_DEFAULT          (15)
#define ATC_ECCFG_1_DISABLENCELLMEAS_VAL_MIN         (0)
#define ATC_ECCFG_1_DISABLENCELLMEAS_VAL_MAX         (1)
#define ATC_ECCFG_1_DISABLENCELLMEAS_VAL_DEFAULT     (0)
#define ATC_ECCFG_1_UECATEGORY_VAL_MIN               (1)
#define ATC_ECCFG_1_UECATEGORY_VAL_MAX               (2)  //1 - CAT1, 2 - CAT1 bis
#define ATC_ECCFG_1_UECATEGORY_VAL_DEFAULT           (1)

#define ATC_ECCFG_1_PSSOFTRESET_VAL_MIN              (0)
#define ATC_ECCFG_1_PSSOFTRESET_VAL_MAX              (1)
#define ATC_ECCFG_1_PSSOFTRESET_VAL_DEFAULT          (0)

#define ATC_ECCFG_1_ENABLEEAB_VAL_MIN                (0)
#define ATC_ECCFG_1_ENABLE_VAL_MAX                   (1)
#define ATC_ECCFG_1_ENABLE_VAL_DEFAULT               (1)

#define ATC_ECCFG_1_ENABLEABCHECK_VAL_MIN            (0)
#define ATC_ECCFG_1_ENABLEABCHECK_VAL_MAX            (1)
#define ATC_ECCFG_1_ENABLEABCHECK_VAL_DEFAULT        (0)

#define ATC_ECCFG_1_WEAKCELLOPT_VAL_MIN              (0)
#define ATC_ECCFG_1_WEAKCELLOPT_VAL_MAX              (1)
#define ATC_ECCFG_1_WEAKCELLOPT_VAL_DEFAULT          (0)

#define ATC_ECCFG_1_QRXLEVMIN_VAL_MIN                (-156)
#define ATC_ECCFG_1_QRXLEVMIN_VAL_MAX                (0)
#define ATC_ECCFG_1_QRXLEVMIN_VAL_DEFAULT            (0)

#define ATC_ECCFG_1_RESELTOWEAKNCELLOPT_VAL_MIN      (0)
#define ATC_ECCFG_1_RESELTOWEAKNCELLOPT_VAL_MAX      (100)
#define ATC_ECCFG_1_RESELTOWEAKNCELLOPT_VAL_DEFAULT  (0)

#define ATC_ECCFG_1_ATTACHBEARERCID_VAL_MIN          (1)
#define ATC_ECCFG_1_ATTACHBEARERCID_VAL_MAX          (15)
#define ATC_ECCFG_1_ATTACHBEARERCID_VAL_DEFAULT      (1)

#define ATC_ECCFG_1_TCPTPTOPT_VAL_MIN                 0
#define ATC_ECCFG_1_TCPTPTOPT_VAL_MAX                 2
#define ATC_ECCFG_1_TCPTPTOPT_VAL_DEFAULT             (0)

#define ATC_ECCFG_1_ATTACH_WITH_IMSI_CONTROL_VAL_MIN        (0)
#define ATC_ECCFG_1_ATTACH_WITH_IMSI_CONTROL_VAL_MAX        (2)
#define ATC_ECCFG_1_ATTACH_WITH_IMSI_CONTROL_VAL_DEFAULT    (1)

#define ATC_ECCFG_1_POWER_ATTACH_WITHOUT_EIA_VAL_MIN        (0)
#define ATC_ECCFG_1_POWER_ATTACH_WITHOUT_EIA_VAL_MAX        (1)
#define ATC_ECCFG_1_POWER_ATTACH_WITHOUT_EIA_VAL_DEFAULT    (1)


#define ATC_ECCFG_1_DATACOUNTER_VAL_MIN              (0)
#define ATC_ECCFG_1_DATACOUNTER_VAL_MAX              (1)
#define ATC_ECCFG_1_DATACOUNTER_VAL_DEFAULT          (0)

#define ATC_ECCFG_1_UPDATE_LOCI_CTRL_VAL_MIN              (0)
#define ATC_ECCFG_1_UPDATE_LOCI_CTRL_VAL_MAX              (1)
#define ATC_ECCFG_1_UPDATE_LOCI_CTRL_VAL_DEFAULT          (0)

#define ATC_ECCFG_1_ROAM_MODE_VAL_MIN              (1)
#define ATC_ECCFG_1_ROAM_MODE_VAL_MAX              (255)
#define ATC_ECCFG_1_ROAM_MODE_VAL_DEFAULT          (2)
#define ATC_ECCFG_2_ROAM_MODE_EFFECT_VAL_MIN       (0)
#define ATC_ECCFG_2_ROAM_MODE_EFFECT_VAL_MAX       (1)
#define ATC_ECCFG_2_ROAM_MODE_EFFECT_VAL_DEFAULT   (1)

#define ATC_ECCFG_1_SAVE_PLMN_SEL_MODE_VAL_MIN              (0)
#define ATC_ECCFG_1_SAVE_PLMN_SEL_MODE_VAL_MAX              (1)
#define ATC_ECCFG_1_SAVE_PLMN_SEL_MODE_VAL_DEFAULT          (1)

#define ATC_ECCFG_1_EMERGENCY_CAMP_VAL_MIN          (0)
#define ATC_ECCFG_1_EMERGENCY_CAMP_VAL_MAX          (1)
#define ATC_ECCFG_1_EMERGENCY_CAMP_VAL_DEFAULT      (0)

#define ATC_ECCFG_1_ACL_VAL_MIN          (0)
#define ATC_ECCFG_1_ACL_VAL_MAX          (1)
#define ATC_ECCFG_1_ACL_VAL_DEF          (0)

#define ATC_ECCFG_1_PDPREMAP_VAL_MIN        (0)
#define ATC_ECCFG_1_PDPREMAP_VAL_MAX        (2)
#define ATC_ECCFG_1_PDPREMAP_VAL_DEF        (0)

#define ATC_ECCFG_1_PDPREACT_VAL_MIN        (0)
#define ATC_ECCFG_1_PDPREACT_VAL_MAX        (1)
#define ATC_ECCFG_1_PDPREACT_VAL_DEF        (0)

#define ATC_ECCFG_1_UPDATE_FREQ_CTRL_VAL_MIN        (0)
#define ATC_ECCFG_1_UPDATE_FREQ_CTRL_VAL_MAX        (1)
#define ATC_ECCFG_1_UPDATE_FREQ_CTRL_VAL_DEF        (0)

#define ATC_ECCFG_1_QUALITY_FIRST_VAL_MIN        (0)
#define ATC_ECCFG_1_QUALITY_FIRST_VAL_MAX        (1)
#define ATC_ECCFG_1_QUALITY_FIRST_VAL_DEFAULT    (0)

#define ATC_ECCFG_1_STATIC_CONFIG_VAL_MIN        (0)
#define ATC_ECCFG_1_STATIC_CONFIG_VAL_MAX        (1)
#define ATC_ECCFG_1_STATIC_CONFIG_VAL_DEFAULT    (0)


#define ATEC_ECCFG_GET_RSP_STR_LEN   512

/* AT+ECSTATUS */
#define ATC_ECSTATUS_0_MAX_PARM_STR_LEN              16
#define ATC_ECSTATUS_0_MAX_PARM_STR_DEFAULT          NULL


/* AT+ECRMFPLMN */
#define ATC_ECRMFPLMN_0_VAL_MIN                 0
#define ATC_ECRMFPLMN_0_VAL_MAX                 2
#define ATC_ECRMFPLMN_0_VAL_DEFAULT             0

/*AT+ECBCINFO*/
#define ATC_ECBCINFO_0_VAL_MIN                  0
#define ATC_ECBCINFO_0_VAL_MAX                  2
#define ATC_ECBCINFO_0_VAL_DEFAULT              0

#define ATC_ECBCINFO_1_VAL_MIN                  4
#define ATC_ECBCINFO_1_VAL_MAX                  300     /*timeout, MAX: 5 mins*/
#define ATC_ECBCINFO_1_VAL_DEFAULT              8       /*default: 8s*/

#define ATC_ECBCINFO_2_VAL_MIN                  0
#define ATC_ECBCINFO_2_VAL_MAX                  1       /*save_for_later*/
#define ATC_ECBCINFO_2_VAL_DEFAULT              0       /*not need to save*/

#define ATC_ECBCINFO_3_VAL_MIN                  1       /*max_cell_number*/
#define ATC_ECBCINFO_3_VAL_MAX                  7       /*max_cell_number, 1 serving cell + 6 neighber cell */
#define ATC_ECBCINFO_3_VAL_DEFAULT              7

#define ATC_ECBCINFO_4_VAL_MIN                  0       /*report mode, 0 - report in AT response */
#define ATC_ECBCINFO_4_VAL_MAX                  1       /*report mode, 1 - report in URC response */
#define ATC_ECBCINFO_4_VAL_DEFAULT              0



/* AT+CMAR */
#define ATC_CMAR_0_VAL_MIN                   0
#define ATC_CMAR_0_VAL_MAX                   2
#define ATC_CMAR_0_VAL_DEFAULT               0

/* AT+CMOLR */
#define ATC_CMOLR_0_ENABLE_VAL_MIN                      0
#define ATC_CMOLR_0_ENABLE_VAL_MAX                      3
#define ATC_CMOLR_0_ENABLE_VAL_DEFAULT                  0
#define ATC_CMOLR_1_METHOD_VAL_MIN                      0
#define ATC_CMOLR_1_METHOD_VAL_MAX                      6
#define ATC_CMOLR_1_METHOD_VAL_DEFAULT                  0
#define ATC_CMOLR_2_HORACCSET_VAL_MIN                   0
#define ATC_CMOLR_2_HORACCSET_VAL_MAX                   1
#define ATC_CMOLR_2_HORACCSET_VAL_DEFAULT               0
#define ATC_CMOLR_3_HORACC_VAL_MIN                      0
#define ATC_CMOLR_3_HORACC_VAL_MAX                      127
#define ATC_CMOLR_3_HORACC_VAL_DEFAULT                  0
#define ATC_CMOLR_4_VERREQ_VAL_MIN                      0
#define ATC_CMOLR_4_VERREQ_VAL_MAX                      1
#define ATC_CMOLR_4_VERREQ_VAL_DEFAULT                  0
#define ATC_CMOLR_5_VERACCSET_VAL_MIN                   0
#define ATC_CMOLR_5_VERACCSET_VAL_MAX                   1
#define ATC_CMOLR_5_VERACCSET_VAL_DEFAULT               0
#define ATC_CMOLR_6_VERACC_VAL_MIN                      0
#define ATC_CMOLR_6_VERACC_VAL_MAX                      127
#define ATC_CMOLR_6_VERACC_VAL_DEFAULT                  0
#define ATC_CMOLR_7_VELREQ_VAL_MIN                      0
#define ATC_CMOLR_7_VELREQ_VAL_MAX                      4
#define ATC_CMOLR_7_VELREQ_VAL_DEFAULT                  0
#define ATC_CMOLR_8_REQMODE_VAL_MIN                     0
#define ATC_CMOLR_8_REQMODE_VAL_MAX                     1
#define ATC_CMOLR_8_REQMODE_VAL_DEFAULT                 0
#define ATC_CMOLR_9_TIMEOUT_VAL_MIN                     0
#define ATC_CMOLR_9_TIMEOUT_VAL_MAX                     65535
#define ATC_CMOLR_9_TIMEOUT_VAL_DEFAULT                 0
#define ATC_CMOLR_10_INTERVAL_VAL_MIN                   0
#define ATC_CMOLR_10_INTERVAL_VAL_MAX                   65535
#define ATC_CMOLR_10_INTERVAL_VAL_DEFAULT               0
#define ATC_CMOLR_11_SHAPEREQ_VAL_MIN                   1
#define ATC_CMOLR_11_SHAPEREQ_VAL_MAX                   64
#define ATC_CMOLR_11_SHAPEREQ_VAL_DEFAULT               0
#define ATC_CMOLR_12_PLANE_VAL_MIN                      0
#define ATC_CMOLR_12_PLANE_VAL_MAX                      1
#define ATC_CMOLR_12_PLANE_VAL_DEFAULT                  0
#define ATC_CMOLR_13_NMEAREQ_STR_DEFAULT                NULL
#define ATC_CMOLR_13_NMEAREQ_STR_MAX_LEN                16
#define ATC_CMOLR_14_THIRDPARTYADDR_STR_DEFAULT         NULL
#define ATC_CMOLR_14_THIRDPARTYADDR_STR_MAX_LEN         16

/* AT+CMTLR */
#define ATC_CMTLR_0_VAL_MIN                     0
#define ATC_CMTLR_0_VAL_MAX                     3
#define ATC_CMTLR_0_VAL_DEFAULT                 0

/* AT+CMTLRA */
#define ATC_CMTLRA_0_VAL_MIN                    0
#define ATC_CMTLRA_0_VAL_MAX                    1
#define ATC_CMTLRA_0_VAL_DEFAULT                0
#define ATC_CMTLRA_1_VAL_MIN                    0
#define ATC_CMTLRA_1_VAL_MAX                    255
#define ATC_CMTLRA_1_VAL_DEFAULT                0

/*AT+ECSTATIS*/
#define ATC_ESTATIS_0_VAL_MIN                   0
#define ATC_ESTATIS_0_VAL_MAX                   600
#define ATC_ESTATIS_0_VAL_DEFAULT               0

/*AT+ECCGSN*/
#define ATC_ECCGSN_MAX_PARM_STR_LEN             8
#define ATC_ECCGSN_MAX_PARM_STR_DEFAULT         NULL

/* AT+ECPSTEST */
#define ATC_ECPSTEST_VAL_MIN                    0
#define ATC_ECPSTEST_VAL_MAX                    1
#define ATC_ECPSTEST_VAL_DEFAULT                0

/* AT+ECPOWERCLASS */
#define ATC_ECPOWERCLASS_1_VAL_MIN              0
#define ATC_ECPOWERCLASS_1_VAL_MAX              85
#define ATC_ECPOWERCLASS_1_VAL_DEFAULT          0

#define ATC_ECPOWERCLASS_2_VAL_MIN              3
#define ATC_ECPOWERCLASS_2_VAL_MAX              6
#define ATC_ECPOWERCLASS_2_VAL_DEFAULT          3

/* AT+ECEVENTSTATIS */
#define ATC_ECEVENTSTATIS_1_VAL_MIN             0
#define ATC_ECEVENTSTATIS_1_VAL_MAX             2
#define ATC_ECEVENTSTATIS_1_VAL_DEFAULT         0

/* AT+ECNASTCFG */
#define ATC_ECNASTCFG_0_VAL_MIN                 0
#define ATC_ECNASTCFG_0_VAL_MAX                 2
#define ATC_ECNASTCFG_0_VAL_DEF                 (ATC_ECNASTCFG_0_VAL_MIN)

#define ATC_ECNASTCFG_1_VAL_MIN                 0
#define ATC_ECNASTCFG_1_VAL_MAX                 0xFFFFF
#define ATC_ECNASTCFG_1_VAL_DEF                 0

#define ATC_ECNASTCFG_2_VAL_MIN                 0
#define ATC_ECNASTCFG_2_VAL_MAX                 255
#define ATC_ECNASTCFG_2_VAL_DEF                 0

/* AT+ECWIFISCAN */
#define ATC_ECWIFISCAN_0_TIME_VAL_MIN            4000
#define ATC_ECWIFISCAN_0_TIME_VAL_MAX            255000
#define ATC_ECWIFISCAN_0_TIME_VAL_DEF            12000

#define ATC_ECWIFISCAN_1_ROUND_VAL_MIN           1
#define ATC_ECWIFISCAN_1_ROUND_VAL_MAX           3
#define ATC_ECWIFISCAN_1_ROUND_VAL_DEF           1

#define ATC_ECWIFISCAN_2_MAXBSSIDNUM_VAL_MIN     4
#define ATC_ECWIFISCAN_2_MAXBSSIDNUM_VAL_MAX     10
#define ATC_ECWIFISCAN_2_MAXBSSIDNUM_VAL_DEF     5

#define ATC_ECWIFISCAN_3_SCANTIMEOUT_VAL_MIN     1
#define ATC_ECWIFISCAN_3_SCANTIMEOUT_VAL_MAX     255
#define ATC_ECWIFISCAN_3_SCANTIMEOUT_VAL_DEF     5

#define ATC_ECWIFISCAN_4_PRIORITY_VAL_MIN        0   //data preferred
#define ATC_ECWIFISCAN_4_PRIORITY_VAL_MAX        1   //wifiscan preferred
#define ATC_ECWIFISCAN_4_PRIORITY_VAL_DEF        0


CmsRetId  devCFUN(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devECBAND(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devECFREQ(const AtCmdInputContext *pAtCmdReq);
//CmsRetId  devCGSN(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devECCGSN(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devECCGSNLOCK(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devECCFG(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devECRMFPLMN(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devCMAR(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devCMOLR(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devCMTLR(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devCMTLRA(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devECSTATUS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devECSTATIS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devECBCINFO(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devECWIFISCAN(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devECPSTEST(const AtCmdInputContext *pAtCmdReq);
//CmsRetId  devECPOWERCLASS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  devECEVENTSTATIS(const AtCmdInputContext *pAtCmdReq);
//extern void atCmdResetSystem(uint8_t atCid, uint32_t delayMs);


CmsRetId  devECNASTCFG(const AtCmdInputContext *pAtCmdReq);


#endif

