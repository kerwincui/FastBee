#ifndef _SYS_RECORD_H
#define _SYS_RECORD_H



#define EC_TRACE_SCHEDULE_RECORD  1

#define EC_TRACE_SCHEDULE_PRINT   1


#define RECORD_LIST_LEN        30
#define RECORD_LIST_NAME_LEN   4

typedef enum ecRecordType_enum
{
    EC_RECORD_TYPE_RESV   = 0,
    EC_RECORD_TYPE_USB    = 1,
    EC_RECORD_TYPE_XIC    = 2,
    EC_RECORD_TYPE_TASK   = 3,
    
    EC_RECORD_TYPE_MAX,
}ecRecordType;

typedef enum ecRecordPrintType_enum
{
    EC_RECORD_PRINT_RESV   = 0,
    EC_RECORD_PRINT_IN    = 1,
    EC_RECORD_PRINT_OUT    = 2,
    
    EC_RECORD_PRINT_MAX,
}ecRecordPrintType;

typedef union
{
    UINT32 ecNVICAndResv;                    // NVIC(0-14)---U16            resv(0xFFFF)---U16
    UINT32 ecXicModuleAndIdx;                // xic module(0-2)---U16       idx(0-31)---U16
    CHAR   ecRecordName[RECORD_LIST_NAME_LEN]; //
}ecInterInfo;

typedef struct _recordNodeList
{
    ecInterInfo ecInterInfos;    
    UINT32 ecInTime;
}ecRecordNodeList;

typedef struct _recordNodeParam
{
    UINT32 ecRecordType;
    UINT32 ecLogInOrOut;
    UINT32 ecNVIC;
    UINT32 ecResv;
    UINT32 ecInTime;
    UINT32 ecXicModule;
    UINT32 ecInterruptIdx;
    UINT32 ecInterruptType;
}vRecordParam;


void ecTraceUsbIntOut(void);
void ecTraceUsbIntIn(void);
void ecTraceXicIntOut(INT32 module, INT32 idx);
void ecTraceXicIntIn(INT32 module, INT32 idx);

void vTracePrintSchedule(vRecordParam recordParam);
void vTraceScheduleRecord(vRecordParam recordParam);

#endif
