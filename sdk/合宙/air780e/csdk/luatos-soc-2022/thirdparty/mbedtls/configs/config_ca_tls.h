/*
 *the mbedtls configuration file of ec616_0h00 basic
 */

#ifndef MBEDTLS_CONFIG_BASE_H
#define MBEDTLS_CONFIG_BASE_H

/* OS */
#define MBEDTLS_OS_FREERTOS

/*TCPIP STACK*/
#define MBEDTLS_TCPIP_LWIP

/* System support */
#define MBEDTLS_HAVE_ASM
#define MBEDTLS_PLATFORM_MEMORY
#if defined(MBEDTLS_OS_FREERTOS)
#define MBEDTLS_PLATFORM_CALLOC_MACRO calloc //mbedtls_calloc //
#define MBEDTLS_PLATFORM_FREE_MACRO	free //mbedtls_free //
#endif

/* mbed TLS feature support */
#define MBEDTLS_CIPHER_MODE_CBC
#define MBEDTLS_PKCS1_V15
#define MBEDTLS_KEY_EXCHANGE_RSA_ENABLED
//#define MBEDTLS_SSL_PROTO_SSL3
#define MBEDTLS_SSL_PROTO_TLS1
#define MBEDTLS_SSL_PROTO_TLS1_1
#define MBEDTLS_SSL_PROTO_TLS1_2
#define MBEDTLS_THREADING_C
#define MBEDTLS_PLATFORM_C

/* mbed TLS modules */
#define MBEDTLS_AES_C
//#define MBEDTLS_ARC4_C
#define MBEDTLS_ASN1_PARSE_C
#define MBEDTLS_ASN1_WRITE_C
#define MBEDTLS_BIGNUM_C
#define MBEDTLS_CIPHER_C
#define MBEDTLS_CTR_DRBG_C
#define MBEDTLS_DES_C
#define MBEDTLS_ENTROPY_C
#define MBEDTLS_MD_C
#define MBEDTLS_MD5_C
#define MBEDTLS_NET_C
#define MBEDTLS_OID_C
#define MBEDTLS_PK_C
#define MBEDTLS_PK_PARSE_C
#define MBEDTLS_RSA_C
#define MBEDTLS_SHA1_C
#define MBEDTLS_SHA256_C
#define MBEDTLS_SSL_CLI_C

//#define MBEDTLS_SHA256_HW_ADD
//#define MBEDTLS_AES_HW_ALT

//#define MBEDTLS_SSL_SRV_C
#define MBEDTLS_SSL_TLS_C
#define MBEDTLS_X509_CRT_PARSE_C
#define MBEDTLS_X509_CRL_PARSE_C
#define MBEDTLS_X509_CSR_PARSE_C

#define MBEDTLS_X509_USE_C
#define MBEDTLS_CERTS_C
//#define MBEDTLS_SSL_SERVER_NAME_INDICATION
#define MBEDTLS_SSL_ALPN
#define MBEDTLS_KEY_EXCHANGE_PSK_ENABLED
#define MBEDTLS_USE_RAND_API_ENTROPY

//#define MBEDTLS_NO_PLATFORM_ENTROPY
//#define MBEDTLS_ENTROPY_HARDWARE_ALT

/* For test certificates */
#define MBEDTLS_BASE64_C
#define MBEDTLS_PEM_PARSE_C

//#ifdef CONFIG_MBEDTLS_HW_CRYPTO
//#define MBEDTLS_AES_ALT
//#define MBEDTLS_DES_ALT
//#define MBEDTLS_MD5_ALT
//#define MBEDTLS_SHA1_ALT
//#define MBEDTLS_SHA256_ALT
//#define MBEDTLS_SHA512_ALT
//#endif
#define MBEDTLS_SSL_COOKIE_C

#define MBEDTLS_SSL_MAX_CONTENT_LEN         (4*1024)   /**< Size of the input / output buffer */

#define MBEDTLS_AES_ROM_TABLES

#define MBEDTLS_DEBUG_C
#define MBEDTLS_TIMING_C
#define MBEDTLS_TIMING_ALT

//#define MBEDTLS_SELF_TEST


/* enable SHA512 for home_ref_design requirement */
//#define MBEDTLS_SHA512_C

#include "config_ec_dtls_libcoap.h"

#include "mbedtls/check_config.h"

#endif /* MBEDTLS_CONFIG_H */
