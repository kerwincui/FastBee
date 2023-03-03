//demo用于AIR600EAC云喇叭开发
#include "common_api.h"

#include "luat_rtos.h"
#include "luat_audio_play_ec618.h"
#include "luat_i2s_ec618.h"
#include "ivTTSSDKID_all.h"
#include "ivTTS.h"
#include "amr_alipay_data.h"
#include "amr_2_data.h"
#include "amr_10_data.h"
#include "amr_yuan_data.h"
#include "power_audio.h"
#include "luat_gpio.h"
#include "luat_debug.h"

#include "luat_spi.h"
#include "sfud.h"

#include "soc_spi.h"
#include "driver_gpio.h"

// 这里定义TTS数据在Flash上的起始地址
// 因为很多demo都喜欢用0开始演示flash读写
// 导致TTS的数据无意中就破坏掉了
#define FLASH_TTS_ADDR (64 * 1024)
// SPI 接在SPI0, 片选脚GPIO8
// 注意, SPI0与UART2冲突
#define FLASH_SPI_ID (0)
#define FLASH_SPI_CS (8)
#define FALSH_SPI_BR (25600000)

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

int luat_sfud_read(const sfud_flash* flash, uint8_t* buff, size_t offset, size_t len) {
	// return sfud_read(flash, offset, len, buff)==0?true:false;
	// 以下是SPI直接读
	GPIO_FastOutput(FLASH_SPI_CS, 0);
	offset += FLASH_TTS_ADDR;
	char cmd[4] = {0x03, offset >> 16, (offset >> 8) & 0xFF, offset & 0xFF};
	SPI_FastTransfer(FLASH_SPI_ID, cmd, cmd, 4);
	if (len >= 200) {
		SPI_BlockTransfer(FLASH_SPI_ID, buff, buff, len);
	}
	else {
		SPI_FastTransfer(FLASH_SPI_ID, buff, buff, len);
	}
	
	GPIO_FastOutput(FLASH_SPI_CS, 1);
	// if (memcmp(buff, ivtts_16k + offset, len)) {
	// 	LUAT_DEBUG_PRINT("tts data NOT match %04X %04X", offset, len);
	// }
	return true;
}

luat_spi_t sfud_spi_flash = {
        .id = FLASH_SPI_ID,
        .CPHA = 0,
        .CPOL = 0,
        .dataw = 8,
        .bit_dict = 0,
        .master = 1,
        .mode = 0,
        // .bandrate=13*1000*1000,
        .bandrate=FALSH_SPI_BR,
        .cs = FLASH_SPI_CS
};

extern void download_file();
static HANDLE g_s_delay_timer;

void app_pa_on(uint32_t arg)
{
	luat_gpio_set(PA_PWR_PIN, 1);
}

void audio_event_cb(uint32_t event, void *param)
{
//	PadConfig_t pad_config;
//	GpioPinConfig_t gpio_config;

	LUAT_DEBUG_PRINT("%d", event);
	switch(event)
	{
	case LUAT_MULTIMEDIA_CB_AUDIO_DECODE_START:
		luat_gpio_set(CODEC_PWR_PIN, 1);
		luat_audio_play_write_blank_raw(0, 6, 1);
		break;
	case LUAT_MULTIMEDIA_CB_AUDIO_OUTPUT_START:
		luat_rtos_timer_start(g_s_delay_timer, 200, 0, app_pa_on, NULL);
		break;
	case LUAT_MULTIMEDIA_CB_TTS_INIT:
		break;
	case LUAT_MULTIMEDIA_CB_TTS_DONE:
		if (!luat_audio_play_get_last_error(0))
		{
			luat_audio_play_write_blank_raw(0, 1, 0);
		}
		break;
	case LUAT_MULTIMEDIA_CB_AUDIO_DONE:
		luat_rtos_timer_stop(g_s_delay_timer);
		LUAT_DEBUG_PRINT("audio play done, result=%d!", luat_audio_play_get_last_error(0));
		luat_gpio_set(PA_PWR_PIN, 0);
		luat_gpio_set(CODEC_PWR_PIN, 0);
		break;
	}
}

void audio_data_cb(uint8_t *data, uint32_t len, uint8_t bits, uint8_t channels)
{
	//这里可以对音频数据进行软件音量缩放，或者直接清空来静音
	//软件音量缩放参考HAL_I2sSrcAdjustVolumn
	//LUAT_DEBUG_PRINT("%x,%d,%d,%d", data, len, bits, channels);
}

ivBool tts_read_data(
								  ivPointer		pParameter,			/* [in] user callback parameter */
								  ivPointer		pBuffer,			/* [out] read resource buffer */
								  ivResAddress	iPos,				/* [in] read start position */
	ivResSize		nSize )			/* [in] read size */
{
	LUAT_DEBUG_PRINT("%x,%d,%d", pParameter, iPos, nSize);
    memcpy((uint8_t *)pBuffer, (uint8_t *)pParameter + iPos, nSize);
    return ivTrue;
}

static void demo_task(void *arg)
{
	int re = -1;
    uint8_t data[8] = {0};
    luat_spi_setup(&sfud_spi_flash);

    if (re = sfud_init()!=0){
        LUAT_DEBUG_PRINT("sfud_init error is %d\n", re);
    }
    const sfud_flash *flash = sfud_get_device_table();

// 第一次刷数据到spi flash才需要开启
#if 0
    if (re = sfud_erase(flash, FLASH_TTS_ADDR, 719278)!=0){
        LUAT_DEBUG_PRINT("sfud_erase error is %d\n", re);
    }
    if (re = sfud_write(flash, FLASH_TTS_ADDR, 719278, ivtts_16k)!=0){
        LUAT_DEBUG_PRINT("sfud_write error is %d\n", re);
    }
	LUAT_DEBUG_PRINT("sfud_write ivtts_16k down\n");
	if (re = sfud_read(flash, FLASH_TTS_ADDR, 6, &data)!=0){
        LUAT_DEBUG_PRINT("sfud_read error is %d\n", re);
    }else{
        LUAT_DEBUG_PRINT("sfud_read 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n", data[0], data[1], data[2], data[3], data[4], data[5]);
    }
#else
	// 校验数据
	// char tmp = malloc(4096);
	// for (size_t i = 0; i < 719278; i+=4096)
	// {
	// 	// sfud_read(flash, i+FLASH_TTS_ADDR, 4096, tmp);
	// 	// if (memcmp(tmp, ivtts_16k + i, 4096)) {
	// 	// 	LUAT_DEBUG_PRINT("flash NOT match");
	// 	// 	break;
	// 	// }
	// }
	
#endif

//	luat_rtos_task_sleep(3000);
	ivCStrA sdk_id = AISOUND_SDK_USERID_16K;
	//8K用下面的
//	ivCStrA sdk_id = AISOUND_SDK_USERID_8K;
	// char tts_string[] = "支付宝到账123.45元,微信收款9876.12元ABC支付宝到账123.45元,微信收款9876.12元ABC";
	char tts_string[] = "一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十";
	luat_audio_play_info_t info[5];
//	slpManRegisterUsrdefinedBackupCb(before_sleep, NULL);
//	slpManRegisterUsrdefinedRestoreCb(after_sleep, NULL);
	// download_file();

	luat_rtos_timer_create(&g_s_delay_timer);
    luat_audio_play_global_init(audio_event_cb, audio_data_cb, luat_audio_play_file_default_fun, luat_audio_play_tts_default_fun, NULL);
	// 外部flash版本
	luat_audio_play_tts_set_resource(flash, sdk_id, luat_sfud_read);

    //使用ES7149/ES7148，用如下配置，如果不是，请根据实际情况配置，bus_id直接写0
 //   luat_i2s_base_setup(0, I2S_MODE_I2S, I2S_FRAME_SIZE_16_16);
//	如下配置可使用TM8211
    luat_i2s_base_setup(0, I2S_MODE_MSB, I2S_FRAME_SIZE_16_16);
	// memset(info, 0, sizeof(info));
	// info[0].path = "test1.mp3";
	// info[1].path = "test2.mp3";
	// info[2].path = "test3.mp3";
	// info[3].path = "test4.mp3";
	// luat_audio_play_multi_files(0, info, 4);
	// luat_gpio_set(8, 0);
	luat_rtos_task_sleep(9000);
//	require_lowpower_state(0);
    while(1)
    {


    	// info[0].path = NULL;
    	// info[0].address = (uint32_t)amr_alipay_data;
    	// info[0].rom_data_len = sizeof(amr_alipay_data);
    	// info[1].path = NULL;
    	// info[1].address = (uint32_t)amr_2_data;
    	// info[1].rom_data_len = sizeof(amr_2_data);
    	// info[2].path = NULL;
    	// info[2].address = (uint32_t)amr_10_data;
    	// info[2].rom_data_len = sizeof(amr_10_data);
    	// info[3].path = NULL;
    	// info[3].address = (uint32_t)amr_2_data;
    	// info[3].rom_data_len = sizeof(amr_2_data);
    	// info[4].path = NULL;
    	// info[4].address = (uint32_t)amr_yuan_data;
    	// info[4].rom_data_len = sizeof(amr_yuan_data);
    	// luat_audio_play_multi_files(0, info, 5);
    	// luat_rtos_task_sleep(9000);
    	luat_audio_play_tts_text(0, tts_string, sizeof(tts_string));
    	luat_rtos_task_sleep(30000);

//    	info[0].path = NULL;
//    	info[0].address = (uint32_t)Fqdqwer;
//    	info[0].rom_data_len = sizeof(Fqdqwer);
//    	audio_play_multi_files(0, info, 1);
//    	vTaskDelay(20000);
    }
}

static void test_audio_demo_init(void)
{
	luat_gpio_cfg_t gpio_cfg;
	luat_gpio_set_default_cfg(&gpio_cfg);
	luat_rtos_task_handle task_handle;

	//luat_debug_set_fault_mode(LUAT_DEBUG_FAULT_HANG);

	gpio_cfg.pin = LED2_PIN;
	gpio_cfg.pull = LUAT_GPIO_DEFAULT;
	luat_gpio_open(&gpio_cfg);
	gpio_cfg.pin = LED3_PIN;
	luat_gpio_open(&gpio_cfg);
	gpio_cfg.pin = LED4_PIN;
	luat_gpio_open(&gpio_cfg);
	gpio_cfg.pin = CHARGE_EN_PIN;
	luat_gpio_open(&gpio_cfg);
	gpio_cfg.pin = PA_PWR_PIN;
	luat_gpio_open(&gpio_cfg);
	gpio_cfg.pin = CODEC_PWR_PIN;
	luat_gpio_open(&gpio_cfg);
	gpio_cfg.alt_fun = CODEC_PWR_PIN_ALT_FUN;
	luat_gpio_open(&gpio_cfg);
	luat_rtos_task_create(&task_handle, 2048, 20, "test", demo_task, NULL, 0);
}

INIT_TASK_EXPORT(test_audio_demo_init, "1");
