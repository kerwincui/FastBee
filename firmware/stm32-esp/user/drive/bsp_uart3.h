#ifndef _BSP_UART3_H_
#define _BSP_UART3_H_

#include "stm32f10x.h"
#include "bsp_clock.h"

#include "stdio.h"
#include "string.h"

#include "basic_data.h"

// 判断串口03接收完成
void BSP_UART3SendStr(char *ch);
void BSP_UART3SendData(uint8_t *ch,uint16_t len);
void BSP_UART3Init(uint32_t bound);

#endif

