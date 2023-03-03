/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_http.h
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _ATEC_SSL_H
#define _ATEC_SSL_H

#include "at_util.h"
#include "at_ssl_task.h"

#define SSL_MAX_RSP_LEN                        512
/* AT+SSLCFG */
#define SSLCFG_CONTEXTID_MIN                   0
#define SSLCFG_CONTEXTID_MAX                   5
#define SSLCFG_CONTEXTID_DEF                   0
#define SSLCFG_VERSION_MIN                     0
#define SSLCFG_VERSION_MAX                     4
#define SSLCFG_VERSION_DEF                     4
#define SSLCFG_CIPHSUIT_MAX_SIZE               7
#define SSLCFG_CIPHSUIT_DEF                    0xFFFF
#define SSLCFG_DTLS_MIN                        0
#define SSLCFG_DTLS_MAX                        1
#define SSLCFG_DTLS_DEF                        0
#define SSLCFG_SECLEVEL_MIN                    0
#define SSLCFG_SECLEVEL_MAX                    2
#define SSLCFG_SECLEVEL_DEF                    0
#define SSLCFG_NEGOTIME_MIN                    10
#define SSLCFG_NEGOTIME_MAX                    300
#define SSLCFG_NEGOTIME_DEF                    300
#define SSLCFG_DTLSVER_MIN                     0      
#define SSLCFG_DTLSVER_MAX                     1      
#define SSLCFG_DTLSVER_DEF                     0      
#define SSLCFG_CACHE_MIN                    0
#define SSLCFG_CACHE_MAX                    1
#define SSLCFG_CACHE_DEF                    1
#define SSLCFG_SNI_MIN                      0
#define SSLCFG_SNI_MAX                      1
#define SSLCFG_SNI_DEF                      0
#define SSLCFG_IGNORE_MIN                    0
#define SSLCFG_IGNORE_MAX                    1
#define SSLCFG_IGNORE_DEF                    1

/* AT+SSLOPEN */
#define SSLOPEN_PDPCXTID_MIN                   1
#define SSLOPEN_PDPCXTID_MAX                   15
#define SSLOPEN_PDPCXTID_DEF                   0
#define SSLOPEN_SSLCXTID_MIN                   0
#define SSLOPEN_SSLCXTID_MAX                   5
#define SSLOPEN_SSLCXTID_DEF                   0
#define SSLOPEN_CLIENTID_MIN                   0
#define SSLOPEN_CLIENTID_MAX                   MAX_SSL_CLIENT_INSTANCE-1
#define SSLOPEN_CLIENTID_DEF                   0
#define SSLOPEN_URL_MAX_LEN                    SSL_URL_MAX_LEN
#define SSLOPEN_PORT_MIN                       0
#define SSLOPEN_PORT_MAX                       0xFFFF
#define SSLOPEN_PORT_DEF                       0
#define SSLOPEN_ACCESS_MIN                     0
#define SSLOPEN_ACCESS_MAX                     1
#define SSLOPEN_ACCESS_DEF                     0
/* AT+SSLSEND */
#define SSLOPEN_SENDLEN_MIN                   1
#define SSLOPEN_SENDLEN_MAX                   1460
#define SSLOPEN_SENDLEN_DEF                   1

CmsRetId  sslInputSendData(uint8_t chanId, uint8_t *pData, uint16_t dataLength);
void sslSendCancel(void);

CmsRetId sslCFG(const AtCmdInputContext *pAtCmdReq);
CmsRetId sslOPEN(const AtCmdInputContext *pAtCmdReq);
CmsRetId sslSEND(const AtCmdInputContext *pAtCmdReq);
CmsRetId sslCLOSE(const AtCmdInputContext *pAtCmdReq);
CmsRetId sslSTATE(const AtCmdInputContext *pAtCmdReq);

#endif

