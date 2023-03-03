/**************************************************************************//**
 * @file     system_ARMCM3.h
 * @brief    CMSIS Device System Header File for
 *           ARMCM3 Device Series
 * @version  V5.00
 * @date     02. March 2016
 ******************************************************************************/
/*
 * Copyright (c) 2009-2016 ARM Limited. All rights reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the License); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an AS IS BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef SYSTEM_CATERPILLER_H
#define SYSTEM_CATERPILLER_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/

#include "commontypedef.h"

#ifdef __cplusplus
extern "C" {
#endif

/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/

#define  XTAL                    (204800000U)      /* Oscillator frequency */
#define  DEFAULT_SYSTEM_CLOCK    (XTAL)
#define  SYSTICK_CLOCK           (3250000)



/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/

extern uint32_t SystemCoreClock;     /*!< System Clock Frequency (Core Clock) */



/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

/**
  \brief Setup the microcontroller system.

   Initialize the System and update the SystemCoreClock variable.
 */
void SystemInit (void);


/**
  \brief  Update SystemCoreClock variable.

   Updates the SystemCoreClock with current core Clock retrieved from cpu registers.
 */
void SystemCoreClockUpdate (void);

/**
  \brief  Save and set IRQ mask.

   Close irq and save current IRQ mask.
 */
static __FORCEINLINE uint32_t SaveAndSetIRQMask(void)
{
    uint32_t mask = __get_PRIMASK();
    __disable_irq();
    return mask;
}


/**
  \brief  Restore IRQ mask.

   Restore IRQ mask and enable irq.
 */
static __FORCEINLINE void RestoreIRQMask(uint32_t mask)
{
    __DSB();
    __ISB();
    __set_PRIMASK(mask);
}

#ifdef __cplusplus
}
#endif

#endif /* SYSTEM_CATERPILLER_H */
