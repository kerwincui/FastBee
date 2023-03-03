
#include "gpio.h"
#include "pad.h"
#include "slpman.h"
#include "apmu_external.h"
#include "common_api.h"
/*
      600E      600EAC       780E
LED1 GPIO26     GPIO26      GPIO27
LED2 GPIO27     GPIO27      GPIO24
LED3 GPIO20     GPIO20      GPIO23
*/

#if defined(EVB_AIR600EAC_CLOUD_SPEAK) || (EVB_AIR600E_CLOUD_SPEAK)
#define LED1_PAD 46
#define LED1_PORT 1
#define LED1_PIN 10

#define LED2_PAD 47
#define LED2_PORT 1
#define LED2_PIN 11

#define LED3_PAD 40
#define LED3_PORT 1
#define LED3_PIN 4

#elif defined(EVB_AIR780E_CLOUD_SPEAK)
#define LED1_PAD 47
#define LED1_PORT 1
#define LED1_PIN 11

#define LED2_PAD 44
#define LED2_PORT 1
#define LED2_PIN 8

#define LED3_PAD 41
#define LED3_PORT 1
#define LED3_PIN 7

#endif
#define LED1_CTRL(level)                                            \
    do                                                              \
    {                                                               \
        GPIO_pinWrite(LED1_PORT, 1 << LED1_PIN, level << LED1_PIN); \
    } while (0);
#define LED2_CTRL(level)                                            \
    do                                                              \
    {                                                               \
        GPIO_pinWrite(LED2_PORT, 1 << LED2_PIN, level << LED2_PIN); \
    } while (0);
#define LED3_CTRL(level)                                            \
    do                                                              \
    {                                                               \
        GPIO_pinWrite(LED3_PORT, 1 << LED3_PIN, level << LED3_PIN); \
    } while (0);

static void led_task(void *param)
{
    DBG("entry this func");
    slpManAONIOPowerOn();
    /*600E/600EAC开发板gpio20复用wakeup3，如果想用于io，则需要禁用wakeup3*/
#if defined(EVB_AIR600EAC_CLOUD_SPEAK) || (EVB_AIR600E_CLOUD_SPEAK)
    APmuWakeupPadSettings_t padSetting;
    padSetting.negEdgeEn = false;
    padSetting.posEdgeEn = false;
    padSetting.pullDownEn = false;
    padSetting.pullUpEn = false;
    apmuSetWakeupPadCfg(WAKEUP_PAD_3, false, &padSetting);
#endif
    PadConfig_t padConfig;
    PAD_getDefaultConfig(&padConfig);
    padConfig.mux = PAD_MUX_ALT0;
    PAD_setPinConfig(LED1_PAD, &padConfig);
    PAD_setPinConfig(LED2_PAD, &padConfig);
    PAD_setPinConfig(LED3_PAD, &padConfig);
    GpioPinConfig_t gpioConfig;
    gpioConfig.pinDirection = GPIO_DIRECTION_OUTPUT;
    gpioConfig.misc.initOutput = 0;

    GPIO_pinConfig(LED1_PORT, LED1_PIN, &gpioConfig);
    GPIO_pinConfig(LED2_PORT, LED2_PIN, &gpioConfig);
    GPIO_pinConfig(LED3_PORT, LED3_PIN, &gpioConfig);
    while (1)
    {
        LED1_CTRL(1);
        LED2_CTRL(0);
        LED3_CTRL(0);
        vTaskDelay(100);
        LED1_CTRL(0);
        LED2_CTRL(1);
        LED3_CTRL(0);
        vTaskDelay(100);
        LED1_CTRL(0);
        LED2_CTRL(0);
        LED3_CTRL(1);
        vTaskDelay(100);
    }
    vTaskDelete(NULL);
}

void led_task_init(void)
{
    xTaskCreate(led_task, "", 256, NULL, 20, NULL);
}
