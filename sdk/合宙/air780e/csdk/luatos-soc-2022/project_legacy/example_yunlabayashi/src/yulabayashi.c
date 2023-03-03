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

#include "yulabayanshi.h"

char mqtt_subTopic[40];
static char subTopic[]="test20220929/";
static HttpClientContext AirM2mhttpClient;
static QueueHandle_t networkQue;

#define HTTP_RECV_BUF_SIZE      (1501)
#define HTTP_HEAD_BUF_SIZE      (800)
#define QMSG_ID_BASE               (0x160) 
#define QMSG_ID_NW_IPV4_READY      (QMSG_ID_BASE)
#define QMSG_ID_NW_IPV6_READY      (QMSG_ID_BASE + 1)
#define QMSG_ID_NW_IPV4_6_READY    (QMSG_ID_BASE + 2)
#define QMSG_ID_NW_DISCONNECT      (QMSG_ID_BASE + 3)
#define QMSG_ID_SOCK_SENDPKG       (QMSG_ID_BASE + 4)
#define QMSG_ID_SOCK_RECVPKG       (QMSG_ID_BASE + 5)

/*-------------------------------------------------audio define-----------------------------------------------*/
extern const unsigned char audiopoweron[];
extern const int poweron_count;
static osEventFlagsId_t waitAudioPlayDone = NULL;
QueueHandle_t audioQueueHandle = NULL;
static uint8_t audio_sleep_handler = 0xff;
static TimerHandle_t delay_timer;

/*-------------------------------------------------audio define-----------------------------------------------*/

/*-------------------------------------------------FILE-----------------------------------------------*/
#define FILE_NAME "audio.amr"
#define FILE_NAME_SIZE (20)

static void http_audio_File(void *buf, UINT32 BUFF_SIZE)
{
    OsaFremove(FILE_NAME);
    OSAFILE fp = OsaFopen(FILE_NAME, "wb+");
    if (fp == NULL)
    {
        DBG("open file for write, failed");
        return;
    }
    uint32_t ret = OsaFwrite(buf, BUFF_SIZE, 1, fp);
    if (ret != 1)
    {
        DBG("fail to write, excpt 1 but %d", BUFF_SIZE, ret);
    }
    OsaFclose(fp);
    return;
}

/*-------------------------------------------------FILE-----------------------------------------------*/

/*------------------------------------------------audio-----------------------------------------------*/

void audio_data_cb(uint8_t *data, uint32_t len, uint8_t bits, uint8_t channels)
{
    //这里可以对音频数据进行软件音量缩放，或者直接清空来静音
    //软件音量缩放参考HAL_I2sSrcAdjustVolumn
    // int value = 1;
    // int ret = am_kv_get("volume", &value, 1);
    // if(ret > 0)
    // {
    //     DBG("AUDIO GET VOLUME SUCCESS %d", value);
    //     HAL_I2sSrcAdjustVolumn(data, len, value);
    // }
    // else
    // {
    //     DBG("AUDIO GET VOLUME FAIL %d", value);
    //     HAL_I2sSrcAdjustVolumn(data, len, 1);
    // }
    DBG("%x,%d,%d,%d", data, len, bits, channels);
}
void app_pa_on(uint32_t arg)
{
    GPIO_pinWrite(1, 1 << 9, 1 << 9);
}
void audio_event_cb(uint32_t event, void *param)
{
    //	PadConfig_t pad_config;
    //	GpioPinConfig_t gpio_config;
        uint8_t status = usb_portmon_vbuspad_level();
    DBG("%d", event);
    switch (event)
    {
    case MULTIMEDIA_CB_AUDIO_DECODE_START:
        slpManPlatVoteDisableSleep(audio_sleep_handler, SLP_SLP1_STATE);
        GPIO_pinWrite(0, 1 << 12, 1 << 12);
        audio_play_write_blank_raw(0, 6);
        break;
    case MULTIMEDIA_CB_AUDIO_OUTPUT_START:
        xTimerStart(delay_timer, 200);
        break;
    case MULTIMEDIA_CB_TTS_INIT:
        if (4 == sizeof("你好"))
        {
            audio_play_tts_set_param(0, ivTTS_PARAM_INPUT_CODEPAGE, ivTTS_CODEPAGE_GBK);
        }
        else
        {
            audio_play_tts_set_param(0, ivTTS_PARAM_INPUT_CODEPAGE, ivTTS_CODEPAGE_UTF8);
        }
        break;
    case MULTIMEDIA_CB_AUDIO_DONE:
        xTimerStop(delay_timer, 0);
        DBG("audio play done!");
        GPIO_pinWrite(1, 1 << 9, 0);
        GPIO_pinWrite(0, 1 << 12, 0);
        slpManPlatVoteEnableSleep(audio_sleep_handler, SLP_SLP1_STATE);
        osEventFlagsSet(waitAudioPlayDone, WAIT_PLAY_FLAG);
        break;
    }
}
void audio_task(void *param)
{
    audioQueueData audioQueueRecv = {0};
    uint32_t result = 0;
    while (1)
    {
        if (xQueueReceive(audioQueueHandle, &audioQueueRecv, portMAX_DELAY))
        {
            // audio_play_tts_text(0, audioQueueRecv.data, sizeof(audioQueueRecv.data));
            DBG("this is play priority %d", audioQueueRecv.priority);
            DBG("this is play playType %d", audioQueueRecv.playType);
            if (audioQueueRecv.priority == MONEY_PLAY)
            {
                
                if (audioQueueRecv.playType == TTS_PLAY)
                {
                    // DBG("TEST data address %d", sizeof(audioQueueRecv.message.data));
                    audio_play_tts_text(0, audioQueueRecv.message.tts.data, audioQueueRecv.message.tts.len);
                }
                else if (audioQueueRecv.playType == FILE_PLAY)
                {
                    DBG("TEST address 2 %p", audioQueueRecv.message.file.info);
                    audio_play_multi_files(0, audioQueueRecv.message.file.info, audioQueueRecv.message.file.count);
                }
            }
            else if (audioQueueRecv.priority == PAD_PLAY)
            {
            }
            result = osEventFlagsWait(waitAudioPlayDone, WAIT_PLAY_FLAG, osFlagsWaitAll, 20000);
            if (audioQueueRecv.playType == TTS_PLAY) {
                DBG("FREE MY AUDIO TTS");
                free(audioQueueRecv.message.tts.data);
            }
            else if(audioQueueRecv.playType == FILE_PLAY)
            {
                free(audioQueueRecv.message.file.info);
                DBG("FREE MY AUDIO FILE");
            }
            // volume++;
            
        }
    }
    vTaskDelete(NULL);
}

void audio_task_init(void)
{
    GpioPinConfig_t gpio_config;
    gpio_config.pinDirection = GPIO_DIRECTION_OUTPUT;
    gpio_config.misc.initOutput = 0;
    GPIO_pinConfig(0, 12, &gpio_config);

    PadConfig_t config;
    PAD_getDefaultConfig(&config);
    config.mux = PAD_MUX_ALT0;
    PAD_setPinConfig(45, &config);

    GPIO_pinConfig(1, 9, &gpio_config);

    ivCStrA sdk_id = AISOUND_SDK_USERID;
    slpManSetPmuSleepMode(true, SLP_SLP1_STATE, false);
    slpManApplyPlatVoteHandle("audio", &audio_sleep_handler);

    slpManPlatVoteDisableSleep(audio_sleep_handler, SLP_SLP2_STATE);
    delay_timer = xTimerCreate(NULL, 200, 0, 0, app_pa_on);

    audio_play_global_init(audio_event_cb, audio_data_cb, NULL);
    audio_play_tts_set_resource(ivtts_16k_lite, sdk_id);
    //现在使用ES7149/ES7148，用如下配置，如果不是，请根据实际情况配置，bus_id直接写0
    // Audio_CodecI2SInit(0, I2S_MODE_I2S, I2S_FRAME_SIZE_16_16);
    //如下配置可使用TM8211

    Audio_CodecI2SInit(0, I2S_MODE_MSB, I2S_FRAME_SIZE_16_16);
    if (waitAudioPlayDone == NULL)
    {
        waitAudioPlayDone = osEventFlagsNew(NULL);
    }
    audioQueueHandle = xQueueCreate(100, sizeof(audioQueueData));
    audioQueueData powerOn = {0};
    powerOn.playType = TTS_PLAY;
    powerOn.priority = MONEY_PLAY;
    char str[] = "正在开机"; 
    powerOn.message.tts.data = malloc(sizeof(str));
    memcpy(powerOn.message.tts.data, str, sizeof(str));
    powerOn.message.tts.len = sizeof(str);
    if (pdTRUE != xQueueSend(audioQueueHandle, &powerOn, 0))
    {
        DBG("start send audio fail");
    }
    xTaskCreate(audio_task, " ", 2048, NULL, 20, NULL);
}
/*------------------------------------------------audio-----------------------------------------------*/
/*------------------------------------------------http------------------------------------------------*/
HTTPResult AirM2mGethttp(CHAR *getUrl, CHAR *buf, UINT32 len)
{
    HttpClientData    clientData = {0};
    HTTPResult result=HTTP_INTERNAL;
    //AirM2mhttpClient.timeout_r=20;
    // AirM2mhttpClient.timeout_s=2;
    clientData.headerBuf = malloc(HTTP_HEAD_BUF_SIZE);
    clientData.headerBufLen = HTTP_HEAD_BUF_SIZE;
    clientData.respBuf = buf;
    clientData.respBufLen = len;
    result=httpGet(&AirM2mhttpClient,getUrl,&clientData,20);
    return result;
}
/*------------------------------------------------http------------------------------------------------*/
/*------------------------------------------------MQTT------------------------------------------------*/
void messageArrived(MessageData *data)
{
    audioQueueData audiodata = {0};
    HTTPResult result;
    CHAR url[200];
    char *p = (char *)data->message->payload;
    memcpy(url, p + 5, p[4] + 1);
    for (size_t i = 0; i < p[4]; i++)
    {
        /* code */
        DBG("my test mqtt url %c", url[i]);
    }
    if (p[0] == 0)
    {
        audiodata.playType = TTS_PLAY;
        audiodata.priority = MONEY_PLAY;
        audiodata.message.tts.data = malloc(sizeof(url));
        memcpy(audiodata.message.tts.data, url, sizeof(url));
        audiodata.message.tts.len = sizeof(url);
        if (pdTRUE != xQueueSend(audioQueueHandle, &audiodata, 0))
        {
            DBG("start send audio fail");
        }
    }
    else
    {
        char *recvBuf = malloc(HTTP_RECV_BUF_SIZE);
        result = AirM2mGethttp(url,recvBuf, HTTP_RECV_BUF_SIZE);
        if (result == HTTP_OK)
        {
            DBG("http chengong");
            DBG("http ceshi %s", recvBuf);
            http_audio_File(recvBuf, sizeof(recvBuf));
            audiodata.priority = MONEY_PLAY;
            audiodata.playType = FILE_PLAY;
            audiodata.message.file.info=(audio_play_info_t *)calloc(1, sizeof(audio_play_info_t));
            audiodata.message.file.info->path = FILE_NAME;
            audiodata.message.file.count = 1;
            if (pdTRUE != xQueueSend(audioQueueHandle, &audiodata, 0))
            {
                DBG("start send audio fail");
            }
        }
    }
}

static void mqtt_demo(void){
	int rc = 0;
    MQTTClient mqttClient;
    static Network n = {0};
    MQTTPacket_connectData connectData = MQTTPacket_connectData_initializer;
    connectData.MQTTVersion = 4;
    connectData.clientID.cstring = client_id;
    connectData.username.cstring = User;
    connectData.password.cstring = Password;
    connectData.keepAliveInterval = 120;
    if ((rc = mqtt_connect(&mqttClient, &n,HOST, PORT, &connectData)) != 0)
        DBG("mqtt Return code from MQTT mqtt_connect is %d\n", rc);
    
    if ((rc = MQTTSubscribe(&mqttClient, mqtt_subTopic, 0, messageArrived)) != 0)
        DBG("mqtt Return code from MQTT subscribe is %d\n", rc);
    while (1)
    {
        osDelay(5000);
    }
    
   
}

static void sendQueueMsg(UINT32 msgId, UINT32 xTickstoWait)
{
    eventCallbackMessage_t *queueMsg = NULL;
    queueMsg = malloc(sizeof(eventCallbackMessage_t));
    queueMsg->messageId = msgId;
    if (networkQue)
    {
        if (pdTRUE != xQueueSend(networkQue, &queueMsg, xTickstoWait))
        {
            DBG("xQueueSend error");
        }
    }
}
static INT32 Networkcall(PsEventID eventId, void *param, UINT32 paramLen)
{
    NmAtiNetInfoInd *netif = NULL;
    switch (eventId)
    {
    case PS_URC_ID_PS_NETINFO:
    {
        netif = (NmAtiNetInfoInd *)param;
        if (netif->netifInfo.netStatus == NM_NETIF_ACTIVATED)
        {
            DBG("netif acivated");
            sendQueueMsg(QMSG_ID_NW_IPV4_READY, 0);
        }
        else if (netif->netifInfo.netStatus == NM_NETIF_OOS)
        {
            DBG("PSIF network OOS");
        }
        else if (netif->netifInfo.netStatus == NM_NO_NETIF_OR_DEACTIVATED || netif->netifInfo.netStatus == NM_NO_NETIF_NOT_DIAL)
        {
            DBG("PSIF network deactive");
        }
        break;
    }

    case PS_URC_ID_PS_BEARER_DEACTED:
    {
        DBG("Default bearer Deactivated");
        sendQueueMsg(QMSG_ID_NW_DISCONNECT, 0);
        break;
    }
    default:
        break;
    }
    return 0;
}

static void MQTT_Task(void *param)
{
    CHAR imei[20] = {0};
    CmsRetId ack = appGetImeiNumSync(imei);
    if (CMS_RET_SUCC == ack)
    {
        DBG("GetImei_succeed %s", imei);
        sprintf(mqtt_subTopic, "%s%s", subTopic, imei);
        DBG("Get_Mqtt_subTopic %s", mqtt_subTopic);
    }
    else
    {
        DBG("GetImei_Fail");
    }
    eventCallbackMessage_t *quItem = NULL;
    networkQue = xQueueCreate(10, sizeof(eventCallbackMessage_t *));
    if (networkQue == NULL)
    {
        DBG("xQueueCreate_Fail");
        return;
    }
    registerPSEventCallback(PS_GROUP_ALL_MASK, Networkcall);
    while (1)
    {
        if (xQueueReceive(networkQue, &quItem, portMAX_DELAY))
        {
            switch (quItem->messageId)
            {
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
            free(quItem);
        }
    }
    vTaskDelete(NULL);
}

static void mqttclient_task_init(void){
	xTaskCreate(MQTT_Task, "", 4096, NULL, 20, NULL);
}

/*------------------------------------------------MQTT------------------------------------------------*/

INIT_TASK_EXPORT(mqttclient_task_init, "2");
INIT_TASK_EXPORT(audio_task_init, "3");

