
/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: pwrkey.h
*
*  Description: header of pwrkey.c, power on/off and software debounce
*
*  History: 2021.04.29 initiated by Zhao Weiqi
*
*  Notes:
*
******************************************************************************/
#ifndef PWR_KEY_H
#define PWR_KEY_H

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
#define KEY_BUF_SIZE 8


/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/
typedef struct
{
    int16_t longPressTimeout;
    int16_t repeatTimeout;
    int16_t pwrOffTimeout;
}pwrKeyDly_t;

typedef enum
{
    PWRKEY_PWRON_MODE = 0,
    PWRKEY_WAKEUP_LOWACTIVE_MODE,
    PWRKEY_WAKEUP_HIGHACTIVE_MODE,
    PWRKEY_UNKNOW_MODE,
}pwrKeyWorkMode;

/*
typedef enum
{
    PWRKEY_SYSTEM_ON = 0,
    PWRKEY_SYSTEM_OFF,
}pwrKeySysStatus;
*/

typedef enum
{
    PWRKEY_RELEASE = 0,
    PWRKEY_PRESS,
    PWRKEY_LONGPRESS,
    PWRKEY_REPEAT,
}pwrKeyPressStatus;

typedef struct
{
    bool negEdgeEn;
    bool posEdgeEn;
}pwrKeyWakeupCfg_t;


typedef void(* pwrKeyCallback_t)(pwrKeyPressStatus status);

typedef struct
{
    pwrKeyWorkMode workMode;
    pwrKeyWakeupCfg_t wakeupCfg;
    pwrKeyDly_t delayCfg;
    pwrKeyCallback_t pwrKeyCallback;
    pwrKeyPressStatus curStatus;
    pwrKeyPressStatus keyBuf[KEY_BUF_SIZE];
    uint8_t bufOffset;
}pwrKeyInfo_t;


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
/**
* @brief pwrKeyPushKey
* @details push a key to power key buffer
*
* @param pwrKeyInfo
   @param status

* @return null
*/
void pwrKeyPushKey(pwrKeyInfo_t *pwrKeyInfo, pwrKeyPressStatus status);
/**
* @brief pwrKeyPopKey
* @details pop a key from power key buffer and return the key status
*
* @param pwrKeyInfo
* @return null
*/
pwrKeyPressStatus pwrKeyPopKey(pwrKeyInfo_t *pwrKeyInfo);
/**
* @brief pwrKeyStartPowerOff
* @details force to enter power off status
*
* @return null
*/
void pwrKeyStartPowerOff(void);
/**
* @brief pwrkeyPwrOnDebounce
* @details power on debounce flow according to the configures
*
* @param tmpDelay in ms
* @return null
*/
void pwrkeyPwrOnDebounce(int16_t tmpDelay);
/**
* @brief pwrKeyHwInit
* @details power key hardware init
*
* @param pullUpEn
* @return null
*/
void pwrKeyHwInit(bool pullUpEn);
/**
* @brief pwrKeyHwDeinit
* @details power key hardware deinit
*
* @param pullUpEn
* @return null
*/
void pwrKeyHwDeinit(bool pullUpEn);
/**
* @brief pwrKeyGetPinLevel
* @details get power key pin value
*
* @return null
*/
bool pwrKeyGetPinLevel(void);
/**
* @brief pwrKeyGetPwrKeyMode
* @details get power key mode in bootloader
*
* @return null
*/
pwrKeyWorkMode pwrKeyGetPwrKeyMode(void);


#ifdef __cplusplus
}
#endif

#endif

