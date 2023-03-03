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
 * $Date:        13. July 2018
 * $Revision:    V2.0
 *
 * Driver:       Driver_I2C0, Driver_I2C1
 * Configured:   via RTE_Device.h configuration file
 * Project:      I2C Driver for AirM2M EC618
 * --------------------------------------------------------------------------
 * Use the following configuration settings in the middleware component
 * to connect to this driver.
 *
 *   Configuration Setting                 Value   I2C Interface
 *   ---------------------                 -----   -------------
 *   Connect to hardware via Driver_I2C# = 0       use I2C0
 *   Connect to hardware via Driver_I2C# = 1       use I2C1
 * -------------------------------------------------------------------------- */
/* History:
 *  Version 2.0
 *    - Initial CMSIS Driver API V2.0 release
 */

#include "bsp_i2c.h"
#include "slpman.h"

#define I2C_DEBUG  0
#if I2C_DEBUG
#define I2CDEBUG(...)     printf(__VA_ARGS__)
#else
#define I2CDEBUG(...)
#endif

#define ARM_I2C_DRV_VERSION    ARM_DRIVER_VERSION_MAJOR_MINOR(2, 0) /* driver version */

#if ((!RTE_I2C0) && (!RTE_I2C1))
#error "I2C not enabled in RTE_Device.h!"
#endif

#ifdef PM_FEATURE_ENABLE

/** \brief Internal used data structure */
typedef struct _i2c_database
{
    bool                            isInited;            /**< Whether i2c has been initialized */
    struct
    {
        uint32_t MCR;                                    /**< Main Control Register */
        uint32_t SAR;                                    /**< Slave Address Register */
        uint32_t TPR;                                    /**< Timing Parameter Register */
        uint32_t TOR;                                    /**< Timeout Register */
        uint32_t IER;                                    /**< Interrupt Enable Register */
        uint32_t IMR;                                    /**< Interrupt Mask Register */
    } backup_registers;                                  /**< Backup registers for low power restore */
} i2c_database_t;

static i2c_database_t g_i2cDataBase[I2C_INSTANCE_NUM] = {0};

static I2C_TypeDef* const g_i2cBases[I2C_INSTANCE_NUM] = {I2C0, I2C1};
#endif

static ClockId_e g_i2cClocks[I2C_INSTANCE_NUM*2] = {PCLK_I2C0, FCLK_I2C0, PCLK_I2C1, FCLK_I2C1};

#ifdef PM_FEATURE_ENABLE
/**
  \brief i2c initialization counter, for lower power callback register/de-register
 */
static uint32_t g_i2cInitCounter = 0;

/**
  \brief Bitmap of I2C working status,
         when all I2C instances are not working, we can vote to enter to low power state.
 */

static uint32_t g_i2cWorkingStatus = 0;

/**
  \fn        static void I2C_EnterLowPowerStatePrepare(void* pdata, slpManLpState state)
  \brief     Perform necessary preparations before sleep.
             After recovering from SLPMAN_SLEEP1_STATE, I2C hareware is repowered, we backup
             some registers here first so that we can restore user's configurations after exit.
  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state
 */
static void I2C_EnterLowPowerStatePrepare(void* pdata, slpManLpState state)
{
    uint32_t i;

    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            for(i = 0; i < I2C_INSTANCE_NUM; i++)
            {
                if(g_i2cDataBase[i].isInited == true)
                {
                    g_i2cDataBase[i].backup_registers.MCR = g_i2cBases[i]->MCR;
                    g_i2cDataBase[i].backup_registers.SAR = g_i2cBases[i]->SAR;
                    g_i2cDataBase[i].backup_registers.TPR = g_i2cBases[i]->TPR;
                    g_i2cDataBase[i].backup_registers.TOR = g_i2cBases[i]->TOR;
                    g_i2cDataBase[i].backup_registers.IER = g_i2cBases[i]->IER;
                    g_i2cDataBase[i].backup_registers.IMR = g_i2cBases[i]->IMR;
                }
            }
            break;
        default:
            break;
    }

}

/**
  \fn        static void I2C_ExitLowPowerStateRestore(void* pdata, slpManLpState state)
  \brief     Restore after exit from sleep.
             After recovering from SLPMAN_SLEEP1_STATE, I2C hareware is repowered, we restore user's configurations
             by aidding of the stored registers.

  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state
 */
static void I2C_ExitLowPowerStateRestore(void* pdata, slpManLpState state)
{
    uint32_t i;

    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            for(i = 0; i < I2C_INSTANCE_NUM; i++)
            {
                if(g_i2cDataBase[i].isInited == true)
                {
                    GPR_clockEnable(g_i2cClocks[2*i]);
                    GPR_clockEnable(g_i2cClocks[2*i+1]);

                    g_i2cBases[i]->SAR = g_i2cDataBase[i].backup_registers.SAR;
                    g_i2cBases[i]->TPR = g_i2cDataBase[i].backup_registers.TPR;
                    g_i2cBases[i]->TOR = g_i2cDataBase[i].backup_registers.TOR;
                    g_i2cBases[i]->IER = g_i2cDataBase[i].backup_registers.IER;
                    g_i2cBases[i]->IMR = g_i2cDataBase[i].backup_registers.IMR;
                    g_i2cBases[i]->MCR = g_i2cDataBase[i].backup_registers.MCR;

                }
            }
            break;

        default:
            break;
    }

}

#define  LOCK_SLEEP(instance)       do                                                                  \
                                    {                                                                   \
                                        g_i2cWorkingStatus |= (1U << instance);                         \
                                        slpManDrvVoteSleep(SLP_VOTE_I2C, SLP_ACTIVE_STATE);       \
                                    }                                                                   \
                                    while(0)

#define  CHECK_TO_UNLOCK_SLEEP(instance)    do                                                                  \
                                            {                                                                   \
                                                g_i2cWorkingStatus &= ~(1U << instance);                        \
                                                if(g_i2cWorkingStatus == 0)                                     \
                                                    slpManDrvVoteSleep(SLP_VOTE_I2C, SLP_SLP1_STATE);      \
                                            }                                                                   \
                                            while(0)
#endif

/* Driver Version */
static const ARM_DRIVER_VERSION DriverVersion =
{
    ARM_I2C_API_VERSION,
    ARM_I2C_DRV_VERSION
};

/* Driver Capabilities */
static const ARM_I2C_CAPABILITIES DriverCapabilities =
{
    1 /* supports 10-bit addressing */
};


#if (RTE_I2C0)

static I2C_CTRL I2C0_Ctrl = { 0 };
static PIN I2C0_pin_scl  = {RTE_I2C0_SCL_BIT,   RTE_I2C0_SCL_FUNC};
static PIN I2C0_pin_sda  = {RTE_I2C0_SDA_BIT,   RTE_I2C0_SDA_FUNC};

#if (RTE_I2C0_IO_MODE == DMA_MODE)
void I2C0_DmaTxEvent(uint32_t event);
void I2C0_DmaRxEvent(uint32_t event);

static I2C_DMA I2C0_DMA = {
                            RTE_I2C0_DMA_TX_CH,
                            RTE_I2C0_DMA_TX_REQID,
                            I2C0_DmaTxEvent,
                            RTE_I2C0_DMA_RX_CH,
                            RTE_I2C0_DMA_RX_REQID,
                            I2C0_DmaRxEvent
                          };
#endif

#if (RTE_I2C0_IO_MODE == IRQ_MODE)
void I2C0_IRQHandler(void);

static I2C_IRQ I2C0_IRQ = {
                            PXIC_I2c0_IRQn,
                            I2C0_IRQHandler
                          };

#endif

static I2C_RESOURCES I2C0_Resources =
{
    I2C0,
    {
      &I2C0_pin_scl,
      &I2C0_pin_sda,
    },
#if (RTE_I2C0_IO_MODE == DMA_MODE)
    &I2C0_DMA,
#else
    NULL,
#endif

#if (RTE_I2C0_IO_MODE == IRQ_MODE)
    &I2C0_IRQ,
#else
    NULL,
#endif

    &I2C0_Ctrl
};
#endif

#if (RTE_I2C1)

static I2C_CTRL I2C1_Ctrl = { 0 };
static PIN I2C1_pin_scl  = {RTE_I2C1_SCL_BIT,   RTE_I2C1_SCL_FUNC};
static PIN I2C1_pin_sda  = {RTE_I2C1_SDA_BIT,   RTE_I2C1_SDA_FUNC};

#if (RTE_I2C1_IO_MODE == DMA_MODE)
void I2C1_DmaTxEvent(uint32_t event);
void I2C1_DmaRxEvent(uint32_t event);

static I2C_DMA I2C1_DMA = {
                            DMA_INSTANCE_AP,
                            RTE_I2C1_DMA_TX_CH,
                            RTE_I2C1_DMA_TX_REQID,
                            I2C1_DmaTxEvent,
                            DMA_INSTANCE_AP,
                            RTE_I2C1_DMA_RX_CH,
                            RTE_I2C1_DMA_RX_REQID,
                            I2C1_DmaRxEvent
                          };

#endif

#if (RTE_I2C1_IO_MODE == IRQ_MODE)

void I2C1_IRQHandler(void);

static I2C_IRQ I2C1_IRQ = {
                            PXIC_I2c1_IRQn,
                            I2C1_IRQHandler
                          };

#endif

static I2C_RESOURCES I2C1_Resources =
{
    I2C1,
    {
      &I2C1_pin_scl,
      &I2C1_pin_sda,
    },
#if (RTE_I2C1_IO_MODE == DMA_MODE)
    &I2C1_DMA,
#else
    NULL,
#endif

#if (RTE_I2C1_IO_MODE == IRQ_MODE)
    &I2C1_IRQ,
#else
    NULL,
#endif
    &I2C1_Ctrl
};
#endif

// Local Function
/**
  \fn          ARM_DRIVER_VERSION I2C_GetVersion(void)
  \brief       Get driver version.
  \return      \ref ARM_DRIVER_VERSION
*/
ARM_DRIVER_VERSION ARM_I2C_GetVersion(void)
{
    return DriverVersion;
}


/**
  \fn          ARM_I2C_CAPABILITIES I2C_GetCapabilities(void)
  \brief       Get driver capabilities.
  \return      \ref ARM_I2C_CAPABILITIES
*/
ARM_I2C_CAPABILITIES I2C_GetCapabilities()
{
    return DriverCapabilities;
}

/**
  \fn          static uint32_t I2C_GetInstanceNumber(I2C_RESOURCES *i2c)
  \brief       Get instance number
  \param[in]   i2c       Pointer to I2C resources
  \returns     instance number
*/
static uint32_t I2C_GetInstanceNumber(I2C_RESOURCES *i2c)
{
    return ((uint32_t)i2c->reg - (uint32_t)I2C0) >> 12;
}

/**
  \fn          int32_t I2C_Initialize(ARM_I2C_SignalEvent_t cb_event,
                                      I2C_RESOURCES         *i2c)
  \brief       Initialize I2C Interface.
  \param[in]   cb_event  Pointer to \ref ARM_I2C_SignalEvent
  \param[in]   i2c   Pointer to I2C resources
  \return      \ref execution_status
*/
int32_t I2C_Initialize(ARM_I2C_SignalEvent_t cb_event, I2C_RESOURCES *i2c)
{
    int32_t returnCode;
#ifdef PM_FEATURE_ENABLE
    uint32_t instance;
#endif

    PadConfig_t padConfig;

    if(i2c->ctrl->flags & I2C_FLAG_INIT)
    {
        return ARM_DRIVER_OK;
    }

    I2CDEBUG("I2C_Initialize\r\n");
    // Configure I2C Pins

    PAD_getDefaultConfig(&padConfig);
    padConfig.mux = i2c->pins.pin_scl->funcNum;
    PAD_setPinConfig(i2c->pins.pin_scl->pinNum, &padConfig);
    padConfig.mux = i2c->pins.pin_sda->funcNum;
    PAD_setPinConfig(i2c->pins.pin_sda->pinNum, &padConfig);

    // Reset Run-Time information structure
    memset(i2c->ctrl, 0, sizeof(I2C_CTRL));

    i2c->ctrl->cb_event = cb_event;

    // Configure DMA if necessary
    if(i2c->dma)
    {
        returnCode = DMA_openChannel(i2c->dma->tx_instance);

        if (returnCode == ARM_DMA_ERROR_CHANNEL_ALLOC)
            return ARM_DRIVER_ERROR;
        else
            i2c->dma->tx_ch = returnCode;

        returnCode = DMA_openChannel(i2c->dma->rx_instance);

        if (returnCode == ARM_DMA_ERROR_CHANNEL_ALLOC)
            return ARM_DRIVER_ERROR;
        else
            i2c->dma->rx_ch = returnCode;


        DMA_setChannelRequestSource(i2c->dma->tx_instance, i2c->dma->tx_ch, (DmaRequestSource_e)i2c->dma->tx_req);
        DMA_rigisterChannelCallback(i2c->dma->tx_instance, i2c->dma->tx_ch, i2c->dma->tx_callback);


        DMA_setChannelRequestSource(i2c->dma->rx_instance, i2c->dma->rx_ch, (DmaRequestSource_e)i2c->dma->rx_req);
        DMA_rigisterChannelCallback(i2c->dma->rx_instance, i2c->dma->rx_ch, i2c->dma->rx_callback);
    }

    i2c->ctrl->flags |= I2C_FLAG_INIT;

#ifdef PM_FEATURE_ENABLE

    instance = I2C_GetInstanceNumber(i2c);

    g_i2cDataBase[instance].isInited = true;

    g_i2cInitCounter++;

    if(g_i2cInitCounter == 1)
    {
        g_i2cWorkingStatus = 0;
        slpManRegisterPredefinedBackupCb(SLP_CALLBACK_I2C_MODULE, I2C_EnterLowPowerStatePrepare, NULL);
        slpManRegisterPredefinedRestoreCb(SLP_CALLBACK_I2C_MODULE, I2C_ExitLowPowerStateRestore, NULL);
    }
#endif

    return ARM_DRIVER_OK;
}

/**
  \fn          int32_t I2C_Uninitialize(I2C_RESOURCES *i2c)
  \brief       De-initialize I2C Interface.
  \param[in]   i2c   Pointer to I2C resources
  \return      \ref execution_status
*/
int32_t I2C_Uninitialize(I2C_RESOURCES *i2c)
{
#ifdef PM_FEATURE_ENABLE
    uint32_t instance;
#endif

    PadConfig_t padConfig;
    i2c->ctrl->flags = 0;
    i2c->ctrl->cb_event = NULL;

    // Unconfigure SCL and SDA pins
    PAD_getDefaultConfig(&padConfig);
    padConfig.mux = PAD_MUX_ALT0;

    PAD_setPinConfig(i2c->pins.pin_scl->pinNum, &padConfig);
    PAD_setPinConfig(i2c->pins.pin_sda->pinNum, &padConfig);
    // Input+pullup
    PAD_setPinPullConfig(i2c->pins.pin_scl->pinNum, PAD_INTERNAL_PULL_UP);
    PAD_setPinPullConfig(i2c->pins.pin_sda->pinNum, PAD_INTERNAL_PULL_UP);

#ifdef PM_FEATURE_ENABLE
    instance = I2C_GetInstanceNumber(i2c);
    g_i2cDataBase[instance].isInited = false;

    g_i2cInitCounter--;
    if(g_i2cInitCounter == 0)
    {
        g_i2cWorkingStatus = 0;
        slpManUnregisterPredefinedBackupCb(SLP_CALLBACK_I2C_MODULE);
        slpManUnregisterPredefinedRestoreCb(SLP_CALLBACK_I2C_MODULE);

    }
#endif

    return ARM_DRIVER_OK;
}


/**
  \fn          int32_t I2C_PowerControl(ARM_POWER_STATE state,
                                        I2C_RESOURCES   *i2c)
  \brief       Control I2C Interface Power.
  \param[in]   state  Power state
  \param[in]   i2c    Pointer to I2C resources
  \return      \ref execution_status
*/
int32_t I2C_PowerControl(ARM_POWER_STATE state, I2C_RESOURCES *i2c)
{
    uint32_t instance = I2C_GetInstanceNumber(i2c);

    switch (state)
    {
        case ARM_POWER_OFF:
            // I2C reset controller, including disable all I2C interrupts & clear fifo
            if(i2c->irq)
                XIC_DisableIRQ(i2c->irq->irq_num);

            // DMA disable
            if(i2c->dma)
            {
                DMA_stopChannel(i2c->dma->tx_instance, i2c->dma->tx_ch, false);
                DMA_stopChannel(i2c->dma->rx_instance, i2c->dma->rx_ch, false);
            }
            // Disable I2C and other control bits
            i2c->reg->MCR = 0;

            // Disable I2C power
            CLOCK_clockDisable(g_i2cClocks[instance*2]);
            CLOCK_clockDisable(g_i2cClocks[instance*2+1]);

            memset((void*)&i2c->ctrl->status, 0, sizeof(ARM_I2C_STATUS));

            i2c->ctrl->stalled = 0;
            i2c->ctrl->snum    = 0;
            i2c->ctrl->flags  &= ~I2C_FLAG_POWER;
            break;

        case ARM_POWER_LOW:
            return ARM_DRIVER_ERROR_UNSUPPORTED;

        case ARM_POWER_FULL:
            if((i2c->ctrl->flags & I2C_FLAG_INIT) == 0U)
            {
                return ARM_DRIVER_ERROR;
            }
            if(i2c->ctrl->flags & I2C_FLAG_POWER)
            {
                return ARM_DRIVER_OK;
            }

            // Enable power to i2c clock
            CLOCK_clockEnable(g_i2cClocks[instance*2]);
            CLOCK_clockEnable(g_i2cClocks[instance*2+1]);

            // Setup SDA setup/hold time parameter
            i2c->reg->TPR = ((0x4 << I2C_TPR_SDA_SETUP_TIME_Pos) | (0x4 << I2C_TPR_SDA_HOLD_TIME_Pos)
                                | (0x0 << I2C_TPR_SPIKE_FILTER_CNUM_Pos));

            // Enable I2C irq
            if(i2c->irq)
            {
                XIC_SetVector(i2c->irq->irq_num,i2c->irq->cb_irq);
                XIC_EnableIRQ(i2c->irq->irq_num);
            }

            i2c->ctrl->flags |= I2C_FLAG_POWER;
            break;

        default:
            return ARM_DRIVER_ERROR_UNSUPPORTED;
    }
    return ARM_DRIVER_OK;
}


#if 0
/**
  \fn     static void I2C_TransferConfig(I2C_RESOURCES *i2c,
                                         uint16_t DevAddress,
                                         uint8_t Size,
                                         uint32_t Request,
                                         uint8_t Mode)
  \brief  Handles I2Cx communication when starting transfer or during transfer (TC or TCR flag are set).
  \param  i2c         I2C handle.
  \param  devAddress  Specifies the slave address to be programmed.
  \param  size        Specifies the number of bytes to be programmed.
                      This parameter must be a value between 0 and 255.
  \param  request     New state of the I2C START condition generation.
                      This parameter can be one of the following values:
                      \arg \ref I2C_NO_STARTSTOP Don't Generate stop and start condition.
                      \arg \ref I2C_GENERATE_STOP Generate stop condition (Size should be set to 0).
                      \arg \ref I2C_GENERATE_START_READ Generate Restart for read request.
                      \arg \ref I2C_GENERATE_START_WRITE Generate Restart for write request.
  \param  mode        I2C mode
  \return void
  */
static void I2C_TransferConfig(I2C_RESOURCES *i2c, uint16_t devAddress, uint8_t size, uint32_t request, uint8_t mode)
{
    uint32_t defaultreg = 0U;

    if((I2C_AUTOMATIC_MODE1 == mode) || (I2C_AUTOMATIC_MODE2 == mode))
        defaultreg |= I2C_MCR_CONTROL_MODE_Msk;
    else if(I2C_DEDICATED_MODE == mode)
        defaultreg &= ~I2C_MCR_CONTROL_MODE_Msk;

    defaultreg |= ((0x08 << I2C_MCR_TX_FIFO_THRESHOLD_Pos) | (0x08 << I2C_MCR_RX_FIFO_THRESHOLD_Pos)
                   | I2C_MCR_I2C_EN_Msk);
    // Enable DMA
    if(i2c->dma)
        defaultreg |= (I2C_MCR_TX_DMA_EN_Msk | I2C_MCR_RX_DMA_EN_Msk);
    I2CDEBUG("MCR = 0x%x\r\n", defaultreg);
    i2c->reg->MCR = defaultreg;

    defaultreg = 0U;
    // byte_num_unknown = 0
    if(I2C_AUTOMATIC_MODE1 == mode)
    {
        // ON Number of bytes (master mode)
        defaultreg |= ((size - 1) << I2C_SCR_BYTE_NUM_Pos);
    }
    else if(I2C_AUTOMATIC_MODE2 == mode)
    {
        // OFF Number of bytes (master mode)
        defaultreg |= I2C_SCR_BYTE_NUM_UNKNOWN_Msk;
    }

    defaultreg |= ((devAddress << 1) & (I2C_SCR_TARGET_SLAVE_ADDR_Msk) | (uint32_t)request);
    I2CDEBUG("SCR = 0x%x\r\n", defaultreg);
    i2c->reg->SCR = defaultreg;

}
#endif

typedef enum __I2C_STATE
{
    I2C_STATE_IDLE,            // IDLE state
    I2C_STATE_MASTER_START,    // master START transmitted
    I2C_STATE_MASTER_RSTART,   // master repeated START transmitted
    I2C_STATE_MASTER_SLAW_A,   // master SLA+W transmited and ACK received
    I2C_STATE_MASTER_SLAW_NA,  // master SLA+W transmited but no ACK received
    I2C_STATE_MASTER_DT_A,     // master data transmited and ACK received
    I2C_STATE_MASTER_DT_NA,    // master data transmited but no ACK received
    I2C_STATE_MASTER_ARB_LOST, // master arbitration lost
    I2C_STATE_MASTER_SLAR_A,   // master SLA+R transmited and ACK received
    I2C_STATE_MASTER_SLAR_NA,  // master SLA+R transmited but no ACK received
    I2C_STATE_MASTER_DR_A,     // master data received and ACK returned
    I2C_STATE_MASTER_DR_NA,    // master data received but no ACK returned
} I2C_STATE_t;

void I2C_MasterTransmitStateMachine(I2C_RESOURCES *i2c)
{

}

/**
  \fn     static int32_t I2C_MasterCheckStatus(I2C_RESOURCES *i2c)
  \brief  Check status and clear any error if present
  \param  i2c         Pointer to I2C resources
  \return ARM_DRIVER_ERROR if any exception occurs, otherwise ARM_DRIVER_OK
  */
static int32_t I2C_MasterCheckStatus(I2C_RESOURCES *i2c)
{
    int32_t ret = ARM_DRIVER_OK;

    volatile uint32_t isr_reg = i2c->reg->ISR;

    if(isr_reg & (I2C_ISR_ARBITRATATION_LOST_Msk | I2C_ISR_BUS_ERROR_Msk | I2C_ISR_RX_NACK_Msk))
        ret = ARM_DRIVER_ERROR;

    // if any exception occurs, clear it
    if(ret == ARM_DRIVER_ERROR)
    {
        if(isr_reg & I2C_ISR_ARBITRATATION_LOST_Msk)
            i2c->ctrl->status.arbitration_lost = 1;

        if(isr_reg & I2C_ISR_BUS_ERROR_Msk)
            i2c->ctrl->status.bus_error = 1;

        if(isr_reg & I2C_ISR_RX_NACK_Msk)
            i2c->ctrl->status.rx_nack = 1;

        i2c->reg->ISR = isr_reg;
        i2c->reg->SCR |= (I2C_SCR_FLUSH_TX_FIFO_Msk | I2C_SCR_FLUSH_RX_FIFO_Msk);
    }

    return ret;
}

/**
  \fn          int32_t I2Cx_MasterTransmit(uint32_t       addr,
                                           const uint8_t *data,
                                           uint32_t       num,
                                           bool           xfer_pending,
                                           I2C_RESOURCES *i2c)
  \brief       Start transmitting data as I2C Master.
  \param[in]   addr          Slave address (7-bit or 10-bit)
  \param[in]   data          Pointer to buffer with data to transmit to I2C Slave
  \param[in]   num           Number of data bytes to transmit
  \param[in]   xfer_pending  Transfer operation is pending - Stop condition will not be generated
  \param[in]   i2c           Pointer to I2C resources
  \return      \ref execution_status
*/
int32_t I2C_MasterTransmit(uint32_t addr, const uint8_t *data, uint32_t num, bool xfer_pending, I2C_RESOURCES *i2c)
{
#ifdef PM_FEATURE_ENABLE
    uint32_t instance;
#endif
    int32_t ret;
    uint32_t reg_value;

    //uint8_t send_data;

    DmaTransferConfig_t dmaTxConfig = {(void *)data, (void *)&(i2c->reg->TDR),
                                       DMA_FLOW_CONTROL_TARGET, DMA_ADDRESS_INCREMENT_SOURCE,
                                       DMA_DATA_WIDTH_ONE_BYTE,
                                       DMA_BURST_8_BYTES, num
                                      };
    if(!data || !num || (addr > 0x3ff))
    {
        return ARM_DRIVER_ERROR_PARAMETER;
    }

    if(!(i2c->ctrl->flags & I2C_FLAG_SETUP))
    {
        return ARM_DRIVER_ERROR;
    }

    if(i2c->ctrl->status.busy)
    {
        return ARM_DRIVER_ERROR_BUSY;
    }

#ifdef PM_FEATURE_ENABLE
    instance = I2C_GetInstanceNumber(i2c);
#endif

    // Set control variables
    i2c->ctrl->sla_rw = addr;
    i2c->ctrl->pending = xfer_pending;
    i2c->ctrl->data = (uint8_t *)data;
    i2c->ctrl->num  = num;
    i2c->ctrl->cnt  = 0;

    // Update driver status
    i2c->ctrl->status.busy = 1;
    // 0 :slave / 1 :master
    i2c->ctrl->status.mode = 1;
    // 0 :tx  / 1 :rx
    i2c->ctrl->status.direction = 0;
    i2c->ctrl->status.arbitration_lost = 0;
    i2c->ctrl->status.bus_error = 0;
    i2c->ctrl->status.rx_nack = 0;

    if(i2c->reg->STR & I2C_STR_BUSY_Msk)
    {
        return ARM_DRIVER_ERROR_BUSY;
    }

    i2c->ctrl->flags |= I2C_FLAG_MASTER_TX;
    // Setup transfer config
    // I2C_TransferConfig(i2c, addr & 0x7f, num, I2C_GENERATE_START_WRITE, I2C_AUTOMATIC_MODE1);

    if(i2c->dma)
    {
#ifdef PM_FEATURE_ENABLE
        LOCK_SLEEP(instance);
#endif

        I2CDEBUG("dma configure\n");
        // Configure tx DMA and start it
        DMA_transferSetup(i2c->dma->tx_instance, i2c->dma->tx_ch, &dmaTxConfig);
        DMA_enableChannelInterrupts(i2c->dma->tx_instance, i2c->dma->tx_ch, DMA_END_INTERRUPT_ENABLE);

        I2CDEBUG("i2c tx dma start\n");
        DMA_startChannel(i2c->dma->tx_instance, i2c->dma->tx_ch);
        // Enable interrupts to reflect specific status
        i2c->reg->IER = (I2C_IER_TRANSFER_DONE_Msk |
                         I2C_IER_ARBITRATATION_LOST_Msk |
                         I2C_IER_DETECT_STOP_Msk |
                         I2C_IER_BUS_ERROR_Msk |
                         I2C_IER_RX_NACK_Msk);

        // Clear all flags first(W1C)
        i2c->reg->ISR = i2c->reg->ISR;

        // Config and issue command
        i2c->reg->MCR = (EIGEN_VAL2FLD(I2C_MCR_TX_FIFO_THRESHOLD, 8) | EIGEN_VAL2FLD(I2C_MCR_RX_FIFO_THRESHOLD, 8) | I2C_MCR_TX_DMA_EN_Msk | I2C_MCR_CONTROL_MODE_Msk | I2C_MCR_I2C_EN_Msk);

        reg_value = (((addr << 1) & (I2C_SCR_TARGET_SLAVE_ADDR_Msk)) | ((num - 1) << I2C_SCR_BYTE_NUM_Pos) | I2C_SCR_START_Msk);


        i2c->reg->SCR = reg_value;
    }
    else
    {
        // Enable interrupts to reflect specific status
        i2c->reg->IER = (I2C_IER_TRANSFER_DONE_Msk |
                         I2C_IER_ARBITRATATION_LOST_Msk |
                         I2C_IER_DETECT_STOP_Msk |
                         I2C_IER_BUS_ERROR_Msk |
                         I2C_IER_RX_NACK_Msk);

        // Clear all flags first(W1C)
        i2c->reg->ISR = i2c->reg->ISR;

        // Config and issue command
        i2c->reg->MCR = (I2C_MCR_CONTROL_MODE_Msk | I2C_MCR_I2C_EN_Msk);

        reg_value = (((addr << 1) & (I2C_SCR_TARGET_SLAVE_ADDR_Msk)) | ((num - 1) << I2C_SCR_BYTE_NUM_Pos) | I2C_SCR_START_Msk);

        I2CDEBUG("SCR = 0x%x\r\n", reg_value);

        i2c->reg->SCR = reg_value;

        // Send data
        while(num > i2c->ctrl->cnt)
        {
            // Wait for Tx ready
            do
            {
                ret = I2C_MasterCheckStatus(i2c);

            } while(((i2c->reg->FSR & I2C_FSR_TX_FIFO_FREE_NUM_Msk) == 0) && (ret == ARM_DRIVER_OK));

            if(ret != ARM_DRIVER_OK)
            {
                i2c->ctrl->status.busy = 0;
                return ret;
            }
            i2c->reg->TDR = i2c->ctrl->data[i2c->ctrl->cnt++];
        }

        // Wait for ACK/NACK
        do
        {
            ret = I2C_MasterCheckStatus(i2c);

        } while((EIGEN_FLD2VAL(I2C_FSR_TX_FIFO_FREE_NUM, i2c->reg->FSR) != 0x10) && (ret == ARM_DRIVER_OK));

        if(ret != ARM_DRIVER_OK)
        {
            i2c->ctrl->status.busy = 0;
            return ret;
        }

        if(xfer_pending == false)
        {
            i2c->reg->SCR |= I2C_SCR_STOP_Msk;

            // Wait for stop condition has been send out
            while((i2c->reg->ISR & I2C_ISR_DETECT_STOP_Msk) == 0);
            i2c->reg->ISR = I2C_ISR_DETECT_STOP_Msk;
        }

        while(i2c->reg->STR & I2C_STR_BUSY_Msk);

        i2c->reg->IER = 0;

        i2c->ctrl->status.busy = 0;
    }

    return ARM_DRIVER_OK;
}

/**
  \fn          int32_t I2Cx_MasterReceive(uint32_t       addr,
                                          uint8_t       *data,
                                          uint32_t       num,
                                          bool           xfer_pending,
                                          I2C_RESOURCES *i2c)
  \brief       Start receiving data as I2C Master.
  \param[in]   addr          Slave address (7-bit or 10-bit)
  \param[out]  data          Pointer to buffer for data to receive from I2C Slave
  \param[in]   num           Number of data bytes to receive
  \param[in]   xfer_pending  Transfer operation is pending - Stop condition will not be generated
  \param[in]   i2c           Pointer to I2C resources
  \return      \ref execution_status
*/
int32_t I2C_MasterReceive(uint32_t addr, uint8_t *data, uint32_t num, bool xfer_pending, I2C_RESOURCES *i2c)
{
#ifdef PM_FEATURE_ENABLE
    uint32_t instance;
#endif
    uint32_t reg_value;
    int32_t ret;


    DmaTransferConfig_t dmaRxConfig = {(void *)&i2c->reg->RDR, (void *)data,
                                       DMA_FLOW_CONTROL_SOURCE, DMA_ADDRESS_INCREMENT_TARGET,
                                       DMA_DATA_WIDTH_ONE_BYTE,
                                       DMA_BURST_8_BYTES, num
                                      };
    if(!data || !num || (addr > 0x3ff))
    {
        return ARM_DRIVER_ERROR_PARAMETER;
    }

    if(!(i2c->ctrl->flags & I2C_FLAG_SETUP))
    {
        I2CDEBUG("I2C_FLAG_SETUP not done\n");
        return ARM_DRIVER_ERROR;
    }

    if(i2c->ctrl->status.busy)
    {
        return ARM_DRIVER_ERROR_BUSY;
    }

#ifdef PM_FEATURE_ENABLE
    instance = I2C_GetInstanceNumber(i2c);
#endif

    I2CDEBUG("I2C_MasterReceive\n");

    // Set control variables
    i2c->ctrl->sla_rw = addr;
    i2c->ctrl->pending = xfer_pending;
    i2c->ctrl->data = (uint8_t *)data;
    i2c->ctrl->num  = num;
    i2c->ctrl->cnt  = 0;

    // Update driver status
    i2c->ctrl->status.busy = 1;
    // 0 :slave / 1 :master
    i2c->ctrl->status.mode = 1;
    // 0 :tx  / 1 :rx
    i2c->ctrl->status.direction = 0;
    i2c->ctrl->status.arbitration_lost = 0;
    i2c->ctrl->status.bus_error = 0;
    i2c->ctrl->status.rx_nack = 0;

    if(i2c->reg->STR & I2C_STR_BUSY_Msk)
    {
        return ARM_DRIVER_ERROR_BUSY;
    }

    i2c->ctrl->flags |= I2C_FLAG_MASTER_RX;

    if(i2c->dma)
    {
#ifdef PM_FEATURE_ENABLE
        LOCK_SLEEP(instance);
#endif
        // Configure rx DMA and start it
        DMA_transferSetup(i2c->dma->rx_instance, i2c->dma->rx_ch, &dmaRxConfig);
        DMA_enableChannelInterrupts(i2c->dma->rx_instance, i2c->dma->rx_ch, DMA_END_INTERRUPT_ENABLE);

        I2CDEBUG("dma configure\n");
        DMA_startChannel(i2c->dma->rx_instance, i2c->dma->rx_ch);
    }
    else
    {
        // Enable interrupts to reflect specific status
        i2c->reg->IER = (I2C_IER_TRANSFER_DONE_Msk |
                         I2C_IER_ARBITRATATION_LOST_Msk |
                         I2C_IER_DETECT_STOP_Msk |
                         I2C_IER_BUS_ERROR_Msk |
                         I2C_IER_RX_NACK_Msk);


        // Clear all flags first(W1C)
        i2c->reg->ISR = i2c->reg->ISR;

        // Config and issue command
        i2c->reg->MCR = (I2C_MCR_CONTROL_MODE_Msk | I2C_MCR_I2C_EN_Msk);

        reg_value = (((addr << 1) & (I2C_SCR_TARGET_SLAVE_ADDR_Msk)) | ((num - 1) << I2C_SCR_BYTE_NUM_Pos) | I2C_SCR_TARGET_RWN_Msk | I2C_SCR_START_Msk);

        I2CDEBUG("SCR = 0x%x\r\n", reg_value);

        i2c->reg->SCR = reg_value;

        while(num > i2c->ctrl->cnt)
        {
            // Wait for Rx ready
            do
            {
                ret = I2C_MasterCheckStatus(i2c);

            } while(((i2c->reg->FSR & I2C_FSR_RX_FIFO_DATA_NUM_Msk) == 0) && (ret == ARM_DRIVER_OK));

            if(ret != ARM_DRIVER_OK)
            {
                i2c->ctrl->status.busy = 0;
                return ret;
            }

            i2c->ctrl->data[i2c->ctrl->cnt++] = i2c->reg->RDR;
        }

        if(xfer_pending == false)
        {
            i2c->reg->SCR |= I2C_SCR_STOP_Msk;

            // Wait for stop condition has been send out
            while((i2c->reg->ISR & I2C_ISR_DETECT_STOP_Msk) == 0);
            i2c->reg->ISR = I2C_ISR_DETECT_STOP_Msk;
        }

        while((i2c->reg->ISR & I2C_ISR_TRANSFER_DONE_Msk) == 0);

        i2c->reg->IER = 0;
        i2c->ctrl->status.busy = 0;
    }
    return ARM_DRIVER_OK;
}

/**
  \fn          int32_t I2Cx_SlaveTransmit(const uint8_t *data,
                                          uint32_t       num,
                                          I2C_RESOURCES *i2c)
  \brief       Start transmitting data as I2C Slave.
  \param[in]   data  Pointer to buffer with data to transmit to I2C Master
  \param[in]   num   Number of data bytes to transmit
  \param[in]   i2c   Pointer to I2C resources
  \return      \ref execution_status
*/
int32_t I2C_SlaveTransmit(const uint8_t *data, uint32_t num, I2C_RESOURCES *i2c)
{
    return ARM_DRIVER_OK;
}

/**
  \fn          int32_t I2Cx_MasterReceive(uint32_t       addr,
                                          uint8_t       *data,
                                          uint32_t       num,
                                          bool           xfer_pending,
                                          I2C_RESOURCES *i2c)
  \brief       Start receiving data as I2C Master.
  \param[in]   addr          Slave address (7-bit or 10-bit)
  \param[out]  data          Pointer to buffer for data to receive from I2C Slave
  \param[in]   num           Number of data bytes to receive
  \param[in]   xfer_pending  Transfer operation is pending - Stop condition will not be generated
  \param[in]   i2c           Pointer to I2C resources
  \return      \ref execution_status
*/
int32_t I2C_SlaveReceive(uint8_t *data, uint32_t num, I2C_RESOURCES *i2c)
{
#ifdef PM_FEATURE_ENABLE
    uint32_t instance;
#endif

    if(!data || !num)
    {
        /* Invalid parameters */
        return ARM_DRIVER_ERROR_PARAMETER;
    }

    if(i2c->ctrl->status.busy)
    {
        /* Transfer operation in progress, Master stalled or Slave transmit stalled */
        return ARM_DRIVER_ERROR_BUSY;
    }

#ifdef PM_FEATURE_ENABLE
    instance = I2C_GetInstanceNumber(i2c);
#endif

    /* Set control variables */
    i2c->ctrl->flags |= I2C_FLAG_SLAVE_RX;
    i2c->ctrl->sdata  = data;
    i2c->ctrl->snum   = num;
    i2c->ctrl->cnt    = 0;

    /* Update driver status */
    i2c->ctrl->status.general_call = 0;
    i2c->ctrl->status.bus_error    = 0;

    // Update driver status
    i2c->ctrl->status.busy = 1;
    // 0 :slave / 1 :master
    i2c->ctrl->status.mode = 0;
    // 0 :tx  / 1 :rx
    i2c->ctrl->status.direction = 1;

    if(i2c->reg->STR & I2C_STR_BUSY_Msk)
    {
        return ARM_DRIVER_ERROR_BUSY;
    }

    if(i2c->dma)
    {
#ifdef PM_FEATURE_ENABLE
        LOCK_SLEEP(instance);
#endif
    }
    else
    {
        // Enable interrupts to reflect specific status
#if 0
        i2c->reg->IER = (I2C_IER_TRANSFER_DONE_Msk |
                         I2C_IER_ARBITRATATION_LOST_Msk |
                         I2C_IER_DETECT_STOP_Msk |
                         I2C_IER_BUS_ERROR_Msk |
                         I2C_IER_RX_NACK_Msk);
#else
        i2c->reg->IER = 0x3ffff;
#endif

        // Clear all flags first(W1C)
        i2c->reg->ISR = i2c->reg->ISR;

        // Config and issue command
        i2c->reg->MCR = EIGEN_VAL2FLD(I2C_MCR_TX_FIFO_THRESHOLD, 8) | EIGEN_VAL2FLD(I2C_MCR_RX_FIFO_THRESHOLD, 8) | \
        I2C_MCR_DISABLE_SCL_STRETCH_Msk | I2C_MCR_AUTOCG_EN_Msk | \
        I2C_MCR_CONTROL_MODE_Msk | I2C_MCR_I2C_EN_Msk | I2C_MCR_DISABLE_MASTER_Msk;

        i2c->reg->SCR = (num - 1) << I2C_SCR_BYTE_NUM_Pos ; //I2C_SCR_BYTE_NUM_UNKNOWN_Msk;//;


        while((i2c->reg->ISR & I2C_ISR_SLAVE_ADDR_MATCHED_Msk) == 0);
        i2c->reg->ISR = I2C_ISR_SLAVE_ADDR_MATCHED_Msk;

        while(num > i2c->ctrl->cnt)
        {
#if 1
            if(i2c->reg->ISR & I2C_ISR_RX_ONE_DATA_Msk)
            {
                i2c->reg->ISR = I2C_ISR_RX_ONE_DATA_Msk;
                i2c->reg->SCR = I2C_SCR_ACK_Msk;
                i2c->ctrl->sdata[i2c->ctrl->cnt++] = i2c->reg->RDR;
            }
#endif
        }


        i2c->reg->IER = 0;
        i2c->ctrl->status.busy = 0;
    }

    return ARM_DRIVER_OK;
}

/**
  \fn          int32_t I2Cx_GetDataCount(I2C_RESOURCES *i2c)
  \brief       Get transferred data count.
  \return      number of data bytes transferred; -1 when Slave is not addressed by Master
*/
int32_t I2C_GetDataCount(I2C_RESOURCES *i2c)
{
    return (i2c->ctrl->cnt);
}

/**
  \fn          int32_t I2C_GetClockFreq(I2C_RESOURCES *i2c)
  \brief       Get i2c clock.
  \return      value of i2c clock
*/
int32_t I2C_GetClockFreq(I2C_RESOURCES *i2c)
{
    uint32_t instance = I2C_GetInstanceNumber(i2c);

    return GPR_getClockFreq(g_i2cClocks[instance*2 + 1]);
}

/**
  \fn          int32_t I2Cx_Control(uint32_t       control,
                                    uint32_t       arg,
                                    I2C_RESOURCES *i2c)
  \brief       Control I2C Interface.
  \param[in]   control  operation
  \param[in]   arg      argument of operation (optional)
  \param[in]   i2c      pointer to I2C resources
  \return      \ref execution_status
*/
int32_t I2C_Control(uint32_t control, uint32_t arg, I2C_RESOURCES *i2c)
{
    uint32_t val, clk;
    if(!(i2c->ctrl->flags & I2C_FLAG_POWER))
    {
        return ARM_DRIVER_ERROR;
    }
    switch(control)
    {
        case ARM_I2C_OWN_ADDRESS:
            // General call enable
            if(arg & ARM_I2C_ADDRESS_GC)
            {
                i2c->reg->SAR |= I2C_SAR_GENERAL_CALL_EN_Msk;
            }
            else
            {
                i2c->reg->SAR &= (~I2C_SAR_GENERAL_CALL_EN_Msk);
            }
            // Slave address mode 0: 7-bit mode 1: 10-bit mode
            if(arg & ARM_I2C_ADDRESS_10BIT)
            {
                i2c->reg->SAR |= I2C_SAR_SLAVE_ADDR_MODE_Msk;
                val = arg & 0x3FF;
            }
            else
            {
                i2c->reg->SAR &= (~I2C_SAR_SLAVE_ADDR_MODE_Msk);
                val = arg & 0x7F;
            }
            // Slave address
            i2c->reg->SAR |= (val << 1);
            // Enable slave address
            i2c->reg->SAR |= I2C_SAR_SLAVE_ADDR_EN_Msk;
            break;

        case ARM_I2C_BUS_SPEED:
            clk = I2C_GetClockFreq(i2c);
            switch(arg)
            {
                case ARM_I2C_BUS_SPEED_STANDARD:
                    // 100kHz
                    clk /= 100000U;
                    break;
                case ARM_I2C_BUS_SPEED_FAST:
                    // 400kHz
                    clk /= 400000U;
                    break;
                case ARM_I2C_BUS_SPEED_FAST_PLUS:
                    // 1MHz
                    clk /= 1000000U;
                    break;
                default:
                    return ARM_DRIVER_ERROR_UNSUPPORTED;
            }
            i2c->reg->TPR = (((clk / 2) << I2C_TPR_SCLH_Pos) | ((clk / 2 ) << I2C_TPR_SCLL_Pos)) | \
                            EIGEN_VAL2FLD(I2C_TPR_SDA_SETUP_TIME, 0) | \
                            EIGEN_VAL2FLD(I2C_TPR_SDA_HOLD_TIME, 1)  | \
                            EIGEN_VAL2FLD(I2C_TPR_SPIKE_FILTER_CNUM, 0);
            I2CDEBUG("TPR = 0x%x\r\n", i2c->reg->TPR);
            // Speed configured
            i2c->ctrl->flags |= I2C_FLAG_SETUP;
            break;

        case ARM_I2C_BUS_CLEAR:
            break;

        case ARM_I2C_ABORT_TRANSFER:
            break;

        default:
            return ARM_DRIVER_ERROR_UNSUPPORTED;
    }
    return ARM_DRIVER_OK;
}

/**
  \fn          ARM_I2C_STATUS I2Cx_GetStatus(I2C_RESOURCES *i2c)
  \brief       Get I2C status.
  \param[in]   i2c      pointer to I2C resources
  \return      I2C status \ref ARM_I2C_STATUS
*/
ARM_I2C_STATUS I2C_GetStatus(I2C_RESOURCES *i2c)
{
    return (i2c->ctrl->status);
}


/**
  \fn          void I2Cx_IRQHandler(I2C_RESOURCES *i2c)
  \brief       I2C Event Interrupt handler.
  \param[in]   i2c  Pointer to I2C resources
*/
void I2C_IRQHandler(I2C_RESOURCES *i2c)
{
    uint32_t tmp_status = 0;
    tmp_status = i2c->reg->ISR;
    // write 1 clear for those interrupts
    i2c->reg->ISR = tmp_status;

    I2CDEBUG("IRQHandler = 0x%x\n", tmp_status);
    if(tmp_status & I2C_ISR_TRANSFER_DONE_Msk)
    {
        I2CDEBUG("I2C_IRQHandler transfer done\r\n");

        // Clear Tx or Rx flag
        i2c->ctrl->flags &= ~(I2C_FLAG_MASTER_TX | I2C_FLAG_MASTER_RX);
        i2c->ctrl->status.busy = 0;
        if(i2c->ctrl->cb_event)
           i2c->ctrl->cb_event(ARM_I2C_EVENT_TRANSFER_DONE);
    }
    if(tmp_status & I2C_ISR_TX_FIFO_EMPTY_Msk)
    {
        I2CDEBUG("I2C_IRQHandler tx fifo empty\r\n");
    }
    if(tmp_status & I2C_ISR_RX_FIFO_FULL_Msk)
    {
        I2CDEBUG("I2C_IRQHandler rx fifo full\r\n");
    }
    if(tmp_status & I2C_IER_RX_ONE_DATA_Msk)
    {
        I2CDEBUG("I2C_IRQHandler rx one data\r\n");
        #if 0
        if(i2c->ctrl->num > i2c->ctrl->cnt)
        {
            temp_data = i2c->reg->RDR;
            I2CDEBUG("recv data=%d\n", temp_data);
            *(i2c->ctrl->data++) = temp_data;
            i2c->ctrl->cnt++;
        }
        #endif
    }
    if(tmp_status & I2C_IER_TX_ONE_DATA_Msk)
    {
        I2CDEBUG("I2C_IRQHandler tx one data\r\n");
        #if 0
        if(i2c->ctrl->num > i2c->ctrl->cnt)
        {
            if(i2c->ctrl->data)
            {
                // If data available
                temp_data = *(i2c->ctrl->data++);
            }
            I2CDEBUG("send data=%d\n", temp_data);
            i2c->reg->I2CTDR = temp_data;            // Activate send
            i2c->ctrl->cnt++;
        }
        #endif
    }
}

/**
  \fn          void I2C_DmaTxEvent(uint32_t event, I2C_RESOURCES *i2c)
  \brief       I2C DMA Tx Event handler.
  \param[in]   event DMA Tx Event
  \param[in]   i2c   Pointer to I2C resources
*/
void I2C_DmaTxEvent(uint32_t event, I2C_RESOURCES *i2c)
{
#ifdef PM_FEATURE_ENABLE
    uint32_t instance = I2C_GetInstanceNumber(i2c);
#endif

    switch(event)
    {
        case DMA_EVENT_END:

            I2CDEBUG("I2C_DmaTxEvent\n");
            i2c->ctrl->cnt= i2c->ctrl->num;
            i2c->ctrl->status.busy = 0U;
            if(i2c->ctrl->cb_event)
            {
                i2c->ctrl->cb_event(ARM_I2C_EVENT_TRANSFER_DONE);
            }
#ifdef PM_FEATURE_ENABLE
            CHECK_TO_UNLOCK_SLEEP(instance);
#endif
            break;
        case DMA_EVENT_ERROR:
        default:
            break;
    }
}


/**
  \fn          void I2C_DmaRxEvent(uint32_t event, I2C_RESOURCES *i2c)
  \brief       I2C DMA Rx Event handler.
  \param[in]   event DMA Rx Event
  \param[in]   i2c   Pointer to I2C resources
*/
void I2C_DmaRxEvent(uint32_t event, I2C_RESOURCES *i2c)
{
#ifdef PM_FEATURE_ENABLE
    uint32_t instance = I2C_GetInstanceNumber(i2c);
#endif

    switch(event)
    {
        case DMA_EVENT_END:
            i2c->ctrl->cnt= i2c->ctrl->num;
            i2c->ctrl->status.busy = 0U;
            if(i2c->ctrl->cb_event)
            {
                i2c->ctrl->cb_event(ARM_I2C_EVENT_TRANSFER_DONE);
            }
#ifdef PM_FEATURE_ENABLE
            CHECK_TO_UNLOCK_SLEEP(instance);
#endif
            break;
        case DMA_EVENT_ERROR:
        default:
            break;
    }
}

#if (RTE_I2C0)
static int32_t I2C0_Initialize(ARM_I2C_SignalEvent_t cb_event)
{
    return I2C_Initialize(cb_event, &I2C0_Resources);
}
static int32_t I2C0_Uninitialize(void)
{
    return I2C_Uninitialize(&I2C0_Resources);
}
static int32_t I2C0_PowerControl(ARM_POWER_STATE state)
{
    return I2C_PowerControl(state, &I2C0_Resources);
}
static int32_t I2C0_MasterTransmit(uint32_t addr, const uint8_t *data, uint32_t num, bool xfer_pending)
{
    return I2C_MasterTransmit(addr, data, num, xfer_pending, &I2C0_Resources);
}
static int32_t I2C0_MasterReceive(uint32_t addr, uint8_t *data, uint32_t num, bool xfer_pending)
{
    return I2C_MasterReceive(addr, data, num, xfer_pending, &I2C0_Resources);
}
static int32_t I2C0_SlaveTransmit(const uint8_t *data, uint32_t num)
{
    return I2C_SlaveTransmit(data, num, &I2C0_Resources);
}
static int32_t I2C0_SlaveReceive(uint8_t *data, uint32_t num)
{
    return I2C_SlaveReceive(data, num, &I2C0_Resources);
}
static int32_t I2C0_GetDataCount(void)
{
    return I2C_GetDataCount(&I2C0_Resources);
}
static int32_t I2C0_Control(uint32_t control, uint32_t arg)
{
    return I2C_Control(control, arg, &I2C0_Resources);
}
static ARM_I2C_STATUS I2C0_GetStatus(void)
{
    return I2C_GetStatus(&I2C0_Resources);
}
void I2C0_IRQHandler(void)
{
    I2C_IRQHandler(&I2C0_Resources);
}
void I2C0_DmaTxEvent(uint32_t event)
{
    I2C_DmaTxEvent(event, &I2C0_Resources);
}
void I2C0_DmaRxEvent(uint32_t event)
{
    I2C_DmaRxEvent(event, &I2C0_Resources);
}

ARM_DRIVER_I2C Driver_I2C0 =
{
    ARM_I2C_GetVersion,
    I2C_GetCapabilities,
    I2C0_Initialize,
    I2C0_Uninitialize,
    I2C0_PowerControl,
    I2C0_MasterTransmit,
    I2C0_MasterReceive,
    I2C0_SlaveTransmit,
    I2C0_SlaveReceive,
    I2C0_GetDataCount,
    I2C0_Control,
    I2C0_GetStatus
};

#endif

#if (RTE_I2C1)

static int32_t I2C1_Initialize(ARM_I2C_SignalEvent_t cb_event)
{
    return I2C_Initialize(cb_event, &I2C1_Resources);
}
static int32_t I2C1_Uninitialize(void)
{
    return I2C_Uninitialize(&I2C1_Resources);
}
static int32_t I2C1_PowerControl(ARM_POWER_STATE state)
{
    return I2C_PowerControl(state, &I2C1_Resources);
}
static int32_t I2C1_MasterTransmit(uint32_t addr, const uint8_t *data, uint32_t num, bool xfer_pending)
{
    return I2C_MasterTransmit(addr, data, num, xfer_pending, &I2C1_Resources);
}
static int32_t I2C1_MasterReceive(uint32_t addr, uint8_t *data, uint32_t num, bool xfer_pending)
{
    return I2C_MasterReceive(addr, data, num, xfer_pending, &I2C1_Resources);
}
static int32_t I2C1_SlaveTransmit(const uint8_t *data, uint32_t num)
{
    return I2C_SlaveTransmit(data, num, &I2C1_Resources);
}
static int32_t I2C1_SlaveReceive(uint8_t *data, uint32_t num)
{
    return I2C_SlaveReceive(data, num, &I2C1_Resources);
}
static int32_t I2C1_GetDataCount (void)
{
    return I2C_GetDataCount(&I2C1_Resources);
}
static int32_t I2C1_Control(uint32_t control, uint32_t arg)
{
    return I2C_Control(control, arg, &I2C1_Resources);
}
static ARM_I2C_STATUS I2C1_GetStatus(void)
{
    return I2C_GetStatus(&I2C1_Resources);
}
void I2C1_IRQHandler(void)
{
    I2C_IRQHandler(&I2C1_Resources);
}

void I2C1_DmaTxEvent(uint32_t event)
{
    I2C_DmaTxEvent(event, &I2C1_Resources);
}
void I2C1_DmaRxEvent(uint32_t event)
{
    I2C_DmaRxEvent(event, &I2C1_Resources);
}

// End I2C Interface

ARM_DRIVER_I2C Driver_I2C1 =
{
    ARM_I2C_GetVersion,
    I2C_GetCapabilities,
    I2C1_Initialize,
    I2C1_Uninitialize,
    I2C1_PowerControl,
    I2C1_MasterTransmit,
    I2C1_MasterReceive,
    I2C1_SlaveTransmit,
    I2C1_SlaveReceive,
    I2C1_GetDataCount,
    I2C1_Control,
    I2C1_GetStatus
};
#endif

