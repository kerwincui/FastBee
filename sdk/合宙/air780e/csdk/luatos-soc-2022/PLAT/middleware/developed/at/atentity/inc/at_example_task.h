#ifndef _EXAMPLE_TASK_
#define _EXAMPLE_TASK_
#include "FreeRTOS.h" 
#include "queue.h"

#define EG_AT_DEMO_TASK_STACK_SIZE    512 
#define EG_MSG_TIMEOUT                1000
#define EG_MSG_MAX_NUMB               10 

typedef enum AT_EC_RET_TAG
{
    EC_RET_SUCC = 0,
    EC_RET_FAIL = 1,
    EC_RET_END,
}AT_EC_RET_TYPE;

typedef enum AT_EC_REQ_TYPE_TAG
{
    // customer cmd param type
    AT_EC_REQ_TESTA = 1,
    AT_EC_REQ_TESTB,
    AT_EC_REQ_TESTC,

}AT_EG_REQ_TYPE;

typedef enum AT_EC_CNF_TYPE_TAG
{
    // customer cmd param type
    AT_EC_CNF_TESTA = 1,
    AT_EC_CNF_TESTB,
    AT_EC_CNF_TESTC,

}AT_EC_CNF_TYPE;

typedef enum AT_EC_IND_TYPE_TAG
{
    // customer cmd param type
    AT_EC_IND_TESTA = 1,
    AT_EC_IND_TESTB,
    AT_EC_IND_TESTC,

}AT_EC_IND_TYPE;
	
typedef enum applExamplePrimId_Enum
{
    APPL_EXAMPLE_PRIM_ID_BASE = 0,

	APPL_EXAMPLE_ECTESTB_REQ, 
	APPL_EXAMPLE_ECTESTB_CNF,
	APPL_EXAMPLE_ECTESTB_IND,
	
	APPL_EXAMPLE_ECTESTC_REQ, 
	APPL_EXAMPLE_ECTESTC_CNF,
	APPL_EXAMPLE_ECTESTC_IND,

    APPL_EXAMPLE_PRIM_ID_END = 0xFF
}applExamplePrimId;


typedef struct
{
    char data_type;
	unsigned int data_value;
    char * data_ptr;
    int data_len;
}EC_SEND_DATA_STRUCT;

typedef struct
{
    int    cmd_type;
	unsigned int reqhandle;
    EC_SEND_DATA_STRUCT send_data;
}EC_SEND_Q_MSG;

typedef struct
{
    int    cmd_type;
	unsigned int data;
}EC_CNF_MSG;

typedef struct
{
    int    cmd_type;
	unsigned int data;
}EC_IND_MSG;

int ecFuncTestA(int input);
int ecFuncTestB(int input);
int ecFuncTestC(int input);


int ecTestaApi(UINT32 atHandle, QueueHandle_t msgHandle, INT32 cmdType, UINT32 data, CHAR *dataPtr);
int ecTestbApi(UINT32 atHandle, QueueHandle_t msgHandle, INT32 cmdType, UINT32 data, CHAR *dataPtr);
int ecTestcApi(UINT32 atHandle, QueueHandle_t msgHandle, INT32 cmdType, UINT32 data, CHAR *dataPtr);
INT32 ecHandleEGErrCode(UINT32 atHandle, UINT16 errCode);
void ecExecuteRetAck(UINT16 atHandle, UINT16 ackType, AT_EC_RET_TYPE retCode, UINT8 sgId, UINT16 primId, UINT16 primSize, void *primBody);
void ecSendMsg(UINT32 atHandle, QueueHandle_t msgHandle, INT32 cmdType, UINT32 data, CHAR *dataPtr);
void ecFreeMsg(const EC_SEND_Q_MSG *ccMsg);

int custAtDemoTaskInit(void);

#endif
