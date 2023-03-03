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

/*
LFS_xxx 系列函数, 分文件函数和文件夹, 还有几个文件系统相关的函数.
**注意**: 不要调用 LFS_init LFS_deinit LFS_format 函数!!!
*/

#include "common_api.h"
#include "luat_base.h"
#include "luat_rtos.h"
#include "luat_fs.h"
#include "luat_crypto.h"
#include "luat_debug.h"
#include "luat_mem.h"

static int print_fs_info()
{
    luat_fs_info_t fs_info = {0};

    luat_fs_info("/", &fs_info);
    // 打印文件系统空间信息
    LUAT_DEBUG_PRINT("fs_info %s %d %d %d %d", 
        fs_info.filesystem, 
        fs_info.type, 
        fs_info.total_block, 
        fs_info.block_used, 
        fs_info.block_size);
}

static int recur_fs(const char* dir_path)
{
    luat_fs_dirent_t *fs_dirent = LUAT_MEM_MALLOC(sizeof(luat_fs_dirent_t)*100);
    memset(fs_dirent, 0, sizeof(luat_fs_dirent_t)*100);

    int lsdir_cnt = luat_fs_lsdir(dir_path, fs_dirent, 0, 100);

    if (lsdir_cnt > 0)
    {
        char path[255] = {0};

        LUAT_DEBUG_PRINT("dir_path=%s, lsdir_cnt=%d", dir_path, lsdir_cnt);

        for (size_t i = 0; i < lsdir_cnt; i++)
        {
            memset(path, 0, sizeof(path));            

            switch ((fs_dirent+i)->d_type)
            {
            // 文件类型
            case 0:   
                snprintf(path, sizeof(path)-1, "%s%s", dir_path, (fs_dirent+i)->d_name);             
                LUAT_DEBUG_PRINT("\tfile=%s, size=%d", path, luat_fs_fsize(path));
                break;
            
            // 文件夹类型
            case 1:
                // 移芯618平台不支持文件夹创建操作，以下注释掉的两行代码未经测试
                // snprintf(path, sizeof(path)-1, "%s/%s/", dir_path, (fs_dirent+i)->d_name);
                // recur_fs(path);
                break;

            default:
                break;
            }
        }        
    }

    LUAT_MEM_FREE(fs_dirent);
    fs_dirent = NULL;
    
    return lsdir_cnt;
}

// 演示文件操作, luat_fs_XXX 文件函数
void exmaple_fs_luat_file(void) {
    FILE* fp = NULL;
    uint8_t *buff = NULL;
    const char* filepath = "lfs_test.txt";
    const char* newpath = "newpath";
    char tmp[100];
    int ret = 0;
    size_t size = 0;

    LUAT_DEBUG_PRINT("check file exists? %s", filepath);
    // 通过获取大小, 判断文件是否存在, 存在就删除之
    if (luat_fs_fexist(filepath)) {
        LUAT_DEBUG_PRINT("remove %s", filepath);
        luat_fs_remove(filepath);
    }

    //----------------------------------------------
    //            文件写入演示
    //----------------------------------------------
    // 开始写入文件
    LUAT_DEBUG_PRINT("test lfs file write");
    fp = luat_fs_fopen(filepath, "wb+");
    if (!fp) {
        LUAT_DEBUG_PRINT("file open failed %s", filepath);
        return;
    }
    // 产生随机数据, 模拟业务写入
    LUAT_DEBUG_PRINT("call malloc and rngGenRandom");
    buff = malloc(24 * 100);
    if (buff == NULL) {
        LUAT_DEBUG_PRINT("out of memory ?");
        luat_fs_fclose(fp);
        goto exit;
    }
    for (size_t i = 0; i < 100; i++)
    {
        luat_crypto_trng(buff + i*24, 24);
    }

    // 按块写入数据
    LUAT_DEBUG_PRINT("call luat_fs_write");
    for (size_t i = 0; i < 24; i++)
    {
        ret = luat_fs_fwrite((const void*)(buff + i * 100), 100, 1, fp);
        if (ret < 0) {
            LUAT_DEBUG_PRINT("fail to write ret %d", ret);
            luat_fs_fclose(fp);
            goto exit;
        }
    }
    // 关闭文件
    luat_fs_fclose(fp);

    //----------------------------------------------
    //            文件读取演示
    //----------------------------------------------
    // 读取文件
    fp = luat_fs_fopen(filepath, "r");
    if (!fp) {
        LUAT_DEBUG_PRINT("file open failed %s", filepath);
        goto exit;
    }
    for (size_t i = 0; i < 24; i++)
    {
        ret = luat_fs_fread(tmp, 100, 1, fp);
        if (ret < 0) {
            LUAT_DEBUG_PRINT("fail to write ret %d", ret);
            luat_fs_fclose(fp);
            goto exit;
        }
        if (memcmp(tmp, buff + i * 100, 100) != 0) {
            LUAT_DEBUG_PRINT("file data NOT match");
        }
    }
    // 直接定位 offset=100的位置, 重新读取
    luat_fs_fseek(fp, 100, SEEK_SET);
    ret = luat_fs_fread(tmp, 100, 1, fp);
    if (memcmp(tmp, buff + 100, 100) != 0) {
        LUAT_DEBUG_PRINT("file data NOT match at offset 100");
    }
    ret = luat_fs_ftell(fp);
    if (ret != 200) {
        // 按前面的逻辑, 先设置到100, 然后读取100, 当前偏移量应该是200
        LUAT_DEBUG_PRINT("file seek NOT match at offset 200");
    }
    
    // 关闭句柄
    luat_fs_fclose(fp);

    //----------------------------------------------
    //            文件截断演示
    //----------------------------------------------

    // // 直接用路径裁剪
    luat_fs_truncate(filepath, 300);


    //----------------------------------------------
    //            文件改名演示
    //----------------------------------------------
    // 文件还在, 测试改名
    luat_fs_remove(newpath);
    luat_fs_rename(filepath, newpath);
    // 读取文件, 老路径应该得到文件大小不大于0
    
    size = luat_fs_fsize(filepath);
    if (size > 0) {
        LUAT_DEBUG_PRINT("file shall not exist");
    }
    // 读取文件, 新路径应该得到文件大小等于300
    size = luat_fs_fsize(newpath);
    if (size != 300) {
        LUAT_DEBUG_PRINT("file shall 300 byte but %d", size);
    }

    luat_fs_remove(filepath);
    luat_fs_remove(newpath);

    //------------------------------------------------------
    // 演示完毕, 清理资源
    exit:
        if (buff != NULL) {
            free(buff);
        }
        LUAT_DEBUG_PRINT("file example exited");
        return;
}


void exmaple_fs_luat_main(void) {
    luat_fs_init(); // 必须先初始化    
    print_fs_info();
    recur_fs("/");
    exmaple_fs_luat_file();
    luat_rtos_task_sleep(1000);
}
