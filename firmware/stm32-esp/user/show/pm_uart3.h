#ifndef _PM_UART3_H_
#define _PM_UART3_H_

#include "stm32f10x.h"

#include "bsp_uart3.h"

#include "bsp_timer3.h"

#include "bsp_port.h"

#include "simulation_lcd.h"

void PMD4_Init(void);
/*PMD4，获取空气信息*/
void PMD4_GetAirInfor(void);
/*显示部分，基础外形刷新*/
void Show_BasicShapeRefresh(void);
#endif









