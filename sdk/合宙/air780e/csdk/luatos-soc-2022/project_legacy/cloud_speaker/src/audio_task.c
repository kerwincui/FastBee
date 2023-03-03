#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "common_api.h"
#include "audio_task.h"
#include "timers.h"
#include "portmacro.h"
#include "audio_play.h"
#include "ivTTS.h"
#include "slpman.h"
#include "gpio.h"
#include "pad.h"
#define WAIT_PLAY_FLAG (0x1)
#include "common_api.h"
#include "bsp_custom.h"
#include "ostask.h"
#include DEBUG_LOG_HEADER_FILE
#include "plat_config.h"
#include "audio_play.h"
#include "audio_ll_drv.h"
#include "FreeRTOS.h"
#include "timers.h"
#include "slpman.h"
#include "osasys.h"
#include "version.h"
#include "ivTTS.h"
#include "audio_extern.h"
#include "led_task.h"
extern BOOL g_green_led_status;
extern BOOL g_red_led_status;
extern BOOL g_blue_led_status;
extern const unsigned char audiopoweron[];
static osEventFlagsId_t waitAudioPlayDone = NULL;
QueueHandle_t audioQueueHandle = NULL;
static uint8_t audio_sleep_handler = 0xff;
static TimerHandle_t delay_timer;
void before_sleep(void *pdata, slpManLpState state)
{
    slpManAONIOLatchEn(true);
}
/**
  \brief definition of restore callback(called after sleep)
 */
void after_sleep(void *pdata, slpManLpState state)
{
    GpioPinConfig_t gpio_config;
    gpio_config.pinDirection = GPIO_DIRECTION_OUTPUT;
    gpio_config.misc.initOutput = 0;
    GPIO_pinConfig(0, 12, &gpio_config);
    gpio_config.misc.initOutput = 0;
    GPIO_pinConfig(1, 9, &gpio_config);


    PadConfig_t padConfig;
	PAD_getDefaultConfig(&padConfig);
	padConfig.mux = PAD_MUX_ALT0;
	PAD_setPinConfig(LED_GREEN_PAD, &padConfig);
	PAD_setPinConfig(LED_RED_PAD, &padConfig);
	PAD_setPinConfig(LED_BLUE_PAD, &padConfig);

	gpio_config.pinDirection = GPIO_DIRECTION_OUTPUT;
    if (!getNetStatus())
	{
        gpio_config.misc.initOutput = g_green_led_status ? 0 : 1;
        GPIO_pinConfig(LED_GREEN_PORT, LED_GREEN_PIN, &gpio_config);
        gpio_config.misc.initOutput = 0;
        GPIO_pinConfig(LED_RED_PORT, LED_RED_PIN, &gpio_config);
        GPIO_pinConfig(LED_BLUE_PORT, LED_BLUE_PIN, &gpio_config);
	}
	else if ((usb_portmon_vbuspad_level() == 1))
	{
        gpio_config.misc.initOutput = 1;
        GPIO_pinConfig(LED_RED_PORT, LED_RED_PIN, &gpio_config);
        gpio_config.misc.initOutput = 0;
        GPIO_pinConfig(LED_GREEN_PORT, LED_GREEN_PIN, &gpio_config);
        GPIO_pinConfig(LED_BLUE_PORT, LED_BLUE_PIN, &gpio_config);
	}
	else if (getNetStatus() && !getServerStatus())
	{
        gpio_config.misc.initOutput = 1;
        GPIO_pinConfig(LED_BLUE_PORT, LED_BLUE_PIN, &gpio_config);
        gpio_config.misc.initOutput = 0;
        GPIO_pinConfig(LED_RED_PORT, LED_RED_PIN, &gpio_config);
        GPIO_pinConfig(LED_GREEN_PORT, LED_GREEN_PIN, &gpio_config);
	}
	else if (getServerStatus())
	{
        gpio_config.misc.initOutput = 1;
        GPIO_pinConfig(LED_BLUE_PORT, LED_BLUE_PIN, &gpio_config);
        gpio_config.misc.initOutput = 0;
        GPIO_pinConfig(LED_RED_PORT, LED_RED_PIN, &gpio_config);
        GPIO_pinConfig(LED_GREEN_PORT, LED_GREEN_PIN, &gpio_config);
	}
}
void audio_data_cb(uint8_t *data, uint32_t len, uint8_t bits, uint8_t channels)
{
    //这里可以对音频数据进行软件音量缩放，或者直接清空来静音
    //软件音量缩放参考HAL_I2sSrcAdjustVolumn
    int value = 4;
    int ret = am_kv_get("volume", &value, 1);
    if(ret > 0)
    {
        DBG("AUDIO GET VOLUME SUCCESS %d", value);
        HAL_I2sSrcAdjustVolumn(data, len, value);
    }
    else
    {
        DBG("AUDIO GET VOLUME FAIL %d", value);
        HAL_I2sSrcAdjustVolumn(data, len, 4);
    }
    DBG("%x,%d,%d,%d", data, len, bits, channels);
}
void app_pa_on(uint32_t arg)
{
    GPIO_pinWrite(1, 1 << 9, 1 << 9);
}
void audio_event_cb(uint32_t event, void *param)
{
    DBG("%d", event);
    switch (event)
    {
    case MULTIMEDIA_CB_AUDIO_DECODE_START:
        slpManPlatVoteDisableSleep(audio_sleep_handler, SLP_SLP1_STATE);
        GPIO_pinWrite(0, 1 << 12, 1 << 12);
        audio_play_write_blank_raw(0, 6);
        break;
    case MULTIMEDIA_CB_AUDIO_OUTPUT_START:
        xTimerStart(delay_timer, 200);
        break;
    case MULTIMEDIA_CB_TTS_INIT:
        if (4 == sizeof("你好"))
        {
            audio_play_tts_set_param(0, ivTTS_PARAM_INPUT_CODEPAGE, ivTTS_CODEPAGE_GBK);
        }
        else
        {
            audio_play_tts_set_param(0, ivTTS_PARAM_INPUT_CODEPAGE, ivTTS_CODEPAGE_UTF8);
        }
        break;
    case MULTIMEDIA_CB_AUDIO_DONE:
        xTimerStop(delay_timer, 0);
        DBG("audio play done, result = %d!", audio_play_get_last_error(0));
        GPIO_pinWrite(1, 1 << 9, 0);
        GPIO_pinWrite(0, 1 << 12, 0);
        slpManPlatVoteEnableSleep(audio_sleep_handler, SLP_SLP1_STATE);
        osEventFlagsSet(waitAudioPlayDone, WAIT_PLAY_FLAG);
        break;
    }
}

void audio_task(void *param)
{
    audioQueueData audioQueueRecv = {0};
    uint32_t result = 0;
    while (1)
    {
        if (xQueueReceive(audioQueueHandle, &audioQueueRecv, portMAX_DELAY))
        {
            DBG("this is play priority %d", audioQueueRecv.priority);
            DBG("this is play playType %d", audioQueueRecv.playType);
            if (audioQueueRecv.priority == MONEY_PLAY)
            {
                
                if (audioQueueRecv.playType == TTS_PLAY)
                {
                    audio_play_tts_text(0, audioQueueRecv.message.tts.data, audioQueueRecv.message.tts.len);
                }
                else if (audioQueueRecv.playType == FILE_PLAY)
                {
                    audio_play_multi_files(0, audioQueueRecv.message.file.info, audioQueueRecv.message.file.count);
                }
            }
            else if (audioQueueRecv.priority == PAD_PLAY)
            {
            }
            result = osEventFlagsWait(waitAudioPlayDone, WAIT_PLAY_FLAG, osFlagsWaitAll, 20000);
            DBG("this is play wait result %d", result);
            if (audioQueueRecv.playType == TTS_PLAY) {
                DBG("free tts data");
                free(audioQueueRecv.message.tts.data);
            }
            else if(audioQueueRecv.playType == FILE_PLAY)
            {
                free(audioQueueRecv.message.file.info);
                DBG("free file data");
            }
        }
    }
    vTaskDelete(NULL);
}

void audio_task_init(void)
{
    GpioPinConfig_t gpio_config;
    gpio_config.pinDirection = GPIO_DIRECTION_OUTPUT;
    gpio_config.misc.initOutput = 0;
    GPIO_pinConfig(0, 12, &gpio_config);

    PadConfig_t config;
    PAD_getDefaultConfig(&config);
    config.mux = PAD_MUX_ALT0;
    PAD_setPinConfig(45, &config);

    GPIO_pinConfig(1, 9, &gpio_config);
    slpManRegisterUsrdefinedBackupCb(before_sleep, NULL);
    slpManRegisterUsrdefinedRestoreCb(after_sleep, NULL);
    ivCStrA sdk_id = AISOUND_SDK_USERID;
    slpManSetPmuSleepMode(true, SLP_SLP1_STATE, false);
    slpManApplyPlatVoteHandle("audio", &audio_sleep_handler);

    slpManPlatVoteDisableSleep(audio_sleep_handler, SLP_SLP2_STATE);
    delay_timer = xTimerCreate(NULL, 200, 0, 0, app_pa_on);

    audio_play_global_init(audio_event_cb, audio_data_cb, NULL);
    audio_play_tts_set_resource(ivtts_16k_lite, sdk_id);
    //现在使用ES7149/ES7148，用如下配置，如果不是，请根据实际情况配置，bus_id直接写0
    // Audio_CodecI2SInit(0, I2S_MODE_I2S, I2S_FRAME_SIZE_16_16);

    //如下配置可使用TM8211
    Audio_CodecI2SInit(0, I2S_MODE_MSB, I2S_FRAME_SIZE_16_16);
    if (waitAudioPlayDone == NULL)
    {
        waitAudioPlayDone = osEventFlagsNew(NULL);
    }
    audioQueueHandle = xQueueCreate(100, sizeof(audioQueueData));
    audioQueueData powerOn = {0};
    powerOn.playType = TTS_PLAY;
    powerOn.priority = MONEY_PLAY;
    char str[] = "正在开机"; 
    powerOn.message.tts.data = malloc(sizeof(str));
    memcpy(powerOn.message.tts.data, str, sizeof(str));
    powerOn.message.tts.len = sizeof(str);
    if (pdTRUE != xQueueSend(audioQueueHandle, &powerOn, 0))
    {
        DBG("start send audio fail");
    }
    xTaskCreate(audio_task, " ", 2048, NULL, 20, NULL);
}
