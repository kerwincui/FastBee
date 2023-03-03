/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    ps_nm_if.h
 * Description:  API interface implementation header file for PHY service
 * History:      Rev1.0   2018-10-12
 *
 ****************************************************************************/
#ifndef __PS_NM_IF_H__
#define __PS_NM_IF_H__
#include "cms_util.h"
#include "appmgr.h"
#include "networkmgr.h"



//#define ATEC_PING_IND_STR_LEN   160
//#define ATEC_ECGADDR_STR_LEN    160


CmsRetId psGetDNS(UINT32 atHandle, UINT8* url, UINT8 cid);
CmsRetId psGetDNSWithoutCache(UINT32 atHandle, UINT8* url, UINT8 cid);
CmsRetId psStopPing(UINT32 atHandle );
CmsRetId psStartPing(UINT32 atHandle, UINT8* addr, INT16 addr_len, INT32 count, INT32 size, INT32 timeout, BOOL raiFlag, UINT8 cid);
CmsRetId psStartPingWithOutUrl(UINT32 atHandle, UINT8 *pAddr, INT16 addr_len, INT32 count, INT32 size, INT32 timeout, BOOL raiFlag, UINT8 cid);

CmsRetId psIperfReq(UINT32 atHandle, NmIperfReq *pIperfReq);
CmsRetId psSntpReq(UINT32 atHandle, char *sntpServer, UINT16 port, BOOL autoSync, UINT8 cid);
CmsRetId psClearDnsCache(BOOL bClearAll, UINT8* url );

CmsRetId psGetDnsServer(UINT8 cid, NmNetIfDnsCfg *dnsServer);

CmsRetId psSetDnsServer(UINT8 cid, NmNetIfDnsCfg *dnsServer);


#endif

