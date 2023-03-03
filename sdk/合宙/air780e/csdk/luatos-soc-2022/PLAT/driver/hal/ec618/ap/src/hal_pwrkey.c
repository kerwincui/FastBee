
/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: pwrkey.c
*
*  Description: power on/off and software debounce
*
*  History: initiated by Zhao Weiqi
*
*  Notes:
*
******************************************************************************/
/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#ifndef FEATURE_BOOTLOADER_PROJECT_ENABLE

#include <string.h>
#include "hal_pwrkey.h"
#include "ec618.h"
#include "FreeRTOS.h"
#include "cmsis_os2.h"
#include "queue.h"
#include "exception_process.h"
#include "reset.h"
#include "apmu_external.h"
#include "slpman.h"

#include DEBUG_LOG_HEADER_FILE


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/
#define PWRKEY_TASK_STATK_SIZE    512
#define PWRKEY_EVENT_QUEUE_SIZE   2
#define PWRKEY_KEY_MESSAGE        0x1

#define PWRKEY_LOCK_SLEEP()       slpManDrvVoteSleep(SLP_VOTE_PWRKEY, SLP_ACTIVE_STATE)
#define PWRKEY_UNLOCK_SLEEP()     slpManDrvVoteSleep(SLP_VOTE_PWRKEY, SLP_SLP1_STATE)

/*----------------------------------------------------------------------------*
 *                    DATA TYPE DEFINITION                                    *
 *----------------------------------------------------------------------------*/

typedef struct {
    uint32_t messageId;
} pwrKeyQueueMsg_t;

typedef void(* pwrKeyIsrCb)(void);


/*----------------------------------------------------------------------------*
 *                      PRIVATE FUNCTION DECLEARATION                         *
 *----------------------------------------------------------------------------*/
static void pwrKeyLongPressTimerExp(void *argument);



/*----------------------------------------------------------------------------*
 *                      GLOBAL VARIABLES                                      *
 *----------------------------------------------------------------------------*/
pwrKeyInfo_t gPwrKeyInfo;
static uint8_t pwrKeyLongPressTimerId = 0;
static uint8_t pwrKeyRepeatTimerId = 0;
static QueueHandle_t pwrKeyEventQueueHandle;
osTimerId_t pwrKeyLongPressTimer;
osTimerId_t pwrKeyRepeatTimer;
pwrKeyIsrCb pwrKeyIsrCallback = NULL;



/*----------------------------------------------------------------------------*
 *                      PRIVATE FUNCTIONS                                     *
 *----------------------------------------------------------------------------*/
void pwrKeySendKeyStatus(void)
{
    uint32_t msgId = PWRKEY_KEY_MESSAGE;
    if (pwrKeyEventQueueHandle)
    {
        if (pdTRUE != xQueueSend(pwrKeyEventQueueHandle, &msgId, 1000))
        {
            ECPLAT_PRINTF(UNILOG_PMU, pwrKeySendKeyStatus_1, P_VALUE, "Power Key message send error");
        }
    }
    else
    {
        ECPLAT_PRINTF(UNILOG_PMU, pwrKeySendKeyStatus_2, P_VALUE, "Power Key queue not ready");
    }
}


void pwrKeySendKeyStatusInIsr(void)
{
    BaseType_t xHigherPriorityTaskWoken;

    xHigherPriorityTaskWoken = pdFALSE;

    uint32_t msgId = PWRKEY_KEY_MESSAGE;

    if (pwrKeyEventQueueHandle)
    {
        if (pdTRUE != xQueueSendFromISR(pwrKeyEventQueueHandle, &msgId, &xHigherPriorityTaskWoken))
        {
            ECPLAT_PRINTF(UNILOG_PMU, pwrKeySendKeyStatusInIsr_1, P_VALUE, "Power Key message send in isr error");
        }
    }
    else
    {
        ECPLAT_PRINTF(UNILOG_PMU, pwrKeySendKeyStatusInIsr_2, P_VALUE, "Power Key queue not ready in isr");
    }

    if(xHigherPriorityTaskWoken)
    {
        portYIELD_FROM_ISR(pdTRUE);
    }
}

static void pwrKeyQueueInit(void)
{
    pwrKeyEventQueueHandle = xQueueCreate(PWRKEY_EVENT_QUEUE_SIZE, sizeof(pwrKeyQueueMsg_t));

    if(pwrKeyEventQueueHandle == NULL)
    {
        ECPLAT_PRINTF(UNILOG_PMU, pwrKeyTask_1, P_VALUE, "Power Key task queue init error");
    }
}

static void pwrKeyTask(void *arg)
{
    uint32_t msgId = 0;
    pwrKeyPressStatus keyStatus = PWRKEY_RELEASE;

    while(1)
    {
        if (xQueueReceive(pwrKeyEventQueueHandle, &msgId, portMAX_DELAY))
        {
            switch(msgId)
            {
                case PWRKEY_KEY_MESSAGE:
                    keyStatus = pwrKeyPopKey(&gPwrKeyInfo);
                    if(gPwrKeyInfo.pwrKeyCallback != NULL)
                    {
                        gPwrKeyInfo.pwrKeyCallback(keyStatus);
                    }
                    if(keyStatus == PWRKEY_PRESS)
                    {
                        if(pwrKeyLongPressTimer == NULL)
                            pwrKeyLongPressTimer = osTimerNew((osTimerFunc_t)pwrKeyLongPressTimerExp, osTimerOnce, (void *)(uint32_t)pwrKeyLongPressTimerId, NULL);
                        osTimerStart(pwrKeyLongPressTimer, gPwrKeyInfo.delayCfg.longPressTimeout);
                    }
                    break;
                default:
                    break;
            }
        }
    }
}


static void pwrKeyTaskInit(void)
{
    osThreadAttr_t task_attr;
    memset(&task_attr,0,sizeof(task_attr));
    task_attr.name = "pwrKeyTask";
    task_attr.stack_size = PWRKEY_TASK_STATK_SIZE;
    task_attr.priority = osPriorityNormal1;
    osThreadNew(pwrKeyTask, NULL, &task_attr);
}

static void pwrKeyLongPressTimerExp(void *argument)
{
    if(gPwrKeyInfo.curStatus == PWRKEY_PRESS)
    {
        gPwrKeyInfo.curStatus = PWRKEY_LONGPRESS;

        pwrKeyPushKey(&gPwrKeyInfo, PWRKEY_LONGPRESS);

        pwrKeySendKeyStatus();

        if(pwrKeyRepeatTimer == NULL)
        {
            pwrKeyRepeatTimer = osTimerNew((osTimerFunc_t)pwrKeyLongPressTimerExp, osTimerOnce, (void *)(uint32_t)pwrKeyRepeatTimerId, NULL);
        }
        osTimerStart(pwrKeyRepeatTimer, gPwrKeyInfo.delayCfg.repeatTimeout);
    }
    else if(gPwrKeyInfo.curStatus == PWRKEY_LONGPRESS)
    {
        pwrKeyPushKey(&gPwrKeyInfo, PWRKEY_REPEAT);

        pwrKeySendKeyStatus();

        EC_ASSERT(pwrKeyRepeatTimer != NULL, 0, 0, 0);

        osTimerStart(pwrKeyRepeatTimer, gPwrKeyInfo.delayCfg.repeatTimeout);
    }

}



static void pwrkeyIntProcess(void)
{
    bool pinlevel = pwrKeyGetPinLevel();

    PWRKEY_LOCK_SLEEP();
    if((gPwrKeyInfo.workMode == PWRKEY_WAKEUP_LOWACTIVE_MODE) ||
        (gPwrKeyInfo.workMode == PWRKEY_PWRON_MODE))
    {
        if(pinlevel == true)
        {
            // release
            gPwrKeyInfo.curStatus = PWRKEY_RELEASE;
            pwrKeyPushKey(&gPwrKeyInfo, PWRKEY_RELEASE);
            PWRKEY_UNLOCK_SLEEP();
            pwrKeySendKeyStatusInIsr();
        }
        else
        {
            gPwrKeyInfo.curStatus = PWRKEY_PRESS;
            pwrKeyPushKey(&gPwrKeyInfo, PWRKEY_PRESS);
            pwrKeySendKeyStatusInIsr();
        }
    }
    else if(gPwrKeyInfo.workMode == PWRKEY_WAKEUP_HIGHACTIVE_MODE)
    {
        if(pinlevel == true)
        {
            gPwrKeyInfo.curStatus = PWRKEY_PRESS;
            pwrKeyPushKey(&gPwrKeyInfo, PWRKEY_PRESS);
            pwrKeySendKeyStatusInIsr();
        }
        else
        {
            gPwrKeyInfo.curStatus = PWRKEY_RELEASE;
            pwrKeyPushKey(&gPwrKeyInfo, PWRKEY_RELEASE);
            PWRKEY_UNLOCK_SLEEP();
            pwrKeySendKeyStatusInIsr();
        }
    }

}

/*----------------------------------------------------------------------------*
 *                      GLOBAL FUNCTIONS                                      *
 *----------------------------------------------------------------------------*/
/* example for pwrKeyCallback :
void powerKeyStatusUpdate(pwrKeyPressStatus status)
{
    ECPLAT_PRINTF(UNILOG_PMU, powerKeyStatusUpdate_1, P_VALUE, "PowerKey Status update to = %d", status);
    if(status == PWRKEY_LONGPRESS)
    {
        pwrKeyStartPowerOff();
    }
}
*/


void pwrKeyIntHandler(void)
{
    if(pwrKeyIsrCallback != NULL)
        pwrKeyIsrCallback();
}



void pwrKeyInit(pwrKeyWorkMode workMode, bool pullUpEn, pwrKeyDly_t dlyCfg, pwrKeyCallback_t Callback)
{
    bool pinlevel = pwrKeyGetPinLevel();

    memset(&gPwrKeyInfo, 0, sizeof(gPwrKeyInfo));
    gPwrKeyInfo.delayCfg = dlyCfg;
    gPwrKeyInfo.workMode = workMode;
    gPwrKeyInfo.curStatus = PWRKEY_RELEASE;
    gPwrKeyInfo.pwrKeyCallback = Callback;

    pwrKeyHwInit(pullUpEn);

    if(workMode == PWRKEY_PWRON_MODE)
    {
        if(pinlevel == false)
        {
            gPwrKeyInfo.curStatus = PWRKEY_PRESS;
        }
    }
    else if(workMode == PWRKEY_WAKEUP_LOWACTIVE_MODE)
    {
        if(pinlevel == false)
        {
            gPwrKeyInfo.curStatus = PWRKEY_PRESS;
        }
    }
    else if(workMode == PWRKEY_WAKEUP_HIGHACTIVE_MODE)
    {
        if(pinlevel == true)
        {
            gPwrKeyInfo.curStatus = PWRKEY_PRESS;
        }
    }

    pwrKeyIsrCallback = pwrkeyIntProcess;

    pwrKeyQueueInit();

    pwrKeyTaskInit();

    NVIC_EnableIRQ(PwrkeyWakeup_IRQn);
}


void pwrKeyDeinit(bool pullUpEn)
{
    memset(&gPwrKeyInfo, 0, sizeof(gPwrKeyInfo));
    pwrKeyHwDeinit(pullUpEn);
    NVIC_DisableIRQ(PwrkeyWakeup_IRQn);

    pwrKeyIsrCallback = NULL;
}

#endif

