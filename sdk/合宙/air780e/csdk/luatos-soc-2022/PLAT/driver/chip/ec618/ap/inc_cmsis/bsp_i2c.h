#ifndef  BSP_I2C_H
#define  BSP_I2C_H

#ifdef __cplusplus
extern "C" {
#endif

#include "stdio.h"
#include "string.h"
#include "ec618.h"
#include "bsp.h"


// I2C Driver state flags
#define I2C_FLAG_INIT        BIT(0)        // Driver initialized
#define I2C_FLAG_POWER       BIT(1)        // Driver power on
#define I2C_FLAG_SETUP       BIT(2)        // Master configured, clock set
#define I2C_FLAG_MASTER_TX   BIT(3)        // Master tx
#define I2C_FLAG_MASTER_RX   BIT(4)        // Master rx
#define I2C_FLAG_SLAVE_TX    BIT(5)        // Slave  tx
#define I2C_FLAG_SLAVE_RX    BIT(6)        // Slave  rx

#define  I2C_NO_STARTSTOP               (0x00000000U)
#define  I2C_GENERATE_STOP              (I2C_SCR_STOP_Msk)
#define  I2C_GENERATE_START_READ        (I2C_SCR_START_Msk | I2C_SCR_TARGET_RWN_Msk)
#define  I2C_GENERATE_START_WRITE       (I2C_SCR_START_Msk)
#define  I2C_GENERATE_RESTART_READ      (I2C_SCR_RESTART_Msk | I2C_SCR_TARGET_RWN_Msk)
#define  I2C_GENERATE_RESTART_WRITE     (I2C_SCR_RESTART_Msk)


#define I2C_MEMADD_SIZE_8BIT            (0x00000001U)
#define I2C_MEMADD_SIZE_16BIT           (0x00000002U)

#define I2C_AUTOMATIC_MODE1              (0x01)    // byte_num_unknown = 0
#define I2C_AUTOMATIC_MODE2              (0x02)    // byte_num_unknown = 1
#define I2C_DEDICATED_MODE               (0x03)

// I2C IRQ
typedef const struct _I2C_IRQ {
  IRQn_Type             irq_num;         // I2C IRQ Number
  IRQ_Callback_t        cb_irq;
} I2C_IRQ;

// I2C PINS
typedef const struct _I2C_PIN {
  PIN               *pin_scl;                                //  SCL Pin identifier
  PIN               *pin_sda;                                //  SDA Pin identifier
} I2C_PINS;

// I2C DMA
typedef struct _I2C_DMA {
  DmaInstance_e         tx_instance;                            // Transmit DMA instance
  int8_t                tx_ch;                                  // Transmit channel number
  uint8_t               tx_req;                                 // Transmit DMA request number
  void                  (*tx_callback)(uint32_t event);         // Transmit callback
  DmaInstance_e         rx_instance;                            // Receive DMA instance
  int8_t                rx_ch;                                  // Receive channel number
  uint8_t               rx_req;                                 // Receive DMA request number
  void                  (*rx_callback)(uint32_t event);         // Receive callback
} I2C_DMA;


// I2C Control Information
typedef struct {
  ARM_I2C_SignalEvent_t cb_event;           // Event callback
  ARM_I2C_STATUS        status;             // Status flags
  uint8_t               flags;              // Control and state flags
  uint8_t               sla_rw;             // Slave address and RW bit
  bool                  pending;            // Transfer pending (no STOP)
  uint8_t               stalled;            // Stall mode status flags
  uint8_t               con_aa;             // I2C slave CON flag
  uint32_t              cnt;                // Master transfer count
  uint8_t              *data;               // Master data to transfer
  uint32_t              num;                // Number of bytes to transfer
  uint8_t              *sdata;              // Slave data to transfer
  uint32_t              snum;               // Number of bytes to transfer
} I2C_CTRL;


// I2C Resources definition
typedef struct {
  I2C_TypeDef                 *reg;                  // I2C peripheral register interface
  I2C_PINS                     pins;                 // I2C PINS config
  I2C_DMA*                     dma;                  // I2C DMA configuration
  I2C_IRQ*                     irq;                  // I2C IRQ
  I2C_CTRL                    *ctrl;                 // Run-Time control information
} const I2C_RESOURCES;

#ifdef __cplusplus
}
#endif

#endif /* BSP_I2C_H */
