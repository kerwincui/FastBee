/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename:
*
*  Description:
*
*  History: initiated by xxxx
*
*  Notes:
*
******************************************************************************/

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include <stdbool.h>
#include "cmsis_os2.h"
#include "hal_misc.h"
#include "sctdef.h"
#include "ec618.h"
#include "clock.h"
/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*
 *                    DATA TYPE DEFINITION                                    *
 *----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*
 *                      GLOBAL VARIABLES                                      *
 *----------------------------------------------------------------------------*/
extern uint32_t SystemCoreClock;


/*----------------------------------------------------------------------------*
 *                      PRIVATE FUNCTION DECLEARATION                         *
 *----------------------------------------------------------------------------*/

extern uint32_t GPR_getChipFullID(void);
extern uint32_t GPR_getChipRevID(void);
extern uint32_t GPR_getChipID(void);

/*----------------------------------------------------------------------------*
 *                      PRIVATE FUNCTIONS                                     *
 *----------------------------------------------------------------------------*/

/*
 *  cpu cycles delay, every loop spends 2 cpu cycles, so the actual delay is 2*cycles
 *  Parameter: cycles
 */

#if defined(__CC_ARM)
PLAT_PA_RAMCODE __asm static void delay_cycles(uint32_t cycles)
{
loop
    SUBS r0, r0, #1
    BNE loop
    BX lr
}
#elif defined (__GNUC__)
PLAT_PA_RAMCODE static void delay_cycles(uint32_t cycles)
{
asm volatile(
    "mov r0, %0\n\t"
    "loop:\n\t"
    "SUBS r0, r0, #1\n\t"
    "BNE loop\n\t"
    : : "r" (cycles)
);
}
#endif


/*----------------------------------------------------------------------------*
 *                      GLOBAL FUNCTIONS                                      *
 *----------------------------------------------------------------------------*/

/**
  \fn        HAL_Get_ChipID(chip_id_sel sel)
  \brief     Get chip id.
  \param[in] HAL_Get_ChipID enum
  \note
   31-----8 is chip id
   7------0 is revision id
   sel=CHIP_ID_ONLYID, return chip id
   sel=CHIP_ID_REVID,  return revision id
   sel=CHIP_ID_FULL, return both revision and chip id
 */
uint32_t HAL_Get_ChipID(chip_id_sel sel)
{
   uint32_t chipID=0;


   switch(sel)
   {
       case CHIP_ID_ONLYID:

           chipID=GPR_getChipID();
           break;

       case CHIP_ID_REVID:
           chipID=GPR_getChipRevID();
           break;

       case CHIP_ID_FULLID:

           chipID=GPR_getChipFullID();
           break;

       default:
           break;
    }

   return chipID;

}




/**
  \fn        delay_us(uint32_t us)
  \brief     delay time in microseconds.
  \param[in] number of us
  \note       Given the maximum cpu frequency is 204.8MHz and the limit in calculation,
 *            the maximum time can be delayed is 0xFFFFFFFF / 2048 = 2097151 us = 2097 m
 */
PLAT_PA_RAMCODE void delay_us(uint32_t us)
{
    uint32_t ticks;

    // cpu frequency ranges from 26MHz to 204.8MHz
    // first divide 0.1M to get rid of multiply overflow
    // considering 3 cpu cycles are taken to execute one loop operation(sub and branch) in delay_cycles function(includ one pre read assembly),
    // and 0.1M in first step, so we shall divide another 30 before passing the result to delay_cycles function
    // if the delay us is short, it may not be accurate
    ticks = SystemCoreClock / 100000U;
    ticks = ticks * us / 30U;

    delay_cycles(ticks);
}

/**
  \fn        apmuBootDbgGPIOSet(bool level)
  \brief     set gpio level in boot flow, for boot time dbg
  \param[in] gpio level
  \note       should set register directly, do not use api
 */
void apmuBootDbgGPIOSet(bool level)
{
#if 0
    volatile uint32_t *apb_mp_pclken = (volatile uint32_t *)0x4d000030;
    (*apb_mp_pclken) |= ((1<<6) | (1<<7));  // pclk pad and gpio
    GPIO_TypeDef *base = (GPIO_TypeDef *)0x4D070000;	//gpio instance 0
    base->OUTENSET = (1<<7);
    base->DATAOUT = (level<<7);
#endif
}


/**
  \fn        bool apmuGetLongSlpCfg(void)
  \brief     config the maximum sleep length.
             1. We suggest return false to sleep no more than 36hour
             2. But when usb is disabled and you do not care about time accuracy, 
             return true to set maximum sleep time to 1165 hour
  \note      false: sleep no more than 36.4 hour, true:  can sleep 1165 hour
 */
bool apmuGetLongSlpCfg(void)
{
    return false;       
}

ClockId_e CLOCK_checkClkID(void)
{
    return INVALID_CLK;
}

