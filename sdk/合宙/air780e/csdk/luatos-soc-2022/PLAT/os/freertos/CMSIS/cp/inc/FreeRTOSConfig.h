/*
 * FreeRTOS Kernel V9.0.0a
 * Copyright (C) 2018 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * http://www.FreeRTOS.org
 * http://aws.amazon.com/freertos
 *
 * 1 tab == 4 spaces!
 */

#ifndef FREERTOS_CONFIG_H
#define FREERTOS_CONFIG_H

/*-----------------------------------------------------------
 * Application specific definitions.
 *
 * These definitions should be adjusted for your particular hardware and
 * application requirements.
 *
 * THESE PARAMETERS ARE DESCRIBED WITHIN THE 'CONFIGURATION' SECTION OF THE
 * FreeRTOS API DOCUMENTATION AVAILABLE ON THE FreeRTOS.org WEB SITE.
 *
 * See http://www.freertos.org/a00110.html.
 *----------------------------------------------------------*/

#include <stdint.h>

#include "RTE_Components.h"
//#include CMSIS_device_header
#include "CP_Arm_Common.h"
#include "os_tick.h"


//-------- <<< Use Configuration Wizard in Context Menu >>> --------------------

//  <o>Minimal stack size [words] <0-65535>
//  <i> Stack for idle task and default task stack in words.
//  <i> Default: 128
#define configMINIMAL_STACK_SIZE                ((uint16_t)(512))

//  <o>Total heap size [bytes] <0-0xFFFFFFFF>
//  <i> Heap memory size in bytes.
//  <i> Default: 8192
#define configTOTAL_HEAP_SIZE                   ((size_t)1024*20)

//  <o>Kernel tick frequency [Hz] <0-0xFFFFFFFF>
//  <i> Kernel tick rate in Hz.
//  <i> Default: 1000
#define configTICK_RATE_HZ                      ((TickType_t)1000)

// idle task stack
#define configIDLE_TASK_STACK_DEPTH            ((uint16_t)(512))//from 3K---2K

//  <o>Timer task stack depth [words] <0-65535>
//  <i> Stack for timer task in words.
//  <i> Default: 80
//increase timer task stack size, since we will call many func in timer callback
#define configTIMER_TASK_STACK_DEPTH            256//from 2k--1k

//  <o>Timer task priority <0-56>
//  <i> Timer task priority.
//  <i> Default: 40 (High)
#define configTIMER_TASK_PRIORITY               40

//  <o>Timer queue length <0-1024>
//  <i> Timer command queue length.
//  <i> Default: 5
#define configTIMER_QUEUE_LENGTH                32

//  <q>Use time slicing
//  <i> Enable setting to use timeslicing.
//  <i> Default: 1
#define configUSE_TIME_SLICING                  1

//  <q>Idle should yield
//  <i> Control Yield behaviour of the idle task.
//  <i> Default: 1
#define configIDLE_SHOULD_YIELD                 1

//  <o>Check for stack overflow
//    <0=>Disable <1=>Method one <2=>Method two
//  <i> Enable or disable stack overflow checking.
//  <i> Callback function vApplicationStackOverflowHook implementation is required when stack checking is enabled.
//  <i> Default: 0
#define configCHECK_FOR_STACK_OVERFLOW          2

//  <q>Use idle hook
//  <i> Enable callback function call on each idle task iteration.
//  <i> Callback function vApplicationIdleHook implementation is required when idle hook is enabled.
//  <i> Default: 0
#define configUSE_IDLE_HOOK                     0

//  <q>Use tick hook
//  <i> Enable callback function call during each tick interrupt.
//  <i> Callback function vApplicationTickHook implementation is required when tick hook is enabled.
//  <i> Default: 0
#define configUSE_TICK_HOOK                     0

//  <q>Use deamon task startup hook
//  <i> Enable callback function call when timer service starts.
//  <i> Callback function vApplicationDaemonTaskStartupHook implementation is required when deamon task startup hook is enabled.
//  <i> Default: 0
#define configUSE_DAEMON_TASK_STARTUP_HOOK      0

//  <q>Use malloc failed hook
//  <i> Enable callback function call when out of dynamic memory.
//  <i> Callback function vApplicationMallocFailedHook implementation is required when malloc failed hook is enabled.
//  <i> Default: 0
#define configUSE_MALLOC_FAILED_HOOK            0

//------------- <<< end of configuration section >>> ---------------------------

/* Defines needed by FreeRTOS to implement CMSIS RTOS2 API. Do not change! */
#define configCPU_CLOCK_HZ                      (SystemCoreClock)
#define configSUPPORT_STATIC_ALLOCATION         1
#define configSUPPORT_DYNAMIC_ALLOCATION        1
#define configUSE_PREEMPTION                    1
#define configUSE_TIMERS                        0
#define configUSE_MUTEXES                       0
#define configUSE_RECURSIVE_MUTEXES             0
#define configUSE_COUNTING_SEMAPHORES           0
#define configUSE_TASK_NOTIFICATIONS            1
#define configUSE_TRACE_FACILITY                1
#define configUSE_16_BIT_TICKS                  0
#define configUSE_PORT_OPTIMISED_TASK_SELECTION 0
#define configMAX_PRIORITIES                    10
//#define configMAX_SYSCALL_INTERRUPT_PRIORITY    16
//#define configKERNEL_INTERRUPT_PRIORITY         255


#define configUSE_TICKLESS_IDLE                 2


/* Cortex-M specific definitions. */
#ifdef __NVIC_PRIO_BITS
	/* __BVIC_PRIO_BITS will be specified when CMSIS is being used. */
	#define configPRIO_BITS		       __NVIC_PRIO_BITS
#else
	#define configPRIO_BITS		       3	/* 8 priority levels */
#endif


#define configLIBRARY_LOWEST_INTERRUPT_PRIORITY			0x7


#define configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY	0x1// os api will disable int priority lower than this value when enter critical section


#define configKERNEL_INTERRUPT_PRIORITY		 ( configLIBRARY_LOWEST_INTERRUPT_PRIORITY << (8 - configPRIO_BITS) )//numeric value 0xe0

#define configMAX_SYSCALL_INTERRUPT_PRIORITY  0x20//(configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY << (8 - configPRIO_BITS))

/* Defines that include FreeRTOS functions which implement CMSIS RTOS2 API. Do not change! */
#define INCLUDE_xEventGroupSetBitsFromISR       0
#define INCLUDE_xSemaphoreGetMutexHolder        0
#define INCLUDE_vTaskDelay                      1
#define INCLUDE_vTaskDelayUntil                 0
#define INCLUDE_vTaskDelete                     1
#define INCLUDE_xTaskGetCurrentTaskHandle       1
#define INCLUDE_xTaskGetSchedulerState          1
#define INCLUDE_uxTaskGetStackHighWaterMark     0
#define INCLUDE_uxTaskPriorityGet               0
#define INCLUDE_vTaskPrioritySet                0
#define INCLUDE_eTaskGetState                   0
#define INCLUDE_vTaskSuspend                    1
#define INCLUDE_xTimerPendFunctionCall          0

/* Map the FreeRTOS port interrupt handlers to their CMSIS standard names. */
#define xPortPendSVHandler                    PendSV_Handler
#define vPortSVCHandler                       SVC_Handler


/* Include debug event definitions */
//#include "freertos_evr.h"

#endif /* FREERTOS_CONFIG_H */
