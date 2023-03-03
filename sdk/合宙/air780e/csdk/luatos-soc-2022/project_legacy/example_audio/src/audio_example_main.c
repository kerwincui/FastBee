//demo用于AIR600EAC云喇叭开发
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
#include "amr_alipay_data.h"
#include "amr_2_data.h"
#include "amr_10_data.h"
#include "amr_yuan_data.h"
#include "power_audio.h"
#include "driver_gpio.h"
#include "cms_api.h"
#include "apmu_external.h"
//AIR780E+TM8211开发板配置
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

//AIR600EAC开发板配置
//#define CODEC_PWR_PIN HAL_GPIO_12
//#define CODEC_PWR_PIN_ALT_FUN	4
//#define PA_PWR_PIN HAL_GPIO_10
//#define PA_PWR_PIN_ALT_FUN	0
//#define CODEC_PWR_PIN HAL_GPIO_12
//#define CODEC_PWR_PIN_ALT_FUN	4
//#define PA_PWR_PIN HAL_GPIO_10
//#define PA_PWR_PIN_ALT_FUN	0
//#define LED2_PIN	HAL_GPIO_26
//#define LED2_PIN_ALT_FUN	0
//#define LED3_PIN	HAL_GPIO_27
//#define LED3_PIN_ALT_FUN	0
//#define LED4_PIN	HAL_GPIO_20
//#define LED4_PIN_ALT_FUN	0
//#define CHARGE_EN_PIN	HAL_GPIO_NONE
//#define CHARGE_EN_PIN_ALT_FUN	0



extern void downloadFile();
static HANDLE g_s_delay_timer;
void before_sleep(void *pdata, slpManLpState state)
{
//	GPIO_Output(LED2_PIN, 0);
}
/**
  \brief definition of restore callback(called after sleep)
 */
void after_sleep(void *pdata, slpManLpState state)
{
//	GPIO_Output(LED2_PIN, 1);
//	DBG("!");
//	GPIO_ConfigWithPullEC618(CODEC_PWR_PIN, 0, 0, CODEC_PWR_PIN_ALT_FUN);
//	GPIO_ConfigWithPullEC618(PA_PWR_PIN, 0, 0, PA_PWR_PIN_ALT_FUN);
//	GpioPinConfig_t gpio_config;
//    gpio_config.pinDirection = GPIO_DIRECTION_OUTPUT;
//    gpio_config.misc.initOutput = 0;
//    GPIO_pinConfig(0, 12, &gpio_config);
//    gpio_config.misc.initOutput = 0;
//    GPIO_pinConfig(0, 10, &gpio_config);
}

void app_pa_on(uint32_t arg)
{
	GPIO_Output(PA_PWR_PIN, 1);
}

void audio_event_cb(uint32_t event, void *param)
{
//	PadConfig_t pad_config;
//	GpioPinConfig_t gpio_config;

	DBG("%d", event);
	switch(event)
	{
	case MULTIMEDIA_CB_AUDIO_DECODE_START:
		GPIO_Output(CODEC_PWR_PIN, 1);
		audio_play_write_blank_raw(0, 6);
		break;
	case MULTIMEDIA_CB_AUDIO_OUTPUT_START:
		xTimerStart(g_s_delay_timer, 150);
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
		xTimerStop(g_s_delay_timer, 0);
		DBG("audio play done, result=%d!", audio_play_get_last_error(0));
		GPIO_Output(PA_PWR_PIN, 0);
		GPIO_Output(CODEC_PWR_PIN, 0);
		break;
	}
}

void audio_data_cb(uint8_t *data, uint32_t len, uint8_t bits, uint8_t channels)
{
	//这里可以对音频数据进行软件音量缩放，或者直接清空来静音
	//软件音量缩放参考HAL_I2sSrcAdjustVolumn
	//DBG("%x,%d,%d,%d", data, len, bits, channels);
}


static void demo_task(void *arg)
{
	ivCStrA sdk_id = AISOUND_SDK_USERID;
	char tts_string[] = "支付宝到账123456.7元";
	audio_play_info_t info[5];
//	slpManRegisterUsrdefinedBackupCb(before_sleep, NULL);
//	slpManRegisterUsrdefinedRestoreCb(after_sleep, NULL);
	GPIO_ConfigWithPullEC618(CODEC_PWR_PIN, 0, 0, CODEC_PWR_PIN_ALT_FUN);
	GPIO_ConfigWithPullEC618(PA_PWR_PIN, 0, 0, PA_PWR_PIN_ALT_FUN);
	downloadFile();
    g_s_delay_timer = xTimerCreate(NULL, 200, 0, 0, app_pa_on);

    audio_play_global_init(audio_event_cb, audio_data_cb, NULL);
    audio_play_tts_set_resource(ivtts_16k_lite, sdk_id);
    //使用ES7149/ES7148，用如下配置，如果不是，请根据实际情况配置，bus_id直接写0
//    Audio_CodecI2SInit(0, I2S_MODE_I2S, I2S_FRAME_SIZE_16_16);
//	如下配置可使用TM8211
    Audio_CodecI2SInit(0, I2S_MODE_MSB, I2S_FRAME_SIZE_16_16);
	memset(info, 0, sizeof(info));
	info[0].path = "test1.mp3";
	info[1].path = "test2.mp3";
	info[2].path = "test3.mp3";
	info[3].path = "test4.mp3";
	audio_play_multi_files(0, info, 4);
	vTaskDelay(9000);
//	require_lowpower_state(0);
    while(1)
    {


    	info[0].path = NULL;
    	info[0].address = (uint32_t)amr_alipay_data;
    	info[0].rom_data_len = sizeof(amr_alipay_data);
    	info[1].path = NULL;
    	info[1].address = (uint32_t)amr_2_data;
    	info[1].rom_data_len = sizeof(amr_2_data);
    	info[2].path = NULL;
    	info[2].address = (uint32_t)amr_10_data;
    	info[2].rom_data_len = sizeof(amr_10_data);
    	info[3].path = NULL;
    	info[3].address = (uint32_t)amr_2_data;
    	info[3].rom_data_len = sizeof(amr_2_data);
    	info[4].path = NULL;
    	info[4].address = (uint32_t)amr_yuan_data;
    	info[4].rom_data_len = sizeof(amr_yuan_data);
    	audio_play_multi_files(0, info, 5);
    	vTaskDelay(10000);
    	audio_play_tts_text(0, tts_string, sizeof(tts_string));
    	vTaskDelay(10000);

//    	info[0].path = NULL;
//    	info[0].address = (uint32_t)Fqdqwer;
//    	info[0].rom_data_len = sizeof(Fqdqwer);
//    	audio_play_multi_files(0, info, 1);
//    	vTaskDelay(20000);
    }
}

static void test_audio_demo_init(void)
{
	GPIO_GlobalInit(NULL);
	GPIO_ConfigWithPullEC618(LED2_PIN, 0, 0, LED2_PIN_ALT_FUN);
	GPIO_ConfigWithPullEC618(LED3_PIN, 0, 0, LED3_PIN_ALT_FUN);
	GPIO_ConfigWithPullEC618(LED4_PIN, 0, 0, LED4_PIN_ALT_FUN);
	GPIO_ConfigWithPullEC618(CHARGE_EN_PIN, 0, 0, CHARGE_EN_PIN_ALT_FUN);
	xTaskCreate(demo_task, "test", 1024, NULL, 20, NULL);
}

INIT_TASK_EXPORT(test_audio_demo_init, "1");
