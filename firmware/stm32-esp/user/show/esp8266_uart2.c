#include "esp8266_uart2.h"

//检测应答命令
static uint8_t* ESP8266_CheckCMD(uint8_t *str){
	char *strx = 0;
	if(UART2ReadFlag&0x8000)
	{ 
		UART2ReadBuf[UART2ReadFlag&0x7FFF] = 0;//添加结束符
		strx = strstr((const char*)UART2ReadBuf,(const char*)str);
	}
	return (uint8_t*)strx;
}

//cmd:发送的命令字符串
//ack:期待的应答结果,如果为空,则表示不需要等待应答
//返回值:0,发送成功  1,发送失败       
uint8_t ESP8266_SendCMD(uint8_t *cmd,uint8_t *ack,uint16_t waittime) {
    UART2ReadFlag = 0;
    memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));

	Dev_UART2SendStr(cmd, 0, 0);
	if(ack&&waittime)
	{
		while(--waittime)
		{
			Delay_ms(10);
			if(UART2ReadFlag&0x8000)
			{
				if(ESP8266_CheckCMD(ack))
                {        
                    UART2ReadFlag = 0;                    
                    return 0;  
                }
                else 
                {
                    UART2ReadFlag = 0;                    
                    return 1;
                }
			}
		}
		if(waittime==0) 
        {
            return 1;
        }
	}
	return 1;
}
uint8_t ESP8266_SendStr(char* fmt,...){
    uint8_t  tbuf[300] = {0};
	uint16_t i = 0,j = 0;
    
    va_list ap;
	va_start(ap, fmt);
	vsprintf((char*)tbuf, fmt, ap);
	va_end(ap);
	
    j = strlen((const char*)tbuf);
	
    for( i = 0; i < j; i++)
	{
		while(USART_GetFlagStatus(USART2, USART_FLAG_TC)==RESET){}
        USART_SendData(USART2, tbuf[i]);
	}
	while(USART_GetFlagStatus(USART2, USART_FLAG_TC)==RESET){}
    
    return 0; 
}
uint8_t ESP8266_SendData(uint8_t *tbuf, uint16_t len){
    uint16_t i = 0;
    for( i = 0; i < len; i++)
    {
		while(USART_GetFlagStatus(USART2, USART_FLAG_TC)==RESET){}
        USART_SendData(USART2, tbuf[i]);
    }
	while(USART_GetFlagStatus(USART2, USART_FLAG_TC)==RESET){}
    return 0; 
}
// STA模式下获取本地IP
void ESP8266_GetLocalIP(uint8_t* ipbuf){
	uint8_t *p,*p1;
    
    if(ESP8266_SendCMD( (uint8_t *)"AT+CIFSR\r\n", (uint8_t *)"OK", 50))
    {
        ipbuf[0] = 0;
        return;
    }
	
    p  = ESP8266_CheckCMD((uint8_t *)"\"");
    p1 = (uint8_t *)strstr((const char*)(p+1),"\"");
    *p1=0;
    sprintf((char*)ipbuf,"%s",p+1);
}

//退出透传模式 0,退出成功; 1,退出失败
uint8_t ESP8266_QuitTrans(void){
    while(USART_GetFlagStatus(USART2,USART_FLAG_TC)==RESET){};
    USART_SendData(USART2, '+');
    Delay_ms(15);
    while(USART_GetFlagStatus(USART2,USART_FLAG_TC)==RESET){};
    USART_SendData(USART2, '+');
    Delay_ms(15);        
    while(USART_GetFlagStatus(USART2,USART_FLAG_TC)==RESET){};
    USART_SendData(USART2, '+');    
	Delay_ms(500);					//等待500ms
	return ESP8266_SendCMD((uint8_t *)"AT\r\n",(uint8_t *)"OK",20);//退出透传判断
}

//获取连接状态  0,未连接;1,连接成功.
uint8_t ESP8266_ConstaCheck(void){
	while(ESP8266_SendCMD((uint8_t *)"AT+CIPSTATUS\r\n",(uint8_t *)"OK",50));	
	return 0;
}

uint8_t ESP8266_APInit(char *name, char *password){
    uint8_t Sbuf[60] ={0};
    
    // UART2
    BSP_UART2Init(115200);
	
    Delay_ms(1000); 
    Delay_ms(1000);
    
    while(ESP8266_SendCMD((uint8_t *)"AT\r\n",(uint8_t *)"OK",200))
    {//退出透传
		ESP8266_QuitTrans();
      
        //关闭透传模式        	
        ESP8266_SendCMD((uint8_t *)"AT+CIPMODE=0\r\n",(uint8_t *)"OK",200);
		Delay_ms(1000);
	}
    
    // 关闭回显
    while(ESP8266_SendCMD((uint8_t *)"ATE0\r\n",(uint8_t *)"OK",200));	   
    
    // 设置波特率
    while(ESP8266_SendCMD((uint8_t *)"AT+UART=115200,8,1,0,0\r\n",(uint8_t *)"OK",200));
	
    Delay_ms(10);

    // 设置WIFI AP模式
    while(ESP8266_SendCMD((uint8_t *)"AT+CWMODE=2\r\n",(uint8_t *)"OK",200));
    while(ESP8266_SendCMD((uint8_t *)"AT+RST\r\n",(uint8_t *)"OK",200));	    
    
    // 延时4秒等待重启成功    
    Delay_ms(1000); 
    Delay_ms(1000);
    Delay_ms(1000); 
    Delay_ms(1000);
    
    memset(Sbuf, 0 , sizeof(Sbuf));
    sprintf((char*)Sbuf, "AT+CWSAP=\"%s\",\"%s\",1,4\r\n", name, password);
    while(ESP8266_SendCMD(Sbuf, (uint8_t *)"OK", 1000));
    
    #ifdef TCP_Mode

    #endif     
    #ifdef UDP_Mode
    while(ESP8266_SendCMD((uint8_t *)"AT+CIPMUX=0\r\n",(uint8_t *)"OK",200));       
    while(ESP8266_SendCMD((uint8_t *)"AT+CIPSTART=\"UDP\",\"255.255.255.255\",60156,42254,0\r\n",(uint8_t *)"OK",500));
    while(ESP8266_SendCMD((uint8_t *)"AT+CIPMODE=1\r\n",(uint8_t *)"OK",300));
    while(ESP8266_SendCMD((uint8_t *)"AT+CIPSEND\r\n",(uint8_t *)"OK",200));
    #endif    

    UART2ReadFlag = 0;
    memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf)); 
    return 0;
}
uint8_t ESP8266_STAConnect(char *name, char *password){
    uint8_t Sbuf[60] ={0};
   
    memset(Sbuf, 0 , sizeof(Sbuf));
    sprintf((char*)Sbuf,"AT+CWJAP=\"%s\",\"%s\"\r\n", name, password);   
	if(ESP8266_SendCMD( Sbuf, (uint8_t *)"WIFI GOT IP", 100)){
		return 1;
	}
	else 
    { 
        #ifdef MQTT_AT 
        
        #elif  MQTT_SCode 
        
        #elif TCP_Mode
            while(ESP8266_SendCMD((uint8_t *)"AT+CIPMUX=0\r\n",(uint8_t *)"OK",200));
            while(ESP8266_SendCMD((uint8_t *)"AT+CIPSTART=\"TCP\",\"192.168.0.102\",8086\r\n",(uint8_t *)"OK",200)); 
            while(ESP8266_SendCMD((uint8_t *)"AT+CIPMODE=1\r\n",(uint8_t *)"OK",200));
            while(ESP8266_SendCMD((uint8_t *)"AT+CIPSEND\r\n",(uint8_t *)"OK",20));
        #elif UDP_Mode
            while(ESP8266_SendCMD((uint8_t *)"AT+CIPMUX=0\r\n",(uint8_t *)"OK",200));
            while(ESP8266_SendCMD((uint8_t *)"AT+CIPSTART=\"UDP\",\"192.168.1.6\",8086,8086,0\r\n",(uint8_t *)"OK",200)); 
            while(ESP8266_SendCMD((uint8_t *)"AT+CIPMODE=1\r\n",(uint8_t *)"OK",200));
            while(ESP8266_SendCMD((uint8_t *)"AT+CIPSEND\r\n",(uint8_t *)"OK",20));
        #endif
        
        UART2ReadFlag = 0;
        memset((void *)UART2ReadBuf, 0, sizeof(UART2ReadBuf));  
        return 0;
    }
}
uint8_t ESP8266_STAInit(void){
    // 初始化串口
	BSP_UART2Init(115200);
	
    // 延时2秒等待串口初始化完成 
	Delay_ms(1000);
    Delay_ms(1000);
    while(ESP8266_SendCMD((uint8_t *)"AT\r\n",(uint8_t *)"OK",200))
    {
        //退出透传
		ESP8266_QuitTrans();
        
        //关闭透传模式        
		ESP8266_SendCMD((uint8_t *)"AT+CIPMODE=0\r\n",(uint8_t *)"OK",200);
		Delay_ms(800);
	}
    // 关闭回显
    while(ESP8266_SendCMD((uint8_t *)"ATE0\r\n",(uint8_t *)"OK",200));	   
    
    // 设置波特率
    while(ESP8266_SendCMD((uint8_t *)"AT+UART=115200,8,1,0,0\r\n",(uint8_t *)"OK",200));

	Delay_ms(10);
    
    // 设置WIFI STA模式
    while(ESP8266_SendCMD((uint8_t *)"AT+CWMODE=1\r\n",(uint8_t *)"OK",200));
    while(ESP8266_SendCMD((uint8_t *)"AT+RST\r\n",(uint8_t *)"OK",200));	 

    Delay_ms(1000);
    Delay_ms(1000);
    Delay_ms(1000);
    
    return 1;  
}



















