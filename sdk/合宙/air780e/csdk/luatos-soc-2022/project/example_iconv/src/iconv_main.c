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
#include "luat_mem.h"
#include "luat_debug.h"

#include "iconv.h"
#include "luat_iconv.h"

luat_rtos_task_handle task_handle;


static void demo_init_iconv()
{
	LUAT_DEBUG_PRINT("==================iconv is running==================");

	char input[] = "LuatOS is coming", output[255];
	memset(output, 0, sizeof(output));

	char* inPtr = input;
	char* outPtr = output;
	size_t inlen = strlen(input);
	size_t outlen = sizeof(output);

	LUAT_DEBUG_PRINT("The convert inlen is %d", inlen);
	LUAT_DEBUG_PRINT("The convert outlen is %d", outlen);

	luat_iconv_t cd = luat_iconv_open("utf8", "ucs2");
	int len = luat_iconv_convert(cd, &inPtr, &inlen, &outPtr, &outlen);
	LUAT_DEBUG_PRINT("The convert num is %d", len);
	if (len == 0)
	{
		LUAT_DEBUG_PRINT("The convert before: %s", input);
		LUAT_DEBUG_PRINT("The convert  after: %s", outPtr);
	}
	luat_iconv_close(cd);
}

static void task(void *param)
{
	while(1)
	{
		demo_init_iconv();
		luat_rtos_task_sleep(1000);
		LUAT_DEBUG_PRINT("==================iconv is done==================");
	}
}


static void task_demoE_init(void)
{
	luat_rtos_task_create(&task_handle, 2*1024, 50, "task", task, NULL, 0);
}

//启动task_demoE_init，启动位置任务1级
INIT_TASK_EXPORT(task_demoE_init, "1");
