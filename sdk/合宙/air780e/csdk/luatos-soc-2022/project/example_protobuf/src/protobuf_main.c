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


#include <stdio.h>
#include <errno.h>
#include "common_api.h"
#include "luat_rtos.h"
#include "luat_mem.h"
#include "luat_debug.h"

luat_rtos_task_handle task_handle;

#include "user.pb.h"
#include "pb_encode.h"
#include "pb_decode.h"

#define DATA_BUFFER_SIZE    1024

static int pack_user_data(uint8_t *buffer)
{
    //Initialize the UserInformation structure;
    UserInformation userInfo = UserInformation_init_zero;

    // Initialize buffer
    memset(buffer, 0, DATA_BUFFER_SIZE);

    strcpy(userInfo.name, "LuatOS-Hello");
    userInfo.age = 18; 
    strcpy(userInfo.phone, "0110-12345678");
    userInfo.stat = UserStatus_IDLE;
    strcpy(userInfo.email, "luatcsdk@123.com");

    // encode userInfo data
    pb_ostream_t enc_stream;
	enc_stream = pb_ostream_from_buffer(buffer, DATA_BUFFER_SIZE);
	if (!pb_encode(&enc_stream, UserInformation_fields, &userInfo))
	{
		//encode error happened
		LUAT_DEBUG_PRINT("pb encode error in [%s]\n",PB_GET_ERROR(&enc_stream));
		return -1;
	}

    return enc_stream.bytes_written;
}

static int unpack_user_data(const uint8_t *buffer, size_t len)
{
    UserInformation userInfo;

    // decode userInfo data
	pb_istream_t dec_stream;
	dec_stream = pb_istream_from_buffer(buffer, len);
	if (!pb_decode(&dec_stream, UserInformation_fields, &userInfo))
	{
		LUAT_DEBUG_PRINT("pb decode error");
		return -1;
	}

    LUAT_DEBUG_PRINT("Unpack: name: %s | age: %d | phone: %s | email: %s\n", userInfo.name, userInfo.age, userInfo.phone, userInfo.email);

    return 0;
}


static void demo_init_protobuf()
{
	LUAT_DEBUG_PRINT("==================protobuf is running==================");
    uint8_t buffer[DATA_BUFFER_SIZE];

    int lenght = pack_user_data(buffer);
    if(lenght<0){
        LUAT_DEBUG_PRINT("main: pack_user_data is fail!!!\n");
        return -1;
    }
    LUAT_DEBUG_PRINT("User data len: %d\n",lenght);
    unpack_user_data(buffer, lenght);

}

static void task(void *param)
{
	while(1)
	{
		demo_init_protobuf();
		luat_rtos_task_sleep(1000);
		LUAT_DEBUG_PRINT("==================protobuf is done==================");
	}
}


static void task_demoE_init(void)
{
	luat_rtos_task_create(&task_handle, 2*1024, 50, "task", task, NULL, 0);
}

//启动task_demoE_init，启动位置任务1级
INIT_TASK_EXPORT(task_demoE_init, "1");
