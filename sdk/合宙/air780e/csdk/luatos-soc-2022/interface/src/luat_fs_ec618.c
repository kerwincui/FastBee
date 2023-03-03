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
#include "luat_base.h"
#include "luat_fs.h"
#include "osasys.h"
#include "lfs_port.h"
#include "luat_rtos.h"
#include "luat_debug.h"

#ifdef __LUATOS__
#include "luat_malloc.h"
#define LUAT_LOG_TAG "fs"
#include "luat_log.h"
#include "mem_map.h"
#else
#include "luat_mem.h"
#endif


static inline const char* check_path(const char* path) {
    // if (path == NULL || strlen(path) < 1)
    //     return NULL;
    // const char* dst = path;
    // if (dst[0] == '/')
    //     dst = path + 1;
    return path;
}

static inline int is_file(const char* path) {
    if (path == NULL || strlen(path) < 1 || path[strlen(path) - 1] == '/')
        return 0;
    return 1;
} 


// #ifdef LUAT_USE_FS_VFS
// #if 1

FILE* luat_vfs_ec618_fopen(__attribute__((unused)) void* userdata, const char *filename, const char *mode) {
    int flag = 0;
    const char* dst = check_path(filename);
    if (dst == NULL || is_file(dst) == 0)
        return NULL;
    //LLOGD("luat_fs_fopen %s %s", filename, mode);
    lfs_file_t *file = (lfs_file_t*)luat_heap_malloc(sizeof(lfs_file_t));
    if (NULL == file) {
        //LLOGE("out of memory when open file");
        return NULL;
    }
/*
"r": 读模式（默认）；
"w": 写模式；
"a": 追加模式；
"r+": 更新模式，所有之前的数据都保留；
"w+": 更新模式，所有之前的数据都删除；
"a+": 追加更新模式，所有之前的数据都保留，只允许在文件尾部做写入。
*/
    if (!strcmp("r+", mode) || !strcmp("r+b", mode) || !strcmp("rb+", mode)) {
        flag = LFS_O_RDWR | LFS_O_CREAT;
    }
    else if(!strcmp("w+", mode) || !strcmp("w+b", mode) || !strcmp("wb+", mode)) {
        flag = LFS_O_RDWR | LFS_O_CREAT | LFS_O_TRUNC;
    }
    else if(!strcmp("a+", mode) || !strcmp("a+b", mode) || !strcmp("ab+", mode)) {
        flag = LFS_O_RDWR | LFS_O_APPEND | LFS_O_CREAT;
    }
    else if(!strcmp("w", mode) || !strcmp("wb", mode)) {
        flag = LFS_O_RDWR | LFS_O_CREAT | LFS_O_TRUNC;
    }
    else if(!strcmp("r", mode) || !strcmp("rb", mode)) {
        flag = LFS_O_RDONLY;
    }
    else if(!strcmp("a", mode) || !strcmp("ab", mode)) {
        flag = LFS_O_WRONLY | LFS_O_APPEND | LFS_O_CREAT;
    }
    else {
        //LLOGW("bad file open mode %s, fallback to 'r'", mode);
        flag = LFS_O_RDONLY;
    }
    int ret = LFS_fileOpen(file, dst, flag);
    //LLOGD("luat_fs_fopen %s %s ret %d", filename, mode, ret);
    if (ret == LFS_ERR_OK) {
        return (FILE*)file;
    }
    luat_heap_free(file);
    return NULL;
}

int luat_vfs_ec618_getc(__attribute__((unused))void* userdata, FILE* stream) {
    char buff[1];
    buff[0] = 0;
    int ret = LFS_fileRead((lfs_file_t*)stream, buff, 1);
    if (ret == 1)
        return buff[0];
    return -1;
}

int luat_vfs_ec618_fseek(__attribute__((unused))void* userdata, FILE* stream, long int offset, int origin) {
    //DBG("luat_fs_fseek fd=%p offset=%ld ori=%ld", stream, offset, origin);
    return LFS_fileSeek((lfs_file_t*)stream, offset, origin);
}

int luat_vfs_ec618_ftell(__attribute__((unused))void* userdata, FILE* stream) {
    //DBG("luat_fs_ftell fd=%ld", stream);
    return LFS_fileTell((lfs_file_t *)stream);
}

int luat_vfs_ec618_fclose(__attribute__((unused))void* userdata, FILE* stream) {
    if (stream == NULL)
        return 0;
    LFS_fileClose((lfs_file_t *)stream);
    free(stream);
    return 0;
}
int luat_vfs_ec618_feof(__attribute__((unused))void* userdata, FILE* stream) {
    return LFS_fileTell((lfs_file_t *)stream) == LFS_fileSize((lfs_file_t *)stream) ? 1 : 0;
}
int luat_vfs_ec618_ferror(__attribute__((unused))void* userdata, __attribute__((unused))FILE *stream) {
    return 0;
}
size_t luat_vfs_ec618_fread(__attribute__((unused))void* userdata, void *ptr, size_t size, size_t nmemb, FILE *stream) {
    lfs_ssize_t ret = LFS_fileRead((lfs_file_t*)stream, ptr, size * nmemb);
    //DBG("luat_fs_fread fd=%p size=%ld nmemb=%ld ret=%ld", stream, size, nmemb, t);
    //DBG("luat_fs_fread data[0-7] %p %X %X %X %X %X %X %X %X", data, *(data), *(data+1), *(data+2), *(data+3), *(data+4), *(data+5), *(data+6), *(data+7));
    if (ret < 0)
        return 0;
    return ret;
}
size_t luat_vfs_ec618_fwrite(__attribute__((unused))void* userdata, const void *ptr, size_t size, size_t nmemb, FILE *stream) {
    //DBG("luat_fs_fwrite fd=%p size=%ld nmemb=%ld", stream, size, nmemb);
    lfs_ssize_t ret = LFS_fileWrite((lfs_file_t*)stream, ptr, size * nmemb);
    if (ret < 0)
        return 0;
    return ret;
}
int luat_vfs_ec618_remove(__attribute__((unused))void* userdata, const char *filename) {
    const char* dst = check_path(filename);
    if (dst == NULL)
        return 0;
    return LFS_remove(dst);
}
int luat_vfs_ec618_rename(__attribute__((unused))void* userdata, const char *old_filename, const char *new_filename) {
    const char* src = check_path(old_filename);
    if (src == NULL)
        return 0;
    const char* dst = check_path(new_filename);
    if (dst == NULL)
        return 0;
    return LFS_rename(src, dst);
}
int luat_vfs_ec618_fexist(__attribute__((unused))void* userdata, const char *filename) {
    const char* dst = check_path(filename);
    if (dst == NULL)
        return 0;
    lfs_file_t file = {0};
    int ret = LFS_fileOpen(&file, dst, LFS_O_RDONLY);
    if (ret == LFS_ERR_OK) {
        LFS_fileClose(&file);
        return 1;
    }
    return 0;
}

size_t luat_vfs_ec618_fsize(__attribute__((unused))void* userdata, const char *filename) {
    const char* dst = check_path(filename);
    if (dst == NULL)
        return 0;
    lfs_file_t file = {0};
    int ret = LFS_fileOpen(&file, dst, LFS_O_RDONLY);
    if (ret == LFS_ERR_OK) {
        size_t sz = LFS_fileSize(&file);
        LFS_fileClose(&file);
        return sz;
    }
    return 0;
}

int luat_vfs_ec618_truncate(__attribute__((unused))void* userdata, const char* filename, size_t len) {
    const char* dst = check_path(filename);
    if (dst == NULL)
        return -1;
    lfs_file_t file = {0};
    int ret = LFS_fileOpen(&file, dst, LFS_O_RDWR);
    if (ret != LFS_ERR_OK) {
        return -2;
    }
    ret = LFS_fileTruncate(&file, len);
    LFS_fileClose(&file);
    return ret;
}

int luat_vfs_ec618_mkfs(__attribute__((unused))void* userdata, __attribute__((unused))luat_fs_conf_t *conf) {
    //DBG("not support yet : mkfs");
    return -1;
}
int luat_vfs_ec618_mount(__attribute__((unused))void** userdata, __attribute__((unused))luat_fs_conf_t *conf) {
    //DBG("not support yet : mount");
    return 0;
}
int luat_vfs_ec618_umount(__attribute__((unused))void* userdata, __attribute__((unused))luat_fs_conf_t *conf) {
    //DBG("not support yet : umount");
    return 0;
}

int LFS_mkdir(const char* dir);
int luat_vfs_ec618_mkdir(__attribute__((unused))void* userdata, __attribute__((unused))char const* _DirName) {
    const char* dir = check_path(_DirName);
    char buff[64] = {0};
    //LUAT_DEBUG_PRINT("mkdir %s %s", dir, _DirName);
    if (dir == NULL)
        return -1;
    size_t len = strlen(dir);
    if (strlen(dir) > 63 || strlen(dir) < 2) {
        return -2;
    }
    memcpy(buff, dir, len);
    if (buff[len - 1] == '/')
        buff[len - 1] = 0x00;
    int ret = LFS_mkdir(buff);
    //LUAT_DEBUG_PRINT("mkdir %s %s %d", dir, _DirName, ret);
    return ret;
}
int luat_vfs_ec618_rmdir(__attribute__((unused))void* userdata, __attribute__((unused))char const* _DirName) {
    const char* dir = check_path(_DirName);
    if (dir == NULL)
        return -1;
    return LFS_remove(dir);
}

int luat_vfs_ec618_lsdir(__attribute__((unused))void* userdata, char const* dir_name, luat_fs_dirent_t* ents, size_t offset, size_t len) {
    int ret = 0;
    size_t num = 0;
    lfs_dir_t *dir = NULL;
    struct lfs_info info = {0};
    const char* dirpath = check_path(dir_name);
    // if (fs->filecount > offset) {
        // if (offset + len > fs->filecount)
            // len = fs->filecount - offset;
        dir = luat_heap_malloc(sizeof(lfs_dir_t));
        if (dir == NULL) {
            // LLOGE("out of memory when lsdir");
            return 0;
        }
        ret = LFS_dirOpen(dir, dirpath); // 固定值, 因为不支持文件夹
        if (ret < 0) {
            luat_heap_free(dir);
            // LLOGE("no such dir %s _DirName");
            return 0;
        }

        // TODO 使用seek/tell组合更快更省
        for (size_t i = 0; i < offset; i++)
        {
            ret = LFS_dirRead(dir, &info);
            if (ret <= 0) {
                LFS_dirClose(dir);
                luat_heap_free(dir);
                return 0;
            }
        }

        while (num < len)
        {
            ret = LFS_dirRead(dir, &info);
            if (ret < 0) {
                LFS_dirClose(dir);
                luat_heap_free(dir);
                return 0;
            }
            if (ret == 0) {
                break;
            }
            if (info.type == 2 && (memcmp(info.name, ".", 2) !=0 ||memcmp(info.name, "..", 3)!=0))
                continue;
            ents[num].d_type = info.type - 1; // lfs file =1, dir=2
            strcpy(ents[num].d_name, info.name);
            num++;
        }
        LFS_dirClose(dir);
        luat_heap_free(dir);
        return num;
    // }
    // return 0;
}

int luat_vfs_ec618_info(__attribute__((unused))void* userdata, __attribute__((unused))const char* path, luat_fs_info_t *conf) {
    lfs_status_t status = {0};
    int ret = LFS_statfs(&status);
    if (ret == LFS_ERR_OK) {
        conf->total_block = status.total_block;
        conf->block_used = status.block_used;
        conf->block_size = status.block_size;
        conf->type = 1; // 片上FLASH
        memcpy(conf->filesystem, "lfs", 3);
        conf->filesystem[4] = 0;
        return 0;
    }
    // else {
    //     DBG("LFS_Statfs return %d", ret);
    // }
    return -1;
}

#ifdef LUAT_USE_FS_VFS

#define T(name) .name = luat_vfs_ec618_##name
const struct luat_vfs_filesystem vfs_fs_ec618 = {
    .name = "ec618",
    .opts = {
        T(mkfs),
        T(mount),
        T(umount),
        T(mkdir),
        T(rmdir),
        T(remove),
        T(rename),
        T(fsize),
        T(fexist),
        T(info),
        T(lsdir)
    },
    .fopts = {
        T(fopen),
        T(getc),
        T(fseek),
        T(ftell),
        T(fclose),
        T(feof),
        T(ferror),
        T(fread),
        T(fwrite)
    }
};

#ifdef __LUATOS__
extern const struct luat_vfs_filesystem vfs_fs_lfs2;
extern const struct luat_vfs_filesystem vfs_fs_luadb;
void luat_lv_fs_init(void);
void lv_split_jpeg_init(void);
void lv_bmp_init(void);
void lv_png_init(void);
#endif

int luat_fs_init(void) {

    luat_vfs_reg(&vfs_fs_ec618);
#ifdef __LUATOS__
    luat_vfs_reg(&vfs_fs_lfs2);
	luat_vfs_reg(&vfs_fs_luadb);
#endif

	luat_fs_conf_t conf = {
		.busname = "",
		.type = "ec618",
		.filesystem = "ec618",
		.mount_point = ""
	};
	luat_fs_mount(&conf);

#ifdef __LUATOS__
    // 以下为临时配置, 从APP区的末端,切出128k作为临时脚本区，80K作为OTA区
    #define LUADB_ADDR ((uint32_t)LUA_SCRIPT_ADDR | AP_FLASH_XIP_ADDR)
    //DBG("luadb tmp addr %p", LUADB_ADDR);
	luat_fs_conf_t conf2 = {
		.busname = (char*)(const char*)LUADB_ADDR,
		.type = "luadb",
		.filesystem = "luadb",
		.mount_point = "/luadb/",
	};
	luat_fs_mount(&conf2);
#ifdef LUAT_USE_LVGL
	luat_lv_fs_init();
	// lv_bmp_init();
	// lv_png_init();
	lv_split_jpeg_init();
#endif
#endif
	return 0;
}

#else

FILE* luat_fs_fopen(const char *filename, const char *mode) {
    return luat_vfs_ec618_fopen(NULL, filename, mode);
}

int luat_fs_getc(FILE* stream) {
    return luat_vfs_ec618_getc(NULL, stream);
}

int luat_fs_fseek(FILE* stream, long int offset, int origin) {
    return luat_vfs_ec618_fseek(NULL, stream, offset, origin);
}

int luat_fs_ftell(FILE* stream) {
    return luat_vfs_ec618_ftell(NULL, stream);
}

int luat_fs_fclose(FILE* stream) {
    return luat_vfs_ec618_fclose(NULL, stream);
}

int luat_fs_feof(FILE* stream) {
    return luat_vfs_ec618_feof(NULL, stream);
}

int luat_fs_ferror(FILE *stream) {
    return luat_vfs_ec618_ferror(NULL, stream);
}


size_t luat_fs_fread(void *ptr, size_t size, size_t nmemb, FILE *stream) {
    return luat_vfs_ec618_fread(NULL, ptr, size, nmemb, stream);
}

size_t luat_fs_fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream) {
    return luat_vfs_ec618_fwrite(NULL, ptr, size, nmemb, stream);
}

int luat_fs_remove(const char *filename) {
    return luat_vfs_ec618_remove(NULL, filename);
}

int luat_fs_rename(const char *old_filename, const char *new_filename) {
    return luat_vfs_ec618_rename(NULL, old_filename, new_filename);
}


size_t luat_fs_fsize(const char *filename) {
    return luat_vfs_ec618_fsize(NULL, filename);
}

int luat_fs_fexist(const char *filename) {
    return luat_vfs_ec618_fexist(NULL, filename);
}

// int luat_fs_ftruncate(FILE* fp, size_t len) {

// }


int luat_fs_truncate(const char* filename, size_t len) {
    return luat_vfs_ec618_truncate(NULL, filename, len);
}

// int luat_fs_readline(char * buf, int bufsize, FILE * stream);

// 文件夹相关的API

int luat_fs_mkdir(char const* dir) {
    return luat_vfs_ec618_mkdir(NULL, dir);
}

int luat_fs_rmdir(char const* dir) {
    return luat_vfs_ec618_rmdir(NULL, dir);
}

int luat_fs_lsdir(char const* dir, luat_fs_dirent_t* ents, size_t offset, size_t len) {
    return luat_vfs_ec618_lsdir(NULL, dir, ents, offset, len);
}

int luat_fs_init(void) {
    return 0;
}

int luat_fs_info(const char* path, luat_fs_info_t *info){
    return luat_vfs_ec618_info(NULL, path, info);
}

extern int lfs_ready;
int luat_fs_ready(void) {
    return lfs_ready;
}

#endif

