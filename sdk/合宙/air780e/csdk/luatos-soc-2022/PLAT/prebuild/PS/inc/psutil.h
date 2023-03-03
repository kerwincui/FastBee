#ifndef __PS_UTIL_H__
#define __PS_UTIL_H__
/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017- Copyrights of AirM2M Ltd.
 File name:      - psutil.h
 Description:    - Protocol Stack COMMON utility, just defined some common
                   functions/structures which is common for all PS tasks
 History:        - 14/09/2020, Originated by Jason
 ******************************************************************************
******************************************************************************/

#include "pssys.h"
#include "pscommtype.h"
#include "pspdu.h"
#include "nascommon.h"

#define CHECK_EBI_VALID(ebi)    (((ebi) >= EBI_5) && ((ebi) <= EBI_15))
#define CHECK_CID_VALID(cid)    (((UINT32)(cid)) <= 15)


/*
 * UL PKG default (LT) life time
*/
#define PS_UL_PKG_DEFAULT_LIFE_TIME_SEC     20

/*
 * MAX UL PKG pending PKG size
*/
#define PS_NB_UL_MAX_PENDING_PKG_SIZE       4500    //3*1500

/*
 * MAX UL PKG pending PKG number
*/
#define PS_NB_UL_MAX_PENDING_PKG_NUM        10

/*
 * MAX UL PKG pending PKG size used for CAT1 mode
 * Here, we suggest service request procedure cost 50ms, and UL TPT is 5.12 Mbps
 *  So pending PKG size = 50*5120/8 = 32KB
*/
#define PS_UL_MAX_PENDING_PKG_SIZE          32000

/*
 * MAX UL PKG pending PKG number, 32000/1500 ~= 22, here set to 32
*/
#define PS_UL_MAX_PENDING_PKG_NUM           32


/*
 * Invalid band indicator, band range (1..70) ref to 36.101, Table 5.7.3-1
*/
#define PS_INVALID_BAND                     0


/*
 * set bit B to 1 in D
 * example:
 *  Bit1Set(0x00, 0) = 0x01
 *  Bit1Set(0x01, 4) = 0x11
*/
#define Bit1Set(D, B)   ((D) |= ((UINT32)1<<(B)))

/*
 * set bit B to 0 in D
 * example:
 *  Bit0Set(0xFF, 0) = 0xFE
 *  Bit0Set(0xFE, 4) = 0xEE
*/
#define Bit0Set(D, B)   ((D) &= (~((UINT32)1<<(B))))


/*
 * whether bit B in D is 1
 * example:
 *  IsBit1(1010 1010, 0) = FALSE
 *  IsBit1(1010 1010, 1) = TRUE
*/
#define IsBit1(D, B)    ((((D)>>(B))&0x01) == 0x01)

/*
 * whether bit B in D is 0
 * example:
 *  IsBit0(1010 1010, 0) = TRUE
 *  IsBit0(1010 1010, 1) = FALSE
*/
#define IsBit0(D, B)    ((((D)>>(B))&0x01) == 0x00)

/*
 * Get bit N value
 * example:
 *  GetBitN(1010 1010, 0) = 0
 *  GetBitN(1010 1010, 1) = 1
*/
#define GetBitN(D, B)   (((D)>>(B))&0x01)

/*
 * Get N bits value, start from S,
 * example:
 *  GetBitsN(0x18, 0, 4) = 0x08
 *  GetBitsN(0x18, 3, 2) = 0x03
*/
#define GetBitsN(D, S, N)   (((D)>>(S))&(~(0xFFFFFFFF << (N))))

/*
 * Set N bits of D (UINT8) start from S to V,
 *  (D) &= ~((~(0xFFFFFFFF<<(N)))<<(S)); // set N bits to 0
 *  (D) |= (((V)&(~(0xFFFFFFFF<<(N))))<<(S)); // set N bits to V
 * example:
 *  SetUint8BitsN(1111 1111, 2, 4, 1010) => 1110 1011
 *  SetUint8BitsN(0000 0000, 4, 3, 101)  => 0101 0000
*/
#define SetUint8BitsN(D, S, N, V)   ((D) &= ~((~(0xFFFFFFFF<<(N)))<<(S)), (D) |= (((V)&(~(0xFFFFFFFF<<(N))))<<(S)))

/*
 * GET bytes number from bits number
 * example: GetBitsByteLen(3) = 1
 *          GetBitsByteLen(8) = 1
 *          GetBitsByteLen(10) = 2
*/
//#define GetBitsByteLen(bits)    (((bits)&0x07) == 0 ? ((bits)>>3) : (((bits)>>3)+1))
#define GetBitsByteLen(bitlen)  (((bitlen)+7)>>3)

/*
 * GetBitLen(1) = 8
 * GetBitLen(2) = 16
*/
#define GetBitLen(byteLen)      ((byteLen)<<3)

/*
 * Get4ByteAlignLen(0) = 0
 * Get4ByteAlignLen(1) = 4
 * Get4ByteAlignLen(8) = 8
*/
#define Get4ByteAlignLen(byteLen)   (((byteLen)+3)&0xFFFFFFFC)

/*
 * IsByteAligned(8)     = TRUE
 * IsByteAligned(13)    = FALSE
 * IsByteAligned(16)    = TRUE
*/
#define IsByteAligned(bitLen)         (((bitLen)&0x07) == 0)


/*
 * SHA-256 functions
*/
/* The right shift operation */
#define SHR(x, n)   ((x) >> (n))
/* The rotate right (circular right shift) operation */
#define ROTR(x, n)  (((x) >> (n)) | ((x) << (32 - (n))))
#define Ch(x, y, z)     (((x) & (y)) ^ (~(x) & (z)))
#define Maj(x, y, z)    (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
#define SIGMA0(x)       (ROTR((x), 2)  ^ ROTR((x), 13) ^ ROTR((x), 22))
#define SIGMA1(x)       (ROTR((x), 6)  ^ ROTR((x), 11) ^ ROTR((x), 25))
#define sigma0(x)       (ROTR((x), 7)  ^ ROTR((x), 18) ^ (SHR((x), 3)))
#define sigma1(x)       (ROTR((x), 17) ^ ROTR((x), 19) ^ (SHR((x), 10)))


#ifdef WIN32
void PsFreeOneDlPduBlock(DlPduBlock **pDlPduBlk);      //specification
#else
#define PsFreeOneDlPduBlock(ppDlPduBlk)     OsaFreeOneDlPduBlock((ppDlPduBlk))
#endif

#ifdef WIN32
void PsFreeDlPduBlockList(DlPduBlock **pDlPduBlk);      //specification
#else
#define PsFreeDlPduBlockList(ppDlPduBlk)    OsaFreeDlPduBlockList((ppDlPduBlk))
#endif


#ifdef WIN32
void PsFreeOneUlPduBlock(UlPduBlock **pUlPduBlk);      //specification
#else
#define PsFreeOneUlPduBlock(ppUlPduBlk)    OsaFreeOneUlPduBlock((ppUlPduBlk))
#endif

#ifdef WIN32
void PsFreeUlPduBlockList(UlPduBlock **pUlPduBlk);      //specification
#else
#define PsFreeUlPduBlockList(ppUlPduBlk)    OsaFreeUlPduBlockList((ppUlPduBlk))
#endif

/*
 * Free the "UlPduBlock" list
 *  void PsFreeDataPduList(UlPduBlock **pPdu);
*/
#ifdef WIN32
#define PsFreeDataPduList(ppUlPduBlk)       PsFreeUlPduBlockList((ppUlPduBlk))
#else
#define PsFreeDataPduList(ppUlPduBlk)       OsaFreeUlPduBlockList((ppUlPduBlk))
#endif


/*
 * Single linked list operation MARCO
 * !!!! STRUCT must have "pNext" element !!!
*/
#define PsSingleLinkAddOne(pHdr, pTailer, pNew)  \
do {                                                \
    if ((pHdr) == PNULL)                            \
    {                                               \
        GosCheck((pTailer) == PNULL && (pNew) != PNULL && ((pNew)->pNext) == PNULL, (pTailer), ((pNew)->pNext), 0xABCDEF);  \
        (pHdr)  = (pTailer) = (pNew);               \
    }                                               \
    else                                            \
    {                                               \
        GosCheck((pTailer) != PNULL && (pNew) != PNULL && ((pNew)->pNext) == PNULL, (pTailer), ((pNew)->pNext), 0xFEDCBA);  \
        (pTailer)->pNext    = (pNew);               \
        (pTailer)           = (pNew);               \
    }                                               \
}while(FALSE)

/*
*/
#define PsSingleLinkAddList(pHdr, pTailer, pNewHdr, pNewTailer)  \
do {                                                \
    if ((pHdr) == PNULL)                            \
    {                                               \
        GosCheck((pTailer) == PNULL && (pNewHdr) != PNULL && ((pNewTailer)->pNext) == PNULL, (pTailer), ((pNewTailer)->pNext), 0x12345678);  \
        (pHdr)      = (pNewHdr);                    \
        (pTailer)   = (pNewTailer);                 \
    }                                               \
    else                                            \
    {                                               \
        GosCheck((pTailer) != PNULL && (pNewHdr) != PNULL && ((pNewTailer)->pNext) == PNULL, (pTailer), ((pNewTailer)->pNext), 0x87654321);  \
        (pTailer)->pNext    = (pNewHdr);            \
        (pTailer)           = (pNewTailer);         \
    }                                               \
}while(FALSE)



#define SET_UINT32_DATA_LEFT_SHIFT(n,b,i)             \
{                                                     \
    (n) = ( (UINT32) (b)[(i)    ]       )             \
        | ( (UINT32) (b)[(i) + 1] <<  8 )             \
        | ( (UINT32) (b)[(i) + 2] << 16 )             \
        | ( (UINT32) (b)[(i) + 3] << 24 );            \
}

#define SET_UINT32_DATA_RIGHT_SHIFT(n,b,i)            \
{                                                     \
    (b)[(i)    ] = (UINT8) (((n)       ) & 0xFF );    \
    (b)[(i) + 1] = (UINT8) (((n) >>  8 ) & 0xFF );   \
    (b)[(i) + 2] = (UINT8) (((n) >> 16 ) & 0xFF );   \
    (b)[(i) + 3] = (UINT8) (((n) >> 24 ) & 0xFF );   \
}



typedef enum PS_CHAP_AUTH_CODE_TYPE_Tag
{
    CHAP_MSG_CODE_TYPE_CHALLENGE = 1,
    CHAP_MSG_CODE_TYPE_RESPONSE  = 2,
    CHAP_MSG_CODE_TYPE_SUCCESS   = 3,
    CHAP_MSG_CODE_TYPE_FAILURE   = 4,
}PS_CHAP_AUTH_CODE_TYPE;



/******************************************************************************
 *****************************************************************************
 * Functions specification
 *****************************************************************************
******************************************************************************/

UINT8 Uint8Bit1Search(UINT8 data);
UINT8 Uint16Bit1Search(UINT16 data);
UINT8 Uint32Bit1Search(UINT32 data);
UINT8 UintBit1Search(UINT32 data);

UINT8 Uint4Bit0Search(UINT8 data);
UINT8 Uint8Bit0Search(UINT8 data);
UINT8 Uint16Bit0Search(UINT16 data);
UINT8 Uint32Bit0Search(UINT32 data);
UINT8 UintBit0Search(UINT32 data);

#ifdef WIN32
/*
 * set bits value (1-32 bits) ina UINT8 pBuf
*/
void SetBufBitsValue(UINT8 *pBuf, UINT32 *startBitOffset, UINT8 bitsLen, UINT32 value);

/*
 * Get "bitLen" (MAX 32 bits) bits value from "pBuf" start from "bitOffset"
*/
UINT32 GetBufBitsValue(const UINT8 *pBuf, UINT32 *startBitOffset, UINT8 bitsLen);

/*
 * Whether memory is all set to zero, 1 - TRUE, 0 - FALSE
*/
UINT32 BeZeroMemory(const void *pMem, UINT32 size);

#else

#define SetBufBitsValue(pBuf, startBitOffset, bitsLen, value)   \
    OsaSetBufBitsValue((pBuf), (startBitOffset), (bitsLen), (value))

#define GetBufBitsValue(pBuf, startBitOffset, bitsLen)          \
    OsaGetBufBitsValue((pBuf), (startBitOffset), (bitsLen))

#define BeZeroMemory(pMem, size)        \
    OsaBeZeroMemory((pMem), (size))
#endif




/*
 * BITS COPY
*/
void PsBitsCopy(UINT8 *pDestBuf, UINT16 *pDestBO, UINT8 *pSrcBuf, UINT16 ibo, UINT16 bitLen);

/*
 * get PLMN info from IMSI
*/
Plmn PsGetPlmnFromImsi(Imsi *pImsi);

void HmacSha256(UINT16 inputKeyLength, UINT8 *pInputKey, UINT32 messageLength, UINT8 *pMessageContent, UINT8 *outPut);

/*
 * Free the Data memory, which type is : UlPduMemType
*/
void PsFreeDataPduMem(UINT8 memType, UINT8 **ptr);



/*
 * Free the "PacketFilterList" list
*/
void PsFreePacketFilterlist(PacketFilterList** pflist);

/*
 * Copy the "PacketFilterList" list
*/
void PsCopyTftList(const PacketFilterList *pSrcTftHdr, PacketFilterList **ppDestTftHdr);

/*
 * get next UL Pkg header in the list
*/
UlPduBlock* PsGetNextUlPkgHdr(UlPduBlock *pPdu);

/*
 * check whether the UL PKG(DATA) is out of date
*/
BOOL PsUlDataBeOutDate(UINT8 tickType, UINT32 sysTick, BOOL *bMustDiscard);

/*
 * Get the PDU pkg number, and valid total length in UL PDU list
*/
void PsGetUlPduNumAndLenInList(const UlPduBlock *pHdr, const UlPduBlock *pTailer, UINT32 *pPduNum, UINT32 *pPduLen);

/*
 * Clear the UL pending PKG list
 *  check whether out of date, or pending pkg number/size overflow
*/
//UINT32 PsClearUlPendingPduList(UlPduBlock **pHdr, UlPduBlock **pTailer);

/*
 * Clear the UL pending PKG list
 *  check whether out of date, or pending pkg number/size overflow
*/
void PsClearUlPendingPduList(UlPduBlock  **pHdr,
                             UlPduBlock  **pTailer,
                             UINT32      *pOutPkgNum,
                             UINT32      *pOutPkgLen);

/*
 * TFT route, decide which bearer (return CID) carry this UL PKG
*/
UINT8 PsTftRouteUlPkg(UINT8 defaultIpv4Cid, UINT8 defaultIpv6Cid, const PacketFilterList *pfList, const UlPduBlock *pPdu);

/*
 * APN format convert
*/
void ConvertDisPlayApnToNetworkFormat(const UINT8 *srcApn, UINT8 srcApnLen, UINT8 *desApn, UINT8 *desApnLen);
void ConvertNetworkApnToDisPlayFormat(const UINT8 *srcApn, UINT8 srcApnLen, UINT8 *desApn, UINT8 *desApnLen);

/*
 * Convert DL EARFCN to BAND
*/
UINT8 PsGetBandFromDlEarfcn(UINT32 dlEarfcn);

/*
 * Check overseas operator
*/
BOOL PsIsOverseasOperator(Plmn plmn);

/*
 * Encode GSM 7Bit
*/
UINT16 PsEncodeGsm7BitData(UINT8 *pInput, UINT16 inputLength, UINT8 *pOutput, UINT16 outputLength, UINT16 shiftBits);

/*
 * Decode GSM 7Bit
*/
UINT16 PsDecodeGsm7BitData(UINT8 *pInput, UINT16 inputLength, UINT8 *pOutput, UINT16 outputLength, UINT16 shiftBits);

/*Generate a defined length random */
UINT16 PsGenRandom(UINT16 outPutLen,UINT8 *pOutPut);


/* to generate a CHAP authenticaion response with MD5 hash  */
void PsGenChapMd5HashResponse(
         const  UINT8   *identifier,
         const  UINT8   *pSecretVal,
         const  UINT16   secretLen,
         const  UINT8   *pChallenge,
         const  UINT16   challengeLen,
         UINT8    outPut[16]);

#endif

