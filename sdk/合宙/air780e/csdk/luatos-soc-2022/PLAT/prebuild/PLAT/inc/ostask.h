/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    ostask.h
 * Description:  adpter layer for ps to use os task, queue API
 * History:
 *
 ****************************************************************************/

#ifndef _PS_OSTAS_H
#define _PS_OSTAS_H

#ifndef CORE_IS_CP //for AP

#include "commontypedef.h"
#include "cmsis_os2.h"                // ::CMSIS:RTOS2

#define CMS_TASK_NAME                   "CmsTask"



/******************************************************************************
 *
 * Task STACK size
 *
******************************************************************************/
#define PS_TASK_STACK_SIZE              1536

#define UICC_CTRL_TASK_STACK_SIZE       2048
#define UICC_DRV_TASK_STACK_SIZE        1536

//#define TCPIP_THREAD_STACKSIZE          2048
#define LWIP_TASK_STACK_SIZE            1536


/******************************************************************************
 *
 * Task signal queue size
 *
******************************************************************************/
#define PS_TASK_QUEUE_SIZE              20      // queue size of ps tasks

/******************************************************************************
 *
 * Task priority, from low -> high
 *
******************************************************************************/
#define OTHER_TASK_PRIORITY             osPriorityNormal    /* all APP task priority should <= osPriorityNormal*/


#define CMS_TASK_PRIORITY               osPriorityNormal2

//#define TCPIP_THREAD_PRIO             26   //osPriorityNormal2

#define CCM_TASK_PRIORITY               osPriorityAboveNormal
#define UICC_CTRL_TASK_PRIORITY         osPriorityAboveNormal1
#define CENAS_TASK_PRIORITY             osPriorityAboveNormal2
#define CERRC_TASK_PRIORITY             osPriorityAboveNormal4
#define CEUP_TASK_PRIORITY              osPriorityAboveNormal7

//#define configTIMER_TASK_PRIORITY     40    //osPriorityHigh

#define UICC_DRV_TASK_PRIORITY          osPriorityHigh1     //UICC DRV task should have more high priority




typedef enum OsaTaskIdTag  /* tasks sent to identified by their task ids */
{
    CCM_TASK_ID,            // 0
    NAS_TASK_ID,            // 1
    CERRC_TASK_ID,          // 2
    CEUP_TASK_ID,           // 3
    UICC_CTRL_TASK_ID,      // 4
    UICC_DRV_TASK_ID,       // 5

    CMS_TASK_ID,            // 6, CMS (Communication Modem Service) task

    NUM_OF_REAL_TASKS,

    CEPHY_TASK_ID ,
} OsaTaskId;






/*******************************************************************************
* Typedef     : PsTaskInitDefTag
*
* Type        : structure
* Description : This structure is used to hold information about a task that
*                   needs to be created at run time. This is the base type of
*                   the psTaskInitTable array. NOTE: that this must hold only
*                   things that are known at compile time as the psTaskInitTable
*                   array is marked as constant i.e. in ROM.
*******************************************************************************/
typedef struct PsTaskInitDefTag
{
    /* Member: task id of this task. */
    OsaTaskId               taskId;
    /* Member: void *() entryPoint = Pointer to entry point function for
    **             this task. */
    void                    (*entryPoint)();
    /* Member: void *stack = A pointer to the memory to use for this tasks
    **             stack. */
    void                    *stack;
    /* Member: Int16 stackSize = The number bytes in this tasks stack. */
    INT16                   stackSize;
    /* Member: Int16 priority = The priority of this task. */
    INT16                   priority;

    void        *queue;
    INT16       queueSize;
    const CHAR* taskName;


} PsTaskInitDef;

/** Function prototype for functions callback */
typedef void (*app_callback_fn)(void *ctx);


typedef struct appFunCbTag
{
  app_callback_fn function;
  void *ctx;
} appFunCb;

// number of Message Queue objects
#define MSGQUEUE_OBJECTS   (4)

// message queue element typedef
typedef struct
{
    uint32_t uart_chann;   // current uart chann
    uint32_t recv_cnt;   // current receiver buffer coounter
} msgqueue_obj_t;


/*
 * CMS task create
*/
void CmsTaskAndQCeate(osThreadFunc_t func, UINT32 stackSize, UINT32 queueCount, void *pStackMem, void *pQueueMem);

/*
 * Whether CMS & AT task createds
*/
BOOL CmsTaskIsCreated(void);

/*
 * Get CMS task ID
*/
osThreadId_t CmsTaskGetId(void);


/*
 * create all PS tasks and their associated queues.
*/
void PsInitialiseTasks(BOOL taskCreatedBefore);

void PsOsGetLwipTaskMemory(void **tcbBuf, int *tcbSize, void **stackBuf, int *stackSize);
void registerAppEntry(osThreadFunc_t func, void *arg);


#else

#include "commontypedef.h"
#include "cmsis_os2.h"                // ::CMSIS:RTOS2

/******************************************************************************
 *
 * Task STACK size
 *
******************************************************************************/

#define PHY_HIGH_TASK_STACK_SIZE        1536
#define PHY_MID_TASK_STACK_SIZE         2048        // NOTE: 1536 is not enough, verified by zlfu @20200511
#define PHY_LOW_TASK_STACK_SIZE         1536        // NOTE: 1024 is not enough, verified by zlfu @20200511

//#define TCPIP_THREAD_STACKSIZE          2048
#define LWIP_TASK_STACK_SIZE            1536


/******************************************************************************
 *
 * Task signal queue size
 *
******************************************************************************/

#define PHY_HIGH_TASK_QUEUE_SIZE        10      // queue size of phy tasks
#define PHY_MID_TASK_QUEUE_SIZE         10      // queue size of phy tasks
#define PHY_LOW_TASK_QUEUE_SIZE         10      // queue size of phy tasks



/******************************************************************************
 *
 * Task priority, from low -> high
 *
******************************************************************************/


#define PHY_LOW_TASK_PRIORITY           osPriorityHigh5     //L1 low priority task
#define PHY_MID_TASK_PRIORITY           osPriorityHigh6     //L1 task should have high priority
#define PHY_HIGH_TASK_PRIORITY          osPriorityHigh7     //L1 low priority task


typedef enum OsaTaskIdTag  /* tasks sent to identified by their task ids */
{
    PHY_HIGH_TASK_ID,       // For PHY HwTask Config only

    PHY_MID_TASK_ID,        // L1 task, used for parse message from PS


    PHY_LOW_TASK_ID,        // L1 low priority task



    NUM_OF_REAL_TASKS
} OsaTaskId;






/*******************************************************************************
* Typedef     : PsTaskInitDefTag
*
* Type        : structure
* Description : This structure is used to hold information about a task that
*                   needs to be created at run time. This is the base type of
*                   the psTaskInitTable array. NOTE: that this must hold only
*                   things that are known at compile time as the psTaskInitTable
*                   array is marked as constant i.e. in ROM.
*******************************************************************************/
typedef struct PsTaskInitDefTag
{
    /* Member: TaskId taskId = The GKI task id of this task. */
    OsaTaskId               taskId;
    /* Member: void *() entryPoint = Pointer to entry point function for
    **             this task. */
    void                    (*entryPoint)();
    /* Member: void *stack = A pointer to the memory to use for this tasks
    **             stack. */
    void                    *stack;
    /* Member: Int16 stackSize = The number bytes in this tasks stack. */
    INT16                   stackSize;
    /* Member: Int16 priority = The priority of this task. */
    INT16                   priority;

    void        *queue;
    INT16       queueSize;
    const CHAR* taskName;


} PsTaskInitDef;

/** Function prototype for functions callback */
typedef void (*app_callback_fn)(void *ctx);


typedef struct appFunCbTag
{
  app_callback_fn function;
  void *ctx;
} appFunCb;

// number of Message Queue objects
#define MSGQUEUE_OBJECTS   (4)

// message queue element typedef
typedef struct
{
    uint32_t uart_chann;   // current uart chann
    uint32_t recv_cnt;   // current receiver buffer coounter
} msgqueue_obj_t;


//extern osThreadId_t        psTaskIdTable[NUM_OF_REAL_TASKS];
//extern osMessageQueueId_t  psQueueHandleTable[NUM_OF_REAL_TASKS];

void PsInitialiseTasks(void);
void registerAppEntry(osThreadFunc_t func, void *arg);

#endif

#endif

