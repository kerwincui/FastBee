#ifndef  BSP_CSPI_H
#define  BSP_CSPI_H

#ifdef __cplusplus
extern "C" {
#endif
#include "stdio.h"
#include "string.h"
#include "ec618.h"
#include "bsp.h"

#define CSPI_TRANSFER_TRUNK_SIZE               7680    ///< Each DMA descriptor data size, fixed to 7680byte 


typedef void (*cspiCbEvent_fn) (uint32_t event);            ///< cspi callback event.


/** \brief CSPI flags */
#define CSPI_FLAG_INITIALIZED       (1UL << 0)                  ///< CSPI initialized
#define CSPI_FLAG_POWERED           (1UL << 1)                  ///< CSPI powered on


/** \brief CSPI DMA */
typedef struct 
{
  DmaInstance_e                     rxInstance;                 ///< Receive DMA instance number
  int8_t                            rxCh;                       ///< Receive channel number
  uint8_t                           rxReq;                      ///< Receive DMA request number
  void                              (*rxCb)(uint32_t event);    ///< Receive callback
  DmaDescriptor_t                   *descriptor;                ///< Rx descriptor
} cspiDma_t;

// CSPI PINS
typedef const struct
{
  PIN                               *mclk;   ///< Main clk Pin identifier
  PIN                               *pclk;   ///< Pixel clk Pin identifier
  PIN                               *cs;     ///< Cs Pin identifier
  PIN                               *sdo0;   ///< Din Pin identifier
  PIN                               *sdo1;   ///< Dout Pin identifier
} cspiPins_t;

typedef struct
{
  uint8_t busy;                              ///< Transmitter/Receiver busy flag
} cspiRteStats_t;

typedef enum
{
	CAM_8W		= 10, ///< 8w use 10 dma descriptor chain
	CAM_30W		= 40, ///< 30w use 40 dma descriptor chain
}camResolution_e;

typedef enum
{
	CAM_6_5_M	= 0,  ///< camera 6.5M HZ
	CAM_13_M	= 1,  ///< camera 13M HZ
	CAM_25_5_M	= 2,  ///< camera 25.5M HZ
	CAM_24_M	= 3,  ///< camera 24M HZ
	CAM_20_M	= 4,  ///< camera 20M HZ
}camFrequence_e;


// CSPI information (Run-time)
typedef struct 
{
    cspiCbEvent_fn                  cbEvent;        ///< Event callback
    cspiRteStats_t                  status;         ///< CSPI status flags
    uint8_t                         flags;          ///< CSPI driver flags
    uint32_t                        busSpeed;       ///< CSPI bus speed
    uint8_t                         dataWidth;      ///< CSPI data bits select in unit of byte
    uint32_t    					targetAddr;		///< CSPI target address 
    camResolution_e 				resolution;		///< Camera resolution
} cspiInfo_t;


// SPI Resources definition
typedef struct 
{
  CSPI_TypeDef                      *reg;           ///< SPI register pointer
  cspiPins_t                        pins;           ///< SPI PINS configuration
  cspiDma_t                         *dma;           ///< SPI DMA configuration pointer
  cspiInfo_t                        *info;          ///< Run-Time Information
} cspiRes_t;


/**
\brief General power states
*/
typedef enum 
{
    CSPI_POWER_OFF,                                  ///< Power off: no operation possible
    CSPI_POWER_FULL                                  ///< Power on: full operation at maximum performance
} cspiPowerState_e;

typedef struct
{
    uint32_t slaveModeEn            : 1;            ///< Slave Mode Enable
    uint32_t slotSize               : 5;            ///< Slot Size
    uint32_t wordSize               : 5;            ///< Word Size
    uint32_t alignMode              : 1;            ///< Align Mode
    uint32_t endianMode             : 1;            ///< Endian Mode
    uint32_t dataDly                : 2;            ///< Data Delay 
    uint32_t txPad                  : 2;            ///< Tx padding 
    uint32_t rxSignExt              : 1;            ///< Rx Sign Entension
    uint32_t txPack                 : 2;            ///< Tx Pack
    uint32_t rxPack                 : 2;            ///< Rx Pack
    uint32_t txFifoEndianMode       : 1;            ///< Tx Fifo Endian Mode
    uint32_t rxFifoEndianMode       : 1;            ///< Rx Fifo Endian Mode
}cspiDataFmt_t;

typedef struct
{
    uint32_t slotEn                 : 3;            ///< Slot Enable
    uint32_t slotNum                : 8;            ///< Slot Num
}cspiSlotCtrl_t;

typedef struct
{
    uint32_t bclkPolarity           : 1;            ///< Bclk Polarity 
    uint32_t fsPolarity             : 1;            ///< Frame Synchronization Polarity
    uint32_t fsWidth                : 6;            ///< Frame Synchronization Width
}cspiBclkFsCtrl_t;

typedef struct
{
    uint32_t rxDmaReqEn             : 1;            ///< Rx Dma Req Enable 
    uint32_t txDmaReqEn             : 1;            ///< Tx Dma Req Enable
    uint32_t rxDmaTimeOutEn         : 1;            ///< Rx Dma Timeout Enable
    uint32_t dmaWorkWaitCycle       : 5;            ///< Dma Work Wait Cycle
    uint32_t rxDmaBurstSizeSub1     : 4;            ///< Rx Dma Burst Size subtract 1
    uint32_t txDmaBurstSizeSub1     : 4;            ///< Tx Dma Burst Size subtract 1
    uint32_t rxDmaThreadHold        : 4;            ///< Rx Dma Threadhold
    uint32_t txDmaThreadHold        : 4;            ///< Tx Dma Threadhold
    uint32_t rxFifoFlush            : 1;            ///< Rx Fifo flush
    uint32_t txFifoFlush            : 1;            ///< Tx Fifo flush
}cspiDmaCtrl_t;

typedef struct
{
    uint32_t txUnderRunIntEn        : 1;            ///< Tx Underrun interrupt Enable
    uint32_t txDmaErrIntEn          : 1;            ///< Tx Dma Err Interrupt Enable
    uint32_t txDatIntEn             : 1;            ///< Tx Data Interrupt Enable
    uint32_t rxOverFlowIntEn        : 1;            ///< Rx Overflow Interrupt Enable
    uint32_t rxDmaErrIntEn          : 1;            ///< Rx Dma Err Interrupt Enable
    uint32_t rxDatIntEn             : 1;            ///< Rx Data Interrupt Enable
    uint32_t rxTimeOutIntEn         : 1;            ///< Rx Timeout Interrupt Enable
    uint32_t fsErrIntEn             : 1;            ///< Frame Start Interrupt Enable
    uint32_t frameStartIntEn        : 1;            ///< Frame End Interrupt Enable
    uint32_t frameEndIntEn          : 1;            ///< Frame End Interrupt Enable
    uint32_t cspiBusTimeOutIntEn    : 1;            ///< Not use
    uint32_t txIntThreshHold        : 4;            ///< Tx Interrupt Threadhold 
    uint32_t rxIntThreshHold        : 4;            ///< Rx Interrupt Threadhold
}cspiIntCtrl_t;

typedef struct
{
    uint32_t rxTimeOutCycle         : 24;           ///< Rx Timeout Cycle
}cspiTimeOutCycle_t;


typedef struct
{
    uint32_t txUnderRun             : 1;            ///< Tx Underrun
    uint32_t txDmaErr               : 1;            ///< Tx Dma Err
    uint32_t txDataRdy              : 1;            ///< Tx Data ready, readOnly
    uint32_t rxOverFlow             : 1;            ///< Rx OverFlow
    uint32_t rxDmaErr               : 1;            ///< Rx Dma Err
    uint32_t rxDataRdy              : 1;            ///< Rx Data ready, readOnly
    uint32_t rxFifoTimeOut          : 1;            ///< Rx Fifo timeout
    uint32_t fsErr                  : 4;            ///< Frame synchronization Err
    uint32_t frameStart             : 1;            ///< Frame start
    uint32_t frameEnd               : 1;            ///< Frame end
    uint32_t txFifoLevel            : 6;            ///< Tx Fifo Level, readOnly
    uint32_t rxFifoLevel            : 6;            ///< Rx Fifo level, readOnly
    uint32_t cspiBusTimeOut         : 1;            ///< Cspi Bus timeout
}cspiStats_t;

typedef struct
{
    uint32_t enable                 : 1;            ///< Enable
    uint32_t csEn                   : 1;            ///< CS signal check
    uint32_t rxWid                  : 1;            ///< Rx Width
    uint32_t rxdSeq                 : 1;            ///< Rx Sequence
    uint32_t cpol                   : 1;            ///< SPI polarity
    uint32_t cpha                   : 1;            ///< SPI phase
    uint32_t frameProcEn            : 1;            ///< Frame Process Enable
    uint32_t fillYonly              : 1;            ///< Fill Y Only
    uint32_t hwInitEn               : 1;            ///< HW Init Enable
    uint32_t lsCheckEn              : 1;            ///< Line Start Check Enable
    uint32_t dpCheckEn              : 1;            ///< Data Pcket Check Enable
    uint32_t frameProcInitEn        : 1;            ///< Frame Process Init Enable
    uint32_t rowScaleRatio          : 4;            ///< Row Scale Ratio
    uint32_t colScaleRatio          : 4;            ///< Column Scale Ratio
    uint32_t scaleBytes             : 2;            ///< Scale Bytes
}cspiCtrl_t;

typedef struct
{
    uint32_t autoCgEn               : 1;            ///< Auto Configure Enable
}cspiAutoCgCtrl_t;

typedef struct
{
    uint32_t cspiBusTimeOutCycle    : 24;           ///< Cspi Bus Timeout Cycle
    uint32_t dataId                 : 8;            ///< Data Indication, readOnly
}cspiFrameInfo0_t;


typedef struct
{
    uint32_t cspiInit               : 1;            ///< Cspi Init
}cspiInit_t;





/**
\brief Cspi control bits.
*/
#define CSPI_CTRL_TRANSABORT                (1UL << 0)     ///< CSPI trans abort
#define CSPI_CTRL_BUS_SPEED                 (1UL << 1)     ///< CSPI trans abort
#define CSPI_CTRL_DATA_BITS                 (1UL << 2)     ///< CSPI trans abort
#define CSPI_CTRL_DATA_FORMAT               (1UL << 3)     ///< CSPI data format
#define CSPI_CTRL_SLOT_CTRL                 (1UL << 4)     ///< CSPI slot ctrl
#define CSPI_CTRL_BCLK_FS_CTRL              (1UL << 5)     ///< CSPI bclk fs ctrl
#define CSPI_CTRL_DMA_CTRL                  (1UL << 6)     ///< CSPI dma ctrl
#define CSPI_CTRL_INT_CTRL                  (1UL << 7)     ///< CSPI int ctrl
#define CSPI_CTRL_TIMEOUT_CYCLE             (1UL << 8)     ///< CSPI timeout cycle
#define CSPI_CTRL_STATUS                    (1UL << 9)     ///< CSPI status
#define CSPI_CTRL_CSPICTL                   (1UL << 10)    ///< CSPI control
#define CSPI_CTRL_AUTO_CG_CTRL              (1UL << 11)    ///< CSPI auto cg ctrl
#define CSPI_CTRL_FRAME_INFO0               (1UL << 12)    ///< CSPI frame info0
#define CSPI_CTRL_INIT                      (1UL << 13)    ///< CSPI init
#define CSPI_CTRL_RXTOR                     (1UL << 14)    ///< CSPI rx timeout cycle
#define CSPI_CTRL_MEM_ADDR                  (1UL << 15)    ///< CSPI memory addr set
#define CSPI_CTRL_FLUSH_RX_FIFO             (1UL << 16)    ///< Flush rx fifo
#define CSPI_CTRL_START_STOP           		(1UL << 17)    ///< Start or stop cspi
#define CSPI_CTRL_RESOLUTION_SET            (1UL << 18)    ///< Camera resolution set



/**
\brief Access structure of the CSPI Driver.
*/
typedef struct 
{
  int32_t              (*init)            (cspiCbEvent_fn cb_event);          ///< Initialize CSPI Interface.
  int32_t              (*deInit)          (void);                             ///< De-initialize CSPI Interface.
  int32_t              (*powerCtrl)       (cspiPowerState_e state);           ///< Control CSPI Interface Power.
  int32_t              (*recv)            (void);         					  ///< Open dma to receive data.
  int32_t              (*ctrl)            (uint32_t control, uint32_t arg);   ///< Control CSPI Interface.
} const cspiDrvInterface_t;



#ifdef __cplusplus
}
#endif
#endif

