#ifndef _BSP_UART1_H_
#define _BSP_UART1_H_

#include "stm32f10x.h"
#include "bsp_clock.h"

#include "stdio.h"
#include "string.h"
#include "stdarg.h"

#include "bsp_timer3.h"


void Sys_SendLog(const char *fmt, ...);

// 判断串口01接收完成
void BSP_UART1RecComplete(uint64_t Std_1ms);
void BSP_UART1SendStr(char *ch);
void BSP_UART1SendData(uint8_t *ch,uint16_t len);
void BSP_UART1Init(uint32_t bound);

#endif
