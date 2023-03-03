

/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: charge.h
*
*  Description: header of charge.c. api for charge status detect
*
*  History: 2021.05.07 initiated by Zhao Weiqi
*
*  Notes:
*
******************************************************************************/

#ifndef CHARGE_H
#define CHARGE_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/


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
    CHARGE_STATUS_DISCONNECT = 0,
    CHARGE_STATUS_CHARGING = 1,
    CHARGE_STATUS_FINISH = 2,
}chargeStatus_e;

typedef void(* chargeStatusCb)(chargeStatus_e status);

/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
/**
* @brief chargeGetCurStatus
* @details Get current charge status
*
* @return charge status:
    CHARGE_STATUS_DISCONNECT = 0,
    CHARGE_STATUS_CHARGING = 1,
    CHARGE_STATUS_FINISH = 2,
*/
chargeStatus_e chargeGetCurStatus(void);
/**
* @brief chargeHwInit
* @details init hardware
*
* @return null
*/
void chargeHwInit(void);
/**
* @brief chargeHwDeinit
* @details deinit hardware
*
* @return null
*/
void chargeHwDeinit(void);



#ifdef __cplusplus
}
#endif

#endif


