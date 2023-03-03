
/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: alarm.h
*
*  Description: header of alarm.c, hw config for hal_alarm
*
*  History: 2021.05.12 initiated by Zhao Weiqi
*
*  Notes:
*
******************************************************************************/
#ifndef CHIP_ALARM_H
#define CHIP_ALARM_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include <stdint.h>
#include <stdbool.h>


#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
/**
* @brief alarmVBatHwInit
* @details configure and start vbat alarm
*
* @param voltThd100: set the threshold
* @return null
*/
void alarmVBatHwInit(uint16_t voltThd100);
/**
* @brief alarmThmHwInit
* @details configure and start themral alarm
*
* @param thmThd: set the threshold
* @param range:  set the hysteresis range
* @return null
*/
void alarmThmHwInit(uint8_t thmThd, uint8_t range);
/**
* @brief alarmVBatHwDeinit
* @details stop vbat alarm

* @return null
*/
void alarmVBatHwDeinit(void);
/**
* @brief alarmThmHwDeinit
* @details stop thermal alarm

* @return null
*/
void alarmThmHwDeinit(void);
/**
* @brief alarmVBatGetIntIndicate
* @details stop thermal alarm

* @return 1: high  0: low
*/
uint8_t alarmVBatGetIntIndicate(void);
/**
* @brief alarmThmGetIntIndicate
* @details stop thermal alarm

* @return 1: high  0: low
*/
uint8_t alarmThmGetIntIndicate(void);
/**
* @brief alarmThmDisableInAdc
* @details stop thermal alarm, call in auxadc when sample the thm channel

* @return 1: disable operation down  0: do nothing
*/
bool alarmThmDisableInAdc(void);
/**
* @brief alarmThmEnableInAdc
* @details restart thermal alarm, call in auxadc when sample the thm channel

* @return 1: enable operation down  0: do nothing
*/
bool alarmThmEnableInAdc(void);


#ifdef __cplusplus
}
#endif

#endif





