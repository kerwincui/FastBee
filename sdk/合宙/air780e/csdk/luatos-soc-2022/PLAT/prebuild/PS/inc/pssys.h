#ifndef __PS_SYS_H__
#define __PS_SYS_H__

/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017, All rights reserved by AirM2M
 File name:      - pssys.h
 Description:    - PS system common include header files, and common MARCO
 History:        - 08/09/2020, Originated by Jason
 ******************************************************************************
******************************************************************************/

/******************************************************************************
 * include OS header files
******************************************************************************/
#ifdef WIN32
#include "winsys.h"
#include "osautil.h"
#else
#include "osasys.h"
#include "ostask.h"
#include "cmsis_os2.h"
#include "debug_trace.h"
#include "sctdef.h"
#endif
#include "osanvm.h"
#include "psdebug.h"
#include "pstrace.h"

#ifdef WIN32
//#define EUTRAN_CAT_MODE
#endif
//#define EUTRAN_NB_MODE

#undef      PS_ENABLE_LPP_LCS_FEATURE   /* Cat1 disable LCS feature */
//#define PS_ENABLE_LPP_LCS_FEATURE

/*
 * offset of body in a structure
*/
#ifndef OFFSETOF
#define OFFSETOF(type, body) ((UINT32)&(((type *)0)->body))
#endif

#ifndef GOS_GET_SIGNAL_FROM_BODY
#define     GOS_GET_SIGNAL_FROM_BODY    OSA_GET_SIGNAL_FROM_BODY
#endif

/*
 * 4 bytes align
*/
#ifndef ALIGNED_4BYTE
#ifdef WIN32
#define ALIGNED_4BYTE
#else
#define ALIGNED_4BYTE __ALIGNED(4)
#endif
#endif

#ifndef ALIGNED_128KB
#ifdef WIN32
#define ALIGNED_128KB
#else
#define ALIGNED_128KB CAT_UP_DATA          //__ALIGNED(0x20000)
#endif
#endif



/*
 * Code in RAM
*/
#ifndef PS_CODE_IN_RAM
#ifdef WIN32
#define PS_CODE_IN_RAM
#else
//#define PS_CODE_IN_RAM  __attribute__((__section__(".ramCode2")))
#define PS_CODE_IN_RAM      PS_FM_RAMCODE       /* FM: Full image, MSMB */
#endif
#endif

#ifndef PS_SLP2_ZI
#ifdef WIN32
#define PS_SLP2_ZI
#else
#define PS_SLP2_ZI      PS_FA_ZI        /* DATA in ASMB, remain in sleep2, and zero inited */
#endif
#endif

#ifndef PS_SLP2_DATA
#ifdef WIN32
#define PS_SLP2_DATA
#else
#define PS_SLP2_DATA    PS_FA_DATA      /* DATA in ASMB, remain in sleep2 */
#endif
#endif


/*
 * 4 bytes aligned size
*/
#define FOUR_BYTE_ALIGN_SIZE(size)  (((size)+3)&(0xFFFFFFFC))

#ifndef CAT_PSPHY_SHAREDATA
#ifdef WIN32
#define CAT_PSPHY_SHAREDATA
#endif
#endif


#ifdef WIN32
#define PS_HW_REG_WRITE_32(_pHW, val)
#define PS_HW_REG_READ_32(_pHW, val)
#else

#if   defined ( __CC_ARM )

#define PS_HW_REG_WRITE_32(_pHW, val)   \
do {                                    \
    __asm                               \
    {                                   \
        STR val, [_pHW]                 \
    }                                   \
}while(FALSE)

#define PS_HW_REG_READ_32(_pHW, val)    \
do {                                    \
    __asm                               \
    {                                   \
        LDR val, [_pHW]                 \
    }                                   \
}while(FALSE)

#elif defined ( __GNUC__ )

#define PS_HW_REG_WRITE_32(_pHW, val)  __STREXW(val, _pHW)

#define PS_HW_REG_READ_32(_pHW, val) val = __LDREXW(_pHW)

#endif

#endif


/******************************************************************************
 * InternalMsg
 *  internal message in a task, used to communicate between sub-modules in a task
 *  16 bytes
 *****************************************************************************/
typedef void (*MsgHandler)(UINT8 srcId, UINT8 argvUint8, UINT16 argvUint16, UINT32 argvUint32, void* argvPtr);
typedef struct InternalMsg_Tag
{
    MsgHandler msgHandler;

    UINT8   srcId; // msg from which sub-module
    UINT8   argvUint8;
    UINT16  argvUint16;
    UINT32  argvUint32;
    void    *argvPtr;
}InternalMsg;

/******************************************************************************
 * MsgQueue
 * Message buffer queue, use to buffer internal message
 *****************************************************************************/
typedef UnitQueue MsgQueue;

/******************************************************************************
 * EMPTY SIGNAL
******************************************************************************/
typedef UINT32 GosEmptySignal;

/******************************************************************************
 * SIG_WIN_SIMULATE_INTERNAL_MSG
******************************************************************************/
typedef struct WinSimulateInternalMsg_Tag
{
    MsgHandler msgHandler;

    UINT8   srcId; // msg from which sub-module
    UINT8   argvUint8;
    UINT16  argvUint16;
    UINT32  argvUint32;
    void    *argvPtr;
}WinSimulateInternalMsg;


/******************************************************************************
 ******************************************************************************
 * external some SYS/OS API
 ******************************************************************************
 *****************************************************************************/
void GosLogSig(UINT16 dTaskId, SignalBuf *pSig);
void GosDumpSig(UINT16 dTaskId, SignalBuf *pSig);

//void GosCreateSignal(UINT16 sigId, UINT16 sigBodySize, SignalBuf **signal);
#define     GosCreateSignal     OsaCreateSignal
//void GosCreateZeroSignal(UINT16 sigId, UINT16 sigBodySize, SignalBuf **signal);
#define     GosCreateZeroSignal OsaCreateZeroSignal
//void GosCreateIsrSignal(UINT16 sigId, UINT16 sigBodySize, SignalBuf **signal);
#define     GosCreateIsrSignal  OsaCreateIsrSignal
#define     GosCreateZeroIsrSignal  OsaCreateZeroIsrSignal

//void GosSendSignal(UINT16 taskId, SignalBuf **signal);
#define     GosSendSignal   OsaSendSignal
#define     GosSendNoLogSignal  OsaSendNoLogSignal
// dump the signal to RAM
#define     GosSendDumpSignal   OsaSendDumpSignal
#define     GosSendNoDumpSignal OsaSendNoDumpSignal
//void OsaSendSignalToFront(UINT16 taskId, SignalBuf **signal)
#define     GosSendSignalToFront    OsaSendSignalToFront


//void GosDestroySignal(SignalBuf **signal);
#define     GosDestroySignal    OsaDestroySignal
//void OsaDestroyFastSignal(SignalBuf **signal);
#define     GosDestroyIsrSignal    OsaDestroyIsrSignal
//void GosReceiveSignal(UINT16 taskId, SignalBuf **signal); // if no signal received, just blocked
#define     GosReceiveSignal    OsaReceiveSignal


/* Create PHY signal, called by ERRC/L2 */
void GosCreateSignalToPhy(UINT16 sigId, UINT16 sigBodySize, SignalBuf **signal);

/* Send the signal to PHY*/
void GosSendSignalToPhy(SignalBuf **signal);

/* Destory the signal to PHY, if ERRC/L2 not need to send the signal to PHY */
void GosDestroySignalToPhy(SignalBuf **signal);

/* Destory the signal send from PHY, called by ERRC/L2 */
void GosDestroySignalFromPhy(SignalBuf **signal);

/* Allocate the dynamic memory, which need to pass to PHY */
void* GosAllocMemoryToPhy(UINT16 size);

/* Free the memory, which comes from PHY */
void GosFreeMemoryFromPhy(void **ptr);  //after free it, *ptr is set to PNULL

//void* GosAllocMemory(UINT16 size); // if no memory left, NULL will return
#define     GosAllocMemory      OsaAllocMemory
//void* GosAllocZeroMemory(UINT16 size);
#define     GosAllocZeroMemory  OsaAllocZeroMemory
//void* GosAllocMemoryNoAssert(UINT32 size);
#define     GosAllocMemoryNoAssert      OsaAllocMemoryNoAssert  /* return PNULL, if no memory allcated */
//void* GosAllocZeroMemoryNoAssert(UINT32 size);
#define     GosAllocZeroMemoryNoAssert  OsaAllocZeroMemoryNoAssert  /* return PNULL, if no memory allcated */
//void GosFreeMemory(void **ptr); //after free it, *ptr is set to PNULL
#define     GosFreeMemory       OsaFreeMemory


//UINT8 PsNvmCalcCrcValue(const UINT8 *dataBuf, UINT16 bufSize)
#define     PsNvmCalcCrcValue   OsaCalcCrcValue

#ifdef  WIN32
#define     GosRand             rand
#else
#define     GosRand             OsaRand
#endif

#ifdef  WIN32
#define     PsAllocSlp2Mem          GosAllocMemory
#define     PsAllocZeroSlp2Mem      GosAllocZeroMemory
#define     PsFreeSlp2Mem           GosFreeMemory
#else
/*
 * Memory allocated in sleep2 ASMB memory
 * !!! Note: memory may alloc fail. and return PNULL !!!
*/
void *PsSlp2MallocEC(UINT32 xWantedSize, unsigned int funcPtr);
void *PsSlp2MallocZero(UINT32 xWantedSize);
void PsSlp2FreeEC( void *pv );

#define     PsAllocSlp2Mem(size)        PsSlp2MallocEC((size), 0)
#define     PsAllocZeroSlp2Mem(size)    PsSlp2MallocZero((size))
#define     PsFreeSlp2Mem(pPtr) \
do {                            \
    GosCheck((pPtr) != PNULL && (*(pPtr)) != PNULL, (pPtr), (*(pPtr)), 0);  \
    PsSlp2FreeEC(*(pPtr));                                                  \
    (*(pPtr)) = PNULL;                                                      \
}while(FALSE);

#endif

/*
 * NVM file APIs
*/
#ifdef WIN32
typedef FILE*   GOSFILE;
//GOSFILE GosFopen(UINT8 nvId, UINT8 *fileName, UINT8 *mode);
#define GosFopen(nvId, fileName, mode)    WinFopen((fileName), (mode))
#define GosFclose   WinFclose
#define GosFread    WinFread
#define GosFwrite   WinFwrite
#define GosFremove  WinFremove
#elif defined NVRAM_FILE_SYSTEM  //old file system
//typedef NVFILE_HANDLER GOSFILE;
typedef void*   GOSFILE;
//GOSFILE GosFopen(UINT8 nvId, UINT8 *fileName, UINT8 *mode);
#define GosFopen(nvId, fileName, mode)  (GOSFILE)NVFopen((nvId), (mode))
//UINT32  GosFclose(GOSFILE fp);
#define GosFclose(fp)   NVFclose((NVFILE_HANDLER)(fp))
//UINT32  GosFread(void *buf, UINT32 size, UINT32 count, GOSFILE fp);
#define GosFread(buf, size, count, fp)  NVFread((buf), (size), (count), (NVFILE_HANDLER)(fp))
//UINT32  GosFwrite(void *buf, UINT32 size, UINT32 count, GOSFILE fp);
#define GosFwrite(buf, size, count, fp) NVFwrite((buf), (size), (count), (NVFILE_HANDLER)(fp))
//UINT32  GosFremove(UINT8 *fileName);
#define GosFremove(fileName) NVFremove(0)
#else
typedef OSAFILE   GOSFILE;
//GOSFILE GosFopen(UINT8 nvId, UINT8 *fileName, UINT8 *mode);
#define GosFopen(nvId, fileName, mode)  (GOSFILE)OsaFopen((const char *)(fileName), (const char *)(mode))
#define GosFclose   OsaFclose
#define GosFread    OsaFread
#define GosFwrite   OsaFwrite
#define GosFremove  OsaFremove
#endif

/*
 * OSA NVM operation
*/
typedef OsaNvmRet           PsNvmRet;
typedef OsaNvmBodyInfo      PsNvmBodyInfo;

/*
 * void OsaNvmFreeBody(OsaNvmBodyInfo *pNvmBodyInfo);
*/
#define PsNvmFreeBody       OsaNvmFreeBody


/*
 * GosGetSysTickCout
*/
#ifdef WIN32
#define GosGetSysTickCount() GetTickCount()
#else
#define GosGetSysTickCount() osKernelGetTickCount()
#endif


/******************************************************************************
 ******************************************************************************
  externl functions
 ******************************************************************************
******************************************************************************/
typedef enum PsPrintModId_Tag
{
    PS_MOD_START_ID = 0x10,
    PS = PS_MOD_START_ID,
    PS_UP = 0x11,
    PS_CERRC,
    PS_NAS,
    PS_UICC,
    PS_UICC_DRV,
    PS_CCM,
    PS_CAC,

    PS_MOD_MAX_ID = 0x30
}PsPrintModId;


/******************************************************************************
 * GosPrintf/GosPsPrintf
******************************************************************************/
#ifdef WIN32
#define GosTraceAddModule(_module_name, _trace_level)
#endif

#ifdef WIN32
#define GosPrintf   OsaPrintf
#else
#define GosPrintf(level, fmt, ...)
#endif

#ifdef WIN32
#define GosPsPrintf OsaPsPrintf
#else
#define GosPsPrintf(mod, submod, level, fmt, ...)
#endif

#ifdef WIN32
#define GosHexDump(_module, _level, _dump_name, _data, _len)    \
    OsaHexDump((_dump_name), _data, _len)
#else
//void GosHexDump(_module, _level,_dump_name, _data, _len)
#define GosHexDump(_module, _level, _dump_name, _data, _len)
#endif


/******************************************************************************
 * GosCheck/GosDebugBegin/GosDebugEnd
******************************************************************************/
#define     GosCheck    OsaCheck
#define     GosDebugBegin   OsaDebugBegin
#define     GosDebugEnd     OsaDebugEnd


/******************************************************************************
 * Internal message queue function
******************************************************************************/
void GosLogInternalMsg(InternalMsg *msg, const CHAR *pHdr, UINT16 varSize);

//void GosMsgQueueInit(MsgQueue *msgQ);
#define GosMsgQueueInit(Q) UnitQueueInit((Q), sizeof(InternalMsg))
/*
 * void GosMsgEnQueue(MsgQueue *msgQ, InternalMsg *msg, MsgHandler hdr, UINT16 varSize);
 * MsgQueue *msgQ;  // internal Msg queue
 * InternalMsg *msg; // internal Msg;
 * MsgHandler hdr;  //which callback func;
 * UINT16 varSize;  //size of "argvPtr"
*/
//#define GosMsgEnQueue(Q, M, H, S) UnitEnQueue((Q), (M))
#define GosMsgEnQueue(Q, M, H, S)   \
do {                                \
    GosLogInternalMsg((M), #H, (S));    \
    UnitEnQueue((Q), (M));              \
}while(FALSE)


//void GosMsgDeQueue(MsgQueue *msgQ, InternalMsg *msg);
#define GosMsgDeQueue(Q, M) UnitDeQueue((Q), (M))
//void GosMsgOnQueue(MsgQueue *msgQ);
#define GosMsgOnQueue(Q)    UnitOnQueue((Q))
//void GosMsgFlushQueue(MsgQueue *msgQ);
#define GosMsgFlushQueue(Q) UnitFlushQueue((Q))

/******************************************************************************
 * Gos Signal QUEUE function
******************************************************************************/
#define     GosSigQueueInit     OsaSigQueueInit
//void GosSigEnQueue(SignalQueue *que, SignalBuf **signal);
#define     GosSigEnQueue       OsaSigEnQueue
//void GosSigDeQueue(SignalQueue *que, SignalBuf **signal);
#define     GosSigDeQueue       OsaSigDeQueue
//BOOL GosSigOnQueue(SignalQueue *que);
#define     GosSigOnQueue       OsaSigOnQueue
//void GosSigFlushQueue(SignalQueue *que);
#define     GosSigFlushQueue    OsaSigFlushQueue

/******************************************************************************
 * Gos Task Flags function
******************************************************************************/
//UINT32 GosTaskFlagsSet(UINT16 taskId, UINT32 flags);
#define     GosTaskFlagsSet     OsaTaskFlagsSet
//UINT32 GosTaskFlagsWait(UINT32 waitFlags);
#define     GosTaskFlagsWait    OsaTaskFlagsWait
//UINT32 OsaTaskFlagsClear(UINT32 clearFlags)
#define     GosTaskFlagsClear   OsaTaskFlagsClear

/******************************************************************************
 * Gos signal timer function
 * When timer expiry, timer task will create a signal (TIMER_EXPIRY) to SRC task
******************************************************************************/
typedef OsaTimerId GosTimerId;

#define GOS_TIMER_NOT_CREATE OSA_TIMER_NOT_CREATE

typedef OsaTimerExpiry  GosTimerExpiry;

void GosPsHibTimerExpiryFunc(OsaHibTimerId hibTimerId);

//GosTimerId GosTimerNew(UINT16 taskId, UINT16 timerEnum, osTimerType_t type);
//osTimerId_t osTimerNew (osTimerFunc_t func, osTimerType_t type, void *argument, const osTimerAttr_t *attr)
#ifdef WIN32
void OsaTimerExpiryFunc(void *argument);
#define OsaTimerNew(taskId, timerEnum, type)    \
    osTimerNew(OsaTimerExpiryFunc, type, taskId, timerEnum)					/* used for LPP UT */
#define GosTimerNew(taskId, timerEnum, type)    \
    osTimerNew(OsaTimerExpiryFunc, type, taskId, timerEnum)
#else
#define GosTimerNew     OsaTimerNew
#endif
#define GosTimerStart   OsaTimerStart
#define GosTimerStop    OsaTimerStop
#define GosTimerIsRunning   OsaTimerIsRunning
//osStatus_t GosTimerDelete(GosTimerId *timer_id);
#define GosTimerDelete      OsaTimerDelete
#define GosTimerGetRemainTicks  OsaTimerGetRemainTicks


/******************************************************************************
 ******************************************************************************
 *  TIMER/SYS time ticks info, which need to still runing in HIBERNATE STATE
 ******************************************************************************
******************************************************************************/
typedef OsaHibMs  GosHibMs;

#ifdef WIN32
typedef struct GosHibTimerExpiry_Tag
{
    UINT8   hibTimerId;
    UINT8   reserved0;
    UINT16  reserved1;
}GosHibTimerExpiry;
#else
typedef OsaHibTimerExpiry   GosHibTimerExpiry;
#endif

/*
 * Get current HIB second count
*/
#ifdef WIN32
#define GosGetHibSecondCount()      GetTickCount()
#else
extern uint32_t apmuGetHibSecondCount(void);
#define GosGetHibSecondCount()      apmuGetHibSecondCount()
#endif

/*
 * Get current HIB count in unit of 10 ms
 *  Max count: 0x0FFFFFFF (745 hours), when extended 0x0FFFFFFF, will set to 0
*/
#define GOS_HIB_10MS_COUNT_MAX      0x0FFFFFFF
#ifdef WIN32
#define GosGetHib10MsCount()        GetTickCount()
#else
extern uint32_t hibTimerGet10MsCnt(void);
#define GosGetHib10MsCount()        hibTimerGet10MsCnt()
#endif


/*
 * MARCO:
 * SECONDS_TO_HIB_TICKS(sec)
 * MINUTES_TO_HIB_TICKS(min)
 * MILLISECONDS_TO_HIB_TICKS(MS)
*/

/******************************************************************************
 * GosHibTimerStart
 * Description: Start HIB timer
 *        OsaHibTimerId timerId;    //which HIB timer
 *        UINT32 periodMs;         //timer period in millisecond
 * output: void
 * Comment:
 *  if "timerId" already start before, just print a warning, and restart it
******************************************************************************/
//void OsaHibTimerStart(OsaHibTimerId timerId, OsaHibMs nMs);
#define GosHibTimerStart(hibTid, periodMs)     OsaHibTimerStart(hibTid, periodMs)

/******************************************************************************
 * GosHibTimerIsRunning
 * Description: whether the HIB timer is running
 * input: OsaHibTimerId timerId
 * output: BOOL
 * Comment:
******************************************************************************/
//BOOL    OsaHibTimerIsRunning(OsaHibTimerId timerId);
#define GosHibTimerIsRunning(hibTid)        OsaHibTimerIsRunning(hibTid)

/******************************************************************************
 * GosHibTimerStopAndDel
 * Description: stop HIB and delete HIB timer
 * input: OsaHibTimerId timerId
 * output: void
 * Comment:
******************************************************************************/
//void    OsaHibTimerStopAndDel(OsaHibTimerId timerId);
//#define GosHibTimerStop(hibTid)
#define GosHibTimerStopAndDel(hibTid)       OsaHibTimerStopAndDel(hibTid)


/******************************************************************************
 * GosHibTimerGetRemainMs
 * Description: Get HIB timer remaining time value in milli-seconds
 * input: OsaHibTimerId hibTId
 * output: UINT32
 * Comment:
******************************************************************************/
//UINT32 OsaHibTimerGetRemainMs(OsaHibTimerId hibTId)
#define GosHibTimerGetRemainMs(hibTid)      OsaHibTimerGetRemainMs(hibTid)



/******************************************************************************
 * GosFwdWinSimulateInternalMsgSig
 * This API only use for integration testing in WIN PC
******************************************************************************/
void GosFwdWinSimulateInternalMsgSig(UINT8 srcId, UINT8 argvUint8, UINT16 argvUint16, UINT32 argvUint32, void* argvPtr);

/******************************************************************************
 * PsLastDeepHib
 * Description: Whether PS wake up from HIB. just means ASMB are all lost
 * input:
 * output: BOOL
 * Comment: Now: apmuBWakeupFromHib() & apmuBWakeupFromSlp2() is not suitable called for PS
 *  as AP sleep mode maybe changed in MCU mode.
******************************************************************************/
BOOL PsLastDeepHib(void);

/******************************************************************************
 * PsLastDeepSlp2
 * Description: Whether PS wake up from sleep2. just means ASMB are still usefull
 * input:
 * output: BOOL
 * Comment:
******************************************************************************/
BOOL PsLastDeepSlp2(void);



#endif

