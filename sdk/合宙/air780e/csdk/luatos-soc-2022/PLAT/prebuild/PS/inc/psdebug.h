#ifndef __PS_DEBUG_H__
#define __PS_DEBUG_H__

/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017, All rights reserved by AirM2M
 File name:      - psdebug.h
 Description:    - PS system common include header files, and common MARCO
 History:        - 02/28/2020, Originated by Jason
 ******************************************************************************
******************************************************************************/

/******************************************************************************
 * include OS header files
******************************************************************************/
#ifdef WIN32
#include "winsys.h"
#else
#include "osasys.h"
#include "ostask.h"
#include "cmsis_os2.h"
#endif

/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/



/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/*
 * same as: "T_SYS_TIME", to record the PHY TIME info
*/
typedef struct {
    UINT32  hfnsfnsbn;    // hfn(10)|sfn(10)|sbn(4)
    UINT32  spn;          // spn(11)
}PHY_T_SYS_TIME;



/******************************************************************************
 ******************************************************************************
 * PS RAM LOG
 ******************************************************************************
******************************************************************************/

#define PS_RAM_LOG_BUF_SIZE 32*1024

#define PS_RAM_LOG_BUF_END_OFFSET   (PS_RAM_LOG_BUF_SIZE-4)

#define PS_RAM_LOG_START_OFFSET_INIT    0xFFFF

#define PS_RAM_LOG_MAGIC_WORD   0xB6C7

/*
 * PsRamLogBuf
 * Used as a cycle buffer,
 * RAM log record from "endOffset"
*/
typedef struct PsRamLogBuf_Tag
{
    UINT16  magicWord;
    UINT16  endOffset;      //Next RAM log start from it;

    UINT8   buf[PS_RAM_LOG_BUF_SIZE-4];
}PsRamLogBuf;

/*
 * +-----------------------+-----------------------+
 * | PsRamLogHdr (4 bytes) | RAM RECORD BODY...    |
 * +-----------------------+-----------------------+
*/

/*
 * 4 bits, MAX 15
*/
typedef enum PsRamLogType_Enum
{
    PS_RAM_VAR = 0,
    PS_RAM_SIG_RECORD = 1,
    PS_RAM_SIG_DUMP = 2,
    PS_RAM_HEX_DUMP = 3,
    PS_RAM_INTERNAL_MSG_RECORD = 4,
    PS_RAM_DEBUG_ASSERT_RECORD = 5,
    PS_RAM_ASSERT_RECORD = 6
}PsRamLogType;

/*
 * 8 bytes header, before PS RAM LOG
*/
typedef struct PsRamLogHdr_Tag
{
    UINT16  magicWord;
    UINT16  logType: 4;
    UINT16  logLen:  12;
    UINT32  hfnhfnSfnSbn;   //hfn(10)|sfn(10)|sbn(4)
}PsRamLogHdr;

#define PS_RAM_LOG_HDR_SIZE sizeof(PsRamLogHdr)

/*
 * VAR RAM LOG
 * 10 bytes (filename) + 2 bytes (line) + 12 bytes (var1&var2&var3)
 * 24 bytes
 * PS_RAM_VAR
 */
typedef struct PsRamVarLog_Tag
{
    UINT8   fileName[10];
    UINT16  lineNum;
    UINT32  var1;
    UINT32  var2;
    UINT32  var3;
}PsRamVarLog;

#define PS_RAM_VAR_LOG_SIZE sizeof(PsRamVarLog)

/*
 * SIGNAL RAM LOG
 * 4 bytes
 * PS_RAM_SIG_RECORD
 */
typedef struct PsRamSigLog_Tag
{
    UINT16  dTaskId;
    UINT16  sigId;
}PsRamSigLog;

#define PS_RAM_SIG_LOG_SIZE sizeof(PsRamSigLog)

/*
 * SIGNAL DUMP RAM LOG
 * 4 bytes
 * PS_RAM_SIG_DUMP
 */
typedef struct PsRamSigDumpLog_Tag
{
    UINT16  dTaskId;
    UINT16  sigId;
    UINT8   sigBody[];
}PsRamSigDumpLog;


/*
 * VAR RAM LOG
 * 10 bytes (filename) + 2 bytes (line) + hexDump
 * PS_RAM_HEX_DUMP
 */
#define PS_RAM_HEX_DUMP_FILE_NAME_SIZE  8
typedef struct PsRamHexDumpLog_Tag
{
    UINT8   fileName[PS_RAM_HEX_DUMP_FILE_NAME_SIZE];
    UINT16  hexLen;
    UINT16  lineNum;
    UINT8   hexDump[];
}PsRamHexDumpLog;

#define PS_RAM_HEX_DUMP_MAX_SIZE 1024


/*
 * INTERNAL MSG RECORD
 * PS_RAM_INTERNAL_MSG_RECORD
 *  40 bytes
*/
#define PS_RAM_INTERNAL_MSG_STR_SIZE    32
typedef struct PsRamInternalMsgLog_Tag
{
    UINT8   srcId; // msg from which sub-module
    UINT8   argvUint8;
    UINT16  argvUint16;
    UINT32  argvUint32;

    UINT8   handlerStr[PS_RAM_INTERNAL_MSG_STR_SIZE];
}PsRamInternalMsgLog;

#define PS_RAM_INTERNAL_MSG_LOG_SIZE sizeof(PsRamInternalMsgLog)

/*
 * PS_RAM_DEBUG_ASSERT_RECORD
 * PS_RAM_ASSERT_RECORD
 * sizeof(PsRamAssertInfoLog) = 60
*/
#define PS_RAM_ASSERT_FUNC_STR_SIZE 32
#define PS_RAM_ASSERT_FILE_STR_SIZE 14
typedef struct PsRamAssertInfoLog_Tag
{
    //printf("Assert (%.32s), file: %s, (0x%lx, 0x%lx, 0x%lx), line: %d", #cond, __FILE__, (v1), (v2), (v3), __LINE__);
    UINT8   func[PS_RAM_ASSERT_FUNC_STR_SIZE];
    UINT8   fileName[PS_RAM_ASSERT_FILE_STR_SIZE];
    UINT16  lineNum;
    UINT32  var1;
    UINT32  var2;
    UINT32  var3;
}PsRamAssertInfoLog;
#define PS_RAM_ASSERT_INFO_LOG_SIZE sizeof(PsRamAssertInfoLog)


/******************************************************************************
 ******************************************************************************
 * API
 ******************************************************************************
******************************************************************************/
void PsRamLogVar(UINT8 *file, UINT16 line, UINT32 var1, UINT32 var2, UINT32 var3);
void PsRamLogSig(UINT16 dTaskId, UINT16 sigId);
void PsRamLogSigDump(UINT16 dTaskId, SignalBuf *pSig);
void PsRamLogHexDump(UINT8 *file, UINT16 line, UINT16 hexLen, UINT8 *hex);
void PsRamLogInternalMsg(UINT8 *strHandler, UINT8 srcId, UINT8 argvUint8, UINT16 argvUint16, UINT32 argvUint32);
//void GosLogDebugAssertInfo(UINT8 *pFunc, UINT8 *pFile, UINT16 line, UINT32 var1, UINT32 var2, UINT32 var3);
//void GosLogAssertInfo(UINT8 *pFunc, UINT8 *pFile, UINT16 line, UINT32 var1, UINT32 var2, UINT32 var3);


#endif

