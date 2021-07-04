/******************************************************************************
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 *****************************************************************************/
#ifndef _WIFI_H_ 
#define _WIFI_H_

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"
#include "esp_wifi.h"
#include "esp_log.h"
#include <string.h>

char ssid[33];                // wifi的SSID
char pwd[65];                 // wifi的密码
void wifi_start(void);

#endif
