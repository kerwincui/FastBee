#ifndef LFS_PORT_H
#define LFS_PORT_H

#include "lfs.h"
#include "cmsis_os2.h"

#ifdef __cplusplus
extern "C"
{
#endif

/*
*/
typedef int (*lfs_callback_func)(void *arg);

// List of all supported LFS request type
typedef enum
{
    LFS_REQUEST_REMOVE,
    LFS_REQUEST_FORMAT,
    LFS_REQUEST_RENAME,
    LFS_REQUEST_STAT,
    LFS_REQUEST_STATFS,
    LFS_REQUEST_SAVE_MONITOR_RESULT,

    LFS_REQUEST_FILE_OPEN,
    LFS_REQUEST_FILE_CLOSE,
    LFS_REQUEST_FILE_READ,
    LFS_REQUEST_FILE_WRITE,
    LFS_REQUEST_FILE_SEEK,
    LFS_REQUEST_FILE_SYNC,
    LFS_REQUEST_FILE_TRUNCATE,
    LFS_REQUEST_FILE_TELL,
    LFS_REQUEST_FILE_REWIND,
    LFS_REQUEST_FILE_SIZE,

    LFS_REQUEST_DIR_OPEN,
    LFS_REQUEST_DIR_CLOSE,
    LFS_REQUEST_DIR_READ,

    LFS_REQUEST_BLOCK_CALLBACK,
#ifdef __USER_CODE__
    LFS_REQUEST_DIR_CREATE,
#endif
} lfs_request_type_t;

typedef struct
{
    lfs_request_type_t       type;

    osThreadId_t             threadId;   //Indicate which thread sends this request

    union
    {
        lfs_file_t          *fileHandle;
        lfs_dir_t           *dirHandle;
        void                *opaqueHandle;
        lfs_callback_func   callbackFunc;
    } handle;

    uint32_t                 data[2];
} lfs_request_t;

typedef struct
{
    int32_t            retCode;
} lfs_reply_t;

typedef struct _lfs_status
{
    uint32_t total_block;
    uint32_t block_used;
    uint32_t block_size;
} lfs_status_t;

typedef struct _file_operation_statistic_result
{
    const char* name;
    uint32_t writeCount;
    uint32_t writeBytesCount;
} file_operation_statistic_result_t;

int LFS_getFileWriteMonitorResult(file_operation_statistic_result_t* result);
int LFS_getBlockEraseCountResult(uint32_t* result);
void LFS_resetMonitorResult(void);

void LFS_adjustDaemonTaskPriority(void);

// Initialize
int LFS_init(void);

// Deinit
void LFS_deinit(void);

// Wrapper of lfs_format
int LFS_format(void);

// Wrapper of lfs_stat
int LFS_stat(const char *path, struct lfs_info *info);

// Wrapper of lfs_remove
int LFS_remove(const char *path);

// Wrapper of lfs_rename
int LFS_rename(const char *oldpath, const char *newpath);

// Wrapper of lfs_file_open
int LFS_fileOpen( lfs_file_t *file, const char *path, int flags);

// Wrapper of lfs_file_close
int LFS_fileClose(lfs_file_t *file);

// Wrapper of lfs_file_read
lfs_ssize_t LFS_fileRead(lfs_file_t *file, void *buffer, lfs_size_t size);

// Wrapper of lfs_file_write
lfs_ssize_t LFS_fileWrite(lfs_file_t *file, const void *buffer, lfs_size_t size);

// Wrapper of lfs_file_sync
int LFS_fileSync(lfs_file_t *file);

// Wrapper of lfs_file_seek
lfs_soff_t LFS_fileSeek(lfs_file_t *file, lfs_soff_t off, int whence);

// Wrapper of lfs_file_truncate
int LFS_fileTruncate(lfs_file_t *file, lfs_off_t size);

// Wrapper of lfs_file_tell
lfs_soff_t LFS_fileTell(lfs_file_t *file);

// Wrapper of lfs_file_rewind
int LFS_fileRewind(lfs_file_t *file);

// Wrapper of lfs_file_size
lfs_soff_t LFS_fileSize(lfs_file_t *file);

// Wrapper of lfs_dir_open
int LFS_dirOpen(lfs_dir_t *dir, const char *path);

// Wrapper of lfs_dir_close
int LFS_dirClose(lfs_dir_t *dir);

// Wrapper of lfs_dir_read
int LFS_dirRead(lfs_dir_t *dir, struct lfs_info *info);

// Get fs status
int LFS_statfs(lfs_status_t *status);

// Callback func, running in LFS daemon task
int LFS_blockCallback(lfs_callback_func callback, void *arg);

// Non-thread-safe version API, used internally
int LFS_removeUnsafe(const char *path);

int LFS_fileOpenUnsafe(lfs_file_t *file, const char *path, int flags);

int LFS_fileCloseUnsafe(lfs_file_t *file);

lfs_ssize_t LFS_fileReadUnsafe(lfs_file_t *file, void *buffer, lfs_size_t size);

lfs_ssize_t LFS_fileWriteUnsafe(lfs_file_t *file, const void *buffer, lfs_size_t size);

lfs_soff_t LFS_fileSeekUnsafe(lfs_file_t *file, lfs_soff_t off, int whence);

int LFS_fileSyncUnsafe(lfs_file_t *file);

int LFS_fileTruncateUnsafe(lfs_file_t *file, lfs_off_t size);

lfs_soff_t LFS_fileTellUnsafe(lfs_file_t *file);

int LFS_fileRewindUnsafe(lfs_file_t *file);

lfs_soff_t LFS_fileSizeUnsafe(lfs_file_t *file);

#ifdef __USER_CODE__
int LFS_mkdir(const char* dir);
#endif

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif
