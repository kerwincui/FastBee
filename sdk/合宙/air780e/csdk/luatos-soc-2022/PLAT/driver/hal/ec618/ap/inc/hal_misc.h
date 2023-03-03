/****************************************************************************
 *
 * Copy right:   2019-, Copyrigths of AirM2M Ltd.
 * File name:    hal_misc.h
 * Description:  EC618 hal for misc header file
 * History:      Rev1.0   2019-12-12
 *
 ****************************************************************************/

#ifndef _HAL_MISC_H
#define _HAL_MISC_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>

/**
  \brief  HAL_Get_ChipID enum
 */
typedef enum _chip_id_sel
{
   CHIP_ID_ONLYID = 0,  /**< only read chip ID */
   CHIP_ID_REVID,       /**< only read revison ID */
   CHIP_ID_FULLID         /**< read both  chip ID & revison ID */
} chip_id_sel;


/**
  \brief Get chip id
  \param[in] sel       HAL_Get_ChipID enum
  \return              chip id value
 */
uint32_t HAL_Get_ChipID(chip_id_sel sel);

/**
  \fn        delay_us(uint32_t us)
  \brief     delay time in microseconds.
  \param[in] us number of us
  \note       Given the maximum cpu frequency is 204.8MHz and the limit in calculation,
 *            the maximum time can be delayed is 0xFFFFFFFF / 2048 = 2097151 us = 2097 m   
 */
void delay_us(uint32_t us);

/**
  \fn        apmuBootDbgGPIOSet(bool level)
  \brief     set gpio level in boot flow, for boot time dbg
  \param[in] level
  \note       should set register directly, do not use api
 */
void apmuBootDbgGPIOSet(bool level);
    
/**
  \fn        bool apmuGetLongSlpCfg(void)
  \brief     config the maximum sleep length.
             1. We suggest return false to sleep no more than 36hour
             2. But when usb is disabled and you do not care about time accuracy, 
             return true to set maximum sleep time to 1165 hour
  \note      false: sleep no more than 36.4 hour, true:  can sleep 1165 hour
 */
bool apmuGetLongSlpCfg(void);

#ifdef __cplusplus
}
#endif

#endif /* _HAL_MISC_H */
