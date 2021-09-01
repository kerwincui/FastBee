#ifndef _BSP_CLOCK_H_
#define _BSP_CLOCK_H_

#include "stm32f10x.h"

void Delay_ms(uint32_t nms);
void Delay_us(uint32_t nus);

void BSP_ClockInit(void);

#endif

