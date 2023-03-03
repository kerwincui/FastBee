/* Copyright (C) 2018 RDA Technologies Limited and/or its affiliates("RDA").
 * All rights reserved.
 *
 * This software is supplied "AS IS" without any warranties.
 * RDA assumes no responsibility or liability for the use of the software,
 * conveys no license or title under any patent, copyright, or mask work
 * right to the product. RDA reserves the right to make changes in the
 * software without notification.  RDA also make no representation or
 * warranty that such application will be suitable for the specified use
 * without further testing or modification.
 */

#ifndef _PB_UTIL_H_
#define _PB_UTIL_H_

#include <pb.h>
#include "pb_decode.h"
#include "pb_encode.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * The pointer variable name of PB struct
 */
#ifndef PB_VAR_NAME
#define PB_VAR_NAME pbs
#endif

/**
 * For plain and necessary variables
 */
#define PB_DEC_ASSIGN(var, field) \
    var = PB_VAR_NAME->field;
#define PB_ENC_ASSIGN(var, field) \
    PB_VAR_NAME->field = var;

/**
 * For plain and optional variables
 */
#define PB_OPT_DEC_ASSIGN(var, field) \
    if (PB_VAR_NAME->has_##field)     \
        var = PB_VAR_NAME->field;
#define PB_OPT_ENC_ASSIGN(var, field) \
    PB_VAR_NAME->has_##field = true;  \
    PB_VAR_NAME->field = var;

/**
 * For decode/encode with provided callback, usually for sub-message.
 */
#define PB_DEC_CB(field, cb, param)       \
    PB_VAR_NAME->field.funcs.decode = cb; \
    PB_VAR_NAME->field.arg = param;
#define PB_ENC_CB(field, cb, param)       \
    PB_VAR_NAME->field.funcs.encode = cb; \
    PB_VAR_NAME->field.arg = param;

/**
 * For decode/encode string, with provided size.
 */
#define PB_DEC_VARSTRING(var, field, size)                              \
    pbStringDecodeParam_t field##__LINE__ = {.data = var, .cnt = size}; \
    PB_VAR_NAME->field.funcs.decode = pbDecStringCallback;              \
    PB_VAR_NAME->field.arg = &field##__LINE__;
#define PB_ENC_VARSTRING(var, field, size)                    \
    pbStringEncodeParam_t field = {.data = var, .cnt = size}; \
    PB_VAR_NAME->field.funcs.encode = pbEncStringCallback;    \
    PB_VAR_NAME->field.arg = &field;

/**
 * For decode/encode string, size if from sizeof(var).
 */
#define PB_DEC_STRING(var, field)                               \
    pbStringDecodeParam_t field##__LINE__ = {var, sizeof(var)}; \
    PB_VAR_NAME->field.funcs.decode = pbDecStringCallback;      \
    PB_VAR_NAME->field.arg = &field##__LINE__;
#define PB_ENC_STRING(var, field)                               \
    pbStringEncodeParam_t field##__LINE__ = {var, sizeof(var)}; \
    PB_VAR_NAME->field.funcs.encode = pbEncStringCallback;      \
    PB_VAR_NAME->field.arg = &field##__LINE__;

/**
 * For decode/encode array.
 */
#define PB_DEC_ARRAY(var, field, fdec)                    \
    pbArrayDecodeParam_t field##__LINE__ = {              \
        .data = var,                                      \
        .cnt = sizeof(var) / sizeof(var[0]),              \
        .idx = 0,                                         \
        .decode = fdec};                                  \
    PB_VAR_NAME->field.funcs.decode = pbDecArrayCallback; \
    PB_VAR_NAME->field.arg = &field##__LINE__;
#define PB_ENC_ARRAY(var, field, fenc)                    \
    pbArrayEncodeParam_t field##__LINE__ = {              \
        .data = var,                                      \
        .cnt = sizeof(var) / sizeof(var[0]),              \
        .encode = fenc};                                  \
    PB_VAR_NAME->field.funcs.encode = pbEncArrayCallback; \
    PB_VAR_NAME->field.arg = &field##__LINE__;

/**
 * For decode/encode 2-D array.
 */
#define PB_DEC_ARRAY2D(var, field, fdec)                  \
    pbArrayDecodeParam_t field##__LINE__ = {              \
        .data = var,                                      \
        .cnt = sizeof(var) / sizeof(var[0][0]),           \
        .idx = 0,                                         \
        .decode = fdec};                                  \
    PB_VAR_NAME->field.funcs.decode = pbDecArrayCallback; \
    PB_VAR_NAME->field.arg = &field##__LINE__;
#define PB_ENC_ARRAY2D(var, field, fenc)                  \
    pbArrayEncodeParam_t field##__LINE__ = {              \
        .data = var,                                      \
        .cnt = sizeof(var) / sizeof(var[0][0]),           \
        .encode = fenc};                                  \
    PB_VAR_NAME->field.funcs.encode = pbEncArrayCallback; \
    PB_VAR_NAME->field.arg = &field##__LINE__;

typedef struct pbArrayDecodeParam
{
    void *data;   // pointer to the address of first submsg
    unsigned cnt; // max submsg count, for check
    unsigned idx; // currrent submsg index
    bool (*decode)(pb_istream_t *stream, struct pbArrayDecodeParam *param);
} pbArrayDecodeParam_t;

typedef struct pbArrayEncodeParam
{
    const void *data; // pointer to the address of first submsg
    unsigned cnt;     // max submsg count, for loop
    bool (*encode)(pb_ostream_t *stream, const struct pbArrayEncodeParam *param, unsigned idx);
} pbArrayEncodeParam_t;

bool pbDecArrayCallback(pb_istream_t *stream, const pb_field_t *field, void **arg);
bool pbEncArrayCallback(pb_ostream_t *stream, const pb_field_t *field, void *const *arg);

typedef struct
{
    void *data;
    unsigned cnt;
} pbStringDecodeParam_t;

typedef struct
{
    const void *data;
    unsigned cnt;
} pbStringEncodeParam_t;

bool pbDecStringCallback(pb_istream_t *stream, const pb_field_t *field, void **arg);
bool pbEncStringCallback(pb_ostream_t *stream, const pb_field_t *field, void *const *arg);

/**
 * \brief encode PB fields to stream buffer
 *
 * When \p buf is NULL, this can be used to get the encoded stream size.
 *
 * \param fields    PB fields
 * \param pbs       PB struct
 * \param buf       buffer to be encoded to
 * \param size      buffer size
 * \return
 *      - encoded stream size
 *      - -1 on error
 *          - encode error
 *          - \size is smaller than needed and \p buf is not NULL
 */
int pbEncodeToMem(const pb_field_t *fields, void *pbs, void *buf, size_t size);

#ifdef __cplusplus
}
#endif
#endif
