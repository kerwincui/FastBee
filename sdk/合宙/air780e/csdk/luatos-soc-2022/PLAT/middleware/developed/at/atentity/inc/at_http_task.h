/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: at_http_task.h
*
*  Description: Process http(s) client related AT commands
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _AT_HTTP_TASK_H_
#define _AT_HTTP_TASK_H_

#include "at_util.h"
#include "httpclient.h"

#define HTTP_RSP_HEAD_BUFFER_SIZE 800
#define HTTP_RSP_CONTENT_BUFFER_SIZE  1501
/*
 * APPL SGID: APPL_HTTP, related PRIM ID
*/
enum applHttpPrimId_Enum
{
    APPL_HTTP_PRIM_ID_BASE = 0,

    APPL_HTTP_SEND_CNF,
    APPL_HTTP_READ_CNF,
    APPL_HTTP_STOP_CNF,
    APPL_HTTP_FOTADL_CNF,
    APPL_HTTP_URC_IND,
    APPL_HTTP_READ_IND,

    APPL_HTTP_PRIM_ID_END = 0xFF
};

typedef enum {
    HTTPSTAT_CLOSE = 0,
    HTTPSTAT_CONNECT,
    HTTPSTAT_REQHANDL,
}HTTPAtStatus_e;

enum HTTP_CMD_TYPE
{
    HTTP_SEND_COMMAND,
    HTTP_STOP_COMMAND,
    HTTP_CLOSE_TCP_COMMAND,
};

typedef enum AT_HTTP_ERROR
{
    HTTPAT_OK = 0,                                           //success
    HTTPAT_PARAM_ERROR = 1,                                  //parameter error
    HTTPAT_INPUT_TIMEOUT = 2,                                //input timeout
    HTTPAT_NO_URL = 3,                                       //not set url
    HTTPAT_OPERATION_NOT_SUPPORT = 4,                        //operation not support
    HTTPAT_NO_REQ = 5,                                       //no request
    HTTPAT_REQ_PROCESSING = 6,                               //request processing
    HTTPAT_FILENAME_TOO_LONG = 7,                            //filename too long
    HTTPAT_NO_SUCH_FILE = 8,                                 //no file or read nothing
    HTTPAT_MEMORY_NOT_ENOUGH = 9,                            //memory not enough
    HTTPAT_CONFIG_SSL_ERROR = 10,                            //ssl config error
    HTTPAT_URL_PARSE_ERROR = 11,                             //url parse error
    HTTPAT_DNS_FAILED = 12,                                  //dns resolution failed
    HTTPAT_PRTCL_ERROR = 13,                                 //decode http data failed
    HTTPAT_SOCKET_ERROR = 14,                                //create socket failed
    HTTPAT_BIND_FAILED = 15,                                 //bind socket failed
    HTTPAT_CONNECT_TIMEOUT = 16,                             //connect timeout
    HTTPAT_CONNECT_ERROR = 17,                               //connect error
    HTTPAT_CONNECT_CLOSE = 18,                               //connect close by remote host
    HTTPAT_TLS_ERROR = 19,                                   //meet tls error 
    HTTPAT_REQ_TIMEOUT = 20,                                 //http request timeout
    HTTPAT_INTERNAL = 21,                                    //internal error
    HTTPAT_URL_ERROR = 22,                                   //url error
    HTTPAT_NOT_SUPPORT_TLS = 23,                             //tls is not supported
    HTTPAT_RECV_COMP = 100,                                  //receive complete
}AtHttpError_e;

typedef enum
{
    HTTPFOTA_BEGIN = 0,                                    //FOTA begin http download
    HTTPFOTA_DL_PROC = 1,                                  //FOTA download progress
    HTTPFOTA_ERR = 2,                                      //FOTA http error
    HTTPFOTA_DOWNLOADEND = 3,                              //FOTA http download end
    HTTPFOTA_PACKAGE_MISMATCH = 4                          //FOTA http package mismatch
}HTTPFotaUrc_e;

typedef enum
{
    HTTP_EN_SLEEP,
    HTTP_DIS_SLEEP
}HTTPSleep_e;

typedef struct{
    uint8_t contextID;
    uint8_t requestHead;
    uint8_t responseHead;
    uint8_t sslctxID;
    uint8_t contentType;
    uint8_t bRestore;
    //uint8_t autoOutrsp;
    //uint8_t closedInd;
}httpAtCfgParam_t;

typedef struct {
    HTTPAtStatus_e status;
    bool hasRequest;
    uint8_t method;
    char* url;
    HttpClientContext* clientContext;
    HttpClientData* clientData;
    uint32_t reqhandle;
    bool isRange;
    uint32_t startPos;
    int32_t endPos;
    bool isFota;
    uint8_t dlUrcRag;
    bool cache2flash;
    bool postfile;
    char* postfilename;
    bool readfile;
    char* respfilename;
    void* fp;
} httpAtContext_t;

typedef struct
{
    uint8_t cmd_type;
} httpCmdMsg_t;

typedef struct
{
    uint8_t ret;
} httpCnfCmdMsg_t;

typedef struct
{
    void *pHttpInd;
} httpIndMsg_t;

void httpSleepVote(HTTPSleep_e sleep);

bool httpClrCustNewContext(uint16_t datalen);
void httpClearAtContext(httpAtContext_t* atContext);

bool httpCreateClientContext(httpAtContext_t* atContext);

CmsRetId httpStopReq(void);
CmsRetId httpSendReq(void);
CmsRetId httpReadReq(void);

void httpSaveUrltoNvm(void);
void httpSaveConfigtoNvm(void);
AtHttpError_e httpCheckRestore(void);

void httpEngineInit(void);


#endif

