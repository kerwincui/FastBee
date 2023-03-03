/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    ps_sim_if.h
 * Description:  The header file for API interface for PS SIM module
 * History:      Rev1.0   2018-10-12
 *
 ****************************************************************************/
#ifndef __PS_SIM_IF_H__
#define __PS_SIM_IF_H__

#include "cms_util.h"
#include "cmisim.h"

CmsRetId simGetImsi(UINT32 atHandle);
CmsRetId simGetPinState(UINT32 atHandle);
CmsRetId simEnterPin(UINT32 atHandle, UINT8* oldPasswd, UINT8* newPasswd);
CmsRetId simSetCRSM(UINT32 atHandle, INT32 cmd, INT32 fileId, INT32 p1, INT32 p2, INT32 p3, CHAR *data, CHAR *pathId);
CmsRetId simSetCSIM(UINT32 atHandle, UINT16 cmdStrLen, UINT8 *cmdStr);
CmsRetId simGetIccid(UINT32 atHandle);
CmsRetId simSetCPWD(UINT32 atHandle, UINT8 no, UINT8 oper, UINT8* oldPasswd, UINT8* newPasswd);
CmsRetId simSetClck(UINT32 atHandle, UINT8 mode, UINT8 fac, UINT8* pinCode);
CmsRetId simSetCcho(UINT32 atHandle, UINT8 *dfName);
CmsRetId simSetCchc(UINT32 atHandle, UINT8 sessionId);
CmsRetId simSetCgla(UINT32 atHandle, UINT8 sessionId, UINT16 len, UINT8* command);
CmsRetId simSetSimSleep(UINT32 atHandle, UINT8 mode);
CmsRetId simGetSimSleepState(UINT32 atHandle);
CmsRetId simSetCpinr(UINT32 atHandle, UINT8 pinCode);
CmsRetId simSetECSWC(UINT32 atHandle, UINT8 mode);
CmsRetId simGetSWCSetting(UINT32 atHandle);
CmsRetId simSetPinOperation(UINT32 atHandle, UINT8 operMode, UINT8* pinStr1, UINT8* pinStr2);
//CmsRetId simSetECSIMPD(UINT32 atHandle, UINT8 mode);
CmsRetId simGetECSIMPDSetting(UINT32 atHandle);
CmsRetId simGetSubscriberNumber(UINT32 atHandle);
CmsRetId simSetTerminalProfile(UINT32 atHandle, UINT16 strLen, UINT8 *profileStr);
CmsRetId simGetTerminalProfile(UINT32 atHandle);
CmsRetId simSetExtCfg(UINT32 atHandle, CmiSimSetExtCfgReq *pSetExtCfgReq);
CmsRetId simGetExtCfg(UINT32 atHandle);
CmsRetId simSetRemoval(UINT32 atHandle);
CmsRetId simGetSmsParams(UINT32 atHandle);
CmsRetId simSetSelectPlmnList(UINT32 atHandle, UINT8 plmnList);
CmsRetId simSetPreferredPlmnList(UINT32 atHandle, UINT16 index, UINT8 format, UINT8 *pOperStr, UINT16 AccessTech);
CmsRetId simGetPreferredPlmnList(UINT32 atHandle);


/******************************************************************************
 ******************************************************************************
  PS SYNC API, which could return info directly
 ******************************************************************************
******************************************************************************/
/**
  \fn          CmiRcCode simGetPinStateSync(UINT8 *pPinState)
  \brief       AT+CPIN? get SIM PIN state
  \param[out]  pPinState    CmiSimPinState
  \returns     CmiRcCode    MtErrorResultCode
*/
CmiRcCode simGetPinStateSync(UINT8 *pPinState);

/**
  \fn          simSetHotSwapNotifySync(BOOL bSimPlugIn)
  \brief       called by CMS task processed CmsSimHotSwapInd
  \param[out]  pPinState    CmiSimPinState
  \returns     CmiRcCode    MtErrorResultCode
*/
CmiRcCode simSetHotSwapNotifySync(BOOL bSimPlugIn);

/**
  \fn          CmiRcCode simGetSelectedPlmnListSync(UINT8 *pPinState)
  \brief       AT+CPLS? get selected PLMN list
  \param[out]  pPinState    CmiSimPinState
  \returns     CmiRcCode    MtErrorResultCode
*/
CmiRcCode simGetSelectedPlmnListSync(UINT8 *pList);

#endif

