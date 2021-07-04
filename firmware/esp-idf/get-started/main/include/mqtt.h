/******************************************************************************
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
#ifndef _MQTT_H_ 
#define _MQTT_H_

#include <stdio.h>
#include <string.h>
#include "esp_log.h"
#include "mqtt_client.h"
#include "cJSON.h"
#include "cJSON_Utils.h"

char owner_id[64];            // 用户ID
char device_num[13];          // 设备编号，mac地址
void mqtt_start(void);


#endif
