/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: cms_sock_mgr.h
 *
 *  Description: cms socket manager API header file
 *
 *  History:create by xwang
 *
 *  Notes:
 *
******************************************************************************/

#ifndef __CMS_SOCK_MGR_H__
#define __CMS_SOCK_MGR_H__

#include "commontypedef.h"
#include "cmicomm.h"
#include "ip_addr.h"
#include "pssys.h"
#include "lwip/opt.h"

#include "apmu_external.h"


/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/

#define  CMS_LIMIT_DL_BUFFER_OPT


#define CMS_SOCK_MGR_CONTEXT_NUM_MAX 12
#define CMS_SOCK_MGR_CLIENT_PORT 60002
#define CMS_SOCK_MGR_SERVER_PORT 60003
#define CMS_SOCK_MGR_ASYNC_REQUEST_MAGIC 0x1234
#define CMS_SOCK_MGR_SYNC_REQUEST_MAGIC 0x4321
#define CMS_SOCK_MGR_EVENT_MAGIC 0x1111
#define CMS_SOCK_MGR_RESPONSE_LEN_MAX 256   //bytes

#define CMS_SOCK_MGR_CONNECT_TIMEOUT 31            //seconds

#define CMS_SOCK_MGR_UL_DATA_SEQUENCE_MAX 255
#define CMS_SOCK_MGR_UL_DATA_SEQUENCE_MIN 1

#define CMS_SOCK_MGR_DNS_RESOLVE_RESULT_REQ_ID 200

#define CMS_SOCK_MGR_MESSAGE_MAGIC 0xAABB
#define CMS_SOCK_MGR_MESSAGE_LENGTH_MAX 124

#define CMS_SOCK_MGR_CONTEXT_MAGIC 0xABCD
#define CMS_SOCK_MGR_TCP_CONTEXT_MAGIC 0xBCDA
#define CMS_SOCK_MGR_UDP_CONTEXT_MAGIC 0xCDAB

#define CMS_SOCK_MGR_HIB_PRIVATE_CONTEXT_MAX_LENGTH 32

#define CMS_SOCK_MGR_DATA_HEADER_LENGTH_MAX 64

#define CMS_SOCK_ONE_MGR_DL_LENGTH_MAX 1460

#ifdef   CMS_LIMIT_DL_BUFFER_OPT
#define  CMS_SOCK_TOTAL_MGR_DL_LENGTH_MAX  (12*1024)   //max 12K DL PDU buffer
#else
#define  CMS_SOCK_TOTAL_MGR_DL_LENGTH_MAX  (20*1024)   //max 20K DL PDU buffer
#endif

#define CMS_SOCK_MGR_SELECT_WAIT_TIME_MISECONDS     (500)   //Microseconds

#define CMS_SOCK_RECV_RAWDATA_PADDING_LEN   (10)
#define CMS_SOCK_UL_PENDING_TIMEOUT_SECONDS_MAX (10)

#define CMSSOCKMGR_CHECK_SOURCE(source) (((source) > (SOCK_SOURCE_MINI)) && ((source) < (SOCK_SOURCE_MAX)))
#define CMSSOCKMGR_CHECK_TYPE(type) (((type) == (SOCK_CONN_TYPE_UDP)) || ((type) == (SOCK_CONN_TYPE_TCP)))

#define CMSSOCKMGR_EXPECT_CLIENT_SOCKET_ID (MEMP_NUM_NETCONN + LWIP_SOCKET_OFFSET - 2)
#define CMSSOCKMGR_EXPEXT_SERVER_SOCKET_ID (MEMP_NUM_NETCONN + LWIP_SOCKET_OFFSET - 1)



/*this define how long to report close event under connect state*/
#define CMS_SOC_REF_SOCK_TIMEOUT_MAX          (30)


/******************************************************************************
 *****************************************************************************
 * ENUM
 *****************************************************************************
******************************************************************************/
typedef enum{
    SOCK_MGR_MESSAGE_TYPE_REQUEST = 1,
    SOCK_MGR_MESSAGE_TYPE_EVENT   = 2,
}CmsSockMgrMessageType;


typedef enum{
    SOCK_CONN_TYPE_UDP = 1,
    SOCK_CONN_TYPE_TCP = 2,
}CmsSockMgrConnType;

typedef enum{
    SOCK_MGR_DATA_TYPE_RAW = 1,
    SOCK_MGR_DATA_TYPE_HEX_STRING = 2,
}CmsSockMgrDataType;


typedef enum{
    SOCK_SOURCE_MINI   = 0,
    SOCK_SOURCE_ATSKT     ,
    SOCK_SOURCE_ECSOC     ,
    SOCK_SOURCE_ATQIREF   ,
    SOCK_SOURCE_SDKAPI    ,
    SOCK_SOURCE_ECSRVSOC  ,
    SOCK_SOURCE_MAX       ,
}CmsSockMgrSource;

typedef enum{
    SOCK_EVENT_CONN_STATUS               = 0,
    SOCK_EVENT_CONN_DL                   = 1,
    SOCK_EVENT_CONN_UL_STATUS            = 2,
    SOCK_EVENT_CONN_ERROR                = 3,
    SOCK_EVENT_CONN_TCP_ACCEPT_CLIENT    = 4, //for tcp server mode, accept client connection event
    SOCK_EVENT_CONN_TCP_REFUSE_CLIENT    = 5,
    SOCK_EVENT_CONN_UL_TOTAL_STATUS      =6,
    SOCK_EVENT_PROC_UL_PENDINGLIST       =7,


    SOCK_EVENT_PROC_CONNECT_TIMEOUT_CLOSE   = 8,  /* this error is :
                                           1> received the error event under connect state
                                           2> dl data list has pendding data
                                          */
    SOCK_EVENT_CONN_MAX     = 255,
}CmsSockMgrEventType;

typedef enum{
    SOCK_CONN_STATUS_CLOSED     = 0,
    SOCK_CONN_STATUS_CREATED    = 1,
    SOCK_CONN_STATUS_CONNECTING = 2,
    SOCK_CONN_STATUS_CONNECTED  = 3,
    SOCK_CONN_DNS_RESOLVING     = 4,
    SOCK_CONN_STATUS_CLOSING    = 5,
}CmsSockMgrConnStatus;

typedef enum{
    SOCK_MGR_IND_UL_STATUS              = 1,
    SOCK_MGR_IND_UL_TOTAL_LEN_STATUS    = 2,
}CmsSockMgrInd;

typedef enum{
    SOCK_CONN_UL_STATUS_SUCCESS = 0,
    SOCK_CONN_UL_STATUS_FAIL    = 1,
}CmsSockMgrConnUlStatus;

typedef enum{
    SOCK_MGR_ACTION_OK      = 1,
    SOCK_MGR_ACTION_TIMEOUT = 2,
    SOCK_MGR_ACTION_FAIL    = 3,
}CmsSockMgrActionResult;

typedef enum {
    SOCK_MGR_UL_SEQUENCE_STATE_DISCARD = 0,
    SOCK_MGR_UL_SEQUENCE_STATE_SENT = 1,
}CmsSockMgrUlStatusResult;

typedef enum {
    /*
     * 401 - 500 are reserved for socket error
    */
    CME_SOCK_MGR_ERROR_BASE = 401,
    CME_SOCK_MGR_ERROR_PARAM_ERROR,                             //parameter error
    CME_SOCK_MGR_ERROR_TOO_MUCH_INST,                           //too much socket instance
    CME_SOCK_MGR_ERROR_CREATE_SOCK_ERROR,                       //create socket error
    CME_SOCK_MGR_ERROR_OPERATION_NOT_SUPPORT,                   //operation not support
    CME_SOCK_MGR_ERROR_NO_FIND_CLIENT,                          //operation not support
    CME_SOCK_MGR_ERROR_CONNECT_FAIL,                            //connect failed
    CME_SOCK_MGR_ERROR_BIND_FAIL,                               //bind failed
    CME_SOCK_MGR_ERROR_SEND_FAIL,                               //send failed
    CME_SOCK_MGR_ERROR_NO_CONNECTED,                            //connect failed
    CME_SOCK_MGR_ERROR_IS_CONNECTED,                           //already connected
    CME_SOCK_MGR_ERROR_INVALID_STATUS,
    CME_SOCK_MGR_ERROR_CONNECT_TIMEOUT,
    CME_SOCK_MGR_ERROR_DELETE_FAIL,
    CME_SOCK_MGR_ERROR_SOCK_ERROR,                                //socket error
    CME_SOCK_MGR_ERROR_NO_MEMORY,
    CME_SOCK_MGR_ERROR_NO_MORE_DL_BUFFER_RESOURCE,
    CME_SOCK_MGR_ERROR_CONNECT_IS_ONGOING,
    CME_SOCK_MGR_ERROR_UL_SEQUENCE_INVALID,
    CME_SOCK_MGR_ERROR_SEND_REQUEST_FAIL,
    CME_SOCK_MGR_ERROR_SERVER_HASE_CREATED,
    CME_SOCK_MGR_ERROR_SET_DNS_SERVER_FAIL,
    CME_SOCK_MGR_ERROR_DNS_RESOLVE_FAIL,
    CME_SOCK_MGR_ERROR_LISTERN_FAIL,
    CME_SOCK_MGR_ERROR_SET_OPTION_FAIL,
    CME_SOCK_MGR_ERROR_PDP_CONTEXT_DEACTIVE,
    CME_SOCK_MGR_ERROR_PDP_CONTEXT_BIND_FAIL,
    CME_SOCK_MGR_ERROR_CONNECT_ID_USED,
    CME_SOCK_MGR_ERROR_UNKNOWN,

    CME_SOCK_MGR_ERROR_MAX = 500
}CmsSockMgrErrorCode;

typedef enum {
    /*
     * 0, 550 - 574 are reserved for ref socket error
    */
    CME_REF_SOCK_SUCC                       = 0, //Operation success
    CME_REF_SOCK_UNKNOWN_ERROR              = 550, //Unknown error
    CME_REF_SOCK_OPERATION_BLOCKED          = 551, //Operation blocked
    CME_REF_SOCK_INVALID_PARAM              = 552, //Invalid parameters
    CME_REF_SOCK_MEM_NOT_ENOUGH             = 553, //Memory not enough
    CME_REF_SOCK_SOCK_CREATE_FAIL           = 554, //Socket creation failed
    CME_REF_SOCK_OPERATION_NOT_SUPPORT      = 555, //Operation not supported
    CME_REF_SOCK_SOCK_BIND_FAIL             = 556, //Socket bind failed
    CME_REF_SOCK_SOCK_LISTEN_FAIL           = 557, //Socket listen failed
    CME_REF_SOCK_SOCK_WRITE_FAIL            = 558, //Socket write failed
    CME_REF_SOCK_SOCK_READ_FAIL             = 559, //Socket read failed
    CME_REF_SOCK_ACCEPT_FAIL                = 560, //Socket accept failed
    CME_REF_SOCK_PDP_CTX_OPEN_FAIL          = 561, //PDP context opening failed
    CME_REF_SOCK_PDP_CTX_CLOSE_FAIL         = 562, //PDP context closure failed
    CME_REF_SOCK_SOCK_ID_HAS_BEEN_USED      = 563, //Socket Identity has been used
    CME_REF_SOCK_DNS_BUSY                   = 564, //DNS busy
    CME_REF_SOCK_DNS_PARSE_FAIL             = 565, //DNS parse failed
    CME_REF_SOCK_SOCK_CONNECT_FAIL          = 566, //Socket connect failed
    CME_REF_SOCK_SOCK_HAS_BEEN_CLOSE        = 567, //Socket has been closed
    CME_REF_SOCK_OPERATION_BUSY             = 568, //Operation busy
    CME_REF_SOCK_OPERATION_TIMEOUT          = 569, //Operation timeout
    CME_REF_SOCK_PDP_CTX_BROKEN_DOWN        = 570, //PDP contet broken down
    CME_REF_SOCK_CANCEL_SENDING             = 571, //Cancel sending
    CME_REF_SOCK_OPERATION_NOT_ALLOWED      = 572, //Operation not allowed
    CME_REF_SOCK_APN_NOT_CONFIGURED         = 573, //APN not configured
    CME_REF_SOCK_PORT_BUSY                  = 574, //Port busy
    CME_REF_SOCK_SOCK_OPTION_SET_FAIL       = 575, //Port busy


    /*here is a internal error for showing URC to applayer*/
    CME_REF_SOCK_BUFFSIZE_NOT_ENOUGH       = 800,
    CME_REF_SOCK_MGR_ERROR_PARAM_ERROR     = 801,

    CME_REF_SOCK_MGR_WRITE_IS_ONGOING      = 802, /*in this case the send length is litter than expect length, cms will
                                                   continue to send the buffer,and NOT directly  response SEND CNF until
                                                   all raw data sent out*/
    CME_REF_SOCK_ERROR_MAX = 1024,
}CmsRefSockErrorCode;

/******************************************************************************
 *****************************************************************************
 * structure
 *****************************************************************************
******************************************************************************/

typedef struct CmsSockDlBufContext_Tag
{
   UINT16                   dlLen;       //the dl rawdata total len
   UINT16                   remotePort;
   INT32                    sockId;
   ip_addr_t                remoteAddr;
   void                    *pData;
   struct CmsSockDlBufContext_Tag  *pNext;
}CmsSockDlBufContext;

typedef struct CmsSockUlPendingPriData_Tag
{
    UINT8     accMode;   /*AcceMode: 0,buffer mode;1.direct transfer mode;3. passthrough mode*/

    UINT8     primId;    /*requst prim id*/
    UINT16    offset;    /*this flag marks the actural rawData send position when re-transmit */

    UINT32    atHandle;  /*at request handle, for response Send CNF*/
    UINT8     rawData[]; /*the actual send raw data*/

}CmsSockUlPendingPriData;


typedef struct CmsSockUlPendingList_Tag
{
   INT32     sockId;     /*the sockId*/
   UINT16    leftLen;    /*the send raw datalength*/
   UINT16    remotePort; /*remote port*/
   ip_addr_t remoteAddr; /*remote address*/

   UINT32    addTicks; /*record the time that raw data adds into pending list*/

   struct CmsSockUlPendingList_Tag *pNext;

   UINT8   pData[];
}CmsSockUlPendingList;

typedef struct CmsSockMgrContext_Tag{
    INT32   sockId;    //the socket connection id

    UINT8   source;    //CmsSockMgrSource
    UINT8   type;      //CmsSockMgrConnType
    BOOL    hibEnable; //whether the socketid enable HIB/SLEEP2 option
    UINT8   status;    //the socket connection status

    UINT8   bServer;     //the flag indicate whether the connection is or not server connection
    UINT8   hWaterOccur; //the flag that current this socket whether has reach highwater
    UINT16  localPort;

    UINT8   domain;
    UINT8   errorThenCloseFlag:1;
    UINT8   resv0: 7 ;
    UINT16  dlCacheCalLen;  /*Cal the DL buffer has Malloc but Not send out buffer size*/


    ip_addr_t localAddr;
    UINT32    connectStartTicks;
    UINT32    dlMaxLen;

    void      *eventCallback; //error/dl/ul status event callback
    CmsSockDlBufContext    *pDlBufContext;
    CmsSockUlPendingList   *pUlPendingList;
    struct CmsSockMgrContext_Tag *next;
    UINT8  priContext[]; //the sock mgr private context
}CmsSockMgrContext;

/*

*
*-------------------------------------------------------------------
               |CmsSockMgrDataContext  |                             |
*-------------------------------------------------------------------
*--------------^        dlPdu data     ^
* DlPduBlock   |          |     |      |
*--------------|          |     |      |
*^  pPdu--------|         |     --------
*|                        |
*-------------------------|
*/
typedef struct CmsSockMgrDataContext_Tag{
    UINT16 type;   //data type, CmsSockMgrDataType
    UINT16 Length; //rcv data lenghth
    UINT16 totalLen; //dlpdu->length
    UINT16 offset; // the data point of the pdu,dlPdu->pPdu + offset, init the offset as sizeof(CmsSockMgrDataContext)
    DlPduBlock *dlPdu;
    struct CmsSockMgrDataContext_Tag *pNext;
    CHAR header[CMS_SOCK_MGR_DATA_HEADER_LENGTH_MAX];
    CHAR data[];
}CmsSockMgrDataContext;

typedef struct CmsSockMgrMessage_Tag{
    UINT16 magic; //CMS_SOCK_MGR_MESSAGE_MAGIC
    UINT8  type;  //CmsSockMgrMessageType
    UINT8  rsvd;
    UINT8  body[CMS_SOCK_MGR_MESSAGE_LENGTH_MAX];
}CmsSockMgrMessage;

typedef struct CmsSockMgrRequest_Tag{
    UINT16 magic;
    UINT16 reqId;
    UINT32 reqTicks;
    UINT16 timeout;
    UINT8 source;
    UINT8 rsvd;
    void *reqBody;  /* heap memory, struct desided by "reqId" */
}CmsSockMgrRequest;

typedef struct CmsSockMgrEvent_Tag{
    UINT16 magic; //CMS_SOCK_MGR_EVENT_MAGIC
    UINT16 eventId; //CmsSockMgrInd
    UINT8  eventBody[CMS_SOCK_MGR_MESSAGE_LENGTH_MAX - 4];
}CmsSockMgrEvent;

typedef struct CmsSockMgrResponse_Tag{
    UINT8 source;
    UINT8 reqId;
    UINT16 bodyLen; // < CMSSOCKMGRRESPONSELEN_MAX
    UINT8 body[];
}CmsSockMgrResponse;

typedef struct CmsSockMgrConnStatusArg_Tag{
    UINT8 oldStatus; //CmsSockMgrConnStatus
    UINT8 newStatus;
    UINT16 cause;
}CmsSockMgrConnStatusArg;

typedef struct CmsSockMgrConnDlArg_Tag{
    UINT16 fromPort;
    UINT16 rsvd;
    ip_addr_t fromAddr;
    CmsSockMgrDataContext *dataContext;
}CmsSockMgrConnDlArg;

typedef struct CmsSockMgrConnUlStatusArg_Tag{
    UINT8 sequence;
    UINT8 status; //CmsSockMgrConnUlStatus
    UINT16 rsvd;
}CmsSockMgrConnUlStatusArg;

typedef struct CmsSockMgrConnErrArg_Tag{
    INT32 errCode;
}CmsSockMgrConnErrArg;

typedef struct CmsSockMgrConnAcceptClientArg_Tag{
    INT32 serverSocketId;
    INT32 clientSocketId;
    UINT16 clientPort;
    UINT16    rsvd;
    ip_addr_t clientAddr;
}CmsSockMgrConnAcceptClientArg;

typedef struct CmsSockUlPendingListArg_Tag{
    UINT8  failCause;  /*if failCause is not equal to 0,this is failed*/
    UINT8  resv0;
    UINT16 resv1;

    void  *pList;

}CmsSockUlPendingEventArg;


typedef struct CmsSockMgrConnRefuseClientArg_Tag{
    INT32   serverSocketId;
    INT32   clientSocketId;
    UINT16  clientPort;
    UINT16  cause;
    ip_addr_t clientAddr;
}CmsSockMgrConnRefuseClientArg;

typedef struct CmsSockMgrConnUlTotalStatusArg_Tag{
    UINT32 totalLen;
}CmsSockMgrConnUlTotalStatusArg;


enum {
    CMS_SOCK_MGR_UL_SEQUENCE_STATE_DISCARD = 0,
    CMS_SOCK_MGR_UL_SEQUENCE_STATE_SENT = 1,
};

typedef struct CmsSockMgrUlStatusInd_Tag{
    INT32 sockId;
    INT32 ulStatus;//0->success, 1->fail/discard
    UINT32 sequence_state_bitmap[8];
}CmsSockMgrUlStatusInd;

typedef struct CmsSockMgrUlTotalStatusInd_Tag{
    INT32  socketId;
    UINT32 hasSentTotalLent;
}CmsSockMgrUlTotalStatusInd;


typedef struct CmsCockMgrDnsResolveResult_tag
{
    UINT8 result;
    UINT8 rsvd0;
    UINT16 rsvd1;
    ip_addr_t addrinfo;
    CHAR url[DNS_MAX_NAME_LENGTH];
}CmsCockMgrDnsResolveResult;

typedef struct CmsSockMgrConnHibContext_Tag{
    UINT16 magic;
    UINT8 source;
    UINT8 type;
    INT32 sockId;
    UINT8 status;
    UINT8 domain;
    UINT16 localPort;
    ip_addr_t localAddr;
    void *eventCallback;
    UINT8 priContext[CMS_SOCK_MGR_HIB_PRIVATE_CONTEXT_MAX_LENGTH];
}CmsSockMgrConnHibContext;  //64 bytes

typedef struct CmsSockMgrHibContext_Tag{
    UINT16 magic; //CMS_SOCK_MGR_CONTEXT_MAGIC
    UINT16 flag;
    CmsSockMgrConnHibContext tcpContext;    //64 bytes
    CmsSockMgrConnHibContext udpContext;    //64 bytes
}CmsSockMgrHibContext;  // 92 bytes


typedef enum CmsRefSockDataFormat_Tag
{
    REF_SOCK_DATA_FORMAT_TEXT = 0,
    REF_SOCK_DATA_FORMAT_HEX = 1
}CmsRefSockDataFormat;

typedef enum CmsRefSockViewMode_Tag
{
    REF_SOCK_VIEW_MODE_HEADER_NEWLING_DATA = 0,//data header\r\ndata
    REF_SOCK_VIEW_MODE_HEADER_COMMA_DATA = 1//data header,data
}CmsRefSockViewMode;

typedef enum CmsRefSockDataTransMode_Tag
{
    REF_SOCK_DATA_TRANS_MODE_DISABLE_BLOCK = 0,//disable block mode
    REF_SOCK_DATA_TRANS_MODE_ENABLE_STREAM = 1//enable stream mode
}CmsRefSockDataTransMode;

typedef struct CmsRefSockTcpKeepAliveParam_Tag
{
    UINT16              idleTime;//cycle time to trigger keepalive, range value: 1-1800 sec
    UINT8               intervalTime;//range value:24-100 sec
    UINT8               probeCnt;//range value: 3-10
}CmsRefSockTcpKeepAliveParam;


typedef struct CmsRefSockCfgParam_Tag
{
    UINT16                              transPktSize; //transport paket size, range: 1-1460, def 1024 bytes
    UINT8                               transWaitTm; //range: 0-20, def: 2 ms
    UINT8                               rsvd;
    CmsRefSockDataFormat                sendDataFormat;
    CmsRefSockDataFormat                recvDataFormat;
    CmsRefSockViewMode                  viewMode;
    CmsRefSockDataTransMode             udpRdMode;//UPD read mode
    CmsRefSockDataTransMode             udpSendMode;//UDP send mode
    UINT8                               bPassiveClose:1;//indicated whether auto disconnect when server close enable or not
    UINT8                               bRecvInd:1;//indicated whether show length in recv URC on cache mode
    UINT8                               bTcpServerAutoAccept:1;//indicated whether TCP auto accept enable or not
    UINT8                               bTcpKeepAlive:1;//indicated whether TCP keep alive enable or not
    UINT8                               bSendEcho:1;//indicated whether echo sent data by AT+QISDE enable or not
    UINT8                               bSendInfoFlag:1 ;/*show QISEND/QISENDEX result 0 : not with URC;1: with +QISEND URC */
    UINT8                               bresv:2;
    CmsRefSockTcpKeepAliveParam         tcpKeepAliveParam;
}CmsRefSockCfgParam;  // 14 bytes

typedef void (*CmsSockMgrReqProcess)(CmsSockMgrRequest *Req, ip_addr_t *sourceAddr, UINT16 sourcePort, INT32 rcvRequestFd);

typedef void (*CmsSockMgrEventCallback)(CmsSockMgrContext *mgrContext, CmsSockMgrEventType eventType, void *eventArg);

typedef BOOL (*CmsSockMgrCheckHibMode)(CmsSockMgrContext *mgrContext);

typedef void (*CmsSockMgrStoreConnContext)(CmsSockMgrContext *sockMgrContext, CmsSockMgrConnHibContext *hibContext);
typedef void (*CmsSockMgrRecoverConnContext)(CmsSockMgrConnHibContext *hibContext);

typedef BOOL (*CmsSockMgrTcpServerProcessAcceptClient)(CmsSockMgrContext* gMgrContext, INT32 clientSocketId, ip_addr_t *clientAddr, UINT16 clientPort);

typedef struct cmsSockMgrHandleDefine_Tag{
    UINT32 source;
    CmsSockMgrReqProcess reqProcess;
    CmsSockMgrCheckHibMode hibCheck;
    CmsSockMgrStoreConnContext storeHibContext;
    CmsSockMgrRecoverConnContext recoverHibContext;
    CmsSockMgrTcpServerProcessAcceptClient tcpServerProcessAcceptClient;
}CmsSockMgrHandleDefine;

typedef struct CmsSockMgrDynamicHandleList_Tag{
    CmsSockMgrHandleDefine handle;
    struct CmsSockMgrDynamicHandleList_Tag *next;
}CmsSockMgrDynamicHandleList;

/******************************************************************************
 *****************************************************************************
 * function
 *****************************************************************************
******************************************************************************/
//get ticks
UINT32 cmsSockMgrGetCurrHibTicks(void);
UINT32 cmsSockMgrGetCurrentSysTicks(void);

//cms sock mgr context related
CmsSockMgrContext* cmsSockMgrGetContextList(void);
CmsSockMgrContext* cmsSockMgrGetFreeMgrContext(UINT16 priLen);
CmsSockMgrContext* cmsSockMgrFindMgrContextById(INT32 id);
void cmsSockMgrRemoveContextById(INT32 id);
void cmsSockMgrRemoveContext(CmsSockMgrContext *context);


//cms sock related
INT32 cmsSockMgrCreateSocket(INT32 domain, INT32 type, INT32 protocol, INT32 expect_fd);
INT32 cmsSockMgrBindSocket(INT32 fd, UINT8 domain, UINT16 localPort, ip_addr_t *localAddr);
INT32 cmsSockMgrConnectSocket(INT32 fd, UINT8 domain, UINT16 remotePort, ip_addr_t *remoteAddr, BOOL withTimeout);
INT32 cmsSockMgrCloseSocket(INT32 fd);
INT32 cmsSockMgrCreateTcpSrvSocket(INT32 domain, UINT16 listenPort, ip_addr_t *bindAddr, UINT8 listenNum, INT32 expect_fd);

CmsSockMgrConnStatus cmsSockMgrRebuildSocket(INT32 fd, ip_addr_t *localAddr, ip_addr_t *remoteAddr, UINT16 *localPort, UINT16 *remotePort, INT32 type);

CmsSockMgrConnStatus cmsSockMgrReCreateSocket(INT32 fd, INT32 domain, INT32 type);

//cms sock ul sequence status related
BOOL cmsSockMgrGetUlPendingSequenceState(UINT32 bitmap[8], UINT8 sequence);
void cmsSockMgrUpdateUlPendingSequenceBitMapState(UINT32 bitmap[8], UINT8 sequence, BOOL bActive);

//cms sock send request related
CmsSockMgrActionResult cmsSockMgrSendAsyncRequest(UINT16 reqId, void *reqBody, CmsSockMgrSource source);
CmsSockMgrActionResult cmsSockMgrSendsyncRequest(UINT16 reqId, void *reqBody, CmsSockMgrSource source, CmsSockMgrResponse *response, UINT16 timeout);

//event callback related
void csmsSockMgrCallErrorEventCallback(CmsSockMgrContext* gMgrContext, INT32 errorCode);
void cmsSockMgrCallStatusEventCallback(CmsSockMgrContext* gMgrContext, UINT8 oldStatus, UINT8 newStatus, UINT16 cause);
void cmsSockMgrCallDlEventCallback(CmsSockMgrContext* gMgrContext, CmsSockMgrDataContext *dataContext, ip_addr_t *remoteAddr, UINT16 remotePort);
void cmsSockMgrCallUlStatusEventCallback(CmsSockMgrContext* gMgrContext, UINT8 sequence, UINT8 status);
void cmsSockMgrCallProcUlPendingCallBack(CmsSockMgrContext* gMgrContext,CmsSockUlPendingList *pList,UINT8 isTimeOut);
CmsSockUlPendingList *cmsSockMgrInitUlPendingList(UINT16 len);


//cms sock hibernate related
BOOL cmsSockMgrEnableHibMode(CmsSockMgrContext *context);
CmsSockMgrContext* cmsSockMgrGetHibContext(CmsSockMgrConnType type);
void cmsSockMgrRecoverHibCallback(CmsSockMgrHibContext *hibContext);
void cmsSockMgrEnterHibCallback(void *data, APSleepState state);

//cms sock mgr init related
BOOL cmsSockMgrHandleInit(BOOL bWakeup);

//cms sock mgr handle register/unregister
BOOL cmsSockMgrRegisterHandleDefine(CmsSockMgrHandleDefine *handleDefine);
void cmsSockMgrUnregisterHandleDefine(UINT8 source);


void  cmsSockMgrSockDlCacheContext(void);
void  cmsSockMgrCallErrorEventCallback(CmsSockMgrContext* gMgrContext, UINT8 eventType,INT32 errorCode);
void  cmsSockMgrProcessWriteEvent(CmsSockMgrContext  *pMgrContext);

void  cmsSockMgrProcTimeOutEvent(void);
void  cmsSockMgrProcAcceptClientRequest(CmsSockMgrContext* gMgrContext, INT32 clientSocketId, ip_addr_t *clientAddr, UINT16 clientPort);

INT32  cmsSockMgrProcessReadEvent(CmsSockMgrContext  *pMgrContext);
INT32  cmsSockMgrProcDlCacheData(CmsSockDlBufContext   *pList);
INT32  cmsSockMgrSockRead(CmsSockMgrContext  *pMgrContext);
void   cmsSockMgrProcessErrorEvent(CmsSockMgrContext  *pMgrContext);
void   cmsSockMgrSockReCalHwater(void);
BOOL   cmsSockMgrProcDlCacheListBuffer(CmsSockMgrContext *pMgrContext);


BOOL   cmsSockMgrCheckPendingNodeIsTimeOut(CmsSockUlPendingList *pUlList);

INT32  cmsSockMgrAddUlNodeToPendingList(CmsSockMgrContext *pSockMgrContext,CmsSockUlPendingList *pAddist);

BOOL   cmsSockMgrRemvUlPendingNode(CmsSockMgrContext *pSockMgrContext,CmsSockUlPendingList *pRemoveList);

INT32  cmsSockMgrRemvUlAllPendingList(CmsSockMgrContext *pSockMgrContext);

INT32  cmsSockMgrProcUlPendingList(void);

UINT32 cmsSockMgrQueryDlfcDefinedSize(void);


#endif


