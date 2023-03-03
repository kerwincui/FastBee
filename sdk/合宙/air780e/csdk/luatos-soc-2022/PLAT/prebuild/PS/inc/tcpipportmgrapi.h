/******************************************************************************
 ******************************************************************************
 Copyright:      - 2020- Copyrights of AirM2M Ltd.
 File name:      - tcpipportmgrapi.h
 Description:    - tcpip TCP/UDP port manager API:
 History:        - 12/25/2020 xwang
 ******************************************************************************
******************************************************************************/

#ifndef TCPIP_PORT_MGR_API_H
#define TCPIP_PORT_MGR_API_H

#include "commontypedef.h"

#define TCPIP_IP_TYPE_4   4
#define TCPIP_IP_TYPE_6   6

typedef enum
{
    PORT_MGR_CONN_SOURCE_INVALID            = 0,
    PORT_MGR_CONN_SOURCE_UE                 = 1,
    PORT_MGR_CONN_SOURCE_HOST_ETH           = 2,
    PORT_MGR_CONN_SOURCE_HOST_PPP           = 3,
    PORT_MGR_CONN_SOURCE_HOST_ETH_SECONDARY = 4,
    PORT_MGR_CONN_SOURCE_HOST_PPP_SECONDARY = 5,
    PORT_MGR_CONN_SOURCE_NW                 = 6,
    PORT_MGR_CONN_SOURCE_ANY                = 7,

}PortMgrConnSource;

typedef enum
{
    PORT_MGR_CONN_DEST_UNDEFINE         = 0,
    PORT_MGR_CONN_DEST_UE               = 1,
    PORT_MGR_CONN_DEST_HOST             = 2,
    PORT_MGR_CONN_DEST_HOST_ETH         = 3,
    PORT_MGR_CONN_DEST_HOST_PPP         = 4,
    PORT_MGR_CONN_DEST_NW               = 5,
    PORT_MGR_CONN_DEST_MAPPING          = 6,

    PORT_MGR_CONN_DEST_UE_AND_HOST_ALL  = 7,
    PORT_MGR_CONN_DEST_UE_AND_NW        = 8,
    PORT_MGR_CONN_DEST_HOST_DNS_PKG     = 9,
    PORT_MGR_CONN_DEST_HOST_ETH_DNS_PKG = 10,
    PORT_MGR_CONN_DEST_HOST_PPP_DNS_PKG = 11,
    PORT_MGR_CONN_DEST_NW_DNS_PKG       = 12,
    PORT_MGR_CONN_DEST_DHCP_REQ_PKG         = 13,

}PortMgrConnDest;

typedef enum
{
    PORT_MGR_CONN_TYPE_UDP = 0,
    PORT_MGR_CONN_TYPE_TCP = 1,
}PortMgrConnType;


UINT8 PortMgrCheckDest(UINT8 source, UINT8 destination, UINT16 sourcePort, UINT16 destPort, UINT8 ipType);

UINT16 PortMgrUlProcess(UINT8 connType, UINT8 source, UINT16 sourcePort, UINT16 destPort, UINT8 ipType, UINT8 cid);

UINT8 PortMgrDlMappingProcess(UINT8 connType, UINT16 *originalPort, UINT16 mappingPort, UINT8 ipType, UINT8 cid);

UINT16 PortMgrNewUeTcpPort(void);

UINT16 PortMgrNewUeUdpPort(void);

void PortMgrInit(void);


#endif

