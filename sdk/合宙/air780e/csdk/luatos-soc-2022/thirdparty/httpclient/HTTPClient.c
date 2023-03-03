/* Copyright (C) 2012 mbed.org, MIT License
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software
 * and associated documentation files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge, publish, distribute,
 * sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
 * BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include <stdio.h>
#include <string.h>

#include "netdb.h"
#include "sockets.h"
#include "mbedtls/debug.h"
#include "ec_sslcmd_api.h"
#include "cmsis_os2.h"

#include "HTTPClient.h"

#include DEBUG_LOG_HEADER_FILE

#define HTTP_CONNECT_TIMEOUT_EN



#define CHUNK_SIZE 1501
#define MAXHOST_SIZE 128
#define TEMPBUF_SIZE 512

#define MAX_TIMEOUT  (10 * 60)  //10 min

#ifndef MIN
#define MIN(x,y) (((x)<(y))?(x):(y))
#endif

#define CHECK_CONN_ERR(ret) \
  do{ \
    if(ret) { \
      return HTTP_CONN; \
    } \
  } while(0)

#define CHECK_ERR(ret) \
        do{ \
          if(ret != HTTP_OK && ret != HTTP_CONN) { \
            return ret; \
          } \
        } while(0)

#define PRTCL_ERR() \
  do{ \
    return HTTP_PRTCL; \
  } while(0)

#define OVERFLOW_ERR(ret) \
    do{ \
      if(ret) { \
        return HTTP_OVERFLOW; \
      } \
    } while(0)

#define DEBUG_LEVEL 2

static char *httpSendBuf = NULL;
static char *httpSendBufTemp = NULL;
//extern size_t xBytesTaskMalloced;
extern uint8_t ec_mbedtls_check_crt_valid;
extern sslSessionContext * gSslSessionContext;

/****************************************************************************************************************************
 ****************************************************************************************************************************
 *  static function 
 ****************************************************************************************************************************
****************************************************************************************************************************/
#define __DEFINE_STATIC_FUNCTION__//just for easy to find this position


static HTTPResult parseURL(const char* url, char* scheme, int32_t maxSchemeLen, char* host, int32_t maxHostLen, uint16_t* port, char* path, int32_t maxPathLen) //Parse URL
{
    DBG("url=%s", (uint8_t*)url);
    char* schemePtr = (char*) url;
    char* hostPtr = (char*) strstr(url, "://");
    if (hostPtr == NULL) {
        DBG("Could not find host");
        return HTTP_PARSE; //URL is invalid
    }

    if ( (uint16_t)maxSchemeLen < hostPtr - schemePtr + 1 ) { //including NULL-terminating char
        DBG("Scheme str is too small (%d >= %d)", maxSchemeLen, hostPtr - schemePtr + 1);
        return HTTP_PARSE;
    }
    memcpy(scheme, schemePtr, hostPtr - schemePtr);
    scheme[hostPtr - schemePtr] = '\0';

    hostPtr += 3;

    int32_t hostLen = 0;

    char* portPtr = strchr(hostPtr, ':');
    if( portPtr != NULL ) {
        hostLen = portPtr - hostPtr;
        portPtr++;
        if( sscanf(portPtr, "%hu", port) != 1) {
            DBG("Could not find port");
            return HTTP_PARSE;
        }
        DBG("has port=%d, hostLen= %d", *port,hostLen);
    } else {
        hostLen = strlen(hostPtr);
        DBG("no port, hostLen=%d", hostLen);
        *port=0;
    }
    char* pathPtr = strchr(hostPtr, '/');
    if( pathPtr != 0 && portPtr == 0) {
        hostLen = pathPtr - hostPtr;
        DBG("has path, hostLen=%d", hostLen);
    }
    if( maxHostLen < hostLen + 1 ) { //including NULL-terminating char
        DBG("Host str is too small (%d >= %d)", maxHostLen, hostLen + 1);
        return HTTP_PARSE;
    }
    memcpy(host, hostPtr, hostLen);
    host[hostLen] = '\0';
    DBG("host=%s", (uint8_t*)host);

    int32_t pathLen;
    char* fragmentPtr = strchr(hostPtr, '#');
    if(fragmentPtr != NULL) {
        pathLen = fragmentPtr - pathPtr;
    } else {
        if(pathPtr != NULL){
            pathLen = strlen(pathPtr);
        } else {
            pathLen = 0;
        }
    }

    if( maxPathLen < pathLen + 1 ) { //including NULL-terminating char
    	DBG("Path str is too small (%d >= %d)", maxPathLen, pathLen + 1);
        return HTTP_PARSE;
    }
    if (pathPtr!= NULL && pathLen > 0) {
        memcpy(path, pathPtr, pathLen);
        path[pathLen] = '\0';
    }
    DBG("path=%s", (uint8_t*)path);
    DBG("parseURL{url(%s),host(%s),maxHostLen(%d),port(%d),path(%s),maxPathLen(%d)}\r\n",
        url, host, maxHostLen, *port, path, maxPathLen);

    return HTTP_OK;
}

// Copyright (c) 2010 Donatien Garnier (donatiengar [at] gmail [dot] com)
static int base64enc(const char *input, unsigned int length, char *output, int len)
{
    static const char base64[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    unsigned int c, c1, c2, c3;

    if ((uint16_t)len < ((((length-1)/3)+1)<<2)) return -1;
    for(unsigned int i = 0, j = 0; i<length; i+=3,j+=4) {
        c1 = ((((unsigned char)*((unsigned char *)&input[i]))));
        c2 = (length>i+1)?((((unsigned char)*((unsigned char *)&input[i+1])))):0;
        c3 = (length>i+2)?((((unsigned char)*((unsigned char *)&input[i+2])))):0;

        c = ((c1 & 0xFC) >> 2);
        output[j+0] = base64[c];
        c = ((c1 & 0x03) << 4) | ((c2 & 0xF0) >> 4);
        output[j+1] = base64[c];
        c = ((c2 & 0x0F) << 2) | ((c3 & 0xC0) >> 6);
        output[j+2] = (length>i+1)?base64[c]:'=';
        c = (c3 & 0x3F);
        output[j+3] = (length>i+2)?base64[c]:'=';
    }
    output[(((length-1)/3)+1)<<2] = '\0';
    return 0;
}

static void createauth (const char *user, const char *pwd, char *buf, int len)
{
    char tmp[128];
    snprintf(tmp, sizeof(tmp), "%s:%s", user, pwd);
    base64enc(tmp, strlen(tmp), &buf[strlen(buf)], len - strlen(buf));
}

static HTTPResult httpSslClose(HttpClientContext* context)
{
    HttpClientSsl *ssl = (HttpClientSsl *)context->ssl;
    /*context->clientCert = NULL;
    context->caCert = NULL;
    context->clientPk = NULL; let up level free it*/
    if(ssl == NULL)
        return HTTP_MBEDTLS_ERR;

    mbedtls_ssl_close_notify(&(ssl->sslContext));
    mbedtls_net_free(&(ssl->netContext));
    mbedtls_x509_crt_free(&(ssl->caCert));
    mbedtls_x509_crt_free(&(ssl->clientCert));
    mbedtls_pk_free(&(ssl->pkContext));
    mbedtls_ssl_free(&(ssl->sslContext));
    mbedtls_ssl_config_free(&(ssl->sslConfig));
    mbedtls_ctr_drbg_free(&(ssl->ctrDrbgContext));
    mbedtls_entropy_free(&(ssl->entropyContext));

    free(ssl);
    context->ssl = NULL;
    return HTTP_OK;
}

static HTTPResult httpSendInter(HttpClientContext* context, const char* buf, uint16_t len) //0 on success, err code on failure
{
    int32_t waitToSend = len;
    int32_t hasSend = 0;
    fd_set writeFs;
    struct timeval tv;
    uint32_t preSelTime = 0,passedTime=0;
    uint8_t ret=0;

    tv.tv_sec = 0;
    tv.tv_usec =context->timeout_s*1000000;
    
    FD_ZERO(&writeFs);
    if(context && context->socket >= 0)
    FD_SET(context->socket, &writeFs);

    
    do
    {
        tv.tv_usec -= (passedTime*1000);
        DBG("passedTime: %d,tv_usec %d", passedTime,tv.tv_usec);
        preSelTime=osKernelGetTickCount()/portTICK_PERIOD_MS;
        ret = select(context->socket + 1, NULL, &writeFs, NULL, &tv);
        if(ret>0)
        {
            hasSend = send(context->socket, (buf + len - waitToSend), waitToSend, MSG_DONTWAIT);
            DBG("%d bytes data has sent to server", hasSend);
            if(hasSend > 0)
            {
                waitToSend -= hasSend;
            }
            else if(hasSend == 0)
            {
                return HTTP_OK;
            }
            else
            {
            	DBG("send failed (errno:%d)", errno);
                return HTTP_CONN;
            }
            
            DBG("preSelTime: %d,current tick %d", preSelTime,osKernelGetTickCount());
            passedTime=(osKernelGetTickCount()-preSelTime)>0?(osKernelGetTickCount() - preSelTime)/portTICK_PERIOD_MS:(0xFFFFFFFF - preSelTime + osKernelGetTickCount())/portTICK_PERIOD_MS;
            
        }
        else//slelct return <=0 select timeout or error
        {
             return HTTP_CONN;
        }

        
    }while(waitToSend>0);

    return HTTP_OK;
}


static HTTPResult httpSslSend(mbedtls_ssl_context* sslContext, const char* buf, uint16_t len)
{
    int32_t waitToSend = len;
    int32_t hasSend = 0;
    
    do
    {
        hasSend = mbedtls_ssl_write(sslContext, (unsigned char *)(buf + len - waitToSend), waitToSend);
        if(hasSend > 0)
        {
            waitToSend -= hasSend;
        }
        else if(hasSend == 0)
        {
            return HTTP_OK;
        }
        else
        {
            DBG("http_client(ssl): send failed \n");
            return HTTP_CONN;
        }
    }while(waitToSend>0);

    return HTTP_OK;
}

static int httpSslNonblockRecv(void *netContext, uint8_t *buf, size_t len)
{
    int ret;
    int fd = ((mbedtls_net_context *)netContext)->fd;
    if(fd < 0)
        return HTTP_MBEDTLS_ERR;
    ret = (int)recv(fd, buf, len, MSG_DONTWAIT);
    if(ret<0){
        if( errno == EPIPE || errno == ECONNRESET) {
            return (MBEDTLS_ERR_NET_CONN_RESET);
        }
        if( errno == EINTR ) {
            return (MBEDTLS_ERR_SSL_WANT_READ);
        }
        if(ret == -1 && errno == EWOULDBLOCK) {
            return ret;
        }
        return (MBEDTLS_ERR_NET_RECV_FAILED);
    }
    return (ret);
}

HTTPResult httpSend(HttpClientContext* context, const char* buf, uint16_t len) //0 on success, err code on failure
{
    uint8_t ret=0;
    if(context->isHttps)
    {
        HttpClientSsl *ssl = (HttpClientSsl *)context->ssl;
        ret = httpSslSend(&(ssl->sslContext), buf, len);
    }
    else
    {
        ret = httpSendInter(context, buf, len);
    }
    return ret;
}

HTTPResult httpRecv(HttpClientContext* context, char* buf, int32_t minLen, int32_t maxLen, int32_t* pReadLen) //0 on success, err code on failure
{
	DBG("Trying to read between %d and %d bytes", minLen, maxLen);
    int32_t readLen = 0;

    int ret;
    while (readLen < maxLen) 
    {
        if(!context->isHttps)
        {
            if (readLen < minLen) {
                ret = recv(context->socket, buf+readLen, minLen-readLen, 0);
                DBG("recv [blocking] return:%d", ret);
                if(ret == 0)
                {
                    int mErr = sock_get_errno(context->socket);
                    if(socket_error_is_fatal(mErr))//maybe closed or reset by peer
                    {
                    	DBG("recv return 0 fatal error return HTTP_CLOSED");
                       return HTTP_CLOSED;
                    }
                    else
                    { 
                    	DBG("recv return 0 connect error");
                       return HTTP_CONN;
                    }
                }
            } 
            else 
            {
                ret = recv(context->socket, buf+readLen, maxLen-readLen, MSG_DONTWAIT);
                DBG("recv [not blocking] return:%d", ret);
                if(ret == -1 && errno == EWOULDBLOCK) 
                {
                	DBG("recv [not blocking] errno == EWOULDBLOCK");
                    break;
                }
            }
        }
        else
        {
            HttpClientSsl *ssl = (HttpClientSsl *)context->ssl;
            if (readLen < minLen) {
                mbedtls_ssl_set_bio(&(ssl->sslContext), &(ssl->netContext), (mbedtls_ssl_send_t*)mbedtls_net_send, (mbedtls_ssl_recv_t*)mbedtls_net_recv, NULL);
                ret = mbedtls_ssl_read(&(ssl->sslContext), (unsigned char *)(buf+readLen), minLen-readLen);
                if(ret < 0)
                {
                	DBG("mbedtls_ssl_read [blocking] return:-0x%x", -ret);
                }
                if(ret == 0)
                {
                	DBG("mbedtls_ssl_read [blocking] return 0 connect error");
                    return HTTP_CONN;
                }
            } 
            else 
            {
                mbedtls_ssl_set_bio(&(ssl->sslContext), &(ssl->netContext), (mbedtls_ssl_send_t*)mbedtls_net_send, (mbedtls_ssl_recv_t*)httpSslNonblockRecv, NULL);
                ret = mbedtls_ssl_read(&(ssl->sslContext), (unsigned char*)(buf+readLen), maxLen-readLen);
                
                if(ret < 0)
                {
                	DBG("mbedtls_ssl_read [not blocking] return:-0x%x", -ret);
                }
                if(ret == -1 && errno == EWOULDBLOCK) 
                {
                	DBG("mbedtls_ssl_read [not blocking] errno == EWOULDBLOCK");
                    break;
                }
            }
            if(ret == MBEDTLS_ERR_SSL_PEER_CLOSE_NOTIFY)
                return HTTP_CLOSED;
        }

        if (ret > 0) 
        {
            readLen += ret;
        } 
        else if ( ret == 0 ) 
        {
            break;
        }
        else 
        {
        	DBG("Connection error (recv returned -0x%x)", -ret);
            *pReadLen = readLen;
            if(context->isHttps)
            {
                return HTTP_MBEDTLS_ERR;
            }
            else
            {
                int mErr = sock_get_errno(context->socket);
                if(socket_error_is_fatal(mErr))//maybe closed or reset by peer
                {
                	DBG("recv return 0 fatal error return HTTP_CLOSED");
                   return HTTP_CLOSED;
                }
                else
                { 
                	DBG("recv return 0 connect error");
                   return HTTP_CONN;
                }
            }
        }
    }
    DBG("Read %d bytes", readLen);
    buf[readLen] = '\0';    // DS makes it easier to see what's new.
    *pReadLen = readLen;
    return HTTP_OK;
}

static HTTPResult prepareBuffer(HttpClientContext* context, char* sendBuf, int* cursor, char* buf, int len)
{
    int copyLen;
    int sendbufCursor = *cursor;
    
    if(len == 0){
        len = strlen(buf);
    }

    do {
        if((CHUNK_SIZE - sendbufCursor) >= len) {
            copyLen = len;
        }else{
            HTTPERR("send buffer overflow");
            return HTTP_OVERFLOW;
        }
        memcpy(sendBuf + sendbufCursor, buf, copyLen);
        sendbufCursor += copyLen;
        len -= copyLen;
    }while(len);
    
    *cursor = sendbufCursor;
    return HTTP_OK;
}

void httpFreeBuff(HTTPResult ret)
{
    if(ret != 0)
    {
        if(httpSendBuf != NULL)
        {
            free(httpSendBuf);
            httpSendBuf = NULL;
        }

        if(httpSendBufTemp != NULL)
        {
            free(httpSendBufTemp);
            httpSendBufTemp = NULL;
        }
    }
}

static HTTPResult httpSendHeader(HttpClientContext* context, const char * url, HTTP_METH method, HttpClientData * data)
{
    char scheme[8];
    uint16_t port;
    char host[MAXHOST_SIZE];
    char path[MAXPATH_SIZE];
    HTTPResult ret = HTTP_OK;
    int bufCursor = 0;
    memset(host, 0, MAXHOST_SIZE);
    memset(path, 0, MAXPATH_SIZE);
    context->method = method;

    HTTPResult res = parseURL(url, scheme, sizeof(scheme), host, sizeof(host), &port, path, sizeof(path));
    if(res != HTTP_OK) {
        HTTPERR("parseURL returned %d", res);
        return res;
    }
    
    httpSendBuf = malloc(CHUNK_SIZE);
    memset(httpSendBuf, 0, CHUNK_SIZE);
    
    httpSendBufTemp = malloc(TEMPBUF_SIZE);
    
    const char* meth = (method==HTTP_GET)?"GET":(method==HTTP_POST)?"POST":(method==HTTP_PUT)?"PUT":(method==HTTP_HEAD)?"HEAD":(method==HTTP_DELETE)?"DELETE":"";
    snprintf(httpSendBufTemp, TEMPBUF_SIZE, "%s %s HTTP/1.1\r\nHost: %s\r\n", meth, path, host); //Write request
    ret = prepareBuffer(context, httpSendBuf, &bufCursor, httpSendBufTemp, strlen(httpSendBufTemp));
    httpFreeBuff(ret);
    OVERFLOW_ERR(ret);
    
    // send authorization
    if (context->basicAuthUser && context->basicAuthPassword) {
        memset(httpSendBufTemp, 0, TEMPBUF_SIZE);
        DBG("send auth (if defined)");
        strcpy(httpSendBufTemp, "Authorization: Basic ");
        createauth(context->basicAuthUser, context->basicAuthPassword, httpSendBufTemp+strlen(httpSendBufTemp), TEMPBUF_SIZE-strlen(httpSendBufTemp));
        strcat(httpSendBufTemp, "\r\n");
        DBG(" (%s,%s) => (%s)", context->basicAuthUser, context->basicAuthPassword, httpSendBufTemp);
        ret = prepareBuffer(context, httpSendBuf, &bufCursor, httpSendBufTemp, strlen(httpSendBufTemp));
        httpFreeBuff(ret);
        OVERFLOW_ERR(ret);
    }
    
    // Send custom header
    if(context->custHeader) {
        snprintf(httpSendBufTemp, TEMPBUF_SIZE, "%s\r\n", context->custHeader);
        DBG("httpSendHeader custheader:{%s}", httpSendBufTemp);
        ret = prepareBuffer(context, httpSendBuf, &bufCursor, httpSendBufTemp, strlen(httpSendBufTemp));
        httpFreeBuff(ret);
        OVERFLOW_ERR(ret);
    }

    // set range
    if(data->isRange)
    {
    	DBG("Range:bytes=%d-%d",data->rangeHead, data->rangeTail);
       if(data->rangeTail == -1){
            snprintf(httpSendBufTemp, TEMPBUF_SIZE, "Range:bytes=%d-\r\n", data->rangeHead);
        }else{
           snprintf(httpSendBufTemp, TEMPBUF_SIZE, "Range:bytes=%d-%d\r\n", data->rangeHead, data->rangeTail);
       }
       ret = prepareBuffer(context, httpSendBuf, &bufCursor, httpSendBufTemp, strlen(httpSendBufTemp));
       httpFreeBuff(ret);
       OVERFLOW_ERR(ret);
    }
    
    //Send default headers
    strcpy(httpSendBufTemp, "Connection: Keep-Alive\r\n");
    ret = prepareBuffer(context, httpSendBuf, &bufCursor, httpSendBufTemp, strlen(httpSendBufTemp));
    httpFreeBuff(ret);
    OVERFLOW_ERR(ret);
    
    snprintf(httpSendBufTemp, TEMPBUF_SIZE, "Content-Length: %d\r\n", data->postBufLen);
    ret = prepareBuffer(context, httpSendBuf, &bufCursor, httpSendBufTemp, strlen(httpSendBufTemp));
    httpFreeBuff(ret);
    OVERFLOW_ERR(ret);

    if(data->postContentType != NULL)
    {
        snprintf(httpSendBufTemp, TEMPBUF_SIZE, "Content-Type: %s\r\n", data->postContentType);
        ret = prepareBuffer(context, httpSendBuf, &bufCursor, httpSendBufTemp, strlen(httpSendBufTemp));
        httpFreeBuff(ret);
        OVERFLOW_ERR(ret);
    }
    
    //Close headers
    ret = prepareBuffer(context, httpSendBuf, &bufCursor, "\r\n", strlen("\r\n"));
    httpFreeBuff(ret);
    OVERFLOW_ERR(ret);
    DBG("httpSendHeader send head:%s, headlen:%d", httpSendBuf,strlen(httpSendBuf));

    if(context->isHttps){
        HttpClientSsl *ssl = (HttpClientSsl *)context->ssl;
        ret = httpSslSend(&(ssl->sslContext), httpSendBuf, strlen(httpSendBuf));
        httpFreeBuff(ret);
        CHECK_CONN_ERR(ret);
    }
    else {
        ret = httpSendInter(context, httpSendBuf, strlen(httpSendBuf));
        httpFreeBuff(ret);
        CHECK_CONN_ERR(ret);
    }
    httpFreeBuff((HTTPResult)1);
    return ret;
}

static HTTPResult httpSendUserdata(HttpClientContext* context, HttpClientData * data) 
{
    HTTPResult ret = HTTP_OK;
    DBG("begin send content");
    if(data->postBuf && data->postBufLen)
    {
    	DBG("data->postBufLen=%d",data->postBufLen);
        if(context->isHttps)
        {
            HttpClientSsl *ssl = (HttpClientSsl *)context->ssl;
            ret = httpSslSend(&(ssl->sslContext), data->postBuf, data->postBufLen);
            CHECK_CONN_ERR(ret);
        }
        else
        {
        	DBG("data->postBuf=%s",(uint8_t*)data->postBuf);
            ret = httpSendInter(context, data->postBuf, data->postBufLen);
            CHECK_CONN_ERR(ret);
        }
    }
    return ret;
}
static HTTPResult check_timeout_ret(HTTPResult ret){
    static uint8_t count = 0;
    if(ret == HTTP_OK){
        count = 0;
    }else if(ret == HTTP_CONN ){
        if(count < 3){
        	DBG("wait %d x 20s", count);
            count += 1;
        }else{
        	DBG("give up return HTTP_TIMEOUT");
            ret = HTTP_REQ_TIMEOUT;
        }
    }
    return ret; 
}

static HTTPResult httpParseContent(HttpClientContext* context, char * buf, int32_t trfLen, HttpClientData * data)
{
    int32_t crlfPos = 0;
    HTTPResult ret = HTTP_OK;
    int maxlen;
    int total = 0;
    int templen = 0;
    static int seqNum = 0;
    //Receive data
//    DBG("begin parse content");

    data->isMoreContent = TRUE;

    if(data->recvContentLength == -1 && data->isChunked == FALSE)
    {
        while(true)
        {
            if(total + trfLen < data->respBufLen - 1)
            {
                memcpy(data->respBuf + total, buf, trfLen);
                total += trfLen;
                data->respBuf[total] = '\0';
                DBG("all data are here");
            }
            else
            {
                memcpy(data->respBuf + total, buf, data->respBufLen - 1 - total);
                data->respBuf[data->respBufLen-1] = '\0';
                data->blockContentLen = data->respBufLen-1;
                DBG("still has more data on the way");
                return HTTP_MOREDATA;
            }

            maxlen = MIN(CHUNK_SIZE - 1, data->respBufLen - 1 - total);
            ret = httpRecv(context, buf, 1, maxlen, &trfLen);

            DBG("receive data len:%d, total:%d", trfLen, total);

            if(ret != HTTP_OK)
            {
                data->blockContentLen = total;
                data->isMoreContent = false;
                DBG("ret:%d", ret);
                return ret;
            }
            if(trfLen == 0)
            {
            	DBG("no more data read");
                data->isMoreContent = false;
                return HTTP_OK;
            }
        }
    }
    
    while(true) {
        int32_t readLen = 0;
    
        if( data->isChunked && data->needObtainLen <= 0) {//content is chunked code and first package
        	DBG("content is chunked code");
            //Read chunk header
            bool foundCrlf;
            do {
                foundCrlf = false;
                crlfPos=0;
                buf[trfLen]=0;
                if(trfLen >= 2) {
                    for(; crlfPos < trfLen - 2; crlfPos++) {
                        if( buf[crlfPos] == '\r' && buf[crlfPos + 1] == '\n' ) {
                            foundCrlf = true;
                            break;
                        }
                    }
                }
                if(!foundCrlf) { //Try to read more
                	DBG("no find crlf to read more");
                    maxlen = MIN(CHUNK_SIZE-trfLen-1, data->respBufLen-1-total);
                    if( trfLen < maxlen ) {
                        int32_t newTrfLen = 0;
                        ret = httpRecv(context, buf + trfLen, 0, maxlen, &newTrfLen);
                        trfLen += newTrfLen;
                        CHECK_CONN_ERR(ret);
                        continue;
                    } else {
                        PRTCL_ERR();
                    }
                }
            } while(!foundCrlf);
            buf[crlfPos] = '\0';
            int n = sscanf(buf, "%x", &readLen);
            data->needObtainLen = readLen;
            data->recvContentLength += readLen;
            if(n!=1) {
            	DBG("Could not read chunk length");
                PRTCL_ERR();
            }
    
            memmove(buf, &buf[crlfPos+2], trfLen - (crlfPos + 2)); //Not need to move NULL-terminating char any more
            trfLen -= (crlfPos + 2);
    
            if( readLen == 0 ) {
                //Last chunk
                data->isMoreContent = false;
                break;
            }
        } else {
            readLen = data->needObtainLen;
        }
    
        DBG("need to obtaining %d bytes trfLen=%d", readLen,trfLen);
    
        do {
        	DBG("trfLen=%d, readLen=%d", trfLen, readLen);
            templen = MIN(trfLen, readLen);
            if(total+templen < data->respBufLen - 1){
                memcpy(data->respBuf+total, buf, templen);
                total += templen;
                data->respBuf[total] = '\0';
                data->needObtainLen -= templen;
                DBG("templen=%d data->needObtainLen=%d", templen,data->needObtainLen);
            } else {
                if(data->respBufLen -1 < trfLen){
                	DBG("data->respBufLen=%d is too small, data has overflowed", data->respBufLen);
                }
                memcpy(data->respBuf + total, buf, data->respBufLen - 1 - total);
                data->respBuf[data->respBufLen - 1] = '\0';
                data->needObtainLen -= data->respBufLen - 1 - total;
                DBG("data->needObtainLen=%d total=%d", data->needObtainLen,total);
                if(readLen > trfLen){
                    data->blockContentLen = data->respBufLen -1;
                    seqNum += 1;
                    DBG("return 12 moredata data->blockContentLen=%d, seqNum=%d", data->blockContentLen, seqNum);
                    return HTTP_MOREDATA;
                }else{
                    total += templen;
                    DBG("templen=%d total=%d", templen,total);
                }
            }
            
            if( trfLen >= readLen ) {
                memmove(buf, &buf[readLen], trfLen - readLen);
                trfLen -= readLen;
                readLen = 0;
                data->needObtainLen = 0;
                DBG("trfLen=%d data->needObtainLen and readLen set 0", trfLen);
            } else {
                readLen -= trfLen;
                DBG("readLen=%d", readLen);
            }
    
            if(readLen) {
                maxlen = MIN(MIN(CHUNK_SIZE-1, data->respBufLen-1-total),readLen);
                DBG("to read maxlen=%d", maxlen);
                ret = httpRecv(context, buf, 1, maxlen, &trfLen);
                DBG("httpRecv return: %d,trfLen:%d", ret,trfLen);
                ret = check_timeout_ret(ret);
                CHECK_ERR(ret);
            }
        } while(readLen);
    
        if( data->isChunked ) {
            if(trfLen < 2) {
                int32_t newTrfLen;
                //Read missing chars to find end of chunk
                DBG("search end of chunk");
                maxlen = MIN(CHUNK_SIZE-trfLen-1, data->respBufLen-1-total);
                ret = httpRecv(context, buf + trfLen, 2 - trfLen, maxlen, &newTrfLen);
                CHECK_CONN_ERR(ret);
                trfLen += newTrfLen;
            }
            if( (buf[0] != '\r') || (buf[1] != '\n') ) {
                DBG("Format error");
                PRTCL_ERR();
            }
            memmove(buf, &buf[2], trfLen - 2);
            trfLen -= 2;
        } else {
        	DBG("no more content");
            data->isMoreContent = false;
            break;
        }
    }
    DBG("all content over, seqNum=%d", seqNum);
    data->blockContentLen = total;
    return ret;
}

static HTTPResult httpParseHeader(HttpClientContext* context, char * buf, int32_t trfLen, HttpClientData * data)
{
    HTTPResult ret;
    int32_t crlfPos = 0;
    int temp1 = 0, temp2 = 0;
    int headerBufLen = data->headerBufLen;
    char *headerBuf = data->headerBuf;
    
    memset(headerBuf, 0, headerBufLen);
    
    data->recvContentLength = -1;
    data->isChunked = false;
    
    char* crlfPtr = strstr(buf, "\r\n");
    if( crlfPtr == NULL) {
        PRTCL_ERR();
    }

    crlfPos = crlfPtr - buf;
    memcpy(headerBuf, buf, crlfPos + 2);                                
    headerBuf += crlfPos + 2;
    
    buf[crlfPos] = '\0';
    //char temp[36] = {0};
    //strncpy(temp, buf, 36);
    //DBG("BUF=%s",(uint8_t*)temp);

    //Parse HTTP response
    if( sscanf(buf, "HTTP/%*d.%*d %d %*[^\r\n]", &(context->httpResponseCode)) != 1 ) {
        //Cannot match string, error
    	DBG("Not a correct HTTP answer");
        PRTCL_ERR();
    }

    if( (context->httpResponseCode < 200) || (context->httpResponseCode >= 400) ) {
        //Did not return a 2xx code; TODO fetch headers/(&data?) anyway and implement a mean of writing/reading headers
    	DBG("Response code %d", context->httpResponseCode);
    }
    //DBG("context->httpResponseCode = %d", context->httpResponseCode);

    memmove(buf, &buf[crlfPos+2], trfLen - (crlfPos + 2) + 1); //Be sure to move NULL-terminating char as well
    trfLen -= (crlfPos + 2);

    //Now get headers
    while( true ) {
        char *colonPtr, *keyPtr, *valuePtr;
        int keyLen, valueLen;

        crlfPtr = strstr(buf, "\r\n");
        if(crlfPtr == NULL) {
            if( trfLen < (CHUNK_SIZE - 1) ) 
            {
                int32_t newTrfLen = 0;
                ret = httpRecv(context, buf + trfLen, 1, CHUNK_SIZE - trfLen - 1, &newTrfLen);
                trfLen += newTrfLen;
                buf[trfLen] = '\0';
                //DBG("trfLen = %d, new recv:%d", trfLen, newTrfLen);
                CHECK_ERR(ret);
                continue;
            } 
            else 
            {
                //DBG("trfLen = %d > CHUNK_SIZE",trfLen);
                PRTCL_ERR();
            }
        }
        crlfPos = crlfPtr - buf;
        //DBG("crlfPos = %d...trfLen=%d",crlfPos,trfLen);

        if(crlfPos == 0) { //End of headers
            memmove(buf, &buf[2], trfLen - 2 + 1); //Be sure to move NULL-terminating char as well
            trfLen -= 2;
            DBG("End of headers,trfLen=%d",trfLen);
            break;
        }
        
        colonPtr = strstr(buf, ": ");        
        if (colonPtr) {             
            if (headerBufLen >= crlfPos + 2) {
                //DBG("headerBufLen=%d crlfPos=%d",headerBufLen,crlfPos);
                /* copy response header to caller buffer */
                memcpy(headerBuf, buf, crlfPos + 2);                                
                headerBuf += crlfPos + 2;
                headerBufLen -= crlfPos + 2;
            }
            
            keyLen = colonPtr - buf;
            valueLen = crlfPtr - colonPtr - strlen(": ");            
            keyPtr = buf;
            valuePtr = colonPtr + strlen(": ");

            //printf("Read header : %.*s: %.*s\r\n", keyLen, keyPtr, valueLen, valuePtr); 
            if (0 == strncasecmp(keyPtr, "Content-Length", keyLen)) {
                sscanf(valuePtr, "%d[^\r]", &(data->recvContentLength));                
                data->needObtainLen = data->recvContentLength;
                //DBG("data->needObtainLen=%d",data->needObtainLen);
            } else if (0 == strncasecmp(keyPtr, "Transfer-Encoding", keyLen)) {
                if (0 == strncasecmp(valuePtr, "Chunked", valueLen)) {
                    data->isChunked = true;
                    data->recvContentLength = 0;
                    data->needObtainLen = 0;
                    DBG("data->isChunked = true");
                }
            } else if (0 == strncasecmp(keyPtr, "Content-Range", keyLen)) {
                sscanf(valuePtr, "%*[^/]/%d[^\r]", &(data->contentRange));                
                sscanf(valuePtr, "%*[^ ] %d-[^\\-]", &(temp1));                
                sscanf(valuePtr, "%*[^\\-]-%d[^/]", &(temp2));                
                DBG("data->contentRange=%d,current head=%d tail=%d",data->contentRange,temp1,temp2);
            } 
           
            memmove(buf, &buf[crlfPos+2], trfLen - (crlfPos + 2) + 1); //Be sure to move NULL-terminating char as well
            trfLen -= (crlfPos + 2);
        } else {
            DBG("Could not parse header");
            PRTCL_ERR();
        }
    }// get headers
    
    //DBG("Completed HTTP header parse");
    if(context->method == HTTP_HEAD)
        return HTTP_OK;
    else{
        //DBG("continue parse content, trfLen=%d",trfLen);
        ret = httpParseContent(context, buf, trfLen, data);
    }
    
    return ret;
}

static HTTPResult httpConnectTimeout(int32_t connectFd, uint32_t timeout)
{
    fd_set writeSet;
    fd_set errorSet;
    FD_ZERO(&writeSet);
    FD_ZERO(&errorSet);
    FD_SET(connectFd,&writeSet);
    FD_SET(connectFd,&errorSet);
    struct timeval tv;
    tv.tv_sec  = timeout;
    tv.tv_usec = 0;
    INT32 ret;

    ret = select(connectFd+1, NULL, &writeSet, &errorSet, &tv);
    
    if(ret < 0)
    {
        return HTTP_CONN;
    }
    else if(ret == 0)
    {
        return HTTP_TIMEOUT;
    }
    else
    {
        if(FD_ISSET(connectFd, &errorSet))
        {
            int mErr = sock_get_errno(connectFd);
            DBG("select error fd set get errno=%d", mErr);
            if(mErr)
            {
                return HTTP_CONN;
            }
        }
        else if(FD_ISSET(connectFd, &writeSet))
        {
            DBG("errno=115(EINPROGRESS) connect success in time(10s)");
        }
    }

    return HTTP_OK;

}

static HTTPResult httpConnectSocket(int32_t socket,struct sockaddr *addr, int32_t addrlen)
{

    HTTPResult ret = HTTP_OK;
    int32_t errCode;

    if(connect(socket,addr,addrlen) == 0)
    {                                         
        DBG("httpConnectSocket connect success");
    }
    else
    {
        errCode = sock_get_errno(socket);
        if(errCode == EINPROGRESS)
        {
            DBG("httpConnectSocket connect is ongoing");

            ret = httpConnectTimeout(socket, 25);//from 10s to 25s 
            if(ret == 0)
            {
                DBG("httpConnectSocket connect success");
            }
            else
            {
                DBG("httpConnectSocket connect fail,error code %d", errCode);
                if(socket_error_is_fatal(errCode))
                {
                    ret = HTTP_CLOSED;
                }
            }
        }
        else
        {
            DBG("httpConnectSocket connect fail %d",errCode);
            ret = HTTP_CONN;
        }
    }

   return ret;
}

static HTTPResult httpConn(HttpClientContext* context, char* host)
{
    HTTPResult ret=HTTP_OK;
    //struct timeval timeout_send;
    struct timeval timeout_recv;
    struct addrinfo hints, *addr_list, *p;
    char port[10] = {0};
    int retVal = 0;

    //timeout_send.tv_sec = context->timeout_s > MAX_TIMEOUT ? MAX_TIMEOUT : context->timeout_s;
    //timeout_send.tv_usec = 0;
    timeout_recv.tv_sec = context->timeout_r > MAX_TIMEOUT ? MAX_TIMEOUT : context->timeout_r;
    timeout_recv.tv_usec = 0;

    memset( &hints, 0, sizeof( hints ) );
    //hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;


    snprintf(port, sizeof(port), "%d", context->port) ;
    
    if (getaddrinfo( host, port , &hints, &addr_list ) != 0 ) {
        DBG("HTTP connect unresolved dns");
        return HTTP_DNS;
    }

    //try address one by one until sucess
    for ( p = addr_list; p != NULL; p = p->ai_next ) {
        context->socket = (int) socket( p->ai_family, p->ai_socktype,p->ai_protocol);
        if ( context->socket < 0 ) {
            ret = HTTP_SOCKET_FAIL;
            continue;//try new one
        }

        retVal = bind_cid(context->socket, context->pdpId);
        if(retVal == -1){
            ret = HTTP_BIND_FAIL;
            continue;//try new one
        }
        /* set timeout for both tx removed since lwip not support tx timeout */
        //if ( context->timeout_s > 0) {
        //    setsockopt(context->socket, SOL_SOCKET, SO_SNDTIMEO, &timeout_send, sizeof(timeout_send));
        //}

        /* set timeout for both rx */
        if ( context->timeout_r > 0) {
            setsockopt(context->socket, SOL_SOCKET, SO_RCVTIMEO, &timeout_recv, sizeof(timeout_recv));;
        }

        #ifdef HTTP_CONNECT_TIMEOUT_EN

        int32_t flags = fcntl( context->socket, F_GETFL, 0);
        if(flags < 0)
        {
            DBG("httpCreateSocket get file cntrl flags fail");
            close(context->socket);
            context->socket = -1;
            continue;//try new one
        }
        
        fcntl(context->socket, F_SETFL, flags|O_NONBLOCK); //set socket as nonblock for connect timeout
        
        if ( httpConnectSocket( context->socket, p->ai_addr, (int32_t)p->ai_addrlen ) == HTTP_OK ) {
            DBG("HTTP connect success");
            ret = HTTP_OK;//connect success
            fcntl(context->socket, F_SETFL, flags&~O_NONBLOCK); //connect success recover to block mode
            break;
        }

        fcntl(context->socket, F_SETFL, flags&~O_NONBLOCK); //connect fail recover to block mode

        #else
        if ( connect( context->socket, p->ai_addr, (int)p->ai_addrlen ) == 0 ) {
            ret = HTTP_OK;//connect success
            break;
        }
        #endif
        
        close( context->socket );
        context->socket = -1;
        ret = HTTP_SOCKET_FAIL;
    }

    freeaddrinfo( addr_list );

    return ret;

}


static int sslRandom(void *p_rng, unsigned char *output, size_t output_len)
{
    uint32_t rnglen = output_len;
    uint8_t   rngoffset = 0;

    while (rnglen > 0) {
        *(output + rngoffset) = (unsigned char)rand();
        rngoffset++;
        rnglen--;
    }
    return 0;
}

static void sslDebug(void *ctx, int level, const char *file, int line, const char *str)
{
    //HTTPDBG("%s(%d):%s", file, line, str);
    //DBG("%s(%d):%s", file, line, str);
}

static HTTPResult httpSslConn(HttpClientContext* context, char* host)
{
    int value;
    HttpClientSsl *ssl;
    const char *custom = "https";
    char port[10] = {0};
    int authmode = MBEDTLS_SSL_VERIFY_NONE;
    uint32_t flag = 0;
    
    mbedtls_ssl_session* pSavedSession = NULL;
    bool bDirectSaveSession = FALSE;
    
    //DBG("before ssl context malloc:%d", xBytesTaskMalloced);
    context->ssl = malloc(sizeof(HttpClientSsl));
    ssl = context->ssl;
    
    /*
     * 0. Initialize the RNG and the session data
     */
#if defined(MBEDTLS_DEBUG_C)
    mbedtls_debug_set_threshold((int)DEBUG_LEVEL);
#endif
    mbedtls_net_init(&ssl->netContext);
    mbedtls_ssl_init(&ssl->sslContext);
    mbedtls_ssl_config_init(&ssl->sslConfig);
    mbedtls_x509_crt_init(&ssl->caCert);
    mbedtls_x509_crt_init(&ssl->clientCert);
    mbedtls_pk_init(&ssl->pkContext);
    mbedtls_ctr_drbg_init(&ssl->ctrDrbgContext);
    mbedtls_entropy_init(&ssl->entropyContext);

    if((value = mbedtls_ctr_drbg_seed(&ssl->ctrDrbgContext,
                             mbedtls_entropy_func,
                             &ssl->entropyContext,
                             (const unsigned char*)custom,
                             strlen(custom))) != 0) {
        DBG("mbedtls_ctr_drbg_seed failed, value:-0x%x.", -value);
        return HTTP_MBEDTLS_ERR;
    }
    //DBG("after ssl init:%d", xBytesTaskMalloced);
    /*
     * 0. Initialize certificates
     */
    if(context->seclevel != 0){
        if (NULL != context->caCert) {
            DBG("STEP 0. Loading the CA root certificate ...");
            authmode = MBEDTLS_SSL_VERIFY_REQUIRED;
            if (0 != (value = mbedtls_x509_crt_parse(&(ssl->caCert), (const unsigned char *)context->caCert, context->caCertLen))) {
                DBG("failed ! value:-0x%x", -value);
                return HTTP_MBEDTLS_ERR;
            }else if(context->saveMem == 1){
                free(context->caCert);
                context->caCert = NULL;
            }
        }
    }
    //DBG("after ca cert parse:%d", xBytesTaskMalloced);
    /* Setup Client Cert/Key */
    if(context->seclevel == 2){
        if (context->clientCert != NULL && context->clientPk != NULL) {
            DBG("STEP 0. start prepare client cert ...");
            value = mbedtls_x509_crt_parse(&(ssl->clientCert), (const unsigned char *) context->clientCert, context->clientCertLen);
            if (value != 0) {
                DBG("failed!  mbedtls_x509_crt_parse returned -0x%x\n", -value);
                return HTTP_MBEDTLS_ERR;
            }else if(context->saveMem == 1){
                free(context->clientCert);
                context->clientCert = NULL;
                flag = 1;
            }

            DBG("context->clientPkLen=%d", context->clientPkLen);
            
            
            value = mbedtls_pk_parse_key(&ssl->pkContext, (const unsigned char *) context->clientPk, context->clientPkLen, NULL, 0);
    
            if (value != 0) {
                DBG("failed !  mbedtls_pk_parse_key returned -0x%x\n", -value);
                return HTTP_MBEDTLS_ERR;
            }else if(context->saveMem == 1){
                free(context->clientPk);
                context->clientPk = NULL;
            }
        }
    }
    if(context->seclevel == 0){
        DBG("user set verify none");
        authmode = MBEDTLS_SSL_VERIFY_NONE;
    }
    //DBG("after client cert parse:%d", xBytesTaskMalloced);
    
    if(context->sni == 1){
        DBG("set sni");
        ssl->sslContext.sni = 1;
    }
    
    if(context->ignore == 0){
        DBG("not ignore the crt's valid time");
        ec_mbedtls_check_crt_valid = 1;
    }else{
        DBG("ignore the crt's valid time");
        ec_mbedtls_check_crt_valid = 0;
    }

    /*
     * 1. Start the connection
     */
    snprintf(port, sizeof(port), "%d", context->port);
    DBG("STEP 1. Connecting to PORT:%d",context->port);
    if (0 != (value = mbedtls_net_connect(&ssl->netContext, host, port, MBEDTLS_NET_PROTO_TCP, context->pdpId))) {
        DBG(" failed ! mbedtls_net_connect returned -0x%x", -value);
        return HTTP_MBEDTLS_ERR;
    }

    
    /*
     * 2. Setup stuff
     */
    DBG("STEP 2. Setting up the SSL/TLS structure...");
    if ((value = mbedtls_ssl_config_defaults(&(ssl->sslConfig), MBEDTLS_SSL_IS_CLIENT, MBEDTLS_SSL_TRANSPORT_STREAM,
                                           MBEDTLS_SSL_PRESET_DEFAULT)) != 0) {
        DBG(" failed! mbedtls_ssl_config_defaults returned -0x%x", -value);
        return HTTP_MBEDTLS_ERR;
    }

    //DBG("after net connect:%d", xBytesTaskMalloced);
    mbedtls_ssl_conf_max_version(&ssl->sslConfig, MBEDTLS_SSL_MAJOR_VERSION_3, MBEDTLS_SSL_MINOR_VERSION_3);
    mbedtls_ssl_conf_min_version(&ssl->sslConfig, MBEDTLS_SSL_MAJOR_VERSION_3, MBEDTLS_SSL_MINOR_VERSION_3);

    memcpy(&(ssl->crtProfile), ssl->sslConfig.cert_profile, sizeof(mbedtls_x509_crt_profile));
    mbedtls_ssl_conf_authmode(&(ssl->sslConfig), authmode);

#if defined(MBEDTLS_SSL_MAX_FRAGMENT_LENGTH)
    if ((value = mbedtls_ssl_conf_max_frag_len(&(ssl->sslConfig), MBEDTLS_SSL_MAX_FRAG_LEN_4096)) != 0) {
        DBG(" mbedtls_ssl_conf_max_frag_len returned -0x%x", -value);
        return HTTP_MBEDTLS_ERR;
    }
#endif

#if defined(MBEDTLS_X509_CRT_PARSE_C)
    mbedtls_ssl_conf_cert_profile(&ssl->sslConfig, &ssl->crtProfile);
    mbedtls_ssl_conf_ca_chain(&(ssl->sslConfig), &(ssl->caCert), NULL);
    if(flag == 1) {
        if ((value = mbedtls_ssl_conf_own_cert(&(ssl->sslConfig), &(ssl->clientCert), &(ssl->pkContext))) != 0) {
            DBG("  failed! mbedtls_ssl_conf_own_cert returned -0x%x", -value);
            return HTTP_MBEDTLS_ERR;
        }
    }
#endif

    mbedtls_ssl_conf_session_tickets(&(ssl->sslConfig), MBEDTLS_SSL_SESSION_TICKETS_ENABLED);

    if(context->ciphersuite[0] != 0xFFFF){
        mbedtls_ssl_conf_ciphersuites(&(ssl->sslConfig), (const int *)(context->ciphersuite));
        DBG("conf ciphersuite 0x%x", context->ciphersuite[0]);
    }

    mbedtls_ssl_conf_rng(&(ssl->sslConfig), sslRandom, &(ssl->ctrDrbgContext));
    mbedtls_ssl_conf_dbg(&(ssl->sslConfig), sslDebug, NULL);

#if defined(MBEDTLS_SSL_ALPN)
    const char *alpn_list[] = { "http/1.1", NULL };
    mbedtls_ssl_conf_alpn_protocols(&(ssl->sslConfig),alpn_list);
#endif

    if(context->timeout_r > 0) {
        uint32_t recvTimeout;
        recvTimeout = context->timeout_r > MAX_TIMEOUT ? MAX_TIMEOUT * 1000 : context->timeout_r * 1000;
        mbedtls_ssl_conf_read_timeout(&(ssl->sslConfig), recvTimeout);
    }
    //DBG("before ssl setup:%d", xBytesTaskMalloced);
    if ((value = mbedtls_ssl_setup(&(ssl->sslContext), &(ssl->sslConfig))) != 0) {
        DBG(" failed! mbedtls_ssl_setup returned -0x%x", -value);
        return HTTP_MBEDTLS_ERR;
    }
    mbedtls_ssl_set_hostname(&(ssl->sslContext), host);
    mbedtls_ssl_set_bio(&(ssl->sslContext), &(ssl->netContext), (mbedtls_ssl_send_t*)mbedtls_net_send, (mbedtls_ssl_recv_t*)mbedtls_net_recv, (mbedtls_ssl_recv_timeout_t*)mbedtls_net_recv_timeout);
    
    /*
     * 3. session resumption
     */
    if(context->cache == 1 && gSslSessionContext != NULL){
        DBG("has set cache and saved session");
        if(strncasecmp((const CHAR*)gSslSessionContext->server, host, strlen(host)) == 0 && gSslSessionContext->port == context->port)
        {
            DBG("current connect is the same");
            pSavedSession = malloc(sizeof(mbedtls_ssl_session));
            configASSERT(pSavedSession != NULL);

            if( ( value = mbedtls_ssl_session_load( pSavedSession,
                                                  (const unsigned char*)gSslSessionContext->session,
                                                  gSslSessionContext->session_len ) ) == 0 )
            {
                DBG("session_load success");
                if( ( value = mbedtls_ssl_set_session( &(ssl->sslContext), pSavedSession ) ) != 0 )
                {
                    DBG(" failed! mbedtls_ssl_set_session returned -0x%x", -value );
                }
            }
            else
            {
                DBG(" failed! mbedtls_ssl_session_load returned -0x%x no session resumption", -value );
            }
        }
    }

    /*
     * 4. Handshake
     */
    //DBG("after ssl setup before handshake:%d", xBytesTaskMalloced);
    DBG("STEP 3. Performing the SSL/TLS handshake...");
    
    while ((value = mbedtls_ssl_handshake(&(ssl->sslContext))) != 0) {
        if ((value != MBEDTLS_ERR_SSL_WANT_READ) && (value != MBEDTLS_ERR_SSL_WANT_WRITE)) {
            DBG("failed  ! mbedtls_ssl_handshake returned -0x%x", -value);
            return HTTP_MBEDTLS_ERR;
        }
    }
    //DBG("after handshake:%d", xBytesTaskMalloced);

    /*
     * 5. Verify the server certificate
     */
    DBG("STEP 4. Verifying peer X.509 certificate..");
    flag = mbedtls_ssl_get_verify_result(&(ssl->sslContext));
    if (flag != 0) {
        DBG(" failed  ! verify result not confirmed.");
        return HTTP_MBEDTLS_ERR;
    }

    /*
     * 6. Save session for session resumption
     */
    /* get size of the buffer needed */
    if(context->cache == 1){
        if(gSslSessionContext == NULL){//not save it yet
            DBG("not save session yet(%d)", sizeof(sslSessionContext));
            gSslSessionContext = (sslSessionContext*)malloc(sizeof(sslSessionContext));
            configASSERT(gSslSessionContext != NULL);
            memset(gSslSessionContext, 0, sizeof(sslSessionContext));
            bDirectSaveSession = TRUE;
        }else{//has saved session, to check whether the session is same with current session to be establish
            if(strncasecmp((const CHAR*)gSslSessionContext->server, host, strlen(host)) == 0 && gSslSessionContext->port == context->port){
                DBG("current connect is the same");
                if(ssl->sslContext.session->ticket_len != pSavedSession->ticket_len
                    || memcmp(ssl->sslContext.session->ticket,pSavedSession->ticket, ssl->sslContext.session->ticket_len) != 0){
                    DBG("server has give a new ticket, save it");
                    bDirectSaveSession = TRUE;
                }
            }else{
                DBG("current connect is diff save new session");
                bDirectSaveSession = TRUE;
            }
        }
        if(bDirectSaveSession == TRUE){
            mbedtls_ssl_session_save( mbedtls_ssl_get_session_pointer(&(ssl->sslContext)),NULL, 0, &(gSslSessionContext->session_len) );
            DBG("new session need %d bytes", gSslSessionContext->session_len);
            if(gSslSessionContext->session_len < SSL_SESSION_MAX_LEN){//this session can save in cache so save it. else not save it
                /* actually save session data */
                if( (value = mbedtls_ssl_session_save( mbedtls_ssl_get_session_pointer(&(ssl->sslContext)),
                                                      gSslSessionContext->session, gSslSessionContext->session_len,
                                                      &gSslSessionContext->session_len ) ) != 0 ){
                    DBG("failed ! mbedtls_ssl_session_saved returned -0x%x", -value );
                }else{
                    DBG("new session get success");
                    strcpy(gSslSessionContext->server, host);
                    gSslSessionContext->port = context->port;
                    sslSaveSession();
                }
            }
        }
    }
    if(pSavedSession != NULL)
    {
        mbedtls_ssl_session_free(pSavedSession);
        free(pSavedSession);
    }

    return HTTP_OK;
}

/****************************************************************************************************************************
 ****************************************************************************************************************************
 *  EXTERNAL/GLOBAL FUNCTION 
 ****************************************************************************************************************************
****************************************************************************************************************************/
#define __DEFINE_GLOBAL_FUNCTION__//just for easy to find this position

void basicAuth(HttpClientContext* context, const char* user, const char* password) //Basic Authentification
{
    if (context->basicAuthUser)
        free(context->basicAuthUser);
    context->basicAuthUser = (char *)malloc(strlen(user)+1);
    strcpy(context->basicAuthUser, user);
    if (context->basicAuthPassword)
        free(context->basicAuthPassword);
    context->basicAuthPassword = (char *)malloc(strlen(password)+1);
    strcpy(context->basicAuthPassword, password);//not free yet!!!
}

void custHeader(HttpClientContext* context, char *header)
{
    context->custHeader = header;
}

HTTPResult httpParseURL(HttpClientContext* context, char* url) 
{
    char scheme[8]= {0};
    uint16_t port;
    char host[MAXHOST_SIZE] = {0};
    char path[MAXPATH_SIZE] = {0};

    if(context == NULL)
        return HTTP_INTERNAL;
    
    //First we need to parse the url (http[s]://host[:port][/[path]]) -- HTTPS not supported (yet?)
    HTTPResult res = parseURL(url, scheme, sizeof(scheme), host, sizeof(host), &port, path, sizeof(path));
    if(res != HTTP_OK) {
        DBG("parseURL fail");
        return res;
    }

    if(strncasecmp((const char*)scheme, "https", strlen("https")) == 0)
        context->isHttps = true;
    else
        context->isHttps = false;
    
    DBG("isHttps=%d", context->isHttps);
    
    return HTTP_OK;
}


HTTPResult httpConnect(HttpClientContext* context, const char* url) //Execute request
{
    HTTPResult ret;
    
    char scheme[8]= {0};
    uint16_t port;
    char host[MAXHOST_SIZE] = {0};
    char path[MAXPATH_SIZE] = {0};
    
    DBG("httpConnect parse url: [%s]", url);
    //First we need to parse the url (http[s]://host[:port][/[path]]) -- HTTPS not supported (yet?)
    HTTPResult res = parseURL(url, scheme, sizeof(scheme), host, sizeof(host), &port, path, sizeof(path));
    if(res != HTTP_OK) {
        HTTPERR("parseURL returned %d", res);
        return res;
    }

    if(strncasecmp((const char*)scheme, "https", strlen("https")) == 0)
        context->isHttps = TRUE;
    else
        context->isHttps = FALSE;
    
    if(port == 0) { 
        if(context->isHttps)
            port = 443;
        else
            port = 80;
    }
    context->port = port;
    
    HTTPDBG("httpConnect Scheme: %s", scheme);
    HTTPDBG("httpConnect Host: %s", host);
    HTTPDBG("httpConnect Port: %d", port);
    HTTPDBG("httpConnect Path: %s", path);
    
    if(context->isHttps) {
        ret = httpSslConn(context, host);
        if(HTTP_OK == ret) {
            HttpClientSsl *ssl = (HttpClientSsl *)context->ssl;
            context->socket = ssl->netContext.fd;
        }
    } else {
        ret = httpConn(context, host);
    }
    return ret;
}

HTTPResult httpSendRequest(HttpClientContext* context, const char* url, HTTP_METH method,  HttpClientData * data) 
{
    HTTPResult ret = HTTP_CONN;
    if(context->socket <0)
    {
        return ret;
    }
    ret = httpSendHeader(context, url, method, data);
    if(ret != HTTP_OK)
        return ret;
    if(method == HTTP_GET || method == HTTP_POST)
    {
        ret = httpSendUserdata(context, data);
    }
    HTTPDBG("httpSendRequest ret:%d",ret);
    return ret;
}

HTTPResult httpClose(HttpClientContext* context)
{
    HTTPResult ret = HTTP_OK;
    if(context->isHttps)
    {
        ret = httpSslClose(context);
    }
    else
    {
        if(context->socket >= 0)
            close(context->socket);
    }
    /*if(context->basicAuthUser){
        free(context->basicAuthUser);
    if(context->basicAuthPassword)
        free(context->basicAuthPassword);let up level free it*/
    context->socket = -1;
    HTTPDBG("httpClose");
    DBG("httpClose,ret=%d",ret);
    return ret;
}
char *httpRecvRespBuf = NULL;

HTTPResult httpRecvResponse(HttpClientContext* context, HttpClientData * data) 
{
    //Receive response
    HTTPResult ret = HTTP_CONN;
    int32_t trfLen = 0;
    //char buf[CHUNK_SIZE+2] = {0};

    HTTPDBG("Receiving response");
   
    DBG("Receiving response");

    if(context->socket < 0)
        return ret;
    
    httpRecvRespBuf = malloc(CHUNK_SIZE);

    if(httpRecvRespBuf == NULL)
        return HTTP_NO_MEMORY;
    memset(httpRecvRespBuf, 0, (CHUNK_SIZE));
   
    if(data->isMoreContent)
    {
        DBG("data->isMoreContent is true continue parseContent");
        data->respBuf[0] = '\0';
        ret = httpParseContent(context, httpRecvRespBuf, trfLen, data);
    }
    else
    {
         ret = httpRecv(context, httpRecvRespBuf, 1, CHUNK_SIZE - 1, &trfLen);    // recommended by Rob Noble to avoid timeout wait
         if(ret != HTTP_OK)
         {      
            if(httpRecvRespBuf != NULL)
            {
                free(httpRecvRespBuf);
                httpRecvRespBuf = NULL;
            }
            return ret;
         }
         DBG("has read %d bytes", trfLen);
         httpRecvRespBuf[trfLen] = '\0';
         if(trfLen)
         {
             HTTPDBG("Received \r\n(%s\r\n)", httpRecvRespBuf);
             ret = httpParseHeader(context, httpRecvRespBuf, trfLen, data);
         }
     }

     if(httpRecvRespBuf != NULL)
     {
         free(httpRecvRespBuf);
         httpRecvRespBuf = NULL;
     }
     return ret;
}

HTTPResult httpGet(HttpClientContext* context, const char* url,  HttpClientData * data,  int timeout) //Blocking
{
    context->timeout_s = timeout;
    HTTPResult ret = HTTP_CONN;
    ret = httpConnect(context, url);
    if(ret == HTTP_OK)
    {
        ret = httpSendRequest(context, url, HTTP_GET, data);
        if(ret == HTTP_OK)
        {
            ret = httpRecvResponse(context, data);
        }
    }
    return ret;
}

HTTPResult httpPostURL(HttpClientContext* context, const char* url,  HttpClientData * data,  int timeout) //Blocking
{
    context->timeout_s = timeout;
    HTTPResult ret = HTTP_CONN;
    ret = httpConnect(context, url);
    if(ret == HTTP_OK)
    {
        ret = httpSendRequest(context, url, HTTP_POST, data);
        if(ret == HTTP_OK)
        {
            ret = httpRecvResponse(context, data);
        }
    }
    return ret;
}




