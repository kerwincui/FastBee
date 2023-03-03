
/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: hal_pwrkey.h
*
*  Description: header of hal_pwrkey.c, power on/off and software debounce
*
*  History: 2021.05.06 initiated by Zhao Weiqi
*
*  Notes:
*
******************************************************************************/

#ifndef HAL_PWRKEY_H
#define HAL_PWRKEY_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/

#include "pwrkey.h"


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
* @brief pwrKeyIntHandler
* @details call in PwrKey_WakeupIntHandler
*
* @return null
*/
void pwrKeyIntHandler(void);
/**
* @brief pwrKeyInit
* @details init and enable powerkey
*
* @param workMode
   @param pullUpEn
   @param dlyCfg
   @param Callback

* @return null
*/
void pwrKeyInit(pwrKeyWorkMode workMode, bool pullUpEn, pwrKeyDly_t dlyCfg, pwrKeyCallback_t Callback);
/**
* @brief pwrKeyDeinit
* @details deinit and disable powerkey
*
* @param pullUpEn
* @return null
*/
void pwrKeyDeinit(bool pullUpEn);

#ifdef __cplusplus
}
#endif

#endif


