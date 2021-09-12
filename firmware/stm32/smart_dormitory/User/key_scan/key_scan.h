#ifndef __KEY_SCAN_H
#define __KEY_SCAN_H

#include "main.h"

#define KEY1    0x40
#define KEY2    0x41
#define KEY3    0x42

typedef enum{
	KEY_NONE_PRESS,
	KEY_SHORT_PRESS,
	KEY_LONG_PRESS,
}key_event_e;

typedef struct
{
	int enable;  // 使能，判断按键是否按下
	int key;     // 按键名字
	int type;    // 按键类型，详见key_event_e中定义
}key_status_t; 
extern key_status_t key_status;


void key_init(void);

int key_scan(void);

#endif

