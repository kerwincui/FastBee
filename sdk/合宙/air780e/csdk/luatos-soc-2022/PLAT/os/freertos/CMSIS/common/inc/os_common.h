/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename:
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef OS_COMMON_H
#define OS_COMMON_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include "FreeRTOS.h"
#include "stdlib.h"
#include "string.h"
#include "stdio.h"
#include "cmsis_compiler.h"
#include "exception_process.h"

#include DEBUG_LOG_HEADER_FILE

#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/


#define OsaCheck(cond, v1, v2, v3)  \
    EC_ASSERT((BOOL)(cond), (UINT32)(v1), (UINT32)(v2), (UINT32)(v3))

/*
 * OSA memory function
*/
//void* OsaAllocMemory(UINT32 size); // if no memory left, NULL will return
#define     OsaAllocMemory(S)           pvPortAssertMalloc((S))         /* Assert, if no memory allocated */
//void* OsaAllocZeroMemory(UINT32 size);
#define     OsaAllocZeroMemory(S)       pvPortZeroAssertMalloc((S))     /* Assert, if no memory allocated */
//void* OsaAllocMemoryNoAssert(UINT32 size);
#define     OsaAllocMemoryNoAssert(S)   pvPortMalloc((S))               /* return PNULL, if no memory allcated */
//void* OsaAllocZeroMemoryNoAssert(UINT32 size);
#define     OsaAllocZeroMemoryNoAssert(S)       pvPortZeroMalloc((S))   /* return PNULL, if no memory allcated */

#define OsaFreeMemory(pPtr)     \
do {                            \
    OsaCheck((pPtr) != PNULL && (*(pPtr)) != PNULL, (pPtr), (*(pPtr)), 0);  \
    vPortFree(*(pPtr));                                                     \
    (*(pPtr)) = PNULL;                                                      \
}while(FALSE);

#define OsaFreeMemoryNoCheck(pPtr)      \
do {                                    \
    vPortFree(*(pPtr));                                                     \
    (*(pPtr)) = PNULL;                                                      \
}while(FALSE)






/* !!! Del do while. Otherwise, use continue/break between OsaDebugBegin and OsaDebugEnd,
   will invaild and cause ambiguity !!! */
#define OsaDebugBegin(cond, v1, v2, v3)     \
    if (!(cond))                            \
    {                                       \
        ECPLAT_PRINTF(UNILOG_OSA, OsaCheckDebugFalse_e_1, P_ERROR, "Debug Error, func: %s, line: %d, (0x%x, 0x%x, 0x%x)", __FUNCTION__, __LINE__, (UINT32)(v1), (UINT32)(v2), (UINT32)(v3));

#define OsaDebugEnd()                       \
}


/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/







/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/




#ifdef __cplusplus
}
#endif

#endif
