#ifndef __OSA_UTIL_H__
#define __OSA_UTIL_H__

/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017, All rights reserved by AirM2M Ltd.
 File name:      - osautil.h
 Description:    - defined some common functions/structures
 History:        - 2021/02/20, Originated by Jason
 ******************************************************************************
******************************************************************************/
#ifdef WIN32
#include "winsys.h"
#else
#include "commontypedef.h"
#endif

#include "pspdu.h"

/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/

#ifndef OsaBit1Set
/*
 * set bit B to 1 in D
 * example:
 *  OsaBit1Set(0x00, 0) = 0x01
 *  OsaBit1Set(0x01, 4) = 0x11
*/
#define     OsaBit1Set(D, B)    ((D) |= ((UINT32)1<<(B)))
#endif

#ifndef OsaBit0Set
/*
 * set bit B to 0 in D
 * example:
 *  OsaBit1Set(0xFF, 0) = 0xFE
 *  OsaBit1Set(0xFE, 4) = 0xEE
*/
#define     OsaBit0Set(D, B)    ((D) &= (~((UINT32)1<<(B))))
#endif

#ifndef OsaIsBit1
/*
 * whether bit B in D is 1
 * example:
 *  OsaIsBit1(1010 1010, 0) = FALSE
 *  OsaIsBit1(1010 1010, 1) = TRUE
*/
#define     OsaIsBit1(D, B)     ((((D)>>(B))&0x01) == 0x01)
#endif

#ifndef OsaIsBit0
/*
 * whether bit B in D is 0
 * example:
 *  OsaIsBit0(1010 1010, 0) = TRUE
 *  OsaIsBit0(1010 1010, 1) = FALSE
*/
#define     OsaIsBit0(D, B)     ((((D)>>(B))&0x01) == 0x00)
#endif

/*
 * get byte length from bit length
 * example:
 *  OsaBitsByteLen(1)   = 1
 *  OsaBitsByteLen(7)   = 1
 *  OsaBitsByteLen(9)   = 2
*/
#define     OsaBitsByteLen(bits)    (((bits)+7)>>3)

/*
 * Set N bits of D (UINT8) start from S to V,
 *  (D) &= ~((~(0xFFFFFFFF<<(N)))<<(S)); // set N bits to 0
 *  (D) |= (((V)&(~(0xFFFFFFFF<<(N))))<<(S)); // set N bits to V
 * Example
 * OsaSetUint8BitsN(1111 1111, 2, 4, 1010) => 1110 1011
 *                        ^S
 * OsaSetUint8BitsN(0000 0000, 4, 3, 101)  => 0101 0000
 *                     ^S
*/
#define     OsaSetUint8BitsN(D, S, N, V)    ((D) &= ~((~(0xFFFFFFFF<<(N)))<<(S)), (D) |=  (((V)&(~(0xFFFFFFFF<<(N)))) << (S)))

/*
 * Example
 *  OsaGetBitsN(0001 1000, 0, 4) = 0x08
 *                      ^S
 *  OsaGetBitsN(0001 1000, 3, 2) = 0x03
 *                   ^S
*/
#define     OsaGetBitsN(D, S, N)            (((D)>>(S))&(~(0xFFFFFFFF << (N))))


/*
*/
#define     OSA_IE_BUF_STEP_SIZE        128

#define     OSA_IE_BUF_MAX_SIZE         4096

/*
 * Osa4ByteAlignLen(0) = 0
 * Osa4ByteAlignLen(1) = 4
 * Osa4ByteAlignLen(8) = 8
*/
#define Osa4ByteAlignLen(byteLen)    (((byteLen)+3)&0xFFFFFFFC)


/*
 * Single linked list operation MARCO
 * !!!! STRUCT must have "pNext" element !!!
*/
#define OsaSingleLinkAddOne(pHdr, pTailer, pNew)  \
do {                                                \
    if ((pHdr) == PNULL)                            \
    {                                               \
        OsaCheck((pTailer) == PNULL && (pNew) != PNULL && ((pNew)->pNext) == PNULL, (pTailer), ((pNew)->pNext), 0xABCDEF);  \
        (pHdr)  = (pTailer) = (pNew);               \
    }                                               \
    else                                            \
    {                                               \
        OsaCheck((pTailer) != PNULL && (pNew) != PNULL && ((pNew)->pNext) == PNULL, (pTailer), ((pNew)->pNext), 0xFEDCBA);  \
        (pTailer)->pNext    = (pNew);               \
        (pTailer)           = (pNew);               \
    }                                               \
}while(FALSE)

/*
*/
#define OsaSingleLinkAddList(pHdr, pTailer, pNewHdr, pNewTailer)  \
do {                                                \
    if ((pHdr) == PNULL)                            \
    {                                               \
        OsaCheck((pTailer) == PNULL && (pNewHdr) != PNULL && ((pNewTailer)->pNext) == PNULL, (pTailer), ((pNewTailer)->pNext), 0x12345678);  \
        (pHdr)      = (pNewHdr);                    \
        (pTailer)   = (pNewTailer);                 \
    }                                               \
    else                                            \
    {                                               \
        OsaCheck((pTailer) != PNULL && (pNewHdr) != PNULL && ((pNewTailer)->pNext) == PNULL, (pTailer), ((pNewTailer)->pNext), 0x87654321);  \
        (pTailer)->pNext    = (pNewHdr);            \
        (pTailer)           = (pNewTailer);         \
    }                                               \
}while(FALSE)



/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/*
 * Dynamic memory allocated for ASN1 read/decode
*/
typedef struct OsaIeBuffer_Tag
{
    struct OsaIeBuffer_Tag    *pNext;

    /*
     * total allocated size of current memory
    */
    UINT16      totalSize;
    /*
     * free memory address = pStart + freeOffset
    */
    UINT16      freeOffset;

    UINT8       pStart[];
}OsaIeBuffer;         // 8 bytes

typedef struct OsaIeMemInfo_Tag
{
    OsaIeBuffer     *pBufHdr;
}OsaIeMemInfo;


/******************************************************************************
 *****************************************************************************
 * FUNC
 *****************************************************************************
******************************************************************************/

/******************************************************************************
 * OsaBit1Search
 * Description: From LSB(right/low) to MSB (left/high), to find the first postion
 *              of bit 1
 * input: UINT32 data
 * output: UINT8 //if not found, return 0xFF
 * Comment:
 * example: 10100100 00001000 10101111 11000000, return 6
 *          0x00000000 return 0xFF
 *          0xFFFFFFFF return 0
******************************************************************************/
UINT8 OsaBit1Search(UINT32 data);

/******************************************************************************
 * OsaBit0Search
 * Description: From LSB(right/low) to MSB (left/high), to find the first postion
 *              of bit 0
 * input: UINT32 data
 * output: UINT8 //if not found, return 0xFF
 * Comment:
 * example: 1010 1011, return 2
 *          0000 0000, return 0
 *          0xFFFFFFFF, return 0xFF
******************************************************************************/
UINT8 OsaBit0Search(UINT32 data);


/******************************************************************************
 * OsaBeZeroMemory
 * Description: Whether all memory are set to zero
 * input:
 * output: UINT32   // 0 - not all zero, 1 - all zero
 *
******************************************************************************/
UINT32 OsaBeZeroMemory(const void *pMem, UINT32 size);



/******************************************************************************
 * OsaIeMemInit
 * Description: init PS IE (information element) memory info
 * input:  OsaIeMemInfo     *pIeMemInfo     //IE memory info
 *         UINT16           estIeSize       //estimate IE structure size
 *         void             **ppRootIebuf   //output, return root IE buffer
 * output: void
 * Comment:
******************************************************************************/
void OsaIeMemInit(OsaIeMemInfo *pIeMemInfo, UINT16 estIeSize, void **ppRootIebuf);


/******************************************************************************
 * OsaIeMemAllocate
 * Description: Allocate memory from IE memory
 * input:  OsaIeMemInfo     *pIeMemInfo     //IE memory info
 *         UINT16           wantSize        //want size
 * output: void
 * Comment:
******************************************************************************/
void* OsaIeMemAllocate(OsaIeMemInfo *pIeMemInfo, UINT16 wantSize);

/******************************************************************************
 * OsaIeMemDestroy
 * Description: destroy/free all IE memory
 * input:  OsaIeMemInfo     *pIeMemInfo     //IE memory info
 * output: void
 * Comment:
******************************************************************************/
void OsaIeMemDestroy(OsaIeMemInfo *pIeMemInfo);

/******************************************************************************
 * OsaSetBufBitsValue
 * Description: Set "bitLen" (MAX 32 bits) bits value in "pBuf" start from "bitOffset", to "value"
 * input: UINT8 *pBuf;
 *        UINT32 *startBitOffset //IN & OUT put, output = *startBitOffset + bitsLen
 *        UINT8 bitsLen
 *        UINT32 value
 * output: void
 * Comment:
******************************************************************************/
void OsaSetBufBitsValue(UINT8 *pBuf, UINT32 *startBitOffset, UINT8 bitsLen, UINT32 value);

/******************************************************************************
 * OsaGetBufBitsValue
 * Description: Get "bitLen" (MAX 32 bits) bits value from "pBuf" start from "bitOffset"
 * input: UINT8 *pBuf;
 *        UINT32 *startBitOffset //IN & OUT put, output = *startBitOffset + bitsLen
 *        UINT8 bitsLen
 * output: UINT32
 * Comment:
******************************************************************************/
UINT32 OsaGetBufBitsValue(const UINT8 *pBuf, UINT32 *startBitOffset, UINT8 bitsLen);

/*
 * Alloc one "DlPduBlock" from heap, if failed, return PNULL
*/
DlPduBlock* OsaAllocDlPduBlock(UINT32 len);

/*
 * Free one DL PDU block
*/
void OsaFreeOneDlPduBlock(DlPduBlock **pDlPduBlk);

/*
 * Free DL PDU list
*/
void OsaFreeDlPduBlockList(DlPduBlock **pDlPduBlk);

/*
 * Free one UL PDU block
*/
void OsaFreeOneUlPduBlock(UlPduBlock **pUlPduBlk);

/*
 * Free UL PDU list
*/
void OsaFreeUlPduBlockList(UlPduBlock **pUlPduBlk);

#endif

