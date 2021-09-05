#ifndef _ESP8266_WORK_H_
#define _ESP8266_WORK_H_

#include "stm32f10x.h"

#include "esp8266_uart2.h"

#include "stdio.h"

#include "string.h"

#include "stdarg.h"

#include "cJSON.h"

#include "mqtt.h"

void ESP8266_NetWorkFlow(void);
void ESP8266_NetReceiveInfor(void);
#endif


