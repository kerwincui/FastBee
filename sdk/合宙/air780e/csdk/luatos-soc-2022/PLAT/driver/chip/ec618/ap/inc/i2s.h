#ifndef  BSP_I2S_H
#define  BSP_I2S_H

#ifdef __cplusplus
extern "C" {
#endif
#include "stdio.h"
#include "string.h"
#include "ec618.h"
#include "bsp.h"
#include "hal_i2s.h" // To use some of typedef in this H file and the macro of DMA_CHAIN_NUM(can dynamic array in C99?)

#define POLLING_MODE                    0x1
#define DMA_MODE                        0x2



//////////////////////////////////////////////////////////////////////////////////////////////
// I2S Setting field Start
// All the I2S's parameters that need user to set are all put here
//////////////////////////////////////////////////////////////////////////////////////////////
#define ES8388_IICADDR                  0x11
#define NAU88C22_IICADDR                0x1A
#define ES8311_IICADDR                  0x18

// Sample rate that 618 supports
#define SAMPLE_RATE_8K                  0x1
#define SAMPLE_RATE_16K                 0x2
#define SAMPLE_RATE_32K                 0x3
#define SAMPLE_RATE_22_05K              0x4
#define SAMPLE_RATE_44_1K               0x5
#define SAMPLE_RATE_48K                 0x6
#define SAMPLE_RATE_96K                 0x7


// I2S0 Configuration
#define RTE_I2S0                        1
#define RTE_I2S0_IO_MODE                DMA_MODE

#define RTE_I2S0_MCLK_PAD_ADDR          39
#define RTE_I2S0_MCLK_FUNC              PAD_MUX_ALT1

#define RTE_I2S0_BCLK_PAD_ADDR          35
#define RTE_I2S0_BCLK_FUNC              PAD_MUX_ALT1

#define RTE_I2S0_LRCK_PAD_ADDR          36
#define RTE_I2S0_LRCK_FUNC              PAD_MUX_ALT1

#define RTE_I2S0_DIN_PAD_ADDR           37
#define RTE_I2S0_DIN_FUNC               PAD_MUX_ALT1

#define RTE_I2S0_DOUT_PAD_ADDR          38
#define RTE_I2S0_DOUT_FUNC              PAD_MUX_ALT1

// I2S1 Configuration
#define RTE_I2S1                        0
#define RTE_I2S1_IO_MODE                DMA_MODE

#define RTE_I2S1_MCLK_PAD_ADDR          18
#define RTE_I2S1_MCLK_FUNC              PAD_MUX_ALT1

#define RTE_I2S1_BCLK_PAD_ADDR          19
#define RTE_I2S1_BCLK_FUNC              PAD_MUX_ALT1

#define RTE_I2S1_LRCK_PAD_ADDR          20
#define RTE_I2S1_LRCK_FUNC              PAD_MUX_ALT1

#define RTE_I2S1_DIN_PAD_ADDR           21
#define RTE_I2S1_DIN_FUNC               PAD_MUX_ALT1

#define RTE_I2S1_DOUT_PAD_ADDR          22
#define RTE_I2S1_DOUT_FUNC              PAD_MUX_ALT1

//////////////////////////////////////////////////////////////////////////////////////////////
// I2S Setting field End
//////////////////////////////////////////////////////////////////////////////////////////////




/****** I2S Event *****/
#define I2S_EVENT_TRANSFER_COMPLETE     (1UL << 0)     // Data Transfer completed
#define I2S_EVENT_DATA_LOST             (1UL << 1)     // Data lost: Receive overflow / Transmit underflow
#define I2S_EVENT_MODE_FAULT            (1UL << 2)     // Master Mode Fault (SS deactivated when Master)

// DMA I2S0 Request ID
#define RTE_I2S0_DMA_TX_REQID           DMA_REQUEST_I2S0_TX
#define RTE_I2S0_DMA_RX_REQID           DMA_REQUEST_I2S0_RX

// DMA I2S1 Request ID
#define RTE_I2S1_DMA_TX_REQID           DMA_REQUEST_I2S1_TX
#define RTE_I2S1_DMA_RX_REQID           DMA_REQUEST_I2S1_RX

typedef void (*i2sCbEvent_fn) (uint32_t event, uint32_t arg);     // i2s callback event.


// I2S IRQ
typedef struct 
{
  IRQn_Type                 irqNum;                             // I2S IRQ Number
  IRQ_Callback_t            cbIrq;
} i2sIrq_t;

// I2S DMA
typedef struct 
{
    DmaInstance_e           txInstance;                         // Transmit DMA instance number
    int8_t                  txCh;                               // Transmit channel number
    uint8_t                 txReq;                              // Transmit DMA request number
    void                    (*txCb)(uint32_t event);            // Transmit callback
    DmaDescriptor_t         *txDescriptor;                      // Tx descriptor
    DmaInstance_e           rxInstance;                         // Receive DMA instance number
    int8_t                  rxCh;                               // Receive channel number
    uint8_t                 rxReq;                              // Receive DMA request number
    void                    (*rxCb)(uint32_t event);            // Receive callback
    DmaDescriptor_t         *rxDescriptor;                      // Rx descriptor
} i2sDma_t;


// I2S PINS
typedef const struct
{
    PIN                     *mclk;                               //  main clk Pin identifier
    PIN                     *bclk;                               //  pixel clk Pin identifier
    PIN                     *lrck;                               //  cs Pin identifier
    PIN                     *din;                                //  din Pin identifier
    PIN                     *dout;                               //  dout Pin identifier
} i2sPins_t;


typedef struct 
{
    uint8_t busy;                        // Transmitter/Receiver busy flag
    uint8_t dataLost;                    // Data lost: Receive overflow / Transmit underflow (cleared on start of transfer operation)
    uint8_t modeFault;                   // Mode fault detected; optional (cleared on start of transfer operation)
} i2sStatus_t;

// I2S Transfer Information (Run-Time)
typedef struct 
{
    uint32_t                num;         // Total number of transfers
    uint8_t                 *rxBuf;      // Pointer to in data buffer
    uint8_t                 *txBuf;      // Pointer to out data buffer
    uint32_t                rxCnt;       // Number of data received
    uint32_t                txCnt;       // Number of data sent
    uint32_t                dumpVal;     // Variable for dumping DMA data
    uint16_t                defVal;      // Default transfer value
} i2sTransferInfo_t;

// I2S information (Run-time)
typedef struct 
{
    i2sCbEvent_fn           txCbEvent;   // tx event callback
    i2sCbEvent_fn           rxCbEvent;   // rx event callback
    uint32_t                mode;        // I2S mode
    uint32_t                busSpeed;    // I2S bus speed
    uint16_t                chainCnt;
    uint32_t                totalNum;    // Total length of audio source
} i2sInfo_t;


// I2S Resources definition
typedef struct 
{
    I2S_TypeDef             *reg;        // I2S register pointer
    i2sPins_t               pins;        // I2S PINS configuration
    i2sDma_t                *dma;        // I2S DMA configuration pointer
    i2sIrq_t                *irq;        // I2S IRQ configuration pointer
    i2sInfo_t               *info;       // Run-Time Information
} i2sResources_t;

/**
\brief General power states
*/
typedef enum 
{
    I2S_POWER_OFF,                       // Power off: no operation possible
    I2S_POWER_FULL                       // Power on: full operation at maximum performance
} i2sPowerState_e;


/**
\brief Access structure of the I2S Driver.
*/
typedef struct 
{
    int32_t              (*init)            (i2sCbEvent_fn txCbEvent, i2sCbEvent_fn rxCbEvent); // Initialize I2S Interface.
    int32_t              (*deInit)          (void);                            // De-initialize I2S Interface.
    int32_t              (*powerCtrl)       (i2sPowerState_e state);           // Control I2S Interface Power.
    int32_t              (*send)            (void *data, uint32_t chunkNum);        // Start sending data from I2S Interface.
    int32_t              (*recv)            (void *data, uint32_t chunkNum);        // Start receiving data from I2S Interface.
    int32_t              (*ctrl)            (uint32_t control, uint32_t arg);  // Control I2S Interface.
    uint32_t			 (*getTotalCnt)		(void);
} const i2sDrvInterface_t;

typedef struct
{
    uint32_t slaveModeEn            : 1;    // Slave Mode Enable
    uint32_t slotSize               : 5;    // Slot Size
    uint32_t wordSize               : 5;    // Word Size
    uint32_t alignMode              : 1;    // Align Mode
    uint32_t endianMode             : 1;    // Endian Mode
    uint32_t dataDly                : 2;    // Data Delay
    uint32_t txPad                  : 2;    // Tx Padding
    uint32_t rxSignExt              : 1;    // Rx Sign extention
    uint32_t txPack                 : 2;    // Tx Pack
    uint32_t rxPack                 : 2;    // Rx Pack
    uint32_t txFifoEndianMode       : 1;    // Tx Fifo Endian Mode
    uint32_t rxFifoEndianMode       : 1;    // Rx Fifo Endian Mode
}i2sDataFmt_t;

/** \brief I2S Slot Control */
typedef struct
{
    uint32_t slotEn                 : 8;    // Slot Enable
    uint32_t slotNum                : 3;    // Slot number per frame synchronization
}i2sSlotCtrl_t;

/** \brief I2S Bclk Frame Synchronization Control */
typedef struct
{
    uint32_t bclkPolarity           : 1;    // Bclk Polarity
    uint32_t fsPolarity             : 1;    // Frame Synchronization Polarity
    uint32_t fsWidth                : 6;    // Frame Synchronization width
}i2sBclkFsCtrl_t;

/** \brief I2S DMA Control */
typedef struct
{
    uint32_t rxDmaReqEn             : 1;    // Rx Dma Req Enable
    uint32_t txDmaReqEn             : 1;    // Tx Dma Req Enable
    uint32_t rxDmaTimeOutEn         : 1;    // Rx Dma Timeout Enable
    uint32_t dmaWorkWaitCycle       : 5;    // Dma Work Wait Cycle
    uint32_t rxDmaBurstSizeSub1     : 4;    // Rx Dma Burst Size subtract 1
    uint32_t txDmaBurstSizeSub1     : 4;    // Tx Dma Burst Size subtract 1
    uint32_t rxDmaThreadHold        : 4;    // Rx Dma Threadhold
    uint32_t txDmaThreadHold        : 4;    // Tx Dma Threadhold
    uint32_t rxFifoFlush            : 1;    // Rx Fifo flush
    uint32_t txFifoFlush            : 1;    // Tx Fifo flush
}i2sDmaCtrl_t;

/** \brief I2S Interrupt Control */
typedef struct
{
    uint32_t txUnderRunIntEn        : 1;    // Tx Underrun interrupt Enable
    uint32_t txDmaErrIntEn          : 1;    // Tx Dma Err Interrupt Enable
    uint32_t txDatIntEn             : 1;    // Tx Data Interrupt Enable
    uint32_t rxOverFlowIntEn        : 1;    // Rx Overflow Interrupt Enable
    uint32_t rxDmaErrIntEn          : 1;    // Rx Dma Err Interrupt Enable
    uint32_t rxDatIntEn             : 1;    // Rx Data Interrupt Enable
    uint32_t rxTimeOutIntEn         : 1;    // Rx Timeout Interrupt Enable
    uint32_t fsErrIntEn             : 1;    // Frame Start Interrupt Enable
    uint32_t frameStartIntEn        : 1;    // Frame End Interrupt Enable
    uint32_t frameEndIntEn          : 1;    // Frame End Interrupt Enable
    uint32_t cspiBusTimeOutIntEn    : 1;    // Not use
    uint32_t txIntThreshHold        : 4;    // Tx Interrupt Threadhold 
    uint32_t rxIntThreshHold        : 4;    // Rx Interrupt Threadhold
}i2sIntCtrl_t;

/** \brief I2S Timeout Cycle */
typedef struct
{
    uint32_t rxTimeOutCycle         : 24;   // Rx Timeout cycle
}i2sTimeOutCycle_t;

/** \brief I2S Status */
typedef struct
{   
    uint32_t txUnderRun             : 1;    // Tx Underrun
    uint32_t txDmaErr               : 1;    // Tx Dma Err
    uint32_t txDataRdy              : 1;    // Tx Data ready, readOnly
    uint32_t rxOverFlow             : 1;    // Rx OverFlow
    uint32_t rxDmaErr               : 1;    // Rx Dma Err
    uint32_t rxDataRdy              : 1;    // Rx Data ready, readOnly
    uint32_t rxFifoTimeOut          : 1;    // Rx Fifo timeout
    uint32_t fsErr                  : 4;    // Frame synchronization Err
    uint32_t frameStart             : 1;    // Frame start
    uint32_t frameEnd               : 1;    // Frame end
    uint32_t txFifoLevel            : 6;    // Tx Fifo Level, readOnly
    uint32_t rxFifoLevel            : 6;    // Rx Fifo level, readOnly
    uint32_t cspiBusTimeOut         : 1;    // Not use
}i2sStats_t;

/** \brief I2S Control */
typedef struct
{
    uint32_t i2sMode                : 2;    // I2S Mode
}i2sCtrl_t;

/** \brief I2S Auto Configure Control */
typedef struct
{
    uint32_t autoCgEn               : 1;    // Auto Configure Enable
}i2sAutoCgCtrl_t;

/**
\brief I2S control bits.
*/
#define I2S_CTRL_TRANSABORT                (1UL << 0)     // I2S trans abort
#define I2S_CTRL_SAMPLE_RATE_SLAVE         (1UL << 1)     // I2S sample rate setting, used in ec618 slave mode
#define I2S_CTRL_SAMPLE_RATE_MASTER        (1UL << 2)     // I2S sample rate setting, used in ec618 master mode
#define I2S_CTRL_SET_TOTAL_NUM             (1UL << 3)     // Audio source total num
#define I2S_CTRL_DATA_FORMAT               (1UL << 4)     // I2S data format
#define I2S_CTRL_SLOT_CTRL                 (1UL << 5)     // I2S slot ctrl
#define I2S_CTRL_BCLK_FS_CTRL              (1UL << 6)     // I2S bclk fs ctrl
#define I2S_CTRL_DMA_CTRL                  (1UL << 7)     // I2S dma ctrl
#define I2S_CTRL_INT_CTRL                  (1UL << 8)     // I2S int ctrl
#define I2S_CTRL_TIMEOUT_CYCLE             (1UL << 9)     // I2S timeout cycle
#define I2S_CTRL_STATUS                    (1UL << 10)    // I2S status
#define I2S_CTRL_I2SCTL                    (1UL << 11)    // I2S control
#define I2S_CTRL_AUTO_CG_CTRL              (1UL << 12)    // I2S auto cg ctrl
#define I2S_CTRL_INIT                      (1UL << 13)    // I2S init
#define I2S_CTRL_START_STOP                (1UL << 14)    // I2S audio play start/stop ctrl 

#ifdef __cplusplus
}
#endif

#endif /* BSP_I2S_H */
