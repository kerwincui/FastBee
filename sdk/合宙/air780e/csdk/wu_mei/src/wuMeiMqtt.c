#include "luat_mobile.h"
#include "wuMeiMqtt.h"
#include "MQTTClient.h"
#include "luat_debug.h"
#include "comAuth.h"
#include "comInteraction.h"
#include "app.h"

static const char* g_pstrIp = "43.143.82.218"; //mqtt IP
static const int g_nPort = 1883; //Mqtt 端口
static const char* g_pstrEncryptionMode = "E"; // 加密类型 S 简单加密
static const int g_nProductId = 45; //产品ID
static const char* g_pstrUserId = "1"; //用户ID
static const char* g_pstrMqttUser = "wumei-smart"; //mqtt 用户
static const char* g_pstrMqttPassword = "P47254TN6NNBB01L"; // mqtt 密码
static const char* g_pstrProductPassword = "KL0MKIA2HIAT2346"; //产品密码
static const unsigned int g_nMqttAuthenticationTimeout = 24 * 60 * 60 * 1000; // 24小时
static const char* g_pstrDeviceAuthorizationCode = "";// "A25040D2E34B483DA371B5F9A315BB43"; //设备授权码

static char* g_szDeviceId[16] = { 0 }; //设备ID IMEI

#define MQTT_SEND_BUFF_LEN       (2048)
#define MQTT_RECV_BUFF_LEN       (2048)

static MQTTClient g_mqttClient = { 0 };
static Network g_network = { 0 };
unsigned char g_mqttSendbuf[MQTT_SEND_BUFF_LEN] = { 0 };
unsigned char g_mqttReadbuf[MQTT_RECV_BUFF_LEN] = { 0 };
static unsigned char g_nStatus = 0;

static MQTTPacket_connectData g_connectData = MQTTPacket_connectData_initializer;
unsigned char g_mqttReadMessageData[1024] = { 0 };
unsigned char g_mqttReadMessageTopic[200] = { 0 };
static char g_nRecvFlag = 0;
luat_rtos_mutex_t g_mutexMqttRecv;

static void callAuthResultFunction(unsigned char nStatus)
{
	LUAT_DEBUG_PRINT("callAuthResultFunction nStatus=%d", nStatus);
	if (nStatus == 1)
	{
		g_nStatus = 2;
		LUAT_DEBUG_PRINT("callAuthResultFunction g_nStatus=%d", g_nStatus);
	}
	else if (nStatus == 0)
	{
		g_nStatus = 0;
	}
}

static void mqttInit(const char* pstrClientId, const char* pstrUserName, const char* pstrPassword, unsigned short nkeepAliveInterval)
{
	LUAT_DEBUG_PRINT("mqttInit pstrClientId=%s", pstrClientId);
	g_connectData.MQTTVersion = 4;
	g_connectData.clientID.cstring = pstrClientId;
	g_connectData.username.cstring = pstrUserName;
	g_connectData.password.cstring = pstrPassword;
	g_connectData.keepAliveInterval = nkeepAliveInterval;//120;
	LUAT_DEBUG_PRINT("mqttInit pstrClientId=%s pstrUserName=%s pstrPassword=%s", pstrClientId, pstrUserName, pstrPassword);
}

static void messageArrived(MessageData* data)
{
	LUAT_DEBUG_PRINT("mqtt Recv topic %.*s: %.*s", data->topicName->lenstring.len, data->topicName->lenstring.data,
		data->message->payloadlen, data->message->payload);
	LUAT_DEBUG_PRINT("topic=%d Data=%d", data->topicName->lenstring.len, data->message->payloadlen);
	luat_rtos_mutex_lock(g_mutexMqttRecv, 1000);
	memcpy(g_mqttReadMessageData, data->message->payload, data->message->payloadlen);

	int nTopicLeng = data->topicName->lenstring.len;
	if (nTopicLeng > (sizeof(g_mqttReadMessageTopic) - 1))
		nTopicLeng = (sizeof(g_mqttReadMessageTopic) - 1);
	snprintf(g_mqttReadMessageTopic, nTopicLeng + 1, "%s", data->topicName->lenstring.data);
	g_nRecvFlag = 1;
	luat_rtos_mutex_unlock(g_mutexMqttRecv);
}

void mqttSendData(const char* pstrTopic, const char* pstrMessage, unsigned char nQs)
{
	int nResult = 0;
	if (g_nStatus != 3)
	{
		LUAT_DEBUG_PRINT("mqttSendData error status!=3");
		return;
	}
	LUAT_DEBUG_PRINT("--mqttSendData 2 ");

	if (MQTTIsConnected(&g_mqttClient) == 0)
	{
		g_nStatus = 2;// 让他重连
		LUAT_DEBUG_PRINT("--g_nStatus 2 ");
		return;
	}
	LUAT_DEBUG_PRINT("--mqttSendData 3 ");
	//if (MQTTIsConnected(&g_mqttClient) == 0)
	//	return; //这里应该是没有连接就返回了
	// 加锁
	MQTTMessage message;
	LUAT_DEBUG_PRINT("--mqttSendData 4 ");
	message.qos = nQs;
	message.retained = 0;
	message.payload = pstrMessage;
	message.payloadlen = strlen(pstrMessage) + 1;
	LUAT_DEBUG_PRINT("--mqttSendData 5 l=%d ", message.payloadlen);
	if (nResult = MQTTPublish(&g_mqttClient, pstrTopic, &message) != 0)
		LUAT_DEBUG_PRINT("MQTTPublish %d\n", nResult);
	// 释放锁
	LUAT_DEBUG_PRINT("--mqttSendData Topic=%s Message=%s", pstrTopic, pstrMessage);
}

static void recvDataPool()
{
	luat_rtos_mutex_lock(g_mutexMqttRecv, 1000);

	if (g_nRecvFlag == 1)
	{
		LUAT_DEBUG_PRINT("recvDataPool %s %s", g_mqttReadMessageTopic, g_mqttReadMessageData);
		//加锁放起来
		onRecvData(g_mqttReadMessageTopic, g_mqttReadMessageData);
		g_nRecvFlag = 0;
	}
	luat_rtos_mutex_unlock(g_mutexMqttRecv);
}
void wuMeiMqttConnectPool(unsigned char nNetStatus)
{
	int nResult = 0;
	if (nNetStatus == 1)
	{
		if (g_nStatus == 0)
		{
			luat_rtos_mutex_create(&g_mutexMqttRecv);
			g_nStatus = 1; //调用认证在等待认证状态
			luat_mobile_get_imei(0, g_szDeviceId, sizeof(g_szDeviceId));
			ComAuthInit(
				g_pstrEncryptionMode,
				g_nProductId,
				g_szDeviceId,
				g_pstrUserId,
				g_pstrMqttUser,
				g_pstrMqttPassword,
				g_nMqttAuthenticationTimeout,
				g_pstrIp,
				g_pstrDeviceAuthorizationCode,
				g_pstrProductPassword,
				callAuthResultFunction
			);
			comInteractionInit(g_nProductId, g_szDeviceId, mqttSendData, getPropertyData, getFunctionData, getEventData, getInformationData);
		}
		else if (g_nStatus == 2)
		{
			mqttInit(getComAuthClientId(), getComAuthUser(), getComAuthPassword(), 120);
			//没有连接网络
			NetworkInit(&g_network);
			MQTTClientInit(&g_mqttClient, &g_network, 40000, g_mqttSendbuf, MQTT_SEND_BUFF_LEN, g_mqttReadbuf, MQTT_RECV_BUFF_LEN);
			LUAT_DEBUG_PRINT("---start NetworkConnect--");
			if ((NetworkConnect(&g_network, g_pstrIp, g_nPort)) != 0)
			{
				LUAT_DEBUG_PRINT("NetworkConnect fail");
				g_mqttClient.keepAliveInterval = g_connectData.keepAliveInterval;
				g_mqttClient.ping_outstanding = 1;
				goto error;
			}
			else {
				if ((MQTTConnect(&g_mqttClient, &g_connectData)) != 0)
				{
					g_mqttClient.ping_outstanding = 1;
					goto error;
				}
				else
				{
					LUAT_DEBUG_PRINT("MQTTStartTask");
#if defined(MQTT_TASK)
					if ((MQTTStartTask(&g_mqttClient)) != pdPASS) {
						goto error;
					}
#endif
				}
			}

			g_nStatus = 3; //连接成功
			LUAT_DEBUG_PRINT("--start MQTTSubscribe---");
			//订阅
			char* pstrSubscriberAll = getSubscriberAll();
			for (char* pstr = strtok(pstrSubscriberAll, "|"); pstr != NULL; pstr = strtok(NULL, "|"))
			{
				if ((nResult = MQTTSubscribe(&g_mqttClient, pstr, 0, messageArrived)) != 0)
				{
					LUAT_DEBUG_PRINT("---MQTTSubscribe error -%d--", nResult);
					break;
				}
			}
			LUAT_DEBUG_PRINT("--end MQTTSubscribe---");
			comInteractionDelayInit();
			return;
		}
		else if (g_nStatus == 3)
		{
#if !defined(MQTT_TASK)
			//if ((nResult = MQTTYield(&g_mqttClient, 2)) != 0)
			//	LUAT_DEBUG_PRINT("mqtt_demo Return code from yield is %d\n", rc);
#endif
			// 连接成功了 就空闲了 有数据来会到回到的
			recvDataPool();
			return;
		}
	error:
		LUAT_DEBUG_PRINT("--g_nStatus= %d", g_nStatus);
		//外部睡眠		luat_rtos_task_sleep(200); // 睡眠一会防止连接过于频繁
	}
	else
	{
		LUAT_DEBUG_PRINT("--nNetStatus= %d", nNetStatus);
	}
}