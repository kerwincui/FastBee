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

#include "common_api.h"
#include "FreeRTOS.h"
#include "task.h"
#include "luat_base.h"

#include "luat_iconv.h"
#include "iconv.h"


luat_iconv_t luat_iconv_open (const char *to_code, const char *from_code)
{
    return iconv_open(to_code, from_code);
}


size_t luat_iconv_convert (luat_iconv_t cd, char ** inbuf, size_t * in_bytes_left, char ** outbuf, size_t * out_bytes_left)
{
    return iconv_convert(cd, inbuf, in_bytes_left, outbuf, out_bytes_left);
}


int luat_iconv_close (luat_iconv_t cd)
{
    return iconv_close(cd);
}