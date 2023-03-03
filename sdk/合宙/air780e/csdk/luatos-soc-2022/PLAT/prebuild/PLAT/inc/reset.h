
/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: reset.h
*
*  Description: header of reset.c, for reset reason check
*
*  History: 2021.04.02 initiated by Zhao Weiqi
*
*  Notes:
*
******************************************************************************/
#ifndef RESET_H
#define RESET_H

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
#define RESET_REASON_MAGIC          (0xACD20E00)
#define RESET_REASON_MASK           (0xFFFFFF00)
#define DUMP_UNREADY_MAGIC            (0x8)
#define DUMP_UNREADY_MASK             (0xF)

/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/

typedef enum _EPAT_ResetReason_e
{
    RESET_REASON_CLEAR = 0x80,
    RESET_REASON_CPPOR = 0x90,    
    RESET_REASON_HARDFAULT = 0xA0,
    RESET_REASON_ASSERT = 0xB0,
    RESET_REASON_WDT = 0xC0,
    RESET_REASON_BAT = 0xD0,
    RESET_REASON_TEMP = 0xE0,
    RESET_REASON_FOTA = 0xF0,
}ResetReason_e;


typedef enum
{
    LAST_RESET_POR = 0,
    LAST_RESET_NORMAL,  // can be sleep2/hib
    LAST_RESET_SWRESET,
    LAST_RESET_HARDFAULT,
    LAST_RESET_ASSERT,
    LAST_RESET_WDTSW,
    LAST_RESET_WDTHW,
    LAST_RESET_LOCKUP,
    LAST_RESET_AONWDT,
    LAST_RESET_BATLOW,
    LAST_RESET_TEMPHI,
    LAST_RESET_FOTA,
    LAST_RESET_CPRESET,
    LAST_RESET_UNKNOWN,
    LAST_RESET_MAXNUM,
}LastResetState_e;


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

#ifdef CORE_IS_CP
/**
* @brief ResetReasonWriteCP
* @details CP write reset reason
* @param 
* @note 
*/
void ResetReasonWriteCP(ResetReason_e reason);
/**
* @brief cpNVIC_SystemReset
* @details call this api to process cp system reset, 
            do not call __NVIC_SystemReset
* @param 
* @note 
*/
void cpNVIC_SystemReset(void);
/**
* @brief cpClearBootFlag
* @details clear cp boot flag when enter hardfault or assert, in case of lockup happens
* @param 
* @note 
*/
void cpClearBootFlag(void);
#else
/**
* @brief ResetReasonWriteAP
* @details AP write reset reason
* @param 
* @note 
*/
void ResetReasonWriteAP(ResetReason_e reason);
/**
* @brief ResetCheckCpNeedPorReset
* @details or cp reset ap cases, always trigger a por reset
* @param 
* @note 
*/
void ResetCheckCpNeedPorReset(void);
/**
* @brief ResetReasonInit
* @details call in AP bsp customInit to print reset reason
* @param 
* @note 
*/
void ResetReasonInit(void);
/**
* @brief ResetReasonCpRstCheck
* @details call in CP Rst Irq to update cp reset reason
* @param 
* @note 
*/
void ResetReasonCpRstCheck(void);
/**
* @brief ResetStateGet
* @details get last reset state
* @param 
* @note 
*/
void ResetStateGet(LastResetState_e *apRstState, LastResetState_e *cpRstState);
/**
* @brief ResetLockupCfg
* @details set ap and cp lockup process, this settings will store in aon
           set true to reset when lockup happen. set false will stop cpu when lockup happen
* @param 
* @note 
*/
void ResetLockupCfg(bool apLockupRstEn, bool cpLockupRstEn);
/**
* @brief ResetApplyAPLockupCfg
* @details get ap lockup settings from aon and apply
* @param 
* @note 
*/
void ResetApplyAPLockupCfg(void);
/**
* @brief ResetECSystemReset
* @details System reset, call this api is more safe than _NVIC_SystemReset
* @param 
* @note 
*/
void ResetECSystemReset(void);
/**
* @brief ResetStartPorReset
* @details process a por reset, a reset magic is write to flash in this api
* @param 
* @note 
*/
void ResetStartPorReset(ResetReason_e reason);
/**
* @brief ResetIsSwPorReset
* @details check flash to decide whether it is por reset
           use to bypass pwrkey debounce flow
* @param 
* @note 
*/
bool ResetIsSwPorReset(ResetReason_e *pReason);

#endif


#ifdef __cplusplus
}
#endif

#endif




