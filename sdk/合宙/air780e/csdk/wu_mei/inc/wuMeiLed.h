#pragma once

#include "header.h"
/**************************************************************************

Copyright: 杜兴杰

Author: 杜兴杰 1066950103@qq.com

Date: 2022-11-23

Description: 物美开发板Led 

**************************************************************************/
#include "luat_gpio.h"
#include "platform_define.h"


/*
*Summary:继电器初始化
*Parameters:
*Return:
*/
void ledInit();

/*
*Summary:继电器控制
*Parameters:
*	nledIndex:继电器号
*   nValue 设置值
*Return: 0 失败 1成功
*/
unsigned char ledControl(unsigned char nledIndex, unsigned char nValue);