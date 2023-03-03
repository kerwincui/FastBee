/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    dma.h
 * Description:  EC618 dma controller driver header file
 * History:      Rev1.0   2018-08-08
 *
 ****************************************************************************/

#ifndef _DMA_EC618_H
#define _DMA_EC618_H

#include "ec618.h"
#include "Driver_Common.h"

/**
  \addtogroup dma_interface_gr
  \{
 */

/*******************************************************************************
 * Definitions
 ******************************************************************************/

/** \brief List of DMA source/target address increment control options */
typedef enum
{
    DMA_ADDRESS_INCREMENT_NONE     = 0,   /**< Increment neither source or target address */
    DMA_ADDRESS_INCREMENT_SOURCE   = 1U,  /**< Increment source address                   */
    DMA_ADDRESS_INCREMENT_TARGET   = 2U,  /**< Increment target address                   */
    DMA_ADDRESS_INCREMENT_BOTH     = 3U,  /**< Increment both source and target address   */
} DmaAddressIncrement_e;

/** \brief List of DMA flow control options */
typedef enum
{
    DMA_FLOW_CONTROL_NONE          = 0U,  /**< No flow control */
    DMA_FLOW_CONTROL_SOURCE        = 1U,  /**< Only source     */
    DMA_FLOW_CONTROL_TARGET        = 2U,  /**< Only target     */
} DmaFlowControl_e;

/** \brief List of DMA transfer data width in peripheral involved case */
typedef enum
{
    DMA_DATA_WIDTH_NO_USE           = 0,   /**< Data width is set to 0 in memory to memory transfer    */
    DMA_DATA_WIDTH_ONE_BYTE         = 1U,  /**< Data widath is 1 byte in peripheral involved transfer  */
    DMA_DATA_WIDTH_TWO_BYTES        = 2U,  /**< Data widath is 2 bytes in peripheral involved transfer */
    DMA_DATA_WIDTH_FOUR_BYTES       = 3U,  /**< Data widath is 4 bytes in peripheral involved transfer */
} DmaDataWidth_e;

/** \brief Maximum burst size of each data transfer */
typedef enum
{
    DMA_BURST_4_BYTES              = 0,   /**< Burst size is set to reserved */
    DMA_BURST_8_BYTES              = 1U,  /**< Burst size is set to 8 bytes  */
    DMA_BURST_16_BYTES             = 2U,  /**< Burst size is set to 16 bytes */
    DMA_BURST_32_BYTES             = 3U,  /**< Burst size is set to 32 bytes */
    DMA_BURST_64_BYTES             = 4U,  /**< Burst size is set to 64 bytes */
} DmaBurstSize_e;

/** \brief DMA transfer configuration structure */
typedef struct
{
    void                     *sourceAddress;        /**< Source address                  */
    void                     *targetAddress;        /**< Target address                  */
    DmaFlowControl_e          flowControl;          /**< Flow control setting            */
    DmaAddressIncrement_e     addressIncrement;     /**< Address increment setting       */
    DmaDataWidth_e            dataWidth;            /**< Data width setting              */
    DmaBurstSize_e            burstSize;            /**< Burst size setting              */
    uint32_t                  totalLength;          /**< Transfer length onetime, less than 8k bytes. In descriptor chain it means every transfer's size */
 } DmaTransferConfig_t;

/** \brief DMA descriptor extra configuration structure for descriptor-chain mode */
typedef struct
{
    void                  *nextDesriptorAddress;        /**< Next descriptor address                        */
    bool                   stopDecriptorFetch;          /**< Indicate whether this is the last descriptor   */
    bool                   enableStartInterrupt;        /**< Start interrupt control */
    bool                   enableEndInterrupt;          /**< End interrupt control */
} DmaExtraConfig_t;

/** \brief DMA descriptor structure */
typedef struct
{
    uint32_t      DAR;      /**< DMA Descriptor Address */
    uint32_t      SAR;      /**< DMA Source Address     */
    uint32_t      TAR;      /**< DMA Target Address     */
    uint32_t      CMDR;     /**< DMA Command            */
} DmaDescriptor_t;

/** \brief List of DMA interrupt sources */
typedef enum
{
    /** Stop interrupt enable, when enabled, interrupt is triggered after the channel stops */
    DMA_STOP_INTERRUPT_ENABLE  = (1U << 29U),
    /** EOR interrupt enable, when enabled, interrupt is triggered on End-Of-Receive condition */
    DMA_EOR_INTERRUPT_ENABLE   = (1U << 28U),
    /** Start interrupt enable, when enabled, interrupt is triggered as soon as descriptor is loaded, valid for descriptor-chain-mode */
    DMA_START_INTERRUPT_ENABLE = (1U << 22U),
    /** End interrupt enable, when enabled, interrupt is triggered when transfer length decrements to 0 */
    DMA_END_INTERRUPT_ENABLE   = (1U << 21U),
} DmaInterruptEnable_e;

/** \brief List of DMA available intances */
typedef enum
{
    DMA_INSTANCE_AP,
    DMA_INSTANCE_MP,
    DMA_INSTANCE_MAX,
} DmaInstance_e;

/** DMA specific error codes */
#define     ARM_DMA_ERROR_CHANNEL_ALLOC        (ARM_DRIVER_ERROR_SPECIFIC - 1)     /**< No free channel any more        */
#define     ARM_DMA_ERROR_CHANNEL_NOT_OPEN     (ARM_DRIVER_ERROR_SPECIFIC - 2)     /**< Specific channel not open       */
#define     ARM_DMA_ERROR_CHANNEL_NOT_STOPPED  (ARM_DRIVER_ERROR_SPECIFIC - 3)     /**< Specific channel not stopped    */
#define     ARM_DMA_ERROR_ADDRESS_NOT_ALIGNED  (ARM_DRIVER_ERROR_SPECIFIC - 4)     /**< Address alignment check failure */


/** List of events reported to application */
#define DMA_EVENT_ERROR    (1)        /**< Bus error                    */
#define DMA_EVENT_START    (2)        /**< Descriptor load successfully */
#define DMA_EVENT_END      (3)        /**< Transaction end              */
#define DMA_EVENT_EOR      (4)        /**< Receive EOR signal           */
#define DMA_EVENT_STOP     (5)        /**< Channel has stopped          */

/**
  \brief Defines callback function prototype.
         Callback function will be called in DMA interrupt service routine after a transaction is complete
  \param event  transaction event for the current transaction, application can get the tansaction
                    result from this paramter, available events: DMA_EVENT_ERROR, DMA_EVENT_START, DMA_EVENT_END, DMA_EVENT_EOR, DMA_EVENT_STOP
 */
typedef void (*dma_callback_t)(uint32_t event);

/** \brief timeout value when stopping channel */
#define DMA_STOP_TIMEOUT             (5000U)

/*******************************************************************************
 * API
 ******************************************************************************/


#ifdef __cplusplus
 extern "C" {
#endif

/**
  \fn    void DMA_init(DmaInstance_e instance)
  \brief Intialize DMA hareware and internal used structure, call this function before any other DMA APIs
 */
void DMA_init(DmaInstance_e instance);

/** \name DMA Channel operation API */
/** \{ */

/**
  \fn        int32_t DMA_openChannel(DmaInstance_e instance)
  \brief     Opens a DMA channel
  \return    Channel on successful allocate
             ARM_DMA_ERROR_CHANNEL_ALLOC when no free channel is found
  \note      Caller shall check the return code
 */
int32_t DMA_openChannel(DmaInstance_e instance);

/**
  \fn        int32_t DMA_closeChannel(DmaInstance_e instance, uint32_t channel)
  \brief     Closes a DMA channel
  \param[in] instance
  \param[in] channel    DMA channel number
  \return    ARM_DRIVER_OK if no error happens
             ARM_DMA_ERROR_CHANNEL_NOT_OPEN when channel is not open
  \note      This API will call \ref DMA_stopChannel to stop channel first if channel is running before close
 */
int32_t DMA_closeChannel(DmaInstance_e instance, uint32_t channel);

/**
  \fn        void DMA_startChannel(DmaInstance_e instance, uint32_t channel)
  \brief     Activates the DMA channel
  \param[in] instance
  \param[in] channel    DMA channel number
 */
void DMA_startChannel(DmaInstance_e instance, uint32_t channel);

/**
  \fn        int32_t DMA_stopChannel(uint32_t channel, bool waitForStop)
  \brief     Stops the DMA channel from running
  \param[in] channel        DMA channel number
  \param[in] waitForStop    whether to wait channel to fully stop or not
  \return    ARM_DRIVER_OK if stops successfully
             ARM_DMA_ERROR_CHANNEL_NOT_STOPPED if channel fails to stop until timeout expires
  \note      staus and interrupt flags will be cleared in this function call
 */
int32_t DMA_stopChannel(DmaInstance_e instance, uint32_t channel, bool waitForStop);

/**
  \fn        void DMA_resetChannel(uint32_t channel)

  \brief     Put the DMA channel to reset state
  \param[in] channel        DMA channel number
  \note      Make sure DMA is stopped before calling this function
 */
void DMA_resetChannel(DmaInstance_e instance, uint32_t channel);

/**
  \fn        void DMA_rigisterChannelCallback(uint32_t channel, dma_callback_t callback)
  \brief     Registers a DMA callback
  \param[in] channel        DMA channel number
  \param[in] callback       Given by the application and will be called in DMA interrupt service routine
 */
void DMA_rigisterChannelCallback(DmaInstance_e instance, uint32_t channel, dma_callback_t callback);

/**
  \fn        void DMA_enableChannelInterrupts(uint32_t channel, uint32_t mask)
  \brief     Enables DMA interrupts
  \param[in] channel        DMA channel number
  \param[in] mask           Mask of interrupt source to be set, can be ORed by items list in \ref DmaInterruptEnable_e
  \note      In no-descriptor-fetch mode, all interrupt sources can be enabled by calling this API, however, in descritor-fetch
             mode, only \ref DMA_STOP_INTERRUPT_ENABLE \ref DMA_EOR_INTERRUPT_ENABLE can be done by this function call,
             the \ref DMA_START_INTERRUPT_ENABLE and \ref DMA_END_INTERRUPT_ENABLE is controlled by setting in \ref DmaExtraConfig_t respectively.
 */
void DMA_enableChannelInterrupts(DmaInstance_e instance, uint32_t channel, uint32_t mask);

/**
  \fn        void DMA_disableChannelInterrupts(uint32_t channel, uint32_t mask)
  \brief     Disables DMA interrupts
  \param[in] channel        DMA channel number
  \param[in] mask           Mask of interrupt source to be disabled, can be ORed by items list in \ref DmaInterruptEnable_e
  \note      In no-descriptor-fetch mode, all interrupt sources can be disabled by calling this API, however, in descritor-fetch
             mode, only \ref DMA_STOP_INTERRUPT_ENABLE \ref DMA_EOR_INTERRUPT_ENABLE can be done by this function call ,
             the \ref DMA_START_INTERRUPT_ENABLE and \ref DMA_END_INTERRUPT_ENABLE is controlled by setting in \ref DmaExtraConfig_t respectively.
 */
void DMA_disableChannelInterrupts(DmaInstance_e instance, uint32_t channel, uint32_t mask);

/**
  \fn        uint32_t DMA_getEnabledInterrupts(uint32_t channel)
  \brief     Gets current enabled DMA channel interrupts
  \param[in] channel    DMA channel number
  \return    The logical OR of members of the enumeration \ref DmaInterruptEnable_e
 */
uint32_t DMA_getEnabledInterrupts(DmaInstance_e instance, uint32_t channel);

/**
  \fn        uint32_t DMA_getChannelCount(uint32_t channel)
  \brief     Obtains courrent transferred data length of a transaction in unit of byte
  \param[in] channel        DMA channel number
  \return    Size of data has been transferred
  \note      In descritor-fetch mode, Start Interrupt shall be enabled by enableStartInterrupt setting in \ref DmaExtraConfig_t
             so that driver can load total transfer number for calculation before transferring.
 */
uint32_t DMA_getChannelCount(DmaInstance_e instance, uint32_t channel);

/**
  \fn        void DMA_setChannelRequestSource(uint32_t channel, DmaRequestSource_e request)
  \brief     Configures DMA request source
  \param[in] channel        DMA channel number
  \param[in] request        DMA request binded to this channel
 */
void DMA_setChannelRequestSource(DmaInstance_e instance, uint32_t channel, DmaRequestSource_e request);

/** \} */

/** \name DMA register mode API */
/** \{ */

/**
  \fn        void DMA_transferSetup(DmaInstance_e instance, uint32_t channel, const DmaTransferConfig_t* config)
  \brief     Setups DMA channel according to user's transfer configuration, usded for register mode
  \param[in] instance
  \param[in] channel        DMA channel number
  \param[in] config         Pointer to transfer configuration
  \note      user configuration shall be retaining(global variable) for it will be used again after exit from low power
 */
void DMA_transferSetup(DmaInstance_e instance, uint32_t channel, const DmaTransferConfig_t* config);
/** \} */

/** \name DMA descriptor chain mode API */
/** \{ */

/**
  \fn         void DMA_buildDescriptor(DmaDescriptor_t* descriptor, const DmaTransferConfig_t* config, const DmaExtraConfig_t* extraConfig)
  \brief      Builds a descritor for DMA mode use
  \param[out] descriptor     Pointer to DMA descriptor instance
  \param[in]  config         Pointer to transfer configuration
  \param[in]  extraConfig    Pointer to extra configuration which is invalid in descriptor-chain-mode only
  \note       descriptor shall be retaining(global variable) for it will be used again after exit from low power
 */

void DMA_buildDescriptor(DmaDescriptor_t* descriptor, const DmaTransferConfig_t* config, const DmaExtraConfig_t* extraConfig);

/**
  \fn         void DMA_buildDescriptorChain(DmaDescriptor_t* descriptorArray, const DmaTransferConfig_t* config, const uint16_t chainCnt)
  \brief      Builds a descritor for DMA chain mode use
  \param[out] descriptorArray     Pointer to DMA descriptor chain array, should aligned with 16byte
  \param[in]  config         Pointer to transfer configuration
  \param[in]  chainCnt     The count of descriptor chain
  \param[in]  needStop     Need cycling transfer data or not
  \note       descriptor shall be retaining(global variable) for it will be used again after exit from low power
 */

void DMA_buildDescriptorChain(DmaDescriptor_t* descriptorArray, const DmaTransferConfig_t* config, const uint16_t chainCnt, bool needStop);

/**
  \fn        int32_t DMA_loadChannelFirstDescriptor(DmaInstance_e instance, uint32_t channel, void* descriptorAddress)
  \brief     Loads first descritor
  \param[in] instance
  \param[in] channel              DMA channel number
  \param[in] descriptorAddress    Address of descriptor from which to load, shall be aligend on a 16-byte boundary in memory
  \return    ARM_DRIVER_OK if success
             ARM_DMA_ERROR_ADDRESS_NOT_ALIGNED on address alignment check failure
 */
int32_t DMA_loadChannelFirstDescriptor(DmaInstance_e instance, uint32_t channel, void* descriptorAddress);

/**
  \fn        void DMA_loadChannelDescriptorAndRun(DmaInstance_e instance, uint32_t channel, void* descriptorAddress)
  \brief     Loads first descritor and run
  \param[in] instance
  \param[in] channel              DMA channel number
  \param[in] descriptorAddress    Address of descriptor from which to load, shall be aligend on a 16-byte boundary in memory
  \return    ARM_DRIVER_OK if success
             ARM_DMA_ERROR_ADDRESS_NOT_ALIGNED on address alignment check failure
 */
void DMA_loadChannelDescriptorAndRun(DmaInstance_e instance, uint32_t channel, void* descriptorAddress);


/** \} */

/** \} */

#ifdef __cplusplus
}
#endif

#endif

