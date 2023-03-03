#ifndef MINIMP3_H
#define MINIMP3_H
/*
    https://github.com/lieff/minimp3
    To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide.
    This software is distributed without any warranty.
    See <http://creativecommons.org/publicdomain/zero/1.0/>.
*/
#include <stdint.h>
#define MINIMP3_NO_SIMD
#define MINIMP3_IMPLEMENTATION
#define MINIMP3_MAX_SAMPLES_PER_FRAME (1152*2)

typedef struct
{
    int frame_bytes, frame_offset, channels, hz, layer, bitrate_kbps;
} mp3dec_frame_info_t;

typedef struct
{
    float mdct_overlap[2][9*32], qmf_state[15*2*32];
    int reserv, free_format_bytes;
    unsigned char header[4], reserv_buf[511];
} mp3dec_t;

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

void mp3dec_init(mp3dec_t *dec);
#ifndef MINIMP3_FLOAT_OUTPUT
typedef int16_t mp3d_sample_t;
#else /* MINIMP3_FLOAT_OUTPUT */
typedef float mp3d_sample_t;
void mp3dec_f32_to_s16(const float *in, int16_t *out, int num_samples);
#endif /* MINIMP3_FLOAT_OUTPUT */
int mp3dec_decode_frame(mp3dec_t *dec, const uint8_t *mp3, int mp3_bytes, mp3d_sample_t *pcm, mp3dec_frame_info_t *info);

#ifdef __cplusplus
}
#endif /* __cplusplus */


#if defined(MINIMP3_IMPLEMENTATION) && !defined(_MINIMP3_IMPLEMENTATION_GUARD)
#define _MINIMP3_IMPLEMENTATION_GUARD

#include <stdlib.h>
#include <string.h>

#define MAX_FREE_FORMAT_FRAME_SIZE  2304    /* more than ISO spec's */
#ifndef MAX_FRAME_SYNC_MATCHES
#define MAX_FRAME_SYNC_MATCHES      10
#endif /* MAX_FRAME_SYNC_MATCHES */

#define MAX_L3_FRAME_PAYLOAD_BYTES  MAX_FREE_FORMAT_FRAME_SIZE /* MUST be >= 320000/8/32000*1152 = 1440 */

#define MAX_BITRESERVOIR_BYTES      511
#define SHORT_BLOCK_TYPE            2
#define STOP_BLOCK_TYPE             3
#define MODE_MONO                   3
#define MODE_JOINT_STEREO           1
#define HDR_SIZE                    4
#define HDR_IS_MONO(h)              (((h[3]) & 0xC0) == 0xC0)
#define HDR_IS_MS_STEREO(h)         (((h[3]) & 0xE0) == 0x60)
#define HDR_IS_FREE_FORMAT(h)       (((h[2]) & 0xF0) == 0)
#define HDR_IS_CRC(h)               (!((h[1]) & 1))
#define HDR_TEST_PADDING(h)         ((h[2]) & 0x2)
#define HDR_TEST_MPEG1(h)           ((h[1]) & 0x8)
#define HDR_TEST_NOT_MPEG25(h)      ((h[1]) & 0x10)
#define HDR_TEST_I_STEREO(h)        ((h[3]) & 0x10)
#define HDR_TEST_MS_STEREO(h)       ((h[3]) & 0x20)
#define HDR_GET_STEREO_MODE(h)      (((h[3]) >> 6) & 3)
#define HDR_GET_STEREO_MODE_EXT(h)  (((h[3]) >> 4) & 3)
#define HDR_GET_LAYER(h)            (((h[1]) >> 1) & 3)
#define HDR_GET_BITRATE(h)          ((h[2]) >> 4)
#define HDR_GET_SAMPLE_RATE(h)      (((h[2]) >> 2) & 3)
#define HDR_GET_MY_SAMPLE_RATE(h)   (HDR_GET_SAMPLE_RATE(h) + (((h[1] >> 3) & 1) + ((h[1] >> 4) & 1))*3)
#define HDR_IS_FRAME_576(h)         ((h[1] & 14) == 2)
#define HDR_IS_LAYER_1(h)           ((h[1] & 6) == 6)

#define BITS_DEQUANTIZER_OUT        -1
#define MAX_SCF                     (255 + BITS_DEQUANTIZER_OUT*4 - 210)
#define MAX_SCFI                    ((MAX_SCF + 3) & ~3)

#define MINIMP3_MIN(a, b)           ((a) > (b) ? (b) : (a))
#define MINIMP3_MAX(a, b)           ((a) < (b) ? (b) : (a))

#define HAVE_SIMD 0


#define HAVE_ARMV6 0

typedef struct
{
    const uint8_t *buf;
    int pos, limit;
} bs_t;

typedef struct
{
    float scf[3*64];
    uint8_t total_bands, stereo_bands, bitalloc[64], scfcod[64];
} L12_scale_info;

typedef struct
{
    uint8_t tab_offset, code_tab_width, band_count;
} L12_subband_alloc_t;

typedef struct
{
    const uint8_t *sfbtab;
    uint16_t part_23_length, big_values, scalefac_compress;
    uint8_t global_gain, block_type, mixed_block_flag, n_long_sfb, n_short_sfb;
    uint8_t table_select[3], region_count[3], subblock_gain[3];
    uint8_t preflag, scalefac_scale, count1_table, scfsi;
} L3_gr_info_t;

typedef struct
{
    bs_t bs;
    uint8_t maindata[MAX_BITRESERVOIR_BYTES + MAX_L3_FRAME_PAYLOAD_BYTES];
    L3_gr_info_t gr_info[4];
    float grbuf[2][576], scf[40], syn[18 + 15][2*32];
    uint8_t ist_pos[2][39];
} mp3dec_scratch_t;

#ifdef MINIMP3_FLOAT_OUTPUT
void mp3dec_f32_to_s16(const float *in, int16_t *out, int num_samples);
#endif /* MINIMP3_FLOAT_OUTPUT */
#endif /* MINIMP3_IMPLEMENTATION && !_MINIMP3_IMPLEMENTATION_GUARD */
#endif /* MINIMP3_H */
