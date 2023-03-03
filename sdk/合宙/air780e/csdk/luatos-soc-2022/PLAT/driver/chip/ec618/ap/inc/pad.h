/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    pad.h
 * Description:  EC618 pad driver header file
 * History:
 *
 ****************************************************************************/

#ifndef _PAD_EC618_H_
#define _PAD_EC618_H_

#include "ec618.h"
#include "Driver_Common.h"


/**
  \addtogroup pad_interface_gr
  \{
 */

/*******************************************************************************
 * Definitions
 ******************************************************************************/

/** \brief PAD pin mux selection */
typedef enum
{
    PAD_MUX_ALT0 = 0U,             /**< Chip-specific */
    PAD_MUX_ALT1 = 1U,             /**< Chip-specific */
    PAD_MUX_ALT2 = 2U,             /**< Chip-specific */
    PAD_MUX_ALT3 = 3U,             /**< Chip-specific */
    PAD_MUX_ALT4 = 4U,             /**< Chip-specific */
    PAD_MUX_ALT5 = 5U,             /**< Chip-specific */
    PAD_MUX_ALT6 = 6U,             /**< Chip-specific */
    PAD_MUX_ALT7 = 7U,             /**< Chip-specific */
} PadMux_e;


/** \brief Internal pull-up resistor configuration */
typedef enum
{
    PAD_PULL_UP_DISABLE = 0U,      /**< Internal pull-up resistor is disabled */
    PAD_PULL_UP_ENABLE  = 1U,      /**< Internal pull-up resistor is enabled */
} PadPullUp_e;

/** \brief Internal pull-down resistor configuration */
typedef enum
{
    PAD_PULL_DOWN_DISABLE = 0U,      /**< Internal pull-down resistor is disabled */
    PAD_PULL_DOWN_ENABLE  = 1U,      /**< Internal pull-down resistor is enabled */
} PadPullDown_e;

/** \brief Pull feature selection */
typedef enum
{
    PAD_PULL_AUTO      = 0U,      /**< Pull up/down is controlled by muxed alt function */
    PAD_PULL_INTERNAL  = 1U,      /**< Use internal pull-up/down resistor */
} PadPullSel_e;

/** \brief Input buffer enable/disable */
typedef enum
{
    PAD_INPUT_BUFFER_DISABLE = 0U,     /**< Input Buffer is disabled */
    PAD_INPUT_BUFFER_ENABLE  = 1U,     /**< Input Buffer is enabled */
} PadInputBuffer_e;

/** \brief Configures pull feature */
typedef enum
{
    PAD_INTERNAL_PULL_UP   = 0U,  /**< select internal pull up */
    PAD_INTERNAL_PULL_DOWN = 1U,  /**< select internal pull down */
    PAD_AUTO_PULL          = 2U,  /**< Pull up/down is controlled by muxed alt function */
} PadPullConfig_e;

/** \brief PAD configuration structure */
typedef struct
{
    uint32_t                                    : 4;
    uint32_t         mux                        : 3;   /**< Pad mux configuration */
    uint32_t                                    : 1;
    uint32_t         pullUpEnable               : 1;   /**< Enable pull-up */
    uint32_t         pullDownEnable             : 1;   /**< Enable pull-down */
    uint32_t         pullSelect                 : 1;   /**< Pull select, external or internal control */
    uint32_t                                    : 2;
    uint32_t         inputBufferEnable          : 1;   /**< Enable/disable input buffer */
    uint32_t                                    : 18;
} PadConfig_t;

/*******************************************************************************
 * API
 ******************************************************************************/

#if defined(__cplusplus)
extern "C" {
#endif

/** \name PAD Driver Initialization */
/** \{ */

/**
  \fn    void PAD_driverInit(void);
  \brief Intialize PAD driver internal data, must be called before any other APIs
 */
void PAD_driverInit(void);

/**
  \fn    void PAD_driverInit(void);
  \brief De-Intialize PAD driver, disable PAD clock and perform some clearups
 */
void PAD_driverDeInit(void);

/** \} */

/** \name Configuration */
/* \{ */

/**
  \fn    void PAD_getDefaultConfig(PadConfig_t *config)
  \brief Gets the PAD default configuartion
         This function sets the configuration structure to default values as below:
  \code
         config->mux = PAD_MUX_ALT0;
         config->inputBufferEnable = PAD_INPUT_BUFFER_DISABLE;
         config->pullSelect = PAD_PULL_AUTO;
         config->pullUpEnable = PAD_PULL_UP_DISABLE;
         config->pullDownEnable = PAD_PULL_DOWN_DISABLE;
  \endcode
  \param config Pointer to PAD configuration structure
 */
void PAD_getDefaultConfig(PadConfig_t *config);

/**
  \fn    void PAD_setPinConfig(uint32_t pin, const PadConfig_t *config)
  \brief Sets the pad PCR register
  \param pin       PAD pin number
  \param config    Pointer to PAD configuration structure
 */
void PAD_setPinConfig(uint32_t paddr, const PadConfig_t *config);

/**
  \fn    void PAD_setPinMux(uint32_t pin, PadMux_e mux)
  \brief Configures pin mux
  \param pin       PAD pin number
  \param mux       pin signal source selection
 */
void PAD_setPinMux(uint32_t paddr, PadMux_e mux);

/**
  \fn    void PAD_enablePinInputBuffer(uint32_t pin, bool enable)
  \brief Enable/disable pin's input buffer
  \param pin       PAD pin number
  \param enable    true to enable, false to disable
 */
void PAD_enablePinInputBuffer(uint32_t paddr, bool enable);

/**
  \fn    void PAD_setPinPullConfig(uint32_t pin, PadPullConfig_e config)
  \brief Configures pin's pull feature
  \param pin       PAD pin number
  \param config    PAD pin pull configuration
 */
void PAD_setPinPullConfig(uint32_t paddr, PadPullConfig_e config);

/** \} */

/** \}*/

#if defined(__cplusplus)
}
#endif

#endif /* _PAD_EC618_H_ */
