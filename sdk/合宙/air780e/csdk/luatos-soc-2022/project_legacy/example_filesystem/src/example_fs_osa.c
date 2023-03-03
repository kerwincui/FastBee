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
本demo使用OsaXXX系列API进行演示.

提示: 底层文件系统是基于lifftefs, 具有掉电不丢数据的特性.

在写入新数据时, 若文件路径已经存在, 在打开该文件进行写操作时,原有数据并不会马上被清除.

该特性, 在极端情况下, 会出现2倍的flash空间消耗. 所以, 下面是覆写文件时的建议

1. 若该文件重要, 那按常规写法进行, 且重要文件应保持小体积.
2. 若该文件不重要, 那应该先执行 OsaRemove, 然后在OsaFopen

*/

// 标准include
#include "common_api.h"
#include "FreeRTOS.h"
#include "task.h"

// 引入osa文件API
#include "osasys.h"

// 引入随机数API
#include "rng.h"


#define FILE_NAME "test.txt"
#define BUFF_SIZE (24)

// 这个buff的用途是存放file write的随机数据, 与 file read的数据进行对比
// buff size选24是因为rngGenRandom固定24字节
static uint8_t tmpbuff[BUFF_SIZE];

static void exmaple_file_write(void) {
    //----------------------------------------------
    //            文件写入演示
    //----------------------------------------------
	// 可选, 先移除现有文件, 详情看本文件头部的提示
	// OsaRemove(FILE_NAME);

	// OsaFopen的用法用fopen一致, 支持 rb/wb/wb+/a/a+等操作
	OSAFILE fp = OsaFopen(FILE_NAME, "wb+");
	if (fp == NULL) {
		DBG("open file for write, failed");
		return;
	}
	// 随机数生成器, 注意其输入是24字节的数组.
	rngGenRandom(tmpbuff);

	// 写入数据, 与 fwrite 一个样, 返回值写入的块数量(1), 而非字节数
	uint32_t ret = OsaFwrite(tmpbuff, BUFF_SIZE, 1, fp);
	if (ret != 1) {
		DBG("fail to write, excpt 1 but %d", BUFF_SIZE, ret);
	}
	// 操作完成后,务必关闭文件句柄
	OsaFclose(fp);

	return;
}

static void exmaple_file_read(void) {
    //----------------------------------------------
    //            文件读取演示
    //----------------------------------------------
	// OsaFopen的用法用fopen一致, 支持 rb/wb/wb+/a/a+等操作
	OSAFILE fp = OsaFopen(FILE_NAME, "rb");
	if (fp == NULL) {
		DBG("open file for read, failed");
		return;
	}
	
	char buff[BUFF_SIZE];
	// 读取数据, 与 fread 一个样, 返回值是块数量(1), 而非字节数
	uint32_t ret = OsaFread(buff, BUFF_SIZE, 1, fp);
	if (ret != 1) {
		DBG("fail to read, excpt %d but %d", BUFF_SIZE, ret);
	}
	// 与 fwrite的数据进行对比, 理应一致
	if (memcmp(buff, tmpbuff, BUFF_SIZE)) {
		DBG("file content NOT match!!");
	}
	// 最后务必关闭文件句柄
	OsaFclose(fp);

	return;
}

void exmaple_fs_osa_main(void) {
	vTaskDelay(1000);
	exmaple_file_write();
	vTaskDelay(1000);
	exmaple_file_read();
}
