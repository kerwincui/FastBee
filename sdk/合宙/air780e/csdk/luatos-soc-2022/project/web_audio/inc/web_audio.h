#ifndef _WEB_AUDIO_H
#define _WEB_AUDIO_H
#include "string.h"

#include "common_api.h"
#include "luat_mobile.h"
#include "luat_debug.h"
#include "luat_rtos.h"
#include "luat_gpio.h"
#include "luat_audio_play_ec618.h"
#include "luat_i2s_ec618.h"
#include "ivTTSSDKID_all.h"
#include "ivTTS.h"
#include "MQTTClient.h"
#include "FreeRTOS.h"
#include "queue.h"
#define WAIT_PLAY_FLAG (0x1)
#include "HTTPClient.h"
#include "osasys.h"
#include "luat_fs.h"
#define HOST "lbsmqtt.airm2m.com"
#define PORT 1883
#define client_id "60561eae30594a88bd432627a36240d9"
#define User "username"  
#define Password "password" 




#endif