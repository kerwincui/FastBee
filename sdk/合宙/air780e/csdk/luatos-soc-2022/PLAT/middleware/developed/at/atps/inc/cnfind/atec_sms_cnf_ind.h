/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_sms_cnf_ind.h
*
*  Description: Process SMS related AT commands
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifdef FEATURE_PS_SMS_AT_ENABLE

#ifndef __ATEC_SMS_CNF_IND_H__
#define __ATEC_SMS_CNF_IND_H__

#include "at_util.h"
#include "atec_sms.h"
#include "ps_sms_if.h"



CmsRetId smsNewMsgAck(UINT32 reqHandle, UINT32 reply, UINT16 ackPduLen, UINT8 *ackPdu);
CmsRetId smsCMGSCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCMSSCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCSCAGetCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCSCACSMPSetCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCSMSCurrentGetCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCSMSSetCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCSMSSupportedGetCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCMMSSetCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCMMSGetCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCSCBGetCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCSCBSetCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCMGRCMSSGetSmsMsgRecordCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCMGWSetSmsMsgRecordCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCMGDDelSmsMsgRecordCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCMGLSmsMsgRecordCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId smsCPMSGetStorStatusCnf(UINT16 reqHandle, UINT16 rc, void *paras);

CmsRetId smsNewSMSRptUrc(CmiSmsNewMsgInd *pCmiMsgInd);
CmsRetId smsProcNewSMSInd(void * paras);
CmsRetId smsNewMessageMemoryLocationInd(void *paras);

CmsRetId smsCMGRGetSmsMsgCnf(UINT16 reqHandle, PsilSmsStoreItemInfo *pGetSmsInfo);
CmsRetId smsCMSSGetSmsMsgCnf(UINT16 reqHandle, PsilSmsStoreItemInfo *pGetSmsInfo);

CmiSmsAccMemRet smsStoreNewMsgToStorage(UINT32 atHandle, CmiSmsNewMsgInd *pCmiMsgInd, UINT8 saveMode, UINT8* pMemIndex);


void atSmsProcCmiCnf(CamCmiCnf *pCmiCnf);
void atSmsProcCmiInd(CamCmiInd *pCmiInd);

#endif

#endif