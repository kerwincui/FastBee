/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 *****************************************************************************/
#ifndef _WIFI_H_ 
#define _WIFI_H_


#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"
#include "esp_system.h"
#include "esp_wifi.h"
#include "esp_event.h"
#include "esp_log.h"
#include "nvs_flash.h"
#include "lwip/err.h"
#include "lwip/sys.h"


#define LISTEN_INTERVAL  3 //站监听AP信标的间隔。监听间隔的单位是一个信标间隔。例如，如果信标间隔为100 ms，侦听间隔为3，则站侦听信标的间隔为300 ms。
#define POWER_SAVE_MODE  WIFI_PS_MIN_MODEM
#define MAXIMUM_RETRY    5 

#define AP_SSID          "wumei"
#define AP_PASS          "wumei.live"
#define AP_CHANNEL       1 //wifi频道1-13的值
#define AP_MAX_STA_CONN  4

#define WIFI_CONNECTED_BIT BIT0
#define WIFI_FAIL_BIT      BIT1

void wifi_start(void);
void wifi_mqtt_stop(void);
void wifi_continue(void);
void ap_start(void);


#endif
