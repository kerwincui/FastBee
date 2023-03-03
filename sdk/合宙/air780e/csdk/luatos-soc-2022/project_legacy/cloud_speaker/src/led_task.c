
#include "gpio.h"
#include "pad.h"
#include "slpman.h"
#include "apmu_external.h"
#include "common_api.h"
#include "charge_management.h"
#include "mqttStatus.h"
#include "led_task.h"
BOOL g_green_led_status = false;
BOOL g_red_led_status = false;
BOOL g_blue_led_status = false;
#define GREEN_CTRL(level)                                                          \
	do                                                                             \
	{                                                                              \
		GPIO_pinWrite(LED_GREEN_PORT, 1 << LED_GREEN_PIN, level << LED_GREEN_PIN); \
	} while (0);
#define RED_CTRL(level)                                                      \
	do                                                                       \
	{                                                                        \
		GPIO_pinWrite(LED_RED_PORT, 1 << LED_RED_PIN, level << LED_RED_PIN); \
	} while (0);
#define BLUE_CTRL(level)                                                        \
	do                                                                          \
	{                                                                           \
		GPIO_pinWrite(LED_BLUE_PORT, 1 << LED_BLUE_PIN, level << LED_BLUE_PIN); \
	} while (0);

static void led_task(void *param)
{
	DBG("entry this func");
	slpManAONIOPowerOn();
	PadConfig_t padConfig;
	PAD_getDefaultConfig(&padConfig);
	padConfig.mux = PAD_MUX_ALT0;
	PAD_setPinConfig(LED_GREEN_PAD, &padConfig);
	PAD_setPinConfig(LED_RED_PAD, &padConfig);
	PAD_setPinConfig(LED_BLUE_PAD, &padConfig);
	GpioPinConfig_t gpioConfig;
	gpioConfig.pinDirection = GPIO_DIRECTION_OUTPUT;
	gpioConfig.misc.initOutput = 0;

	uint8_t ledHandler = 0xff;
	slpManApplyPlatVoteHandle("ledSLP1Vote",&ledHandler); 
	GPIO_pinConfig(LED_GREEN_PORT, LED_GREEN_PIN, &gpioConfig);
	GPIO_pinConfig(LED_RED_PORT, LED_RED_PIN, &gpioConfig);
	GPIO_pinConfig(LED_BLUE_PORT, LED_BLUE_PIN, &gpioConfig);
	while (1)
	{

		if (!getNetStatus())
		{
			slpManPlatVoteDisableSleep(ledHandler, SLP_SLP1_STATE);
			GREEN_CTRL(1);
			BLUE_CTRL(0);
			RED_CTRL(0);
			g_green_led_status = true;
			g_red_led_status = false;
			g_blue_led_status = false;
			slpManPlatVoteEnableSleep(ledHandler, SLP_SLP1_STATE);
			
			vTaskDelay(500);
			
			slpManPlatVoteDisableSleep(ledHandler, SLP_SLP1_STATE);
			GREEN_CTRL(0);
			BLUE_CTRL(0);
			RED_CTRL(0);
			g_green_led_status = false;
			g_red_led_status = false;
			g_blue_led_status = false;
			slpManPlatVoteEnableSleep(ledHandler, SLP_SLP1_STATE);
			vTaskDelay(500);
		}
		else if ((usb_portmon_vbuspad_level() == 1))
		{
			slpManPlatVoteDisableSleep(ledHandler, SLP_SLP1_STATE);
			GREEN_CTRL(0);
			BLUE_CTRL(0);
			RED_CTRL(1);
			g_green_led_status = false;
			g_red_led_status = true;
			g_blue_led_status = false;
			slpManPlatVoteEnableSleep(ledHandler, SLP_SLP1_STATE);
			vTaskDelay(500);
		}
		else if (getNetStatus() && !getServerStatus())
		{
			slpManPlatVoteDisableSleep(ledHandler, SLP_SLP1_STATE);
			GREEN_CTRL(0);
			BLUE_CTRL(1);
			RED_CTRL(0);
			g_green_led_status = false;
			g_red_led_status = false;
			g_blue_led_status = true;
			slpManPlatVoteEnableSleep(ledHandler, SLP_SLP1_STATE);
			vTaskDelay(1000);
		}
		else if (getServerStatus())
		{
			slpManPlatVoteDisableSleep(ledHandler, SLP_SLP1_STATE);
			GREEN_CTRL(0);
			BLUE_CTRL(1);
			RED_CTRL(0);
			g_green_led_status = false;
			g_red_led_status = false;
			g_blue_led_status = true;
			slpManPlatVoteEnableSleep(ledHandler, SLP_SLP1_STATE);
			vTaskDelay(1000);
		}
	}
	vTaskDelete(NULL);
}

void led_task_init(void)
{
	xTaskCreate(led_task, "", 256, NULL, 20, NULL);
}
