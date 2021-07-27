#include "mqtt.h"

void ESP8266_STA_MQTTClient_Init(void)
{
	char str[] = "{\
			\"deviceNum\": \"E8DB84933089\",\
			\"relayStatus\": 0,\
			\"lightStatus\": 0,\
			\"isOnline\": 1,\
			\"rssi\": -54,\
			\"deviceTemperature\": 40,\
			\"airTemperature\": 0,\
			\"airHumidity\": 0,\
			\"triggerSource\": 0,\
			\"brightness\": 11,\
			\"lightInterval\": 432,\
			\"lightMode\": 0,\
			\"fadeTime\": 259,\
			\"red\": 255,\
			\"green\": 0,\
			\"blue\": 0,\
			\"remark\":{\"door_status\":1, \"light\":60}\
		}";
	printf("正在配置ESP8266参数\r\n");
	// ESP8266_AT_Test();//恢复出厂默认模式
	ESP8266_Net_Mode_Choose(STA);
	while(!ESP8266_JoinAP(User_ESP8266_SSID, User_ESP8266_PWD));
	ESP8266_MQTTUSERCFG(User_ESP8266_client_id,User_ESP8266_username,User_ESP8266_password);
	ESP8266_MQTTCONN( User_ESP8266_MQTTServer_IP, User_ESP8266_MQTTServer_PORT);
	ESP8266_MQTTSUB( User_ESP8266_MQTTServer_Topic_SUB);
	printf("\r\nMQTT配置完成");
	
//	sprintf(str,"{}");//格式化发送字符串到MQTT服务器
	MQTT_SendString (User_ESP8266_MQTTServer_Topic_PUB,str);//发送数据到MQTT服务器
	
//	while(1)
//	{

//		delay_ms(20);
//	}
}

