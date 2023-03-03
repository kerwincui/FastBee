/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_sim.h
*
*  Description: Process SIM related AT commands
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _ATEC_SIM_H
#define _ATEC_SIM_H

/* AT+CRSM */
#define ATC_CRSM_0_CMD_VAL_MIN                   0
#define ATC_CRSM_0_CMD_VAL_MAX                   255
#define ATC_CRSM_0_CMD_VAL_DEFAULT               0
#define ATC_CRSM_1_FILEID_VAL_MIN                  0
#define ATC_CRSM_1_FILEID_VAL_MAX                  0x7FFF
#define ATC_CRSM_1_FILEID_VAL_DEFAULT             0
#define ATC_CRSM_2_P1_VAL_MIN                    0
#define ATC_CRSM_2_P1_VAL_MAX                    255
#define ATC_CRSM_2_P1_VAL_DEFAULT                0
#define ATC_CRSM_3_P2_VAL_MIN                   0
#define ATC_CRSM_3_P2_VAL_MAX                   255
#define ATC_CRSM_3_P2_VAL_DEFAULT               0
#define ATC_CRSM_4_P3_VAL_MIN                     0
#define ATC_CRSM_4_P3_VAL_MAX                     255
#define ATC_CRSM_4_P3_VAL_DEFAULT                 0
#define ATC_CRSM_5_DATA_STR_MAX_LEN             512
#define ATC_CRSM_5_DATA_STR_DEFAULT             NULL
#define ATC_CRSM_6_PATH_STR_MAX_LEN               8
#define ATC_CRSM_6_PATH_STR_DEFAULT               NULL

/* AT+CSIM */
#define ATC_CSIM_0_VAL_MIN                   8
#define ATC_CSIM_0_VAL_MAX                   522
#define ATC_CSIM_0_VAL_DEFAULT               0
#define ATC_CSIM_1_CMD_STR_MAX_LEN           522
#define ATC_CSIM_1_CMD_STR_DEFAULT           NULL

/* AT+CPIN */
#define ATC_CPIN_0_PIN_STR_MAX_LEN              8
#define ATC_CPIN_0_PIN_STR_MIN_LEN              4
#define ATC_CPIN_0_PIN_STR_DEFAULT              NULL
#define ATC_CPIN_1_NEWPIN_STR_MAX_LEN           8
#define ATC_CPIN_1_NEWPIN_STR_MIN_LEN           4
#define ATC_CPIN_1_NEWPIN_STR_DEFAULT           NULL

/* AT+CPWD */
#define ATC_CPWD_0_FAC_STR_MAX_LEN              2
#define ATC_CPWD_0_FAC_STR_DEFAULT              NULL
#define ATC_CPWD_1_OLDPIN_STR_MAX_LEN              8
#define ATC_CPWD_1_OLDPIN_STR_MIN_LEN              4
#define ATC_CPWD_1_OLDPIN_STR_DEFAULT              NULL
#define ATC_CPWD_2_NEWPIN_STR_MAX_LEN           8
#define ATC_CPWD_2_NEWPIN_STR_MIN_LEN           4
#define ATC_CPWD_2_NEWPIN_STR_DEFAULT           NULL

/* AT+CLCK */
#define ATC_CLCK_0_FAC_STR_MAX_LEN            2
#define ATC_CLCK_0_FAC_STR_DEFAULT            NULL
#define ATC_CLCK_1_MODE_VAL_MIN                  0
#define ATC_CLCK_1_MODE_VAL_MAX                  2
#define ATC_CLCK_1_MODE_VAL_DEFAULT              0
#define ATC_CLCK_2_PIN_STR_MAX_LEN            8
#define ATC_CLCK_2_PIN_STR_MIN_LEN            4
#define ATC_CLCK_2_PIN_STR_DEFAULT            NULL

/* AT+CPINR */
#define ATC_CPINR_0_MAX_PARM_STR_LEN                 16
#define ATC_CPINR_0_MAX_PARM_STR_DEFAULT             NULL

/* AT+CSUS */
#define ATC_CSUS_0_VAL_MIN                   0
#define ATC_CSUS_0_VAL_MAX                   2
#define ATC_CSUS_0_VAL_DEFAULT               0

/* AT+CCHO */
#define ATC_CCHO_0_STR_MAX_LEN            32
#define ATC_CCHO_0_STR_DEFAULT            NULL

/* AT+CCHC */
#define ATC_CCHC_0_VAL_MIN                   1
#define ATC_CCHC_0_VAL_MAX                   19
#define ATC_CCHC_0_VAL_DEFAULT               0

/* AT+CGLA */
#define ATC_CGLA_0_VAL_MIN                   1
#define ATC_CGLA_0_VAL_MAX                   19
#define ATC_CGLA_0_VAL_DEFAULT               0
#define ATC_CGLA_1_VAL_MIN                   8
#define ATC_CGLA_1_VAL_MAX                   522
#define ATC_CGLA_1_VAL_DEFAULT               0
#define ATC_CGLA_2_STR_MAX_LEN            522
#define ATC_CGLA_2_STR_DEFAULT            NULL

/* AT+ECSIMSLEEP */
#define ATC_ECSIMSLEEP_0_VAL_MIN                   0
#define ATC_ECSIMSLEEP_0_VAL_MAX                   1
#define ATC_ECSIMSLEEP_0_VAL_DEFAULT               1

/* AT+ECSWC */
#define ATC_ECSWC_0_VAL_MIN                   0
#define ATC_ECSWC_0_VAL_MAX                   3
#define ATC_ECSWC_0_VAL_DEFAULT               0

/* AT+ECSIMPD */
#define ATC_ECSIMPD_0_VAL_MIN                   0
#define ATC_ECSIMPD_0_VAL_MAX                   1
#define ATC_ECSIMPD_0_VAL_DEFAULT               0

/* AT+ECUSATP */
#define ATC_ECUSATP_0_VAL_MIN                   64
#define ATC_ECUSATP_0_VAL_MAX                   78
#define ATC_ECUSATP_0_VAL_DEFAULT               0
#define ATC_ECUSATP_1_CMD_STR_MAX_LEN           78
#define ATC_ECUSATP_1_CMD_STR_DEFAULT           NULL

/* AT+ECSIMCFG */
#define ECSIMCFG_MAX_SET_PARAMS_NUM    16 //limit input parameter number <= 16
#define ATC_ECSIMCFG_0_MAX_PARM_STR_LEN                 32
#define ATC_ECSIMCFG_0_MAX_PARM_STR_DEFAULT             NULL
#define ATC_ECSIMCFG_1_SIMSIMULATOR_VAL_MIN            0
#define ATC_ECSIMCFG_1_SIMSIMULATOR_VAL_MAX            1
#define ATC_ECSIMCFG_1_SIMSIMULATOR_VAL_DEFAULT        (-1)
#define ATC_ECSIMCFG_1_SOFTSIM_VAL_MIN                  0
#define ATC_ECSIMCFG_1_SOFTSIM_VAL_MAX                  1
#define ATC_ECSIMCFG_1_SOFTSIM_VAL_DEFAULT              (-1)
#define ATC_ECSIMCFG_1_SIMPOWERSAVE_VAL_MIN                  0
#define ATC_ECSIMCFG_1_SIMPOWERSAVE_VAL_MAX                  1
#define ATC_ECSIMCFG_1_SIMPOWERSAVE_VAL_DEFAULT              (-1)
#define ATC_ECSIMCFG_1_SIMPRESENCEDETECT_VAL_MIN                  0
#define ATC_ECSIMCFG_1_SIMPRESENCEDETECT_VAL_MAX                  1
#define ATC_ECSIMCFG_1_SIMPRESENCEDETECT_VAL_DEFAULT              (-1)
#define ATC_ECSIMCFG_1_SIMSLOT_VAL_MIN                  0
#define ATC_ECSIMCFG_1_SIMSLOT_VAL_MAX                  1
#define ATC_ECSIMCFG_1_SIMSLOT_VAL_DEFAULT              0


/* AT+CPOL */
#define ATC_CPOL_0_INDEX_VAL_MIN                   1
#define ATC_CPOL_0_INDEX_VAL_MAX                   500
#define ATC_CPOL_0_INDEX_VAL_DEFAULT               0
#define ATC_CPOL_1_FORMAT_VAL_MIN                   0
#define ATC_CPOL_1_FORMAT_VAL_MAX                   2
#define ATC_CPOL_1_FORMAT_VAL_DEFAULT              0xFF
#define ATC_CPOL_2_OPERN_STR_MAX_LEN                16
#define ATC_CPOL_2_OPERN_STR_DEFAULT                NULL
#define ATC_CPOL_3_GSMACT_VAL_MIN                   0
#define ATC_CPOL_3_GSMACT_VAL_MAX                   1
#define ATC_CPOL_3_GSMACT_VAL_DEFAULT               0
#define ATC_CPOL_4_GSMCACT_VAL_MIN                   0
#define ATC_CPOL_4_GSMCACT_VAL_MAX                   1
#define ATC_CPOL_4_GSMCACT_VAL_DEFAULT               0
#define ATC_CPOL_5_UTRANACT_VAL_MIN                   0
#define ATC_CPOL_5_UTRANACT_VAL_MAX                   1
#define ATC_CPOL_5_UTRANACT_VAL_DEFAULT               0
#define ATC_CPOL_6_EUTRANACT_VAL_MIN                   0
#define ATC_CPOL_6_EUTRANACT_VAL_MAX                   1
#define ATC_CPOL_6_EUTRANACT_VAL_DEFAULT               0


/* AT+CPLS */
#define ATC_CPLS_0_LIST_VAL_MIN                   0
#define ATC_CPLS_0_LIST_VAL_MAX                   2
#define ATC_CPLS_0_LIST_VAL_DEFAULT               0


CmsRetId  simCPIN(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simCPWD(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simCSIM(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simCRSM(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simCIMI(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simECICCID(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simCLCK(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simCPINR(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simCSUS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simCCHO(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simCCHC(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simCGLA(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simECSIMSLEEP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simECSWC(const AtCmdInputContext *pAtCmdReq);
//CmsRetId  simECSIMPD(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simCNUM(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simECUSATP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simECSIMCFG(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simECSIMRM(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simCPOL(const AtCmdInputContext *pAtCmdReq);
CmsRetId  simCPLS(const AtCmdInputContext *pAtCmdReq);


#endif

