/****************************************************************************
 *
 * Copy right:   2019-, Copyrigths of AirM2M Ltd.
 * File name:    tls.c
 * Description:  This driver is part of SCT(Security Top) module, only focus on AES and SHA functions which are 
 *               mostly used in TLS(transport layer security) area.
 * History:      Rev1.0   2021-12-3
 *
 ****************************************************************************/

#include "tls.h"

static __attribute__((aligned(4))) sctDescCfg_t sctDescCfg;

void sctInit()
{
    // open clock
    CLOCK_clockEnable(SCT_RMI_HCLK);

    GPR_swReset(RST_SCT_RMI_HCLK);
    GPR_swReset(RST_SCT_HCLK);

    memset(&sctDescCfg, 0, sizeof(sctDescCfg_t));

    // enable sct
    *(uint32_t *)SCT_ENABLE_REG = 1; 

    // set memory guard
    sctMemGuard_t *sctMemGuard = (sctMemGuard_t*)SCT_MEM_GUARD_REG;
    sctMemGuard->hAddr0 = MGR_HIGH_ADDR;
    sctMemGuard->lAddr0 = MGR_LOW_ADDR;
    sctMemGuard->hAddr1 = MGR_HIGH_ADDR1;
    sctMemGuard->lAddr1 = MGR_LOW_ADDR1;
    sctMemGuard->hAddr2 = MGR_HIGH_ADDR2;
    sctMemGuard->lAddr2 = MGR_LOW_ADDR2;
    sctMemGuard->hAddr3 = MGR_HIGH_ADDR3;
    sctMemGuard->lAddr3 = MGR_LOW_ADDR3;
    
    // sct common config
    sctCfgWord0_t *cfgWord0 = (sctCfgWord0_t*)SCT_COMM_CFG0_REG;
    sctCfgWord1_t *cfgWord1 = (sctCfgWord1_t*)SCT_COMM_CFG1_REG;
    sctCfgWord0_t word0;
    cfgWord0->val = 0;
    cfgWord1->descMaxProcTickTime = 0x4fffb;
    
    word0.ahbAcg = 0;
    word0.rmiAcg = 1;
    word0.chainStartUnilog = 1;
    word0.descDoneUnilog = 1;
    word0.chainEndUnilog = 1;
    word0.errorIntUnilog = 1;
    word0.usbEndianInd = 0;
    word0.memHighAddrOffset = 0;
    cfgWord0->val = word0.val;
}

static uint32_t sctCheckBusy()
{
    sctChaState_t *state = (sctChaState_t*)AES_SHA_CH4_STATE_REG;
    if (state->chaBeEmpty)
    {
        return 0;
    }
    return 1;
}

static int sctTrigger(sctDescCfg_t* sctDescCfg)
{
    if (sctCheckBusy())
    {
        return SCTDRV_BUSY;
    }

    sctCfgWord_t* sctCfgWord = (sctCfgWord_t*)AES_SHA_CH4_CFG_REG;   
    sctCfgWord->chanCfgWord1 = (uint32_t)sctDescCfg;
    CLOCK_clockEnable(SCT_HCLK);
    sctCfgWord->chanCfgWord5.trigger = 1;

    return SCTDRV_OK;
}

static int sctPollDone(uint32_t timeOutCycle)
{
    while (timeOutCycle--)
    {
        delay_us(1);

        if (!sctCheckBusy())
        {
            return SCTDRV_OK;
        }
    }
    
    return SCTDRV_TIMEOUT;
}


int32_t aesUpdate(aesInfo_t* aesInfo)
{
    uint32_t ret = SCTDRV_OK;

    sctDescCfg_t* sctDescCfgPtr = &sctDescCfg;
    sctDescCfgPtr->u1.aesField.length       = aesInfo->length;
    sctDescCfgPtr->u1.aesField.dir          = aesInfo->aesCtrl.dir;
    sctDescCfgPtr->u1.aesField.aesMode      = aesInfo->aesCtrl.aesMode;
    sctDescCfgPtr->u1.aesField.paddingMode  = aesInfo->aesCtrl.paddingMode;
    sctDescCfgPtr->u1.aesField.ckLen        = aesInfo->aesCtrl.ckLen;
    sctDescCfgPtr->u1.aesField.aesCkSel     = aesInfo->aesCtrl.aesCkSel;
    sctDescCfgPtr->u1.aesField.subType      = 0; // aes
    sctDescCfgPtr->u1.aesField.type         = 5; // default value is 5
    sctDescCfgPtr->srcAddr                  = aesInfo->srcAddr;
    sctDescCfgPtr->dstAddr                  = aesInfo->dstAddr;

    if (aesInfo->aesCtrl.aesCkSel == 0) // from memory
    {
        sctDescCfgPtr->u2.aesCkAddr  = aesInfo->aesCkAddr;;
    }

    if (aesInfo->aesCtrl.aesMode == 1 || aesInfo->aesCtrl.aesMode == 2) // aes cbc, ctr mode
    {
        sctDescCfgPtr->u3.aesIvAddr = aesInfo->ivAddr;
    }

    sctCfgWord_t* sctCfgWord = (sctCfgWord_t*)AES_SHA_CH4_CFG_REG;
    chanCfgWord0_t cfgWord0;
    cfgWord0.val = 0;
    if (aesInfo->aesCtrl.ckBLEndian == 1) // key is big endian
    {
        cfgWord0.ckBLEndian = 1;
    }

    if (aesInfo->aesCtrl.aesIvBLEndian == 1) // iv is big endian
    {
        cfgWord0.aesIvBLEndian = 1;
    }
    
    cfgWord0.fifoLen = 1; // only 1 descriptor(aes)
    sctCfgWord->chanCfgWord0.val = cfgWord0.val;

    ret = sctTrigger(sctDescCfgPtr);
    if (ret != SCTDRV_OK)
    {
        return SCTDRV_BUSY;
    }

    ret = sctPollDone(50000);
    return ret;
}

// if you need to loop call this api, "lastFlag" should be 0 for intermediate steps, and last step it should be 1.
int32_t shaUpdate(shaType_e shaMode, uint32_t srcAddr, uint32_t dstAddr, uint32_t length, uint32_t lastFlag)
{
    uint32_t ret = SCTDRV_OK;

    // sha input should 64bytes aligned, if not, you need to padding it first
    if ((length & 0x3f) != 0)
    {
        return SCTDRV_PAMERR;
    }

    sctDescCfg_t* sctDescCfgPtr = &sctDescCfg;
    sctDescCfgPtr->srcAddr = srcAddr; // sha input
    sctDescCfgPtr->dstAddr = dstAddr; // sha output
    sctDescCfgPtr->u1.shaField.length = length; // sha input length, should 64bytes aligned
    sctDescCfgPtr->u1.shaField.subType = 1; // 0: aes; 1:sha
    sctDescCfgPtr->u1.shaField.shaMode = shaMode;
    sctDescCfgPtr->u1.shaField.type = 5; // default value 5
    sctDescCfgPtr->u1.shaField.shaBls = 1; // sha output endian. 0: LE;  1: BE

    if (lastFlag == 0)
    {
        sctDescCfgPtr->u1.shaField.rcs = 1; // data is continuous
        sctDescCfgPtr->u1.shaField.outEn = 0; // not output
    }
    else
    {
        sctDescCfgPtr->u1.shaField.rcs = 0; // data has been the last sector
        sctDescCfgPtr->u1.shaField.outEn = 1; // open sha output value
    }

    sctDescCfgPtr->u3.shaHeadLen.headLen = 0; // no head

    sctCfgWord_t* sctCfgWord = (sctCfgWord_t*)AES_SHA_CH4_CFG_REG;
    chanCfgWord0_t cfgWord0;
    cfgWord0.val = 0;   
    cfgWord0.fifoLen = 1; // here only 1 descriptor(sha)
    sctCfgWord->chanCfgWord0.val = cfgWord0.val;
    
    ret = sctTrigger(sctDescCfgPtr);
    if (ret != SCTDRV_OK)
    {
        return SCTDRV_BUSY;
    }

    ret = sctPollDone(50000);
    return ret;
}

