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


#include "common_api.h"
#include "FreeRTOS.h"
#include "task.h"

#include "ps_event_callback.h"
#include "ps_lib_api.h"
#include "sockets.h"
#include "networkmgr.h"
#include "netdb.h"
#include "slpman.h"
#include "time.h"
#include "HTTPClient.h"
#include "plat_config.h"
#include "semphr.h"
typedef struct
{
	ip_addr_t remote_ip;
	ip_addr_t local_ip;
	void *wait_link_sem;
	void *wait_dns_sem;
	void *heart_timer;
	void *pa_delay_timer;
	int socket_id;
	uint8_t is_link_up;
	uint8_t ipv4_cid;
	uint8_t ipv6_cid;
}demo_ctrl_t;

//ciphersuite: TLS-RSA-WITH-AES-128-CBC-SHA  msglen = 2609
//support session ticket/fragment
#define TEST_SERVER_NAME        "https://www.howsmyssl.com:443/a/check"

#define TEST_HOST "https://www.howsmyssl.com:443"
#define HTTP_RECV_BUF_SIZE      (1501)
#define HTTP_HEAD_BUF_SIZE      (800)

static demo_ctrl_t g_s_demo;
static HttpClientContext        gHttpClient = {0};

static const char *testCaCrt = \
{
    \
    "-----BEGIN CERTIFICATE-----\r\n"
    "MIIDSjCCAjKgAwIBAgIQRK+wgNajJ7qJMDmGLvhAazANBgkqhkiG9w0BAQUFADA/\r\n" \
    "MSQwIgYDVQQKExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMT\r\n" \
    "DkRTVCBSb290IENBIFgzMB4XDTAwMDkzMDIxMTIxOVoXDTIxMDkzMDE0MDExNVow\r\n" \
    "PzEkMCIGA1UEChMbRGlnaXRhbCBTaWduYXR1cmUgVHJ1c3QgQ28uMRcwFQYDVQQD\r\n" \
    "Ew5EU1QgUm9vdCBDQSBYMzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB\r\n" \
    "AN+v6ZdQCINXtMxiZfaQguzH0yxrMMpb7NnDfcdAwRgUi+DoM3ZJKuM/IUmTrE4O\r\n" \
    "rz5Iy2Xu/NMhD2XSKtkyj4zl93ewEnu1lcCJo6m67XMuegwGMoOifooUMM0RoOEq\r\n" \
    "OLl5CjH9UL2AZd+3UWODyOKIYepLYYHsUmu5ouJLGiifSKOeDNoJjj4XLh7dIN9b\r\n" \
    "xiqKqy69cK3FCxolkHRyxXtqqzTWMIn/5WgTe1QLyNau7Fqckh49ZLOMxt+/yUFw\r\n" \
    "7BZy1SbsOFU5Q9D8/RhcQPGX69Wam40dutolucbY38EVAjqr2m7xPi71XAicPNaD\r\n" \
    "aeQQmxkqtilX4+U9m5/wAl0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNV\r\n" \
    "HQ8BAf8EBAMCAQYwHQYDVR0OBBYEFMSnsaR7LHH62+FLkHX/xBVghYkQMA0GCSqG\r\n" \
    "SIb3DQEBBQUAA4IBAQCjGiybFwBcqR7uKGY3Or+Dxz9LwwmglSBd49lZRNI+DT69\r\n" \
    "ikugdB/OEIKcdBodfpga3csTS7MgROSR6cz8faXbauX+5v3gTt23ADq1cEmv8uXr\r\n" \
    "AvHRAosZy5Q6XkjEGB5YGV8eAlrwDPGxrancWYaLbumR9YbK+rlmM6pZW87ipxZz\r\n" \
    "R8srzJmwN0jP41ZL9c8PDHIyh8bwRLtTcm1D9SZImlJnt1ir/md2cXjbDaJWFBM5\r\n" \
    "JDGFoqgCWjBH4d1QB7wCCZAA62RjYJsWvIjJEubSfZGL+T0yjWW06XyxV3bqxbYo\r\n" \
    "Ob8VZRzI9neWagqNdwvYkQsEjgfbKbYK7p2CNTUQ\r\n" \
    "-----END CERTIFICATE-----"
};

static INT32 ps_callback(PsEventID eventID, void *param, UINT32 paramLen)
{
    CmiSimImsiStr *imsi = NULL;
    CmiPsCeregInd *creg = NULL;
    NmAtiNetInfoInd *net_info = NULL;

    switch(eventID)
    {
        case PS_URC_ID_SIM_READY:
        {
            imsi = (CmiSimImsiStr *)param;
            DBG("SIM ready(imsi=%s len=%d)", imsi->contents, imsi->length);
            break;
        }
        case PS_URC_ID_PS_BEARER_ACTED:
        {
        	DBG("Default bearer activated");
            break;
        }
        case PS_URC_ID_PS_BEARER_DEACTED:
        {
        	DBG("Default bearer Deactivated");
            break;
        }
        case PS_URC_ID_PS_CEREG_CHANGED:
        {
            creg = (CmiPsCeregInd *)param;
            DBG("CREG message act:%d celId:%d locPresent:%d state:%d", creg->act, creg->celId, creg->locPresent, creg->state);
            break;
        }
        case PS_URC_ID_PS_NETINFO:
        {
            net_info = (NmAtiNetInfoInd *)param;
			DBG("%d,%d,%d,%d", net_info->indCause, net_info->netifInfo.netStatus, net_info->netifInfo.ipv4Cid, net_info->netifInfo.ipv6Cid);
			switch(net_info->indCause)
			{
			case NM_STATUS_CHANGE_LINK_UP:
			case NM_STATUS_CHANGE_LINK_UP_IPV4:
			case NM_STATUS_CHANGE_LINK_UP_IPV6:
			case NM_STATUS_CHANGE_RA_SUCCESS:
				DBG("network ready");
				if (!g_s_demo.is_link_up)
				{
					g_s_demo.is_link_up = 1;
					xSemaphoreGive(g_s_demo.wait_link_sem);
				}
				break;
			default:
				g_s_demo.is_link_up = 0;
				DBG("network not ready");
				break;
			}

			if (NM_NETIF_ACTIVATED == net_info->netifInfo.netStatus)
			{
				g_s_demo.ipv4_cid = net_info->netifInfo.ipv4Cid;
				g_s_demo.ipv6_cid = net_info->netifInfo.ipv6Cid;
				g_s_demo.local_ip.type = IPADDR_TYPE_V4;
				g_s_demo.local_ip.u_addr.ip4 = net_info->netifInfo.ipv4Info.ipv4Addr;
			}
            break;
        }
        default:
            break;

    }
    return 0;
}

/**
  \fn      INT32 httpGetData(CHAR *getUrl, CHAR *buf, UINT32 len)
  \brief
  \return
*/
static INT32 httpGetData(CHAR *getUrl, CHAR *buf, UINT32 len)
{
    HTTPResult result = HTTP_INTERNAL;
    HttpClientData    clientData = {0};
    UINT32 count = 0;
    uint16_t headerLen = 0;

    EC_ASSERT(buf != NULL,0,0,0);

    clientData.headerBuf = malloc(HTTP_HEAD_BUF_SIZE);
    clientData.headerBufLen = HTTP_HEAD_BUF_SIZE;
    clientData.respBuf = buf;
    clientData.respBufLen = len;

    result = httpSendRequest(&gHttpClient, getUrl, HTTP_GET, &clientData);
    DBG("send request result=%d", result);
    if (result != HTTP_OK)
        goto exit;
    do {
    	DBG("recvResponse loop.");
        memset(clientData.headerBuf, 0, clientData.headerBufLen);
        memset(clientData.respBuf, 0, clientData.respBufLen);
        result = httpRecvResponse(&gHttpClient, &clientData);
        if(result == HTTP_OK || result == HTTP_MOREDATA){
            headerLen = strlen(clientData.headerBuf);
            if(headerLen > 0)
            {
            	DBG("total content length=%d", clientData.recvContentLength);
            }

            if(clientData.blockContentLen > 0)
            {
            	DBG("response content:{%s}", (uint8_t*)clientData.respBuf);
            }
            count += clientData.blockContentLen;
            DBG("has recv=%d", count);
        }
    } while (result == HTTP_MOREDATA || result == HTTP_CONN);

    DBG("result=%d", result);
    if (gHttpClient.httpResponseCode < 200 || gHttpClient.httpResponseCode > 404)
    {
    	DBG("invalid http response code=%d",gHttpClient.httpResponseCode);
    } else if (count == 0 || count != clientData.recvContentLength) {
    	DBG("data not receive complete");
    } else {
    	DBG("receive success");
    }
exit:
    free(clientData.headerBuf);
    return result;
}

static void task_test_https(void *param)
{
	BSP_SetPlatConfigItemValue(PLAT_CONFIG_ITEM_FAULT_ACTION, 0);//死机不重启而是打印信息
	char *recvBuf = malloc(HTTP_RECV_BUF_SIZE);
	HTTPResult result = HTTP_INTERNAL;
	uint8_t test_sleep_handler;
	slpManSetPmuSleepMode(true, SLP_HIB_STATE, false);
	slpManApplyPlatVoteHandle("test", &test_sleep_handler);
	slpManPlatVoteDisableSleep(test_sleep_handler, SLP_SLP2_STATE);

    g_s_demo.wait_link_sem = xSemaphoreCreateBinary();

    registerPSEventCallback(PS_GROUP_ALL_MASK, ps_callback);
    gHttpClient.caCert= (char*)testCaCrt;
    gHttpClient.caCertLen= strlen(testCaCrt)+1;
    gHttpClient.timeout_s = 2;
    gHttpClient.timeout_r = 20;
    gHttpClient.seclevel = 1;
    gHttpClient.ciphersuite[0] = 0xFFFF;
    gHttpClient.ignore = 1;
    xSemaphoreTake(g_s_demo.wait_link_sem, portMAX_DELAY);
    result = httpConnect(&gHttpClient, TEST_HOST);
    if (result == HTTP_OK)
    {
        httpGetData(TEST_SERVER_NAME, recvBuf, HTTP_RECV_BUF_SIZE);
        httpClose(&gHttpClient);
    }
    else
    {
        DBG("http client connect error");
    }

    while(1)
    {
        vTaskDelay(300000);
        if (!g_s_demo.is_link_up)
        {
        	xSemaphoreTake(g_s_demo.wait_link_sem, portMAX_DELAY);
        }
        result = httpConnect(&gHttpClient, TEST_HOST);
        if (result == HTTP_OK)
        {
            httpGetData(TEST_SERVER_NAME, recvBuf, HTTP_RECV_BUF_SIZE);
            httpClose(&gHttpClient);
        }
        else
        {
            DBG("http client connect error");
        }
    }

	vTaskDelete(NULL);
}

static void task_demo_https(void)
{
	xTaskCreate(task_test_https, "ntp", 2048, NULL, 20, NULL);
}
//启动task_demoF_init，启动位置任务2级
INIT_TASK_EXPORT(task_demo_https, "1");

