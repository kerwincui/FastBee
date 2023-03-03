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
#include "luat_wdt.h"

/*
移芯618平台上的看门狗使用有如下注意事项：
1、看门狗特性说明可以参考：https://doc.openluat.com/wiki/37?wiki_page_id=4586
2、luat_wdt.h中的接口不要在INIT_HW_EXPORT、INIT_DRV_EXPORT、INIT_TASK_EXPORT中的处理函数中调用，原因是：
   在这里调用后，SDK系统后续还会对看门狗进行初始化，会覆盖用户的配置；
   使用位置可以参考本文件task_dead_loop_run中对luat_wdt_set_timeout接口的调用。
*/

static luat_rtos_task_handle feed_wdt_task_handle;

static void task_feed_wdt_run(void *param)
{                     
    while (1)
    {
        //看门狗默认打开，超时时间20s，并且有自动喂狗逻辑，用户不需要去再次启动看门狗，只需根据自身逻辑按时去喂狗即可
        luat_wdt_feed(); 
        LUAT_DEBUG_PRINT("feed wdt");
        luat_rtos_task_sleep(1000);                            
    }
    luat_rtos_task_delete(feed_wdt_task_handle);
    
}

static void task_feed_wdt_init(void)
{
    luat_rtos_task_create(&feed_wdt_task_handle, 2048, 20, "feed_wdt", task_feed_wdt_run, NULL, NULL);
}


static luat_rtos_task_handle dead_loop_task_handle;

static void task_dead_loop_run(void *param)
{
    while (1)
    {
        LUAT_DEBUG_PRINT("dead loop");
    }
    luat_rtos_task_delete(dead_loop_task_handle);
    
}

static void task_dead_loop_init(void)
{   
    luat_rtos_task_create(&dead_loop_task_handle, 2048, 50, "dead_loop", task_dead_loop_run, NULL, NULL);
}

INIT_TASK_EXPORT(task_feed_wdt_init,"1");
// 此task通过执行一个死循环，来模拟软件异常，20秒后看门狗超时会自动重启
// 仅用来模拟测试使用，有需要可以自行打开
// INIT_TASK_EXPORT(task_dead_loop_init,"2");



