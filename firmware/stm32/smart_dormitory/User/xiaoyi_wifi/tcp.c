#include "tcp.h"

volatile uint8_t TcpClosedFlag = 0;

void ESP8266_STA_TCPClient_Test(void)
{
    uint8_t res;
	
    char str[100]={0};
    ESP8266_AT_Test();
	printf("正在配置ESP8266\r\n");
    ESP8266_Net_Mode_Choose(STA);
    while(!ESP8266_JoinAP(User_ESP8266_SSID, User_ESP8266_PWD));
    ESP8266_Enable_MultipleId ( DISABLE );
    while(!ESP8266_Link_Server(enumTCP, User_ESP8266_TCPServer_IP, User_ESP8266_TCPServer_PORT, Single_ID_0));
    while(!ESP8266_UnvarnishSend());
		printf("\r\n配置完成");
    while ( 1 )
    {       
			  sprintf (str,"深圳市安信可科技有限公司" );//格式化发送字符串到TCP服务器
        ESP8266_SendString ( ENABLE, str, 0, Single_ID_0 );
        delay_ms(1000);
        if(TcpClosedFlag) //判断是否失去连接
        {
            ESP8266_ExitUnvarnishSend(); //退出透传模式
            do
            {
                res = ESP8266_Get_LinkStatus();     //获取连接状态
            }   
            while(!res);

            if(res == 4)                     //确认失去连接，重连
            {
                
                
                while (!ESP8266_JoinAP(User_ESP8266_SSID, User_ESP8266_PWD ) );
                while (!ESP8266_Link_Server(enumTCP, User_ESP8266_TCPServer_IP, User_ESP8266_TCPServer_PORT, Single_ID_0 ) );        
            } 
            while(!ESP8266_UnvarnishSend());                    
        }
    }   
}
