 /****************************************************************************
  *
  * Copy right:   2019-, Copyrigths of AirM2M Ltd.
  * File name:    i2s.c
  * Description:  Audio use in EC618. The interface is similar with CMSIS Driver API V2.0.
  * History:      Rev1.0   2021-06-23
  *
  ****************************************************************************/
#include "i2s.h"
#include "slpman.h"

//////////////////////////////////////////////////////////////////////////////////////////////
// I2S Setting field Start
// All the I2S's parameters that need user to set are all put here
//////////////////////////////////////////////////////////////////////////////////////////////
static DmaTransferConfig_t g_dmaTxConfig =
{
    NULL,
    NULL,
    DMA_FLOW_CONTROL_TARGET,
    DMA_ADDRESS_INCREMENT_SOURCE,
    DMA_DATA_WIDTH_FOUR_BYTES,
    DMA_BURST_64_BYTES, 
    0
};

static DmaTransferConfig_t g_dmaRxConfig =
{
    NULL,
    NULL,
    DMA_FLOW_CONTROL_SOURCE,
    DMA_ADDRESS_INCREMENT_TARGET,
    DMA_DATA_WIDTH_TWO_BYTES,
    DMA_BURST_8_BYTES, 
    0
};


#if (RTE_I2S0)
static PIN i2s0PinMCLK  = {RTE_I2S0_MCLK_PAD_ADDR,   RTE_I2S0_MCLK_FUNC};
static PIN i2s0PinBCLK  = {RTE_I2S0_BCLK_PAD_ADDR,   RTE_I2S0_BCLK_FUNC};
static PIN i2s0PinLRCK  = {RTE_I2S0_LRCK_PAD_ADDR,   RTE_I2S0_LRCK_FUNC};
static PIN i2s0PinDin   = {RTE_I2S0_DIN_PAD_ADDR,    RTE_I2S0_DIN_FUNC};
static PIN i2s0PinDout  = {RTE_I2S0_DOUT_PAD_ADDR,   RTE_I2S0_DOUT_FUNC};
#elif (RTE_I2S1)
static PIN i2s1PinMCLK  = {RTE_I2S1_MCLK_PAD_ADDR,   RTE_I2S1_MCLK_FUNC};
static PIN i2s1PinBCLK  = {RTE_I2S1_BCLK_PAD_ADDR,   RTE_I2S1_BCLK_FUNC};
static PIN i2s1PinLRCK  = {RTE_I2S1_LRCK_PAD_ADDR,   RTE_I2S1_LRCK_FUNC};
static PIN i2s1PinDin   = {RTE_I2S1_DIN_PAD_ADDR,    RTE_I2S1_DIN_FUNC};
static PIN i2s1PinDout  = {RTE_I2S1_DOUT_PAD_ADDR,   RTE_I2S1_DOUT_FUNC};
#endif


// Sample rate, fs, fracdiv part, integer part. Generate MClk accoding to the sample rate.
const uint32_t i2sSampleRateTbl[][4] = 
{
    {SAMPLE_RATE_8K,    256, 0xCE0000, 0x31},   // 256fs, 8k
    {SAMPLE_RATE_16K,   256, 0xE70000, 0x18},   // 256fs, 16k
    {SAMPLE_RATE_32K,   256, 0x738000, 0x0C},   // 256fs, 32k
    {SAMPLE_RATE_22_05K,256, 0x11D9B0, 0x12},   // 256fs, 22.05k
    {SAMPLE_RATE_44_1K, 256, 0x08ECD8, 0x09},   // 256fs, 44.1k
    {SAMPLE_RATE_48K,   256, 0x4D0000, 0x08},   // 256fs, 48k
    {SAMPLE_RATE_96K,   256, 0x268000, 0x04},   // 256fs, 96k
};


// Data Format 
i2sDataFmt_t i2sDataFmt = 
{
    .slaveModeEn            = 0x1, // 0:Master; 1:Slave mode
    .slotSize               = 0xf, // Slot size
    .wordSize               = 0xf, // Real word size
    .alignMode              = 0,   // 1: Right alignment; 0: Left alignment
    .endianMode             = 0x1, // 1: MSB;  0: LSB
    .dataDly                = 0,   // Used by I2S format
    .txPad                  = 0,   // Tx padding
    .rxSignExt              = 0,   // Rx sign external
    .txPack                 = 1,   // 0: not compress; 1: 1word; 2: 2word
    .rxPack                 = 0,   // 0: not compress; 1: 1word; 2: 2word
    .txFifoEndianMode       = 0,   // I2s use or cspi use?
    .rxFifoEndianMode       = 0,   // I2s use or cspi use?
};

// Slot Control 
i2sSlotCtrl_t i2sSlotCtrl = 
{
    .slotEn                 = 0x1,  // Total 8 channels
    .slotNum                = 0x1   // For I2S, this value should be 1; For PCM, it can change
};

// BclkFs Control 
i2sBclkFsCtrl_t i2sBclkFsCtrl = 
{
    .bclkPolarity           = 1,    // 0: Rising edge send, falling edge sample; 1: falling edge send, rising edge sample 
    .fsPolarity             = 0,    // 0: rising edge start; 1: falling edge start
    .fsWidth                = 0xf   // fsWidth = slotNum *  slotSize
};

// I2S Control 
i2sCtrl_t i2sCtrl = 
{
	.i2sMode                = 1,    // 0: disable; 1: Only send; 2: Only receive; 3: Send and Receive
};

// DMA Control
i2sDmaCtrl_t i2sDmaCtrl = 
{
    .rxDmaReqEn             = 0,    // rx dma enable
    .txDmaReqEn             = 1,    // tx dma enable
    .rxDmaTimeOutEn         = 0,    // rx dma timeout enable
    .dmaWorkWaitCycle       = 31,   // dma wait cycle number
    .rxDmaBurstSizeSub1     = 7,    // rx dma burst size -1
    .txDmaBurstSizeSub1     = 15,    // tx dma burst size -1
    .rxDmaThreadHold        = 8,    // rx dma threshold
    .txDmaThreadHold        = 15,    // tx dma threshold
    .rxFifoFlush            = 0,    // flush rx fifo
    .txFifoFlush            = 0     // flush tx fifo
};


//////////////////////////////////////////////////////////////////////////////////////////////
// I2S Setting field End
//////////////////////////////////////////////////////////////////////////////////////////////
#if (RTE_I2S0)
static i2sInfo_t  i2s0Info = {0};
void i2s0DmaRxEvent(uint32_t event);
void i2s0DmaTxEvent(uint32_t event);
DmaDescriptor_t __ALIGNED(16) i2s0DmaTxDesc[I2S_DMA_TX_DESCRIPTOR_CHAIN_NUM];
DmaDescriptor_t __ALIGNED(16) i2s0DmaRxDesc[I2S_DMA_RX_DESCRIPTOR_CHAIN_NUM];

#if (RTE_I2S0_IO_MODE == DMA_MODE)
static i2sDma_t i2s0Dma =
{
    DMA_INSTANCE_MP,
    -1,
    RTE_I2S0_DMA_TX_REQID,
    i2s0DmaTxEvent,
    i2s0DmaTxDesc,

    DMA_INSTANCE_MP,
    -1,
    RTE_I2S0_DMA_RX_REQID,
    i2s0DmaRxEvent,
    i2s0DmaRxDesc
};
#endif

static i2sResources_t i2s0Res = {
    I2S0,
    {
        &i2s0PinMCLK,
        &i2s0PinBCLK,
        &i2s0PinLRCK,
        &i2s0PinDin,
        &i2s0PinDout,
    },
#if (RTE_I2S0_IO_MODE == DMA_MODE)
    &i2s0Dma,
#else
    NULL,
#endif
    NULL,
    &i2s0Info
};
#endif

#if (RTE_I2S1)

static i2sInfo_t i2s1Info = {0};
void i2s1DmaRxEvent(uint32_t event);
void i2s1DmaTxEvent(uint32_t event);
static DmaDescriptor_t __ALIGNED(16) i2s1DmaTxDesc[I2S_DMA_TX_DESCRIPTOR_CHAIN_NUM];
static DmaDescriptor_t __ALIGNED(16) i2s1DmaRxDesc[I2S_DMA_RX_DESCRIPTOR_CHAIN_NUM];

static i2sDma_t i2s1Dma =
{
    DMA_INSTANCE_MP,
    -1,
    RTE_I2S1_DMA_TX_REQID,
    i2s1DmaTxEvent,
    i2s1DmaTxDesc,

    DMA_INSTANCE_MP,
    -1,
    RTE_I2S1_DMA_RX_REQID,
    i2s1DmaRxEvent,
    i2s1DmaRxDesc
};

static i2sResources_t i2s1Res = {
    I2S1,
    {
        &i2s1PinMCLK,
        &i2s1PinBCLK,
        &i2s1PinLRCK,
        &i2s1PinDin,
        &i2s1PinDout,
    },
#if (RTE_I2S1_IO_MODE == DMA_MODE)
    &i2s1Dma,
#else
    NULL,
#endif
    NULL,
    &i2s1Info
};
#endif


static I2S_TypeDef* const i2sInstance[I2S_INSTANCE_NUM] = {I2S0, I2S1};

static ClockId_e i2sClk[I2S_INSTANCE_NUM * 2] =
{
    PCLK_I2S0,
    FCLK_I2S0,
    PCLK_I2S1,
    FCLK_I2S1
};

static ClockId_e i2sMClk[I2S_INSTANCE_NUM] = 
{
    MCLK0,
    MCLK1,
};

static ClockResetId_e i2sRstClk[I2S_INSTANCE_NUM * 2] =
{
    RST_PCLK_I2S0,
    RST_FCLK_I2S0,
    RST_PCLK_I2S1,
    RST_FCLK_I2S1
};



#ifdef PM_FEATURE_ENABLE

/** \brief Internal used data structure */
typedef struct
{
    bool              isInited;                       /**< Whether spi has been initialized */
    bool              mclkHasBeenClosed;              /**< 1: mclk has been closed; 0: mclk hasn't been closed */
    struct
    {
        __IO uint32_t DFMT;                           /**< Data Format Register,                offset: 0x0 */
        __IO uint32_t SLOTCTL;                        /**< Slot Control Register,               offset: 0x4 */
        __IO uint32_t CLKCTL;                         /**< Clock Control Register,              offset: 0x8 */
        __IO uint32_t DMACTL;                         /**< DMA Control Register,                offset: 0xC */
        __IO uint32_t INTCTL;                         /**< Interrupt Control Register,          offset: 0x10 */
        __IO uint32_t TIMEOUTCTL;                     /**< Timeout Control Register,            offset: 0x14 */
        __IO uint32_t STAS;                           /**< Status Register,                     offset: 0x18 */
        __IO uint32_t RFIFO;                          /**< Rx Buffer Register,                  offset: 0x1c */
        __IO uint32_t TFIFO;                          /**< Tx Buffer Register,                  offset: 0x20 */
        __IO uint32_t I2SCTL;                         /**< I2S Control Register,                offset: 0x28 */
    }regsBackup;
} i2sDataBase_t;

static i2sDataBase_t i2sDataBase[I2S_INSTANCE_NUM] = {0};
/**
  \brief i2s initialization counter, for lower power callback register/de-register
 */
static uint32_t i2sInitCnt = 0;

/**
  \brief Bitmap of I2S working status, each instance is assigned 2 bits representing tx and rx status,
         when all I2S instances are not working, we can vote to enter to low power state.
 */

volatile uint32_t i2sWorkingStats = 0;


/**
  \fn        static void i2sEnterLowPowerStatePrepare(void* pdata, slpManLpState state)
  \brief     Perform necessary preparations before sleep.
             After recovering from SLPMAN_SLEEP1_STATE, I2S hareware is repowered, we backup
             some registers here first so that we can restore user's configurations after exit.
  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state
 */
static void i2sEnterLpStatePrepare(void* pdata, slpManLpState state)
{
    uint32_t i;

    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            for(i = 0; i < I2S_INSTANCE_NUM; i++)
            {
                if(i2sDataBase[i].isInited == true)
                {
                    GPR_mclkDisable(i2sMClk[i]); // before sleep, disable MCLK
                    i2sDataBase[i].mclkHasBeenClosed = true;
                    
                    i2sDataBase[i].regsBackup.DFMT       = i2sInstance[i]->DFMT;
                    i2sDataBase[i].regsBackup.SLOTCTL    = i2sInstance[i]->SLOTCTL;
                    i2sDataBase[i].regsBackup.CLKCTL     = i2sInstance[i]->CLKCTL;
                    i2sDataBase[i].regsBackup.DMACTL     = i2sInstance[i]->DMACTL;
                    i2sDataBase[i].regsBackup.INTCTL     = i2sInstance[i]->INTCTL;
                    i2sDataBase[i].regsBackup.TIMEOUTCTL = i2sInstance[i]->TIMEOUTCTL;
                    i2sDataBase[i].regsBackup.STAS       = i2sInstance[i]->STAS;
                    i2sDataBase[i].regsBackup.I2SCTL     = i2sInstance[i]->I2SCTL;
                }
            }
            break;
        default:
            break;
    }
}

/**
  \fn        static void i2sExitLowPowerStateRestore(void* pdata, slpManLpState state)
  \brief     Restore after exit from sleep.
             After recovering from SLPMAN_SLEEP1_STATE, I2S hareware is repowered, we restore user's configurations
             by aidding of the stored registers.

  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state
 */
static void i2sExitLpStateRestore(void* pdata, slpManLpState state)
{
    uint32_t i;

    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            for(i = 0; i < I2S_INSTANCE_NUM; i++)
            {
                if(i2sDataBase[i].isInited == true)
                {
                    GPR_clockEnable(i2sClk[i*2]);
                    GPR_clockEnable(i2sClk[i*2 + 1]);

                    i2sInstance[i]->DFMT        = i2sDataBase[i].regsBackup.DFMT;
                    i2sInstance[i]->SLOTCTL     = i2sDataBase[i].regsBackup.SLOTCTL;
                    i2sInstance[i]->CLKCTL      = i2sDataBase[i].regsBackup.CLKCTL;
                    i2sInstance[i]->DMACTL      = i2sDataBase[i].regsBackup.DMACTL;
                    i2sInstance[i]->INTCTL      = i2sDataBase[i].regsBackup.INTCTL;
                    i2sInstance[i]->TIMEOUTCTL  = i2sDataBase[i].regsBackup.TIMEOUTCTL;
                    i2sInstance[i]->STAS        = i2sDataBase[i].regsBackup.STAS;
                    i2sInstance[i]->I2SCTL      = i2sDataBase[i].regsBackup.I2SCTL;
                }
            }
            break;

        default:
            break;
    }
}

#define  LOCK_SLEEP(instance)                                                                   \
                                    do                                                          \
                                    {                                                           \
                                        i2sWorkingStats |= (1U << instance);                    \
                                        slpManDrvVoteSleep(SLP_VOTE_I2S, SLP_ACTIVE_STATE);     \
                                    }                                                           \
                                    while(0)

#define  CHECK_TO_UNLOCK_SLEEP(instance)                                                        \
                                    do                                                          \
                                    {                                                           \
                                        i2sWorkingStats &= ~(1U << instance);                   \
                                        if(i2sWorkingStats == 0)                                \
                                            slpManDrvVoteSleep(SLP_VOTE_I2S, SLP_SLP1_STATE);   \
                                    }                                                           \
                                    while(0)
#endif

static uint32_t i2sGetInstanceNum(i2sResources_t *i2s)
{
    return ((uint32_t)i2s->reg - (uint32_t)I2S0) >> 12U;
}

int32_t i2sInit(i2sCbEvent_fn txCbEvent, i2sCbEvent_fn rxCbEvent, i2sResources_t *i2s)
{
    int32_t returnCode;
    PadConfig_t config;

#ifdef PM_FEATURE_ENABLE
    uint32_t instance = i2sGetInstanceNum(i2s);
    i2sDataBase[instance].isInited = true;
#endif

    // Initialize I2S PINS
    PAD_getDefaultConfig(&config);
    config.mux = i2s->pins.mclk->funcNum;
    PAD_setPinConfig(i2s->pins.mclk->pinNum, &config);
    config.mux = i2s->pins.bclk->funcNum;
    PAD_setPinConfig(i2s->pins.bclk->pinNum, &config);
    config.mux = i2s->pins.lrck->funcNum;
    PAD_setPinConfig(i2s->pins.lrck->pinNum, &config);
    config.mux = i2s->pins.din->funcNum;
    PAD_setPinConfig(i2s->pins.din->pinNum, &config);
    config.mux = i2s->pins.dout->funcNum;
    PAD_setPinConfig(i2s->pins.dout->pinNum, &config);

    // Initialize I2S run-time resources
    i2s->info->txCbEvent     = txCbEvent;
    i2s->info->rxCbEvent     = rxCbEvent;

    // Configure DMA if necessary
    if (i2s->dma)
    {
        // Tx config
        DMA_init(i2s->dma->txInstance);
        returnCode = DMA_openChannel(i2s->dma->txInstance);

        if (returnCode == ARM_DMA_ERROR_CHANNEL_ALLOC)
            return ARM_DRIVER_ERROR;
        else
            i2s->dma->txCh = returnCode;

        DMA_setChannelRequestSource(i2s->dma->txInstance, i2s->dma->txCh, (DmaRequestSource_e)i2s->dma->txReq);
        DMA_rigisterChannelCallback(i2s->dma->txInstance, i2s->dma->txCh, i2s->dma->txCb);

        // Rx config
        DMA_init(i2s->dma->rxInstance);
        returnCode = DMA_openChannel(i2s->dma->rxInstance);

        if (returnCode == ARM_DMA_ERROR_CHANNEL_ALLOC)
            return ARM_DRIVER_ERROR;
        else
            i2s->dma->rxCh = returnCode;

        DMA_setChannelRequestSource(i2s->dma->rxInstance, i2s->dma->rxCh, (DmaRequestSource_e)i2s->dma->rxReq);
        DMA_rigisterChannelCallback(i2s->dma->rxInstance, i2s->dma->rxCh, i2s->dma->rxCb);
    }

#ifdef PM_FEATURE_ENABLE
    i2sInitCnt++;

    if(i2sInitCnt == 1U)
    {
        i2sWorkingStats = 0;
        slpManRegisterPredefinedBackupCb(SLP_CALLBACK_I2S_MODULE, i2sEnterLpStatePrepare, NULL);
        slpManRegisterPredefinedRestoreCb(SLP_CALLBACK_I2S_MODULE, i2sExitLpStateRestore, NULL);
    }
#endif

    return ARM_DRIVER_OK;
}


int32_t i2sDeInit(i2sResources_t *i2s)
{
#ifdef PM_FEATURE_ENABLE
    uint32_t instance = i2sGetInstanceNum(i2s);
    i2sDataBase[instance].isInited = false;

    i2sInitCnt--;

    if(i2sInitCnt == 0)
    {
        i2sWorkingStats = 0;
        slpManUnregisterPredefinedBackupCb(SLP_CALLBACK_I2S_MODULE);
        slpManUnregisterPredefinedRestoreCb(SLP_CALLBACK_I2S_MODULE);
    }
#endif

    return ARM_DRIVER_OK;
}

int32_t i2sPowerCtrl(i2sPowerState_e state, i2sResources_t *i2s)
{
    uint32_t instance = i2sGetInstanceNum(i2s);

    switch (state)
    {
        // when need to enter sleep, do not call this api. PMU will manage all the clocks by default.
        case I2S_POWER_OFF:
            if(i2s->dma)
            {
                DMA_stopChannel(i2s->dma->txInstance, i2s->dma->txCh, false);
            }

            // Reset register values
            if (instance == 0)
            {
                CLOCK_setClockSrc(FCLK_I2S0, FCLK_I2S0_SEL_26M);
                GPR_swReset(RST_PCLK_I2S0);
            }
            else
            {
                CLOCK_setClockSrc(FCLK_I2S1, FCLK_I2S1_SEL_26M);
                GPR_swReset(RST_PCLK_I2S1);
            }

            // Disable I2S clock
            CLOCK_clockDisable(i2sClk[instance*2]);
            CLOCK_clockDisable(i2sClk[instance*2+1]);
            
            break;

        case I2S_POWER_FULL:

            // Enable I2S clock            
            CLOCK_clockEnable(i2sClk[instance*2]);   // pclk
            CLOCK_clockEnable(i2sClk[instance*2+1]); // fclk

            GPR_swReset(i2sRstClk[instance*2]);    // pclk
            GPR_swReset(i2sRstClk[instance*2+1]);  // fclk

            break;

        default:
            return ARM_DRIVER_ERROR_UNSUPPORTED;
    }
    return ARM_DRIVER_OK;
}

int32_t i2sSend(const void *data, uint32_t chunkNum, i2sResources_t *i2s)
{
    uint32_t instance = i2sGetInstanceNum(i2s);

    if ((data == NULL) || (chunkNum == 0))
        return ARM_DRIVER_ERROR_PARAMETER;

    // dma mode
    if(i2s->dma)
    {
#ifdef PM_FEATURE_ENABLE
        LOCK_SLEEP(instance);
#endif

        // Configure tx DMA and start it
        g_dmaTxConfig.sourceAddress = (void *)data;
        g_dmaTxConfig.targetAddress = (void *)&(i2sInstance[instance]->TFIFO);
        g_dmaTxConfig.totalLength   = chunkNum;
        DMA_buildDescriptorChain(i2s->dma->txDescriptor, &g_dmaTxConfig, I2S_DMA_TX_DESCRIPTOR_CHAIN_NUM, true);
        DMA_loadChannelDescriptorAndRun(i2s->dma->txInstance, i2s->dma->txCh, i2s->dma->txDescriptor);
    }
    // polling mode
    else
    {
        for (int i = 0; i < chunkNum; i++)
        {
            // Flow control. Make sure TX have empty fifo
           while (((16 - (i2s->reg->STAS & I2S_STATS_CTRL_TX_FIFO_LEVEL_Msk)) 
                    >>  I2S_STATS_CTRL_TX_FIFO_LEVEL_Pos) == 0){};
                    
			i2s->reg->TFIFO = *(uint32_t*)data; 
        }
    }

    return ARM_DRIVER_OK;
}


int32_t i2sRecv(void *data, uint32_t chunkNum, i2sResources_t *i2s)
{
    uint32_t instance = i2sGetInstanceNum(i2s);;

    if ((data == NULL) || (chunkNum == 0))
        return ARM_DRIVER_ERROR_PARAMETER;

    // dma mode
    if(i2s->dma)
    {
#ifdef PM_FEATURE_ENABLE
        LOCK_SLEEP(instance);
#endif

        // Configure rx DMA and start it
        g_dmaRxConfig.sourceAddress = (void *)&(i2sInstance[instance]->RFIFO);
        g_dmaRxConfig.targetAddress = (void *)data;
        g_dmaRxConfig.totalLength   = chunkNum;
        DMA_buildDescriptorChain(i2s->dma->rxDescriptor, &g_dmaRxConfig, I2S_DMA_RX_DESCRIPTOR_CHAIN_NUM, true);
        DMA_loadChannelDescriptorAndRun(i2s->dma->rxInstance, i2s->dma->rxCh, i2s->dma->rxDescriptor);
    }
    // polling mode
    else
    {
        for (int i = 0; i < chunkNum; i++)
        {
            while (((i2s->reg->STAS >> I2S_STATS_CTRL_RX_DAT_RDY_Pos) & 0x1) == 0); // Wait until RxFifo have data
            *((uint32_t*)data + i) = i2s->reg->RFIFO;
        }
    }

    return ARM_DRIVER_OK;
}


/**
  \fn          static int32_t i2sSetBusSpeed(uint32_t bps, i2sResources_t *i2s)
  \brief       Set bus speed
  \param[in]   bps       bus speed to set
  \param[in]   spi       Pointer to SPI resources
  \return      \ref execution_status
*/
static int32_t i2sSetSampleRate(uint32_t bps, i2sResources_t *i2s, i2sRole_e i2sRole)
{
    uint32_t instance = i2sGetInstanceNum(i2s);

    if (instance == 0) // i2s0
    {
        CLOCK_clockEnable(FCLK_I2S0);
    }
    else // i2s1
    {
        CLOCK_clockEnable(FCLK_I2S1);
    }

    CLOCK_setClockSrc(CLK_CC, CLK_CC_SEL_204M); // Core clk selects 204M

    if (instance == 0) // i2s0
    {
        CLOCK_fracDivOutCLkEnable(FRACDIV0_OUT0); // Fracdiv0 out0 enable       
        CLOCK_setMclkSrc(MCLK0, MCLK_SRC_FRACDIV0_OUT0); // Choose Fracdiv0 out0 as MClk source
        CLOCK_mclkEnable(MCLK0); // Mclk enable
        CLOCK_setFracDivOutClkDiv(FRACDIV0_OUT0, 4); // First step to generate MClk clock. 4 div, from 408M -> 102M

        // need to add gpr api for fracdiv
        int sampleRateIdx;
        for (sampleRateIdx = 0; sampleRateIdx < sizeof(i2sSampleRateTbl) / sizeof(i2sSampleRateTbl[0]); sampleRateIdx++)
        {
            if (bps == i2sSampleRateTbl[sampleRateIdx][0])
            {
                // Fracdiv clk selects 408M and set frac and integer clk
                FracDivConfig_t fracdivCfg;
                memset(&fracdivCfg, 0, sizeof(FracDivConfig_t));
                fracdivCfg.source = FRACDIC_ROOT_CLK_408M;
                fracdivCfg.fracDiv0DivRatioInteger = i2sSampleRateTbl[sampleRateIdx][3];
                fracdivCfg.fracDiv0DivRatioFrac = i2sSampleRateTbl[sampleRateIdx][2];
                CLOCK_setFracDivConfig(&fracdivCfg); // Second step to generate MClk
            }
        }
    }
    else // i2s1
    {
        CLOCK_fracDivOutCLkEnable(FRACDIV1_OUT0); // Fracdiv1 out0 enable       
        CLOCK_setMclkSrc(MCLK1, MCLK_SRC_FRACDIV1_OUT0); // Choose Fracdiv1 out0 as MClk source
        CLOCK_mclkEnable(MCLK1); // Mclk enable
        CLOCK_setFracDivOutClkDiv(FRACDIV1_OUT0, 4); // First step to generate MClk clock. 4 div, from 408M -> 102M

        // need to add gpr api for fracdiv
        int sampleRateIdx;
        for (sampleRateIdx = 0; sampleRateIdx < sizeof(i2sSampleRateTbl) / sizeof(i2sSampleRateTbl[0]); sampleRateIdx++)
        {
            if (bps == i2sSampleRateTbl[sampleRateIdx][0])
            {
                // Fracdiv clk selects 408M and set frac and integer clk
                FracDivConfig_t fracdivCfg;
                memset(&fracdivCfg, 0, sizeof(FracDivConfig_t));
                fracdivCfg.source = FRACDIC_ROOT_CLK_408M;
                fracdivCfg.fracDiv1DivRatioInteger = i2sSampleRateTbl[sampleRateIdx][3];
                fracdivCfg.fracDiv1DivRatioFrac = i2sSampleRateTbl[sampleRateIdx][2];
                CLOCK_setFracDivConfig(&fracdivCfg); // Second step to generate MClk
            }
        }
    }

    if (instance == 0)
    {
        // I2S master mode need to genetate LRCLK by MCU
        if (i2sRole == CODEC_SLAVE_MODE) // I2S controller act as master, codec is slave
        {       
            CLOCK_fracDivOutCLkEnable(FRACDIV0_OUT1); // Enable fracdiv0 out1
            CLOCK_setBclkSrc(BCLK0, BCLK_SRC_FRACDIV0_OUT1); // Use fracdiv0 out1 to generate bclk
            CLOCK_setFracDivOutClkDiv(FRACDIV0_OUT1, 8); // First step to generate BClk clock. 8 div, from 408M->51M
            CLOCK_setBclkDiv(BCLK0, 4); // Second step to generate BClk clock. Bclk enable and divide by 4(256fs)
            CLOCK_bclkEnable(BCLK0); // Enable bclk
        }
    }
    else
    {
        // I2S master mode need to genetate LRCLK by MCU
        if (i2sRole == CODEC_SLAVE_MODE) // I2S controller act as master, codec is slave
        {       
            CLOCK_fracDivOutCLkEnable(FRACDIV1_OUT1); // Enable fracdiv1 out1
            CLOCK_setBclkSrc(BCLK1, BCLK_SRC_FRACDIV1_OUT1); // Use fracdiv1 out1 to generate bclk
            CLOCK_setFracDivOutClkDiv(FRACDIV1_OUT1, 8); // First step to generate BClk clock. 8 div, from 408M->51M
            CLOCK_setBclkDiv(BCLK1, 4); // Second step to generate BClk clock. Bclk enable and divide by 4(256fs)
            CLOCK_bclkEnable(BCLK1); // Enable bclk
        }
    }

    return ARM_DRIVER_OK;
}


/**
  \fn          int32_t i2sControl(uint32_t control, uint32_t arg, i2sRes_t *i2s)
  \brief       Control I2S Interface.
  \param[in]   control  Operation
  \param[in]   arg      Argument of operation (optional)
  \param[in]   i2s      Pointer to I2S resources
  \return      common \ref execution_status and driver specific \ref spi_execution_status
*/
int32_t i2sControl(uint32_t control, uint32_t arg, i2sResources_t *i2s)
{
    uint32_t instance = i2sGetInstanceNum(i2s);

    switch(control & 0xFFFF)
    {
        // Set transport abort
        case I2S_CTRL_TRANSABORT:
        {
            // If DMA mode, disable DMA channel
            if(i2s->dma)
            {
                DMA_stopChannel(i2s->dma->txInstance, i2s->dma->txCh, true);
            }

            break;
        }

        case I2S_CTRL_SET_TOTAL_NUM:
        {
            i2s->info->totalNum = arg;
        }        

        // Set Bus Speed in bps; arg = value
        case I2S_CTRL_SAMPLE_RATE_SLAVE:
        {
            if(i2sSetSampleRate(arg, i2s, CODEC_MASTER_MODE) != ARM_DRIVER_OK)
            {
                return ARM_DRIVER_ERROR;
            }
            break;
        }

        case I2S_CTRL_SAMPLE_RATE_MASTER:
        {
            if(i2sSetSampleRate(arg, i2s, CODEC_SLAVE_MODE) != ARM_DRIVER_OK)
            {
                return ARM_DRIVER_ERROR;
            }
            break;
        }     

        // Set Data Format
        case I2S_CTRL_DATA_FORMAT:
        {
            memcpy((void*)&(i2sInstance[instance]->DFMT), &i2sDataFmt, sizeof(i2sDataFmt_t));
            break;
        }

        // Set Slot
        case I2S_CTRL_SLOT_CTRL:
        {
            memcpy((void*)&(i2sInstance[instance]->SLOTCTL), &i2sSlotCtrl, sizeof(i2sSlotCtrl_t));
            break;
        }

        // Set DMA Control
        case I2S_CTRL_DMA_CTRL:
        {
            memcpy((void*)&(i2sInstance[instance]->DMACTL), &i2sDmaCtrl, sizeof(i2sDmaCtrl_t));
            break;
        }

        // Set I2S Control
        case I2S_CTRL_I2SCTL:
        {
            memcpy((void*)&(i2sInstance[instance]->I2SCTL), &i2sCtrl, sizeof(i2sCtrl_t));
            break;
        }

        // Set Frame Info0
        case I2S_CTRL_BCLK_FS_CTRL:
        {
            memcpy((void*)&(i2sInstance[instance]->CLKCTL), &i2sBclkFsCtrl, sizeof(i2sBclkFsCtrl_t));
            break;
        }

        // Start or stop audio play
        case I2S_CTRL_START_STOP:
        {
#ifdef PM_FEATURE_ENABLE
            if (i2sDataBase[instance].mclkHasBeenClosed == true)
            {
                GPR_mclkEnable(i2sMClk[instance]);
                i2sDataBase[instance].mclkHasBeenClosed = false; // already opened MCLK now
            }
#endif
            i2sInstance[instance]->I2SCTL = arg; // 0: disable i2s; 1: enable send; 2: enable recv; 3: enable send/recv
            break;
        }

        default:
            return ARM_DRIVER_ERROR_UNSUPPORTED;
    }
    return ARM_DRIVER_OK;
}

void i2sDmaRxEvent(uint32_t event, i2sResources_t *i2s)
{
#ifdef PM_FEATURE_ENABLE
    uint32_t instance = i2sGetInstanceNum(i2s);
#endif

    switch(event)
    {
        case DMA_EVENT_END:
            //DMA_stopChannel(i2s->dma->rxInstance, i2s->dma->rxCh, true);
            //i2s->reg->I2SCTL &= ~I2S_CTL_MODE_Msk;

            if(i2s->info->rxCbEvent)
            {
                i2s->info->rxCbEvent(I2S_EVENT_TRANSFER_COMPLETE, 0);
            }
#ifdef PM_FEATURE_ENABLE
             CHECK_TO_UNLOCK_SLEEP(instance);
#endif
            break;

        default:
            break;
    }
}

void i2sDmaTxEvent(uint32_t event, i2sResources_t *i2s)
{
#ifdef PM_FEATURE_ENABLE
    uint32_t instance = i2sGetInstanceNum(i2s);
#endif

    switch(event)
    {
        case DMA_EVENT_END:
#if 0 // If you want to loop the audio, don't stop DMA here       
            DMA_stopChannel(i2s->dma->txInstance, i2s->dma->txCh, true);
            i2s->info->status.busy = 0;
            i2s->reg->I2SCTL &= ~I2S_CTL_MODE_Msk;
#endif
            if(i2s->info->txCbEvent)
            {
                i2s->info->txCbEvent(I2S_EVENT_TRANSFER_COMPLETE, i2s->info->totalNum);
            }
#ifdef PM_FEATURE_ENABLE
             CHECK_TO_UNLOCK_SLEEP(instance);
#endif
            break;

        default:
            break;
    }
}

uint32_t i2sGetTotalCnt(i2sResources_t *i2s)
{
	return i2s->info->totalNum;
}


#if (RTE_I2S0)

static int32_t i2s0Init(i2sCbEvent_fn txCbEvent, i2sCbEvent_fn rxCbEvent)
{
    return i2sInit(txCbEvent, rxCbEvent, &i2s0Res);
}
static int32_t i2s0Deinit(void)
{
    return i2sDeInit(&i2s0Res);
}
static int32_t i2s0PowerCtrl(i2sPowerState_e state)
{
    return i2sPowerCtrl(state, &i2s0Res);
}

static int32_t i2s0Send(void *data, uint32_t num)
{
    return i2sSend(data, num, &i2s0Res);
}

static int32_t i2s0Recv(void *data, uint32_t num)
{
    return i2sRecv(data, num, &i2s0Res);
}

static int32_t i2s0Ctrl(uint32_t control, uint32_t arg)
{
    return i2sControl(control, arg, &i2s0Res);
}

void i2s0DmaTxEvent(uint32_t event)
{
    i2sDmaTxEvent(event, &i2s0Res);
}

void i2s0DmaRxEvent(uint32_t event)
{
    i2sDmaRxEvent(event, &i2s0Res);
}

uint32_t i2s0GetTotalCnt(void)
{
	return i2sGetTotalCnt(&i2s0Res);
}

// I2S0 Driver Control Block
i2sDrvInterface_t i2sDrvInterface0 = 
{
    i2s0Init,
    i2s0Deinit,
    i2s0PowerCtrl,
    i2s0Send,
    i2s0Recv,
    i2s0Ctrl,
    i2s0GetTotalCnt,
};
#endif

#if (RTE_I2S1)
static int32_t i2s1Init(i2sCbEvent_fn txCbEvent, i2sCbEvent_fn rxCbEvent)
{
    return i2sInit(txCbEvent, rxCbEvent, &i2s1Res);
}
static int32_t i2s1Deinit(void)
{
    return i2sDeInit(&i2s1Res);
}
static int32_t i2s1PowerCtrl(i2sPowerState_e state)
{
    return i2sPowerCtrl(state, &i2s1Res);
}

static int32_t i2s1Send(void *data, uint32_t num)
{
    return i2sSend(data, num, &i2s1Res);
}

static int32_t i2s1Recv(void *data, uint32_t num)
{
    return i2sRecv(data, num, &i2s1Res);
}

static int32_t i2s1Ctrl(uint32_t control, uint32_t arg)
{
    return i2sControl(control, arg, &i2s1Res);
}

uint32_t i2s1GetTotalCnt(void)
{
	return i2sGetTotalCnt(&i2s1Res);
}

void i2s1DmaRxEvent(uint32_t event)
{
    i2sDmaRxEvent(event, &i2s1Res);
}

void i2s1DmaTxEvent(uint32_t event)
{
    i2sDmaTxEvent(event, &i2s1Res);
}

// I2S1 Driver Control Block
i2sDrvInterface_t i2sDrvInterface1 = 
{
    i2s1Init,
    i2s1Deinit,
    i2s1PowerCtrl,
    i2s1Send,
    i2s1Recv,
    i2s1Ctrl,
	i2s1GetTotalCnt,
};
#endif

