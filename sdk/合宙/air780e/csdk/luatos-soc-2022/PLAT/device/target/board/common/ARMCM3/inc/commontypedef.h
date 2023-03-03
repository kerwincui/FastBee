
/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    CommonTypedef.h
 * Description:  Common type define file
 * History:      08/23/2017    Originated by Yunfei Li
 *
 ****************************************************************************/

#ifndef _COMMON_TYPEDEF_H
#define _COMMON_TYPEDEF_H

#ifndef PHY_PC_SIM
#include "cmsis_compiler.h"
#else
#define __FORCEINLINE            __inline
typedef unsigned long            uint32_t;

#endif

//#define PUBLIC_CMCC_EDRX_DEBUG        1

/*****************************************************************************
                                    armcc definition

char                    8           1 (byte-aligned)                0 to 255 (unsigned) by default.
                                                                    C128 to 127 (signed) when compiled with
                                                                    --signed_chars.
signed char             8           1 (byte-aligned)                每128 to 127
unsigned char           8           1 (byte-aligned)                0 to 255
(signed) short          16          2 (halfword-aligned)            每32,768 to 32,767
unsigned short          16          2 (halfword-aligned)             0 to 65,535
(signed) int            32          4 (word-aligned)                每2,147,483,648 to 2,147,483,647
unsigned int            32          4 (word-aligned)                0 to 4,294,967,295
(signed) long           32          4 (word-aligned)                每2,147,483,648 to 2,147,483,647
unsigned long           32          4 (word-aligned)                0 to 4,294,967,295
(signed) long long      64          8 (doubleword-aligned)          每9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
unsigned long long      64          8 (doubleword-aligned)          0 to 18,446,744,073,709,551,615
float                   32          4 (word-aligned)                1.175494351e-38 to 3.40282347e+38 (normalized values)
double                  64          8 (doubleword-aligned)          2.22507385850720138e-308 to 1.79769313486231571e
                                                                    +308 (normalized values)
long double             64          8 (doubleword-aligned)          2.22507385850720138e-308 to 1.79769313486231571e
                                                                    +308 (normalized values)
wchar_t                 16          2 (halfword-aligned)            0 to 65,535 by default.
                        32          4 (word-aligned)                0 to 4,294,967,295 when compiled with --wchar32.
                                        
All pointers            32          4 (word-aligned)                Not applicable.
bool (C++ only)         8           1 (byte-aligned)                false or true
_Bool (C only)          8           1 (byte-aligned)                false or true
*****************************************************************************/

//#define VC_VERSION  /* defined for windows, if undefined, unix or linux */

#ifndef VC_VERSION
typedef signed char             INT8;
typedef unsigned char           UINT8;

typedef signed short            INT16;
typedef unsigned short          UINT16;

typedef signed long             INT32;
typedef unsigned long           UINT32;

typedef long long               INT64;
typedef unsigned long long      UINT64;

#if (!defined PHY_PC_SIM)||(!defined PHY_PC_UNILOG) 
typedef unsigned char           BOOL;
#else
#define BOOL                    UINT8
#endif

typedef char                    CHAR;
#else
typedef signed char             INT8;
typedef unsigned char           UINT8;

typedef signed short            INT16;
typedef unsigned short          UINT16;

typedef signed long             INT32;
typedef unsigned long           UINT32;

typedef __int64                 INT64;
typedef unsigned __int64        UINT64;

typedef unsigned char           BOOL;
typedef char                    CHAR;
#endif //#ifndef VC_VERSION

typedef void ( *PhyCBFunc_T )(void* sigBody);

typedef struct
{
    INT32 integer;
    INT32 fwl;
} DCXODouble;


#ifndef  FALSE
#define FALSE                   ((BOOL)0)
#endif

#ifndef  TRUE
#define TRUE                    ((BOOL)1)
#endif


#ifndef NULL
#define NULL                    0 
#endif

#ifndef PNULL
#define PNULL                   ((void*) NULL)
#endif

#ifndef PPNULL
#define PPNULL                   ((void*)((void*) NULL))
#endif

#endif //#ifndef _COMMON_TYPEDEF_H

