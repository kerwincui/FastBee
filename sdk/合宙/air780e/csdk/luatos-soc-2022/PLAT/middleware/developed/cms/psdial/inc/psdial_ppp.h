#ifndef __PS_DIAL_PPP_H__
#define __PS_DIAL_PPP_H__
/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017- Copyrights of AirM2M Ltd.
 File name:      - psdial_pp.h
 Description:    - psdial pp header
 History:        - 2021/12/15, Originated by fwang
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

#define     PS_DIAL_PPP_AUTH_INFO_LEN       64



/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/
/*
 * PS Dial Ppp Disconnect non block api struct info
*/
typedef struct PsDialPppDisconnect_Tag
{
    UINT8       atChanId;
    UINT8       ipv4Cid;
    UINT8       ipv6Cid;
    UINT8       resv;
}PsDialPppDisconnect;


/*
 * AUTH info during PPP LCP AUTH procedure
*/
typedef struct PsDialPppAuthInfo_Tag
{
    UINT8       cid;
    UINT8       authType;       /* 0 - invalid, 1 - PAP,; 2 - CHAP*/

    UINT8       idChallLen;     /* len of "papIdChapChall" */
    UINT8       pwdRespLen;     /* len of "papPwdChapResp" */

    /*
     * 1> If PAP type, "papIdChapChall" is the PAP username/userId, "papPwdChapResp" is PAP password, all in string format.
     * 2> If CHAP type, "papIdChapChall" is the CHAP challenge which sent from PPP server (UE) to PPP client (host),
     *                  "papPwdChapResp" is the CHAP response which sent from PPP client (host) to PPP server (UE),
     *  Format (RFC 1994, 4.1):
     *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     *  |     Code      |  Identifier   |            Length             |
     *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     *  |  Value-Size   |  Value ...
     *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     *  |  Name ...
     *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     *  Code:  1 - Challenge
     *         2 - Response
     *  Length: length of:  4 bytes (code + ID + length) + length of "Value-size + Value + name"
    */
    UINT8       papIdChapChall[PS_DIAL_PPP_AUTH_INFO_LEN];
    UINT8       papPwdChapResp[PS_DIAL_PPP_AUTH_INFO_LEN];
}PsDialPppAuthInfo;

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
CmsRetId psDialPppProcCmiCnf(const SignalBuf *cnfSignalPtr);

BOOL psDialIsPppChan(UINT16 atHandle);
CmsRetId psDialPppConnect(UINT16 atHandle, BOOL bCidPresent, UINT8 cid);
void psDialPppDisconnect(UINT8 atChanId, UINT8 ipv4Cid, UINT8 ipv6Cid);
void psDialPppHoldOn(UINT8 atChanId);
void psDialPppHangUp(UINT16 atHandle);
void psDialPppLanLinkUp(UINT8 wanLinkupCid, NmIfConfiguration *pIfCfg);

/*
 * PPP LCP AUTH info
*/
void psDialPppSetAuth(PsDialPppAuthInfo *pAuthInfo);

/*
 * PPP LCP ACT BEARER
*/
void psDialPppActBearer(UINT8 cid);


#endif

