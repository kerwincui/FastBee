/*
 * Copyright (c) 2013-2016 ARM Limited. All rights reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the License); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an AS IS BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include "Driver_Common.h"
#include "bsp_lpusart.h"
#include "slpman.h"

#ifdef PM_FEATURE_ENABLE

#include DEBUG_LOG_HEADER_FILE
#define LPUSART_DRIVER_DEBUG  1

#endif

//#pragma push
//#pragma O0

#define ARM_LPUSART_DRV_VERSION    ARM_DRIVER_VERSION_MAJOR_MINOR(2, 0)  /* driver version */

#if (!RTE_UART1)
#error "Cooperating UART not enabled in RTE_Device.h!"
#endif

#define CO_USART_DMA_BURST_SIZE  (8)
#define LPUSART_RX_TRIG_LVL      (8)

#ifdef PM_FEATURE_ENABLE
/** \brief Internal used data structure */
typedef struct _lpusart_database
{
    bool                            isInited;            /**< Whether usart has been initialized */
    struct
    {
        uint32_t DLL;                                    /**< Divisor Latch Low */
        uint32_t DLH;                                    /**< Divisor Latch High */
        uint32_t IER;                                    /**< Interrupt Enable Register */
        uint32_t FCR;                                    /**< FIFO Control Register */
        uint32_t LCR;                                    /**< Line Control Register */
        uint32_t MCR;                                    /**< Modem Control Register */
        uint32_t MFCR;                                   /**< Main Function Control Register */
        uint32_t EFCR;                                   /**< Extended Function Control Register */
    } co_usart_registers;                                /**< Backup registers for low power restore */
    struct
    {
        uint32_t TCR;                                    /**< Timeout Control Register,                 offset: 0x4 */
        uint32_t FCSR;                                   /**< FIFO Control and Status Register,         offset: 0xC */
        uint32_t IER;                                    /**< Interrupt Enable Register,                offset: 0x10 */
    } core_registers;
    bool     autoBaudRateDone;                           /**< Flag indication whether auto baud dection is done */
} lpusart_database_t;

static lpusart_database_t g_lpusartDataBase = {0};

#endif

#ifdef PM_FEATURE_ENABLE
/**
  \brief Bitmap of LPUSART working status */
static uint32_t g_lpusartWorkingStatus = 0;

/**
  \fn        static void LPUSART_EnterLowPowerStatePrepare(void* pdata, slpManLpState state)
  \brief     Perform necessary preparations before sleep.
             After recovering from SLPMAN_SLEEP1_STATE, LPUSART hareware is repowered, we backup
             some registers here first so that we can restore user's configurations after exit.
  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state
 */
static void LPUSART_EnterLowPowerStatePrepare(void* pdata, slpManLpState state)
{
    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            if(g_lpusartDataBase.isInited == true)
            {
                g_lpusartDataBase.co_usart_registers.IER = USART_1->IER;
                g_lpusartDataBase.co_usart_registers.LCR = USART_1->LCR;
                g_lpusartDataBase.co_usart_registers.MCR = USART_1->MCR;
                g_lpusartDataBase.co_usart_registers.MFCR = USART_1->MFCR;
                g_lpusartDataBase.co_usart_registers.EFCR = USART_1->EFCR;

                g_lpusartDataBase.core_registers.TCR = LPUSART_CORE->TCR;
                g_lpusartDataBase.core_registers.FCSR = LPUSART_CORE->FCSR;
                g_lpusartDataBase.core_registers.IER = LPUSART_CORE->IER;
            }
            break;
        default:
            break;
    }

}

extern bool apmuGetSleepedFlag(void);

/**
  \fn        static void LPUSART_ExitLowPowerStateRestore(void* pdata, slpManLpState state)
  \brief     Restore after exit from sleep.
             After recovering from SLPMAN_SLEEP1_STATE, LPUSART hareware is repowered, we restore user's configurations
             by aidding of the stored registers.

  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state

 */
static void LPUSART_ExitLowPowerStateRestore(void* pdata, slpManLpState state)
{
    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            // no need to restore if failing to sleep

            if(apmuGetSleepedFlag() == false)
            {
                break;
            }

            if(g_lpusartDataBase.isInited == true)
            {
                GPR_clockEnable(PCLK_UART1);
                GPR_clockEnable(FCLK_UART1);

                USART_1->LCR |= USART_LCR_ACCESS_DIVISOR_LATCH_Msk;
                USART_1->DLL = g_lpusartDataBase.co_usart_registers.DLL;
                USART_1->DLH = g_lpusartDataBase.co_usart_registers.DLH;

                USART_1->LCR &= ~USART_LCR_ACCESS_DIVISOR_LATCH_Msk;
                USART_1->IER = g_lpusartDataBase.co_usart_registers.IER;
                USART_1->LCR = g_lpusartDataBase.co_usart_registers.LCR;
                USART_1->MCR = g_lpusartDataBase.co_usart_registers.MCR;
                USART_1->EFCR = g_lpusartDataBase.co_usart_registers.EFCR;
                USART_1->FCR = g_lpusartDataBase.co_usart_registers.FCR;
                USART_1->MFCR = g_lpusartDataBase.co_usart_registers.MFCR;

                LPUSART_CORE->DCR = LPUSARTCORE_DCR_RX_REQ_EN_Msk;
                LPUSART_CORE->TCR = (LPUSARTCORE_TCR_TOCNT_SWTRG_Msk | g_lpusartDataBase.core_registers.TCR);
                LPUSART_CORE->IER = g_lpusartDataBase.core_registers.IER;
            }

            break;

        default:
            break;
    }

}

#define  LOCK_SLEEP(tx, rx)     do                                                                        \
                                          {                                                               \
                                              g_lpusartWorkingStatus |= (rx);                             \
                                              g_lpusartWorkingStatus |= (tx << 1);                        \
                                              slpManDrvVoteSleep(SLP_VOTE_LPUSART, SLP_ACTIVE_STATE);     \
                                          }                                                               \
                                          while(0)

#define  CHECK_TO_UNLOCK_SLEEP(tx, rx)      do                                                              \
                                                      {                                                     \
                                                          g_lpusartWorkingStatus &= ~(rx);                  \
                                                          g_lpusartWorkingStatus &= ~(tx << 1);             \
                                                          if(g_lpusartWorkingStatus == 0)                   \
                                                          {                                                 \
                                                              NVIC_ClearPendingIRQ(LpuartWakeup_IRQn);                    \
                                                              slpManDrvVoteSleep(SLP_VOTE_LPUSART, SLP_SLP1_STATE);       \
                                                          }                                                               \
                                                      }                                                                   \
                                                      while(0)
#endif

#define  LPUSART_AON_REGISTER_WRITE(register, value)      do                                                      \
                                                          {                                                       \
                                                              (register) = (value);                               \
                                                              while((register) != (value));                       \
                                                          }                                                       \
                                                          while(0)
#define LPUSART_AON_CR1_ENABLE                            (LPUSARTAON_CR1_ENABLE_Msk | LPUSARTAON_CR1_ACG_EN_Msk)

// declearation for DMA API
extern void DMA_stopChannelNoWait(DmaInstance_e instance, uint32_t channel);
extern uint32_t DMA_setDescriptorTransferLen(uint32_t dcmd, uint32_t len);
extern void DMA_loadChannelDescriptorAndRun(DmaInstance_e instance, uint32_t channel, void* descriptorAddress);
extern uint32_t DMA_getChannelCurrentTargetAddress(DmaInstance_e instance, uint32_t channel, bool sync);
extern void DMA_buildDescriptor(DmaDescriptor_t* descriptor, const DmaTransferConfig_t* config, const DmaExtraConfig_t* extraConfig);

// Driver Version
static const ARM_DRIVER_VERSION DriverVersion = {
    ARM_USART_API_VERSION,
    ARM_LPUSART_DRV_VERSION
};

// Driver Capabilities
static const ARM_USART_CAPABILITIES DriverCapabilities = {
    1, /* supports UART (Asynchronous) mode */
    0, /* supports Synchronous Master mode */
    0, /* supports Synchronous Slave mode */
    0, /* supports UART Single-wire mode */
    0, /* supports UART IrDA mode */
    0, /* supports UART Smart Card mode */
    0, /* Smart Card Clock generator available */
    0, /* RTS Flow Control available */
    0, /* CTS Flow Control available */
    0, /* Transmit completed event: \ref ARM_USART_EVENT_TX_COMPLETE */
    0, /* Signal receive character timeout event: \ref ARM_USART_EVENT_RX_TIMEOUT */
    0, /* RTS Line: 0=not available, 1=available */
    0, /* CTS Line: 0=not available, 1=available */
    0, /* DTR Line: 0=not available, 1=available */
    0, /* DSR Line: 0=not available, 1=available */
    0, /* DCD Line: 0=not available, 1=available */
    0, /* RI Line: 0=not available, 1=available */
    0, /* Signal CTS change event: \ref ARM_USART_EVENT_CTS */
    0, /* Signal DSR change event: \ref ARM_USART_EVENT_DSR */
    0, /* Signal DCD change event: \ref ARM_USART_EVENT_DCD */
    0  /* Signal RI change event: \ref ARM_USART_EVENT_RI */
};

void LPUSART1_IRQHandler(void);
void CO_USART1_IRQHandler(void);

#if (RTE_UART1)

static LPUSART_INFO    LPUSART1_Info  = { 0 };
static const PIN LPUSART1_pin_tx  = {RTE_UART1_TX_BIT,   RTE_UART1_TX_FUNC};
static const PIN LPUSART1_pin_rx  = {RTE_UART1_RX_BIT,   RTE_UART1_RX_FUNC};
#if (RTE_UART1_CTS_PIN_EN == 1)
static const PIN LPUSART1_pin_cts = {RTE_UART1_CTS_BIT,  RTE_UART1_CTS_FUNC};
#endif
#if (RTE_UART1_RTS_PIN_EN == 1)
static const PIN LPUSART1_pin_rts = {RTE_UART1_RTS_BIT,  RTE_UART1_RTS_FUNC};
#endif

#if (RTE_UART1_TX_IO_MODE == DMA_MODE)

void LPUSART1_DmaTxEvent(uint32_t event);
static LPUSART_TX_DMA LPUSART1_DMA_Tx = {
                                    DMA_INSTANCE_MP,
                                    -1,
                                    RTE_UART1_DMA_TX_REQID,
                                    LPUSART1_DmaTxEvent
                                 };
#endif

#if (RTE_UART1_RX_IO_MODE == DMA_MODE)

void CO_USART1_DmaRxEvent(uint32_t event);
static DmaDescriptor_t __ALIGNED(16) CO_USART1_DMA_Rx_Descriptor[2];

static LPUSART_RX_DMA CO_USART1_DMA_Rx = {
                                    DMA_INSTANCE_MP,
                                    -1,
                                    RTE_UART1_DMA_RX_REQID,
                                    CO_USART1_DMA_Rx_Descriptor,
                                    CO_USART1_DmaRxEvent
                                 };

static DmaDescriptor_t __ALIGNED(16) LPUSART1_DMA_Rx_Descriptor;

static LPUSART_RX_DMA LPUSART1_DMA_Rx = {
                                    DMA_INSTANCE_MP,
                                    -1,
                                    DMA_REQUEST_LPUSART_RX,
                                    &LPUSART1_DMA_Rx_Descriptor,
                                    NULL
                                 };

#endif

#if (RTE_UART1_TX_IO_MODE == IRQ_MODE) || (RTE_UART1_RX_IO_MODE == IRQ_MODE) || (RTE_UART1_RX_IO_MODE == DMA_MODE)
static LPUSART_IRQ CO_USART1_IRQ = {
                                PXIC0_UART1_IRQn,
                                CO_USART1_IRQHandler
                              };

static LPUSART_IRQ LPUSART1_IRQ = {
                                PXIC0_LPUC_IRQn,
                                LPUSART1_IRQHandler
                              };
#endif

static const LPUSART_RESOURCES LPUSART1_Resources = {
    USART_1,
    LPUSART_AON,
    LPUSART_CORE,
    {
      &LPUSART1_pin_tx,
      &LPUSART1_pin_rx,
#if (RTE_UART1_CTS_PIN_EN == 1)
      &LPUSART1_pin_cts,
#else
      NULL,
#endif
#if (RTE_UART1_RTS_PIN_EN == 1)
      &LPUSART1_pin_rts,
#else
      NULL,
#endif
    },

#if (RTE_UART1_RX_IO_MODE == DMA_MODE)
    &LPUSART1_DMA_Rx,
#else
    NULL,
#endif

#if (RTE_UART1_TX_IO_MODE == DMA_MODE)
    &LPUSART1_DMA_Tx,
#else
    NULL,
#endif

#if (RTE_UART1_RX_IO_MODE == DMA_MODE)
    &CO_USART1_DMA_Rx,
#else
    NULL,
#endif

#if (RTE_UART1_TX_IO_MODE == IRQ_MODE) || (RTE_UART1_RX_IO_MODE == IRQ_MODE) || (RTE_UART1_RX_IO_MODE == DMA_MODE)
    &LPUSART1_IRQ,
    &CO_USART1_IRQ,
#else
    NULL,
    NULL,
#endif
    &LPUSART1_Info
};
#endif


static DmaTransferConfig_t dmaTxConfig = {NULL, NULL,
                                       DMA_FLOW_CONTROL_TARGET, DMA_ADDRESS_INCREMENT_SOURCE,
                                       DMA_DATA_WIDTH_ONE_BYTE, DMA_BURST_16_BYTES, 0
                                      };

ARM_DRIVER_VERSION LPUSART_GetVersion(void)
{
    return DriverVersion;
}

ARM_USART_CAPABILITIES LPUSART_GetCapabilities(void)
{
    return DriverCapabilities;
}

/*
 * when uart input clock is 26000000, the supported baudrate is:
 * 4800,9600,14400,19200,
 * 28800,38400,56000,57600,
 * 115200,230400,460800,921600,
 * 1000000,1500000,2000000,3000000
 */
int32_t LPUSART_SetBaudrate(uint32_t baudrate, LPUSART_RESOURCES *lpusart)
{
    uint8_t frac = 0;
    uint32_t uart_clock = 0;
    uint32_t div;
    int32_t i;

    if(lpusart->info->flags & LPUSART_FLAG_POWER_LOW)
    {
        const static uint16_t g_lpusartSupportedBaudRate[5] = {600, 1200, 2400, 4800, 9600};

        // timeout threshold is 24 bits, sample clock is 26M, threshold/26M = 24/baudrate
        const static uint32_t g_lpusartTimeoutValue[5] = {1040000, 520000, 260000, 130000, 65000};

        const static uint16_t g_lpusartDLRValue[5] = {1748, 874, 437, 218, 109};

        for(i = 0; i <= 4; i++)
        {
            if(baudrate == g_lpusartSupportedBaudRate[i])
            {
                if((lpusart->core_regs->FCSR & (LPUSARTCORE_FCSR_RXFIFO_EMPTY_Msk | LPUSARTCORE_FCSR_AON_RX_BUSY_Msk | LPUSARTCORE_FCSR_AON_RXFIFO_EMPTY_Msk)) == (LPUSARTCORE_FCSR_RXFIFO_EMPTY_Msk | LPUSARTCORE_FCSR_AON_RXFIFO_EMPTY_Msk))
                {
                    LPUSART_AON_REGISTER_WRITE(lpusart->aon_regs->CR0, LPUSARTAON_CR0_CLK_ENABLE_Msk);
                    LPUSART_AON_REGISTER_WRITE(lpusart->aon_regs->DLR, g_lpusartDLRValue[i]);
                }
                lpusart->core_regs->TCR |= LPUSARTCORE_TCR_TOCNT_SWCLR_Msk;
                lpusart->core_regs->TCR = g_lpusartTimeoutValue[i];
                lpusart->core_regs->TCR |= LPUSARTCORE_TCR_TOCNT_SWTRG_Msk;
                break;
            }
        }

        if(i > 5)
        {
            return ARM_DRIVER_ERROR_PARAMETER;
        }

    }

    if(baudrate == 0)
    {
        lpusart->co_usart_regs->ADCR = 0x3;
    }
    else
    {
        uart_clock = GPR_getClockFreq(FCLK_UART1);

        /*
         * formula to calculate baudrate, baudrate = clock_in / (prescalar * divisor_value),
         * where prescalar = MFCR_PRESCALE_FACTOR(4,8,16), divisor_value = DLH:DLL.EFCR_FRAC
         */
        for(i = 0; i <= 2; i++)
        {
            div = (1 << i) * uart_clock / baudrate;
            frac = div & 0xf;
            div >>= 4;
            // Integer part of divisor value shall not be zero, otherwise, the result is invalid
            if (div != 0)
                break;
        }

        if(i > 2)
            return ARM_DRIVER_ERROR_PARAMETER;

        // Disable uart first
        lpusart->co_usart_regs->MFCR &= ~USART_MFCR_UART_EN_Msk;

        // Enable latch bit to change divisor
        lpusart->co_usart_regs->LCR |= USART_LCR_ACCESS_DIVISOR_LATCH_Msk;
        lpusart->co_usart_regs->MFCR = ((lpusart->co_usart_regs->MFCR & ~USART_MFCR_PRESCALE_FACTOR_Msk) | EIGEN_VAL2FLD(USART_MFCR_PRESCALE_FACTOR, i));
        lpusart->co_usart_regs->DLL = (div >> 0) & 0xff;
        lpusart->co_usart_regs->DLH = (div >> 8) & 0xff;
        lpusart->co_usart_regs->EFCR = ((lpusart->co_usart_regs->EFCR & ~USART_EFCR_FRAC_DIVISOR_Msk) | (frac << USART_EFCR_FRAC_DIVISOR_Pos));
        // Reset latch bit
        lpusart->co_usart_regs->LCR &= (~USART_LCR_ACCESS_DIVISOR_LATCH_Msk);

#ifdef PM_FEATURE_ENABLE
        // backup setting
        g_lpusartDataBase.co_usart_registers.DLL = (div >> 0) & 0xff;
        g_lpusartDataBase.co_usart_registers.DLH = (div >> 8) & 0xff;
#endif

    }

    lpusart->info->baudrate = baudrate;

    return ARM_DRIVER_OK;
}

uint32_t LPUSART_GetBaudRate(LPUSART_RESOURCES *lpusart)
{
    return lpusart->info->baudrate;
}

/*
 * Check whether rx is ongoing, return true if rx is ongoing at this moment, otherwise false
 */
bool LPUSART_IsRxActive(void)
{
#ifdef PM_FEATURE_ENABLE
    if(LPUSART1_Info.flags & LPUSART_FLAG_POWER_LOW)
    {
        return !((LPUSART_CORE->FCSR & (LPUSARTCORE_FCSR_RXFIFO_EMPTY_Msk | LPUSARTCORE_FCSR_AON_RX_BUSY_Msk | LPUSARTCORE_FCSR_AON_RXFIFO_EMPTY_Msk)) == (LPUSARTCORE_FCSR_RXFIFO_EMPTY_Msk | LPUSARTCORE_FCSR_AON_RXFIFO_EMPTY_Msk));
    }
    else
    {
        return 0;
    }
#else
    return 0;
#endif
}

void LPUSART_ClearStopFlag(void)
{
#ifdef PM_FEATURE_ENABLE
    if(LPUSART1_Info.flags & LPUSART_FLAG_POWER_LOW)
    {
        LPUSART_AON->SCR = LPUSARTAON_SCR_STOP_SW_CLR_Msk;
        while(LPUSART_CORE->FCSR & LPUSARTCORE_FCSR_AON_STOP_FLAG_Msk);
        LPUSART_AON->SCR = 0;
    }
#endif
}

void LPUSART_SetStopFlag(void)
{
#ifdef PM_FEATURE_ENABLE
    if(LPUSART1_Info.flags & LPUSART_FLAG_POWER_LOW)
    {
        LPUSART_AON->SCR = LPUSARTAON_SCR_STOP_SW_SET_Msk;
        while((LPUSART_CORE->FCSR & LPUSARTCORE_FCSR_AON_STOP_FLAG_Msk) == 0);
        LPUSART_AON->SCR = 0;
    }
#endif
}

static void LPUSART_DMARxConfig(LPUSART_RESOURCES *lpusart, bool isLpuart)
{
    DmaTransferConfig_t dmaConfig;
    DmaExtraConfig_t extraConfig;

    dmaConfig.addressIncrement              = DMA_ADDRESS_INCREMENT_TARGET;
    dmaConfig.dataWidth                     = DMA_DATA_WIDTH_ONE_BYTE;
    dmaConfig.flowControl                   = DMA_FLOW_CONTROL_SOURCE;
    dmaConfig.targetAddress                 = NULL;

    if(isLpuart == true)
    {
        dmaConfig.burstSize                     = DMA_BURST_64_BYTES;
        dmaConfig.sourceAddress                 = (void*)&(lpusart->core_regs->RBR);
        dmaConfig.targetAddress                 = NULL;
        dmaConfig.totalLength                   = LPUSART_RX_TRIG_LVL - 1;
        extraConfig.stopDecriptorFetch          = true;
        extraConfig.enableStartInterrupt        = false;
        extraConfig.enableEndInterrupt          = false;
        extraConfig.nextDesriptorAddress        = lpusart->dma_rx->descriptor;

        DMA_buildDescriptor(lpusart->dma_rx->descriptor, &dmaConfig, &extraConfig);

        DMA_resetChannel(lpusart->dma_rx->instance, lpusart->dma_rx->channel);

    }
    else
    {
        dmaConfig.burstSize                     = DMA_BURST_8_BYTES;
        dmaConfig.sourceAddress                 = (void*)&(lpusart->co_usart_regs->RBR);
        dmaConfig.totalLength                   = CO_USART_DMA_BURST_SIZE;

        extraConfig.stopDecriptorFetch          = false;
        extraConfig.enableStartInterrupt        = false;
        extraConfig.enableEndInterrupt          = true;
        extraConfig.nextDesriptorAddress        = &lpusart->co_usart_dma_rx->descriptor[1];

        DMA_buildDescriptor(&lpusart->co_usart_dma_rx->descriptor[0], &dmaConfig, &extraConfig);

        extraConfig.stopDecriptorFetch          = true;
        extraConfig.nextDesriptorAddress        = &lpusart->co_usart_dma_rx->descriptor[0];

        DMA_buildDescriptor(&lpusart->co_usart_dma_rx->descriptor[1], &dmaConfig, &extraConfig);

        DMA_resetChannel(lpusart->co_usart_dma_rx->instance, lpusart->co_usart_dma_rx->channel);

    }
}

PLAT_PA_RAMCODE static void CO_USART_DmaUpdateRxConfig(LPUSART_RESOURCES *lpusart, uint32_t targetAddress, uint32_t num)
{
    uint32_t firstDescriptorLen = MIN(num, CO_USART_DMA_BURST_SIZE);

    lpusart->co_usart_dma_rx->descriptor[0].TAR = targetAddress;
    lpusart->co_usart_dma_rx->descriptor[0].CMDR = DMA_setDescriptorTransferLen(lpusart->co_usart_dma_rx->descriptor[1].CMDR, firstDescriptorLen);

    lpusart->co_usart_dma_rx->descriptor[1].TAR = lpusart->co_usart_dma_rx->descriptor[0].TAR + firstDescriptorLen;
    lpusart->co_usart_dma_rx->descriptor[1].CMDR = DMA_setDescriptorTransferLen(lpusart->co_usart_dma_rx->descriptor[1].CMDR, num - firstDescriptorLen);
}


int32_t LPUSART_Initialize(ARM_USART_SignalEvent_t cb_event, LPUSART_RESOURCES *lpusart)
{
    int32_t returnCode;

    if (lpusart->info->flags & LPUSART_FLAG_INITIALIZED)
        return ARM_DRIVER_OK;

    // Pin initialize
    PadConfig_t config;
    PAD_getDefaultConfig(&config);

    config.mux = lpusart->pins.pin_tx->funcNum;
    PAD_setPinConfig(lpusart->pins.pin_tx->pinNum, &config);

    config.pullSelect = PAD_PULL_INTERNAL;
    config.pullUpEnable = PAD_PULL_UP_ENABLE;
    config.pullDownEnable = PAD_PULL_DOWN_DISABLE;
    config.mux = lpusart->pins.pin_rx->funcNum;
    PAD_setPinConfig(lpusart->pins.pin_rx->pinNum, &config);

    if(lpusart->pins.pin_cts)
    {
        config.mux = lpusart->pins.pin_cts->funcNum;
        PAD_setPinConfig(lpusart->pins.pin_cts->pinNum, &config);
    }

    if(lpusart->pins.pin_rts)
    {
        config.mux = lpusart->pins.pin_rts->funcNum;
        PAD_setPinConfig(lpusart->pins.pin_rts->pinNum, &config);
    }

#ifdef PM_FEATURE_ENABLE
    g_lpusartDataBase.isInited = true;
#endif

    // Initialize LPUSART run-time resources
    lpusart->info->cb_event = cb_event;
    memset(&(lpusart->info->rx_status), 0, sizeof(LPUSART_STATUS));

    lpusart->info->xfer.send_active           = 0;
    lpusart->info->xfer.tx_def_val            = 0;

    if(lpusart->co_usart_dma_tx)
    {
        returnCode = DMA_openChannel(lpusart->co_usart_dma_tx->instance);

        if (returnCode == ARM_DMA_ERROR_CHANNEL_ALLOC)
            return ARM_DRIVER_ERROR;
        else
            lpusart->co_usart_dma_tx->channel = returnCode;

        DMA_setChannelRequestSource(lpusart->co_usart_dma_tx->instance, lpusart->co_usart_dma_tx->channel, (DmaRequestSource_e)lpusart->co_usart_dma_tx->request);
        DMA_rigisterChannelCallback(lpusart->co_usart_dma_tx->instance, lpusart->co_usart_dma_tx->channel, lpusart->co_usart_dma_tx->callback);
    }

    if(lpusart->co_usart_dma_rx)
    {
        returnCode = DMA_openChannel(lpusart->co_usart_dma_rx->instance);

        if (returnCode == ARM_DMA_ERROR_CHANNEL_ALLOC)
            return ARM_DRIVER_ERROR;
        else
            lpusart->co_usart_dma_rx->channel = returnCode;

        DMA_setChannelRequestSource(lpusart->co_usart_dma_rx->instance, lpusart->co_usart_dma_rx->channel, (DmaRequestSource_e)lpusart->co_usart_dma_rx->request);
        LPUSART_DMARxConfig(lpusart, false);
        DMA_rigisterChannelCallback(lpusart->co_usart_dma_rx->instance, lpusart->co_usart_dma_rx->channel, lpusart->co_usart_dma_rx->callback);
    }

    if(lpusart->dma_rx)
    {
        returnCode = DMA_openChannel(lpusart->dma_rx->instance);

        if (returnCode == ARM_DMA_ERROR_CHANNEL_ALLOC)
            return ARM_DRIVER_ERROR;
        else
            lpusart->dma_rx->channel = returnCode;

        DMA_setChannelRequestSource(lpusart->dma_rx->instance, lpusart->dma_rx->channel, (DmaRequestSource_e)lpusart->dma_rx->request);
        LPUSART_DMARxConfig(lpusart, true);
    }

    lpusart->info->flags = LPUSART_FLAG_INITIALIZED;  // LPUSART is initialized

#ifdef PM_FEATURE_ENABLE
    g_lpusartWorkingStatus = 0;
    slpManRegisterPredefinedBackupCb(SLP_CALLBACK_LPUSART_MODULE, LPUSART_EnterLowPowerStatePrepare, NULL);
    slpManRegisterPredefinedRestoreCb(SLP_CALLBACK_LPUSART_MODULE, LPUSART_ExitLowPowerStateRestore, NULL);
#endif
    return ARM_DRIVER_OK;
}

int32_t LPUSART_Uninitialize(LPUSART_RESOURCES *lpusart)
{
    lpusart->info->flags = 0;
    lpusart->info->cb_event = NULL;

    if(lpusart->co_usart_dma_tx)
    {
        DMA_closeChannel(lpusart->co_usart_dma_tx->instance, lpusart->co_usart_dma_tx->channel);
    }

    if(lpusart->co_usart_dma_rx)
    {
        DMA_closeChannel(lpusart->co_usart_dma_rx->instance, lpusart->co_usart_dma_rx->channel);
    }

    if(lpusart->dma_rx)
    {
        DMA_closeChannel(lpusart->dma_rx->instance, lpusart->dma_rx->channel);
    }

#ifdef PM_FEATURE_ENABLE

    g_lpusartDataBase.isInited = false;
    g_lpusartWorkingStatus = 0;
    slpManUnregisterPredefinedBackupCb(SLP_CALLBACK_LPUSART_MODULE);
    slpManUnregisterPredefinedRestoreCb(SLP_CALLBACK_LPUSART_MODULE);
#endif

    return ARM_DRIVER_OK;
}

int32_t LPUSART_PowerControl(ARM_POWER_STATE state,LPUSART_RESOURCES *lpusart)
{
    uint32_t val = 0;

    switch (state)
    {
        case ARM_POWER_OFF:

            // Reset LPUSART
            GPR_swReset(RST_PCLK_UART1);
            GPR_swReset(RST_FCLK_UART1);

            if(lpusart->info->flags & LPUSART_FLAG_POWER_LOW)
            {
                GPR_swReset(RST_LPUA);

                LPUSART_AON_REGISTER_WRITE(lpusart->aon_regs->CR1, 0);

            }

            LPUSART_AON_REGISTER_WRITE(lpusart->aon_regs->CR0, 0);

            // DMA disable
            if(lpusart->co_usart_dma_tx)
                DMA_stopChannel(lpusart->co_usart_dma_tx->instance, lpusart->co_usart_dma_tx->channel, false);

            if(lpusart->co_usart_dma_rx)
                DMA_stopChannel(lpusart->co_usart_dma_rx->instance, lpusart->co_usart_dma_rx->channel, false);

            if(lpusart->dma_rx)
                DMA_stopChannel(lpusart->dma_rx->instance, lpusart->dma_rx->channel, false);

            // Disable clock
            GPR_clockDisable(PCLK_LPUC);
            GPR_clockDisable(PCLK_UART1);
            GPR_clockDisable(FCLK_UART1);

            // Clear driver variables
            memset(&(lpusart->info->rx_status), 0, sizeof(LPUSART_STATUS));
            lpusart->info->frame_code       = 0;
            lpusart->info->xfer.send_active = 0;

            // Disable LPUSART IRQ
            if(lpusart->irq)
            {
                XIC_ClearPendingIRQ(lpusart->irq->irq_num);
                XIC_DisableIRQ(lpusart->irq->irq_num);
            }

            if(lpusart->co_usart_irq)
            {
                XIC_ClearPendingIRQ(lpusart->co_usart_irq->irq_num);
                XIC_DisableIRQ(lpusart->co_usart_irq->irq_num);
            }

            lpusart->info->flags &= ~(LPUSART_FLAG_POWER_MSK | LPUSART_FLAG_CONFIGURED);

            break;

        case ARM_POWER_LOW:
            if((lpusart->info->flags & LPUSART_FLAG_INITIALIZED) == 0)
            {
                return ARM_DRIVER_ERROR;
            }

            if(lpusart->info->flags & LPUSART_FLAG_POWER_LOW)
            {
                return ARM_DRIVER_OK;
            }

            // Enable lpusart clock
            GPR_clockEnable(PCLK_LPUC);
            GPR_clockEnable(PCLK_UART1);
            GPR_clockEnable(FCLK_UART1);

            // Disable interrupts
            lpusart->co_usart_regs->IER = 0;
            lpusart->core_regs->IER = 0;

            // Clear driver variables
            memset(&(lpusart->info->rx_status), 0, sizeof(LPUSART_STATUS));
            lpusart->info->frame_code       = 0;
            lpusart->info->xfer.send_active = 0;

            // Configure FIFO Control register
            val = USART_FCR_FIFO_EN_Msk | USART_FCR_RESET_TX_FIFO_Msk;

            lpusart->co_usart_regs->FCR = val;

#ifdef PM_FEATURE_ENABLE
            g_lpusartDataBase.co_usart_registers.FCR = val;
#endif

            val = EIGEN_VAL2FLD(LPUSARTCORE_FCSR_RXFIFO_THRLD, LPUSART_RX_TRIG_LVL);
            //val |= LPUSARTCORE_FCSR_FLUSH_RXFIFO_Msk;
            lpusart->core_regs->FCSR = val;

            if(lpusart->co_usart_dma_tx)
            {
                lpusart->co_usart_regs->MFCR |= USART_MFCR_DMA_EN_Msk;
            }

            if(lpusart->dma_rx)
            {
                lpusart->core_regs->DCR = LPUSARTCORE_DCR_RX_REQ_EN_Msk;
            }

            if(lpusart->irq)
            {
                XIC_SetVector(lpusart->irq->irq_num, lpusart->irq->cb_irq);
                XIC_EnableIRQ(lpusart->irq->irq_num);
                XIC_SuppressOvfIRQ(lpusart->irq->irq_num);
            }
            if(lpusart->co_usart_irq)
            {
                XIC_SetVector(lpusart->co_usart_irq->irq_num, lpusart->co_usart_irq->cb_irq);
                XIC_EnableIRQ(lpusart->co_usart_irq->irq_num);
                XIC_SuppressOvfIRQ(lpusart->co_usart_irq->irq_num);
            }

            lpusart->info->flags |= LPUSART_FLAG_POWER_LOW;  // LPUSART is powered on

            break;

        case ARM_POWER_FULL:
            if((lpusart->info->flags & LPUSART_FLAG_INITIALIZED) == 0)
            {
                return ARM_DRIVER_ERROR;
            }
            if(lpusart->info->flags & LPUSART_FLAG_POWER_FULL)
            {
                return ARM_DRIVER_OK;
            }

            // Enable cooperating usart clock
            GPR_clockEnable(PCLK_AON);
            GPR_clockEnable(PCLK_UART1);
            GPR_clockEnable(FCLK_UART1);

            GPR_swReset(RST_PCLK_UART1);
            GPR_swReset(RST_FCLK_UART1);

            // Clear driver variables
            memset(&(lpusart->info->rx_status), 0, sizeof(LPUSART_STATUS));
            lpusart->info->frame_code       = 0;
            lpusart->info->xfer.send_active = 0;

            // Configure FIFO Control register
            val = USART_FCR_FIFO_EN_Msk | USART_FCR_RESET_RX_FIFO_Msk | USART_FCR_RESET_TX_FIFO_Msk;

            // rxfifo trigger level set as 16 bytes
            val |= (2U << USART_FCR_RX_FIFO_AVAIL_TRIG_LEVEL_Pos);

            lpusart->co_usart_regs->FCR = val;

#ifdef PM_FEATURE_ENABLE
            g_lpusartDataBase.co_usart_registers.FCR = val;
#endif

            if(lpusart->co_usart_dma_tx || lpusart->co_usart_dma_rx)
            {
                lpusart->co_usart_regs->MFCR |= USART_MFCR_DMA_EN_Msk;
            }

            if(lpusart->co_usart_irq)
            {
                XIC_SetVector(lpusart->co_usart_irq->irq_num, lpusart->co_usart_irq->cb_irq);
                XIC_EnableIRQ(lpusart->co_usart_irq->irq_num);
                XIC_SuppressOvfIRQ(lpusart->co_usart_irq->irq_num);
            }
            lpusart->info->flags |= LPUSART_FLAG_POWER_FULL;  // LPUSART is powered on

            // Enable wakeup feature only
            LPUSART_AON_REGISTER_WRITE(lpusart->aon_regs->CR0, LPUSARTAON_CR0_RX_ENABLE_Msk);

            break;

        default:
            return ARM_DRIVER_ERROR_UNSUPPORTED;
    }
    return ARM_DRIVER_OK;
}

int32_t LPUSART_Send(const void *data, uint32_t num, LPUSART_RESOURCES *lpusart)
{
    uint32_t mask;
    if ((data == NULL) || (num == 0))
        return ARM_DRIVER_ERROR_PARAMETER;
    if ((lpusart->info->flags & LPUSART_FLAG_CONFIGURED) == 0)
        return ARM_DRIVER_ERROR;

#ifdef PM_FEATURE_ENABLE
    if((lpusart->co_usart_regs->ADCR & USART_ADCR_AUTO_BAUD_INT_EN_Msk) && (g_lpusartDataBase.autoBaudRateDone == false))
    {
        return ARM_DRIVER_OK;
    }
#endif

    mask = SaveAndSetIRQMask();
    if (lpusart->info->xfer.send_active != 0)
    {
        RestoreIRQMask(mask);
        return ARM_DRIVER_ERROR_BUSY;
    }

    lpusart->info->xfer.send_active = 1U;
    RestoreIRQMask(mask);

    // Save transmit buffer info
    lpusart->info->xfer.tx_buf = (uint8_t *)data;
    lpusart->info->xfer.tx_num = num;
    lpusart->info->xfer.tx_cnt = 0;
    // DMA mode
    if(lpusart->co_usart_dma_tx)
    {
#if 0
        // wait until tx is empty
        while((lpusart->co_usart_regs->LSR & USART_LSR_TX_EMPTY_Msk) == 0);
#else
        // relax the constraint
        while(EIGEN_FLD2VAL(USART_FCNR_TX_FIFO_NUM, lpusart->co_usart_regs->FCNR) > 16);
#endif

#ifdef PM_FEATURE_ENABLE
        mask = SaveAndSetIRQMask();

        LOCK_SLEEP(1, 0);

        RestoreIRQMask(mask);
#endif

        if(num == 1)
        {
            mask = SaveAndSetIRQMask();

            lpusart->co_usart_regs->IER |= USART_IER_TX_DATA_REQ_Msk;

            lpusart->co_usart_regs->THR = lpusart->info->xfer.tx_buf[0];

            RestoreIRQMask(mask);
        }
        else
        {
            dmaTxConfig.sourceAddress = (void*)data;
            dmaTxConfig.targetAddress = (void*)&(lpusart->co_usart_regs->THR);
            dmaTxConfig.totalLength = num - 1;

            // Configure tx DMA and start it
            DMA_transferSetup(lpusart->co_usart_dma_tx->instance, lpusart->co_usart_dma_tx->channel, &dmaTxConfig);
            DMA_enableChannelInterrupts(lpusart->co_usart_dma_tx->instance, lpusart->co_usart_dma_tx->channel, DMA_END_INTERRUPT_ENABLE);
            DMA_startChannel(lpusart->co_usart_dma_tx->instance, lpusart->co_usart_dma_tx->channel);
        }

    }
    else
    {
        while (lpusart->info->xfer.tx_cnt < lpusart->info->xfer.tx_num)
        {
            // wait until tx is empty
            while((lpusart->co_usart_regs->LSR & USART_LSR_TX_EMPTY_Msk) == 0);
            lpusart->co_usart_regs->THR = lpusart->info->xfer.tx_buf[lpusart->info->xfer.tx_cnt++];
        }
        while((lpusart->co_usart_regs->LSR & USART_LSR_TX_EMPTY_Msk) == 0);
        mask = SaveAndSetIRQMask();
        lpusart->info->xfer.send_active = 0;
        RestoreIRQMask(mask);
    }

    return ARM_DRIVER_OK;
}

int32_t LPUSART_SendPolling(const void *data, uint32_t num, LPUSART_RESOURCES *lpusart)
{
    uint32_t mask;
    if ((data == NULL) || (num == 0))
        return ARM_DRIVER_ERROR_PARAMETER;
    if ((lpusart->info->flags & LPUSART_FLAG_CONFIGURED) == 0)
        return ARM_DRIVER_ERROR;

#ifdef PM_FEATURE_ENABLE
    if((lpusart->co_usart_regs->ADCR & USART_ADCR_AUTO_BAUD_INT_EN_Msk) && (g_lpusartDataBase.autoBaudRateDone == false))
    {
        return ARM_DRIVER_OK;
    }
#endif

    mask = SaveAndSetIRQMask();
    if (lpusart->info->xfer.send_active != 0)
    {
        RestoreIRQMask(mask);
        return ARM_DRIVER_ERROR_BUSY;
    }

    lpusart->info->xfer.send_active = 1U;
    RestoreIRQMask(mask);

    // Save transmit buffer info
    lpusart->info->xfer.tx_buf = (uint8_t *)data;
    lpusart->info->xfer.tx_num = num;
    lpusart->info->xfer.tx_cnt = 0;

    while (lpusart->info->xfer.tx_cnt < lpusart->info->xfer.tx_num)
    {
        // wait until tx is empty
        while((lpusart->co_usart_regs->LSR & USART_LSR_TX_EMPTY_Msk) == 0);
        lpusart->co_usart_regs->THR = lpusart->info->xfer.tx_buf[lpusart->info->xfer.tx_cnt++];
    }
    while((lpusart->co_usart_regs->LSR & USART_LSR_TX_EMPTY_Msk) == 0);
    mask = SaveAndSetIRQMask();
    lpusart->info->xfer.send_active = 0;
    RestoreIRQMask(mask);

    return ARM_DRIVER_OK;
}

PLAT_PA_RAMCODE int32_t LPUSART_Receive(void *data, uint32_t num, LPUSART_RESOURCES *lpusart)
{
    uint32_t mask, bytes_in_fifo, i;

    volatile uint32_t left_to_recv = num;

    if ((data == NULL) || num == 0)
    {
        return ARM_DRIVER_ERROR_PARAMETER;
    }

    if ((lpusart->info->flags & LPUSART_FLAG_CONFIGURED) == 0)
    {
        return ARM_DRIVER_ERROR;
    }

    // check if receiver is busy
    if (lpusart->info->rx_status.rx_busy == 1U)
    {
        return ARM_DRIVER_ERROR_BUSY;
    }

    lpusart->info->rx_status.rx_busy = 1U;

    // save num of data to be received
    lpusart->info->xfer.rx_num = num;
    lpusart->info->xfer.rx_buf = (uint8_t *)data;
    lpusart->info->xfer.rx_cnt = 0;

    if(lpusart->dma_rx || lpusart->co_usart_dma_rx)
    {
       lpusart->info->rx_status.rx_dma_triggered = 0;

       if(lpusart->co_usart_dma_rx)
       {
           CO_USART_DmaUpdateRxConfig(lpusart, (uint32_t)data, num);
       }
    }

    if(lpusart->info->flags & LPUSART_FLAG_POWER_FULL)
    {
        lpusart->co_usart_regs->IER |= USART_IER_RX_LINE_STATUS_Msk;

        lpusart->info->rx_status.rx_busy = 1U;

        // Lucky :), we have bytes waiting, try our best to receive all of them, however, let normal recv process handle the case if new data keeps arriving
        while((bytes_in_fifo = EIGEN_FLD2VAL(USART_FCNR_RX_FIFO_NUM, lpusart->co_usart_regs->FCNR)) > 0)
        {

            if(lpusart->co_usart_regs->LSR & USART_LSR_RX_BUSY_Msk)
            {
                break;
            }

            left_to_recv = num - lpusart->info->xfer.rx_cnt;

            i = MIN(bytes_in_fifo, left_to_recv);

            while(i--)
            {
                lpusart->info->xfer.rx_buf[lpusart->info->xfer.rx_cnt++] = lpusart->co_usart_regs->RBR;
            }

            left_to_recv = num - lpusart->info->xfer.rx_cnt;

            // prepare in advance for dma recv
            if(lpusart->co_usart_dma_rx)
            {
                CO_USART_DmaUpdateRxConfig(lpusart, (uint32_t)&lpusart->info->xfer.rx_buf[lpusart->info->xfer.rx_cnt], left_to_recv);
            }

            if(left_to_recv == 0)
            {
                // Full
                lpusart->info->rx_status.rx_busy = 0;

                lpusart->co_usart_regs->IER &= ~USART_IER_RX_LINE_STATUS_Msk;

                if(lpusart->info->cb_event != NULL)
                {
                    lpusart->info->cb_event(ARM_USART_EVENT_RECEIVE_COMPLETE);
                }

                return ARM_DRIVER_OK;

            }

            // check again whether there's ongoing data stream
            if(lpusart->co_usart_regs->LSR & USART_LSR_RX_BUSY_Msk)
            {
                break;
            }

        }

        // need to add protection to check rxfifo in irqHandler for 'fake' timeout, that's caused by
        // we have try to receive bytes from rxfifo as many as possible so when timeout occurs, there maybe no bytes left in rxfifo
        if(lpusart->co_usart_dma_rx)
        {
            lpusart->co_usart_regs->IER |= USART_IER_RX_TIMEOUT_Msk;

            DMA_loadChannelDescriptorAndRun(lpusart->co_usart_dma_rx->instance, lpusart->co_usart_dma_rx->channel, &lpusart->co_usart_dma_rx->descriptor[0]);

            if(lpusart->info->xfer.rx_cnt != 0)
            {
                if(lpusart->co_usart_regs->LSR & USART_LSR_RX_BUSY_Msk)
                {
                    // do nothing if there's still data coming since we can let isr report later
                }
                else
                {
                    // report to upper layer that we've received some data
                    lpusart->info->rx_status.rx_busy = 0;

                    // rx_busy is not reliable flag since it'll change to 0 on stop bit
                    // so it's possible here to break the continuous rx data steam into two parts
                    if(lpusart->info->cb_event != NULL)
                    {
                        lpusart->info->cb_event(ARM_USART_EVENT_RX_TIMEOUT);
                    }
                }

            }

        }
        else if(lpusart->co_usart_irq)
        {
            lpusart->co_usart_regs->IER |= USART_IER_RX_TIMEOUT_Msk   | \
                                           USART_IER_RX_DATA_REQ_Msk;

            if(lpusart->info->xfer.rx_cnt != 0)
            {
                if(lpusart->co_usart_regs->LSR & USART_LSR_RX_BUSY_Msk)
                {
                    // do nothing if there's still data coming since we can let isr report later
                }
                else
                {
                    // report to upper layer that we've received some data
                    lpusart->info->rx_status.rx_busy = 0;

                    // rx_busy is not reliable flag since it'll change to 0 on stop bit
                    // so it's possible here to break the continuous rx data steam into two parts
                    if(lpusart->info->cb_event != NULL)
                    {
                        lpusart->info->cb_event(ARM_USART_EVENT_RX_TIMEOUT);
                    }
                }

            }
        }
        else
        {
            while(lpusart->info->xfer.rx_cnt < lpusart->info->xfer.rx_num)
            {
                //wait unitl receive data is ready
                while((lpusart->co_usart_regs->LSR & USART_LSR_RX_DATA_READY_Msk) == 0);
                //read data
                lpusart->info->xfer.rx_buf[lpusart->info->xfer.rx_cnt++] = lpusart->co_usart_regs->RBR;
            }
            lpusart->info->rx_status.rx_busy = 0;
        }
    }

    if(lpusart->info->flags & LPUSART_FLAG_POWER_LOW)
    {
        if(lpusart->irq)
        {
#if LPUSART_DRIVER_DEBUG
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, lpuart_recv_0, P_DEBUG, "lpuart recv enter, iir: 0x%x, fcsr: 0x%x, tcr: 0x%x, tsr: 0x%x", lpusart->core_regs->IIR, lpusart->core_regs->FCSR, lpusart->core_regs->TCR, lpusart->core_regs->TSR);
#endif
            mask = SaveAndSetIRQMask();

            // refresh timeout counter when wakeup from low power state
            lpusart->core_regs->IIR |= LPUSARTCORE_IIR_CLR_Msk;
            lpusart->core_regs->TCR |= LPUSARTCORE_TCR_TOCNT_SWTRG_Msk;
            lpusart->core_regs->IER = LPUSARTCORE_IER_AON_RX_OVERRUN_Msk   | \
                                      LPUSARTCORE_IER_AON_RX_PARITY_Msk    | \
                                      LPUSARTCORE_IER_AON_RX_FRMERR_Msk    | \
                                      LPUSARTCORE_IER_RX_DATA_AVAIL_Msk    | \
                                      LPUSARTCORE_IER_RX_TIMEOUT_Msk       | \
                                      LPUSARTCORE_IER_RX_OVERRUN_Msk;

            RestoreIRQMask(mask);

#if LPUSART_DRIVER_DEBUG
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, lpuart_recv_1, P_DEBUG, "lpuart recv exit, iir: 0x%x, fcsr: 0x%x, tcr: 0x%x, tsr: 0x%x", lpusart->core_regs->IIR, lpusart->core_regs->FCSR, lpusart->core_regs->TCR, lpusart->core_regs->TSR);
#endif
        }
        else
        {
            while(lpusart->info->xfer.rx_cnt < lpusart->info->xfer.rx_num)
            {
                //wait unitl receive data is ready
                while(lpusart->core_regs->FCSR & LPUSARTCORE_FCSR_RXFIFO_EMPTY_Msk);
                //read data
                lpusart->info->xfer.rx_buf[lpusart->info->xfer.rx_cnt++] = lpusart->core_regs->RBR;
            }
            lpusart->info->rx_status.rx_busy = 0;
        }
    }

    return ARM_DRIVER_OK;
}

int32_t LPUSART_Transfer(const void *data_out, void *data_in, uint32_t num,LPUSART_RESOURCES *lpusart)
{
    //maybe used by command transfer
    return ARM_DRIVER_ERROR_UNSUPPORTED;
}

int32_t LPUSART_GetTxCount(LPUSART_RESOURCES *lpusart)
{
    uint32_t cnt;
    if (!(lpusart->info->flags & LPUSART_FLAG_CONFIGURED))
        return 0;
    if(lpusart->co_usart_dma_tx)
        cnt = DMA_getChannelCount(lpusart->co_usart_dma_tx->instance, lpusart->co_usart_dma_tx->channel);
    else
        cnt = lpusart->info->xfer.tx_cnt;
    return cnt;
}

PLAT_PA_RAMCODE int32_t LPUSART_GetRxCount(LPUSART_RESOURCES *lpusart)
{
    if (!(lpusart->info->flags & LPUSART_FLAG_CONFIGURED))
        return 0;
    return lpusart->info->xfer.rx_cnt;
}

int32_t LPUSART_Control(uint32_t control, uint32_t arg, LPUSART_RESOURCES *lpusart)
{
    uint32_t val, mfcr, mask;
    uint8_t aon_lcr = 0;
    uint8_t lcr = lpusart->co_usart_regs->LCR;

    if(lpusart->info->flags & LPUSART_FLAG_POWER_LOW)
    {
        aon_lcr = lpusart->aon_regs->LCR;
    }

    switch (control & ARM_USART_CONTROL_Msk)
    {
        // Control TX
        case ARM_USART_CONTROL_TX:
            return ARM_DRIVER_OK;
        // Control RX
        case ARM_USART_CONTROL_RX:
            // Not recommend to use this feature
            if ((lpusart->info->flags & LPUSART_FLAG_CONFIGURED) == 0U)
            {
                return ARM_DRIVER_ERROR;
            }

            // What we can do now is just to suppress irqs since we have no solo control bit to disable RX for UART

            mask = SaveAndSetIRQMask();

            if(lpusart->info->flags & LPUSART_FLAG_POWER_FULL)
            {
                if(arg == 0)
                {
                    if(lpusart->co_usart_dma_rx)
                    {
                        lpusart->co_usart_regs->IER &= ~(USART_IER_RX_TIMEOUT_Msk   | \
                                                         USART_IER_RX_LINE_STATUS_Msk);

                        lpusart->info->rx_status.rx_dma_triggered = 0;

                        DMA_stopChannelNoWait(lpusart->co_usart_dma_rx->instance, lpusart->co_usart_dma_rx->channel);
                    }
                    else if(lpusart->co_usart_irq)
                    {
                        lpusart->co_usart_regs->IER &= ~(USART_IER_RX_TIMEOUT_Msk   | \
                                                         USART_IER_RX_DATA_REQ_Msk  | \
                                                         USART_IER_RX_LINE_STATUS_Msk);
                    }

                    lpusart->co_usart_regs->ICR = USART_ICR_RX_DATA_REQ_Msk | \
                                                  USART_ICR_RX_TIMEOUT_Msk | \
                                                  USART_ICR_RX_LINE_STATUS_Msk;

                }
                else
                {
                    // Not support now, call receive instead
                }

            }

            if(lpusart->info->flags & LPUSART_FLAG_POWER_LOW)
            {
                if(arg == 1)
                {
                    LPUSART_AON_REGISTER_WRITE(lpusart->aon_regs->CR1, LPUSART_AON_CR1_ENABLE);
                }
                else
                {
                    LPUSART_AON_REGISTER_WRITE(lpusart->aon_regs->CR1, 0);
                }
            }


            lpusart->info->rx_status.rx_busy = 0;

            RestoreIRQMask(mask);

            return ARM_DRIVER_OK;


        // Control break
        case ARM_USART_CONTROL_BREAK:
            return ARM_DRIVER_ERROR_UNSUPPORTED;
        // Abort Send
        case ARM_USART_ABORT_SEND:
            return ARM_DRIVER_ERROR_UNSUPPORTED;
        // Abort receive
        case ARM_USART_ABORT_RECEIVE:
            return ARM_DRIVER_ERROR_UNSUPPORTED;
        // Abort transfer
        case ARM_USART_ABORT_TRANSFER:
            return ARM_DRIVER_ERROR_UNSUPPORTED;
        case ARM_USART_MODE_ASYNCHRONOUS:
            break;
        // Flush TX fifo
        case ARM_USART_CONTROL_FLUSH_TX:

            if(lpusart->co_usart_regs->MFCR & USART_MFCR_AUTO_FLOW_CTS_EN_Msk)
            {
                while(((lpusart->co_usart_regs->LSR & USART_LSR_TX_EMPTY_Msk) == 0) && ((lpusart->co_usart_regs->MSR & USART_MSR_CTS_Msk) == USART_MSR_CTS_Msk));
            }
            else
            {
                while((lpusart->co_usart_regs->LSR & USART_LSR_TX_EMPTY_Msk) == 0);
            }
            return ARM_DRIVER_OK;

        case ARM_USART_CONTROL_PURGE_COMM:
            if(lpusart->info->flags & LPUSART_FLAG_POWER_FULL)
            {
                mfcr = lpusart->co_usart_regs->MFCR;
                lpusart->co_usart_regs->MFCR = 0;
                // reconfigure FIFO Control register
                val = USART_FCR_FIFO_EN_Msk | USART_FCR_RESET_RX_FIFO_Msk | USART_FCR_RESET_TX_FIFO_Msk;

                // rxfifo trigger level set as 16 bytes
                val |= (2U << USART_FCR_RX_FIFO_AVAIL_TRIG_LEVEL_Pos);

                lpusart->co_usart_regs->FCR = val;
                lpusart->co_usart_regs->MFCR = mfcr;
            }
            else if(lpusart->info->flags & LPUSART_FLAG_POWER_LOW)
            {
                val = EIGEN_VAL2FLD(LPUSARTCORE_FCSR_RXFIFO_THRLD, LPUSART_RX_TRIG_LVL);
                val |= LPUSARTCORE_FCSR_FLUSH_RXFIFO_Msk;
                lpusart->core_regs->FCSR = val;
                GPR_swReset(RST_LPUA);
                lpusart->core_regs->IIR = LPUSARTCORE_IIR_CLR_Msk;
            }
            return ARM_DRIVER_OK;

        default:
            return ARM_DRIVER_ERROR_UNSUPPORTED;
    }

    switch (control & ARM_USART_DATA_BITS_Msk)
    {
        case ARM_USART_DATA_BITS_5:
            lcr &= ~USART_LCR_CHAR_LEN_Msk;
            aon_lcr &= ~LPUSARTAON_LCR_CHAR_LEN_Msk;
            break;
        case ARM_USART_DATA_BITS_6:
            lcr &= ~USART_LCR_CHAR_LEN_Msk;
            lcr |= 1U;
            aon_lcr &= ~LPUSARTAON_LCR_CHAR_LEN_Msk;
            aon_lcr |= 1U;
            break;
        case ARM_USART_DATA_BITS_7:
            lcr &= ~USART_LCR_CHAR_LEN_Msk;
            lcr |= 2U;
            aon_lcr &= ~LPUSARTAON_LCR_CHAR_LEN_Msk;
            aon_lcr |= 2U;
            break;
        case ARM_USART_DATA_BITS_8:
            lcr &= ~USART_LCR_CHAR_LEN_Msk;
            lcr |= 3U;
            aon_lcr &= ~LPUSARTAON_LCR_CHAR_LEN_Msk;
            aon_lcr |= 3U;
            break;
        default:
            return ARM_USART_ERROR_DATA_BITS;
    }

    // LPUSART Parity
    switch (control & ARM_USART_PARITY_Msk)
    {
        case ARM_USART_PARITY_NONE:
            lcr &= ~USART_LCR_PARITY_EN_Msk;
            aon_lcr &= ~LPUSARTAON_LCR_PARITY_EN_Msk;
            break;
        case ARM_USART_PARITY_EVEN:
            lcr |= (USART_LCR_PARITY_EN_Msk | USART_LCR_EVEN_PARITY_Msk);
            aon_lcr |= (LPUSARTAON_LCR_PARITY_EN_Msk | LPUSARTAON_LCR_EVEN_PARITY_Msk);
            break;
        case ARM_USART_PARITY_ODD:
            lcr |= USART_LCR_PARITY_EN_Msk;
            lcr &= ~USART_LCR_EVEN_PARITY_Msk;
            aon_lcr |= LPUSARTAON_LCR_PARITY_EN_Msk;
            aon_lcr &= ~LPUSARTAON_LCR_EVEN_PARITY_Msk;
            break;
        default:
            return (ARM_USART_ERROR_PARITY);
    }

    // LPUSART Stop bits
    switch (control & ARM_USART_STOP_BITS_Msk)
    {
        case ARM_USART_STOP_BITS_1:
            lcr &=~ USART_LCR_STOP_BIT_NUM_Msk;
            break;
        case ARM_USART_STOP_BITS_1_5:
            if ((control & ARM_USART_DATA_BITS_Msk) == ARM_USART_DATA_BITS_5)
            {
                lcr |= USART_LCR_STOP_BIT_NUM_Msk;
                break;
            }
            else
                return ARM_USART_ERROR_STOP_BITS;
        case ARM_USART_STOP_BITS_2:
            lcr |= USART_LCR_STOP_BIT_NUM_Msk;
            break;
        default:
            return ARM_USART_ERROR_STOP_BITS;
    }

    // LPUSART Flow Control
    switch (control & ARM_USART_FLOW_CONTROL_Msk)
    {
        case ARM_USART_FLOW_CONTROL_NONE:
            lpusart->co_usart_regs->MFCR &= ~(USART_MFCR_AUTO_FLOW_RTS_EN_Msk | USART_MFCR_AUTO_FLOW_CTS_EN_Msk);
            break;
        case ARM_USART_FLOW_CONTROL_RTS:
            lpusart->co_usart_regs->MCR |= USART_MCR_RTS_Msk; //activate rts, put rts pin to low level
            lpusart->co_usart_regs->MFCR &= ~(USART_MFCR_AUTO_FLOW_RTS_EN_Msk | USART_MFCR_AUTO_FLOW_CTS_EN_Msk);
            break;
        case ARM_USART_FLOW_CONTROL_CTS:
            lpusart->co_usart_regs->MFCR |= (USART_MFCR_AUTO_FLOW_CTS_EN_Msk);
            break;
        case ARM_USART_FLOW_CONTROL_RTS_CTS:
            lpusart->co_usart_regs->MCR |= USART_MCR_RTS_Msk; //activate rts, put rts pin to low level
            lpusart->co_usart_regs->MFCR |= (USART_MFCR_AUTO_FLOW_CTS_EN_Msk);
            break;
    }
    // LPUSART Baudrate
    if(ARM_DRIVER_OK != LPUSART_SetBaudrate(arg, lpusart))
    {
        return ARM_USART_ERROR_BAUDRATE;
    }

    // Configuration is OK - frame code is valid
    lpusart->info->frame_code = control;

    lpusart->co_usart_regs->LCR = lcr;

    if(lpusart->info->flags & LPUSART_FLAG_POWER_LOW)
    {

        if((lpusart->core_regs->FCSR & (LPUSARTCORE_FCSR_RXFIFO_EMPTY_Msk | LPUSARTCORE_FCSR_AON_RX_BUSY_Msk | LPUSARTCORE_FCSR_AON_RXFIFO_EMPTY_Msk)) == (LPUSARTCORE_FCSR_RXFIFO_EMPTY_Msk | LPUSARTCORE_FCSR_AON_RXFIFO_EMPTY_Msk))
        {
            LPUSART_AON_REGISTER_WRITE(lpusart->aon_regs->CR0, LPUSARTAON_CR0_RX_ENABLE_Msk | LPUSARTAON_CR0_CLK_ENABLE_Msk);
            LPUSART_AON_REGISTER_WRITE(lpusart->aon_regs->LCR, aon_lcr);
            //LPUSART_AON_REGISTER_WRITE(lpusart->aon_regs->CR1, LPUSARTAON_CR1_ENABLE_Msk | LPUSARTAON_CR1_ACG_EN_Msk | LPUSARTAON_CR1_AUTO_ADJ_Msk);
            LPUSART_AON_REGISTER_WRITE(lpusart->aon_regs->CR1, LPUSART_AON_CR1_ENABLE);
        }
        LPUSART_ClearStopFlag();
    }

    // lpusart enable
    lpusart->co_usart_regs->MFCR |= USART_MFCR_UART_EN_Msk;

    lpusart->info->flags |= LPUSART_FLAG_CONFIGURED;
    return ARM_DRIVER_OK;
}

ARM_USART_STATUS LPUSART_GetStatus(LPUSART_RESOURCES *lpusart)
{
    ARM_USART_STATUS status;

    status.tx_busy          = lpusart->info->xfer.send_active;
    status.rx_busy          = lpusart->info->rx_status.rx_busy;
    status.tx_underflow     = 0;
    status.rx_overflow      = lpusart->info->rx_status.rx_overflow;
    status.rx_break         = lpusart->info->rx_status.rx_break;
    status.rx_framing_error = lpusart->info->rx_status.rx_framing_error;
    status.rx_parity_error  = lpusart->info->rx_status.rx_parity_error;
    status.is_send_block    = (lpusart->co_usart_dma_tx == NULL);
    return status;
}

int32_t LPUSART_SetModemControl(ARM_USART_MODEM_CONTROL control, LPUSART_RESOURCES *lpusart)
{
    if((lpusart->info->flags & LPUSART_FLAG_CONFIGURED) == 0U)
    {
        // USART is not configured
       return ARM_DRIVER_ERROR;
    }

    if(lpusart->info->frame_code & ARM_USART_FLOW_CONTROL_RTS)
    {
        if(control == ARM_USART_RTS_CLEAR) //Deactivate RTS, put rts pin to high level
        {
            lpusart->co_usart_regs->MCR &= ~USART_MCR_RTS_Msk;
        }

        if(control == ARM_USART_RTS_SET) //Activate RTS, put rts pin to low level
        {
            lpusart->co_usart_regs->MCR |= USART_MCR_RTS_Msk;
        }

    }

    if(control == ARM_USART_DTR_CLEAR)
    {
        return ARM_DRIVER_ERROR_UNSUPPORTED;
    }

    if(control == ARM_USART_DTR_SET)
    {
        return ARM_DRIVER_ERROR_UNSUPPORTED;
    }

    return ARM_DRIVER_OK;

}

ARM_USART_MODEM_STATUS LPUSART_GetModemStatus(LPUSART_RESOURCES *lpusart)
{
    ARM_USART_MODEM_STATUS status = {0};

    if(lpusart->info->flags & LPUSART_FLAG_CONFIGURED)
    {
        status.cts = EIGEN_FLD2VAL(USART_MSR_CTS, lpusart->co_usart_regs->MSR);
    }

    return status;
}
#ifdef __USER_CODE__
#else
void LPUSART_WakeupIntHandler(void)
{
    slpManExtIntPreProcess(LpuartWakeup_IRQn);

    //extern void AonRegAPClrWIC(void);
    // WIC clear
    //AonRegAPClrWIC();
    *(uint32_t*) 0x4d020140 = 1;
    NVIC_DisableIRQ(LpuartWakeup_IRQn);

#if LPUSART_DRIVER_DEBUG
    ECPLAT_PRINTF(UNILOG_PLA_DRIVER, lpuart_wakeup_irq_1, P_SIG, "LPUART->IIR:0x%x, LPUART->FCSR:0x%x", LPUSART_CORE->IIR, LPUSART_CORE->FCSR);
#endif
}
#endif
PLAT_PA_RAMCODE void LPUSART_IRQHandler(LPUSART_RESOURCES *lpusart)
{
    uint32_t i, dma_rx_channel;
    uint32_t event = 0;
    uint32_t iir_reg;
    uint32_t current_cnt, total_cnt, left_to_recv, bytes_in_fifo;

#define LPUSARTAON_INT_MASK      (LPUSARTCORE_IIR_AON_RX_OVERRUN_Msk | LPUSARTCORE_IIR_AON_RX_PARITY_Msk | LPUSARTCORE_IIR_AON_RX_FRMERR_Msk)
#define LPUSARTCORE_INT_MASK     (LPUSARTCORE_IIR_RX_DATA_AVAIL_Msk | LPUSARTCORE_IIR_RX_TIMEOUT_Msk | LPUSARTCORE_IIR_RX_OVERRUN_Msk)

    LPUSART_INFO *info = lpusart->info;

    // Check interrupt source
#if LPUSART_DRIVER_DEBUG
    ECPLAT_PRINTF(UNILOG_PLA_DRIVER, lpuart_irq_0, P_DEBUG, "Enter lpuart irq, iir: 0x%x, fcsr: 0x%x, tcr: 0x%x, tsr: 0x%x, rx_cnt:%d, ", lpusart->core_regs->IIR, lpusart->core_regs->FCSR, lpusart->core_regs->TCR, lpusart->core_regs->TSR, info->xfer.rx_cnt);
#endif

    iir_reg = lpusart->core_regs->IIR;

    if(iir_reg & LPUSARTAON_INT_MASK)
    {
        if(iir_reg & LPUSARTCORE_IIR_AON_RX_OVERRUN_Msk)
        {
            info->rx_status.rx_overflow = 1U;
            info->rx_status.aon_rx_overflow = 1U;
            event |= ARM_USART_EVENT_RX_OVERFLOW;
        }

        if(iir_reg & LPUSARTCORE_IIR_RX_OVERRUN_Msk)
        {
            info->rx_status.rx_overflow = 1U;
            event |= ARM_USART_EVENT_RX_OVERFLOW;
        }

        // Parity error
        if (iir_reg & LPUSARTCORE_IIR_AON_RX_PARITY_Msk)
        {
            info->rx_status.rx_parity_error= 1U;
            event |= ARM_USART_EVENT_RX_PARITY_ERROR;
        }

        // Framing error
        if (iir_reg & LPUSARTCORE_IIR_AON_RX_FRMERR_Msk)
        {
            info->rx_status.rx_framing_error= 1U;
            event |= ARM_USART_EVENT_RX_FRAMING_ERROR;
        }

        info->rx_status.rx_busy = 0;
#ifdef PM_FEATURE_ENABLE
        CHECK_TO_UNLOCK_SLEEP(0, 1);
#endif
    }
    else if(iir_reg & LPUSARTCORE_INT_MASK)
    {
        // clear interrupt flags
        lpusart->core_regs->IIR = LPUSARTCORE_IIR_CLR_Msk;

        if(iir_reg & LPUSARTCORE_IIR_RX_OVERRUN_Msk)
        {
            info->rx_status.rx_overflow = 1U;
            event |= ARM_USART_EVENT_RX_OVERFLOW;
        }
        else
        {
            if(iir_reg & LPUSARTCORE_IIR_RX_DATA_AVAIL_Msk)
            {
                // need to retrigger timeout counter if both interrupts have reached or timeout is approaching
                if((lpusart->core_regs->TSR & LPUSARTCORE_TSR_TOCNT_Msk) > ((lpusart->core_regs->TCR & LPUSARTCORE_TCR_TIMEOUT_THRLD_Msk) - 20000))
                {
                    lpusart->core_regs->TCR |= LPUSARTCORE_TCR_TOCNT_SWTRG_Msk; // timeout interrupt is not cleared by this operation
                    lpusart->core_regs->IIR = LPUSARTCORE_IIR_CLR_Msk;
                }

#ifdef PM_FEATURE_ENABLE
                LOCK_SLEEP(0, 1);
#endif
                info->rx_status.rx_busy = 1U;

                current_cnt = info->xfer.rx_cnt;
                total_cnt = info->xfer.rx_num;

                left_to_recv = total_cnt - current_cnt;

                bytes_in_fifo = EIGEN_FLD2VAL(LPUSARTCORE_FCSR_RXFIFO_NUM, lpusart->core_regs->FCSR);

                // leave at least one byte in fifo to trigger timeout interrupt
                i = bytes_in_fifo - 1;

                if(i == 0)
                    i = 1;

                i = MIN(i, left_to_recv);

                // DMA mode
                if(lpusart->dma_rx)
                {
                    // Let CPU transfer last chunk and all data when trigger level is set to be 1
                    if ((left_to_recv <= (bytes_in_fifo - 1)) || (LPUSART_RX_TRIG_LVL == 1))
                    {
#if LPUSART_DRIVER_DEBUG
                        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, lpuart_irq_3, P_DEBUG, "CPU will transfer: %d", i);
#endif
                        while(i--)
                        {
                            info->xfer.rx_buf[current_cnt++] = lpusart->core_regs->RBR;
                        }

                    }
                    else
                    {
                        dma_rx_channel = lpusart->dma_rx->channel;
#if LPUSART_DRIVER_DEBUG
                        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, lpuart_irq_2, P_DEBUG, "DMA will transfer: %d", i);
#endif
                        lpusart->dma_rx->descriptor->TAR = (uint32_t)(info->xfer.rx_buf + current_cnt);
                        lpusart->dma_rx->descriptor->CMDR = DMA_setDescriptorTransferLen(lpusart->dma_rx->descriptor->CMDR, i);

                        // load descriptor and start DMA transfer
                        DMA_loadChannelDescriptorAndRun(lpusart->dma_rx->instance, dma_rx_channel, lpusart->dma_rx->descriptor);

                        current_cnt += i;
                        info->rx_status.rx_dma_triggered = 1;
                    }

                }
                // IRQ mode
                else
                {
                    while(i--)
                    {
                        info->xfer.rx_buf[current_cnt++] = lpusart->core_regs->RBR;
                    }
                    // clear interrupt flags
                    lpusart->core_regs->IIR = LPUSARTCORE_IIR_CLR_Msk;

                }

                info->xfer.rx_cnt = current_cnt;

                if(current_cnt == total_cnt)
                {
                    // Clear RX busy flag and set receive transfer complete event
                    event |= ARM_USART_EVENT_RECEIVE_COMPLETE;

                    //Disable interrupt
                    lpusart->core_regs->IER = 0;

                    info->rx_status.rx_busy = 0;
                }

            }
            else if(iir_reg & LPUSARTCORE_IIR_RX_TIMEOUT_Msk)
            {
                bytes_in_fifo = EIGEN_FLD2VAL(LPUSARTCORE_FCSR_RXFIFO_NUM, lpusart->core_regs->FCSR);

                if((bytes_in_fifo > 0) && (lpusart->core_regs->TSR & LPUSARTCORE_TSR_TOCNT_REACH_Msk))
                {
#ifdef PM_FEATURE_ENABLE
                    LOCK_SLEEP(0, 1);
#endif
                    info->rx_status.rx_busy = 1U;

                    info->rx_status.rx_dma_triggered = 0;

                    current_cnt = info->xfer.rx_cnt;

                    total_cnt = info->xfer.rx_num;

                    left_to_recv = total_cnt - current_cnt;

                    i = MIN(bytes_in_fifo, left_to_recv);

#if LPUSART_DRIVER_DEBUG
                    ECPLAT_PRINTF(UNILOG_PLA_DRIVER, lpuart_irq_4, P_DEBUG, "Time out, CPU will transfer: %d", i);
#endif

                    while(i--)
                    {
                        info->xfer.rx_buf[current_cnt++] = lpusart->core_regs->RBR;
                    }

                    info->xfer.rx_cnt = current_cnt;

                    // Check if required amount of data is received
                    if (current_cnt == total_cnt)
                    {
                        // Clear RX busy flag and set receive transfer complete event
                        event |= ARM_USART_EVENT_RECEIVE_COMPLETE;

                        //Disable interrupt
                        lpusart->core_regs->IER = 0;

                    }
                    else
                    {
                        event |= ARM_USART_EVENT_RX_TIMEOUT;
                    }

                    info->rx_status.rx_busy = 0;
                }

            }
        }
    }

    if ((info->cb_event != NULL) && (event != 0))
    {
        info->cb_event (event);

#ifdef PM_FEATURE_ENABLE
        CHECK_TO_UNLOCK_SLEEP(0, 1);
#endif

    }
}


PLAT_PA_RAMCODE void CO_USART_IRQHandler(LPUSART_RESOURCES *lpusart)
{
    uint32_t i;
    uint32_t event = 0;
    uint32_t lsr_reg, isr_reg;
    uint32_t current_cnt, total_cnt, left_to_recv, bytes_in_fifo;

    LPUSART_INFO *info = lpusart->info;

    // Check interrupt source
    isr_reg = lpusart->co_usart_regs->ISR;
    lpusart->co_usart_regs->ICR = isr_reg;
    lpusart->co_usart_regs->ICR = 0;

#if LPUSART_DRIVER_DEBUG
    ECPLAT_PRINTF(UNILOG_PLA_DRIVER, CO_USART_IRQHandler_0, P_DEBUG, "Enter co_uart irq, isr: 0x%x, fcnr: 0x%x, rx_cnt:%d", isr_reg, lpusart->co_usart_regs->FCNR, info->xfer.rx_cnt);
#endif


    if((isr_reg & USART_ISR_RX_LINE_STATUS_Msk) == USART_ISR_RX_LINE_STATUS_Msk)
    {
        lsr_reg = lpusart->co_usart_regs->LSR;

        if (lsr_reg & USART_LSR_RX_OVERRUN_ERROR_Msk)
        {
            info->rx_status.rx_overflow = 1U;
            event |= ARM_USART_EVENT_RX_OVERFLOW;
        }

        // Parity error
        if (lsr_reg & USART_LSR_RX_PARITY_ERROR_Msk)
        {
            info->rx_status.rx_parity_error= 1U;
            event |= ARM_USART_EVENT_RX_PARITY_ERROR;
        }
        // Break detected
        if (lsr_reg & USART_LSR_RX_BREAK_Msk)
        {
            info->rx_status.rx_break= 1U;
            event |= ARM_USART_EVENT_RX_BREAK;
        }
        // Framing error
        if (lsr_reg & USART_LSR_RX_FRAME_ERROR_Msk)
        {
            info->rx_status.rx_framing_error= 1U;
            event |= ARM_USART_EVENT_RX_FRAMING_ERROR;
        }

        info->rx_status.rx_busy = 0;
#ifdef PM_FEATURE_ENABLE
        CHECK_TO_UNLOCK_SLEEP(0, 1);
#endif

    }
    else if((isr_reg & USART_ISR_RX_TIMEOUT_Msk) == USART_ISR_RX_TIMEOUT_Msk)
    {
        {
            // refer to receive API for this check
            if(lpusart->co_usart_regs->FCNR >> USART_FCNR_RX_FIFO_NUM_Pos)
            {
#ifdef PM_FEATURE_ENABLE
                LOCK_SLEEP(0, 1);
#endif
                info->rx_status.rx_busy = 1U;

                current_cnt = info->xfer.rx_cnt;

                if(lpusart->co_usart_dma_rx)
                {
                    if(info->rx_status.rx_dma_triggered)
                    {
                        // Sync with undergoing DMA transfer, wait until DMA burst transfer(8 bytes) done and update current_cnt
                        do
                        {
                            current_cnt = DMA_getChannelCurrentTargetAddress(lpusart->co_usart_dma_rx->instance, lpusart->co_usart_dma_rx->channel, true) - (uint32_t)info->xfer.rx_buf;
#if LPUSART_DRIVER_DEBUG
                            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, CO_USART_IRQHandler_1, P_DEBUG, "dma transfer done, cnt:%d", current_cnt);
#endif
                        } while(((current_cnt - info->xfer.rx_cnt) & (CO_USART_DMA_BURST_SIZE - 1)) != 0);

                        info->rx_status.rx_dma_triggered = 0;

                    }
                    /*
                       No matter DMA transfer is started or not(left recv buffer space is not enough),
                       now we can stop DMA saftely for next transfer and handle tailing bytes in FIFO
                    */
                    DMA_stopChannelNoWait(lpusart->co_usart_dma_rx->instance, lpusart->co_usart_dma_rx->channel);
                }

                total_cnt = info->xfer.rx_num;

                bytes_in_fifo = lpusart->co_usart_regs->FCNR >> USART_FCNR_RX_FIFO_NUM_Pos;

                left_to_recv = total_cnt - current_cnt;

                i = MIN(bytes_in_fifo, left_to_recv);

                // if still have space to recv
                if(left_to_recv > 0)
                {
                    while(i--)
                    {
                        info->xfer.rx_buf[current_cnt++] = lpusart->co_usart_regs->RBR;
                    }
                }

                info->xfer.rx_cnt = current_cnt;

                // Check if required amount of data is received
                if (current_cnt == total_cnt)
                {
                    // Clear RX busy flag and set receive transfer complete event
                    event |= ARM_USART_EVENT_RECEIVE_COMPLETE;

                    //Disable RDA interrupt
                    lpusart->co_usart_regs->IER &= ~(USART_IER_RX_DATA_REQ_Msk | USART_IER_RX_TIMEOUT_Msk | USART_IER_RX_LINE_STATUS_Msk);

                }
                else
                {
                    event |= ARM_USART_EVENT_RX_TIMEOUT;

                    if(lpusart->co_usart_dma_rx)
                    {
                        // Prepare for next recv
                        left_to_recv = total_cnt - info->xfer.rx_cnt;

                        CO_USART_DmaUpdateRxConfig(lpusart, (uint32_t)info->xfer.rx_buf + info->xfer.rx_cnt, left_to_recv);

                        // load descriptor and start DMA transfer
                        DMA_loadChannelDescriptorAndRun(lpusart->co_usart_dma_rx->instance, lpusart->co_usart_dma_rx->channel, &lpusart->co_usart_dma_rx->descriptor[0]);

                    }

                }

                info->rx_status.rx_busy = 0;
            }
        }
    }
    else if((isr_reg & USART_ISR_RX_DATA_REQ_Msk) == USART_ISR_RX_DATA_REQ_Msk)
    {
#ifdef PM_FEATURE_ENABLE
        LOCK_SLEEP(0, 1);
#endif
        info->rx_status.rx_busy = 1U;

        current_cnt = info->xfer.rx_cnt;
        total_cnt = info->xfer.rx_num;

        left_to_recv = total_cnt - current_cnt;

        bytes_in_fifo = lpusart->co_usart_regs->FCNR >> USART_FCNR_RX_FIFO_NUM_Pos;

        // leave at least one byte in fifo to trigger timeout interrupt
        i = bytes_in_fifo - 1;

        if(i == 0)
            i = 1;

        i = MIN(i, left_to_recv);

        while(i--)
        {
            info->xfer.rx_buf[current_cnt++] = lpusart->co_usart_regs->RBR;
        }

        info->xfer.rx_cnt = current_cnt;

        if(current_cnt == total_cnt)
        {
            // Clear RX busy flag and set receive transfer complete event
            event |= ARM_USART_EVENT_RECEIVE_COMPLETE;

            //Disable RDA interrupt
            lpusart->co_usart_regs->IER &= ~(USART_IER_RX_DATA_REQ_Msk | USART_IER_RX_TIMEOUT_Msk | USART_IER_RX_LINE_STATUS_Msk);

            info->rx_status.rx_busy = 0;
        }
    }

    if(((isr_reg & USART_ISR_TX_DATA_REQ_Msk) == USART_ISR_TX_DATA_REQ_Msk) || \
       ((lpusart->co_usart_regs->IER & USART_IER_TX_DATA_REQ_Msk) && ((lpusart->co_usart_regs->FCNR & USART_FCNR_TX_FIFO_NUM_Msk) == 0)))
    {
        info->xfer.tx_cnt = info->xfer.tx_num;
        info->xfer.send_active = 0U;
        event |= ARM_USART_EVENT_SEND_COMPLETE;
        lpusart->co_usart_regs->IER &= ~USART_IER_TX_DATA_REQ_Msk;

#ifdef PM_FEATURE_ENABLE
        CHECK_TO_UNLOCK_SLEEP(1, 0);
#endif
    }

    if ((info->cb_event != NULL) && (event != 0))
    {
        info->cb_event (event);

#ifdef PM_FEATURE_ENABLE
        CHECK_TO_UNLOCK_SLEEP(0, 1);
#endif

    }
}

/**
  \fn          void LPUSART_DmaTxEvent(uint32_t event, LPUSART_RESOURCES *usart)
  \brief       LPUSART DMA Tx Event handler.
  \param[in]   event DMA Tx Event
  \param[in]   usart   Pointer to LPUSART resources
*/
void LPUSART_DmaTxEvent(uint32_t event, LPUSART_RESOURCES *lpusart)
{
    switch (event)
    {
        case DMA_EVENT_END:
            // TXFIFO may still have data not sent out
            lpusart->co_usart_regs->IER |= USART_IER_TX_DATA_REQ_Msk;
            lpusart->co_usart_regs->THR = lpusart->info->xfer.tx_buf[lpusart->info->xfer.tx_num-1];

            break;
        case DMA_EVENT_ERROR:
        default:
            break;
    }
}

void CO_USART_DmaRxEvent(uint32_t event, LPUSART_RESOURCES *lpusart)
{

    uint32_t dmaCurrentTargetAddress = DMA_getChannelCurrentTargetAddress(lpusart->co_usart_dma_rx->instance, lpusart->co_usart_dma_rx->channel, false);

    switch (event)
    {
        case DMA_EVENT_END:

#if LPUSART_DRIVER_DEBUG
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, CO_USART_DmaRxEvent_0, P_DEBUG, "uart dma rx event, fcnr:%x, cnt:%d", lpusart->co_usart_regs->FCNR, dmaCurrentTargetAddress - (uint32_t)lpusart->info->xfer.rx_buf);
#endif

#ifdef PM_FEATURE_ENABLE
            LOCK_SLEEP(0, 1);
#endif
            lpusart->info->rx_status.rx_busy = 1U;
            lpusart->info->rx_status.rx_dma_triggered = 1;

            if(dmaCurrentTargetAddress == ( (uint32_t)lpusart->info->xfer.rx_buf + lpusart->info->xfer.rx_num))
            {
#if LPUSART_DRIVER_DEBUG
                ECPLAT_PRINTF(UNILOG_PLA_DRIVER, CO_USART_DmaRxEvent_1, P_DEBUG, "uart dma rx complete");
#endif
                lpusart->info->xfer.rx_cnt = lpusart->info->xfer.rx_num;

                //Disable all recv interrupt
                lpusart->co_usart_regs->IER &= ~(USART_IER_RX_DATA_REQ_Msk | USART_IER_RX_TIMEOUT_Msk | USART_IER_RX_LINE_STATUS_Msk);
                lpusart->info->rx_status.rx_busy = 0;
                lpusart->info->rx_status.rx_dma_triggered = 0;

                if(lpusart->info->cb_event)
                {
                    lpusart->info->cb_event(ARM_USART_EVENT_RECEIVE_COMPLETE);
                }

#ifdef PM_FEATURE_ENABLE
                CHECK_TO_UNLOCK_SLEEP(0, 1);
#endif
            }

            break;
        case DMA_EVENT_ERROR:
        default:
            break;
    }
}
#if (RTE_UART1)
static int32_t                    LPUSART1_Initialize      (ARM_USART_SignalEvent_t cb_event)                    { return LPUSART_Initialize(cb_event, &LPUSART1_Resources); }
static int32_t                    LPUSART1_Uninitialize    (void)                                                { return LPUSART_Uninitialize(&LPUSART1_Resources); }
static int32_t                    LPUSART1_PowerControl    (ARM_POWER_STATE state)                               { return LPUSART_PowerControl(state, &LPUSART1_Resources); }
static int32_t                    LPUSART1_Send            (const void *data, uint32_t num)                      { return LPUSART_Send(data, num, &LPUSART1_Resources); }
static int32_t                    LPUSART1_Receive         (void *data, uint32_t num)                            { return LPUSART_Receive(data, num, &LPUSART1_Resources); }
static int32_t                    LPUSART1_Transfer        (const void *data_out, void *data_in, uint32_t num)   { return LPUSART_Transfer(data_out, data_in, num, &LPUSART1_Resources); }
static int32_t                    LPUSART1_SendPolling     (const void *data, uint32_t num)                      { return LPUSART_SendPolling (data, num, &LPUSART1_Resources); }
static uint32_t                   LPUSART1_GetTxCount      (void)                                                { return LPUSART_GetTxCount(&LPUSART1_Resources); }
PLAT_PA_RAMCODE static uint32_t  LPUSART1_GetRxCount      (void)                                                { return LPUSART_GetRxCount(&LPUSART1_Resources); }
static uint32_t                   LPUSART1_GetBaudRate      (void)                                                 { return LPUSART_GetBaudRate(&LPUSART1_Resources); }
static int32_t                    LPUSART1_Control         (uint32_t control, uint32_t arg)                      { return LPUSART_Control(control, arg, &LPUSART1_Resources); }
static ARM_USART_STATUS           LPUSART1_GetStatus       (void)                                                { return LPUSART_GetStatus(&LPUSART1_Resources); }
static int32_t                    LPUSART1_SetModemControl (ARM_USART_MODEM_CONTROL control)                     { return LPUSART_SetModemControl(control, &LPUSART1_Resources); }
static ARM_USART_MODEM_STATUS     LPUSART1_GetModemStatus  (void)                                                { return LPUSART_GetModemStatus(&LPUSART1_Resources); }
PLAT_PA_RAMCODE       void       LPUSART1_IRQHandler      (void)                                                {        LPUSART_IRQHandler(&LPUSART1_Resources); }
PLAT_PA_RAMCODE       void       CO_USART1_IRQHandler      (void)                                               {        CO_USART_IRQHandler(&LPUSART1_Resources); }
#if (RTE_UART1_TX_IO_MODE == DMA_MODE)
void                              LPUSART1_DmaTxEvent(uint32_t event)                                            { LPUSART_DmaTxEvent(event, &LPUSART1_Resources);}
#endif
#if (RTE_UART1_RX_IO_MODE == DMA_MODE)
void                              CO_USART1_DmaRxEvent(uint32_t event)                                           { CO_USART_DmaRxEvent(event, &LPUSART1_Resources);};
#endif

ARM_DRIVER_USART Driver_LPUSART1 = {
    LPUSART_GetVersion,
    LPUSART_GetCapabilities,
    LPUSART1_Initialize,
    LPUSART1_Uninitialize,
    LPUSART1_PowerControl,
    LPUSART1_Send,
    LPUSART1_Receive,
    LPUSART1_Transfer,
    LPUSART1_GetTxCount,
    LPUSART1_GetRxCount,
    LPUSART1_Control,
    LPUSART1_GetStatus,
    LPUSART1_SetModemControl,
    LPUSART1_GetModemStatus,
    LPUSART1_GetBaudRate,
    LPUSART1_SendPolling
};

#endif

//#pragma pop

