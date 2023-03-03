/**
 * \file base64.h
 *
 * \brief RFC 1521 base64 encoding/decoding
 */
/*
 *  Copyright The Mbed TLS Contributors
 *  SPDX-License-Identifier: Apache-2.0
 *
 *  Licensed under the Apache License, Version 2.0 (the "License"); you may
 *  not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 *  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
#ifndef MBEDTLS_BASE64_H
#define MBEDTLS_BASE64_H


#ifdef __cplusplus
extern "C" {
#endif

int32_t iBase64Encode(const uint8_t *pcInputData, int32_t iInputLength, uint8_t *pucOutputData);
int32_t iBase64Decode(const uint8_t *pcInputData, int32_t iInputLength, uint8_t *pucOutputData);


#ifdef __cplusplus
}
#endif

#endif /* base64.h */
