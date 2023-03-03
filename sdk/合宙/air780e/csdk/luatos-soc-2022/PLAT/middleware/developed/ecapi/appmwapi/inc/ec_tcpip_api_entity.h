/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: tcpip_lib_event.h
 *
 *  Description: tcpip related SDK API
 *
 *  History: create by xwang
 *
 *  Notes:
 *
******************************************************************************/
#ifndef __TCPIP_LIB_TASK_H__
#define __TCPIP_LIB_TASK_H__

#include "commontypedef.h"
#include "cms_sock_mgr.h"



/******************************************************************************
 *****************************************************************************
 * ENUM
 *****************************************************************************
******************************************************************************/

typedef enum{
    TCPIP_API_REQ_CREATE_CONNECTION  = 19,
    TCPIP_API_REQ_SEND_DATA          = 20,
    TCPIP_API_REQ_CLOSE_CONNECTION   = 21,
    TCPIP_API_REQ_SEND_TOTAL_LENGTH  = 22,
    TCPIP_API_REQ_ACKED_TOTAL_LENGTH = 23,
    TCPIP_API_REQ_TCP_SEND_BUFF_LENGTH = 24
}TcpipApiRequestId;

/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/
typedef struct TcpipApiCreateConnectionReq_Tag{
    UINT32 type;
    UINT16 localPort;
    UINT16 remotePort;
    ip_addr_t localAddr;
    ip_addr_t remoteAddr;
    void *eventCallback;
    void *tcpipApiConnEventCallback;
}TcpipApiCreateConnectionReq;

typedef struct TcpipApiSendDataReq_Tag{
    UINT32 connectionId;
    UINT8 raiInfo;
    UINT8 expectFlag;
    UINT16 dataLen;
    UINT8 sequence;
    UINT8 rsvd1;
    UINT8 rsvd2;
    UINT8 data[];
}TcpipApiSendDataReq;

typedef struct TcpipApiCloseConnectionReq_Tag{
    UINT32 connectionId;
    UINT16 timeout;
    UINT16 rsvd;
}TcpipApiCloseConnectionReq;

typedef struct TcpipApiSendTotalLenReq_Tag{
    UINT32 connectionId;
}TcpipApiSendTotalLenReq;

typedef struct TcpipApiAckedTotalLenReq_Tag{
    UINT32 connectionId;
}TcpipApiAckedTotalLenReq;

typedef struct TcpipApiTcpSendBuffLenReq_Tag{
    UINT32 connectionId;
}TcpipApiTcpSendBuffLenReq;

typedef struct TcpipApiPriMgrContext_Tag{
    UINT16 createSourcePort;
    UINT16 creatTimeout;
    UINT32 startCreateTicks;
    UINT32 rcvRequestFd;
    UINT32 sendToalLen;
    UINT32 ackedTotalLen;

    /*tcpipApiConnEventCallback (): this is a callback implemented by customer ,and MUST NOT free any input DLFC memory */
    void *tcpipApiConnEventCallback;
    ip_addr_t createSourceAddr;
    UINT32 bitmap[8];
}TcpipApiPriMgrContext;

typedef struct TcpipCreateConnResult_Tag{
    INT32 connectionId;
    INT32 cause;
}TcpipCreateConnResult;

typedef struct TcpipSendDataResult_Tag{
    INT32 sendLen;
    INT32 cause;
}TcpipSendDataResult;

typedef struct TcpipCloseResult_Tag{
    INT32 result;
    INT32 cause;
}TcpipCloseResult;

typedef struct TcpipSendTotalLenResult_Tag{
    INT32 result;
    UINT32 totalLen;
}TcpipSendTotalLenResult;

typedef struct TcpipAckedTotalLenResult_Tag{
    INT32 result;
    UINT32 totalLen;
}TcpipAckedTotalLenResult;

typedef struct TcpipTcpSendBuffLenResult_Tag{
    INT32 result;
    UINT32 sendBuffLen;
}TcpipTcpSendBuffLenResult;

typedef struct TcpipApiConnHibPriContext_Tag{
    UINT32 sendTotalLen;
    UINT32 ackedTotalLen;
    void *tcpipApiConnEventCallback;
}TcpipApiConnHibPriContext;


/******************************************************************************
 *****************************************************************************
 * FUNCTION/API
 *****************************************************************************
******************************************************************************/

void tcpipApiProessReq(CmsSockMgrRequest *atecSktReq, ip_addr_t *sourceAddr, UINT16 sourcePort, INT32 rcvRequestFd);
void tcpipApiEventCallback(CmsSockMgrContext *mgrContext, CmsSockMgrEventType eventType, void *eventArg);
BOOL tcpipCheckHibMode(CmsSockMgrContext *mgrContext);
void tcpipApiStoreConnHibContext(CmsSockMgrContext *sockMgrContext, CmsSockMgrConnHibContext *hibContext);
void tcpipApiRecoverConnContext(CmsSockMgrConnHibContext *hibContext);








#endif

