#include "web_audio.h"
#include "audio_Task.h"
#include "net_led_Task.h"

extern QueueHandle_t audioQueueHandle;
extern uint8_t link_UP;
char mqtt_subTopic[40];
static char subTopic[] = "test20220929/";

static HttpClientContext AirM2mhttpClient;

#define HTTP_RECV_BUF_SIZE      (11520)
#define HTTP_HEAD_BUF_SIZE      (800)

/*------------------------------------------------http------------------------------------------------*/
static INT32 httpGetData(CHAR *getUrl, CHAR *buf, UINT32 len)
{
    HTTPResult result = HTTP_INTERNAL;
    HttpClientData    clientData = {0};
    UINT32 count = 0;
    uint16_t headerLen = 0;

    LUAT_DEBUG_ASSERT(buf != NULL,0,0,0);

    clientData.headerBuf = malloc(HTTP_HEAD_BUF_SIZE);
    clientData.headerBufLen = HTTP_HEAD_BUF_SIZE;
    clientData.respBuf = buf;
    clientData.respBufLen = len;
    result = httpSendRequest(&AirM2mhttpClient, getUrl, HTTP_GET, &clientData);
    LUAT_DEBUG_PRINT("send request result=%d", result);
    if (result != HTTP_OK)
        goto exit;
    do {
    	LUAT_DEBUG_PRINT("recvResponse loop.");
        memset(clientData.headerBuf, 0, clientData.headerBufLen);
        memset(clientData.respBuf, 0, clientData.respBufLen);
        result = httpRecvResponse(&AirM2mhttpClient, &clientData);
        if(result == HTTP_OK || result == HTTP_MOREDATA){
            headerLen = strlen(clientData.headerBuf);
            if(headerLen > 0)
            {
            	LUAT_DEBUG_PRINT("total content length=%d", clientData.recvContentLength);
            }

            if(clientData.blockContentLen > 0)
            {
            	LUAT_DEBUG_PRINT("response content:{%s}", (uint8_t*)clientData.respBuf);
            }
            count += clientData.blockContentLen;
            LUAT_DEBUG_PRINT("has recv=%d", count);
        }
    } while (result == HTTP_MOREDATA || result == HTTP_CONN);

    LUAT_DEBUG_PRINT("result=%d", result);
    if (AirM2mhttpClient.httpResponseCode < 200 || AirM2mhttpClient.httpResponseCode > 404)
    {
    	LUAT_DEBUG_PRINT("invalid http response code=%d",AirM2mhttpClient.httpResponseCode);
    } else if (count == 0 || count != clientData.recvContentLength) {
    	LUAT_DEBUG_PRINT("data not receive complete");
    } else {
    	LUAT_DEBUG_PRINT("receive success");
    }
exit:
    free(clientData.headerBuf);
    return result;
}

static void task_test_https(CHAR *getUrl, uint16_t *buf, UINT32 len)
{
    //HttpClientData    clientData = {0};
	//char *recvBuf = malloc(HTTP_RECV_BUF_SIZE);
	HTTPResult result = HTTP_INTERNAL;
    
    result = httpConnect(&AirM2mhttpClient,getUrl);
    if (result == HTTP_OK)
    {
        httpGetData(getUrl, buf, len);
        httpClose(&AirM2mhttpClient); 
    }
    else
    {
        LUAT_DEBUG_PRINT("http client connect error");
    }
}
void messageArrived(MessageData *data)
{
    luat_audio_play_info_t info[1];
    memset(info, 0, sizeof(info));
    static uint32_t *tmpbuff[HTTP_RECV_BUF_SIZE]={0};
    uint32_t status;
    LUAT_DEBUG_PRINT("mqtt Message arrived on topic %d%s: %d%s", data->topicName->lenstring.len, data->topicName->lenstring.data, data->message->payloadlen, data->message->payload);
    char *p = (char *)data->message->payload;
    uint8_t payload_len = data->message->payloadlen;
    for (size_t i = 0; i < data->message->payloadlen; i++)
    {
        LUAT_DEBUG_PRINT("ceshi%c", p[i]);
    }
    if (p[0] == 0)
    {
        uint16_t TTS_Len = p[4];
        CHAR *TTS=malloc(TTS_Len*sizeof(char));
        if (TTS_Len == payload_len - 5)
        {
            memcpy(TTS, p + 5, TTS_Len);
            luat_audio_play_tts_text(0, TTS, TTS_Len);
        }
        else
        {
            int URL_Len = p[9 + TTS_Len];
            CHAR *URL=malloc(URL_Len*sizeof(char));
            memset(URL,'\0',URL_Len*sizeof(char));
            memcpy(TTS, p + 5, TTS_Len);
            memcpy(URL, p + 10 + TTS_Len, URL_Len);
            task_test_https(URL, tmpbuff, HTTP_RECV_BUF_SIZE);
            info[0].path = NULL;
            info[0].address = (uint32_t)tmpbuff;
            info[0].rom_data_len = sizeof(tmpbuff);
            luat_audio_play_tts_text(0, TTS, TTS_Len);
            luat_rtos_task_sleep(2000);
            luat_audio_play_multi_files(0, info, 1);
            free(URL);
        }
        luat_rtos_task_sleep(2000);
        free(TTS);
        
    }
    else if (p[0] == 1)
    {
        uint16_t URL_Len = p[4];
        CHAR *URL=malloc(URL_Len*sizeof(char));
        memset(URL,'\0',URL_Len*sizeof(char));
        if (URL_Len == payload_len - 5)
        {
            memcpy(URL, p + 5, URL_Len);
            task_test_https(URL, tmpbuff, HTTP_RECV_BUF_SIZE);
            FILE* fp1 = luat_fs_fopen("test1.mp3", "wb+");
            status = luat_fs_fwrite((uint8_t *)tmpbuff, sizeof(tmpbuff), 1, fp1);
            if (status == 0)
            {
                while (1);
            }
            luat_fs_fclose(fp1);
            info[0].path = "test1.mp3";
            luat_audio_play_multi_files(0, info, 1);
            luat_rtos_task_sleep(3000);
        }
        else
        {

            int TTS_Len = p[9 + URL_Len];
            CHAR *TTS=malloc(TTS_Len*sizeof(char));
            memcpy(URL, p + 5, URL_Len);
            memcpy(TTS, p + 10 + URL_Len, TTS_Len);
            task_test_https(URL, tmpbuff, HTTP_RECV_BUF_SIZE);
            info[0].path = NULL;
            info[0].address = (uint32_t)tmpbuff;
            info[0].rom_data_len = sizeof(tmpbuff);
            luat_audio_play_multi_files(0, info, 1);
            luat_rtos_task_sleep(2000);
            luat_audio_play_tts_text(0, TTS, TTS_Len);
            free(TTS);
        
        }
        free(URL);
    }
    luat_rtos_task_sleep(2000);
    
    memset(tmpbuff, 0, HTTP_RECV_BUF_SIZE);
}

static void mqtt_demo(void)
{
    CHAR IMEI[20] = {0};
    if (luat_mobile_get_imei(0, IMEI, sizeof(IMEI)))
    {
        sprintf(mqtt_subTopic, "%s%s", subTopic, IMEI);
        LUAT_DEBUG_PRINT("imei%s", mqtt_subTopic);
    }
    int rc = 0;
    MQTTClient mqttClient;
    static Network n = {0};
    MQTTPacket_connectData connectData = MQTTPacket_connectData_initializer;
    connectData.MQTTVersion = 4;
    connectData.clientID.cstring = IMEI;
    connectData.username.cstring = User;
    connectData.password.cstring = Password;
    connectData.keepAliveInterval = 120;
    while (1)
    {
        while (!link_UP)
        {
            luat_rtos_task_sleep(1000);
        }
        if ((rc = mqtt_connect(&mqttClient, &n, HOST, PORT, &connectData)) == 0)
        {
            audioQueueData MQTT_link = {0};
            MQTT_link.playType = TTS_PLAY;
            MQTT_link.priority = MONEY_PLAY;
            char str[] = "服务器连接成功";
            MQTT_link.message.tts.data = malloc(sizeof(str));
            memcpy(MQTT_link.message.tts.data, str, sizeof(str));
            MQTT_link.message.tts.len = sizeof(str);
            if (pdTRUE != xQueueSend(audioQueueHandle, &MQTT_link, 0))
            {
                LUAT_DEBUG_PRINT("start send audio fail");
            }
        }
        else
        {
            audioQueueData MQTT_link = {0};
            MQTT_link.playType = TTS_PLAY;
            MQTT_link.priority = MONEY_PLAY;
            char str[] = "服务器连接失败";
            MQTT_link.message.tts.data = malloc(sizeof(str));
            memcpy(MQTT_link.message.tts.data, str, sizeof(str));
            MQTT_link.message.tts.len = sizeof(str);
            if (pdTRUE != xQueueSend(audioQueueHandle, &MQTT_link, 0))
            {
                LUAT_DEBUG_PRINT("start send audio fail");
            }
        }

        if ((rc = MQTTSubscribe(&mqttClient, mqtt_subTopic, 0, messageArrived)) != 0)
            LUAT_DEBUG_PRINT("mqtt Return code from MQTT subscribe is %d\n", rc);

        while (1)
        {
            luat_rtos_task_sleep(1000);
        }
    }
}
static void mqttclient_task_init(void)
{
    luat_rtos_task_handle mqttclient_task_handle;
    luat_rtos_task_create(&mqttclient_task_handle, 4*1024, 80, "mqttclient", mqtt_demo, NULL, NULL);
}
/*------------------------------------------------------MQTT event-----------------------------------------------------------------*/

INIT_HW_EXPORT(Task_netinfo_call, "0");
INIT_TASK_EXPORT(mqttclient_task_init, "1");
INIT_TASK_EXPORT(audio_task_init, "2");
INIT_TASK_EXPORT(NET_LED_Task, "3");
