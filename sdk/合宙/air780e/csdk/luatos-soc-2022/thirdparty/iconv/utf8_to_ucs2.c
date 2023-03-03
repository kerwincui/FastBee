/**************************************************************************
 *              Copyright (C), AirM2M Tech. Co., Ltd.
 *
 * Name:    utf8_to_ucs2.c
 * Author:  liweiqiang
 * Version: V0.1
 * Date:    2013/7/19
 *
 * Description:
 *          utf8 转换为 ucs2 le/be
 **************************************************************************/

#include "stdio.h"
#include "errno.h"

#if 0
/***************************************************************************** 
 * 将一个字符的Unicode(UCS-2和UCS-4)编码转换成UTF-8编码. 
 * 
 * 参数: 
 *    unic     字符的Unicode编码值 
 *    pOutput  指向输出的用于存储UTF8编码值的缓冲区的指针 
 *    outsize  pOutput缓冲的大小 
 * 
 * 返回值: 
 *    返回转换后的字符的UTF8编码所占的字节数, 如果出错则返回 0 . 
 * 
 * 注意: 
 *     1. UTF8没有字节序问题, 但是Unicode有字节序要求; 
 *        字节序分为大端(Big Endian)和小端(Little Endian)两种; 
 *        在Intel处理器中采用小端法表示, 在此采用小端法表示. (低地址存低位) 
 *     2. 请保证 pOutput 缓冲区有最少有 6 字节的空间大小! 
 ****************************************************************************/  
static int enc_unicode_to_utf8_one(unsigned long unic, unsigned char *pOutput,  
        int outSize)  
{  
    ASSERT(pOutput != NULL);  
    ASSERT(outSize >= 6);  

    if ( unic <= 0x0000007F )  
    {  
        // * U-00000000 - U-0000007F:  0xxxxxxx  
        *pOutput     = (unic & 0x7F);  
        return 1;  
    }  
    else if ( unic >= 0x00000080 && unic <= 0x000007FF )  
    {  
        // * U-00000080 - U-000007FF:  110xxxxx 10xxxxxx  
        *(pOutput+1) = (unic & 0x3F) | 0x80;  
        *pOutput     = ((unic >> 6) & 0x1F) | 0xC0;  
        return 2;  
    }  
    else if ( unic >= 0x00000800 && unic <= 0x0000FFFF )  
    {  
        // * U-00000800 - U-0000FFFF:  1110xxxx 10xxxxxx 10xxxxxx  
        *(pOutput+2) = (unic & 0x3F) | 0x80;  
        *(pOutput+1) = ((unic >>  6) & 0x3F) | 0x80;  
        *pOutput     = ((unic >> 12) & 0x0F) | 0xE0;  
        return 3;  
    }  
    else if ( unic >= 0x00010000 && unic <= 0x001FFFFF )  
    {  
        // * U-00010000 - U-001FFFFF:  11110xxx 10xxxxxx 10xxxxxx 10xxxxxx  
        *(pOutput+3) = (unic & 0x3F) | 0x80;  
        *(pOutput+2) = ((unic >>  6) & 0x3F) | 0x80;  
        *(pOutput+1) = ((unic >> 12) & 0x3F) | 0x80;  
        *pOutput     = ((unic >> 18) & 0x07) | 0xF0;  
        return 4;  
    }  
    else if ( unic >= 0x00200000 && unic <= 0x03FFFFFF )  
    {  
        // * U-00200000 - U-03FFFFFF:  111110xx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx  
        *(pOutput+4) = (unic & 0x3F) | 0x80;  
        *(pOutput+3) = ((unic >>  6) & 0x3F) | 0x80;  
        *(pOutput+2) = ((unic >> 12) & 0x3F) | 0x80;  
        *(pOutput+1) = ((unic >> 18) & 0x3F) | 0x80;  
        *pOutput     = ((unic >> 24) & 0x03) | 0xF8;  
        return 5;  
    }  
    else if ( unic >= 0x04000000 && unic <= 0x7FFFFFFF )  
    {  
        // * U-04000000 - U-7FFFFFFF:  1111110x 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx  
        *(pOutput+5) = (unic & 0x3F) | 0x80;  
        *(pOutput+4) = ((unic >>  6) & 0x3F) | 0x80;  
        *(pOutput+3) = ((unic >> 12) & 0x3F) | 0x80;  
        *(pOutput+2) = ((unic >> 18) & 0x3F) | 0x80;  
        *(pOutput+1) = ((unic >> 24) & 0x3F) | 0x80;  
        *pOutput     = ((unic >> 30) & 0x01) | 0xFC;  
        return 6;  
    }  

    return 0;  
}  
#endif

static int enc_get_utf8_size(char c)
{
    int count = 0;
    while (c & (1<<7))
    {
        c = c << 1;
        count++;
    }
    return count == 0 ? 1 : count;
}

/***************************************************************************** 
 * 将一个字符的UTF8编码转换成Unicode(UCS-2和UCS-4)编码. 
 * 
 * 参数: 
 *    pInput      指向输入缓冲区, 以UTF-8编码 
 *    pOutput     指向输出缓冲区, 其保存的数据即是Unicode编码值, 
 *    endian      1 - big endian
 *                0 - little endian
 * 
 * 返回值: 
 *    成功则返回该字符的UTF8编码所占用的字节数; 失败则返回0. 
 * 
 * 注意: 
 *     1. UTF8没有字节序问题, 但是Unicode有字节序要求; 
 *        字节序分为大端(Big Endian)和小端(Little Endian)两种; 
 *        在Intel处理器中采用小端法表示, 在此采用小端法表示. (低地址存低位) 
 ****************************************************************************/  
static int enc_utf8_to_unicode_one(const char* pInput, char* pOutput, int endian)
{
    char b1, b2, b3/*, b4, b5, b6*/;
    int utfbytes = enc_get_utf8_size(*pInput);

    switch ( utfbytes )
    {
        case 1:
            if(endian)
            {
                *pOutput++ = 0x00;
                *pOutput = *pInput;
            }
            else
            {
                *pOutput++ = *pInput;
                *pOutput = 0x00;
            }
            return 2;
            //break;
        case 2:
            b1 = *pInput;
            b2 = *(pInput + 1);
            /*+\BUG\wangyuan\2020.11.18\遇到一些特殊字符会返回错误*/
			/*UTF-8二进制形式为 1100xxxx 10xxxxxx
			例如:'·'的  UTF-8编码 11000010 10110111*/
            if ( (b2 & 0xC0) != 0x80 )
            	return -1;
			/*-\BUG\wangyuan\2020.11.18\遇到一些特殊字符会返回错误*/
            if(endian)
            {
                *pOutput++ = (b1 >> 2) & 0x07;
                *pOutput     = (b1 << 6) + (b2 & 0x3F);
            }
            else
            {
                *pOutput++     = (b1 << 6) + (b2 & 0x3F);
                *pOutput = (b1 >> 2) & 0x07;
            }
            return 2;
            //break;
        case 3:
            b1 = *pInput;
            b2 = *(pInput + 1);
            b3 = *(pInput + 2);
            if ( ((b2 & 0xC0) != 0x80) || ((b3 & 0xC0) != 0x80) )
                return -1;
            if(endian)
            {
                *pOutput++ = (b1 << 4) + ((b2 >> 2) & 0x0F);
                *pOutput = (b2 << 6) + (b3 & 0x3F);
            }
            else
            {
                *pOutput++ = (b2 << 6) + (b3 & 0x3F);
                *pOutput = (b1 << 4) + ((b2 >> 2) & 0x0F);
            }
            return 2;
            //break;
#if 0
        case 4:
            b1 = *pInput;
            b2 = *(pInput + 1);
            b3 = *(pInput + 2);
            b4 = *(pInput + 3);
            if ( ((b2 & 0xC0) != 0x80) || ((b3 & 0xC0) != 0x80) 
            || ((b4 & 0xC0) != 0x80) )
                return -1;
            *pOutput     = (b3 << 6) + (b4 & 0x3F);
            *(pOutput+1) = (b2 << 4) + ((b3 >> 2) & 0x0F);
            *(pOutput+2) = ((b1 << 2) & 0x1C)  + ((b2 >> 4) & 0x03);
            return 3;
        break;
        case 5:
            b1 = *pInput;
            b2 = *(pInput + 1);
            b3 = *(pInput + 2);
            b4 = *(pInput + 3);
            b5 = *(pInput + 4);
            if ( ((b2 & 0xC0) != 0x80) || ((b3 & 0xC0) != 0x80) 
            || ((b4 & 0xC0) != 0x80) || ((b5 & 0xC0) != 0x80) )
                return -1;
            *pOutput     = (b4 << 6) + (b5 & 0x3F);
            *(pOutput+1) = (b3 << 4) + ((b4 >> 2) & 0x0F);
            *(pOutput+2) = (b2 << 2) + ((b3 >> 4) & 0x03);
            *(pOutput+3) = (b1 << 6);
            return 4;
        break;
        case 6:
            b1 = *pInput;
            b2 = *(pInput + 1);
            b3 = *(pInput + 2);
            b4 = *(pInput + 3);
            b5 = *(pInput + 4);
            b6 = *(pInput + 5);
            if ( ((b2 & 0xC0) != 0x80) || ((b3 & 0xC0) != 0x80) 
            || ((b4 & 0xC0) != 0x80) || ((b5 & 0xC0) != 0x80) 
            || ((b6 & 0xC0) != 0x80) )
                return -1;
            *pOutput     = (b5 << 6) + (b6 & 0x3F);
            *(pOutput+1) = (b5 << 4) + ((b6 >> 2) & 0x0F);
            *(pOutput+2) = (b3 << 2) + ((b4 >> 4) & 0x03);
            *(pOutput+3) = ((b1 << 6) & 0x40) + (b2 & 0x3F);
            return 4;
        break;
#endif
        default:
        break;
    }

    return -1;
}

static size_t enc_utf8_to_unicode(char **_inbuf, size_t *inbytesleft, char **_outbuf, size_t *outbytesleft, int endian)
{
    size_t maxOLen = *outbytesleft;
    size_t iLen = *inbytesleft;
    char *src = *_inbuf;
    char *dst = *_outbuf;
    size_t iPos, oPos;
    size_t utfbytes = 0;
    size_t unicodeBytes = 0;
    int result = 0;

    for(iPos = 0, oPos = 0; iPos < iLen; )
    {
        if(oPos + 2 > maxOLen)
        {
            errno = E2BIG;
            result = -1;
            goto utf8_to_ucs2_exit;
        }

        utfbytes = enc_get_utf8_size(src[iPos]);

        if(utfbytes == 0)
            utfbytes = 1;

        if((unicodeBytes = enc_utf8_to_unicode_one(&src[iPos], &dst[oPos], endian)) == -1)
        {
            errno = EINVAL;
            result = -1;
            break;
        }

        oPos += unicodeBytes;
        iPos += utfbytes;
    }

utf8_to_ucs2_exit:
    *inbytesleft -= iPos;
    *_inbuf += iPos;
    *outbytesleft -= oPos;

    return (size_t)result;
}

size_t iconv_utf8_to_ucs2(char **_inbuf, size_t *inbytesleft, char **_outbuf, size_t *outbytesleft)
{
    return enc_utf8_to_unicode(_inbuf, inbytesleft, _outbuf, outbytesleft, 0);
}

size_t iconv_utf8_to_ucs2be(char **_inbuf, size_t *inbytesleft, char **_outbuf, size_t *outbytesleft)
{
    return enc_utf8_to_unicode(_inbuf, inbytesleft, _outbuf, outbytesleft, 1);
}


static size_t enc_unicode_to_utf8(char **_inbuf, size_t *inbytesleft, char **_outbuf, size_t *outbytesleft, int endian)
{
    size_t maxOLen = *outbytesleft;
    size_t iLen = *inbytesleft;
    char *src = *_inbuf;
    char *dst = *_outbuf;
    size_t iPos, oPos;
    size_t utfbytes = 0;
    int result = 0;
    size_t unicodeVal = 0;

    for(iPos = 0, oPos = 0; iPos+1 < iLen;)
    {
        unicodeVal = ((endian==1) ? ((unsigned char)src[iPos]*256+(unsigned char)src[iPos+1]) : ((unsigned char)src[iPos+1]*256+(unsigned char)src[iPos]));
        //printf("test1:%d,%X,%X,%X\n",endian,unicodeVal,src[iPos],src[iPos+1]);

    	 if(unicodeVal <= 0x7F)
    	 {
    	     utfbytes = 1;    	 	
    	 }
    	 else if(unicodeVal > 0x7F && unicodeVal <= 0x07FF)
    	 {
    	     utfbytes = 2;
    	 }
    	 else if(unicodeVal > 0x07FF)
    	 {
    	     utfbytes = 3;
    	 }
    	 else
    	 {
    	     errno = EINVAL;
            result = -1;
            goto ucs2_to_utf8_exit;
    	 }

    	 
        if(oPos + utfbytes > maxOLen)
        {
            errno = E2BIG;
            result = -1;
            goto ucs2_to_utf8_exit;
        }

        switch ( utfbytes )
        {
            case 1:
                dst[oPos] = unicodeVal;
                break;

            case 2:
                dst[oPos] = ((unicodeVal>>6)|0xE0)&0xDF;
                dst[oPos+1] = ((char)(unicodeVal&0xFF)|0xC0)&0xBF;
                break;

            case 3: 
                dst[oPos] = (((unicodeVal>>12)&0xFF)|0xF0)&0xEF;
                dst[oPos+1] = (((unicodeVal>>6)&0xFF)|0xC0)&0xBF;
                //printf("test:%X,%X,%X,%X,%X,",unicodeVal,unicodeVal>>6,((unicodeVal>>6)&0xFF),((unicodeVal>>6)&0xFF)|0xC0,dst[oPos+1]);
                dst[oPos+2] =((unicodeVal&0xFF)|0xC0)&0xBF;
                break;

            default:
                break;
        }       

        iPos += 2;
        oPos += utfbytes;
    }

ucs2_to_utf8_exit:
    *inbytesleft -= iPos;
    *_inbuf += iPos;
    *outbytesleft -= oPos;

    return (size_t)result;
}

size_t iconv_ucs2_to_utf8(char **_inbuf, size_t *inbytesleft, char **_outbuf, size_t *outbytesleft)
{
    return enc_unicode_to_utf8(_inbuf, inbytesleft, _outbuf, outbytesleft, 0);
}

size_t iconv_ucs2be_to_utf8(char **_inbuf, size_t *inbytesleft, char **_outbuf, size_t *outbytesleft)
{
    return enc_unicode_to_utf8(_inbuf, inbytesleft, _outbuf, outbytesleft, 1);
}

