
/******************************************************************************
 ******************************************************************************
 Copyright:      - 2018- Copyrights of AirM2M Ltd.
 File name:      - appmgr.h
 Description:    - tcpip app manage function header
 History:        - 08/01/2021, Originated by xwang
 ******************************************************************************
******************************************************************************/
#ifndef TCPIP_APP_MGR_HDR_H
#define TCPIP_APP_MGR_HDR_H

#include "commontypedef.h"
#include "lwip/opt.h"
#include "lwip/ip_addr.h"
#include "cmips.h"

/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/

/*
 * default setting for ping
*/
#define NM_PING_DEFAULT_COUNT       15
#define NM_PING_KEEP_COUNT          255
#define NM_PING_DEFAULT_PAYLOAD_SIZE    32
#define NM_PING_DEFAULT_TIMEOUT     20  //20s


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
    APP_MGR_SUCCESS = 0,
    APP_MGR_FAIL = 1,
}AppMgrResult;


/******************************************************************************
 * ECIPERF related
******************************************************************************/
/*
 * iperf mode type
*/
typedef enum NmIperfAction_Enum
{
    NM_IPERF_STOP_ALL = 0,
    NM_IPERF_START_CLIENT = 1,
    NM_IPERF_STOP_CLIENT = 2,
    NM_IPERF_START_SERVER = 3,
    NM_IPERF_START_UDP_NAT_SERVER = 4,   //special mode
    NM_IPERF_STOP_SERVER = 5
}NmIperfAction;

/*
 * iperf network domain type
*/
typedef enum NmIperfProtocol_Enum
{
    NM_IPERF_PROTOCOL_UDP = 0,
    NM_IPERF_PROTOCOL_TCP = 1,
}NmIperfProtocol;

typedef struct NmIperfReq_Tag
{
    UINT8       reqAct;     //NmIperfAction
    UINT8       protocol;   //NmIperfProtocol
    UINT16      port;       //client/server UDP/TCP port

    BOOL        destAddrPresent;
    BOOL        tptPresent;
    BOOL        payloadSizePresent;
    BOOL        pkgNumPresent;

    ip_addr_t   destAddr;   //client, or UDP NAT server DEST address, 20 bytes
    UINT32      tpt;        //client through put setting, in bps, such as: 20000, just means 20000 bps

    UINT16      payloadSize;//client parameter
    UINT16      pkgNum;     //client parameter

    BOOL        durationPresent;
    BOOL        rptIntervalPresent;
    UINT16      rsvd0;

    UINT16      durationS;      //client/server parameter, in seconds
    UINT8       rptIntervalS;   //report internal in seconds
    UINT8       rsvd1;

    UINT16      reqHandle;
    UINT16      rsvd2;
}NmIperfReq;    //46 bytes


/******************************************************************************
 * NM_ATI_PRIM_GT_DNS_REQ
 * DNS query to get URL IP ADDR
******************************************************************************/
#define NM_MAX_URL_STR_LEN  256

typedef struct NmAtiGetDnsReq_Tag
{
    BOOL bDisableCache;
    UINT8 rsdv1;
    UINT8 rsdv2;
    CHAR        url[NM_MAX_URL_STR_LEN];
}NmAtiGetDnsReq;

typedef struct NmAtiGetDnsCnf_Tag
{
    u32_t ttl;
    ip_addr_t addrInfo[LWIP_DNS_RESULT_NUM_MAX]; //now support multiple dns result
}NmAtiGetDnsCnf;


/******************************************************************************
 * NM_ATI_PRIM_PING_RESULT_IND
******************************************************************************/
typedef enum NmPingResultEnum_Tag
{
    NM_PING_RET_DONE,       //ping succ, and ping done
    NM_PING_RET_ONE_SUCC,   //One ping is succ, and maybe ping is still ongoing
    NM_PING_RET_ONE_FAIL,   //One ping is fail, and maybe ping is still ongoing
    NM_PING_RET_ONE_SEND_FAIL,  //One ping send fail
    NM_PING_PARAM_ERROR,    //input parameters error
    NM_PING_DNS_ERROR,      //DNS failed
    NM_PING_SOCKET_ERROR,   //socket error
    NM_PING_PDP_CONTEXT_STATUS_INVALID,
    NM_PING_ALL_FAIL,
    NM_PING_ERROR
}NmPingResultEnum;

#define NM_ATI_PING_DEST_IP_STR_LEN    40

typedef struct NmAtiPingResultIndTag
{
    UINT8   result;         //NmPingResultEnum
    UINT8   ttl;            //the TTL value from ping reply packet
    UINT16  packetLossRate; //valid when "NM_PING_RET_DONE", RATE*100, example: 23 just means: 23%

    UINT16  requestNum;     //if "NM_PING_RET_ONE_SUCC/NM_PING_RET_ONE_FAIL", set to 1
    UINT16  responseNum;    //if "NM_PING_RET_ONE_SUCC" set 1, if "NM_PING_RET_ONE_FAIL", set to 0

    /*
     * ms,
     * if "NM_PING_RET_ONE_SUCC", set RTT at this time,
     * if "NM_PING_RET_ONE_FAIL", set max wait time
    */
    UINT32  minRtt;
    UINT32  maxRtt;         //ms
    UINT32  avgRtt;         //ms

    /*ping pkg payload len*/
    UINT16  payloadLen;
    UINT16  rsvd;

    /*
     * Dest IP address, in string format;
     * For Ipv4, example: "10.10.10.10"
     * For Ipv6, example: "1234:1234:1234:1234:1234:1234:1234:1234"
    */
    CHAR    pingDst[NM_ATI_PING_DEST_IP_STR_LEN];
}NmAtiPingResultInd;  //60 bytes


typedef enum NmSntpResultEnum_Tag{
    SNTP_RESULT_OK = 0,
    SNTP_RESULT_CREATE_CLIENT_SOCK_FAIL,
    SNTP_RESULT_PARAMTER_INVALID,
    SNTP_RESULT_URL_RESOLVE_FAIL,
    SNTP_RESULT_NETWORK_NOT_READY,
    SNTP_RESULT_RETRY_REACH_MAX_TIMES,
    SNTP_RESULT_PDP_CONTEXT_STATUS_INVALID,
    SNTP_RESULT_FAIL,
}NmSntpResultEnum;



typedef struct NmAtiSntpResultInd_Tag{
    UINT16 result;
    UINT16 autoSync;
    UINT32 time;
    UINT32 us;
}NmAtiSntpResultInt;


/******************************************************************************
 * NM_ATI_IPERF_RET_IND
******************************************************************************/
typedef enum NmIperfModeEnum_Tag
{
    NM_IPERF_MODE_CLIENT,       //ECIPERF tmp report for every rtpInterval, iperf task is on goging
    NM_IPERF_MODE_SERVER,   //ECIPERF the last report, iperf task end
}NmIperfModeEnum;

typedef enum NmIperfResultEnum_Tag
{
    NM_IPERF_END_REPORT_SUCCESS,   //ECIPERF the last report, iperf task end
    NM_IPERF_ONE_REPORT_SUCCESS,   //ECIPERF tmp report for every rtpInterval, iperf task is on goging
    NM_IPERF_PARAM_ERROR,   //iperf parameter error, iperf task end
    NM_IPERF_SOCKET_ERROR,  //iperf socket error, iperf task end
    NM_IPERF_MALLOC_ERROR,  //iperf task malloc fail, iperf task end
}NmIperfResultEnum;

typedef struct NmAtiIperfResultIndTag
{
    UINT8   result;   //NmIperfResultEnum
    UINT8   mode;     //NmIperfModeEnum
    UINT16  reserved;

    /*
     * "dataNum"/"bandwidth" only valid when
     * 1> "result" == NM_IPERF_END_REPORT_SUCCESS, total pkg bytes and average bandwith (send/recv) during the whole duration;
     * 2> "result" == NM_IPERF_ONE_REPORT_SUCCESS, total pkg bytes and bandwith (send/recv) during report interval
    */
    UINT32  dataNum;    //client mode, total send packet bytes; for server mode, total receive packet bytes
    UINT32  bandwidth;  //bps
}NmAtiIperfResultInd;


/******************************************************************************
 *****************************************************************************
 * Functions
 *****************************************************************************
******************************************************************************/

/******************************************************************************
 * AppMgrPingRequest
 * Description: appmgr ip ping request function
 * input: NmIpAddr *pDest   //ping DEST IP address info
 *        UINT8 tFlag       //ping count, if set "255", just means keep ping, default value 15
 *        UINT16 payloadLen     //ping payload byte len, default: 32; ping pkg size: 28(ping ICMP header)+32 = 60
 *        UINT32 timeout    //set wait time for one ping pkg
 *        BOOL   raiFlag    //whether enable rai info flag
 *        UINT8   cid // pdp context id
 * output: AppMgrResult
 * Comment:
******************************************************************************/
AppMgrResult AppMgrPingRequest(ip_addr_t *pDest, UINT8 count, UINT16 payloadLen, UINT32 timeout, BOOL raiFlag, UINT16 reqHandle, UINT8 cid);

/******************************************************************************
 * AppMgrPingUrlRequest
 * Description: appmgr url ping request function
 * input: const CHAR* pingTarget,
 *        UINT8 count,
 *        UINT16 payloadLen,
 *        UINT32 timeout
 *        BOOL   raiFlag    //whether enable rai info flag
 *        UINT8   cid // pdp context id
 * output:
 * Comment:
******************************************************************************/
AppMgrResult AppMgrPingUrlRequest(const CHAR* pingTarget, UINT8 count, UINT16 payloadLen, UINT32 timeout, BOOL raiFlag, UINT16 reqHandle, UINT8 cid);

/******************************************************************************
 * AppMgrPingTerminate
 * Description: appmgr ping request terminate function
 * input:
 * output:
 * Comment:
******************************************************************************/
void AppMgrPingTerminate(void);


/******************************************************************************
 * AppMgrPingRunStatus
 * Description: appmgr get ping run status function
 * input:
 * output:
 * Comment:
******************************************************************************/

BOOL AppMgrPingRunStatus(void);


/*
*the reference AT command format: AT^ECIPERF:<action>,[protocol],["ipaddr"],[port],[tpt],[pkg_payload_size],[pkg_num],[duration],[rpt_interval]
*1 action:NmIperfAction
*1.1 client mode: must param <action>,<"ipaddr">,<tpt>
*1.2 server mode: must param <action>
*1.3 nat server mode: must param <action>,<"ipaddr">
*2 protocol: default udp
*3 "ipaddr": ipv4 or ipv6
*3.1 dst addr for client mode [must]
*3.2 remote client address for nat server mode [must]
*4 port: default 5001
*4.1 server rcv port for server mode
*4.2 dst port for client mode
*5 tpt: throughput
*6 pkg_payload_size: max -> MTU-28
*7 pkg_num
*8 duration
*9 rtp_interval: default 10 seconds
*/

/******************************************************************************
 * NetMgrIperfRequest
 * Description: appmgr iperf request function
 * input: NmIperfReq *pIperfReq
 * output: AppMgrResult
 * Comment:
******************************************************************************/
AppMgrResult AppMgrIperfRequest(NmIperfReq *pIperfReq);

/******************************************************************************
 * AppMgrSntpStart
 * Description: appmgr sntp start function
 * input: sntp server address and server port
 * output: AppMgrResult
 * Comment:
******************************************************************************/
AppMgrResult AppMgrSntpStart(CHAR *server, UINT16 port, UINT16 reqHandler, BOOL autoSync, UINT8 cid);

/******************************************************************************
 * AppMgrSntpStop
 * Description: appmgr stop sntp function
 * input:
 * output:
 * Comment:
******************************************************************************/
void AppMgrSntpStop(void);

/******************************************************************************
 * AppMgrSntpRunStatus
 * Description: appmgr get sntp run status function
 * input:
 * output:
 * Comment:
******************************************************************************/

BOOL AppMgrSntpRunStatus(CHAR *serverAddr, UINT16 *serverPort, UINT8 *cid);

/*
 * Send URL DNS result
*/
void AppMgrSendGetDnsCnf(INT32 result, ip_addr_t *pIpInfo, UINT16 srcHdr);


/*
 * Send PING result
*/
void AppMgrSendPingResultInd(NmAtiPingResultInd *pPingRet, UINT16 reqHandle);

/*
 * Send ECIPERF result
*/
void AppMgrSendIperfResultInd(NmAtiIperfResultInd *pIperfRet, UINT16 reqHandle);

/*
 * Send SNTP result
*/
void AppMgrSendSntpResultInd(NmAtiSntpResultInt *pSntpRet, UINT16 reqHandle);

/*
 * Send SNTP result
*/
AppMgrResult AppDnsResolve(CHAR *url, UINT8 cid, UINT16 srcHandler, UINT8 bCache);



#endif

