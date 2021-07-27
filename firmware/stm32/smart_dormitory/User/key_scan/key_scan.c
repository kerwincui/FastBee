/****************************************Copyright (c)****************************************************
**     
** File name:               humi.c
** Created by:              XiaoYi
** Created date:            2020-10-16
** Version:                 v1.0
** Descriptions:            The original 
** Link address:            https://blog.csdn.net/weixin_45006076
**
*********************************************************************************************************/

#include "key_scan.h"
#include "multi_button.h"
#include "tim.h"
#include "gpio.h"

struct Button key1_mode;
struct Button key2_mode;
struct Button key3_mode;

uint8_t btn1_event_val;
uint8_t btn2_event_val;
uint8_t btn3_event_val;

key_status_t key_status = { 0x00 };

/*******************************************************************************
 * @brief 模式按键
 *
 * @retval PIN's status
*******************************************************************************/
uint8_t read_key1_mode_pin()
{
	return HAL_GPIO_ReadPin(GPIOB, GPIO_PIN_4);
}

uint8_t read_key2_mode_pin()
{
	return HAL_GPIO_ReadPin(GPIOB, GPIO_PIN_3);
}

uint8_t read_key3_mode_pin()
{
	return HAL_GPIO_ReadPin(GPIOA, GPIO_PIN_0);
}

void key1_short_presssed_cb(void *param)
{
	key_status.enable = 1;
	key_status.key = KEY1;
	key_status.type = KEY_SHORT_PRESS;
	
	printf("key1_short_pressed\r\n");
}

void key1_long_presssed_cb(void *param)
{
//	key_status.enable = 1;
//	key_status.key = KEY1;
//	key_status.type = KEY_LONG_PRESS;
	printf("key1_long_pressed\r\n");
	key_status.enable = 1;
	key_status.key = KEY1;
	key_status.type = KEY_LONG_PRESS;
}

void key2_short_presssed_cb(void *param)
{
	key_status.enable = 1;
	key_status.key = KEY2;
	key_status.type = KEY_SHORT_PRESS;
	printf("key2_short_pressed\r\n");
}
void key3_short_presssed_cb(void *param)
{
	key_status.enable = 1;
	key_status.key = KEY3;
	key_status.type = KEY_SHORT_PRESS;
	printf("key3_short_pressed\r\n");
}

/*******************************************************************************
* @brief  : key_scan
* Description    : scan key's status
* Input          : None
* Output         : None
* Return         : Return the clicked button
* Attention		 : None
*******************************************************************************/
void key_init(void)
{
  GPIO_InitTypeDef GPIO_InitStruct = {0};
	/*Configure GPIO pins : PB3 PB4 */
  GPIO_InitStruct.Pin = GPIO_PIN_3|GPIO_PIN_4;
  GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
  GPIO_InitStruct.Pull = GPIO_PULLUP;
  HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);
	
	//初始化按键对象
	button_init(&key1_mode, read_key1_mode_pin, 0);
	button_attach(&key1_mode, SINGLE_CLICK, key1_short_presssed_cb);
	button_attach(&key1_mode, LONG_PRESS_START, key1_long_presssed_cb);
	button_start(&key1_mode);
	
	button_init(&key2_mode, read_key2_mode_pin, 0);
	button_attach(&key2_mode, PRESS_UP, key2_short_presssed_cb);
	button_start(&key2_mode);
	
	button_init(&key3_mode, read_key3_mode_pin, 0);
	button_attach(&key3_mode, PRESS_UP, key3_short_presssed_cb);
	button_start(&key3_mode);
}

/**
 * @brief T = 5ms
 *
 */
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef* tim_baseHandle)
{
    if(tim_baseHandle->Instance == htim2.Instance)
		{
			button_ticks();
		}
}
