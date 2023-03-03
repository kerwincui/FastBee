#ifndef __LED_TASK_H_
#define __LED_TASK_H_

#define LED_GREEN_PAD 44
#define LED_GREEN_PORT 1
#define LED_GREEN_PIN 8

#define LED_RED_PAD 47
#define LED_RED_PORT 1
#define LED_RED_PIN 11

#define LED_BLUE_PAD 41
#define LED_BLUE_PORT 1
#define LED_BLUE_PIN 7

void led_task_init(void);
#endif