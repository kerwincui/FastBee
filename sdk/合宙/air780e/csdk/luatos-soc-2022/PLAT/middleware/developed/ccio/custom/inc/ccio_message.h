/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: ccio_message.h
*
*  Description:
*
*  History: 2021/1/19 created by xuwang
*
*  Notes:
*
******************************************************************************/
#ifndef CCIO_MESSAGE_H
#define CCIO_MESSAGE_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include "ccio_pub.h"
#include "ccio_device.h"


#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/
/* universal flag */
#define CCIO_CHAN_MSG_FLAG        0x7

/* ctrl/data/err msg type flag */
#define CCIO_CHAN_CMSG_TYPE       0xC
#define CCIO_CHAN_DMSG_TYPE       0xD
#define CCIO_CHAN_EMSG_TYPE       0xE

#define CCIO_CHAN_CMSG_MAXNUM    (CCIO_CHAN_CMSG_MAXID & CCIO_CHAN_MSG_CODE_MASK)
#define CCIO_CHAN_DMSG_MAXNUM    (CCIO_CHAN_DMSG_MAXID & CCIO_CHAN_MSG_CODE_MASK)
#define CCIO_CHAN_EMSG_MAXNUM    (CCIO_CHAN_EMSG_MAXID & CCIO_CHAN_MSG_CODE_MASK)

/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/
typedef enum
{
    /* control msg */
    CCIO_CHAN_CMSG_BEGIN = CCIO_CHAN_CMSG_FLAG,
    CCIO_CHAN_DEV_ADD = CCIO_CHAN_CMSG_BEGIN,
    CCIO_CHAN_DEV_DEL,
    CCIO_CHAN_ULPDU_FREE,
    CCIO_CHAN_DLPDU_FREE,
    CCIO_CHAN_RBUF_FLUSH,
    CCIO_CHAN_SYSTEM_RESET,
    CCIO_CHAN_SYSTEM_PWOFF,
    CCIO_CHAN_SLP_MODE_SWITCH,
    CCIO_CHAN_SERL_CONF_CHG,
    CCIO_CHAN_SERL_CTS_CHG,
    CCIO_CHAN_SERL_DTR_CHG,
    CCIO_CHAN_SERL_STATE_SET,
    CCIO_CHAN_AUTO_BAUDRATE,
    CCIO_CHAN_USB_STATE,
    CCIO_CHAN_SCT_USB_STATE,
    CCIO_CHAN_SCT_USB_TXDONE,
    CCIO_CHAN_SCT_USB_T_EXPIRY,
    CCIO_CHAN_SCT_USB_EP_UNBLOCK,
    CCIO_CHAN_RNDIS_INIT,
    CCIO_CHAN_RNDIS_DEINIT,
    CCIO_CHAN_ECM_SET_FILTER,
    CCIO_CHAN_WAN_MEDIA_NOTIF,
    CCIO_CHAN_PPP_SESSN_START,
    CCIO_CHAN_PPP_SESSN_STOP,
    CCIO_CHAN_PPP_SESSN_RESUME,
    CCIO_CHAN_PPP_SESSN_TMCTRL,
    CCIO_CHAN_PPP_SPEC_PATTN,
    CCIO_CHAN_DATA_MODE_HS_REQ,
    CCIO_CHAN_ULFC_MEM_EVENT,
    CCIO_CHAN_DLFC_MEM_EVENT,
    CCIO_CHAN_TFC_POLICY_ENABLE,
    CCIO_CHAN_CMSG_MAXID,
    CCIO_CHAN_CMSG_END = (CCIO_CHAN_CMSG_FLAG | CCIO_CHAN_MSG_CODE_MASK),

    /* data msg */
    CCIO_CHAN_DMSG_BEGIN = CCIO_CHAN_DMSG_FLAG,
    CCIO_CHAN_AT = CCIO_CHAN_DMSG_BEGIN,
    CCIO_CHAN_PPP,
    CCIO_CHAN_ECM,
    CCIO_CHAN_RNDIS,
    CCIO_CHAN_DIAG,
    CCIO_CHAN_OPAQ,

    CCIO_CHAN_DMSG_MAXID,
    CCIO_CHAN_DATA_END = (CCIO_CHAN_DMSG_FLAG | CCIO_CHAN_MSG_CODE_MASK),

    /* error msg */
    CCIO_CHAN_EMSG_BEGIN = CCIO_CHAN_EMSG_FLAG,
    CCIO_CHAN_RBUF_EBNA = CCIO_CHAN_EMSG_BEGIN,
    CCIO_CHAN_USB_ESTATUS,
    CCIO_CHAN_AHB_EADDR,

    CCIO_CHAN_EMSG_MAXID,
    CCIO_CHAN_EMSG_END = (CCIO_CHAN_EMSG_FLAG | CCIO_CHAN_MSG_CODE_MASK)
}CcioChanMessageId_e;

typedef struct
{
    uint32_t           msgId;
    const int8_t      *msgName;     /* recommended MAX length: 32 */
    chanMsgHandleFunc  msgHandlFn;
}CcioChanMsgTblEntry_t;

typedef struct
{
    bool_t  isUsed;
    CcioChanMsgTblEntry_t *entry;
}CcioChanMsgTblIdx_t;

/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
void    ccioInitChanMsgTbls(void);
void    ccioDeinitChanMsgTbls(void);
int32_t ccioHandleChanMsg(CcioChanMessage_t *chmsg, CcioChanMsgTblIdx_t *tblIdx, uint32_t maxItems);

int32_t ccioBuildMsgDevAdd(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaDevAdd_t *dsaDevAdd);
int32_t ccioBuildMsgDevDel(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaDevDel_t *dsaDevDel);
int32_t ccioBuildMsgUlPduFree(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaUlPduFree_t *dsaPduFree);
int32_t ccioBuildMsgDlPduFree(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaDlPduFree_t *dsaPduFree);

int32_t ccioBuildMsgSystemReset(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, AtCmdResetSystem_t *resetSys);
int32_t ccioBuildMsgSystemPwOff(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, AtCmdPwOffSystem_t *powerOffSys);
int32_t ccioBuildMsgSlpModeSwitch(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, AtCmdSwitchSlpMode_t *slpMode);
int32_t ccioBuildMsgSerlConfChg(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, AtCmdChgSerlConf_t *serlConf);
int32_t ccioBuildMsgSerlCtsChg(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaCtsChg_t *ctsChg);
int32_t ccioBuildMsgSerlDtrChg(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaDtrChg_t *dtrChg);
int32_t ccioBuildMsgSerlStateSet(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioSerlState_t *serlState);
int32_t ccioBuildMsgTfcPolicyEnable(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioTfcPolicyEnable_t *tfcEnable);
int32_t ccioBuildMsgUlfcMemEvent(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioUlfcMemEvent_t *ulfcMemEvt);
int32_t ccioBuildMsgDlfcMemEvent(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDlfcMemEvent_t *dlfcMemEvt);

int32_t ccioBuildMsgWanMediaNotif(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaWanMediaNotif_t *dsaWanNotif);

int32_t ccioBuildMsgAutoBaudRate(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaAutoBaudRate_t *dsaAutoBaud);

int32_t ccioBuildMsgUsbState(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaUsbState_t *dsaUsbState);
int32_t ccioBuildMsgSctUsbTxDone(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaSctTxDone_t *dsaTxDone);
int32_t ccioBuildMsgSctUsbState(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaSctUsbState_t *dsaSctState);
int32_t ccioBuildMsgSctUsbTExpiry(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaSctUsbTmExpr_t *dsaTmExpr);
int32_t ccioBuildMsgSctUsbEpUnblock(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaSctUsbUnblkEp_t *dsaUnblkEp);
int32_t ccioBuildMsgRndisInit(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaRndisInit_t *dsaRndisInit);
int32_t ccioBuildMsgRndisDeinit(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaRndisDeinit_t *dsaRndisDeinit);
int32_t ccioBuildMsgEcmSetFilter(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaEcmSetFilter_t *dsaEcmFilter);
int32_t ccioBuildMsgPppSessnStart(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, AtCmdStartPppSessn_t *pppStart);
int32_t ccioBuildMsgPppSessnStop(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, AtCmdStopPppSessn_t *pppStop);
int32_t ccioBuildMsgPppSessnResume(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, AtCmdResumePppSessn_t *pppResume);
int32_t ccioBuildMsgPppSessnTmCtrl(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, AtCmdTmCtrlPppSessn_t *pppTmCtrl);
int32_t ccioBuildMsgDataModeHSReq(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, AtCmdReqDataModeHS_t *dataModeHS);

int32_t ccioBuildMsgDevInXfer(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDevInXfer_t *inXfer);
int32_t ccioBuildMsgDevOutXfer(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDevOutXfer_t *outXfer);
int32_t ccioBuildMsgRxStatus(CcioChanMessage_t *chmsg, CcioChanMessageId_e msgId, CcioDsaRxStatus_t *dsaRxStatus);


#ifdef __cplusplus
}
#endif
#endif

