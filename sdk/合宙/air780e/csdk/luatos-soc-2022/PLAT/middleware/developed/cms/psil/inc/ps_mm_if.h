/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    ps_mm_if.h
 * Description:  API interface implementation header file for mm service
 * History:      Rev1.0   2018-10-12
 *
 ****************************************************************************/
#ifndef __PS_MM_IF_H__
#define __PS_MM_IF_H__
#include "cms_util.h"

CmsRetId mmGetCregCapaReq(UINT32 atHandle);
CmsRetId mmGetCregReq(UINT32 atHandle);
CmsRetId mmManualPlmnSearch(UINT32 atHandle, UINT32 gardTimerSec);
CmsRetId mmGetCurOperInfo(UINT32 atHandle);
CmsRetId mmSetAutoPlmnRegister(UINT32 atHandle);
CmsRetId mmSetManualPlmnRegister(UINT32 atHandle, BOOL bFailToAuto, INT32 operFormat, UINT8 *pOperStr, INT32 accTchVal);
CmsRetId mmSetDeregister(UINT32 atHandle);
CmsRetId mmSetOperFormat(UINT32 atHandle, INT32 operFormat);
CmsRetId mmSetOperFormatSync(INT32 operFormat);
CmsRetId mmGetCpsms(UINT32 atHandle);
CmsRetId mmSetCpsms(UINT32 atHandle, UINT8 modeVal, const UINT8 *pRauT, const UINT8 *pGprsT, const UINT8 *pTauT, const UINT8 *pActT);
CmsRetId mmGetEdrx(UINT32 atHandle);
CmsRetId mmSetEdrx(UINT32 atHandle, UINT8 modeVal, UINT8 actType, UINT8* edrxVal);
CmsRetId mmReadEdrxDyn(UINT32 atHandle);
CmsRetId mmGetCiotoptCapa(UINT32 atHandle);
CmsRetId mmSetCiotoptCfg(UINT32 atHandle, CmiMmSetCiotOptCfgReq *pSetCiotOptCfgReq);
CmsRetId mmGetCiotoptCfg(UINT32 atHandle);
CmsRetId mmGetCoverEnhancStatus(UINT32 atHandle);
CmsRetId mmGetEcplmns(UINT32 atHandle);
CmsRetId mmExecEcplmns(UINT32 atHandle);
CmsRetId mmGetCESQ(UINT32 atHandle);
CmsRetId mmGetECPSMR(UINT32 atHandle);
UINT8 mmGetCsqRssiFromCesq(INT8 rsrp, INT8 rsrq, UINT16 rssiComp);
CmsRetId mmSetPtwEdrx(UINT32 atHandle, UINT8 modeVal, UINT8 actType, UINT8* ptw, UINT8* edrxVal);
CmsRetId mmGetPtwEdrx(UINT32 atHandle);
CmsRetId mmGetECEMMTIME(UINT32 atHandle);
CmsRetId mmSetECPLMNRESELECT(UINT32 atHandle);
CmsRetId mmGetCurrOperatorName(UINT32 atHandle);
CmsRetId mmSetTriggerRrcRelease(UINT32 atHandle);
CmsRetId mmSetTriggerTau(UINT32 atHandle, UINT8 epsUpdateType);
BOOL OperatorStringToNumericPlmn(const UINT8 *pPlmnStr, CmiNumericPlmn *pOutPlmn);


#endif

