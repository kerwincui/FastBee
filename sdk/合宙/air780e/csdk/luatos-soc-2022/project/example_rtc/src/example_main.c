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

#include "luat_rtc.h"


luat_rtos_task_handle rtc_task_handle;

static void task_test_rtc(void *param)
{
    luat_rtos_task_sleep(2000);
    struct tm tblock = {0};
    luat_rtc_get(&tblock);
    LUAT_DEBUG_PRINT("%04d/%02d/%02d/ %02d:%02d:%02d %02d", tblock.tm_year+1900, tblock.tm_mon+1, tblock.tm_mday, tblock.tm_hour, tblock.tm_min,tblock.tm_sec,tblock.tm_wday);

    tblock.tm_year = 2022-1900; 
    tblock.tm_mon  = 12-1;  
    tblock.tm_mday = 16;  
    tblock.tm_hour = 15;  
    tblock.tm_min  = 41; 
    tblock.tm_sec  = 59; 
    luat_rtc_set(&tblock);
    
    luat_rtos_task_sleep(1000);

    luat_rtc_get(&tblock);
    LUAT_DEBUG_PRINT("%04d/%02d/%02d/ %02d:%02d:%02d %02d", tblock.tm_year+1900, tblock.tm_mon+1, tblock.tm_mday, tblock.tm_hour, tblock.tm_min,tblock.tm_sec,tblock.tm_wday);
    
    luat_rtos_task_delete(rtc_task_handle);
}

static void task_demo_rtc(void)
{
    luat_rtos_task_create(&rtc_task_handle, 1024, 20, "rtc", task_test_rtc, NULL, NULL);
}

INIT_TASK_EXPORT(task_demo_rtc,"1");



