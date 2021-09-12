/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2021 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f1xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
	
/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/******************************快速位绑定**********************************************************/
/*----------------1、宏定义要操作的寄存器地址---------------------------------------------*/
 #define GPIOA_ODR (GPIOA_BASE + 0X0C)
 #define GPIOA_IDR (GPIOA_BASE + 0X08)
 
 #define GPIOB_ODR (GPIOB_BASE + 0X0C)
 #define GPIOB_IDR (GPIOB_BASE + 0X08)
 
 #define GPIOC_ODR (GPIOC_BASE + 0X0C)
 #define GPIOC_IDR (GPIOC_BASE + 0X08)
 
 #define GPIOD_ODR (GPIOD_BASE + 0X0C)
 #define GPIOD_IDR (GPIOD_BASE + 0X08)
 
 #define GPIOE_ODR (GPIOE_BASE + 0X0C)
 #define GPIOE_IDR (GPIOE_BASE + 0X08)
 
/*----------------2、获取端口GPIOx(A-E)的对应寄存器的某一操作位的位地址-------------------*/
// #define BitBand(Addr , BitNum) *( (volatile unsigned long *)(Addr & 0xf0000000) + 0x2000000 + ((Addr&0xfffff)*32) + (BitNum*4) ) 
// 因为 左移、右移 语句的执行速度比乘除法语句的运动速度快，所以将上述语句改成如下方式
 #define BitBand(Addr , BitNum) *( (volatile unsigned long *)( (Addr & 0xf0000000) + 0x2000000 + ((Addr&0xfffff)<<5) + (BitNum<<2) ) ) 
  
/*----------------3、宏定义函数，对固定的位绑定 进行功能封装------------------------------*/
 #define PAout(n) BitBand(GPIOA_ODR , n) 
 #define PAin(n) BitBand(GPIOA_IDR , n)
 
 #define PBout(n) BitBand(GPIOB_ODR , n) 
 #define PBin(n) BitBand(GPIOB_IDR , n)
 
 #define PCout(n) BitBand(GPIOC_ODR , n) 
 #define PCin(n) BitBand(GPIOC_IDR , n)
 
 #define PDout(n) BitBand(GPIOD_ODR , n) 
 #define PDin(n) BitBand(GPIOD_IDR , n)
 
 #define PEout(n) BitBand(GPIOE_ODR , n) 
 #define PEin(n) BitBand(GPIOE_IDR , n)
/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */
void delay_ms(int ms);

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define LED_R_Pin GPIO_PIN_13
#define LED_R_GPIO_Port GPIOC
#define LED_G_Pin GPIO_PIN_14
#define LED_G_GPIO_Port GPIOC
#define LED_B_Pin GPIO_PIN_15
#define LED_B_GPIO_Port GPIOC
#define BUZZ_Pin GPIO_PIN_0
#define BUZZ_GPIO_Port GPIOB
#define DHT11_Pin GPIO_PIN_5
#define DHT11_GPIO_Port GPIOB
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
