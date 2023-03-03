/****************************************************************************
 *
 * Copy right:   2019-, Copyrigths of AirM2M Ltd.
 * File name:    hal_adc.h
 * Description:  EC618 adc hal driver header file
 * History:      Rev1.0   2019-12-12
 *               Rev1.1   2020-02-29  Add api to get internal thermal temperature
 *
 ****************************************************************************/

#ifndef _HAL_ADC_H
#define _HAL_ADC_H

/**
  \addtogroup hal_adc_interface_gr
  \{
 */

/**
  \brief Calibarte ADC raw sample code
  \param[in] input     ADC conversion raw register value
  \return              calibrated voltage in unit of uV
 */
uint32_t HAL_ADC_CalibrateRawCode(uint32_t input);

/**
  \brief Convert ADC thermal channel raw sample to temperature in unit of mili degree centigrade
  \param[in] input     ADC thermal channel register value
  \return              temperature in unit of mili centidegree
  */
int32_t HAL_ADC_ConvertThermalRawCodeToTemperatureHighAccuracy(uint32_t input);

/**
  \brief Convert ADC thermal channel raw sample to temperature in unit of degree centigrade
  \param[in] input     ADC thermal channel register value
  \return              temperature in unit of centidegree
  */
int32_t HAL_ADC_ConvertThermalRawCodeToTemperature(uint32_t input);

/**
  \brief Get Vbat voltage in unit of mV in given time
  \param[in] timeout_ms  timeout value in unit of ms
  \return                error code or calibrated Vbat voltage
                         - -2  : timeout
                         - -1  : other errors
                         - > 0 : calibrated Vbat voltage in unit of mV
  \note  This API shall only be used in task context since semphore is used for synchronization
 */
int32_t HAL_ADC_SampleVbatVoltage(uint32_t timeout_ms);

/**
  \brief Get ADC thermal temperature in unit of degree centigrade in given time
  \param[in]     timeout_ms      timeout value in unit of ms
  \param[in,out] temperatruePtr  pointer to temperature
  \return                error code
                         - -2  : timeout
                         - -1  : other errors
  \note  This API shall only be used in task context since semphore is used for synchronization
 */
int32_t HAL_ADC_GetThermalTemperature(uint32_t timeout_ms, int32_t* temperatruePtr);

/** \} */

#ifdef __cplusplus
}
#endif

#endif /* _HAL_ADC_H */
