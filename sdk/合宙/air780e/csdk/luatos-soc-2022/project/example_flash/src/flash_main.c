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

#include "luat_rtos.h"
#include "luat_debug.h"
#include "luat_flash.h"
#include "luat_crypto.h"

#include "mem_map.h"

/*
本Demo属于高级操作, 请务必先看完提示

Flash的整体布局如下, 对应非LuatOS应用:

AP flash layout, toatl 4MB
flash raw address: 0x00000000---0x00400000
flash xip address(from ap view): 0x00800000---0x00c00000


0x00000000          |---------------------------------|
                    |      header1 8KB                |
0x00002000          |---------------------------------|
                    |      header2 8KB                |
0x00004000          |---------------------------------|
                    |      bl part1 32KB              |
0x0000c000          |---------------------------------|
                    |      bl part2 96KB              |
0x00024000          |---------------------------------|
                    |      app img 2.5MB + 384k       |------OTA write
0x00304000          |---------------------------------|
                    |      fota 512KB                 |-----OTA download write
0x00384000          |---------------------------------|
                    |      lfs 288KB                  |-----FS write
0x003cc000          |---------------------------------|
                    |      kv  64KB                   |-----kv write
0x003dc000          |---------------------------------|
                    |      rel_ap(factory) 16KB       |-----factory write
0x003e0000          |---------------------------------|
                    |      rel_ap 16KB                |-----factory write
0x003e4000          |---------------------------------|
                    |      hib backup 96KB            |-----hib write
0x003fc000          |---------------------------------|
                    |      plat config 16KB           |-----similar as FS
0x00400000          |---------------------------------|


**注意**:
1. 若直接读取数据, 可通过 上述地址+0x00800000 直接读取, 不需要经过luat_flash.h
2. 若需要写入或抹除数据, 则需要调用luat_flash.h

按上图可知, 只有两个区域可以动:
1. KV数据库区, 若完全不使用luat_kv, 则可以直接使用
2. AP空间, 若确定不需要使用全部空间, 可进行裁剪, 但需要改mem_map.h
*/

static void flash_example(void *param)
{
	luat_rtos_task_sleep(1500);
	fotaNvmNfsPeInit(1);	//允许开放出app.img的最后896KB空间可写

	luat_rtos_task_sleep(2000);
	
	char buff[256] = {0};
	

	uint32_t addr = 0x00284000; // 这是app.img的最后512KB空间

	// flash读写没有太多技巧
	luat_flash_read(buff, addr, 256);

	luat_flash_erase(addr, 4096);

	// 生成一些随机数据,模拟业务数据
	luat_crypto_trng(buff, 256);

	luat_flash_write(buff, addr, 256);

	luat_flash_read(buff, addr, 256);
	fotaNvmNfsPeInit(0);	//测试完成，就可以关闭开放了
	while(1)
	{
		luat_rtos_task_sleep(1000);
		LUAT_DEBUG_PRINT("flash demo is done");
	}
}

static void task_demoE_init(void)
{
	luat_rtos_task_handle handle;
	luat_rtos_task_create(&handle, 16*1024, 50, "flash", flash_example, NULL, 0);
}


//启动hw_demoA_init，启动位置硬件初始1级
// INIT_HW_EXPORT(hw_demoA_init, "1");
//启动hw_demoB_init，启动位置硬件初始2级
// INIT_HW_EXPORT(hw_demoB_init, "2");
//启动dr_demoC_init，启动位置驱动1级
// INIT_DRV_EXPORT(dr_demoC_init, "1");
//启动dr_demoD_init，启动位置驱动2级
// INIT_DRV_EXPORT(dr_demoD_init, "2");
//启动task_demoE_init，启动位置任务1级
INIT_TASK_EXPORT(task_demoE_init, "1");
//启动task_demoF_init，启动位置任务2级
// INIT_TASK_EXPORT(task_demoF_init, "2");

