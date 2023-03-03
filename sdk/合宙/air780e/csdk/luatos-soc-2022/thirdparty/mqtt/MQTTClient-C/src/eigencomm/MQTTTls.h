
#ifndef MQTT_DTLS_H
#define MQTT_DTLS_H

#include "commonTypedef.h"

#include "mbedtls/net.h"
#include "mbedtls/ssl.h"
#include "mbedtls/certs.h"
#include "mbedtls/entropy.h"
#include "mbedtls/ctr_drbg.h"




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

typedef struct mqttsClientContextTag
{
    int socket;
    int timeout_s;
    int timeout_r;
    int isMqtts;
    int method;
    UINT16 port;
    unsigned int keepAliveInterval;
    size_t sendBufSize;
    size_t readBufSize;
    unsigned char *sendBuf;
    unsigned char *readBuf;
    
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

}mqttsClientContext;



int mqttSslConn_old(mqttsClientContext* context, char* host);
int mqttSslSend(mqttsClientContext* context, unsigned char* buf, int len);
int mqttSslRecv(mqttsClientContext* context, unsigned char* buf, int minLen, int maxLen, int* pReadLen);
int mqttSslRead(mqttsClientContext* context, unsigned char *buffer, int len, int timeout_ms);
int mqttSslClose(mqttsClientContext* context);
int mqttSslConn_new(mqttsClientContext* context, char* host);

#endif

