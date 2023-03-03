#ifndef  BSP_H
#define  BSP_H

#ifdef __cplusplus
extern "C" {
#endif
#include "version.h"
#include "Driver_Common.h"
#include "Driver_I2C.h"
#include "Driver_SPI.h"
#include "Driver_USART.h"
#include "RTE_Device.h"
#include "pad.h"
#include "gpio.h"
#include "ic.h"
#include "dma.h"
#include "clock.h"

#define STRING_EOL      "\r\n"
#define BOARD_NAME      "EC618_EVK"

#define SDK_VERSION     "EC618_SW_V"SDK_MAJOR_VERSION"."SDK_MINOR_VERSION"."SDK_PATCH_VERSION
#define EVB_VERSION     "EC618_HW_V"EVB_MAJOR_VERSION"."EVB_MINOR_VERSION
#define VERSION_INFO    "-- SDK Version: "SDK_VERSION" -- "STRING_EOL"-- EVB Version: "EVB_VERSION" -- "STRING_EOL

#define BSP_HEADER       STRING_EOL"-- Board: "BOARD_NAME " -- "STRING_EOL \
                         VERSION_INFO \
                        "-- Compiled: "__DATE__" "__TIME__" -- "STRING_EOL

#define ATI_VERSION_INFO       STRING_EOL"-- Board: "BOARD_NAME " -- "STRING_EOL \
                               "-- SDK Version: "SDK_VERSION" -- "STRING_EOL

#define SOFTVERSION     "V"SDK_MAJOR_VERSION"."SDK_MINOR_VERSION"."SDK_PATCH_VERSION


#define CREATE_SYMBOL(name, port) name##port

/** @brief UART port index
 * | UART port | Hardware Flow Control |
 * |-----------|-----------------------|
 * |  UART0    |           Y           |
 * |  UART1    |           Y           |
 * |  UART2    |           N           |
 */
typedef enum usart_port
{
    PORT_USART_0,                           /**< USART port 0. */
    PORT_USART_1,                           /**< USART port 1. */
    PORT_USART_2,                           /**< USART port 2. */
    PORT_USART_MAX,                         /**< The total number of USART ports (invalid UART port number). */
    PORT_USART_INVALID                     /**< USART invalid. */
} usart_port_t;

extern ARM_DRIVER_USART *UsartPrintHandle;
extern ARM_DRIVER_USART *UsartUnilogHandle;
extern ARM_DRIVER_USART *UsartAtCmdHandle;

/** @brief IRQ Callback functions
 */
typedef void (*IRQ_Callback_t)();


uint8_t* getBuildInfo(void);
uint8_t* getATIVersionInfo(void);
uint8_t* getVersionInfo(void);
void FlushUnilogOutput(void);
void SetUnilogUart(usart_port_t port, uint32_t baudrate, bool startRecv);
void BSP_CommonInit(void);
void setOSState(uint8_t state);
uint8_t * getDebugDVersion(void);
void delay_us(uint32_t us);

#ifdef __cplusplus
}
#endif

#endif /* BSP_H */
