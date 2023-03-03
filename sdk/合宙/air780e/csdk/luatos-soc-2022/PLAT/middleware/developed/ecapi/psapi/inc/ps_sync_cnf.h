/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    ps_sync_cnf.h
 * Description:  EC618 opencpu pssynccnf header file
 * History:      Rev1.0   2018-12-10
 *
 ****************************************************************************/
#ifndef __PS_SYNC_CNF_H__
#define __PS_SYNC_CNF_H__

#include "cms_util.h"
#include "osasys.h"



/*
 * 1> CMS task OSA timer ID defination:
 *
 * 16 bits timerID
 * 15      12                    0
 * +-------+---------------------+
 * | modId |   timerId in modId  |
 * +-------+---------------------+
 *  MSB 4 bits: use to distinguish which sub-module in CMS task, so MAX 16 sub-modes
 *
 * 2> AT timer sub-module ID: CMS_TIMER_APP_PS_BLOCK_REQ_SUB_MOD_ID
 *
 * 3> AT sub timer ID defination:
 * 15      12    8 7       3    0
 * +-------+------+-------+-----+
 * |   2   |              | HID |
 * +-------+------+-------+-----+
 *
 *  HID: sub handler ID, 4 bits
 *
 * 4> ReqHander:
 *  APP_PS_BLOCK_REQ_START_HANDLER + HID
*/
#define APP_SET_BLOCK_REQ_GUARD_TIMER_ID(hId)   \
    (UINT16)((((CMS_TIMER_APP_PS_BLOCK_REQ_SUB_MOD_ID)<<12)&0xF000) | ((hId)&0x0F))

#define APP_GET_BLOCK_REQ_GUARD_TIMER_SUB_HDR_ID(timerId)   ((timerId)&0x0F)






/******************************************************************************
 *****************************************************************************
 * API
 *****************************************************************************
******************************************************************************/
//CmsRetId addPsCmiReqtoList(UINT16 requestId, void *cmiRequest);
CmsRetId psSyncProcErrCode(UINT16 result);

/*
 * Callback API, runing in CMS task
*/
void psBlockCmiReqCallback(void *pArg);

/*
 * Proc "SIG_CAM_CMI_CNF", which handler between: APP_PS_BLOCK_REQ_START_HANDLER ~ APP_PS_BLOCK_REQ_END_HANDLER
*/
void psBlockProcCmiCnf(const SignalBuf *pSig);

/*
 * Proc "OSA_TIMER_EXPIRY", which timer sub-mod ID is: CMS_TIMER_APP_PS_BLOCK_REQ_SUB_MOD_ID
*/
void psBlockProcTimerExpiry(OsaTimerExpiry *pTimerExpiry);

/*
 * Get Net info from netmgr, this API called by: appGetNetInfoSync(), and running in CMS task
*/
CmsRetId psGetNetInfoSynCallback(UINT16 inputSize, void *pInput, UINT16 outputSize, void *pOutput);


#endif

