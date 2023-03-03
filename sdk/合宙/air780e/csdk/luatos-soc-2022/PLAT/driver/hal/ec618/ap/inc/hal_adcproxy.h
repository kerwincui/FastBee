
/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: hal_adcproxy.h
*
*  Description: ap collect adc for cp use
*
*  History: 2021.06.20 initiated by Zhao Weiqi
*
*  Notes:
*
******************************************************************************/

#ifndef HAL_ADC_PROXY_H
#define HAL_ADC_PROXY_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/
/* to use default efuse data, set to 1 if no data in efuse */
#define USE_DEFAULT_EFUSE_VALUE         1


/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/
#define ADC_PROXY_VBAT          0
#define ADC_PROXY_INTTEMP       1
#define ADC_PROXY_EXTTEMP       2

/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
/**
* @brief cpADCProxyStartChannel
* @details start adc collection for cp use
* @note
*/
void cpADCProxyStartChannel(uint8_t ADCSampleBm);

/**
* @brief cpADCInit
* @details always call this api, use
    use aio1 for vref, should call far before aio2 start sample, aio1 output need long stable time,
    so call this api as early as possible
* @note
*/
void cpADCInit(void);

/**
* @brief cpADCDeInit
* @details power off vref output

* @note
*/
void cpADCDeInit(void);

/**
* @brief adcProxyConvertRawCodeToTemperature
* @details calculate internal thermal from adc raw data. output accuracy is 0.001 degree
* @note
*/
int32_t adcProxyConvertRawCodeToTemperature(uint32_t input);


#ifdef __cplusplus
}
#endif

#endif


