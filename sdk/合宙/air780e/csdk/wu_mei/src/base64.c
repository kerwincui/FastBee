/*
 *  RFC 1521 base64 encoding/decoding
 *
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
#include <stdint.h>
#include "base64.h"
#include "stdio.h"

static const uint8_t base64_enc_map[64] =
{
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd',
    'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
    'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
    'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7',
    '8', '9', '+', '/'
};

static const uint8_t base64_dec_map[128] =
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


/*
 * Constant flow conditional assignment to unsigned char
 */
static void mbedtls_base64_cond_assign_uchar( uint8_t * dest, const uint8_t * const src, uint8_t condition )
{
    /* Generate bitmask from condition, mask will either be 0xFF or 0 */
    uint8_t mask = ( condition | -condition );

    mask >>= 7;
    mask = -mask;

    *dest = ( ( *src ) & mask ) | ( ( *dest ) & ~mask );
}

/*
 * Constant flow conditional assignment to uint_32
 */
static void mbedtls_base64_cond_assign_uint32( uint32_t * dest, const uint32_t src, uint32_t condition )
{
    /* Generate bitmask from condition, mask will either be 0xFFFFFFFF or 0 */
    uint32_t mask = ( condition | -condition );

    mask >>= 31;
    mask = -mask;

    *dest = ( src & mask ) | ( ( *dest ) & ~mask );
}

/*
 * Constant flow check for equality
 */
static uint8_t mbedtls_base64_eq( uint32_t in_a, uint32_t in_b )
{
    uint32_t difference = in_a ^ in_b;

    difference |= -difference;

    /* cope with the varying size of int per platform */
    difference >>= ( sizeof( difference ) * 8 - 1 );

    return (uint8_t) ( 1 ^ difference );
}

/*
 * Constant flow lookup into table.
 */
static uint8_t mbedtls_base64_table_lookup( const uint8_t * const table, const int32_t table_size, const int32_t table_index )
{
    int32_t i = 0;
    uint8_t result = 0;

    for( i = 0; i < table_size; ++i )
    {
        mbedtls_base64_cond_assign_uchar( &result, &table[i], mbedtls_base64_eq( i, table_index ) );
    }

    return result;
}

/*
 * Encode a buffer into base64 format
 */
int32_t iBase64Encode(const uint8_t *pcInputData, int32_t iInputLength, uint8_t *pucOutputData)
{
    int32_t i = 0, n = 0, iOutputLength = 0, C1 = 0, C2 = 0, C3 = 0;
    uint8_t *p = pucOutputData;

    if((pucOutputData == NULL) || (pcInputData == NULL) || (iInputLength == 0))
    {
        return -1;
    }

    n = ( iInputLength / 3 ) * 3;

    for( i = 0; i < n; i += 3 )
    {
        C1 = *pcInputData++;
        C2 = *pcInputData++;
        C3 = *pcInputData++;

        *p++ = mbedtls_base64_table_lookup( base64_enc_map, sizeof( base64_enc_map ), ( ( C1 >> 2 ) & 0x3F ) );

        *p++ = mbedtls_base64_table_lookup( base64_enc_map, sizeof( base64_enc_map ), ( ( ( ( C1 &  3 ) << 4 ) + ( C2 >> 4 ) ) & 0x3F ) );

        *p++ = mbedtls_base64_table_lookup( base64_enc_map, sizeof( base64_enc_map ), ( ( ( ( C2 & 15 ) << 2 ) + ( C3 >> 6 ) ) & 0x3F ) );

        *p++ = mbedtls_base64_table_lookup( base64_enc_map, sizeof( base64_enc_map ), ( C3 & 0x3F ) );
    }

    if( i < iInputLength )
    {
        C1 = *pcInputData++;
        C2 = ( ( i + 1 ) < iInputLength ) ? *pcInputData++ : 0;

        *p++ = mbedtls_base64_table_lookup( base64_enc_map, sizeof( base64_enc_map ), ( ( C1 >> 2 ) & 0x3F ) );

        *p++ = mbedtls_base64_table_lookup( base64_enc_map, sizeof( base64_enc_map ), ( ( ( ( C1 & 3 ) << 4 ) + ( C2 >> 4 ) ) & 0x3F ) );

        if( ( i + 1 ) < iInputLength )
            *p++ = mbedtls_base64_table_lookup( base64_enc_map, sizeof( base64_enc_map ), ( ( ( C2 & 15 ) << 2 ) & 0x3F ) );
        else
            *p++ = '=';

        *p++ = '=';
    }

    iOutputLength = p - pucOutputData;
    *p = 0;

    return iOutputLength;
}

/*
 * Decode a base64-formatted buffer
 */
int32_t iBase64Decode(const uint8_t *pcInputData, int32_t iInputLength, uint8_t *pucOutputData)
{
    int32_t i = 0, n = 0, iOutputLength = 0;
    uint32_t j = 0, x = 0;
    uint8_t dec_map_lookup = 0, *p = pucOutputData;

    if((pucOutputData == NULL) || (pcInputData == NULL) || (iInputLength == 0))
    {
        return -1;
    }

    for( i = j = 0; i < iInputLength; ++i )
    {
        if( pcInputData[i] == '=' && ++j > 2 )
            return -2;

        dec_map_lookup = mbedtls_base64_table_lookup( base64_dec_map, sizeof( base64_dec_map ), pcInputData[i] );

        if( pcInputData[i] > 127 || dec_map_lookup == 127 )
            return -3;

        if( dec_map_lookup < 64 && j != 0 )
            return -4;
    }

    for( j = 3; i > 0; --i)
    {
        dec_map_lookup = mbedtls_base64_table_lookup( base64_dec_map, sizeof( base64_dec_map ), *pcInputData++ );

        mbedtls_base64_cond_assign_uint32( &j, j - 1, mbedtls_base64_eq( dec_map_lookup, 64 ) );
        x  = ( x << 6 ) | ( dec_map_lookup & 0x3F );

        if( ++n == 4 )
        {
            n = 0;
            if( j > 0 ) *p++ = (uint8_t)( x >> 16 );
            if( j > 1 ) *p++ = (uint8_t)( x >>  8 );
            if( j > 2 ) *p++ = (uint8_t)( x       );
        }
    }

    iOutputLength = p - pucOutputData;

    return iOutputLength;
}
