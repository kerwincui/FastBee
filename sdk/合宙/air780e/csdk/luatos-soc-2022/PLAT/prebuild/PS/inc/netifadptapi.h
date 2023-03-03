#ifndef NETIF_ADPT_HDR_API_H
#define NETIF_ADPT_HDR_API_H

/******************************************************************************
 ******************************************************************************
 Copyright:      - 2021- Copyrights of AirM2M Ltd.
 File name:      - netifadptapi.h
 Description:    - netif adpt common api header
 History:        - 03/04/2021, Originated by xwang
 ******************************************************************************
******************************************************************************/
#include "pspdu.h"
#include "lwip/netif.h"

#define NETIF_DLPDUBLOCK_SIZE sizeof(DlPduBlock)

#define NETIF_UL_BUFF_RSVD_RNDIS_HDR_LEN 44
#define NETIF_UL_BUFF_RSVD_RNDIS_TAILER_LEN 8
#define NETIF_UL_BUFF_RSVD_PPP_HDR_LEN 8
#define NETIF_UL_BUFF_RSVD_PPP_TAILER_LEN 4;

#define NETIF_UL_DL_TCP_MSS_CHECK 1

#define NETIF_DL_TCP_WINDOWS_ADPT 1

#define NETIF_DL_TCP_MAX_WINDOWS 0xFFFF

#define NETIF_TCP_MAX_SCALE_VALUE 14

typedef enum NetIfRetEnum_Tag
{
    NETIF_SUCC = 0,
    NETIF_ERROR
}NetIfRetEnum;

// lan netif type
typedef enum NetifType_Tag
{
    NETIF_TYPE_INVALID    = 0,
    NETIF_TYPE_PS_WAN     = 1,
    NETIF_TYPE_RNDIS_LAN  = 2,
    NETIF_TYPE_PPP_LAN    = 3,
}NetifType;


typedef UINT8   NetIfRet;

//ip4 pkg input process result
typedef enum NetifIp4InputResult_Tag
{
    NETIF_IP4_INPUT_RESULT_DISCARD                             = 0,
    NETIF_IP4_INPUT_RESULT_LOCAL_INPUT                         = 1,
    NETIF_IP4_INPUT_RESULT_FORWARD_WAN                         = 2,
    NETIF_IP4_INPUT_RESULT_FORWARD_LAN                         = 3,
    NETIF_IP4_INPUT_RESULT_FORWARD_LAN_ETH                     = 4,
    NETIF_IP4_INPUT_RESULT_FORWARD_LAN_PPP                     = 5,
    NETIF_IP4_INPUT_RESULT_FORWARD_LAN_AND_INPUT               = 6,
    NETIF_IP4_INPUT_RESULT_FORWARD_LAN_ETH_AND_INPUT           = 7,
    NETIF_IP4_INPUT_RESULT_FORWARD_LAN_PPP_AND_INPUT           = 8,
    NETIF_IP4_INPUT_RESULT_FORWARD_WAN_AND_INPUT               = 9,
    NETIF_IP4_INPUT_RESULT_FORWAD_WAN_AND_DNS_RELAY_CHECK      = 10,
    NETIF_IP4_INPUT_RESULT_FORWAD_LAN_AND_DNS_RELAY_CHECK      = 11,
    NETIF_IP4_INPUT_RESULT_FORWAD_LAN_ETH_AND_DNS_RELAY_CHECK  = 12,
    NETIF_IP4_INPUT_RESULT_FORWAD_LAN_PPP_AND_DNS_RELAY_CHECK  = 13,
    NETIF_IP4_INPUT_RESULT_FAIL                                = 14,
}NetifIp4InputResult;


/*
 * DL PDU block list
*/
typedef struct NetifDlPduList_Tag
{
    UINT16      pkgNum;
    UINT16      rsvd;

    DlPduBlock  *pHead;
    DlPduBlock  *pTail;
}NetifDlPduList;    //12 bytes

/*
 * UL PDU block list
*/
typedef struct NetifUlPduList_Tag
{
    UINT16      pkgNum;
    UINT16      pkgLen;

    UlPduBlock  *pHead;
    UlPduBlock  *pTail;
}NetifUlPduList;    //12 bytes

/*
 * NETIF_UL_PDU_LIST_ADD_ONE(NetifUlPduList *pUlList, UlPduBlock *pPkgHead, UlPduBlock *pPkgTail, UINT16 pkgLen)
*/
#define NETIF_UL_PDU_LIST_ADD_ONE(PULLIST, PPKGHEAD, PPKGTAIL, PKGLEN)          \
do {                                                                            \
    OsaSingleLinkAddList((PULLIST)->pHead, (PULLIST)->pTail, (PPKGHEAD), (PPKGTAIL));   \
    (PULLIST)->pkgNum   += 1;                                                   \
    (PULLIST)->pkgLen   += (PKGLEN);                                            \
}while(FALSE)


/******************************************************************************
 * NetifUpdateFastPathChkInfo
 * Description: update fast path chk info
 * input:
 * output:
 * Comment: it will be called for these cases as below:
 * 1. wan link up /link down(ipv6 maybe link up delay)
 * 2. lan link up/link down
 * 3. lan link layer status change
 * 4. lan netif related arp cache update
 * 5. lan netif related ndp cache update(ToDo: ndp cache timeout)
******************************************************************************/
void NetifUpdateFastPathChkInfo(void);

/******************************************************************************
 * NetGetLanNetif
 * Description: netmgr adpt get system bind LAN netif by ip4 wan netif
 * input:
 * output:struct netif *
 * Comment:
******************************************************************************/
struct netif *NetGetBindLanNetifByIp4WanNetif(struct netif *wanNetif);


/******************************************************************************
 * NetGetLanNetif
 * Description: netmgr adpt get system bind LAN netif by ip6 wan netif
 * input:
 * output:struct netif *
 * Comment:
******************************************************************************/
struct netif *NetGetBindLanNetifByIp6WanNetif(struct netif *wanNetif);


/******************************************************************************
 * NetGetLanNetif
 * Description: netmgr adpt get system bind WAN ip4 netif by lan netif
 * input:
 * output:struct netif *
 * Comment:
******************************************************************************/
struct netif *NetGetBindIp4WanNetifByLanNetif(struct netif *lanNetif);

/******************************************************************************
 * NetGetLanNetif
 * Description: netmgr adpt get system bind WAN ip6 netif by lan netif
 * input:
 * output:struct netif *
 * Comment:
******************************************************************************/
struct netif *NetGetBindIp6WanNetifByLanNetif(struct netif *lanNetif);


/******************************************************************************
 * NetifUlGetOnePkg
 * Description: get one whole pkg from "UlPduBlock" list, and return to next pkg head
 * input:   UlPduBlock  *pUlHdr    //in
 *          UlPduBlock   **ppOnePkgHead //out
 *          UlPduBlock   **ppOnePkgTail //out
 *          UINT16       *pPkgLen       //out
 * output: UlPduBlock*
******************************************************************************/
UlPduBlock* NetifUlGetOnePkg(UlPduBlock   *pUlHdr,
                                                   UlPduBlock   **ppOnePkgHead,
                                                   UlPduBlock   **ppOnePkgTail,
                                                   UINT16       *pPkgLen);


/******************************************************************************
 * NetifLanDlOnePkgDataReq
 * Description: provide by ppp service, lwip send IP pkg to ppp/rndis service by this API
 * input: DlPduBlock *pDlPdu
 * output:
 * Comment:
 *          Called by tcpip statck (ppp netif adpt layer)
******************************************************************************/
void NetifLanDlOnePkgDataReq(UINT8 lanNetifType, DlPduBlock *pDlPdu);


/******************************************************************************
 * NetifDumpUlPacket
 * Description: netif dump UL data(ulpdu buffer)
 * input: UlPduBlock *ulData, UINT8 type(lwip_netif_type_t)
 * output:
 * Comment:
******************************************************************************/
void NetifDumpUlPduPacket(UlPduBlock *ulData, UINT8 type);


/******************************************************************************
 * NetifDumpDlPduPacket
 * Description: netif dump DL data(dlpdu buffer)
 * input: DlPduBlock *dlData, UINT8 type(lwip_netif_type_t)
 * output:
 * Comment:
******************************************************************************/
void NetifDumpDlPduPacket(DlPduBlock *dlData, UINT8 type);

/******************************************************************************
 * NetifDumpDlPbufPacket
 * Description: netif dump DL data(pbuf buffer)
 * input: struct pbuf *pbufdata, UINT8 type(lwip_netif_type_t)
 * output:
 * Comment:
******************************************************************************/
void NetifDumpDlPbufPacket(struct pbuf *pbufData, UINT8 type);

/******************************************************************************
 * NetifDumpUlPbufPacket
 * Description: netif dump UL data(pbuf buffer)
 * input: struct pbuf *pbufdata, UINT8 type(lwip_netif_type_t)
 * output:
 * Comment:
******************************************************************************/
void NetifDumpUlPbufPacket(struct pbuf *pbufData, UINT8 type);


/******************************************************************************
 * NetifCopyDataFromUlPdu
 * Description:
 * input: UlPduBlock *pUlPdu
 * output:UINT16
 * Comment:
******************************************************************************/
UINT16 NetifCopyDataFromUlPdu(UINT8 *payload, UlPduBlock *pUlPdu);

/******************************************************************************
 * NetifProcessIp4InputPkg
 * Description:
 * input: struct netif *inp, struct pbuf *p
 * output:UINT8
 * Comment:
******************************************************************************/

/******************************************************************************
 * NetGetLanNetif
 * Description: netmgr adpt get system bind LAN channel id by LAN netif
 * input:
 * output:struct netif *
 * Comment:
******************************************************************************/
UINT8 NetGetBindLanChannelIdByLanNetif(struct netif *pLanNetif);

UINT8 NetifProcessIp4InputPkg(struct netif *inp, struct pbuf *p);


err_t NetifLanTcpipInput(u8_t lanType, UlPduBlock *pPduHdr);

/*
*/
void NetifLanDlPkgListOutput(UINT8 lanNetifType, UINT16 pkgNum, DlPduBlock *pHead, DlPduBlock *pTail);

/*
*/
void NetifLanDlPkgListGet(UINT8 lanType, DlPduBlock **ppHead, DlPduBlock **ppTail);

void NetifIp4PkgFwdWanFromLanSrcAddrProcess(struct pbuf *p, struct netif *wanIf, struct netif *lanIf, ip4_addr_t *srcAddr);

void NetifIp4PkgFwdLanFromWanDestAddrProcess(struct pbuf *p, struct netif *wanIf, struct netif *lanIf, ip4_addr_t *destAddr);

UINT8 *NetifParseTcpOption(UINT8 *pOption, UINT16 len, UINT8 type, UINT8 **pPreOption);

UINT16 NetifUpdateTcpIpCheckSumUint16(UINT16 oldChkSum, UINT16 oldValue, UINT16 newValue);

UINT16 NetifUpdateTcpIpCheckSumUint32(UINT16 oldChkSum, UINT32 oldValue, UINT32 newValue);

BOOL NetifCopyDataToUlPdu(UlPduBlock *pUlPdu, UINT16 offset, UINT8 *pIn, UINT16 length);

BOOL NetifDnsRelayWanProcess(struct netif *wanIf, struct netif *lanIf, struct pbuf *p, ip4_addr_t *srcAddr);

BOOL NetifDnsRelayLanProcess(struct netif *lanIf, struct netif *wanIf, struct pbuf *p, ip4_addr_t *destAddr);

void NetifDlTcpDisableWSOption(UINT8 *pTransport);

err_t NetifProcessIp6TcpSyncInputPkg(struct pbuf *pbuf, UINT8 lanType);

void NetifClearPortMappingTable(UINT8 connSource, UINT8 cid);

struct netif *NetGetBindLanNetifByIp4WanNetifAndLanType(struct netif *wanNetif, UINT8 lanNetifType);

#endif

