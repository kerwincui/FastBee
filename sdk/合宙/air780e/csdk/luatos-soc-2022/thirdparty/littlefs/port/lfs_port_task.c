#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "lfs_port.h"
#include "lfs_util.h"
#include "flash_rt.h"

#include "mem_map.h"
#include DEBUG_LOG_HEADER_FILE
#include "osasys.h"
#include "plat_config.h"

/***************************************************
 ***************       MACRO      ******************
 ***************************************************/

#define LFS_BLOCK_DEVICE_READ_SIZE      (256)
#define LFS_BLOCK_DEVICE_PROG_SIZE      (256)
#define LFS_BLOCK_DEVICE_CACHE_SIZE     (256)
#define LFS_BLOCK_DEVICE_ERASE_SIZE     (4096)       // one sector 4KB
#define LFS_BLOCK_DEVICE_TOTOAL_SIZE    (FLASH_FS_REGION_SIZE)
#define LFS_BLOCK_DEVICE_LOOK_AHEAD     (16)


#define LFS_TASK_STACK_SIZE             (2048)
#define LFS_REQUEST_COMPLETION_FLAG     (0x444F4E45)           // ASCII value of "DONE"

/***************************************************
 *******    FUNCTION FORWARD DECLARTION     ********
 ***************************************************/

// Read a block
static int block_device_read(const struct lfs_config *cfg, lfs_block_t block,
        lfs_off_t off, void *buffer, lfs_size_t size);

// Program a block
//
// The block must have previously been erased.
static int block_device_prog(const struct lfs_config *cfg, lfs_block_t block,
        lfs_off_t off, const void *buffer, lfs_size_t size);

// Erase a block
//
// A block must be erased before being programmed. The
// state of an erased block is undefined.
static int block_device_erase(const struct lfs_config *cfg, lfs_block_t block);

// Sync the block device
static int block_device_sync(const struct lfs_config *cfg);

// utility functions for traversals
static int lfs_statfs_count(void *p, lfs_block_t b);

// Send LFS operation request to LFS Daemon task and wait for completion
static int LFS_waitForCompletion(lfs_request_type_t type, void *handle, uint32_t data0, uint32_t data1);

//
static void LFS_reply(osThreadId_t threadId, int retCode);

static void LFS_daemonTaskEntry(void *arg);


/***************************************************
 ***************  GLOBAL VARIABLE  *****************
 ***************************************************/

// variables used by the filesystem
static lfs_t lfs;

static char lfs_read_buf[256];
static char lfs_prog_buf[256];
static __ALIGNED(4) char lfs_lookahead_buf[LFS_BLOCK_DEVICE_LOOK_AHEAD];

// configuration of the filesystem is provided by this struct
static struct lfs_config lfs_cfg =
{
    .context = NULL,
    // block device operations
    .read  = block_device_read,
    .prog  = block_device_prog,
    .erase = block_device_erase,
    .sync  = block_device_sync,

    // block device configuration
    .read_size = LFS_BLOCK_DEVICE_READ_SIZE,
    .prog_size = LFS_BLOCK_DEVICE_PROG_SIZE,
    .block_size = LFS_BLOCK_DEVICE_ERASE_SIZE,
    .block_count = LFS_BLOCK_DEVICE_TOTOAL_SIZE / LFS_BLOCK_DEVICE_ERASE_SIZE,
    .block_cycles = 200,
    .cache_size = LFS_BLOCK_DEVICE_CACHE_SIZE,
    .lookahead_size = LFS_BLOCK_DEVICE_LOOK_AHEAD,

    .read_buffer = lfs_read_buf,
    .prog_buffer = lfs_prog_buf,
    .lookahead_buffer = lfs_lookahead_buf,
    .name_max = 0,
    .file_max = 0,
    .attr_max = 0,
    .metadata_max = 0
};

static StaticTask_t             gLfsDaemonTask;
static uint8_t                  gLfsDaemonTaskStack[LFS_TASK_STACK_SIZE];

static StaticQueue_t            gLfsRequestQueueCb;
static uint8_t                  gLfsRequestQueueBuf[sizeof(lfs_request_t)];

static StaticQueue_t            gLfsReplyQueueCb;
static uint8_t                  gLfsReplyQueueBuf[sizeof(lfs_reply_t)];

// message queue id
static osMessageQueueId_t       gLfsRequestMsgQueue;
static osMessageQueueId_t       gLfsReplyMsgQueue;

// thread id
static osThreadId_t             gLfsDaemonTaskthreadId;

#ifdef FS_FILE_OPERATION_STATISTIC

enum file_id_to_monitor
{
    FILE_CCMCONFIG,
    FILE_CEMMCONFIGEMM,
    FILE_CEMMCONFIGUE,
    FILE_CEMMESM,
    FILE_CEMMPLMN,
    FILE_CERRC,
    FILE_CISCONFIG,
    FILE_COAPNVM,
    FILE_DCXOFTBUFF,
    FILE_MIDWARECONFIG,
    FILE_NPICONFIG,
    FILE_PLATCONFIG,
    FILE_SLPNVM,
    FILE_UICCCTRL,
    FILE_TO_MONITOR_TOTAL_NUMBER
};

typedef struct file_to_monitor
{
    uint8_t fileId;
    const char* fileName;
} file_to_monitor_t;

const static file_to_monitor_t fileToMonitor[FILE_TO_MONITOR_TOTAL_NUMBER] =
{
    {FILE_CCMCONFIG,      "ccmconfig.nvm"},
    {FILE_CEMMCONFIGEMM,  "cemmconfigemminformation.nvm"},
    {FILE_CEMMCONFIGUE,   "cemmconfigueinformation.nvm"},
    {FILE_CEMMESM,        "cemmesmconfig.nvm"},
    {FILE_CEMMPLMN,       "cemmplmnconfig.nvm"},
    {FILE_CERRC,          "cerrcconfig.nvm"},
    {FILE_CISCONFIG,      "cisconfig.nvm"},
    {FILE_COAPNVM,        "coap_nvm"},
    {FILE_DCXOFTBUFF,     "dcxoFTBuff.nvm"},
    {FILE_MIDWARECONFIG,  "midwareconfig.nvm"},
    {FILE_NPICONFIG,      "npiconfig.nvm"},
    {FILE_PLATCONFIG,     "plat_config"},
    {FILE_SLPNVM,         "slp_nvm"},
    {FILE_UICCCTRL,       "uiccctrlconfig.nvm"},
};

#define STATISTIC_RESULT_FILE_NAME  "fileOpStatistic"

static uint32_t g_fileWriteBytesCount[FILE_TO_MONITOR_TOTAL_NUMBER] = {0};
static uint32_t g_fileWriteCount[FILE_TO_MONITOR_TOTAL_NUMBER] = {0};
static uint32_t g_blockEraseCount[LFS_BLOCK_DEVICE_TOTOAL_SIZE / LFS_BLOCK_DEVICE_ERASE_SIZE] = {0};

#define STATITIC_RESULT_FILE_BODY_SIZE    (sizeof(g_fileWriteBytesCount) + sizeof(g_fileWriteCount) + sizeof(g_blockEraseCount))
#define STATISTIC_RESULT_MAGIC_NUMBR  0x5AA5


typedef struct statistic_result_file_header
{
    uint16_t fileBodySize;
    uint16_t magicNumber;
} statistic_result_file_header_t;

static bool g_statisticResultLoaded = false;
static bool g_statisticResultChanged = false;

#endif

/***************************************************
 *******         INTERANL FUNCTION          ********
 ***************************************************/

static int block_device_read(const struct lfs_config *cfg, lfs_block_t block,
        lfs_off_t off, void *buffer, lfs_size_t size)
{
    // Check if read is valid
    LFS_ASSERT(off  % cfg->read_size == 0);
    LFS_ASSERT(size % cfg->read_size == 0);
    LFS_ASSERT(block < cfg->block_count);

    uint8_t retValue;

#ifdef LFS_DEBUG_TRACE
    //ECPLAT_PRINTF(UNILOG_LFS, block_device_read, P_DEBUG, "LFS block read, block: 0x%x, off: 0x%x, size: 0x%x", block, off, size);
#endif

    retValue = BSP_QSPI_Read_Safe((uint8_t *)buffer, (FLASH_FS_REGION_START + block * cfg->block_size + off), size);

    LFS_ASSERT(retValue == QSPI_OK);

    return (retValue == QSPI_OK) ? LFS_ERR_OK: LFS_ERR_IO;
}

static int block_device_prog(const struct lfs_config *cfg, lfs_block_t block,
        lfs_off_t off, const void *buffer, lfs_size_t size)
{
    // Check if write is valid
    LFS_ASSERT(off  % cfg->prog_size == 0);
    LFS_ASSERT(size % cfg->prog_size == 0);
    LFS_ASSERT(block < cfg->block_count);

    uint8_t retValue;

#ifdef LFS_DEBUG_TRACE
    //ECPLAT_PRINTF(UNILOG_LFS, block_device_prog, P_DEBUG, "LFS prog, block: 0x%x, off: 0x%x, size: 0x%x", block, off, size);
#endif

    // Program data
    retValue = BSP_QSPI_Write_Safe((uint8_t *)buffer, (FLASH_FS_REGION_START + block * cfg->block_size + off), size);

    LFS_ASSERT(retValue == QSPI_OK);

    return (retValue == QSPI_OK) ? LFS_ERR_OK: LFS_ERR_IO;
}

static int block_device_erase(const struct lfs_config *cfg, lfs_block_t block)
{
    // Check if erase is valid
    LFS_ASSERT(block < cfg->block_count);

#ifdef FS_FILE_OPERATION_STATISTIC
    g_blockEraseCount[block]++;
    g_statisticResultChanged = true;
#endif

    uint8_t retValue;

#ifdef LFS_DEBUG_TRACE
    //ECPLAT_PRINTF(UNILOG_LFS, block_device_erase, P_DEBUG, "LFS erase block 0x%x", block);
#endif

    // Erase the block
    retValue = BSP_QSPI_Erase_Safe(FLASH_FS_REGION_START + block * cfg->block_size, LFS_BLOCK_DEVICE_ERASE_SIZE);

    LFS_ASSERT(retValue == QSPI_OK);

    return (retValue == QSPI_OK) ? LFS_ERR_OK: LFS_ERR_IO;
}

static int block_device_sync(const struct lfs_config *cfg)
{
    return 0;
}

static int lfs_statfs_count(void *p, lfs_block_t b)
{
    *(lfs_size_t *)p += 1;

    return 0;
}

/***************************************************
 *******      FUNCTION IMPLEMENTATION       ********
 ***************************************************/
#ifdef FS_FILE_OPERATION_STATISTIC

void LFS_loadMonitorResult(void)
{
    int32_t err;

    lfs_file_t file;

    statistic_result_file_header_t fileHeader;

    if(g_statisticResultLoaded)
    {
        return;
    }

    err = lfs_file_open(&lfs, &file, STATISTIC_RESULT_FILE_NAME, LFS_O_RDWR);

    // file doesn't exist, create a new one and then write into default value
    if(err == LFS_ERR_NOENT)
    {
        err = lfs_file_open(&lfs, &file, STATISTIC_RESULT_FILE_NAME, LFS_O_CREAT | LFS_O_WRONLY);
        EC_ASSERT(err == 0, err, 0, 0);

        // fill file header
        fileHeader.fileBodySize = STATITIC_RESULT_FILE_BODY_SIZE;
        fileHeader.magicNumber = STATISTIC_RESULT_MAGIC_NUMBR;

        //write file header and check result
        err = lfs_file_write(&lfs, &file, &fileHeader, sizeof(statistic_result_file_header_t));
        EC_ASSERT(err == sizeof(statistic_result_file_header_t), 0, 0, 0);

        //write default value and check return value
        memset(g_fileWriteBytesCount, 0, sizeof(g_fileWriteBytesCount));
        err = lfs_file_write(&lfs, &file, g_fileWriteBytesCount, sizeof(g_fileWriteBytesCount));
        EC_ASSERT(err == sizeof(g_fileWriteBytesCount), err, sizeof(g_fileWriteBytesCount), 0);

        memset(g_fileWriteCount, 0, sizeof(g_fileWriteCount));
        err = lfs_file_write(&lfs, &file, g_fileWriteCount, sizeof(g_fileWriteCount));
        EC_ASSERT(err == sizeof(g_fileWriteCount), err, sizeof(g_fileWriteCount), 0);

        memset(g_blockEraseCount, 0, sizeof(g_blockEraseCount));
        err = lfs_file_write(&lfs, &file, g_blockEraseCount, sizeof(g_blockEraseCount));
        EC_ASSERT(err == sizeof(g_blockEraseCount), err, sizeof(g_blockEraseCount), 0);

        err = lfs_file_close(&lfs, &file);

        EC_ASSERT(err == 0, 0, 0, 0);
    }
    // file already exists
    else if(err == LFS_ERR_OK)
    {
        // fetch file header and perform validation check
        err = lfs_file_read(&lfs, &file, &fileHeader, sizeof(statistic_result_file_header_t));
        EC_ASSERT(err == sizeof(statistic_result_file_header_t), err, sizeof(statistic_result_file_header_t), 0);

        // file size and magicNumber check, if doest't match, write into default value
        if((fileHeader.fileBodySize != STATITIC_RESULT_FILE_BODY_SIZE) || (fileHeader.magicNumber != STATISTIC_RESULT_MAGIC_NUMBR))
        {
            // change position of the file to the beginning of the file
            err = lfs_file_rewind(&lfs, &file);
            EC_ASSERT(err == 0, 0, 0, 0);

            // fill file header
            fileHeader.fileBodySize = STATITIC_RESULT_FILE_BODY_SIZE;
            fileHeader.magicNumber = STATISTIC_RESULT_MAGIC_NUMBR;

            // write file header and check result
            err = lfs_file_write(&lfs, &file, &fileHeader, sizeof(statistic_result_file_header_t));
            EC_ASSERT(err == sizeof(statistic_result_file_header_t), err, sizeof(statistic_result_file_header_t), 0);

            // write default value and check return value
            memset(g_fileWriteBytesCount, 0, sizeof(g_fileWriteBytesCount));
            err = lfs_file_write(&lfs, &file, g_fileWriteBytesCount, sizeof(g_fileWriteBytesCount));
            EC_ASSERT(err == sizeof(g_fileWriteBytesCount), err, sizeof(g_fileWriteBytesCount), 0);

            memset(g_fileWriteCount, 0, sizeof(g_fileWriteCount));
            err = lfs_file_write(&lfs, &file, g_fileWriteCount, sizeof(g_fileWriteCount));
            EC_ASSERT(err == sizeof(g_fileWriteCount), err, sizeof(g_fileWriteCount), 0);

            memset(g_blockEraseCount, 0, sizeof(g_blockEraseCount));
            err = lfs_file_write(&lfs, &file, g_blockEraseCount, sizeof(g_blockEraseCount));
            EC_ASSERT(err == sizeof(g_blockEraseCount), err, sizeof(g_blockEraseCount), 0);
        }
        else
        {
            err = lfs_file_read(&lfs, &file, g_fileWriteBytesCount, sizeof(g_fileWriteBytesCount));
            EC_ASSERT(err == sizeof(g_fileWriteBytesCount), err, sizeof(g_fileWriteBytesCount), 0);

            err = lfs_file_read(&lfs, &file, g_fileWriteCount, sizeof(g_fileWriteCount));
            EC_ASSERT(err == sizeof(g_fileWriteCount), err, sizeof(g_fileWriteCount), 0);

            err = lfs_file_read(&lfs, &file, g_blockEraseCount, sizeof(g_blockEraseCount));
            EC_ASSERT(err == sizeof(g_blockEraseCount), err, sizeof(g_blockEraseCount), 0);
        }

        err = lfs_file_close(&lfs, &file);
        EC_ASSERT(err == 0, 0, 0, 0);

    }
    // handle left errors
    else
    {
        EC_ASSERT(err == LFS_ERR_OK, 0, 0, 0);
    }

    g_statisticResultLoaded = TRUE;

    return;
}

int LFS_getFileWriteMonitorResult(file_operation_statistic_result_t* result)
{
    EC_ASSERT(result, result, 0, 0);

    LFS_loadMonitorResult();

    static uint8_t pos = 0;

    if(pos < FILE_TO_MONITOR_TOTAL_NUMBER)
    {
        result->name = fileToMonitor[pos].fileName;
        result->writeCount = g_fileWriteCount[fileToMonitor[pos].fileId];
        result->writeBytesCount = g_fileWriteBytesCount[fileToMonitor[pos].fileId];
        pos++;
        return 1;
    }
    else
    {
        pos = 0;
        return 0;
    }
}

int LFS_getBlockEraseCountResult(uint32_t* result)
{
    EC_ASSERT(result, result, 0, 0);

    LFS_loadMonitorResult();

    static uint8_t index = 0;

    if(index < (LFS_BLOCK_DEVICE_TOTOAL_SIZE / LFS_BLOCK_DEVICE_ERASE_SIZE))
    {
        *result = g_blockEraseCount[index++];
        return 1;
    }
    else
    {
        index = 0;
        return 0;
    }
}

static void LFS_handleSaveMonitorResultRequest(void)
{
    int err;

    lfs_file_t statisticFile;
    statistic_result_file_header_t fileHeader;

    if(g_statisticResultChanged)
    {
        err = lfs_file_open(&lfs, &statisticFile, STATISTIC_RESULT_FILE_NAME, LFS_O_WRONLY);
        EC_ASSERT(err == 0, 0, 0, 0);

        // fill file header
        fileHeader.fileBodySize = STATITIC_RESULT_FILE_BODY_SIZE;
        fileHeader.magicNumber = STATISTIC_RESULT_MAGIC_NUMBR;

        // write file header and check result
        err = lfs_file_write(&lfs, &statisticFile, &fileHeader, sizeof(statistic_result_file_header_t));
        EC_ASSERT(err == sizeof(statistic_result_file_header_t), err, sizeof(statistic_result_file_header_t), 0);

        // write filebody and check return value
        err = lfs_file_write(&lfs, &statisticFile, g_fileWriteBytesCount, sizeof(g_fileWriteBytesCount));
        EC_ASSERT(err == sizeof(g_fileWriteBytesCount), err, sizeof(g_fileWriteBytesCount), 0);

        err = lfs_file_write(&lfs, &statisticFile, g_fileWriteCount, sizeof(g_fileWriteCount));
        EC_ASSERT(err == sizeof(g_fileWriteCount), err, sizeof(g_fileWriteCount), 0);

        err = lfs_file_write(&lfs, &statisticFile, g_blockEraseCount, sizeof(g_blockEraseCount));
        EC_ASSERT(err == sizeof(g_blockEraseCount), err, sizeof(g_blockEraseCount), 0);

        err = lfs_file_close(&lfs, &statisticFile);
        EC_ASSERT(err == 0, 0, 0, 0);
    }

}

void LFS_saveMonitorResult(void)
{
    LFS_waitForCompletion(LFS_REQUEST_SAVE_MONITOR_RESULT, NULL, 0, 0);
}

void LFS_resetMonitorResult(void)
{
    memset(g_fileWriteBytesCount, 0, sizeof(g_fileWriteBytesCount));
    memset(g_fileWriteCount, 0, sizeof(g_fileWriteCount));
    memset(g_blockEraseCount, 0, sizeof(g_blockEraseCount));

    g_statisticResultChanged = true;

    LFS_waitForCompletion(LFS_REQUEST_SAVE_MONITOR_RESULT, NULL, 0, 0);
}


#else

int LFS_getFileWriteMonitorResult(file_operation_statistic_result_t* result)
{
    return 0;
}

int LFS_getBlockEraseCountResult(uint32_t* result)
{
    return 0;
}

void LFS_saveMonitorResult(void)
{
}

void LFS_resetMonitorResult(void)
{
}

#endif

static void LFS_createDaemonTaskAndQueue(void)
{
    osThreadAttr_t taskAttr;
    osMessageQueueAttr_t queueAttr;

    memset(&queueAttr, 0, sizeof(queueAttr));

    queueAttr.mq_size = sizeof(gLfsRequestQueueBuf);
    queueAttr.mq_mem = gLfsRequestQueueBuf;
    queueAttr.cb_mem = &gLfsRequestQueueCb;
    queueAttr.cb_size = sizeof(gLfsRequestQueueCb);

    // init message queue
    gLfsRequestMsgQueue = osMessageQueueNew(1, sizeof(lfs_request_t), &queueAttr);

    EC_ASSERT(gLfsRequestMsgQueue, gLfsRequestMsgQueue, 0, 0);

    queueAttr.mq_size = sizeof(gLfsReplyQueueBuf);
    queueAttr.mq_mem = gLfsReplyQueueBuf;
    queueAttr.cb_mem = &gLfsReplyQueueCb;
    queueAttr.cb_size = sizeof(gLfsReplyQueueCb);

    // init message queue
    gLfsReplyMsgQueue = osMessageQueueNew(1, sizeof(lfs_reply_t), &queueAttr);

    EC_ASSERT(gLfsReplyMsgQueue, gLfsReplyMsgQueue, 0, 0);


    memset(&taskAttr,0,sizeof(taskAttr));
    memset(gLfsDaemonTaskStack, 0xA5, LFS_TASK_STACK_SIZE);
    taskAttr.name = "lfs";
    taskAttr.stack_mem = gLfsDaemonTaskStack;
    taskAttr.stack_size = LFS_TASK_STACK_SIZE;
    taskAttr.priority = osPriorityRealtime6;   // lower priority after system initialization phase
    taskAttr.cb_mem = &gLfsDaemonTask;         // task control block
    taskAttr.cb_size = sizeof(StaticTask_t);   // size of task control block

    gLfsDaemonTaskthreadId = osThreadNew(LFS_daemonTaskEntry, NULL, &taskAttr);

    EC_ASSERT(gLfsDaemonTaskthreadId, gLfsDaemonTaskthreadId, 0, 0);

}

static void LFS_reply(osThreadId_t threadId, int retCode)
{
    lfs_reply_t reply;
    osStatus_t status;

    reply.retCode = retCode;

    ECPLAT_PRINTF(UNILOG_LFS, LFS_Reply_0, P_INFO, "LFS reply, ret:%d, threadId:%x", reply.retCode, threadId);

    status = osMessageQueuePut(gLfsReplyMsgQueue, &reply, 0, osWaitForever);

    EC_ASSERT(status == osOK, status, 0, 0);

    osThreadFlagsSet(threadId, LFS_REQUEST_COMPLETION_FLAG);
}

static int LFS_waitForCompletion(lfs_request_type_t type, void *handle, uint32_t data0, uint32_t data1)
{
    lfs_request_t request;
    lfs_reply_t   reply;
    osStatus_t    status;
    uint32_t      flags = 0;

    request.type = type;
    request.threadId = osThreadGetId();
    request.handle.opaqueHandle = handle;
    request.data[0] = data0;
    request.data[1] = data1;

    status = osMessageQueuePut(gLfsRequestMsgQueue, &request, 0, osWaitForever);

    EC_ASSERT(status == osOK, status, 0, 0);

    // wait for completion and fetch return code
    flags = osThreadFlagsWait(LFS_REQUEST_COMPLETION_FLAG, osFlagsWaitAll, osWaitForever);

    EC_ASSERT((flags & LFS_REQUEST_COMPLETION_FLAG) == LFS_REQUEST_COMPLETION_FLAG, flags, LFS_REQUEST_COMPLETION_FLAG, 0);

    status = osMessageQueueGet(gLfsReplyMsgQueue, &reply, 0, 0);

    if(status == osOK)
    {
        return reply.retCode;
    }
    else
    {
        EC_ASSERT(0, 0, 0, 0);
    }

}

static void LFS_daemonTaskEntry(void *arg)
{

    while(1)
    {
        lfs_request_t request;
        osStatus_t status;

        lfs_status_t *lfsStatus = NULL;

        int ret;

        // wait for message
        status = osMessageQueueGet(gLfsRequestMsgQueue, &request, 0, osWaitForever);

        ECPLAT_PRINTF(UNILOG_LFS, LFS_daemonTaskEntry, P_INFO, "LFS Daemon task recv a request, type:%d, threadId:%x", request.type, request.threadId);

        if(status == osOK)
        {
            switch(request.type)
            {
                // general oprations
                case LFS_REQUEST_REMOVE:

                    ret = lfs_remove(&lfs, (char *)request.data[0]);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_FORMAT:

                    ret = lfs_format(&lfs, &lfs_cfg);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_RENAME:

                    ret = lfs_rename(&lfs, (char *)request.data[0], (char *)request.data[1]);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_STAT:

                    ret = lfs_stat(&lfs, (char *)request.data[0], (struct lfs_info *)request.data[1]);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_STATFS:

                    lfsStatus =  (lfs_status_t *)request.data[0];
                    lfsStatus->total_block = lfs_cfg.block_count;
                    lfsStatus->block_size = lfs_cfg.block_size;

                    ret = lfs_fs_traverse(&lfs, lfs_statfs_count, &(lfsStatus->block_used));
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_SAVE_MONITOR_RESULT:

#ifdef FS_FILE_OPERATION_STATISTIC

                    LFS_handleSaveMonitorResultRequest();
                    LFS_reply(request.threadId, 0);
#endif
                    break;

                // file operations
                case LFS_REQUEST_FILE_OPEN:

                    ret = lfs_file_open(&lfs, request.handle.fileHandle, (char *)request.data[0], request.data[1]);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_FILE_CLOSE:

                    ret = lfs_file_close(&lfs, request.handle.fileHandle);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_FILE_READ:

                    ret = lfs_file_read(&lfs, request.handle.fileHandle, (void *)request.data[0], request.data[1]);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_FILE_WRITE:

#ifdef FS_FILE_OPERATION_STATISTIC
                    LFS_loadMonitorResult();

                    g_statisticResultChanged = true;

                    for(int i = 0; i < FILE_TO_MONITOR_TOTAL_NUMBER; i++)
                    {
                        if(request.handle.fileHandle->name && (strcmp(request.handle.fileHandle->name, fileToMonitor[i].fileName) == 0))
                        {
                            g_fileWriteBytesCount[fileToMonitor[i].fileId] += request.data[1];
                            g_fileWriteCount[fileToMonitor[i].fileId] += 1;
                        }
                    }

#endif

                    ret = lfs_file_write(&lfs, request.handle.fileHandle, (void *)request.data[0], request.data[1]);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_FILE_SEEK:

                    ret = lfs_file_seek(&lfs, request.handle.fileHandle, request.data[0], request.data[1]);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_FILE_SYNC:

                    ret = lfs_file_sync(&lfs, request.handle.fileHandle);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_FILE_TRUNCATE:

                    ret = lfs_file_truncate(&lfs, request.handle.fileHandle, request.data[0]);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_FILE_TELL:

                    ret = lfs_file_tell(&lfs, request.handle.fileHandle);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_FILE_REWIND:

                    ret = lfs_file_rewind(&lfs, request.handle.fileHandle);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_FILE_SIZE:

                    ret = lfs_file_size(&lfs, request.handle.fileHandle);
                    LFS_reply(request.threadId, ret);

                    break;


                // dir operations
                case LFS_REQUEST_DIR_OPEN:

                    ret = lfs_dir_open(&lfs, request.handle.dirHandle, (char *)request.data[0]);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_DIR_CLOSE:

                    ret = lfs_dir_close(&lfs, request.handle.dirHandle);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_DIR_READ:

                    ret = lfs_dir_read(&lfs, request.handle.dirHandle, (struct lfs_info *)request.data[0]);
                    LFS_reply(request.threadId, ret);

                    break;

                case LFS_REQUEST_BLOCK_CALLBACK:
                    EC_ASSERT(request.handle.callbackFunc != PNULL, request.data[0], request.data[1], 0);
                    ret = (request.handle.callbackFunc)((void *)(request.data[0]));
                    LFS_reply(request.threadId, ret);
                    break;
#ifdef __USER_CODE__
                case LFS_REQUEST_DIR_CREATE:
                    ret = lfs_mkdir(&lfs, (const char *)request.data[0]);
                    LFS_reply(request.threadId, ret);

                    break;
#endif
                default :
                    ECPLAT_PRINTF(UNILOG_EXCEP_PRINT, LFS_DaemonTaskEntry_e_1, P_ERROR,
                                  "LFS deamon, can't proc reqType: %d", request.type);
                    break;
            }
        }
    }
}


void LFS_adjustDaemonTaskPriority(void)
{
    osThreadSetPriority(gLfsDaemonTaskthreadId, osPriorityNormal7);
}

int lfs_ready;
// Initialize
int LFS_init(void)
{
    uint32_t fs_assert_count = BSP_GetFSAssertCount();

    if(fs_assert_count && ((fs_assert_count % EC_FS_ASSERT_REFORMAT_THRESHOLD) == 0))
    {
        ECPLAT_PRINTF(UNILOG_EXCEP_PRINT, LFS_Init_0, P_ERROR, "FS region reformat threshold: %d, Current FS assert count:%d", EC_FS_ASSERT_REFORMAT_THRESHOLD, fs_assert_count);

        if(BSP_QSPI_Erase_Safe(FLASH_FS_REGION_START, FLASH_FS_REGION_SIZE) != 0)
        {
            ECPLAT_PRINTF(UNILOG_EXCEP_PRINT, LFS_Init_1, P_ERROR, "FS region reformat failed!!!");
        }

        BSP_SetFSAssertCount(0);
    }

    // mount the filesystem
    int err = lfs_mount(&lfs, &lfs_cfg);

    // reformat if we can't mount the filesystem
    // this should only happen on the first boot
    if (err)
    {
        err = lfs_format(&lfs, &lfs_cfg);
        if(err)
            return err;

        err = lfs_mount(&lfs, &lfs_cfg);
        if(err)
            return err;
    }

    LFS_createDaemonTaskAndQueue();
    lfs_ready = 1;
    return 0;
}

// Deinit
void LFS_deinit(void)
{
    // release any resources we were using
    lfs_unmount(&lfs);
}

int LFS_format(void)
{
    int ret;

    ret = LFS_waitForCompletion(LFS_REQUEST_FORMAT, NULL, 0, 0);

    return ret;
}

int LFS_stat(const char *path, struct lfs_info *info)
{
    int ret;

    ret = LFS_waitForCompletion(LFS_REQUEST_STAT, NULL, (uint32_t)path, (uint32_t)info);

    return ret;
}

int LFS_remove(const char *path)
{
    int ret;

#ifdef LFS_DEBUG_TRACE
    ECPLAT_PRINTF(UNILOG_LFS, fs_remove, P_DEBUG, "LFS remove, path: %s", (uint8_t *)path);
#endif

    ret = LFS_waitForCompletion(LFS_REQUEST_REMOVE, NULL, (uint32_t)path, 0);

    return ret;
}

int LFS_rename(const char *oldpath, const char *newpath)
{
    int ret;

#ifdef LFS_DEBUG_TRACE
    ECPLAT_PRINTF(UNILOG_LFS, fs_rename, P_DEBUG, "LFS rename, old path: %s, new path: %s", (uint8_t *)oldpath, (uint8_t *)newpath);
#endif

    ret = LFS_waitForCompletion(LFS_REQUEST_RENAME, NULL, (uint32_t)oldpath, (uint32_t)newpath);

    return ret;
}


int LFS_fileOpen(lfs_file_t *file, const char *path, int flags)
{
    int ret;

#ifdef LFS_DEBUG_TRACE
    ECPLAT_PRINTF(UNILOG_LFS, fs_file_open, P_DEBUG, "LFS file open, path: %s", (uint8_t *)path);
#endif

    ret = LFS_waitForCompletion(LFS_REQUEST_FILE_OPEN, file, (uint32_t)path, flags);

    return ret;

}

int LFS_fileClose(lfs_file_t *file)
{
    int ret;

#ifdef LFS_DEBUG_TRACE
    ECPLAT_PRINTF(UNILOG_LFS, fs_file_close, P_DEBUG, "LFS file close, file name: %s", (file->name) ? (uint8_t *)file->name : (uint8_t *)"unknown name");
#endif

    ret = LFS_waitForCompletion(LFS_REQUEST_FILE_CLOSE, file, 0, 0);

    return ret;
}

lfs_ssize_t LFS_fileRead(lfs_file_t *file, void *buffer, lfs_size_t size)
{
    int ret;

#ifdef LFS_DEBUG_TRACE
    ECPLAT_PRINTF(UNILOG_LFS, fs_file_read, P_DEBUG, "LFS file read, file name: %s", (file->name) ? (uint8_t *)file->name : (uint8_t *)"unknown name");
#endif

    ret = LFS_waitForCompletion(LFS_REQUEST_FILE_READ, file, (uint32_t)buffer, size);

    return ret;
}

lfs_ssize_t LFS_fileWrite(lfs_file_t *file, const void *buffer, lfs_size_t size)
{
    int ret;

#ifdef LFS_DEBUG_TRACE
    ECPLAT_PRINTF(UNILOG_LFS, fs_file_write, P_DEBUG, "LFS file write, file name: %s", (file->name) ? (uint8_t *)file->name : (uint8_t *)"unknown name");
#endif

    ret = LFS_waitForCompletion(LFS_REQUEST_FILE_WRITE, file, (uint32_t)buffer, size);

    return ret;
}

lfs_soff_t LFS_fileSeek(lfs_file_t *file, lfs_soff_t off, int whence)
{
    int ret;

#ifdef LFS_DEBUG_TRACE
    ECPLAT_PRINTF(UNILOG_LFS, fs_file_seek, P_DEBUG, "LFS file seek, file name: %s", (file->name) ? (uint8_t *)file->name : (uint8_t *)"unknown name");
#endif

    ret = LFS_waitForCompletion(LFS_REQUEST_FILE_SEEK, file, off, whence);

    return ret;
}

int LFS_fileSync(lfs_file_t *file)
{
    int ret;

#ifdef LFS_DEBUG_TRACE
    ECPLAT_PRINTF(UNILOG_LFS, fs_file_sync, P_DEBUG, "LFS file sync, file name: %s", (file->name) ? (uint8_t *)file->name : (uint8_t *)"unknown name");
#endif

    ret = LFS_waitForCompletion(LFS_REQUEST_FILE_SYNC, file, 0, 0);

    return ret;
}

int LFS_fileTruncate(lfs_file_t *file, lfs_off_t size)
{
    int ret;

#ifdef LFS_DEBUG_TRACE
    ECPLAT_PRINTF(UNILOG_LFS, fs_file_truncate, P_DEBUG, "LFS file truncate, file name: %s", (file->name) ? (uint8_t *)file->name : (uint8_t *)"unknown name");
#endif

    ret = LFS_waitForCompletion(LFS_REQUEST_FILE_TRUNCATE, file, size, 0);

    return ret;
}

lfs_soff_t LFS_fileTell(lfs_file_t *file)
{
    int ret;

    ret = LFS_waitForCompletion(LFS_REQUEST_FILE_TELL, file, 0, 0);

    return ret;
}

int LFS_fileRewind(lfs_file_t *file)
{
    int ret;

#ifdef LFS_DEBUG_TRACE
    ECPLAT_PRINTF(UNILOG_LFS, fs_file_rewind, P_DEBUG, "LFS file rewind, file name: %s", (file->name) ? (uint8_t *)file->name : (uint8_t *)"unknown name");
#endif

    ret = LFS_waitForCompletion(LFS_REQUEST_FILE_REWIND, file, 0, 0);

    return ret;
}

lfs_soff_t LFS_fileSize(lfs_file_t *file)
{
    int ret;

    ret = LFS_waitForCompletion(LFS_REQUEST_FILE_SIZE, file, 0, 0);

    return ret;
}

int LFS_dirOpen(lfs_dir_t *dir, const char *path)
{
    int ret;

    ret = LFS_waitForCompletion(LFS_REQUEST_DIR_OPEN, dir, (uint32_t)path, 0);

    return ret;
}

int LFS_dirClose(lfs_dir_t *dir)
{
    int ret;

    ret = LFS_waitForCompletion(LFS_REQUEST_DIR_CLOSE, dir, 0, 0);

    return ret;
}

int LFS_dirRead(lfs_dir_t *dir, struct lfs_info *info)
{
    int ret;

    ret = LFS_waitForCompletion(LFS_REQUEST_DIR_READ, dir, (uint32_t)info, 0);

    return ret;
}

int LFS_statfs(lfs_status_t *status)
{
    int ret;

    ret = LFS_waitForCompletion(LFS_REQUEST_STATFS, NULL, (uint32_t)status, 0);

    return ret;
}

int LFS_blockCallback(lfs_callback_func callback, void *arg)
{
    int ret;

    EC_ASSERT(callback != PNULL, callback, arg, 0);

    ret = LFS_waitForCompletion(LFS_REQUEST_BLOCK_CALLBACK, (void *)callback, (uint32_t)arg, 0);

    return ret;
}


int LFS_removeUnsafe(const char *path)
{
    return lfs_remove(&lfs, path);
}

int LFS_fileOpenUnsafe(lfs_file_t *file, const char *path, int flags)
{
    return lfs_file_open(&lfs, file, path, flags);
}

int LFS_fileCloseUnsafe(lfs_file_t *file)
{
    return lfs_file_close(&lfs, file);
}

lfs_ssize_t LFS_fileReadUnsafe(lfs_file_t *file, void *buffer, lfs_size_t size)
{
    return lfs_file_read(&lfs, file, buffer, size);
}

lfs_ssize_t LFS_fileWriteUnsafe(lfs_file_t *file, const void *buffer, lfs_size_t size)
{
    int ret;

#ifdef FS_FILE_OPERATION_STATISTIC
    LFS_loadMonitorResult();
#endif

#ifdef FS_FILE_OPERATION_STATISTIC

    g_statisticResultChanged = true;

    for(int i = 0; i < FILE_TO_MONITOR_TOTAL_NUMBER; i++)
    {
        if(file->name && (strcmp(file->name, fileToMonitor[i].fileName) == 0))
        {
            g_fileWriteBytesCount[fileToMonitor[i].fileId] += size;
            g_fileWriteCount[fileToMonitor[i].fileId] += 1;
        }
    }

#endif

    ret = lfs_file_write(&lfs, file, buffer, size);

    return ret;
}

lfs_soff_t LFS_fileSeekUnsafe(lfs_file_t *file, lfs_soff_t off, int whence)
{
    return lfs_file_seek(&lfs, file, off, whence);
}

int LFS_fileSyncUnsafe(lfs_file_t *file)
{
    return lfs_file_sync(&lfs, file);
}

int LFS_fileTruncateUnsafe(lfs_file_t *file, lfs_off_t size)
{
    return lfs_file_truncate(&lfs, file, size);
}

lfs_soff_t LFS_fileTellUnsafe(lfs_file_t *file)
{
    return lfs_file_tell(&lfs, file);
}

int LFS_fileRewindUnsafe(lfs_file_t *file)
{
    return lfs_file_rewind(&lfs, file);
}

lfs_soff_t LFS_fileSizeUnsafe(lfs_file_t *file)
{
    return lfs_file_size(&lfs, file);
}


#ifdef __USER_CODE__
int LFS_mkdir(const char* dir) {
    int ret;

    ret = LFS_waitForCompletion(LFS_REQUEST_DIR_CREATE, NULL, (uint32_t)dir, 0);

    return ret;
}
#endif
