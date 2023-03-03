#ifndef _YULABAYANSHI_H
#define _UNLABAYANSHI_H

#include "string.h"
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"
#include "bsp.h"
#include "bsp_custom.h"
#include "common_api.h"

#include "portmacro.h"
#include "audio_play.h"
#include "ivTTS.h"
#include "ostask.h"
#include "ps_event_callback.h"
#include "ps_lib_api.h"
#include "cmisim.h"
#include "cmips.h"
#include "slpman.h"
#include "gpio.h"
#include "pad.h"
#define WAIT_PLAY_FLAG (0x1)
#include DEBUG_LOG_HEADER_FILE
#include "plat_config.h"
#include "audio_play.h"
#include "audio_ll_drv.h"
#include "osasys.h"
#include "version.h"
#include "ivTTS.h"


#include "MQTTClient.h"
#include "HTTPClient.h"
#define HOST "lbsmqtt.airm2m.com"
#define PORT 1883
#define client_id "60561eae30594a88bd432627a36240d9"
#define User "username"  
#define Password "password" 
#include "osasys.h"
typedef struct
{
    uint32_t priority;
    uint32_t playType;
    union
    {
        struct
        {
            char *data;
            uint8_t len;
        } tts;
        struct
        {
            audio_play_info_t *info;
            uint8_t count;
        } file;
    } message;
    void * userParam;
} audioQueueData;

typedef enum
{
    MONEY_PLAY = 0,
    PAD_PLAY,
    SYS_PLAY
} AUDIO_PLAY_PRIORITY;

typedef enum
{
    TTS_PLAY = 0,
    FILE_PLAY,
} AUDI;
#endif