#ifndef __TLS_H__
#define __TLS_H__

#include "stdio.h"
#include "string.h"
#include "ec618.h"
#include "bsp.h"

#define SCT_BASE_ADDR           (0x40050000)

#define AES_SHA_CH4_CFG_REG     (SCT_BASE_ADDR + 0xbc) // AES/SHA uses sct channel4
#define AES_SHA_CH4_STATE_REG   (SCT_BASE_ADDR + 0x130)

#define SCT_ENABLE_REG          (SCT_BASE_ADDR + 0x00)
#define SCT_COMM_CFG0_REG       (SCT_BASE_ADDR + 0x54)
#define SCT_COMM_CFG1_REG       (SCT_BASE_ADDR + 0x58)
#define SCT_MEM_GUARD_REG       (SCT_BASE_ADDR + 0xec)



typedef enum 
{
    SHA_TYPE_1,
    SHA_TYPE_224,
    SHA_TYPE_256,    
}shaType_e;

typedef struct
{
    uint32_t length         : 16;
    uint32_t dir            : 1; // 0 - Encryption, 1 - Decryption
    uint32_t aesMode        : 2; // 0 每 ECB, 1 每 CBC, 2 每 CTR
    uint32_t paddingMode    : 3;
    uint32_t ckLen          : 2; // 0 每 128, 1 每 192, 2 每 256
    uint32_t aesCkSel       : 1; // 0 每 from configured CK address, 1 每 from efuse
    uint32_t                : 2;
    uint32_t subType        : 2; // 0 每 AES descriptor; 1 每 SHA descriptor
    uint32_t type           : 3; // Default 101
}aesField_t;

typedef struct
{
    uint32_t length     : 16; // sha can handle 64k data one time
    uint32_t shaMode    : 2; // 0: sha1; 1: sha224; 2: sha256
    uint32_t shaBls     : 1; // sha output endian. 0: LE;  1: BE
    uint32_t rcs        : 1; // 0: current is last data; 1: current data is continuous
    uint32_t outEn      : 1; // open output
    uint32_t            : 6;
    uint32_t subType    : 2; // // 0: aes; 1:sha
    uint32_t type       : 3; // Default 101
}shaField_t;


typedef struct
{
    uint32_t headLen    : 16;
    uint32_t            : 16;
}shaHeadLen_t;

typedef struct
{
    union firstWord
    {
        aesField_t aesField;
        shaField_t shaField;
    }u1;
    
    uint32_t srcAddr;
    uint32_t dstAddr;

    union secondWord
    {
        uint32_t aesCkAddr;
        uint32_t shaHeaderAddr;
    }u2;

    union thirdWord
    {
        uint32_t aesIvAddr;
        shaHeadLen_t shaHeadLen;
    }u3;
}sctDescCfg_t;

typedef struct
{
    uint32_t trigger    : 1;
    uint32_t reset      : 1;
    uint32_t            : 30;
}sctChanCfg_t;


typedef union {
    struct
    {
        uint32_t  fifoLen           : 8; // chain fifo length, max is 255
        uint32_t  chainIntEn        : 1;
        uint32_t  chainEmptyIntEn   : 1;
        uint32_t  chainFullIntEn    : 1;
        uint32_t  ckBLEndian        : 1;
        uint32_t  aesIvBLEndian     : 1; // bit: 12 
        uint32_t  ckOptDis          : 1; // bit: 13 
        uint32_t                    : 2;
        uint32_t  crcPolyLen        : 2; // bit: 16:17 
        uint32_t                    : 1;
        uint32_t  crcOutComple      : 1; // bit: 19 
        uint32_t  crcInCompleByteNum: 4; // bit: 20:23 
        uint32_t  crcOutBitSwap     : 1; // bit: 24 
        uint32_t  crcInBitSwap      : 1; // bit: 25 
        uint32_t                    : 6;
    };
    uint32_t val;
}chanCfgWord0_t;

typedef struct
{
    chanCfgWord0_t  chanCfgWord0;
    uint32_t        chanCfgWord1; // First desc addr
    uint32_t        rsvd[3];
    sctChanCfg_t    chanCfgWord5;
}sctCfgWord_t;

typedef struct
{
    uint32_t chaNextCfgIdx  : 8;
    uint32_t chaNextDoneIdx : 8;
    uint32_t chaFreeLen     : 8;
    uint32_t chaBeFull      : 1;
    uint32_t chaBeEmpty     : 1;
    uint32_t chaBeAct       : 1;
    uint32_t chaBeRstDone   : 1;
    uint32_t descBeTimeout  : 1;
    uint32_t                : 3;
}sctChaState_t;

typedef struct
{
    uint32_t hAddr0;
    uint32_t lAddr0;
    uint32_t hAddr1;
    uint32_t lAddr1;
    uint32_t hAddr2;
    uint32_t lAddr2;
    uint32_t hAddr3;
    uint32_t lAddr3;
}sctMemGuard_t;

typedef union
{
    struct
    {
        uint32_t rmiAcg             : 1;
        uint32_t ahbAcg             : 1;
        uint32_t                    : 14;
        uint32_t chainStartUnilog   : 1;
        uint32_t descDoneUnilog     : 1;
        uint32_t chainEndUnilog     : 1;
        uint32_t errorIntUnilog     : 1;
        uint32_t usbEndianInd       : 1;
        uint32_t                    : 3;
        uint32_t memHighAddrOffset  : 8;
    };
    uint32_t val;
}sctCfgWord0_t;

typedef struct
{
    uint32_t descMaxProcTickTime    : 20; // descriptor handle max timeout
    uint32_t                        : 12;
}sctCfgWord1_t;


typedef struct
{
    uint32_t dir            : 1; // 0: encrypt, 1: decrypt
    uint32_t aesMode        : 2; // 0: ecb, 1:cbc, 2:ctr
    uint32_t paddingMode    : 3; // 0: no padding, 1: PKCS7, 2: paddingOneZeros, 3: paddingZerosLen, 4: paddingZeros
    uint32_t ckLen          : 2; // 0:128, 1:192, 2:256
    uint32_t aesCkSel       : 1; // 0: from memory, 1: from efuse
    uint32_t ckBLEndian     : 1; // Ignore it if key is from efuse. If key is from memory, 0: little; 1: big
    uint32_t aesIvBLEndian  : 1; // input AES IV is big/little endian. 0: little;   1: big
    uint32_t                : 23;
}aesCtrl_t;

typedef struct
{
    uint32_t  ivAddr;
    uint32_t  srcAddr;
    uint32_t  dstAddr;
    uint32_t  aesCkAddr;
    uint32_t  length;
    aesCtrl_t aesCtrl;
}aesInfo_t;

/*
 * SCT memory guard address
 * SCT could only access MSMB: 0x00400000 ~ 0x0053FFFF
*/
#define MGR_LOW_ADDR        0x00400000
#define MGR_HIGH_ADDR       0x0053FFFF

/*
 * SCT memory guard address
 * USB TX FIFO: 0x00400000 ~ 0x0053FFFF
*/
#define MGR_LOW_ADDR1       0x1A000000
#define MGR_HIGH_ADDR1      0x1AFFFFFF

/*
 * AP flash, 4M: 0x0080-0000~0x00BF-FFFF
*/
#define MGR_LOW_ADDR2       0x00800000
#define MGR_HIGH_ADDR2      0x00BFFFFF


/*
 * CP flash, 1M: 0x0880-0000~0x088F-FFFF
*/
#define MGR_LOW_ADDR3       0x08800000
#define MGR_HIGH_ADDR3      0x088FFFFF



#define SCTDRV_OK           (0)
#define SCTDRV_BUSY         (-1)
#define SCTDRV_TIMEOUT      (-2)
#define SCTDRV_PAMERR       (-5)

/**
  \brief SCT module init.
  \return               
*/
void sctInit();

/**
  \brief SCT module deInit.
  \return               
*/
void sctDeInit();


/**
  \brief Aes operation
  \param[in] aesInfo   Aes information.
  \return status              
*/
int32_t aesUpdate(aesInfo_t* aesInfo);

/**
  \brief Sha operation.
  \param[in] shaMode  Choose SHA1, SHA224, SHA256.
  \param[in] srcAddr  SHA input address.
  \param[in] dstAddr  SHA output address.
  \param[in] length   SHA input length.
  \param[in] lastFlag If you need to loop call this api, "lastFlag" should be 0 for intermediate steps, and last step it should be 1.
  \return status              
*/
int32_t shaUpdate(shaType_e shaMode, uint32_t srcAddr, uint32_t dstAddr, uint32_t length, uint32_t lastFlag);

#endif
