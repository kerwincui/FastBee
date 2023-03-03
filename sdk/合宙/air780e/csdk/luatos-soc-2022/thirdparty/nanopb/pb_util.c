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

#include "pb_util.h"
#include "pb_decode.h"
#include "pb_encode.h"
#include <stdlib.h>

bool pbDecStringCallback(pb_istream_t *stream, const pb_field_t *field, void **arg)
{
    pbStringDecodeParam_t *param = (pbStringDecodeParam_t *)*arg;

    if (stream->bytes_left > param->cnt)
        return false;
    if (!pb_read(stream, param->data, stream->bytes_left))
        return false;
    return true;
}

bool pbEncStringCallback(pb_ostream_t *stream, const pb_field_t *field, void *const *arg)
{
    const pbStringEncodeParam_t *param = (const pbStringEncodeParam_t *)*arg;

    if (!pb_encode_tag_for_field(stream, field))
        return false;
    return pb_encode_string(stream, param->data, param->cnt);
}

bool pbEncArrayCallback(pb_ostream_t *stream, const pb_field_t *field, void *const *arg)
{
    const pbArrayEncodeParam_t *param = (const pbArrayEncodeParam_t *)*arg;
    for (int idx = 0; idx < param->cnt; idx++)
    {
        if (!pb_encode_tag_for_field(stream, field))
            return false;
        if (!param->encode(stream, param, idx))
            return false;
    }
    return true;
}

bool pbDecArrayCallback(pb_istream_t *stream, const pb_field_t *field, void **arg)
{
    pbArrayDecodeParam_t *param = (pbArrayDecodeParam_t *)*arg;

    if (param->idx >= param->cnt)
        return false;
    if (!param->decode(stream, param))
        return false;
    param->idx++;
    return true;
}

int pbEncodeToMem(const pb_field_t *fields, void *pbs, void *buf, size_t size)
{
    size_t strm_size;
    if (!pb_get_encoded_size(&strm_size, fields, pbs))
        return -1;

    if (buf == NULL)
        return strm_size;

    if (size < strm_size)
        return -1;

    pb_ostream_t ostrm = pb_ostream_from_buffer(buf, strm_size);
    if (!pb_encode(&ostrm, fields, pbs))
        return -1;

    return ostrm.bytes_written;
}
