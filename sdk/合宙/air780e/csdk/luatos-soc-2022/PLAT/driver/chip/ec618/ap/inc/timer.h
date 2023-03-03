/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    timer.h
 * Description:  EC618 timer driver header file
 * History:
 *
 ****************************************************************************/

#ifndef _TIMER_EC618_H
#define _TIMER_EC618_H

#include "ec618.h"
#include "Driver_Common.h"

/**
  \addtogroup timer_interface_gr
  \{
 */

/*******************************************************************************
 * Definitions
 ******************************************************************************/

/** \brief List of TIMER clock source */
typedef enum
{
    TIMER_INTERNAL_CLOCK  = 0U,  /**< Internal clock */
    TIMER_EXTERNAL_CLOCK  = 1U,  /**< External clock */
} TimerClockSource_t;

/** \brief List of TIMER match value select */
typedef enum
{
    TIMER_MATCH0_SELECT    = 0U,  /**< Select Match0 */
    TIMER_MATCH1_SELECT    = 1U,  /**< Select Match1 */
    TIMER_MATCH2_SELECT    = 2U,  /**< Select Match2 */
} TimerMatchSelect_t;

/** \brief List of TIMER reload option, counter will be reloaded to init value upon reach it */
typedef enum
{
    TIMER_RELOAD_DISABLE      = 0U,  /**< Counter will run freely */
    TIMER_RELOAD_ON_MATCH0    = 1U,  /**< Counter will be reloaded on reaching match0 value */
    TIMER_RELOAD_ON_MATCH1    = 2U,  /**< Counter will be reloaded on reaching match1 value */
    TIMER_RELOAD_ON_MATCH2    = 3U,  /**< Counter will be reloaded on reaching match1 value */
} TimerReloadOption_t;

/** \brief PWM configuration structure */
typedef struct
{
    uint32_t pwmFreq_HZ;             /**< PWM signal frequency in HZ */
    uint32_t srcClock_HZ;            /**< TIMER counter clock in HZ */
    uint32_t dutyCyclePercent;       /**< PWM pulse width, the valid range is 0 to 100 */
} TimerPwmConfig_t;

/** \brief TIMER configuration structure */
typedef struct
{
    TimerClockSource_t    clockSource;     /**< Clock source */
    TimerReloadOption_t   reloadOption;    /**< Reload option */
    uint32_t              initValue;       /**< Counter init value */
    uint32_t              match0;          /**< Match0 value */
    uint32_t              match1;          /**< Match1 value */
    uint32_t              match2;          /**< Match2 value */
} TimerConfig_t;

/** \brief TIMER interrupt configuration */
typedef enum
{
    TIMER_INTERRUPT_DISABLED    = 0U,  /**< Disable interrupt */
    TIMER_INTERRUPT_LEVEL       = 1U,  /**< Level interrupt, a high level interrupt signal is generated */
    TIMER_INTERRUPT_PULSE       = 2U,  /**< Pulse interrupt, a pulse of one clock width
                                           is generated after counter matches */
} TimerInterruptConfig_t;


/** \brief List of TIMER interrupts */
typedef enum
{
    TIMER_MATCH0_INTERRUPT_ENABLE  = TIMER_TCTLR_IE_0_Msk,  /**< Match0 interrupt */
    TIMER_MATCH1_INTERRUPT_ENABLE  = TIMER_TCTLR_IE_1_Msk,  /**< Match1 interrupt */
    TIMER_MATCH2_INTERRUPT_ENABLE  = TIMER_TCTLR_IE_2_Msk,  /**< Match2 interrupt */
} TimerInterruptEnable_t;

/** \brief List of TIMER interrupt flags */
typedef enum
{
    TIMER_MATCH0_INTERRUPT_FLAG  = TIMER_TSR_ICLR_0_Msk,  /**< Match0 interrupt flag */
    TIMER_MATCH1_INTERRUPT_FLAG  = TIMER_TSR_ICLR_1_Msk,  /**< Match1 interrupt flag */
    TIMER_MATCH2_INTERRUPT_FLAG  = TIMER_TSR_ICLR_2_Msk,  /**< Match2 interrupt flag */
} TimerInterruptFlags_t;


/*******************************************************************************
 * API
 ******************************************************************************/

#if defined(__cplusplus)
extern "C" {
#endif

/** \name TIMER Driver Initialization */
/** \{ */

/**
  \fn    void TIMER_driverInit(void);
  \brief Intialize TIMER driver internal data, must be called before any other APIs
 */
void TIMER_driverInit(void);

/** \} */

/** \name TIMER Configuration */
/** \{ */

/**
  \fn    void TIMER_getDefaultConfig(TimerConfig_t *config)
  \brief Gets the TIMER default configuartion.
         This function sets the configuration structure to default values as below:
  \code
         config->clockSource = TIMER_INTERNAL_CLOCK;
         config->reloadOption = TIMER_RELOAD_ON_MATCH1;
         config->initValue = 0;
         config->match0 = 0x10000 >> 1;
         config->match1 = 0x10000;
         config->match2 = 0xFFFFFFFF;
  \endcode

  \param[in] config      Pointer to TIMER configuration structure
 */
void TIMER_getDefaultConfig(TimerConfig_t *config);

/**
  \fn    void TIMER_init(uint32_t instance, const TimerConfig_t *config)
  \brief Intialize TIMER
  \param[in] instance    TIMER instance number (0, 1, ...)
  \param[in] config      Pointer to TIMER configuration
  \note      PWM out is disabled after this function's call, use \ref TIMER_setupPwm function to eable PWM
 */
void TIMER_init(uint32_t instance, const TimerConfig_t *config);

/**
  \fn    void TIMER_deInit(uint32_t instance)
  \brief Deintialize TIMER
  \param[in] instance    TIMER instance number (0, 1, ...)
 */
void TIMER_deInit(uint32_t instance);

/**
  \fn    void TIMER_setMatch(uint32_t instance, TimerMatchSelect_t match)
  \brief Sets one of TIMER match values
  \param[in] instance    TIMER instance number (0, 1, ...)
  \param[in] matchNum    TIMER match select
  \param[in] matchValue  TIMER match value
 */
void TIMER_setMatch(uint32_t instance, TimerMatchSelect_t matchNum, uint32_t matchValue);

/**
  \fn    void TIMER_setMatch(uint32_t instance, TimerMatchSelect_t match)
  \brief Sets TIMER counter initial value
  \param[in] instance    TIMER instance number (0, 1, ...)
  \param[in] initValue   TIMER initial value
 */
void TIMER_setInitValue(uint32_t instance, uint32_t initValue);

/**
  \fn    void TIMER_setMatch(uint32_t instance, TimerMatchSelect_t match)
  \brief Sets TIMER counter reload option
  \param[in] instance    TIMER instance number (0, 1, ...)
  \param[in] option      TIMER counter reload option
 */
void TIMER_setReloadOption(uint32_t instance, TimerReloadOption_t option);

/** \} */

/** \name TIMER Counter */
/** \{ */

/**
  \fn    void TIMER_start(uint32_t instance)
  \brief Starts TIMER counter
  \param[in] instance    TIMER instance number (0, 1, ...)
 */
void TIMER_start(uint32_t instance);

/**
  \fn    void TIMER_stop(uint32_t instance)
  \brief Stops TIMER counter
  \param[in] instance    TIMER instance number (0, 1, ...)
 */
void TIMER_stop(uint32_t instance);

/**
  \fn    uint32_t TIMER_getCount(uint32_t instance)
  \brief Reads current TIMER counter value
  \param[in] instance    TIMER instance number (0, 1, ...)
  \return                current TIMER counter value
 */
uint32_t TIMER_getCount(uint32_t instance);

/** \} */

/** \name TIMER PWM */
/** \{ */

/**
  \fn    int32_t TIMER_setupPwm(uint32_t instance, const TimerPwmConfig_t *config)
  \brief Configures the PWM signals period, mode, etc.
  \param[in] instance    TIMER instance number (0, 1, ...)
  \param[in] config      Pointer to PWM parameter
  \return    ARM_DRIVER_OK if the PWM setup is successful
             ARM_DRIVER_ERROR_PARAMETER on parameter check failure
 */
int32_t TIMER_setupPwm(uint32_t instance, const TimerPwmConfig_t *config);

/**
  \fn    void TIMER_updatePwmDutyCycle(uint32_t instance, uint32_t dutyCyclePercent)
  \brief Updates the duty cycle of PWM signal
  \param[in] instance              TIMER instance number (0, 1, ...)
  \param[in] dutyCyclePercent      New PWM pulse width, value shall be between 0 to 100,
                                   if the value exceeds 100, dutyCyclePercent is set to 100.
 */
void TIMER_updatePwmDutyCycle(uint32_t instance, uint32_t dutyCyclePercent);

/** \} */

/** \name TIMER Interrupt */
/** \{ */

/**
  \fn    void TIMER_interruptConfig(uint32_t instance, TimerMatchSelect_t match, TimerInterruptConfig_t config)
  \brief Configures the selected TIMER interrupt
  \param[in] instance    TIMER instance number (0, 1, ...)
  \param[in] match       TIMER match select
  \param[in] config      TIMER interrupt configuration
  */
void TIMER_interruptConfig(uint32_t instance, TimerMatchSelect_t match, TimerInterruptConfig_t config);

/**
  \fn    TimerInterruptConfig_t TIMER_getInterruptConfig(uint32_t instance, TimerMatchSelect_t match)
  \brief Gets current configuration of the selected TIMER interrupt
  \param[in] instance    TIMER instance number (0, 1, ...)
  \param[in] match       TIMER match select
  \return                Current TIMER interrupt configuration
  */
TimerInterruptConfig_t TIMER_getInterruptConfig(uint32_t instance, TimerMatchSelect_t match);

/**
  \fn    uint32_t TIMER_getInterruptFlags(uint32_t instance)
  \brief Reads TIMER interrupt status flags
  \param[in] instance    TIMER instance number (0, 1, ...)
  \return    Interrupt flags. This is the logical OR of members of the
             enumeration \ref TimerInterruptFlags_t
 */
uint32_t TIMER_getInterruptFlags(uint32_t instance);

/**
  \fn    void TIMER_clearInterruptFlags(uint32_t instance, uint32_t mask)
  \brief Clears TIMER interrupt flags
  \param[in] instance    TIMER instance number (0, 1, ...)
  \param[in] mask        Interrupt flags to clear. This is a logic OR of members of the
                         enumeration \ref TimerInterruptFlags_t
 */
void TIMER_clearInterruptFlags(uint32_t instance, uint32_t mask);

/**
  \fn    void TIMER_netlightEnable(uint32_t instance)
  \brief Set Netlight Enable, called by user in bsp_custom.c to define specific timer instance for netlight
  \param[in] instance    TIMER instance number (0, 1, ...)
 */
void TIMER_netlightEnable(uint8_t instance);

/** \} */

/** \} */

#ifdef __cplusplus
}
#endif

#endif /* _TIMER_EC618_H */
