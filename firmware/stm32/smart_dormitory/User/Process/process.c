/****************************************Copyright (c)****************************************************
**     
** File name:               process.c
** Created by:              XiaoYi
** Created date:            2020-10-16
** Version:                 v1.0
** Descriptions:            The original 
** Link address:            https://blog.csdn.net/weixin_45006076
**
*********************************************************************************************************/

#include "process.h"
#include "gpio.h"
#include "flash.h"
#include "tim.h"
#include "oled.h"

/*
	SG90的舵机要求控制舵机的 PWM 信号频率在50Hz左右，即周期为 20ms 的 PWM 信号，当该信号的高电平部分在0.5ms - 2.5ms之间时，对应舵机转动的角度，具体对应情况如下
	value参数值    高电平脉宽        舵机转动角度
		50							0.5ms              0°
		100               1ms              45°
		150             1.5ms              90°
		200               2ms              135°
		250             2.5ms              180°
*/
void set_sg90(int value)  // 模拟开门
{
	__HAL_TIM_SET_COMPARE(&htim4, TIM_CHANNEL_1, value);
}

void start_buzz(void)
{
	BUZZ = 1;
}

void stop_buzz(void)
{
	BUZZ = 1;
}
  
void process_local_handle(uint16_t value_humi)
{
	/* 如果湿度小于系统设置的最小值，转动电机浇水，当湿度超过最大值时候，停止浇水，关闭电机 */
;
}

void process_report_data(void)
{
	uint8_t send_buff[12];
	
	// 当前系统处于连云状态时候发送数据

}

void process_handle_wifi_data(void)
{
	int i = 0;


}

