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

#ifndef __OLED_H__
#define __OLED_H__

#include "main.h"


typedef enum{
	CURSOR_INIT,
	CURSOR_HIGH,
	CURSOR_LOW,
}eStatus;

/* Private function prototypes -----------------------------------------------*/
void oled_init(void);

void oled_write_cmd(unsigned char cmd);

void oled_write_data(unsigned char data);

void oled_set_pos(unsigned char x, unsigned char y);

void oled_fill(unsigned char fill_Data);

void oled_clear_screen(void);

void oled_wakeup(void);

void oled_sleep(void);

void oled_show_string(unsigned char x, unsigned char y, unsigned char ch[], unsigned char TextSize);

void oled_show_chinese(unsigned char x, unsigned char y, unsigned char N);

void oled_draw_bmp(unsigned char x0,unsigned char y0,unsigned char x1,unsigned char y1,unsigned char *bmp);


#endif

