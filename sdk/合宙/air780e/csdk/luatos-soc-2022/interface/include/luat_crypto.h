/*
 * Copyright (c) 2022 OpenLuat & AirM2M
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#ifndef Luat_CRYPTO_H
#define Luat_CRYPTO_H

#include "luat_base.h"

/**
 * @defgroup luatos_crypto crypto数据加密
 * @{
 */

/**
 * \brief          进行MD5检验
 * \param input    输入的数据
 * \param ilen     输入的数据长度
 * \param output   输出的MD5检验值
 */
void luat_crypto_md5( unsigned char *input, int ilen, unsigned char output[16] );


/**
 * @brief BASE64加密
 * @param dst buffer
 * @param dlen buffer长度
 * @param olen 写入的字节数
 * @param src 加密密钥
 * @param slen 加密密钥长度
 * @return 0成功
 */
int luat_crypto_base64_encode( unsigned char *dst, size_t dlen, size_t *olen, const unsigned char *src, size_t slen );

/**
 * @brief BASE64解密
 * @param dst buffer
 * @param dlen buffer长度
 * @param olen 写入的字节数
 * @param src 密钥
 * @param slen 密钥长度
 * @return 0成功
 */
int luat_crypto_base64_decode( unsigned char *dst, size_t dlen, size_t *olen, const unsigned char *src, size_t slen );

/**
 * @brief 进行SHA1校验
 * @param input    输入的数据
 * @param ilen     输入的数据长度
 * @param output   输出的SHA1检验值
 */
void luat_crypto_sha1(const unsigned char *input, size_t ilen, unsigned char output[20]);


/**
 * @brief 进行SHA256校验
 * @param input    输入的数据
 * @param ilen     输入的数据长度
 * @param output   输出的SHA1检验值
 * @param is_224   是否是224校验
 */
void luat_crypto_sha256(const unsigned char *input, size_t ilen, unsigned char output[20], int is_224);

/**
 * @brief 产生随机数
 * @param buff    随机数存放地址
 * @param ilen    随机数长度
 */
int luat_crypto_trng(char* buff, size_t len);

/**@}*/ 
#endif