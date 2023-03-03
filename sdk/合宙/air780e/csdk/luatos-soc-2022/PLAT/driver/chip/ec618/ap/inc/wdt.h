/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    wdt.h
 * Description:  EC618 wdt driver header file
 * History:
 *
 ****************************************************************************/

#ifndef _WDT_EC618_H
#define _WDT_EC618_H

#include "ec618.h"
#include "Driver_Common.h"

/**
  \addtogroup wdt_interface_gr
  \{
 */

/*******************************************************************************
 * Definitions
 ******************************************************************************/

/** \brief List of WDT mode */
typedef enum
{
    WDT_INTERRUPT_ONLY_MODE   = 0U,  /**< Only generate an interrupt upon timeout */
    WDT_INTERRUPT_RESET_MODE  = 1U,  /**< Reset upon timeout if the first interrupt is not cleared */
} WdtMode_e;

/** \brief WDT configuration structure */
typedef struct
{
    WdtMode_e            mode;
    uint16_t             timeoutValue;
} WdtConfig_t;

/** \brief List of WDT interrupt flags */
typedef enum
{
    WDT_INTERRUPT_FLAG  = WDT_STAT_ISTAT_Msk,  /**< Wdt interrupt flag */
} WdtInterruptFlags_e;

/*******************************************************************************
 * API
 ******************************************************************************/

#if defined(__cplusplus)
extern "C" {
#endif

/** \name WDT Configuration */
/** \{ */

/**
  \fn    void WDT_getDefaultConfig(WdtConfig_t *config)
  \brief Gets the WDT default configuartion.
         This function sets the configuration structure to default values as below:
  \code
         config->mode = WDT_INTERRUPT_ONLY_MODE;
         config->timeoutValue = 0xFFFF;
  \endcode

  \param[in] config      Pointer to WDT configuration structure
 */
void WDT_getDefaultConfig(WdtConfig_t *config);

/**
  \fn    void WDT_init(const WdtConfig_t *config)
  \brief Initialize WDT
  \param[in] config      Pointer to WDT configuration
 */
void WDT_init(const WdtConfig_t *config);

/**
  \fn    void WDT_deInit(void)
  \brief Deinitialize WDT
 */
void WDT_deInit(void);

/** \} */

/** \name WDT Unlock and Kick */
/** \{ */

/**
  \fn    void WDT_unlock(void)
  \brief Unlocks the WDT register written
 */
void WDT_unlock(void);

/**
  \fn    void WDT_kick(void)
  \brief Refreshes WDT counter
 */
void WDT_kick(void);

/** \} */

/** \name WDT Start and Stop */
/** \{ */

/**
  \fn    void WDT_start(void)
  \brief Starts WDT counter
 */
void WDT_start(void);

/**
  \fn    void WDT_stop(void)
  \brief Stops WDT counter
 */
void WDT_stop(void);

/** \} */

/** \name WDT Interrupt and Status */
/** \{ */

/**
  \fn    uint32_t WDT_getInterruptFlags(void)
  \brief Reads WDT interrupt status flags
  \return    Interrupt flags. This is the logical OR of members of the
             enumeration \ref WdtInterruptFlags_e
 */
uint32_t WDT_getInterruptFlags(void);

/**
  \fn    void WDTclearInterruptFlags(uint32_t mask)
  \brief Clears WDT interrupt flags
  \param[in] mask        Interrupt flags to clear. This is a logic OR of members of the
                         enumeration \ref WdtInterruptFlags_e
 */
void WDTclearInterruptFlags(uint32_t mask);

/**
  \fn    WdtMode_e WDT_getMode(void)
  \brief Gets current WDT mode
  \return                WDT mode, see \ref WdtMode_e
 */
WdtMode_e WDT_getMode(void);

/**
  \fn    bool WDT_getStartStatus(void)
  \brief Checks if WDT is started or stopped
  \return                true if WDT is counting
                         false if WDT is stopped
 */
bool WDT_getStartStatus(void);

/** \} */

/** \} */

#ifdef __cplusplus
}
#endif

#endif /* _WDT_EC618_H */
