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
#include "ps_lib_api.h"
#include "example_main.h"
#include "fota_nvm.h"
#include "at_http_task.h"
#include "slpman.h"
#include "reset.h"
#include "ccio_base.h"
#include "ccio_pub.h"
#include "ccio_tfc.h"
#include "lwip/sockets.h"

#define HTTPFOTA_IND_HANDLER       0x0001
static bool isQFota = FALSE;

typedef int (* fotaProgressCB_t)(void);
fotaProgressCB_t progresscb;

uint32_t fotaFirmwaresize = 0;
httpAtCfgParam_t gHttpcfg = {1,0,0,0,0,0};
amFotaImgProcCtxPtr test_am_fota_handle = NULL;

amFotaProgressCB_t g_am_fota_firmware_download_cb = NULL;

httpAtContext_t gHttpAtCxt = {HTTPSTAT_CLOSE,false,0,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,NULL,0,NULL };
static uint8_t httpSlpHandler = 0xff;
static bool httpRecvTaskRunning = FALSE;
static bool httpSendTaskRunning = FALSE;
static osThreadId_t httprecv_task_handle = NULL;
static osMessageQueueId_t http_msgqueue = NULL;
static osThreadId_t httpsend_task_handle = NULL;
uint16_t curCustheadbodyLen = 0;
uint8_t *gptCustheadbody = NULL;
uint16_t gCustheadbodyLen = 0;
#define HTTPRECV_TASK_STACK_SIZE   3072//2520
#define HTTPSEND_TASK_STACK_SIZE   4096//2976
static uint32_t curContentLen = 0;
static osMutexId_t    httpMutex = NULL;
static CcioTfcPid_t gHttpTfcPid = CCIO_TFC_PID_UNDEF;

static HTTPFotaUrc_e httpFotaStatus = HTTPFOTA_BEGIN;
#define CONTENTTYPE0 "application/x-www-form-urlencoded"
#define CONTENTTYPE1 "text/plain"
#define CONTENTTYPE2 "application/octet-stream"
#define CONTENTTYPE3 "application/form-data"

amFotaImgProcCtxPtr am_fota_init(void)
{
	static int am_fota_core_write_size;
	am_fota_core_write_size = 0;
    fotaNvmInit();
    if(0 != fotaNvmClearDelta(0, fotaNvmGetDeltaSize(0)))
    {
       DBG("clear flash: failure!");
        return NULL;
    }
    DBG("clear flash: success");
    fotaFirmwaresize = 0;
	memset(&g_s_otaCtx, 0, sizeof(g_s_otaCtx));
	return &am_fota_core_write_size;
}

int am_fota_image_write(amFotaImgProcCtxPtr context, void *data, int len)
{
	int offset = *(int*)context;
	DBG("offset:%d len:%d", offset, len);
	uint8_t result = fotaNvmWriteDelta(offset, (uint8_t*)data, len);
	if(result != 0)
	{
		DBG("write_flash error!");
		return -1;
	}
	*(int*)context += len;
	return 0;
}
void httpDeleteClientContext(httpAtContext_t* atContext)
{
    EC_ASSERT(atContext != NULL,0,0,0);
    HttpClientContext* clientContext = atContext->clientContext;

    if(clientContext != NULL)
    {
        if(clientContext->caCert != NULL)
        {
            free((char*)clientContext->caCert);
        }
        if(clientContext->clientCert != NULL)
        {
            free((char*)clientContext->clientCert);
        }
        if(clientContext->clientPk != NULL)
        {
            free((char*)clientContext->clientPk);
        }
        free((void*)clientContext);
        atContext->clientContext = NULL;
    }
}

void httpDeleteClientData(httpAtContext_t* atContext)
{
    EC_ASSERT(atContext != NULL,0,0,0);
    HttpClientData* clientData = atContext->clientData;
    if(clientData != NULL)
    {
        if(clientData->respBuf)
        {
            free(clientData->respBuf);
        }
        if(clientData->headerBuf)
        {
            free(clientData->headerBuf);
        }
        free(clientData);
        atContext->clientData = NULL;
    }
}

static int am_http_down_cb(void)
{
    httpAtContext_t* httpAtCxt = &gHttpAtCxt;
	amFotaSta amFotaStaStatus = AM_FOTA_FAIL;
    uint16_t headerLen = strlen(httpAtCxt->clientData->headerBuf);
    if(headerLen > 0)
    {
        if(httpAtCxt->clientContext->httpResponseCode == 200){
            DBG("fota headerLen:%d contentlength=%d",headerLen, httpAtCxt->clientData->recvContentLength);
            // fotaBegin();
            // httpFotaUrcInd(HTTPFOTA_BEGIN, 0);
        }else{
            DBG("rspcode=%d,can't start fota", httpAtCxt->clientContext->httpResponseCode);
			amFotaStaStatus = AM_FOTA_FAIL;
			g_am_fota_firmware_download_cb(amFotaStaStatus, AM_FOTA_FILE_GET_ERR, NULL, 0);
            return -1;
        }
    }
    if(httpAtCxt->clientData->blockContentLen > 0)
    {
        DBG("CONTENT blockContentLen=%d", httpAtCxt->clientData->blockContentLen);
        // uint8_t result = fotaNvmWriteDelta(fotaFirmwaresize, (uint8_t*)httpAtCxt->clientData->respBuf, httpAtCxt->clientData->blockContentLen);
        // if(result != 0)
        // {
        //     DBG("write_flash error!");
        //     EC_ASSERT(FALSE,httpAtCxt->clientData->blockContentLen,0,0);
        // }
        fotaFirmwaresize += httpAtCxt->clientData->blockContentLen;
	    if(httpAtCxt->dlUrcRag != 0)
        {
			uint32_t percent = (fotaFirmwaresize * httpAtCxt->dlUrcRag) / httpAtCxt->clientData->recvContentLength;
			DBG("has download = %d, percent = %d", httpAtCxt->clientData->blockContentLen, percent);
			
			if(fotaFirmwaresize != httpAtCxt->clientData->recvContentLength)
				amFotaStaStatus = AM_FOTA_INPROGRESS;
			else
				amFotaStaStatus = AM_FOTA_SUCCEED;
			g_am_fota_firmware_download_cb(amFotaStaStatus, percent, httpAtCxt->clientData->respBuf, httpAtCxt->clientData->blockContentLen);

		}
        
    }
    return 0;
}

void httpClearAtContext(httpAtContext_t* atContext)
{
    EC_ASSERT(atContext != NULL,0,0,0);
    atContext->isRange = false;
    atContext->isFota = false;
    isQFota = false;
    atContext->postfile = false;
    atContext->readfile = false;
}

void httpCreateClientContext(httpAtContext_t* atContext)
{
    EC_ASSERT(atContext != NULL,0,0,0);
    if(atContext->clientContext == NULL)
    {
        atContext->clientContext = malloc(sizeof(HttpClientContext));
        memset(atContext->clientContext, 0, sizeof(HttpClientContext));
        atContext->clientContext->timeout_s = 2;  //default send timeout 2 second,no need to wait for a long time for TCP
        atContext->clientContext->timeout_r = 20;  //default recv timeout 20 second
        atContext->clientContext->socket = -1;
        atContext->clientContext->pdpId = gHttpcfg.contextID;
        atContext->clientContext->saveMem = 1;
    }
}

static void httpInitSleepHandler(void)
{
    slpManRet_t result=slpManFindPlatVoteHandle("HTTPSLP", &httpSlpHandler);
    if(result==RET_HANDLE_NOT_FOUND)
        slpManApplyPlatVoteHandle("HTTPSLP",&httpSlpHandler);
}

static int8_t httpMutexCreate(void)
{
    if(httpMutex == NULL)
    {
        httpMutex = osMutexNew(NULL);
    }
    if(httpMutex == NULL)
    {
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}

void httpCreateClientData(httpAtContext_t* atContext)
{
    EC_ASSERT(atContext != NULL,0,0,0);

    if(atContext->clientData == NULL)
    {
        atContext->clientData = malloc(sizeof(HttpClientData));
        memset(atContext->clientData, 0, sizeof(HttpClientData));
        atContext->clientData->headerBufLen = HTTP_RSP_HEAD_BUFFER_SIZE;
        atContext->clientData->headerBuf = malloc(HTTP_RSP_HEAD_BUFFER_SIZE);
        atContext->clientData->respBufLen = HTTP_RSP_CONTENT_BUFFER_SIZE;
        atContext->clientData->respBuf = malloc(HTTP_RSP_CONTENT_BUFFER_SIZE);
    }
}
static void httpConnectInd()
{
    char pIndBuf[32] = {0};
    httpAtContext_t* httpAtCxt = &gHttpAtCxt;

    snprintf(pIndBuf, 32, "\r\nCONNECT\r\n");
    applSendCmsInd(httpAtCxt->reqhandle, APPL_HTTP, APPL_HTTP_URC_IND, strlen(pIndBuf)+1, pIndBuf);
}

static HTTPResult httpAtConnect(httpAtContext_t* httpCxt)
{
    HTTPResult result = httpConnect(httpCxt->clientContext, httpCxt->url);

    return result;
}

static BOOL flowMutexCreate(void)
{
    CcioTfcObjKeys_t  keys;
    CcioTfcObjAttr_t  attr;

    keys.mediaType = CCIO_LAN_MEDIA_AT;
    keys.mediaCid  = AT_GET_HANDLER_CHAN_ID(gHttpAtCxt.reqhandle);
    attr.objId     = CCIO_TOI_HTTP;
    gHttpTfcPid = ccioCreateTfcPolicy(&keys, &attr);

    return TRUE;
}

static int8_t httpMutexAcquire(void)
{
    if (osMutexAcquire(httpMutex, osWaitForever) != osOK)
    {
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}

static void httpMutexRelease(void)
{
    osMutexRelease(httpMutex);
}

static int8_t fotaBegin(void)
{
    fotaNvmInit();

    if(0 != fotaNvmClearDelta(0, fotaNvmGetDeltaSize(0)))
    {
        DBG("clear flash: failure!");
        return -1;
    }

    DBG("clear flash: success");

    fotaFirmwaresize = 0;

    return 0;
}

static void httpFotaUrcInd(HTTPFotaUrc_e code, uint32_t percent)
{
    char pIndBuf[64] = {0};
    httpAtContext_t* httpAtCxt = &gHttpAtCxt;
    httpFotaStatus = code;
    switch(code){
        case HTTPFOTA_BEGIN:
            if(isQFota){
                snprintf(pIndBuf, 64, "\r\n+QIND: \"FOTA\",\"HTTPSTART\"\r\n");
            }else{
                snprintf(pIndBuf, 64, "\r\n+HTTPURC: \"FOTA\",\"HTTPSTART\"\r\n");
            }
            break;
        case HTTPFOTA_DL_PROC:
            if(isQFota){
                snprintf(pIndBuf, 64, "\r\n+QIND: \"FOTA\",\"DOWNLOADING\",%d\r\n", percent);
            }else{
                snprintf(pIndBuf, 64, "\r\n+HTTPURC: \"FOTA\",\"DOWNLOADING\",%d\r\n", percent);
            }
            break;
        case HTTPFOTA_ERR:
            if(isQFota){
                snprintf(pIndBuf, 64, "\r\n+QIND: \"FOTA\",\"DOWNLOADERROR\"\r\n");
            }else{
                snprintf(pIndBuf, 64, "\r\n+HTTPURC: \"FOTA\",\"DOWNLOADERROR\"\r\n");
            }
            break;
        case HTTPFOTA_DOWNLOADEND:
            if(isQFota){
                snprintf(pIndBuf, 64, "\r\n+QIND: \"FOTA\",\"DOWNLOADED\"\r\n");
            }else{
                snprintf(pIndBuf, 64, "\r\n+HTTPURC: \"FOTA\",\"DOWNLOADED\"\r\n");
            }
            break;
        case HTTPFOTA_PACKAGE_MISMATCH:
            snprintf(pIndBuf, 64, "\r\n+HTTPURC: \"FOTA\",\"PACKAGE MISMATCH\"\r\n");
            break;
    }
    applSendCmsInd(HTTPFOTA_IND_HANDLER, APPL_HTTP, APPL_HTTP_URC_IND, strlen(pIndBuf)+1, pIndBuf);
}


static int httpFotaDownload()
{
    httpAtContext_t* httpAtCxt = &gHttpAtCxt;
    uint16_t headerLen = 0;
    uint8_t result = 0;
    uint32_t percent = 0;
    headerLen = strlen(httpAtCxt->clientData->headerBuf);
    if(headerLen > 0)
    {
        if(httpAtCxt->clientContext->httpResponseCode == 200){
            DBG("fota contentlength=%d", httpAtCxt->clientData->recvContentLength);
            fotaBegin();
            httpFotaUrcInd(HTTPFOTA_BEGIN, 0);
        }else{
            DBG("rspcode=%d,can't start fota", httpAtCxt->clientContext->httpResponseCode);
            httpFotaUrcInd(HTTPFOTA_ERR, 0);
            return -1;
        }
    }
    if(httpAtCxt->clientData->blockContentLen > 0)
    {
        DBG("CONTENT blockContentLen=%d", httpAtCxt->clientData->blockContentLen);
        result = fotaNvmWriteDelta(fotaFirmwaresize, (uint8_t*)httpAtCxt->clientData->respBuf, httpAtCxt->clientData->blockContentLen);
        if(result != 0)
        {
            DBG("write_flash error!");
            EC_ASSERT(FALSE,httpAtCxt->clientData->blockContentLen,0,0);
        }
        fotaFirmwaresize += httpAtCxt->clientData->blockContentLen;
        if(httpAtCxt->dlUrcRag != 0)
        {
            percent = (fotaFirmwaresize * httpAtCxt->dlUrcRag) / httpAtCxt->clientData->recvContentLength;
            DBG("has download = %d, percent = %d", httpAtCxt->clientData->blockContentLen, percent);
            httpFotaUrcInd(HTTPFOTA_DL_PROC, percent);
        }
    }
    return 0;
}

static void flowMutexDelete(void)
{
    CcioTfcObjAttr_t  attr = {CCIO_TOI_HTTP, {0}};

    ccioDeleteTfcPolicy(gHttpTfcPid, &attr);
    gHttpTfcPid = CCIO_TFC_PID_UNDEF;
}

static void httpRetInd(AtHttpError_e errCode)
{
    char pIndBuf[32] = {0};
    httpAtContext_t* httpAtCxt = &gHttpAtCxt;
    if(errCode == HTTPAT_OK || errCode == HTTPAT_RECV_COMP){
        if(httpAtCxt->method == HTTP_GET)
        {
            snprintf(pIndBuf, 32, "\r\n+HTTPGET: %d,%d,%d", errCode, httpAtCxt->clientContext->httpResponseCode, httpAtCxt->clientData->recvContentLength);
        }
        else if(httpAtCxt->method == HTTP_POST)
        {
            if(httpAtCxt->postfile){
                snprintf(pIndBuf, 32, "\r\n+HTTPPOSTFILE: %d,%d,%d", errCode, httpAtCxt->clientContext->httpResponseCode, httpAtCxt->clientData->recvContentLength);
            }else{
                snprintf(pIndBuf, 32, "\r\n+HTTPPOST: %d,%d,%d", errCode, httpAtCxt->clientContext->httpResponseCode, httpAtCxt->clientData->recvContentLength);
            }
        }
    }else{
        if(httpAtCxt->method == HTTP_GET)
        {
            snprintf(pIndBuf, 32, "\r\n+HTTPGET: %d,%d,%d", errCode, httpAtCxt->clientContext->httpResponseCode, curContentLen);
        }
        else if(httpAtCxt->method == HTTP_POST)
        {
            if(httpAtCxt->postfile){
                snprintf(pIndBuf, 32, "\r\n+HTTPPOSTFILE: %d,%d,%d", errCode, httpAtCxt->clientContext->httpResponseCode, curContentLen);
            }else{
                snprintf(pIndBuf, 32, "\r\n+HTTPPOST: %d,%d,%d", errCode, httpAtCxt->clientContext->httpResponseCode, curContentLen);
            }
        }
    }
    applSendCmsInd(httpAtCxt->reqhandle, APPL_HTTP, APPL_HTTP_URC_IND, strlen(pIndBuf)+1, pIndBuf);
}

static void httpClientRecvTask(void* arg)
{
    HTTPResult result;
    httpAtContext_t* httpAtCxt = &gHttpAtCxt;
    httpCmdMsg_t httpMsg;
    osStatus_t status;
    fd_set readFs,errorFs;
    struct timeval tv;
    tv.tv_sec = 5;
    tv.tv_usec = 0;
    int maxFs = -1, ret;
    int httpStatus = -1;
    int isRecvTaskRunning = TRUE;
    flowMutexCreate();

    for(;;)
    {
        httpStatus = httpAtCxt->status;
        switch(httpStatus)
        {
            case HTTPSTAT_REQHANDL:
            {
                maxFs = httpAtCxt->clientContext->socket;
                if(maxFs >= 0)
                {
                    //httpMutexAcquire();
                    FD_ZERO(&readFs);
                    FD_ZERO(&errorFs);
                    FD_SET(httpAtCxt->clientContext->socket, &readFs);
                    FD_SET(httpAtCxt->clientContext->socket, &errorFs);
                    ret = select(maxFs + 1, &readFs, NULL, &errorFs, &tv);
                    //httpMutexRelease();
                    if(ret>0)
                    {
                        if(FD_ISSET(httpAtCxt->clientContext->socket, &readFs))
                        {
                        
                            do
                            {
                                httpMutexAcquire();

                                if(httpAtCxt->status != HTTPSTAT_REQHANDL)//user interrupted the request
                                {
                                    DBG("httpMutexRelease");
                                    httpMutexRelease();
                                    break;
                                }

                                memset(httpAtCxt->clientData->headerBuf, 0, httpAtCxt->clientData->headerBufLen);
                                memset(httpAtCxt->clientData->respBuf, 0, httpAtCxt->clientData->respBufLen);
                                result = httpRecvResponse(httpAtCxt->clientContext, httpAtCxt->clientData);

                                if(result == HTTP_OK)
                                {
                                    if(httpAtCxt->isFota == FALSE){
                                        DBG("all data recevied, to close socket");
                                        httpMsg.cmd_type = HTTP_CLOSE_TCP_COMMAND;//request has recevied all response data, close socket
                                        status = osMessageQueuePut(http_msgqueue, &httpMsg, 0, 0);
                                        EC_ASSERT(status==osOK,status,0,0);
                                    }else{
                                        if(progresscb)
                                            ret = progresscb();
                                        else
                                            ret = httpFotaDownload();
                                        if(ret == 0){
                                            if(progresscb == NULL)
                                            {
                                                FotaDefChkDeltaState_t    chkDelta = {0};
                                                FotaDefChkBaseImage_t      chkBase = {0};
                                                fotaNvmDoExtension(FOTA_DEF_CHK_DELTA_STATE, (void*)&chkDelta);
                                                if(chkDelta.isValid){
                                                    fotaNvmDoExtension(FOTA_DEF_CHK_BASE_IMAGE, (void*)&chkBase);
                                                    if(chkBase.isMatched){
                                                        httpFotaUrcInd(HTTPFOTA_DOWNLOADEND, 0);
                                                        osDelay(2000);
                                                        appSetCFUN(0);
                                                        ResetStartPorReset(RESET_REASON_FOTA);
                                                    }
                                                }
                                                DBG("chkDelta.isValid=%d,chkBase.isMatched=%d", chkDelta.isValid,chkBase.isMatched);
                                            }
									
                                            #ifdef FEATURE_QCOMAT_ENABLE
                                            httpFotaUrcInd(HTTPFOTA_PACKAGE_MISMATCH, 0);
                                            #endif

                                            httpMsg.cmd_type = HTTP_CLOSE_TCP_COMMAND;//request has recevied all response data, close socket
                                            status = osMessageQueuePut(http_msgqueue, &httpMsg, 0, 0);
                                            EC_ASSERT(status==osOK,status,0,0);
                                        }else{
                                            DBG("fota get par failed stop connect");
                                            httpMsg.cmd_type = HTTP_CLOSE_TCP_COMMAND;//request has recevied all response data, close socket
                                            status = osMessageQueuePut(http_msgqueue, &httpMsg, 0, 0);
                                            EC_ASSERT(status==osOK,status,0,0);
                                        }
                                    }
                                }
                                else if(result == HTTP_MOREDATA)
                                {
                                    if(httpAtCxt->isFota == FALSE){
                                        
                                    }else{
                                        int ret = 0;
                                        if(progresscb)
                                            ret = progresscb();
                                        else
                                            ret = httpFotaDownload();
                                        if(ret < 0){
                                            DBG("fota get par failed stop connect");
                                            httpMsg.cmd_type = HTTP_CLOSE_TCP_COMMAND;//request has recevied all response data, close socket
                                            status = osMessageQueuePut(http_msgqueue, &httpMsg, 0, 0);
                                            EC_ASSERT(status==osOK,status,0,0);
                                        }
                                    }
                                }
                                else if(result == HTTP_CONN)
                                {
                                    DBG("httpRecvResponse return HTTP_CONN release mutex try recv data again");
                                }
                                else
                                {
                                    if(httpAtCxt->isFota == FALSE){
                                        if(result == HTTP_NO_MEMORY){
                                            httpRetInd(HTTPAT_MEMORY_NOT_ENOUGH);
                                        }else{
                                            httpRetInd(HTTPAT_SOCKET_ERROR);
                                        }
                                    }else{
                                        httpFotaUrcInd(HTTPFOTA_ERR, 0);
                                    }
                                    int mErr = sock_get_errno(httpAtCxt->clientContext->socket);
                                    DBG("httpRecvResponse return %d error=%d, close socket", result,mErr);
                                    httpMsg.cmd_type = HTTP_CLOSE_TCP_COMMAND;
                                    status = osMessageQueuePut(http_msgqueue, &httpMsg, 0, 0);
                                    EC_ASSERT(status==osOK,status,0,0);
                                }
                                //ECPLAT_PRINTF(UNILOG_HTTP, httpClientRecvTask_1_0_3, P_INFO, "httpMutexRelease");
                                httpMutexRelease();
                            }while(result == HTTP_MOREDATA);
                        }
                        else if(FD_ISSET(httpAtCxt->clientContext->socket, &errorFs))
                        {
                            int mErr = sock_get_errno(httpAtCxt->clientContext->socket);
                            if(socket_error_is_fatal(mErr))
                            {
                                if(httpAtCxt->isFota == FALSE){
                                    httpRetInd(HTTPAT_SOCKET_ERROR);
                                }else{
                                    httpFotaUrcInd(HTTPFOTA_ERR, 0);
                                }
                                DBG("selected fatal error socket:%d, errno:%d", httpAtCxt->clientContext->socket, mErr);
                                httpMsg.cmd_type = HTTP_CLOSE_TCP_COMMAND;

                                status = osMessageQueuePut(http_msgqueue, &httpMsg, 0, 0);
                                EC_ASSERT(status==osOK,status,0,0);
                            }
                            else
                            {
                                DBG("selected not fatal error socket:%d, errno:%d", httpAtCxt->clientContext->socket, mErr);
                            }
                        }
                    }
                    else
                    {
                        DBG("recv select return:%d, errno:%d", ret, errno);
                    }
                }
                else
                {
                    DBG("no valid socket exit recv task, errno:%d", errno);
                    isRecvTaskRunning = FALSE;
                }

                break;
            }

            case HTTPSTAT_CONNECT:
            {
                if(httpAtCxt->clientContext->socket == -1){
                    DBG("in HTTPSTAT_CONNECTED socket invalid exit recv task, errno:%d", errno);
                    isRecvTaskRunning = FALSE;
                }
                break;
            }

            case HTTPSTAT_CLOSE:
            default:
            {
                isRecvTaskRunning = FALSE;
                break;
            }
        }
        DBG(".httpStatus:%d", httpStatus);
        if(isRecvTaskRunning == FALSE)
        {
            break;
        }
    }

    DBG("http recv task no need running");

    flowMutexDelete();
    osThreadSetPriority(osThreadGetId(), osPriorityNormal); //should be higher than http send task
    ostaskENTER_CRITICAL();
    httprecv_task_handle = NULL;
    httpRecvTaskRunning = FALSE;
    ostaskEXIT_CRITICAL();

    vTaskDelete(NULL);
}


static bool httpRecvTaskInit(void)
{
    osThreadAttr_t task_attr;
    memset(&task_attr, 0, sizeof(task_attr));

    task_attr.name = "httpRecv";
    task_attr.stack_size = HTTPRECV_TASK_STACK_SIZE;
    task_attr.priority = osPriorityBelowNormal6;

    if(httprecv_task_handle == NULL)
    {
        httprecv_task_handle = osThreadNew(httpClientRecvTask, NULL,&task_attr);
        if(httprecv_task_handle == NULL)
        {
            EC_ASSERT(FALSE,0,0,0);
        }
    }
    //ECPLAT_PRINTF(UNILOG_HTTP, httpRecvTaskInit_1, P_INFO, 0, "httpRecvTaskInit success");
    return true;
}

static void httpSetContentType(httpAtContext_t* httpCxt)
{
    char* value = NULL;
    switch(gHttpcfg.contentType)
    {
    case 0:
        value = CONTENTTYPE0;
        break;
    case 1:
        value = CONTENTTYPE1;
        break;
    case 2:
        value = CONTENTTYPE2;
        break;
    case 3:
        value = CONTENTTYPE3;
        break;
    default:
        break;
    }
    httpCxt->clientData->postContentType = value;
}

void httpClrCustNewContext(uint16_t datalen)
{
    gCustheadbodyLen = datalen;
    curCustheadbodyLen = 0;
    if(gptCustheadbody != NULL)
    {
        DBG("has remaining gptCustheadbody clean it");
        free(gptCustheadbody);
        gptCustheadbody = NULL;
    }
    DBG("to malloc gptCustheadbody(%d)",datalen);
    gptCustheadbody = malloc(gCustheadbodyLen+1);
    configASSERT(gptCustheadbody != NULL);
    memset(gptCustheadbody, 0, gCustheadbodyLen+1);

    //if clientContext == NULL new it
    httpCreateClientContext(&gHttpAtCxt);
}

static int8_t httpFillPostContentByFile(const char* filename)
{
    OSAFILE fp = PNULL;
    int32_t readCount = 0;
    int32_t filesize = 0;

    /*
     * open the NVM file
    */
    fp = OsaFopen(filename, "rb");   //read only
    if (fp == PNULL)
    {
        DBG("fail to open such file:%s", (uint8_t*)filename);
        return -1;
    }

    DBG("file:%s", (uint8_t*)filename);

    filesize = OsaFsize(fp);
    if(filesize<=0)
    {
        DBG("filesize=%x", filesize);
        return -1;
    }
    else
    {
        DBG("filesize=%d", filesize);
    }

    httpClrCustNewContext(filesize);

    readCount = OsaFread(gptCustheadbody, filesize, 1, fp);
    if (readCount != 1)
    {
        DBG("read failed");
        OsaFclose(fp);
        return -1;
    }
    OsaFclose(fp);
    return 0;

}

static void httpMutexDelete(void)
{
    //ECPLAT_PRINTF(UNILOG_HTTP, httpMutexDelete_1, P_INFO, 0, "ok");
    if(httpMutex != NULL)
    {
        osMutexDelete(httpMutex);
        httpMutex = NULL;
    }
}

void httpSendReqWait(void)
{
    while(httpSendTaskRunning == TRUE)
        osDelay(20);
}

static void httpClientSendTask(void* arg)
{
    osStatus_t status;
    httpCmdMsg_t msg;
    httpCnfCmdMsg_t cnfMsg;
    HTTPResult result = HTTP_INTERNAL;
    httpAtContext_t* httpAtCxt = &gHttpAtCxt;
    int primSize = sizeof(cnfMsg);
    uint8_t waitloop = 10;
    int8_t readRet = 0;
    AtHttpError_e sslRet = (AtHttpError_e)0;

    httpMutexCreate();

    while(httpSendTaskRunning)
    {
        //ECPLAT_PRINTF(UNILOG_HTTP, httpClientSendTask_1, P_INFO, 0, "send task wait for signal");
        status = osMessageQueueGet(http_msgqueue, &msg, 0, osWaitForever);
        EC_ASSERT(status==osOK,status,0,0);

        switch(msg.cmd_type)
        {
            case HTTP_SEND_COMMAND:
            {
                DBG("recv send command");
                //ECPLAT_PRINTF(UNILOG_HTTP, sslMEM_1, P_INFO, "before load cert:%d", xBytesTaskMalloced);
                httpCreateClientData(httpAtCxt);
                cnfMsg.ret = HTTPAT_INTERNAL;

                result = httpParseURL(httpAtCxt->clientContext, httpAtCxt->url);
                if(result == HTTP_OK)
                {
                }
                else
                {
                    if(result == HTTP_INTERNAL){
                        cnfMsg.ret = HTTPAT_INTERNAL;
                    }else{
                        result = HTTPAT_INTERNAL;
                        cnfMsg.ret = HTTPAT_URL_PARSE_ERROR;
                    }
                    goto exit;
                }
                result = httpAtConnect(httpAtCxt);
                if(result == HTTP_OK)
                {
                    httpAtCxt->status = HTTPSTAT_CONNECT;
                    DBG("connect peer OK");
                    if(!httpAtCxt->readfile && !httpAtCxt->isFota){//imitate yy
                        httpConnectInd();
                    }
                    if(httpRecvTaskRunning == FALSE)
                    {
                        httpRecvTaskRunning = TRUE;
                        httpRecvTaskInit();
                    }
                    //ECPLAT_PRINTF(UNILOG_HTTP, sslMEM_10, P_INFO, "after create recv task:%d", xBytesTaskMalloced);
                    if(httpAtCxt->postfile)//+HTTPPOSTFILE
                    {
                        readRet = httpFillPostContentByFile(httpAtCxt->postfilename);
                        if(readRet == 0)
                        {
                            if(gHttpcfg.requestHead == 0)//POSTFILE not content head
                            {
                                httpSetContentType(httpAtCxt);
                                httpAtCxt->clientData->postBuf = (char*)gptCustheadbody;
                                httpAtCxt->clientData->postBufLen = gCustheadbodyLen;
                                result = httpSendRequest(httpAtCxt->clientContext, httpAtCxt->url,(HTTP_METH)httpAtCxt->method, httpAtCxt->clientData);
                            }
                            else//POSTFILE content head
                            {
                                result = httpSend(httpAtCxt->clientContext, (char*)gptCustheadbody, gCustheadbodyLen);
                            }
                        }
                        else
                        {
                            result = HTTPAT_INTERNAL;
                            cnfMsg.ret = HTTPAT_NO_SUCH_FILE;
                            goto exit;
                        }
                    }
                    else//+HTTPPOST or +HTTPGET
                    {
                        if(gHttpcfg.requestHead == 0)//not set custom head
                        {
                            if(httpAtCxt->method == 1)
                            {//+HTTPPOST request with body
                                if(gptCustheadbody != NULL && gCustheadbodyLen != 0){
                                    httpSetContentType(httpAtCxt);
                                    httpAtCxt->clientData->postBuf = (char*)gptCustheadbody;
                                    httpAtCxt->clientData->postBufLen = gCustheadbodyLen;
                                    result = httpSendRequest(httpAtCxt->clientContext, httpAtCxt->url,(HTTP_METH)httpAtCxt->method, httpAtCxt->clientData);
                                }else{
                                    result = HTTPAT_INTERNAL;
                                    cnfMsg.ret = HTTPAT_INTERNAL;
                                    goto exit;
                                }
                            }
                            else
                            {//GET request no body
                                if(httpAtCxt->isRange){
                                    httpAtCxt->clientData->isRange = true;
                                    httpAtCxt->clientData->rangeHead = httpAtCxt->startPos;
                                    httpAtCxt->clientData->rangeTail = httpAtCxt->endPos;
                                }
                                result = httpSendRequest(httpAtCxt->clientContext, httpAtCxt->url,(HTTP_METH)httpAtCxt->method, httpAtCxt->clientData);
                            }
                        }
                        else// set custom head
                        {//GET request with custom head or POST request with costom head
                            if(gptCustheadbody != NULL && gCustheadbodyLen != 0){
                                result = httpSend(httpAtCxt->clientContext, (char*)gptCustheadbody, gCustheadbodyLen);
                            }else{
                                result = HTTP_INTERNAL;
                                cnfMsg.ret = HTTPAT_INTERNAL;
                            }
                        }
                    }
                }
exit:
                if(result == HTTP_OK)
                {
                    httpAtCxt->status = HTTPSTAT_REQHANDL;
                    DBG("send HTTP request OK");
                    applSendCmsCnf(httpAtCxt->reqhandle, APPL_RET_SUCC, APPL_HTTP, APPL_HTTP_SEND_CNF, primSize, &cnfMsg);
                    httpAtCxt->hasRequest = false;
                    curContentLen = 0;
                }
                else
                {
                    DBG("send HTTP request failed,result=%d, disconnect peer",result);
                    switch(result)
                    {
                    case HTTP_DNS:
                        cnfMsg.ret = HTTPAT_DNS_FAILED;
                        break;
                    case HTTP_PRTCL:
                        cnfMsg.ret = HTTPAT_PRTCL_ERROR;
                        break;
                    case HTTP_SOCKET_FAIL:
                        cnfMsg.ret = HTTPAT_SOCKET_ERROR;
                        break;
                    case HTTP_BIND_FAIL:
                        cnfMsg.ret = HTTPAT_BIND_FAILED;
                        break;
                    case HTTP_TIMEOUT:
                        cnfMsg.ret = HTTPAT_CONNECT_TIMEOUT;
                        break;
                    case HTTP_CONN:
                        cnfMsg.ret = HTTPAT_CONNECT_ERROR;
                        break;
                    case HTTP_CLOSED:
                        cnfMsg.ret = HTTPAT_CONNECT_CLOSE;
                        break;
                    case HTTP_MBEDTLS_ERR:
                        cnfMsg.ret = HTTPAT_TLS_ERROR;
                        break;
                    case HTTP_OVERFLOW:
                        cnfMsg.ret = HTTPAT_INTERNAL;
                        break;
                    case HTTP_INTERNAL:
                    default:
                        break;
                    }

                    httpSendTaskRunning = FALSE;
                    httpAtCxt->hasRequest = false;
                    httpClose(httpAtCxt->clientContext);
                    httpDeleteClientData(httpAtCxt);
                    httpDeleteClientContext(httpAtCxt);
                    applSendCmsCnf(httpAtCxt->reqhandle, APPL_RET_FAIL, APPL_HTTP, APPL_HTTP_SEND_CNF, primSize, &cnfMsg);
                    httpSleepVote(HTTP_EN_SLEEP);
                    httpAtCxt->status = HTTPSTAT_CLOSE;
                }

                if(gptCustheadbody != NULL)
                {
                    free(gptCustheadbody);
                    gptCustheadbody = NULL;
                }
                break;
            }

            case HTTP_CLOSE_TCP_COMMAND:
            {
                httpMutexAcquire();
                //ECPLAT_PRINTF(UNILOG_HTTP, httpClientSendTask_3, P_INFO, "recv close command from internal httpMutexAcquire");

                if(httpAtCxt->status != HTTPSTAT_CLOSE)
                {
                    //peer addr close the socket
                    DBG("socketclose by peer addr or network reason");
                    httpSendTaskRunning = FALSE;
                    httpClose(httpAtCxt->clientContext);
                }
                //ECPLAT_PRINTF(UNILOG_HTTP, httpClientSendTask_3_2, P_INFO, "httpMutexRelease");
                httpDeleteClientContext(httpAtCxt);
                httpDeleteClientData(httpAtCxt);
                httpSleepVote(HTTP_EN_SLEEP);
                httpAtCxt->status = HTTPSTAT_CLOSE;
                httpMutexRelease();
                break;
            }

            case HTTP_STOP_COMMAND:
            {
               DBG("recv stop command httpMutexAcquire");
                httpMutexAcquire();
                result = httpClose(httpAtCxt->clientContext);
                DBG("http close 0x%x",result);
                httpMutexRelease();

                //wait for recv task really deleted
                if(httpRecvTaskRunning == TRUE)//no conenct recv task should delete itself
                {
                    while(waitloop)//max 10s
                    {
                        if(httpRecvTaskRunning == FALSE)//deteled,break
                        {
                            break;
                        }
                        vTaskDelay(1000);
                        waitloop--;
                    }
                    if(waitloop==0)
                    {
                        DBG(" wait recv task deleted tiemout");
                    }
                }
                DBG(" wait recv task deleted %d and send task exit",httpRecvTaskRunning);

                httpSendTaskRunning = FALSE;
                applSendCmsCnf(httpAtCxt->reqhandle, APPL_RET_SUCC, APPL_HTTP, APPL_HTTP_STOP_CNF, primSize, &cnfMsg);
                httpDeleteClientContext(httpAtCxt);
                httpDeleteClientData(httpAtCxt);
                httpSleepVote(HTTP_EN_SLEEP);
                httpAtCxt->status = HTTPSTAT_CLOSE;
                break;
            }

            default:
            {
                DBG(" recv error cmd");
                break;
            }
        }
    }

    if(http_msgqueue != NULL)
    {
        osMessageQueueDelete(http_msgqueue);//delete the memory for queue
        http_msgqueue = NULL;
    }
    httpMutexDelete();

    osThreadSetPriority(osThreadGetId(), osPriorityNormal2); //should be higher than cms task
    ostaskENTER_CRITICAL();
    httpsend_task_handle = NULL;
    ostaskEXIT_CRITICAL();
    vTaskDelete(NULL);

}


static bool httpSendTaskInit(void)
{
    osThreadAttr_t task_attr;

    // init message queue
    if(http_msgqueue == NULL)
    {
        http_msgqueue = osMessageQueueNew(16, sizeof(httpCmdMsg_t), NULL);
    }
    else
    {
        osMessageQueueReset(http_msgqueue);
    }
    if(http_msgqueue == NULL)
    {
        EC_ASSERT(FALSE,0,0,0);
    }

    memset(&task_attr, 0, sizeof(task_attr));
    task_attr.name = "httpSend";
    task_attr.stack_size = HTTPSEND_TASK_STACK_SIZE;
    task_attr.priority = osPriorityBelowNormal7;
    if(httpsend_task_handle == NULL)
    {
        httpsend_task_handle = osThreadNew(httpClientSendTask, NULL,&task_attr);
        if(httpsend_task_handle == NULL)
        {
            EC_ASSERT(FALSE,0,0,0);
        }
    }
    //ECPLAT_PRINTF(UNILOG_HTTP, httpSendTaskInit_1, P_INFO, 0, "httpSendTaskInit success");
    return true;
}


CmsRetId httpSendReq()
{
    httpCmdMsg_t httpMsg;
    CmsRetId rc = CMS_FAIL;
    osStatus_t status;

    if(!httpSendTaskRunning)
    {
        httpSendTaskRunning = TRUE;
        httpSendTaskInit();
    }

    memset(&httpMsg, 0, sizeof(httpMsg));
    httpMsg.cmd_type = HTTP_SEND_COMMAND;

    status = osMessageQueuePut(http_msgqueue, &httpMsg, 0, 0);
    EC_ASSERT(status==osOK,status,0,0);

    rc = CMS_RET_SUCC;

    return rc;
}

void httpSleepVote(HTTPSleep_e sleep)
{
    uint8_t counter = 0;
    slpManSlpState_t pstate;
    DBG("vote(%d)",sleep);

    if(httpSlpHandler == 0xff){
        httpInitSleepHandler();
    }

    if(sleep == HTTP_EN_SLEEP)
    {
        if(RET_TRUE == slpManCheckVoteState(httpSlpHandler, &pstate, &counter))
        {
            for(; counter > 0; counter -- )
            {
                slpManPlatVoteEnableSleep(httpSlpHandler, SLP_SLP2_STATE);
            }
        }
    }
    else
    {
        if(RET_TRUE == slpManCheckVoteState(httpSlpHandler, &pstate, &counter))
        {
            slpManPlatVoteDisableSleep(httpSlpHandler, SLP_SLP2_STATE);
        }
    }
}

int am_fota_firmware_download(int profile_idx, amFotaDwnldMod mode, char *address, char *username, char *password, amFotaProgressCB_t cb)
{
	DBG("download start");
	// 暂时不支持FTP下载
	if(AM_FOTA_DWNLD_MOD_FTP == mode)
		return -1;

	if(address == NULL)
		return -1;

	g_am_fota_firmware_download_cb = cb;

	httpClearAtContext(&gHttpAtCxt);
	gHttpAtCxt.reqhandle = HTTPFOTA_IND_HANDLER;
	gHttpAtCxt.isFota = TRUE;
	gHttpAtCxt.dlUrcRag = 100;
	gHttpAtCxt.method = 0;
	progresscb = am_http_down_cb;
	httpCreateClientContext(&gHttpAtCxt);

	if(gHttpAtCxt.url != NULL){
		free(gHttpAtCxt.url);
		gHttpAtCxt.url = NULL;
	}

	int urlLen = strlen(address);
	gHttpAtCxt.url = malloc(urlLen+1);
	configASSERT(gHttpAtCxt.url != NULL);
	memset(gHttpAtCxt.url, 0, urlLen);
	strcpy(gHttpAtCxt.url, (char*)address);
	httpSleepVote(HTTP_DIS_SLEEP);

	httpSendReq();//send fota download request
	httpSendReqWait();
	return 0;
}


void amFotaProgressCB(amFotaSta sta, int progress, char* buff, int len)
{
	DBG("sta:%d progress:%d", sta, progress);
	am_fota_image_write(test_am_fota_handle, buff, len);
	// am_fota_update(test_am_fota_handle, (uint8_t*)buff, (uint32_t)len);
}

int am_fota_image_verify(amFotaImgProcCtxPtr context)
{
    FotaDefChkDeltaState_t    chkDelta = {0};
    FotaDefChkBaseImage_t      chkBase = {0};
    do
    {
        fotaNvmDoExtension(FOTA_DEF_CHK_DELTA_STATE, (void*)&chkDelta);
        if(!chkDelta.isValid)
        {
            DBG("validate delta err! errno(%d)", chkDelta.state);
			return -1;
        }
        else
        {
            DBG("validate delta ok!");
            fotaNvmDoExtension(FOTA_DEF_CHK_BASE_IMAGE, (void*)&chkBase);
            if(!chkBase.isMatched)
            {
                DBG("however, base fw is unmatched!");
				return -1;
            }
        }
    }while(0);
	return 0;
}


void fota_test_task(void *argument)
{

    NmAtiNetifInfo netInfo = {0};
	while(1)
	{
		appGetNetInfoSync(0, &netInfo);
		DBG("appGetNetInfoSync wait net:%d",netInfo.netStatus);
		if(netInfo.netStatus == NM_NETIF_ACTIVATED)
		{
			break;
		}
		vTaskDelay(1000);
	}
	test_am_fota_handle = am_fota_init();
	if(test_am_fota_handle == NULL)
	{
		DBG("am_fota_init error");
		goto exit;
	}
	DBG("down start &p:0x%x p:0x%x *p:0x%x",&test_am_fota_handle,test_am_fota_handle,*(int *)test_am_fota_handle);
    DBG("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
	char *url = "http://airtest.openluat.com:2900/download/test_delta111.par";
	am_fota_firmware_download(0, AM_FOTA_DWNLD_MOD_HTTP, url, NULL, NULL, amFotaProgressCB);
	DBG("down end");
	DBG("verify start");
	int verify = am_fota_image_verify(test_am_fota_handle);
	if(verify != 0)
	{
		DBG("image_verify error");
		goto exit;
	}
	DBG("image_verify ok");
	vTaskDelay(1000);
	ResetStartPorReset(RESET_REASON_FOTA);
	exit:
   	vTaskDelete(NULL);
}


static void task_demoE_init(void)
{
	xTaskCreate(fota_test_task, "", 2048, NULL, 20, NULL);
}



//启动task_demoE_init，启动位置任务1级
INIT_TASK_EXPORT(task_demoE_init, "1");

