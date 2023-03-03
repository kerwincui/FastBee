

/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: hal_alarm.h
*
*  Description: header of hal_alarm.c, battery low and high temperature interrupt handler
*
*  History: 2021.05.12 initiated by Zhao Weiqi
*
*  Notes:
*
******************************************************************************/
#ifndef CHIP_HALALARM_H
#define CHIP_HALALARM_H

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
typedef enum
{
    ALARM_TYPE_VOLT = 0,
    ALARM_TYPE_THERM,
}alarmMsgType_e;

typedef enum
{
    ALARM_INFO_DOWNWARD = 0,
    ALARM_INFO_UPWARD,
}alarmMsgInfo_e;

typedef struct
{
    uint8_t value;
}alarmInfo;

typedef enum _EPAT_alarmVoltThd
{
    VOLT_THRESHOLD_2150 = 0,
    VOLT_THRESHOLD_2200,
    VOLT_THRESHOLD_2250,
    VOLT_THRESHOLD_2300,
    VOLT_THRESHOLD_2350,
    VOLT_THRESHOLD_2400,
    VOLT_THRESHOLD_2450,
    VOLT_THRESHOLD_2500,
    VOLT_THRESHOLD_2550,
    VOLT_THRESHOLD_2600,
    VOLT_THRESHOLD_2650 = 10,
    VOLT_THRESHOLD_2700,
    VOLT_THRESHOLD_2750,
    VOLT_THRESHOLD_2800,
    VOLT_THRESHOLD_2850,
    VOLT_THRESHOLD_2900,
    VOLT_THRESHOLD_2950 = 16,
    VOLT_THRESHOLD_3000,
    VOLT_THRESHOLD_3050,
    VOLT_THRESHOLD_3100,
    VOLT_THRESHOLD_3150 = 20,
    VOLT_THRESHOLD_3200,
    VOLT_THRESHOLD_3250,
    VOLT_THRESHOLD_3300 = 23,
}alarmVoltThd;

typedef enum _EPAT_alarmThmThd
{
    THM_THRESHOLD_LEVEL0 = 0,
    THM_THRESHOLD_LEVEL1 = 1,
    THM_THRESHOLD_LEVEL2 = 2,
    THM_THRESHOLD_LEVEL3 = 3,
}alarmThmThd;

typedef enum _EPAT_alarmHysteresisRange
{
    THM_HYSTERESIS_10 = 0,
    THM_HYSTERESIS_20 = 1,
    THM_HYSTERESIS_30 = 2,
    THM_HYSTERESIS_40 = 3,
}alarmHysteresisRange;


typedef struct
{
    uint8_t                 voltEnable  : 1;
    uint8_t                 thermEnable : 1;
    uint8_t                 rsvd        : 6;
    alarmVoltThd            voltThd;        /* voltage alarm threshold */ 
    alarmThmThd             thermThd;       /* thermal alarm threshold */ 
    alarmHysteresisRange    hysterThd;      /* thermal alarm hysteresis config */
}alarmParamCfg_t;


typedef void(* vbatLowCallback_t)(bool isVoltAboveThd);
typedef void(* thmHighCallback_t)(bool isTempAboveThd);



/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
/**
* @brief alarmVBatInit
* @details vbat alarm init, callback will excute when vbat is too low 
               the hysteresis is fixed to 200mV 
*
* @param voltThd100: vbat too low threshold
                          e.g.  set threshold to 2.20V then voltThd100 = 220
* @return null
*/
void alarmVBatInit(uint16_t voltThd100);
/**
* @brief alarmVBatDeinit
* @details vbat alarm deinit, no vbat alarm will come anymore  
*
* @return null
*/
void alarmVBatDeinit(void);
/**
* @brief alarmThmHighInit
* @details thermometer alarm init, callback will excute when temperature is too high 
*
* @param thmThd: set the threshold
   @param range:  set the hysteresis range
* @return null
*/
void alarmThmHighInit(alarmThmThd thmThd, alarmHysteresisRange range);
/**
* @brief alarmThmHighDeinit
* @details thermometer alarm deinit, no thermometer alarm will come anymore  
*
* @return null
*/
void alarmThmHighDeinit(void);
/**
* @brief alarmFuncInit
* @details init to detect low voltage and high temperature
*
* @return null
*/
void alarmFuncInit(void);


#ifdef __cplusplus
}
#endif

#endif

