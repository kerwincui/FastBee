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
#include "FreeRTOS.h"
#include "task.h"

#include "lfs_port.h"
#include "rng.h"

// 演示文件操作, LFS_XXX 文件函数
void exmaple_fs_lfs_file(void) {
    lfs_file_t fp = {0}; // 注意, 如果需要跨函数使用, lfs_file_t需要malloc
    uint8_t *buff = NULL;
    const char* filepath = "lfs_test.txt";
    struct lfs_info info = {0};
    char tmp[100];
    int ret = 0;

    DBG("check file exists? %s", filepath);
    // 通过获取大小, 判断文件是否存在, 存在就删除之
    if (LFS_stat(filepath, &info) == LFS_ERR_OK) {
        if (info.size > 0) {
            DBG("remove %s", filepath);
            LFS_remove(filepath);
        }
    }

    //----------------------------------------------
    //            文件写入演示
    //----------------------------------------------
    // 开始写入文件
    DBG("test lfs file write");
    ret = LFS_fileOpen(&fp, filepath, LFS_O_CREAT | LFS_O_RDWR | LFS_O_TRUNC);
    if (ret != LFS_ERR_OK) {
        DBG("file open failed %d", ret);
        return;
    }
    // 产生随机数据, 模拟业务写入
    DBG("call malloc and rngGenRandom");
    buff = malloc(24 * 100);
    if (buff == NULL) {
        DBG("out of memory ?");
        LFS_fileClose(&fp);
        goto exit;
    }
    for (size_t i = 0; i < 100; i++)
    {
        rngGenRandom(buff + i*24);
    }

    // 按块写入数据
    DBG("call LFS_fileWrite");
    for (size_t i = 0; i < 24; i++)
    {
        ret = LFS_fileWrite(&fp, (const void*)(buff + i * 100), 100);
        if (ret != 100) {
            DBG("fail to write ret %d", ret);
            LFS_fileClose(&fp);
            goto exit;
        }
    }
    // 为保证正确性, 关闭前可先执行sync操作
    LFS_fileSync(&fp);
    // 关闭文件
    LFS_fileClose(&fp);

    //----------------------------------------------
    //            文件读取演示
    //----------------------------------------------
    // 读取文件
    ret = LFS_fileOpen(&fp, filepath, LFS_O_RDONLY);
    if (ret != LFS_ERR_OK) {
        DBG("file open failed %d", ret);
        goto exit;
    }
    for (size_t i = 0; i < 24; i++)
    {
        ret = LFS_fileRead(&fp, tmp, 100);
        if (ret != 100) {
            DBG("fail to write ret %d", ret);
            LFS_fileClose(&fp);
            goto exit;
        }
        if (memcmp(tmp, buff + i * 100, 100) != 0) {
            DBG("file data NOT match");
        }
    }
    // 直接定位 offset=100的位置, 重新读取
    LFS_fileSeek(&fp, 100, LFS_SEEK_SET);
    ret = LFS_fileRead(&fp, tmp, 100);
    if (memcmp(tmp, buff + 100, 100) != 0) {
        DBG("file data NOT match at offset 100");
    }
    ret = LFS_fileTell(&fp);
    if (ret != 200) {
        // 按前面的逻辑, 先设置到100, 然后读取100, 当前偏移量应该是200
        DBG("file seek NOT match at offset 200");
    }
    
    // 关闭句柄
    LFS_fileClose(&fp);

    //----------------------------------------------
    //            文件截断演示
    //----------------------------------------------
    // LFS_fileTruncate需要以读写方式打开文件,否则会崩
    ret = LFS_fileOpen(&fp, filepath, LFS_O_RDWR);

    // 缩减文件到300字节
    LFS_fileTruncate(&fp, 300);
    ret = LFS_fileSize(&fp);
    if (ret != 300) {
        // 裁剪后文件大小应该是300
        DBG("file size NOT 300, but %d", ret);
    }
    LFS_fileClose(&fp);


    //----------------------------------------------
    //            文件改名演示
    //----------------------------------------------
    // 文件还在, 测试改名
    LFS_remove("newpath");
    LFS_rename(filepath, "newpath");
    // 读取文件, 老路径应该得到文件大小不大于0
    info.size  = 0;
    LFS_stat(filepath, &info);
    if (info.size > 0) {
        DBG("file shall not exist");
    }
    // 读取文件, 新路径应该得到文件大小等于300
    info.size  = 0;
    LFS_stat("newpath", &info);
    if (info.size != 300) {
        DBG("file shall 300 byte but %d", info.size);
    }

    LFS_remove(filepath);
    LFS_remove("newpath");

    //------------------------------------------------------
    // 演示完毕, 清理资源
    exit:
        if (buff != NULL) {
            free(buff);
        }
        DBG("file example exited");
        return;
}


// 演示文件操作, LFS_XXX 文件夹函数
void exmaple_fs_lfs_dir(void) {
    // TODO
}

void exmaple_fs_lfs_main(void) {
    exmaple_fs_lfs_file();
    vTaskDelay(1000);
    exmaple_fs_lfs_dir();
}
