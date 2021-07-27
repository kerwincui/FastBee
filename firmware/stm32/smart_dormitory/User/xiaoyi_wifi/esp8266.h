#ifndef __ESP8266_H
#define __ESP8266_H 

#include "main.h"

#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#if defined ( __CC_ARM   )
#pragma anon_unions
#endif

//ESP8266模式选择
typedef enum
{
    STA,
    AP,
    STA_AP  
}ENUM_Net_ModeTypeDef;

//网络传输层协议，枚举类型
typedef enum{
     enumTCP,
     enumUDP,
} ENUM_NetPro_TypeDef;
//连接号，指定为该连接号可以防止其他计算机访问同一端口而发生错误
typedef enum{
    Multiple_ID_0 = 0,
    Multiple_ID_1 = 1,
    Multiple_ID_2 = 2,
    Multiple_ID_3 = 3,
    Multiple_ID_4 = 4,
    Single_ID_0 = 5,
} ENUM_ID_NO_TypeDef;

#define ESP8266_RST_Pin          GPIO_PIN_4    //复位管脚
#define ESP8266_RST_Pin_Port     GPIOA    //复位 

#define ESP8266_CH_PD_Pin     	 GPIO_PIN_5   //使能管脚
#define ESP8266_CH_PD_Pin_Port   GPIOA   //使能端口


#define ESP8266_RST_Pin_SetH     HAL_GPIO_WritePin(ESP8266_RST_Pin_Port, ESP8266_RST_Pin, GPIO_PIN_SET)
#define ESP8266_RST_Pin_SetL     HAL_GPIO_WritePin(ESP8266_RST_Pin_Port, ESP8266_RST_Pin, GPIO_PIN_RESET)


#define ESP8266_CH_PD_Pin_SetH     HAL_GPIO_WritePin(ESP8266_CH_PD_Pin_Port,ESP8266_CH_PD_Pin, GPIO_PIN_SET)
#define ESP8266_CH_PD_Pin_SetL     HAL_GPIO_WritePin(ESP8266_CH_PD_Pin_Port,ESP8266_CH_PD_Pin, GPIO_PIN_RESET)


#define ESP8266_USART(fmt, ...)  USART_printf (fmt, ##__VA_ARGS__)    
#define PC_USART(fmt, ...)       printf(fmt, ##__VA_ARGS__)       //这是串口打印函数，串口1，执行printf后会自动执行fput函数，重定向了printf。



#define RX_BUF_MAX_LEN 1024       //最大字节数
extern struct STRUCT_USART_Fram   //数据帧结构体
{
    uint8_t Data_RX_BUF[RX_BUF_MAX_LEN];
    union 
    {
        __IO uint16_t InfAll;
        struct 
        {
            __IO uint16_t FramLength       :15;                               // 14:0 
            __IO uint16_t FramFinishFlag   :1;                                // 15 
        }InfBit;
    }; 
	
}ESP8266_Fram_Record_Struct;


//初始化和TCP功能函数
void ESP8266_Init(uint32_t bound);
void ESP8266_AT_Test(void);
bool ESP8266_Send_AT_Cmd(char *cmd,char *ack1,char *ack2,uint32_t time);
void ESP8266_Rst(void);
bool ESP8266_Net_Mode_Choose(ENUM_Net_ModeTypeDef enumMode);
bool ESP8266_JoinAP( char * pSSID, char * pPassWord );
bool ESP8266_Enable_MultipleId ( FunctionalState enumEnUnvarnishTx );
bool ESP8266_Link_Server(ENUM_NetPro_TypeDef enumE, char * ip, char * ComNum, ENUM_ID_NO_TypeDef id);
bool ESP8266_SendString(FunctionalState enumEnUnvarnishTx, char * pStr, uint32_t ulStrLength, ENUM_ID_NO_TypeDef ucId );
bool ESP8266_UnvarnishSend ( void );
void ESP8266_ExitUnvarnishSend ( void );
uint8_t ESP8266_Get_LinkStatus ( void );
void USART_printf( char * Data, ... );

//MQTT功能函数
bool ESP8266_MQTTUSERCFG( char * pClient_Id, char * pUserName,char * PassWord);
bool ESP8266_MQTTCONN( char * Ip, int Num);
bool ESP8266_MQTTSUB(char * Topic);
bool ESP8266_MQTTPUB( char * Topic,char *temp);
bool ESP8266_MQTTCLEAN(void);
bool MQTT_SendString(char * pTopic,char *temp2);

#endif

