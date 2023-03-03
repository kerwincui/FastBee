/**************************************************************************
 *              Copyright (C), AirM2M Tech. Co., Ltd.
 *
 * Name:    ucs2_to_gb2312.c
 * Author:  liweiqiang
 * Version: V0.1
 * Date:    2013/7/15
 *
 * Description:
 *          ucs2 ×ª»» gb2312
 **************************************************************************/

#include <stdint.h>
#include "stdio.h"
#include "errno.h"

#include "ucs2_to_gb2312_table.h"
#include "ucs2_to_gb2312_offset.h"

const uint8_t number_of_bit_1[256] = 
{
    0x00, 0x01, 0x01, 0x02, 0x01, 0x02, 0x02, 0x03,
    0x01, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x04,
    0x01, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x04,
    0x02, 0x03, 0x03, 0x04, 0x03, 0x04, 0x04, 0x05,
    0x01, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x04,
    0x02, 0x03, 0x03, 0x04, 0x03, 0x04, 0x04, 0x05,
    0x02, 0x03, 0x03, 0x04, 0x03, 0x04, 0x04, 0x05,
    0x03, 0x04, 0x04, 0x05, 0x04, 0x05, 0x05, 0x06,
    0x01, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x04,
    0x02, 0x03, 0x03, 0x04, 0x03, 0x04, 0x04, 0x05,
    0x02, 0x03, 0x03, 0x04, 0x03, 0x04, 0x04, 0x05,
    0x03, 0x04, 0x04, 0x05, 0x04, 0x05, 0x05, 0x06,
    0x02, 0x03, 0x03, 0x04, 0x03, 0x04, 0x04, 0x05,
    0x03, 0x04, 0x04, 0x05, 0x04, 0x05, 0x05, 0x06,
    0x03, 0x04, 0x04, 0x05, 0x04, 0x05, 0x05, 0x06,
    0x04, 0x05, 0x05, 0x06, 0x05, 0x06, 0x06, 0x07,
    0x01, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x04,
    0x02, 0x03, 0x03, 0x04, 0x03, 0x04, 0x04, 0x05,
    0x02, 0x03, 0x03, 0x04, 0x03, 0x04, 0x04, 0x05,
    0x03, 0x04, 0x04, 0x05, 0x04, 0x05, 0x05, 0x06,
    0x02, 0x03, 0x03, 0x04, 0x03, 0x04, 0x04, 0x05,
    0x03, 0x04, 0x04, 0x05, 0x04, 0x05, 0x05, 0x06,
    0x03, 0x04, 0x04, 0x05, 0x04, 0x05, 0x05, 0x06,
    0x04, 0x05, 0x05, 0x06, 0x05, 0x06, 0x06, 0x07,
    0x02, 0x03, 0x03, 0x04, 0x03, 0x04, 0x04, 0x05,
    0x03, 0x04, 0x04, 0x05, 0x04, 0x05, 0x05, 0x06,
    0x03, 0x04, 0x04, 0x05, 0x04, 0x05, 0x05, 0x06,
    0x04, 0x05, 0x05, 0x06, 0x05, 0x06, 0x06, 0x07,
    0x03, 0x04, 0x04, 0x05, 0x04, 0x05, 0x05, 0x06, 
    0x04, 0x05, 0x05, 0x06, 0x05, 0x06, 0x06, 0x07,
    0x04, 0x05, 0x05, 0x06, 0x05, 0x06, 0x06, 0x07,
    0x05, 0x06, 0x06, 0x07, 0x06, 0x07, 0x07, 0x08,
};

/* 0x4E00 <= ucs2 < 0xA000 */ 
static uint16_t get_ucs2_offset(uint16_t ucs2)
{
    uint16_t   offset, page, tmp;
    uint8_t    *mirror_ptr, ch;

    page = (ucs2>>8) - 0x4E;
    ucs2 &= 0xFF;

    tmp        = ucs2>>6; /* now 0 <= tmp < 4  */ 
    offset     = ucs2_index_table_4E00_9FFF[page][tmp];  
    mirror_ptr = (uint8_t*)&ucs2_mirror_4E00_9FFF[page][tmp<<3]; /* [0, 8, 16, 24] */ 

    tmp = ucs2&0x3F; /* mod 64 */ 

    while(tmp >= 8)
    {
        offset += number_of_bit_1[*mirror_ptr];
        mirror_ptr++;
        tmp -= 8;
    }

    ch = *mirror_ptr;
    if(ch&(0x1<<tmp))
    {   /* Ok , this ucs2 can be covert to GB2312. */ 
        while(tmp) 
        { 
            if(ch&0x1)
            offset++;
            ch>>=1;
            tmp--;
        }
        return offset;
    }

    return (uint16_t)(-1);
}

uint16_t unicode_to_gb2312(uint16_t ucs2, uint8_t marks)
{
	uint16_t gb = 0xA1A1;
	if(0x80 > ucs2)
    {
        // can be convert to ASCII char
        gb = ucs2;
    }
    else
    {
        if((0x4E00 <= ucs2) && (0xA000 > ucs2))
        {
            uint16_t offset = get_ucs2_offset(ucs2);
            if((uint16_t)(-1) != offset)
            {
                gb = ucs2_to_gb2312_table[offset];
            }
        }
        else if (marks == 0)
        {
            uint16_t u16count = sizeof(tab_UCS2_to_GBK)/4;
            for(uint16_t ui=0; ui < u16count; ui++)
            {
                if(ucs2 == tab_UCS2_to_GBK[ui][0])
                {
                    gb = tab_UCS2_to_GBK[ui][1];
                }
            }
                
        }
    }
	return gb;
}

/*+\NEW\liweiqiang\2013.11.26\ÍêÉÆgb2312<->ucs2(ucs2be)±àÂë×ª»»*/
static size_t iconv_ucs2_to_gb2312_endian(char **_inbuf, size_t *inbytesleft, char **_outbuf, size_t *outbytesleft, int endian)
{
    uint16_t gb2312 = 0xA1A1; 
    uint16_t ucs2;
    size_t gb_length = 0;
    uint16_t *ucs2buf = (uint16_t*)*_inbuf;
    char *outbuf = (char *)*_outbuf;
    size_t inlen = *inbytesleft/2;
    size_t outlen = *outbytesleft;
    size_t ret = 0;

    while(inlen > 0)
    {
        if(gb_length+2 > outlen)
        {
            errno = E2BIG;
            ret = -1;
            goto ucs2_to_gb2312_exit;
        }

        ucs2 = *ucs2buf++;

        if(endian == 1)
            ucs2 = (ucs2<<8)|(ucs2>>8);

        gb2312 = unicode_to_gb2312(ucs2, 0);
        //End 7205

        if(0x80 > gb2312)
        {
            // can be convert to ASCII char
            *outbuf++ = (uint8_t)gb2312;
            gb_length++;
        }
        else
        {
            *outbuf++ = (uint8_t)(gb2312>>8);
            *outbuf++ = (uint8_t)(gb2312);
            gb_length += 2;
        }
        
        inlen--;
    }

    if(inlen > 0)
    {
        errno = EINVAL;
        ret = -1;
    }

ucs2_to_gb2312_exit:
    *inbytesleft = inlen;
    *outbytesleft -= gb_length;

    return ret;
}

size_t iconv_ucs2_to_gb2312(char **_inbuf, size_t *inbytesleft, char **_outbuf, size_t *outbytesleft)
{
    return iconv_ucs2_to_gb2312_endian(_inbuf, inbytesleft, _outbuf, outbytesleft, 0);
}

size_t iconv_ucs2be_to_gb2312(char **_inbuf, size_t *inbytesleft, char **_outbuf, size_t *outbytesleft)
{
    return iconv_ucs2_to_gb2312_endian(_inbuf, inbytesleft, _outbuf, outbytesleft, 1);
}
/*-\NEW\liweiqiang\2013.11.26\ÍêÉÆgb2312<->ucs2(ucs2be)±àÂë×ª»»*/

