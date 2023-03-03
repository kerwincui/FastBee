#include "header.h"
/**************************************************************************

Copyright: 杜兴杰

Author: 杜兴杰 1066950103@qq.com

Date: 2022-12-01

Description: 物美开发板 串口头文件

**************************************************************************/
#include "luat_uart.h"

void uartInit();
void uartSend(unsigned char nUartId, unsigned char* pnData, unsigned int nLength);
unsigned char* getUartBuffer(unsigned char nUartId);
unsigned int getUartRxLength(unsigned char nUartId);
