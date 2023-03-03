#include "comInteraction.h"
#include "cJSON.h"

int g_nProductId = NULL;
char* g_pstrDeviceNum = NULL;

void* g_callbackSendData = NULL;
void* g_callbackPropertyData = NULL;
void* g_callbackFunctionData = NULL;
void* g_callbackEventData = NULL;
void* g_callbackDeviceInformationData = NULL;

static luat_rtos_timer_t g_propertyTimerHandle;
static luat_rtos_timer_t g_functionTimerHandle;
static luat_rtos_timer_t g_eventTimerHandle;
static luat_rtos_timer_t g_monitorTimerHandle;
static unsigned int g_monitorCount = 0;

static const char* getSubscriberDeviceInformation()
{
	static char szResult[50] = { 0 };
	snprintf(szResult, 49, "/%d/%s/info/get", g_nProductId, g_pstrDeviceNum);
	//LUAT_DEBUG_PRINT("---str=%s", szResult);
	return szResult;
}

static const char* getSubscriberDeviceInOta()
{
	static char szResult[50] = { 0 };
	snprintf(szResult, 49, "/%d/%s/ota/get", g_nProductId, g_pstrDeviceNum);
	//LUAT_DEBUG_PRINT("---str=%s", szResult);
	return szResult;
}

static const char* getSubscriberDeviceProperty()
{
	static char szResult[50] = { 0 };
	snprintf(szResult, 49, "/%d/%s/property/get", g_nProductId, g_pstrDeviceNum);
	//LUAT_DEBUG_PRINT("---str=%s", szResult);
	return szResult;
}

static const char* getSubscriberDevicePropertyOnline()
{
	static char szResult[50] = { 0 };
	snprintf(szResult, 49, "/%d/%s/property-online/get", g_nProductId, g_pstrDeviceNum);
	//LUAT_DEBUG_PRINT("---str=%s", szResult);
	return szResult;
}

static const char* getSubscriberDeviceFunction()
{
	static char szResult[50] = { 0 };
	snprintf(szResult, 49, "/%d/%s/function/get", g_nProductId, g_pstrDeviceNum);
	//LUAT_DEBUG_PRINT("---str=%s", szResult);
	return szResult;
}

static const char* getSubscriberDeviceFunctionOnline()
{
	static char szResult[50] = { 0 };
	snprintf(szResult, 49, "/%d/%s/function-online/get", g_nProductId, g_pstrDeviceNum);
	//LUAT_DEBUG_PRINT("---str=%s", szResult);
	return szResult;
}

static const char* getSubscriberDeviceMonitor()
{
	static char szResult[50] = { 0 };
	snprintf(szResult, 49, "/%d/%s/monitor/get", g_nProductId, g_pstrDeviceNum);
	//LUAT_DEBUG_PRINT("---str=%s", szResult);
	return szResult;
}

static const char* getSubscriberDeviceNtp()
{
	static char szResult[50] = { 0 };
	snprintf(szResult, 49, "/%d/%s/ntp/get", g_nProductId, g_pstrDeviceNum);
	//LUAT_DEBUG_PRINT("---str=%s", szResult);
	return szResult;
}

static const char* getPublishDeviceInformation()
{
	static char szResult[50] = { 0 };
	snprintf(szResult, 49, "/%d/%s/info/post", g_nProductId, g_pstrDeviceNum);
	//LUAT_DEBUG_PRINT("---str=%s", szResult);
	return szResult;
}

static const char* getPublishDeviceProperty()
{
	static char szResult[50] = { 0 };
	snprintf(szResult, 49, "/%d/%s/property/post", g_nProductId, g_pstrDeviceNum);
	//LUAT_DEBUG_PRINT("---str=%s", szResult);
	return szResult;
}

static const char* getPublishDeviceFunction()
{
	static char szResult[50] = { 0 };
	snprintf(szResult, 49, "/%d/%s/function/post", g_nProductId, g_pstrDeviceNum);
	//LUAT_DEBUG_PRINT("---str=%s", szResult);
	return szResult;
}

static const char* getPublishDeviceEvent()
{
	static char szResult[50] = { 0 };
	snprintf(szResult, 49, "/%d/%s/event/post", g_nProductId, g_pstrDeviceNum);
	//LUAT_DEBUG_PRINT("---str=%s", szResult);
	return szResult;
}

static const char* getPublishDeviceNtp()
{
	static char szResult[50] = { 0 };
	snprintf(szResult, 49, "/%d/%s/ntp/post", g_nProductId, g_pstrDeviceNum);
	//LUAT_DEBUG_PRINT("---str=%s", szResult);
	return szResult;
}

static const char* getPublishMonitorProperty()
{
	static char szResult[50] = { 0 };
	snprintf(szResult, 49, "/%d/%s/monitor/post", g_nProductId, g_pstrDeviceNum);
	//LUAT_DEBUG_PRINT("---str=%s", szResult);
	return szResult;
}

static void propertyPush(const char* pstrRecvMessage)
{
	char* pSendBuffer[300] = { 0 };
	char* pstrTopic = getPublishDeviceProperty();
	char* pstrMessage = ((fnCallbackGetMessage)g_callbackPropertyData)(pSendBuffer, sizeof(pSendBuffer), pstrRecvMessage);
	((fnCallbackSendData)g_callbackSendData)(pstrTopic, pstrMessage, 1);
}

static void functionPush(const char* pstrRecvMessage)
{
	char* pSendBuffer[300] = { 0 };
	char* pstrTopic = getPublishDeviceFunction();
	char* pstrMessage = ((fnCallbackGetMessage)g_callbackFunctionData)(pSendBuffer, sizeof(pSendBuffer), pstrRecvMessage);
	//LUAT_DEBUG_PRINT("functionPush Topic=%s Message=%s", pstrTopic, pstrMessage);
	((fnCallbackSendData)g_callbackSendData)(pstrTopic, pstrMessage, 1);
}

static void eventPush(const char* pstrRecvMessage)
{
	char* pSendBuffer[300] = { 0 };
	char* pstrTopic = getPublishDeviceEvent();
	char* pstrMessage = ((fnCallbackGetMessage)g_callbackEventData)(pSendBuffer, sizeof(pSendBuffer), pstrRecvMessage);
	((fnCallbackSendData)g_callbackSendData)(pstrTopic, pstrMessage, 1);
}

static void monitorPush(const char* pstrRecvMessage)
{
	char* pSendBuffer[300] = { 0 };
	char* pstrTopic = getPublishMonitorProperty();
	char* pstrMessage = ((fnCallbackGetMessage)g_callbackPropertyData)(pSendBuffer, sizeof(pSendBuffer), pstrRecvMessage);
	((fnCallbackSendData)g_callbackSendData)(pstrTopic, pstrMessage, 1);
}

static void deviceInformationPush(const char* pstrRecvMessage)
{
	char* pSendBuffer[300] = { 0 };
	char* pstrTopic = getPublishDeviceInformation();
	char* pstrMessage = ((fnCallbackGetMessage)g_callbackDeviceInformationData)(pSendBuffer, sizeof(pSendBuffer), pstrRecvMessage);
	((fnCallbackSendData)g_callbackSendData)(pstrTopic, pstrMessage, 1);
}

void comInteractionInit(
	const int nProductId,
	const char* pstrDeviceNum,
	void* callbackSendData,
	void* callbackPropertyData,
	void* callbackFunctionData,
	void* callbackEventData,
	void* callbackDeviceInformationData)
{
	g_callbackSendData = callbackSendData;
	g_callbackPropertyData = callbackPropertyData;
	g_callbackFunctionData = callbackFunctionData;
	g_callbackEventData = callbackEventData;
	g_callbackDeviceInformationData = callbackDeviceInformationData;
	g_nProductId = nProductId;
	g_pstrDeviceNum = pstrDeviceNum;
	luat_rtos_timer_create(&g_propertyTimerHandle);
	luat_rtos_timer_create(&g_functionTimerHandle);
	luat_rtos_timer_create(&g_eventTimerHandle);
	luat_rtos_timer_create(&g_monitorTimerHandle);
}

void comInteractionDelayInit()
{
	deviceInformationPush(NULL);
}

static void onTimerPropertyPush(uint32_t arg)
{
	propertyPush(NULL);
}

static void onTimerFunctionPush(uint32_t arg)
{
	functionPush(NULL);
}

static void onTimerEventPush(uint32_t arg)
{
	eventPush(NULL);
}

static void onTimerMonitorPush(uint32_t arg)
{
	if (g_monitorCount != 0)
	{
		g_monitorCount--;
	}
	if (g_monitorCount == 0)
		luat_rtos_timer_stop(g_monitorTimerHandle);
}

void setPropertyPush(unsigned int nTime)
{
	if (luat_rtos_timer_is_active(g_propertyTimerHandle) != 0)
		luat_rtos_timer_stop(g_propertyTimerHandle);
	luat_rtos_timer_start(g_propertyTimerHandle, nTime, 1, onTimerPropertyPush, NULL);
}

void setFunctionPush(unsigned int nTime)
{
	if (luat_rtos_timer_is_active(g_functionTimerHandle) != 0)
		luat_rtos_timer_stop(g_functionTimerHandle);
	luat_rtos_timer_start(g_functionTimerHandle, nTime, 1, onTimerFunctionPush, NULL);
}

void setEventPush(unsigned int nTime)
{
	if (luat_rtos_timer_is_active(g_eventTimerHandle) != 0)
		luat_rtos_timer_stop(g_eventTimerHandle);
	luat_rtos_timer_start(g_eventTimerHandle, nTime, 1, onTimerEventPush, NULL);
}

static void setMonitorPush(unsigned int nTime, unsigned int nNumber)
{
	if (luat_rtos_timer_is_active(g_monitorTimerHandle) != 0)
		luat_rtos_timer_stop(g_monitorTimerHandle);
	luat_rtos_timer_start(g_monitorTimerHandle, nTime, 1, onTimerMonitorPush, NULL);
	g_monitorCount = nNumber;
}

const char* getSubscriberAll()
{
	//大局部变量有风险
	static char szSubscriberBuffer[1024] = { 0 };
	snprintf(szSubscriberBuffer, sizeof(szSubscriberBuffer) - 1, "%s|%s|%s|%s|%s|%s|%s",
		getSubscriberDeviceInformation(), //1
		getSubscriberDeviceProperty(), //2
		getSubscriberDevicePropertyOnline(), //3
		getSubscriberDeviceFunction(), //4
		getSubscriberDeviceFunctionOnline(), //5
		getSubscriberDeviceMonitor(), //6
		getSubscriberDeviceNtp() //7
	);
	return szSubscriberBuffer;
}

void onRecvData(const char* pstrTopic, const char* pstrMessage)
{
	LUAT_DEBUG_PRINT("--onRecvData Topic=%s Message=%s", pstrTopic, pstrMessage);
	//待解析json 
	if (strcmp(pstrTopic, getSubscriberDeviceInformation()) == 0)
		deviceInformationPush(pstrMessage);
	else if (strcmp(pstrTopic, getSubscriberDeviceProperty()) == 0)
		propertyPush(pstrMessage);
	else if (strcmp(pstrTopic, getSubscriberDevicePropertyOnline()) == 0)
	{
		propertyPush(pstrMessage);
		//在线获取
	}
	else if (strcmp(pstrTopic, getSubscriberDeviceFunction()) == 0)
		functionPush(pstrMessage);
	else if (strcmp(pstrTopic, getSubscriberDeviceFunctionOnline()) == 0)
	{
		functionPush(pstrMessage);
	}
	else if (strcmp(pstrTopic, getSubscriberDeviceMonitor()) == 0)
	{
		// 获取设备监控
	}
	else if (strcmp(pstrTopic, getSubscriberDeviceNtp()) == 0)
	{
		//ntp 同步
	}
}

void triggerPropertyPush()
{
	propertyPush(NULL);
}

void triggerFunctionPush()
{
	functionPush(NULL);
}

void triggerEventPush()
{
	eventPush(NULL);
}