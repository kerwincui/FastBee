/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: osadlfcmem.h
*
*  Description:
*
*  History: 2021/8/15 created by xuwang
*
*  Notes: memroy operations with an attribute of DownLink Flow Controlling policy.
*
******************************************************************************/
#ifndef OSA_DLFC_MEM_H
#define OSA_DLFC_MEM_H

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

#define OSA_DLFC_MFI_INNER_MASK        ((1 << (OSA_DLFC_MFI_INNER_END - OSA_DLFC_MFI_INNER_BEGIN + 1)) - 1)
#define OSA_DLFC_MFI_OUTER_MASK        (((1 << (OSA_DLFC_MFI_OUTER_END - OSA_DLFC_MFI_OUTER_BEGIN + 1)) - 1) << OSA_DLFC_MFI_OUTER_BEGIN)



/* dlfc malloc buffer with/without a (pbuf+)dlpdu header in blocking/non-blocking mode?
 * usage: only for application's exchange data, mostly downlink data.
 */
#define OsaDlfcAllocMemBlocking(wantedSize)           OsaDlfcAllocMem((wantedSize), 0, 0, 1, 0)
#define OsaDlfcAllocMemNonBlocking(wantedSize)        OsaDlfcAllocMem((wantedSize), 0, 0, 0, 0)
#define OsaDlfcAllocDlPduBlocking(wantedSize)         OsaDlfcAllocMem((wantedSize), 0, 1, 1, 0)
#define OsaDlfcAllocDlPduNonBlocking(wantedSize)      OsaDlfcAllocMem((wantedSize), 0, 1, 0, 0)
#define OsaDlfcAllocPbufDlPduBlocking(wantedSize)     OsaDlfcAllocMem((wantedSize), 1, 1, 1, 0)
#define OsaDlfcAllocPbufDlPduNonBlocking(wantedSize)  OsaDlfcAllocMem((wantedSize), 1, 1, 0, 0)


/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/
typedef struct
{
    uint16_t  magicNum;
    uint16_t  extras;
    uint32_t  memSize;   /* aligned size */
}OsaDlfcMemHdr_t;

typedef enum
{
    /* inner factors */
    OSA_DLFC_MFI_INNER_BEGIN = 0,
    OSA_DLFC_MFI_MEM_THRES = OSA_DLFC_MFI_INNER_BEGIN,

    OSA_DLFC_MFI_INNER_END = 9,

    /* outer factors */
    OSA_DLFC_MFI_OUTER_BEGIN = 10,
    OSA_DLFC_MFI_MSG_QUEUE = OSA_DLFC_MFI_OUTER_BEGIN,

    OSA_DLFC_MFI_OUTER_END = 31,

    OSA_DLFC_MFI_MAXNUM
}OsaDlfcMemFactorId_e;

typedef enum
{
    OSA_DLFC_MEF_LOW_WATER = 0,
    OSA_DLFC_MEF_HIGH_WATER,

    OSA_DLFC_MEF_MAXNUM
}OsaDlfcMemEvtFlags_e;

typedef struct
{
    uint32_t  memUsed;
    uint32_t  extras;
}OsaDlfcMemEvtArgs_t;


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
uint32_t OsaDlfcGetMemUsedThresAlertPct(void);
void OsaDlfcSetMemUsedThresAlertPct(uint8_t alertPct);

uint32_t OsaDlfcGetMemUsedSizeThres(void);
void  OsaDlfcSetMemUsedSizeThres(uint32_t usedSize);

void  OsaDlfcSetMemOuterFactor(OsaDlfcMemFactorId_e fid);
void  OsaDlfcClrMemOuterFactor(OsaDlfcMemFactorId_e fid);

uint32_t OsaDlfcQueryMemAvlbSize(void);

void* OsaDlfcAllocMem(uint32_t wantedSize, uint8_t hasPbuf, uint8_t hasDldpu, uint8_t isBlocking, uint16_t extras);
void  OsaDlfcFreeMem(void *ptr);
void  OsaDlfcReallocMem(void *ptr, uint32_t wantedSize);

void  OsaDlfcNotifyMemEvent(OsaDlfcMemEvtFlags_e flags, OsaDlfcMemEvtArgs_t *args);

#ifdef __cplusplus
}
#endif
#endif

