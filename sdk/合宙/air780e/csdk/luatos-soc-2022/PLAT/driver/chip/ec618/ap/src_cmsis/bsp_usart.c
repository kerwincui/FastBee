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
#include "bsp_usart.h"
#include "slpman.h"

#ifdef PM_FEATURE_ENABLE
#define USART_DEBUG  1
#if USART_DEBUG
#include DEBUG_LOG_HEADER_FILE
#endif
#endif

#define ARM_USART_DRV_VERSION    ARM_DRIVER_VERSION_MAJOR_MINOR(2, 0)  /* driver version */

#if ((!RTE_UART0) && (!RTE_UART1)) && (!RTE_UART2)
#error "UART not enabled in RTE_Device.h!"
#endif

enum _USART_RX_FIFO_TRIG_LVL
{
    RX_FIFO_TRIG_LVL_1BYTE   = 1U,
    RX_FIFO_TRIG_LVL_8BYTE   = 8U,
    RX_FIFO_TRIG_LVL_16BYTE  = 16U,
    RX_FIFO_TRIG_LVL_30BYTE  = 30U
};

enum _USART_TX_FIFO_TRIG_LVL
{
    TX_FIFO_TRIG_LVL_0BYTE,
    TX_FIFO_TRIG_LVL_2BYTE,
    TX_FIFO_TRIG_LVL_8BYTE,
    TX_FIFO_TRIG_LVL_16BYTE
};

#define UART_DMA_BURST_SIZE      8

// Trigger level definitions
#ifndef USART0_RX_TRIG_LVL

#if (RTE_UART0_RX_IO_MODE == DMA_MODE)
#define USART0_RX_TRIG_LVL   RX_FIFO_TRIG_LVL_16BYTE
#else
#define USART0_RX_TRIG_LVL   RX_FIFO_TRIG_LVL_30BYTE
#endif

#endif

#ifndef USART1_RX_TRIG_LVL

#if (RTE_UART1_RX_IO_MODE == DMA_MODE)
#define USART1_RX_TRIG_LVL   RX_FIFO_TRIG_LVL_16BYTE
#else
#define USART1_RX_TRIG_LVL   RX_FIFO_TRIG_LVL_30BYTE
#endif

#endif

#ifndef USART2_RX_TRIG_LVL

#if (RTE_UART2_RX_IO_MODE == DMA_MODE)
#define USART2_RX_TRIG_LVL   RX_FIFO_TRIG_LVL_16BYTE
#else
#define USART2_RX_TRIG_LVL   RX_FIFO_TRIG_LVL_30BYTE
#endif

#endif

#define USART0_TX_TRIG_LVL   TX_FIFO_TRIG_LVL_0BYTE
#define USART1_TX_TRIG_LVL   TX_FIFO_TRIG_LVL_0BYTE
#define USART2_TX_TRIG_LVL   TX_FIFO_TRIG_LVL_0BYTE

#ifdef PM_FEATURE_ENABLE
/** \brief Internal used data structure */
typedef struct _usart_database
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
        uint32_t ADCR;                                   /**< Auto-baud Detect Control Register*/
    } backup_registers;                                  /**< Backup registers for low power restore */
    bool     autoBaudRateDone;                           /**< Flag indication whether auto baud dection is done */
} usart_database_t;

static usart_database_t g_usartDataBase[USART_INSTANCE_NUM] = {0};

static USART_TypeDef* const g_usartBases[USART_INSTANCE_NUM] = {USART_0, USART_1, USART_2};
#endif

static const ClockId_e g_uartClocks[USART_INSTANCE_NUM*2] = {PCLK_UART0, FCLK_UART0,
                                                        PCLK_UART1, FCLK_UART1,
                                                        PCLK_UART2, FCLK_UART2
                                                        };

static const ClockResetVector_t g_usartResetVectors[] = {UART0_RESET_VECTOR, UART1_RESET_VECTOR, UART2_RESET_VECTOR};

#ifdef PM_FEATURE_ENABLE
/**
  \brief usart initialization counter, for lower power callback register/de-register
 */
static uint32_t g_usartInitCounter = 0;

/**
  \brief Bitmap of USART working status,
         when all USART instances are not working, we can vote to enter to low power state.
 */
static uint32_t g_usartWorkingStatus = 0;


/**
  \fn        static void USART_EnterLowPowerStatePrepare(void* pdata, slpManLpState state)
  \brief     Perform necessary preparations before sleep.
             After recovering from SLPMAN_SLEEP1_STATE, USART hareware is repowered, we backup
             some registers here first so that we can restore user's configurations after exit.
  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state
 */
static void USART_EnterLowPowerStatePrepare(void* pdata, slpManLpState state)
{
    uint32_t i;

    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            for(i = 0; i < USART_INSTANCE_NUM; i++)
            {
                if(g_usartDataBase[i].isInited == true)
                {
                    g_usartDataBase[i].backup_registers.IER = g_usartBases[i]->IER;
                    g_usartDataBase[i].backup_registers.LCR = g_usartBases[i]->LCR;
                    g_usartDataBase[i].backup_registers.MCR = g_usartBases[i]->MCR;
                    g_usartDataBase[i].backup_registers.MFCR = g_usartBases[i]->MFCR;
                    g_usartDataBase[i].backup_registers.EFCR = g_usartBases[i]->EFCR;
                    g_usartDataBase[i].backup_registers.ADCR = g_usartBases[i]->ADCR;
                }
            }
            break;
        default:
            break;
    }

}

/**
  \fn        static void USART_ExitLowPowerStateRestore(void* pdata, slpManLpState state)
  \brief     Restore after exit from sleep.
             After recovering from SLPMAN_SLEEP1_STATE, USART hareware is repowered, we restore user's configurations
             by aidding of the stored registers.

  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state

 */
static void USART_ExitLowPowerStateRestore(void* pdata, slpManLpState state)
{
    uint32_t i;
    extern bool apmuGetSleepedFlag(void);

    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            // no need to restore if failing to sleep
            if(apmuGetSleepedFlag() == false)
            {
                break;
            }

            for(i = 0; i < USART_INSTANCE_NUM; i++)
            {
                if(g_usartDataBase[i].isInited == true)
                {
                    GPR_clockEnable(g_uartClocks[2*i]);
                    GPR_clockEnable(g_uartClocks[2*i+1]);

                    g_usartBases[i]->LCR |= USART_LCR_ACCESS_DIVISOR_LATCH_Msk;
                    g_usartBases[i]->DLL = g_usartDataBase[i].backup_registers.DLL;
                    g_usartBases[i]->DLH = g_usartDataBase[i].backup_registers.DLH;

                    g_usartBases[i]->LCR &= ~USART_LCR_ACCESS_DIVISOR_LATCH_Msk;
                    g_usartBases[i]->IER = g_usartDataBase[i].backup_registers.IER;
                    g_usartBases[i]->LCR = g_usartDataBase[i].backup_registers.LCR;
                    g_usartBases[i]->MCR = g_usartDataBase[i].backup_registers.MCR;
                    g_usartBases[i]->EFCR = g_usartDataBase[i].backup_registers.EFCR;
                    g_usartBases[i]->FCR = g_usartDataBase[i].backup_registers.FCR;
                    g_usartBases[i]->MFCR = g_usartDataBase[i].backup_registers.MFCR;
                }
            }
            break;

        default:
            break;
    }

}

#define  LOCK_SLEEP(instance, tx, rx)     do                                                                   \
                                          {                                                                    \
                                              g_usartWorkingStatus |= (rx << (2 * instance));                    \
                                              g_usartWorkingStatus |= (tx << (2 * instance + 1));                \
                                              slpManDrvVoteSleep(SLP_VOTE_USART, SLP_ACTIVE_STATE);     \
                                          }                                                                   \
                                          while(0)

#define  CHECK_TO_UNLOCK_SLEEP(instance, tx, rx)      do                                                                  \
                                                      {                                                                   \
                                                          g_usartWorkingStatus &= ~(rx << (2 * instance));                  \
                                                          g_usartWorkingStatus &= ~(tx << (2 * instance + 1));              \
                                                          if(g_usartWorkingStatus == 0)                                   \
                                                              slpManDrvVoteSleep(SLP_VOTE_USART, SLP_SLP1_STATE);    \
                                                      }                                                                   \
                                                      while(0)
#endif

// declearation for DMA API
extern void DMA_stopChannelNoWait(DmaInstance_e instance, uint32_t channel);
extern uint32_t DMA_setDescriptorTransferLen(uint32_t dcmd, uint32_t len);
extern void DMA_loadChannelDescriptorAndRun(DmaInstance_e instance, uint32_t channel, void* descriptorAddress);
extern uint32_t DMA_getChannelCurrentTargetAddress(DmaInstance_e instance, uint32_t channel, bool sync);
extern void DMA_buildDescriptor(DmaDescriptor_t* descriptor, const DmaTransferConfig_t* config, const DmaExtraConfig_t* extraConfig);

// Driver Version
static const ARM_DRIVER_VERSION DriverVersion = {
    ARM_USART_API_VERSION,
    ARM_USART_DRV_VERSION
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

void USART0_IRQHandler(void);
void USART1_IRQHandler(void);
void USART2_IRQHandler(void);

#if (RTE_UART0)

static USART_INFO      USART0_Info = { 0U };
static const PIN USART0_pin_tx  = {RTE_UART0_TX_BIT,   RTE_UART0_TX_FUNC};
static const PIN USART0_pin_rx  = {RTE_UART0_RX_BIT,   RTE_UART0_RX_FUNC};
#if (RTE_UART0_CTS_PIN_EN == 1)
static const PIN USART0_pin_cts  = {RTE_UART0_CTS_BIT,   RTE_UART0_CTS_FUNC};
#endif
#if (RTE_UART0_RTS_PIN_EN == 1)
static const PIN USART0_pin_rts  = {RTE_UART0_RTS_BIT,   RTE_UART0_RTS_FUNC};
#endif

#if (RTE_UART0_TX_IO_MODE == DMA_MODE)

void USART0_DmaTxEvent(uint32_t event);
static USART_TX_DMA USART0_DMA_Tx = {
                                    DMA_INSTANCE_MP,
                                    -1,
                                    RTE_UART0_DMA_TX_REQID,
                                    USART0_DmaTxEvent
                                 };
#endif

#if (RTE_UART0_RX_IO_MODE == DMA_MODE)

void USART0_DmaRxEvent(uint32_t event);

static DmaDescriptor_t __ALIGNED(16) USART0_DMA_Rx_Descriptor[2];

static USART_RX_DMA USART0_DMA_Rx = {
                                    DMA_INSTANCE_MP,
                                    -1,
                                    RTE_UART0_DMA_RX_REQID,
                                    USART0_DMA_Rx_Descriptor,
                                    USART0_DmaRxEvent
                                 };

#endif

#if (RTE_UART0_TX_IO_MODE == IRQ_MODE) || (RTE_UART0_RX_IO_MODE == IRQ_MODE) || (RTE_UART0_RX_IO_MODE == DMA_MODE)
static USART_IRQ USART0_IRQ = {
                                PXIC0_UART0_IRQn,
                                USART0_IRQHandler
                              };
#endif


static const USART_RESOURCES USART0_Resources = {
    USART_0,
    {
      &USART0_pin_tx,
      &USART0_pin_rx,
#if (RTE_UART0_CTS_PIN_EN == 1)
      &USART0_pin_cts,
#else
      NULL,
#endif
#if (RTE_UART0_RTS_PIN_EN == 1)
      &USART0_pin_rts,
#else
      NULL,
#endif
    },

#if (RTE_UART0_TX_IO_MODE == DMA_MODE)
    &USART0_DMA_Tx,
#else
    NULL,
#endif

#if (RTE_UART0_RX_IO_MODE == DMA_MODE)
    &USART0_DMA_Rx,
#else
    NULL,
#endif
#if (RTE_UART0_TX_IO_MODE == IRQ_MODE) || (RTE_UART0_RX_IO_MODE == IRQ_MODE) || (RTE_UART0_RX_IO_MODE == DMA_MODE)
    &USART0_IRQ,
#else
    NULL,
#endif
    USART0_TX_TRIG_LVL,
    USART0_RX_TRIG_LVL,
    &USART0_Info,
#if (RTE_UART0_TX_IO_MODE == UNILOG_MODE)
    1,
#else
    0
#endif
};

#endif

#if (RTE_UART1)

static USART_INFO    USART1_Info  = { 0 };
static const PIN USART1_pin_tx  = {RTE_UART1_TX_BIT,   RTE_UART1_TX_FUNC};
static const PIN USART1_pin_rx  = {RTE_UART1_RX_BIT,   RTE_UART1_RX_FUNC};
#if (RTE_UART1_CTS_PIN_EN == 1)
static const PIN USART1_pin_cts  = {RTE_UART1_CTS_BIT,   RTE_UART1_CTS_FUNC};
#endif
#if (RTE_UART1_RTS_PIN_EN == 1)
static const PIN USART1_pin_rts  = {RTE_UART1_RTS_BIT,   RTE_UART1_RTS_FUNC};
#endif

#if (RTE_UART1_TX_IO_MODE == DMA_MODE)

void USART1_DmaTxEvent(uint32_t event);
static USART_TX_DMA USART1_DMA_Tx = {
                                    DMA_INSTANCE_MP,
                                    -1,
                                    RTE_UART1_DMA_TX_REQID,
                                    USART1_DmaTxEvent
                                 };
#endif

#if (RTE_UART1_RX_IO_MODE == DMA_MODE)

void USART1_DmaRxEvent(uint32_t event);

static DmaDescriptor_t __ALIGNED(16) USART1_DMA_Rx_Descriptor[2];

static USART_RX_DMA USART1_DMA_Rx = {
                                    DMA_INSTANCE_MP,
                                    -1,
                                    RTE_UART1_DMA_RX_REQID,
                                    USART1_DMA_Rx_Descriptor,
                                    USART1_DmaRxEvent
                                 };

#endif

#if (RTE_UART1_TX_IO_MODE == IRQ_MODE) || (RTE_UART1_RX_IO_MODE == IRQ_MODE) || (RTE_UART1_RX_IO_MODE == DMA_MODE)
static USART_IRQ USART1_IRQ = {
                                PXIC0_UART1_IRQn,
                                USART1_IRQHandler
                              };
#endif

static const USART_RESOURCES USART1_Resources = {
    USART_1,
    {
      &USART1_pin_tx,
      &USART1_pin_rx,
#if (RTE_UART1_CTS_PIN_EN == 1)
      &USART1_pin_cts,
#else
      NULL,
#endif
#if (RTE_UART1_RTS_PIN_EN == 1)
      &USART1_pin_rts,
#else
      NULL,
#endif
    },

#if (RTE_UART1_TX_IO_MODE == DMA_MODE)
    &USART1_DMA_Tx,
#else
    NULL,
#endif

#if (RTE_UART1_RX_IO_MODE == DMA_MODE)
    &USART1_DMA_Rx,
#else
    NULL,
#endif
#if (RTE_UART1_TX_IO_MODE == IRQ_MODE) || (RTE_UART1_RX_IO_MODE == IRQ_MODE) || (RTE_UART1_RX_IO_MODE == DMA_MODE)
    &USART1_IRQ,
#else
    NULL,
#endif
    USART1_TX_TRIG_LVL,
    USART1_RX_TRIG_LVL,
    &USART1_Info,
#if (RTE_UART1_TX_IO_MODE == UNILOG_MODE)
    1,
#else
    0
#endif
};
#endif

#if (RTE_UART2)

static USART_INFO    USART2_Info  = { 0 };
static const PIN USART2_pin_tx  = {RTE_UART2_TX_BIT,   RTE_UART2_TX_FUNC};
static const PIN USART2_pin_rx  = {RTE_UART2_RX_BIT,   RTE_UART2_RX_FUNC};
#if (RTE_UART2_CTS_PIN_EN == 1)
static const PIN USART2_pin_cts  = {RTE_UART2_CTS_BIT,   RTE_UART2_CTS_FUNC};
#endif
#if (RTE_UART2_RTS_PIN_EN == 1)
static const PIN USART2_pin_rts  = {RTE_UART2_RTS_BIT,   RTE_UART2_RTS_FUNC};
#endif

#if (RTE_UART2_TX_IO_MODE == DMA_MODE)

void USART2_DmaTxEvent(uint32_t event);
static USART_TX_DMA USART2_DMA_Tx = {
                                    DMA_INSTANCE_MP,
                                    -1,
                                    RTE_UART2_DMA_TX_REQID,
                                    USART2_DmaTxEvent
                                 };
#endif

#if (RTE_UART2_RX_IO_MODE == DMA_MODE)

void USART2_DmaRxEvent(uint32_t event);

static DmaDescriptor_t __ALIGNED(16) USART2_DMA_Rx_Descriptor[2];

static USART_RX_DMA USART2_DMA_Rx = {
                                    DMA_INSTANCE_MP,
                                    -1,
                                    RTE_UART2_DMA_RX_REQID,
                                    USART2_DMA_Rx_Descriptor,
                                    USART2_DmaRxEvent
                                 };

#endif

#if (RTE_UART2_TX_IO_MODE == IRQ_MODE) || (RTE_UART2_RX_IO_MODE == IRQ_MODE) || (RTE_UART2_RX_IO_MODE == DMA_MODE)
static USART_IRQ USART2_IRQ = {
                                PXIC0_UART2_IRQn,
                                USART2_IRQHandler
                              };
#endif

static const USART_RESOURCES USART2_Resources = {
    USART_2,
    {
      &USART2_pin_tx,
      &USART2_pin_rx,
#if (RTE_UART2_CTS_PIN_EN == 1)
      &USART2_pin_cts,
#else
      NULL,
#endif
#if (RTE_UART2_RTS_PIN_EN == 1)
      &USART2_pin_rts,
#else
      NULL,
#endif
    },

#if (RTE_UART2_TX_IO_MODE == DMA_MODE)
    &USART2_DMA_Tx,
#else
    NULL,
#endif

#if (RTE_UART2_RX_IO_MODE == DMA_MODE)
    &USART2_DMA_Rx,
#else
    NULL,
#endif
#if (RTE_UART2_TX_IO_MODE == IRQ_MODE) || (RTE_UART2_RX_IO_MODE == IRQ_MODE) || (RTE_UART2_RX_IO_MODE == DMA_MODE)
    &USART2_IRQ,
#else
    NULL,
#endif
    USART2_TX_TRIG_LVL,
    USART2_RX_TRIG_LVL,
    &USART2_Info,
#if (RTE_UART2_TX_IO_MODE == UNILOG_MODE)
    1,
#else
    0
#endif
};
#endif


static DmaTransferConfig_t dmaTxConfig = {NULL, NULL,
                                       DMA_FLOW_CONTROL_TARGET, DMA_ADDRESS_INCREMENT_SOURCE,
                                       DMA_DATA_WIDTH_ONE_BYTE, DMA_BURST_16_BYTES, 0
                                      };

ARM_DRIVER_VERSION ARM_USART_GetVersion(void)
{
    return DriverVersion;
}

ARM_USART_CAPABILITIES USART_GetCapabilities(const USART_RESOURCES *usart)
{
    return DriverCapabilities;
}

PLAT_PA_RAMCODE static uint32_t USART_GetInstanceNumber(USART_RESOURCES *usart)
{
    return ((uint32_t)usart->reg - (uint32_t)USART_0) >> 12;
}

/*
 * when uart input clock is 26000000, the supported baudrate is:
 * 300,600,1200,2400,
 * 4800,9600,14400,19200,
 * 28800,38400,56000,57600,
 * 115200,230400,460800,921600,
 * 1000000,1500000,2000000,3000000
 *
 */
int32_t USART_SetBaudrate (uint32_t baudrate, USART_RESOURCES *usart)
{
    uint8_t frac = 0;
    uint32_t uart_clock = 0;
    uint32_t div, instance;
    int32_t i;

    instance = USART_GetInstanceNumber(usart);

    uart_clock = GPR_getClockFreq(g_uartClocks[instance*2+1]);

    if(baudrate == 0)
    {
        usart->reg->ADCR = 0x3;
    }
    else
    {
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

        if (i > 2)
            return ARM_DRIVER_ERROR_PARAMETER;

        // Disable uart first
        usart->reg->MFCR &= ~USART_MFCR_UART_EN_Msk;

        // Enable latch bit to change divisor
        usart->reg->LCR |= USART_LCR_ACCESS_DIVISOR_LATCH_Msk;
        usart->reg->MFCR = ((usart->reg->MFCR & ~USART_MFCR_PRESCALE_FACTOR_Msk) | EIGEN_VAL2FLD(USART_MFCR_PRESCALE_FACTOR, i));
        usart->reg->DLL = (div >> 0) & 0xff;
        usart->reg->DLH = (div >> 8) & 0xff;
        usart->reg->EFCR = ((usart->reg->EFCR & ~USART_EFCR_FRAC_DIVISOR_Msk) | (frac << USART_EFCR_FRAC_DIVISOR_Pos));
        // Reset latch bit
        usart->reg->LCR &= (~USART_LCR_ACCESS_DIVISOR_LATCH_Msk);

#ifdef PM_FEATURE_ENABLE
        // backup setting
        g_usartDataBase[instance].backup_registers.DLL = (div >> 0) & 0xff;
        g_usartDataBase[instance].backup_registers.DLH = (div >> 8) & 0xff;
#endif
    }

    usart->info->baudrate = baudrate;

    return ARM_DRIVER_OK;
}

uint32_t USART_GetBaudRate(USART_RESOURCES *usart)
{
    return usart->info->baudrate;
}


static void USART_DmaRxConfig(USART_RESOURCES *usart)
{

    DmaTransferConfig_t dmaConfig;
    DmaExtraConfig_t extraConfig;

    dmaConfig.addressIncrement              = DMA_ADDRESS_INCREMENT_TARGET;
    dmaConfig.burstSize                     = DMA_BURST_8_BYTES;
    dmaConfig.dataWidth                     = DMA_DATA_WIDTH_ONE_BYTE;
    dmaConfig.flowControl                   = DMA_FLOW_CONTROL_SOURCE;
    dmaConfig.sourceAddress                 = (void*)&(usart->reg->RBR);
    dmaConfig.targetAddress                 = NULL;
    dmaConfig.totalLength                   = UART_DMA_BURST_SIZE;

    extraConfig.stopDecriptorFetch          = false;
    extraConfig.enableStartInterrupt        = false;
    extraConfig.enableEndInterrupt          = true;
    extraConfig.nextDesriptorAddress        = &usart->dma_rx->descriptor[1];

    DMA_buildDescriptor(&usart->dma_rx->descriptor[0], &dmaConfig, &extraConfig);

    extraConfig.stopDecriptorFetch          = true;
    extraConfig.nextDesriptorAddress        = &usart->dma_rx->descriptor[0];
    DMA_buildDescriptor(&usart->dma_rx->descriptor[1], &dmaConfig, &extraConfig);
    DMA_resetChannel(usart->dma_rx->instance, usart->dma_rx->channel);

}

PLAT_PA_RAMCODE static void USART_DmaUpdateRxConfig(USART_RESOURCES *usart, uint32_t targetAddress, uint32_t num)
{
    uint32_t firstDescriptorLen = MIN(num, UART_DMA_BURST_SIZE);

    usart->dma_rx->descriptor[0].TAR = targetAddress;
    usart->dma_rx->descriptor[0].CMDR = DMA_setDescriptorTransferLen(usart->dma_rx->descriptor[1].CMDR, firstDescriptorLen);

    usart->dma_rx->descriptor[1].TAR = usart->dma_rx->descriptor[0].TAR + firstDescriptorLen;
    usart->dma_rx->descriptor[1].CMDR = DMA_setDescriptorTransferLen(usart->dma_rx->descriptor[1].CMDR, num - firstDescriptorLen);
}

int32_t USART_Initialize(ARM_USART_SignalEvent_t cb_event, USART_RESOURCES *usart)
{
    int32_t returnCode;
#ifdef PM_FEATURE_ENABLE
    uint32_t instance;
#endif

    if (usart->info->flags & USART_FLAG_INITIALIZED)
        return ARM_DRIVER_OK;

    // Pin initialize
    PadConfig_t config;
    PAD_getDefaultConfig(&config);

    config.mux = usart->pins.pin_tx->funcNum;
    PAD_setPinConfig(usart->pins.pin_tx->pinNum, &config);

    config.pullSelect = PAD_PULL_INTERNAL;
    config.pullUpEnable = PAD_PULL_UP_ENABLE;
    config.pullDownEnable = PAD_PULL_DOWN_DISABLE;
    config.mux = usart->pins.pin_rx->funcNum;

    PAD_setPinConfig(usart->pins.pin_rx->pinNum, &config);

    if(usart->pins.pin_cts)
    {
        config.mux = usart->pins.pin_cts->funcNum;
        PAD_setPinConfig(usart->pins.pin_cts->pinNum, &config);
    }

    if(usart->pins.pin_rts)
    {
        config.mux = usart->pins.pin_rts->funcNum;
        PAD_setPinConfig(usart->pins.pin_rts->pinNum, &config);
    }

#ifdef PM_FEATURE_ENABLE
    instance = USART_GetInstanceNumber(usart);
    g_usartDataBase[instance].isInited = true;
#endif

    // Initialize USART run-time resources
    usart->info->cb_event = cb_event;
    memset(&(usart->info->rx_status), 0, sizeof(USART_STATUS));

    usart->info->xfer.send_active           = 0U;
    usart->info->xfer.tx_def_val            = 0U;

    if (usart->dma_tx)
    {
        returnCode = DMA_openChannel(usart->dma_tx->instance);

        if (returnCode == ARM_DMA_ERROR_CHANNEL_ALLOC)
            return ARM_DRIVER_ERROR;
        else
            usart->dma_tx->channel = returnCode;

        DMA_setChannelRequestSource(usart->dma_tx->instance, usart->dma_tx->channel, (DmaRequestSource_e)usart->dma_tx->request);
        DMA_rigisterChannelCallback(usart->dma_tx->instance, usart->dma_tx->channel, usart->dma_tx->callback);
    }
    if (usart->dma_rx)
    {
        returnCode = DMA_openChannel(usart->dma_rx->instance);

        if (returnCode == ARM_DMA_ERROR_CHANNEL_ALLOC)
            return ARM_DRIVER_ERROR;
        else
            usart->dma_rx->channel = returnCode;

        DMA_setChannelRequestSource(usart->dma_rx->instance, usart->dma_rx->channel, (DmaRequestSource_e)usart->dma_rx->request);
        USART_DmaRxConfig(usart);
        DMA_rigisterChannelCallback(usart->dma_rx->instance, usart->dma_rx->channel, usart->dma_rx->callback);
    }

    usart->info->flags = USART_FLAG_INITIALIZED;  // USART is initialized

#ifdef PM_FEATURE_ENABLE
    g_usartInitCounter++;

    if(g_usartInitCounter == 1)
    {
        g_usartWorkingStatus = 0;
        slpManRegisterPredefinedBackupCb(SLP_CALLBACK_USART_MODULE, USART_EnterLowPowerStatePrepare, NULL);
        slpManRegisterPredefinedRestoreCb(SLP_CALLBACK_USART_MODULE, USART_ExitLowPowerStateRestore, NULL);
    }
#endif
    return ARM_DRIVER_OK;
}

int32_t USART_Uninitialize(USART_RESOURCES *usart)
{
#ifdef PM_FEATURE_ENABLE
    uint32_t instance;
    instance = USART_GetInstanceNumber(usart);
#endif

    usart->info->flags = 0U;
    usart->info->cb_event = NULL;

    if(usart->dma_tx)
    {
        DMA_closeChannel(usart->dma_tx->instance, usart->dma_tx->channel);
    }

    if(usart->dma_rx)
    {
        DMA_closeChannel(usart->dma_rx->instance, usart->dma_rx->channel);
    }

#ifdef PM_FEATURE_ENABLE

    g_usartDataBase[instance].isInited = false;

    g_usartInitCounter--;

    if(g_usartInitCounter == 0)
    {
        g_usartWorkingStatus = 0;
        slpManUnregisterPredefinedBackupCb(SLP_CALLBACK_USART_MODULE);
        slpManUnregisterPredefinedRestoreCb(SLP_CALLBACK_USART_MODULE);
    }
#endif

    return ARM_DRIVER_OK;
}

int32_t USART_PowerControl(ARM_POWER_STATE state,USART_RESOURCES *usart)
{
    uint32_t instance;
    uint32_t val = 0;

    instance = USART_GetInstanceNumber(usart);

    switch (state)
    {
        case ARM_POWER_OFF:

            // Reset USART registers
            GPR_swResetModule(&g_usartResetVectors[instance]);

            // DMA disable
            if(usart->dma_tx)
                DMA_stopChannel(usart->dma_tx->instance, usart->dma_tx->channel, false);
            if(usart->dma_rx)
                DMA_stopChannel(usart->dma_rx->instance, usart->dma_rx->channel, false);


            // Disable power to usart clock
            CLOCK_clockDisable(g_uartClocks[instance*2]);
            CLOCK_clockDisable(g_uartClocks[instance*2+1]);

            // Clear driver variables
            memset(&(usart->info->rx_status), 0, sizeof(USART_STATUS));
            usart->info->frame_code       = 0U;
            usart->info->xfer.send_active = 0U;

            // Disable USART IRQ
            if(usart->usart_irq)
            {
                XIC_ClearPendingIRQ(usart->usart_irq->irq_num);
                XIC_DisableIRQ(usart->usart_irq->irq_num);
            }

            usart->info->flags &= ~(USART_FLAG_POWERED | USART_FLAG_CONFIGURED);

            break;

        case ARM_POWER_LOW:
            return ARM_DRIVER_ERROR_UNSUPPORTED;

        case ARM_POWER_FULL:
            if ((usart->info->flags & USART_FLAG_INITIALIZED) == 0U)
            {
                return ARM_DRIVER_ERROR;
            }
            if (usart->info->flags & USART_FLAG_POWERED)
            {
                return ARM_DRIVER_OK;
            }

            // Enable power to usart clock
            CLOCK_clockEnable(g_uartClocks[instance*2]);
            CLOCK_clockEnable(g_uartClocks[instance*2+1]);

            // Disable interrupts
            usart->reg->IER = 0U;
            // Clear driver variables
            memset(&(usart->info->rx_status), 0, sizeof(USART_STATUS));
            usart->info->frame_code       = 0U;
            usart->info->xfer.send_active = 0U;

            // Configure FIFO Control register
            val = USART_FCR_FIFO_EN_Msk | USART_FCR_RESET_RX_FIFO_Msk | USART_FCR_RESET_TX_FIFO_Msk;

            switch(usart->rx_fifo_trig_lvl)
            {
                case RX_FIFO_TRIG_LVL_8BYTE:
                    val |= (1U << USART_FCR_RX_FIFO_AVAIL_TRIG_LEVEL_Pos);
                    break;

                case RX_FIFO_TRIG_LVL_16BYTE:
                    val |= (2U << USART_FCR_RX_FIFO_AVAIL_TRIG_LEVEL_Pos);
                    break;

                case RX_FIFO_TRIG_LVL_30BYTE:
                    val |= (3U << USART_FCR_RX_FIFO_AVAIL_TRIG_LEVEL_Pos);
                    break;
                default:
                    break;
            }

            switch(usart->tx_fifo_trig_lvl)
            {
                case TX_FIFO_TRIG_LVL_2BYTE:
                    val |= (1U << USART_FCR_TX_FIFO_EMPTY_TRIG_LEVEL_Pos);
                    break;

                case TX_FIFO_TRIG_LVL_8BYTE:
                    val |= (2U << USART_FCR_TX_FIFO_EMPTY_TRIG_LEVEL_Pos);
                    break;

                case TX_FIFO_TRIG_LVL_16BYTE:
                    val |= (3U << USART_FCR_TX_FIFO_EMPTY_TRIG_LEVEL_Pos);
                    break;
                default:
                    break;
            }

            usart->reg->FCR = val;

#ifdef PM_FEATURE_ENABLE
            g_usartDataBase[instance].backup_registers.FCR = val;
#endif

            if(usart->dma_tx || usart->dma_rx || usart->is_unilog_mode == 1)
            {
                usart->reg->MFCR |= USART_MFCR_DMA_EN_Msk;
            }

            if(usart->usart_irq)
            {
                XIC_SetVector(usart->usart_irq->irq_num, usart->usart_irq->cb_irq);
                XIC_EnableIRQ(usart->usart_irq->irq_num);
                XIC_SuppressOvfIRQ(usart->usart_irq->irq_num);
            }
            usart->info->flags |= USART_FLAG_POWERED;  // USART is powered on

            break;

        default:
            return ARM_DRIVER_ERROR_UNSUPPORTED;
    }
    return ARM_DRIVER_OK;
}

int32_t USART_Send(const void *data, uint32_t num, USART_RESOURCES *usart)
{
    uint32_t mask;
#ifdef PM_FEATURE_ENABLE
    uint32_t instance = USART_GetInstanceNumber(usart);
#endif

    if ((data == NULL) || (num == 0U))
        return ARM_DRIVER_ERROR_PARAMETER;
    if ((usart->info->flags & USART_FLAG_CONFIGURED) == 0U)
        return ARM_DRIVER_ERROR;

#ifdef PM_FEATURE_ENABLE
    if(usart->reg->MCR == 0x10)
    {
        return ARM_DRIVER_OK;
    }

    if((usart->reg->ADCR & USART_ADCR_AUTO_BAUD_INT_EN_Msk) && (g_usartDataBase[instance].autoBaudRateDone == false))
    {
        if(usart->info->cb_event && usart->dma_tx)
        {
            usart->info->cb_event(ARM_USART_EVENT_SEND_COMPLETE);
        }

        return ARM_DRIVER_OK;
    }
#endif

    mask = SaveAndSetIRQMask();
    if (usart->info->xfer.send_active != 0)
    {
        RestoreIRQMask(mask);
        return ARM_DRIVER_ERROR_BUSY;
    }

    usart->info->xfer.send_active = 1U;
    RestoreIRQMask(mask);


    // Save transmit buffer info
    usart->info->xfer.tx_buf = (uint8_t *)data;
    usart->info->xfer.tx_num = num;
    usart->info->xfer.tx_cnt = 0U;
    // DMA mode
    if(usart->dma_tx)
    {
#if 0
        // wait until tx is empty
        while((usart->reg->LSR & USART_LSR_TX_EMPTY_Msk) == 0);
#else
        // relax the constraint
        while(EIGEN_FLD2VAL(USART_FCNR_TX_FIFO_NUM, usart->reg->FCNR) > 16);
#endif

#ifdef PM_FEATURE_ENABLE
        mask = SaveAndSetIRQMask();

        LOCK_SLEEP(instance, 1, 0);

        RestoreIRQMask(mask);
#endif

        if(num == 1)
        {
            mask = SaveAndSetIRQMask();

            usart->reg->IER |= USART_IER_TX_DATA_REQ_Msk;

            usart->reg->THR = usart->info->xfer.tx_buf[0];

            RestoreIRQMask(mask);
        }
        else
        {
            dmaTxConfig.sourceAddress = (void*)data;
            dmaTxConfig.targetAddress = (void*)&(usart->reg->THR);
            dmaTxConfig.totalLength = num-1;

            // Configure tx DMA and start it
            DMA_transferSetup(usart->dma_tx->instance, usart->dma_tx->channel, &dmaTxConfig);
            DMA_enableChannelInterrupts(usart->dma_tx->instance, usart->dma_tx->channel, DMA_END_INTERRUPT_ENABLE);
            DMA_startChannel(usart->dma_tx->instance, usart->dma_tx->channel);
        }

    }
    else
    {
        while (usart->info->xfer.tx_cnt < usart->info->xfer.tx_num)
        {
            // wait until tx is empty
            while((usart->reg->LSR & USART_LSR_TX_EMPTY_Msk) == 0);
            usart->reg->THR = usart->info->xfer.tx_buf[usart->info->xfer.tx_cnt++];
        }
        while((usart->reg->LSR & USART_LSR_TX_EMPTY_Msk) == 0);
        mask = SaveAndSetIRQMask();
        usart->info->xfer.send_active = 0U;
        RestoreIRQMask(mask);
    }

    return ARM_DRIVER_OK;
}


int32_t USART_SendPolling(const void *data, uint32_t num, USART_RESOURCES *usart)
{
    uint32_t mask;
#ifdef PM_FEATURE_ENABLE
    uint32_t instance = USART_GetInstanceNumber(usart);
#endif

    if ((data == NULL) || (num == 0U))
        return ARM_DRIVER_ERROR_PARAMETER;
    if ((usart->info->flags & USART_FLAG_CONFIGURED) == 0U)
        return ARM_DRIVER_ERROR;

#ifdef PM_FEATURE_ENABLE
    if(usart->reg->MCR == 0x10)
    {
        return ARM_DRIVER_OK;
    }

    if((usart->reg->ADCR & USART_ADCR_AUTO_BAUD_INT_EN_Msk) && (g_usartDataBase[instance].autoBaudRateDone == false))
    {
        return ARM_DRIVER_OK;
    }
#endif

    mask = SaveAndSetIRQMask();
    if (usart->info->xfer.send_active != 0)
    {
        RestoreIRQMask(mask);
        return ARM_DRIVER_ERROR_BUSY;
    }

    usart->info->xfer.send_active = 1U;
    RestoreIRQMask(mask);

    // Save transmit buffer info
    usart->info->xfer.tx_buf = (uint8_t *)data;
    usart->info->xfer.tx_num = num;
    usart->info->xfer.tx_cnt = 0U;

    while (usart->info->xfer.tx_cnt < usart->info->xfer.tx_num)
    {
        // wait until tx is empty
        while((usart->reg->LSR & USART_LSR_TX_EMPTY_Msk) == 0);
        usart->reg->THR = usart->info->xfer.tx_buf[usart->info->xfer.tx_cnt++];
    }
    while((usart->reg->LSR & USART_LSR_TX_EMPTY_Msk) == 0);

    mask = SaveAndSetIRQMask();
    usart->info->xfer.send_active = 0U;
    RestoreIRQMask(mask);

    return ARM_DRIVER_OK;
}

PLAT_PA_RAMCODE int32_t USART_Receive(void *data, uint32_t num, USART_RESOURCES *usart)
{
    uint32_t bytes_in_fifo, i;

    volatile uint32_t left_to_recv = num;

    if ((data == NULL) || num == 0U)
    {
        return ARM_DRIVER_ERROR_PARAMETER;
    }

    if ((usart->info->flags & USART_FLAG_CONFIGURED) == 0U)
    {
        return ARM_DRIVER_ERROR;
    }

    // check if receiver is busy
    if (usart->info->rx_status.rx_busy == 1U)
    {
        return ARM_DRIVER_ERROR_BUSY;
    }

    // save num of data to be received
    usart->info->xfer.rx_num = num;
    usart->info->xfer.rx_buf = (uint8_t *)data;
    usart->info->xfer.rx_cnt = 0U;

    usart->reg->IER |= USART_IER_RX_LINE_STATUS_Msk;

    // prepare in advance for dma recv
    if(usart->dma_rx)
    {
        usart->info->rx_status.rx_dma_triggered = 0;

        USART_DmaUpdateRxConfig(usart, (uint32_t)data, num);
    }

    usart->info->rx_status.rx_busy = 1U;

    // Lucky :), we have bytes waiting, try our best to receive all of them, however, let normal recv process handle the case if new data keeps arriving
    while((bytes_in_fifo = EIGEN_FLD2VAL(USART_FCNR_RX_FIFO_NUM, usart->reg->FCNR)) > 0)
    {

        if(usart->reg->LSR & USART_LSR_RX_BUSY_Msk)
        {
            break;
        }

        left_to_recv = num - usart->info->xfer.rx_cnt;

        i = MIN(bytes_in_fifo, left_to_recv);

        while(i--)
        {
            usart->info->xfer.rx_buf[usart->info->xfer.rx_cnt++] = usart->reg->RBR;
        }

        left_to_recv = num - usart->info->xfer.rx_cnt;

        // prepare in advance for dma recv
        if(usart->dma_rx)
        {
            USART_DmaUpdateRxConfig(usart, (uint32_t)&usart->info->xfer.rx_buf[usart->info->xfer.rx_cnt], left_to_recv);
        }

        if(left_to_recv == 0)
        {
            // Full
            usart->info->rx_status.rx_busy = 0;

            usart->reg->IER &= ~USART_IER_RX_LINE_STATUS_Msk;

            if(usart->info->cb_event != NULL)
            {
                usart->info->cb_event(ARM_USART_EVENT_RECEIVE_COMPLETE);
            }

            return ARM_DRIVER_OK;

        }

        // check again whether there's ongoing data stream
        if(usart->reg->LSR & USART_LSR_RX_BUSY_Msk)
        {
            break;
        }

    }

    // need to add protection to check rxfifo in irqHandler for 'fake' timeout, that's caused by
    // we have try to receive bytes from rxfifo as many as possible so when timeout occurs, there maybe no bytes left in rxfifo
    if(usart->dma_rx)
    {
        usart->reg->IER |= USART_IER_RX_TIMEOUT_Msk;

        DMA_loadChannelDescriptorAndRun(usart->dma_rx->instance, usart->dma_rx->channel, &usart->dma_rx->descriptor[0]);

        if(usart->info->xfer.rx_cnt != 0)
        {
            if(usart->reg->LSR & USART_LSR_RX_BUSY_Msk)
            {
                // do nothing if there's still data coming since we can let isr report later
            }
            else
            {
                // report to upper layer that we've received some data
                usart->info->rx_status.rx_busy = 0;

                // rx_busy is not reliable flag since it'll change to 0 on stop bit
                // so it's possible here to break the continuous rx data steam into two parts
                if(usart->info->cb_event != NULL)
                {
                    usart->info->cb_event(ARM_USART_EVENT_RX_TIMEOUT);
                }
            }

        }
    }
    else if(usart->usart_irq)
    {
        usart->reg->IER |= USART_IER_RX_TIMEOUT_Msk   | \
                           USART_IER_RX_DATA_REQ_Msk ;

        if(usart->info->xfer.rx_cnt != 0)
        {
            if(usart->reg->LSR & USART_LSR_RX_BUSY_Msk)
            {
                // do nothing if there's still data coming since we can let isr report later
            }
            else
            {
                // report to upper layer that we've received some data
                usart->info->rx_status.rx_busy = 0;

                // rx_busy is not reliable flag since it'll change to 0 on stop bit
                // so it's possible here to break the continuous rx data steam into two parts
                if(usart->info->cb_event != NULL)
                {
                    usart->info->cb_event(ARM_USART_EVENT_RX_TIMEOUT);
                }
            }

        }
    }
    else
    {
        while(usart->info->xfer.rx_cnt < usart->info->xfer.rx_num)
        {
            //wait unitl receive data is ready
            while((usart->reg->LSR & USART_LSR_RX_DATA_READY_Msk) == 0);
            //read data
            usart->info->xfer.rx_buf[usart->info->xfer.rx_cnt++] = usart->reg->RBR;
        }
        usart->info->rx_status.rx_busy = 0U;
    }
    return ARM_DRIVER_OK;
}

int32_t USART_Transfer(const void *data_out, void *data_in, uint32_t num,USART_RESOURCES *usart)
{
    //maybe used by command transfer
    return ARM_DRIVER_ERROR_UNSUPPORTED;
}

int32_t USART_GetTxCount(USART_RESOURCES *usart)
{
    uint32_t cnt;
    if (!(usart->info->flags & USART_FLAG_CONFIGURED))
        return 0U;
    if(usart->dma_tx)
        cnt = DMA_getChannelCount(usart->dma_tx->instance, usart->dma_tx->channel);
    else
        cnt = usart->info->xfer.tx_cnt;
    return cnt;
}

PLAT_PA_RAMCODE int32_t USART_GetRxCount(USART_RESOURCES *usart)
{
    if (!(usart->info->flags & USART_FLAG_CONFIGURED))
        return 0U;
    return usart->info->xfer.rx_cnt;
}

int32_t USART_Control(uint32_t control, uint32_t arg, USART_RESOURCES *usart)
{
    uint32_t val, mfcr, mask;
    uint8_t lcr = usart->reg->LCR;

    switch (control & ARM_USART_CONTROL_Msk)
    {
        // Control TX
        case ARM_USART_CONTROL_TX:
            return ARM_DRIVER_OK;
        // Control RX
        case ARM_USART_CONTROL_RX:
            // Not recommend to use this feature
            if ((usart->info->flags & USART_FLAG_CONFIGURED) == 0U)
            {
                return ARM_DRIVER_ERROR;
            }

            // Only support disable RX
            if(!arg)
            {
                // What we can do now is just to suppress irqs since we have no solo control bit to disable RX

                mask = SaveAndSetIRQMask();

                if(usart->dma_rx)
                {

                    usart->reg->IER &= ~(USART_IER_RX_TIMEOUT_Msk | USART_IER_RX_LINE_STATUS_Msk);
                    usart->info->rx_status.rx_dma_triggered = 0;
                    DMA_stopChannelNoWait(usart->dma_rx->instance, usart->dma_rx->channel);
                }
                else if(usart->usart_irq)
                {
                    usart->reg->IER &= ~(USART_IER_RX_TIMEOUT_Msk   | \
                                      USART_IER_RX_DATA_REQ_Msk  | \
                                      USART_IER_RX_LINE_STATUS_Msk);
                }

                usart->reg->ICR = USART_ICR_RX_DATA_REQ_Msk | \
                                  USART_ICR_RX_TIMEOUT_Msk | \
                                  USART_ICR_RX_LINE_STATUS_Msk;

                usart->info->rx_status.rx_busy = 0;

                RestoreIRQMask(mask);
                return ARM_DRIVER_OK;
            }
            else
            {
                // Not support, call receive instead
                return ARM_DRIVER_OK;
            }
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

            if(usart->reg->MFCR & USART_MFCR_AUTO_FLOW_CTS_EN_Msk)
            {
                while(((usart->reg->LSR & USART_LSR_TX_EMPTY_Msk) == 0) && ((usart->reg->MSR & USART_MSR_CTS_Msk) == USART_MSR_CTS_Msk));
            }
            else
            {
                while((usart->reg->LSR & USART_LSR_TX_EMPTY_Msk) == 0);
            }
            return ARM_DRIVER_OK;

        case ARM_USART_CONTROL_PURGE_COMM:

            mfcr = usart->reg->MFCR;
            usart->reg->MFCR = 0;

            // reconfigure FIFO Control register
            val = USART_FCR_FIFO_EN_Msk | USART_FCR_RESET_RX_FIFO_Msk | USART_FCR_RESET_TX_FIFO_Msk;

            switch(usart->rx_fifo_trig_lvl)
            {
                case RX_FIFO_TRIG_LVL_8BYTE:
                    val |= (1U << USART_FCR_RX_FIFO_AVAIL_TRIG_LEVEL_Pos);
                    break;

                case RX_FIFO_TRIG_LVL_16BYTE:
                    val |= (2U << USART_FCR_RX_FIFO_AVAIL_TRIG_LEVEL_Pos);
                    break;

                case RX_FIFO_TRIG_LVL_30BYTE:
                    val |= (3U << USART_FCR_RX_FIFO_AVAIL_TRIG_LEVEL_Pos);
                    break;
                default:
                    break;
            }

            switch(usart->tx_fifo_trig_lvl)
            {
                case TX_FIFO_TRIG_LVL_2BYTE:
                    val |= (1U << USART_FCR_TX_FIFO_EMPTY_TRIG_LEVEL_Pos);
                    break;

                case TX_FIFO_TRIG_LVL_8BYTE:
                    val |= (2U << USART_FCR_TX_FIFO_EMPTY_TRIG_LEVEL_Pos);
                    break;

                case TX_FIFO_TRIG_LVL_16BYTE:
                    val |= (3U << USART_FCR_TX_FIFO_EMPTY_TRIG_LEVEL_Pos);
                    break;
                default:
                    break;
            }

            usart->reg->FCR = val;
            usart->reg->MFCR = mfcr;

            return ARM_DRIVER_OK;

        default:
            return ARM_DRIVER_ERROR_UNSUPPORTED;
    }

    switch (control & ARM_USART_DATA_BITS_Msk)
    {
        case ARM_USART_DATA_BITS_5:
            lcr &= ~USART_LCR_CHAR_LEN_Msk;
            break;
        case ARM_USART_DATA_BITS_6:
            lcr &= ~USART_LCR_CHAR_LEN_Msk;
            lcr |= 1U;
            break;
        case ARM_USART_DATA_BITS_7:
            lcr &= ~USART_LCR_CHAR_LEN_Msk;
            lcr |= 2U;
            break;
        case ARM_USART_DATA_BITS_8:
            lcr &= ~USART_LCR_CHAR_LEN_Msk;
            lcr |= 3U;
            break;
        default:
            return ARM_USART_ERROR_DATA_BITS;
    }

    // USART Parity
    switch (control & ARM_USART_PARITY_Msk)
    {
        case ARM_USART_PARITY_NONE:
            lcr &= ~USART_LCR_PARITY_EN_Msk;
            break;
        case ARM_USART_PARITY_EVEN:
            lcr |= (USART_LCR_PARITY_EN_Msk | USART_LCR_EVEN_PARITY_Msk);
            break;
        case ARM_USART_PARITY_ODD:
            lcr |= USART_LCR_PARITY_EN_Msk;
            lcr &= ~USART_LCR_EVEN_PARITY_Msk;
            break;
        default:
            return (ARM_USART_ERROR_PARITY);
    }

    // USART Stop bits
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

    // USART Flow Control
    switch (control & ARM_USART_FLOW_CONTROL_Msk)
    {
        case ARM_USART_FLOW_CONTROL_NONE:
            usart->reg->MFCR &= ~(USART_MFCR_AUTO_FLOW_RTS_EN_Msk | USART_MFCR_AUTO_FLOW_CTS_EN_Msk);
            break;
        case ARM_USART_FLOW_CONTROL_RTS:
            usart->reg->MCR |= USART_MCR_RTS_Msk; //activate rts, put rts pin to low level
            usart->reg->MFCR &= ~(USART_MFCR_AUTO_FLOW_RTS_EN_Msk | USART_MFCR_AUTO_FLOW_CTS_EN_Msk);
            break;
        case ARM_USART_FLOW_CONTROL_CTS:
            usart->reg->MFCR |= (USART_MFCR_AUTO_FLOW_CTS_EN_Msk);
            break;
        case ARM_USART_FLOW_CONTROL_RTS_CTS:
            usart->reg->MCR |= USART_MCR_RTS_Msk; //activate rts, put rts pin to low level
            usart->reg->MFCR |= (USART_MFCR_AUTO_FLOW_CTS_EN_Msk);
            break;
    }
    // USART Baudrate
    if(ARM_DRIVER_OK != USART_SetBaudrate (arg, usart))
        return ARM_USART_ERROR_BAUDRATE;

    // Configuration is OK - frame code is valid
    usart->info->frame_code = control;

    usart->reg->LCR = lcr;
    // usart enable
    usart->reg->MFCR |= USART_MFCR_UART_EN_Msk;

    usart->info->flags |= USART_FLAG_CONFIGURED;
    return ARM_DRIVER_OK;
}

ARM_USART_STATUS USART_GetStatus(USART_RESOURCES *usart)
{
    ARM_USART_STATUS status;

    status.tx_busy          = usart->info->xfer.send_active;
    status.rx_busy          = usart->info->rx_status.rx_busy;
    status.tx_underflow     = 0U;
    status.rx_overflow      = usart->info->rx_status.rx_overflow;
    status.rx_break         = usart->info->rx_status.rx_break;
    status.rx_framing_error = usart->info->rx_status.rx_framing_error;
    status.rx_parity_error  = usart->info->rx_status.rx_parity_error;
    status.is_send_block    = (usart->dma_tx == NULL);
    return status;
}


/*
if not enable FC via AT+IFC, RTS default is high level
if peer enbale CTS, it could send data
if enable FC via AT+IFC, set RTS to low level when init, allow peer to send

*/
int32_t USART_SetModemControl(ARM_USART_MODEM_CONTROL control,USART_RESOURCES *usart)
{
    if((usart->info->flags & USART_FLAG_CONFIGURED) == 0U)
    {
        // USART is not configured
       return ARM_DRIVER_ERROR;
    }

    if(usart->info->frame_code & ARM_USART_FLOW_CONTROL_RTS)
    {
        if(control == ARM_USART_RTS_CLEAR) //Deactivate RTS, put rts pin to high level
        {
            usart->reg->MCR &= ~USART_MCR_RTS_Msk;
        }

        if(control == ARM_USART_RTS_SET) //Activate RTS, put rts pin to low level
        {
            usart->reg->MCR |= USART_MCR_RTS_Msk;
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

ARM_USART_MODEM_STATUS USART_GetModemStatus(USART_RESOURCES *usart)
{
    ARM_USART_MODEM_STATUS status = {0};

    if(usart->info->flags & USART_FLAG_CONFIGURED)
    {
        status.cts = EIGEN_FLD2VAL(USART_MSR_CTS, usart->reg->MSR);
    }

    return status;
}

PLAT_PA_RAMCODE void USART_IRQHandler (USART_RESOURCES *usart)
{
#ifdef PM_FEATURE_ENABLE
    uint32_t instance;
#endif

    uint32_t i;
    uint32_t event = 0;
    uint32_t lsr_reg, isr_reg;
    uint32_t current_cnt, total_cnt, left_to_recv, bytes_in_fifo;

    USART_INFO *info = usart->info;

#ifdef PM_FEATURE_ENABLE
    instance = USART_GetInstanceNumber(usart);
#endif
    // Check interrupt source
    isr_reg = usart->reg->ISR;
    usart->reg->ICR = isr_reg;
    usart->reg->ICR = 0;

#ifdef PM_FEATURE_ENABLE
#if USART_DEBUG
    ECPLAT_PRINTF(UNILOG_PLA_DRIVER, USART_IRQHandler_0, P_DEBUG, "isr:0x%x, fcnr_reg:0x%x, rx_cnt:%d",isr_reg, usart->reg->FCNR, info->xfer.rx_cnt);
#endif

#endif

    if((isr_reg & USART_ISR_RX_LINE_STATUS_Msk) == USART_ISR_RX_LINE_STATUS_Msk)
    {
        lsr_reg = usart->reg->LSR;

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
        CHECK_TO_UNLOCK_SLEEP(instance, 0, 1);
#endif

    }
    else if((isr_reg & USART_ISR_RX_TIMEOUT_Msk) == USART_ISR_RX_TIMEOUT_Msk)
    {
#ifdef PM_FEATURE_ENABLE

        if(usart->reg->ADCR & USART_ADCR_AUTO_BAUD_INT_EN_Msk)
        {
            uint32_t adrr_reg = usart->reg->ADRR;
            usart->reg->MFCR &= ~USART_MFCR_UART_EN_Msk;
            usart->reg->LCR |= USART_LCR_ACCESS_DIVISOR_LATCH_Msk;
            usart->reg->MFCR = ((usart->reg->MFCR & ~USART_MFCR_PRESCALE_FACTOR_Msk) | EIGEN_VAL2FLD(USART_MFCR_PRESCALE_FACTOR, 0));
            usart->reg->DLL = ((adrr_reg & USART_ADRR_AUTO_BAUD_INTE_Msk) >> 4) & 0xff;
            usart->reg->DLH = ((adrr_reg & USART_ADRR_AUTO_BAUD_INTE_Msk) >> 12) & 0xff;
            usart->reg->EFCR = ((usart->reg->EFCR & ~USART_EFCR_FRAC_DIVISOR_Msk) | ((adrr_reg >> USART_ADRR_AUTO_BAUD_FRAC_Pos) << USART_EFCR_FRAC_DIVISOR_Pos));
            usart->reg->LCR &= (~USART_LCR_ACCESS_DIVISOR_LATCH_Msk);
            usart->reg->ADCR = 0;
            usart->reg->MFCR |= USART_MFCR_UART_EN_Msk;

            usart->reg->FCR = g_usartDataBase[instance].backup_registers.FCR;

            g_usartDataBase[instance].autoBaudRateDone = true;
            // backup setting
            g_usartDataBase[instance].backup_registers.DLL = ((adrr_reg & USART_ADRR_AUTO_BAUD_INTE_Msk) >> 4) & 0xff;
            g_usartDataBase[instance].backup_registers.DLH = ((adrr_reg & USART_ADRR_AUTO_BAUD_INTE_Msk) >> 12) & 0xff;

            event = ARM_USART_EVENT_AUTO_BAUDRATE_DONE;

            if(adrr_reg != 0)
            {
                usart->info->baudrate = GPR_getClockFreq(g_uartClocks[instance*2+1]) / (adrr_reg &  USART_ADRR_AUTO_BAUD_INTE_Msk);
            }
            else
            {
                usart->info->baudrate = 0;
            }
        }
        else
#endif
        {
            // refer to receive API for this check
            if(usart->reg->FCNR >> USART_FCNR_RX_FIFO_NUM_Pos)
            {
#ifdef PM_FEATURE_ENABLE
                LOCK_SLEEP(instance, 0, 1);
#endif
                info->rx_status.rx_busy = 1U;

                current_cnt = info->xfer.rx_cnt;

                if(usart->dma_rx)
                {
                    if(usart->info->rx_status.rx_dma_triggered)
                    {
                        // Sync with undergoing DMA transfer, wait until DMA burst transfer(8 bytes) done and update current_cnt
                        do
                        {
                            current_cnt = DMA_getChannelCurrentTargetAddress(usart->dma_rx->instance, usart->dma_rx->channel, true) - (uint32_t)info->xfer.rx_buf;
#if USART_DEBUG
                            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, USART_IRQHandler_1, P_INFO, "dma transfer done, cnt:%d", current_cnt);
#endif
                        } while(((current_cnt - info->xfer.rx_cnt) & (UART_DMA_BURST_SIZE - 1)) != 0);

                        usart->info->rx_status.rx_dma_triggered = 0;

                    }
                    /*
                       No matter DMA transfer is started or not(left recv buffer space is not enough),
                       now we can stop DMA saftely for next transfer and handle tailing bytes in FIFO
                    */
                    DMA_stopChannelNoWait(usart->dma_rx->instance, usart->dma_rx->channel);
                }

                total_cnt = info->xfer.rx_num;

                bytes_in_fifo = usart->reg->FCNR >> USART_FCNR_RX_FIFO_NUM_Pos;

                left_to_recv = total_cnt - current_cnt;

                i = MIN(bytes_in_fifo, left_to_recv);

                // if still have space to recv
                if(left_to_recv > 0)
                {
                    while(i--)
                    {
                        info->xfer.rx_buf[current_cnt++] = usart->reg->RBR;
                    }
                }

                info->xfer.rx_cnt = current_cnt;

                // Check if required amount of data is received
                if (current_cnt == total_cnt)
                {
                    // Clear RX busy flag and set receive transfer complete event
                    event |= ARM_USART_EVENT_RECEIVE_COMPLETE;

                    //Disable RDA interrupt
                    usart->reg->IER &= ~(USART_IER_RX_DATA_REQ_Msk | USART_IER_RX_TIMEOUT_Msk | USART_IER_RX_LINE_STATUS_Msk);
                }
                else
                {
                    event |= ARM_USART_EVENT_RX_TIMEOUT;

                    if(usart->dma_rx)
                    {
                        // Prepare for next recv
                        left_to_recv = total_cnt - info->xfer.rx_cnt;

                        USART_DmaUpdateRxConfig(usart, (uint32_t)info->xfer.rx_buf + info->xfer.rx_cnt, left_to_recv);

                        // load descriptor and start DMA transfer
                        DMA_loadChannelDescriptorAndRun(usart->dma_rx->instance, usart->dma_rx->channel, &usart->dma_rx->descriptor[0]);

                    }

                }

                info->rx_status.rx_busy = 0U;

            }


        }

    }
    else if((isr_reg & USART_ISR_RX_DATA_REQ_Msk) == USART_ISR_RX_DATA_REQ_Msk)
    {
#ifdef PM_FEATURE_ENABLE
        LOCK_SLEEP(instance, 0, 1);
#endif
        info->rx_status.rx_busy = 1U;

        current_cnt = info->xfer.rx_cnt;
        total_cnt = info->xfer.rx_num;

        left_to_recv = total_cnt - current_cnt;

        bytes_in_fifo = usart->reg->FCNR >> USART_FCNR_RX_FIFO_NUM_Pos;

        // leave at least one byte in fifo to trigger timeout interrupt
        i = bytes_in_fifo - 1;

        if(i == 0)
            i = 1;

        i = MIN(i, left_to_recv);

        while(i--)
        {
            info->xfer.rx_buf[current_cnt++] = usart->reg->RBR;
        }

        info->xfer.rx_cnt = current_cnt;

        if(current_cnt == total_cnt)
        {
            // Clear RX busy flag and set receive transfer complete event
            event |= ARM_USART_EVENT_RECEIVE_COMPLETE;

            //Disable RDA interrupt
            usart->reg->IER &= ~(USART_IER_RX_DATA_REQ_Msk | USART_IER_RX_TIMEOUT_Msk | USART_IER_RX_LINE_STATUS_Msk);

            info->rx_status.rx_busy = 0U;
        }
    }

    if(((isr_reg & USART_ISR_TX_DATA_REQ_Msk) == USART_ISR_TX_DATA_REQ_Msk) || \
       ((usart->reg->IER & USART_IER_TX_DATA_REQ_Msk) && ((usart->reg->FCNR & USART_FCNR_TX_FIFO_NUM_Msk) == 0)))
    {
        info->xfer.tx_cnt = info->xfer.tx_num;
        info->xfer.send_active = 0U;
        event |= ARM_USART_EVENT_SEND_COMPLETE;
        usart->reg->IER &= ~USART_IER_TX_DATA_REQ_Msk;

#ifdef PM_FEATURE_ENABLE
        CHECK_TO_UNLOCK_SLEEP(instance, 1, 0);
#endif
    }


    if ((info->cb_event != NULL) && (event != 0U))
    {
        info->cb_event (event);

#ifdef PM_FEATURE_ENABLE
        CHECK_TO_UNLOCK_SLEEP(instance, 0, 1);
#endif

    }
}

/**
  \fn          void USART_DmaTxEvent(uint32_t event, USART_RESOURCES *usart)
  \brief       USART DMA Tx Event handler.
  \param[in]   event DMA Tx Event
  \param[in]   usart   Pointer to USART resources
*/
void USART_DmaTxEvent(uint32_t event, USART_RESOURCES *usart)
{
    switch (event)
    {
        case DMA_EVENT_END:
            // TXFIFO may still have data not sent out
            usart->reg->IER |= USART_IER_TX_DATA_REQ_Msk;
            usart->reg->THR = usart->info->xfer.tx_buf[usart->info->xfer.tx_num-1];

            break;
        case DMA_EVENT_ERROR:
        default:
            break;
    }
}

void USART_DmaRxEvent(uint32_t event, USART_RESOURCES *usart)
{
#ifdef PM_FEATURE_ENABLE
    uint32_t instance = USART_GetInstanceNumber(usart);
#endif

    uint32_t dmaCurrentTargetAddress = DMA_getChannelCurrentTargetAddress(usart->dma_rx->instance, usart->dma_rx->channel, false);

    switch (event)
    {
        case DMA_EVENT_END:

#if USART_DEBUG
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, USART_DmaRxEvent_0, P_INFO, "uart dma rx event, fcnr:%x, cnt:%d", usart->reg->FCNR, dmaCurrentTargetAddress - (uint32_t)usart->info->xfer.rx_buf);
#endif

#ifdef PM_FEATURE_ENABLE
            LOCK_SLEEP(instance, 0, 1);
#endif
            usart->info->rx_status.rx_busy = 1U;
            usart->info->rx_status.rx_dma_triggered = 1;

            if(dmaCurrentTargetAddress == ( (uint32_t)usart->info->xfer.rx_buf + usart->info->xfer.rx_num))
            {
#if USART_DEBUG
                ECPLAT_PRINTF(UNILOG_PLA_DRIVER, USART_DmaRxEvent_1, P_INFO,"uart dma rx complete");
#endif
                usart->info->xfer.rx_cnt = usart->info->xfer.rx_num;

                //Disable all recv interrupt
                usart->reg->IER &= ~(USART_IER_RX_DATA_REQ_Msk | USART_IER_RX_TIMEOUT_Msk | USART_IER_RX_LINE_STATUS_Msk);
                usart->info->rx_status.rx_busy = 0;
                usart->info->rx_status.rx_dma_triggered = 0;

                if(usart->info->cb_event)
                {
                    usart->info->cb_event(ARM_USART_EVENT_RECEIVE_COMPLETE);
                }

#ifdef PM_FEATURE_ENABLE
                CHECK_TO_UNLOCK_SLEEP(instance, 0, 1);
#endif
            }

            break;
        case DMA_EVENT_ERROR:
        default:
            break;
    }
}


#if (RTE_UART0)
// End USART Interface
static ARM_USART_CAPABILITIES     USART0_GetCapabilities (void)                                                { return USART_GetCapabilities (&USART0_Resources); }
static int32_t                    USART0_Initialize      (ARM_USART_SignalEvent_t cb_event)                    { return USART_Initialize (cb_event, &USART0_Resources); }
static int32_t                    USART0_Uninitialize    (void)                                                { return USART_Uninitialize (&USART0_Resources); }
static int32_t                    USART0_PowerControl    (ARM_POWER_STATE state)                               { return USART_PowerControl (state, &USART0_Resources); }
static int32_t                    USART0_Send            (const void *data, uint32_t num)                      { return USART_Send (data, num, &USART0_Resources); }
static int32_t                    USART0_Receive         (void *data, uint32_t num)                            { return USART_Receive (data, num, &USART0_Resources); }
static int32_t                    USART0_Transfer        (const void *data_out, void *data_in, uint32_t num)   { return USART_Transfer (data_out, data_in, num, &USART0_Resources); }
static int32_t                    USART0_SendPolling     (const void *data, uint32_t num)                      { return USART_SendPolling (data, num, &USART0_Resources); }
static uint32_t                   USART0_GetTxCount      (void)                                                { return USART_GetTxCount (&USART0_Resources); }
PLAT_PA_RAMCODE static uint32_t  USART0_GetRxCount      (void)                                                { return USART_GetRxCount (&USART0_Resources); }
static uint32_t                   USART0_GetBaudRate      (void)                                               { return USART_GetBaudRate (&USART0_Resources); }
static int32_t                    USART0_Control         (uint32_t control, uint32_t arg)                      { return USART_Control (control, arg, &USART0_Resources); }
static ARM_USART_STATUS           USART0_GetStatus       (void)                                                { return USART_GetStatus (&USART0_Resources); }
static int32_t                    USART0_SetModemControl (ARM_USART_MODEM_CONTROL control)                     { return USART_SetModemControl (control, &USART0_Resources); }
static ARM_USART_MODEM_STATUS     USART0_GetModemStatus  (void)                                                { return USART_GetModemStatus (&USART0_Resources); }
PLAT_PA_RAMCODE       void       USART0_IRQHandler      (void)                                                {        USART_IRQHandler (&USART0_Resources); }

#if (RTE_UART0_TX_IO_MODE == DMA_MODE)
       void USART0_DmaTxEvent(uint32_t event) { USART_DmaTxEvent(event, &USART0_Resources);}
#endif

#if (RTE_UART0_RX_IO_MODE == DMA_MODE)
      void USART0_DmaRxEvent(uint32_t event) { USART_DmaRxEvent(event, &USART0_Resources);}
#endif

ARM_DRIVER_USART Driver_USART0 = {
    ARM_USART_GetVersion,
    USART0_GetCapabilities,
    USART0_Initialize,
    USART0_Uninitialize,
    USART0_PowerControl,
    USART0_Send,
    USART0_Receive,
    USART0_Transfer,
    USART0_GetTxCount,
    USART0_GetRxCount,
    USART0_Control,
    USART0_GetStatus,
    USART0_SetModemControl,
    USART0_GetModemStatus,
    USART0_GetBaudRate,
    USART0_SendPolling
};

#endif

#if (RTE_UART1)
static ARM_USART_CAPABILITIES     USART1_GetCapabilities (void)                                                { return USART_GetCapabilities (&USART1_Resources); }
static int32_t                    USART1_Initialize      (ARM_USART_SignalEvent_t cb_event)                    { return USART_Initialize (cb_event, &USART1_Resources); }
static int32_t                    USART1_Uninitialize    (void)                                                { return USART_Uninitialize (&USART1_Resources); }
static int32_t                    USART1_PowerControl    (ARM_POWER_STATE state)                               { return USART_PowerControl (state, &USART1_Resources); }
static int32_t                    USART1_Send            (const void *data, uint32_t num)                      { return USART_Send (data, num, &USART1_Resources); }
static int32_t                    USART1_Receive         (void *data, uint32_t num)                            { return USART_Receive (data, num, &USART1_Resources); }
static int32_t                    USART1_Transfer        (const void *data_out, void *data_in, uint32_t num)   { return USART_Transfer (data_out, data_in, num, &USART1_Resources); }
static int32_t                    USART1_SendPolling     (const void *data, uint32_t num)                      { return USART_SendPolling (data, num, &USART1_Resources); }
static uint32_t                   USART1_GetTxCount      (void)                                                { return USART_GetTxCount (&USART1_Resources); }
PLAT_PA_RAMCODE static uint32_t  USART1_GetRxCount      (void)                                                { return USART_GetRxCount (&USART1_Resources); }
static uint32_t                   USART1_GetBaudRate      (void)                                               { return USART_GetBaudRate (&USART1_Resources); }
static int32_t                    USART1_Control         (uint32_t control, uint32_t arg)                      { return USART_Control (control, arg, &USART1_Resources); }
static ARM_USART_STATUS           USART1_GetStatus       (void)                                                { return USART_GetStatus (&USART1_Resources); }
static int32_t                    USART1_SetModemControl (ARM_USART_MODEM_CONTROL control)                     { return USART_SetModemControl (control, &USART1_Resources); }
static ARM_USART_MODEM_STATUS     USART1_GetModemStatus  (void)                                                { return USART_GetModemStatus (&USART1_Resources); }
PLAT_PA_RAMCODE       void       USART1_IRQHandler      (void)                                                {        USART_IRQHandler (&USART1_Resources); }

#if (RTE_UART1_TX_IO_MODE == DMA_MODE)
      void USART1_DmaTxEvent(uint32_t event) { USART_DmaTxEvent(event, &USART1_Resources);}
#endif

#if (RTE_UART1_RX_IO_MODE == DMA_MODE)
      void USART1_DmaRxEvent(uint32_t event) { USART_DmaRxEvent(event, &USART1_Resources);}
#endif


ARM_DRIVER_USART Driver_USART1 = {
    ARM_USART_GetVersion,
    USART1_GetCapabilities,
    USART1_Initialize,
    USART1_Uninitialize,
    USART1_PowerControl,
    USART1_Send,
    USART1_Receive,
    USART1_Transfer,
    USART1_GetTxCount,
    USART1_GetRxCount,
    USART1_Control,
    USART1_GetStatus,
    USART1_SetModemControl,
    USART1_GetModemStatus,
    USART1_GetBaudRate,
    USART1_SendPolling
};

#endif

#if (RTE_UART2)
static ARM_USART_CAPABILITIES     USART2_GetCapabilities (void)                                                { return USART_GetCapabilities (&USART2_Resources); }
static int32_t                    USART2_Initialize      (ARM_USART_SignalEvent_t cb_event)                    { return USART_Initialize (cb_event, &USART2_Resources); }
static int32_t                    USART2_Uninitialize    (void)                                                { return USART_Uninitialize (&USART2_Resources); }
static int32_t                    USART2_PowerControl    (ARM_POWER_STATE state)                               { return USART_PowerControl (state, &USART2_Resources); }
static int32_t                    USART2_Send            (const void *data, uint32_t num)                      { return USART_Send (data, num, &USART2_Resources); }
static int32_t                    USART2_Receive         (void *data, uint32_t num)                            { return USART_Receive (data, num, &USART2_Resources); }
static int32_t                    USART2_Transfer        (const void *data_out, void *data_in, uint32_t num)   { return USART_Transfer (data_out, data_in, num, &USART2_Resources); }
static int32_t                    USART2_SendPolling     (const void *data, uint32_t num)                      { return USART_SendPolling (data, num, &USART2_Resources); }
static uint32_t                   USART2_GetTxCount      (void)                                                { return USART_GetTxCount (&USART2_Resources); }
PLAT_PA_RAMCODE static uint32_t  USART2_GetRxCount      (void)                                                { return USART_GetRxCount (&USART2_Resources); }
static uint32_t                   USART2_GetBaudRate      (void)                                               { return USART_GetBaudRate (&USART2_Resources); }
static int32_t                    USART2_Control         (uint32_t control, uint32_t arg)                      { return USART_Control (control, arg, &USART2_Resources); }
static ARM_USART_STATUS           USART2_GetStatus       (void)                                                { return USART_GetStatus (&USART2_Resources); }
static int32_t                    USART2_SetModemControl (ARM_USART_MODEM_CONTROL control)                     { return USART_SetModemControl (control, &USART2_Resources); }
static ARM_USART_MODEM_STATUS     USART2_GetModemStatus  (void)                                                { return USART_GetModemStatus (&USART2_Resources); }
PLAT_PA_RAMCODE       void       USART2_IRQHandler      (void)                                                {        USART_IRQHandler (&USART2_Resources); }

#if (RTE_UART2_TX_IO_MODE == DMA_MODE)
      void USART2_DmaTxEvent(uint32_t event) { USART_DmaTxEvent(event, &USART2_Resources);}
#endif

#if (RTE_UART2_RX_IO_MODE == DMA_MODE)
      void USART2_DmaRxEvent(uint32_t event) { USART_DmaRxEvent(event, &USART2_Resources);}
#endif


ARM_DRIVER_USART Driver_USART2 = {
    ARM_USART_GetVersion,
    USART2_GetCapabilities,
    USART2_Initialize,
    USART2_Uninitialize,
    USART2_PowerControl,
    USART2_Send,
    USART2_Receive,
    USART2_Transfer,
    USART2_GetTxCount,
    USART2_GetRxCount,
    USART2_Control,
    USART2_GetStatus,
    USART2_SetModemControl,
    USART2_GetModemStatus,
    USART2_GetBaudRate,
    USART2_SendPolling
};

#endif


