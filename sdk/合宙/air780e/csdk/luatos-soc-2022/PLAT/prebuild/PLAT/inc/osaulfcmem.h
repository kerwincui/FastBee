/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: osaulfcmem.h
*
*  Description:
*
*  History: 2022/2/14 created by xuwang
*
*  Notes: memroy operations with an attribute of UpLink Flow Controlling policy.
*
******************************************************************************/
#ifndef OSA_ULFC_MEM_H
#define OSA_ULFC_MEM_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/

#include "pspdu.h"


#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/
#define OSA_ULFC_MEM_USED_THRES_ANY_ALERT_PCT    0xff
#define OSA_ULFC_MEM_USED_THRES_ANY              0xffff

/* ulfc malloc buffer with/without a (pbuf+)ulpdu header in blocking/non-blocking mode?
 * usage: only for application's exchange data, mostly uplink data.
 */
#define OsaUlfcAllocMemBlocking(wantedSize, chanNo)           OsaUlfcAllocMem(wantedSize, 0, 0, 1, chanNo)
#define OsaUlfcAllocMemNonBlocking(wantedSize, chanNo)        OsaUlfcAllocMem(wantedSize, 0, 0, 0, chanNo)
#define OsaUlfcAllocUlPduBlocking(wantedSize, chanNo)         OsaUlfcAllocMem(wantedSize, 0, 1, 1, chanNo)
#define OsaUlfcAllocUlPduNonBlocking(wantedSize, chanNo)      OsaUlfcAllocMem(wantedSize, 0, 1, 0, chanNo)
#define OsaUlfcAllocPbufUlPduBlocking(wantedSize, chanNo)     OsaUlfcAllocMem(wantedSize, 1, 1, 1, chanNo)
#define OsaUlfcAllocPbufUlPduNonBlocking(wantedSize, chanNo)  OsaUlfcAllocMem(wantedSize, 1, 1, 0, chanNo)


/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/
typedef struct
{
    uint16_t  magicNum;
    uint16_t  extras;
    uint32_t  memSize;   /* aligned size */
}OsaUlfcMemHdr_t;

typedef enum
{
    OSA_ULFC_MFI_MEM_THRES = 0,

    OSA_ULFC_MFI_MAXNUM
}OsaUlfcMemFactorId_e;

typedef enum
{
    OSA_ULFC_STI_CCIO_RX = 0,

    OSA_ULFC_STI_MAXNUM
}OsaUlfcSrcTaskId_e;

typedef uint32_t OsaUlfcSrcTaskId_bm;

typedef enum
{
    OSA_ULFC_MEF_LOW_WATER = 0,
    OSA_ULFC_MEF_HIGH_WATER,

    OSA_ULFC_MEF_MAXNUM
}OsaUlfcMemEvtFlags_e;

typedef struct
{
    uint32_t  memUsed;
    uint32_t  extras;
}OsaUlfcMemEvtArgs_t;


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
uint32_t OsaUlfcGetMemUsedThresAlertPct(uint8_t chanNo);
void OsaUlfcSetMemUsedThresAlertPct(uint8_t chanNo, uint8_t alertPct);

uint32_t OsaUlfcGetMemUsedSizeThres(uint8_t chanNo);
void  OsaUlfcSetMemUsedSizeThres(uint8_t chanNo, uint32_t usedSize);

uint8_t  OsaUlfcQueryEnableState(uint8_t chanNo);
uint32_t OsaUlfcQueryMemAvlbSize(uint8_t chanNo);

void* OsaUlfcAllocMem(uint32_t wantedSize, uint8_t hasPbuf, uint8_t hasUldpu, uint8_t isBlocking, uint16_t extras);
void  OsaUlfcFreeMem(void *ptr);
void  OsaUlfcReallocMem(void *ptr, uint32_t wantedSize);

void  OsaUlfcEnable(uint8_t chanNo, uint8_t isBlocking, OsaUlfcSrcTaskId_e taskId);
void  OsaUlfcDisable(uint8_t chanNo, OsaUlfcSrcTaskId_e taskId);

void  OsaUlfcNotifyMemEvent(OsaUlfcMemEvtFlags_e flags, OsaUlfcMemEvtArgs_t *args);
void  OsaUlfcConfmMemEvent(uint8_t chanNo);

#ifdef __cplusplus
}
#endif
#endif

