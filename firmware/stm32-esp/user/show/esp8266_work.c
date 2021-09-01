#include "esp8266_work.h"
          
/****************************
    配网流程
    1、将无线设备初始化为AP模式，默认设置为
    2、
       // 配置 MQTT 用户属性
       // AT+MQTTUSERCFG=0,1,"8bf209cd00704760b7a60b2f71be9d8c","test","123456",0,0,""\r\n
       // 配置 MQTT 连接属性
       // AT+MQTTCONNCFG=0,120,0,"","",0,0\r\n
       // 连接/查询 MQTT Broker
       // AT+MQTTCONN=0,"106.12.9.213",1883,0\r\n
       // 发布主题
       // {"deviceNum":"7CDFA1049ADA","categoryId":2,"firmwareVersion":"1.0","ownerId":"1"}
       // AT+MQTTPUB=0,"device_info","{"deviceNum":"E8DB84933050","categoryId":1,"firmwareVersion":"1.0","ownerId":"1"}",0,0\r\n
       // 订阅/查询主题
       // AT+MQTTSUB=0,"status/set/E8DB84933050",1\r\n
       // 取消订阅主题
       // AT+MQTTUNSUB=0,"status/set/E8DB84933050"
       // 关闭连接, 释放资源
       // AT+MQTTCLEAN=0
****************************/
static uint8_t  NetWorkFlow = 1;
static uint32_t Nport = 0;
static uint8_t  Nssid[20]     = {0};
static uint8_t  Npassword[20] = {0};

#ifdef MQTT_SCode
MQTTPacket_connectData MQTT_ConnectData = MQTTPacket_connectData_initializer;
char MQTT_ClientId[150] = {0};
char MQTT_Username[65]  = {0};
char MQTT_Password[65]  = {0};
volatile uint16_t MQTT_ReadBufLen = 0;
#endif

int ESP8266_WaitData(unsigned char* buf, int count)
{
	while(1)
	{	
		if(UART2ReadFlag&0x8000)
		{
			memcpy(buf, (void*)&UART2ReadBuf[MQTT_ReadBufLen], count);
			MQTT_ReadBufLen += count;
			return count;
		}
		Delay_ms(10);
	}
}
#ifdef MQTT_SCode
uint8_t MQTT_UserSubscribe(char *pSubTopic) {
    uint8_t buf[200] = {0};
    uint32_t buflen = sizeof(buf);
    int32_t msgid = 1;
    int32_t req_qos = 0;  // 服务质量

    MQTTString topicString = MQTTString_initializer;
    topicString.cstring    = pSubTopic;
    
	// 订阅格式化
    MQTTSerialize_subscribe(buf, buflen, 0, msgid, 1, &topicString, &req_qos);
	
    // 发送订阅
    UART2ReadFlag = 0;
    ESP8266_SendStr((char *)buf);
    if (MQTTPacket_read(buf, buflen, ESP8266_WaitData)==SUBACK) /* wait for suback */
    {
        unsigned short submsgid;
        int subcount;
        int granted_qos;

        MQTTDeserialize_suback(&submsgid, 1, &subcount, &granted_qos, buf, buflen);
        if (granted_qos != 0)
        {
            //Sys_SendLog("granted qos != 0, %d\n", granted_qos);
            return 0;
        }
        else
        {
            //Sys_SendLog("granted qos = 0\n");
            return 1;
        }
    }
    else
	{
        //Sys_SendLog("no suback received!\r\n");
        return 0;
	}
}
#endif
#ifdef MQTT_SCode
// MQTT_Publish("/mqtt/topic/0", "hello0");
void MQTT_UserPublish(char *pPubTopic, char *payload, int payloadlen) {
    uint8_t buf[400] = {0};
    int buflen = sizeof(buf);
    MQTTString topicString = MQTTString_initializer;
    int len = 0;

    topicString.cstring = pPubTopic;
    len += MQTTSerialize_publish((unsigned char *)(buf + len), buflen - len, 0, 0, 0, 0, topicString, (unsigned char *)payload, payloadlen);
	ESP8266_SendStr((char *)buf);
}
#endif
uint8_t buf[400] = {0};
int buflen = 0;
void ESP8266_NetWorkFlow(void) 
{
    // 第一步，初始化为AP
    if(NetWorkFlow == 1)    {
        ESP8266_APInit("XiaoYi_IOT_AirBox", "asdqwe9867");
        NetWorkFlow = 2;
    }
    // 第二步，持续发送UDP广播
    else if(NetWorkFlow == 2)    {
        if(DevParam.ESP8266SendTime >= 2000)
        {
            ESP8266_SendStr("{\"code\":\"0\",\"msg\":\"start connect\"}");
            DevParam.ESP8266SendTime = 0;
        }   
    }
    // 第三步，返回接受成功信息
    else if(NetWorkFlow == 3)    {
        ESP8266_SendStr("{\"code\":\"1\",\"msg\":\"getWifiInfo:success\"}");
        NetWorkFlow = 4;
    }
    // 第四步，连接家庭无线
    else if(NetWorkFlow == 4)    {
        ESP8266_STAInit();
        while(ESP8266_STAConnect((char *)Nssid, (char *)Npassword));
        NetWorkFlow = 5;
    }
    else if(NetWorkFlow == 5)    {
        #ifdef MQTT_SCode
//        MQTT_ConnectData.MQTTVersion       = 4;					   // 3.1.1
//        MQTT_ConnectData.keepAliveInterval = 60;                   // 设置心跳包间隔时间
//        MQTT_ConnectData.clientID.cstring  = (char *)MQTT_ClientId;// 客户端ID
//        MQTT_ConnectData.username.cstring  = (char *)MQTT_Username;// 用户名
//        MQTT_ConnectData.password.cstring  = (char *)MQTT_Password;// 密码
//        MQTT_ConnectData.cleansession = 0;					       // 清除会话
        
        //rc = aiotMqttSign(product_key, device_name, device_secret, \
        //MQTT_ConnectData.clientID.cstring, MQTT_ConnectData.username.cstring, MQTT_ConnectData.password.cstring);
        //if (rc  < 0) {
            //Sys_SendLog("aiotMqttSign -%0x4x\n", -rc);
            //return -1;
        //}
        
        // 网络连接
        //char *host = "a1ykSq0uPgd.iot-as-mqtt.cn-shanghai.aliyuncs.com";
        //int port = 1883;
        //transport_open( host, port);
        
        // 发送 登录数据
        // 将连接字符串格式化一下，现在还没有发送
//        memset(buf, 0 ,sizeof(buf));
//        buflen = sizeof(buf);	
//        
//        MQTTSerialize_connect( buf, buflen, &MQTT_ConnectData);
//        UART2ReadFlag = 0;
//        ESP8266_SendStr((char *)buf);
        
        // 等待connack
//        if (MQTTPacket_read(buf, buflen, ESP8266_WaitData) == CONNACK){
//            unsigned char sessionPresent, connack_rc;
//            if (MQTTDeserialize_connack(&sessionPresent, &connack_rc, buf, buflen) != 1 || connack_rc != 0)
//            {
//                //Sys_SendLog("Unable to connect,return code %d\r\n", connack_rc);
//                //return -1;
//            }
//        }
        /*订阅*/
//        MQTT_UserSubscribe("status/set/7CDFA1049ADA"); //更新设备状态
//        MQTT_UserSubscribe("status/get/7CDFA1049ADA"); //获取设备状态 
//        MQTT_UserSubscribe("setting/set/7CDFA1049ADA");//更新设备配置 
//        MQTT_UserSubscribe("setting/get/7CDFA1049ADA");//获取设备配置
        #endif
        /********************************/
        #ifdef MQTT_AT
            
        #endif
        /********************************/
    }
    else if(NetWorkFlow == 10)
    {
        #ifdef MQTT_SCode
//        if(DevParam.ESP8266SendTime >= 2000)
//        {
//            MQTTSerialize_pingreq(buf, buflen);// 发送心跳
//			ESP8266_SendStr((char *)buf);
//            DevParam.ESP8266SendTime = 0;
//        }
        // 发布设备状态
//		else if(DevParam.ESP8266SendTime>=1500){
//			// /a1ykSq0uPgd/qmvH76OCy2FeGp9DDMPx/user/update
//			// 0x00 00000001 0032 0100 001223
//			char txBuf[30] = {0};
//			char txLen     = 0;
//			//txBuf[txLen++] = COMMAND_REPORT;// 属性上报
//			txBuf[txLen++] = 0x00;txBuf[txLen++] = 0x00;txBuf[txLen++] = 0x00;txBuf[txLen++] = 0x01;// ID
//			//txBuf[txLen++] = (uint8_t)(DeviceData.prop_int16 >> 8);txBuf[txLen++] = (uint8_t)(DeviceData.prop_int16 >> 0); // INT16
//			//txBuf[txLen++] = DeviceData.prop_bool;		 // BOOL
//			//txBuf[txLen++] = (uint8_t)(DeviceData.prop_int16 >> 8);txBuf[txLen++] = (uint8_t)(DeviceData.prop_int16 >> 0);// FLOAT

//			MQTT_UserPublish("device_info", txBuf, txLen);
//			DevParam.ESP8266SendTime = 0;
//		}
        #endif        
    }
}

cJSON *root = NULL;
char JsonString[100] = {0};
uint16_t init = 0;
uint16_t i = 0;

uint8_t rbuf[256] = {0};
uint8_t rlen = 0;
void ESP8266_NetReceiveInfor(void) {
    if(UART2ReadFlag&0x8000)
    {
        if(NetWorkFlow == 2)        {
            // {"port":"60156","ssid":"xxx","password":"xxxx"}
            if(UART2ReadBuf[0] == '{')
            {
                for(i = 0;;i++)
                {
                    JsonString[i] = UART2ReadBuf[i];
                    if(UART2ReadBuf[i] == '}')
                    {
                        // 解析数据
                        root = cJSON_Parse((char *)JsonString); 
                        if(root == NULL)
                        {
                            memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));
                            UART3ReadFlag = 0;
                            return;
                        }
                        Nport = cJSON_GetObjectItem(root, "port")->valuedouble;
                        if(Nport==60156)
                        {
                            sprintf((char *)Nssid,    "%s",cJSON_GetObjectItem(root, "ssid")->valuestring);
                            sprintf((char *)Npassword,"%s",cJSON_GetObjectItem(root, "password")->valuestring);
                            // 进入无线第三步
                            NetWorkFlow = 3;
                        }
                        cJSON_Delete(root);                       
                        memset(JsonString, 0, sizeof(JsonString));                     
                        break;
                    }
                }
            } 
        }
        if(NetWorkFlow == 10)
        {
            #ifdef MQTT_SCode
            rlen = UART2ReadFlag&(~(1<<15));
            memcpy(rbuf, (void*)&UART2ReadBuf, rlen);
            memset(UART2ReadBuf, 0, sizeof(UART2ReadBuf));
            UART2ReadFlag = 0; 
            
            if (strstr((char *)rbuf, "CLOSED"))
            {
                
            }
            else
            {
                if (0xD0 == *rbuf) 
                {
                    //Sys_SendLog("MQTT Heart Beat \r\n");
                }
                else
                {
//                    strncpy(Topic, (void*)(rbuf+4), rbuf[3]);
//                  printf("Topic: %s\r\n", Topic);
//                  strncpy(message,(void*)(rbuf+4+rbuf[3]),rbuf[1]-rbuf[3]-2);
//                  printf("Message: %s\r\n", message);            
//                  memset(rbuf, 0, sizeof(rbuf));
                }
            }
            #endif            
        }          
    }    
}
















