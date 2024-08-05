/*
 * ESPRESSIF MIT License
 *
 * Copyright (c) 2019 <ESPRESSIF SYSTEMS (SHANGHAI) PTE LTD>
 *
 * Permission is hereby granted for use on all ESPRESSIF SYSTEMS products, in which case,
 * it is free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the Software is furnished
 * to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 */

#include "infra_types.h"
#include "infra_defs.h"
#include "string.h"
#include "esp_log.h"
#include "esp_ota_ops.h"
#include "mbedtls/sha256.h"
#include "mbedtls/md5.h"
#include "mbedtls/bignum.h"
#include "mbedtls/rsa.h"
#include "ota_wrapper.h"

typedef struct {
    const esp_partition_t     *partition;
    esp_ota_handle_t    handle;
    esp_err_t           write_err;
} hal_ota_t;

static hal_ota_t *s_ota_handle;
static uint8_t security_ota = 0;
static const char *TAG = "ota";

void HAL_Firmware_Persistence_Start(void)
{
    if (s_ota_handle) {
        ESP_LOGE(TAG, "OTA is running...");
        return;
    }

    do {
        esp_err_t err;
        esp_ota_handle_t update_handle = 0;
        const esp_partition_t *update_partition = NULL;

        ESP_LOGI(TAG, "Starting OTA...");
        update_partition = esp_ota_get_next_update_partition(NULL);

        if (update_partition == NULL) {
            ESP_LOGE(TAG, "Passive OTA partition not found");
            break;
        }

        ESP_LOGI(TAG, "Writing to partition subtype %d at offset 0x%x",
                 update_partition->subtype, update_partition->address);

        err = esp_ota_begin(update_partition, OTA_SIZE_UNKNOWN, &update_handle);

        if (err != ESP_OK) {
            ESP_LOGE(TAG, "esp_ota_begin failed, error=0x%x", err);
            break;
        }

        ESP_LOGI(TAG, "esp_ota_begin succeeded");
        ESP_LOGI(TAG, "Please Wait. This may take time");

        s_ota_handle = (hal_ota_t *)HAL_Malloc(sizeof(hal_ota_t));

        if (!s_ota_handle) {
            ESP_LOGE(TAG, "No space for ota handle");
            break;;
        }

        s_ota_handle->partition = update_partition;
        s_ota_handle->handle    = update_handle;
    } while (0);
}

int HAL_Firmware_Persistence_Stop(void)
{
    if (!s_ota_handle) {
        ESP_LOGE(TAG, "OTA doesn't start");
        return NULL_VALUE_ERROR;
    }

    bool err_flag = true;

    do {
        esp_err_t err = esp_ota_end(s_ota_handle->handle);

        if (s_ota_handle->write_err != ESP_OK) {
            ESP_LOGE(TAG, "esp_ota_write failed! err=0x%x", s_ota_handle->write_err);
            break;
        } else if (err != ESP_OK) {
            ESP_LOGE(TAG, "esp_ota_end failed! err=0x%x. Image is invalid", err);
            break;
        }

        err = esp_ota_set_boot_partition(s_ota_handle->partition);

        if (err != ESP_OK) {
            ESP_LOGE(TAG, "esp_ota_set_boot_partition failed! err=0x%x", err);
            break;
        }

        ESP_LOGI(TAG, "esp_ota_set_boot_partition succeeded");

        err_flag = false;
    } while (0);

    HAL_Free(s_ota_handle);
    s_ota_handle = NULL;

    return err_flag ? FAIL_RETURN : SUCCESS_RETURN;
}

int HAL_Firmware_Persistence_Write(char *buffer, uint32_t length)
{
    if (!s_ota_handle) {
        ESP_LOGE(TAG, "OTA doesn't start");
        return NULL_VALUE_ERROR;
    }

    s_ota_handle->write_err = esp_ota_write(s_ota_handle->handle, (const void *) buffer, length);

    if (s_ota_handle->write_err != ESP_OK) {
        ESP_LOGE(TAG, "esp_ota_write failed, err=0x%x", s_ota_handle->write_err);
        return FAIL_RETURN;
    }

    return length;
}

/* RSA Public Key:User needs sign in alibaba cloud to get and replace them. */
const __attribute__((section(".rodata_custom_desc"))) unsigned char ota_pubn_buf[256] = {0xB3, 0x6F, 0xEE, 0x07, 0x2D, 0xB9, 0x5B, 0x11, 0x6E, 0x13, 0x6C, 0xA1, 0x00, 0xAA, 0xAE, 0xB8, 0xC4, 0x2D, 0xB7, 0xF9, 0x4D, 0xEC, 0xC2, 0x82, 0x8A, 0x88, 0x57, 0xAF, 0xEB, 0xFB, 0x74, 0xE4, 0xE0, 0x44, 0xAE, 0xDC, 0x63, 0xEF, 0x85, 0xBC, 0xBE, 0x70, 0x62, 0xC0, 0x1F, 0x06, 0x79, 0x7A, 0x10, 0xCD, 0x94, 0x07, 0x57, 0x65, 0xE4, 0xD2, 0x1F, 0x51, 0x02, 0x87, 0x37, 0x0B, 0x2F, 0xC3, 0x0B, 0xB6, 0x93, 0x7F, 0xBD, 0x5A, 0x35, 0x1A, 0x67, 0xC0, 0xD0, 0x40, 0x48, 0x61, 0x58, 0x34, 0x83, 0x7D, 0x43, 0x82, 0xE8, 0xF8, 0x91, 0xC4, 0x1F, 0x40, 0x98, 0xF4, 0xE0, 0x5A, 0xED, 0x3C, 0x0D, 0x95, 0xBD, 0x24, 0x5F, 0xA3, 0x77, 0xD9, 0xDE, 0x4F, 0x6B, 0xE8, 0x76, 0xCB, 0xB0, 0xE2, 0x18, 0x27, 0xB9, 0x32, 0x19, 0x99, 0x6E, 0xED, 0x2D, 0x18, 0x0A, 0x8A, 0x19, 0xE6, 0x1B, 0x78, 0x9B, 0x70, 0xB6, 0xD7, 0x44, 0x7E, 0xF7, 0x91, 0xDC, 0x94, 0x72, 0xE7, 0x32, 0xE8, 0xDB, 0x51, 0x38, 0x86, 0xC6, 0xBE, 0xEA, 0x82, 0xAE, 0xDF, 0x4B, 0x7F, 0x40, 0xB7, 0x08, 0xDC, 0x67, 0xE8, 0xE6, 0xD3, 0x8F, 0xCC, 0x4A, 0xC9, 0x1F, 0xF3, 0xCC, 0x33, 0xCC, 0xB5, 0xBA, 0x8C, 0xD5, 0x06, 0x63, 0xCB, 0x98, 0x9B, 0xF2, 0xCB, 0xD0, 0x7C, 0xBC, 0xD6, 0x31, 0x53, 0xAE, 0x71, 0xEF, 0xD0, 0xFD, 0x42, 0x8F, 0xC6, 0x19, 0x17, 0x28, 0xE7, 0x52, 0xC6, 0xC1, 0xA4, 0xB4, 0x45, 0x58, 0xC3, 0xDF, 0x0C, 0x2F, 0xB4, 0x8E, 0x81, 0x66, 0x3F, 0x4A, 0xDF, 0x10, 0xB0, 0x0F, 0xF4, 0xDC, 0xF6, 0x80, 0x18, 0xED, 0xFB, 0x1F, 0x32, 0x65, 0xB0, 0x57, 0x95, 0x0C, 0x53, 0xF6, 0x1F, 0xDC, 0xCE, 0x73, 0x59, 0xD8, 0xC9, 0xE6, 0x95, 0x63, 0x4B, 0x0B, 0x1B, 0xB6, 0x76, 0x8B, 0x65, 0xD5, 0x3D};
static const unsigned char ota_pube_buf[3] = {0x01, 0x00, 0x01};

static int ota_rsa_pubkey_verify(const unsigned char *pubkey_n,
                          const unsigned char *pubkey_e,
                          unsigned int pubkey_n_size,
                          unsigned int pubkey_e_size,
                          const unsigned char *dig,
                          unsigned int dig_size,
                          const unsigned char *sig,
                          unsigned int sig_size)
{
    int                   ret = 0;
    mbedtls_rsa_context   ctx;

    if (pubkey_n == NULL || pubkey_n == NULL || dig == NULL || sig == NULL) {
        ret = -1;
        goto EXIT;
    }

    mbedtls_rsa_init(&ctx, MBEDTLS_RSA_PKCS_V15, MBEDTLS_MD_SHA256);
    ret = mbedtls_mpi_read_binary(&ctx.N, pubkey_n, pubkey_n_size);
    if (0 != ret) {
       goto EXIT;
    }
    ret = mbedtls_mpi_read_binary(&ctx.E, pubkey_e, pubkey_e_size);
    if (0 != ret) {
        goto EXIT;
    }
    ctx.len = pubkey_n_size;
    ret = mbedtls_rsa_check_pubkey(&ctx);
    if (0 != ret) {
        goto EXIT;
    }
    ret = mbedtls_rsa_pkcs1_verify(&ctx, NULL, NULL, MBEDTLS_RSA_PUBLIC, MBEDTLS_MD_SHA256,(unsigned int)0, (const unsigned char *)dig, (const unsigned char *)sig);
    if (0 != ret) {
        goto EXIT;
    }
EXIT:
    if(ret != 0) {
        ESP_LOGE(TAG, "rsa verify ret: 0x%x", ret);
    }
    mbedtls_rsa_free(&ctx);
    return ret;
}

static int ota_str2hex(const char *src, char *dest, unsigned int dest_len)
{
    int i, n = 0;
    int ret = -1;
    if((src != NULL) && (dest != NULL) && (strlen(src) % 2 == 0) && (dest_len >= strlen(src) / 2)) {
        ret = 0;
        for(i = 0; src[i]; i += 2) {
            if(src[i] >= 'A' && src[i] <= 'F') {
                dest[n] = src[i] - 'A' + 10;
            }
            else {
                dest[n] = src[i] - '0';
            }
            if(src[i + 1] >= 'A' && src[i + 1] <= 'F') {
                dest[n] = (dest[n] << 4) | (src[i + 1] - 'A' + 10);
            }
            else {
               dest[n] = (dest[n] << 4) | (src[i + 1] - '0');
            }
            ++n;
        }
    }
    return ret;
}

static int ota_to_capital(char *value, int len)
{
    int i = 0;
    int ret = -1;
    if ((value != NULL) && (len > 0)) {
        ret = 0;
        for (; i < len; i++) {
            if (*(value + i) >= 'a' && *(value + i) <= 'z') {
                *(value + i) -= 'a' - 'A';
            }
        }
    }
    return ret;
}

/*base64*/
static const unsigned char base64_dec_map[128] =
{
    127, 127, 127, 127, 127, 127, 127, 127, 127, 127,
    127, 127, 127, 127, 127, 127, 127, 127, 127, 127,
    127, 127, 127, 127, 127, 127, 127, 127, 127, 127,
    127, 127, 127, 127, 127, 127, 127, 127, 127, 127,
    127, 127, 127,  62, 127, 127, 127,  63,  52,  53,
     54,  55,  56,  57,  58,  59,  60,  61, 127, 127,
    127,  64, 127, 127, 127,   0,   1,   2,   3,   4,
      5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
     15,  16,  17,  18,  19,  20,  21,  22,  23,  24,
     25, 127, 127, 127, 127, 127, 127,  26,  27,  28,
     29,  30,  31,  32,  33,  34,  35,  36,  37,  38,
     39,  40,  41,  42,  43,  44,  45,  46,  47,  48,
     49,  50,  51, 127, 127, 127, 127, 127
};

static int ota_base64_decode(const unsigned char *src, unsigned int slen, unsigned char *dst, unsigned int *dlen)
{
    unsigned int i, n;
    unsigned int j, x;
    unsigned char *p;

    for( i = n = j = 0; i < slen; i++ )
    {
        if( ( slen - i ) >= 2 &&
            src[i] == '\r' && src[i + 1] == '\n' )
            continue;

        if( src[i] == '\n' )
            continue;

        if( src[i] == '=' && ++j > 2 )
            return -1;

        if( src[i] > 127 || base64_dec_map[src[i]] == 127 )
            return -1;

        if( base64_dec_map[src[i]] < 64 && j != 0 )
            return -1;

        n++;
    }

    if( n == 0 )
        return 0;

    n = ( ( n * 6 ) + 7 ) >> 3;
    n -= j;

    if( dst == 0 || *dlen < n )
    {
        *dlen = n;
        return -2;
    }

   for( j = 3, n = x = 0, p = dst; i > 0; i--, src++ )
   {
        if( *src == '\r' || *src == '\n' )
            continue;

        j -= ( base64_dec_map[*src] == 64 );
        x  = ( x << 6 ) | ( base64_dec_map[*src] & 0x3F );

        if( ++n == 4 )
        {
            n = 0;
            if( j > 0 ) *p++ = (unsigned char)( x >> 16 );
            if( j > 1 ) *p++ = (unsigned char)( x >>  8 );
            if( j > 2 ) *p++ = (unsigned char)( x       );
        }
    }

    *dlen = p - dst;

    return 0;
}

static int ota_hash_create(const char *signMethod, const unsigned char *src, unsigned char *dst)
{
    if (!signMethod || !src || !dst) {
        ESP_LOGE(TAG, "%s: input parameter invalid", __FUNCTION__);
        return FAIL_RETURN;
    }

    if (!strncmp(signMethod, "SHA256", strlen("SHA256"))) {
        mbedtls_sha256_context ctx;
        mbedtls_sha256_init(&ctx);
        mbedtls_sha256_starts_ret(&ctx, 0);
        mbedtls_sha256_update_ret(&ctx, src, 32);
        mbedtls_sha256_finish_ret(&ctx, dst);
        mbedtls_sha256_free( &ctx );
    } else if (!strncmp(signMethod, "Md5", strlen("Md5"))) {
        mbedtls_md5_context ctx;
        mbedtls_md5_init(&ctx);
        mbedtls_md5_starts_ret(&ctx);
        mbedtls_md5_update_ret(&ctx, src, 16);
        mbedtls_md5_finish_ret(&ctx, dst);
        mbedtls_md5_free( &ctx );
    } else {
        ESP_LOGE(TAG, "%s: Not SHA256 and Md5", __FUNCTION__);
        return FAIL_RETURN;
    }
    return SUCCESS_RETURN;
}

int HAL_OTA_Security_check(const char *digest, const char *sign, const char *signMethod)
{
    if (!digest || !sign || !signMethod) {
        ESP_LOGE(TAG, "%s: input parameter invalid", __FUNCTION__);
        return FAIL_RETURN;
    }

    ESP_LOGI(TAG, "digest is %s, sign is %s, signMethod is %s\n", digest, sign, signMethod);

    if (strncmp(signMethod, "SHA256", strlen("SHA256"))) { //only check signmethod is SHA256
        ESP_LOGI(TAG, "signMethod is %s, regard sign success", signMethod);
        return SUCCESS_RETURN;
    }

    int ret = FAIL_RETURN;
    char sign_hash[66] = {0};
    unsigned char hash[32] = {0};
    unsigned char hash_ctx[32] = {0};

    unsigned int digest_len = 256;
    unsigned char *digest_decode = calloc(1, digest_len + 1);

    if (!digest_decode) {
        ESP_LOGE(TAG, "%s: calloc digest_decode fail", __FUNCTION__);
        return FAIL_RETURN;
    }

    strncpy(sign_hash, sign, strlen(sign) + 1);
    sign_hash[strlen(sign)] = '\0';
    ota_to_capital(sign_hash, strlen(sign_hash));
    ota_str2hex(sign_hash, (char *)hash, sizeof(hash));

    ota_base64_decode((unsigned char *)digest, strlen(digest), digest_decode, &digest_len);

    ota_hash_create(signMethod, hash, hash_ctx);

    ret = ota_rsa_pubkey_verify(ota_pubn_buf, ota_pube_buf, sizeof(ota_pubn_buf), sizeof(ota_pube_buf), hash_ctx, 32, digest_decode, 256);

    if (ret == 0) {
        ESP_LOGI(TAG, "check security success");
        ret = SUCCESS_RETURN;
    }

    free(digest_decode);
    digest_decode = NULL;

    return ret;
}

int HAL_Firmware_Check_Rsa_Key(char *buffer, uint32_t length)
{
    if (!security_ota) {
        return SUCCESS_RETURN;
    }

    if (!s_ota_handle) {
        ESP_LOGE(TAG, "OTA doesn't start");
        return NULL_VALUE_ERROR;
    }
#ifdef CONFIG_IDF_TARGET_ESP8266
    uint8_t *p = (uint8_t *)buffer + 16;
#else
    uint8_t *p = (uint8_t *)buffer + 288;
#endif
    if (memcmp(p, ota_pubn_buf, 256)) {
        ESP_LOGI(TAG, "check firmware key fail");
        return FAIL_RETURN;
    } else {
        ESP_LOGI(TAG, "check firmware key success");
        return SUCCESS_RETURN;
    }
}

void HAL_Firmware_Need_Check_Security_Ota(uint8_t flag)
{
    security_ota = flag;
}