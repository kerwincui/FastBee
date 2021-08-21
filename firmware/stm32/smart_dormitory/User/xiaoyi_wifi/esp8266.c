#include "esp8266.h"

extern UART_HandleTypeDef huart3;

STRUCT_USART_Fram_t ESP8266_Fram_Record_Struct;

void ESP8266_Init(uint32_t bound)
{
    GPIO_InitTypeDef GPIO_InitStructure;

	__HAL_RCC_GPIOA_CLK_ENABLE();
	
//    GPIO_InitStructure.Pin = ESP8266_RST_Pin;             
//    GPIO_InitStructure.Mode = GPIO_MODE_OUTPUT_PP;     //复用推挽输出
//    GPIO_InitStructure.Speed = GPIO_SPEED_FREQ_HIGH;  
//	HAL_GPIO_Init(GPIOA, &GPIO_InitStructure);
//	
//    GPIO_InitStructure.Pin = ESP8266_CH_PD_Pin;               
//    HAL_GPIO_Init(ESP8266_CH_PD_Pin_Port, &GPIO_InitStructure);
//	
//	ESP8266_Rst();
}

//对ESP8266模块发送AT指令
// cmd 待发送的指令
// ack1,ack2;期待的响应，为NULL表不需响应，两者为或逻辑关系
// time 等待响应时间
//返回1发送成功， 0失败
bool ESP8266_Send_AT_Cmd(char *cmd,char *ack1,char *ack2,uint32_t time)
{ 
    ESP8266_Fram_Record_Struct.InfBit.FramLength = 0; //重新接收新的数据包
	ESP8266_Fram_Record_Struct.InfBit.FramFinishFlag = 0;
	memset(ESP8266_Fram_Record_Struct.Data_RX_BUF, 0x00, sizeof(ESP8266_Fram_Record_Struct.Data_RX_BUF));
	
    hal_AT_printf("%s\r\n", cmd);
    if(ack1==0&&ack2==0)     //不需要接收数据
    {
			return true;
    }
    delay_ms(time);   //延时
		delay_ms(1000);
    ESP8266_Fram_Record_Struct.Data_RX_BUF[ESP8266_Fram_Record_Struct.InfBit.FramLength ] = '\0';
		
    printf("------ %s", ESP8266_Fram_Record_Struct.Data_RX_BUF);
    if(ack1!=0&&ack2!=0)
    {
        return ( ( bool ) strstr ( (char *)ESP8266_Fram_Record_Struct.Data_RX_BUF, ack1 ) || 
                         ( bool ) strstr ( (char *)ESP8266_Fram_Record_Struct.Data_RX_BUF, ack2 ) );
    }
    else if( ack1 != 0 )  //strstr(s1,s2);检测s2是否为s1的一部分，是返回该位置，否则返回false，它强制转换为bool类型了
        return ( ( bool ) strstr ( (char *)ESP8266_Fram_Record_Struct.Data_RX_BUF, ack1 ) );

    else
        return ( ( bool ) strstr ( (char *)ESP8266_Fram_Record_Struct.Data_RX_BUF, ack2 ) );

}

/*-------------------------------------------------*/
/*函数名：WiFi复位                                 */
/*参  数：timeout：超时时间（100ms的倍数）          */
/*返回值：0：正确   其他：错误                      */
/*-------------------------------------------------*/

char ESP8266_Rst(void)
{
	return ESP8266_Send_AT_Cmd ( "AT+RST\r\n", "OK", 0, 5000 );
}

//发送恢复出厂默认设置指令将模块恢复成出厂设置
void ESP8266_AT_Test(void)
{
    char count=0;
    delay_ms(1000); 
    while(count < 10)
    {
        if(ESP8266_Send_AT_Cmd("AT+RESTORE","OK",NULL,500)) 
        {
            printf("OK\r\n");
            return;
        }
        ++ count;
    }
}

//取消回显
void ESP8266_ATE0(void)
{
    char count=0;
    delay_ms(1000); 
    while(count < 10)
    {
        if(ESP8266_Send_AT_Cmd("ATE0","OK",NULL,1000)) 
        {
            printf("ATE0 OK\r\n");
            return;
        }
        ++ count;
    }
}

//选择ESP8266的工作模式
// enumMode 模式类型
//成功返回true，失败返回false
bool ESP8266_Net_Mode_Choose(ENUM_Net_ModeTypeDef enumMode)
{
    switch ( enumMode )
    {
        case STA:
            return ESP8266_Send_AT_Cmd ( "AT+CWMODE=1", "OK", "no change", 2500 ); 

        case AP:
            return ESP8266_Send_AT_Cmd ( "AT+CWMODE=2", "OK", "no change", 2500 ); 

        case STA_AP:
            return ESP8266_Send_AT_Cmd ( "AT+CWMODE=3", "OK", "no change", 2500 ); 

        default:
          return false;
    }       
}

//ESP8266连接外部的WIFI
//pSSID WiFi帐号
//pPassWord WiFi密码
//设置成功返回true 反之false
bool ESP8266_JoinAP( char * pSSID, char * pPassWord)
{
    char cCmd [120];
	
    sprintf ( cCmd, "AT+CWJAP=\"%s\",\"%s\"", pSSID, pPassWord );
    return ESP8266_Send_AT_Cmd( cCmd, "OK", "WIFI CONNECTED", 5000 );
}

//ESP8266 透传使能
//enumEnUnvarnishTx  是否多连接，bool类型
//设置成功返回true，反之false
bool ESP8266_Enable_MultipleId (FunctionalState enumEnUnvarnishTx )
{
    char cStr [20];

    sprintf ( cStr, "AT+CIPMUX=%d", ( enumEnUnvarnishTx ? 1 : 0 ) );

    return ESP8266_Send_AT_Cmd ( cStr, "OK", 0, 500 );

}

//ESP8266 使能自动重连
//enumEnUnvarnishTx  是否多连接，bool类型
//设置成功返回true，反之false
bool ESP8266_Enable_AutoConnect (int enable )
{
    char cStr [20];

    sprintf ( cStr, "AT+CWAUTOCONN=%d", enable );

    return ESP8266_Send_AT_Cmd ( cStr, "OK", 0, 500 );

}

//ESP8266 连接服务器
//enumE  网络类型
//ip ，服务器IP
//ComNum  服务器端口
//id，连接号，确保通信不受外界干扰
//设置成功返回true，反之fasle
bool ESP8266_Link_Server(ENUM_NetPro_TypeDef enumE, char * ip, char * ComNum, ENUM_ID_NO_TypeDef id)
{
    char cStr [100] = { 0 }, cCmd [120];

    switch (  enumE )
    {
        case enumTCP:
          sprintf ( cStr, "\"%s\",\"%s\",%s", "TCP", ip, ComNum );
          break;

        case enumUDP:
          sprintf ( cStr, "\"%s\",\"%s\",%s", "UDP", ip, ComNum );
          break;

        default:
            break;
    }

    if ( id < 5 )
        sprintf ( cCmd, "AT+CIPSTART=%d,%s", id, cStr);

    else
        sprintf ( cCmd, "AT+CIPSTART=%s", cStr );

    return ESP8266_Send_AT_Cmd ( cCmd, "OK", "ALREAY CONNECT", 4000 );

}


//透传使能
//设置成功返回true， 反之false
bool ESP8266_UnvarnishSend ( void )
{
    if (!ESP8266_Send_AT_Cmd ( "AT+CIPMODE=1", "OK", 0, 500 ))
        return false;

    return 
        ESP8266_Send_AT_Cmd( "AT+CIPSEND", "OK", ">", 500 );
}


//ESP8266发送字符串
//enumEnUnvarnishTx是否使能透传模式
//pStr字符串
//ulStrLength字符串长度
//ucId 连接号
//设置成功返回true， 反之false
bool ESP8266_SendString(FunctionalState enumEnUnvarnishTx, char * pStr, uint32_t ulStrLength, ENUM_ID_NO_TypeDef ucId )
{
    char cStr [20];
    bool bRet = false;

    if ( enumEnUnvarnishTx )
    {
        hal_AT_printf ( "%s", pStr );

        bRet = true;
    }
    else
    {
        if ( ucId < 5 )
            sprintf ( cStr, "AT+CIPSEND=%d,%d", ucId, ulStrLength + 2 );

        else
            sprintf ( cStr, "AT+CIPSEND=%d", ulStrLength + 2 );

        ESP8266_Send_AT_Cmd ( cStr, "> ", 0, 1000 );

        bRet = ESP8266_Send_AT_Cmd ( pStr, "SEND OK", 0, 1000 );
    }
    return bRet;
}


//ESP8266退出透传模式
void ESP8266_ExitUnvarnishSend ( void )
{
    delay_ms(1000);
    hal_AT_printf( "+++" );
    delay_ms( 500 );    
}


//ESP8266 检测连接状态
//返回0：获取状态失败
//返回2：获得ip
//返回3：建立连接 
//返回4：失去连接 
uint8_t ESP8266_Get_LinkStatus ( void )
{
    if (ESP8266_Send_AT_Cmd( "AT+CIPSTATUS", "OK", 0, 500 ) )
    {
        if ( strstr ( (char *)ESP8266_Fram_Record_Struct.Data_RX_BUF, "STATUS:2\r\n" ) )
            return 2;
        else if ( strstr ( (char *)ESP8266_Fram_Record_Struct.Data_RX_BUF, "STATUS:3\r\n" ) )
            return 3;
        else if ( strstr ( (char *)ESP8266_Fram_Record_Struct.Data_RX_BUF, "STATUS:4\r\n" ) )
            return 4;       
    }
    return 0;
}



extern char mqtt_tcp_connect(int timeout);

/*-------------------------------------------------*/
/*函数名：WiFi连接服务器                           */
/*参  数：无                                       */
/*返回值：0：正确   其他：错误                     */
/*-------------------------------------------------*/
char WiFi_Connect_IoTServer(void)
{	
//	printf("准备复位模块\r\n");                   //串口提示数据
//	ESP8266_Rst();

	// 取消回显
	ESP8266_ATE0();
	
	printf("ready to set STA mode\r\n");
	// 设置STA模式
	if (ESP8266_Net_Mode_Choose(STA))
	{
		printf("Set STA mode\r\n");
	}

	// 准备关闭多路连接
	if (ESP8266_Enable_MultipleId(DISABLE))
	{
		printf("close multipled ID success\r\n");
	}else
	{
		printf("close multipled ID error\r\n");
	}
	// 取消自动重连
	if(ESP8266_Enable_AutoConnect(0))		 //取消自动连接，100ms超时单位，总计5s超时时间
	{       
		printf("取消自动连接成功\r\n");        //串口提示数据
	}else 
	{
		printf("取消自动连接失败，准备重启\r\n"); //返回非0值，进入if，串口提示数据
		return 3;       
	}
			

	// 连接路由器
	if(ESP8266_JoinAP(User_SSID, User_PWD))
	{
		printf("connect to router success\r\n");
	}else
	{
		printf("connect to router failed\r\n");
		return 9;
	}
	
	// 连接服务器
	if(mqtt_tcp_connect(500))      				 //连接服务器，100ms超时单位，总计10s超时时间
	{            
		printf("connect to server success\r\n");    //返回非0值，进入if，串口提示数据
		                                 //返回10
	}else 
	{
		printf("connect to server failed\r\n");            //串口提示数据	
		return 10;  
	}
	
	// 进入透传模式
	if (ESP8266_UnvarnishSend() )
	{
		printf("go into unvarnishSend mode\r\n");
	}
	return 0;                                        //正确返回0
}


static char *itoa( int value, char *string, int radix )
{
    int     i, d;
    int     flag = 0;
    char    *ptr = string;

    /* This implementation only works for decimal numbers. */
    if (radix != 10)
    {
        *ptr = 0;
        return string;
    }

    if (!value)
    {
        *ptr++ = 0x30;
        *ptr = 0;
        return string;
    }

    /* if this is a negative value insert the minus sign. */
    if (value < 0)
    {
        *ptr++ = '-';

        /* Make the value positive. */
        value *= -1;

    }

    for (i = 10000; i > 0; i /= 10)
    {
        d = value / i;

        if (d || flag)
        {
            *ptr++ = (char)(d + 0x30);
            value -= (d * i);
            flag = 1;
        }
    }

    /* Null terminate the string. */
    *ptr = 0;

    return string;

} /* NCL_Itoa */


void hal_AT_printf ( char * Data, ... )
{
    const char *s;
    int d;   
    char buf[16];
	uint8_t ch = 0;


    va_list ap;
    va_start(ap, Data);

    while ( * Data != 0 )     // 判断数据是否到达结束符
    {                                         
        if ( * Data == 0x5c )  //'\'
        {                                     
            switch ( *++Data )
            {
                case 'r':                                     //回车符
					ch = 0x0d;
					HAL_UART_Transmit(&huart3, (uint8_t *)&ch, 1, 0xFFFF);
					Data ++;
                break;

                case 'n':                                     //换行符
					ch = 0x0a;
					HAL_UART_Transmit(&huart3, (uint8_t *)&ch, 1, 0xFFFF);
					Data ++;
                break;

                default:
                Data ++;
                break;
            }            
        }

        else if ( * Data == '%')
        {                                     
            switch ( *++Data )
            {               
                case 's':                                         //字符串
                s = va_arg(ap, const char *);
                for ( ; *s; s++) 
                {
					HAL_UART_Transmit(&huart3, (uint8_t *)s, 1, 0xFFFF);
					while( __HAL_UART_GET_FLAG(&huart3, UART_FLAG_TXE) == false);
                }
                Data++;
                break;

                case 'd':           
                    //十进制
                d = va_arg(ap, int);
                itoa(d, buf, 10);
                for (s = buf; *s; s++) 
                {
					HAL_UART_Transmit(&huart3, (uint8_t *)s, 1, 0xFFFF);
					while( __HAL_UART_GET_FLAG(&huart3, UART_FLAG_TXE) == false);
                }
                     Data++;
                     break;
                default:
                     Data++;
                     break;
            }        
        } 
        else 
		{
			HAL_UART_Transmit(&huart3, (uint8_t *)Data, 1, 0xFFFF);
			Data++;
			while( __HAL_UART_GET_FLAG(&huart3, UART_FLAG_TXE) == false);
		}
    }
}

 