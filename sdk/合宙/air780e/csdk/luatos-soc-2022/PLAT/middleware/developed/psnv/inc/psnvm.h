#ifndef __PS_NVM_H__
#define __PS_NVM_H__
/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017- Copyrights of AirM2M Ltd.
 File name:      - psnvm.h
 Description:    - Protocol Stack NVM files
 History:        - 13/09/2020, Originated by Jason
 ******************************************************************************
******************************************************************************/
#include "pssys.h"
#include "psnvmutil.h"
#include "pscommtype.h"


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/



/******************************************************************************
 ******************************************************************************
 * DEFINE each NVM DATA structure, and related version here.
 ******************************************************************************
******************************************************************************/


/******************************************************************************
 * CESM PDP config NVM
******************************************************************************/

#define CUR_CESM_PDP_CONFIG_NVM_VER     0x00



/*
 * PDP defination/config, set by AT+CGDCONT, or AT+CGAUTH
 * +CGDCONT=[<cid>[,<PDP_type>[,<APN>[,<PDP_addr>[,<d_comp>[,<h_comp>[,<IPv4AddrAlloc>[,<request_type>
 *           [,<PCSCF_discovery>[,<IM_CN_Signalling_Flag_Ind>[,<NSLPI>[,<securePCO>[,<IPv4_MTU_discovery>
 *           [,<Local_Addr_Ind>[,<NonIP_MTU_discovery>[,<Reliable_Data_Service>[,<SSC_mode>[,<SNSSAI>
 *           [,<Pref_access_type>[,<RQoS_ind>[,<MH6-PDU>[,<Alwayson_req>]]]]]]]]]]]]]]]]]]]]]]
*/
typedef struct _EPAT_CesmPdpDefinition_tag
{
    UINT32  ipv4AlloTypePresent : 1;
    UINT32  reqTypePresent      : 1;
    UINT32  pcscfDisTypePresent : 1;    /* "pcscfDisType" only support set to 0 */
    UINT32  imCnSigFlagPresent  : 1;    /* "imCnSigFlag" only support set to 0 */
    UINT32  NSLPIPresent        : 1;
    UINT32  secPcoPresent       : 1;
    UINT32  ipv4MtuDisTypePresent : 1;
    UINT32  localAddrIndPresent : 1;    /* "localAddrInd" only support set to 0 */

    UINT32  nonIpMtuDisTypePresent : 1;
    UINT32  RDSPresent          : 1;    /* "reliableDataSrv" only support set to 0 */
    UINT32  rsvd0_val0          : 22;   /* rsvd set to 0 */


    UINT8   pdnIpType;          /* PdnType
                                 * 1-PDN_IP_V4, 2-PDN_IP_V6, 3-PDN_IP_V4V6, 4-PDN_UNUSED, 5-NONIP
                                */
    UINT8   ipv4AlloType;       /* CmiPsIpv4AllocType
                                 * 0 - IPv4 address allocation through NAS signalling
                                 * 1 - IPv4 address allocation through DHCP - not support now
                                */
    UINT8   reqType;            /* CmiPsBearerReqType
                                 * 0 - PDP context is for new PDP context establishment or for handover from a non-3GPP access network
                                 * 1 - PDP context is for emergency bearer, - not support now
                                 * 2 - PDP context is for new PDP context establishment
                                 * 3 - PDP context is for handover from a non-3GPP access network, - not support
                                 * 4 - PDP context is for handover of emergency bearer services from a non-3GPP, - not support
                                */
    UINT8   apnLength;          /* 0 - apn is not present */
    UINT8   apnStr[PS_APN_MAX_LEN];     /* apn string, in fact MAX: 99 bytes,
                                         * 1> readable format, example: cmnbiot.mnc004.mcc460.gprs
                                         * 2> not: 7"cmnbiot"6"mnc004"6"mcc460"4"gprs"
                                        */

    /* "PDP_addr" is ignored with the set command */
    /* "d_comp" & "h_comp" is for 2/3G, don't need */

    UINT8   pcscfDisType;       /* 0 - Preference of P-CSCF address discovery not influenced
                                 * 1 - Preference of P-CSCF address discovery through NAS signalling, - not support
                                 * 2- Preference of P-CSCF address discovery through DHCP, - not support now
                                 */
    UINT8   imCnSigFlag;        /* 0 - UE indicates that the PDP context is not for IM CN subsystem-related signalling only
                                 * 1 - UE indicates that the PDP context is for IM CN subsystem-related signalling only, - not support
                                */
    UINT8   NSLPI;              /* CmiPsNSLPICfg,
                                 * 0 - low priority indicator configured in the MT, set from USIM
                                 * 1 - low priority indicator set to "MS is not configured for NAS signalling low priority".
                                */
    UINT8   secPco;             /* 0 - Security protected transmission of PCO is not requested
                                 * 1 - Security protected transmission of PCO is requested
                                 * Note, if set to 1, eitf flag should be set to 1, if this bearer used as attached bearer
                                */

    UINT8   ipv4MtuDisType;     /* 0 - Preference of IPv4 MTU size discovery not influenced by +CGDCONT
                                 * 1 - Preference of IPv4 MTU size discovery through NAS signalling
                                */
    UINT8   localAddrInd;       /* 0 - indicates that the MS does not support local IP address in TFTs
                                 * 1 - indicates that the MS supports local IP address in TFTs, - not support
                                */
    UINT8   nonIpMtuDisType;    /* 0 - Preference of Non-IP MTU size discovery not influenced by +CGDCONT
                                 * 1 - Preference of Non-IP MTU size discovery through NAS signalling
                                */
    UINT8   RDS;                /*
                                 * 0 - Reliable Data Service is not being used for the PDN connection
                                 * 1 - Reliable Data Service is being used for the PDN connection, - not support
                                */

    UINT32  rsvd2_val0;         /* reserved for extension */
    UINT32  rsvd3_val0;
}CesmPdpDefinition;     //124 bytes

/* NVM ID: PS_CESM_PDP_CONFIG_NVM, filename: cesmpdpconfig.nvm */
typedef struct _NVM_EPAT_cesmpdpconfig
{
    UINT16              defCidBitmap;       /* which CID PDP is defined, 0 - not defined, 1 - defined
                                             * 1> example: 00000000 00000010, means CID 1 is defined
                                             * 2> MAX 11 PDP defined, not allow > 11
                                            */
    UINT16              rsvd;
    CesmPdpDefinition   pdpDefinition[PS_PDP_CID_NUM];  /* index by CID, size: 124*16 = 1984 */
}CesmNvmPdpConfig;      /* Whole NVM should limited in 4KB */



/*
 * AT+CGAUTH=<cid>[,<auth_prot>[,<userid>[,<password>]]]
*/
#define CUR_CESM_PDP_AUTH_CONFIG_NVM_VER    0x00

typedef struct _EPAT_CesmPdpAuthDefinition_Tag
{

    UINT8   authType;           /* PcoSecurityProtocol
                                 * 0 - NULL; 1 - PAP; 2 - CHAP ,3- PREFER CHAP, change to PAP when CHAP auth failed
                                */
    UINT8   rsvd1_val0;
    UINT8   userNameLen;
    UINT8   pwdLen;
    UINT8   userName[CESM_MAX_AUTH_STR_LEN];
    UINT8   pwd[CESM_MAX_AUTH_STR_LEN];

    UINT32  rsvd2_val0;         /* reserved for extension */
    UINT32  rsvd3_val0;
}CesmPdpAuthDefinition; //140 bytes

/* NVM ID: PS_CESM_PDP_AUTH_CONFIG_NVM, filename: cesmpdpauthconfig.nvm */
typedef struct _NVM_EPAT_cesmpdpauthconfig
{
    UINT16              cidBitmap;          /* which CID PDP is defined, 0 - not defined, 1 - defined
                                             * 1> example: 00000000 00000010, means CID 1 is defined
                                             * 2> MAX 11 PDP defined, not allow > 11
                                            */
    UINT16              rsvd;
    CesmPdpAuthDefinition   pdpAuth[PS_PDP_CID_NUM];  /* index by CID, size: 140*16 = 2240 */
}CesmNvmPdpAuthConfig;      /* Whole NVM should limited in 4KB */



/******************************************************************************
 *****************************************************************************
 * Functions
 *****************************************************************************
******************************************************************************/

/*
 * if attach bearer/PDP context is not defined in NVM: "cesmpdpconfig.nvm", use this IP type
*/
PdnType PsGetDefaultAttachBearerIpType(void);


#endif

