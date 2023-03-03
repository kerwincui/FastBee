#ifndef __PS_DIAL_NET_H__
#define __PS_DIAL_NET_H__
/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017- Copyrights of AirM2M Ltd.
 File name:      - psdial_net.h
 Description:    - psdial net header
 History:        - 2021/11/17, Originated by xlhu
 ******************************************************************************
******************************************************************************/
#include "commontypedef.h"
#include "cms_api.h"
#include "networkmgr.h"

/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/
#define PSDIAL_NET_OPT


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

#ifdef  PSDIAL_NET_OPT

/*
 * PS dial static context in MSMB
*/
typedef struct PsDialNetStaticContext_Tag
{
    #if 0
    UINT32      ignoreUrc   :1;     /* Whether need ignore URC: +ECNETDEVSTATUS: %d
                                     * 1> During the NET CID re-bind (AT+ECNETDEVCTL change the CID) procedure,
                                     *    should not report the first unbind URC for old CID.
                                     * 2> During the PDP re-act procedure, also should not report all URC
                                    */
    UINT32      needRebindAfterUnbindInd    :1; /* Whether need to re-bind (NetMgrLanCtrl()) the CID, after recv: NmAtiLanInfo
                                                 *  which indicated the OLD cid unbind. used in case:
                                                 * 1> the bind CID changed by AT+ECNETDEVCTL, before bind new, need waiting for
                                                 *    old unbind
                                                 * 2> PDP re-act, should wait for old CID LAN unbind, before bind new CID, in fact
                                                 *    here "old CID" = "new CID"
                                                 * 3> the new bind CID in: "MWAonNetParamCfg.cid"
                                                 * In fact, not need it, always need to check whether need to bind after recv: NmAtiLanInfo
                                                */
    #endif
    UINT32      bBindOnceProc   :1; /* whether current procedure is tigger by AT+ECNETDEVCTL, which OPT is:
                                     *  MW_AON_NET_DEV_CTL_OP_BIND_CID_ONCE
                                    */

    UINT32      rsvd            :31;

}PsDialNetStaticContext;


#endif

/******************************************************************************
 ******************************************************************************
 * External global variable
 ******************************************************************************
******************************************************************************/



/******************************************************************************
 *****************************************************************************
 * Functions
 *****************************************************************************
******************************************************************************/
/*
* psdial net unbind cid for lwip
*/
//void psDialNetDevCtrlUnBindCid(UINT8 cid);

/*
* psdial net bind cid for lwip
*/
//void psDialNetDevCtrlBindCid(UINT8 newCid);

/*
 * psdial net process device control
*/
void psDialNetDevCtl(UINT8 op, UINT8 cid, BOOL bUrcEn);

/*
* psdial net proc appl Ind (NM_ATI_LAN_INFO_IND)
*/
void psDialNetProcApplInd(CmsApplInd *pAppInd);

/*
* psdial net proc Act Pdn Ctx Failure by sending appl Ind (NM_ATI_LAN_INFO_IND)
*/
void psDialNetProcActPdnCtxFailure(void);

/*
 * psdial net WAN link up and lan bind
*/
void psDialNetLinkupCtrl(UINT8 cid, NmIfConfiguration *pIfCfg);

/*
 * psdial net auto dial mode check
*/
void psDialNetAutoDialCheck(void);

/*
* psdial net link down
*/
void psDialNetLinkDown(UINT8 cid);

/*
 * psdial net init and lanconfig for lwip
*/
void psDialNetInit(void);


#endif

