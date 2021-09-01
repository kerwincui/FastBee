#ifndef _ESP8266_UART2_H_
#define _ESP8266_UART2_H_

#include "stm32f10x.h"

#include "bsp_uart2.h"

#include "stdio.h"
#include "string.h"
#include "stdarg.h"

//#define TCP_Mode 1 
#define UDP_Mode 1

uint8_t ESP8266_SendStr(char* fmt,...);
uint8_t ESP8266_SendData(uint8_t *tbuf, uint16_t len);
uint8_t ESP8266_APInit(char *name, char *password);
uint8_t ESP8266_STAInit(void);
uint8_t ESP8266_STAConnect(char *name, char *password);

#endif


