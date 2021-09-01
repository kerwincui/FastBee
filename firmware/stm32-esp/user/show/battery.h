#ifndef _BATTERY_H_
#define _BATTERY_H_

#include "stm32f10x.h"

#include "bsp_timer3.h"

#include "bsp_port.h"

#include "bsp_adc.h"

#include "simulation_lcd.h"

/*电池，获取电池信息*/
void Bat_GetWorkInfor(void);
/*显示部分，电池图标外形刷新*/
void Show_BatIconShapeRefresh(void);
/*显示部分，电池图标刷新*/
void Show_BatIconRefresh(void);
/*显示部分，侧边跳动*/
void Show_BroadSideBeat(void);
#endif









