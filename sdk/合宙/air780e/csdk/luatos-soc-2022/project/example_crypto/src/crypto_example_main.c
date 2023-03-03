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
#include "luat_rtos.h"
#include "luat_mem.h"
#include "luat_debug.h"

luat_rtos_task_handle task_handle;

#include "md5.h"
#include "sha1.h"
#include "sha256.h"
#include "base64.h"
#include "des.h"
#include "aes.h"
#include "rsa.h"
#include "luat_crypto.h"

static unsigned char md5_test_buf[8][99] =
	{
		{" "},
		{"123"},
		{"ABC3E333"},
		{"aaaaaa"},
		{"abcasdgasdgf"},
		{"pokhaw;leh;lashdgf;lk1546123"},
		{"zxcbwep;j3827319734lhalsdkv4 asDEFL01DC5A3W231A"},
		{"kc254awZXCDSV142547zcx 35874dasdf3A214354C3BA4SWE84FAWDFASDF0....65DA6SDVGF12MJDASDFasd"}};

static const int md5_test_buflen[8] = {1, 3, 8, 6, 12, 28, 47, 87};

static const unsigned char md5_test_sum[8][16] =
	{
		{0x72, 0x15, 0xee, 0x9c, 0x7d, 0x9d, 0xc2, 0x29, 0xd2, 0x92, 0x1a, 0x40, 0xe8, 0x99, 0xec, 0x5f},
		{0x20, 0x2c, 0xb9, 0x62, 0xac, 0x59, 0x07, 0x5b, 0x96, 0x4b, 0x07, 0x15, 0x2d, 0x23, 0x4b, 0x70},
		{0x99, 0xa6, 0xac, 0x88, 0x0c, 0x73, 0xaa, 0xac, 0x7c, 0xaf, 0x5e, 0xd6, 0x3a, 0x30, 0xdb, 0x3e},
		{0x0b, 0x4e, 0x7a, 0x0e, 0x5f, 0xe8, 0x4a, 0xd3, 0x5f, 0xb5, 0xf9, 0x5b, 0x9c, 0xee, 0xac, 0x79},
		{0x33, 0x57, 0x7e, 0x23, 0x23, 0xf1, 0xc1, 0x12, 0x3e, 0x90, 0xbe, 0xee, 0x7f, 0xdb, 0x43, 0xdf},
		{0x4c, 0xe3, 0xd7, 0x6c, 0xb4, 0xfd, 0xfb, 0xcf, 0xe3, 0x92, 0x1f, 0x76, 0x14, 0x84, 0xd1, 0x5c},
		{0x2d, 0x7f, 0xdb, 0x1e, 0x1f, 0xec, 0xe9, 0xe5, 0x4a, 0xc2, 0x4a, 0x78, 0x92, 0x60, 0x4d, 0x6b},
		{0x9b, 0xdf, 0xc2, 0x7c, 0xfa, 0xa1, 0x59, 0x88, 0x8e, 0xe8, 0xee, 0xf3, 0xf6, 0x24, 0x17, 0xcb}};

void md5_test(void)
{
	unsigned char output[16] = {0};
	//调用封装好的接口
	for (int i = 0; i < 8; i++)
	{
		luat_crypto_md5(md5_test_buf[i], md5_test_buflen[i], output);
		if (memcmp(output, md5_test_sum[i], 16) == 0)
		{
			LUAT_DEBUG_PRINT("md5 test success1 %d", i);
		}
		else
		{
			LUAT_DEBUG_PRINT("md5 test fail1 %d", i);
		}
		memset(output, 0, sizeof(output));
	}

	//调用未封装的接口
	for (int i = 0; i < 8; i++)
	{
		mbedtls_md5_context ctx;
		mbedtls_md5_init(&ctx);
		mbedtls_md5_starts(&ctx);
		mbedtls_md5_update(&ctx, md5_test_buf[i], md5_test_buflen[i]);
		mbedtls_md5_finish(&ctx, output);
		mbedtls_md5_free(&ctx);

		if (memcmp(output, md5_test_sum[i], 16) == 0)
		{
			LUAT_DEBUG_PRINT("md5 test success2 %d", i);
		}
		else
		{
			LUAT_DEBUG_PRINT("md5 test fail2 %d", i);
		}
		memset(output, 0, sizeof(output));
	}
}

static const unsigned char base64_test_decode[88] =
	{
		0x61, 0x69, 0x78, 0x69, 0x61, 0x48, 0x70, 0x34, 0x50, 0x57, 0x4e,
		0x72, 0x62, 0x47, 0x6f, 0x67, 0x4f, 0x32, 0x78, 0x68, 0x63, 0x32,
		0x52, 0x72, 0x5a, 0x69, 0x42, 0x4d, 0x4f, 0x30, 0x46, 0x4c, 0x4c,
		0x43, 0x38, 0x67, 0x62, 0x47, 0x46, 0x73, 0x59, 0x57, 0x78, 0x68,
		0x62, 0x44, 0x45, 0x75, 0x4d, 0x6a, 0x51, 0x7a, 0x4e, 0x54, 0x52,
		0x54, 0x52, 0x45, 0x56, 0x4d, 0x54, 0x6b, 0x74, 0x42, 0x55, 0x30,
		0x51, 0x75, 0x4d, 0x6a, 0x42, 0x68, 0x63, 0x32, 0x52, 0x6d, 0x59,
		0x58, 0x63, 0x7a, 0x4e, 0x47, 0x55, 0x39, 0x50, 0x51, 0x3d, 0x3d};

static const unsigned char base64_test_encode[] = "j,bhzx=cklj ;lasdkf L;AK,/ lalalal1.24354SDELNKASD.20asdfaw34e==";

void base64_test(void)
{
	size_t len;
	unsigned char tmpbuf[128] = {0};
	if (luat_crypto_base64_encode(tmpbuf, sizeof(tmpbuf), &len, base64_test_encode, 64) == 0)
	{
		if (memcmp(tmpbuf, base64_test_decode, 88) == 0)
			LUAT_DEBUG_PRINT("base64 encoding test success");
		else
			LUAT_DEBUG_PRINT("base64 encoding test fail");
	}
	memset(tmpbuf, 0, sizeof(tmpbuf));
	if (luat_crypto_base64_decode(tmpbuf, sizeof(tmpbuf), &len, base64_test_decode, 88) == 0)
	{
		if (memcmp(tmpbuf, base64_test_encode, 64) == 0)
			LUAT_DEBUG_PRINT("base64 decoding test success");
		else
			LUAT_DEBUG_PRINT("base64 decoding test fail");
	}
}

static const unsigned char sha1_test_buf[3][100] = {
	{"abc"},
	{"abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"},
	{"j,bchzx=cklj ;lasdkf L;AK,/ lalalal1.24354SDELNKASD.20asdfaw34eDBZ D2SALCHDAKCDASDEFRT=="}};

static const size_t sha1_test_buflen[3] = {3, 56, 88};

static const unsigned char sha1_test_sum[3][20] =
	{
		{0xA9, 0x99, 0x3E, 0x36, 0x47, 0x06, 0x81, 0x6A, 0xBA, 0x3E,
		 0x25, 0x71, 0x78, 0x50, 0xC2, 0x6C, 0x9C, 0xD0, 0xD8, 0x9D},
		{0x84, 0x98, 0x3E, 0x44, 0x1C, 0x3B, 0xD2, 0x6E, 0xBA, 0xAE,
		 0x4A, 0xA1, 0xF9, 0x51, 0x29, 0xE5, 0xE5, 0x46, 0x70, 0xF1},
		{0x56, 0x0a, 0x8c, 0x99, 0xc3, 0x25, 0x8f, 0x07, 0x14, 0xf1,
		 0xd3, 0x2e, 0x11, 0x2a, 0x6c, 0x9c, 0x98, 0x6c, 0x8d, 0x9b}};
void sha1_test(void)
{
	unsigned char output[20] = {0};
	//调用封装好的接口
	for (int i = 0; i < 3; i++)
	{
		luat_crypto_sha1(sha1_test_buf[i], sha1_test_buflen[i], output);
		if (memcmp(output, sha1_test_sum[i], 20) == 0)
		{
			LUAT_DEBUG_PRINT("sha1 test success1 %d", i);
		}
		else
		{
			LUAT_DEBUG_PRINT("sha1 test fail1 %d", i);
		}
		memset(output, 0, sizeof(output));
	}

	//调用未封装的接口
	for (int i = 0; i < 3; i++)
	{
		mbedtls_sha1_context ctx;
		mbedtls_sha1_init(&ctx);
		mbedtls_sha1_starts(&ctx);
		mbedtls_sha1_update(&ctx, sha1_test_buf[i], sha1_test_buflen[i]);
		mbedtls_sha1_finish(&ctx, output);
		mbedtls_sha1_free(&ctx);
		if (memcmp(output, sha1_test_sum[i], 20) == 0)
		{
			LUAT_DEBUG_PRINT("sha1 test success2 %d", i);
		}
		else
		{
			LUAT_DEBUG_PRINT("sha1 test fail2 %d", i);
		}
		memset(output, 0, sizeof(output));
	}
}

static const unsigned char sha256_test_buf[2][57] = {
	{"abc"},
	{"abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"},
};

static const size_t sha256_test_buflen[2] = {3, 56};

static const unsigned char sha256_224_test_sum[6][32] =
	{
		/*
		 * SHA-224 test vectors
		 */
		{0x23, 0x09, 0x7D, 0x22, 0x34, 0x05, 0xD8, 0x22,
		 0x86, 0x42, 0xA4, 0x77, 0xBD, 0xA2, 0x55, 0xB3,
		 0x2A, 0xAD, 0xBC, 0xE4, 0xBD, 0xA0, 0xB3, 0xF7,
		 0xE3, 0x6C, 0x9D, 0xA7},
		{0x75, 0x38, 0x8B, 0x16, 0x51, 0x27, 0x76, 0xCC,
		 0x5D, 0xBA, 0x5D, 0xA1, 0xFD, 0x89, 0x01, 0x50,
		 0xB0, 0xC6, 0x45, 0x5C, 0xB4, 0xF5, 0x8B, 0x19,
		 0x52, 0x52, 0x25, 0x25},

		/*
		 * SHA-256 test vectors
		 */
		{0xBA, 0x78, 0x16, 0xBF, 0x8F, 0x01, 0xCF, 0xEA,
		 0x41, 0x41, 0x40, 0xDE, 0x5D, 0xAE, 0x22, 0x23,
		 0xB0, 0x03, 0x61, 0xA3, 0x96, 0x17, 0x7A, 0x9C,
		 0xB4, 0x10, 0xFF, 0x61, 0xF2, 0x00, 0x15, 0xAD},
		{0x24, 0x8D, 0x6A, 0x61, 0xD2, 0x06, 0x38, 0xB8,
		 0xE5, 0xC0, 0x26, 0x93, 0x0C, 0x3E, 0x60, 0x39,
		 0xA3, 0x3C, 0xE4, 0x59, 0x64, 0xFF, 0x21, 0x67,
		 0xF6, 0xEC, 0xED, 0xD4, 0x19, 0xDB, 0x06, 0xC1},
};

static const unsigned char sha224_1000a[32] = {0x20, 0x79, 0x46, 0x55, 0x98, 0x0C, 0x91, 0xD8,
											   0xBB, 0xB4, 0xC1, 0xEA, 0x97, 0x61, 0x8A, 0x4B,
											   0xF0, 0x3F, 0x42, 0x58, 0x19, 0x48, 0xB2, 0xEE,
											   0x4E, 0xE7, 0xAD, 0x67};

static const unsigned char sha256_1000a[32] = {0xCD, 0xC7, 0x6E, 0x5C, 0x99, 0x14, 0xFB, 0x92,
											   0x81, 0xA1, 0xC7, 0xE2, 0x84, 0xD7, 0x3E, 0x67,
											   0xF1, 0x80, 0x9A, 0x48, 0xA4, 0x97, 0x20, 0x0E,
											   0x04, 0x6D, 0x39, 0xCC, 0xC7, 0x11, 0x2C, 0xD0};

void sha256_224_test(void)
{
	unsigned char output[32] = {0};
	for (int i = 0; i < 2; i++)
	{
		//sha224
		luat_crypto_sha256(sha256_test_buf[i], sha256_test_buflen[i], output, 1);
		if (memcmp(output, sha256_224_test_sum[i], 32) == 0)
			LUAT_DEBUG_PRINT("sha224 test success1 %d", i);
		else
			LUAT_DEBUG_PRINT("sha224 test fail1 %d", i);

		memset(output, 0, 32);

		//sha256
		luat_crypto_sha256(sha256_test_buf[i], sha256_test_buflen[i], output, 0);
		if (memcmp(output, sha256_224_test_sum[i + 2], 32) == 0)
			LUAT_DEBUG_PRINT("sha256 test success1 %d", i);
		else
			LUAT_DEBUG_PRINT("sha256 test fail1 %d", i);
		memset(output, 0, 32);
	}

	for (int i = 0; i < 2; i++)
	{
		mbedtls_sha256_context ctx;
		mbedtls_sha256_init(&ctx);
		mbedtls_sha256_starts(&ctx, 1);
		mbedtls_sha256_update(&ctx, sha256_test_buf[i], sha256_test_buflen[i]);
		mbedtls_sha256_finish(&ctx, output);
		mbedtls_sha256_free(&ctx);
		if (memcmp(output, sha256_224_test_sum[i], 32) == 0)
			LUAT_DEBUG_PRINT("sha224 test success2 %d", i);
		else
			LUAT_DEBUG_PRINT("sha224 test fail2 %d", i);
		memset(output, 0, 32);

		mbedtls_sha256_init(&ctx);
		mbedtls_sha256_starts(&ctx, 0);
		mbedtls_sha256_update(&ctx, sha256_test_buf[i], sha256_test_buflen[i]);
		mbedtls_sha256_finish(&ctx, output);
		mbedtls_sha256_free(&ctx);
		if (memcmp(output, sha256_224_test_sum[i + 2], 32) == 0)
			LUAT_DEBUG_PRINT("sha256 test success2 %d", i);
		else
			LUAT_DEBUG_PRINT("sha256 test fail2 %d", i);
		memset(output, 0, 32);
	}

	unsigned char *testBuf = NULL;
	testBuf = (unsigned char *)malloc(1024);
	if (testBuf == NULL)
	{
		LUAT_DEBUG_PRINT("sha256 test malloc fail");
		return;
	}

	mbedtls_sha256_context ctx;

	mbedtls_sha256_init(&ctx);
	mbedtls_sha256_starts(&ctx, 1);
	memset(testBuf, 'a', 1000);
	for (int i = 0; i < 1000; i++)
		mbedtls_sha256_update(&ctx, testBuf, 1000);
	mbedtls_sha256_finish(&ctx, output);
	mbedtls_sha256_free(&ctx);
	if (memcmp(output, sha224_1000a, 32) == 0)
		LUAT_DEBUG_PRINT("sha224 test success3");
	else
		LUAT_DEBUG_PRINT("sha224 test fail3");

	mbedtls_sha256_init(&ctx);
	mbedtls_sha256_starts(&ctx, 0);
	memset(testBuf, 'a', 1000);
	for (int i = 0; i < 1000; i++)
		mbedtls_sha256_update(&ctx, testBuf, 1000);
	mbedtls_sha256_finish(&ctx, output);
	mbedtls_sha256_free(&ctx);
	if (memcmp(output, sha256_1000a, 32) == 0)
		LUAT_DEBUG_PRINT("sha256 test success3");
	else
		LUAT_DEBUG_PRINT("sha256 test fail3");

	if (testBuf != NULL)
	{
		free(testBuf);
	}
}
#define KEY_LEN 128

#define RSA_N   "9292758453063D803DD603D5E777D788" \
                "8ED1D5BF35786190FA2F23EBC0848AEA" \
                "DDA92CA6C3D80B32C4D109BE0F36D6AE" \
                "7130B9CED7ACDF54CFC7555AC14EEBAB" \
                "93A89813FBF3C4F8066D2D800F7C38A8" \
                "1AE31942917403FF4946B0A83D3D3E05" \
                "EE57C6F5F5606FB5D4BC6CD34EE0801A" \
                "5E94BB77B07507233A0BC7BAC8F90F79"

#define RSA_E   "10001"

#define RSA_D   "24BF6185468786FDD303083D25E64EFC" \
                "66CA472BC44D253102F8B4A9D3BFA750" \
                "91386C0077937FE33FA3252D28855837" \
                "AE1B484A8A9A45F7EE8C0C634F99E8CD" \
                "DF79C5CE07EE72C7F123142198164234" \
                "CABB724CF78B8173B9F880FC86322407" \
                "AF1FEDFDDE2BEB674CA15F3E81A1521E" \
                "071513A1E85B5DFA031F21ECAE91A34D"

#define RSA_P   "C36D0EB7FCD285223CFB5AABA5BDA3D8" \
                "2C01CAD19EA484A87EA4377637E75500" \
                "FCB2005C5C7DD6EC4AC023CDA285D796" \
                "C3D9E75E1EFC42488BB4F1D13AC30A57"

#define RSA_Q   "C000DF51A7C77AE8D7C7370C1FF55B69" \
                "E211C2B9E5DB1ED0BF61D0D9899620F4" \
                "910E4168387E3C30AA1E00C339A79508" \
                "8452DD96A9A5EA5D9DCA68DA636032AF"

#define PT_LEN  24
#define RSA_PT  "\xAA\xBB\xCC\x03\x02\x01\x00\xFF\xFF\xFF\xFF\xFF" \
                "\x11\x22\x33\x0A\x0B\x0C\xCC\xDD\xDD\xDD\xDD\xDD"
#include "bignum.h"
static int myrand( void *rng_state, unsigned char *output, size_t len )
{
#if !defined(__OpenBSD__) && !defined(__NetBSD__)
    size_t i;

    if( rng_state != NULL )
        rng_state  = NULL;

    for( i = 0; i < len; ++i )
        output[i] = rand();
#else
    if( rng_state != NULL )
        rng_state = NULL;

    arc4random_buf( output, len );
#endif /* !OpenBSD && !NetBSD */

    return( 0 );
}
static int mbedtls_rsa_test( int verbose )
{
    int ret = 0;
#if defined(MBEDTLS_PKCS1_V15)
    size_t len;
    mbedtls_rsa_context rsa;
    unsigned char rsa_plaintext[PT_LEN];
    unsigned char rsa_decrypted[PT_LEN];
    unsigned char rsa_ciphertext[KEY_LEN];
#if defined(MBEDTLS_SHA1_C)
    unsigned char sha1sum[20];
#endif

    mbedtls_mpi K;

    mbedtls_mpi_init( &K );
    mbedtls_rsa_init( &rsa, MBEDTLS_RSA_PKCS_V15, 0 );

    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &K, 16, RSA_N  ) );
    MBEDTLS_MPI_CHK( mbedtls_rsa_import( &rsa, &K, NULL, NULL, NULL, NULL ) );
    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &K, 16, RSA_P  ) );
    MBEDTLS_MPI_CHK( mbedtls_rsa_import( &rsa, NULL, &K, NULL, NULL, NULL ) );
    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &K, 16, RSA_Q  ) );
    MBEDTLS_MPI_CHK( mbedtls_rsa_import( &rsa, NULL, NULL, &K, NULL, NULL ) );
    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &K, 16, RSA_D  ) );
    MBEDTLS_MPI_CHK( mbedtls_rsa_import( &rsa, NULL, NULL, NULL, &K, NULL ) );
    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &K, 16, RSA_E  ) );
    MBEDTLS_MPI_CHK( mbedtls_rsa_import( &rsa, NULL, NULL, NULL, NULL, &K ) );

    MBEDTLS_MPI_CHK( mbedtls_rsa_complete( &rsa ) );

    if( verbose != 0 )
        LUAT_DEBUG_PRINT( "  RSA key validation: " );

    if( mbedtls_rsa_check_pubkey(  &rsa ) != 0 ||
        mbedtls_rsa_check_privkey( &rsa ) != 0 )
    {
        if( verbose != 0 )
            LUAT_DEBUG_PRINT( "failed\n" );

        ret = 1;
        goto cleanup;
    }

    if( verbose != 0 )
        LUAT_DEBUG_PRINT( "passed\n  PKCS#1 encryption : " );

    memcpy( rsa_plaintext, RSA_PT, PT_LEN );

    if( mbedtls_rsa_pkcs1_encrypt( &rsa, myrand, NULL, MBEDTLS_RSA_PUBLIC,
                                   PT_LEN, rsa_plaintext,
                                   rsa_ciphertext ) != 0 )
    {
        if( verbose != 0 )
            LUAT_DEBUG_PRINT( "failed\n" );

        ret = 1;
        goto cleanup;
    }

    if( verbose != 0 )
        LUAT_DEBUG_PRINT( "passed\n  PKCS#1 decryption : " );

    if( mbedtls_rsa_pkcs1_decrypt( &rsa, myrand, NULL, MBEDTLS_RSA_PRIVATE,
                                   &len, rsa_ciphertext, rsa_decrypted,
                                   sizeof(rsa_decrypted) ) != 0 )
    {
        if( verbose != 0 )
            LUAT_DEBUG_PRINT( "failed\n" );

        ret = 1;
        goto cleanup;
    }

    if( memcmp( rsa_decrypted, rsa_plaintext, len ) != 0 )
    {
        if( verbose != 0 )
            LUAT_DEBUG_PRINT( "failed\n" );

        ret = 1;
        goto cleanup;
    }

    if( verbose != 0 )
        LUAT_DEBUG_PRINT( "passed\n" );

#if defined(MBEDTLS_SHA1_C)
    if( verbose != 0 )
        LUAT_DEBUG_PRINT( "  PKCS#1 data sign  : " );

    if( mbedtls_sha1_ret( rsa_plaintext, PT_LEN, sha1sum ) != 0 )
    {
        if( verbose != 0 )
            LUAT_DEBUG_PRINT( "failed\n" );

        return( 1 );
    }

    if( mbedtls_rsa_pkcs1_sign( &rsa, myrand, NULL,
                                MBEDTLS_RSA_PRIVATE, MBEDTLS_MD_SHA1, 0,
                                sha1sum, rsa_ciphertext ) != 0 )
    {
        if( verbose != 0 )
            LUAT_DEBUG_PRINT( "failed\n" );

        ret = 1;
        goto cleanup;
    }

    if( verbose != 0 )
        LUAT_DEBUG_PRINT( "passed\n  PKCS#1 sig. verify: " );

    if( mbedtls_rsa_pkcs1_verify( &rsa, NULL, NULL,
                                  MBEDTLS_RSA_PUBLIC, MBEDTLS_MD_SHA1, 0,
                                  sha1sum, rsa_ciphertext ) != 0 )
    {
        if( verbose != 0 )
            LUAT_DEBUG_PRINT( "failed\n" );

        ret = 1;
        goto cleanup;
    }

    if( verbose != 0 )
        LUAT_DEBUG_PRINT( "passed\n" );
#endif /* MBEDTLS_SHA1_C */

    if( verbose != 0 )
        LUAT_DEBUG_PRINT( "\n" );

cleanup:
    mbedtls_mpi_free( &K );
    mbedtls_rsa_free( &rsa );
#else /* MBEDTLS_PKCS1_V15 */
    ((void) verbose);
#endif /* MBEDTLS_PKCS1_V15 */
    return( ret );
}


// /*
//  * AES test vectors from:
//  *
//  * http://csrc.nist.gov/archive/aes/rijndael/rijndael-vals.zip
//  */
// static const unsigned char aes_test_ecb_dec[3][16] =
// {
//     { 0x44, 0x41, 0x6A, 0xC2, 0xD1, 0xF5, 0x3C, 0x58,
//       0x33, 0x03, 0x91, 0x7E, 0x6B, 0xE9, 0xEB, 0xE0 },
//     { 0x48, 0xE3, 0x1E, 0x9E, 0x25, 0x67, 0x18, 0xF2,
//       0x92, 0x29, 0x31, 0x9C, 0x19, 0xF1, 0x5B, 0xA4 },
//     { 0x05, 0x8C, 0xCF, 0xFD, 0xBB, 0xCB, 0x38, 0x2D,
//       0x1F, 0x6F, 0x56, 0x58, 0x5D, 0x8A, 0x4A, 0xDE }
// };

// static const unsigned char aes_test_ecb_enc[3][16] =
// {
//     { 0xC3, 0x4C, 0x05, 0x2C, 0xC0, 0xDA, 0x8D, 0x73,
//       0x45, 0x1A, 0xFE, 0x5F, 0x03, 0xBE, 0x29, 0x7F },
//     { 0xF3, 0xF6, 0x75, 0x2A, 0xE8, 0xD7, 0x83, 0x11,
//       0x38, 0xF0, 0x41, 0x56, 0x06, 0x31, 0xB1, 0x14 },
//     { 0x8B, 0x79, 0xEE, 0xCC, 0x93, 0xA0, 0xEE, 0x5D,
//       0xFF, 0x30, 0xB4, 0xEA, 0x21, 0x63, 0x6D, 0xA4 }
// };

// #if defined(MBEDTLS_CIPHER_MODE_CBC)
// static const unsigned char aes_test_cbc_dec[3][16] =
// {
//     { 0xFA, 0xCA, 0x37, 0xE0, 0xB0, 0xC8, 0x53, 0x73,
//       0xDF, 0x70, 0x6E, 0x73, 0xF7, 0xC9, 0xAF, 0x86 },
//     { 0x5D, 0xF6, 0x78, 0xDD, 0x17, 0xBA, 0x4E, 0x75,
//       0xB6, 0x17, 0x68, 0xC6, 0xAD, 0xEF, 0x7C, 0x7B },
//     { 0x48, 0x04, 0xE1, 0x81, 0x8F, 0xE6, 0x29, 0x75,
//       0x19, 0xA3, 0xE8, 0x8C, 0x57, 0x31, 0x04, 0x13 }
// };

// static const unsigned char aes_test_cbc_enc[3][16] =
// {
//     { 0x8A, 0x05, 0xFC, 0x5E, 0x09, 0x5A, 0xF4, 0x84,
//       0x8A, 0x08, 0xD3, 0x28, 0xD3, 0x68, 0x8E, 0x3D },
//     { 0x7B, 0xD9, 0x66, 0xD5, 0x3A, 0xD8, 0xC1, 0xBB,
//       0x85, 0xD2, 0xAD, 0xFA, 0xE8, 0x7B, 0xB1, 0x04 },
//     { 0xFE, 0x3C, 0x53, 0x65, 0x3E, 0x2F, 0x45, 0xB5,
//       0x6F, 0xCD, 0x88, 0xB2, 0xCC, 0x89, 0x8F, 0xF0 }
// };
// #endif /* MBEDTLS_CIPHER_MODE_CBC */

// #if defined(MBEDTLS_CIPHER_MODE_CFB)
// /*
//  * AES-CFB128 test vectors from:
//  *
//  * http://csrc.nist.gov/publications/nistpubs/800-38a/sp800-38a.pdf
//  */
// static const unsigned char aes_test_cfb128_key[3][32] =
// {
//     { 0x2B, 0x7E, 0x15, 0x16, 0x28, 0xAE, 0xD2, 0xA6,
//       0xAB, 0xF7, 0x15, 0x88, 0x09, 0xCF, 0x4F, 0x3C },
//     { 0x8E, 0x73, 0xB0, 0xF7, 0xDA, 0x0E, 0x64, 0x52,
//       0xC8, 0x10, 0xF3, 0x2B, 0x80, 0x90, 0x79, 0xE5,
//       0x62, 0xF8, 0xEA, 0xD2, 0x52, 0x2C, 0x6B, 0x7B },
//     { 0x60, 0x3D, 0xEB, 0x10, 0x15, 0xCA, 0x71, 0xBE,
//       0x2B, 0x73, 0xAE, 0xF0, 0x85, 0x7D, 0x77, 0x81,
//       0x1F, 0x35, 0x2C, 0x07, 0x3B, 0x61, 0x08, 0xD7,
//       0x2D, 0x98, 0x10, 0xA3, 0x09, 0x14, 0xDF, 0xF4 }
// };

// static const unsigned char aes_test_cfb128_iv[16] =
// {
//     0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
//     0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F
// };

// static const unsigned char aes_test_cfb128_pt[64] =
// {
//     0x6B, 0xC1, 0xBE, 0xE2, 0x2E, 0x40, 0x9F, 0x96,
//     0xE9, 0x3D, 0x7E, 0x11, 0x73, 0x93, 0x17, 0x2A,
//     0xAE, 0x2D, 0x8A, 0x57, 0x1E, 0x03, 0xAC, 0x9C,
//     0x9E, 0xB7, 0x6F, 0xAC, 0x45, 0xAF, 0x8E, 0x51,
//     0x30, 0xC8, 0x1C, 0x46, 0xA3, 0x5C, 0xE4, 0x11,
//     0xE5, 0xFB, 0xC1, 0x19, 0x1A, 0x0A, 0x52, 0xEF,
//     0xF6, 0x9F, 0x24, 0x45, 0xDF, 0x4F, 0x9B, 0x17,
//     0xAD, 0x2B, 0x41, 0x7B, 0xE6, 0x6C, 0x37, 0x10
// };

// static const unsigned char aes_test_cfb128_ct[3][64] =
// {
//     { 0x3B, 0x3F, 0xD9, 0x2E, 0xB7, 0x2D, 0xAD, 0x20,
//       0x33, 0x34, 0x49, 0xF8, 0xE8, 0x3C, 0xFB, 0x4A,
//       0xC8, 0xA6, 0x45, 0x37, 0xA0, 0xB3, 0xA9, 0x3F,
//       0xCD, 0xE3, 0xCD, 0xAD, 0x9F, 0x1C, 0xE5, 0x8B,
//       0x26, 0x75, 0x1F, 0x67, 0xA3, 0xCB, 0xB1, 0x40,
//       0xB1, 0x80, 0x8C, 0xF1, 0x87, 0xA4, 0xF4, 0xDF,
//       0xC0, 0x4B, 0x05, 0x35, 0x7C, 0x5D, 0x1C, 0x0E,
//       0xEA, 0xC4, 0xC6, 0x6F, 0x9F, 0xF7, 0xF2, 0xE6 },
//     { 0xCD, 0xC8, 0x0D, 0x6F, 0xDD, 0xF1, 0x8C, 0xAB,
//       0x34, 0xC2, 0x59, 0x09, 0xC9, 0x9A, 0x41, 0x74,
//       0x67, 0xCE, 0x7F, 0x7F, 0x81, 0x17, 0x36, 0x21,
//       0x96, 0x1A, 0x2B, 0x70, 0x17, 0x1D, 0x3D, 0x7A,
//       0x2E, 0x1E, 0x8A, 0x1D, 0xD5, 0x9B, 0x88, 0xB1,
//       0xC8, 0xE6, 0x0F, 0xED, 0x1E, 0xFA, 0xC4, 0xC9,
//       0xC0, 0x5F, 0x9F, 0x9C, 0xA9, 0x83, 0x4F, 0xA0,
//       0x42, 0xAE, 0x8F, 0xBA, 0x58, 0x4B, 0x09, 0xFF },
//     { 0xDC, 0x7E, 0x84, 0xBF, 0xDA, 0x79, 0x16, 0x4B,
//       0x7E, 0xCD, 0x84, 0x86, 0x98, 0x5D, 0x38, 0x60,
//       0x39, 0xFF, 0xED, 0x14, 0x3B, 0x28, 0xB1, 0xC8,
//       0x32, 0x11, 0x3C, 0x63, 0x31, 0xE5, 0x40, 0x7B,
//       0xDF, 0x10, 0x13, 0x24, 0x15, 0xE5, 0x4B, 0x92,
//       0xA1, 0x3E, 0xD0, 0xA8, 0x26, 0x7A, 0xE2, 0xF9,
//       0x75, 0xA3, 0x85, 0x74, 0x1A, 0xB9, 0xCE, 0xF8,
//       0x20, 0x31, 0x62, 0x3D, 0x55, 0xB1, 0xE4, 0x71 }
// };
// #endif /* MBEDTLS_CIPHER_MODE_CFB */

// #if defined(MBEDTLS_CIPHER_MODE_OFB)
// /*
//  * AES-OFB test vectors from:
//  *
//  * https://csrc.nist.gov/publications/detail/sp/800-38a/final
//  */
// static const unsigned char aes_test_ofb_key[3][32] =
// {
//     { 0x2B, 0x7E, 0x15, 0x16, 0x28, 0xAE, 0xD2, 0xA6,
//       0xAB, 0xF7, 0x15, 0x88, 0x09, 0xCF, 0x4F, 0x3C },
//     { 0x8E, 0x73, 0xB0, 0xF7, 0xDA, 0x0E, 0x64, 0x52,
//       0xC8, 0x10, 0xF3, 0x2B, 0x80, 0x90, 0x79, 0xE5,
//       0x62, 0xF8, 0xEA, 0xD2, 0x52, 0x2C, 0x6B, 0x7B },
//     { 0x60, 0x3D, 0xEB, 0x10, 0x15, 0xCA, 0x71, 0xBE,
//       0x2B, 0x73, 0xAE, 0xF0, 0x85, 0x7D, 0x77, 0x81,
//       0x1F, 0x35, 0x2C, 0x07, 0x3B, 0x61, 0x08, 0xD7,
//       0x2D, 0x98, 0x10, 0xA3, 0x09, 0x14, 0xDF, 0xF4 }
// };

// static const unsigned char aes_test_ofb_iv[16] =
// {
//     0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
//     0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F
// };

// static const unsigned char aes_test_ofb_pt[64] =
// {
//     0x6B, 0xC1, 0xBE, 0xE2, 0x2E, 0x40, 0x9F, 0x96,
//     0xE9, 0x3D, 0x7E, 0x11, 0x73, 0x93, 0x17, 0x2A,
//     0xAE, 0x2D, 0x8A, 0x57, 0x1E, 0x03, 0xAC, 0x9C,
//     0x9E, 0xB7, 0x6F, 0xAC, 0x45, 0xAF, 0x8E, 0x51,
//     0x30, 0xC8, 0x1C, 0x46, 0xA3, 0x5C, 0xE4, 0x11,
//     0xE5, 0xFB, 0xC1, 0x19, 0x1A, 0x0A, 0x52, 0xEF,
//     0xF6, 0x9F, 0x24, 0x45, 0xDF, 0x4F, 0x9B, 0x17,
//     0xAD, 0x2B, 0x41, 0x7B, 0xE6, 0x6C, 0x37, 0x10
// };

// static const unsigned char aes_test_ofb_ct[3][64] =
// {
//     { 0x3B, 0x3F, 0xD9, 0x2E, 0xB7, 0x2D, 0xAD, 0x20,
//       0x33, 0x34, 0x49, 0xF8, 0xE8, 0x3C, 0xFB, 0x4A,
//       0x77, 0x89, 0x50, 0x8d, 0x16, 0x91, 0x8f, 0x03,
//       0xf5, 0x3c, 0x52, 0xda, 0xc5, 0x4e, 0xd8, 0x25,
//       0x97, 0x40, 0x05, 0x1e, 0x9c, 0x5f, 0xec, 0xf6,
//       0x43, 0x44, 0xf7, 0xa8, 0x22, 0x60, 0xed, 0xcc,
//       0x30, 0x4c, 0x65, 0x28, 0xf6, 0x59, 0xc7, 0x78,
//       0x66, 0xa5, 0x10, 0xd9, 0xc1, 0xd6, 0xae, 0x5e },
//     { 0xCD, 0xC8, 0x0D, 0x6F, 0xDD, 0xF1, 0x8C, 0xAB,
//       0x34, 0xC2, 0x59, 0x09, 0xC9, 0x9A, 0x41, 0x74,
//       0xfc, 0xc2, 0x8b, 0x8d, 0x4c, 0x63, 0x83, 0x7c,
//       0x09, 0xe8, 0x17, 0x00, 0xc1, 0x10, 0x04, 0x01,
//       0x8d, 0x9a, 0x9a, 0xea, 0xc0, 0xf6, 0x59, 0x6f,
//       0x55, 0x9c, 0x6d, 0x4d, 0xaf, 0x59, 0xa5, 0xf2,
//       0x6d, 0x9f, 0x20, 0x08, 0x57, 0xca, 0x6c, 0x3e,
//       0x9c, 0xac, 0x52, 0x4b, 0xd9, 0xac, 0xc9, 0x2a },
//     { 0xDC, 0x7E, 0x84, 0xBF, 0xDA, 0x79, 0x16, 0x4B,
//       0x7E, 0xCD, 0x84, 0x86, 0x98, 0x5D, 0x38, 0x60,
//       0x4f, 0xeb, 0xdc, 0x67, 0x40, 0xd2, 0x0b, 0x3a,
//       0xc8, 0x8f, 0x6a, 0xd8, 0x2a, 0x4f, 0xb0, 0x8d,
//       0x71, 0xab, 0x47, 0xa0, 0x86, 0xe8, 0x6e, 0xed,
//       0xf3, 0x9d, 0x1c, 0x5b, 0xba, 0x97, 0xc4, 0x08,
//       0x01, 0x26, 0x14, 0x1d, 0x67, 0xf3, 0x7b, 0xe8,
//       0x53, 0x8f, 0x5a, 0x8b, 0xe7, 0x40, 0xe4, 0x84 }
// };
// #endif /* MBEDTLS_CIPHER_MODE_OFB */

// #if defined(MBEDTLS_CIPHER_MODE_CTR)
// /*
//  * AES-CTR test vectors from:
//  *
//  * http://www.faqs.org/rfcs/rfc3686.html
//  */

// static const unsigned char aes_test_ctr_key[3][16] =
// {
//     { 0xAE, 0x68, 0x52, 0xF8, 0x12, 0x10, 0x67, 0xCC,
//       0x4B, 0xF7, 0xA5, 0x76, 0x55, 0x77, 0xF3, 0x9E },
//     { 0x7E, 0x24, 0x06, 0x78, 0x17, 0xFA, 0xE0, 0xD7,
//       0x43, 0xD6, 0xCE, 0x1F, 0x32, 0x53, 0x91, 0x63 },
//     { 0x76, 0x91, 0xBE, 0x03, 0x5E, 0x50, 0x20, 0xA8,
//       0xAC, 0x6E, 0x61, 0x85, 0x29, 0xF9, 0xA0, 0xDC }
// };

// static const unsigned char aes_test_ctr_nonce_counter[3][16] =
// {
//     { 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00,
//       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01 },
//     { 0x00, 0x6C, 0xB6, 0xDB, 0xC0, 0x54, 0x3B, 0x59,
//       0xDA, 0x48, 0xD9, 0x0B, 0x00, 0x00, 0x00, 0x01 },
//     { 0x00, 0xE0, 0x01, 0x7B, 0x27, 0x77, 0x7F, 0x3F,
//       0x4A, 0x17, 0x86, 0xF0, 0x00, 0x00, 0x00, 0x01 }
// };

// static const unsigned char aes_test_ctr_pt[3][48] =
// {
//     { 0x53, 0x69, 0x6E, 0x67, 0x6C, 0x65, 0x20, 0x62,
//       0x6C, 0x6F, 0x63, 0x6B, 0x20, 0x6D, 0x73, 0x67 },

//     { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
//       0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
//       0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
//       0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F },

//     { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
//       0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
//       0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
//       0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
//       0x20, 0x21, 0x22, 0x23 }
// };

// static const unsigned char aes_test_ctr_ct[3][48] =
// {
//     { 0xE4, 0x09, 0x5D, 0x4F, 0xB7, 0xA7, 0xB3, 0x79,
//       0x2D, 0x61, 0x75, 0xA3, 0x26, 0x13, 0x11, 0xB8 },
//     { 0x51, 0x04, 0xA1, 0x06, 0x16, 0x8A, 0x72, 0xD9,
//       0x79, 0x0D, 0x41, 0xEE, 0x8E, 0xDA, 0xD3, 0x88,
//       0xEB, 0x2E, 0x1E, 0xFC, 0x46, 0xDA, 0x57, 0xC8,
//       0xFC, 0xE6, 0x30, 0xDF, 0x91, 0x41, 0xBE, 0x28 },
//     { 0xC1, 0xCF, 0x48, 0xA8, 0x9F, 0x2F, 0xFD, 0xD9,
//       0xCF, 0x46, 0x52, 0xE9, 0xEF, 0xDB, 0x72, 0xD7,
//       0x45, 0x40, 0xA4, 0x2B, 0xDE, 0x6D, 0x78, 0x36,
//       0xD5, 0x9A, 0x5C, 0xEA, 0xAE, 0xF3, 0x10, 0x53,
//       0x25, 0xB2, 0x07, 0x2F }
// };

// static const int aes_test_ctr_len[3] =
//     { 16, 32, 36 };
// #endif /* MBEDTLS_CIPHER_MODE_CTR */

// #if defined(MBEDTLS_CIPHER_MODE_XTS)
// /*
//  * AES-XTS test vectors from:
//  *
//  * IEEE P1619/D16 Annex B
//  * https://web.archive.org/web/20150629024421/http://grouper.ieee.org/groups/1619/email/pdf00086.pdf
//  * (Archived from original at http://grouper.ieee.org/groups/1619/email/pdf00086.pdf)
//  */
// static const unsigned char aes_test_xts_key[][32] =
// {
//     { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
//       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
//       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
//       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
//     { 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
//       0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
//       0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22,
//       0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22 },
//     { 0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
//       0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
//       0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22,
//       0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22 },
// };

// static const unsigned char aes_test_xts_pt32[][32] =
// {
//     { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
//       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
//       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
//       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
//     { 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44,
//       0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44,
//       0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44,
//       0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44 },
//     { 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44,
//       0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44,
//       0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44,
//       0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44 },
// };

// static const unsigned char aes_test_xts_ct32[][32] =
// {
//     { 0x91, 0x7c, 0xf6, 0x9e, 0xbd, 0x68, 0xb2, 0xec,
//       0x9b, 0x9f, 0xe9, 0xa3, 0xea, 0xdd, 0xa6, 0x92,
//       0xcd, 0x43, 0xd2, 0xf5, 0x95, 0x98, 0xed, 0x85,
//       0x8c, 0x02, 0xc2, 0x65, 0x2f, 0xbf, 0x92, 0x2e },
//     { 0xc4, 0x54, 0x18, 0x5e, 0x6a, 0x16, 0x93, 0x6e,
//       0x39, 0x33, 0x40, 0x38, 0xac, 0xef, 0x83, 0x8b,
//       0xfb, 0x18, 0x6f, 0xff, 0x74, 0x80, 0xad, 0xc4,
//       0x28, 0x93, 0x82, 0xec, 0xd6, 0xd3, 0x94, 0xf0 },
//     { 0xaf, 0x85, 0x33, 0x6b, 0x59, 0x7a, 0xfc, 0x1a,
//       0x90, 0x0b, 0x2e, 0xb2, 0x1e, 0xc9, 0x49, 0xd2,
//       0x92, 0xdf, 0x4c, 0x04, 0x7e, 0x0b, 0x21, 0x53,
//       0x21, 0x86, 0xa5, 0x97, 0x1a, 0x22, 0x7a, 0x89 },
// };

// static const unsigned char aes_test_xts_data_unit[][16] =
// {
//    { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
//      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
//    { 0x33, 0x33, 0x33, 0x33, 0x33, 0x00, 0x00, 0x00,
//      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
//    { 0x33, 0x33, 0x33, 0x33, 0x33, 0x00, 0x00, 0x00,
//      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
// };

// #endif /* MBEDTLS_CIPHER_MODE_XTS */

// /*
//  * Checkup routine
//  */
// int mbedtls_aes_test( int verbose )
// {
//     int ret = 0, i, j, u, mode;
//     unsigned int keybits;
//     unsigned char key[32];
//     unsigned char buf[64];
//     const unsigned char *aes_tests;
// #if defined(MBEDTLS_CIPHER_MODE_CBC) || defined(MBEDTLS_CIPHER_MODE_CFB)
//     unsigned char iv[16];
// #endif
// #if defined(MBEDTLS_CIPHER_MODE_CBC)
//     unsigned char prv[16];
// #endif
// #if defined(MBEDTLS_CIPHER_MODE_CTR) || defined(MBEDTLS_CIPHER_MODE_CFB) || \
//     defined(MBEDTLS_CIPHER_MODE_OFB)
//     size_t offset;
// #endif
// #if defined(MBEDTLS_CIPHER_MODE_CTR) || defined(MBEDTLS_CIPHER_MODE_XTS)
//     int len;
// #endif
// #if defined(MBEDTLS_CIPHER_MODE_CTR)
//     unsigned char nonce_counter[16];
//     unsigned char stream_block[16];
// #endif
//     mbedtls_aes_context ctx;

//     memset( key, 0, 32 );
//     mbedtls_aes_init( &ctx );

//     /*
//      * ECB mode
//      */
//     for( i = 0; i < 6; i++ )
//     {
//         u = i >> 1;
//         keybits = 128 + u * 64;
//         mode = i & 1;

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "  AES-ECB-%3u (%s): ", keybits,
//                             ( mode == MBEDTLS_AES_DECRYPT ) ? "dec" : "enc" );

//         memset( buf, 0, 16 );

//         if( mode == MBEDTLS_AES_DECRYPT )
//         {
//             ret = mbedtls_aes_setkey_dec( &ctx, key, keybits );
//             aes_tests = aes_test_ecb_dec[u];
//         }
//         else
//         {
//             ret = mbedtls_aes_setkey_enc( &ctx, key, keybits );
//             aes_tests = aes_test_ecb_enc[u];
//         }

//         /*
//          * AES-192 is an optional feature that may be unavailable when
//          * there is an alternative underlying implementation i.e. when
//          * MBEDTLS_AES_ALT is defined.
//          */
//         if( ret == MBEDTLS_ERR_PLATFORM_FEATURE_UNSUPPORTED && keybits == 192 )
//         {
//             LUAT_DEBUG_PRINT( "skipped\n" );
//             continue;
//         }
//         else if( ret != 0 )
//         {
//             goto exit;
//         }

//         for( j = 0; j < 10000; j++ )
//         {
//             ret = mbedtls_aes_crypt_ecb( &ctx, mode, buf, buf );
//             if( ret != 0 )
//                 goto exit;
//         }

//         if( memcmp( buf, aes_tests, 16 ) != 0 )
//         {
//             ret = 1;
//             goto exit;
//         }

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "passed\n" );
//     }

//     if( verbose != 0 )
//         LUAT_DEBUG_PRINT( "\n" );

// #if defined(MBEDTLS_CIPHER_MODE_CBC)
//     /*
//      * CBC mode
//      */
//     for( i = 0; i < 6; i++ )
//     {
//         u = i >> 1;
//         keybits = 128 + u * 64;
//         mode = i & 1;

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "  AES-CBC-%3u (%s): ", keybits,
//                             ( mode == MBEDTLS_AES_DECRYPT ) ? "dec" : "enc" );

//         memset( iv , 0, 16 );
//         memset( prv, 0, 16 );
//         memset( buf, 0, 16 );

//         if( mode == MBEDTLS_AES_DECRYPT )
//         {
//             ret = mbedtls_aes_setkey_dec( &ctx, key, keybits );
//             aes_tests = aes_test_cbc_dec[u];
//         }
//         else
//         {
//             ret = mbedtls_aes_setkey_enc( &ctx, key, keybits );
//             aes_tests = aes_test_cbc_enc[u];
//         }

//         /*
//          * AES-192 is an optional feature that may be unavailable when
//          * there is an alternative underlying implementation i.e. when
//          * MBEDTLS_AES_ALT is defined.
//          */
//         if( ret == MBEDTLS_ERR_PLATFORM_FEATURE_UNSUPPORTED && keybits == 192 )
//         {
//             LUAT_DEBUG_PRINT( "skipped\n" );
//             continue;
//         }
//         else if( ret != 0 )
//         {
//             goto exit;
//         }

//         for( j = 0; j < 10000; j++ )
//         {
//             if( mode == MBEDTLS_AES_ENCRYPT )
//             {
//                 unsigned char tmp[16];

//                 memcpy( tmp, prv, 16 );
//                 memcpy( prv, buf, 16 );
//                 memcpy( buf, tmp, 16 );
//             }

//             ret = mbedtls_aes_crypt_cbc( &ctx, mode, 16, iv, buf, buf );
//             if( ret != 0 )
//                 goto exit;

//         }

//         if( memcmp( buf, aes_tests, 16 ) != 0 )
//         {
//             ret = 1;
//             goto exit;
//         }

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "passed\n" );
//     }

//     if( verbose != 0 )
//         LUAT_DEBUG_PRINT( "\n" );
// #endif /* MBEDTLS_CIPHER_MODE_CBC */

// #if defined(MBEDTLS_CIPHER_MODE_CFB)
//     /*
//      * CFB128 mode
//      */
//     for( i = 0; i < 6; i++ )
//     {
//         u = i >> 1;
//         keybits = 128 + u * 64;
//         mode = i & 1;

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "  AES-CFB128-%3u (%s): ", keybits,
//                             ( mode == MBEDTLS_AES_DECRYPT ) ? "dec" : "enc" );

//         memcpy( iv,  aes_test_cfb128_iv, 16 );
//         memcpy( key, aes_test_cfb128_key[u], keybits / 8 );

//         offset = 0;
//         ret = mbedtls_aes_setkey_enc( &ctx, key, keybits );
//         /*
//          * AES-192 is an optional feature that may be unavailable when
//          * there is an alternative underlying implementation i.e. when
//          * MBEDTLS_AES_ALT is defined.
//          */
//         if( ret == MBEDTLS_ERR_PLATFORM_FEATURE_UNSUPPORTED && keybits == 192 )
//         {
//             LUAT_DEBUG_PRINT( "skipped\n" );
//             continue;
//         }
//         else if( ret != 0 )
//         {
//             goto exit;
//         }

//         if( mode == MBEDTLS_AES_DECRYPT )
//         {
//             memcpy( buf, aes_test_cfb128_ct[u], 64 );
//             aes_tests = aes_test_cfb128_pt;
//         }
//         else
//         {
//             memcpy( buf, aes_test_cfb128_pt, 64 );
//             aes_tests = aes_test_cfb128_ct[u];
//         }

//         ret = mbedtls_aes_crypt_cfb128( &ctx, mode, 64, &offset, iv, buf, buf );
//         if( ret != 0 )
//             goto exit;

//         if( memcmp( buf, aes_tests, 64 ) != 0 )
//         {
//             ret = 1;
//             goto exit;
//         }

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "passed\n" );
//     }

//     if( verbose != 0 )
//         LUAT_DEBUG_PRINT( "\n" );
// #endif /* MBEDTLS_CIPHER_MODE_CFB */

// #if defined(MBEDTLS_CIPHER_MODE_OFB)
//     /*
//      * OFB mode
//      */
//     for( i = 0; i < 6; i++ )
//     {
//         u = i >> 1;
//         keybits = 128 + u * 64;
//         mode = i & 1;

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "  AES-OFB-%3u (%s): ", keybits,
//                             ( mode == MBEDTLS_AES_DECRYPT ) ? "dec" : "enc" );

//         memcpy( iv,  aes_test_ofb_iv, 16 );
//         memcpy( key, aes_test_ofb_key[u], keybits / 8 );

//         offset = 0;
//         ret = mbedtls_aes_setkey_enc( &ctx, key, keybits );
//         /*
//          * AES-192 is an optional feature that may be unavailable when
//          * there is an alternative underlying implementation i.e. when
//          * MBEDTLS_AES_ALT is defined.
//          */
//         if( ret == MBEDTLS_ERR_PLATFORM_FEATURE_UNSUPPORTED && keybits == 192 )
//         {
//             LUAT_DEBUG_PRINT( "skipped\n" );
//             continue;
//         }
//         else if( ret != 0 )
//         {
//             goto exit;
//         }

//         if( mode == MBEDTLS_AES_DECRYPT )
//         {
//             memcpy( buf, aes_test_ofb_ct[u], 64 );
//             aes_tests = aes_test_ofb_pt;
//         }
//         else
//         {
//             memcpy( buf, aes_test_ofb_pt, 64 );
//             aes_tests = aes_test_ofb_ct[u];
//         }

//         ret = mbedtls_aes_crypt_ofb( &ctx, 64, &offset, iv, buf, buf );
//         if( ret != 0 )
//             goto exit;

//         if( memcmp( buf, aes_tests, 64 ) != 0 )
//         {
//             ret = 1;
//             goto exit;
//         }

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "passed\n" );
//     }

//     if( verbose != 0 )
//         LUAT_DEBUG_PRINT( "\n" );
// #endif /* MBEDTLS_CIPHER_MODE_OFB */

// #if defined(MBEDTLS_CIPHER_MODE_CTR)
//     /*
//      * CTR mode
//      */
//     for( i = 0; i < 6; i++ )
//     {
//         u = i >> 1;
//         mode = i & 1;

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "  AES-CTR-128 (%s): ",
//                             ( mode == MBEDTLS_AES_DECRYPT ) ? "dec" : "enc" );

//         memcpy( nonce_counter, aes_test_ctr_nonce_counter[u], 16 );
//         memcpy( key, aes_test_ctr_key[u], 16 );

//         offset = 0;
//         if( ( ret = mbedtls_aes_setkey_enc( &ctx, key, 128 ) ) != 0 )
//             goto exit;

//         len = aes_test_ctr_len[u];

//         if( mode == MBEDTLS_AES_DECRYPT )
//         {
//             memcpy( buf, aes_test_ctr_ct[u], len );
//             aes_tests = aes_test_ctr_pt[u];
//         }
//         else
//         {
//             memcpy( buf, aes_test_ctr_pt[u], len );
//             aes_tests = aes_test_ctr_ct[u];
//         }

//         ret = mbedtls_aes_crypt_ctr( &ctx, len, &offset, nonce_counter,
//                                      stream_block, buf, buf );
//         if( ret != 0 )
//             goto exit;

//         if( memcmp( buf, aes_tests, len ) != 0 )
//         {
//             ret = 1;
//             goto exit;
//         }

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "passed\n" );
//     }

//     if( verbose != 0 )
//         LUAT_DEBUG_PRINT( "\n" );
// #endif /* MBEDTLS_CIPHER_MODE_CTR */

// #if defined(MBEDTLS_CIPHER_MODE_XTS)
//     {
//     static const int num_tests =
//         sizeof(aes_test_xts_key) / sizeof(*aes_test_xts_key);
//     mbedtls_aes_xts_context ctx_xts;

//     /*
//      * XTS mode
//      */
//     mbedtls_aes_xts_init( &ctx_xts );

//     for( i = 0; i < num_tests << 1; i++ )
//     {
//         const unsigned char *data_unit;
//         u = i >> 1;
//         mode = i & 1;

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "  AES-XTS-128 (%s): ",
//                             ( mode == MBEDTLS_AES_DECRYPT ) ? "dec" : "enc" );

//         memset( key, 0, sizeof( key ) );
//         memcpy( key, aes_test_xts_key[u], 32 );
//         data_unit = aes_test_xts_data_unit[u];

//         len = sizeof( *aes_test_xts_ct32 );

//         if( mode == MBEDTLS_AES_DECRYPT )
//         {
//             ret = mbedtls_aes_xts_setkey_dec( &ctx_xts, key, 256 );
//             if( ret != 0)
//                 goto exit;
//             memcpy( buf, aes_test_xts_ct32[u], len );
//             aes_tests = aes_test_xts_pt32[u];
//         }
//         else
//         {
//             ret = mbedtls_aes_xts_setkey_enc( &ctx_xts, key, 256 );
//             if( ret != 0)
//                 goto exit;
//             memcpy( buf, aes_test_xts_pt32[u], len );
//             aes_tests = aes_test_xts_ct32[u];
//         }


//         ret = mbedtls_aes_crypt_xts( &ctx_xts, mode, len, data_unit,
//                                      buf, buf );
//         if( ret != 0 )
//             goto exit;

//         if( memcmp( buf, aes_tests, len ) != 0 )
//         {
//             ret = 1;
//             goto exit;
//         }

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "passed\n" );
//     }

//     if( verbose != 0 )
//         LUAT_DEBUG_PRINT( "\n" );

//     mbedtls_aes_xts_free( &ctx_xts );
//     }
// #endif /* MBEDTLS_CIPHER_MODE_XTS */

//     ret = 0;

// exit:
//     if( ret != 0 && verbose != 0 )
//         LUAT_DEBUG_PRINT( "failed\n" );

//     mbedtls_aes_free( &ctx );

//     return( ret );
// }

// /*
//  * DES and 3DES test vectors from:
//  *
//  * http://csrc.nist.gov/groups/STM/cavp/documents/des/tripledes-vectors.zip
//  */
// static const unsigned char des3_test_keys[24] =
// {
//     0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF,
//     0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF, 0x01,
//     0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF, 0x01, 0x23
// };

// static const unsigned char des3_test_buf[8] =
// {
//     0x4E, 0x6F, 0x77, 0x20, 0x69, 0x73, 0x20, 0x74
// };

// static const unsigned char des3_test_ecb_dec[3][8] =
// {
//     { 0x37, 0x2B, 0x98, 0xBF, 0x52, 0x65, 0xB0, 0x59 },
//     { 0xC2, 0x10, 0x19, 0x9C, 0x38, 0x5A, 0x65, 0xA1 },
//     { 0xA2, 0x70, 0x56, 0x68, 0x69, 0xE5, 0x15, 0x1D }
// };

// static const unsigned char des3_test_ecb_enc[3][8] =
// {
//     { 0x1C, 0xD5, 0x97, 0xEA, 0x84, 0x26, 0x73, 0xFB },
//     { 0xB3, 0x92, 0x4D, 0xF3, 0xC5, 0xB5, 0x42, 0x93 },
//     { 0xDA, 0x37, 0x64, 0x41, 0xBA, 0x6F, 0x62, 0x6F }
// };

// #if defined(MBEDTLS_CIPHER_MODE_CBC)
// static const unsigned char des3_test_iv[8] =
// {
//     0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF,
// };

// static const unsigned char des3_test_cbc_dec[3][8] =
// {
//     { 0x58, 0xD9, 0x48, 0xEF, 0x85, 0x14, 0x65, 0x9A },
//     { 0x5F, 0xC8, 0x78, 0xD4, 0xD7, 0x92, 0xD9, 0x54 },
//     { 0x25, 0xF9, 0x75, 0x85, 0xA8, 0x1E, 0x48, 0xBF }
// };

// static const unsigned char des3_test_cbc_enc[3][8] =
// {
//     { 0x91, 0x1C, 0x6D, 0xCF, 0x48, 0xA7, 0xC3, 0x4D },
//     { 0x60, 0x1A, 0x76, 0x8F, 0xA1, 0xF9, 0x66, 0xF1 },
//     { 0xA1, 0x50, 0x0F, 0x99, 0xB2, 0xCD, 0x64, 0x76 }
// };
// #endif /* MBEDTLS_CIPHER_MODE_CBC */

// /*
//  * Checkup routine
//  */
// static int mbedtls_des_test( int verbose )
// {
//     int i, j, u, v, ret = 0;
//     mbedtls_des_context ctx;
//     mbedtls_des3_context ctx3;
//     unsigned char buf[8];
// #if defined(MBEDTLS_CIPHER_MODE_CBC)
//     unsigned char prv[8];
//     unsigned char iv[8];
// #endif

//     mbedtls_des_init( &ctx );
//     mbedtls_des3_init( &ctx3 );
//     /*
//      * ECB mode
//      */
//     for( i = 0; i < 6; i++ )
//     {
//         u = i >> 1;
//         v = i  & 1;

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "  DES%c-ECB-%3d (%s): ",
//                              ( u == 0 ) ? ' ' : '3', 56 + u * 56,
//                              ( v == MBEDTLS_DES_DECRYPT ) ? "dec" : "enc" );

//         memcpy( buf, des3_test_buf, 8 );

//         switch( i )
//         {
//         case 0:
//             mbedtls_des_setkey_dec( &ctx, des3_test_keys );
//             break;

//         case 1:
//             mbedtls_des_setkey_enc( &ctx, des3_test_keys );
//             break;

//         case 2:
//             mbedtls_des3_set2key_dec( &ctx3, des3_test_keys );
//             break;

//         case 3:
//             mbedtls_des3_set2key_enc( &ctx3, des3_test_keys );
//             break;

//         case 4:
//             mbedtls_des3_set3key_dec( &ctx3, des3_test_keys );
//             break;

//         case 5:
//             mbedtls_des3_set3key_enc( &ctx3, des3_test_keys );
//             break;

//         default:
//             return( 1 );
//         }

//         for( j = 0; j < 100; j++ )
//         {
//             if( u == 0 )
//                 mbedtls_des_crypt_ecb( &ctx, buf, buf );
//             else
//                 mbedtls_des3_crypt_ecb( &ctx3, buf, buf );
//         }

//         if( ( v == MBEDTLS_DES_DECRYPT &&
//                 memcmp( buf, des3_test_ecb_dec[u], 8 ) != 0 ) ||
//             ( v != MBEDTLS_DES_DECRYPT &&
//                 memcmp( buf, des3_test_ecb_enc[u], 8 ) != 0 ) )
//         {
//             if( verbose != 0 )
//                 LUAT_DEBUG_PRINT( "failed\n" );

//             ret = 1;
//             goto exit;
//         }

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "passed\n" );
//     }

//     if( verbose != 0 )
//         LUAT_DEBUG_PRINT( "\n" );

// #if defined(MBEDTLS_CIPHER_MODE_CBC)
//     /*
//      * CBC mode
//      */
//     for( i = 0; i < 6; i++ )
//     {
//         u = i >> 1;
//         v = i  & 1;

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "  DES%c-CBC-%3d (%s): ",
//                              ( u == 0 ) ? ' ' : '3', 56 + u * 56,
//                              ( v == MBEDTLS_DES_DECRYPT ) ? "dec" : "enc" );

//         memcpy( iv,  des3_test_iv,  8 );
//         memcpy( prv, des3_test_iv,  8 );
//         memcpy( buf, des3_test_buf, 8 );

//         switch( i )
//         {
//         case 0:
//             mbedtls_des_setkey_dec( &ctx, des3_test_keys );
//             break;

//         case 1:
//             mbedtls_des_setkey_enc( &ctx, des3_test_keys );
//             break;

//         case 2:
//             mbedtls_des3_set2key_dec( &ctx3, des3_test_keys );
//             break;

//         case 3:
//             mbedtls_des3_set2key_enc( &ctx3, des3_test_keys );
//             break;

//         case 4:
//             mbedtls_des3_set3key_dec( &ctx3, des3_test_keys );
//             break;

//         case 5:
//             mbedtls_des3_set3key_enc( &ctx3, des3_test_keys );
//             break;

//         default:
//             return( 1 );
//         }

//         if( v == MBEDTLS_DES_DECRYPT )
//         {
//             for( j = 0; j < 100; j++ )
//             {
//                 if( u == 0 )
//                     mbedtls_des_crypt_cbc( &ctx, v, 8, iv, buf, buf );
//                 else
//                     mbedtls_des3_crypt_cbc( &ctx3, v, 8, iv, buf, buf );
//             }
//         }
//         else
//         {
//             for( j = 0; j < 100; j++ )
//             {
//                 unsigned char tmp[8];

//                 if( u == 0 )
//                     mbedtls_des_crypt_cbc( &ctx, v, 8, iv, buf, buf );
//                 else
//                     mbedtls_des3_crypt_cbc( &ctx3, v, 8, iv, buf, buf );

//                 memcpy( tmp, prv, 8 );
//                 memcpy( prv, buf, 8 );
//                 memcpy( buf, tmp, 8 );
//             }

//             memcpy( buf, prv, 8 );
//         }

//         if( ( v == MBEDTLS_DES_DECRYPT &&
//                 memcmp( buf, des3_test_cbc_dec[u], 8 ) != 0 ) ||
//             ( v != MBEDTLS_DES_DECRYPT &&
//                 memcmp( buf, des3_test_cbc_enc[u], 8 ) != 0 ) )
//         {
//             if( verbose != 0 )
//                 LUAT_DEBUG_PRINT( "failed\n" );

//             ret = 1;
//             goto exit;
//         }

//         if( verbose != 0 )
//             LUAT_DEBUG_PRINT( "passed\n" );
//     }
// #endif /* MBEDTLS_CIPHER_MODE_CBC */

//     if( verbose != 0 )
//         LUAT_DEBUG_PRINT( "\n" );

// exit:
//     mbedtls_des_free( &ctx );
//     mbedtls_des3_free( &ctx3 );

//     return( ret );
// }

void trng_test()
{
    uint8_t *buff = NULL;
    buff = malloc(24 * 100);
    for (size_t i = 0; i < 100; i++)
    {
        luat_crypto_trng(buff + i*24, 24);
    }
	LUAT_DEBUG_PRINT("The Trng string is [%u]", buff);
}

static void demo_init_crypto()
{
	md5_test();
	base64_test();
	sha1_test();
	sha256_224_test();
	mbedtls_rsa_test(1);
	// mbedtls_aes_test(1);
	// mbedtls_des_test(1);
	trng_test();
}

static void demo_init_protobuf()
{
	LUAT_DEBUG_PRINT("==================crypto is running==================");
}

static void task(void *param)
{
	while(1)
	{
		luat_rtos_task_sleep(1000);
		demo_init_crypto();
		LUAT_DEBUG_PRINT("==================crypto is done==================");
	}
}


static void task_demoE_init(void)
{
	luat_rtos_task_create(&task_handle, 2*1024, 50, "task", task, NULL, 0);
}

//启动task_demoE_init，启动位置任务1级
INIT_TASK_EXPORT(task_demoE_init, "1");
