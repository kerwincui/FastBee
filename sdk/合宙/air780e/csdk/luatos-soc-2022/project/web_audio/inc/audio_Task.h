#ifndef _AUDIO_TASK_
#define _AUDIO_TASK_

#include "string.h"

#include "common_api.h"
#include "luat_debug.h"
#include "luat_rtos.h"
#include "luat_gpio.h"
#include "luat_audio_play_ec618.h"
#include "luat_i2s_ec618.h"
#include "ivTTSSDKID_all.h"
#include "ivTTS.h"
#include "FreeRTOS.h"
#include "queue.h"
#define WAIT_PLAY_FLAG (0x1)
#include "osasys.h"

#define CODEC_PWR_PIN HAL_GPIO_12
#define CODEC_PWR_PIN_ALT_FUN	4
#define PA_PWR_PIN HAL_GPIO_25
#define PA_PWR_PIN_ALT_FUN	0
#define LED2_PIN	HAL_GPIO_24
#define LED2_PIN_ALT_FUN	0
#define LED3_PIN	HAL_GPIO_23
#define LED3_PIN_ALT_FUN	0
#define LED4_PIN	HAL_GPIO_27
#define LED4_PIN_ALT_FUN	0
#define CHARGE_EN_PIN	HAL_GPIO_2
#define CHARGE_EN_PIN_ALT_FUN	0

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
    void *userParam;
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

void audio_task_init(void);



#endif