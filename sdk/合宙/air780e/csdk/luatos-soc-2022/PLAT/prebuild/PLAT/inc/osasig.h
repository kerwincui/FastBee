#ifndef __PS_OSA_SIG_H__
#define __PS_OSA_SIG_H__

/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017, All rights reserved by AirM2M
 File name:      - osasig.h
 Description:    - OSA signal operation
 History:
 ******************************************************************************
******************************************************************************/
#include "commontypedef.h"
#include "cmsis_os2.h"


/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/


/*
 * offset of body in a structure
*/
#ifndef OFFSETOF
#define OFFSETOF(type, body) ((UINT32)&(((type *)0)->body))
#endif

#define OSA_BIG_FAST_SIG_BODY_MAX_SIZE      128


/*
 * OSA related common signal ID
*/
typedef enum _SIG_EPAT_OSASIGIDTAG
{
    SIG_TIMER_EXPIRY = 0x0100,  //OsaTimerExpiry
    SIG_HIB_TIMER_EXPIRY,       //OsaHibTimerExpiry
    SIG_OSA_FAST_IPC,           //OsaFastIpcSig
    SIG_CP_PAGING_IMG_EVENT_IND,    //CpPagingImgEventInd

    SIG_OSA_SIG_END = 0x0110,

    SIG_C2A_FREE_AP_MEMORY_REQ = 0x3102,    /* Same ID: C2A_FREE_AP_MEMORY_REQ, add here, only used for EPAT logging */

}OSASIGID;


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/*
 * SIGID: SIG_TIMER_EXPIRY
*/
typedef struct OsaTimerExpiry_Tag
{
    UINT16 timerEnum;
    UINT16 destTaskId;
}OsaTimerExpiry;

/*
 * SIGID: SIG_OSA_FAST_IPC
 * 1> Fast IPC message (> 128)
 *    Signal                                    A2C fast IPC                    CP ISR signal: SIG_OSA_FAST_IPC, to PHY task
 *                                              31               0              31               0
 *     31               0                       +--------+--------+             +--------+--------+
 *    +--------+--------+ -------------<-+-+    | ipcId  |F|ipclen|             | ipcId  | ipclen |
 *    | sigId  | bodyLen| (bodyLen > 128)| |    +--------+--------+             +--------+--------+
 *    +--------+--------+                | +--> |   Signal_Addr   |      =  +-- |   Signal_Addr   |
 *    /                 /                |      +--------+--------+         |   +--------+--------+
 *    /    sig body     /                +--------<-----------------------<-+
 *    /                 /
 *    +--------+--------+
 *    a) ipcId = sigId; F_flag = 1; ipcLen = sigBodyLen + 4 (Signal header length)
 *       'Signal_Addr' set the signal address, NOT SIGNAL BODY address
 *    b) Signal should allocated by: ACAlloApMemory();
 *    c) When CP process done, should send the "C2A_FREE_AP_MEMORY_REQ" IPC to let AP free the memory
*/
typedef struct OsaFastIpcSig_Tag
{
   UINT16   ipcMsgId;       //For easy IPC MSG ID, just the same as signalID
   UINT16   msgBodyLen;     //siganl read len, including 4 bytes signal header (sigBodyLen + 4)

   UINT8    *pIpcMsg;       //point to "SignalBuf", this msg buffer in fact allocated in another core, should call to free it.
}OsaFastIpcSig;

/*
 * SIGID: SIG_HIB_TIMER_EXPIRY
*/
typedef struct OsaHibTimerExpiry_Tag
{
    UINT8   hibTimerId;
    UINT8   reserved0;
    UINT16  reserved1;
}OsaHibTimerExpiry;


/*
 * The result of handling CP Paging image evert, i.e. whether wake up AP/CP full image
*/
typedef enum _EPAT_CpPagingImgEventRet_enum
{
    BOOT_RET_NO_WAKEUP = 0,         /* Stay in HIB/SLEEP2 state not wakeup */
    BOOT_RET_AP_CP_WAKEUP = 1,      /* wakeup CP for sure, send CephyCpWakeupInd */
    BOOT_RET_AP_WAKEUP = 2,         /* wakeup CP or not is undetermined */
}CpPagingImgEventRet;


/*
 * CP/PHY paging image event ID
*/
typedef enum _EPAT_CpPagingImgEventId_enum
{
    CP_PAGING_IMG_NO_EVENT  = 0,
    CP_UE_PAGING_EVENT      = 1,        /* recv UE paging */
    CP_MEAS_EVENT           = 2,        /* recv Cell measurement */
    CP_RE_SELECT_EVENT      = 3         /* recv measurement, need wakeup PS, and send CephyStartRelectionInd to RRC */

}CpPagingImgEventId;

/*
 * SIG_CP_PAGING_IMG_EVENT_IND
 * Signal send to ERRC, to proc CP/PHY paging/measurment event
*/
typedef struct CpPagingImgEventInd_Tag
{
    UINT8   eventId;        //CpPagingImgEventId
    BOOL    bWakeupCp;      //TRUE if cerrc boot API returns BOOT_RET_AP_CP_WAKEUP, need send CephyCpWakeupInd to PHY
    UINT16  eventSize;      //event body/buffer size

    /*
     * ID                   event               size
     * CP_UE_PAGING_EVENT   CephyPagingInd      PHY_MSMB_PAGING_SHARE_MEM_SIZE (>= sizeof(CephyPagingInd))
     * CP_MEAS_EVENT        CephyCellMeasInd    PHY_MSMB_MEASUREMENT_SHARE_MEM_SIZE (>= sizeof(CephyCellMeasInd))
     * CP_RE_SELECT_EVENT   CephyStartRelectionInd  0   !!! here, size is 0 !!!
    */
    void    *pEvent;        /* event body/buffer, !!! not need to free, as using AP/CP share global memory !!!  */
}CpPagingImgEventInd;   // 8 bytes



/******************************************************************************
 * OS signal struct definition
 *****************************************************************************/
typedef struct SignalBuf_Tag
{
    UINT16 sigId;
    UINT16 sigBodyLen;
    UINT8  sigBody[];
}SignalBuf;

#define OSA_GET_SIGNAL_FROM_BODY(pSigBody) (SignalBuf *)(((UINT8 *)(pSigBody)) - OFFSETOF(SignalBuf, sigBody))


/******************************************************************************
 * EMPTY SIGNAL
******************************************************************************/
typedef UINT32 OsaEmptySignal;





/******************************************************************************
 ******************************************************************************
 * external SYS/OSA API
 ******************************************************************************
 *****************************************************************************/
/*
 * OSA Signal functions
*/
void OsaCreateSignal(UINT16 sigId, UINT16 sigBodySize, SignalBuf **signal);
void OsaCreateZeroSignal(UINT16 sigId, UINT16 sigBodySize, SignalBuf **signal);
void OsaCreateFastSignal(UINT16 sigId, UINT16 sigBodySize, SignalBuf **signal);
void OsaCreateZeroFastSignal(UINT16 sigId, UINT16 sigBodySize, SignalBuf **signal);
//void OsaSendSignal(UINT16 taskId, SignalBuf **signal);
void OsaSendSignalToFront(UINT16 taskId, SignalBuf **signal);
void OsaDestroySignal(SignalBuf **signal);
void OsaDestroyFastSignal(SignalBuf **signal);
void OsaReceiveSignal(UINT16 taskId, SignalBuf **signal); // if no signal received, just blocked

void OsaSendNoLogSignal(UINT16 taskId, SignalBuf **signal); /*no signal record*/
void OsaSendDumpSignal(UINT16 taskId, SignalBuf **signal);  /*dump signal entity*/
void OsaSendNoDumpSignal(UINT16 taskId, SignalBuf **signal);    /*not dump the signal, only record the signalId/destTaskId*/

void OsaSendCustNoLogSignal(osMessageQueueId_t mq_id, SignalBuf **signal);
void OsaReceiveCustSignal(osMessageQueueId_t mq_id, SignalBuf **signal, UINT32 timeOut);


#define OsaCreateIsrSignal      OsaCreateFastSignal
#define OsaCreateZeroIsrSignal  OsaCreateZeroFastSignal
#define OsaDestroyIsrSignal     OsaDestroyFastSignal

/*
 * void OsaSendSignal(UINT16 taskId, SignalBuf **signal);
*/
#define OsaSendSignal           OsaSendDumpSignal


/**
 * Get signal number in current task queue
*/
UINT32 OsaGetSignalCount(UINT16 taskId);

/**
 * Get signal space of current task queue, how many signals could be input.
*/
UINT32 OsaGetSignalSpace(UINT16 taskId);


#endif

