
/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: ccio_monitor.h
*
*  Description:
*
*  History: 2021/1/19 created by xuwang
*
*  Notes:
*
******************************************************************************/
#ifndef CCIO_MONITOR_H
#define CCIO_MONITOR_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/


#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/
#define CCIO_CHAN_MSGQ_DELAY_NONE       0
#define CCIO_CHAN_MSGQ_DELAT_TIME       500


/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
void  ccioInitMonitor(uint8_t bmTaskCreateFlag);
void  ccioDeinitMonitor(uint8_t bmTaskKillFlag);

void  ccioReportUlfcMemEvent(OsaUlfcMemEvtFlags_e flags, OsaUlfcMemEvtArgs_t *args);
void  ccioReportDlfcMemEvent(OsaDlfcMemEvtFlags_e flags, OsaDlfcMemEvtArgs_t *args);

int32_t ccioSetRxSyncFlag(uint8_t isSync);
int32_t ccioGetRxSyncFlag(void);

int32_t ccioSetUpChannels(uint8_t chanType, void *chent);
int32_t ccioPullDownChannels(uint8_t chanType, void *chent);

int32_t ccioHandleDevStatus(uint32_t flags, void *args);
int32_t ccioHandleEntStatus(uint32_t flags, void *args);

uint32_t ccioQueryChanPendTccm(void);

uint8_t  ccioIsUldpPppSchemAvlb(void);

void*  ccioGetEutraServEnt(void);
void*  ccioGetEtherServEnt(void);
void*  ccioGetPppServEnt(void);

int32_t ccioDisablePmuSleep(uint32_t lanMedia, uint32_t slpState);
int32_t ccioEnablePmuSleep(uint32_t lanMedia, uint32_t slpState);

#ifdef __cplusplus
}
#endif
#endif

