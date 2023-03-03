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
 
#ifndef HTTP_CLIENT_H
#define HTTP_CLIENT_H

#include "commonTypedef.h"
#include "common_api.h"
#include "mbedtls/net.h"
#include "mbedtls/ssl.h"
#include "mbedtls/certs.h"
#include "mbedtls/entropy.h"
#include "mbedtls/ctr_drbg.h"

#define MAXPATH_SIZE 260
#define HTTP_CLIENT_DEFAULT_TIMEOUT 15000

///HTTP client results
typedef enum {
    HTTP_OK = 0,        ///<Success
    HTTP_PARSE,         ///1<url Parse error
    HTTP_DNS,           ///2<Could not resolve name
    HTTP_PRTCL,         ///3<Protocol error
    HTTP_SOCKET_FAIL,   ///4<create socket fail
    HTTP_BIND_FAIL,     ///5<bind fail  
    HTTP_TIMEOUT,       ///6<Connection timeout
    HTTP_CONN,          ///7<Connection error
    HTTP_CLOSED,        ///8<Connection was closed by remote host
    HTTP_MBEDTLS_ERR,   ///9<meet ssl error
    HTTP_MOREDATA,      ///10<Need get more data
    HTTP_OVERFLOW,      ///11<Buffer overflow
    HTTP_REQ_TIMEOUT,   ///12<HTTP request timeout waittime is 60s
    HTTP_NO_MEMORY,     ///13<memory not enough
    HTTP_INTERNAL       ///14<Internal error
}HTTPResult;


typedef enum  {
    HTTP_GET,
    HTTP_POST,
    HTTP_PUT,
    HTTP_DELETE,
    HTTP_HEAD
}HTTP_METH;

typedef struct HttpClientSslTag
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
}HttpClientSsl;

typedef struct HttpClientContextTag
{
    int socket;
    int timeout_s;
    int timeout_r;
    bool isHttps;
    int method;
    uint16_t port;
    char* basicAuthUser;
    char* basicAuthPassword;
    char* custHeader;
    int httpResponseCode;
    HttpClientSsl * ssl;
    char *caCert;
    char *clientCert;
    char *clientPk;
    int32_t caCertLen;
    int32_t clientCertLen;
    int32_t clientPkLen;
    uint8_t seclevel;//0:no verify; 1:verify server; 2:both verify
    int32_t ciphersuite[2];//just like 0x0035 TLS_RSA_WITH_AES_256_CBC_SHA,ciphersuite[1] must NULL
    uint8_t pdpId;//pdp context id--cid--0 is default
    uint8_t cache;//0:no session resumption; 1:session resumption
    uint8_t sni;//0:no sni; 1:has sni
    uint8_t ignore;//0:not ignore; 1:ignore
    uint8_t saveMem;//0:disable; 1:enable
}HttpClientContext;

typedef struct HttpClientDataTag
{
    char * postBuf;         //user data to be post
    int postBufLen;
    char * postContentType; //content type of the post data
    int recvContentLength;  //response content length
    int needObtainLen;      //content length hasn't get
    int blockContentLen;    //content length of one block
    bool isChunked;
    bool isMoreContent;
    char * respBuf;         //buffer to store the response body data
    char * headerBuf;       //buffer to store the response head data
    int respBufLen;
    int  headerBufLen;
    bool isRange;         //if get file by Range, each block (rangeTail-rangeHead+1) bytes 
    int rangeHead;
    int rangeTail;
    int contentRange;
}HttpClientData;


#define HTTPDBG(x, ...)      
#define HTTPWARN(x, ...)     
#define HTTPERR(x, ...)      
#define HTTPINFO(x, ...)     

/// Get the text form of the error number
/// 
/// Gets a pointer to a text message that described the result code.
///
/// @param[in] res is the HTTPResult code to translate to text.
/// @returns a pointer to a text message.
///
const char * GetErrorMessage(HTTPResult res);

/**
Provides a basic authentification feature (Base64 encoded username and password)
Pass two NULL pointers to switch back to no authentication
@param[in] user username to use for authentication, must remain valid durlng the whole HTTP session
@param[in] user password to use for authentication, must remain valid durlng the whole HTTP session
*/
void basicAuth(HttpClientContext* context, const char* user, const char* password); //Basic Authentification

/**
Set custom headers for request.

Pass NULL, 0 to turn off custom headers.

@code
 const char * hdrs[] = 
        {
        "Connection", "keep-alive",
        "Accept", "text/html",
        "User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64)",
        "Accept-Encoding", "gzip,deflate,sdch",
        "Accept-Language", "en-US,en;q=0.8",
        };

    http.basicAuth("username", "password");
    http.customHeaders(hdrs, 5);
@endcode

@param[in] headers an array (size multiple of two) key-value pairs, must remain valid during the whole HTTP session
@param[in] pairs number of key-value pairs
*/
void customHeaders(HttpClientContext* context, char** headers, int pairs);

HTTPResult httpSendRequest(HttpClientContext* context, const char* url, HTTP_METH method,  HttpClientData * data); 
HTTPResult httpRecvResponse(HttpClientContext* context, HttpClientData * data); 

//High Level setup functions
/** Execute a GET request on the URL
Blocks until completion
@param[in] url : url on which to execute the request
@param[in,out] pDataIn : pointer to an IHTTPDataIn instance that will collect the data returned by the request, can be NULL
@param[in] timeout waiting timeout in ms (osWaitForever for blocking function, not recommended)
@return 0 on success, HTTP error (<0) on failure
*/
HTTPResult httpGet(HttpClientContext* context, const char* url,  HttpClientData * data,  int timeout);

HTTPResult httpPostURL(HttpClientContext* context, const char* url,  HttpClientData * data,  int timeout);

HTTPResult httpConnect(HttpClientContext* context, const char* url); //Execute request

HTTPResult httpClose(HttpClientContext* context);

HTTPResult httpRecv(HttpClientContext* context, char* buf, int32_t minLen, int32_t maxLen, int32_t* pReadLen);

HTTPResult httpSend(HttpClientContext* context, const char* buf, uint16_t len); //0 on success, err code on failure

HTTPResult httpParseURL(HttpClientContext* context, char* url);

#endif
