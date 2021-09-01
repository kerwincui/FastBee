#ifndef _ESP8266_WORK_H_
#define _ESP8266_WORK_H_

#include "stm32f10x.h"

#include "esp8266_uart2.h"

#include "cJSON.h"

#include "MQTTPacket.h"

#include "MQTTConnect.h"

void ESP8266_NetWorkFlow(void);
void ESP8266_NetReceiveInfor(void);
#endif


