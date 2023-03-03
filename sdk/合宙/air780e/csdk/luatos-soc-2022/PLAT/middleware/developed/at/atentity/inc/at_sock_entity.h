/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: at_sock_task.h
 *
 *  Description: AT SOCKET TASK, task created by SOCKET AT COMMAND
 *
 *  History:create by xwang
 *
 *  Notes:
 *
******************************************************************************/
#ifndef __AT_SOCK_TASK_H__
#define __AT_SOCK_TASK_H__

#include "at_util.h"
#include "lwip/api.h"
#include "cms_sock_mgr.h"

/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/


#define ATECSKTREQ_MAGIC 0x1234
#define ATECSKTHANDLE_PORT 60000
#define ATECSKTREQUEST_PORT 60001
#define ATECSKTCONNECTTIMEOUT 24            //seconds
#define ATSOCHIBTCPCONTEXTMAGIC 0xABCD
#define ATSOCHIBUDPCONTEXTMAGIC 0xDCBA

#define AT_SOC_MAX_REF_URL_IPADDR_LEN 255
#define AT_SOC_REF_STATE_MAX_LEN    1024
/*AT SOCKET related  define*/
#define AT_SOC_FD_MAX (CMS_SOCK_MGR_CONTEXT_NUM_MAX - 1)
#define AT_SOC_FD_MIN 0
#define AT_SOC_FD_DEF -2
#define AT_SOC_FD_ALL 255
#define AT_SOC_UL_LENGTH_MAX 1400
#define AT_SOC_UL_LENGTH_MIN 1
#define AT_SOC_DL_LENGTH_MAX 1358
#define AT_SOC_DL_LENGTH_MIN 1
#define AT_SOC_PORT_MAX 65535
#define AT_SOC_PORT_MIN 1
#define AT_SOC_UL_DATA_SEQUENCE_MAX 255
#define AT_SOC_UL_DATA_SEQUENCE_MIN 1
#define AT_SOC_UL_SEGMENT_ID_MAX  4
#define AT_SOC_UL_SEGMENT_ID_MIN  1
#define AT_SOC_UL_SEGMENT_NUM_MAX  4
#define AT_SOC_UL_SEGMENT_NUM_MIN  2
#define AT_SOC_NOTIFY_MODE_DEF 0
#define AT_SOC_NOTIFY_MODE_MIN 0
#define AT_SOC_NOTIFY_MODE_MAX 3
#define AT_SOC_NOTIFY_MODE_IGNORE 254
#define AT_SOC_NOTIFY_MODE_PRIVATE_DISABLE 255
#define AT_SOC_PUBLIC_DL_BUFFER_DEF (2048 )
#define AT_SOC_PUBLIC_DL_BUFFER_MAX 3072
#define AT_SOC_PUBLIC_DL_BUFFER_MIN 1358
#define AT_SOC_PUBLIC_DL_BUFFER_IGNORE 0XFFFF
#define AT_SOC_PRIVATE_DL_BUFFER_DEF 1358
#define AT_SOC_PRIVATE_DL_BUFFER_MAX 2048
#define AT_SOC_PRIVATE_DL_BUFFER_MIN 1358
#define AT_SOC_PRIVATE_DL_BUFFER_MIN 1358
#define AT_SOC_PRIVATE_DL_BUFFER_IGNORE 0XFFFF
#define AT_SOC_PUBLIC_DL_PKG_NUM_DEF (12)
#define AT_SOC_PUBLIC_DL_PKG_NUM_MAX 16
#define AT_SOC_PUBLIC_DL_PKG_NUM_MIN 8
#define AT_SOC_PUBLIC_DL_PKG_NUM_IGNORE 0XFF
#define AT_SOC_PRIVATE_DL_PKG_NUM_DEF 4
#define AT_SOC_PRIVATE_DL_PKG_NUM_MAX 8
#define AT_SOC_PRIVATE_DL_PKG_NUM_MIN 1
#define AT_SOC_PRIVATE_DL_PKG_NUM_IGNORE 0XFF
#define AT_SOC_IP_ADDR_STRING_LENGTH_MAX 63
#define AT_SOC_QUERY_UL_PENDING_LIST_RESPONSE_LENGTH_MAX 64



#define SUPPORT_MAX_SOCKET_NUM                5

#define SUPPORT_MAX_SOCKET_RAW_DATA_LENGTH    1400
#define SUPPORT_MAX_SOCKET_HEX_STRING_DATA_LENGTH (SUPPORT_MAX_SOCKET_RAW_DATA_LENGTH * 2 + 1)
#define SUPPORT_MAX_TCP_SERVER_LISTEN_NUM     3


#define  SUPPORT_REF_MAX_SOCKET_RAW_DATA_LENGTH    (1460 + 1)


#define  SUPPORT_REF_UL_SEND_BUFFER_MAX     (SUPPORT_REF_MAX_SOCKET_RAW_DATA_LENGTH * 5)

/******************************************************************************
 *****************************************************************************
 * ENUM
 *****************************************************************************
******************************************************************************/

typedef enum {
/***********AT SKT **************************/
    ATECSKTREQ_CREATE   = 1,
    ATECSKTREQ_BIND,
    ATECSKTREQ_CONNECT,
    ATECSKTREQ_SEND,
    ATECSKTREQ_DELETE,
    ATECSKTREQ_STATUS,
    ATECSKTREQ_MAX = 30,

/***********AT QI **************************/
    ATECQIREQ_CREATE   = 31,
    ATECQIREQ_BIND ,
    ATECQIREQ_CONNECT,
    ATECQIREQ_SEND,                /*send the raw data,may be a present string or a Hex string */
    ATECQIREQ_SENDHEX,             /*send the hex data */
    ATECQIREQ_SEND_PSTH_DATA,      /*send the data with passthrough mode */
    ATECQIREQ_GSOCK,
    ATECQIREQ_DELETE,
    ATECQIREQ_READ,
    ATECQIREQ_STATUS,
    ATECQIREQ_SETDATAACCMODE,
    ATECQIREQ_GETDATAACCMODE,
    ATECQIREQ_MAX= 50,

/**********AT EC SOC**********************************/
    ECSOCREQ_CREATE     = 51,
    ECSOCREQ_UDPSEND,
    ECSOCREQ_UDPSENDF,
    ECSOCREQ_QUERY,
    ECSOCREQ_READ,
    ECSOCREQ_TCPCONNECT,
    ECSOCREQ_TCPSEND ,
    ECSOCREQ_CLOSE,
    ECSOCREQ_NMI  ,
    ECSOCREQ_NMIE ,
    ECSOCREQ_GNMI ,
    ECSOCREQ_GNMIE,
    ECSOCREQ_STATUS,
    ECSOCREQ_MAX,
/***********AT EC SRV***********************************/
    ECSRVSOCREQ_CREATETCP   = 90,
    ECSRVSOCREQ_CLOSELISTEN,
    ECSRVSOCREQ_CLOSECLIENT,
    ECSRVSOCREQ_SENDCLIENT,
    ECSRVSOCREQ_STATUSLISTEN,
    ECSRVSOCREQ_MAX=  110,

/********************rsvd********************************/

    ECSKT_MAX = 255,
}AtecSktReqId;



/*
 * APPL SGID: APPL_SOCKET/APPL_ECSOC, related PRIM ID
*/
typedef enum applSockPrimId_Enum
{
    APPL_SOCKET_PRIM_BASE = 0,

    APPL_SOCKET_CREATE_CNF,   //
    APPL_SOCKET_BIND_CNF,
    APPL_SOCKET_CONNECT_CNF,
    APPL_SOCKET_SEND_CNF,
    APPL_SOCKET_DELETE_CNF,
    APPL_SOCKET_STATUS_CNF,
    APPL_SOCKET_ERROR_IND,
    APPL_SOCKET_RCV_IND,

    APPL_QISOCKET_CREATE_CNF,
    APPL_QISOCKET_BIND_CNF,
    APPL_QISOCKET_CONNECT_CNF,
    APPL_QISOCKET_SEND_CNF,
    APPL_QISOCKET_SENDHEX_CNF,
    APPL_QISOCKET_SENDPSRH_CNF,
    APPL_QISOCKET_READ_CNF,
    APPL_QISOCKET_QUERYSOCK_CNF,
    APPL_QISOCKET_DELETE_CNF,
    APPL_QISOCKET_STATUS_CNF,
    APPL_QISOCKET_SETMODE_CNF,
    APPL_QISOCKET_GETMODE_CNF,
    APPL_QISOCKET_ACCMODE_IND,
    APPL_QISOCKET_ERROR_IND,
    APPL_QISOCKET_RCV_IND,
    APPL_QISOCKET_CREATE_IND,
    APPL_QISOCKET_CLOSE_IND,

    APPL_ECSOC_CREATE_CNF,
    APPL_ECSOC_UDPSEND_CNF,
    APPL_ECSOC_UDPSENDF_CNF,
    APPL_ECSOC_QUERY_CNF,
    APPL_ECSOC_READ_CNF,
    APPL_ECSOC_TCPCONNECT_CNF,
    APPL_ECSOC_TCPSEND_CNF,
    APPL_ECSOC_CLOSE_CNF,
    APPL_ECSOC_NMI_CNF,
    APPL_ECSOC_NMIE_CNF,
    APPL_ECSOC_GNMI_CNF,
    APPL_ECSOC_GNMIE_CNF,
    APPL_ECSOC_STATUS_CNF,
    APPL_ECSOC_NMI_IND,
    APPL_ECSOC_CLOSE_IND,
    APPL_ECSOC_QUERY_RESULT_IND,
    APPL_ECSOC_GNMIE_IND,
    APPL_ECSOC_ULSTATUS_IND,
    APPL_ECSOC_STATUS_IND,
    APPL_ECSOC_CONNECTED_IND,

    APPL_ECSRVSOC_CREATE_TCP_LISTEN_CNF,
    APPL_ECSRVSOC_CLOSE_TCP_LISTEN_CNF,
    APPL_ECSRVSOC_CLOSE_TCP_CLIENT_CNF,
    APPL_ECSRVSOC_SEND_TCP_CLIENT_CNF,
    APPL_ECSRVSOC_STATUS_TCP_LISTEN_CNF,
    APPL_ECSRVSOC_CREATE_TCP_LISTEN_IND,
    APPL_ECSRVSOC_SERVER_ACCEPT_CLIENT_IND,
    APPL_ECSRVSOC_STATUS_TCP_LISTEN_IND,
    APPL_ECSRVSOC_RECEIVE_TCP_CLIENT_IND,
    APPL_ECSRVSOC_CLOSE_TCP_CONNECTION_IND,
    APPL_ECSRVSOC_SERVER_REFUSE_CLIENT_IND,

    APPL_SOCKET_PRIM_MAX = 255
}ApplSockPrimId;


/*
 * value of "ApplRetCnf->header.rc"
*/
typedef enum ApplSockRetCode_enum
{
    SOCKET_ACTION_OK   = 0,
    SOCKET_PARAM_ERROR = 1,                             //parameter error
    SOCKET_TOO_MUCH_INST = 2,                           //too much socket instance
    SOCKET_CREATE_SOCK_ERROR = 3,                       //create socket error
    SOCKET_OPERATION_NOT_SUPPORT = 4,                   //operation not support
    SOCKET_NO_FIND_CLIENT = 5,                          //operation not support
    SOCKET_CONNECT_FAIL = 6,                            //connect failed
    SOCKET_BIND_FAIL = 7,                               //bind failed
    SOCKET_SEND_FAIL = 8,                               //send failed
    SOCKET_NO_CONNECTED = 9,                            //connect failed
    SOCKET_IS_CONNECTED = 10,                           //already connected
    SOCKET_INVALID_STATUS,
    SOCKET_CONNECT_TIMEOUT,
    SOCKET_DELETE_FAIL,
    SOCKET_FATAL_ERROR,                                //fatal error
    SOCKET_NO_MEMORY,
    SOCKET_NO_MORE_DL_BUFFER_RESOURCE,
    SOCKET_CONNECT_IS_ONGOING,
    SOCKET_UL_SEQUENCE_INVALID,
    SOCKET_UNKNOWN,
}ApplSockRetCode;



typedef enum AtecSktDataRelAssistInd_Tag
{
    ATEC_SKT_DATA_RAI_NO_INFO = 0,
    ATEC_SKT_DATA_RAI_NO_UL_DL_FOLLOWED = 1,
    ATEC_SKT_DATA_RAI_ONLY_DL_FOLLOWED = 2,
    ATEC_SKT_DATA_RAI_RESERVED = 3
}AtecSktDataRelAssistIndEnum;

typedef enum {
    ATECECSOC_FAIL =    0,
    ATECECSOC_SUCCESS = 1,
}AtecEcSocUlStatus;

typedef enum AtSocketType_Tag
{
    AT_SOCKET_ATSKT = 0,
    AT_SOCKET_ECSOC = 1,
    AT_SOCKET_SDKSOC = 2,
}AtSocketTypeEnum;

typedef enum {
    SOCK_CLOSED = 0, //socket delete
    SOCK_INIT = 1, //socket create
    SOCK_CONNECTING = 2, //socket is connecting
    SOCK_CONNECTED = 3, //socket connected
}sockStatus;

typedef enum {
    MODE_PUBLIC = 0,
    MODE_PRIVATE = 1,
}EcSocModeFlag;

typedef enum {
    RCV_DISABLE = 0, //diabel receive DL packet
    RCV_ENABLE  = 1, //enable receive DL packet
}EcSocRcvControlFlag;

typedef enum {
    NMI_MODE_0 = 0, //disable notify
    NMI_MODE_1  = 1, //notify with socketid and length
    NMI_MODE_2  = 2, //notify with socketid, server address&port, length and data
    NMI_MODE_3  = 3, //notify with socketid, length and data
}EcSocNotifyIndMode;

typedef enum {
    EC_SOCK_VALID = 0, //EC socket available
    EC_SOCK_INVALID = 1, //EC socket unavailable
    EC_SOCK_FLOW_CONTROL = 2, //flow control
    EC_SOCK_BACK_OFF = 3, //back off
}EcSockStatus;



/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/******************************ATSKT related**********************************/

typedef struct AtecSktCreateReq_Tag{
    INT32 domain;
    INT32 type;
    INT32 protocol;
    UINT32 reqSource;
    void *eventCallback;
}AtecSktCreateReq;

typedef struct AtecSktSendReq_Tag{
    INT32 fd;
    UINT32 sendLen;
    UINT8 dataRai;
    BOOL dataExpect;
    UINT16 rsvd;
    UINT32 reqSource;
    UINT8 data[];
}AtecSktSendReq;

typedef struct AtecSktBindReq_Tag{
    INT32 fd;
    UINT16 localPort;
    UINT16 reserved;
    UINT32 reqSource;
    ip_addr_t localAddr;
}AtecSktBindReq;

typedef struct AtecSktConnectReq_Tag{
    INT32 fd;
    UINT16 remotePort;
    UINT16 reserved;
    UINT32 reqSource;
    ip_addr_t remoteAddr;
}AtecSktConnectReq;

typedef struct AtecSktDeleteReq_Tag{
    INT32 fd;
    UINT32 reqSource;
}AtecSktDeleteReq;

typedef struct AtecSktStatusReq_Tag{
    INT32 fd;
    UINT32 reqSource;
}AtecSktStatusReq;

typedef struct AtecSktDlInd_Tag{
    INT32 fd;
    UINT16 len;
    UINT16 rsvd;
}AtecSktDlInd;

typedef struct AtecSktCnfTag
{
    union {
        UINT32 errCode;
        INT32 fd;
        INT32 status;
    }cnfBody;
}AtecSktCnf;

typedef struct AtecSktPriMgrContext_Tag{
    UINT16 createReqHandle;
    UINT16 connectReqHandle;
}AtecSktPriMgrContext;

/******************************ECSOC related**********************************/

typedef struct EcSocCreateReq_Tag{
    INT32 type;
    INT32 protocol;
    INT32 domain;
    UINT8 receiveControl;
    UINT8 reserved;
    UINT16 listenPort;
    UINT32 reqSource;
    void *eventCallback;
    ip_addr_t localAddr;
}EcSocCreateReq;


typedef struct EcSocUdpSendReq_Tag{
    INT32 socketId;
    UINT16 remotePort;
    UINT16 length;
    UINT8 sequence;
    UINT8 segmentId;
    UINT8 segmentNum;
    UINT8 exceptionFlag;
    UINT8 raiInfo;
    UINT8 reserved1;
    UINT16 reserved2;
    UINT32 reqSource;
    ip_addr_t remoteAddr;
    UINT8 data[];
}EcSocUdpSendReq;

typedef struct EcSocQueryReq_Tag{
    UINT32 reqSource;
    BOOL bQueryAll;
    UINT8 rsvd1;
    UINT16 rsvd2;
    INT32 socketId[SUPPORT_MAX_SOCKET_NUM];
}EcSocQueryReq;

typedef struct EcSocReadReq_Tag{
    INT32 socketId;
    UINT16 length;
    UINT16 reserved;
    UINT32 reqSource;
}EcSocReadReq;

typedef struct EcSocTcpConnectReq_Tag{
    INT32 socketId;
    UINT16 remotePort;
    UINT16 reserved;
    UINT32 reqSource;
    ip_addr_t remoteAddr;
}EcSocTcpConnectReq;

typedef struct EcSocTcpSendReq_Tag{
    INT32 socketId;
    UINT16 length;
    UINT8 sequence;
    UINT8 expectionFlag;
    UINT8 raiInfo;
    UINT8 reserved1;
    UINT16 reserved2;
    UINT32 reqSource;
    UINT8 data[];
}EcSocTcpSendReq;

typedef struct EcSocCloseReq_Tag{
    INT32 socketId;
    UINT32 reqSource;
}EcSocCloseReq;

typedef struct EcSocNMIReq_Tag{
    UINT8 mode;
    UINT8 maxPublicDlPkgNum;
    UINT16 maxPublicDlBuffer;
    UINT32 reqSource;
}EcSocNMIReq;

typedef struct EcSocNMIEReq_Tag{
    INT32 socketId;
    UINT8 mode;
    UINT8 maxPublicDlPkgNum;
    UINT16 maxPublicDlBuffer;
    UINT32 reqSource;
}EcSocNMIEReq;

typedef struct EcSocNMIGetReq_Tag{
    UINT32 reqSource;
}EcSocNMIGetReq;

typedef struct EcSocNMIEGetReq_Tag{
    UINT32 reqSource;
}EcSocNMIEGetReq;

typedef struct EcSocStatusReq_Tag{
    BOOL bQuryAll;
    UINT8 rsvd1;
    UINT16 rsvd2;
    INT32 socketId;
    UINT32 reqSource;
}EcSocStatusReq;

typedef struct EcSocUlStatusReq_Tag{
    INT32 socketId;
    INT32 ulStatus;
    UINT32 sequenceBitMap[8];
}EcSocUlStatusReq;

typedef struct EcSocCreateResponse_Tag{
    INT32 socketId;
}EcSocCreateResponse;

typedef struct EcSocUdpSendResponse_Tag{
    INT32 socketId;
    UINT16 length;
    UINT16 reserved;
}EcSocUdpSendResponse;

typedef struct EcSocQueryInd_Tag{
    INT32 socketId;
    UINT8 sequence;
    UINT8 reserved1;
    UINT16 reserved2;
}EcSocQueryInd;

typedef struct EcSocReadResponse_Tag{
    INT32 socketId;
    ip_addr_t remoteAddr;
    UINT16 remotePort;
    UINT16 length;
    UINT16 remainingLen;
    UINT8 reserved;
    UINT8 data[];
}EcSocReadResponse;

typedef struct EcSocNMInd_Tag{
    INT32 socketId;
    ip_addr_t remoteAddr;
    UINT16 remotePort;
    UINT16 length;
    UINT8 modeNMI;
    UINT8 serviceType;
    UINT16 reserved2;
    CHAR data[];
}EcSocNMInd;

typedef struct EcSocTcpSendResponse_Tag{
    INT32 socketId;
    UINT16 length;
    UINT16 reserved;
}EcSocTcpSendResponse;

typedef struct EcSocGNMIResponse_Tag{
    UINT8 mode;
    UINT8 maxDlPkgNum;
    UINT16 maxDlBufferSize;
}EcSocGNMIResponse;

typedef struct EcSocGNMIEInd_Tag{
    INT32 socketId;
    UINT8 mode;
    UINT8 maxDlPkgNum;
    UINT16 maxDlBufferSize;
}EcSocGNMIEInd;

typedef struct EcSocCloseInd_Tag{
    INT32 socketId;
    INT32 errCode;
    UINT8 sockStatus;
    UINT8 accMode;
    UINT16 reserved;
}EcSocCloseInd;

typedef struct EcSocUlStatusInd_Tag{
    INT32 socketId;
    UINT8 sequence;
    UINT8 status;  //AtecEcSocUlStatus
    UINT16 reserved;
}EcSocUlStatusInd;

typedef struct EcSocStatusInd_Tag{
    INT32 socketId;
    UINT8 status;//EcSockStatus
    UINT8 rsvd;
    UINT16 backOffTimer;
}EcSocStatusInd;

typedef struct EcSocConnectedInd_Tag{
    INT32 socketId;
}EcSocConnectedInd;

typedef struct AtecSocCnfTag
{
    union {
        UINT32 errCode;
        INT32 fd;
        INT32 status;
    }cnfBody;
}AtecSocCnf;

typedef struct AtecEcSocErrCnfTag
{
    UINT32 errCode;
}AtecEcSocErrCnf;

typedef struct EcSocUlBuffer_Tag{
    UINT8 segmentId;
    UINT8 reserved;
    UINT16 length;
    struct EcSocUlBuffer_Tag *next;
    UINT8 data[];
}EcSocUlBuffer;

typedef struct EcSocUlList_Tag{
    UINT8 sequence;
    UINT8 segmentNum;
    UINT16 remotePort;
    UINT8 segmentAlready;
    UINT8 reserved1;
    UINT16 reserved2;
    ip_addr_t remoteAddr;
    struct EcSocUlList_Tag *next;
    EcSocUlBuffer *ulData;
}EcSocUlList;

typedef struct EcSocDlBufferList_Tag{
    BOOL  isPrivate; //default FALSE
    UINT8 reserved1;
    UINT16 totalLen;
    UINT16 reserved;
    UINT16 length;   /*the actual raw data length,*/
    UINT16 offSet;
    UINT16 remotePort;
    ip_addr_t remoteAddr;
    CmsSockMgrDataContext *dataContext;
    struct EcSocDlBufferList_Tag *next;

}EcSocDlBufferList;

typedef struct EcSocModeSet_Tag{
    UINT8 flag:1; //EcSocModeFlag
    UINT8 mode:2; //EcSocNotifyIndMode
    UINT8 receiveControl:1; //EcSocRcvControlFlag
    UINT8 reserved:4;
}EcSocModeSet;

typedef struct EcSocUlSequenceStatus_Tag{
    UINT32 bitmap[8];
}EcSocUlSequenceStatus;

typedef struct EcSocDlPrivateSet_Tag{
    UINT16 privateDlBufferToalSize;
    UINT16 privateDlBufferTotalUsage;
    UINT8 privateDlPkgNumMax;
    UINT8 privateDlPkgNumTotalUsage;
    UINT16 reserved;
}EcSocDlPrivateSet;

typedef struct EcSocPublicDlConfig_Tag{
    UINT32 publicDlBufferToalSize;
    UINT32 dlBuffTotalUsage;

    UINT8 publicDlPkgNumMax;
    UINT8 dlNumTotalUsage;

    UINT8 mode;
    UINT8 receiveControl;
}EcSocPublicDlConfig;

typedef struct EcsocPriMgrContext_Tag{
    UINT16 rsvd1;
    UINT16 dlTotalLen;
    UINT16 createReqHandle;
    UINT16 connectReqHandle;
    EcSocModeSet modeSet;
    EcSocDlPrivateSet dlPriSet;
    EcSocUlSequenceStatus ulSeqStatus;
    EcSocUlList *ulList; //only for udp socket
    EcSocDlBufferList *dlList;
}EcsocPriMgrContext;


#define   __REF_SOCK_DEFINE_GLOBAL_VARIABLES__

/***************************** ref related ***********************************/


typedef enum AtRefSocServiceType_Tag
{
    ATEC_REF_SOCK_TCP_CLIENT_MODE = 0,
    ATEC_REF_SOCK_UDP_CLIENT_MODE,
    ATEC_REF_SOCK_TCP_SERVER_MODE,
    ATEC_REF_SOCK_TCP_SERVER_ACCEPT_CLIENT_MODE,
    ATEC_REF_SOCK_UDP_SERVER_MODE,
    ATEC_REF_SOCK_UDP_SERVER_ACCEPT_CLIENT_MODE,
    ATEC_REF_SOCK_UDP_SERVER_MAX =128,
}AtRefSocServiceType;

typedef struct atRefServiceTypeTable_Tag
{
    UINT8         serviceId;
    const   CHAR *serviceName;
}atRefServiceTypeTable;


typedef struct atRefSockAccPathTable_Tag
{
    UINT8         accId;
    const   CHAR *accPathName;
}atRefSockAccPathTable;


typedef  enum AtRefDataAccessMode_tag {
    ATEC_REF_DATA_ACC_BUFF_MODE = 0,
    ATEC_REF_DATA_ACC_DIRECT_MODE,
    ATEC_REF_DATA_ACC_PASSTHROUGH_MODE
}AtRefataAccessMode;


typedef enum AtRefDataSendStatus_Tag{
    ATEC_REF_DATA_SEND_TO_BUFF_SUCC    =0,
    ATEC_REF_DATA_SEND_TO_BUFF_FAIL    =1,
    ATEC_REF_DATA_SEND_TO_BUFF_ONGOING =2
}AtRefDataSendStatus ;


typedef enum AtRefSockStatus_Tag{
    REF_SOCK_INIT = 0,       //"initial state
    REF_SOCK_OPENING = 1,       //"opening" state
    REF_SOCK_CONNECTED = 2, //"Connected" state
    REF_SOCK_LISTENING = 3,  //"Listening" state
    REF_SOCK_CLOSED = 4,  //"Closing" state
}AtRefSockStatus;


typedef enum AtRefSockAccPath_Tag{
    SOCK_ACC_USB_MODEM = 0,  //"usb modem port"
    SOCK_ACC_USB_AT    = 1,  //"usb AT port"
    SOCK_ACC_UART_1_AT = 2,  //UART port 1
    SOCK_ACC_MUX_1_AT  = 3,  //MUX port 1
    SOCK_ACC_MUX_2_AT  = 4,  //MUX port 2
    SOCK_ACC_MUX_3_AT  = 5,  //MUX port 3
    SOCK_ACC_MUX_4_AT  = 6,  //MUX port 4
    SOCK_ACC_MAX       = 128,
}AtRefSockAccPath;

typedef enum AtRefSockSendViewMode_Tag{
    SOCK_URC_IND_REPORT_DISABLE = 0,
    SOCK_URC_IND_REPORT_ENABLE  = 1,
}AtRefSockSendViewMode;


typedef struct AtRefSocketDlConfig_Tag{
    UINT32 dLTotaLUsage;   /*dynamic statistic the total used size*/
    UINT32 dlTotalSize;    /*defined the max size*/
}AtEcSocketDlConfig;



typedef struct AtRefSocCloseInd_Tag{
    UINT8 connectId;
    UINT8 sockStatus;
    UINT8 accMode;
    UINT8 resv0;

    INT32 errCode;
}AtRefSocCloseInd;

/*brief:AT+QISEND/AT+QISENDEX/PASSTHROUGH mode use*/
typedef struct AtRefSocketSendInfo_Tag
{
    UINT8   connectId;
    UINT8   source;
    UINT16  reqHander;  /*if set to zero, just means no sending request */

    UINT16  dataOffset;
    UINT16  requestId;

    UINT16  remotePort;
    UINT16  dataLen;

    ip_addr_t remoteAddr;
    void    *pPdu;  /*Dyn mem, raw data send to SOCK task, for feature, could be UlPduBlock*/
}AtRefSocketSendInfo;

typedef struct AtRefPassThroughSockInfo_Tag
{
    UINT8  connectId;
    UINT8  resv0;
    UINT16 reqHander;
}AtRefPassThroughSockInfo; /*4 bytes*/

typedef struct AtRefSocSendCnf_Tag{
    UINT8  primId;
    UINT8  status;
    UINT8  accMode;
    UINT8  connectId;

    UINT16 bufFreeSize;
    UINT16 resv0;

    UINT32 reqSource;

}AtRefSocSendCnf;

typedef struct AtRefSocPackQueryReq_Tag{
    UINT8      connectId;
    UINT8      recv0;
    UINT16     sendLen;
    UINT32     reqSource;
}AtRefSocPackQueryReq;

typedef struct AtRefSocPackQueryCnf_Tag{
    UINT8      connectId;
    UINT8      recv0;
    UINT16     recv1;

    UINT32     totallen;
    UINT32     ackBytesLen;
    UINT32     unAckBytesLen;
    UINT32     reqSource;
}AtRefSocPackQueryCnf;

/* AT+QIRD */
#define MAX_READ_DATA_LEN   1500
typedef enum AtRefQiReadType_Tag
{
    QI_READ_TYPE_TCP_UDP_INCOMING,//<service type>: "TCP"/"UDP"/"TCP INCOMING"/"UDP INCOMING"
    QI_READ_TYPE_UDP_SERVICE,//<service type>: "UDP SERVICE"
    QI_READ_TYPE_QUERY //<read_length>,0 query read data
}AtRefQiReadType;

typedef struct AtRefQiReadReq_Tag{
    UINT8       connectId;
    BOOL        lenPresent;
    UINT16      length;

    UINT32      reqSource;
}AtRefQiReadReq;

typedef struct AtRefQiReadCnf_Tag
{
    UINT8                   type;//AtRefQiReadType
    UINT8                   resvd1;
    UINT16                  reqLength;
    UINT32                  totalRcvLen;//total receive data length
    UINT32                  haveRdLen;//have read length
    UINT16                  unreadLen;//unread length
    UINT16                  remotePort;
    ip_addr_t               remoteAddr;
    CmsSockMgrDataContext   *dataContext;
}AtRefQiReadCnf;

typedef struct AtRefSocketCreateReq_Tag{
    UINT8  cid;
    UINT8  serviceType; //AtRefSocServiceType
    UINT8  connedId;
    UINT8  accessMode;
    UINT16 remotePort;
    UINT16 localPort;
    UINT32 reqSource;
    void  *eventCallback;
    CHAR   remote[AT_SOC_MAX_REF_URL_IPADDR_LEN+1];
}AtRefSocketCreateReq;

typedef struct AtRefSocCreateResponse_Tag{
    UINT8  connectId;
    UINT8  accessMode;
    UINT16 result;
}AtRefSocCreateResponse;

typedef struct AtRefSocketCloseReq_Tag{
    UINT8 connetId;
    UINT8 rsvd;
    UINT16 timeout;
    UINT32 reqSource;
}AtRefSocketCloseReq;

typedef struct AtRefSocketDnsResolveCnf_Tag{
    UINT8 result;
    UINT8 rsvd;
    UINT16 rsvd1;
    ip_addr_t address;
    CHAR remote[AT_SOC_MAX_REF_URL_IPADDR_LEN+1];
}AtRefSocketDnsResolveCnf;


/*AT+QISTATE= */
typedef struct AtRefSocQueryStateReq_Tag{
    UINT8  reqAll;
    UINT8  queryId;
    UINT8  queryType;
    UINT8  resv0;

    UINT32 reqSource;
}AtRefSocQueryStateReq;

typedef struct AtRefSocQueryStateCnfMsg_Tag{
    UINT8   num;
    UINT8   reserv0;
    UINT16  reserv1;
    UINT8   *pdata;
}AtRefSocQueryStateCnfMsg;


typedef struct AtRefSocStateMsgBody_Tag{
    INT32     sockId;
    INT32     serverId;

    UINT8     conntextId;
    UINT8     accessMode;
    UINT8     serviceType;
    UINT8     socketState;

    UINT8     sockAccPath;
    UINT8     resv0;
    UINT16    localPort;

    UINT16    remotePort;
    UINT16    resv1;
    ip_addr_t ipAddr;
}AtRefSocStateMsgBody;


/*
 * Change socket (QISOCK) access mode, in case of
 * 1> AT+QISWTMD=<connectID>,<access_mode>  //<access_mode> 0-buffer mode, 1-direct mode, 2-pass through mode
 * 2> '+++'/DTR, transfer from 2 (pass throgh mode) to 0 (buffer mode)
*/
typedef struct AtRefSocSetDataAccModeReq_Tag{
    UINT8   connectId;
    UINT8   mode;       /* AtRefataAccessMode, 0-buffer mode, 1-direct mode, 2-pass through mode */
    UINT8   trgSrc;     /* trigger source, 0 - AT+QISWTMD, 1 - '+++', 2 - DTR */
    UINT8   resv0;

    UINT16  atHandler;  /* Request AT hander, in case of "+++"/DTR, pass the old atHandler */
    UINT16  error;
}AtRefSocSetDataAccModeReq;

typedef struct AtRefSocSetDataAccModeCnf_Tag{
    UINT8   connectId;
    UINT8   setNewmode; /* AtRefataAccessMode, 0-buffer mode, 1-direct mode, 2-pass through mode */
    UINT8   resv0;
    UINT8   trgSrc;     /* trigger source, 0 - AT+QISWTMD, 1 - '+++', 2 - DTR */

    UINT16  atHandler;
    UINT16  rsv1;
}AtRefSocSetDataAccModeCnf;


typedef struct AtRefSocNotifyAccModeInd_Tag{
    UINT8   connectId;
    UINT8   accmode;
    UINT16  result;
    UINT32  reqSource;
}AtRefSocNotifyAccModeInd;


typedef struct AtRefSocGetDataAccModeReq_Tag{
    UINT8  connectId;
    UINT8  resv0;
    UINT16 resv1 ;
    UINT32 reqSource;
}AtRefSocGetDataAccModeReq;

typedef struct AtRefSocGetDataAccModeCnf_Tag{
    UINT8  mode;
    UINT8  connectId;
    UINT16 resv0;
}AtRefSocGetDataAccModeCnf;

typedef struct AtRefSocPriMgrContext_Tag
{
    UINT8                  connectId :4;      /*connectId 1~11*/
    UINT8                  pdpContextId :4;   /*pdp contextId from 0~15*/

    UINT8                  oldAccMode:2;      /*record the old accmode before changed by AT+QISWTMD/ATO/+++*/
    UINT8                  accessMode:2;     /*accessMode 0,1,2*/
    UINT8                  sockstate:3;
    UINT8                  resv0:1;

    UINT16                 reqHandle;        /*source AT request handle */

    AtRefSocServiceType    serviceType;  /*serviceType,0~5*/
    UINT8                  resv1;
    UINT16                 remotePort;

    INT32                  errorCode ;    /*record the sockerrno when erroc occured*/

    UINT32                 ulTotalLen;      /* total ul send length,maybe this length is not the actual received length of peer */
    UINT32                 ulTotalAckedLen; /* tcp ul length of has been acked by peer */
    UINT32                 dlTotalLen;     /* total length of DL data since socket created, add when recv new data,clear it after socket disconn*/
    UINT32                 dlUnreadLen;   /* unread length of DL data*/
    EcSocDlBufferList      *pDlList;
    CHAR    remote[AT_SOC_MAX_REF_URL_IPADDR_LEN +1];
}AtRefSocPriMgrContext;


typedef struct AtRefSocHibPriMgrContext_Tag
{
    UINT8                  connectId ;       /*connectId 1~11*/
    UINT8                  pdpContextId;     /*context Id*/
    UINT16                 reqHandle;        /*source AT request handle */
    AtRefSocServiceType    serviceType;      /*serviceTypeï¼?~5*/
    AtRefataAccessMode     accessMode;       /*accessModeï¼?,1,2*/
    AtRefSockStatus        sockstate;
    UINT32                 dlTotalLen;
    UINT32                 ulTotalLen;
    UINT32                 ulTotalAckedLen; /* tcp ul length of has been acked by peer */
    UINT32                 dlUnreadLen;   /* unread length of DL data*/
}AtRefSocHibPriMgrContext;



typedef struct AtRefSocketCnf_Tag
{
    UINT32 errCode;
    union{
          /*AT+QISEND/QISENDEX to send data*/
         AtRefSocSendCnf            sendSocDataCnfMsg;

         /*AT+QISEND to query sock package*/
         AtRefSocPackQueryCnf       queryPackCnfMsg;

          /*AT+QISTATE */
         AtRefSocQueryStateCnfMsg   queryStateCnfMsg;

         /*AT+QISWTMD to set*/
         AtRefSocSetDataAccModeCnf  setAccModeCnfMsg;

          /*AT+QISWTMD to get*/
         AtRefSocGetDataAccModeCnf  getAccModeCnfMsg;


         /*AT+QIRD */
         AtRefQiReadCnf             readCnfMsg;

    }body;

}AtRefSocketCnf;


/******************************SDKAPI related**********************************/

typedef struct SdkCreateConnectionReq_Tag{
    UINT32 protocol;
    UINT32 reqTicks;
    UINT16 localPort;
    UINT16 destPort;
    ip_addr_t localAddr;
    ip_addr_t destAddr;
    void *callback;
}SdkCreateConnectionReq;

typedef struct SdkSendDataReq_Tag{
    INT32 connectionId;
    UINT32 reqTicks;
    UINT16 length;
    UINT8 sequence;
    UINT8 raiInfo;
    UINT8 data[];
}SdkSendDataReq;

typedef struct SdkCloseReq_Tag{
    INT32 connectionId;
}SdkCloseReq;

typedef struct SdkSktResult_Tag{
    INT32 result;
    union {
        INT32 connectionId;
        UINT16 sendLen;
    }body;
}SdkSktResult;
/*****************************ec server soc related****************************/
typedef struct EcSrvSocCreateTcpReq_Tag{
    INT32 domain;
    UINT8 rsvd1;
    UINT8 rsvd2;
    UINT16 listenPort;
    UINT32 reqSource;
    void *eventCallback;
    ip_addr_t bindAddr;
}EcSrvSocCreateTcpReq;

typedef struct EcSrvSocCloseTcpServerReq_Tag{
    INT32 socketId;
    BOOL bCloseClient;
    UINT8 rsvd1;
    UINT8 rsvd2;
    UINT32 reqSource;
}EcSrvSocCloseTcpServerReq;

typedef struct EcSrvSocCloseTcpClientReq_Tag{
    INT32 socketServerId;
    INT32 socketClientId;
    UINT32 reqSource;
}EcSrvSocCloseTcpClientReq;

typedef struct EcSrvSocSendTcpClientReq_Tag{
    INT32 socketClientId;
    UINT32 sendLen;
    UINT8 dataRai;
    BOOL dataExpect;
    UINT8 rsvd;
    UINT8 sequence;
    UINT32 reqSource;
    UINT8 data[];
}EcSrvSocSendTcpClientReq;

typedef struct EcSrvSocStatusTcpServerReq_Tag{
    INT32 socketId;
    UINT32 reqSource;
}EcSrvSocStatusTcpServerReq;

typedef struct EcSrcSocCreateTcpListenInd_Tag{
    INT32 result;
    INT32 socketId;
}EcSrcSocCreateTcpListenInd;

typedef struct EcSrvSocTcpAcceptClientReaultInd_Tag{
    INT32 serverSocketId;
    INT32 clientSocketId;
    UINT16 clientPort;
    UINT16 rsvd;
    ip_addr_t clientAddr;
}EcSrvSocTcpAcceptClientReaultInd;

typedef struct EcSrvSocTcpListenStatusInd_Tag{
    INT32 serverSocketId;
    INT32 status;
}EcSrvSocTcpListenStatusInd;

typedef struct EcSrvSocTcpClientReceiveInd_Tag{
    INT32   socketId;
    UINT16  length;
    UINT16  remoteIp;
    ip_addr_t remoteAddr;
    UINT8   data[];
}EcSrvSocTcpClientReceiveInd;

typedef struct EcSrvSocCloseInd_Tag{
    INT32 socketId;
    INT32 errCode;
    BOOL bServer;
    UINT8 rsvd1;
    UINT16 rsvd2;
}EcSrvSocCloseInd;

typedef struct AtecEcSrvSocErrCnf_Tag
{
    UINT32 errCode;
}AtecEcSrvSocErrCnf;


typedef struct EcSrvSocTcpRefuseClientReaultInd_Tag{
    INT32 serverSocketId;
    INT32 clientSocketId;
    UINT16 clientPort;
    UINT16 cause;
    ip_addr_t clientAddr;
}EcSrvSocTcpRefuseClientReaultInd;


typedef struct EcSrvSocPriMgrContext_Tag{
    UINT16 createReqHandle;
    UINT16 listenPort;
    INT32 fSocketId; //father socket
    ip_addr_t bindAddr;
}EcSrvSocPriMgrContext;

typedef struct AtSocketSendInfo_Tag
{
    INT32   socketId;
    UINT16  reqHander;  /*if set to zero, just means no sending request */
    UINT16  dataOffset;
    INT32   dataLen;
    BOOL    expectData;
    UINT8   raiInfo;
    UINT8   sequence;
    UINT8   source;
    UINT16  requestId;
    UINT16  remotePort;
    ip_addr_t remoteAddr;
    UINT8   data[SUPPORT_MAX_SOCKET_HEX_STRING_DATA_LENGTH];
}AtSocketSendInfo;



/******************************common related**********************************/
typedef struct AtecSktReq_Tag{
    UINT16 magic; //ATECSKTREQ_MAGIC
    UINT16 reqId;
    UINT32 reqSource;
    void* reqBody;
}AtecSktReq;

typedef struct SdkSktResponse_Tag{
    UINT16 magic; //ATECSKTREQ_MAGIC
    UINT16 reqId;
    SdkSktResult reqResult;
}SdkSktResponse;


typedef struct socketAtcmd_Tag
{
    UINT8 status;
    UINT8 atSockType; //AtSocketTypeEnum
    UINT16 createReqHandle;
    UINT16 connectReqHandle;
    UINT16 reserved;
    INT32 socketId;
    UINT8 domain;
    UINT8 type;
    UINT8 protocol;
    BOOL hibEnable;
    UINT32 connectTime;
    EcSocModeSet modeSet;
    EcSocDlPrivateSet dlPriSet;
    EcSocUlSequenceStatus ulSeqStatus;
    EcSocUlList *ulList; //only for udp socket
    EcSocDlBufferList *dlList;
    struct socketAtcmd_Tag *next;
}socketAtcmd;

typedef struct GsocketAtcmd_Tag
{
    UINT8 socketNum;
    socketAtcmd *socketList;
}GsocketAtcmd;


typedef struct EcsocConnHibPriContext_Tag{
    UINT8 domain;
    UINT8 rsvd1;
    UINT16 rsvd2;
    EcSocModeSet modeSet;
    UINT16 createReqHandle;
    EcSocDlPrivateSet dlPriSet;
}EcsocConnHibPriContext;

typedef struct AtsktConnHibPriContext_Tag{
    UINT8 domain;
    UINT8 rsvd;
    UINT16 createReqHandle;
}AtsktConnHibPriContext;


/******************************************************************************
 *****************************************************************************
 * FUNCTION/API
 *****************************************************************************
******************************************************************************/

void atecSktProessReq(CmsSockMgrRequest *atecSktReq, ip_addr_t *sourceAddr, UINT16 sourcePort, INT32 rcvRequestFd);
void atecEcsocProessReq(CmsSockMgrRequest *atecSktReq, ip_addr_t *sourceAddr, UINT16 sourcePort, INT32 rcvRequestFd);
void atecEcSrvSocProessReq(CmsSockMgrRequest *atecEcSrvSocReq, ip_addr_t *sourceAddr, UINT16 sourcePort, INT32 rcvRequestFd);
void atSktEventCallback(CmsSockMgrContext *mgrContext, CmsSockMgrEventType eventType, void *eventArg);
void atEcsocEventCallback(CmsSockMgrContext *mgrContext, CmsSockMgrEventType eventType, void *eventArg);
void atEcSrvSocEventCallback(CmsSockMgrContext *mgrContext, CmsSockMgrEventType eventType, void *eventArg);
void atSktStoreConnHibContext(CmsSockMgrContext *sockMgrContext, CmsSockMgrConnHibContext *hibContext);
void atEcsocStoreConnHibContext(CmsSockMgrContext *sockMgrContext, CmsSockMgrConnHibContext *hibContext);
void atSktRecoverConnContext(CmsSockMgrConnHibContext *hibContext);
void atecPubSocReduceDlBufferUsage(UINT16 len );


void     atSocketInit(void);
BOOL     atSockQueryCidIsActivated(UINT8 connectId);

void     atRefSocEventCallback(CmsSockMgrContext *mgrContext, CmsSockMgrEventType eventType, void *eventArg);
UINT32   atRefSocQuerySocketByConnectId(UINT8 cid);

CmsRetId atRefSockPsthSockResume(UINT16 reqHandle);
AtRefSocPriMgrContext    *atRefSocFindPSTHConnectId(UINT8 channelId);
INT32    atRefCloseSockByConnectId(UINT8 cid);


#endif

