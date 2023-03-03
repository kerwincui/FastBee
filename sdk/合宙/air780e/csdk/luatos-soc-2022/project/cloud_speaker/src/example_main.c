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
#include "cJSON.h"
#include "MQTTClient.h"
#include "audio_task.h"
#include "audio_file.h"
#include "math.h"
#include "luat_rtos.h"
#include "luat_mobile.h"
#include "luat_debug.h"
#include "luat_pm.h"
#include "mqtt_publish.h"
uint8_t g_s_is_link_up = 0;
static luat_rtos_semaphore_t net_semaphore_handle;
static luat_rtos_task_handle mqtt_task_handle;
extern luat_rtos_queue_t audio_queue_handle;

#define MQTT_HOST    	"lbsmqtt.airm2m.com"   				// MQTT服务器的地址和端口号
#define MQTT_PORT		 1884

#define MQTT_SEND_BUFF_LEN       (1024)
#define MQTT_RECV_BUFF_LEN       (1024)

#define CLIENTID    "12345678"
const static char mqtt_sub_topic_head[] = "/sub/topic/money/";    //订阅的主题头，待与设备imei进行拼接
const static char mqtt_pub_topic[] = "/pub/topic/message";       //发布的主题
static char mqtt_send_payload[] = "hello mqtt_test!!!";
static char mqtt_sub_topic[40];                            //订阅的主题，待存放订阅的主题头和设备imei，共计17+15,32个字符
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
            if(2 == thousand)
            {
                data->message.file.info[*index].address = audioliang;
                data->message.file.info[*index].rom_data_len = audioliangSize;
            }
            else
            {
                data->message.file.info[*index].address = audioArray[thousand][0];
                data->message.file.info[*index].rom_data_len = audioArray[thousand][1];
            }
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
            if(2 == hundred)
            {
                data->message.file.info[*index].address = audioliang;
                data->message.file.info[*index].rom_data_len = audioliangSize;
            }
            else
            {
                data->message.file.info[*index].address = audioArray[hundred][0];
                data->message.file.info[*index].rom_data_len = audioArray[hundred][1];
        }
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
        if (flag)
        {
            if((2 == *index) && (data->message.file.info[1].address == audio2))
            {
                data->message.file.info[1].address = audioliang;
                data->message.file.info[1].rom_data_len = sizeof(audioliang);
            }
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
    int fraction = atoi(decStr);
    if (fraction > 0)
    {
        if (flag)
        {
            data->message.file.info[*index].path = NULL; 
            data->message.file.info[*index].address = audiodot;
            data->message.file.info[*index].rom_data_len = sizeof(audiodot);
        }
        *index += 1;
        if (fraction >= 10)
        {
            int ten = fraction / 10;
            int unit = fraction % 10;
            if (ten != 0 && unit != 0)
            {
                if (flag)
                {
                    data->message.file.info[*index].path = NULL; 
                    data->message.file.info[*index].address = audioArray[ten][0];
                    data->message.file.info[*index].rom_data_len = audioArray[ten][1];
                }
                *index += 1;
                if(flag)
                {
                    data->message.file.info[*index].path = NULL; 
                    data->message.file.info[*index].address = audioArray[unit][0];
                    data->message.file.info[*index].rom_data_len = audioArray[unit][1];
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
                    data->message.file.info[*index].address = audioArray[ten][0];
                    data->message.file.info[*index].rom_data_len = audioArray[ten][1];
                }
                *index += 1;
            }
        }
        else
        {
            if(decStr[0] == 0x30)
            {
                if (flag)
                {
                    data->message.file.info[*index].path = NULL; 
                    data->message.file.info[*index].address = audioArray[0][0];
                    data->message.file.info[*index].rom_data_len = audioArray[0][1];
                }
                *index += 1;
            }
            if (flag)
            {
                data->message.file.info[*index].path = NULL; 
                data->message.file.info[*index].address = audioArray[fraction][0];
                data->message.file.info[*index].rom_data_len = audioArray[fraction][1];
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

void messageArrived(MessageData* data)
{
    if (strcmp(mqtt_sub_topic, data->topicName->lenstring.data) == 0)
    {
        cJSON *boss = NULL;
        LUAT_DEBUG_PRINT("cloud_speaker_mqtt mqtt Message arrived on topic %.*s: %.*s\n", data->topicName->lenstring.len, data->topicName->lenstring.data, data->message->payloadlen, data->message->payload);
        boss = cJSON_Parse((const char *)data->message->payload);
        if (boss == NULL){
            LUAT_DEBUG_PRINT("cloud_speaker_mqtt cjson parse fail");
        }
        else
        {
            LUAT_DEBUG_PRINT("cloud_speaker_mqtt cjson parse success");
            cJSON *money = cJSON_GetObjectItem(boss, "money");
            if(money == NULL)
            {
                LUAT_DEBUG_PRINT("cloud_speaker_mqtt Missing amount field %d", money);
                return 0;
            }
            if (cJSON_IsString(money))
            {
                audioQueueData moneyPlay = {0};
                moneyPlay.priority = MONEY_PLAY;
                moneyPlay.playType = FILE_PLAY;
                char* str = NULL;
                str = strstr(money->valuestring, ".");
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
                        str++;
                        //如果小数点位数大于两位，则说明数字金额不合法，播报收款成功
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
                        //调用strToFile来将金额格式化为对应的文件播报数据，需要调用两次，第一次获取需要malloc的空间，第二次将文件数据放进空间里
                        int index = 0;
                        strToFile(money->valuestring, &moneyPlay, &index, false);
                        moneyPlay.message.file.info = (audio_play_info_t *)calloc(index, sizeof(audio_play_info_t));
                        index = 0;
                        strToFile(money->valuestring, &moneyPlay, &index, true);
                        moneyPlay.message.file.count = index;
                    }
                }
                if (-1 == luat_rtos_queue_send(audio_queue_handle, &moneyPlay, NULL, 0)){
                    free(moneyPlay.message.file.info);
                    LUAT_DEBUG_PRINT("cloud_speaker_mqtt sub queue send error");
                }
            }
            else
            {
                LUAT_DEBUG_PRINT("cloud_speaker_mqtt money data is invalid %d", cJSON_IsString(money));
            }
        }
        cJSON_Delete(boss);
    }
}

static void mobile_event_cb(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status)
{
	switch(event)
	{
	case LUAT_MOBILE_EVENT_CFUN:
		LUAT_DEBUG_PRINT("CFUN消息，status %d", status);
		break;
	case LUAT_MOBILE_EVENT_SIM:
		LUAT_DEBUG_PRINT("SIM卡消息");
		switch(status)
		{
		case LUAT_MOBILE_SIM_READY:
			LUAT_DEBUG_PRINT("SIM卡正常工作");
			break;
		case LUAT_MOBILE_NO_SIM:
			LUAT_DEBUG_PRINT("SIM卡不存在");
			break;
		case LUAT_MOBILE_SIM_NEED_PIN:
			LUAT_DEBUG_PRINT("SIM卡需要输入PIN码");
			break;
		}
		break;
	case LUAT_MOBILE_EVENT_REGISTER_STATUS:
		LUAT_DEBUG_PRINT("移动网络服务状态变更，当前为%d", status);
		break;
	case LUAT_MOBILE_EVENT_CELL_INFO:
		switch(status)
		{
		case LUAT_MOBILE_CELL_INFO_UPDATE:
			break;
		case LUAT_MOBILE_SIGNAL_UPDATE:
			break;
		}
		break;
	case LUAT_MOBILE_EVENT_PDP:
		LUAT_DEBUG_PRINT("CID %d PDP激活状态变更为 %d", index, status);
		break;
	case LUAT_MOBILE_EVENT_NETIF:
		LUAT_DEBUG_PRINT("internet工作状态变更为 %d", status);
		switch (status)
		{
		case LUAT_MOBILE_NETIF_LINK_ON:
			LUAT_DEBUG_PRINT("可以上网");
            g_s_is_link_up = 1;
			break;
		default:
            g_s_is_link_up = 0;
			LUAT_DEBUG_PRINT("不能上网");
			break;
		}
		break;
	case LUAT_MOBILE_EVENT_TIME_SYNC:
		LUAT_DEBUG_PRINT("通过移动网络同步了UTC时间");
		break;
	case LUAT_MOBILE_EVENT_CSCON:
		LUAT_DEBUG_PRINT("RRC状态 %d", status);
		break;
	default:
		break;
	}
}
extern luat_rtos_task_handle mqtt_publish_task_handle;
extern void mqtt_publish_task(void *args);
static void mqtt_demo(void){
	int rc = 0;
    unsigned char mqttSendbuf[MQTT_SEND_BUFF_LEN] = {0}, mqttReadbuf[MQTT_RECV_BUFF_LEN] = {0};
    static MQTTClient mqttClient;
    static Network n = {0};
    
    MQTTMessage message = {0};
    MQTTPacket_connectData connectData = MQTTPacket_connectData_initializer;
    connectData.MQTTVersion = 4;
    int ret = 0;
    char str[32] = {0};
    char clientId[17] = {0};
    char username[17] = {0};
    char password[17] = {0};
    ret = luat_kv_get("clientId", str, 17);             //从数据库中读取clientId
    if(ret > 0 )
    {
        memcpy(clientId, str, 16);                      //留一位确保字符串结尾能有0x00
        connectData.clientID.cstring = clientId;
    }
    else                                                //数据库中没有写入过clientId，获取设备imei作为clientId
    {
        int result = 0;
        result = luat_mobile_get_imei(0, clientId, 15); //imei是15位，留一个位置放0x00
        if(result <= 0)
        {
            connectData.clientID.cstring = CLIENTID;
            LUAT_DEBUG_PRINT("cloud_speaker_mqtt clientid get fail");
        }
        else
        {
            connectData.clientID.cstring = clientId;
            LUAT_DEBUG_PRINT("cloud_speaker_mqtt clientid get success %s", clientId);
        }       
    }
    memset(str, 0, 32);
    ret = luat_kv_get("username", str, 17);             //从数据库中读取username，如果没读到，则用默认的
    if(ret > 0 )
    {
        memcpy(username, str, 16);                      //留一位确保字符串结尾能有0x00
        connectData.username.cstring = username;
    }
    else
    {
        connectData.username.cstring = NULL;
    }
    memset(str, 0, 32);
    ret = luat_kv_get("password", str, 17);             //从数据库中读取password，如果没读到，则用默认的
    if(ret > 0 )
    {
        memcpy(password, str, 16);                      //留一位确保字符串结尾能有0x00
        connectData.password.cstring = password;
    }
    else
    {
        connectData.password.cstring = NULL;
    }
    memset(str, 0, 32);
    memset(mqtt_sub_topic, 0x00, sizeof(mqtt_sub_topic));
    snprintf(mqtt_sub_topic, 40, "%s%s", mqtt_sub_topic_head, clientId);
    LUAT_DEBUG_PRINT("cloud_speaker_mqtt subscribe_topic %s %s %s %s", mqtt_sub_topic, clientId, username, password);
    connectData.keepAliveInterval = 120;

    while(!g_s_is_link_up)
	{
		luat_rtos_task_sleep(1000);
	}
    // 设置my_app标记可以休眠到LIGHT等级
    luat_pm_set_sleep_mode(LUAT_PM_SLEEP_MODE_LIGHT, "my_app");

    NetworkInit(&n);
	MQTTClientInit(&mqttClient, &n, 40000, mqttSendbuf, MQTT_SEND_BUFF_LEN, mqttReadbuf, MQTT_RECV_BUFF_LEN);

    if ((NetworkConnect(&n, MQTT_HOST, MQTT_PORT)) != 0){
	    mqttClient.keepAliveInterval = connectData.keepAliveInterval;
	    mqttClient.ping_outstanding = 1;
	    goto error;
	}else{
	if ((MQTTConnect(&mqttClient, &connectData)) != 0){
		mqttClient.ping_outstanding = 1;
		goto error;
	}else{
		LUAT_DEBUG_PRINT("MQTTStartTask \n");
		#if defined(MQTT_TASK)
			if ((MQTTStartTask(&mqttClient)) != pdPASS){
				goto error;
			}
		#endif
	}
	}
    while (1){
        // 支付报文一般来说不能丢失，也最好不要重复发送，这里设置qos为1即可，保证只收到一次
        if ((rc = MQTTSubscribe(&mqttClient, mqtt_sub_topic, 1, messageArrived)) != 0)
        {
            LUAT_DEBUG_PRINT("mqtt Return code from MQTT subscribe error is %d\n", rc);
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
            if (-1 == luat_rtos_queue_send(audio_queue_handle, &welcome, NULL, 0)){
                free(welcome.message.tts.data);
                LUAT_DEBUG_PRINT("cloud_speaker_mqtt sub audio queue send error");
            }
            if (mqtt_publish_task_handle == NULL)
            {
                luat_rtos_task_create(&mqtt_publish_task_handle, 2048, 20, "mqtt_publish_task", mqtt_publish_task, (void *)&mqttClient, 10);
            }
        }

        while (1)
        {
            if(MQTTIsConnected(&mqttClient) == 0){
                goto error;
            }


            luat_rtos_task_sleep(5000);
        }
error:
		while(!g_s_is_link_up){
			luat_rtos_task_sleep(1000);
		}

		if (rc = MQTTReConnect(&mqttClient, &connectData) != 0){
			luat_rtos_task_sleep(5000);
			LUAT_DEBUG_PRINT("MQTTReConnect %d\n", rc);
			goto error;
		}
		else
		{
			LUAT_DEBUG_PRINT("MQTTReConnect OK");
		}
    }
    luat_rtos_task_delete(mqtt_task_handle);
}

static void task_init(void){
    luat_mobile_event_register_handler(mobile_event_cb);
}

static void mqttclient_task_init(void){
    int result = luat_rtos_task_create(&mqtt_task_handle, 4096, 20, "mqtt", mqtt_demo, NULL, NULL);
    LUAT_DEBUG_PRINT("cloud_speaker_mqtt create task result %d", result);
}

extern void led_task_init(void);
extern void key_task_init(void);
extern void charge_task_init(void);
extern void usb_uart_init(void);
extern void fdb_init(void);
extern void mqtt_send_task_init(void);


INIT_HW_EXPORT(task_init, "1");
INIT_HW_EXPORT(fdb_init, "1");
INIT_TASK_EXPORT(mqttclient_task_init, "2");
INIT_TASK_EXPORT(audio_task_init, "2");
INIT_TASK_EXPORT(led_task_init, "2");
INIT_TASK_EXPORT(key_task_init, "3");
INIT_TASK_EXPORT(charge_task_init, "2");
INIT_TASK_EXPORT(usb_uart_init, "2");
INIT_TASK_EXPORT(mqtt_send_task_init, "3");

