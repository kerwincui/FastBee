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
#include "http_queue.h"
#include "luat_fs.h"
#include "HTTPClient.h"
#include "cJSON.h"
#include "audio_task.h"
luat_rtos_queue_t http_queue_handle;
extern luat_rtos_queue_t audio_queue_handle;

bool http_get_status = false;   // 这只是一个示例，没有对于多次下发动态报文的处理，简单使用一个变量来控制一下
// ciphersuite: TLS-RSA-WITH-AES-128-CBC-SHA  msglen = 2609
// support session ticket/fragment
#define HTTP_RECV_BUF_SIZE (5000)
#define HTTP_HEAD_BUF_SIZE (800)

static HttpClientContext gHttpClient = {0};

/**
  \fn      INT32 httpGetData(CHAR *getUrl, CHAR *buf, UINT32 len)
  \brief
  \return
*/
static INT32 httpGetData(CHAR *getUrl, CHAR *buf, UINT32 len)
{
    HTTPResult result = HTTP_INTERNAL;
    HttpClientData clientData = {0};
    UINT32 count = 0;
    uint16_t headerLen = 0;

    LUAT_DEBUG_ASSERT(buf != NULL, 0, 0, 0);

    clientData.headerBuf = malloc(HTTP_HEAD_BUF_SIZE);
    clientData.headerBufLen = HTTP_HEAD_BUF_SIZE;
    clientData.respBuf = buf;
    clientData.respBufLen = len;

    result = httpSendRequest(&gHttpClient, getUrl, HTTP_GET, &clientData);
    LUAT_DEBUG_PRINT("send request result=%d", result);
    if (result != HTTP_OK)
        goto exit;
    do
    {
        LUAT_DEBUG_PRINT("recvResponse loop.");
        memset(clientData.headerBuf, 0, clientData.headerBufLen);
        memset(clientData.respBuf, 0, clientData.respBufLen);
        result = httpRecvResponse(&gHttpClient, &clientData);
        if (result == HTTP_OK || result == HTTP_MOREDATA)
        {
            headerLen = strlen(clientData.headerBuf);
            if (headerLen > 0)
            {
                LUAT_DEBUG_PRINT("total content length=%d", clientData.recvContentLength);
            }

            if (clientData.blockContentLen > 0)
            {
                LUAT_DEBUG_PRINT("response content:{%s}", (uint8_t *)clientData.respBuf);
            }
            count += clientData.blockContentLen;
            LUAT_DEBUG_PRINT("has recv=%d", count);
        }
    } while (result == HTTP_MOREDATA || result == HTTP_CONN);

    LUAT_DEBUG_PRINT("result=%d", result);
    if (gHttpClient.httpResponseCode < 200 || gHttpClient.httpResponseCode > 404)
    {
        LUAT_DEBUG_PRINT("invalid http response code=%d", gHttpClient.httpResponseCode);
    }
    else if (count == 0 || count != clientData.recvContentLength)
    {
        LUAT_DEBUG_PRINT("data not receive complete");
    }
    else
    {
        LUAT_DEBUG_PRINT("receive success");
    }
exit:
    free(clientData.headerBuf);
    return result;
}

static INT32 httpGetDataToFile(CHAR *getUrl, CHAR *buf, UINT32 len, char *file) //http下载数据并保存在文件系统
{
    LUAT_DEBUG_PRINT("this wait write filename %s", file);
    HTTPResult result = HTTP_INTERNAL;
    HttpClientData clientData = {0};
    UINT32 count = 0;
    int status;
    uint16_t headerLen = 0;

    LUAT_DEBUG_ASSERT(buf != NULL, 0, 0, 0);

    clientData.headerBuf = malloc(HTTP_HEAD_BUF_SIZE);
    clientData.headerBufLen = HTTP_HEAD_BUF_SIZE;
    clientData.respBuf = buf;
    clientData.respBufLen = len;
    FILE *file_handle = luat_fs_fopen(file, "wb+");

    result = httpSendRequest(&gHttpClient, getUrl, HTTP_GET, &clientData);
    LUAT_DEBUG_PRINT("send request result=%d", result);
    if (result != HTTP_OK)
        goto exit;
    do
    {
        LUAT_DEBUG_PRINT("recvResponse loop.");
        memset(clientData.headerBuf, 0, clientData.headerBufLen);
        memset(clientData.respBuf, 0, clientData.respBufLen);
        result = httpRecvResponse(&gHttpClient, &clientData);
        if (result == HTTP_OK || result == HTTP_MOREDATA)
        {
            headerLen = strlen(clientData.headerBuf);
            if (headerLen > 0)
            {
                LUAT_DEBUG_PRINT("total content length=%d", clientData.recvContentLength);
            }

            if (clientData.blockContentLen > 0)
            {
                LUAT_DEBUG_PRINT("response content:{%s}", (uint8_t *)clientData.respBuf);
            }
            count += clientData.blockContentLen;
            status = luat_fs_fwrite((uint8_t *)clientData.respBuf, clientData.blockContentLen, 1, file_handle);
            if (status == 0)
            {
                while (1)
                    ;
            }
            LUAT_DEBUG_PRINT("has recv=%d", count);
        }
    } while (result == HTTP_MOREDATA || result == HTTP_CONN);

    LUAT_DEBUG_PRINT("result=%d", result);
    luat_fs_fclose(file_handle);
    if (gHttpClient.httpResponseCode < 200 || gHttpClient.httpResponseCode > 404)
    {
        LUAT_DEBUG_PRINT("invalid http response code=%d", gHttpClient.httpResponseCode);
        luat_fs_remove(file);
    }
    else if (count == 0 || count != clientData.recvContentLength)
    {
        LUAT_DEBUG_PRINT("data not receive complete");
        luat_fs_remove(file);
    }
    else
    {
        LUAT_DEBUG_PRINT("receive success");
    }
exit:
    free(clientData.headerBuf);
    return result;
}

luat_rtos_task_handle https_task_handle;

static void task_test_https(void *param)
{
    char *recvBuf = malloc(HTTP_RECV_BUF_SIZE);
    http_queue_t wait_http_request = {0};
    while (1)
    {
        HTTPResult result = HTTP_INTERNAL;
        if (0 == luat_rtos_queue_recv(http_queue_handle, &wait_http_request, NULL, LUAT_WAIT_FOREVER))
        {
            memset(recvBuf, 0x00, HTTP_RECV_BUF_SIZE);
            memset(&gHttpClient, 0, sizeof(HttpClientContext));
            gHttpClient.timeout_s = 2;
            gHttpClient.timeout_r = 20;
            result = httpConnect(&gHttpClient, wait_http_request.url);
            if (wait_http_request.type == SPEECH_POST)
            {
                if (result == HTTP_OK)
                {
                    result = httpGetData(wait_http_request.url, recvBuf, HTTP_RECV_BUF_SIZE);
                    httpClose(&gHttpClient);
                    if (result == HTTP_OK)
                    {
                        cJSON *boss = cJSON_Parse(recvBuf);
                        if (boss != NULL)
                        {
                            cJSON *audio = cJSON_GetObjectItem(boss, "audios");

                            int arraysize = cJSON_GetArraySize(audio);
                            http_queue_t http_get_file = {0};
                            for (size_t i = 0; i < arraysize; i++)
                            {
                                cJSON *row = cJSON_GetArrayItem(audio, i);
                                if (row == NULL)
                                    break;
                                cJSON *format = cJSON_GetObjectItem(row, "format");
                                cJSON *id = cJSON_GetObjectItem(row, "id");
                                cJSON *url = cJSON_GetObjectItem(row, "url");
                                cJSON *size = cJSON_GetObjectItem(row, "size");
                                http_get_file.filename = malloc(strlen(id->valuestring) + strlen(format->valuestring) + 2);
                                memset(http_get_file.filename, 0x00, strlen(id->valuestring) + strlen(format->valuestring) + 2);
                                snprintf(http_get_file.filename, strlen(id->valuestring) + strlen(format->valuestring) + 2, "%s%s%s", id->valuestring, ".", format->valuestring);
                                if (luat_fs_fexist(http_get_file.filename) == 0)        //文件不存在的时候才去下载
                                {
                                    http_get_file.type = PUSH_SPEECH;
                                    http_get_file.url = malloc(strlen(url->valuestring) + 1);
                                    memset(http_get_file.url, 0x00, strlen(url->valuestring) + 1);
                                    memcpy(http_get_file.url, url->valuestring, strlen(url->valuestring) + 1);

                                    if (-1 == luat_rtos_queue_send(http_queue_handle, &http_get_file, 0, 0))
                                    {
                                        free(http_get_file.filename);
                                        LUAT_DEBUG_PRINT("queue send fail");
                                    }
                                }
                                else
                                {
                                    free(http_get_file.filename);
                                    LUAT_DEBUG_PRINT("file exists");
                                }
                            }
                        }
                        cJSON_Delete(boss);
                    }
                }
                else
                {
                    LUAT_DEBUG_PRINT("http client connect error");
                }
            }
            else if (wait_http_request.type == PUSH_SPEECH) // 下载下发的语料文本，并保存在文件系统
            {
                if (result == HTTP_OK)
                {
                    result = httpGetDataToFile(wait_http_request.url, recvBuf, HTTP_RECV_BUF_SIZE, wait_http_request.filename);
                    httpClose(&gHttpClient);
                }
                else
                {
                    LUAT_DEBUG_PRINT("http client connect error");
                }
                LUAT_DEBUG_PRINT("this is http get name and size: %s, %d", wait_http_request.filename, luat_fs_fsize(wait_http_request.filename));
            }
            else if (wait_http_request.type == SPEECH_BY_SYNTHESIS) // 下载动态下发的音频文件，并且去播放
            {
                if (result == HTTP_OK)
                {
                    result = httpGetDataToFile(wait_http_request.url, recvBuf, HTTP_RECV_BUF_SIZE, wait_http_request.filename);
                    httpClose(&gHttpClient);
                    if (result == HTTP_OK)
                    {
                        audioQueueData data = {0};
                        char *file_name = malloc(strlen(wait_http_request.filename) + 1);
                        memset(file_name, 0x00, strlen(wait_http_request.filename) + 1);
                        memcpy(file_name, wait_http_request.filename, strlen(wait_http_request.filename));
                        data.file.info = (audio_play_info_t *)calloc(1, sizeof(audio_play_info_t));
                        data.file.info[0].path = file_name;
                        data.file.count = 1;
                        data.userParam = (void *)file_name;
                        if (-1 == luat_rtos_queue_send(audio_queue_handle, &data, 0, 0))
                        {
                            free(file_name);
                            free(data.file.info);
                            http_get_status = false;    // 这只是一个示例，没有对于多次下发动态报文的处理，简单使用一个变量来控制一下
                            LUAT_DEBUG_PRINT("money send fail");
                        }
                    }
                    else
                    {
                        http_get_status = false;    // 这只是一个示例，没有对于多次下发动态报文的处理，简单使用一个变量来控制一下
                    }
                }
                else
                {
                    LUAT_DEBUG_PRINT("http client connect error");
                }
                LUAT_DEBUG_PRINT("this is http get name and size: %s, %d", wait_http_request.filename, luat_fs_fsize(wait_http_request.filename));
            }

            LUAT_DEBUG_PRINT("this is test result %d", result);

            if (wait_http_request.url != NULL)
            {
                free(wait_http_request.url);
            }
            if (wait_http_request.filename != NULL)
            {
                free(wait_http_request.filename);
            }
        }
    }

    luat_rtos_task_delete(https_task_handle);
}

void task_demo_https(void)
{
    luat_fs_init();
    if (-1 == luat_rtos_queue_create(&http_queue_handle, 100, sizeof(http_queue_t)))
        LUAT_DEBUG_PRINT("http queue create fail");
    luat_rtos_task_create(&https_task_handle, 32 * 1024, 20, "https", task_test_https, NULL, NULL);
}

