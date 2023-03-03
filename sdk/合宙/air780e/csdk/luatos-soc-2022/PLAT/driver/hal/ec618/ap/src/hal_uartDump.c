/****************************************************************************
 *
 * Copy right:   2022-, Copyrigths of AirM2M Ltd.
 * File name:    hal_uartDump.c
 * Description:  source file for dumping info through UART when exception occurs
 *               Damn it, too many dependencies are pulled into this module
 * History:      Rev1.0   2022-1-17
 *
 ****************************************************************************/

#include "uart.h"
#include "bsp_usart.h"
#include "bsp_lpusart.h"
#include "plat_config.h"
#include "apmu_external.h"

// Doesn't matter this variable is initialized or not since it'll be set in HAL_UartDumpPortInit
static uint8_t gCurrentUartDumpPort = 0xFF;

void HAL_UartDumpPortInit(void)
{
#ifdef __USER_CODE__

#else
    uint32_t uartDumpPort = BSP_GetPlatConfigItemValue(PLAT_CONFIG_ITEM_UART_DUMP_PORT);
    uint32_t uartBaudRate = 0;

#if RTE_UART0 == 1
    extern ARM_DRIVER_USART Driver_USART0;
#endif

#if RTE_UART1 == 1
    extern ARM_DRIVER_USART Driver_USART1;
    extern ARM_DRIVER_USART Driver_LPUSART1;
#endif

#if RTE_UART2 == 1
    extern ARM_DRIVER_USART Driver_USART2;
#endif

    switch(uartDumpPort)
    {
        case 0:

#if RTE_UART0 == 1
            uartBaudRate = Driver_USART0.GetBaudRate();
#endif

            // Means uart has already been initialized
            if((apmuGetImageType() == 1) && (uartBaudRate != 0))
            {
                UART_init(0, uartBaudRate, false);
                gCurrentUartDumpPort = uartDumpPort;
            }
            else
            {
                // Add custom setting(pinmux & baudrate) here !!!!!!
#if 0
                PadConfig_t config;
                PAD_getDefaultConfig(&config);

                config.mux = RTE_UART0_TX_FUNC;

                config.pullSelect = PAD_PULL_INTERNAL;
                config.pullUpEnable = PAD_PULL_UP_ENABLE;
                config.pullDownEnable = PAD_PULL_DOWN_DISABLE;

                PAD_setPinConfig(RTE_UART0_TX_BIT, &config);

                UART_init(0, 115200, false);

                gCurrentUartDumpPort = uartDumpPort;
#endif
            }

        break;

        case 1:

#if RTE_UART1 == 1
            if(apmuGetImageType() == 1)
            {
                uartBaudRate = Driver_USART1.GetBaudRate();

                if(uartBaudRate == 0)
                {
                    uartBaudRate = Driver_LPUSART1.GetBaudRate();
                }
            }
#endif
            // Means uart has already been initialized
            if((apmuGetImageType() == 1) && (uartBaudRate != 0))
            {
                UART_init(1, uartBaudRate, false);

                gCurrentUartDumpPort = uartDumpPort;
            }
            else
            {
                // Add custom setting(pinmux & baudrate) here !!!!!!
#if 0
                PadConfig_t config;
                PAD_getDefaultConfig(&config);

                config.mux = RTE_UART1_TX_FUNC;

                config.pullSelect = PAD_PULL_INTERNAL;
                config.pullUpEnable = PAD_PULL_UP_ENABLE;
                config.pullDownEnable = PAD_PULL_DOWN_DISABLE;

                PAD_setPinConfig(RTE_UART1_TX_BIT, &config);

                UART_init(1, 115200, false);

                gCurrentUartDumpPort = uartDumpPort;
#endif
            }

        break;

        case 2:

#if RTE_UART2 == 1
            uartBaudRate = Driver_USART2.GetBaudRate();
#endif
            // Means uart has already been initialized
            if((apmuGetImageType() == 1) && (uartBaudRate != 0))
            {
                UART_init(2, uartBaudRate, false);

                gCurrentUartDumpPort = uartDumpPort;
            }
            else
            {
                // Add custom setting(pinmux & baudrate) here !!!!!!
#if 0
                PadConfig_t config;
                PAD_getDefaultConfig(&config);

                config.mux = RTE_UART2_TX_FUNC;

                config.pullSelect = PAD_PULL_INTERNAL;
                config.pullUpEnable = PAD_PULL_UP_ENABLE;
                config.pullDownEnable = PAD_PULL_DOWN_DISABLE;

                PAD_setPinConfig(RTE_UART2_TX_BIT, &config);

                UART_init(2, 115200, false);

                gCurrentUartDumpPort = uartDumpPort;

#endif
            }

        break;

        // means uart dump function is disabled
        default:

            gCurrentUartDumpPort = 0xFF;

        return;
    }
#endif
}


/**
  \brief Check validation of uart dump port
  \return  true if current dump port is valid, otherwise false
  */
bool HAL_UartDumpPortCheck(void)
{
    return (gCurrentUartDumpPort < USART_INSTANCE_NUM) ? true : false;
}

/**
  \brief Send data to uart dump port in polling way
  \param[in]   data        Pointer to buffer with data to be sent to
  \param[in]   num         Number of data items to send
  \param[in]   timeout_us  timeout value in unit of us
  \return      num of data items sent in the internal of timeout
  */
uint32_t HAL_UartDumpPortSend(const uint8_t *data, uint32_t num, uint32_t timeout_us)
{
    if(gCurrentUartDumpPort < USART_INSTANCE_NUM)
    {
        return UART_send(gCurrentUartDumpPort, data, num, timeout_us);
    }
    else
    {
        return 0;
    }
}


