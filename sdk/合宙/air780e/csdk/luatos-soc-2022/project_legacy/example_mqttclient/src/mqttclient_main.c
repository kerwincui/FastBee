/*
 * Copyright (c) 2022 OpenLuat & AirM2M
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include "bsp.h"
#include "bsp_custom.h"
#include "common_api.h"
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "ps_event_callback.h"
#include "ps_lib_api.h"
#include "cmisim.h"
#include "cmips.h"
#include "slpman.h"

#include "MQTTClient.h"
#include "cmimm.h"


#define MQTT_HOST    	"120.55.137.106"   				// MQTT服务器的地址和端口号
#define MQTT_PORT		1884
#define CLIENT_ID    	"123456789"          
#define USERNAME    	"username"                 
#define PASSWORD    	"password"   

static char mqtt_sub_topic[] = "test_topic";
static char mqtt_pub_topic[] = "test_topic";
static char mqtt_send_payload[] = "hello mqtt_test!!!";

#define QMSG_ID_BASE               (0x160) 
#define QMSG_ID_NW_IPV4_READY      (QMSG_ID_BASE)
#define QMSG_ID_NW_IPV6_READY      (QMSG_ID_BASE + 1)
#define QMSG_ID_NW_IPV4_6_READY    (QMSG_ID_BASE + 2)
#define QMSG_ID_NW_DISCONNECT      (QMSG_ID_BASE + 3)
#define QMSG_ID_SOCK_SENDPKG       (QMSG_ID_BASE + 4)
#define QMSG_ID_SOCK_RECVPKG       (QMSG_ID_BASE + 5)


#define APP_EVENT_QUEUE_SIZE    (10)
static QueueHandle_t            psEventQueueHandle;

static void sendQueueMsg(UINT32 msgId, UINT32 xTickstoWait){
    eventCallbackMessage_t *queueMsg = NULL;
    queueMsg = malloc(sizeof(eventCallbackMessage_t));
    queueMsg->messageId = msgId;
    if (psEventQueueHandle){
        if (pdTRUE != xQueueSend(psEventQueueHandle, &queueMsg, xTickstoWait)){
            DBG("xQueueSend error");
        }
    }
}

static INT32 mqttPSUrcCallback(PsEventID eventID, void *param, UINT32 paramLen){
    CmiSimImsiStr *imsi = NULL;
    CmiPsCeregInd *creg = NULL;
    UINT8 rssi = 0;
    NmAtiNetInfoInd *netif = NULL;

    switch(eventID){
        case PS_URC_ID_SIM_READY:{
            imsi = (CmiSimImsiStr *)param;
            DBG("SIM ready(imsi=%s len=%d)", imsi->contents, imsi->length);
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
            sendQueueMsg(QMSG_ID_NW_DISCONNECT, 0);
            break;
        }
        case PS_URC_ID_PS_CEREG_CHANGED:{
            creg = (CmiPsCeregInd *)param;
            DBG("CREG message act:%d celId:%d locPresent:%d state:%d", creg->act, creg->celId, creg->locPresent, creg->state);
            break;
        }
        case PS_URC_ID_PS_NETINFO:{
            netif = (NmAtiNetInfoInd *)param;
            if (netif->netifInfo.netStatus == NM_NETIF_ACTIVATED){
                DBG("netif acivated");
                sendQueueMsg(QMSG_ID_NW_IPV4_READY, 0);
            }else if (netif->netifInfo.netStatus == NM_NETIF_OOS){
                DBG("PSIF network OOS");
            }else if (netif->netifInfo.netStatus == NM_NO_NETIF_OR_DEACTIVATED ||
                     netif->netifInfo.netStatus == NM_NO_NETIF_NOT_DIAL){
                DBG("PSIF network deactive");
            }
            break;
        }
        default:
            break;
    }
    return 0;
}

void messageArrived(MessageData* data)
{
	DBG("mqtt Message arrived on topic %.*s: %.*s\n", data->topicName->lenstring.len, data->topicName->lenstring.data,
		data->message->payloadlen, data->message->payload);
}

static void mqtt_demo(void){
	int rc = 0;
    static MQTTClient mqttClient;
    static Network n = {0};
    MQTTMessage message;
    MQTTPacket_connectData connectData = MQTTPacket_connectData_initializer;
    connectData.MQTTVersion = 4;
    connectData.clientID.cstring = CLIENT_ID;
    connectData.username.cstring = USERNAME;
    connectData.password.cstring = PASSWORD;
    connectData.keepAliveInterval = 120;
    
    //mqtts的话自行配置Network,详情查看Network结构体
    // n.isMqtts = TRUE;
    // n.timeout_r = 20;
    // n.seclevel = 1;
    // n.ciphersuite[0] = 0xFFFF;
    // n.ignore = 1;

    if ((rc = mqtt_connect(&mqttClient, &n,MQTT_HOST, MQTT_PORT, &connectData)) != 0)
        DBG("mqtt Return code from MQTT mqtt_connect is %d\n", rc);
    
    if ((rc = MQTTSubscribe(&mqttClient, mqtt_sub_topic, 0, messageArrived)) != 0)
        DBG("mqtt Return code from MQTT subscribe is %d\n", rc);
    while(1){
        int len = strlen(mqtt_send_payload);
        message.qos = 1;
		message.retained = 0;
        message.payload = mqtt_send_payload;
        message.payloadlen = len;
        DBG("mqtt_demo send data");
        MQTTPublish(&mqttClient, mqtt_pub_topic, &message);
        osDelay(5000);
    }
}


static void mqttclient_task(void *param){
    eventCallbackMessage_t *queueItem = NULL;
    psEventQueueHandle = xQueueCreate(APP_EVENT_QUEUE_SIZE, sizeof(eventCallbackMessage_t*));
    if (psEventQueueHandle == NULL){
        DBG("psEventQueue create error!");
        return;
    }
    registerPSEventCallback(PS_GROUP_ALL_MASK, mqttPSUrcCallback);
    while(1){
        if (xQueueReceive(psEventQueueHandle, &queueItem, portMAX_DELAY)){
            switch(queueItem->messageId){
                case QMSG_ID_NW_IPV4_READY:
                case QMSG_ID_NW_IPV6_READY:
                case QMSG_ID_NW_IPV4_6_READY:
					mqtt_demo();
                    break;
                case QMSG_ID_NW_DISCONNECT:
                    break;
                default:
                    break;
            }
            free(queueItem);
        }
    }
	vTaskDelete(NULL);
}

static void mqttclient_task_init(void){
	xTaskCreate(mqttclient_task, "", 4096, NULL, 20, NULL);
}

INIT_TASK_EXPORT(mqttclient_task_init, "2");

