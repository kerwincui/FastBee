#include "comAuth.h"

#include "HTTPClient.h"
#include "cJSON.h"
#include "osasys.h"
#include <time.h>
#include "luat_rtc.h"
#include "luat_crypto.h"
#include "base64.h"
static char* g_pstrEncryptionMode = NULL;
static int g_nProductId = 0;
static char* g_pstrDeviceId = NULL;
static char* g_pstrUserId = NULL;
static char* g_pstrUser = NULL;
static char* g_pstrPassword = NULL;
static unsigned int g_nTimeout = 0;
static char* g_pstrIp = NULL;
static char* g_pstrDeviceAuthorizationCode = NULL;
static char* g_pstrProductPassword = NULL;
static void* g_callback = NULL;

static time_t  g_nLocalTime = 0;

/* http 通信相关 */

#define HTTP_RECV_BUF_SIZE      (1501)
#define HTTP_HEAD_BUF_SIZE      (800)
static HttpClientContext* g_pHttpClient = NULL;

char* getComAuthUser()
{
	return g_pstrUser;
}

int wuMeiAes(char* pInData,int nInLength,char* pOutData, int nOutLength,const char* pKey) 
{ 
	const char* str = pInData;//"P47254TN6NNBB01L&2001841772&";
	const char* key = pKey;//"KL0MKIA2HIAT2346";
	uint8_t* temp = NULL;
	int ret = 0;
	int flags = MBEDTLS_ENCRYPT; //设置为加密模式
	unsigned char output[32] = { 0 };
	size_t input_size = 0;
	size_t output_size = 0;
	size_t block_size = 0;
	mbedtls_cipher_context_t ctx;
	mbedtls_cipher_init(&ctx);

	const mbedtls_cipher_info_t* _cipher = mbedtls_cipher_info_from_string("AES-128-CBC"); //载入一些信息
	if (_cipher == NULL) {
		LUAT_DEBUG_PRINT("mbedtls_cipher_info fail %s not support", "AES-128-CBC");
		goto _error_exit;
	}

	ret = mbedtls_cipher_setup(&ctx, _cipher); //填充上下文
	if (ret) 
	{
		LUAT_DEBUG_PRINT("mbedtls_cipher_setup fail -0x%04x %s", -ret, "AES-128-CBC");
		goto _error_exit;
	}
	ret = mbedtls_cipher_setkey(&ctx, (const unsigned char*)key, 128, MBEDTLS_ENCRYPT);
	if (ret)
	{
		LUAT_DEBUG_PRINT("mbedtls_cipher_setkey fail -0x%04x %s", -ret, "AES-128-CBC");
		goto _error_exit;
	}
	ret = mbedtls_cipher_set_iv(&ctx, (const unsigned char*)"wumei-smart-open", 16);
	if (ret) 
	{
		LUAT_DEBUG_PRINT("mbedtls_cipher_set_iv fail -0x%04x %s", -ret, "AES-128-CBC");
		goto _error_exit;
	}
	
	mbedtls_cipher_reset(&ctx);
	mbedtls_cipher_set_padding_mode(&ctx, MBEDTLS_PADDING_PKCS7);
	
	// 开始注入数据
	block_size = mbedtls_cipher_get_block_size(&ctx);

#if MBEDTLS_VERSION_NUMBER >= 0x03000000
	int cipher_mode = mbedtls_cipher_info_get_mode(_cipher);
#else
	int cipher_mode = _cipher->mode;
#endif
	size_t nIndex = 0;
	for (size_t i = 0; i < nInLength; i += block_size)
	{
		input_size = nInLength - i;
		if (input_size > block_size)
		{
			input_size = block_size;
			ret = mbedtls_cipher_update(&ctx, (const unsigned char*)(str + i), input_size, output, &output_size);
			LUAT_DEBUG_PRINT("input_size=%d i=%d   1", input_size,i);
		}
		else
		{
			ret = mbedtls_cipher_update(&ctx, (const unsigned char*)(str + i), input_size, output, &output_size);
			LUAT_DEBUG_PRINT("input_size=%d i=%d   3 output_size=%d", input_size, i , output_size);
		}

		if (ret)
		{
			LUAT_DEBUG_PRINT("mbedtls_cipher_update fail 0x%04X %s", -ret, "AES-128-CBC");
			goto _exit;
		}
		if (output_size > 0) 
		{
			LUAT_DEBUG_PRINT("output_size= %d", output_size);
			if ((output_size + nIndex) <= nOutLength)
			{
				memcpy(pOutData + nIndex, output, output_size);
				nIndex = nIndex + output_size;
			}
			else
				goto _error_exit;
		}
		output_size = 0;
	}
	output_size = 0;
	ret = mbedtls_cipher_finish(&ctx, (unsigned char*)output, &output_size);
	if (ret) {
		LUAT_DEBUG_PRINT("mbedtls_cipher_finish fail 0x%04X %s", -ret, "AES-128-CBC");
		goto _exit;
	}
	if ((output_size + nIndex) <= nOutLength)
	{
		memcpy(pOutData + nIndex, output, output_size);
		nIndex = nIndex + output_size;
	}
	else
		goto _error_exit;
_exit:
	free(temp);
	mbedtls_cipher_free(&ctx);
	return nIndex;
_error_exit:
	if(temp != NULL)
		free(temp);
	mbedtls_cipher_free(&ctx);
	return 0;
}

static void PrintfHex(char* pData, char nLength)
{
	static char tmpBuffer[1024] = { 0 };
	tmpBuffer[0] = 0;
	for (int i = 0; i < nLength; i++)
	{
		char tmp[4] = { 0 };
		snprintf(tmp, 4," %02x", pData[i]);
		strcat(tmpBuffer, tmp);
	}
	LUAT_DEBUG_PRINT("-------------HEX-------------------");
	LUAT_DEBUG_PRINT("PrintfHex()= %s", tmpBuffer);
	LUAT_DEBUG_PRINT("-------------HEX-------------------");
}

char* getComAuthPassword()
{
	#define getComAuthPasswordINBufferMax 64
	static char szAuthPassword[(getComAuthPasswordINBufferMax / 16) * 16] = { 0 }; //能编译分配出16的倍数不？
	if (strcmp(g_pstrEncryptionMode, "S") == 0)
	{
		if(strlen(g_pstrDeviceAuthorizationCode) == 0)
			snprintf(szAuthPassword, sizeof(szAuthPassword), "%s", g_pstrPassword);
		else
			snprintf(szAuthPassword, sizeof(szAuthPassword), "%s&%s", g_pstrPassword, g_pstrDeviceAuthorizationCode);
		LUAT_DEBUG_PRINT("getComAuthPassword()= %s", szAuthPassword);
		return szAuthPassword;
	}
	else if (strcmp(g_pstrEncryptionMode, "E") == 0)
	{
		char* pstrAesSource = szAuthPassword;
		char nAesDataLength = 0;
		time_t nExpireTime = g_nLocalTime + g_nTimeout;
		if(strlen(g_pstrDeviceAuthorizationCode) == 0)
			snprintf(pstrAesSource, sizeof(szAuthPassword), "%s&%lld", g_pstrPassword, nExpireTime);
		else
			snprintf(pstrAesSource, sizeof(szAuthPassword), "%s&%lld&%s", g_pstrPassword, nExpireTime, g_pstrDeviceAuthorizationCode);
		char nOutLength = 0;
		char nIntLength = strlen(pstrAesSource);
		LUAT_DEBUG_PRINT("Instr= %s ln=%d", pstrAesSource, nIntLength);
		nIntLength = wuMeiAes(pstrAesSource, nIntLength, pstrAesSource,sizeof(szAuthPassword), g_pstrProductPassword);
		static char szAesJson[getComAuthPasswordINBufferMax*5] = { 0 };
		
		//if (luat_crypto_base64_encode(szAesJson, sizeof(szAesJson), &nOutLength, pstrAesSource, nIntLength) != 0)
		//	return "NULL";
		nOutLength = iBase64Encode(pstrAesSource, nIntLength, szAesJson);
		LUAT_DEBUG_PRINT("szAesJson= %s nOutLength=%d nIntLength=%d", szAesJson, nOutLength, nIntLength);
		return szAesJson;
	}
	else
		return "";
}

char* getComAuthClientId()
{
	static char szClientId[100] = {0};
	snprintf(szClientId, 99, "%s&%s&%d&%s", g_pstrEncryptionMode, g_pstrDeviceId, g_nProductId, g_pstrUserId);
	LUAT_DEBUG_PRINT("getComAuthClientId()= %s" , szClientId);
	return szClientId;
}

char* getComAuthIp()
{
	LUAT_DEBUG_PRINT("getComAuthIp()= %s", g_pstrIp);
	return g_pstrIp;
}

static unsigned int getJson(const char* pstrJson)
{
	time_t nDeviceSendTime = 0;
	time_t nServerSendTime = 0;
	time_t nServerRecvTime = 0;
	//cJSON_Minify(pstrJson); //去除一些内容
	cJSON* pjsonRoot = cJSON_Parse(pstrJson); //解析
	if (pjsonRoot == NULL)
	{
		LUAT_DEBUG_PRINT("cJSON_Parse Error");
		return 0;
	}
	cJSON* pjsonDeviceSendTime = cJSON_GetObjectItemCaseSensitive(pjsonRoot, "deviceSendTime"); //跟进key 获取一个item
	if (pjsonDeviceSendTime == NULL)
	{
		cJSON_Delete(pjsonRoot);
		return 0;
	}
	LUAT_DEBUG_PRINT("get deviceSendTime ok");
	if (cJSON_IsNumber(pjsonDeviceSendTime))
		nDeviceSendTime = pjsonDeviceSendTime->valueint;
	
	cJSON* pjsonServerSendTime = cJSON_GetObjectItemCaseSensitive(pjsonRoot, "serverSendTime");
	if (pjsonServerSendTime == NULL)
	{
		cJSON_Delete(pjsonRoot);
		return 0;
	}
	LUAT_DEBUG_PRINT("get serverSendTime ok");
	//if (cJSON_IsNumber(pjsonServerSendTime))
	//	nServerSendTime = pjsonServerSendTime->valueint;
	cJSON_GetLongLong(pjsonRoot, "serverSendTime",&nServerSendTime);

	cJSON* pjsonServerRecvTime = cJSON_GetObjectItemCaseSensitive(pjsonRoot, "serverRecvTime");
	if (pjsonServerRecvTime == NULL)
	{
		cJSON_Delete(pjsonRoot);
		return 0;
	}
	LUAT_DEBUG_PRINT("get serverRecvTime ok");
	//if (cJSON_IsNumber(pjsonServerRecvTime))
	//	nServerRecvTime = pjsonServerRecvTime->valueint; //cjson库 存在64位int bug
	cJSON_GetLongLong(pjsonRoot, "serverRecvTime", &nServerRecvTime);
	cJSON_Delete(pjsonRoot);
	//ToDo 注意内存释放问题
	time_t nDeviceRunTickMs = OsaSystemTimeReadUtc()->UTCms;
	time_t nSyncTime = (nServerRecvTime + nServerSendTime)/2 + (nDeviceRunTickMs - nDeviceSendTime) / 2;
	g_nLocalTime = nSyncTime;
	LUAT_DEBUG_PRINT("--1--nSyncTime=%lld ", nSyncTime);
	struct tm* pTime = localtime(&nSyncTime);
	LUAT_DEBUG_PRINT("---nServerRecvTime=%lld nServerSendTime=%lld nDeviceSendTime=%d nDeviceRunTickMs=%d", nServerRecvTime, nServerSendTime, nDeviceSendTime, nDeviceRunTickMs);
	luat_rtc_set(pTime);
	return 1;
}
/**
  \fn      INT32 httpGetData(CHAR *getUrl, CHAR *buf, UINT32 len)
  \brief
  \return
*/
static INT32 httpGetData(CHAR* getUrl, CHAR* buf, UINT32 len)
{
	HTTPResult result = HTTP_INTERNAL;
	HttpClientData    clientData = { 0 };
	UINT32 count = 0;
	uint16_t headerLen = 0;

	clientData.headerBuf = malloc(HTTP_HEAD_BUF_SIZE);
	clientData.headerBufLen = HTTP_HEAD_BUF_SIZE;
	clientData.respBuf = buf;
	clientData.respBufLen = len;

	result = httpSendRequest(g_pHttpClient, getUrl, HTTP_GET, &clientData);
	LUAT_DEBUG_PRINT("-----httpSendRequest =%d\n\r", result);
	if (result != HTTP_OK)
		goto exit;
	do 
	{
		memset(clientData.headerBuf, 0, clientData.headerBufLen);
		memset(clientData.respBuf, 0, clientData.respBufLen);
		result = httpRecvResponse(g_pHttpClient, &clientData); //取接收响应
		if (result == HTTP_OK || result == HTTP_MOREDATA)
		{
			headerLen = strlen(clientData.headerBuf);
			if (headerLen > 0)
			{
				LUAT_DEBUG_PRINT("total content length=%d", clientData.recvContentLength);
			}
			if (clientData.blockContentLen > 0)
			{
				LUAT_DEBUG_PRINT("response content:{%s}", (uint8_t*)clientData.respBuf);
			}
			count += clientData.blockContentLen;
			LUAT_DEBUG_PRINT("has recv=%d", count);
		}
	} while (result == HTTP_MOREDATA || result == HTTP_CONN);

	LUAT_DEBUG_PRINT("result=%d", result);
	if (g_pHttpClient->httpResponseCode < 200 || g_pHttpClient->httpResponseCode > 404)
	{
		LUAT_DEBUG_PRINT("invalid http response code=%d", g_pHttpClient->httpResponseCode);
	}
	else if (count == 0 || count != clientData.recvContentLength)
	{
		LUAT_DEBUG_PRINT("data not receive complete");
	}
	else 
	{
		LUAT_DEBUG_PRINT("receive success"); //接收数据成功
		/*
			{
			"deviceSendTime": 35768,
			"serverSendTime": 1668995219357,
			"serverRecvTime": 1668995219357
			}
		*/
		result = HTTP_OK;
	}
exit:
	free(clientData.headerBuf);
	return result;
}

static void httpGetOver(unsigned char nResult)
{
	((pComAuthResultFunction)g_callback)(nResult);
}

static void comAuthHttpGet(const char* pstrUrl)
{
	HTTPResult result = HTTP_INTERNAL;
	g_pHttpClient = malloc(sizeof(HttpClientContext));
	if (g_pHttpClient == NULL)
	{
		; //打印异常日志
	}
	memset(g_pHttpClient, 0, sizeof(HttpClientContext));
	g_pHttpClient->timeout_s = 5; //发送超时
	g_pHttpClient->timeout_r = 30; //接收超时
	result = httpConnect(g_pHttpClient, pstrUrl);
	result = HTTP_OK;
	LUAT_DEBUG_PRINT("httpConnect=%d", result);
	if (result == HTTP_OK)
	{
		char* pRecvBuf = malloc(HTTP_RECV_BUF_SIZE);
		if (pRecvBuf == NULL)
		{
			//内存不足
			httpGetOver(0); 
			return;
		}
		result = httpGetData(pstrUrl, pRecvBuf, HTTP_RECV_BUF_SIZE);
		if (result == HTTP_OK)
			if(getJson(pRecvBuf) == 1)
				httpGetOver(1);
			else
				httpGetOver(0);
		else
			httpGetOver(0); //临时返回成功
		free(pRecvBuf);
		pRecvBuf = NULL;
		httpClose(g_pHttpClient);
		free(g_pHttpClient);
		g_pHttpClient = NULL;
	}
	else
	{
		httpClose(g_pHttpClient);
		free(g_pHttpClient);
		g_pHttpClient = NULL;
		httpGetOver(0); //连接失败
	}
}

void ComAuthInit(
	const char* pstrEncryptionMode,
	const int nProductId,
	const char* pstrDeviceId,
	const char* pstrUserId,
	const char* pstrUser,
	const char* pstrPassword,
	unsigned int nTimeout,
	const char* pstrIp,
	const char* pstrDeviceAuthorizationCode,
	const char* pstrProductPassword,
	void* callback
)
{
	g_pstrEncryptionMode = pstrEncryptionMode;
	g_nProductId = nProductId;
	g_pstrDeviceId = pstrDeviceId;
	g_pstrUserId = pstrUserId;
	g_pstrUser = pstrUser;
	g_pstrPassword = pstrPassword;
	g_nTimeout = nTimeout;
	g_pstrIp = pstrIp;
	g_pstrDeviceAuthorizationCode = pstrDeviceAuthorizationCode;
	g_pstrProductPassword = pstrProductPassword;
	g_callback = callback;
	char szUrl[100] = {0};
	snprintf(szUrl,99,"http://%s:8080/iot/tool/ntp?deviceSendTime=%d", pstrIp, OsaSystemTimeReadUtc()->UTCms);
	//LUAT_DEBUG_PRINT("szUrl 1 =%s ", szUrl);
	//LUAT_DEBUG_PRINT("g_pstrDeviceId= %s ", g_pstrDeviceId);
	comAuthHttpGet(szUrl);
}
