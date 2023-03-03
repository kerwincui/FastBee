#ifndef  BSP_LPUSART_H
#define  BSP_LPUSART_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdio.h>
#include <string.h>
#include "ec618.h"
#include "bsp.h"


// LPUSART flags
#define LPUSART_FLAG_INITIALIZED          (1U << 0)     // LPUSARTinitialized
#define LPUSART_FLAG_POWER_FULL           (1U << 1)     // LPUSART powered FULL
#define LPUSART_FLAG_POWER_LOW            (1U << 2)     // LPUSART powered LOW
#define LPUSART_FLAG_CONFIGURED           (1U << 3)     // LPUSART configured
#define LPUSART_FLAG_TX_ENABLED           (1U << 4)     // LPUSART TX enabled
#define LPUSART_FLAG_RX_ENABLED           (1U << 5)     // LPUSART RX enabled
#define LPUSART_FLAG_SEND_ACTIVE          (1U << 6)     // LPUSART send active

#define LPUSART_FLAG_POWER_MSK            (LPUSART_FLAG_POWER_LOW | LPUSART_FLAG_POWER_FULL)

// LPUSART IRQ
typedef const struct _LPUSART_IRQ {
  IRQn_Type             irq_num;         // LPUSART IRQ Number
  IRQ_Callback_t        cb_irq;
} LPUSART_IRQ;

// LPUSART TX DMA
typedef struct _LPUSART_TX_DMA {
  DmaInstance_e         instance;                               //  DMA instance
  int8_t                channel;                                //  Channel number
  uint8_t               request;                                //  DMA request number
  void                  (*callback)(uint32_t event);            //  Tx callback
} LPUSART_TX_DMA;

// LPUSART RX DMA
typedef struct _LPUSART_RX_DMA {
  DmaInstance_e         instance;                               //  DMA instance
  int8_t                channel;                                //  Channel number
  uint8_t               request;                                //  DMA request number
  DmaDescriptor_t      *descriptor;                             //  Rx descriptor
  void                  (*callback)(uint32_t event);            //  Rx callback
} LPUSART_RX_DMA;

// LPUSART PINS
typedef const struct _LPUSART_PIN {
  const PIN               *pin_tx;                                //  TX Pin identifier
  const PIN               *pin_rx;                                //  RX Pin identifier
  const PIN               *pin_cts;                               //  CTS Pin identifier
  const PIN               *pin_rts;                               //  RTS Pin identifier
} LPUSART_PINS;


typedef struct _LPUSART_TRANSFER_INFO {
  uint32_t              rx_num;         // Total number of receive data
  uint32_t              tx_num;         // Total number of transmit data
  uint8_t              *rx_buf;         // Pointer to in data buffer
  uint8_t              *tx_buf;         // Pointer to out data buffer
  uint32_t              rx_cnt;         // Number of data received
  uint32_t              tx_cnt;         // Number of data sent
  uint16_t              tx_def_val;     // Default transmit value
  uint16_t              rx_dump_val;    // Receive dump value
  uint8_t               send_active;    // Send active flag
  uint32_t              sync_mode;      // Synchronous mode flag
} LPUSART_TRANSFER_INFO;

typedef struct _LPUSART_STATUS {
  uint8_t rx_busy;                      // Receiver busy flag
  uint8_t rx_dma_triggered;             // Receive DMA transfer triggered (cleared on start of next receive operation)
  uint8_t rx_overflow;                  // Receive data overflow detected (cleared on start of next receive operation)
  uint8_t aon_rx_overflow;              // AON FIFO receive data overflow detected (cleared on start of next receive operation)
  uint8_t rx_break;                     // Break detected on receive (cleared on start of next receive operation)
  uint8_t rx_framing_error;             // Framing error detected on receive (cleared on start of next receive operation)
  uint8_t rx_parity_error;              // Parity error detected on receive (cleared on start of next receive operation)
} LPUSART_STATUS;

typedef struct _LPUSART_INFO {
  ARM_USART_SignalEvent_t   cb_event;            // Event Callback
  LPUSART_STATUS            rx_status;           // Recieve Status flags
  LPUSART_TRANSFER_INFO     xfer;                // LPUSART transfer information
  uint8_t                   flags;               // Current LPUSART flags
  uint32_t                  frame_code;          // Current LPUSART frame setting code
  uint32_t                  baudrate;            // Baudrate
} LPUSART_INFO;

// LPUSART Resources definition
typedef const struct {
  USART_TypeDef             *co_usart_regs;         // LPUSART cooperating uart registers pointer
  LPUSARTAON_TypeDef        *aon_regs;              // LPUSART AON part registers pointer
  LPUSARTCORE_TypeDef       *core_regs;             // LPUSART CORE part registers pointer
  LPUSART_PINS               pins;                  // LPUSART PINS config
  LPUSART_RX_DMA            *dma_rx;                // LPUSART DMA register interface
  LPUSART_TX_DMA            *co_usart_dma_tx;       // LPUSART DMA register interface
  LPUSART_RX_DMA            *co_usart_dma_rx;       // LPUSART DMA register interface
  LPUSART_IRQ               *irq;                   // LPUSART IRQ
  LPUSART_IRQ               *co_usart_irq;          // LPUSART cooperating uart IRQ
  LPUSART_INFO              *info;                  // Run-Time Information
} LPUSART_RESOURCES;


void LPUSART_ClearStopFlag(void);
void LPUSART_SetStopFlag(void);
/*
 * Check whether rx is ongoing, return true if rx is ongoing at this moment, otherwise false
 */
bool LPUSART_IsRxActive(void);


#ifdef __cplusplus
}
#endif

#endif /* BSP_LPLPUSART_H */
