#include "mqtt.h"

/* 数据采用大端模式，高字节先发
    UTF-8 "长度 + 字符串"
    
    控制报文包含:固定包头+可变包头+有效负载
    固定包头 byte1（报文类型（bit7-4）+类型标识（bit3-0）） + byte2（剩余长度，包含可变包头和有效负载长度，最大128字节）
    两个字节的计算方式：
    两个字节的计算方式：剩余长度=(Byte1-128)+Byte2*128     
*/
/***计算剩余字节数***/
uint8_t by[4] = {0};
uint8_t MQTTSCode_CalcSurplusByte(uint32_t str){
    uint8_t i = 0;
    do 
    {
        by[i] = str%128;
        str   = str/128;
        if(str > 0)
        {
            by[i] = by[i] | 128;
            i++;
        }
    } while(str > 0);
    return i;
}

MQTT_ConnectData_t MQTT_ConnectData;
static uint8_t   StringData[500] = {0};
static uint8_t   StringLen = 0;
static uint16_t  waittime = 200;
static uint16_t  NewSite = 0;  
// 连接服务器
uint8_t MQTTSCode_Connect(void) {
    waittime = 500;
    
    memset((void *)StringData, 0, sizeof(StringData));
    
    /*固定包头*/
    StringData[0] = (uint8_t)(CONNECT<<4) + 0;// 固定帧头
    StringData[1] = 0x00;// 剩余长度值
    /***可变包头***/
    // 协议名
    StringData[2] = 0x00;
    StringData[3] = 0x04;
    StringData[4] = 'M';
    StringData[5] = 'Q';
    StringData[6] = 'T';
    StringData[7] = 'T';
    
    // 协议版本V3.1.1
    StringData[8] = 0x04;
    
    /* 连接标识 使能用户名和密码校验，不使用遗嘱，不保留会话
     * 1bit 清理会话
     * 2bit 遗嘱标识
     * 3bit 遗嘱QoS
     * 4bit 遗嘱QoS
     * 5bit 遗嘱保留
     * 6bit 用户名标识
     * 7bit 密码标识
     */
    StringData[9] = 0xC2;

    // 保活时间 
    StringData[10] = (uint8_t)(MQTT_ConnectData.keepAlive>>8);
    StringData[11] = (uint8_t)(MQTT_ConnectData.keepAlive>>0);
    
    // 客户端ID
    NewSite = 12;
    StringLen = strlen((const char*)MQTT_ConnectData.clientID); 
    StringData[NewSite]   = (uint8_t)(StringLen>>8);
    StringData[NewSite+1] = (uint8_t)(StringLen>>0);
    memcpy( &StringData[NewSite+2], MQTT_ConnectData.clientID, StringLen);
    NewSite = NewSite + 2 + StringLen;
    
    // 用户名
    StringLen = strlen((const char*)MQTT_ConnectData.username);
    StringData[NewSite]  = (uint8_t)(StringLen>>8);
    StringData[NewSite+1]= (uint8_t)(StringLen>>0);
    memcpy( &StringData[NewSite+2], MQTT_ConnectData.username, StringLen);    
    NewSite = NewSite + 2 + StringLen;
    
    // 密码
    StringLen = strlen((const char*)MQTT_ConnectData.password); 
    StringData[NewSite]   = (uint8_t)(StringLen>>8);
    StringData[NewSite+1] = (uint8_t)(StringLen>>0);
    memcpy( &StringData[NewSite+2], MQTT_ConnectData.password, StringLen);
    NewSite = NewSite + 2 + StringLen;
    
    // 剩余长度
    if(NewSite < 127)
        StringData[1] = NewSite - 2;
    else
        return 1; 
    
    UART2ReadFlag = 0;
    memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));
    
    Dev_UART2SendStr(StringData, NewSite, 0);
    
    // 等待回应
	if(waittime)	{
		while(--waittime)
		{
			Delay_ms(10);
			if(UART2ReadFlag&0x8000)
			{
                if(((UART2ReadBuf[0]>>4)==CONNACK)&&(UART2ReadBuf[1]==2))
                {
                    if(UART2ReadBuf[3]==0){
                        UART2ReadFlag = 0;
                        return 0;                        
                    }
                    else{
                        UART2ReadFlag = 0;
                        while(1);
                    }
                }
			}
		}
		if(waittime==0) 
            return 1;
	}
	return 1;
}
// 订阅 服务质量
uint8_t MQTTSCode_Subscribe(char *topic, uint8_t qos, uint8_t bsf) {
    waittime = 500;
    
    memset((void *)StringData, 0, sizeof(StringData));
    
    /*固定包头*/
    StringData[0] = (uint8_t)(SUBSCRIBE<<4) + (uint8_t)(1<<1);// 固定帧头
    StringData[1] = 0x00;// 剩余长度值
    /*可变包头*/
    // 报文标识符
    NewSite = 2;
    StringData[NewSite]   = (uint8_t)(bsf>>8);
    StringData[NewSite+1] = (uint8_t)(bsf>>0);
    NewSite = NewSite + 2;
    // 有效负载
    // 主题
    StringLen = strlen((const char*)topic); 
    StringData[NewSite]   = (uint8_t)(StringLen>>8);
    StringData[NewSite+1] = (uint8_t)(StringLen>>0);
    memcpy( &StringData[NewSite+2], topic, StringLen);
    NewSite = NewSite + 2 + StringLen;
    // 服务质量
    StringData[NewSite]   = (uint8_t)(qos>>0);
    NewSite = NewSite + 1;
    
    // 剩余长度
    if(NewSite < 127)
        StringData[1] = NewSite - 2;
    else
        return 1; 
    
    UART2ReadFlag = 0;
    memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));
    
    Dev_UART2SendStr(StringData, NewSite, 0);
    
	if(waittime)	{
		while(--waittime)
		{
			Delay_ms(10);
			if(UART2ReadFlag&0x8000)
			{
                if((UART2ReadBuf[0]>>4)==SUBACK)
                {
                    UART2ReadFlag = 0;
                    return 0;                        
                }
			}
		}
		if(waittime==0) 
            return 1;
	}
	return 1;
} 
// 发布，暂定负载小于100字节
// qos 0最多发送一次，1至少分发一次，2只分发一次
uint16_t  wait = 0;
uint16_t  byte1 = 0,byte2 = 0;
uint8_t MQTTSCode_Publish(char *topic, char *payload, uint16_t payloadLen, uint8_t dup, uint8_t qos, uint16_t bsf) {
    waittime = 500;
    
    memset((void *)StringData, 0, sizeof(StringData));
    
    /*固定包头*/
    StringData[0] = (uint8_t)(PUBLISH<<4) + (uint8_t)(dup<<3) + (uint8_t)(qos<<1);// 固定帧头
    StringData[1] = 0x00;// 剩余长度值
    /*可变包头*/
    // 主题名
    NewSite = 2;
    StringLen = strlen((const char*)topic); 
    StringData[NewSite]   = (uint8_t)(StringLen>>8);
    StringData[NewSite+1] = (uint8_t)(StringLen>>0);
    memcpy( &StringData[NewSite+2], topic, StringLen);
    NewSite = NewSite + 2 + StringLen;
    
    // 报文标识符
    if((qos==1) || (qos==2))    {
        StringData[NewSite]   = (uint8_t)(bsf>>8);
        StringData[NewSite+1] = (uint8_t)(bsf>>0);
        NewSite = NewSite + 2;
    }
    // 有效负载
    StringLen = payloadLen;
    if(StringLen > 0)     {        
        memcpy( &StringData[NewSite], payload, StringLen);
        NewSite = NewSite + StringLen;
    }
    // 剩余长度
    byte1 = 0;
    byte2 = 0;
    if(NewSite <= 129)    {
        StringData[1] = NewSite - 2;
    }
    else    
    {
        wait  = NewSite - 2;
        byte1 = wait%128;
        wait  = wait/128;
        if(wait > 0)
        {
            byte1 = byte1 | 128;
            byte2 = wait%128;
            StringData[1] = byte1;
        }
    }
    UART2ReadFlag = 0;
    memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));
    Dev_UART2SendStr(StringData, NewSite, byte2);
    
    // 没有回复消息
    if((qos==1)||(qos==2))    {
        if(waittime)	{
            while(--waittime)
            {
                Delay_ms(10);
                if(UART2ReadFlag&0x8000)
                {                
                    if(((UART2ReadBuf[0]>>4)==PUBACK)&&(UART2ReadBuf[1]==2)&&(qos==1))
                    {
                        UART2ReadFlag = 0;
                        return 0;                        
                    }
//                  if(((UART2ReadBuf[0]>>4)==PUBREC)&&(UART2ReadBuf[1]==2)&&(qos==2))
//                  {
//                      UART2ReadFlag = 0;
//                      return 0;                        
//                  }
                }
            }
        }
		if(waittime==0) 
            return 1;        
    }
    else
    {
        return 0;
    }
	return 1;
}
// 心跳 服务质量
uint8_t MQTTSCode_KeepAlive(void) {
    waittime = 500;
    
    memset((void *)StringData, 0, sizeof(StringData));
    
    /*固定包头*/
    StringData[0] = (uint8_t)(PINGREQ<<4) + 0;// 固定帧头
    StringData[1] = 0x00;

    NewSite = 2;
    
    // 剩余长度
    if(NewSite < 127)
        StringData[1] = NewSite - 2;
    else
        return 1; 
    
    UART2ReadFlag = 0;
    memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));
    
    Dev_UART2SendStr(StringData, NewSite, 0);
    
	if(waittime)	{
		while(--waittime)
		{
			Delay_ms(10);
			if(UART2ReadFlag&0x8000)
			{
                if((UART2ReadBuf[0]>>4)==PINGRESP)
                {
                    UART2ReadFlag = 0;
                    return 0;                        
                }
			}
		}
		if(waittime==0) 
            return 1;
	}
	return 1;
} 
// 断开连接
uint8_t MQTTSCode_DisConnect(void) {
    
    memset((void *)StringData, 0, sizeof(StringData));
    
    /*固定包头*/
    StringData[0] = (uint8_t)(DISCONNECT<<4) + 0;// 固定帧头
    StringData[1] = 0x00; // 剩余长度值

    NewSite = 2;

    // 剩余长度
    if(NewSite < 127)
        StringData[1] = NewSite - 2;
    else
        return 1; 
    
    UART2ReadFlag = 0;
    memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));
    
    Dev_UART2SendStr(StringData, NewSite, 0);
    
    // 断开网络连接
    
	return 0;
} 
