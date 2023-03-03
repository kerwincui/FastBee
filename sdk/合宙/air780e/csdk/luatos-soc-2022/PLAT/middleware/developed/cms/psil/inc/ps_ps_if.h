/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: ps_ps_if.h
 *
 *  Description: API interface for PS service
 *
 *  History:
 *
 *  Notes:
 *
******************************************************************************/
#ifndef __PS_PS_IF_H__
#define __PS_PS_IF_H__
#include "networkmgr.h"
#include "cmicomm.h"
#include "cmips.h"
#include "cms_util.h"


/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/

#define PSIL_PS_PDP_IP_V6_SIZE          128
#define PSIL_PS_PDP_IPV4_SIZE           16
#define PSIL_IPV4_SUBNETMUX_MAX_LEN     32


/******************************************************************************
 *****************************************************************************
 * ENUM
 *****************************************************************************
******************************************************************************/


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/


/******************************************************************************
 *****************************************************************************
 * API
 *****************************************************************************
******************************************************************************/
CmsRetId psDeleteCGDCONTContext(UINT32 atHandle, UINT32 dwContextID);
CmsRetId psSetAttachState(UINT32 atHandle, BOOL fAttached);
CmsRetId psGetAttachState(UINT32 atHandle);
CmsRetId psSetCGACT(UINT32 atHandle, INT32 cid, INT32 state);
CmsRetId psEnterDataState(UINT32 atHandle, UINT8 cid);

CmsRetId psSetCdgcont (UINT32 atHandle, CmiPsDefPdpDefinition* ctxInfo);
CmsRetId psGetCGCONTRDPParam(UINT32 atHandle, UINT32 cid);
CmsRetId psGetAllCGCONTRDPParam(UINT32 atHandle);
CmsRetId psQueryERegOption(UINT32 atHandle);
CmsRetId psGetERegStatus(UINT32 atHandle);
CmsRetId psGetCGTFT(UINT32 atHandle);
CmsRetId psDeleteTft(UINT32 atHandle, INT32 cid);
CmsRetId psSetTftFilter(UINT32 atHandle, const CmiPsPacketFilter *tftFilter);
CmsRetId psSendUserData(UINT32 atHandle, INT32 cid, INT32 dataStrLen, UINT8 *pStrdata, INT32 rai, INT32 typeOfUserData, BOOL isCSODCP);
CmsRetId psSetAttBear(UINT32 atHandle, AttachedBearCtxPreSetParam * param);
CmsRetId psGetATTBEAR(UINT32 atHandle);
CmsRetId psModBearerCtxReq (UINT32 atHandle, UINT32 cid);
CmsRetId psGetCGDCONTCid (UINT32 atHandle);
CmsRetId psSetCGEQOSQualityService (UINT32 atHandle, const CmiPsEpsQosParams* params);
CmsRetId psDeleteCGEQOSQualityService (UINT32 atHandle, UINT32 cid);
CmsRetId psGetCGEQOSQualityService (UINT32 atHandle);
CmsRetId psSetCGEQOSRDPQualityService(UINT32 atHandle, UINT32 cid, BOOL bGetAll);
CmsRetId psSetRTDCP(UINT32 atHandle, INT32 reporting);
CmsRetId psGetCurRTDCP(UINT32 atHandle);
CmsRetId psSetCGAUTH( UINT32 atHandle,CmiPsSetDefineAuthCtxReq *pSetDefinedAuthReq);
CmsRetId psGetCGAUTH(UINT32 atHandle);
CmsRetId psSetCIPCA(UINT32 atHandle,INT32 n,INT32 attach);
CmsRetId psGetCIPCA(UINT32 atHandle);
CmsRetId psGetCGAPNRC(UINT32 atHandle, INT32 cid, BOOL bGetAll);
CmsRetId psSetECCIOTPLANE(UINT32 atHandle,INT32 plane);
CmsRetId psGetPDPAddr(UINT32 atHandle, INT32 cid, BOOL bGetAll);
CmsRetId psGetCSCON(UINT32 atHandle);
CmsRetId psSendNoMorePsDataReq(UINT32 atHandle);
CmsRetId psGetCEER(UINT32 atHandle);
CmsRetId psSetCemode(UINT32 atHandle, UINT8 ceMode);
CmsRetId psGetCemode(UINT32 atHandle);
CmsRetId psGetAllBrsCidsInfo(UINT32 atHandle, CmiPsGetAllCidsInfoCmd reqCmd);

void psSetNetMaskStr(UINT8 addrType, int subnetMaskLen, char *maskStr);
void psUint8IpAddrToStr(UINT8 addrType, UINT8 *valData, CHAR *ippStr);
void psUint8Ipv4AddrToStr(UINT8 *addrData, CHAR *ippStr);
void psUint8Ipv6AddrToStr(UINT8 addrType, UINT8 *ipUint8Addr, CHAR *ippStr);

void psPdpTypeToStr(UINT8 pdpType, char  *typeStr);

CmsRetId psParseIpAddrAndMaskFromStr(CmiIpAddr *pCmiIp, const UINT8 *pIpStr);
CmsRetId psParsePfPortInfoFromStr(CmiPsPfPortInfo *pPfPortInfo, const UINT8 *pIpStr);
CmsRetId psParseTosMaskFromStr(CmiPsTosMask *pTosMask, const UINT8 *pStr);

BOOL psBeAllZero(const UINT8 *ArrayName, UINT8 Length);
CmsRetId psGetCGDSCONTCid (UINT32 atHandle);
CmsRetId psDeleteCGDedDCONTContext (UINT32 atHandle, UINT32 delCid);
CmsRetId psSetDedCdgCont (UINT32 atHandle, DefineDedBearerCtxInfo* ctxInfo);
CmsRetId psGetCGTFTRDPParam(UINT32 atHandle, UINT32 cid);
CmsRetId psGetAllCGTFTRDPParam(UINT32 atHandle) ;
CmsRetId psGetCPSDO(UINT32 atHandle);
CmsRetId psSetCPSDO(UINT32 atHandle, UINT8 status);
CmsRetId psSetModDedHandSkResultReq(UINT32 atHandle, UINT8 cid,UINT8 result);
CmsRetId psSetActDedHandSkResultReq(UINT32 atHandle, UINT8 cid,UINT8 result);
BOOL psParseDisplayApnName(const UINT8 *srcApn,UINT8 *destApn,UINT16 destMaxSize, UINT16 len, UINT8 *outlen);
CmsRetId psGetCGSCONTRDPParam(UINT32 atHandle, UINT32 cid);
CmsRetId psGetAllCGSCONTRDPParam(UINT32 atHandle);
CmsRetId psGetDefinedCidContext (UINT32 atHandle,UINT8 cid);
CmsRetId psSetGDCNT(UINT32 atHandle, UINT8 dataCounterOption);
CmsRetId psGetGDCNT(UINT32 atHandle);
CmsRetId psSetAUGDCNT(UINT32 atHandle, UINT16 autoSavePeriodS);
CmsRetId psGetAUGDCNT(UINT32 atHandle);


/******************************************************************************
 ******************************************************************************
  PS SYNC API, which could return info directly
 ******************************************************************************
******************************************************************************/
/**
  \fn          CmiRcCode psGetCGATTSync(UINT8 *pPsState)
  \brief       AT+CGATT? get PS attach state
  \param[out]  pPsState     CMI_PS_DETACHED(0)/CMI_PS_DETACHED(1)
  \returns     CmiRcCode    MtErrorResultCode
*/
CmiRcCode psGetCGATTSync(UINT8 *pPsState);


/**
  \fn          CmiRcCode psGetAllBearersCidsBasicInfoSync(CmiPsGetAllBearersCidsInfoCnf *pCmiAllBrCidBasicInfo)
  \brief       Get all bearers and cids basic info
  \param[out]  pCmiAllBrCidBasicInfo        CmiPsGetAllBearersCidsInfoCnf
  \returns     CmiRcCode                    MtErrorResultCode
*/
CmiRcCode psGetAllBearersCidsBasicInfoSync(CmiPsGetAllBearersCidsInfoCnf *pCmiAllBrCidBasicInfo);

/**
  \fn           CmiRcCode psSetCGAUTHSync(const CmiPsSetDefineAuthCtxReq *pCmiSetAuthInfo)
  \brief        Set CGAUTH info
  \param[in]    pCmiSetAuthInfo         CmiPsSetDefineAuthCtxReq
  \returns      CmiRcCode               MtErrorResultCode
*/
CmiRcCode psSetCGAUTHSync(const CmiPsSetDefineAuthCtxReq *pCmiSetAuthInfo);

/**
  \fn           CmiRcCode psGetOneCGAUTHSync(UINT8 cid, CmiPsGetDefineAuthCtxCnf *pCmiGetAuthCnf)
  \brief        get one PDP AUTH config info
  \param[in]    cid                     PDP CID
  \param[out]   pCmiGetAuthCnf          CmiPsGetDefineAuthCtxCnf
  \returns      CmiRcCode               MtErrorResultCode
*/
CmiRcCode psGetOneCGAUTHSync(UINT8 cid, CmiPsGetDefineAuthCtxCnf *pCmiGetAuthCnf);

/**
  \fn           CmiRcCode psSetCGDCONTSync(CmiPsDefineBearerCtxReq *pCmiDefinePdpCtxReq)
  \brief        Set CGDCONT info, define a default PDP
  \param[in]    pCmiDefinePdpCtxReq     CmiPsDefineBearerCtxReq
  \returns      CmiRcCode               MtErrorResultCode
*/
CmiRcCode psSetCGDCONTSync(const CmiPsDefineBearerCtxReq *pCmiDefinePdpCtxReq);

/**
  \fn           CmiRcCode psGetOneCGDCONTSync(UINT8 cid, CmiPsGetDefinedBearerCtxCnf *pCmiGetdefinedPdpCnf)
  \brief        get one default PDP CGDCONT info
  \param[in]    cid                     default PDP CID
  \param[out]   pCmiGetdefinedPdpCnf    CmiPsGetDefinedBearerCtxCnf
  \returns      CmiRcCode               MtErrorResultCode
*/
CmiRcCode psGetOneCGDCONTSync(UINT8 cid, CmiPsGetDefinedBearerCtxCnf *pCmiGetdefinedPdpCnf);

/**
  \fn           CmiRcCode psDelCGDCONTSync(UINT8 cid)
  \brief        delete CGDCONT info, delete a default PDP context, refer: AT+CGDCONT=<cid>
  \param[in]    cid                 PDP CID
  \returns      CmiRcCode           MtErrorResultCode
*/
CmiRcCode psDelCGDCONTSync(UINT8 cid);

/**
  \fn           CmiRcCode psGetCGCONTRDPSync(UINT8 cid, CmiPsReadBearerDynCtxParamCnf *pDynBearerCtxParamCnf)
  \brief        get one default PDP CGDCONT dyn param
  \param[in]    cid                     default PDP CID
  \param[out]   pDynBearerCtxParamCnf    CmiPsReadBearerDynCtxParamCnf
  \returns      CmiRcCode           MtErrorResultCode
*/
CmiRcCode psGetCGCONTRDPSync(UINT8 cid, CmiPsReadBearerDynCtxParamCnf *pDynBearerCtxParamCnf);

#if 0   //duplicated
/**
  \fn           CmiRcCode psGetOneCGCONTRDPSync(UINT8 cid, CmiPsReadBearerDynCtxParamCnf *pCmiGetdefinedPdpCnf)
  \brief        get one  PDP dynamic info
  \param[in]    cid                     default PDP CID
  \param[out]   CmiPsReadBearerDynCtxParamCnf    pCmiGetRdpPdpCnf
  \returns      CmiRcCode
*/
CmiRcCode psGetOneCGCONTRDPSync(UINT8 cid, CmiPsReadBearerDynCtxParamCnf *pCmiGetRdpPdpCnf);
#endif

/**
  \fn           CmiRcCode psGetCGTFTRDPSync(UINT8 cid, CmiPsReadTFTDynCtxParamCnf *pDynTftCnf)
  \brief        get actived TFT parameters of one bearer
  \param[in]    cid                     PDP CID
  \param[out]   pDynBearerCtxParamCnf   CmiPsReadTFTDynCtxParamCnf
  \returns      CmiRcCode           MtErrorResultCode
*/
CmiRcCode psGetCGTFTRDPSync(UINT8 cid, CmiPsReadTFTDynCtxParamCnf *pDynTftCnf);


/**
  \fn           CmiRcCode psGetSCLKEXSync(CmiPsGetTrafficIdleMonitorCnf *pGetTrafficIdleMonitorCnf)
  \brief        Get Traffic Idle Monitor Cnf
  \param[in]    void
  \param[out]   CmiPsGetTrafficIdleMonitorCnf *pGetTrafficIdleMonitorCnf
  \returns      CmiRcCode           MtErrorResultCode
*/
CmiRcCode psGetSCLKEXSync(CmiPsGetTrafficIdleMonitorCnf *pGetTrafficIdleMonitorCnf);


/**
  \fn           CmiRcCode psGetSCLKEXSync(CmiPsSetTrafficIdleMonitorReq *pSetTrafficIdleMonitorReq)
  \brief        Set Traffic Idle Monitor Cnf
  \param[in]    CmiPsSetTrafficIdleMonitorReq *pSetTrafficIdleMonitorReq
  \param[out]   void
  \returns      CmiRcCode           MtErrorResultCode
*/
CmiRcCode psSetSCLKEXSync(const CmiPsSetTrafficIdleMonitorReq *pSetTrafficIdleMonitorReq);

#endif

