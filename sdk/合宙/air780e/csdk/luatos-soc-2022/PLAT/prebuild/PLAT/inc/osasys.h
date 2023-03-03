#ifndef __PS_OSA_SYS_H__
#define __PS_OSA_SYS_H__

/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017, All rights reserved by AirM2M
 File name:      - osasys.h
 Description:    - OSA system common include header files, and common MARCO
 History:
 ******************************************************************************
******************************************************************************/
#include "cmsis_os2.h"
#include "osasig.h"
#include "osautil.h"
#include "FreeRTOS.h"
#include "stdlib.h"
#include "string.h"
#include "stdio.h"
#include "debug_trace.h"
#include "cmsis_compiler.h"
#include "time.h"
#include "Driver_Common.h"
#include "os_common.h"
#include DEBUG_LOG_HEADER_FILE

/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/


#define SECONDS_TO_TICKS(S)         (UINT32)((S)*configTICK_RATE_HZ)
#define MINUTES_TO_TICKS(M)         (SECONDS_TO_TICKS((M)*60))

//
#define MILLISECONDS_TO_TICKS(MS)   (SECONDS_TO_TICKS((MS))/1000)

#define SECONDS_TO_MILLISECONDS(S)  (UINT32)((S) * 1000)
#define MINUTES_TO_MILLISECONDS(M)  (SECONDS_TO_MILLISECONDS((M)*60))

#define TICKS_TO_SECONDS(T)         (UINT32)((T)/configTICK_RATE_HZ)

#define TICKS_TO_MILLISECONDS(T)    (UINT32)(((UINT64)(T)*1000)/configTICK_RATE_HZ)



/******************************************************************************
 * UnitQueue
 * Use to buffer a fixed size message/signal/entity, FIFO
 * 8 bytes
******************************************************************************/
typedef struct UnitQueue_Tag
{
    UINT8 totalNum; /*total number of entity, which memory allocated in *queue*/
    UINT8 validNum; /*how many entity already stored in this queue*/
    UINT8 header;   /*queue header (first entity index), so the input tail index: (header+validNum)%totalNum */
    UINT8 entitySize; /*each element size*/
    UINT8 *buf;
}UnitQueue;
#define UNIT_QUE_STEP 4 /*allo 4/8/12/16 entity memory*/
#define UNIT_QUE_MAX_SIZE 32

/******************************************************************************
 * SignalQueue
 * OS task internal FIFO queue, which used to buffer signal internally
 *****************************************************************************/
typedef UnitQueue SignalQueue;
/******************************************************************************
 ******************************************************************************
 *  TIMER/SYS time ticks info, which need to still runing in HIBERNATE STATE
 ******************************************************************************
******************************************************************************/
/*
 * HIB time enum ID
*/
typedef enum _EPAT_OsaHibTimerId_enum
{
    OSA_HIB_INVALID_TIMER   = 0,
    PS_HIB_PLMN_PERIOD_OR_OOS_TIMER = 1,
    PS_HIB_EMM_T3245_TIMER,
    PS_HIB_EMM_T3247_TIMER,
    PS_HIB_EMM_T3324_TIMER,
    PS_HIB_EMM_T3325_TIMER,
    PS_HIB_EMM_T3346_TIMER,
    PS_HIB_EMM_T3402_TIMER,
    PS_HIB_EMM_T3411_TIMER,
    PS_HIB_EMM_T3412_TIMER,
    PS_HIB_EMM_T3448_TIMER = 10,
    PS_HIB_EMM_FORBIDDEN_TA_TIMER_ID,
    PS_HIB_EMM_BLOCK_PLMN_TIMER_ID,
    //PS_HIB_ESM_T3396_TIMER,
    PS_HIB_POWER_ON_DELAY_TIMER,
    PS_HIB_EMM_EMERGENCY_CAMP_TIMER_ID,

    PS_HIB_ERRC_T320_TIMER = 30,
    PS_HIB_ERRC_T325_TIMER,
    PS_HIB_ERRC_T330_TIMER,
    PS_HIB_ERRC_BCCH_MOD_TIMER,
    PS_HIB_ERRC_LOG_INTERVAL_TIMER,

    PS_HIB_MAX_TIMER    = 0x40,     /* 64 HIB timer resversed for PS */

    CMS_HIB_POWER_ON_DELAY_TIMER = 0x41,    /* Now, power on random delay handled in CMS task */


    OSA_HIB_MAX_TIMER = 0xFF
}OsaHibTimerId;

/*
 * RTC ticks, which should be also need to recorded during Hibernate state
*/
typedef UINT32  OsaHibMs;
typedef UINT32  OsaHibSecond;

#define EC_TIME_RANG_MAX               (10)   /* 10s */
#define EC_TIME_FLASH_VERSION          ((0x11) & 0xFFFFU)


typedef __PACKED_STRUCT _timer_value
{
    /* UTCtimer1    ---UINT16 year--UINT8 mon--UINT8 day           */
    /* UTCtimer2    ---UINT8 hour--UINT8 mins--UINT8 sec--INT8 tz  */
    //unsigned int UTCtimer1;
    //unsigned int UTCtimer2;
    unsigned int UTCsecs;   /*secs since 1970*/
    unsigned int UTCms;     /*current ms */
    unsigned int CTtimer;
    unsigned int Swtimer;
    unsigned int timeZone;
} timer_value_t;

typedef __PACKED_STRUCT _utc_timer_value
{
    /* UTCtimer1    ---UINT16 year--UINT8 mon--UINT8 day           */
    /* UTCtimer2    ---UINT8 hour--UINT8 mins--UINT8 sec--INT8 tz  */
    unsigned int UTCtimer1;
    unsigned int UTCtimer2;
    unsigned int UTCsecs;   /*secs since 1970*/
    unsigned int UTCms;     /*current ms */
    int timeZone;
} utc_timer_value_t;

typedef enum {
    SYNC_NITZ_LOCAL_TIME,
    SET_LOCAL_TIME = 1,
}AtTimeOptVal;

typedef enum {
    NITZ_TIME_SRC,
    SNTP_TIME_SRC = 1,
    APP_TIME_SRC = 2,
    OTHER_TIME_SRC,
}AtTimeSrcVal;

typedef enum {
    AT_FLASH_TIME = 1,
    AT_FLASH_MAX,
}AtGetFlashVal;

/******************************************************************************
 * OsaHibTimerStart
 * Description: Start HIB timer
 * input: OsaHibTimerExpiryFunc callback;   //time expiry callback
 *        OsaHibTimerId timerId;    //which HIB timer
 *        OsaHibMs nMs;         //timer period
 * output: void
 * Comment:
 *  if "timerId" already start before, just print a warning, and restart it
******************************************************************************/
void    OsaHibTimerStart(OsaHibTimerId timerId, OsaHibMs nMs);

/******************************************************************************
 * OsaHibTimerIsRunning
 * Description: whether the HIB timer is running
 * input: OsaHibTimerId timerId
 * output: BOOL
 * Comment:
******************************************************************************/
BOOL    OsaHibTimerIsRunning(OsaHibTimerId timerId);

/******************************************************************************
 * OsaHibTimerStopAndDel
 * Description: delete HIB timer
 * input: OsaHibTimerId timerId
 * output: void
 * Comment:
******************************************************************************/
void OsaHibTimerStopAndDel(OsaHibTimerId timerId);

/******************************************************************************
 * OsaHibTimerGetRemainMs
 * Description: Get HIB timer remaining time value in milli-seconds
 * input: OsaHibTimerId hibTId
 * output: UINT32
 * Comment:
******************************************************************************/
UINT32 OsaHibTimerGetRemainMs(OsaHibTimerId hibTId);
/*
 * OSA Task Flags functionc
*/
UINT32 OsaTaskFlagsSet(UINT16 taskId, UINT32 flags);
UINT32 OsaTaskFlagsWait(UINT32 waitFlags);
UINT32 OsaTaskFlagsClear(UINT32 clearFlags);




/******************************************************************************
 ******************************************************************************
  externl functions
 ******************************************************************************
******************************************************************************/

#define PSOSA 0x01  //useless, add it just to remove compilation warning

#define OsaPrintf(level, fmt, ...)


/******************************************************************************
 * GosCheck/GosDebugBegin/GosDebugEnd
******************************************************************************/
extern void GosLogDebugAssertInfo(UINT8 *pCond, UINT8 *pFile, UINT16 line, UINT32 var1, UINT32 var2, UINT32 var3);
extern void GosLogAssertInfo(UINT8 *pCond, UINT8 *pFile, UINT16 line, UINT32 var1, UINT32 var2, UINT32 var3);


/******************************************************************************
 * OSA signal timer function
 * When timer expiry, timer task will create a signal (TIMER_EXPIRY) to SRC task
******************************************************************************/
typedef osTimerId_t OsaTimerId;

#define OSA_TIMER_NOT_CREATE 0

void OsaTimerExpiryFunc(void *argument);

//GosTimerId GosTimerNew(UINT16 taskId, UINT16 timerEnum, osTimerType_t type);
//osTimerId_t osTimerNew (osTimerFunc_t func, osTimerType_t type, void *argument, const osTimerAttr_t *attr)
#define OsaTimerNew(taskId, timerEnum, type) \
    osTimerNew(OsaTimerExpiryFunc, type, (void *)(((taskId)<<16)|((timerEnum)&0xffff)), PNULL)

#define OsaTimerStart(TID, TICKS)   osTimerStart((TID), (TICKS))
#define OsaTimerStop(TID)           osTimerStop((TID))
#define OsaTimerIsRunning(TID)      osTimerIsRunning((TID))
//osStatus_t GosTimerDelete(GosTimerId *timer_id);
#define OsaTimerDelete(pTID)        \
do {                                \
    OsaCheck((pTID) != PNULL && *(pTID) != OSA_TIMER_NOT_CREATE, (pTID), 0, 0); \
    osTimerDelete(*(pTID));          \
    *(pTID) = OSA_TIMER_NOT_CREATE;  \
}while(FALSE)

/* Get how many ticks remained */
UINT32  OsaTimerGetRemainTicks(OsaTimerId timerId);


/******************************************************************************
 * UNIT QUEUE function
******************************************************************************/
void UnitQueueInit(UnitQueue *queue, UINT8 entitySize);
void UnitEnQueue(UnitQueue *queue, void *entity);
void UnitDeQueue(UnitQueue *queue, void *entity);
BOOL UnitOnQueue(UnitQueue *queue);
void UnitFlushQueue(UnitQueue *queue);

/******************************************************************************
 * NV FILE function
******************************************************************************/
#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

#define RET_FILE_OK         0
#define RET_FILE_ERR        1

typedef UINT32 NVFILE_HANDLER;

NVFILE_HANDLER NVFopen(UINT32 fileId, UINT8 *mode);
UINT32 NVFclose(NVFILE_HANDLER fd);
UINT32 NVFread(void* buf, UINT32 size, UINT32 count, NVFILE_HANDLER fd);
UINT32 NVFwrite(void* buf, UINT32 size, UINT32 count, NVFILE_HANDLER fd);
UINT32 NVFtell(NVFILE_HANDLER fd);
UINT32 NVFseek(NVFILE_HANDLER fd, UINT32 offset, UINT8 seekType);
UINT32 NVFremove(NVFILE_HANDLER fd); //fake

/**
  \fn           UINT8 OsaCalcCrcValue(const UINT8 *dataBuf, UINT16 bufSize)
  \brief        Calculate the "CRC" value of data buffer
  \param[in]    dataBuf     data buffer pointer
  \param[in]    bufSize     data buffer size
  \returns      crcValue
  \code
  The implementation of this function is listed below:
  UINT8 OsaCalcCrcValue(const UINT8 *dataBuf, UINT16 bufSize)
  {
    UINT32 i;
    UINT32 a = 1, b = 0;

    OsaCheck(dataBuf != PNULL && bufSize > 0, dataBuf, bufSize, 0);

    for (i = bufSize; i > 0; )
    {
        a += (UINT32)(dataBuf[--i]);
        b += a;
    }

    return (UINT8)(((a>>24)&0xFF)^((a>>16)&0xFF)^((a>>8)&0xFF)^((a)&0xFF)^
                   ((b>>24)&0xFF)^((b>>16)&0xFF)^((b>>8)&0xFF)^((b)&0xFF)^
                   (bufSize&0xFF));
  }
  \endcode
*/
UINT8 OsaCalcCrcValue(const UINT8 *dataBuf, UINT16 bufSize);

/******************************************************************************
 * OSA FILE function (little filesystem)
******************************************************************************/
typedef void*   OSAFILE;

/**
  \fn          OSAFILE OsaFopen(UINT8 *fileName, UINT8* mode)
  \brief       OSA open one file
  \param[in]   fileName         file name
  \param[in]   mode             file open mode (read/write/etc)
                                currently supported modes are:
                                "r" or "rb"   : read only
                                "w"           : write only
                                "r+" or "rb+" : read & write
                                "wb"          : write & create
                                "wb+"         : read & write & create
  \returns     OSAFILE
*/
OSAFILE OsaFopen(const char *fileName, const char* mode);

/**
  \fn          INT32 OsaFtell(OSAFILE fp)
  \brief       Return the position of the file
  \param[in]   fp      file description
  \returns     INT32   On success, return the "fp" current offset; On failure, -1 is returned.
*/
INT32 OsaFtell(OSAFILE fp);


/**
  \fn          INT32 OsaFclose(OSAFILE fp)
  \brief       OSA close one file, and free the file description
  \param[in]   OSAFILE  fp
  \returns     int
*/
INT32 OsaFclose(OSAFILE fp);

/**
  \fn           UINT32 OsaFread(void *buf, UINT32 size, UINT32 count, OSAFILE fp)
  \brief        read file content into buffer
  \param[out]   *buf    output buffer
  \param[in]    size    one context/entity size
  \param[in]    count   how many context/entity need to read
  \param[in]    fp      file description
  \returns      UINT32  the total number of context/entity successfully read
*/
UINT32 OsaFread(void *buf, UINT32 size, UINT32 count, OSAFILE fp);

/**
  \fn           UINT32 OsaFwrite(void *buf, UINT32 size, UINT32 count, GOSFILE fp)
  \brief        write buffer content into file
  \param[out]   *buf    output buffer
  \param[in]    size    one context/entity size
  \param[in]    count   how many context/entity need to write
  \param[in]    fp      file description
  \returns      UINT32  the total number of context/entity successfully written
*/
UINT32 OsaFwrite(void *buf, UINT32 size, UINT32 count, OSAFILE fp);

/**
  \fn          INT32 OsaFseek(OSAFILE fp, INT32 offset, UINT8 seekType)
  \brief       Change the position of the file
  \param[in]   fp        file description
  \param[in]   offset    offset to set
  \param[in]   seekType  valid values:
                         - SEEK_SET : beginning of file
                         - SEEK_CUR : current position of the file pointer
                         - SEEK_END : end of file
  \returns     INT32     If successful, returns 0, otherwise -1 is returned.
*/
INT32 OsaFseek(OSAFILE fp, INT32 offset, UINT8 seekType);

/**
  \fn          INT32 OsaFsize(OSAFILE fp)
  \brief       Return the size of the file
  \param[in]   fp      file description
  \returns     INT32   On success, return the size of file in unit of bytes; On failure, -1 is returned.
*/
INT32 OsaFsize(OSAFILE fp);

/**
  \fn           UINT32 OsaFremove(const char *fileName)
  \brief        Deletes the file specified by fileName
  \param[in]    fileName         file name
  \returns      0
*/
UINT32 OsaFremove(const char *fileName);


/******************************************************************************
 * OSA Signal QUEUE function
******************************************************************************/
#define OsaSigQueueInit(Q) UnitQueueInit((Q), sizeof(void *))
//void OsaSigEnQueue(SignalQueue *que, SignalBuf **signal);
#define OsaSigEnQueue(Q, S)                             \
do {                                                    \
    OsaCheck((S) != PNULL && *(S) != PNULL, (S), 0, 0); \
    UnitEnQueue((Q), (S));                              \
    *(S) = PNULL;                                       \
}while(FALSE)

//void OsaSigDeQueue(SignalQueue *que, SignalBuf **signal);
#define OsaSigDeQueue(Q, S)                             \
do {                                                    \
    OsaCheck((S) != PNULL && *(S) == PNULL, (S), 0, 0); \
    UnitDeQueue((Q), (S));                              \
    OsaCheck((S) != PNULL && *(S) != PNULL, (S), 0, 0); \
}while(FALSE)

//BOOL OsaSigOnQueue(SignalQueue *que);
#define OsaSigOnQueue(Q) UnitOnQueue((Q))

//void OsaSigFlushQueue(SignalQueue *que);
#define OsaSigFlushQueue (Q)                \
do {                                        \
    SignalBuf *sig = PNULL;                 \
    while (UnitOnQueue((Q)))                \
    {                                       \
        UnitDeQueue((Q), &sig);             \
        OsaCheck(sig != PNULL, 0, 0, 0);    \
        OsaDestroySignal(&sig);             \
        OsaCheck(sig == PNULL, sig, 0, 0);  \
    }                                       \
    UnitFlushQueue((Q));                    \
}while(FALSE)

#if defined(__CC_ARM)
typedef unsigned int time_t;
#endif


CHAR *strdup(const CHAR *string);
BOOL OsaGetImeiNumSync(CHAR* imei);
INT32 OsaTimerSync(UINT32 srcType, UINT32 cmd, UINT32 Timer1, UINT32 Timer2, UINT32 Timer3);
time_t OsaSystemTimeReadSecs(void);
utc_timer_value_t *OsaSystemTimeReadUtc(void);
utc_timer_value_t *OsaSystemTimeReadRamUtc(void);

/*
 * From LSB(right/low) to MSB (left/high), to find the first postion of bit 0
*/
UINT8 OsaUintBit0Search(UINT32 data);

/*
 * From LSB(right/low) to MSB (left/high), to find the first postion of bit 1
*/
UINT8 OsaUintBit1Search(UINT32 data);
void OsaSrand(void);
UINT32 OsaRand(void);

struct tm *gmtime_ec(const time_t* tim_p, struct tm* res);


#endif

