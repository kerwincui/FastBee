

/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: hal_alarm.c
*
*  Description: api for battery low and high temperature interrupt process
*
*  History: initiated by Zhao Weiqi
*
*  Notes:
*
******************************************************************************/
/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include <string.h>
#include "hal_alarm.h"
#include DEBUG_LOG_HEADER_FILE
#include "alarm.h"
#include "FreeRTOS.h"
#include "cmsis_os2.h"
#include "queue.h"
#include "ic.h"
#include "ec618.h"
#include "slpman.h"
#include "cms_comm.h"
#ifdef FEATURE_AT_ENABLE
#include "atec_alarm_cnf_ind.h"
#endif

extern void delay_us(uint32_t us);

/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/
#define ALARM_TASK_STATK_SIZE    512
#define ALARM_EVENT_QUEUE_SIZE   2

/*----------------------------------------------------------------------------*
 *                    DATA TYPE DEFINITION                                    *
 *----------------------------------------------------------------------------*/
typedef struct {
    alarmMsgType_e msgType;
    alarmMsgInfo_e msgInfo;
} alarmQueueMsg_t;



/*----------------------------------------------------------------------------*
 *                      PRIVATE FUNCTION DECLEARATION                         *
 *----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*
 *                      GLOBAL VARIABLES                                      *
 *----------------------------------------------------------------------------*/
static QueueHandle_t alarmQueueHandle;
static bool alarmTaskExist = false;
static vbatLowCallback_t gAlarmVoltCb = NULL;
static vbatLowCallback_t gAlarmThermCb = NULL;
static alarmParamCfg_t gAlmParamDataBase;



/*----------------------------------------------------------------------------*
 *                      PRIVATE FUNCTIONS                                     *
 *----------------------------------------------------------------------------*/
static void ALM_enterLowPowerStatePrepare(void* pdata, slpManLpState state)
{
    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:
            break;
        default:
            break;
    }
}

static void ALM_exitLowPowerStateRestore(void* pdata, slpManLpState state)
{
    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:
            if(gAlmParamDataBase.voltEnable == true)
            {
                alarmVBatInit(gAlmParamDataBase.voltThd);
            }
            if(gAlmParamDataBase.thermEnable == true)
            {
                alarmThmHighInit(gAlmParamDataBase.thermThd,gAlmParamDataBase.hysterThd);
            }
            if((gAlmParamDataBase.voltEnable == true) || (gAlmParamDataBase.thermEnable == true))
                ECPLAT_PRINTF(UNILOG_PLA_DRIVER, ALM_exitLowPowerStateRestore_1, P_VALUE, "Alarm Func Init: %d,%e<alarmVoltThd> - %d,%e<alarmThmThd>,%e<alarmHysteresisRange>", gAlmParamDataBase.voltEnable, gAlmParamDataBase.voltThd, gAlmParamDataBase.thermEnable, gAlmParamDataBase.thermThd, gAlmParamDataBase.hysterThd);
            break;
        default:
            break;
    }

}

static void thmHigh_interruptHandler(void)
{
    alarmQueueMsg_t msg;
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;
    uint8_t thm_hi = alarmThmGetIntIndicate();

    if(thm_hi)
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, thmHigh_interruptHandler_0, P_WARNING, "Thm Interrupt Enter: Temperature too high");
    else
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, thmHigh_interruptHandler_1, P_VALUE, "Thm Interrupt Enter: Temperature below threshold");

    if(apmuGetImageType() == 1)
    {
        msg.msgType = ALARM_TYPE_THERM;
        if(thm_hi == 1)
            msg.msgInfo = ALARM_INFO_UPWARD;
        else
            msg.msgInfo = ALARM_INFO_DOWNWARD;

        if (alarmQueueHandle)
        {
            if (pdTRUE != xQueueSendFromISR(alarmQueueHandle, &msg, &xHigherPriorityTaskWoken))
            {
                ECPLAT_PRINTF(UNILOG_PLA_DRIVER, thmHigh_interruptHandler_2, P_VALUE, "Alarm message send in isr error");
            }
        }
        else
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, thmHigh_interruptHandler_3, P_VALUE, "Alarm message queue not ready in isr");
        }

        if(xHigherPriorityTaskWoken)
        {
            portYIELD_FROM_ISR(pdTRUE);
        }
    }
    else
    {
        if(gAlarmThermCb!=NULL)
            gAlarmThermCb(thm_hi);
    }

}


static void vbatLow_interruptHandler(void)
{
    alarmQueueMsg_t msg;
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;
    uint8_t vbat_info = alarmVBatGetIntIndicate();

    if(vbat_info == 0)
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, vbatLow_interruptHandler_0, P_WARNING, "Vbat Interrupt Enter: Bat volatage too low");
    else
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, vbatLow_interruptHandler_1, P_VALUE, "Vbat Interrupt Enter: Bat volatage above threshold");

    if(apmuGetImageType() == 1)
    {
        msg.msgType = ALARM_TYPE_VOLT;
        if(vbat_info == 1)
            msg.msgInfo = ALARM_INFO_UPWARD;
        else
            msg.msgInfo = ALARM_INFO_DOWNWARD;

        if (alarmQueueHandle)
        {
            if (pdTRUE != xQueueSendFromISR(alarmQueueHandle, &msg, &xHigherPriorityTaskWoken))
            {
                ECPLAT_PRINTF(UNILOG_PLA_DRIVER, vbatLow_interruptHandler_2, P_VALUE, "Alarm message send in isr error");
            }
        }
        else
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, vbatLow_interruptHandler_3, P_VALUE, "Alarm message queue not ready in isr");
        }

        if(xHigherPriorityTaskWoken)
        {
            portYIELD_FROM_ISR(pdTRUE);
        }
    }
    else
    {
        if(gAlarmVoltCb!=NULL)
            gAlarmVoltCb(vbat_info);
    }

}

static void alarmIndUrcBcast(alarmMsgType_e msgType, alarmInfo *info)
{
#ifdef FEATURE_AT_ENABLE
    MWNvmCfgAlarmParam   param;

    mwNvmCfgGetAlarmParam(&param);
    if(!param.voltUrcEnable) return;

    uint32_t primId = (msgType == ALARM_TYPE_VOLT) ? APPL_ALARM_VOLT_IND : APPL_ALARM_THERM_IND;
    applSendCmsInd(BROADCAST_IND_HANDLER, APPL_ALARM, primId, sizeof(alarmInfo), (void *)info);
#endif
}

static void alarmTask(void *arg)
{
    alarmQueueMsg_t msg;
    alarmInfo       info;

    while(1)
    {
        if (xQueueReceive(alarmQueueHandle, &msg, portMAX_DELAY))
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, alarmTask_1, P_VALUE, "alarmTask: type=%d, info=%d", msg.msgType, msg.msgInfo);

            info.value = msg.msgInfo;
            switch(msg.msgType)
            {
                case ALARM_TYPE_VOLT:
                {
                    alarmIndUrcBcast(ALARM_TYPE_VOLT, &info);

                    if(gAlarmVoltCb!=NULL)
                        gAlarmVoltCb(msg.msgInfo);
                    break;
                }
                case ALARM_TYPE_THERM:
                {
                    alarmIndUrcBcast(ALARM_TYPE_THERM, &info);

                    if(gAlarmThermCb!=NULL)
                        gAlarmThermCb(msg.msgInfo);
                    break;
                }

                default:
                    break;
            }
        }
    }
}

static void alarmThreadInit(void)
{
    if(alarmTaskExist == false)
    {
        alarmTaskExist = true;

        alarmQueueHandle = xQueueCreate(ALARM_EVENT_QUEUE_SIZE, sizeof(alarmQueueMsg_t));
        if(alarmQueueHandle == NULL)
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, alarmThreadInit_1, P_VALUE, "Alarm task queue init error");
        }

        osThreadAttr_t task_attr;
        memset(&task_attr,0,sizeof(task_attr));
        task_attr.name = "almTask";
        task_attr.stack_size = ALARM_TASK_STATK_SIZE;
        task_attr.priority = osPriorityNormal1;
        osThreadNew(alarmTask, NULL, &task_attr);
    }
}


/*----------------------------------------------------------------------------*
 *                      GLOBAL FUNCTIONS                                      *
 *----------------------------------------------------------------------------*/
void alarmVBatInit(uint16_t voltThd)
{
    if(apmuGetImageType() == 1)
        alarmThreadInit();

    alarmVBatHwInit(voltThd);
    delay_us(10);
    XIC_ClearPendingIRQ(PXIC0_PM_VBAT_LOW_IRQn);
    XIC_SetVector(PXIC0_PM_VBAT_LOW_IRQn, vbatLow_interruptHandler);
    XIC_EnableIRQ(PXIC0_PM_VBAT_LOW_IRQn);
}


void alarmVBatDeinit(void)
{
    XIC_DisableIRQ(PXIC0_PM_VBAT_LOW_IRQn);
    alarmVBatHwDeinit();
    delay_us(10);
    XIC_ClearPendingIRQ(PXIC0_PM_VBAT_LOW_IRQn);
}

void alarmThmHighInit(alarmThmThd thmThd, alarmHysteresisRange range)
{
    if(apmuGetImageType() == 1)
        alarmThreadInit();

    alarmThmHwInit(thmThd, range);
    delay_us(10);
    XIC_ClearPendingIRQ(PXIC1_THM_HI_IRQn);
    XIC_SetVector(PXIC1_THM_HI_IRQn, thmHigh_interruptHandler);
    XIC_EnableIRQ(PXIC1_THM_HI_IRQn);

}

void alarmThmHighDeinit(void)
{
    XIC_DisableIRQ(PXIC1_THM_HI_IRQn);
    alarmThmHwDeinit();
    delay_us(10);
    XIC_ClearPendingIRQ(PXIC1_THM_HI_IRQn);

}


void alarmFuncInit(void)        // this function also call in paging
{
    alarmParamCfg_t cfg;
    cfg.voltEnable = true;
    cfg.voltThd = VOLT_THRESHOLD_2200;
    cfg.thermEnable = true;
    cfg.thermThd = THM_THRESHOLD_LEVEL3;
    cfg.hysterThd = THM_HYSTERESIS_40;

    ECPLAT_PRINTF(UNILOG_PLA_DRIVER, alarmFuncInit_1, P_VALUE, "Alarm Func Init: %d,%e<alarmVoltThd> - %d,%e<alarmThmThd>,%e<alarmHysteresisRange>", cfg.voltEnable, cfg.voltThd, cfg.thermEnable, cfg.thermThd, cfg.hysterThd);

    if(cfg.voltEnable)
        alarmVBatInit(cfg.voltThd);

    if(cfg.thermEnable)
        alarmThmHighInit(cfg.thermThd,cfg.hysterThd);

    gAlarmThermCb = NULL;
    gAlarmVoltCb = NULL;

    if(apmuGetImageType() == 1)
    {
        #ifdef PM_FEATURE_ENABLE
        slpManRegisterPredefinedBackupCb(SLP_CALLBACK_ALM_MODULE, ALM_enterLowPowerStatePrepare, NULL);
        slpManRegisterPredefinedRestoreCb(SLP_CALLBACK_ALM_MODULE, ALM_exitLowPowerStateRestore, NULL);
        memcpy(&gAlmParamDataBase, &cfg, sizeof(alarmParamCfg_t));
        #endif
    }

}





