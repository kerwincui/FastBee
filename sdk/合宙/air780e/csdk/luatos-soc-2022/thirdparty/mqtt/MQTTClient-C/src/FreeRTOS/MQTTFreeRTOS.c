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
 *    Ian Craggs - convert to FreeRTOS
 *******************************************************************************/

#include "MQTTFreeRTOS.h"

#include "debug_trace.h"
#include DEBUG_LOG_HEADER_FILE

int FreeRTOSConnectTimeout(INT32 connectFd, UINT32 timeout)
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
    
    if(select(connectFd+1, NULL, &writeSet, &errorSet, &tv)<=0)
    {
        int mErr = sock_get_errno(connectFd);
        //////ECOMM_TRACE(UNILOG_MQTT, mqttConnectTimeout_1, P_WARNING, 1, "connect select<0 get errno=%d", mErr);
        if(mErr)
        {
            return MQTT_CONN;
        }
        else
        {
            return MQTT_TIMEOUT;
        }
    }
    else
    {
        if(FD_ISSET(connectFd, &errorSet))
        {
            int mErr = sock_get_errno(connectFd);
            //////ECOMM_TRACE(UNILOG_MQTT, mqttConnectTimeout_2, P_WARNING, 1, "select error fd set get errno=%d", mErr);
            if(mErr)
            {
                return MQTT_CONN;
            }
        }
        else if(FD_ISSET(connectFd, &writeSet))
        {
            //////ECOMM_TRACE(UNILOG_MQTT, mqttConnectTimeout_3, P_WARNING, 0, "errno=115(EINPROGRESS) connect success in time(10s)");
        }
    }

    return MQTT_CONN_OK;

}

int ThreadStart(Thread* thread, void (*fn)(void*), void* arg)
{
    int rc = 0;
    uint16_t usTaskStackSize = (configMINIMAL_STACK_SIZE * 5);
    UBaseType_t uxTaskPriority = uxTaskPriorityGet(NULL); /* set the priority as the same as the calling task*/

    rc = xTaskCreate(fn,    /* The function that implements the task. */
        "MQTTTask",         /* Just a text name for the task to aid debugging. */
        usTaskStackSize,    /* The stack size is defined in FreeRTOSIPConfig.h. */
        arg,                /* The task parameter, not used in this case. */
        uxTaskPriority,     /* The priority assigned to the task is defined in FreeRTOSConfig.h. */
        &thread->task);     /* The task handle is not used. */

    return rc;
}

void MutexInit(Mutex* mutex)
{
    mutex->sem = xSemaphoreCreateMutex();
}

int MutexLock(Mutex* mutex)
{
    return xSemaphoreTake(mutex->sem, portMAX_DELAY);
}

int MutexUnlock(Mutex* mutex)
{
    return xSemaphoreGive(mutex->sem);
}

void TimerCountdownMS(Timer* timer, unsigned int timeout_ms)
{
    timer->xTicksToWait = timeout_ms / portTICK_PERIOD_MS; /* convert milliseconds to ticks */
    vTaskSetTimeOutState(&timer->xTimeOut); /* Record the time at which this function was entered. */
}

void TimerCountdown(Timer* timer, unsigned int timeout) 
{
    TimerCountdownMS(timer, timeout * 1000);
}

int TimerLeftMS(Timer* timer) 
{
    xTaskCheckForTimeOut(&timer->xTimeOut, &timer->xTicksToWait); /* updates xTicksToWait to the number left */
    return (int)(((int)timer->xTicksToWait < 0) ? 0 : (timer->xTicksToWait * portTICK_PERIOD_MS));
}

char TimerIsExpired(Timer* timer)
{
    return xTaskCheckForTimeOut(&timer->xTimeOut, &timer->xTicksToWait) == pdTRUE;
}

void TimerInit(Timer* timer)
{
    timer->xTicksToWait = 0;
    memset(&timer->xTimeOut, '\0', sizeof(timer->xTimeOut));
}

int socket_connect(Network* n, char* addr){
    int retVal = -1;
    INT32 errCode;
    INT32 flags = 0;
    struct sockaddr_in address;
    int rc = -1;
    sa_family_t family = AF_INET;
    struct addrinfo *result = NULL;
    struct addrinfo hints = {0, AF_UNSPEC, SOCK_STREAM, IPPROTO_TCP, 0, NULL, NULL, NULL};

    if((NetworkSetConnTimeout(n, 5000, 5000)) != 0){
        return 1;
    }

    if ((rc = FreeRTOS_gethostbyname(addr, NULL, &hints, &result)) == 0)
    {
        struct addrinfo* res = result;
        /* prefer ip4 addresses */
        while (res)
        {
            if (res->ai_family == AF_INET)
            {
                result = res;
                break;
            }
            res = res->ai_next;
        }
    
        if (result->ai_family == AF_INET)
        {
            address.sin_port = htons(n->port);
            address.sin_family = family = AF_INET;
            address.sin_addr = ((struct sockaddr_in*)(result->ai_addr))->sin_addr;
        }
        else
            rc = -1;
        freeaddrinfo(result);
    }
    if(rc == 0)
    {
        flags = fcntl(n->my_socket, F_GETFL, 0);
        if ((retVal = FreeRTOS_connect(n->my_socket, (struct sockaddr *)&address, sizeof(address))) < 0)
        {
            errCode = sock_get_errno(n->my_socket);
            if(errCode == EINPROGRESS)
            {
                // ECOMM_TRACE(UNILOG_MQTT, mqttConnectSocket_2, P_ERROR, 0, "mqttConnectSocket connect is ongoing");
                retVal = FreeRTOSConnectTimeout(n->my_socket, 30); //for bearer suspend timeout is 25s
                if(retVal == 0)
                {
                    // ECOMM_TRACE(UNILOG_MQTT, mqttConnectSocket_3, P_INFO, 0, "mqttConnectSocket connect success");
                }
                else
                {
                    // ECOMM_TRACE(UNILOG_MQTT, mqttConnectSocket_4, P_ERROR, 1, "mqttConnectSocket connect fail,error code %d", errCode);
                    if(socket_error_is_fatal(errCode))
                    {
                        retVal = 1;
                    }
                }
            }
            else
            {
                // DBG("sock_get_errno errCode:%d\n",errCode);
                // ECOMM_TRACE(UNILOG_MQTT, mqttConnectSocket_5, P_ERROR, 1, "mqttConnectSocket connect fail %d",errCode);
                retVal = 1;
            }
        }
        else
        {
            //ECOMM_TRACE(UNILOG_MQTT, mqttConnectSocket_1, P_ERROR, 0, "mqttConnectSocket connect success");
        }
        fcntl(n->my_socket, F_SETFL, flags&~O_NONBLOCK); 
    }
    return retVal;
}

int socket_read(Network* n, unsigned char* buffer, int len, int timeout_ms)
{
    #if LWIP_SO_SNDRCVTIMEO_NONSTANDARD
    TickType_t xTicksToWait = timeout_ms / portTICK_PERIOD_MS; /* convert milliseconds to ticks */
    int netSecToWait = timeout_ms / 1000; /*  seconds */
    #else
    TickType_t xTicksToWait = timeout_ms / portTICK_PERIOD_MS; /* convert milliseconds to ticks */
    struct timeval netSecToWait;
    netSecToWait.tv_sec = timeout_ms / 1000; /*  seconds */
    netSecToWait.tv_usec = 0;
    if(netSecToWait.tv_sec == 0)
    {
        netSecToWait.tv_sec = 1;
    }
    #endif  
    
    TimeOut_t xTimeOut;
    int recvLen = 0;

    vTaskSetTimeOutState(&xTimeOut); /* Record the time at which this function was entered. */
    do
    {
        int rc = 0;

        FreeRTOS_setsockopt(n->my_socket, SOL_SOCKET, FREERTOS_SO_RCVTIMEO, &netSecToWait, sizeof(netSecToWait));
        rc = FreeRTOS_recv(n->my_socket, buffer + recvLen, len - recvLen, 0);
        if (rc > 0)
            recvLen += rc;
        else if (rc < 0)
        {
            recvLen = rc;
            break;
        }
        else{
            int mErr = sock_get_errno(n->my_socket);
            if(socket_error_is_fatal(mErr)==1){
                return -2;
            }//maybe closed or reset by peer
        }
    } while (recvLen < len && xTaskCheckForTimeOut(&xTimeOut, &xTicksToWait) == pdFALSE);

    return recvLen;
}

int socket_write(Network* n, unsigned char* buffer, int len, int timeout_ms)
{
    #if LWIP_SO_SNDRCVTIMEO_NONSTANDARD
    TickType_t xTicksToWait = timeout_ms / portTICK_PERIOD_MS; /* convert milliseconds to ticks */
    int netSecToWait = timeout_ms / 1000; /*  seconds */
    #else
    TickType_t xTicksToWait = timeout_ms / portTICK_PERIOD_MS; /* convert milliseconds to ticks */
    struct timeval netSecToWait;
    netSecToWait.tv_sec = timeout_ms / 1000; /*  seconds */
    netSecToWait.tv_usec = 0;
    if(netSecToWait.tv_sec == 0)
    {
        netSecToWait.tv_sec = 1;
    }
    #endif  
    
    TimeOut_t xTimeOut;
    int sentLen = 0;

    vTaskSetTimeOutState(&xTimeOut); /* Record the time at which this function was entered. */
    do
    {
        int rc = 0;

        FreeRTOS_setsockopt(n->my_socket, SOL_SOCKET, FRERRTOS_SO_SNDTIMEO, &netSecToWait, sizeof(netSecToWait));
        rc = FreeRTOS_send(n->my_socket, buffer + sentLen, len - sentLen, 0);
        if (rc > 0)
            sentLen += rc;
        else if (rc < 0)
        {
            sentLen = rc;
            break;
        }
    } while (sentLen < len && xTaskCheckForTimeOut(&xTimeOut, &xTicksToWait) == pdFALSE);

    return sentLen;
}

int socket_disconnect(Network* n)
{
    int ret;

    //ECPLAT_PRINTF(UNILOG_CTWING, FreeRTOS_disconnect_0, P_INFO, "FreeRTOS_disconnect my_socket %d", n->my_socket);
    
    ret = FreeRTOS_closesocket(n->my_socket);
    n->my_socket = -1;
    return ret;
}

int mqttSslRandom(void *p_rng, unsigned char *output, size_t output_len){
    uint32_t rnglen = output_len;
    uint8_t   rngoffset = 0;

    while (rnglen > 0) 
    {
        *(output + rngoffset) = (unsigned char)rand();
        rngoffset++;
        rnglen--;
    }
    return 0;
}

static void mqttSslDebug(void *ctx, int level, const char *file, int line, const char *str){
    //ECPLAT_PRINTF(UNILOG_MQTT, mqttTls_00, P_INFO, "%s(%d):%s", file, line, str);

//    DBG("%s", str);
}

int socket_ssl_connect(Network* n, char* addr){
    int value;
    mqttsClientSsl *ssl;
    const char *custom = "mqtts";
    char port[10] = {0};
    int authmode = MBEDTLS_SSL_VERIFY_NONE;
    uint32_t flag;
    
    ////ECPLAT_PRINTF(UNILOG_HTTP, sslMEM_2, P_INFO, "before ssl context malloc:%d", xBytesTaskMalloced);
    n->ssl = malloc(sizeof(mqttsClientSsl));
    ssl = n->ssl;
    
    /*
     * 0. Initialize the RNG and the session data
     */
// #if defined(MBEDTLS_DEBUG_C)
//     mbedtls_debug_set_threshold((int)2);
// #endif
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
        //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_0, P_INFO, "mbedtls_ctr_drbg_seed failed, value:-0x%x.", -value);
        return MQTT_MBEDTLS_ERR;
    }
    ////ECPLAT_PRINTF(UNILOG_HTTP, sslMEM_3, P_INFO, "after ssl init:%d", xBytesTaskMalloced);
    /*
     * 0. Initialize certificates
     */
    if(n->seclevel != 0){
        if (NULL != n->caCert) {
            //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_1, P_INFO, "STEP 0. Loading the CA root certificate ...");
            authmode = MBEDTLS_SSL_VERIFY_REQUIRED;
            if (0 != (value = mbedtls_x509_crt_parse(&(ssl->caCert), (const unsigned char *)n->caCert, n->caCertLen))) {
                //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_2, P_INFO, "failed ! value:-0x%x", -value);
                return MQTT_MBEDTLS_ERR;
            }
        }
    }
    ////ECPLAT_PRINTF(UNILOG_HTTP, sslMEM_4, P_INFO, "after ca cert parse:%d", xBytesTaskMalloced);
    /* Setup Client Cert/Key */
    if(n->seclevel == 2){
        if (n->clientCert != NULL && n->clientPk != NULL) {
            //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_3, P_INFO, "STEP 0. start prepare client cert ...");
            value = mbedtls_x509_crt_parse(&(ssl->clientCert), (const unsigned char *) n->clientCert, n->clientCertLen);
            if (value != 0) {
                //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_4, P_INFO, "failed!  mbedtls_x509_crt_parse returned -0x%x\n", -value);
                return MQTT_MBEDTLS_ERR;
            }

            //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_5, P_INFO, "n->clientPkLen=%d", n->clientPkLen);
            
            
            value = mbedtls_pk_parse_key(&ssl->pkContext, (const unsigned char *) n->clientPk, n->clientPkLen, NULL, 0);
    
            if (value != 0) {
                //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_6, P_INFO, "failed !  mbedtls_pk_parse_key returned -0x%x\n", -value);
                return MQTT_MBEDTLS_ERR;
            }
        }
    }
    if(n->seclevel == 0){
        //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_7, P_INFO, "user set verify none");
        authmode = MBEDTLS_SSL_VERIFY_NONE;
    }
    //ali mqtts is psk tls
    if((n->psk_key != NULL)&&(n->psk_identity != NULL))
    {
        mbedtls_ssl_conf_psk(&ssl->sslConfig, (const unsigned char *)n->psk_key, strlen(n->psk_key),
                             (const unsigned char *)n->psk_identity, strlen(n->psk_identity));
    }
    
    /*
     * 1. Start the connection
     */
    snprintf(port, sizeof(port), "%d", n->port);
    //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_8_0, P_INFO, "STEP 1. host:%s", host);
    //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_8_1, P_INFO, "STEP 1. Connecting to PORT:%d",n->port);
    //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_8_2, P_INFO, "STEP 1. port:%s", port);
    if (0 != (value = mbedtls_net_connect(&ssl->netContext, addr, port, MBEDTLS_NET_PROTO_TCP, LWIP_PS_INVALID_CID))) {
        //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_9, P_INFO, " failed ! mbedtls_net_connect returned -0x%x", -value);
        return MQTT_MBEDTLS_ERR;
    }

    
    /*
     * 2. Setup stuff
     */
    //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_10, P_INFO, "STEP 2. Setting up the SSL/TLS structure...");
    if ((value = mbedtls_ssl_config_defaults(&(ssl->sslConfig), MBEDTLS_SSL_IS_CLIENT, MBEDTLS_SSL_TRANSPORT_STREAM,
                                           MBEDTLS_SSL_PRESET_DEFAULT)) != 0) {
        //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_11, P_INFO, " failed! mbedtls_ssl_config_defaults returned -0x%x", -value);
        return MQTT_MBEDTLS_ERR;
    }

    ////ECPLAT_PRINTF(UNILOG_HTTP, sslMEM_6, P_INFO, "after net connect:%d", xBytesTaskMalloced);
    mbedtls_ssl_conf_max_version(&ssl->sslConfig, MBEDTLS_SSL_MAJOR_VERSION_3, MBEDTLS_SSL_MINOR_VERSION_3);
    mbedtls_ssl_conf_min_version(&ssl->sslConfig, MBEDTLS_SSL_MAJOR_VERSION_3, MBEDTLS_SSL_MINOR_VERSION_3);

    memcpy(&(ssl->crtProfile), ssl->sslConfig.cert_profile, sizeof(mbedtls_x509_crt_profile));
    mbedtls_ssl_conf_authmode(&(ssl->sslConfig), authmode);

#if defined(MBEDTLS_SSL_MAX_FRAGMENT_LENGTH)
    if ((value = mbedtls_ssl_conf_max_frag_len(&(ssl->sslConfig), MBEDTLS_SSL_MAX_FRAG_LEN_4096)) != 0) {
        //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_12, P_INFO, " mbedtls_ssl_conf_max_frag_len returned -0x%x", -value);
        return MQTT_MBEDTLS_ERR;
    }
#endif

#if defined(MBEDTLS_X509_CRT_PARSE_C)
    mbedtls_ssl_conf_cert_profile(&ssl->sslConfig, &ssl->crtProfile);
    mbedtls_ssl_conf_ca_chain(&(ssl->sslConfig), &(ssl->caCert), NULL);
    if(n->clientCert) {
        if ((value = mbedtls_ssl_conf_own_cert(&(ssl->sslConfig), &(ssl->clientCert), &(ssl->pkContext))) != 0) {
            //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_13, P_INFO, "  failed! mbedtls_ssl_conf_own_cert returned -0x%x", -value);
            return MQTT_MBEDTLS_ERR;
        }
    }
#endif

    if(n->ciphersuite[0] != 0xFFFF){
        mbedtls_ssl_conf_ciphersuites(&(ssl->sslConfig), (const int *)(n->ciphersuite));
        //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_14, P_INFO, "conf ciphersuite 0x%x", n->ciphersuite[0]);
    }

    mbedtls_ssl_conf_rng(&(ssl->sslConfig), mqttSslRandom, &(ssl->ctrDrbgContext));
    mbedtls_ssl_conf_dbg(&(ssl->sslConfig), mqttSslDebug, NULL);

#if defined(MBEDTLS_SSL_ALPN)
    const char *alpn_list[] = { "http/1.1", NULL };
    mbedtls_ssl_conf_alpn_protocols(&(ssl->sslConfig),alpn_list);
#endif

    if(n->timeout_r > 0) {
        uint32_t recvTimeout;
        recvTimeout = n->timeout_r > MQTT_MAX_TIMEOUT ? MQTT_MAX_TIMEOUT * 1000 : n->timeout_r * 1000;
        mbedtls_ssl_conf_read_timeout(&(ssl->sslConfig), recvTimeout);
    }
    ////ECPLAT_PRINTF(UNILOG_HTTP, sslMEM_7, P_INFO, "before ssl setup:%d", xBytesTaskMalloced);
    if ((value = mbedtls_ssl_setup(&(ssl->sslContext), &(ssl->sslConfig))) != 0) {
        //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_15, P_INFO, " failed! mbedtls_ssl_setup returned -0x%x", -value);
        return MQTT_MBEDTLS_ERR;
    }
    if(n->hostName != NULL)
    {
        mbedtls_ssl_set_hostname(&(ssl->sslContext), n->hostName);
    }
    else
    {
        mbedtls_ssl_set_hostname(&(ssl->sslContext), addr);
    }
    mbedtls_ssl_set_bio(&(ssl->sslContext), &(ssl->netContext), (mbedtls_ssl_send_t*)mbedtls_net_send, (mbedtls_ssl_recv_t*)mbedtls_net_recv, (mbedtls_ssl_recv_timeout_t*)mbedtls_net_recv_timeout);
    

    /*
     * 3. Handshake
     */
    ////ECPLAT_PRINTF(UNILOG_HTTP, sslMEM_8, P_INFO, "after ssl setup before handshake:%d", xBytesTaskMalloced);
    //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_16, P_INFO, "STEP 3. Performing the SSL/TLS handshake...");
    
    while ((value = mbedtls_ssl_handshake(&(ssl->sslContext))) != 0) {
        if ((value != MBEDTLS_ERR_SSL_WANT_READ) && (value != MBEDTLS_ERR_SSL_WANT_WRITE)) {
            //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_17, P_INFO, "failed  ! mbedtls_ssl_handshake returned -0x%x", -value);
            return MQTT_MBEDTLS_ERR;
        }
    }
    ////ECPLAT_PRINTF(UNILOG_HTTP, sslMEM_9, P_INFO, "after handshake:%d", xBytesTaskMalloced);

    /*
     * 4. Verify the server certificate
     */
    //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_18, P_INFO, "STEP 4. Verifying peer X.509 certificate..");
    flag = mbedtls_ssl_get_verify_result(&(ssl->sslContext));
    if (flag != 0) {
        //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_19, P_INFO, " failed  ! verify result not confirmed.");
        return MQTT_MBEDTLS_ERR;
    }
    //ECPLAT_PRINTF(UNILOG_MQTT, mqttTlsConn_20, P_INFO, "caCert varification ok");

    return MQTT_CONN_OK;
}

int socket_ssl_read(Network *n, unsigned char *buffer, int len, int timeout_ms) {
    UINT32          readLen = 0;
    static int      net_status = 0;
    INT32             ret = -1;
    char            err_str[33];
    mqttsClientSsl *ssl = (mqttsClientSsl *)n->ssl;

    mbedtls_ssl_conf_read_timeout(&(ssl->sslConfig), timeout_ms);
    while (readLen < len) {
        ret = mbedtls_ssl_read(&(ssl->sslContext), (unsigned char *)(buffer + readLen), (len - readLen));
        if (ret > 0) {
            readLen += ret;
            net_status = 0;
        } else if (ret == 0) {
            /* if ret is 0 and net_status is -2, indicate the connection is closed during last call */
            return (net_status == -2) ? net_status : readLen;
        } else {
            if (MBEDTLS_ERR_SSL_PEER_CLOSE_NOTIFY == ret) {
                //mbedtls_strerror(ret, err_str, sizeof(err_str));
                printf("ssl recv error: code = -0x%04X, err_str = '%s'\n", -ret, err_str);
                net_status = -2; /* connection is closed */
                break;
            } else if ((MBEDTLS_ERR_SSL_TIMEOUT == ret)
                       || (MBEDTLS_ERR_SSL_CONN_EOF == ret)
                       || (MBEDTLS_ERR_SSL_SESSION_TICKET_EXPIRED == ret)
                       || (MBEDTLS_ERR_SSL_NON_FATAL == ret)) {
                /* read already complete */
                /* if call mbedtls_ssl_read again, it will return 0 (means EOF) */

                return readLen;
            } else {
                //mbedtls_strerror(ret, err_str, sizeof(err_str));
                printf("ssl recv error: code = -0x%04X, err_str = '%s'\n", -ret, err_str);
                net_status = -1;
                return -1; /* Connection error */
            }
        }
    }

    return (readLen > 0) ? readLen : net_status;
}

int socket_ssl_write(Network *n, unsigned char *buffer, int len, int timeout_ms) {
    INT32 waitToSend = len;
    INT32 hasSend = 0;
    mqttsClientSsl *ssl = (mqttsClientSsl *)n->ssl;
    do
    {
        hasSend = mbedtls_ssl_write(&(ssl->sslContext), (unsigned char *)(buffer + len - waitToSend), waitToSend);
        if(hasSend > 0)
        {
            waitToSend -= hasSend;
        }
        else if(hasSend == 0)
        {
            return len;
        }
        else
        {
            //ECOMM_TRACE(UNILOG_MQTT, mqttTls_23, P_SIG, 0, "mqtt_client(ssl): send failed \n");
            return 0;
        }
    }while(waitToSend>0);

    return len;
}

void socket_ssl_disconnect(Network *n) {

    mqttsClientSsl *ssl = (mqttsClientSsl *)n->ssl;

    if(ssl == NULL)
        return ;

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
    n->ssl = NULL;

    //ECOMM_TRACE(UNILOG_MQTT, mqttTls_36, P_INFO, 0, "mqtt tls close ok");
    return ;
}

int NetworkConnect(Network* n, char* addr, int port){
    n->addr = addr;
    n->port = port;
    if (n->isMqtts){
        if (socket_ssl_connect(n, addr)==MQTT_CONN_OK){
            mqttsClientSsl *ssl = (mqttsClientSsl *)n->ssl;
            n->my_socket = ssl->netContext.fd;
            return 0;
        }
        return 1;
    }
    else
        return socket_connect(n, addr);
}
#include "luat_wdt.h"
int FreeRTOS_read(Network* n, unsigned char* buffer, int len, int timeout_ms){
    luat_wdt_feed();
    if (n->isMqtts)
        return socket_ssl_read(n, buffer, len, timeout_ms);
    else
        return socket_read(n, buffer, len, timeout_ms);
}

int FreeRTOS_write(Network* n, unsigned char* buffer, int len, int timeout_ms){
    if (n->isMqtts)
        return socket_ssl_write(n, buffer, len, timeout_ms);
    else
        return socket_write(n, buffer, len, timeout_ms);
}

int FreeRTOS_disconnect(Network* n){
    if (n->isMqtts)
        socket_ssl_disconnect(n);
    else
        socket_disconnect(n);
    return 0;
}

void NetworkInit(Network* n)
{
    n->my_socket = -1;
    
    n->mqttread = FreeRTOS_read;
    n->mqttwrite = FreeRTOS_write;
    n->disconnect = FreeRTOS_disconnect;
}

int NetworkSetConnTimeout(Network* n, int send_timeout, int recv_timeout)
{
    int ret = 0;
    #if LWIP_SO_SNDRCVTIMEO_NONSTANDARD
    int tx_timeout = send_timeout;
    int rx_timeout = recv_timeout;
    #else
    struct timeval tx_timeout;
    tx_timeout.tv_sec = send_timeout/1000;
    tx_timeout.tv_usec = (send_timeout%1000)*1000;
    struct timeval rx_timeout;
    rx_timeout.tv_sec = recv_timeout/1000;
    rx_timeout.tv_usec = (recv_timeout%1000)*1000;
    #endif     

    if(n->my_socket == -1)
    {
        if ((n->my_socket = FreeRTOS_socket(FREERTOS_AF_INET, FREERTOS_SOCK_STREAM, FREERTOS_IPPROTO_TCP)) < 0)
        {
            //ECPLAT_PRINTF(UNILOG_CTWING, NetworkSetConnTimeout_0, P_INFO, "NetworkSetConnTimeout my_socket fail %d", n->my_socket);
            return 1;
        }
    }
    
    ret = FreeRTOS_setsockopt(n->my_socket, SOL_SOCKET, SO_SNDTIMEO, &tx_timeout, sizeof(tx_timeout));
    if(ret != 0)
    {    
        //ECPLAT_PRINTF(UNILOG_CTWING, NetworkSetConnTimeout_1, P_INFO, "NetworkSetConnTimeout send fail %d", ret);
        //return 1;
    }
    ret = FreeRTOS_setsockopt(n->my_socket, SOL_SOCKET, SO_RCVTIMEO, &rx_timeout, sizeof(rx_timeout));
    if(ret != 0)
    {
        //ECPLAT_PRINTF(UNILOG_CTWING, NetworkSetConnTimeout_2, P_INFO, "NetworkSetConnTimeout recv fail %d", ret);
        //return 1;
    }
    INT32 flags = fcntl(n->my_socket, F_GETFL, 0);
    if(flags < 0)
    {
        //ECPLAT_PRINTF(UNILOG_CTWING, NetworkSetConnTimeout_3, P_INFO, "NetworkSetConnTimeout fcntl fail %d", flags);
        close(n->my_socket);
        n->my_socket = -1;
        return 1;
    }
    
    fcntl(n->my_socket, F_SETFL, flags|O_NONBLOCK); //set socket as nonblock for connect timeout
    
    return 0;
}
