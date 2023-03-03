 /****************************************************************************
  *
  * Copy right:   2017-, Copyrigths of AirM2M Ltd.
  * File name:    gpio.h
  * Description:  EC618 gpio driver header file
  * History:
  *
  ****************************************************************************/

#ifndef _GPIO_EC618_H
#define _GPIO_EC618_H

#include "ec618.h"
#include "Driver_Common.h"

/**
  \addtogroup gpio_interface_gr
  \{
 */

/*******************************************************************************
 * Definitions
 ******************************************************************************/

/** \brief GPIO pin direction */
typedef enum
{
    GPIO_DIRECTION_INPUT  = 0U,  /**< Set pin as input */
    GPIO_DIRECTION_OUTPUT = 1U,  /**< Set pin as output */
} GpioPinDirection_e;

/** \brief GPIO pin interrupt configuration */
typedef enum
{
    GPIO_INTERRUPT_DISABLED     = 0U,  /**< Disable interrupt */
    GPIO_INTERRUPT_LOW_LEVEL    = 1U,  /**< Low-level interrupt */
    GPIO_INTERRUPT_HIGH_LEVEL   = 2U,  /**< High-level interrupt */
    GPIO_INTERRUPT_FALLING_EDGE = 3U,  /**< Falling edge interrupt */
    GPIO_INTERRUPT_RISING_EDGE  = 4U,  /**< Rising edge interrupt */
} GpioInterruptConfig_e;

/** \brief GPIO pin configuration structure */
typedef struct
{
    GpioPinDirection_e pinDirection; /**< GPIO direction, input or output */
    union
    {
        GpioInterruptConfig_e      interruptConfig;   /**< Pin's interrupt configuration, valid when pinDirection is input */
        uint32_t                   initOutput;        /**< Initial pin output value, valid when pinDirection is output*/
    } misc;
} GpioPinConfig_t;

/*******************************************************************************
 * API
 ******************************************************************************/

#if defined(__cplusplus)
extern "C" {
#endif

/** \name GPIO Driver Initialization */
/** \{ */

/**
  \fn    void GPIO_driverInit(void);
  \brief Intialize GPIO driver internal data
  \note  It is not necessarty to call this function before using GPIO driver since it has been
         called in \ref GPIO_pinConfig() api.
 */
void GPIO_driverInit(void);

/**
  \fn    void GPIO_driverDeInit(void);
  \brief De-Intialize GPIO driver, disable GPIO clock and perform some clearups
 */
void GPIO_driverDeInit(void);

/** \} */

/** \name GPIO Configuration */
/** \{ */

/**
  \fn    void GPIO_pinConfig(uint32_t port, uint16_t pin, const GpioPinConfig_t *config);
  \brief Configure a GPIO pin
  \param[in] port    GPIO number (0, 1, ...)
  \param[in] pin     GPIO pin number
  \param[in] config  Pointer to GPIO pin configuration
 */
void GPIO_pinConfig(uint32_t port, uint16_t pin, const GpioPinConfig_t *config);

/**
  \fn    void GPIO_interruptConfig(uint32_t port, uint16_t pin, GpioInterruptConfig_e config);
  \brief Configure a GPIO pin's interrupt type(valid when this pin has been set as input)
  \param[in] port    GPIO number (0, 1, ...)
  \param[in] pin     GPIO pin number
  \param[in] config  GPIO interrupt configuration
 */
void GPIO_interruptConfig(uint32_t port, uint16_t pin, GpioInterruptConfig_e config);

/** \} */

/** \name GPIO Output Operations */
/** \{ */

/**
  \fn    void GPIO_pinWrite(uint32_t port, uint16_t pinMask, uint16_t output);
  \brief Sets output level of multiple GPIO pins to logic 1 or 0

  \code
  Example to set bits[15,1:0] to 1 and clear bits[12:11, 7:6]

  // pinMask shall be b10011000 11000011 = 0x98C3
  // output shall be  b10000000 00000011 = 0x8003
  GPIO_pinWrite(0, 0x98C3, 0x8003);
  // To set a single pin, let's say, pin 12 of GPIO0
  GPIO_pinWrite(0, 1 << 12, 1 << 12);
  // To clear a single pin, let's say, pin 12 of GPIO0
  GPIO_pinWrite(0, 1 << 12, 0);

  \endcode

  \param[in] port        GPIO number (0, 1, ...)
  \param[in] pinMask     GPIO pin mask to set
  \param[in] output      GPIO pin output logic level.
          - 0: corresponding pin output low-logic level.
          - 1: corresponding pin output high-logic level.
 */
void GPIO_pinWrite(uint32_t port, uint16_t pinMask, uint16_t output);

/** \} */

/** \name GPIO Input Operations */
/** \{ */

/**
  \fn    uint32_t GPIO_pinRead(uint32_t port, uint16_t pin)
  \brief Reads current input value of GPIO specific pin
  \param[in] port    GPIO number (0, 1, ...)
  \param[in] pin     GPIO pin number
  \return            GPIO corresponding pin input value
 */
uint32_t GPIO_pinRead(uint32_t port, uint16_t pin);

/** \} */

/** \name GPIO Interrupt */
/** \{ */

/**
  \fn    uint16_t GPIO_getInterruptFlags(uint32_t port)
  \brief Reads GPIO port interrupt status flags
  \param[in]  port    GPIO number (0, 1, ...)
  \return     current GPIO interrupt status flag
 */
uint16_t GPIO_getInterruptFlags(uint32_t port);

/**
  \fn    void GPIO_clearInterruptFlags(uint32_t port, uint16_t mask)
  \brief Clears multiple GPIO pin interrupt status flags
  \param[in] port    GPIO number (0, 1, ...)
  \param[in] mask    GPIO pin number macro
 */
void GPIO_clearInterruptFlags(uint32_t port, uint16_t mask);

/**
  \fn    uint16_t GPIO_saveAndSetIrqMask(uint32_t port)
  \brief Reads GPIO port interrupt enable mask and diables whole port interrupts
  \param[in]  port    GPIO number (0, 1, ...)
  \return     current GPIO port interrupt enable mask
  \note  Used in GPIO ISR to disable GPIO interrupts temporarily
 */
uint16_t GPIO_saveAndSetIrqMask(uint32_t port);

/**
  \fn    void GPIO_restoreIrqMask(uint32_t port, uint16_t mask)
  \brief Restore GPIO port interrupt enable setting
  \param[in]  port    GPIO number (0, 1, ...)
  \param[in]  mask    GPIO interrupt enable mask
  \note  Used in GPIO ISR to restore GPIO enable setting upon exit
 */
void GPIO_restoreIrqMask(uint32_t port, uint16_t mask);

/** \} */

/** \} */

#ifdef __cplusplus
}
#endif

#endif /* _GPIO_EC618_H */
