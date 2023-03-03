/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: uart_device.h
*
*  Description:
*
*  History: 2021/1/19 created by xuwang
*
*  Notes:
*
******************************************************************************/
#ifndef UART_DEVICE_H
#define UART_DEVICE_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include <stdint.h>
#include "Driver_USART.h"
#include "ccio_pub.h"

#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/

/** \brief configuration struct for initializing UART hardware */
typedef struct
{
    ARM_POWER_STATE    powerMode;       /**< UART power mode, ARM_POWER_FULL or ARM_POWER_LOW */
    uint32_t           ctrlSetting;     /**< setting value passed to ARM Control API */
    uint32_t           baudRate;        /**< baudrate value */
}UartHwConf_t;

/**
 * configuration about a uart device.
 */
typedef struct
{
    UartHwConf_t       hwConf;
    ARM_DRIVER_USART  *drvHandler;      /**< uart driver handler */
    uint8_t            mainUsage;       /**< refer to 'CsioDevType_e' */
    uint8_t            speedType;       /**< refer to 'CcioSpeedType_e' */
    uint8_t            bmCreateFlag;    /**< refer to 'CcioTaskOperFlag_e', bitmap type */
    uint8_t            isDftAtPort :1;  /* < default uartIdx for AT or not */
    uint8_t            rsvd :7;
}UartDevConf_t;


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
/**
 * @brief uartDevCreate(uint32_t uartIdx, UartDevConf_t *uartConf)
 * @details create a uart device of 'uartIdx'
 *
 * @param uartIdx   The index of uart port
 * @param uartConf  The configuration about a uart device
 * @return NULL failure; !NULL the created uart device.
 */
CcioDevice_t* uartDevCreate(uint32_t uartIdx, UartDevConf_t *uartConf);

/**
 * @brief uartDevDestroy(uint32_t uartIdx)
 * @details destroy/delete a uart device of 'uartIdx'
 *
 * @param uartIdx index of uart port
 * @return 0 succ; < 0 failure with errno.
 */
int32_t uartDevDestroy(uint32_t uartIdx);


#ifdef __cplusplus
}
#endif
#endif

