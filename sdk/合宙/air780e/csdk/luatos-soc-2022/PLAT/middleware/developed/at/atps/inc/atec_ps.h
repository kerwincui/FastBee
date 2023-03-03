/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_ps.h
*
*  Description: Macro definition for packet switched service related AT commands
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _ATEC_PS_H
#define _ATEC_PS_H

#define ATC_CID_VAL_MIN                         1
#define ATC_CID_VAL_MAX                         15
#define ATC_CID_VAL_DEFAULT                     1


/* AT+CGCMOD */
#define ATC_CGCMOD_0_CID_VAL_MIN                ATC_CID_VAL_MIN
#define ATC_CGCMOD_0_CID_VAL_MAX                ATC_CID_VAL_MAX
#define ATC_CGCMOD_0_CID_VAL_DEFAULT            ATC_CID_VAL_DEFAULT

/* AT+CGREG */
#define ATC_CGREG_0_VAL_MIN                     0
#define ATC_CGREG_0_VAL_MAX                     2
#define ATC_CGREG_0_VAL_DEFAULT                 0

/* AT+CGATT */
#define ATC_CGATT_0_STATE_VAL_MIN               0
#define ATC_CGATT_0_STATE_VAL_MAX               1
#define ATC_CGATT_0_STATE_VAL_DEFAULT           1  /* attached */

/* AT+CGACT */
#define ATC_CGACT_0_STATE_VAL_MIN               0
#define ATC_CGACT_0_STATE_VAL_MAX               1
#define ATC_CGACT_0_STATE_VAL_DEFAULT           1  /* activated */
#define ATC_CGACT_1_CID_VAL_MIN                 ATC_CID_VAL_MIN
#define ATC_CGACT_1_CID_VAL_MAX                 ATC_CID_VAL_MAX
#define ATC_CGACT_1_CID_VAL_DEFAULT             ATC_CID_VAL_DEFAULT

/* AT+CGDATA */
#define ATC_CGDATA_0_L2P_STR_DEFAULT            "M-PT"
#define ATC_CGDATA_0_L2P_STR_MAX_LEN            16
#define ATC_CGDATA_1_CID_VAL_MIN                ATC_CID_VAL_MIN
#define ATC_CGDATA_1_CID_VAL_MAX                ATC_CID_VAL_MAX
#define ATC_CGDATA_1_CID_VAL_DEFAULT            ATC_CID_VAL_DEFAULT

/* AT+CGDCONT */
#define ATC_CGDCONT_0_CID_VAL_MIN                   ATC_CID_VAL_MIN
#define ATC_CGDCONT_0_CID_VAL_MAX                   ATC_CID_VAL_MAX
#define ATC_CGDCONT_0_CID_VAL_DEFAULT               ATC_CID_VAL_DEFAULT
#define ATC_CGDCONT_1_PDPTYPE_STR_DEFAULT           "IP"
#define ATC_CGDCONT_2_APN_STR_DEFAULT               NULL
#define ATC_CGDCONT_2_APN_STR_MAX_LEN               99      /* readable APN should limited in 99 bytes, as encoded APN max: 100 bytes */
#define ATC_CGDCONT_6_IPV4ADDRALLOC_VAL_MIN         0
#define ATC_CGDCONT_6_IPV4ADDRALLOC_VAL_MAX         0
#define ATC_CGDCONT_6_IPV4ADDRALLOC_VAL_DEFAULT     0
#define ATC_CGDCONT_7_PARA_VAL_MIN                  0
#define ATC_CGDCONT_7_PARA_VAL_MAX                  2
#define ATC_CGDCONT_7_PARA_VAL_DEFAULT              0
#define ATC_CGDCONT_8_PARA_VAL_MIN                  0
#define ATC_CGDCONT_8_PARA_VAL_MAX                  0
#define ATC_CGDCONT_8_PARA_VAL_DEFAULT              0
#define ATC_CGDCONT_9_PARA_VAL_MIN                  0
#define ATC_CGDCONT_9_PARA_VAL_MAX                  0
#define ATC_CGDCONT_9_PARA_VAL_DEFAULT              0
#define ATC_CGDCONT_10_PARA_VAL_MIN                 0
#define ATC_CGDCONT_10_PARA_VAL_MAX                 1
#define ATC_CGDCONT_10_PARA_VAL_DEFAULT             0
#define ATC_CGDCONT_11_PARA_VAL_MIN                 0
#define ATC_CGDCONT_11_PARA_VAL_MAX                 1
#define ATC_CGDCONT_11_PARA_VAL_DEFAULT             0
#define ATC_CGDCONT_12_PARA_VAL_MIN                 0
#define ATC_CGDCONT_12_PARA_VAL_MAX                 1
#define ATC_CGDCONT_12_PARA_VAL_DEFAULT             0
#define ATC_CGDCONT_13_PARA_VAL_MIN                 0
#define ATC_CGDCONT_13_PARA_VAL_MAX                 1
#define ATC_CGDCONT_13_PARA_VAL_DEFAULT             0
#define ATC_CGDCONT_14_PARA_VAL_MIN                 0
#define ATC_CGDCONT_14_PARA_VAL_MAX                 1
#define ATC_CGDCONT_14_PARA_VAL_DEFAULT             0

/* AT+CGDSCONT */
#define ATC_CGDSCONT_0_CID_MIN                      ATC_CID_VAL_MIN
#define ATC_CGDSCONT_0_CID_MAX                      ATC_CID_VAL_MAX
#define ATC_CGDSCONT_0_CID_DEFAULT                  ATC_CID_VAL_DEFAULT
#define ATC_CGDSCONT_1_PRIM_CID_MIN                 ATC_CID_VAL_MIN
#define ATC_CGDSCONT_1_PRIM_CID_MAX                 ATC_CID_VAL_MAX
#define ATC_CGDSCONT_1_PRIM_CID_DEFAULT             ATC_CID_VAL_DEFAULT
#define ATC_CGDSCONT_2_PRIM_DCOMP_MIN               0
#define ATC_CGDSCONT_2_PRIM_DCOMP_MAX               3
#define ATC_CGDSCONT_2_PRIM_DCOMP_DEFAULT           0
#define ATC_CGDSCONT_3_PRIM_HCOMP_MIN               0
#define ATC_CGDSCONT_3_PRIM_HCOMP_MAX               4
#define ATC_CGDSCONT_3_PRIM_HCOMP_DEFAULT           0
#define ATC_CGDSCONT_4_PRIM_IMS_SIG_IND_MIN         0
#define ATC_CGDSCONT_4_PRIM_IMS_SIG_IND_MAX         1
#define ATC_CGDSCONT_4_PRIM_IMS_SIG_IND_DEFAULT     0


/* AT+CGEQOS */
#define ATC_CGEQOS_0_CID_VAL_MIN                    ATC_CID_VAL_MIN
#define ATC_CGEQOS_0_CID_VAL_MAX                    ATC_CID_VAL_MAX
#define ATC_CGEQOS_0_CID_VAL_DEFAULT                ATC_CID_VAL_DEFAULT
#define ATC_CGEQOS_1_QCI_VAL_MIN                    0
#define ATC_CGEQOS_1_QCI_VAL_MAX                    79
#define ATC_CGEQOS_1_QCI_VAL_DEFAULT                0
#define ATC_CGEQOS_2_DLGBR_VAL_MIN                  0
#define ATC_CGEQOS_2_DLGBR_VAL_MAX                  256000
#define ATC_CGEQOS_2_DLGBR_VAL_DEFAULT              0
#define ATC_CGEQOS_3_ULGBR_VAL_MIN                  0
#define ATC_CGEQOS_3_ULGBR_VAL_MAX                  256000
#define ATC_CGEQOS_3_ULGBR_VAL_DEFAULT              0
#define ATC_CGEQOS_4_DLMBR_VAL_MIN                  0
#define ATC_CGEQOS_4_DLMBR_VAL_MAX                  256000
#define ATC_CGEQOS_4_DLMBR_VAL_DEFAULT              0
#define ATC_CGEQOS_5_ULMBR_VAL_MIN                  0
#define ATC_CGEQOS_5_ULMBR_VAL_MAX                  256000
#define ATC_CGEQOS_5_ULMBR_VAL_DEFAULT              0

/* AT+CGEQOSRDP */
#define ATC_CGEQOSRDP_0_CID_VAL_MIN                 ATC_CID_VAL_MIN
#define ATC_CGEQOSRDP_0_CID_VAL_MAX                 ATC_CID_VAL_MAX
#define ATC_CGEQOSRDP_0_CID_VAL_DEFAULT             ATC_CID_VAL_DEFAULT

/* AT+CGCONTRDP */
#define ATC_CGCONTRDP_0_CID_VAL_MIN                 ATC_CID_VAL_MIN
#define ATC_CGCONTRDP_0_CID_VAL_MAX                 ATC_CID_VAL_MAX
#define ATC_CGCONTRDP_0_CID_VAL_DEFAULT             ATC_CID_VAL_DEFAULT

/* AT+CGSCONTRDP */
#define ATC_CGSCONTRDP_0_CID_VAL_MIN                ATC_CID_VAL_MIN
#define ATC_CGSCONTRDP_0_CID_VAL_MAX                ATC_CID_VAL_MAX
#define ATC_CGSCONTRDP_0_CID_VAL_DEFAULT            ATC_CID_VAL_DEFAULT


/* AT+CEREG */
#define ATC_CEREG_0_VAL_MIN                     0
#define ATC_CEREG_0_VAL_MAX                     5
#define ATC_CEREG_0_VAL_DEFAULT                 0

/* AT+CSCON */
#define ATC_CSCON_0_VAL_MIN                     0
#define ATC_CSCON_0_VAL_MAX                     2
#define ATC_CSCON_0_VAL_DEFAULT                 0

/* AT+CGTFT */
#define ATC_CGTFT_0_CID_VAL_MIN                 ATC_CID_VAL_MIN
#define ATC_CGTFT_0_CID_VAL_MAX                 ATC_CID_VAL_MAX
#define ATC_CGTFT_0_CID_VAL_DEFAULT             ATC_CID_VAL_DEFAULT
#define ATC_CGTFT_1_PF_ID_VAL_MIN               1
#define ATC_CGTFT_1_PF_ID_VAL_MAX               16
#define ATC_CGTFT_1_PF_ID_VAL_DEFAULT           1
#define ATC_CGTFT_2_EP_INDEX_VAL_MIN            0
#define ATC_CGTFT_2_EP_INDEX_VAL_MAX            255
#define ATC_CGTFT_2_EP_INDEX_VAL_DEFAULT        0
#define ATC_CGTFT_4_PROTO_ID_VAL_MIN            0
#define ATC_CGTFT_4_PROTO_ID_VAL_MAX            255
#define ATC_CGTFT_4_PROTO_ID_VAL_DEFAULT        0
#define ATC_CGTFT_10_DIRECTION_VAL_MIN          0
#define ATC_CGTFT_10_DIRECTION_VAL_MAX          3
#define ATC_CGTFT_10_DIRECTION_VAL_DEFAULT      0


/* AT+CGTFTRDP */
#define ATC_CGTFTRDP_0_CID_VAL_MIN              ATC_CID_VAL_MIN
#define ATC_CGTFTRDP_0_CID_VAL_MAX              ATC_CID_VAL_MAX
#define ATC_CGTFTRDP_0_CID_VAL_DEFAULT          ATC_CID_VAL_DEFAULT

/* AT+CSODCP */
#define ATC_CSODCP_0_CID_VAL_MIN                    0   /* as some equipment send CID = 0, which act as the initial PDP */
#define ATC_CSODCP_0_CID_VAL_MAX                    ATC_CID_VAL_MAX
#define ATC_CSODCP_0_CID_VAL_DEFAULT                ATC_CID_VAL_DEFAULT
#define ATC_CSODCP_1_CPD_VAL_MIN                    1
#define ATC_CSODCP_1_CPD_VAL_MAX                    950
#define ATC_CSODCP_1_CPD_VAL_DEFAULT                24
#define ATC_CSODCP_2_CPDATA_STR_MAX_LEN             (ATC_CSODCP_1_CPD_VAL_MAX*2+1)
#define ATC_CSODCP_2_CPDATA_STR_DEFAULT             NULL
#define ATC_CSODCP_3_RAI_VAL_MIN                    0
#define ATC_CSODCP_3_RAI_VAL_MAX                    2
#define ATC_CSODCP_3_RAI_VAL_DEFAULT                0   /*RAI: No information available*/
#define ATC_CSODCP_4_TYPE_VAL_MIN                   0
#define ATC_CSODCP_4_TYPE_VAL_MAX                   1   /*Regular data*/
#define ATC_CSODCP_4_TYPE_VAL_DEFAULT               0

/* AT+ECATTBEARER */


/* AT+CRTDCP */
#define ATC_CRTDCP_0_VAL_MIN                            0
#define ATC_CRTDCP_0_VAL_MAX                            2
#define ATC_CRTDCP_0_VAL_DEFAULT                        0

/* AT+CGAUTH */
#define ATC_CGAUTH_0_CID_VAL_MIN                        ATC_CID_VAL_MIN
#define ATC_CGAUTH_0_CID_VAL_MAX                        ATC_CID_VAL_MAX
#define ATC_CGAUTH_0_CID_VAL_DEFAULT                    ATC_CID_VAL_DEFAULT
#define ATC_CGAUTH_1_AUTHPROT_VAL_MIN                   0
#define ATC_CGAUTH_1_AUTHPROT_VAL_MAX                   2
#define ATC_CGAUTH_1_AUTHPROT_VAL_DEFAULT               0
#define ATC_CGAUTH_2_USER_STR_MAX_LEN                   64
#define ATC_CGAUTH_2_USER_STR_DEFAULT                   NULL
#define ATC_CGAUTH_3_PASSWD_STR_MAX_LEN                 64
#define ATC_CGAUTH_3_PASSWD_STR_DEFAULT                 NULL

/* AT+CIPCA */
#define ATC_CIPCA_0_VAL_MIN                             3
#define ATC_CIPCA_0_VAL_MAX                             3
#define ATC_CIPCA_0_VAL_DEFAULT                         3
#define ATC_CIPCA_1_ATT_VAL_MIN                         0
#define ATC_CIPCA_1_ATT_VAL_MAX                         1
#define ATC_CIPCA_1_ATT_VAL_DEFAULT                     0

/* AT+CGAPNRC */
#define ATC_CGAPNRC_0_CID_VAL_MIN                       ATC_CID_VAL_MIN
#define ATC_CGAPNRC_0_CID_VAL_MAX                       ATC_CID_VAL_MAX
#define ATC_CGAPNRC_0_CID_VAL_DEFAULT                   ATC_CID_VAL_DEFAULT

/* AT+CGEREP */
#define ATC_CGEREP_0_VAL_MIN                            0
#define ATC_CGEREP_0_VAL_MAX                            1
#define ATC_CGEREP_0_VAL_DEFAULT                        0
#define ATC_CGEREP_1_VAL_MIN                            0
#define ATC_CGEREP_1_VAL_MAX                            0
#define ATC_CGEREP_1_VAL_DEFAULT                        0


/* AT+ECSENDDATA */
#define ATC_ECSENDDATA_0_CID_VAL_MIN                    ATC_CID_VAL_MIN
#define ATC_ECSENDDATA_0_CID_VAL_MAX                    ATC_CID_VAL_MAX
#define ATC_ECSENDDATA_0_CID_VAL_DEFAULT                ATC_CID_VAL_DEFAULT
#define ATC_ECSENDDATA_1_DATALEN_VAL_MIN                1
#define ATC_ECSENDDATA_1_DATALEN_VAL_MAX                950
#define ATC_ECSENDDATA_1_DATALEN_VAL_DEFAULT            24
#define ATC_ECSENDDATA_2_DATA_STR_MAX_LEN               (ATC_ECSENDDATA_1_DATALEN_VAL_MAX*2+1)
#define ATC_ECSENDDATA_2_DATA_STR_DEFAULT               NULL
#define ATC_ECSENDDATA_3_RAI_VAL_MIN                    0
#define ATC_ECSENDDATA_3_RAI_VAL_MAX                    2
#define ATC_ECSENDDATA_3_RAI_VAL_DEFAULT                0   /*RAI: No information available*/
#define ATC_ECSENDDATA_4_TYPE_VAL_MIN                   0
#define ATC_ECSENDDATA_4_TYPE_VAL_MAX                   1
#define ATC_ECSENDDATA_4_TYPE_VAL_DEFAULT               0   /*Regular data*/

/* AT+ECCIOTPLANE */
#define ATC_ECCIOTPLANE_0_PLANE_VAL_MIN                 0
#define ATC_ECCIOTPLANE_0_PLANE_VAL_MAX                 2
#define ATC_ECCIOTPLANE_0_PLANE_VAL_DEFAULT             0

/* AT+ECNBIOTRAI */
#define ATC_ECNBIOTRAI_0_RAI_VAL_MIN                    0
#define ATC_ECNBIOTRAI_0_RAI_VAL_MAX                    1
#define ATC_ECNBIOTRAI_0_RAI_VAL_DEFAULT                0

/* AT+CGPADDR */
#define ATC_CGPADDR_0_CID_VAL_MIN                       ATC_CID_VAL_MIN
#define ATC_CGPADDR_0_CID_VAL_MAX                       ATC_CID_VAL_MAX
#define ATC_CGPADDR_0_CID_VAL_DEFAULT                   ATC_CID_VAL_DEFAULT

/* AT+CSCON */
#define ATC_CSCON_0_STATE_VAL_MIN                       0
#define ATC_CSCON_0_STATE_VAL_MAX                       1
#define ATC_CSCON_0_STATE_VAL_DEFAULT                   0  /* disable indication */

/* AT+CEMODE */
#define ATC_CEMODE_VAL_MIN                      0
#define ATC_CEMODE_VAL_MAX                      3
#define ATC_CEMODE_VAL_DEFAULT                  0


/* AT+CPSDO */
#define ATC_CPSDO_VAL_MIN                       0
#define ATC_CPSDO_VAL_MAX                       1
#define ATC_CPSDO_VAL_DEFAULT                   0


/* AT+ECGDCNT */
#define ATC_ECGDCNT_0_VAL_MIN                   0
#define ATC_ECGDCNT_0_VAL_MAX                   1
#define ATC_ECGDCNT_0_VAL_DEFAULT               0

/* AT+ECAUGDCNT */
#define ATC_ECAUGDCNT_0_VAL_MIN                   0
#define ATC_ECAUGDCNT_0_VAL_MAX                   65535
#define ATC_ECAUGDCNT_0_VAL_DEFAULT               0

/* AT+ECSCLKEX */
#define ATC_ECSCLKEX_0_VAL_MIN                   0
#define ATC_ECSCLKEX_0_VAL_MAX                   1
#define ATC_ECSCLKEX_0_VAL_DEFAULT               0
#define ATC_ECSCLKEX_1_VAL_MIN                   1
#define ATC_ECSCLKEX_1_VAL_MAX                   50
#define ATC_ECSCLKEX_1_VAL_DEFAULT               3
#define ATC_ECSCLKEX_2_VAL_MIN                   1
#define ATC_ECSCLKEX_2_VAL_MAX                   600
#define ATC_ECSCLKEX_2_VAL_DEFAULT               30


/*
 * +CGEREP=[<mode>[,<bfr>]]
 * <mode>: integer type
 *   0 buffer unsolicited result codes in the MT; if MT result code buffer is full, the oldest ones can be discarded.
 *     No codes are forwarded to the TE.
 *   1 discard unsolicited result codes when MT-TE link is reserved (e.g. in on-line data mode); otherwise forward
 *     them directly to the TE
 *   2 buffer unsolicited result codes in the MT when MT-TE link is reserved (e.g. in on-line data mode) and flush
 *     them to the TE when MT-TE link becomes available; otherwise forward them directly to the TE; - NOT SUPPORT
*/
typedef enum AtcCGEREPMode_Enum
{
    ATC_CGEREP_DISCARD_OLD_CGEV = 0,
    ATC_CGEREP_FWD_CGEV
}AtcCGEREPMode;



/*
 * <n>: integer type
 * 0 disable unsolicited result code
 * 1 enable unsolicited result code +CSCON: <mode>
 * 2 enable unsolicited result code +CSCON: <mode>[,<state>]
 * 3 enable unsolicited result code +CSCON: <mode>[,<state>[,<access>]]
*/
typedef enum AtcCSCONRptLevel_Enum
{
    ATC_DISABLE_CSCON_RPT = 0,
    ATC_CSCON_RPT_MODE,
    ATC_CSCON_RPT_MODE_STATE,
    ATC_CSCON_RPT_MODE_STATE_ACCESS
}AtcCSCONRptLevel;


CmsRetId  psCGDCONT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGATT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGACT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGDATA(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGDSCONT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGCMOD(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGEQOS(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGEQOSRDP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGCONTRDP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCEREG(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCSCON(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGTFT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCSODCP(const AtCmdInputContext *pAtCmdReq);
//CmsRetId  psECATTBEARER(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCRTDCP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGAUTH(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCIPCA(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGEREP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGAPNRC(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psECSENDDATA(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psECCIOTPLANE(const AtCmdInputContext *pAtCmdReq);
//CmsRetId  psECNBIOTRAI(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGPADDR(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCNMPSD(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCEER(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCEMODE(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGTFTRDP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCPSDO(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psCGSCONTRDP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psECGDCNT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psECAUGDCNT(const AtCmdInputContext *pAtCmdReq);
CmsRetId  psECSCLKEX(const AtCmdInputContext *pAtCmdReq);



#endif

