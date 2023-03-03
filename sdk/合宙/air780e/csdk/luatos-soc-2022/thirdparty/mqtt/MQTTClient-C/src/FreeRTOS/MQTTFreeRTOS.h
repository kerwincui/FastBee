/*******************************************************************************
 * Copyright (c) 2014, 2015 IBM Corp.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * and Eclipse Distribution License v1.0 which accompany this distribution.
 *
 * The Eclipse Public License is available at
 *    http://www.eclipse.org/legal/epl-v10.html
 * and the Eclipse Distribution License is available at
 *   http://www.eclipse.org/org/documents/edl-v10.php.
 *
 * Contributors:
 *    Allan Stockdill-Mander - initial API and implementation and/or initial documentation
 *******************************************************************************/

#if !defined(MQTTFreeRTOS_H)
#define MQTTFreeRTOS_H

#include "FreeRTOS.h"
#include "semphr.h"
#include "task.h"

#include "common_api.h"

// #ifdef FEATURE_MQTT_TLS_ENABLE
// #include "MQTTTls.h"
// #endif

#include "sockets.h"
#include "api.h"
#include "netdb.h"

#ifdef FEATURE_MQTT_TLS_ENABLE
#include "mbedtls/net.h"
#include "mbedtls/ssl.h"
#include "mbedtls/certs.h"
#include "mbedtls/entropy.h"
#include "mbedtls/ctr_drbg.h"
#endif

#include "sockets.h"
#include "api.h"
#include "netdb.h"
#define FreeRTOS_setsockopt  			setsockopt
#define FreeRTOS_getsockopt				getsockopt
#define FreeRTOS_recv 		 			recv
#define FreeRTOS_closesocket 			close
#define FreeRTOS_shutdownsocket   		shutdown
#define FreeRTOS_socket					socket
#define FreeRTOS_connect				connect
#define	FreeRTOS_gethostbyname 			getaddrinfo
#define FreeRTOS_htons					htons
#define FreeRTOS_send					send

#define FREERTOS_SO_RCVTIMEO 			SO_RCVTIMEO
#define FRERRTOS_SO_SNDTIMEO			SO_SNDTIMEO
#define FRERRTOS_SO_ERROR				SO_ERROR
#define FREERTOS_AF_INET				AF_INET
#define FREERTOS_SOCK_STREAM			SOCK_STREAM
#define FREERTOS_IPPROTO_TCP			IPPROTO_TCP
#define FREERTOS_SOL_SOCKET				SOL_SOCKET

#define freertos_sockaddr 				sockaddr_in

typedef int xSocket_t;


///MQTT client results
typedef enum {
    MQTT_CONN_OK = 0,        ///<Success
    MQTT_PROCESSING,    ///<Processing
    MQTT_PARSE,         ///<url Parse error
    MQTT_DNS,           ///<Could not resolve name
    MQTT_PRTCL,         ///<Protocol error
    MQTT_NOTFOUND,      ///<HTTP 404 Error
    MQTT_REFUSED,       ///<HTTP 403 Error
    MQTT_ERROR,         ///<HTTP xxx error
    MQTT_TIMEOUT,       ///<Connection timeout
    MQTT_CONN,          ///<Connection error
    MQTT_FATAL_ERROR, //fatal error when conenct
    MQTT_CLOSED,        ///<Connection was closed by remote host
    MQTT_MOREDATA,      ///<Need get more data
    MQTT_OVERFLOW,      ///<Buffer overflow
    MQTT_MBEDTLS_ERR,  

}MQTTResult;
typedef struct Timer 
{
    TickType_t xTicksToWait;
    TimeOut_t xTimeOut;
} Timer;

#define MQTT_MAX_TIMEOUT  (10 * 60)  //10 min

typedef struct mqttsClientSslTag
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
}mqttsClientSsl;

typedef struct Network Network;

struct Network
{
    xSocket_t my_socket;

    int timeout_r;
    char *addr;
    uint16_t port;
    bool isMqtts;
#ifdef FEATURE_MQTT_TLS_ENABLE
    mqttsClientSsl * ssl;
    char *caCert;
    char *clientCert;
    char *clientPk;
    char *hostName;
    char *psk_key;
    char *psk_identity;
    int caCertLen;
    int clientCertLen;
    int clientPkLen;
    uint8_t seclevel;//0:no verify; 1:verify server; 2:both verify
    int32_t ciphersuite[2];//just like 0x0035 TLS_RSA_WITH_AES_256_CBC_SHA,ciphersuite[1] must NULL
    uint8_t pdpId;//pdp context id--cid--0 is default
    uint8_t cache;//0:no session resumption; 1:session resumption
    uint8_t sni;//0:no sni; 1:has sni
    uint8_t ignore;//0:not ignore; 1:ignore
    uint8_t saveMem;//0:disable; 1:enable
#endif
    int (*mqttread) (Network*, unsigned char*, int, int);
    int (*mqttwrite) (Network*, unsigned char*, int, int);
    int (*disconnect) (Network*);
};

void TimerInit(Timer*);
char TimerIsExpired(Timer*);
void TimerCountdownMS(Timer*, unsigned int);
void TimerCountdown(Timer*, unsigned int);
int TimerLeftMS(Timer*);

typedef struct Mutex
{
    SemaphoreHandle_t sem;
} Mutex;

void MutexInit(Mutex*);
int MutexLock(Mutex*);
int MutexUnlock(Mutex*);

typedef struct Thread
{
    TaskHandle_t task;
} Thread;

int ThreadStart(Thread*, void (*fn)(void*), void* arg);

int FreeRTOS_read(Network* n, unsigned char* buffer, int len, int timeout_ms);
int FreeRTOS_write(Network* n, unsigned char* buffer, int len, int timeout_ms);
int FreeRTOS_disconnect(Network* n);

void NetworkInit(Network* n);
int NetworkConnect(Network* n, char* addr, int port);
int NetworkSetConnTimeout(Network* n, int send_timeout, int recv_timeout);
/*int NetworkConnectTLS(Network*, char*, int, SlSockSecureFiles_t*, unsigned char, unsigned int, char);*/

#endif
