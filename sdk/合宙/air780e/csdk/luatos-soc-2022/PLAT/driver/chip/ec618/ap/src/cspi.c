/****************************************************************************
 *
 * Copy right:   2019-, Copyrigths of AirM2M Ltd.
 * File name:    cspi.c
 * Description:  Dedicated spi for camera use in EC618. The interface is similar with CMSIS Driver API V2.0.
 * History:      Rev1.0   2021-03-18
 *
 ****************************************************************************/
#include "cspi.h"
#include "slpman.h"
#include "cameraDrv.h"

//////////////////////////////////////////////////////////////////////////////////////////////
// CSPI Setting field Start
// All the CSPI's parameters that need user to set are all put here
//////////////////////////////////////////////////////////////////////////////////////////////
static DmaTransferConfig_t g_dmaRxConfig =
{
    NULL,
    NULL,
    DMA_FLOW_CONTROL_SOURCE,
    DMA_ADDRESS_INCREMENT_TARGET,
    DMA_DATA_WIDTH_FOUR_BYTES,
    DMA_BURST_32_BYTES,
    0
};

#if (RTE_CSPI0)
static PIN cspi0PinMCLK  = {RTE_CSPI0_MCLK_PAD_ADDR,   RTE_CSPI0_MCLK_FUNC};
static PIN cspi0PinPCLK  = {RTE_CSPI0_PCLK_PAD_ADDR,   RTE_CSPI0_PCLK_FUNC};
static PIN cspi0PinCS    = {RTE_CSPI0_CS_PAD_ADDR,     RTE_CSPI0_CS_FUNC};
static PIN cspi0PinSdo0  = {RTE_CSPI0_SDO0_PAD_ADDR,   RTE_CSPI0_SDO0_FUNC};
static PIN cspi0PinSdo1  = {RTE_CSPI0_SDO1_PAD_ADDR,   RTE_CSPI0_SDO1_FUNC};

#elif (RTE_CSPI1)
static PIN cspi1PinMCLK  = {RTE_CSPI1_MCLK_PAD_ADDR,   RTE_CSPI1_MCLK_FUNC};
static PIN cspi1PinPCLK  = {RTE_CSPI1_PCLK_PAD_ADDR,   RTE_CSPI1_PCLK_FUNC};
static PIN cspi1PinCS    = {RTE_CSPI1_CS_PAD_ADDR,     RTE_CSPI1_CS_FUNC};
static PIN cspi1PinSdo0  = {RTE_CSPI1_SDO0_PAD_ADDR,   RTE_CSPI1_SDO0_FUNC};
static PIN cspi1PinSdo1  = {RTE_CSPI1_SDO1_PAD_ADDR,   RTE_CSPI1_SDO1_FUNC};
#endif

// Data Format 
cspiDataFmt_t cspiDataFmt = 
{
    .slaveModeEn            = 1, 
    .slotSize               = 7, 
    .wordSize               = 7, 
    .alignMode              = 0, 
    .endianMode             = 0, // 0:LSB  1: MSB. 
    .dataDly                = 0, 
    .txPad                  = 0, 
    .rxSignExt              = 0, 
    .txPack                 = 0, 
    .rxPack                 = 2, 
    .txFifoEndianMode       = 0, 
    .rxFifoEndianMode       = 0  
};

// Frame Info0
cspiFrameInfo0_t cspiFrameInfo0 = 
{
    .cspiBusTimeOutCycle    = 0x1000,
    .dataId                 = 0, // readOnly
};

// RX Fifo timeout Cycle
cspiTimeOutCycle_t cspiRxTimeOutCycle = 
{
    .rxTimeOutCycle         = 20,
};

// INT Control
cspiIntCtrl_t cspiIntCtrl = 
{
	.txUnderRunIntEn        = 0,
    .txDmaErrIntEn          = 0,
    .txDatIntEn             = 0,
    .rxOverFlowIntEn        = 0,
    .rxDmaErrIntEn          = 0,
    .rxDatIntEn             = 0,
    .rxTimeOutIntEn         = 0,
    .fsErrIntEn             = 0,
    .frameStartIntEn        = 0,
    .frameEndIntEn          = 0,
    .cspiBusTimeOutIntEn    = 0,
    .txIntThreshHold        = 8,
    .rxIntThreshHold        = 8,
};


// DMA Control
cspiDmaCtrl_t cspiDmaCtrl = 
{
    .rxDmaReqEn             = 1,
    .txDmaReqEn             = 0,
    .rxDmaTimeOutEn         = 0,
    .dmaWorkWaitCycle       = 31,
    .rxDmaBurstSizeSub1     = 7,
    .txDmaBurstSizeSub1     = 7,
    .rxDmaThreadHold        = 7,
    .txDmaThreadHold        = 8,
    .rxFifoFlush            = 0,
    .txFifoFlush            = 0
};

cspiCtrl_t cspiCtrl = 
{
    .enable                 = 0,
    .csEn                   = 0,
    .rxWid                  = 1, // 0: 1bit; 1: 2bit
    .rxdSeq                 = 1, // gc032a 0, sp0a39 1
    .cpol                   = 0,
    .cpha                   = 1,
    .frameProcEn            = 1,
    .fillYonly              = 1,
    .hwInitEn               = 1,
    .lsCheckEn              = 1,
    .dpCheckEn              = 1,
    .frameProcInitEn        = 0,
    .rowScaleRatio          = 0, 
    .colScaleRatio          = 0, 
    .scaleBytes             = 0, 
};

//////////////////////////////////////////////////////////////////////////////////////////////
// CSPI Setting field End
//////////////////////////////////////////////////////////////////////////////////////////////



static CSPI_TypeDef* const cspiInstance[CSPI_INSTANCE_NUM] = {CSPI0, CSPI1};

static ClockId_e cspiClk[CSPI_INSTANCE_NUM * 2] =
{
    PCLK_I2S0,
    FCLK_I2S0,
    PCLK_I2S1,
    FCLK_I2S1
};

static ClockResetId_e cspiRstClk[CSPI_INSTANCE_NUM * 2] =
{
    RST_PCLK_I2S0,
    RST_FCLK_I2S0,
    RST_PCLK_I2S1,
    RST_FCLK_I2S1
};

#ifdef PM_FEATURE_ENABLE
/**
  \brief spi initialization counter, for lower power callback register/de-register
 */
static uint32_t cspiInitCnt = 0;

/**
  \brief Bitmap of CSPI working status, each instance is assigned 2 bits representing tx and rx status,
         when all CSPI instances are not working, we can vote to enter to low power state.
 */
static uint32_t cspiWorkingStats = 0;

/** \brief Internal used data structure */
typedef struct
{
    bool              isInited;                       /**< Whether spi has been initialized */
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
        __IO uint32_t CSPICTL;                        /**< Camera SPI Control Register,         offset: 0x28 */
        __IO uint32_t CCTL;                           /**< Auto Cg Control Register,            offset: 0x2c */
        __IO uint32_t CSPIINFO0;                      /**< Cspi Frame info0 Register,           offset: 0x30 */
        __IO uint32_t CSPIINFO1;                      /**< Cspi Frame info1 Register,           offset: 0x34 */
        __IO uint32_t CSPIDBG;                        /**< Cspi Debug Register,                 offset: 0x38 */
        __IO uint32_t CSPINIT;                        /**< Cspi Init Register,                  offset: 0x3c */
        __IO uint32_t CLSP;                           /**< Cspi Line Start Register,            offset: 0x40 */
        __IO uint32_t CDATP;                          /**< Cspi Data Packet Register,           offset: 0x44 */
        __IO uint32_t CLINFO;                         /**< Cspi Line Info Register,             offset: 0x48 */
    }regsBackup;
} cspiDataBase_t;

static cspiDataBase_t cspiDataBase[CSPI_INSTANCE_NUM] = {0};

/**
  \fn        static void cspiEnterLowPowerStatePrepare(void* pdata, slpManLpState state)
  \brief     Perform necessary preparations before sleep.
             After recovering from SLPMAN_SLEEP1_STATE, CSPI hareware is repowered, we backup
             some registers here first so that we can restore user's configurations after exit.
  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state
 */
static void cspiEnterLpStatePrepare(void* pdata, slpManLpState state)
{
    uint32_t i;

    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            for(i = 0; i < CSPI_INSTANCE_NUM; i++)
            {
                if(cspiDataBase[i].isInited == true)
                {
                    cspiDataBase[i].regsBackup.DFMT         = cspiInstance[i]->DFMT;
                    cspiDataBase[i].regsBackup.SLOTCTL      = cspiInstance[i]->SLOTCTL;
                    cspiDataBase[i].regsBackup.CLKCTL       = cspiInstance[i]->CLKCTL;
                    cspiDataBase[i].regsBackup.DMACTL       = cspiInstance[i]->DMACTL;
                    cspiDataBase[i].regsBackup.INTCTL       = cspiInstance[i]->INTCTL;
                    cspiDataBase[i].regsBackup.TIMEOUTCTL   = cspiInstance[i]->TIMEOUTCTL;
                    cspiDataBase[i].regsBackup.STAS         = cspiInstance[i]->STAS;
                    cspiDataBase[i].regsBackup.CSPICTL      = cspiInstance[i]->CSPICTL;
                    cspiDataBase[i].regsBackup.CCTL         = cspiInstance[i]->CCTL;
                    cspiDataBase[i].regsBackup.CSPIINFO0    = cspiInstance[i]->CSPIINFO0;
                    cspiDataBase[i].regsBackup.CSPIINFO1    = cspiInstance[i]->CSPIINFO1;
                    cspiDataBase[i].regsBackup.CSPIDBG      = cspiInstance[i]->CSPIDBG;
                    cspiDataBase[i].regsBackup.CSPINIT      = cspiInstance[i]->CSPINIT;
                    cspiDataBase[i].regsBackup.CLSP         = cspiInstance[i]->CLSP;
                    cspiDataBase[i].regsBackup.CDATP        = cspiInstance[i]->CDATP;
                    cspiDataBase[i].regsBackup.CLINFO       = cspiInstance[i]->CLINFO;
                }
            }
            break;
        default:
            break;
    }
}

/**
  \fn        static void cspiExitLowPowerStateRestore(void* pdata, slpManLpState state)
  \brief     Restore after exit from sleep.
             After recovering from SLPMAN_SLEEP1_STATE, CSPI hareware is repowered, we restore user's configurations
             by aidding of the stored registers.
  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state
 */
static void cspiExitLpStateRestore(void* pdata, slpManLpState state)
{
    uint32_t i;

    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            for(i = 0; i < CSPI_INSTANCE_NUM; i++)
            {
                if(cspiDataBase[i].isInited == true)
                {
                    GPR_clockEnable(cspiClk[2*i]);
                    GPR_clockEnable(cspiClk[2*i+1]);

                    cspiInstance[i]->DFMT       = cspiDataBase[i].regsBackup.DFMT;
                    cspiInstance[i]->SLOTCTL    = cspiDataBase[i].regsBackup.SLOTCTL;
                    cspiInstance[i]->CLKCTL     = cspiDataBase[i].regsBackup.CLKCTL;
                    cspiInstance[i]->DMACTL     = cspiDataBase[i].regsBackup.DMACTL;
                    cspiInstance[i]->INTCTL     = cspiDataBase[i].regsBackup.INTCTL;
                    cspiInstance[i]->TIMEOUTCTL = cspiDataBase[i].regsBackup.TIMEOUTCTL;
                    cspiInstance[i]->STAS       = cspiDataBase[i].regsBackup.STAS;
                    cspiInstance[i]->CSPICTL    = cspiDataBase[i].regsBackup.CSPICTL;
                    cspiInstance[i]->CCTL       = cspiDataBase[i].regsBackup.CCTL;
                    cspiInstance[i]->CSPIINFO0  = cspiDataBase[i].regsBackup.CSPIINFO0;
                    cspiInstance[i]->CSPIINFO1  = cspiDataBase[i].regsBackup.CSPIINFO1;
                    cspiInstance[i]->CSPIDBG    = cspiDataBase[i].regsBackup.CSPIDBG;
                    cspiInstance[i]->CSPINIT    = cspiDataBase[i].regsBackup.CSPINIT;
                    cspiInstance[i]->CLSP       = cspiDataBase[i].regsBackup.CLSP;
                    cspiInstance[i]->CDATP      = cspiDataBase[i].regsBackup.CDATP;
                    cspiInstance[i]->CLINFO     = cspiDataBase[i].regsBackup.CLINFO;
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
                                        cspiWorkingStats |= (1U << instance);                   \
                                        slpManDrvVoteSleep(SLP_VOTE_I2S, SLP_ACTIVE_STATE);     \
                                    }                                                           \
                                    while(0)

#define  CHECK_TO_UNLOCK_SLEEP(instance)                                                        \
                                    do                                                          \
                                    {                                                           \
                                        cspiWorkingStats &= ~(1U << instance);                  \
                                        if(cspiWorkingStats == 0)                               \
                                            slpManDrvVoteSleep(SLP_VOTE_I2S, SLP_SLP1_STATE);   \
                                    }                                                           \
                                    while(0)
#endif

#if (RTE_CSPI0)
static cspiInfo_t  cspi0Info = {0};
void cspi0DmaRxEvent(uint32_t event);
static DmaDescriptor_t __ALIGNED(16) cspi0DmaRxDesc[CAM_CHAIN_COUNT];
static cspiDma_t cspi0Dma =
{
    DMA_INSTANCE_MP,
    -1,
    RTE_CSPI0_DMA_RX_REQID,
    cspi0DmaRxEvent,
    cspi0DmaRxDesc
};

static cspiRes_t cspi0Res = {
    CSPI0,
    {
        &cspi0PinMCLK,
        &cspi0PinPCLK,
        &cspi0PinCS,
        &cspi0PinSdo0,
        &cspi0PinSdo1,
    },
    &cspi0Dma,
    &cspi0Info
};
#endif

#if (RTE_CSPI1)
static cspiInfo_t cspi1Info = {0};
void cspi1DmaRxEvent(uint32_t event);
static DmaDescriptor_t __ALIGNED(16) cspi1DmaRxDesc[CAM_CHAIN_COUNT];
static cspiDma_t cspi1Dma =
{
    DMA_INSTANCE_MP,
    -1,
    RTE_CSPI1_DMA_RX_REQID,
    cspi1DmaRxEvent,
    cspi1DmaRxDesc
};

static cspiRes_t cspi1Res = {
    CSPI1,
    {
        &cspi1PinMCLK,
        &cspi1PinPCLK,
        &cspi1PinCS,
        &cspi1PinSdo0,
        &cspi1PinSdo1,
    },
    &cspi1Dma,
    &cspi1Info
};
#endif

/**
  \fn          static uint32_t cspiGetInstanceNum(cspiRes_t *cspi)
  \brief       Get instance number
  \param[in]   spi       Pointer to CSPI resources
  \returns     instance number
*/
static uint32_t cspiGetInstanceNum(cspiRes_t *cspi)
{
    return ((uint32_t)cspi->reg - (uint32_t)CSPI0) >> 12U;
}

/**
  \fn          static int32_t cspiSetBusSpeed(uint32_t bps, cspiRes_t *cspi)
  \brief       Set bus speed
  \param[in]   bps       bus speed to set
  \param[in]   spi       Pointer to SPI resources
  \return      \ref execution_status
*/
static int32_t cspiSetBusSpeed(camFrequence_e freq, cspiRes_t *cspi)
{
    uint32_t instance = cspiGetInstanceNum(cspi);
    uint32_t freqDivInteger = 0;
    uint32_t freqDivRatio = 0;

	switch(freq)
    {
		case CAM_6_5_M:
			freqDivInteger = 0x40;
			freqDivRatio = 0;
			break;

		case CAM_13_M:
			freqDivInteger = 0x20;
			freqDivRatio = 0;
			break;

		case CAM_25_5_M:
			freqDivInteger = 0x10;
			freqDivRatio = 0;
			break;

		case CAM_24_M:
			freqDivInteger = 0x11;
			freqDivRatio = 0;
			break;

		case CAM_20_M:
			freqDivInteger = 0x14;
			freqDivRatio = 0x666666;
			break;

		default:
			break;
    }

    if (instance == 0) // i2s0
    {
        GPR_clockEnable(FCLK_I2S0);

        GPR_fracDivOutCLkEnable(FRACDIV0_OUT0); // Fracdiv1_en 
        GPR_setFracDivOutClkDiv(FRACDIV0_OUT0, 1); // 4 div, from 408M -> 102M
        #if 1
        GPR_setMclkSrc(MCLK0, MCLK_SRC_FRACDIV0_OUT0); // Bmclk_sel1
        GPR_mclkEnable(MCLK0); // Mclk_oe1
        #else
        GPR_setMclkSrc(MCLK2, MCLK_SRC_FRACDIV1_OUT0); // Bmclk_sel1
        GPR_mclkEnable(MCLK2);
        #endif
        GPR_setClockSrc(CLK_CC, CLK_CC_SEL_204M); // 0x4d000020 = 0x201

        // Fracdiv clk selects 408M and set frac and integer clk
        FracDivConfig_t fracdivCfg;
        fracdivCfg.source = FRACDIC_ROOT_CLK_408M;
        fracdivCfg.fracDiv0DivRatioInteger = freqDivInteger;//0x10;//51M 0x10; // 25.5M
        fracdivCfg.fracDiv0DivRatioFrac = freqDivRatio;
        GPR_setFracDivConfig(&fracdivCfg);
    }
    else // i2s1
    {
        GPR_clockEnable(FCLK_I2S1);
        GPR_fracDivOutCLkEnable(FRACDIV1_OUT0); // Fracdiv1_en 
        GPR_setFracDivOutClkDiv(FRACDIV1_OUT0, 1); // 4 div, from 408M -> 102M
        #if 1
        GPR_setMclkSrc(MCLK1, MCLK_SRC_FRACDIV1_OUT0); // Bmclk_sel1
        GPR_mclkEnable(MCLK1); // Mclk_oe1
        #else
        GPR_setMclkSrc(MCLK2, MCLK_SRC_FRACDIV1_OUT0); // Bmclk_sel1
        GPR_mclkEnable(MCLK2);
        #endif
        GPR_setClockSrc(CLK_CC, CLK_CC_SEL_204M); // 0x4d000020 = 0x201

        // Fracdiv clk selects 408M and set frac and integer clk
        FracDivConfig_t fracdivCfg;
        fracdivCfg.source = FRACDIC_ROOT_CLK_408M;
        fracdivCfg.fracDiv1DivRatioInteger = freqDivInteger;//0x10;//51M 0x10; // 25.5M
        fracdivCfg.fracDiv1DivRatioFrac = freqDivRatio;
        GPR_setFracDivConfig(&fracdivCfg);
    }

    return ARM_DRIVER_OK;
}

/**
  \fn          int32_t cspiInit(cspiCbEvent_fn cbEvent, cspiRes_t *cspi)
  \brief       Initialize SPI Interface.
  \param[in]   cbEvent  Pointer to \ref cspiCbEvent_fn
  \param[in]   spi       Pointer to CSPI resources
  \return      \ref execution_status
*/
int32_t cspiInit(cspiCbEvent_fn cbEvent, cspiRes_t *cspi)
{
    int32_t returnCode;
    PadConfig_t config;
    uint32_t instance = cspiGetInstanceNum(cspi);

#ifdef PM_FEATURE_ENABLE
    cspiDataBase[instance].isInited = true;
#endif

    // Initialize CSPI PINS
    PAD_getDefaultConfig(&config);
    #if 1 // I2S1
    config.mux = cspi->pins.mclk->funcNum;
    PAD_setPinConfig(cspi->pins.mclk->pinNum, &config);
    #else // MCLK2
	config.mux = PAD_MUX_ALT1;
    PAD_setPinConfig(14, &config);
    #endif
    config.mux = cspi->pins.pclk->funcNum;
    PAD_setPinConfig(cspi->pins.pclk->pinNum, &config);
    config.mux = cspi->pins.cs->funcNum;
    PAD_setPinConfig(cspi->pins.cs->pinNum, &config);
    config.mux = cspi->pins.sdo0->funcNum;
    PAD_setPinConfig(cspi->pins.sdo0->pinNum, &config);
    config.mux = cspi->pins.sdo1->funcNum;
    PAD_setPinConfig(cspi->pins.sdo1->pinNum, &config);

    // Initialize SPI run-time resources
    cspi->info->cbEvent     = cbEvent;

    // Configure DMA if necessary
    if (cspi->dma)
    {
        DMA_init(cspi->dma->rxInstance);
        returnCode = DMA_openChannel(cspi->dma->rxInstance);

        if (returnCode == ARM_DMA_ERROR_CHANNEL_ALLOC)
            return ARM_DRIVER_ERROR;
        else
            cspi->dma->rxCh = returnCode;

        DMA_setChannelRequestSource(cspi->dma->rxInstance, cspi->dma->rxCh, (DmaRequestSource_e)cspi->dma->rxReq);
        DMA_rigisterChannelCallback(cspi->dma->rxInstance, cspi->dma->rxCh, cspi->dma->rxCb);

		// Configure rx DMA and start it      
        g_dmaRxConfig.sourceAddress = (void *)&(cspiInstance[instance]->RFIFO);
        g_dmaRxConfig.totalLength   = CSPI_TRANSFER_TRUNK_SIZE;
        
        DMA_enableChannelInterrupts(cspi->dma->rxInstance, cspi->dma->rxCh, DMA_END_INTERRUPT_ENABLE);
        DMA_startChannel(cspi->dma->rxInstance, cspi->dma->rxCh);
    }

#ifdef PM_FEATURE_ENABLE
    cspiInitCnt++;

    if(cspiInitCnt == 1U)
    {
        cspiWorkingStats = 0;
        slpManRegisterPredefinedBackupCb(SLP_CALLBACK_I2S_MODULE, cspiEnterLpStatePrepare, NULL);
        slpManRegisterPredefinedRestoreCb(SLP_CALLBACK_I2S_MODULE, cspiExitLpStateRestore, NULL);
    }
#endif

    return ARM_DRIVER_OK;
}


/**
  \fn          int32_t cspiDeInit(cspiRes_t *cspi)
  \brief       De-initialize CSPI Interface.
  \param[in]   spi  Pointer to CSPI resources
  \return      \ref execution_status
*/
int32_t cspiDeInit(cspiRes_t *cspi)
{
#ifdef PM_FEATURE_ENABLE
    uint32_t instance;

    instance = cspiGetInstanceNum(cspi);

    cspiDataBase[instance].isInited = false;

    cspiInitCnt--;

    if(cspiInitCnt == 0)
    {
        cspiWorkingStats = 0;
        slpManUnregisterPredefinedBackupCb(SLP_CALLBACK_I2S_MODULE);
        slpManUnregisterPredefinedRestoreCb(SLP_CALLBACK_I2S_MODULE);
    }
#endif

    return ARM_DRIVER_OK;
}


/**
  \fn          int32_t cspiPowerControl(cspiPowerState_e state, cspiRes_t *cspi)
  \brief       Control CSPI Interface Power.
  \param[in]   state  Power state
  \param[in]   cspi    Pointer to CSPI resources
  \return      \ref execution_status
*/
int32_t cspiPowerCtrl(cspiPowerState_e state, cspiRes_t *cspi)
{
    uint32_t instance = cspiGetInstanceNum(cspi);

    switch (state)
    {
        case CSPI_POWER_OFF:
            // DMA disable
            if(cspi->dma)
            {
                DMA_stopChannel(cspi->dma->rxInstance, cspi->dma->rxCh, true);
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


            // Disable CSPI clock
            GPR_clockDisable(cspiClk[instance*2]);
            GPR_clockDisable(cspiClk[instance*2+1]);

            cspi->info->flags &= ~CSPI_FLAG_POWERED;
            break;

        case CSPI_POWER_FULL:
            //if ((cspi->info->flags & CSPI_FLAG_INITIALIZED) == 0)
                //return ARM_DRIVER_ERROR;

            if (cspi->info->flags & CSPI_FLAG_POWERED)
                return ARM_DRIVER_OK;

            // Enable CSPI clock            
            GPR_clockEnable(cspiClk[instance*2]);
            GPR_clockEnable(cspiClk[instance*2+1]);

            GPR_swReset(cspiRstClk[instance*2]);
            GPR_swReset(cspiRstClk[instance*2+1]);

            // Set power flag
            cspi->info->flags |= CSPI_FLAG_POWERED;

            break;

        default:
            return ARM_DRIVER_ERROR_UNSUPPORTED;
    }
    return ARM_DRIVER_OK;
}

/**
  \fn          int32_t cspiReceive(void *data, uint32_t num, cspiRes_t *cspi)
  \brief       Start receiving data from SPI receiver.
  \param[out]  dataIn  Pointer to buffer for data to receive from CSPI receiver
  \param[in]   num   Number of data items to receive
  \param[in]   cspi   Pointer to CSPI resources
  \return      \ref execution_status
*/
int32_t cspiRecv(cspiRes_t *cspi)
{
	DMA_buildDescriptorChain(cspi->dma->descriptor, &g_dmaRxConfig, cspi->info->resolution, true);
	DMA_loadChannelDescriptorAndRun(cspi->dma->rxInstance, cspi->dma->rxCh, cspi->dma->descriptor);
	
    return ARM_DRIVER_OK;
}

/**
  \fn          int32_t cspiControl(uint32_t control, uint32_t arg, cspiRes_t *cspi)
  \brief       Control CSPI Interface.
  \param[in]   control  Operation
  \param[in]   arg      Argument of operation (optional)
  \param[in]   cspi      Pointer to CSPI resources
  \return      common \ref execution_status and driver specific \ref spi_execution_status
*/
int32_t cspiControl(uint32_t control, uint32_t arg, cspiRes_t *cspi)
{
    uint32_t instance = cspiGetInstanceNum(cspi);

    switch(control & 0xFFFFFFFF)
    {
        // Set transport abort
        case CSPI_CTRL_TRANSABORT:
        {
            // If DMA mode, disable DMA channel
            if(cspi->dma)
            {
                DMA_stopChannel(cspi->dma->rxInstance, cspi->dma->rxCh, true);
            }

            // clear SPI run-time resources
            cspi->reg->CSPICTL &= ~CSPI_ENABLE_Msk;

            break;
        }

        // Set Bus Speed in bps; arg = value
        case CSPI_CTRL_BUS_SPEED:
        {
            if(cspiSetBusSpeed((camFrequence_e)arg, cspi) != ARM_DRIVER_OK)
            {
                return ARM_DRIVER_ERROR;
            }
            break;
        }

        // Set Data Format
        case CSPI_CTRL_DATA_FORMAT:
        {
            memcpy((void*)&(cspiInstance[instance]->DFMT), &cspiDataFmt, sizeof(cspiDataFmt_t));
            break;
        }		

		// Flush rx fifo
		case CSPI_CTRL_FLUSH_RX_FIFO:
        {
        	cspiInstance[instance]->DMACTL |= 0x1000000;
			break;
        }

        
		// Set Int En
        case CSPI_CTRL_INT_CTRL:
        {
            memcpy((void*)&(cspiInstance[instance]->INTCTL), &cspiIntCtrl, sizeof(cspiIntCtrl_t));
            break;
        }

        // Set recv mem addr
        case CSPI_CTRL_MEM_ADDR:
        {
			g_dmaRxConfig.targetAddress = (void*)arg; // dma gloval val. After this need call "CSPI_CTRL_DMA_CTRL"
			break;
        }

        // Set Rx Timeout Cycle
        case CSPI_CTRL_RXTOR:
        {
            memcpy((void*)&(cspiInstance[instance]->TIMEOUTCTL), &cspiRxTimeOutCycle, sizeof(cspiTimeOutCycle_t));
            break;
        }

        // Set DMA Control
        case CSPI_CTRL_DMA_CTRL:
        {
            //dmaInit(cspi);
            memcpy((void*)&(cspiInstance[instance]->DMACTL), &cspiDmaCtrl, sizeof(cspiDmaCtrl_t));
            break;
        }

        // Set CSPI Control
        case CSPI_CTRL_CSPICTL:
        {
            memcpy((void*)&(cspiInstance[instance]->CSPICTL), &cspiCtrl, sizeof(cspiCtrl_t));
            break;
        }

		// Enable or disable cspi
        case CSPI_CTRL_START_STOP:
        {
        	if (arg > 0)
        	{
				cspiInstance[instance]->CSPICTL |= CSPI_ENABLE_Msk;
        	}
        	else
        	{
				cspiInstance[instance]->CSPICTL &= ~CSPI_ENABLE_Msk;
        	}
            break;
        }

        // Set Frame Info0
        case CSPI_CTRL_FRAME_INFO0:
        {
            memcpy((void*)&(cspiInstance[instance]->CSPIINFO0), &cspiFrameInfo0, sizeof(cspiFrameInfo0_t));
            break;
        }

		// Camera resolution set
		case CSPI_CTRL_RESOLUTION_SET:
        {
        	cspi->info->resolution = (camResolution_e)arg; // this will interface the dma descriptor chain count
			break;
        }

        default:
            return ARM_DRIVER_ERROR_UNSUPPORTED;
    }
    return ARM_DRIVER_OK;
}


/**
  \fn          void cspiDmaRxEvent(uint32_t event, cspiRes_t *cspi)
  \brief       CSPI DMA Rx Event handler.
  \param[in]   event DMA Rx Event
  \param[in]   spi   Pointer to CSPI resources
*/
void cspiDmaRxEvent(uint32_t event, cspiRes_t *cspi)
{
#ifdef PM_FEATURE_ENABLE
    uint32_t instance = cspiGetInstanceNum(cspi);
#endif

    switch(event)
    {
        case DMA_EVENT_END:           
            //cspi->reg->CSPICTL &= ~CSPI_ENABLE_Msk; // must close cspi here

            if(cspi->info->cbEvent)
            {
                cspi->info->cbEvent(ARM_SPI_EVENT_TRANSFER_COMPLETE);
            }
#ifdef PM_FEATURE_ENABLE
             CHECK_TO_UNLOCK_SLEEP(instance);
#endif
            break;

        default:
            break;
    }
}

#if (RTE_CSPI0)

static int32_t cspi0Init(cspiCbEvent_fn cbEvent)
{
    return cspiInit(cbEvent, &cspi0Res);
}
static int32_t cspi0Deinit(void)
{
    return cspiDeInit(&cspi0Res);
}
static int32_t cspi0PowerCtrl(cspiPowerState_e state)
{
    return cspiPowerCtrl(state, &cspi0Res);
}

static int32_t cspi0Recv(void)
{
    return cspiRecv(&cspi0Res);
}

static int32_t cspi0Ctrl(uint32_t control, uint32_t arg)
{
    return cspiControl(control, arg, &cspi0Res);
}

void cspi0DmaRxEvent(uint32_t event)
{
    cspiDmaRxEvent(event, &cspi0Res);
}

// CSPI0 Driver Control Block
cspiDrvInterface_t cspiDrvInterface0 = {
    cspi0Init,
    cspi0Deinit,
    cspi0PowerCtrl,
    cspi0Recv,
    cspi0Ctrl,
};

#endif

#if (RTE_CSPI1)
static int32_t cspi1Init(cspiCbEvent_fn cbEvent)
{
    return cspiInit(cbEvent, &cspi1Res);
}
static int32_t cspi1Deinit(void)
{
    return cspiDeInit(&cspi1Res);
}
static int32_t cspi1PowerCtrl(cspiPowerState_e state)
{
    return cspiPowerCtrl(state, &cspi1Res);
}

static int32_t cspi1Recv(void)
{
    return cspiRecv(&cspi1Res);
}

static int32_t cspi1Ctrl(uint32_t control, uint32_t arg)
{
    return cspiControl(control, arg, &cspi1Res);
}

void cspi1DmaRxEvent(uint32_t event)
{
    cspiDmaRxEvent(event, &cspi1Res);
}

// CSPI1 Driver Control Block
cspiDrvInterface_t cspiDrvInterface1 = {
    cspi1Init,
    cspi1Deinit,
    cspi1PowerCtrl,
    cspi1Recv,
    cspi1Ctrl,
};

#endif

