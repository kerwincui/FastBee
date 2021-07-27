#include "esp8266.h"
#include "usart.h"


struct STRUCT_USART_Fram ESP8266_Fram_Record_Struct= { 0 };  //定义了一个数据帧结构体
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
	ESP8266_Rst();
}

//对ESP8266模块发送AT指令
// cmd 待发送的指令
// ack1,ack2;期待的响应，为NULL表不需响应，两者为或逻辑关系
// time 等待响应时间
//返回1发送成功， 0失败
bool ESP8266_Send_AT_Cmd(char *cmd,char *ack1,char *ack2,uint32_t time)
{ 
    ESP8266_Fram_Record_Struct.InfBit .FramLength = 0; //重新接收新的数据包
    ESP8266_USART("%s\r\n", cmd);
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
        return ( ( bool ) strstr ( ESP8266_Fram_Record_Struct.Data_RX_BUF, ack1 ) || 
                         ( bool ) strstr ( ESP8266_Fram_Record_Struct.Data_RX_BUF, ack2 ) );
    }
    else if( ack1 != 0 )  //strstr(s1,s2);检测s2是否为s1的一部分，是返回该位置，否则返回false，它强制转换为bool类型了
        return ( ( bool ) strstr ( ESP8266_Fram_Record_Struct.Data_RX_BUF, ack1 ) );

    else
        return ( ( bool ) strstr ( ESP8266_Fram_Record_Struct.Data_RX_BUF, ack2 ) );

}


//复位重启
void ESP8266_Rst(void)
{
//    ESP8266_RST_Pin_SetL;
//    delay_ms(500); 
//    ESP8266_RST_Pin_SetH;
	;
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
    return ESP8266_Send_AT_Cmd( cCmd, "OK", NULL, 5000 );
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
        ESP8266_USART ( "%s", pStr );

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
    ESP8266_USART( "+++" );
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
        if ( strstr ( ESP8266_Fram_Record_Struct.Data_RX_BUF, "STATUS:2\r\n" ) )
            return 2;

        else if ( strstr ( ESP8266_Fram_Record_Struct.Data_RX_BUF, "STATUS:3\r\n" ) )
            return 3;

        else if ( strstr ( ESP8266_Fram_Record_Struct.Data_RX_BUF, "STATUS:4\r\n" ) )
            return 4;       

    }

    return 0;
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


void USART_printf ( char * Data, ... )
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

//下面为ESP8266MQTT功能指令

/*
*MQTT配置用户属性
*LinkID 连接ID,目前只支持0
*scheme 连接方式，这里选择MQTT over TCP,这里设置为1
*client_id MQTTclientID 用于标志client身份
*username 用于登录 MQTT 服务器 的 username
*password 用于登录 MQTT 服务器 的 password
*cert_key_ID 证书 ID, 目前支持一套 cert 证书, 参数为 0
*CA_ID 目前支持一套 CA 证书, 参数为 0
*path 资源路径，这里设置为""
*设置成功返回true 反之false
*/
bool ESP8266_MQTTUSERCFG( char * pClient_Id, char * pUserName,char * PassWord)
{
    char cCmd [120];
    sprintf ( cCmd, "AT+MQTTUSERCFG=0,1,\"%s\",\"%s\",\"%s\",0,0,\"\"", pClient_Id,pUserName,PassWord );
    return ESP8266_Send_AT_Cmd( cCmd, "OK", NULL, 500 );
}


/*
*连接指定的MQTT服务器
*LinkID 连接ID,目前只支持0
*IP：MQTT服务器上对应的IP地址
*ComNum MQTT服务器上对应的端口号，一般为1883
*设置成功返回true 反之false
*/
bool ESP8266_MQTTCONN( char * Ip, int  Num)
{
    char cCmd [120];
    sprintf ( cCmd,"AT+MQTTCONN=0,\"%s\",%d,0", Ip,Num);
    return ESP8266_Send_AT_Cmd( cCmd, "OK", NULL, 500 );
}

/*
*订阅指定连接的 MQTT 主题, 可重复多次订阅不同 topic
*LinkID 连接ID,目前只支持0
*Topic 订阅的主题名字，这里设置为Topic
*Qos值：一般为0，这里设置为1
*设置成功返回true 反之false
*/
bool ESP8266_MQTTSUB(char * Topic)
{
    char cCmd [120];
    sprintf ( cCmd, "AT+MQTTSUB=0,\"%s\",1",Topic );
    return ESP8266_Send_AT_Cmd( cCmd, "OK", NULL, 500 );
}


/*
*在LinkID上通过 topic 发布数据 data, 其中 data 为字符串消息
*LinkID 连接ID,目前只支持0
*Topic 订阅的主题名字，这里设置为Topic
*data：字符串信息
*设置成功返回true 反之false
*/
bool ESP8266_MQTTPUB( char * Topic,char *temp)
{
    char cCmd [512];
    sprintf (cCmd, "AT+MQTTPUB=0,\"%s\",\"%s\",0,0", Topic ,temp);
    return ESP8266_Send_AT_Cmd( cCmd, "OK", NULL, 1000 );
}

/*
*关闭 MQTT Client 为 LinkID 的连接, 并释放内部占用的资源
*LinkID 连接ID,目前只支持0
*Topic 订阅的主题名字，这里设置为Topic
*data：字符串信息
*设置成功返回true 反之false
*/
bool ESP8266_MQTTCLEAN(void)
{
    char cCmd [120];
    sprintf ( cCmd, "AT+MQTTCLEAN=0");
    return ESP8266_Send_AT_Cmd( cCmd, "OK", NULL, 500 );
}

//ESP8266发送字符串
//enumEnUnvarnishTx是否使能透传模式
//pStr字符串
//ulStrLength字符串长度
//ucId 连接号
//设置成功返回true， 反之false
bool MQTT_SendString(char * pTopic,char *temp2)
{
	
    bool bRet = false;
    ESP8266_MQTTPUB(pTopic,temp2);
	  delay_ms(1000);
    bRet = true;
    return bRet;
}

