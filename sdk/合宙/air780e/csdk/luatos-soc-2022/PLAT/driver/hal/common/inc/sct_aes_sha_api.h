#ifndef __SCT_AES_SHA_API_H__
#define __SCT_AES_SHA_API_H__

/******************************************************************************
 ******************************************************************************
  Copy right:   2017-, Copyrigths of AirM2M Ltd.
  File name:    sct_aes_sha_api.h
  Description:  SCT AES/SHA API, external, and provide to app
  History:      2020/12/02    Originated by Jason
 ******************************************************************************
******************************************************************************/
#include "osasys.h"


/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/




/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

typedef enum
{
    SCT_AES_SHA_RET_OK  = 0,
    SCT_AES_SHA_ERROR   = -1,
    SCT_AES_SHA_BUSY    = -2
}SctAesShaRetEnum;

typedef INT32   SctAesShaRet;


/*
 * AES mode, same enum as: DescAESMode
*/
typedef enum
{
    SCT_AES_ECB         = 0,
    SCT_AES_CBC         = 1,
    SCT_AES_CTR         = 2
}SctAESMode;

/*
 * AES PAD MODE, same enum as: DescAESPadMode
*/
typedef enum
{
    /*
     0 - No Padding, should: dataLen%16 == 0
     1 - PKCS7, paddingLen = 16 每 dataLen%16, paddingValue = k
     2 每 PaddingOneZeros (ISO/IEC 7816-4), paddingLen = 16 每 dataLen%16, paddingValue = 0x80,0x00,＃..0x00
     3 - PaddingZerosLen (ANSI X.923), paddingLen = 16 每 dataLen%16, paddingValue = 0x00,0x00,＃..k
     4 - PaddingZeros, paddingLen = 16 每 dataLen%16, paddingValue = 0x00,0x00,＃..0x00
    */
    SCT_AES_NO_PAD          = 0,
    SCT_AES_PKCS7_PAD       = 1,
    SCT_AES_ONE_ZEROS_PAD   = 2,
    SCT_AES_ZERO_LEN_PAD    = 3,
    SCT_AES_ZERO_PAD        = 4
}SctAESPadMode;


/*
 * AES Key source, same enum as: DescAESKeySelect
*/
typedef enum
{
    SCT_AES_CK_FROM_ADDR    = 0,
    SCT_AES_CK_FROM_EFUSE   = 1
}SctAESKeySelect;

/*
 * AES CK len, same enum as: DescAESCKLen
*/
typedef enum
{
    /* If key is from flash, only support length: 128/192 */
    SCT_AES_CK_LEN_128      = 0,
    SCT_AES_CK_LEN_192      = 1,
    SCT_AES_CK_LEN_256      = 2
}SctAESCKLen;

/*
 * AES DIR
 *  AESDIR is useless (default set to 0) for CTR (2) AES mode
*/
typedef enum
{
    SCT_AES_ENC_DIR     = 0,    /* Encryption */
    SCT_AES_DEC_DIR     = 1     /* Decryption */
}SctAESDir;

/*
 * endian
*/
typedef enum
{
    SCT_LITTLE_ENDIAN   = 0,
    SCT_BIG_ENDIAN      = 1
}SctEndianType;

/*
 * SHA MODE, same enum as: DescSHAMode
*/
typedef enum
{
    SCT_SHA_1           = 0,        /* SHA output: 20 bytes */
    SCT_SHA_224         = 1,        /* SHA output: 28 bytes */
    SCT_SHA_256         = 2         /* SHA output: 32 bytes */
}SctSHAMode;



/*
 * SCT AES cipher request
*/
typedef struct
{
    UINT32      inputByteLen    : 16;       /* AES input data length */

    UINT32      aesMode         : 2;        /* SctAESMode: ECB/CBC/CTR */
    UINT32      aesPadMode      : 3;        /* SctAESPadMode, For CTR mode, useless, set to 0 */
    UINT32      ckSelect        : 1;        /* SctAESKeySelect, CK select from: "ckAddr", or from eFUSE */
    UINT32      ckLen           : 2;        /* SctAESCKLen: 128/192/256, if CK select from eFUSE, only support: 128/192 */

    UINT32      dir             : 1;        /* SctAESDir, Encryption/Decryption. For CTR mode, useless, set to 0 */
    UINT32      ckBLEndian      : 1;        /* SctEndianType, if not certain/known, suggest big endian: DESC_BIG_ENDIAN */
    UINT32      ivBLEndian      : 1;        /* SctEndianType, if not certain/known, suggest big endian: DESC_BIG_ENDIAN */
    UINT32                      : 5;

    UINT8       *pInput;                    /* Input */
    UINT8       *pOutput;                   /* Output */

    UINT8       *pCkAddr;                   /* Ignore it, if key select from eFUSE. and must 4 bytes aligned */
    UINT8       *pIvAddr;                   /* initial vector,
                                             * Note:
                                             * a) for CBC(AESMode = 1) mode, initial vector address
                                             * b) for CTR(AESMode = 2) mode, initial counter address,
                                             * c) Must 4 bytes aligned, and total 16 bytes
                                            */
}SctAesReq;     //20 bytes


/******************************************************************************
 *****************************************************************************
 * Functions
 *****************************************************************************
******************************************************************************/

/*****************************************************************************
 * Two types of SHA API
 * 1> SHA segment API, which SHA input datas could be divided serveral segments
 *
 * 2> SHA whole API, all SHA datas input once.
*****************************************************************************/

/*******
 * 1> SHA segment API
*******/
/*
 * SHA start
*/
/******************************************************************************
 * SctShaSegStart
 * Description: SHA segment API, which SHA input datas could be divided serveral segments,
 *              SHA start and lock the SCT HW, before SHA done (called by SctShaSegEnd()),
 *              SHA HW can't used by other modules
 * input: SctSHAMode shaMode        //SHA mode
 *        const UINT8 *shaHdr       //SHA header, which also need to calc SHA before input data, if none, input PNULL
 *        UINT16 shaHdrByteLen      //SHA header byte length
 * output: SctShaRet
 * Note: "pShaHdr" should be freed in caller, after "SctShaSegEnd()" called
******************************************************************************/
SctAesShaRet    SctShaSegStart(SctSHAMode shaMode, const UINT8 *pShaHdr, UINT16 shaHdrByteLen);

/******************************************************************************
 * SctShaAppendSeg
 * Description: SHA segment API, calc SHA
 * input: SctSHAMode shaMode        //SHA mode
 *        const UINT8 *pInput       //SHA input source data
 *        UINT16 inputLen           //SHA input source data length
 * output: SctShaRet
******************************************************************************/
SctAesShaRet    SctShaAppendSeg(SctSHAMode shaMode, const UINT8 *pInput, UINT16 inputLen);

/******************************************************************************
 * SctShaSegEnd
 * Description: SHA segment API, end SHA calc
 * input: SctSHAMode shaMode        //SHA mode
 *        SctEndianType outBLType   //output, big/little endian, if not known, suggest BIG endian
 *        UINT8 shaOutput[32]       //output, SHA value
 * output: SctShaRet
******************************************************************************/
SctAesShaRet    SctShaSegEnd(SctSHAMode shaMode, SctEndianType outBLType, UINT8 shaOutput[32]);


/********
 * 2. SHA whole API, all SHA datas input once.
********/
/******************************************************************************
 * SctShaCalc
 * Description: SHA whole API, all SHA datas input once
 * input: SctSHAMode    shaMode     //SHA mode
 *        const UINT8   *pInput     //pInput data
 *        UINT16        inputLen    //input data length in byte
 *        const UINT8   *pShaHdr    //SHA header, which also need to calc SHA before input data, if none, input PNULL
 *        UINT16        shaHdrByteLen   //SHA header length in byte
 *        SctEndianType outBLType  //big/little endian, if not known, suggest BIG endian
 *        UINT8         shaOutput[32]   //output, SHA value
 * output: SctShaRet
******************************************************************************/
SctAesShaRet    SctShaCalc(SctSHAMode   shaMode,
                           UINT8        *pInput,
                           UINT16       inByteLen,
                           UINT8        *pShaHdr,
                           UINT16       shaHdrByteLen,
                           SctEndianType outBLType,
                           UINT8        shaOutput[32]);


/*****************************************************************************
 * AES API
*****************************************************************************/
/******************************************************************************
 * SctAesCalc
 * Description: AES encrypt/decrypt calculation
 * input: SctAesReq *pAesReq
 * output: SctShaRet
******************************************************************************/
SctAesShaRet SctAesCalc(SctAesReq *pAesReq);




#endif

