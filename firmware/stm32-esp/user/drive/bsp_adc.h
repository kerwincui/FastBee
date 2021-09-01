#ifndef _BSP_ADC_H_
#define _BSP_ADC_H_

#include "stm32f10x.h"
#include "string.h"

#include "bsp_port.h"

#include "bsp_timer3.h"

#include "basic_data.h"

void  BSP_ADCInit(void);
float ADC_GetSimpleData(void);

#endif

