#ifndef  _NTC_H
#define  _NTC_H

#ifdef __cplusplus
extern "C" {
#endif

/**
  \brief Get NTC temperature

          Vref(AIO1 output 1200000 uV)
           v
           |
           |
          +-+
          | |
          | |  R = 10 Kohm
          | |
          +-+
           |--------->(AIO2)
          +-+
          | |
          | |  Rntc
          | |
          +-+
           |
         -----
          ---  (GND)
           -

  \param[in] adcInputVoltage     ADC input voltage in unit of uV
  \return    temperature  in unit of mili degree centigrade
 */
int32_t ntcGetTemperature(int32_t adcInputVoltage);

#ifdef __cplusplus
}
#endif

#endif /* _NTC_H */
