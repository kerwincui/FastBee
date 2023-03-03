/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: at_ssl_task.h
*
*  Description: Process tls client related AT commands
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _AT_SSL_TASK_H
#define _AT_SSL_TASK_H
#ifdef __USER_CODE__
#else
#include "at_util.h"
#include "atc_decoder.h"

#include "mbedtls/net.h"
#include "mbedtls/ssl.h"
#include "mbedtls/certs.h"
#include "mbedtls/entropy.h"
#include "mbedtls/ctr_drbg.h"

#define MAX_SSL_CLIENT_INSTANCE 12

typedef enum 
{
    SSL3_0 = 0,
    TLS1_0,
    TLS1_1,
    TLS1_2,
    SSL_VERSION_ALL, 
}sslVersion_e;
    
typedef enum AT_SSL_ERROR
{
    SSLAT_OK = 0,                                           //success
    SSLAT_PARAM_ERROR = 1,                                  //parameter error
    SSLAT_CONFIG_SSL_ERROR = 2,                             //ssl config error
    SSLAT_MBEDTLS_ERROR = 3,                                //mbedtls error
    SSLAT_CONN_ERROR = 4,                                   //connect error
    SSLAT_HAS_CONNENT = 5,                                  //already has a connect
    SSLAT_NO_CONNENT = 6,                                   //has no open connect
    SSLAT_INTERNAL = 7,                                     //internal error, for example can't restore from deep sleep
    SSLAT_MEM_NOT_ENOUGH = 8                                //memory not enough
}AtSslError_e;

enum SSL_CMD_TYPE
{
    SSL_OPEN_COMMAND,
    SSL_OPEN_DONE_COMMAND,
    SSL_SEND_COMMAND,
    SSL_CLOSE_TCP_COMMAND,
    SSL_CLOSE_COMMAND,
    SSL_STATE_COMMAND,
    SSL_DISCON_COMMAND,
    SSL_SEND_PT_DATA
};

/*
 * APPL SGID: APPL_SSL, related PRIM ID
*/
enum applSslPrimId_Enum
{
    APPL_SSL_PRIM_ID_BASE = 0,
        
    APPL_SSL_OPEN_CNF,
    APPL_SSL_SEND_CNF,
    APPL_SSL_CLOSE_CNF,
    APPL_SSL_STATE_CNF,
    APPL_SSL_URC_IND,
    APPL_SSL_OUTPUT_IND,
    APPL_SSL_PASSOUT_IND,
    APPL_SSL_PRIM_ID_END = 0xFF
};

typedef enum {
    SSLSTAT_INIT = 0,
    SSLSTAT_CONNECT,
    SSLSTAT_DISCONN,
    SSLSTAT_CLOSE
}SSLAtStatus_e;

typedef enum
{
    SSL_EN_SLEEP,
    SSL_DIS_SLEEP
}SSLSleep_e;

typedef struct
{
    uint8_t cmd_type;
    uint32_t reqHandle;
    uint8_t clientId;
    uint8_t channelId;
    void* ptr;
} sslCmdMsg_t;

typedef struct
{
    void *pInd;
} sslIndMsg_t;

typedef struct
{
    uint8_t ret;
    uint8_t accessMode;
    uint8_t chanId;
    char rspbuf[60];
} sslCnfCmdMsg_t;

typedef struct sslContextTag
{
    mbedtls_ssl_context       sslContext;
    mbedtls_net_context       netContext;
    mbedtls_ssl_config        sslConfig;
    mbedtls_entropy_context   entropyContext;
    mbedtls_ctr_drbg_context  ctrDrbgContext;
    mbedtls_x509_crt_profile  crtProfile;
    mbedtls_x509_crt          caCert;
    mbedtls_x509_crt          clientCert;
    mbedtls_pk_context        pkContext;
}sslContext;

typedef struct _sslPTUlDataNode
{
    struct _sslPTUlDataNode *next;
    uint16_t    dataLen;    /*the send raw datalength*/
    uint8_t*    pData;
}sslPTUlDataNode;

typedef struct _ssl_list_t
{
    struct _ssl_list_t * next;
} ssl_list_t;

typedef struct sslPTUlPendingList_Tag
{
   ssl_list_t *head;
   ssl_list_t *tail;
   uint8_t nodeCount;
   uint8_t maxNodeNum;
   osMutexId_t mut;
}sslPTUlPendingList;


typedef struct sslClientContextTag
{
    bool isUsed;
    uint8_t pdpId;
    uint8_t clientId;
    uint8_t sslCxtId;
    uint32_t reqhandle;
    uint16_t pid;
    int socket;
    char* serverAddr;
    uint16_t serverPort;
    uint8_t status;
    int timeout_s;
    int timeout_r;
    uint8_t* sendData;
    uint16_t sendDataLen;
    sslContext * ssl;
    char *caCert;
    char *clientCert;
    char *clientPk;
    int32_t caCertLen;
    int32_t clientCertLen;
    int32_t clientPkLen;
    uint8_t seclevel;//0:no verify; 1:verify server; 2:both verify
    int32_t ciphersuite[2];//just like 0x0035 TLS_RSA_WITH_AES_256_CBC_SHA,ciphersuite[1] must NULL
    uint8_t cache;//0:no session resumption; 1:session resumption
    uint8_t sni;//0:no sni; 1:has sni
    uint8_t accessMode;//0:direct mode; 1:passthrough
    uint8_t ignore;//0:not ignore; 1:ignore
    uint8_t channelState;
}sslClientContext;

void sslSaveCxtList(void);
void sslEngineInit(void);
CmsRetId sslClientOpen(uint32_t reqHandle, uint8_t clientId, uint8_t channelId);
CmsRetId sslClientSend(uint8_t clientId);
CmsRetId sslClientClose(uint32_t reqHandle, uint8_t clientId);
CmsRetId sslClientState(uint32_t reqHandle, uint8_t clientId);

void sslDisableSleep(void);

AtSslError_e sslCheckRestore(void);
void sslNewClientContext(sslClientContext* context, uint8_t pdpId, uint8_t clientId, uint8_t sslCxtId, char* pServer, uint16_t port, uint8_t accessMode);

CmsRetId sslPSTHAndOnlineCmdCallback(UINT8 chanId, UINT8 curChanState, AtDataAndOnlineCmdSEvt eventId, void *pArg);
bool sslQueryClientIdIsActivated(UINT8 clientId);
#endif
#endif


