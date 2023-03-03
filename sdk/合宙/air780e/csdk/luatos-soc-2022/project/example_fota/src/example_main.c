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
#include "luat_mobile.h"
#include "luat_rtos.h"
#include "luat_debug.h"
#include "luat_fota.h"
#include "reset.h"
#include "HTTPClient.h"

/*
FOTA应用开发可以参考：https://doc.openluat.com/wiki/37?wiki_page_id=4562
*/


#define PROJECT_VERSION  "1.0.0"
//ciphersuite: TLS-RSA-WITH-AES-128-CBC-SHA  msglen = 2609
//support session ticket/fragment

#define TEST_SERVER_NAME        "http://airtest.openluat.com:2900/download/csdk_delta_test.par"

#define TEST_HOST "http://airtest.openluat.com:2900"
#define HTTP_RECV_BUF_SIZE      (1501)
#define HTTP_HEAD_BUF_SIZE      (800)

static HttpClientContext        gHttpClient = {0};
luat_fota_img_proc_ctx_ptr test_luat_fota_handle = NULL;

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
    int result1 = 0;

    LUAT_DEBUG_ASSERT(buf != NULL,0,0,0);

    clientData.headerBuf = malloc(HTTP_HEAD_BUF_SIZE);
    clientData.headerBufLen = HTTP_HEAD_BUF_SIZE;
    clientData.respBuf = buf;
    clientData.respBufLen = len;
    
    result = httpSendRequest(&gHttpClient, getUrl, HTTP_GET, &clientData);
    LUAT_DEBUG_PRINT("send request result=%d", result);
    if (result != HTTP_OK)
        goto exit;
    do {
    	LUAT_DEBUG_PRINT("recvResponse loop.");
        memset(clientData.headerBuf, 0, clientData.headerBufLen);
        memset(clientData.respBuf, 0, clientData.respBufLen);
        result = httpRecvResponse(&gHttpClient, &clientData);
        if(result == HTTP_OK || result == HTTP_MOREDATA){
            headerLen = strlen(clientData.headerBuf);
            if(headerLen > 0)
            {
            	LUAT_DEBUG_PRINT("total content length=%d", clientData.recvContentLength);
                test_luat_fota_handle = luat_fota_init();
            }

            if(clientData.blockContentLen > 0)
            {
            	LUAT_DEBUG_PRINT("response content:{%s}", (uint8_t*)clientData.respBuf);
                result1 = luat_fota_write(test_luat_fota_handle,clientData.respBuf,clientData.blockContentLen);
                if (result1==0)
                {
                    LUAT_DEBUG_PRINT("fota update success");
                }
                else{
                    LUAT_DEBUG_PRINT("fota update error");
                }
            }
            count += clientData.blockContentLen;

            
            LUAT_DEBUG_PRINT("has recv=%d", count);
        }
    } while (result == HTTP_MOREDATA || result == HTTP_CONN);

    LUAT_DEBUG_PRINT("result=%d", result);
    if (gHttpClient.httpResponseCode < 200 || gHttpClient.httpResponseCode > 404)
    {
    	LUAT_DEBUG_PRINT("invalid http response code=%d",gHttpClient.httpResponseCode);
    } else if (count == 0 || count != clientData.recvContentLength) {
    	LUAT_DEBUG_PRINT("data not receive complete");
    } else {
    	LUAT_DEBUG_PRINT("receive success");
    }
exit:
    free(clientData.headerBuf);
    return result;
}

luat_rtos_semaphore_t net_semaphore_handle;
luat_rtos_task_handle https_task_handle;

void mobile_event_callback(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status){
    if (event == LUAT_MOBILE_EVENT_NETIF && status == LUAT_MOBILE_NETIF_LINK_ON){
        LUAT_DEBUG_PRINT("network ready");
        luat_rtos_semaphore_release(net_semaphore_handle);
    }
}

static void task_test_fota(void *param)
{
    luat_rtos_semaphore_create(&net_semaphore_handle, 1);

	char *recvBuf = malloc(HTTP_RECV_BUF_SIZE);
	HTTPResult result = HTTP_INTERNAL;

    luat_mobile_event_register_handler(mobile_event_callback);

    luat_rtos_task_sleep(3000);
    LUAT_DEBUG_PRINT("version = %s", PROJECT_VERSION);

    gHttpClient.timeout_s = 2;
    gHttpClient.timeout_r = 20;
    gHttpClient.seclevel = 1;
    gHttpClient.ciphersuite[0] = 0xFFFF;
    gHttpClient.ignore = 1;

    luat_rtos_semaphore_take(net_semaphore_handle, LUAT_WAIT_FOREVER);

    result = httpConnect(&gHttpClient, TEST_HOST);
    if (result == HTTP_OK)
    {
        httpGetData(TEST_SERVER_NAME, recvBuf, HTTP_RECV_BUF_SIZE);
        httpClose(&gHttpClient);
        LUAT_DEBUG_PRINT("verify start");
        int verify = luat_fota_done(test_luat_fota_handle);
        if(verify != 0)
        {
            LUAT_DEBUG_PRINT("image_verify error");
            goto exit;
        }
	    LUAT_DEBUG_PRINT("image_verify ok");
        ResetStartPorReset(RESET_REASON_FOTA);
    }
    else
    {
        LUAT_DEBUG_PRINT("http client connect error");
    }
    exit:
    luat_rtos_task_delete(https_task_handle);
}

static void task_demo_fota(void)
{
	luat_rtos_task_create(&https_task_handle, 32*1024, 20, "https", task_test_fota, NULL, NULL);
}
//启动task_demoF_init，启动位置任务2级
INIT_TASK_EXPORT(task_demo_fota, "1");

