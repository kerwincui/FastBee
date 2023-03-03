/****************************************************************************
 *
 * Copy right:   2019-, Copyrigths of AirM2M Ltd.
 * File name:    adc.h
 * Description:  EC618 adc driver header file
 * History:
 ****************************************************************************/

#ifndef _ADC_EC618_H
#define _ADC_EC618_H

#include "ec618.h"
#include "Driver_Common.h"

/**
  \addtogroup adc_interface_gr
  \{
 */

/*******************************************************************************
 * Definitions
 ******************************************************************************/

/** \brief List of ADC clock source divider */
typedef enum
{
    ADC_CLOCK_DIV_4   = 0U,  /**< ADC clock is divided by 4 from input clock */
    ADC_CLOCK_DIV_8   = 1U,  /**< ADC clock is divided by 8 from input clock */
    ADC_CLOCK_DIV_16  = 2U,  /**< ADC clock is divided by 16 from input clock */
} AdcClockDivider_e;

/** \brief List of ADC channels */
typedef enum
{
    ADC_CHANNEL_THERMAL          = 0U,      /**< ADC Thermal channel */
    ADC_CHANNEL_VBAT             = 1U,      /**< ADC VBAT channel */
    ADC_CHANNEL_AIO4             = 2U,      /**< ADC AIO4 channel */
    ADC_CHANNEL_AIO3             = 3U,      /**< ADC AIO3 channel */
    ADC_CHANNEL_AIO2             = 4U,      /**< ADC AIO2 channel */
    ADC_CHANNEL_AIO1             = 5U,      /**< ADC AIO1 channel */
} AdcChannel_e;

/** \brief List of AIO resdiv select options */
typedef enum
{
    ADC_AIO_RESDIV_RATIO_1          = 0U,  /**< ADC AIO RESDIV select as VIN */
    ADC_AIO_RESDIV_RATIO_14OVER16   = 1U,  /**< ADC AIO RESDIV select as 14/16 VIN */
    ADC_AIO_RESDIV_RATIO_12OVER16   = 2U,  /**< ADC AIO RESDIV select as 12/16 VIN */
    ADC_AIO_RESDIV_RATIO_10OVER16   = 3U,  /**< ADC AIO RESDIV select as 10/16 VIN */
    ADC_AIO_RESDIV_RATIO_8OVER16    = 4U,  /**< ADC AIO RESDIV select as 8/16 VIN */
    ADC_AIO_RESDIV_RATIO_7OVER16    = 5U,  /**< ADC AIO RESDIV select as 7/16 VIN */
    ADC_AIO_RESDIV_RATIO_6OVER16    = 6U,  /**< ADC AIO RESDIV select as 6/16 VIN */
    ADC_AIO_RESDIV_RATIO_5OVER16    = 7U,  /**< ADC AIO RESDIV select as 5/16 VIN */
    ADC_AIO_RESDIV_RATIO_4OVER16    = 8U,  /**< ADC AIO RESDIV select as 4/16 VIN */
    ADC_AIO_RESDIV_RATIO_3OVER16    = 9U,  /**< ADC AIO RESDIV select as 3/16 VIN */
    ADC_AIO_RESDIV_RATIO_2OVER16    = 10U, /**< ADC AIO RESDIV select as 2/16 VIN */
    ADC_AIO_RESDIV_RATIO_1OVER16    = 11U, /**< ADC AIO RESDIV select as 1/16 VIN */
    ADC_AIO_RESDIV_BYPASS           = 12U, /**< BYPASS the whole ADC AIO RESDIV network(direct input) */
} AdcAioResDiv_e;

/** \brief List of VBAT resdiv select options */
typedef enum
{
    ADC_VBAT_RESDIV_RATIO_8OVER16     = 0U,  /**< ADC AIO RESDIV select as 8/16 VBAT */
    ADC_VBAT_RESDIV_RATIO_7OVER16     = 1U,  /**< ADC AIO RESDIV select as 7/16 VBAT */
    ADC_VBAT_RESDIV_RATIO_6OVER16     = 2U,  /**< ADC AIO RESDIV select as 6/16 VBAT */
    ADC_VBAT_RESDIV_RATIO_5OVER16     = 3U,  /**< ADC AIO RESDIV select as 5/16 VBAT */
    ADC_VBAT_RESDIV_RATIO_4OVER16     = 4U,  /**< ADC AIO RESDIV select as 4/16 VBAT */
    ADC_VBAT_RESDIV_RATIO_3OVER16     = 5U,  /**< ADC AIO RESDIV select as 3/16 VBAT */
    ADC_VBAT_RESDIV_RATIO_2OVER16     = 6U,  /**< ADC AIO RESDIV select as 2/16 VBAT */
    ADC_VBAT_RESDIV_RATIO_1OVER16     = 7U,  /**< ADC AIO RESDIV select as 1/16 VBAT */
} AdcVbatResdiv_e;

/** \brief ADC channel configuration */
typedef union
{
    AdcAioResDiv_e  aioResDiv;     /**< resdiv setting, valid only for AIO channel */
    AdcVbatResdiv_e vbatResDiv;    /**< resdiv setting, valid only for VBAT channel */
} AdcChannelConfig_t;

/** \brief ADC configuration structure */
typedef struct
{
    AdcClockDivider_e             clockDivider;                /**< ADC work clock source divider setting */
    AdcChannelConfig_t            channelConfig;               /**< ADC channel configuration */
} AdcConfig_t;

/** \brief List of ADC channel users, used to compose logical channel combining with ADC physical channel
    each channel can be occupied by these users at the same time, conversion request gets serviced one by one in FIFO ordering.
    */
typedef enum
{
    ADC_USER_PHY    = 0U,  /**< Internal user ID for PHY */
    ADC_USER_PLAT   = 1U,  /**< Internal user ID for PLAT */
    ADC_USER_APP    = 2U,  /**< user ID for APP */
    ADC_USER_MAX           /**< Total number of users for one channel */
} AdcUser_t;


/**
  \brief Defines callback function prototype.
         Callback function will be called in ADC interrupt service routine after sample completes
  \param result ADC sample result
 */
typedef void (*adcCallback_t)(uint32_t result);

/*******************************************************************************
 * API
 ******************************************************************************/

#if defined(__cplusplus)
extern "C" {
#endif

/** \name ADC Configuration */
/** \{ */

/**
  \fn        void ADC_getDefaultConfig(AdcConfig_t *config)
  \brief     Gets the ADC default configuartion.
             This function sets the configuration structure to default values as below:
  \code
             config->clockDivider = ADC_CLOCK_DIV_4;
             config->channalConfig.aioResDiv = ADC_AIO_RESDIV_BYPASS;  // Note: channelConfig field is union
  \endcode

  \param[in] config      Pointer to ADC configuration structure
 */
void ADC_getDefaultConfig(AdcConfig_t *config);

/**
  \fn        int32_t ADC_channelInit(AdcChannel_e channel, const AdcConfig_t *config, adcCallback_t callback)
  \brief     Initialize ADC specific channel
  \param[in] channel     ADC physical channel to be configured
  \param[in] userID      user ID of specific channel, customer user is assigned with ADC_USER_APP, used to compose logical channel combining with channel parameter
  \param[in] config      Pointer to ADC configuration
  \param[in] callback    Function to be called when ADC conversion completes
  \return                0 on success, -1 for parameter check error, -2 for AIO1 channel conflict(vref output has been enabled)
 */
int32_t ADC_channelInit(AdcChannel_e channel, AdcUser_t userID, const AdcConfig_t *config, adcCallback_t callback);

/**
  \fn        void ADC_channelDeInit(AdcChannel_e channel)
  \brief     Deinitialize ADC channel
  \param[in] channel     physical channel to be de-initialized, configuration of specific logical channel is invalid after this API call.
  \param[in] userID      user ID of specific channel, customer user is assigned with ADC_USER_APP, used to compose logical channel combining with channel parameter
 */
void ADC_channelDeInit(AdcChannel_e channel, AdcUser_t userID);

/**
  \fn        void ADC_startConversion(uint32_t channels)
  \brief     Starts ADC conversion. Conversion is performed imediately when ADC is free, otherwise, the start request is put into a request queue and will be serviced later.

  \param[in] channel     ADC physical channel to converse
  \param[in] userID      user ID of specific channel, customer user is assigned with ADC_USER_APP, used to compose logical channel combining with channel parameter
  \return                0 on success, -1 if request queue is full, -2 if channel has not been initialized yet
 */
int32_t ADC_startConversion(AdcChannel_e channel, AdcUser_t userID);

/**
  \fn        int32_t ADC_enableVrefOutput(void)
  \brief     Enable vref output through AIO1
  \return    0 on success, -2 for AIO1 channel conflict(AIO1 input has been enabled)
  \note      this feature and AIO1 input is mutual exclusive
 */
int32_t ADC_enableVrefOutput(void);

/**
  \fn        void ADC_disableVrefOutput(void)
  \brief     Disable vref output through AIO1
 */
void ADC_disableVrefOutput(void);

/** \} */

/** \} */

#ifdef __cplusplus
}
#endif

#endif /* _ADC_EC618_H */
