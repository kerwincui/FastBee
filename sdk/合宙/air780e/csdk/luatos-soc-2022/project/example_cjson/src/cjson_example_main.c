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

luat_rtos_task_handle task_handle;

#include "cJSON.h"


#define FILE_LENGTH 520

void test_json_1(char* json_data)
{

	LUAT_DEBUG_PRINT("######## Test 12 ########\n");
	cJSON_Minify(json_data);
	LUAT_DEBUG_PRINT("json data = %s\n", json_data);

	// test 01
	cJSON* root = cJSON_Parse(json_data);
	cJSON* format = cJSON_GetObjectItemCaseSensitive(root, "format");
	cJSON* framerate_item = cJSON_GetObjectItemCaseSensitive(format, "frame rate");
	double framerate = 0;
	if(cJSON_IsNumber(framerate_item)) {
		framerate = framerate_item->valuedouble;
	}

	LUAT_DEBUG_PRINT("######## Test START ########\n");

	// test 02
	cJSON_SetNumberValue(framerate_item, 25);
	char* rendered = cJSON_Print(root);
	
	LUAT_DEBUG_PRINT("######## Test 02 ########\n");
	LUAT_DEBUG_PRINT("json data = %s\n", rendered);

	LUAT_DEBUG_PRINT("######## Test 07 ########\n");
	LUAT_DEBUG_PRINT("root json size = %d\n", cJSON_GetArraySize(root));
	LUAT_DEBUG_PRINT("format json size = %d\n", cJSON_GetArraySize(format));
	
	LUAT_DEBUG_PRINT("######## Test 08 ########\n");
	cJSON *json_item1 = cJSON_GetArrayItem(root, 0);
	cJSON *json_item2 = cJSON_GetArrayItem(root, 1);
	LUAT_DEBUG_PRINT("json_item1 data = %s\n", cJSON_Print(json_item1));
	LUAT_DEBUG_PRINT("json_item2 data = %s\n", cJSON_Print(json_item2));

	LUAT_DEBUG_PRINT("######## Test 09 ########\n");
	cJSON* format1 = cJSON_GetObjectItem(root, "format");
	cJSON* framerate_item1 = cJSON_GetObjectItem(format1, "frame rate");
	LUAT_DEBUG_PRINT("json data = %s\n", cJSON_Print(format1));
	LUAT_DEBUG_PRINT("json data = %s\n", cJSON_Print(framerate_item1));
	
	LUAT_DEBUG_PRINT("######## Test 10 ########\n");
	cJSON_bool isHasItem1 = cJSON_HasObjectItem(root, "format");
	cJSON_bool isHasItem2 = cJSON_HasObjectItem(root, "formai");
	LUAT_DEBUG_PRINT("has format item = %d\n", (int)isHasItem1);
	LUAT_DEBUG_PRINT("has formai item = %d\n", (int)isHasItem2);

	LUAT_DEBUG_PRINT("######## Test 11 ########\n");
	cJSON* cjson_null = cJSON_CreateNull();
	LUAT_DEBUG_PRINT("json data = %s\n", cJSON_Print(cjson_null));
	LUAT_DEBUG_PRINT("json data is null or not = %d\n", (int)cJSON_IsNull(cjson_null));
	cJSON_Delete(cjson_null);

	cJSON* cjson_true = cJSON_CreateTrue();
	LUAT_DEBUG_PRINT("json data = %s\n", cJSON_Print(cjson_true));
	LUAT_DEBUG_PRINT("json data is true or not = %d\n", (int)cJSON_IsTrue(cjson_true));
	cJSON_Delete(cjson_true);

	cJSON* cjson_false = cJSON_CreateFalse();
	LUAT_DEBUG_PRINT("json data = %s\n", cJSON_Print(cjson_false));
	LUAT_DEBUG_PRINT("json data is false or not = %d\n", (int)cJSON_IsFalse(cjson_false));
	cJSON_Delete(cjson_false);


	cJSON_bool bool_type = (cJSON_bool)1;
	cJSON* cjson_bool = cJSON_CreateBool(bool_type);
	LUAT_DEBUG_PRINT("json data = %s\n", cJSON_Print(cjson_bool));
	LUAT_DEBUG_PRINT("json data is bool or not = %d\n", (int)cJSON_IsBool(cjson_bool));
	cJSON_Delete(cjson_bool);

	double number_type = 88;
	cJSON* cjson_number = cJSON_CreateNumber(number_type);
	LUAT_DEBUG_PRINT("json data = %s\n", cJSON_Print(cjson_number));
	LUAT_DEBUG_PRINT("json data is number or not = %d\n", (int)cJSON_IsNumber(cjson_number));
	cJSON_Delete(cjson_number);
		
	char* string_type = "Welcome to luatOS";
	cJSON* cjson_string = cJSON_CreateString(string_type);
	LUAT_DEBUG_PRINT("json data = %s\n", cJSON_Print(cjson_string));
	LUAT_DEBUG_PRINT("json data is string or not = %d\n", (int)cJSON_IsString(cjson_string));
	cJSON_Delete(cjson_string);

	char* raw_type = "Welcome to luatOS raw";
	cJSON* cjson_raw = cJSON_CreateRaw(raw_type);
	LUAT_DEBUG_PRINT("json data = %s\n", cJSON_Print(cjson_raw));
	LUAT_DEBUG_PRINT("json data is raw or not = %d\n", (int)cJSON_IsRaw(cjson_raw));
	cJSON_Delete(cjson_raw);

	cJSON* cjson_array = cJSON_CreateArray();
	LUAT_DEBUG_PRINT("json data = %s\n", cJSON_Print(cjson_array));
	LUAT_DEBUG_PRINT("json data is array or not = %d\n", (int)cJSON_IsArray(cjson_array));
	cJSON_Delete(cjson_array);

	cJSON* cjson_object = cJSON_CreateObject();
	LUAT_DEBUG_PRINT("json data = %s\n", cJSON_Print(cjson_object));
	LUAT_DEBUG_PRINT("json data is object or not = %d\n", (int)cJSON_IsObject(cjson_object));
	cJSON_Delete(cjson_object);

	char* rendered1 = cJSON_Print(root);
	
	LUAT_DEBUG_PRINT("######## Test ########\n");
	LUAT_DEBUG_PRINT("json data = %s\n", rendered1);
	
}

void test_json_2()
{
	cJSON *root;
	cJSON *fmt;
	root = cJSON_CreateObject();
	cJSON_AddItemToObject(root, "name", cJSON_CreateString("Jack (\"Bee\") Nimble"));
	cJSON_AddItemToObject(root, "format", fmt = cJSON_CreateObject());
	cJSON_AddStringToObject(fmt, "type", "rect");
	cJSON_AddNumberToObject(fmt, "width", 1920);
	cJSON_AddNumberToObject(fmt, "height", 1080);
	cJSON_AddFalseToObject(fmt, "interlace");
	cJSON_AddNumberToObject(fmt, "frame rate", 24);
	
	char* result = cJSON_Print(root);
	LUAT_DEBUG_PRINT("######## Test 03 ########\n");
	LUAT_DEBUG_PRINT("json data = %s\n", result);
	
	LUAT_DEBUG_PRINT("######## Test 04 ########\n");
	LUAT_DEBUG_PRINT("json version = %s\n", cJSON_Version());

	LUAT_DEBUG_PRINT("######## Test 05 ########\n");
	LUAT_DEBUG_PRINT("json data = %s\n", cJSON_PrintUnformatted(root));

	LUAT_DEBUG_PRINT("######## Test 12 ########\n");
	cJSON_AddNullToObject(root, "null");
	cJSON_AddTrueToObject(root, "true");
	cJSON_AddFalseToObject(root, "false");
	cJSON_AddBoolToObject(root, "bool", 1);
	cJSON_AddNumberToObject(root, "number", 88);
	cJSON_AddStringToObject(root, "string", "Welcome to luatOS");
	cJSON_AddRawToObject(root, "Raw", "Welcome to luatOS raw");
	LUAT_DEBUG_PRINT("json data = %s\n", cJSON_Print(root));
}


static void demo_init_cjson()
{
	LUAT_DEBUG_PRINT("==================cjson is running==================");
	LUAT_DEBUG_PRINT("The cJSON version: %s", cJSON_Version());

	char json_data[FILE_LENGTH] = "{\"name\": \"Jack Nimble\",\"format\": \
	{\"type\":\"rect\",\"width\":1920,\"height\":1080,\"interlace\": false,\"frame rate\": 24}}";
	
	LUAT_DEBUG_PRINT("json_data = %s\n", json_data);

	char json_test[] = "{\"class\":\"paymsg\",\"data\":{\"sn\":\"30000001\",\"type\":\"alipay\",\"content\":\"1326545647980439\",\"uuid\":\"1b56093bf93f493e904fcbeccbf0a0d0\",\"suffix\":15645548.39}}";
	
	cJSON_Minify(json_test);
	LUAT_DEBUG_PRINT("---- %s", json_test);
	cJSON * a = cJSON_Parse(json_test);
	cJSON_AddLongLongToObject(a, "testlonglong", 1670751410618);
	LUAT_DEBUG_PRINT("---- %s", cJSON_Print(a));


	// test
	test_json_1(json_data);
	test_json_2();
}


static void task(void *param)
{
	luat_rtos_task_sleep(1000);
	demo_init_cjson();

	while(1)
	{
		luat_rtos_task_sleep(1000);
		LUAT_DEBUG_PRINT("==================cjson is done==================");
	}
}


static void task_demoE_init(void)
{
	luat_rtos_task_create(&task_handle, 5*1024, 50, "task", task, NULL, 0);
}


//启动task_demoE_init，启动位置任务1级
INIT_TASK_EXPORT(task_demoE_init, "1");
