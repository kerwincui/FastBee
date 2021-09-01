#ifndef _BSP_PORT_H_
#define _BSP_PORT_H_

#include "stm32f10x.h"

#include "bsp_clock.h"

#include "bsp_timer3.h"

#include "basic_data.h"

// 禁用JTAG引脚,保留SWD引脚
void Sys_DisableJTAGEnableSWD(void);

#define Power_PMD4(x) (x)?GPIO_SetBits(GPIOB,GPIO_Pin_1) :GPIO_ResetBits(GPIOB,GPIO_Pin_1) // PM2.5
#define Power_LCD(x)  (x)?GPIO_SetBits(GPIOB,GPIO_Pin_12):GPIO_ResetBits(GPIOB,GPIO_Pin_12)// LCD
#define Power_3V3(x)  (x)?GPIO_SetBits(GPIOB,GPIO_Pin_13):GPIO_ResetBits(GPIOB,GPIO_Pin_13)// 3.3V

#define Read_BatCharging() GPIO_ReadInputDataBit(GPIOC, GPIO_Pin_13)// 电池充电中状态，低电平有效
#define Read_BatComplete() GPIO_ReadInputDataBit(GPIOC, GPIO_Pin_14)// 电池充电完成状态，低电平有效
#define Read_BootKey()     GPIO_ReadInputDataBit(GPIOC, GPIO_Pin_15)// 开机按键
void BSP_PowerInit(void);
void Dev_ReadIndicate(void);

// 重启
void BSP_Restart(void);



#endif




