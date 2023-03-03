#include "FreeRTOS.h"
#include "queue.h"
#include "task.h"
#include "ps_event_callback.h"
#include "networkmgr.h"
#include "cmips.h"
#include "audio_task.h"
#include "bsp_common.h"
#include "common_api.h"
#include "key_test.h"
#include "led_test.h"
#include "cmimm.h"
// static QueueHandle_t            psEventQueueHandle;
extern QueueHandle_t            audioQueueHandle;

static INT32 PSUrcCallback(PsEventID eventID, void *param, UINT32 paramLen){
    CmiSimImsiStr *imsi = NULL;
    CmiPsCeregInd *creg = NULL;
    UINT8 rssi = 0;
    NmAtiNetInfoInd *netif = NULL;

    switch(eventID){
        case PS_URC_ID_SIM_READY:{
            imsi = (CmiSimImsiStr *)param;
            DBG("SIM ready(imsi=%s len=%d)", imsi->contents, imsi->length);
            audioQueueData simReady = {0};
            simReady.playType = TTS_PLAY;
            simReady.priority = MONEY_PLAY;
            char str[] = "流量卡已就绪"; 
            simReady.message.tts.data = malloc(sizeof(str));
            memcpy(simReady.message.tts.data, str, sizeof(str));
            simReady.message.tts.len = sizeof(str);
            if (pdTRUE != xQueueSend(audioQueueHandle, &simReady, 0))
            {
                DBG("start send audio fail");
            }
            break;
        }
        case PS_URC_ID_SIM_REMOVED:{
            audioQueueData simReady = {0};
            simReady.playType = TTS_PLAY;
            simReady.priority = MONEY_PLAY;
            char str[] = "流量卡未插入"; 
            simReady.message.tts.data = malloc(sizeof(str));
            memcpy(simReady.message.tts.data, str, sizeof(str));
            simReady.message.tts.len = sizeof(str);
            if (pdTRUE != xQueueSend(audioQueueHandle, &simReady, 0))
            {
                DBG("start send audio fail");
            }
            break;
        }
        case PS_URC_ID_MM_SIGQ:{
            CmiMmCesqInd *pMmCesqInd = (CmiMmCesqInd *)param;
            rssi = mmGetCsqRssiFromCesq(pMmCesqInd->rsrp, pMmCesqInd->rsrq, pMmCesqInd->rssiCompensation);
            DBG("RSSI signal=%d", rssi);
            break;
        }
        case PS_URC_ID_PS_BEARER_ACTED:{
            DBG("Default bearer activated");
            break;
        }
        case PS_URC_ID_PS_BEARER_DEACTED:{
            DBG("Default bearer Deactivated");
            break;
        }
        case PS_URC_ID_PS_CEREG_CHANGED:{
            creg = (CmiPsCeregInd *)param;
            DBG("CREG message act:%d celId:%d locPresent:%d state:%d", creg->act, creg->celId, creg->locPresent, creg->state);
            break;
        }
        case PS_URC_ID_PS_NETINFO:{
            netif = (NmAtiNetInfoInd *)param;
            audioQueueData netStatusAudio = {0};
            netStatusAudio.playType = TTS_PLAY;
            netStatusAudio.priority = MONEY_PLAY;
            if (netif->netifInfo.netStatus == NM_NETIF_ACTIVATED){
                DBG("netif acivated");
                char str[] = "网络注册成功"; 
                netStatusAudio.message.tts.data = malloc(sizeof(str));
                memcpy(netStatusAudio.message.tts.data, str, sizeof(str));
                netStatusAudio.message.tts.len = sizeof(str);
            }else if (netif->netifInfo.netStatus == NM_NETIF_OOS){
                DBG("PSIF network OOS");
                 //网络注册失败
            }else if (netif->netifInfo.netStatus == NM_NO_NETIF_OR_DEACTIVATED ||   
                     netif->netifInfo.netStatus == NM_NO_NETIF_NOT_DIAL){         
                char str[] = "网络注册失败"; 
                netStatusAudio.message.tts.data = malloc(sizeof(str));
                memcpy(netStatusAudio.message.tts.data, str, sizeof(str));
                netStatusAudio.message.tts.len = sizeof(str);  
                DBG("PSIF network deactive");
            }
            if (pdTRUE != xQueueSend(audioQueueHandle, &netStatusAudio, 0))
            {
                DBG("start send audio fail");
            }
            break;
        }
        default:
            break;
    }
    return 0;
}


static void ps_callback_task(void)
{
    registerPSEventCallback(PS_GROUP_ALL_MASK, PSUrcCallback);
    while (1){
        vTaskDelay(10000);
    }
    vTaskDelay(NULL);
}

static void demo_task(void *param)
{
    xTaskCreate(ps_callback_task, " ", 256, NULL, 20, NULL);
}
INIT_DRV_EXPORT(audio_task_init, "1");
INIT_TASK_EXPORT(demo_task, "2");
INIT_TASK_EXPORT(key_pad_init, "2");
INIT_TASK_EXPORT(led_task_init, "2");