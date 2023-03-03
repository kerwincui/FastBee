#include "app.h"
#include "cJSON.h"
#include "relay.h"
#include "optocoupler.h"

const char* getFunctionData(char* pGetDataBuffer, int nLength, const char* pstrRecvMessage)
{
	/*
	需要支持 一个按键 一个继电器 一个串口
	[{
	"id": "relay",
	"value": "0",
	"remark": ""
}, {
	"id": "key",
	"value": "0",
	"remark": ""
}
{
	"id": "uart",
	"value": "0",
	"remark": ""
}
]
	*/
	/*先解析 执行动作*/
	if (pstrRecvMessage != NULL)
	{
		/*[{"id":"switch","value":"1"}]*/
		LUAT_DEBUG_PRINT("pstrRecvMessage= %s", pstrRecvMessage);
		cJSON* pjsonRoot = cJSON_Parse(pstrRecvMessage); //解析
		if (pjsonRoot == NULL)
		{
			LUAT_DEBUG_PRINT("cJSON_Parse Error");
			return 0;
		}
		LUAT_DEBUG_PRINT("-----1----%d--", cJSON_GetArraySize(pjsonRoot));

		cJSON* client_list = pjsonRoot->child;
		while (client_list != NULL) {
			char* id = cJSON_GetObjectItem(client_list, "id")->valuestring;
			char* value = cJSON_GetObjectItem(client_list, "value")->valuestring;
			LUAT_DEBUG_PRINT("ip: %s  mask: %s", id, value);
			if (strcmp(value, "0") == 0)
			{
				relayControl(0, 0);
			}
			else if (strcmp(value, "1") == 0)
			{
				relayControl(0, 1);
			}
			client_list = client_list->next;
		}
		cJSON_Delete(pjsonRoot); //注意内存涨
	}

	char szTempBuffer[50] = { 0 };
	cJSON* cjsonObj = cJSON_CreateArray(); //数组
	if (cjsonObj == NULL)
		return NULL;

	cJSON* cjsonObjSwitch = cJSON_CreateObject();
	if (cjsonObjSwitch == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}

	if (cJSON_AddStringToObject(cjsonObjSwitch, "id", "switch") == NULL)
	{
		cJSON_Delete(cjsonObj);
		cJSON_Delete(cjsonObjSwitch);
		return NULL;
	}

	snprintf(szTempBuffer, sizeof(szTempBuffer), "%d", relayGetValue(0));
	if (cJSON_AddStringToObject(cjsonObjSwitch, "value", szTempBuffer) == NULL)
	{
		cJSON_Delete(cjsonObj);
		cJSON_Delete(cjsonObjSwitch);
		return NULL;
	}
	if (cJSON_AddItemToArray(cjsonObj, cjsonObjSwitch) == 0)
		LUAT_DEBUG_PRINT("error ");

	cJSON* cjsonObjTemperature = cJSON_CreateObject();
	if (cjsonObjTemperature == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	if (cJSON_AddStringToObject(cjsonObjTemperature, "id", "temperature") == NULL)
	{
		cJSON_Delete(cjsonObj);
		cJSON_Delete(cjsonObjTemperature);
		return NULL;
	}
	float fTemp = 2000 / 100;
	snprintf(szTempBuffer, sizeof(szTempBuffer), "%f", fTemp);// 温度传感器值
	if (cJSON_AddStringToObject(cjsonObjTemperature, "value", szTempBuffer) == NULL)
	{
		cJSON_Delete(cjsonObj);
		cJSON_Delete(cjsonObjTemperature);
		return NULL;
	}
	if (cJSON_AddItemToArray(cjsonObj, cjsonObjTemperature) == 0)
		LUAT_DEBUG_PRINT("error ");


	/* 打印JSON对象(整条链表)的所有数据 */
	char* pstrOut = cJSON_PrintUnformatted(cjsonObj);
	if (pstrOut == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	snprintf(pGetDataBuffer, nLength, "%s", pstrOut);
	LUAT_DEBUG_PRINT("FunctionData= %s", pstrOut);
	cJSON_Delete(cjsonObj);
	cJSON_free(pstrOut);
	return pGetDataBuffer;
}

const char* getPropertyData(char* pGetDataBuffer, int nLength, const char* pstrRecvMessage)
{
	char szTempBuffer[100] = { 0 };
	cJSON* cjsonObj = cJSON_CreateArray(); //数组
	if (cjsonObj == NULL)
		return NULL;

	cJSON* cjsonObjRelay = cJSON_CreateObject();
	if (cjsonObjRelay == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}

	if (cJSON_AddStringToObject(cjsonObjRelay, "id", "relay") == NULL)
	{
		cJSON_Delete(cjsonObj);
		cJSON_Delete(cjsonObjRelay);
		return NULL;
	}

	snprintf(szTempBuffer, sizeof(szTempBuffer), "%d", relayGetValue(0));
	if (cJSON_AddStringToObject(cjsonObjRelay, "value", szTempBuffer) == NULL)
	{
		cJSON_Delete(cjsonObj);
		cJSON_Delete(cjsonObjRelay);
		return NULL;
	}
	if (cJSON_AddItemToArray(cjsonObj, cjsonObjRelay) == 0)
		LUAT_DEBUG_PRINT("error ");

	cJSON* cjsonObjKey = cJSON_CreateObject();
	if (cjsonObjKey == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	if (cJSON_AddStringToObject(cjsonObjKey, "id", "key") == NULL)
	{
		cJSON_Delete(cjsonObj);
		cJSON_Delete(cjsonObjKey);
		return NULL;
	}
	snprintf(szTempBuffer, sizeof(szTempBuffer), "%d", getOptocoupler(0));
	if (cJSON_AddStringToObject(cjsonObjKey, "value", szTempBuffer) == NULL)
	{
		cJSON_Delete(cjsonObj);
		cJSON_Delete(cjsonObjKey);
		return NULL;
	}
	if (cJSON_AddItemToArray(cjsonObj, cjsonObjKey) == 0)
		LUAT_DEBUG_PRINT("error ");

	cJSON* cjsonObjUart = cJSON_CreateObject();
	if (cjsonObjKey == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	if (cJSON_AddStringToObject(cjsonObjUart, "id", "uart") == NULL)
	{
		cJSON_Delete(cjsonObj);
		cJSON_Delete(cjsonObjUart);
		return NULL;
	}
	snprintf(szTempBuffer, sizeof(szTempBuffer), "%s", "1234567890aabcdefg");
	if (cJSON_AddStringToObject(cjsonObjUart, "value", "0") == NULL)
	{
		cJSON_Delete(cjsonObj);
		cJSON_Delete(cjsonObjUart);
		return NULL;
	}
	if (cJSON_AddItemToArray(cjsonObj, cjsonObjUart) == 0)
		LUAT_DEBUG_PRINT("error ");

	/* 打印JSON对象(整条链表)的所有数据 */
	char* pstrOut = cJSON_PrintUnformatted(cjsonObj);
	if (pstrOut == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	snprintf(pGetDataBuffer, nLength, "%s", pstrOut);
	LUAT_DEBUG_PRINT("FunctionData= %s", pstrOut);
	//cJSON_Delete(cjsonSummary);
	cJSON_Delete(cjsonObj);
	cJSON_free(pstrOut);

	return pGetDataBuffer;
}

const char* getInformationData(char* pGetDataBuffer, int nLength, const char* pstrRecvMessage)
{

	/*
	local jsonData = {
        rssi = net.getRssi(),
        firmwareVersion = VERSION,
        status = 3 ,
        userId = m_strUserId ,
        longitude = m_strLongitude ,
        latitude = m_strLatitude,
        summary = {
            name= "device",
            chip = "air724",
            author = "duxingjie",
            version=0.1,
            create = "2022-08-07"
        }
    }
	*/
	cJSON* cjsonObj = cJSON_CreateObject();
	if (cjsonObj == NULL)
		return NULL;
	if (cJSON_AddNumberToObject(cjsonObj, "rssi", -43) == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	if (cJSON_AddStringToObject(cjsonObj, "firmwareVersion", "1.2") == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	if (cJSON_AddNumberToObject(cjsonObj, "status", 3) == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	if (cJSON_AddStringToObject(cjsonObj, "userId", "1") == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	if (cJSON_AddNumberToObject(cjsonObj, "longitude",0) == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	if (cJSON_AddNumberToObject(cjsonObj, "latitude", 0) == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	
	cJSON* cjsonSummary = cJSON_CreateObject();
	if (cjsonSummary == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}

	if (cJSON_AddStringToObject(cjsonSummary, "name", "wumei-smart") == NULL)
	{
		cJSON_Delete(cjsonSummary);
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	if (cJSON_AddStringToObject(cjsonSummary, "chip", "wumei-smart") == NULL)
	{
		cJSON_Delete(cjsonSummary);
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	if (cJSON_AddStringToObject(cjsonSummary, "author", "wumei-smart") == NULL)
	{
		cJSON_Delete(cjsonSummary);
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	if (cJSON_AddNumberToObject(cjsonSummary, "version", 1.2) == NULL)
	{
		cJSON_Delete(cjsonSummary);
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	if(cJSON_AddStringToObject(cjsonSummary, "createTime", "2022-12-09") == NULL)
	{
		cJSON_Delete(cjsonSummary);
		cJSON_Delete(cjsonObj);
		return NULL;
	}

	if(cJSON_AddItemToObject(cjsonObj, "summary", cjsonSummary) == NULL)
	{
		cJSON_Delete(cjsonSummary);
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	
	/* 打印JSON对象(整条链表)的所有数据 */
	char* pstrOut = cJSON_PrintUnformatted(cjsonObj);
	if (pstrOut == NULL)
	{
		cJSON_Delete(cjsonObj);
		return NULL;
	}
	snprintf(pGetDataBuffer,nLength,"%s", pstrOut);
	LUAT_DEBUG_PRINT("InformationData= %s", pstrOut);
	//cJSON_Delete(cjsonSummary);
	cJSON_Delete(cjsonObj);
	cJSON_free(pstrOut);
	
	return pGetDataBuffer;
}

const char* getEventData(char* pGetDataBuffer, int nLength, const char* pstrRecvMessage)
{
	return NULL;
}