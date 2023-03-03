/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include <stdint.h>
#include <string.h>

/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/
#define UNALIGNED(x)  ((uint32_t)x & 0x3)
#define DETECTNULL(x) (((x) - 0x01010101) & ~(x) & 0x80808080)

/*----------------------------------------------------------------------------*
 *                      GLOBAL FUNCTIONS                                      *
 *----------------------------------------------------------------------------*/

/*
 *  Reference: https://github.com/eblot/newlib/blob/master/newlib/libc/string/strlen.c
 */
int32_t strlen_fast(const char *str)
{
    const char *start = str;

    uint32_t* aligned_addr;

    while(UNALIGNED(str))
    {
        if(!*str)
        {
            return str - start;
        }
        str++;
    }

    aligned_addr = (uint32_t*)str;

    while(!DETECTNULL(*aligned_addr))
    {
        aligned_addr++;
    }

    str = (char *)aligned_addr;

    while(*str)
    {
        str++;
    }

    return str - start;
}

/*
 *  Reference: http://src.gnu-darwin.org/src/lib/libc/string/strnstr.c.html
 */
char* ec_strnstr(const char *s, const char *find, size_t slen)
{
    char c, sc;
    size_t len;

    if((c = *find++) != '\0')
    {
        len = strlen(find);

        do
        {
            do
            {
                if((sc = *s++) == '\0' || slen-- < 1)
                    return NULL;
            } while(sc != c);

            if(len > slen)
                return NULL;

        } while(strncmp(s, find, len) != 0);

        s--;
    }

    return (char*)s;
}
