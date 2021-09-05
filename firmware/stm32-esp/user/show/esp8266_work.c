#include "esp8266_work.h"
          
/*************************************************************
    配网流程
    1、将无线设备初始化为AP模式，默认设置为
    2、AT+CWJAP="CMCC-LI","092413131li"
    // 配置 MQTT 用户属性
    // AT+MQTTUSERCFG=0,1,"8bf209cd00704760b7a60b2f71be9d8c","test","12345678",0,0,""
    // 配置 MQTT 连接属性
    // AT+MQTTCONNCFG=0,120,0,"","",0,0
    // 连接/查询 MQTT Broker
    // AT+MQTTCONN=0,"106.12.9.213",1883,0
    // 发布主题
    // {"deviceNum":"E8DB84933056","categoryId":2,"firmwareVersion":"1.0","ownerId":"1"}
    // AT+MQTTPUB=0,"device_info","{\"deviceNum\":\"E8DB8493312\"\\,\"categoryId\":1\\,\"firmwareVersion\":\"1.0\"\\,\"ownerId\":\"1\"}",0,0
    // AT+MQTTPUB=0,"device_info","{\"deviceNum\":\"E8DB8493312\"\\,\"categoryId\":1\\,\"firmwareVersion\":\"1.0\"\\,\"ownerId\":\"1\"}",0,0\r\n
    // 订阅/查询主题
    // AT+MQTTSUB=0,"status/set/E8DB84933056",0
    // 取消订阅
    // AT+MQTTUNSUB=0,"status/set/E8DB84933050"
    // 关闭连接, 释放资源
    // AT+MQTTCLEAN=0
************************************************************/
uint8_t  NetWorkFlow = 1;

uint8_t  Wssid[20]     = "";
uint8_t  Wpassword[20] = "";

char MQTT_ServerIP[20] = "106.12.9.213";
uint32_t MQTT_ServerPort = 1883;

static char MQTT_DeviceID[20]  = "E8DB84933299";
static char MQTT_ClientID[100] = "user";
static char MQTT_Username[20]  = "test";
static char MQTT_Password[20]  = "123456";

uint8_t PublishData[500] = {0};
int len = 0;
void ESP8266_NetWorkFlow(void)  {
    // 第一步，初始化为AP
    if(NetWorkFlow == 1)    {
        ESP8266_APInit("XiaoYi_IOT_AirBox", "asdqwe9867");
        NetWorkFlow = 2;
    }
    // 第二步，持续发送UDP广播
    else if(NetWorkFlow == 2)    {
        if(DevParam.ESP8266SendTime >= 2000)
        {
            ESP8266_SendStr("{\"code\":0,\"msg\":\"start connect\"}");
            DevParam.ESP8266SendTime = 0;
        }   
    }
    // 第三步，返回接受成功信息
    else if(NetWorkFlow == 3)    {
        ESP8266_SendStr("{\"code\":1,\"msg\":\"getWifiInfo:success\"}");
        NetWorkFlow = 4;
    }
    // 第四步，连接家庭无线
    else if(NetWorkFlow == 4)    {
        ESP8266_STAInit();
        while(ESP8266_STAConnect((char *)Wssid, (char *)Wpassword));
        NetWorkFlow = 5;
    }
    // 第五步，配置MQTT
    else if(NetWorkFlow == 5)    {
        /*********模拟MQTT指令**************/
        #ifdef MQTT_SCode
        MQTT_ConnectData.keepAlive         = 120;         // 心跳包，单位秒
        strcpy( MQTT_ConnectData.clientID, MQTT_ClientID);// 客户端ID
        strcpy( MQTT_ConnectData.username, MQTT_Username);// 用户名
        strcpy( MQTT_ConnectData.password, MQTT_Password);// 密码
        
        /***连接服务器***/
        while(ESP8266_SendCMD((uint8_t *)"AT+CIPMUX=0\r\n",(uint8_t *)"OK",200));
        memset((void *)PublishData, 0, sizeof(PublishData));
        sprintf((char *)PublishData,"AT+CIPSTART=\"TCP\",\"%s\",%d\r\n", MQTT_ServerIP, MQTT_ServerPort);
        while(ESP8266_SendCMD((uint8_t *)PublishData, (uint8_t *)"OK", 500)); 
        while(ESP8266_SendCMD((uint8_t *)"AT+CIPMODE=1\r\n",(uint8_t *)"OK",200));
        while(ESP8266_SendCMD((uint8_t *)"AT+CIPSEND\r\n",(uint8_t *)"OK",200));
    
        /***登录服务器***/
        while(MQTTSCode_Connect()); 
        
        /***订阅服务器对状态设置***/
        memset((void *)PublishData, 0, sizeof(PublishData));
        sprintf((char *)PublishData,"status/set/%s", MQTT_DeviceID);
        while(MQTTSCode_Subscribe((char *)PublishData, 0, 12)); 
        #endif
        /********************************/
        /*********AT指令*****************/
        #ifdef MQTT_AT
        // 1，配置 MQTT 用户属性
        memset((void *)PublishData, 0, sizeof(PublishData));
        sprintf((char *)PublishData,"AT+MQTTUSERCFG=0,1,\"%s\",\"%s\",\"%s\",0,0,\"\"\r\n",\
                                     MQTT_ClientID, MQTT_Username, MQTT_Password);
        while(ESP8266_SendCMD((uint8_t *)PublishData, (uint8_t *)"OK", 500));
        
        // 2，配置 MQTT 连接属性
        memset((void *)PublishData, 0, sizeof(PublishData));
        sprintf((char *)PublishData,"AT+MQTTCONNCFG=0,120,0,\"\",\"\",0,0\r\n");
        while(ESP8266_SendCMD((uint8_t *)PublishData, (uint8_t *)"OK", 500));        
        
        // 3，连接/查询服务器
        //memset((void *)PublishData, 0, sizeof(PublishData));
        //sprintf((char *)PublishData,"AT+MQTTCONN=0,\"%s\",1883,0\r\n",\
        //                             MQTT_ServerIP);
        //while(ESP8266_SendCMD((uint8_t *)"AT+MQTTCONN?\r\n", (uint8_t *)"OK", 500)); 
        while(ESP8266_SendCMD((uint8_t *)"AT+MQTTCONN=0,\"106.12.9.213\",1883,0\r\n", (uint8_t *)"OK", 300)); 
        
        // 4，发布注册设备信息Publish
        //memset((void *)PublishData, 0, sizeof(PublishData));
        //sprintf((char *)PublishData,"AT+MQTTPUB=0,\"%s\",\"{\\\"deviceNum\\\":\\\"%s\\\"\\,\\\"categoryId\\\":1\\,\\\"firmwareVersion\\\":\\\"1.0\\\"\\,\\\"ownerId\\\":\\\"1\\\"}\",0,0\r\n",\
        //                                                    "device_info" ,MQTT_DeviceID);
        //while(ESP8266_SendCMD(PublishData, (uint8_t *)"OK", 500));

        // 发布设备上线(设备状态)
        memset((void *)PublishData, 0, sizeof(PublishData));
        sprintf((char *)PublishData,"AT+MQTTPUB=0,\"%s\",\"{\\\"deviceNum\\\":\\\"%s\\\"\\,\\\"isOnline\\\":1\\,\\\"rssi\\\":-73\\,\\\"airTemperature\\\":%d\\,\\\"remark\\\":\\\"\\\"}\",0,0\r\n",\
                                    "status" ,MQTT_DeviceID, DevParam.BatSOC);
        while(ESP8266_SendCMD(PublishData, (uint8_t *)"OK", 500));
        
        // 发布设备遗嘱
//        memset((void *)PublishData, 0, sizeof(PublishData));
//        sprintf((char *)PublishData,"AT+MQTTPUB=0,\"offline\",\"{\\\"deviceNum\\\":\\\"%s\\\"\\,\\\"isOnline\\\":0\\,\\\"remark\\\":\\\"\\\"}\",0,0\r\n",\
//             MQTT_DeviceID);
//        while(ESP8266_SendCMD(PublishData, (uint8_t *)"OK", 500));
        
        // 发布设备配置
        memset((void *)PublishData, 0, sizeof(PublishData));
        sprintf((char *)PublishData,"AT+MQTTPUB=0,\"status\",\"{\\\"deviceNum\\\":\\\"%s\\\"\\,\\\"isReset\\\":0\\,\\\"remark\\\":\\\"\\\"}\",0,0\r\n",\
                             MQTT_DeviceID);
        while(ESP8266_SendCMD(PublishData, (uint8_t *)"OK", 500));
     
        // 5，订阅
//        // 更新设备设置状态
//        memset((void *)PublishData, 0, sizeof(PublishData));
//        sprintf((char *)PublishData,"AT+MQTTSUB=0,\"status\\\/set\\\/%s\", MQTT_DeviceID);
//        while(ESP8266_SendCMD((uint8_t *)PublishData, (uint8_t *)"OK", 500));
        // 订阅获取设备状态
        memset((void *)PublishData, 0, sizeof(PublishData));
        sprintf((char *)PublishData,"AT+MQTTSUB=0,\"status\\/set\\/%s\",0\r\n", MQTT_DeviceID);
        while(ESP8266_SendCMD((uint8_t *)PublishData, (uint8_t *)"OK", 500));
//        // 更新设备配置
//        memset((void *)PublishData, 0, sizeof(PublishData));
//        sprintf((char *)PublishData,"AT+MQTTSUB=0,\"setting/set/%s\",\"\",0,0\r\n", MQTT_DeviceID);
//        while(ESP8266_SendCMD((uint8_t *)PublishData, (uint8_t *)"OK", 500));
//        // 获取设备配置
//        memset((void *)PublishData, 0, sizeof(PublishData));
//        sprintf((char *)PublishData,"AT+MQTTSUB=0,\"setting/get/%s\",\"\",0,0\r\n", MQTT_DeviceID);
//        while(ESP8266_SendCMD((uint8_t *)PublishData, (uint8_t *)"OK", 200));   
        #endif
        NetWorkFlow = 10;
        /********************************/
    }
    // 第十步，发布消息
    else if(NetWorkFlow == 10)    {
        /********************************/
        #ifdef MQTT_SCode
        if(DevParam.MQTTSendTime >= 2000)
        {
            // 定时发布设备状态
            memset((void *)PublishData, 0, sizeof(PublishData));
            len = sprintf((char *)PublishData,"{\"deviceNum\":\"%s\",\"isOnline\":1,\"airTemperature\":%d,\"remark\":\"\"}",\
                MQTT_DeviceID, DevParam.tes);
            if(len > 0)
            {
                while(MQTTSCode_Publish("status", (char *)PublishData, len, 0, 1, 10));
                memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));
            }
            DevParam.MQTTSendTime = 0;
        }
        #endif
        /********************************/
        /********************************/        
        #ifdef MQTT_AT
        if(DevParam.MQTTSendTime >= 5000)
        {
            // 定时发布设备状态
            memset((void *)PublishData, 0, sizeof(PublishData));
            sprintf((char *)PublishData,"AT+MQTTPUB=0,\"%s\",\"{\\\"deviceNum\\\":\\\"%s\\\"\\,\\\"isOnline\\\":1\\,\\\"rssi\\\":-73\\,\\\"airTemperature\\\":%d\\,\\\"remark\\\":\\\"\\\"}\",0,0\r\n",\
                                    "status" ,MQTT_DeviceID, DevParam.BatSOC);
            while(ESP8266_SendCMD(PublishData, (uint8_t *)"OK", 500));
            memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));
            DevParam.MQTTSendTime = 0;
        }
        #endif
        /********************************/        
    }
}
char mystrstr(char *haystack, char *needle) {
    uint16_t i = 0,j = 0;
    for(i = 0;;i++)
    {
        if(haystack[i]==needle[0])
        {
            for(j = 0;;j++)
            {
                if(haystack[i+j]==needle[j])
                {
                    if(needle[j+1] == '\0')
                        return 1;
                }
                else  
                    break;
            }
        }
        if((haystack[i]=='\r') && (haystack[i+1]=='\n'))
        {
            return 0;
        }        
    }
}
cJSON *root = NULL;
char JsonString[500] = {0};
uint16_t i = 0,j = 0,slen = 0;
void ESP8266_NetReceiveInfor(void) {
    if(UART2ReadFlag&0x8000)
    {
        // 配网解析
        if(NetWorkFlow == 2)        {
            // {"port":60156,"ssid":"xxx","password":"xxxx"}
            if(UART2ReadBuf[0] == '{')            {
                memset(JsonString, 0, sizeof(JsonString));
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
//                        Nport = cJSON_GetObjectItem(root, "port")->valuedouble;
//                        if(Nport==60156)
//                        {
                            sprintf((char *)Wssid,    "%s",cJSON_GetObjectItem(root, "ssid")->valuestring);
                            sprintf((char *)Wpassword,"%s",cJSON_GetObjectItem(root, "password")->valuestring);
                            // 进入无线第三步
                            NetWorkFlow = 3;
//                        }
                        cJSON_Delete(root);                                          
                        break;
                    }
                }
            } 
        }
        // 服务器解析
        if(NetWorkFlow == 10)       {
            #ifdef MQTT_SCode            
            slen = UART2ReadFlag&(~(1 << 15));
            UART2ReadBuf[slen]   = 0x0D;
            UART2ReadBuf[slen+1] = 0x0A;
            /**********设置状态*********/
            memset((void *)PublishData, 0, sizeof(PublishData));
            sprintf((char *)PublishData,"status/set/%s", MQTT_DeviceID);
            if(mystrstr((char *)UART2ReadBuf, (char *)PublishData)==1)   {
                memset(JsonString, 0, sizeof(JsonString));
                for(i = 0;;i++)
                {
                    if(UART2ReadBuf[i]=='{')
                    {
                        for(j = 0;;j++)
                        {
                            JsonString[j] = UART2ReadBuf[j+i];
                            if( (UART2ReadBuf[j+i]=='}') && (UART2ReadBuf[j+i+1]==0x0D) && (UART2ReadBuf[j+i+2]==0x0A))
                            {
                                // 解析数据
                                root = cJSON_Parse((char *)JsonString); 
                                if(root == NULL)
                                {
                                    memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));
                                    UART3ReadFlag = 0;
                                    return;
                                }
                                
                                DevParam.ServerRelay= cJSON_GetObjectItem(root, "relayStatus")->valuedouble;
                                DevParam.ServerRed  = cJSON_GetObjectItem(root, "red")->valuedouble;
                                
                                cJSON_Delete(root);                       
                                memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));
                                UART3ReadFlag = 0;                     
                                return;
                            }   
                        }
                    }
                } 
            }            
            #endif  
            #ifdef MQTT_AT
            // 首先判断
            if(strstr((const char*)UART2ReadBuf,(const char*)"+MQTTSUBRECV"))            {
                memset((void *)PublishData, 0, sizeof(PublishData));
                sprintf((char *)PublishData,"status/set/%s", MQTT_DeviceID);
                if(strstr((const char*)UART2ReadBuf,(const char*)PublishData))
                {
                    memset(JsonString, 0, sizeof(JsonString));
                    for(i = 0;;i++)
                    {
                        if(UART2ReadBuf[i]=='{')
                        {
                            for(j = 0;;j++)
                            {
                                JsonString[j] = UART2ReadBuf[j+i];
                                if( (UART2ReadBuf[j+i]=='}') && (UART2ReadBuf[j+i+1]==0x0D) && (UART2ReadBuf[j+i+2]==0x0A))
                                {
                                    // 解析数据
                                    root = cJSON_Parse((char *)JsonString); 
                                    if(root == NULL)
                                    {
                                        memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));
                                        UART3ReadFlag = 0;
                                        return;
                                    }
                                    
                                    DevParam.ServerRelay= cJSON_GetObjectItem(root, "relayStatus")->valuedouble;
                                    DevParam.ServerRed  = cJSON_GetObjectItem(root, "red")->valuedouble;
                                    
                                    cJSON_Delete(root);                       
                                    memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));
                                    UART3ReadFlag = 0;                     
                                    return;
                                }   
                            }
                        }
                    } 
                }
            }           
            #endif
        }
        memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));
        UART2ReadFlag = 0;        
    }    
}
















