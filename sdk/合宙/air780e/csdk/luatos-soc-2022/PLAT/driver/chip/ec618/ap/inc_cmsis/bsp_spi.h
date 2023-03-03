#ifndef  BSP_SPI_H
#define  BSP_SPI_H

#ifdef __cplusplus
extern "C" {
#endif
#include "stdio.h"
#include "string.h"
#include "ec618.h"
#include "bsp.h"


// SPI flags
#define SPI_FLAG_INITIALIZED          (1UL << 0)     // SPI initialized
#define SPI_FLAG_POWERED              (1UL << 1)     // SPI powered on
#define SPI_FLAG_CONFIGURED           (1UL << 2)     // SPI configured
#define SPI_FLAG_DATA_LOST            (1UL << 3)     // SPI data lost occurred
#define SPI_FLAG_MODE_FAULT           (1UL << 4)     // SPI mode fault occurred

// SPI IRQ
typedef const struct _SPI_IRQ {
  IRQn_Type             irq_num;        // SPI IRQ Number
  IRQ_Callback_t        cb_irq;
} SPI_IRQ;

// SPI DMA
typedef struct _SPI_DMA {
  DmaInstance_e         tx_instance;                            // Transmit DMA instance number
  int8_t                tx_ch;                                  // Transmit channel number
  uint8_t               tx_req;                                 // Transmit DMA request number
  void                  (*tx_callback)(uint32_t event);         // Transmit callback
  DmaInstance_e         rx_instance;                            // Receive DMA instance number
  int8_t                rx_ch;                                  // Receive channel number
  uint8_t               rx_req;                                 // Receive DMA request number
  void                  (*rx_callback)(uint32_t event);         // Receive callback
} SPI_DMA;

// SPI PINS
typedef const struct _SPI_PIN {
  const PIN               *pin_sclk;                                //  SCLK Pin identifier
  const PIN               *pin_ssn;                                 //  SSn Pin identifier
  const PIN               *pin_mosi;                                //  MOSI Pin identifier
  const PIN               *pin_miso;                                //  MISO Pin identifier
} SPI_PINS;

typedef struct _SPI_STATUS {
  uint8_t busy;                         // Transmitter/Receiver busy flag
  uint8_t data_lost;                    // Data lost: Receive overflow / Transmit underflow (cleared on start of transfer operation)
  uint8_t mode_fault;                   // Mode fault detected; optional (cleared on start of transfer operation)
} SPI_STATUS;

// SPI Transfer Information (Run-Time)
typedef struct _SPI_TRANSFER_INFO {
  uint32_t              num;            // Total number of transfers
  uint8_t              *rx_buf;         // Pointer to in data buffer
  uint8_t              *tx_buf;         // Pointer to out data buffer
  uint32_t              rx_cnt;         // Number of data received
  uint32_t              tx_cnt;         // Number of data sent
  uint32_t              dump_val;       // Variable for dumping DMA data
  uint16_t              def_val;        // Default transfer value
} SPI_TRANSFER_INFO;

// SPI information (Run-time)
typedef struct _SPI_INFO {
    ARM_SPI_SignalEvent_t cb_event;     // event callback
    SPI_STATUS            status;       // SPI status flags
    SPI_TRANSFER_INFO     xfer;         // SPI transfer information
    uint8_t               flags;        // SPI driver flags
    uint32_t              mode;         // SPI mode
    uint32_t              bus_speed;    // SPI bus speed
    uint8_t               data_width;   // SPI data bits select in unit of byte
} SPI_INFO;


// SPI Resources definition
typedef struct {
  SPI_TypeDef                 *reg;                  // SPI register pointer
  SPI_PINS                     pins;                 // SPI PINS configuration
  SPI_DMA                     *dma;                  // SPI DMA configuration pointer
  SPI_IRQ                     *irq;                  // SPI IRQ configuration pointer
  SPI_INFO                    *info;                 // Run-Time Information
} SPI_RESOURCES;


#ifdef __cplusplus
}
#endif

#endif /* BSP_SPI_H */
