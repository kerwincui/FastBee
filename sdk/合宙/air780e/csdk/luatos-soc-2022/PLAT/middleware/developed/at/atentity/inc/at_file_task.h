#ifndef _AT_FILE_TASK_
#define _AT_FILE_TASK_
#include "FreeRTOS.h"
#include "queue.h"

#define FILE_SEMPHR_MAX_NUMB   4 
#define FILE_TASK_STACK_SIZE   1600
#define FILE_INFO_MAX_NUMB     16
#define FILE_MSG_TIMEOUT       2000
#define FILE_TASK_CREATE   1 
#define FILE_TASK_DELETE   2 
#define FILE_READ_MAX_COUNT   4 

#define FILE_READ_DEFAULT_LEN       0xffff

enum FILE_RET
{
    FILE_OK = 200,
    FILE_ERR,
    FILE_CTRL_Z_OK,

    FILE_MAX_ERR,
};

enum FILE_MODE
{
    FILE_MODE_0 = 0,
    FILE_MODE_1,
    FILE_MODE_2,
};

enum FILE_STATUS
{
    FILE_STATUS_RESERVE,
    FILE_STATUS_OPEN,
    FILE_STATUS_READ,
    FILE_STATUS_WRITE,
    FILE_STATUS_SEEK,
    FILE_STATUS_POSITION,
    FILE_STATUS_TUCAT, 
    FILE_STATUS_CLOSE, 
    FILE_STATUS_RENAME,
    FILE_STATUS_DELETE, 
    FILE_STATUS_ERASE, 
    FILE_STATUS_DELETE_ALL, 
    
    FILE_STATUS_MSLDS,     /*memory space LDS*/
    FILE_STATUS_MSLST,     /*memory space LST*/
    FILE_STATUS_MSDEL,     /*memory space DEL*/
    FILE_STATUS_MSUPL,     /*memory space UPL*/
    FILE_STATUS_MSDWL,     /*memory space DWL*/
    FILE_STATUS_MOV, 

};

enum FILE_MSG_CMD
{
    FILE_MSG_RESERVE,
    FILE_MSG_OPEN,
    FILE_MSG_READ,
    FILE_MSG_WRITE,
    FILE_MSG_SEEK,
    FILE_MSG_POSITION,
    FILE_MSG_TUCAT, 
    FILE_MSG_CLOSE, 
    FILE_MSG_RENAME,
    FILE_MSG_DELETE, 
    FILE_MSG_ERASE, 
    FILE_MSG_DELETE_ALL, 
    
    FILE_MSG_MSLDS,     /*memory space LDS*/
    FILE_MSG_MSLST,     /*memory space LST*/
    FILE_MSG_MSDEL,     /*memory space DEL*/
    FILE_MSG_MSUPL,     /*memory space UPL*/
    FILE_MSG_MSDWL,     /*memory space DWL*/
    FILE_MSG_MOV, 

};

typedef struct
{
    char *fileName;
    char *fileSysHandle;
    int32_t  flags;
    uint32_t fileHandler;
    uint32_t fileMode;
    uint32_t fileLen;
    uint32_t fileStatus;
}fileInfo;

typedef struct
{
    uint32_t reqhandle;
    uint32_t cmdType;
    int32_t  flags;
    char *fileName;
    char *filePattern;
    char *fileSysHandle;
    char *fileBuff;
    char *fileNameNew;
    uint32_t fileHandler;    
    uint32_t mode;
    uint32_t length;
    uint32_t totalLength;
    uint32_t timeout;
    uint32_t offset;
    uint32_t position;
    uint32_t fileStatus;

}fileInfoPara;


typedef struct
{
    uint32_t reqhandle;
    uint32_t cmdType;
    char *fileName;
    char *filePattern;
    char *fileNameNew;
    fileInfo *fileInfoPtr;
    uint32_t fileHandle;
    uint32_t mode;
    uint32_t length;
    uint32_t totalLength;
    uint32_t timeout;
    uint32_t offset;
    uint32_t position;
    char *reqBuff;
}fileReqMsg;

typedef struct
{
    uint32_t reqhandle;
    char *fileName;
    char *filePattern;
    uint32_t fileHandle;
    uint32_t result;
    uint32_t ack;
    char *retBuff;
    INT32 retLen;
    INT32 retTotalLen;
    
}fileCnfMsg;


fileInfo *fileFindExistFileByName(fileInfoPara fileInfo);
fileInfo *fileFindExistFileByHandler(fileInfoPara fileInfo);
int fileClientInterface(fileInfoPara fileReq);
fileInfo *fileGetExistFile(uint32_t index);

#endif
