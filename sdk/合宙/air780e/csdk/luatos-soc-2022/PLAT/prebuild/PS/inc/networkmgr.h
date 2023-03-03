
/******************************************************************************
 ******************************************************************************
 Copyright:      - 2018- Copyrights of AirM2M Ltd.
 File name:      - networkmgr.h
 Description:    - network data path mange related function header
 History:        - 01/02/2018, Originated by xwang
 ******************************************************************************
******************************************************************************/
#ifndef TCPIP_NETWORK_MGR_H
#define TCPIP_NETWORK_MGR_H

/*
 * !!! note, this is the header file which provide to app/cms/at/ccio, and should be opened in SDK !!!
 * !!! not suggect to include more other header filer !!!
*/
#include "commontypedef.h"
#include "lwip/opt.h"
#include "lwip/ip_addr.h"
#include "netif/ethernet.h"
#include "cmips.h"

/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/

#define NM_ADDR_MAX_LENGTH          16

/*
 * set bit B to 1 in D
 * example:
 *  NmBit1Set(0x00, 0) = 0x01
 *  NmBit1Set(0x01, 4) = 0x11
*/
#define NmBit1Set(D, B)   ((D) |= (1<<(B)))

/*
 * set bit B to 0 in D
 * example:
 *  NmBit0Set(0xFF, 0) = 0xFE
 *  NmBit0Set(0xFE, 4) = 0xEE
*/
#define NmBit0Set(D, B)   ((D) &= (~(1<<(B))))


#define NM_MAGIC_WORD               0xA5B7

/******************************************************************************
 *****************************************************************************
 * STRUCT/ENUM
 *****************************************************************************
******************************************************************************/


/*
 * the action result
*/
typedef enum
{
    NM_SUCCESS = 0,
    NM_FAIL = 1,
}NmResult;

/*
 * NM NET type
*/
typedef enum _EPAT_NmNetIpType_tag
{
    NM_NET_TYPE_INVALID = 0,    //net not available
    NM_NET_TYPE_IPV4 = 1,       //ipv4 available
    NM_NET_TYPE_IPV6 = 2,       //ipv6 available
    NM_NET_TYPE_IPV4V6 = 3,     //ipv4&ipv6 available
    NM_NET_TYPE_IPV6preparing = 4, //ipv6 preparing
    NM_NET_TYPE_IPV4_IPV6preparing = 5, //ipv4 available &ipv6 preparing
}NmNetIpType;

/*
 * the ip address type
*/
typedef enum
{
    NM_ADDR_INVALID_ADDR = 0,
    NM_ADDR_IPV4_ADDR,          // 4 bytes length
    NM_ADDR_IPV6_ID,             //8 bytes length
    NM_ADDR_FULL_IPV6_ADDR      //16 bytes length
}NmAddrType;

/*
 *NM LAN type
*/
typedef enum
{
    NM_LAN_TYPE_INVALID = 0,
    NM_LAN_TYPE_RNDIS,
    NM_LAN_TYPE_ECM,
    NM_LAN_TYPE_PPP,
}NmLanType;

/*
 *NM LAN NET type
*/
typedef enum
{
    NM_LAN_NET_TYPE_INVALID = 0,
    NM_LAN_NET_TYPE_ETH,
    NM_LAN_NET_TYPE_PPP,
}NmLanNetType;



/*
 * NM LAN link layer status type:
 *  RNDIS/ECM, HOST and UE Link/connection state
*/
typedef enum
{
    NM_LAN_LINK_STATUS_DISCONNECTED,
    NM_LAN_LINK_STATUS_CONNECTED,
}NmLanLinkStatus;

/*
 * NM LAN data path status
*/
typedef enum
{
    NM_LAN_NET_DEACTIVED,       //lan data path is deactive, init state, or LAN is linkdown by CCIO
    NM_LAN_NET_ACTIVED,         //lan data path is active, LAN is linkup by CCIO
    NM_LAN_NET_ACTIVED_AND_CHANGED, //lan data path is active and changed, such as ipv4 ready change to ipv4ipv6 ready
}NmLanNetStatus;



/*
 * NM ethernet LAN (RNDIS/ECM) data path ip4 mode (ip6 is always pass through mode)
*/
typedef enum
{
    NM_ETH_LAN_IP4_PATH_MODE_PASSTHROUGH = 0,   //pass through mode
    NM_ETH_LAN_IP4_PATH_MODE_NAT,               //nat mode
}NmEthLanIp4PathMode;


/*
*NM LAN ctrl api
*/
typedef enum
{
    NM_LAN_CTRL_ACTION_BIND = 0,   //pass through mode
    NM_LAN_CTRL_ACTION_UNBIND,     //nat mode
}NmLanCtrlAction;

typedef struct NetMgrWanIpv6Info_Tag
{
    ip6_addr_t  ipv6GlobalAddr;
    ip6_addr_t  ipv6LinklocalAddr;

    UINT8       dnsNum;
    UINT8       rsvd0;
    UINT16      rsvd1;
    ip6_addr_t  dns[NM_PDN_TYPE_MAX_DNS_NUM];
}NetMgrWanIpv6Info;   //52 bytes


typedef struct NetMgrWanIpv4Info_Tag
{
    ip4_addr_t  ipv4Addr;

    UINT8       dnsNum;
    UINT8       rsvd0;
    UINT16      rsvd1;
    ip4_addr_t  dns[NM_PDN_TYPE_MAX_DNS_NUM];
}NetMgrWanIpv4Info;   //16 bytes


typedef struct NetMgrWanInfo_Tag
{
    UINT8 ipType;
    UINT8 ipv4Cid;
    UINT8 ipv6Cid;
    BOOL bEnableRohc;

    NetMgrWanIpv4Info wanIpv4Info;
    NetMgrWanIpv6Info wanIpv6Info;
}NetMgrWanInfo;

typedef struct NetMgrLanIPv6Info_Tag
{
    ip6_addr_t  ipv6GlobalAddr;
    ip6_addr_t  ipv6LinklocalAddr;
}NetMgrLanIPv6Info;

typedef struct NetMgrLanIPv4Info_Tag
{
    ip4_addr_t  ipv4Addr;
}NetMgrLanIPv4Info;

typedef struct NetMgrRndisLanInfo_Tag
{
    UINT8  ipType;
    UINT8  rsvd0;
    UINT16 rsvd1;

    NetMgrLanIPv4Info lanIpv4Info;
    NetMgrLanIPv6Info lanIpv6Info;

    UINT8 etherAddr[ETH_HWADDR_LEN];
}NetMgrRndisLanInfo;

typedef struct NetMgrPppLanInfo_Tag
{
    UINT8  ipType;
    UINT8  rsvd0;
    UINT16 rsvd1;

    NetMgrLanIPv4Info lanIpv4Info;
    NetMgrLanIPv6Info lanIpv6Info;
}NetMgrPppLanInfo;

typedef struct NetMgrLanInfo_Tag
{
    UINT8 type;
    union
    {
        NetMgrRndisLanInfo rndisLanInfo;
        NetMgrPppLanInfo   pppLanInfo;
    }lanInfo;
}NetMgrLanInfo;



typedef struct NetMgrEthLanCfg_Tag
{
    UINT8       ethLanIp4PathMode;  //NmEthLanIp4PathMode, nat/passthrough mode
    UINT8       rsvd0;
    UINT16      rsvd1;

    ip4_addr_t  ethLocalAddr;       //Ethernet LAN netif (ECM/RNDIS) address, example: 192.168.10.1
    ip4_addr_t  ethHostAddr;        //host lan netif(ECM/RNDIS) address, if NAT mode, example: 192.168.10.5
    ip4_addr_t  ethHostNetMask;     //host lan netif(ECM/RNDIS) netmask.if NAT mode, example:255.255.255.0; if the setting is 0.0.0.0, ue will use the deault value
}NetMgrEthLanCfg;   // 12 bytes

#if 0
typedef struct NetMgrPppLanCfg_Tag
{
    ip4_addr_t  pppLocalAddr;       //PPP LAN netif address, should not same as: "ethLocalAddr", example: 192.168.20.1
}NetMgrPppLanCfg;
#endif

typedef struct NetMgrLanCfg_Tag
{
    NetMgrEthLanCfg     ethLanCfg;
    //NetMgrPppLanCfg     pppLanCfg;
}NetMgrLanCfg;      // 12 bytes


/*
*/
typedef struct NetMgrLanDataPathCap_Tag
{
    UINT8           lanType;        /* NmNetLanType */
    BOOL            bConnected;     /* Whether LAN is connected/disconnected
                                     * 1> if connected, CCIO need to try linkup LAN, if ethernet(RNDID/ECM)/PPP enabled
                                     * 2> if disconnected, CCIO need to linkdown LAN
                                    */
    UINT16          rsvd0;

    /*
     * Some basic lan info
    */
    UINT8           lanIpType;      /* NmNetIpType */
    UINT8           lanBindIp4Cid;  /* If not bind, set to : 0xFF */
    UINT8           lanBindIp6Cid;  /* If not bind, set to : 0xFF */
    UINT8           rsvd1;
}NetMgrLanDataPathCap;

/*
 * When LAN (PPP/RNDIS/ECM) state changes (connect/disconnect) need to notify CCIO
*/
//void radioDevNotifyTcpipDataPathCapability(NetMgrLanDataPathCap *pLanDataPathCap);

/*
 * query the lan tcpip data path capability, called by CCIO, to descide whether can do lan link up
*/
//NmResult NetMgrQueryLanTcpipDataPathCapability(NmLanType lanType, NetMgrLanDataPathCap *pLanDataPathCap);


/*
 *NM LAN channel TCPIP data path status
*/
typedef struct NetMgrLanChannelTcpipDataPathStatus_Tag
{
    UINT8           status;         /* NmLanNetStatus, event status with (NM_LAN_NET_DEACTIVED/NM_LAN_NET_ACTIVED/NM_LAN_NET_ACTIVED_AND_CHANGED);
                                     *  query return (NM_LAN_NET_DEACTIVED/NM_LAN_NET_ACTIVED)
                                    */
    UINT8           lanIpType;      /* NmNetIpType */
    UINT8           lanBindIp4Cid;  /* If not bind, set to : 0xFF */
    UINT8           lanBindIp6Cid;  /* If not bind, set to : 0xFF */
}NetMgrLanChannelTcpipDataPathStatus;

/*
/NM LAN channel TCPIP data path info(assign to host)
*/
typedef struct NetMgrLanTcpipDataPathHostInfo_Tag
{
    /*
     * Some basic lan info
    */
    UINT8           lanIpType;       /* NmNetIpType */
    UINT8           lanBindIp4Cid;   /* If not bind, set to : 0xFF */
    UINT8           lanBindIp6Cid;   /* If not bind, set to : 0xFF */
    UINT8           rsvd1;

    ip4_addr_t      hostIp4Addr;      /*the ip4 address which will assigned to host*/
    UINT32          hostIp6Prefix[2]; /*the ip6 prefix which will assigned to host*/
    UINT32          hostIp6Id[2];     /*the ip6 ID which will assigned to host*/

    ip4_addr_t      hostIp4Dns[NM_PDN_TYPE_MAX_DNS_NUM]; /*the ip4 dns which will assigned to host*/
    ip6_addr_t      hostIp6Dns[NM_PDN_TYPE_MAX_DNS_NUM]; /*the ip6 dns which will assigned to host*/

}NetMgrLanTcpipDataPathHostInfo;

/*
*/
typedef struct NmAtiLanInfo_Tag
{
    UINT8       lanType;        /*NmLanNetType, ETH/PPP LAN*/
    BOOL        bound;          /*whether current LAN , bind a WAN/netif */

    UINT8       lanBindIp4Cid;  /* If not bind, set to : 0xFF */
    UINT8       lanBindIp6Cid;  /* If not bind, set to : 0xFF */
}NmAtiLanInfo;

/*
 * notify the CMS/psdial the LAN info
*/
//void NetMgrNotifyAtiLanInfoInd(NmAtiLanInfo *pAtiLanInfo);


/******************************************************************************
 * Net manager entity
******************************************************************************/

/*
 * PS NET status, status from CEREG
*/
typedef enum NmPsNetStatus_Tag
{
    /*
     * PS is not registered, and UE is not under dialing
    */
    NM_PS_NET_NOT_DIAL,

    /*
     * 1> PS is not registered, but under registration
     * 2> and no ACT NETIF (bearer)
    */
    NM_PS_NET_NOT_REG,

    /*
     * 1> PS is OOS (out of service)
     * 2> and must have ACT NETIF (bearer);
     * 3> If no ACT NETIF (bearer), status need to change to "NM_PS_NET_NOT_REG"
    */
    NM_PS_NET_OOS,

    /*
     * PS is registered, and NETIF maybe comes later
    */
    NM_PS_NET_REG
}NmPsNetStatus;

typedef struct NmEntity_Tag
{
    UINT8   psNetStatus;    //NmPsNetStatus
    UINT8   rsvd0;

    /*
     * CID valid value: 1 - 15;
     * If one CID (bearer) activated, related bit set to 1
    */
    UINT16  actCidsBitmap;
}NmEntity;

#if 0
/******************************************************************************
 * A blocked callback designation, which called in LWIP task
******************************************************************************/
typedef enum NmBlockCallbackMsgId_Tag
{
    NM_BLOCK_CB_INVALID_ID,
    NM_NET_LINK_UP,
    NM_NET_LINK_DOWN,
    NM_NET_LAN_LINK_UP,
    NM_NET_LAN_LINK_DOWN,
    NM_NET_LAN_LINK_LAYER_STATUS_CHANGE,
    NM_GET_NET_INFO,
    NM_CLEAR_DNS_CACHE,
    NM_GET_DNS_SERVER,
    NM_SET_DNS_SERVER,
}NmBlockCallbackMsgId;
#endif

/*
 * The ip address structure
 * NM_ADDR_IPV4_ADDR: 12~15:0 0~3:address
 * NM_ADDR_FULL_IPV6_ADDR: 0~15 prefix:id
 * NM_ADDR_IPV6_ID: 8~15:0 0~7:id
*/
typedef struct NmIpAddr_Tag
{
    UINT8   addrType;   //NmAddrType
    UINT8   reserved0;
    UINT16  reserved1;
    UINT8   addr[NM_ADDR_MAX_LENGTH];
}NmIpAddr;  //20 bytes



/******************************************************************************
 * PS netif configuration info
 * Use to link up one netif
******************************************************************************/
typedef struct NmIfConfiguration_Tag
{
    UINT16      dnsNum : 3;
    UINT16      mtuPresent : 1; //if mtu is invalid ,this value will be zero
    UINT16      cgevReason: 4;  //CmiPsPdnTypeReason
    UINT16      rsvd0 : 8;

    UINT16      mtu;
    NmIpAddr    ipv4Addr;
    NmIpAddr    ipv6Addr;
    NmIpAddr    dns[NM_MAX_DNS_NUM];
}NmIfConfiguration; //124 bytes


typedef struct NmNetIfDnsCfg_Tag{
    UINT8 dnsNum;
    UINT8 rsvd0;
    UINT16 rsvd1;
    ip_addr_t  dns[NM_MAX_DNS_NUM];
}NmNetIfDnsCfg; //84 bytes


/******************************************************************************
 * NM_ATI_SYNC_GET_NET_INFO_REQ
******************************************************************************/
typedef struct NmAtiGetNetInfoReq_Tag
{
    /*
     * 1> If user want to get the default netif info, CID could set to "LWIP_PS_DEFAULT_CID", CID 0 is used for attached bearer (initial PDP context)
     * 2> Valid value: [LWIP_PS_MIN_VALID_CID - LWIP_PS_MAX_VALID_CID]/[0-15]
    */
    UINT8       cid;
    UINT8       rsvd0;
    UINT16      rsvd1;
}NmAtiGetNetInfoReq;

typedef struct NmAtiGetDnsServerReq_Tag
{
    UINT8       cid;
    UINT8       rsvd0;
    UINT16      rsvd1;
}NmAtiGetDnsServerReq;

typedef struct NmAtiSetDnsServerReq_Tag
{
    UINT8       cid;
    NmNetIfDnsCfg dnsCfg;
}NmAtiSetDnsServerReq;

typedef struct NmAtiClearDnsCacheReq_Tag
{

    BOOL        bAll;
    UINT8       rsvd0;
    UINT16      rsvd1;
    CHAR        name[DNS_MAX_NAME_LENGTH];
}NmAtiClearDnsCacheReq;

typedef struct NmAtiSetDnsCacheReq_Tag
{

    BOOL        bEanble;
    UINT8       rsvd0;
    UINT16      rsvd1;
}NmAtiSetDnsCacheReq;

typedef struct NmAtiGetLanDataPathCapReq_Tag
{
    UINT8       lanType; //NmLanNetType
    UINT8       rsvd0;
    UINT16      rsvd1;
}NmAtiGetLanDataPathCapReq;

typedef struct NmAtiGetLanDataPathStatusReq_Tag
{
    UINT8       lanType; //NmLanNetType
    UINT8       rsvd0;
    UINT16      rsvd1;
}NmAtiGetLanDataPathStatusReq;

typedef struct NmAtiGetLanDataPathHostInfoReq_Tag
{
    UINT8       lanType; //NmLanNetType
    UINT8       rsvd0;
    UINT16      rsvd1;
}NmAtiGetLanDataPathHostInfoReq;


#if 0
/*
 * the netif related ip info
*/
typedef struct NmNetIpv6Info_Tag{
    ip6_addr_t  ipv6Addr;
    ip6_addr_t  ipv6LinkLocalAddr;

    UINT8       dnsNum;
    UINT8       rsvd0;
    UINT16      ipv6GetPrefixDelay;
    ip6_addr_t  dns[NM_PDN_TYPE_MAX_DNS_NUM];
}NmNetIpv6Info;   //52 bytes
#endif
/*
 * the netif related ip info
*/
typedef struct NmNetIpv6Info_Tag{
    ip6_addr_t      ipv6Addr;           /* ipv6 global addree */

    UINT8       dnsNum;
    UINT8       rsvd0;
    UINT16      rsvd1;

    ip6_addr_t  dns[NM_PDN_TYPE_MAX_DNS_NUM];
}NmNetIpv6Info;   //52 bytes


typedef struct NmNetIpv4Info_Tag{
    ip4_addr_t  ipv4Addr;

    UINT8       dnsNum;
    UINT8       rsvd0;
    UINT16      rsvd1;
    ip4_addr_t  dns[NM_PDN_TYPE_MAX_DNS_NUM];
}NmNetIpv4Info;   //16 bytes

/*
 * netif type
*/
typedef enum NmNetifType_Tag
{
    NM_INVALID_NETIF,
    NM_DEFAULT_NETIF,   //default netif, all socket data default to send via this netif
    NM_IMS_NETIF,       //FFS
    NM_OTHER_NETIF
}NmNetifType;


/*
 * netif status
*/
typedef enum _EPAT_NmNetifStatus_Tag
{
    /*
     * no netif created, and UE is not under dialing
    */
    NM_NO_NETIF_NOT_DIAL,

    /*
     * No netif created
     * 1> maybe UE is not registered, but already under dialing, and NETIF maybe be OK later
     * 2> or APP request one specific NETIF (by CID), which not created,
     * 3> when a NETIF deactivated
    */
    NM_NO_NETIF_OR_DEACTIVATED,

    /*
     * netif is created, but NETIF is OOS
    */
    NM_NETIF_OOS,

    /*
     * NETIF is suspend
     * When NETIF is OOS, must be also suspend, in such case, state should be set to OOS
    */
    //NM_NETIF_SUSPEND,

    /*
     * NETIF is activated
    */
    NM_NETIF_ACTIVATED,

    #if 0
    /*
     * NETIF ACTED, but some info changed, such as:
     * 1> ipv4v6 type, ipv6 RS success later, need to report NETIF changed;
     * 2> ipv4v6 two bearers, if one bearer deactivated, but another one is still exist, also need to report NETIF changed;
     * 3> This status only used for event indication report;
    */
    NM_NETIF_ACTIVATED_INFO_CHNAGED
    #endif
}NmNetifStatus;

/*
 * ps/wan net status change cause
*/
typedef enum _EPAT_NmNetifStatusChangeCause_Tag
{
    NM_STATUS_CHANGE_INVALID,
    NM_STATUS_CHANGE_LINK_UP,           /* IPV6 and IPV4 bearer/netif set up, maybe one IPV4V6 bearer, or two bearers (one Ipv4, one Ipv6) */
    NM_STATUS_CHANGE_LINK_UP_IPV4,      /* Only IPV4 bearer/netif set up */
    NM_STATUS_CHANGE_LINK_UP_IPV6,      /* Only IPV6 bearer/netif set up */

    NM_STATUS_CHANGE_RA_SUCCESS,        /* IPV6 RS succ, IPV6 full address gotten */
    NM_STATUS_CHANGE_RA_TIMEOUT,        /* IPV6 RS timeout */
    NM_STATUS_CHANGE_ENTER_OOS,
    NM_STATUS_CHANGE_EXIT_OOS,

    NM_STATUS_CHANGE_LINK_DOWN,         /* bearer/netif down, which bearer? CID indicated in: NmAtiNetifInfo->ipv4Cid/ipv6Cid */
    NM_STATUS_CHANGE_LINK_DOWN_IPV4,    /* 1> If two bearers used for this netif, this just means IPV4 bearer deactivated,
                                         *    and only IPV6 bearer now.
                                         * 2> which IPV4 bearer deactivated? indicated in: NmAtiNetifInfo->ipv4Cid.
                                        */
    NM_STATUS_CHANGE_LINK_DOWN_IPV6,    /* 1> If two bearers used for this netif, this just means IPV6 bearer deactivated,
                                         *    and only IPV4 bearer now.
                                         * 2> which IPV4 bearer deactivated? indicated in: NmAtiNetifInfo->ipv6Cid.
                                        */
    #if 0
    NM_STATUS_CHANGE_LINK_UP_PDN_IPV4_ONLY,     /* Ipv4v6 bearer request, but only ipv4 supported/activated */
    NM_STATUS_CHANGE_LINK_UP_PDN_IPV6_ONLY,     /* Ipv4v6 bearer request, but only ipv6 supported/activated */
    NM_STATUS_CHANGE_LINK_UP_PDN_SINGLE_ADDRESS_ONLY,   /* Ipv4v6 bearer request, but only ipv4 or v6 supported/activated */
    NM_STATUS_CHANGE_LINK_UP_PDN_SINGLE_ADDR_ONLY_ALLOWED_AND_SECOND_BEARER_FAILED, /* Ipv4v6 bearer request, and the second bearer act failed */
    #endif
    NM_STATUS_CHANGE_OTHERS,
}NmNetifStatusChangeCause;

/*
 * lan net status change cause
*/
typedef enum NmLanNetifStatusChangeCause_Tag
{
    NM_LAN_STATUS_CHANGE_INVALID,
    NM_LAN_STATUS_CHANGE_LINK_UP, // the bind wan has active,then the lan link up success, mabybe one IPV4IPV6 wan
    NM_LAN_STATUS_CHANGE_LINK_DOWN, // the lan link down
    NM_LAN_STATUS_CHANGE_LAN_BIND, // for nat mode, the lan link up has already,the the lan bind with one active wan
    NM_LAN_STATUS_CHANGE_LAN_UNBIND,// for nat mode, the lan link up has already,the the lan unbind with one active wan
    NM_LAN_STATUS_CHANGE_WAN_LINK_UP,// for nat mode, the lan link up has already and bind a deactive wan, than the wan active
    NM_LAN_STATUS_CHANGE_WAN_LINK_DOWN,// for nat mode, the lan link up has already and bind a active wan, than the wan deactive
    NM_LAN_STATUS_CHANGE_OTHERS,
}NmLanNetifStatusChangeCause;


#if 0
/*
 * One NETIF info
*/
typedef struct NmAtiNetifInfo_Tag
{
    UINT8               netStatus;  //NmNetifStatus
    UINT8               netifType;  //NmNetifType
    UINT8               ipType;     //NmNetIpType
    UINT8               cause;      //NmNetifStatusChangeCause

    /*
     * 1> if NETIF is ipv4v6 type:
     *    a> if two bearers created, "ipv4Cid" is for IPV4 bearer, and "ipv6Cid" is for IPV6 bearer
     *    b> if one bearer (ipv4v6) created, "ipv4Cid" = "ipv6Cid"
     * 2> if NETIF is ipv4 type
     *    a> "ipv6Cid" should set to NM_PS_INVALID_CID
     * 3> if NETIF is ipv6 type
     *    a> "ipv4Cid" should set to NM_PS_INVALID_CID
    */
    UINT8               ipv4Cid;
    UINT8               ipv6Cid;
    UINT16              mtu;  //mtu size

    NmNetIpv4Info       ipv4Info;   //first need to check "ipType", if "ipType" indicate ipv4 or ipv4v6, then this info must be valid
    NmNetIpv6Info       ipv6Info;   //first need to check "ipType", if "ipType" indicate ipv6 or ipv4v6, then this info must be valid
}NmAtiNetifInfo;    // 76 bytes
#endif

/*
 * One WAN NETIF basic info, note, these info will return to user, should be clear
*/
typedef struct NmAtiNetifInfo_Tag
{
    UINT8               netStatus;  //NmNetifStatus
    UINT8               netifType;  //NmNetifType
    UINT8               ipType;     //NmNetIpType
    UINT8               rsvd0;

    /*
     * 1> if NETIF is ipv4v6 type:
     *    a> if two bearers created, "ipv4Cid" is for IPV4 bearer, and "ipv6Cid" is for IPV6 bearer
     *    b> if one bearer (ipv4v6) created, "ipv4Cid" = "ipv6Cid"
     * 2> if NETIF is ipv4 type
     *    a> "ipv6Cid" should set to LWIP_PS_INVALID_CID
     * 3> if NETIF is ipv6 type
     *    a> "ipv4Cid" should set to LWIP_PS_INVALID_CID
     * ==================================================
     * Note, in case of "NmAtiNetInfoInd" indication.
     * These "ipv4Cid" and "ipv6Cid" maybe set to valid value, to indicate which bearer/netif is deactivated
    */
    UINT8               ipv4Cid;
    UINT8               ipv6Cid;
    UINT16              mtu;  //mtu size

    NmNetIpv4Info       ipv4Info;   //first need to check "ipType", if "ipType" indicate ipv4 or ipv4v6, then this info must be valid
    NmNetIpv6Info       ipv6Info;   //first need to check "ipType", if "ipType" indicate ipv6 or ipv4v6, then this info must be valid
}NmAtiNetifInfo;    // 76 bytes


#if 0
/*
 * Result for: NM_ATI_SYNC_GET_NET_INFO_REQ, just return NET info info
*/
typedef struct NmAtiGetNetInfoRet_Tag
{
    NmAtiNetifInfo      netifInfo;
}NmAtiGetNetInfoRet;    //76 bytes
#endif

#if 0
/*
 * NM ATI SYNC result
*/
typedef struct NmAtiSyncRet_Tag
{
    union {
        NmAtiGetNetInfoRet      netInfoRet;     //76 bytes
        NmNetIfDnsCfg           getDnsServer;   //84 bytes
    }body;
}NmAtiSyncRet;  // 84 bytes
#endif

/******************************************************************************
 * NM_ATI_NET_INFO_IND
 * NmAtiNetInfoInd
******************************************************************************/
typedef struct NmAtiNetInfoInd_Tag
{
    UINT8           indCause;      //NmNetifStatusChangeCause
    UINT8           rsvd0;
    UINT16          rsvd1;

    NmAtiNetifInfo  netifInfo;
}NmAtiNetInfoInd;


/******************************************************************************
 *****************************************************************************
 * Functions
 *****************************************************************************
******************************************************************************/

/******************************************************************************
 * NetMgrLinkUp
 * Description: net manager pdn linkup function
 * input: UINT8 cid     //which CID (CAC layer ID)
 *        NmIfConfiguration *ifConf //default bearer configuration
 *        UINT8 bindToCid   //if NW assign two bearer (one for IPV4, and another for IPV6)
 *                          // when second bearer setup, need to bind to orig "netif"
 *                          // if set to "255", just means not such case
 *        BOOL bWakeup; //whether this NETIF/bearer is linked up during sleep2/hib wake up procedure
 * output: NmResult;
 * Comment:
******************************************************************************/
NmResult NetMgrLinkUp(UINT8 cid, NmIfConfiguration *pIfCfg, UINT8 bindToCid, BOOL bWakeUp);

/*
 * Netmgr dedicated bearer linkup
*/
NmResult NetMgrDedLinkUp(UINT8 cid, UINT8 pcid, BOOL bWakeUp);

/******************************************************************************
 * NetMgrLinkDown
 * Description: netmngr pdn linkdown function
 * input: UINT8 cid
 * output: NmResult
 * Comment:
******************************************************************************/
NmResult NetMgrLinkDown(UINT8 cid);

/*
 * Netmgr default/dedicated bearer TFT config
*/
NmResult NetMgrTftConfig(UINT8 cid, UINT8 pfNum, CmiPsPacketFilter *pPFList);


/******************************************************************************
 * NetMgrLanLinkLayerStatusChange
 * Description: notify the tcpip stack the LAN device link layer status change
 * input: (NmLanType type, NmLanLinkStatus newStatus)
 * output:
 * return: NmResult
 * Comment: called by rndis/ppp service or psdial
 * the default link layer status of LAN is disconnected, and if the status has been change, it must be notify to tcpip stack by this API
******************************************************************************/
NmResult NetMgrLanLinkLayerStatusChange(NmLanType type, NmLanLinkStatus newStatus);


/******************************************************************************
 * NetMgrGetNetInfo
 * Description: get UE wan net info
 * input: UINT8 cid, NmAtiGetNetInfoRet *wanInfo
 * output: NmResult
 * Comment: called by app
 * if cid is LWIP_PS_INVALID_CID, will return default netif status
******************************************************************************/
NmResult NetMgrGetNetInfo(UINT8 cid, NmAtiNetifInfo *pWanInfo);

/******************************************************************************
 * NetMgrGetNetInfoWithoutPsStatusCheck
 * Description: get UE wan net info
 * input:   UINT8 cid, NmAtiNetifInfo *pNetifInfo
 * output:  NmResult
 * Comment: In this API not check whether PS is started, this API is only called
 *          by ESM, as ESM maybe call it to get IPV6 address during wakeup procedure
******************************************************************************/
NmResult NetMgrGetNetInfoWithoutPsStatusCheck(UINT8 cid, NmAtiNetifInfo *pNetifInfo);


/******************************************************************************
 * NetMgrGetDnsServerInfo
 * Description: get UE dns server config
 * input: UINT8 cid, NmNetIfDnsCfg *pGetDnsServer
 * output: NmResult
 * Comment: called by app
******************************************************************************/
NmResult NetMgrGetDnsServerInfo(UINT8 cid, NmNetIfDnsCfg *pGetDnsServer);

/******************************************************************************
 * NetMgrSetDnsServerInfo
 * Description: set UE dns cache
 * input: UINT8 cid, UINT8 number, ip_addr_t dns[NM_MAX_DNS_NUM]
 * output: NmResult
 * Comment: called by app
******************************************************************************/
NmResult NetMgrSetDnsServerInfo(UINT8 cid, UINT8 number, ip_addr_t dns[NM_MAX_DNS_NUM]);

/******************************************************************************
 * NetMgrClearDnsServerInfo
 * Description: clear UE dns cache
 * input: UINT8 cid, NmAtiGetNetInfoRet *wanInfo
 * output: NmResult
 * Comment: called by app
******************************************************************************/
NmResult NetMgrClearDnsCacheInfo(BOOL bClearAll, CHAR name[DNS_MAX_NAME_LENGTH]);

/******************************************************************************
 * NetMgrSetDnsCache
 * Description: enable/sidable dns cache
 * input: BOOL bEnable
 * output: NmResult
 * Comment: called by app
******************************************************************************/
NmResult NetMgrSetDnsCache(BOOL bEnable);


/*
 * Send NET (NETIF) info (status)
*/
void NetMgrSendNetInfoInd(NmAtiNetInfoInd *pNetInfoInd);

/*
 * Proc "CMI_PS_GET_CEREG_CNF"
*/
void NetMgrProcCeregCnf(CmiPsGetCeregCnf *pCregCnf);

/*
 * Proc "CMI_PS_CEREG_IND"
*/
void NetMgrProcCeregInd(CmiPsCeregInd *pCregInd);


/*
 * net mgr lan configuration for tcpip data path
*/
NmResult NetMgrLanConfig(NetMgrLanCfg *lanCfg);

/*
 * net mgr lan ctrl api(control the lan data path wether bind with pdp context)
 * if the same lan type has bind, it will be replace with the new pdp context
 * if the related lan tcpip data path has been actived,then you can not bind with the new pdp context, and it will return error
*/
NmResult NetMgrLanCtrl(NmLanCtrlAction action, NmLanNetType type, UINT8 ip4Cid, UINT8 ip6Cid);


/*
 * query the lan tcpip data path capability, called by CCIO, to descide whether can do lan link up
*/
NmResult NetMgrQueryLanTcpipDataPathCapability(NmLanNetType lanType, NetMgrLanDataPathCap *pLanDataPathCap);


/******************************************************************************
 * NetMgrLanLinkUp
 * Description: netmngr establish LAN TCPIP data path function
 * input:
 * output:
 * return: NmResult
 * Comment: called by rndis/ppp service
******************************************************************************/
NmResult NetMgrLanLinkUp(NmLanType lanType, BOOL bWakeUp, UINT16 mtu);

/******************************************************************************
 * NetMgrLanDataPathDown
 * Description: netmngr LAN data path  disconnect function
 * input: UINT8 lanChannelId(channel[NM_LAN_RNDIS_CHANNEL_ID]->rndis/ecm, channel[NM_LAN_PPP_CHANNEL_ID]->ppp)
 * output:
 * return:NmResult
 * Comment:called by psdial or ps event(NM_ATI_NET_INFO_IND) callback or rndis/ppp service
******************************************************************************/
NmResult NetMgrLanLinkDown(NmLanType lanType);


/*
 * net mgr query lan tcpip data path status api
*/
NmResult NetMgrGetLanTcpipDataPathStatus(NmLanNetType lanType, NetMgrLanChannelTcpipDataPathStatus *status);

/*
 * notify the CMS/psdial the LAN info
*/
void NetMgrNotifyAtiLanInfoInd(NmAtiLanInfo *pAtiLanInfo);

/*
 * net mgr query lan tcpip data path host info api
*/
NmResult NetMgrGetLanTcpipDataPathHostInfo(NmLanNetType lanType, NetMgrLanTcpipDataPathHostInfo *info);


#endif

