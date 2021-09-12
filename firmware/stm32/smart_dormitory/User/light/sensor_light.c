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

#include "sensor_light.h"
#include "gpio.h"
#include "adc.h"

uint16_t light_get_value(void)
{
	// 启动ADC转换
	HAL_ADC_Start(&hadc1);
	// 等待转换完成，第二个参数表示超时时间，单位ms
	HAL_ADC_PollForConversion(&hadc1, 100);
	return HAL_ADC_GetValue(&hadc1);
}

uint8_t light_get_average_value(uint8_t times)  //获取光照数据并返回给主函数
{
	uint32_t temp_val=0;
	uint8_t t;
	float temp_avrg=0;

	for(t=0;t<times;t++)       //LSENS_READ_TIMES在lsens.h文件中设好，默认10//
	{
		temp_val += light_get_value();   //读取ADC值
		delay_ms(5);
	}
	temp_val/=times;           //计算平均值// 
	if(temp_val>4000)
		temp_val=4000;       //当计算后的值大于4000时，强制转换为4000//
	
	return (100-(temp_val/40));       //将temp_val值归一化到0-100之间//
}

