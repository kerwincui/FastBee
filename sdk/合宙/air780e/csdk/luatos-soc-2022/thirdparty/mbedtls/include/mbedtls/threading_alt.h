/**
 * \file threading.h
 *
 * \brief Threading abstraction layer
 *
 *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
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
 *
 *  This file is part of mbed TLS (https://tls.mbed.org)
 */
#ifndef MBEDTLS_THREADING_H
#define MBEDTLS_THREADING_H
#include "FreeRTOS.h"
#include "cmsis_os2.h"
typedef struct
{
    osMutexId_t mutex;
    char is_valid;
} mbedtls_threading_mutex_t;

void threading_mutex_init(mbedtls_threading_mutex_t *mutex);
void threading_mutex_free(mbedtls_threading_mutex_t *mutex);
int threading_mutex_lock(mbedtls_threading_mutex_t *mutex);
int threading_mutex_unlock(mbedtls_threading_mutex_t *mutex);

#ifdef __cplusplus
}
#endif

#endif /* threading.h */
