#pragma once

#include "header.h"
/**************************************************************************

Copyright: 杜兴杰

Author: 杜兴杰 1066950103@qq.com

Date: 2022-11-19

Description: 物美开发板 继电器头文件

**************************************************************************/
#include "luat_gpio.h"
#include "platform_define.h"


/*
*Summary:继电器初始化
*Parameters:
*Return:
*/
void relayInit();

/*
*Summary:继电器控制
*Parameters:
*	nRelayIndex:继电器号
*   nValue 设置值
*Return: 0 失败 1成功
*/
unsigned char relayControl(unsigned char nRelayIndex, unsigned char nValue);

unsigned char relayGetValue(unsigned char nRelayIndex);