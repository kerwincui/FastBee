#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "cmsis_os2.h"
#include "adc.h"
#include "common_api.h"
#include "plat_config.h"
#include "charge_management.h"
#define VBAT_FLAG (0x1)
static osEventFlagsId_t getVbatFlag = NULL;
volatile static uint32_t vbatChannelResult = 0;
volatile static uint16_t vbat = 0;

uint16_t getVbat()
{
    return vbat;
}
static void ADC_VbatChannelCallback(uint32_t result)
{
    vbatChannelResult = result;
    osEventFlagsSet(getVbatFlag, VBAT_FLAG);
}

static void charge_task(void *param)
{
    AdcConfig_t adcConfig;
    ADC_getDefaultConfig(&adcConfig);
    adcConfig.channelConfig.vbatResDiv = ADC_VBAT_RESDIV_RATIO_3OVER16;
    uint32_t result = 0;
    while (1)
    {
        ADC_channelInit(ADC_CHANNEL_VBAT, ADC_USER_PLAT, &adcConfig, ADC_VbatChannelCallback);
        ADC_startConversion(ADC_CHANNEL_VBAT, ADC_USER_PLAT);
        result = osEventFlagsWait(getVbatFlag, VBAT_FLAG, osFlagsWaitAll, 3000);
        if (result == VBAT_FLAG)
        {
            vbat = (HAL_ADC_CalibrateRawCode(vbatChannelResult) * 16 / 3 + 500) / 1000;
            DBG("get vbat result %d", vbat);
        }
        else
        {
            DBG("get vbat timeout");
        }
        ADC_channelDeInit(ADC_CHANNEL_VBAT, ADC_USER_PLAT);
        osDelay(60000); // 60S获取一次当前电量
    }
    vTaskDelete(NULL);
}

void charge_init()
{
    if (getVbatFlag == NULL)
    {
        getVbatFlag = osEventFlagsNew(NULL);
    }
    xTaskCreate(charge_task, "", 256, NULL, 20, NULL);
}
