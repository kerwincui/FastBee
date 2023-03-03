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

#ifndef LUAT_FS_H
#define LUAT_FS_H
//#include "luat_base.h"
#include "stdio.h"


/**
 * @defgroup luat_fs 文件系统接口
 * @{
 */

#ifndef LUAT_WEAK
#define LUAT_WEAK __attribute__((weak))
#endif

typedef struct luat_fs_conf {
    char* busname;
    char* type;
    char* filesystem;
    const char* mount_point;
} luat_fs_conf_t;

typedef struct luat_fs_info
{
    char filesystem[8]; // 文件系统类型
    unsigned char type;   // 连接方式, 片上,spi flash, tf卡等
    size_t total_block;
    size_t block_used;
    size_t block_size;
}luat_fs_info_t;


/**
 * @brief 文件系统初始化
 * @return int =0成功，其他失败
 */
int luat_fs_init(void);

// int luat_fs_mkfs(luat_fs_conf_t *conf);
// int luat_fs_mount(luat_fs_conf_t *conf);
// int luat_fs_umount(luat_fs_conf_t *conf);
/**
 * @brief 获取文件系统状态
 * @param path[IN] 挂载路径, 通常为 /
 * @param info[OUT] 文件系统信息
 * @return int =0成功，其他失败
 */
int luat_fs_info(const char* path, luat_fs_info_t *info);

/**
 * @brief 打开文件,类似于fopen
 * @param path[IN] 文件路径
 * @param mode[IN] 打开模式,与posix类型, 例如 "r" "rw" "w" "w+" "a"
 * @return FILE* 文件句柄,失败返回NULL
 */
FILE* luat_fs_fopen(const char *filename, const char *mode);

/**
 * @brief 读到单个字节,类似于getc
 * @param stream[IN] 文件句柄
 * @return int >=0读取成功返回, -1失败, 例如读取到文件尾部
 */
int luat_fs_getc(FILE* stream);
/**
 * @brief 设置句柄位置,类似于fseek
 * @param stream[IN] 文件句柄
 * @param offset[IN] 偏移量
 * @param origin[IN] 参考点, 例如 SEEK_SET 绝对坐标, SEEK_END 结尾, SEEK_CUR 当前
 * @return int =0成功,否则失败
 */
int luat_fs_fseek(FILE* stream, long int offset, int origin);
/**
 * @brief 获取句柄位置,类似于ftell
 * @param stream[IN] 文件句柄
 * @return int >=0当前位置, 否则失败
 */
int luat_fs_ftell(FILE* stream);
/**
 * @brief 关闭句柄位置,类似于fclose
 * @param stream[IN] 文件句柄
 * @return int =0成功,否则失败
 */
int luat_fs_fclose(FILE* stream);
/**
 * @brief 是否已经到文件结尾,类似于feof
 * @param stream[IN] 文件句柄
 * @return int =0未到文件尾部,其余为到达文件尾部
 */
int luat_fs_feof(FILE* stream);
/**
 * @brief 是否有文件系统错误,类似于ferror
 * @param stream[IN] 文件句柄
 * @return int =0无错误, 其余为错误值
 */
int luat_fs_ferror(FILE *stream);

/**
 * @brief 读取文件,类似于fread
 * @param ptr[OUT] 存放读取数据的缓冲区
 * @param size[IN] 单次读取大小
 * @param nmemb[IN] 读取次数
 * @param stream[IN] 文件句柄
 * @return int >=0实际读取的数量,<0出错
 */
size_t luat_fs_fread(void *ptr, size_t size, size_t nmemb, FILE *stream);
/**
 * @brief 写入文件,类似于fwrite
 * @param ptr[OUT] 存放写入数据的缓冲区
 * @param size[IN] 单次读取大小
 * @param nmemb[IN] 读取次数
 * @param stream[IN] 文件句柄
 * @return int >=0实际写入的数量,<0出错
 */
size_t luat_fs_fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream);

/**
 * @brief 删除文件,类似于remove
 * @param filename[IN] 文件路径
 * @return int =0成功,否则失败
 */
int luat_fs_remove(const char *filename);

/**
 * @brief 文件改名,类似于rename
 * @param old_filename[IN] 原文件路径
 * @param new_filename[IN] 新文件路径
 * @return int =0成功,否则失败
 */
int luat_fs_rename(const char *old_filename, const char *new_filename);


/**
 * @brief 文件大小,类似于fsize
 * @param filename[IN] 文件路径
 * @return int >=0文件大小, <0文件存在或者不可访问
 */
size_t luat_fs_fsize(const char *filename);
/**
 * @brief 文件是否存在,类似于fexist
 * @param filename[IN] 文件路径
 * @return int =0不存在,否则存在
 */
int luat_fs_fexist(const char *filename);

/**
 * @brief 截断文件,类似于ftruncate
 * @param fp[IN] 文件句柄
 * @return int >=0截断后的文件大小,否则失败
 */
// int luat_fs_ftruncate(FILE* fp, size_t len);


/**
 * @brief 截断文件,类似于truncate
 * @param filename[IN] 文件路径
 * @return int >=0截断后的文件大小,否则失败
 */
int luat_fs_truncate(const char* filename, size_t len);

// int luat_fs_readline(char * buf, int bufsize, FILE * stream);

// 文件夹相关的API

typedef struct luat_fs_dirent
{
    unsigned char d_type; //0:文件；1：文件夹(EC618不支持创建目录操作，所以理论上不会出现为1的情况)
    char d_name[255];
}luat_fs_dirent_t;


/**
 * @brief 创建文件夹,当前EC618不支持
 * @param dir[IN] 文件夹路径
 * @return int =0成功,否则失败
 */
int luat_fs_mkdir(char const* dir);

/**
 * @brief 删除文件夹,必须为空文件夹
 * @param dir[IN] 文件夹路径
 * @return int =0成功,否则失败
 */
int luat_fs_rmdir(char const* dir);
/**
 * @brief 遍历文件夹
 * @param dir[IN] 文件夹路径
 * @param ents[OUT] 文件列表,必须已分配内存,且不小于len个元素
 * @param offset[IN] 跳过多少个文件
 * @param len[IN] 最多读取多少个文件
 * @return int =>0读取到文件个数,否则失败
 */
int luat_fs_lsdir(char const* dir, luat_fs_dirent_t* ents, size_t offset, size_t len);

/**
 * @brief 文件系统是否已经就绪
 * @return int 0未就绪, >0已就绪
 */
int luat_fs_ready(void);


#if LUAT_USE_FS_VFS

#ifndef LUAT_VFS_FILESYSTEM_MAX
#define LUAT_VFS_FILESYSTEM_MAX 4
#endif

#ifndef LUAT_VFS_FILESYSTEM_MOUNT_MAX
#define LUAT_VFS_FILESYSTEM_MOUNT_MAX 4
#endif

#ifndef LUAT_VFS_FILESYSTEM_FD_MAX
#define LUAT_VFS_FILESYSTEM_FD_MAX 16
#endif

struct luat_vfs_file_opts {
    FILE* (*fopen)(void* fsdata, const char *filename, const char *mode);
    int (*getc)(void* fsdata, FILE* stream);
    int (*fseek)(void* fsdata, FILE* stream, long int offset, int origin);
    int (*ftell)(void* fsdata, FILE* stream);
    int (*fclose)(void* fsdata, FILE* stream);
    int (*feof)(void* fsdata, FILE* stream);
    int (*ferror)(void* fsdata, FILE *stream);
    size_t (*fread)(void* fsdata, void *ptr, size_t size, size_t nmemb, FILE *stream);
    size_t (*fwrite)(void* fsdata, const void *ptr, size_t size, size_t nmemb, FILE *stream);
};

struct luat_vfs_filesystem_opts {
    int (*remove)(void* fsdata, const char *filename);
    int (*rename)(void* fsdata, const char *old_filename, const char *new_filename);
    size_t (*fsize)(void* fsdata, const char *filename);
    int (*fexist)(void* fsdata, const char *filename);
    int (*mkfs)(void* fsdata, luat_fs_conf_t *conf);

    int (*mount)(void** fsdata, luat_fs_conf_t *conf);
    int (*umount)(void* fsdata, luat_fs_conf_t *conf);
    int (*info)(void* fsdata, const char* path, luat_fs_info_t *conf);

    int (*mkdir)(void* fsdata, char const* _DirName);
    int (*rmdir)(void* fsdata, char const* _DirName);
    int (*lsdir)(void* fsdata, char const* _DirName, luat_fs_dirent_t* ents, size_t offset, size_t len);
};

typedef struct luat_vfs_filesystem {
    char name[16];
    struct luat_vfs_filesystem_opts opts;
    struct luat_vfs_file_opts fopts;
}luat_vfs_filesystem_t;

typedef struct luat_vfs_mount {
    struct luat_vfs_filesystem *fs;
    void *userdata;
    char prefix[16];
    int ok;
} luat_vfs_mount_t;

typedef struct luat_vfs_fd{
    FILE* fd;
    luat_vfs_mount_t *fsMount;
}luat_vfs_fd_t;


typedef struct luat_vfs
{
    struct luat_vfs_filesystem* fsList[LUAT_VFS_FILESYSTEM_MAX];
    luat_vfs_mount_t mounted[LUAT_VFS_FILESYSTEM_MOUNT_MAX];
    luat_vfs_fd_t fds[LUAT_VFS_FILESYSTEM_FD_MAX+1];
}luat_vfs_t;

int luat_vfs_init(void* params);
int luat_vfs_reg(const struct luat_vfs_filesystem* fs);
FILE* luat_vfs_add_fd(FILE* fd, luat_vfs_mount_t * mount);
int luat_vfs_rm_fd(FILE* fd);
const char* luat_vfs_mmap(FILE* fd);
#endif

/** @}*/

#endif


