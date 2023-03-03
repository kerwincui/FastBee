
/*
 * Auto generated Run-Time-Environment Component Configuration File
 *      *** Do not modify ! ***
 *
 * Project: 'Blinky'
 * Target:  'Simulation'
 */

#ifndef RTE_COMPONENTS_H
#define RTE_COMPONENTS_H
/*
 * Define the Device Header File:
 */
#if defined CHIP_EC618 || defined CHIP_EC618_Z0
#define CMSIS_device_header "ec618.h"
#elif defined CHIP_EC718
#define CMSIS_device_header "ec718.h"
#endif

#define RTE_CMSIS_RTOS2                 /* CMSIS-RTOS2 */
        #define RTE_CMSIS_RTOS2_FreeRTOS        /* CMSIS-RTOS2 FreeRTOS */
//#define RTE_Compiler_EventRecorder
//#define RTE_Compiler_EventRecorder_DAP
#define RTE_RTOS_FreeRTOS_CONFIG_RTOS2  /* RTOS FreeRTOS Config for CMSIS RTOS2 API */
#define RTE_RTOS_FreeRTOS_CORE          /* RTOS FreeRTOS Core */
#define RTE_RTOS_FreeRTOS_EVENTGROUPS   /* RTOS FreeRTOS Event Groups */
#define RTE_RTOS_FreeRTOS_HEAP_4        /* RTOS FreeRTOS Heap 4 */
#define RTE_RTOS_FreeRTOS_TIMERS        /* RTOS FreeRTOS Timers */

#endif /* RTE_COMPONENTS_H */
