#ifndef _BSP_UART2_H_
#define _BSP_UART2_H_

#include "stm32f10x.h"
#include "bsp_clock.h"

#include "stdio.h"
#include "string.h"
#include "stdarg.h"

#include "bsp_timer3.h"

#include "basic_data.h"

void Dev_UART2SendStr(char* fmt,...);
void Dev_UART2SendData(uint8_t *ch, uint16_t len);
void BSP_UART2Init(uint32_t bound);

#endif
