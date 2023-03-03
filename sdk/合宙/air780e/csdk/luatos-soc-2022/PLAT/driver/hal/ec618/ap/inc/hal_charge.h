
/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: hal_charge.c
*
*  Description: api for charge status detect
*
*  History: initiated by Zhao Weiqi
*
*  Notes:
*
******************************************************************************/

#ifndef HAL_CHARGE_H
#define HAR_CHARGE_H

#ifdef __cplusplus
extern "C" {
#endif

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include <stdbool.h>
#include <stdint.h>
#include "charge.h"

/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------*
 *                    DATA TYPE DEFINITION                                    *
 *----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*
 *                      PRIVATE FUNCTION DECLEARATION                         *
 *----------------------------------------------------------------------------*/





/*----------------------------------------------------------------------------*
 *                      GLOBAL VARIABLES                                      *
 *----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------*
 *                      PRIVATE FUNCTIONS                                     *
 *----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*
 *                      GLOBAL FUNCTIONS                                      *
 *----------------------------------------------------------------------------*/
/**
* @brief chargeIntHandler
* @details charge interrupt handler
*
* @return null
*/
void chargeIntHandler(void);
/**
* @brief chargeDetectInit
* @details Charge detect initialize
*
* @param cb: callback function for charge status update
* @param monitorEn: enable monitor to detect status_charging and status_full 
   @param sample_dly: sample delay.

* @return null
*/
void chargeDetectInit(chargeStatusCb cb, bool monitorEn, uint32_t sample_dly);
/**
* @brief chargeDetectDeinit
* @details Charge detect deinitialize
*
* @return null
*/
void chargeDetectDeinit(void);


#ifdef __cplusplus
}
#endif

#endif

