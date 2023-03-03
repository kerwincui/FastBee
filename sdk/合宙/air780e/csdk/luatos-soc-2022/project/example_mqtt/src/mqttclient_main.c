/*luat_debug_print
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
#include "luat_mobile.h"
#include "luat_debug.h"
#include "MQTTClient.h"

#define MQTT_DEMO_SSL 		0

#if (MQTT_DEMO_SSL == 1)
#define MQTT_HOST    	"airtest.openluat.com"   				// MQTTS服务器的地址和端口号
#define MQTT_PORT		8883
#define CLIENT_ID    	"123456789"          
#define USERNAME    	"user"                 
#define PASSWORD    	"password"   
#else
#define MQTT_HOST    	"lbsmqtt.airm2m.com"   				// MQTT服务器的地址和端口号
#define MQTT_PORT		1884
#define CLIENT_ID    	"123456789"          
#define USERNAME    	"username"                 
#define PASSWORD    	"password"   
#endif

#define MQTT_SEND_BUFF_LEN       (1024)
#define MQTT_RECV_BUFF_LEN       (1024)

static char mqtt_sub_topic[] = "test_topic";
static char mqtt_pub_topic[] = "test_topic";
static char mqtt_send_payload[] = "hello mqtt_test!!!";

uint8_t g_s_is_link_up = 0;

#if (MQTT_DEMO_SSL == 1)
static const char *testCaCrt = \
{
    \
    "-----BEGIN CERTIFICATE-----\r\n"
    "MIIDUTCCAjmgAwIBAgIJAPPYCjTmxdt/MA0GCSqGSIb3DQEBCwUAMD8xCzAJBgNV\r\n" \
    "BAYTAkNOMREwDwYDVQQIDAhoYW5nemhvdTEMMAoGA1UECgwDRU1RMQ8wDQYDVQQD\r\n" \
    "DAZSb290Q0EwHhcNMjAwNTA4MDgwNjUyWhcNMzAwNTA2MDgwNjUyWjA/MQswCQYD\r\n" \
    "VQQGEwJDTjERMA8GA1UECAwIaGFuZ3pob3UxDDAKBgNVBAoMA0VNUTEPMA0GA1UE\r\n" \
    "AwwGUm9vdENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzcgVLex1\r\n" \
    "EZ9ON64EX8v+wcSjzOZpiEOsAOuSXOEN3wb8FKUxCdsGrsJYB7a5VM/Jot25Mod2\r\n" \
    "juS3OBMg6r85k2TWjdxUoUs+HiUB/pP/ARaaW6VntpAEokpij/przWMPgJnBF3Ur\r\n" \
    "MjtbLayH9hGmpQrI5c2vmHQ2reRZnSFbY+2b8SXZ+3lZZgz9+BaQYWdQWfaUWEHZ\r\n" \
    "uDaNiViVO0OT8DRjCuiDp3yYDj3iLWbTA/gDL6Tf5XuHuEwcOQUrd+h0hyIphO8D\r\n" \
    "tsrsHZ14j4AWYLk1CPA6pq1HIUvEl2rANx2lVUNv+nt64K/Mr3RnVQd9s8bK+TXQ\r\n" \
    "KGHd2Lv/PALYuwIDAQABo1AwTjAdBgNVHQ4EFgQUGBmW+iDzxctWAWxmhgdlE8Pj\r\n" \
    "EbQwHwYDVR0jBBgwFoAUGBmW+iDzxctWAWxmhgdlE8PjEbQwDAYDVR0TBAUwAwEB\r\n" \
    "/zANBgkqhkiG9w0BAQsFAAOCAQEAGbhRUjpIred4cFAFJ7bbYD9hKu/yzWPWkMRa\r\n" \
    "ErlCKHmuYsYk+5d16JQhJaFy6MGXfLgo3KV2itl0d+OWNH0U9ULXcglTxy6+njo5\r\n" \
    "CFqdUBPwN1jxhzo9yteDMKF4+AHIxbvCAJa17qcwUKR5MKNvv09C6pvQDJLzid7y\r\n" \
    "E2dkgSuggik3oa0427KvctFf8uhOV94RvEDyqvT5+pgNYZ2Yfga9pD/jjpoHEUlo\r\n" \
    "88IGU8/wJCx3Ds2yc8+oBg/ynxG8f/HmCC1ET6EHHoe2jlo8FpU/SgGtghS1YL30\r\n" \
    "IWxNsPrUP+XsZpBJy/mvOhE5QXo6Y35zDqqj8tI7AGmAWu22jg==\r\n" \
    "-----END CERTIFICATE-----"
};
static const char *testclientCert = \
{
	\
	"-----BEGIN CERTIFICATE-----\r\n"
	"MIIDEzCCAfugAwIBAgIBATANBgkqhkiG9w0BAQsFADA/MQswCQYDVQQGEwJDTjER\r\n"
	"MA8GA1UECAwIaGFuZ3pob3UxDDAKBgNVBAoMA0VNUTEPMA0GA1UEAwwGUm9vdENB\r\n"
	"MB4XDTIwMDUwODA4MDY1N1oXDTMwMDUwNjA4MDY1N1owPzELMAkGA1UEBhMCQ04x\r\n"
	"ETAPBgNVBAgMCGhhbmd6aG91MQwwCgYDVQQKDANFTVExDzANBgNVBAMMBkNsaWVu\r\n"
	"dDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMy4hoksKcZBDbY680u6\r\n"
	"TS25U51nuB1FBcGMlF9B/t057wPOlxF/OcmbxY5MwepS41JDGPgulE1V7fpsXkiW\r\n"
	"1LUimYV/tsqBfymIe0mlY7oORahKji7zKQ2UBIVFhdlvQxunlIDnw6F9popUgyHt\r\n"
	"dMhtlgZK8oqRwHxO5dbfoukYd6J/r+etS5q26sgVkf3C6dt0Td7B25H9qW+f7oLV\r\n"
	"PbcHYCa+i73u9670nrpXsC+Qc7Mygwa2Kq/jwU+ftyLQnOeW07DuzOwsziC/fQZa\r\n"
	"nbxR+8U9FNftgRcC3uP/JMKYUqsiRAuaDokARZxVTV5hUElfpO6z6/NItSDvvh3i\r\n"
	"eikCAwEAAaMaMBgwCQYDVR0TBAIwADALBgNVHQ8EBAMCBeAwDQYJKoZIhvcNAQEL\r\n"
	"BQADggEBABchYxKo0YMma7g1qDswJXsR5s56Czx/I+B41YcpMBMTrRqpUC0nHtLk\r\n"
	"M7/tZp592u/tT8gzEnQjZLKBAhFeZaR3aaKyknLqwiPqJIgg0pgsBGITrAK3Pv4z\r\n"
	"5/YvAJJKgTe5UdeTz6U4lvNEux/4juZ4pmqH4qSFJTOzQS7LmgSmNIdd072rwXBd\r\n"
	"UzcSHzsJgEMb88u/LDLjj1pQ7AtZ4Tta8JZTvcgBFmjB0QUi6fgkHY6oGat/W4kR\r\n"
	"jSRUBlMUbM/drr2PVzRc2dwbFIl3X+ZE6n5Sl3ZwRAC/s92JU6CPMRW02muVu6xl\r\n"
	"goraNgPISnrbpR6KjxLZkVembXzjNNc=\r\n" \
	"-----END CERTIFICATE-----"

};
static const char *testclientPk= \
{
	\
	"-----BEGIN RSA PRIVATE KEY-----\r\n"
	"MIIEpAIBAAKCAQEAzLiGiSwpxkENtjrzS7pNLblTnWe4HUUFwYyUX0H+3TnvA86X\r\n"
	"EX85yZvFjkzB6lLjUkMY+C6UTVXt+mxeSJbUtSKZhX+2yoF/KYh7SaVjug5FqEqO\r\n"
	"LvMpDZQEhUWF2W9DG6eUgOfDoX2milSDIe10yG2WBkryipHAfE7l1t+i6Rh3on+v\r\n"
	"561LmrbqyBWR/cLp23RN3sHbkf2pb5/ugtU9twdgJr6Lve73rvSeulewL5BzszKD\r\n"
	"BrYqr+PBT5+3ItCc55bTsO7M7CzOIL99BlqdvFH7xT0U1+2BFwLe4/8kwphSqyJE\r\n"
 	"C5oOiQBFnFVNXmFQSV+k7rPr80i1IO++HeJ6KQIDAQABAoIBAGWgvPjfuaU3qizq\r\n"
	"uti/FY07USz0zkuJdkANH6LiSjlchzDmn8wJ0pApCjuIE0PV/g9aS8z4opp5q/gD\r\n"
	"UBLM/a8mC/xf2EhTXOMrY7i9p/I3H5FZ4ZehEqIw9sWKK9YzC6dw26HabB2BGOnW\r\n"
	"5nozPSQ6cp2RGzJ7BIkxSZwPzPnVTgy3OAuPOiJytvK+hGLhsNaT+Y9bNDvplVT2\r\n"
	"ZwYTV8GlHZC+4b2wNROILm0O86v96O+Qd8nn3fXjGHbMsAnONBq10bZS16L4fvkH\r\n"
	"5G+W/1PeSXmtZFppdRRDxIW+DWcXK0D48WRliuxcV4eOOxI+a9N2ZJZZiNLQZGwg\r\n"
	"w3A8+mECgYEA8HuJFrlRvdoBe2U/EwUtG74dcyy30L4yEBnN5QscXmEEikhaQCfX\r\n"
	"Wm6EieMcIB/5I5TQmSw0cmBMeZjSXYoFdoI16/X6yMMuATdxpvhOZGdUGXxhAH+x\r\n"
	"xoTUavWZnEqW3fkUU71kT5E2f2i+0zoatFESXHeslJyz85aAYpP92H0CgYEA2e5A\r\n"
	"Yozt5eaA1Gyhd8SeptkEU4xPirNUnVQHStpMWUb1kzTNXrPmNWccQ7JpfpG6DcYl\r\n"
	"zUF6p6mlzY+zkMiyPQjwEJlhiHM2NlL1QS7td0R8ewgsFoyn8WsBI4RejWrEG9td\r\n"
	"EDniuIw+pBFkcWthnTLHwECHdzgquToyTMjrBB0CgYEA28tdGbrZXhcyAZEhHAZA\r\n"
	"Gzog+pKlkpEzeonLKIuGKzCrEKRecIK5jrqyQsCjhS0T7ZRnL4g6i0s+umiV5M5w\r\n"
	"fcc292pEA1h45L3DD6OlKplSQVTv55/OYS4oY3YEJtf5mfm8vWi9lQeY8sxOlQpn\r\n"
	"O+VZTdBHmTC8PGeTAgZXHZUCgYA6Tyv88lYowB7SN2qQgBQu8jvdGtqhcs/99GCr\r\n"
	"H3N0I69LPsKAR0QeH8OJPXBKhDUywESXAaEOwS5yrLNP1tMRz5Vj65YUCzeDG3kx\r\n"
	"gpvY4IMp7ArX0bSRvJ6mYSFnVxy3k174G3TVCfksrtagHioVBGQ7xUg5ltafjrms\r\n"
	"n8l55QKBgQDVzU8tQvBVqY8/1lnw11Vj4fkE/drZHJ5UkdC1eenOfSWhlSLfUJ8j\r\n"
 	"ds7vEWpRPPoVuPZYeR1y78cyxKe1GBx6Wa2lF5c7xjmiu0xbRnrxYeLolce9/ntp\r\n"
	"asClqpnHT8/VJYTD7Kqj0fouTTZf0zkig/y+2XERppd8k+pSKjUCPQ==\r\n" \
  	"-----END RSA PRIVATE KEY-----"

};
#endif

void messageArrived(MessageData* data)
{
	LUAT_DEBUG_PRINT("mqtt Message arrived on topic %.*s: %.*s", data->topicName->lenstring.len, data->topicName->lenstring.data,
		data->message->payloadlen, data->message->payload);
}

static void mqtt_demo(void){
	int rc = 0,count = 0;
	char clientId[16] = {0};
	unsigned char mqttSendbuf[MQTT_SEND_BUFF_LEN] = {0}, mqttReadbuf[MQTT_RECV_BUFF_LEN] = {0};
    static MQTTClient mqttClient;
    static Network n = {0};
    MQTTMessage message;
    MQTTPacket_connectData connectData = MQTTPacket_connectData_initializer;
    connectData.MQTTVersion = 4;
    connectData.username.cstring = USERNAME;
    connectData.password.cstring = PASSWORD;
    connectData.keepAliveInterval = 120;

	rc = luat_mobile_get_imei(0, clientId, sizeof(clientId)-1);
	if(rc <= 0){
		LUAT_DEBUG_PRINT("imei get fail");
		connectData.clientID.cstring = CLIENT_ID;
	}
	else
		connectData.clientID.cstring = clientId;

    //mqtts的话自行配置Network,详情查看Network结构体
#if (MQTT_DEMO_SSL == 1)
	n.isMqtts = TRUE;
	n.caCert=(char*)testCaCrt;
	n.caCertLen=strlen(testCaCrt)+1;
	n.clientCert=(char*)testclientCert;
	n.clientCertLen=strlen(testclientCert)+1;
	n.clientPk=(char*)testclientPk;
	n.clientPkLen=strlen(testclientPk)+1;
	n.timeout_r = 30;
	n.seclevel = 2;
	n.ciphersuite[0] = 0xFFFF;
	n.ignore = 1;
#endif

	NetworkInit(&n);
	MQTTClientInit(&mqttClient, &n, 40000, mqttSendbuf, MQTT_SEND_BUFF_LEN, mqttReadbuf, MQTT_RECV_BUFF_LEN);
	
	LUAT_DEBUG_PRINT("mqtt_connect");

	while(!g_s_is_link_up){
		luat_rtos_task_sleep(1000);
	}

	if ((NetworkConnect(&n, MQTT_HOST, MQTT_PORT)) != 0){
		LUAT_DEBUG_PRINT("NetworkConnect fail");
		mqttClient.keepAliveInterval = connectData.keepAliveInterval;
		mqttClient.ping_outstanding = 1;
		goto error;
	}else{
		if ((MQTTConnect(&mqttClient, &connectData)) != 0){
			mqttClient.ping_outstanding = 1;
			goto error;
		}else{
			LUAT_DEBUG_PRINT("MQTTStartTask");
			#if defined(MQTT_TASK)
				if ((MQTTStartTask(&mqttClient)) != pdPASS){
					goto error;
				}
			#endif
		}
	}

    while(1){
        if ((rc = MQTTSubscribe(&mqttClient, mqtt_sub_topic, 1, messageArrived)) != 0)
            LUAT_DEBUG_PRINT("mqtt Return code from MQTT subscribe error is %d", rc);

		// 如果需要验证设备主动断开mqtt连接并且自动重连的场景，打开while(count++ <= 5){，注释掉while (1){
        // while(count++ <= 5){
		while (1){
            int len = strlen(mqtt_send_payload);
            message.qos = 1;
            message.retained = 0;
            message.payload = mqtt_send_payload;
            message.payloadlen = len;
			if (MQTTIsConnected(&mqttClient)==0){
				goto error;
			}

            LUAT_DEBUG_PRINT("mqtt_demo send data");
            if (rc = MQTTPublish(&mqttClient, mqtt_pub_topic, &message) != 0){
				LUAT_DEBUG_PRINT("MQTTPublish error %d", rc);
				goto error;
			}
            luat_rtos_task_sleep(2000);
        }
		count = 0;
		LUAT_DEBUG_PRINT("MQTTDisconnect");
		MQTTDisconnect(&mqttClient);
error:
		while(!g_s_is_link_up){
			luat_rtos_task_sleep(1000);
		}

		if (rc = MQTTReConnect(&mqttClient, &connectData) != 0){
			luat_rtos_task_sleep(5000);
			LUAT_DEBUG_PRINT("MQTTReConnect %d", rc);
			goto error;
		}
		else
		{
			LUAT_DEBUG_PRINT("MQTTReConnect OK");
		}
    }
}


static void mqttclient_task_init(void)
{
#if (MQTT_DEMO_SSL == 1)
	LUAT_DEBUG_PRINT("This mqtts demo");
#else
	LUAT_DEBUG_PRINT("This mqtt demo");
#endif
	luat_rtos_task_handle mqttclient_task_handle;
	luat_rtos_task_create(&mqttclient_task_handle, 5120, 20, "mqttclient", mqtt_demo, NULL, NULL);
}

static void flymode_demo(void)
{
	luat_rtos_task_sleep(5000);
	LUAT_DEBUG_PRINT("entry");
	while (1)
	{
		luat_rtos_task_sleep(30000);
		LUAT_DEBUG_PRINT("enter flymode");
		luat_mobile_set_flymode(0,1);
		luat_rtos_task_sleep(5000);
		luat_mobile_set_flymode(0,0);
		LUAT_DEBUG_PRINT("exit flymode");
	}	
}

static void flymode_task_init(void)
{
	luat_rtos_task_handle flymode_task_handle;
	luat_rtos_task_create(&flymode_task_handle, 2048, 20, "flymode", flymode_demo, NULL, NULL);
}

static void mobile_event_cb(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status)
{
	switch(event)
	{
	case LUAT_MOBILE_EVENT_CFUN:
		LUAT_DEBUG_PRINT("CFUN消息，status %d", status);
		break;
	case LUAT_MOBILE_EVENT_SIM:
		LUAT_DEBUG_PRINT("SIM卡消息");
		switch(status)
		{
		case LUAT_MOBILE_SIM_READY:
			LUAT_DEBUG_PRINT("SIM卡正常工作");
			break;
		case LUAT_MOBILE_NO_SIM:
			LUAT_DEBUG_PRINT("SIM卡不存在");
			break;
		case LUAT_MOBILE_SIM_NEED_PIN:
			LUAT_DEBUG_PRINT("SIM卡需要输入PIN码");
			break;
		}
		break;
	case LUAT_MOBILE_EVENT_REGISTER_STATUS:
		LUAT_DEBUG_PRINT("移动网络服务状态变更，当前为%d", status);
		break;
	case LUAT_MOBILE_EVENT_CELL_INFO:
		switch(status)
		{
		case LUAT_MOBILE_CELL_INFO_UPDATE:
			break;
		case LUAT_MOBILE_SIGNAL_UPDATE:
			break;
		}
		break;
	case LUAT_MOBILE_EVENT_PDP:
		LUAT_DEBUG_PRINT("CID %d PDP激活状态变更为 %d", index, status);
		break;
	case LUAT_MOBILE_EVENT_NETIF:
		LUAT_DEBUG_PRINT("internet工作状态变更为 %d", status);
		switch (status)
		{
		case LUAT_MOBILE_NETIF_LINK_ON:
			LUAT_DEBUG_PRINT("可以上网");
            g_s_is_link_up = 1;
			break;
		default:
            g_s_is_link_up = 0;
			LUAT_DEBUG_PRINT("不能上网");
			break;
		}
		break;
	case LUAT_MOBILE_EVENT_TIME_SYNC:
		LUAT_DEBUG_PRINT("通过移动网络同步了UTC时间");
		break;
	case LUAT_MOBILE_EVENT_CSCON:
		LUAT_DEBUG_PRINT("RRC状态 %d", status);
		break;
	default:
		break;
	}
}

static void task_init(void){
    luat_mobile_event_register_handler(mobile_event_cb);
}

INIT_HW_EXPORT(task_init, "0");
INIT_TASK_EXPORT(mqttclient_task_init, "1");
// 此task通过不断的进入和退出飞行模式，来模拟断网场景
// 仅用模拟测试使用，有需要可以自行打开
// INIT_TASK_EXPORT(flymode_task_init, "1");

