//demo用于AIR780e + es8311录音放音功能
#include "common_api.h"

#include "luat_rtos.h"
#include "luat_audio_play_ec618.h"
#include "luat_i2s_ec618.h"
#include "luat_gpio.h"
#include "luat_debug.h"
#include "luat_i2c.h"
#include "interf_enc.h"
//AIR780E+TM8211开发板配置
#define CODEC_PWR_PIN HAL_GPIO_12
#define CODEC_PWR_PIN_ALT_FUN	4
#define PA_PWR_PIN HAL_GPIO_25
#define PA_PWR_PIN_ALT_FUN	0
#define LED2_PIN	HAL_GPIO_24
#define LED2_PIN_ALT_FUN	0
#define LED3_PIN	HAL_GPIO_28
#define LED3_PIN_ALT_FUN	0
#define LED4_PIN	HAL_GPIO_27
#define LED4_PIN_ALT_FUN	0
#define CHARGE_EN_PIN	HAL_GPIO_2
#define CHARGE_EN_PIN_ALT_FUN	0
#define RECORD_TIME	(5)	//设置5秒录音，只要ram够，当然可以更长
static HANDLE g_s_delay_timer;
static HANDLE g_s_amr_encoder_handler;
static uint32_t g_s_record_time;
static Buffer_Struct g_s_amr_rom_file;
typedef struct
{
	uint8_t reg;
	uint8_t value;
}i2c_reg_t;

static const i2c_reg_t es8311_reg_table[] =
{
	{0x45,0x00},
	{0x01,0x30},
	{0x02,0x10},


	//Ratio=MCLK/LRCK=256：12M288-48K；4M096-16K; 2M048-8K
	{0x02,0x00},//MCLK DIV=1
	{0x03,0x10},
	{0x16,0x24},
	{0x04,0x20},
	{0x05,0x00},
	{0x06,(0<<5) + 4 -1},//(0x06,(SCLK_INV<<5) + SCLK_DIV -1); SCLK=BCLK
	{0x07,0x00},
	{0x08,0xFF},//0x07 0x08 fs=256


	{0x09,0x0C},//I2S mode, 16bit
	{0x0A,0x0C},//I2S mode, 16bit



	{0x0B,0x00},
	{0x0C,0x00},

//	{0x10,(0x1C*0) + (0x60*0x01) + 0x03},	//(0x10,(0x1C*DACHPModeOn) + (0x60*VDDA_VOLTAGE) + 0x03);	//VDDA_VOLTAGE=1.8V  close es8311MasterInit 3.3PWR setting
	{0x10,(0x1C*0) + (0x60*0x00) + 0x03},	//(0x10,(0x1C*DACHPModeOn) + (0x60*VDDA_VOLTAGE) + 0x03);	//VDDA_VOLTAGE=3.3V open es8311MasterInit 3.3PWR setting

	{0x11,0x7F},

	{0x00,0x80 + (0<<6)},//Slave  Mode	(0x00,0x80 + (MSMode_MasterSelOn<<6));//Slave  Mode

	{0x0D,0x01},

	{0x01,0x3F + (0x00<<7)},//(0x01,0x3F + (MCLK<<7));

	{0x14,(0<<6) + (1<<4) + 0},//选择CH1输入+30DB GAIN	(0x14,(Dmic_Selon<<6) + (ADCChannelSel<<4) + ADC_PGA_GAIN);

	{0x12,0x28},
	{0x13,0x00 + (0<<4)},	//(0x13,0x00 + (DACHPModeOn<<4));

	{0x0E,0x02},
	{0x0F,0x44},
	{0x15,0x00},
	{0x1B,0x0A},
	{0x1C,0x6A},
	{0x37,0x48},
	{0x44,(0 <<7)},	//(0x44,(ADC2DAC_Sel <<7));
	{0x17,210},//(0x17,ADC_Volume);
	{0x32,200},//(0x32,DAC_Volume);

};

void app_pa_on(uint32_t arg)
{
	luat_gpio_set(PA_PWR_PIN, 1);
}

static void record_encode_amr(uint8_t *data, uint32_t len)
{
	uint8_t outbuf[64];
	int16_t *pcm = (int16_t *)data;
	uint32_t total_len = len >> 1;
	uint32_t done_len = 0;
	int out_len;
	while ((total_len - done_len) >= 160)
	{
		out_len = Encoder_Interface_Encode(g_s_amr_encoder_handler, MR122, &pcm[done_len], outbuf, 0);
		if (out_len <= 0)
		{
			LUAT_DEBUG_PRINT("encode error in %d,result %d", done_len, out_len);
		}
		else
		{
			OS_BufferWrite(&g_s_amr_rom_file, outbuf, out_len);
		}
		done_len += 160;
	}
	free(data);
}

static void record_stop_encode_amr(uint8_t *data, uint32_t len)
{
	Encoder_Interface_exit(g_s_amr_encoder_handler);
	g_s_amr_encoder_handler = NULL;
	LUAT_DEBUG_PRINT("amr encode stop");
}

static int32_t record_cb(void *pdata, void *param)
{
	Buffer_Struct *buffer = (Buffer_Struct *)pdata;
	if (buffer && (buffer->Pos >= 320))
	{
		void *buff = malloc(buffer->Pos);
		memcpy(buff, buffer->Data, buffer->Pos);
		//复杂耗时的操作不可以在回调里处理，这里放到audio task，当然也可以放到用户自己的task里
		soc_call_function_in_audio(record_encode_amr, buff, buffer->Pos, LUAT_WAIT_FOREVER);
		g_s_record_time++;
		if (g_s_record_time >= (RECORD_TIME * 5))	//15秒
		{
			luat_i2s_rx_stop(I2S_ID0);
			soc_call_function_in_audio(record_stop_encode_amr, NULL, NULL, LUAT_WAIT_FOREVER);
		}


		buffer->Pos = 0;

	}

	return 0;
}

void audio_event_cb(uint32_t event, void *param)
{
//	PadConfig_t pad_config;
//	GpioPinConfig_t gpio_config;

	LUAT_DEBUG_PRINT("%d", event);
	switch(event)
	{
	case LUAT_MULTIMEDIA_CB_AUDIO_DECODE_START:
		//luat_gpio_set(CODEC_PWR_PIN, 1);
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
		//luat_gpio_set(CODEC_PWR_PIN, 0);
		break;
	}
}

void audio_data_cb(uint8_t *data, uint32_t len, uint8_t bits, uint8_t channels)
{
	//这里可以对音频数据进行软件音量缩放，或者直接清空来静音
	//软件音量缩放参考HAL_I2sSrcAdjustVolumn
	//LUAT_DEBUG_PRINT("%x,%d,%d,%d", data, len, bits, channels);
}


static void demo_task(void *arg)
{
	uint32_t total, total_free, min_free;
	uint32_t i;
	uint16_t i2c_address = 0x18;
	uint8_t tx_buf[2];
	uint8_t rx_buf[2];
	luat_audio_play_info_t info[1] = {0};
	luat_audio_play_global_init(audio_event_cb, audio_data_cb, luat_audio_play_file_default_fun, NULL, NULL);
	luat_debug_set_fault_mode(LUAT_DEBUG_FAULT_HANG);
	luat_i2c_setup(I2C_ID0, 400000);
	tx_buf[0] = 0xfd;
	luat_i2c_transfer(I2C_ID0, i2c_address, tx_buf, 1, rx_buf, 1);
	tx_buf[0] = 0xfe;
	luat_i2c_transfer(I2C_ID0, i2c_address, tx_buf, 1, rx_buf + 1, 1);
	luat_rtos_timer_create(&g_s_delay_timer);
    luat_i2s_base_setup(I2S_ID0, I2S_MODE_MSB, I2S_FRAME_SIZE_16_16);
    g_s_amr_encoder_handler = Encoder_Interface_init(0);
    OS_InitBuffer(&g_s_amr_rom_file, RECORD_TIME * 1604 + 6);	//1秒最高音质的AMRNB编码是1600
    OS_BufferWrite(&g_s_amr_rom_file, "#!AMR\n", 6);
    while(1)
    {
		if (0x83 == rx_buf[0] && 0x11 == rx_buf[1])
		{
			LUAT_DEBUG_PRINT("find es8311");
			//如果有休眠操作，且控制codec的电源的IO不是AONGPIO，又没有外部上拉保持IO电平，则在唤醒时必须重新初始化codec
			for(i = 0; i < sizeof(es8311_reg_table)/sizeof(i2c_reg_t);i++)
			{
				luat_i2c_transfer(I2C_ID0, i2c_address, NULL, 0, (uint8_t *)&es8311_reg_table[i], 2);
				rx_buf[0] = ~es8311_reg_table[i].value;
				luat_i2c_transfer(I2C_ID0, i2c_address, (uint8_t *)&es8311_reg_table[i].reg, 1, rx_buf, 1);
				if (rx_buf[0] != es8311_reg_table[i].value)
				{
					LUAT_DEBUG_PRINT("write reg %x %x %x", es8311_reg_table[i].reg, es8311_reg_table[i].value,rx_buf[0]);
				}
			}
			luat_i2s_start(I2S_ID0, 0, 8000, 1);
			luat_i2s_no_block_rx(I2S_ID0, 320 * 10, record_cb, NULL);	//单声道8K的amr编码一次320字节，这里每200ms回调一次
			tx_buf[0] = 0x00;
			tx_buf[1] = 0x80|(1 << 6);
			luat_i2c_transfer(I2C_ID0, i2c_address, NULL, 0, tx_buf, 2);
			soc_get_heap_info(&total, &total_free, &min_free);
			LUAT_DEBUG_PRINT("free heap %d", total_free);
			luat_rtos_task_sleep((RECORD_TIME + 1) * 1000);
			tx_buf[0] = 0x00;
			tx_buf[1] = 0x80|(0 << 6);
			luat_i2c_transfer(I2C_ID0, i2c_address, NULL, 0, tx_buf, 2);
			info[0].address = g_s_amr_rom_file.Data;
			info[0].rom_data_len = g_s_amr_rom_file.Pos;
			luat_audio_play_multi_files(0, info, 1);
			while(1)
			{
				soc_get_heap_info(&total, &total_free, &min_free);
				LUAT_DEBUG_PRINT("free heap %d", total_free);
				luat_rtos_task_sleep(5000);
			}
		}
		else
		{
			LUAT_DEBUG_PRINT("not find es8311");
			while(1)
			{
				luat_rtos_task_sleep(500000);
			}
		}
    }
}

static void test_record_demo_init(void)
{
	luat_gpio_cfg_t gpio_cfg;
	luat_gpio_set_default_cfg(&gpio_cfg);
	luat_rtos_task_handle task_handle;

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
	luat_gpio_set(CODEC_PWR_PIN, 1);
	luat_rtos_task_create(&task_handle, 4096, 20, "test", demo_task, NULL, 0);

}

INIT_TASK_EXPORT(test_record_demo_init, "1");
