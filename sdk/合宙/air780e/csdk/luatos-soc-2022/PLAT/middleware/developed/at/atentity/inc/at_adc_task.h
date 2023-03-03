#ifndef _AT_ADC_TASK_
#define _AT_ADC_TASK_
#include "FreeRTOS.h"
#include "queue.h"

#define AT_ADC_TASK_STACK_SIZE    (512)
#define AT_ADC_MSG_TIMEOUT        (1000)
#define AT_ADC_GET_RESULT_TIMOUT  (2000)
#define AT_ADC_MSG_MAX_NUM        (2)

#define AT_ADC_REQ_BITMAP_TEMP    (0x1)
#define AT_ADC_REQ_BITMAP_VBAT    (0x2)

typedef enum applAdcPrimId_Enum
{
    APPL_ADC_PRIM_ID_BASE = 0,

    APPL_ADC_REQ,
    APPL_ADC_CNF,

    APPL_ADC_PRIM_ID_END = 0xFF
}applAdcPrimId;


typedef struct
{
    uint32_t reqhandle;
    uint32_t request;
}adcReqMsg;

typedef struct
{
    uint32_t ack;
    uint32_t data[2];
}adcCnfMsg;


int32_t adcSendMsg(uint32_t atHandle, QueueHandle_t msgHandle, uint32_t req);
int32_t atAdcTaskInit(void);

#endif
