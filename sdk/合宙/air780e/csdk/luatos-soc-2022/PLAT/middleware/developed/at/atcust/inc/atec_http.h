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
#ifndef _ATEC_HTTP_H
#define _ATEC_HTTP_H

#include "at_util.h"

#define HTTP_MAX_RSP_LEN                        256
/* AT+HTTPCFG */
#define HTTPCFG_CONTEXTID_MIN                   1
#define HTTPCFG_CONTEXTID_MAX                   15
#define HTTPCFG_CONTEXTID_DEF                   1
#define HTTPCFG_REQUESTHEAD_MIN                 0
#define HTTPCFG_REQUESTHEAD_MAX                 1
#define HTTPCFG_REQUESTHEAD_DEF                 0
#define HTTPCFG_RESPONSEHEAD_MIN                0
#define HTTPCFG_RESPONSEHEAD_MAX                1
#define HTTPCFG_RESPONSEHEAD_DEF                0
#define HTTPCFG_SSLCTXID_MIN                    0
#define HTTPCFG_SSLCTXID_MAX                    5
#define HTTPCFG_SSLCTXID_DEF                    1
#define HTTPCFG_CONTENTTYPE_MIN                 0
#define HTTPCFG_CONTENTTYPE_MAX                 3
#define HTTPCFG_CONTENTTYPE_DEF                 0
#define HTTPCFG_AUTOOUT_MIN                     0
#define HTTPCFG_AUTOOUT_MAX                     1
#define HTTPCFG_AUTOOUT_DEF                     0
#define HTTPCFG_CLOSEIND_MIN                    0
#define HTTPCFG_CLOSEIND_MAX                    1
#define HTTPCFG_CLOSEIND_DEF                    0
/* AT+HTTPURL */
#define HTTPURL_LEN_MIN                         1
#define HTTPURL_LEN_MAX                         2048
#define HTTPURL_TIMEOUT_MIN                     1
#define HTTPURL_TIMEOUT_MAX                     65535
#define HTTPURL_TIMEOUT_DEF                     60
/* AT+HTTPGET */
#define HTTPGET_RSPTIME_MIN                     1
#define HTTPGET_RSPTIME_MAX                     65535
#define HTTPGET_RSPTIME_DEF                     60
#define HTTPGET_DATALEN_MIN                     1
#define HTTPGET_DATALEN_MAX                     2048
#define HTTPGET_INPUT_MIN                       1
#define HTTPGET_INPUT_MAX                       65535
#define HTTPGET_INPUT_DEF                       60
/* AT+HTTPGETEX */
#define HTTPGETEX_RSPTIME_MIN                   1
#define HTTPGETEX_RSPTIME_MAX                   65535
#define HTTPGETEX_RSPTIME_DEF                   60
#define HTTPGETEX_STARTPOS_MIN                  0
#define HTTPGETEX_STARTPOS_MAX                  0x7FFFFFFF
#define HTTPGETEX_STARTPOS_DEF                  0
#define HTTPGETEX_READLEN_MIN                   1
#define HTTPGETEX_READLEN_MAX                   0x7FFFFFFF
#define HTTPGETEX_READLEN_DEF                   -1
/* AT+HTTPPOST */
#define HTTPPOST_DATALEN_MIN                    1
#define HTTPPOST_DATALEN_MAX                    4096
#define HTTPPOST_INPUTTIME_MIN                  1
#define HTTPPOST_INPUTTIME_MAX                  65534
#define HTTPPOST_INPUTTIME_DEF                  60
#define HTTPPOST_RSPTIME_MIN                    1
#define HTTPPOST_RSPTIME_MAX                    65535
#define HTTPPOST_RSPTIME_DEF                    60

/* AT+HTTPREAD */
#define HTTPREAD_WAIT_MIN                       1
#define HTTPREAD_WAIT_MAX                       65535
#define HTTPREAD_WAIT_DEF                       60

/* AT+HTTFOTADL */
#define HTTPFOTADL_URC_MIN                      0
#define HTTPFOTADL_URC_MAX                      100
#define HTTPFOTADL_URC_DEF                      100

#define HTTPFILENAME_MAX_LEN                    63
enum HTTP_CHANNEL_STATUS
{
    HTTP_URL_INPUT,
    HTTP_REQCONTENT_INPUT
};

void httpTimerExpired(void);
CmsRetId  httpInputData(uint8_t chanId, uint8_t *pData, uint16_t dataLength);

CmsRetId httpCFG(const AtCmdInputContext *pAtCmdReq);
CmsRetId httpURL(const AtCmdInputContext *pAtCmdReq);
CmsRetId  httpGET(const AtCmdInputContext *pAtCmdReq);
CmsRetId  httpGETEX(const AtCmdInputContext *pAtCmdReq);
CmsRetId  httpPOST(const AtCmdInputContext *pAtCmdReq);
CmsRetId  httpPOSTFILE(const AtCmdInputContext *pAtCmdReq);
CmsRetId httpSTOP(const AtCmdInputContext *pAtCmdReq);
CmsRetId  httpREAD(const AtCmdInputContext *pAtCmdReq);
CmsRetId  httpFOTADL(const AtCmdInputContext *pAtCmdReq);
CmsRetId  httpREADFILE(const AtCmdInputContext *pAtCmdReq);

#endif

