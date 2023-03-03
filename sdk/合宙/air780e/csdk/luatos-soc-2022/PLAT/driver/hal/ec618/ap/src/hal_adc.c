/****************************************************************************
 *
 * Copy right:   2019-, Copyrigths of AirM2M Ltd.
 * File name:    hal_adc.c
 * Description:  EC618 adc hal driver source file
 * History:      Rev1.0   2019-12-12
 *               Rev1.1   2020-02-29  Add api to get internal thermal temperature
 *
 ****************************************************************************/

#include "adc.h"
#include "hal_trim.h"
#include "cmsis_os2.h"

typedef struct _adc_conversion_result
{
    volatile uint32_t rawCode;
    osSemaphoreId_t sem;
} adc_conversion_result_t;

static adc_conversion_result_t g_adcVbatResult = {0};
static adc_conversion_result_t g_adcThermalResult = {0};

/**
  \fn          void ADC_VbatCallback(uint32_t result)
  \brief       Vbat channel callback
  \return
*/
static void ADC_VbatCallback(uint32_t result)
{
    g_adcVbatResult.rawCode = result;

    if(g_adcVbatResult.sem)
    {
        osSemaphoreRelease(g_adcVbatResult.sem);
    }
}

/**
  \fn          void ADC_ThermalCallback(uint32_t result)
  \brief       Thermal channel callback
  \return
*/
static void ADC_ThermalCallback(uint32_t result)
{
    g_adcThermalResult.rawCode = result;

    if(g_adcThermalResult.sem)
    {
        osSemaphoreRelease(g_adcThermalResult.sem);
    }
}

/**
  \breif Calibarte ADC raw sample code
  \param[in] input     ADC conversion raw register value
  \return              calibrated voltage in unit of mV
  \details

  The calibration data stored in EFUSE is two sample values of 500mV and 900mV when Vref is set to 1200mV.
  The calibration process can be deduced below with 3 equations:

  Given:
      Gain * Code500 + Offset = 500            (a)
      Gain * Code900 + Offset = 900            (b)
  To calculate:
      Gain * Input + Offset                    (c)  where Input is actual conversion data from ADC

  We can get Gain and Offset from equation (a) and (b):

  Gain = 400 / (Code900 - Code500)
  Offset = 500 - 400 / (Code900 -Code500) * Code500

  Put them into equation (c), Result is:

  Result = 400 * (Input - Code500) / (Code900 - Code500) + 500

  Round the result in the way: round(a/b) = (a + b/2) / b

  Final result = (400 * (Input - Code500) + (Code900 - Code500) / 2) / (Code900 - Code500) + 500

  In case of EFUSE value is invalid, we have to set Gain value to be 1200 / 4096 and Offset value to be 0.

  So Result = Input * 1200 / 4096, after round
  Final result = ((Input * 1200) + 2048) / 4096

 */
uint32_t HAL_ADC_CalibrateRawCode(uint32_t input)
{
    int32_t temp = 0;
    int32_t diff = 0;

    AdcEfuseCalCode_t * efuseCalcodePtr = trimAdcGetCalCode();

    // Resulotion is 12-bits
    input &= 0xFFFU;

    // EFUSE value is invalid
    if((efuseCalcodePtr->code500 == 0) || (efuseCalcodePtr->code900 == 0))
    {
        return ((input * 1200000) + 2048) / 4096;
    }
    else
    {
        temp = input - efuseCalcodePtr->code500;
        diff = efuseCalcodePtr->code900 - efuseCalcodePtr->code500;
        temp = (400000 * temp + (diff >> 1)) / diff + 500000;

        return (temp < 0) ? 0 : temp;
    }

}

/**
  \breif Convert ADC thermal channel raw sample to temperature in unit of centidegree
  \param[in] input     ADC thermal channel register value
  \return              temperature in unit of centidegree
  \details

  The empirical equation between temperature and ADC thermal ram sample is:

  T = k * Input + T0                                          (a)

  where k is slope and its value is approximately -0.16, T0 is bias and its value ranges from 400 to 500,
        Input is actual conversion data from ADC

  The actural k is deduced from EFUSE values with equation:

  k = -(1000 / 1.731 / 0.95) * (0.4 / (Code900 - Code500))    (b)

  where Code900 and Code500 are ADC calibration data stored in EFUSE, refer to previous comment in \ref HAL_ADC_CalibrateRawCode

  T0 = Toffset - k * Tcode                                    (c)

  where Toffset and Tcode are Thermal calibartion data also stored in EFUSE and Toffset is a number with accuracy of 2 decimal digits

  To get rid of float number calculation and balance accuracy loss, we here amplify the equation (a) by 4000,

  that's T = (4000 * k * Input + 4000 * T0) / 4000            (d)

  Combine equation (c), we get

  T = (4000 * k * (Input - Tcode) + 4000 * Toffset) / 4000    (e)

  Put equation (b) into (e) and note that Toffset has accuracy of 2 decimal digits, perform some simplifying we get

  T = (-972970 / (Code900 - Code500) * (Input - Tcode) + Toffset * 1000) / 4000  (f)

  Also, round the result in the way: round(a/b) = (a + b/2) / b if a > 0 and round(a/b) = (a - b/2) / b if a < 0

  The final result is:

  T = (-972970 / (Code900 - Code500) * (Input - Tcode) + Toffset * 1000 + 2000) / 4000     (g)

 */
int32_t HAL_ADC_ConvertThermalRawCodeToTemperatureHighAccuracy(uint32_t input)
{
    static int32_t gain = 0;

    int32_t temp;

    AdcEfuseCalCode_t * efuseCalcodePtr = trimAdcGetCalCode();
    AdcEfuseT0Code_t * efuseT0CodePtr = trimAdcGetT0Code();

    // Resulotion is 12-bits
    input &= 0xFFFU;

    if(gain == 0)
    {
        gain = -972970 / (int32_t)(efuseCalcodePtr->code900 - efuseCalcodePtr->code500);
    }

    temp = gain * (int32_t)(input - efuseT0CodePtr->codet0) + (int32_t)(efuseT0CodePtr->t0 * 1000);

    return (temp > 0) ? (temp + 2000) / 4 : (temp - 2000) / 4;

}


int32_t HAL_ADC_ConvertThermalRawCodeToTemperature(uint32_t input)
{
    return  HAL_ADC_ConvertThermalRawCodeToTemperatureHighAccuracy(input) / 1000;
}

int32_t HAL_ADC_SampleVbatVoltage(uint32_t timeout_ms)
{
    AdcConfig_t adcConfig;
    int ret = -1;

    g_adcVbatResult.sem = osSemaphoreNew(1U, 0, NULL);

    // semphore created succussful
    if(g_adcVbatResult.sem != NULL)
    {
        ADC_getDefaultConfig(&adcConfig);
        adcConfig.channelConfig.vbatResDiv = ADC_VBAT_RESDIV_RATIO_3OVER16;
        ADC_channelInit(ADC_CHANNEL_VBAT, ADC_USER_APP, &adcConfig, ADC_VbatCallback);

        ADC_startConversion(ADC_CHANNEL_VBAT, ADC_USER_APP);

        ret = osSemaphoreAcquire(g_adcVbatResult.sem, timeout_ms);

        ADC_channelDeInit(ADC_CHANNEL_VBAT, ADC_USER_APP);

        if(ret == osOK)
        {
            ret = HAL_ADC_CalibrateRawCode(g_adcVbatResult.rawCode);
            // amplify the result by the reciprocal of div ratio
            ret = ret * 16 / 3;
            ret = (ret + 500) / 1000; // uV -> mV
        }

        osSemaphoreDelete(g_adcVbatResult.sem);
    }

    return ret;

}

int32_t HAL_ADC_GetThermalTemperature(uint32_t timeout_ms, int32_t* temperatruePtr)
{
    int ret = -1;

    if(temperatruePtr == NULL)
        return -1;

    g_adcThermalResult.sem = osSemaphoreNew(1U, 0, NULL);

    // semphore created succussful
    if(g_adcThermalResult.sem != NULL)
    {
        ADC_channelInit(ADC_CHANNEL_THERMAL, ADC_USER_APP, NULL, ADC_ThermalCallback);

        ADC_startConversion(ADC_CHANNEL_THERMAL, ADC_USER_APP);

        ret = osSemaphoreAcquire(g_adcThermalResult.sem, timeout_ms);

        ADC_channelDeInit(ADC_CHANNEL_THERMAL, ADC_USER_APP);

        if(ret == osOK)
        {
            *temperatruePtr = HAL_ADC_ConvertThermalRawCodeToTemperature(g_adcThermalResult.rawCode);
        }

        osSemaphoreDelete(g_adcThermalResult.sem);
    }

    return ret;

}

