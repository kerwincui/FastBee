
#ifndef __YRCP_H_INCLUDED
#define __YRCP_H_INCLUDED 1

typedef unsigned int      yrcpUint;
typedef int               yrcpInt;

#define YRCP_VERSION                 0x10  /* 10 */

#define YRCP_E_OK                    0
#define YRCP_E_ERROR                 (-1)
#define YRCP_E_OUT_OF_MEMORY         (-2)    /*  */
#define YRCP_E_NOT_COMPRESSIBLE      (-3)    /*  */
#define YRCP_E_INPUT_OVERRUN         (-4)
#define YRCP_E_OUTPUT_OVERRUN        (-5)
#define YRCP_E_LOOKBEHIND_OVERRUN    (-6)
#define YRCP_E_EOF_NOT_FOUND         (-7)
#define YRCP_E_INPUT_NOT_CONSUMED    (-8)
#define YRCP_E_NOT_YET_IMPLEMENTED   (-9)    /*  */
#define YRCP_E_INVALID_ARGUMENT      (-10)
#define YRCP_E_INVALID_ALIGNMENT     (-11)   /*  */
#define YRCP_E_OUTPUT_NOT_CONSUMED   (-12)
#define YRCP_E_INTERNAL_ERROR        (-99)

#define YRCP_UCHAR_MAX               0xFF
#define YRCP_CHAR_BIT                8
#define YRCP_MAG_NUMB                0x83828180  /* 0x83828180 */
#define YRCP_MAG_SHORT_NUMB          0x8180      /* 0x8180 */
#define YRCP_COMP_LEN_MAX            49152      /* 49152 */
#define YRCP_COMP_LEN_OFF            0x4000

#define yrcpXint                  yrcpUint
#define yrcpInt16T                short
#define yrcpUint16T               unsigned short
#define yrcpInt32T                int
#define yrcpUint32T               unsigned int
#define yrcpUintPtrT              unsigned int
#define yrcpBytePtr               unsigned char  *
#define yrcpCharPtr               char  *
#define yrcpVoidPtr               void  *
#define yrcpShortPtr              short  *
#define yrcpUshortPtr             unsigned short  *
#define yrcpIntPtr                yrcpInt  *
#define yrcpUintPtr               yrcpUint  *
#define yrcpXintPtr               yrcpXint  *
#define yrcpVoidPPtr              yrcpVoidPtr  *
#define yrcpBytePPtr              yrcpBytePtr  *

#undef assert
#define assert(e) ((void)0)

#define YRCP_INT16_C(c)          (c)
#define YRCP_UINT16_C(c)         (c##U)
#define YRCP_INT32_C(c)          (c)
#define YRCP_UINT32_C(c)         (c##U)

#define YRCP_BYTE(x)         ((unsigned char) (x))

#define YRCP_MAX(a,b)        ((a) >= (b) ? (a) : (b))
#define YRCP_MIN(a,b)        ((a) <= (b) ? (a) : (b))

#define YRCP_SIZE(bits)      (1u << (bits))
#define YRCP_MASK(bits)      (YRCP_SIZE(bits) - 1)

#define YRCP_USIZE(bits)     ((yrcpUint) 1 << (bits))
#define YRCP_UMASK(bits)     (YRCP_USIZE(bits) - 1)

#define YRMULDATA(a,b)       ((yrcpXint) ((a) * (b)))

#define yrcp_memops_TU0p void  *

#define yrcp_memops_TU1p unsigned char  *

typedef yrcpUint16T yrcp_memops_TU2;
#define yrcp_memops_TU2p volatile yrcp_memops_TU2 *

typedef yrcpUint32T yrcp_memops_TU4;
#define yrcp_memops_TU4p volatile yrcp_memops_TU4  *

struct yrcp_memops_TU8_struct { unsigned char a[8]; };
typedef struct yrcp_memops_TU8_struct yrcp_memops_TU8;

#define yrcp_memops_TU8p yrcp_memops_TU8  *

#define yrcp_memops_set_TU1p     volatile yrcp_memops_TU1p

#define yrcp_memops_move_TU1p    yrcp_memops_TU1p

#define YRCP_MEMOPS_SET1(dd,cc) \
    yrcp_memops_set_TU1p data1 = (yrcp_memops_set_TU1p) (yrcp_memops_TU0p) (dd); \
    data1[0] = YRCP_BYTE(cc);

#define YRCP_MEMOPS_SET2(dd,cc) \
    yrcp_memops_set_TU1p data2 = (yrcp_memops_set_TU1p) (yrcp_memops_TU0p) (dd); \
    data2[0] = YRCP_BYTE(cc); data2[1] = YRCP_BYTE(cc);

#define YRCP_MEMOPS_SET3(dd,cc) \
    yrcp_memops_set_TU1p data3 = (yrcp_memops_set_TU1p) (yrcp_memops_TU0p) (dd); \
    data3[0] = YRCP_BYTE(cc); data3[1] = YRCP_BYTE(cc); data3[2] = YRCP_BYTE(cc);

#define YRCP_MEMOPS_SET4(dd,cc) \
    yrcp_memops_set_TU1p data4 = (yrcp_memops_set_TU1p) (yrcp_memops_TU0p) (dd); \
    data4[0] = YRCP_BYTE(cc); data4[1] = YRCP_BYTE(cc); data4[2] = YRCP_BYTE(cc); data4[3] = YRCP_BYTE(cc);


#define YRCP_UA_COPY4(dd,ss)            memcpy((char *)dd, (char *)ss, 4)
#define YRCP_UA_COPY8(dd,ss)            memcpy((char *)dd, (char *)ss, 8)
#define YRCP_UA_COPYN(dd,ss,nn)         memcpy((char *)dd, (char *)ss, nn)

#define YRCP_UA_GET_LE16(ss)            (* (const yrcp_memops_TU2p) (const yrcp_memops_TU0p) (ss))
#define YRCP_UA_GET_LE32(ss)            (* (const yrcp_memops_TU4p) (const yrcp_memops_TU0p) (ss))

#define YRCP_UA_GET_NE16(ss)            (* (const yrcp_memops_TU2p) (const yrcp_memops_TU0p) (ss))
#define YRCP_UA_GET_NE32(ss)            (* (const yrcp_memops_TU4p) (const yrcp_memops_TU0p) (ss))

#define YRSUBDATA(a,b)                  ((yrcpUint) ((a)-(b)))

#define YRCP_DETERMINISTIC 1

#define yrcpDictT            const yrcpBytePtr
#define yrcpDictPtr          yrcpDictT *

#define YRCP_DICT_USE_PTR    0

#define YRCP_NEED_DICT_H     1

#define YRCP_D_BITS          11

#define YRCP_DINDEX(dv,p)        YRCP_DM(((YRMULDATA(0x1824429d,dv)) >> (32-YRCP_D_BITS)))

#define YRCP_M1_MAX_OFFSET   0x0400
#define YRCP_M2_MAX_OFFSET   0x0800
#define YRCP_M3_MAX_OFFSET   0x4000
#define YRCP_M4_MAX_OFFSET   0xbfff

#define YRCP_M1_MIN_LEN      2
#define YRCP_M1_MAX_LEN      2
#define YRCP_M2_MIN_LEN      3
#define YRCP_M2_MAX_LEN      8
#define YRCP_M3_MIN_LEN      3
#define YRCP_M3_MAX_LEN      33
#define YRCP_M4_MIN_LEN      3
#define YRCP_M4_MAX_LEN      9

#define YRCP_M1_MARKER       0
#define YRCP_M2_MARKER       64
#define YRCP_M3_MARKER       32
#define YRCP_M4_MARKER       16

#define YRCP_HASH                  YRCP_HASH_YRCP_INCREMENTAL_B
#define YRCP_DL_MIN_LEN            YRCP_M2_MIN_LEN

#if (YRCP_D_BITS < 16)
    #define YRCP_D_SIZE            YRCP_SIZE(YRCP_D_BITS)
    #define YRCP_D_MASK            YRCP_MASK(YRCP_D_BITS)
#else
    #define YRCP_D_SIZE            YRCP_USIZE(YRCP_D_BITS)
    #define YRCP_D_MASK            YRCP_UMASK(YRCP_D_BITS)
#endif

#define YRCP_D_HIGH                ((YRCP_D_MASK >> 1) + 1)

#define YRCP_DD_BITS               0
#define YRCP_DD_SIZE               YRCP_SIZE(YRCP_DD_BITS)
#define YRCP_DD_MASK               YRCP_MASK(YRCP_DD_BITS)

#define YRCP_DL_BITS               (YRCP_D_BITS - YRCP_DD_BITS)

#define YRCP_DL_SHIFT              ((YRCP_DL_BITS + (YRCP_DL_MIN_LEN - 1)) / YRCP_DL_MIN_LEN)

#define YRCP_HASH_GZIP                    1
#define YRCP_HASH_GZIP_INCREMENTAL        2
#define YRCP_HASH_YRCP_INCREMENTAL_A      3
#define YRCP_HASH_YRCP_INCREMENTAL_B      4

#define YRCP_DTAT_INPUT_LEN_MAX           20

#if (YRCP_DL_BITS < 16)
    #define YRCP_DL_SIZE       YRCP_SIZE(YRCP_DL_BITS)
    #define YRCP_DL_MASK       YRCP_MASK(YRCP_DL_BITS)
#else
    #define YRCP_DL_SIZE       YRCP_USIZE(YRCP_DL_BITS)
    #define YRCP_DL_MASK       YRCP_UMASK(YRCP_DL_BITS)
#endif

#if (YRCP_D_BITS < 6 || YRCP_D_BITS > 18)
    #error "err YRCP_D_BITS"
#endif

#if (YRCP_DL_BITS < 6 || YRCP_DL_BITS > 20)
    #error "err YRCP_DL_BITS"
#endif

#if (YRCP_DD_BITS < 0 || YRCP_DD_BITS > 6)
    #error "err YRCP_DD_BITS"
#endif

#if (YRCP_DL_MIN_LEN == 3)
    #define _DV2_A(p,shift1,shift2)          (((( (yrcpXint)((p)[0]) << shift1) ^ (p)[1]) << shift2) ^ (p)[2])
    #define _DV2_B(p,shift1,shift2)          (((( (yrcpXint)((p)[2]) << shift1) ^ (p)[1]) << shift2) ^ (p)[0])
    #define _DV3_B(p,shift1,shift2,shift3)   ((_DV2_B((p)+1,shift1,shift2) << (shift3)) ^ (p)[0])
#elif (YRCP_DL_MIN_LEN == 2)
    #define _DV2_A(p,shift1,shift2)          (( (yrcpXint)(p[0]) << shift1) ^ p[1])
    #define _DV2_B(p,shift1,shift2)          (( (yrcpXint)(p[1]) << shift1) ^ p[2])
#else
    #error "err YRCP_DL_MIN_LEN"
#endif

#define _DV_A(p,shift)         _DV2_A(p,shift,shift)
#define _DV_B(p,shift)         _DV2_B(p,shift,shift)

#define YRCP_DMS(v,s)          ((yrcpUint) (((v) & (YRCP_D_MASK >> (s))) << (s)))
#define YRCP_DM(v)             YRCP_DMS(v,0)

#if (YRCP_HASH == YRCP_HASH_GZIP)
    #define _DINDEX(dv,p)       (_DV_A((p),YRCP_DL_SHIFT))
#elif (YRCP_HASH == YRCP_HASH_GZIP_INCREMENTAL)
    #define __YRCP_HASH_INCREMENTAL 1
    #define DVAL_FIRST(dv,p)    dv = _DV_A((p),YRCP_DL_SHIFT)
    #define DVAL_NEXT(dv,p)     dv = (((dv) << YRCP_DL_SHIFT) ^ p[2])
    #define _DINDEX(dv,p)       (dv)
    #define DVAL_LOOKAHEAD      YRCP_DL_MIN_LEN
#elif (YRCP_HASH == YRCP_HASH_YRCP_INCREMENTAL_A)
    #define __YRCP_HASH_INCREMENTAL 1
    #define DVAL_FIRST(dv,p)    dv = _DV_A((p),5)
    #define DVAL_NEXT(dv,p)     dv ^= (yrcpXint)(p[-1]) << (2*5); dv = (((dv) << 5) ^ p[2])
    #define _DINDEX(dv,p)       ((YRMULDATA(0x9f5f,dv)) >> 5)
    #define DVAL_LOOKAHEAD      YRCP_DL_MIN_LEN
#elif (YRCP_HASH == YRCP_HASH_YRCP_INCREMENTAL_B)
    #define __YRCP_HASH_INCREMENTAL 1
    #define DVAL_FIRST(dv,p)    dv = _DV_B((p),5)
    #define DVAL_NEXT(dv,p)     dv ^= p[-1]; dv = (((dv) >> 5) ^ ((yrcpXint)(p[2]) << (2*5)))
    #define _DINDEX(dv,p)       ((YRMULDATA(0x9f5f,dv)) >> 5)
    #define DVAL_LOOKAHEAD      YRCP_DL_MIN_LEN
#else
    #error "err choose a hashing strategy"
#endif

#ifndef YRCP_DINDEX
#define YRCP_DINDEX(dv,p)        ((yrcpUint)((_DINDEX(dv,p)) & YRCP_DL_MASK) << YRCP_DD_BITS)
#endif

#if (YRCP_DICT_USE_PTR)
    #define DENTRY(p,in)                          (p)
    #define GINDEX(m_pos,m_off,dict,dindex,in)    (m_pos) = dict[dindex]
#else
    #define DENTRY(p,in)                          (YRSUBDATA(p, in))
    #define GINDEX(m_pos,m_off,dict,dindex,in)    (m_off) = dict[dindex]
#endif

#if (YRCP_DD_BITS == 0)
    #define UPDATE_D(dict,drun,dv,p,in)       dict[ YRCP_DINDEX(dv,p) ] = DENTRY(p,in)
    #define UPDATE_I(dict,drun,index,p,in)    dict[index] = DENTRY(p,in)
    #define UPDATE_P(ptr,drun,p,in)           (ptr)[0] = DENTRY(p,in)
#else
    #define UPDATE_D(dict,drun,dv,p,in)       dict[ YRCP_DINDEX(dv,p) + drun++ ] = DENTRY(p,in); drun &= YRCP_DD_MASK
    #define UPDATE_I(dict,drun,index,p,in)    dict[ (index) + drun++ ] = DENTRY(p,in); drun &= YRCP_DD_MASK
    #define UPDATE_P(ptr,drun,p,in)           (ptr) [ drun++ ] = DENTRY(p,in); drun &= YRCP_DD_MASK
#endif

union yrcpConfigCheckUnion 
{
    yrcpUint array[2];
    unsigned char buf[2*YRCP_MAX(8,sizeof(yrcpUint))];
};

#define yrcp_sizeof_dict_t     ((unsigned)sizeof(yrcpBytePtr))

struct yrcpCallbackT;
typedef struct yrcpCallbackT yrcpCallbackT;

#define yrcp_callback_p yrcpCallbackT  *

typedef yrcpVoidPtr (*yrcpAllocFuncT)  (yrcp_callback_p self, yrcpUint items, yrcpUint size);

typedef void      (*yrcpFreeFuncT)  (yrcp_callback_p self, yrcpVoidPtr ptr);

typedef void (*yrcpProgressFuncT)  (yrcp_callback_p, yrcpUint, yrcpUint, int);

struct yrcpCallbackT
{
    yrcpAllocFuncT nalloc;                /*  */
    yrcpFreeFuncT nfree;                  /*  */
    yrcpProgressFuncT nprogress;
    yrcpVoidPtr user1;
    yrcpXint user2;
    yrcpXint user3;
};

int yellowRabbitInitExecute(unsigned version, int dataSize1, int dataSize2, int dataSize3, int dataSize4, 
                            int dataSize5, int dataSize6, int dataSize7, int dataSize8, int dataSize9);

#define yellowRabbitCompressInit() yellowRabbitInitExecute(YRCP_VERSION,(int)sizeof(short),(int)sizeof(int),\
                                     (int)sizeof(long),(int)sizeof(yrcpUint32T),(int)sizeof(yrcpUint),\
                                     (int)yrcp_sizeof_dict_t,(int)sizeof(char *),(int)sizeof(yrcpVoidPtr),\
                                     (int)sizeof(yrcpCallbackT))


int yellowRabbitCompress(yrcpBytePtr dataIn, yrcpUint dataInLen, yrcpBytePtr dataOut, yrcpUintPtr dataOutLen, yrcpVoidPtr compressCacheMemAddr);

int yellowRabbitDecompress(const yrcpBytePtr in,yrcpUint in_len, yrcpBytePtr out, yrcpUintPtr out_len, yrcpVoidPtr compressCacheMemAddr);



#endif 

