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
#include "cJSON.h"
#include "MQTTClient.h"
#include "audio_task.h"
#include "audioFile.h"
#include "audio_play.h"
#include "math.h"
#include "charge_management.h"
#include "key_pad.h"
#include "am_kv.h"
#include "led_task.h"
#include "plat_config.h"
#include "fdb_init.h"
#include "cmimm.h"
extern QueueHandle_t audioQueueHandle;

#define MQTT_HOST    	"lbsmqtt.airm2m.com"   				// MQTT服务器的地址和端口号
#define MQTT_PORT		 1884
#define CLIENT_ID    	"123456789"          
#define USERNAME    	"username"                 
#define PASSWORD    	"password"   

const static char mqtt_sub_topic[] = "/sub/topic/money";    //订阅的主题
const static char mqtt_pub_topic[] = "/pub/topic/message";  //发布的主题
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
static bool netStatus = false;
static bool serverStatus = false;

bool getNetStatus()
{
    return netStatus;
}
bool getServerStatus()
{
    return serverStatus;
}
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
int fomatMoney(int num, audioQueueData *data, int *index, BOOL flag)
{
     uint32_t  audioArray[10][2] = 
     {
         {audio0,   sizeof(audio0)},
         {audio1,   sizeof(audio1)},
         {audio2,   sizeof(audio2)},
         {audio3,   sizeof(audio3)},
         {audio4,   sizeof(audio4)},
         {audio5,   sizeof(audio5)},
         {audio6,   sizeof(audio6)},
         {audio7,   sizeof(audio7)},
         {audio8,   sizeof(audio8)},
         {audio9,   sizeof(audio9)}
    };
    int thousand = (num - num % 1000) / 1000;
    int hundred = ((num % 1000) - ((num % 1000) % 100)) / 100;
    int ten = ((num % 100) - ((num % 100) % 10)) / 10;
    int unit = num % 10;
    if (thousand == 0)
    {
        thousand = -1;
        if (hundred == 0)
        {
            hundred = -1;
            if (ten == 0)
            {
                ten = -1;
                if (unit == 0)
                {
                    unit = -1;
                }
            }
        }
    }
    if (unit == 0)
    {
        unit = -1;
        if (ten == 0)
        {
            ten = -1;
            if (hundred == 0)
            {
                hundred = -1;
                if (thousand == 0)
                {
                    thousand = -1;
                }
            }
        }
    }
    if (ten == 0 && hundred == 0)
    {
        ten = -1;
    }
    if (thousand != -1)
    {
        if (flag)
        {
            data->message.file.info[*index].path = NULL; 
            data->message.file.info[*index].address = audioArray[thousand][0];
            data->message.file.info[*index].rom_data_len = audioArray[thousand][1];
        }
        *index += 1;
        if (flag)
        {
            data->message.file.info[*index].path = NULL; 
            data->message.file.info[*index].address = audio1000;
            data->message.file.info[*index].rom_data_len = sizeof(audio1000);
        }
        *index += 1;
    }
    if (hundred != -1)
    {
        if(flag)
        {
            data->message.file.info[*index].path = NULL; 
            data->message.file.info[*index].address = audioArray[hundred][0];
            data->message.file.info[*index].rom_data_len = audioArray[hundred][1];
        }
        *index += 1;
        if(flag)
        {
            data->message.file.info[*index].path = NULL; 
            data->message.file.info[*index].address = audio100;
            data->message.file.info[*index].rom_data_len = sizeof(audio100);
        }
        *index += 1;
    }
    if (ten != -1)
    {
        if (!(ten == 1 && hundred == -1 && thousand == -1))
        {
            if(flag)
            {
                data->message.file.info[*index].path = NULL; 
                data->message.file.info[*index].address = audioArray[ten][0];
                data->message.file.info[*index].rom_data_len = audioArray[ten][1];
            }
            *index += 1;
        }
        DBG("333  %d\r\n", *index);
        if (ten != 0)
        {
            if(flag)
            {
                data->message.file.info[*index].path = NULL; 
                data->message.file.info[*index].address = audio10;
                data->message.file.info[*index].rom_data_len = sizeof(audio10);
            }
            *index += 1;
        }
    }
    if (unit != -1)
    {
        if(flag)
        {
            data->message.file.info[*index].path = NULL; 
            data->message.file.info[*index].address = audioArray[unit][0];
            data->message.file.info[*index].rom_data_len = audioArray[unit][1];
        }
        *index += 1;
    }
    return 0;
}
static int strToFile(char *money, audioQueueData *data, int *index, bool flag)
{
    if (flag)
    {
        data->message.file.info[*index].address  = audiozhifubao;
        data->message.file.info[*index].rom_data_len  = sizeof(audiozhifubao);
    }
    *index += 1;
     uint32_t  audioArray[10][2] = 
     {
         {audio0, sizeof(audio0)},
         {audio1, sizeof(audio1)},
         {audio2, sizeof(audio2)},
         {audio3, sizeof(audio3)},
         {audio4, sizeof(audio4)},
         {audio5, sizeof(audio5)},
         {audio6, sizeof(audio6)},
         {audio7, sizeof(audio7)},
         {audio8, sizeof(audio8)},
         {audio9, sizeof(audio9)}
    };
    int count = 0;
    int integer = 0;
    char *str = NULL;
    char intStr[8] = {0};
    char decStr[3] = {0};
    str = strstr(money, ".");
    if (str != NULL)
    {
        memcpy(intStr, money, str - money);
        str = str + 1;
        memcpy(decStr, str, 2);
        integer = atoi(intStr);
    }
    else
    {
        integer = atoi(money);
    }
    if (integer >= 10000)
    {
        int filecount = fomatMoney(integer / 10000, data, index, flag);
        //TODO 待处理两万
        if (flag)
        {
            data->message.file.info[*index].path = NULL; 
            data->message.file.info[*index].address = audio10000;
            data->message.file.info[*index].rom_data_len = sizeof(audio10000);
        }
        *index += 1;
        if (((integer % 10000) < 1000) && ((integer % 10000) != 0))
        {
            if (flag)
            {
                data->message.file.info[*index].path = NULL; 
                data->message.file.info[*index].address = audioArray[0][0];
                data->message.file.info[*index].rom_data_len = audioArray[0][1];
            }
            *index += 1;
        }
    }
    if ((integer % 10000) > 0)
    {
        int filecount = fomatMoney(integer % 10000, data, index, flag);
        //TODO 待处理两千
        // if()
        // if (flag)
        // {
        //     data->message.file.info[*index].path = NULL; 
        //     data->message.file.info[*index].address = audioK;
        //     data->message.file.info[*index].rom_data_len = sizeof(audioK);
        // }
        // *index += 1;
        // count += filecount;
    }
    if (*index == 1)
    {
        if (flag)
        {
            data->message.file.info[*index].path = NULL; 
            data->message.file.info[*index].address = audioArray[0][0];
            data->message.file.info[*index].rom_data_len = audioArray[0][1];
        }
        *index += 1;
    }
    int decial = atoi(decStr);
    if (decial > 0)
    {
        if (flag)
        {
            data->message.file.info[*index].path = NULL; 
            data->message.file.info[*index].address = audiodot;
            data->message.file.info[*index].rom_data_len = sizeof(audiodot);
        }
        *index += 1;
        if (decial > 10)
        {
            int ten = decial / 10;
            int unit = decial % 10;
            if (ten != 0 && unit != 0)
            {
                if (flag)
                {
                    data->message.file.info[*index].path = NULL; 
                    data->message.file.info[*index].address = audioArray[ten][0];
                    data->message.file.info[*index].rom_data_len = audioArray[0][1];
                }
                *index += 1;
                if(flag)
                {
                    data->message.file.info[*index].path = NULL; 
                    data->message.file.info[*index].address = audioArray[unit][0];
                    data->message.file.info[*index].rom_data_len = audioArray[0][1];
                }
                *index += 1;
            }
            else if(ten == 0 && unit!=0)
            {
                if (flag)
                {
                    data->message.file.info[*index].path = NULL; 
                    data->message.file.info[*index].address = audioArray[0][0];
                    data->message.file.info[*index].rom_data_len = audioArray[0][1];
                }
                *index += 1;
                if(flag)
                {
                    data->message.file.info[*index].path = NULL; 
                    data->message.file.info[*index].address = audioArray[unit][0];
                    data->message.file.info[*index].rom_data_len = audioArray[0][1];
                }
                *index += 1;
            }
            else if(ten !=0 && unit == 0)
            {
                if (flag)
                {
                    data->message.file.info[*index].path = NULL; 
                    data->message.file.info[*index].address = audioArray[0][0];
                    data->message.file.info[*index].rom_data_len = audioArray[0][1];
                }
                *index += 1;
            }
        }
        else
        {
            if (flag)
            {
                data->message.file.info[*index].path = NULL; 
                data->message.file.info[*index].address = audioArray[decial][0];
                data->message.file.info[*index].rom_data_len = audioArray[decial][1];
            }
            *index += 1;
        }
    }
    if (flag)
    {
        data->message.file.info[*index].path = NULL; 
        data->message.file.info[*index].address = audioyuan;
        data->message.file.info[*index].rom_data_len = sizeof(audioyuan);
    }
    *index += 1;
    return count;
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
            netStatus = true;
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
                serverStatus = true;
                netStatus = true;
                DBG("netif acivated");
                sendQueueMsg(QMSG_ID_NW_IPV4_READY, 0);
            }else if (netif->netifInfo.netStatus == NM_NETIF_OOS){
                DBG("PSIF network OOS");
            }else if (netif->netifInfo.netStatus == NM_NO_NETIF_OR_DEACTIVATED ||
                     netif->netifInfo.netStatus == NM_NO_NETIF_NOT_DIAL){
                serverStatus = false;
                netStatus = false;
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
    if (memcmp(mqtt_sub_topic, data->topicName->lenstring.data, strlen(mqtt_sub_topic)) == 0)
    {
        cJSON *boss = NULL;
        DBG("mqtt Message arrived on topic %.*s: %.*s\n", data->topicName->lenstring.len, data->topicName->lenstring.data, data->message->payloadlen, data->message->payload);
        boss = cJSON_Parse((const char *)data->message->payload);
        if (boss == NULL){
            DBG("cjson parse fail");
        }
        else
        {
            DBG("cjson parse success");
            cJSON *money = cJSON_GetObjectItem(boss, "money");
            if(money == NULL)
            {
                DBG("Missing amount field %d", money);
                return 0;
            }
            if (cJSON_IsString(money))
            {
                audioQueueData moneyPlay = {0};
                moneyPlay.priority = MONEY_PLAY;
                moneyPlay.playType = FILE_PLAY;
                char* str = strstr(money->valuestring, ".");
                //判断金额长度是否大于8个，也就是千万级别的金额，如果是，则播报收款成功，如果不是，则播报对应金额，这里并未对金额字段做合法性判断
                if (str != NULL)
                {
                    if((str - money->valuestring) > 8)
                    {
                        moneyPlay.message.file.info = (audio_play_info_t *)calloc(1, sizeof(audio_play_info_t));
                        moneyPlay.message.file.info->address = audioshoukuanchenggong;
                        moneyPlay.message.file.info->rom_data_len = audioshoukuanchenggongSize;
                        moneyPlay.message.file.count = 1;
                    }
                    else
                    {
                        //调用strToFile来将金额格式化为对应的文件播报数据，需要调用两次，第一次获取需要malloc的空间，第二次将文件数据放进空间里
                        int index = 0;
                        strToFile(money->valuestring, &moneyPlay, &index, false);
                        moneyPlay.message.file.info = (audio_play_info_t *)calloc(index, sizeof(audio_play_info_t));
                        index = 0;
                        strToFile(money->valuestring, &moneyPlay, &index, true);
                        moneyPlay.message.file.count = index;
                    }
                }
                else
                {
                    if(strlen(money->valuestring) > 8)
                    {
                        moneyPlay.message.file.info = (audio_play_info_t *)calloc(1, sizeof(audio_play_info_t));
                        moneyPlay.message.file.info->address = audioshoukuanchenggong;
                        moneyPlay.message.file.info->rom_data_len = audioshoukuanchenggongSize;
                        moneyPlay.message.file.count = 1;
                    }
                    else
                    {
                        str++;
                        if(strlen(str) > 2)
                        {
                            moneyPlay.message.file.info = (audio_play_info_t *)calloc(1, sizeof(audio_play_info_t));
                            moneyPlay.message.file.info->address = audioshoukuanchenggong;
                            moneyPlay.message.file.info->rom_data_len = audioshoukuanchenggongSize;
                            moneyPlay.message.file.count = 1;
                        }
                        else
                        {
                            //调用strToFile来将金额格式化为对应的文件播报数据，需要调用两次，第一次获取需要malloc的空间，第二次将文件数据放进空间里
                            int index = 0;
                            strToFile(money->valuestring, &moneyPlay, &index, false);
                            moneyPlay.message.file.info = (audio_play_info_t *)calloc(index, sizeof(audio_play_info_t));
                            index = 0;
                            strToFile(money->valuestring, &moneyPlay, &index, true);
                            moneyPlay.message.file.count = index;
                        }
                    }
                }
                if (pdTRUE != xQueueSend(audioQueueHandle, &moneyPlay, 0)){
                    DBG("mqttsub xQueueSend error");
                }
            }
            else
            {
                DBG("money data is invalid %d", cJSON_IsString(money));
            }
        }
        cJSON_Delete(boss);
    }
}

static void mqtt_demo(void){
	int rc = 0;
    MQTTClient mqttClient = {0};
    Network mqttNetwork = {0};

    MQTTMessage message = {0};
    MQTTPacket_connectData connectData = MQTTPacket_connectData_initializer;
    connectData.MQTTVersion = 4;
    int ret = 0;
    char str[32] = {0};
    char clientId[17] = {0};
    char username[17] = {0};
    char password[17] = {0};
    ret = am_kv_get("clientId", str, 17);           //从数据库中读取clientId，如果没读到，则用默认的
    if(ret > 0 )
    {
        memcpy(clientId, str, 17);
        connectData.clientID.cstring = clientId;
    }
    else
    {
        connectData.clientID.cstring = CLIENT_ID;
    }
    memset(str, 0, 32);
    ret = am_kv_get("username", str, 17);           //从数据库中读取username，如果没读到，则用默认的
    if(ret > 0 )
    {
        memcpy(username, str, 17);
        connectData.username.cstring = username;
    }
    else
    {
        connectData.username.cstring = USERNAME;
    }
    memset(str, 0, 32);
    ret = am_kv_get("password", str, 17);           //从数据库中读取password，如果没读到，则用默认的
    if(ret > 0 )
    {
        memcpy(password, str, 17);
        connectData.password.cstring = password;
    }
    else
    {
        connectData.password.cstring = PASSWORD;
    }
    memset(str, 0, 32);
    DBG("test clientid %s", clientId);
    DBG("test username %s", username);
    DBG("test password %s", password);
    
    connectData.keepAliveInterval = 120;

    mqtt_connect(&mqttClient, &mqttNetwork, MQTT_HOST, MQTT_PORT, &connectData);

    if ((rc = MQTTSubscribe(&mqttClient, mqtt_sub_topic, 0, messageArrived)) != 0)
        {
        DBG("mqtt Return code from MQTT subscribe is %d\n", rc);
            serverStatus = false;
        }
        else
        {
            serverStatus = true;
            audioQueueData welcome = {0};
            welcome.playType = TTS_PLAY;
            welcome.priority = MONEY_PLAY;
            char str[] = "服务器连接成功"; 
            welcome.message.tts.data = malloc(sizeof(str));
            memcpy(welcome.message.tts.data, str, sizeof(str));
            welcome.message.tts.len = sizeof(str);
            if (pdTRUE != xQueueSend(audioQueueHandle, &welcome, 0)){
                DBG("mqttsub xQueueSend error");
            }
        }
    
    while(1){
        int len = strlen(mqtt_send_payload);
        message.qos = 1;
		message.retained = 0;
        message.payload = mqtt_send_payload;
        message.payloadlen = len;
        DBG("mqtt_demo send data");
        MQTTPublish(&mqttClient, mqtt_pub_topic, &message);
#if !defined(MQTT_TASK)
		if ((rc = MQTTYield(&mqttClient, 1000)) != 0)
			DBG("mqtt_demo Return code from yield is %d\n", rc);
#endif
        osDelay(60000);
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
extern void usb_data_init(void);
INIT_HW_EXPORT(usb_data_init, "1");
INIT_DRV_EXPORT(fdb_init, "2");
INIT_TASK_EXPORT(mqttclient_task_init, "2");
INIT_TASK_EXPORT(audio_task_init, "2");
INIT_TASK_EXPORT(key_pad_init, "2");
INIT_TASK_EXPORT(charge_init, "2");
INIT_TASK_EXPORT(led_task_init, "2");
