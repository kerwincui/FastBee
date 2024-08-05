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

#include "infra_compat.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "sdkconfig.h"

#ifdef CONFIG_IDF_TARGET_ESP8266
#include "esp_aes.h"
#else
#include "mbedtls/aes.h"
#endif

#define AES_BLOCK_SIZE 16

typedef struct {
#ifdef CONFIG_IDF_TARGET_ESP8266
    esp_aes_t     ctx;
#else
    mbedtls_aes_context ctx;
#endif
    uint8_t iv[16];
    uint8_t key[16];
} platform_aes_t;

int HAL_Aes128_Cbc_Decrypt(
    p_HAL_Aes128_t aes,
    const void *src,
    size_t blockNum,
    void *dst)
{
    int i   = 0;
    int ret = -1;
    platform_aes_t *p_aes128 = (platform_aes_t *)aes;

    if (!aes || !src || !dst) {
        return ret;
    }

    for (i = 0; i < blockNum; ++i) {
#ifdef CONFIG_IDF_TARGET_ESP8266
        ret = esp_aes_decrypt_cbc(&p_aes128->ctx, src, AES_BLOCK_SIZE, dst, AES_BLOCK_SIZE, p_aes128->iv);
#else
        ret = mbedtls_aes_crypt_cbc(&p_aes128->ctx, MBEDTLS_AES_DECRYPT, AES_BLOCK_SIZE,
                                    p_aes128->iv, src, dst);
#endif
        src += 16;
        dst += 16;
    }

    return ret;
}

int HAL_Aes128_Cbc_Encrypt(
    p_HAL_Aes128_t aes,
    const void *src,
    size_t blockNum,
    void *dst)
{
    int i   = 0;
    int ret = ret;
    platform_aes_t *p_aes128 = (platform_aes_t *)aes;

    if (!aes || !src || !dst) {
        return -1;
    }

    for (i = 0; i < blockNum; ++i) {
#ifdef CONFIG_IDF_TARGET_ESP8266
        ret = esp_aes_encrypt_cbc(&p_aes128->ctx, src, AES_BLOCK_SIZE, dst, AES_BLOCK_SIZE, p_aes128->iv);
#else
        ret = mbedtls_aes_crypt_cbc(&p_aes128->ctx, MBEDTLS_AES_ENCRYPT, AES_BLOCK_SIZE,
                                    p_aes128->iv, src, dst);
#endif
        src += 16;
        dst += 16;
    }

    return ret;
}

DLL_HAL_API int HAL_Aes128_Cfb_Decrypt(
    _IN_ p_HAL_Aes128_t aes,
    _IN_ const void *src,
    _IN_ size_t length,
    _OU_ void *dst)
{
    size_t offset = 0;
    int ret = -1;
    platform_aes_t *p_aes128 = (platform_aes_t *)aes;

    if (!aes || !src || !dst) {
        return ret;
    }

#ifdef CONFIG_IDF_TARGET_ESP8266
    ret = esp_aes_set_encrypt_key(&p_aes128->ctx, p_aes128->key, 128);
    ret = esp_aes_decrypt_cfb128(&p_aes128->ctx, src, length, dst, length, p_aes128->iv, &offset);
#else
    ret = mbedtls_aes_setkey_enc(&p_aes128->ctx, p_aes128->key, 128);
    ret = mbedtls_aes_crypt_cfb128(&p_aes128->ctx, MBEDTLS_AES_DECRYPT, length,
                                   &offset, p_aes128->iv, src, dst);
#endif

    return ret;
}

DLL_HAL_API int HAL_Aes128_Cfb_Encrypt(
    _IN_ p_HAL_Aes128_t aes,
    _IN_ const void *src,
    _IN_ size_t length,
    _OU_ void *dst)
{
    size_t offset = 0;
    int ret = -1;
    platform_aes_t *p_aes128 = (platform_aes_t *)aes;

    if (!aes || !src || !dst) {
        return ret;
    }

#ifdef CONFIG_IDF_TARGET_ESP8266
    ret = esp_aes_encrypt_cfb128(&p_aes128->ctx, src, length, dst, length, p_aes128->iv, &offset);
#else
    ret = mbedtls_aes_crypt_cfb128(&p_aes128->ctx, MBEDTLS_AES_ENCRYPT, length,
                                   &offset, p_aes128->iv, src, dst);
#endif
    return ret;
}

int HAL_Aes128_Destroy(p_HAL_Aes128_t aes)
{
    if (!aes) {
        return -1;
    }

#ifdef CONFIG_IDF_TARGET_ESP8266
    // esp_aes_free(&((platform_aes_t *)aes)->ctx);
#else
    mbedtls_aes_free(&((platform_aes_t *)aes)->ctx);
#endif
    free(aes);

    return 0;
}

p_HAL_Aes128_t HAL_Aes128_Init(
    const uint8_t *key,
    const uint8_t *iv,
    AES_DIR_t dir)
{
    int ret = 0;
    platform_aes_t *p_aes128 = NULL;

    if (!key || !iv) {
        return p_aes128;
    }

    p_aes128 = (platform_aes_t *)calloc(1, sizeof(platform_aes_t));

    if (!p_aes128) {
        return p_aes128;
    }

#ifdef CONFIG_IDF_TARGET_ESP8266
    // esp_aes_init(&p_aes128->ctx);
#else
    mbedtls_aes_init(&p_aes128->ctx);
#endif

    if (dir == HAL_AES_ENCRYPTION) {
#ifdef CONFIG_IDF_TARGET_ESP8266
        ret = esp_aes_set_encrypt_key(&p_aes128->ctx, key, 128);
#else
        ret = mbedtls_aes_setkey_enc(&p_aes128->ctx, key, 128);
#endif
    } else {
#ifdef CONFIG_IDF_TARGET_ESP8266
        ret = esp_aes_set_decrypt_key(&p_aes128->ctx, key, 128);
#else
        ret = mbedtls_aes_setkey_dec(&p_aes128->ctx, key, 128);
#endif
    }

    if (ret == 0) {
        memcpy(p_aes128->iv, iv, 16);
        memcpy(p_aes128->key, key, 16);
    } else {
        free(p_aes128);
        p_aes128 = NULL;
    }

    return (p_HAL_Aes128_t *)p_aes128;
}