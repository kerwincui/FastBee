
#include "gpio.h"
#include "pad.h"
#include "slpman.h"
#include "apmu_external.h"
#include "common_api.h"
#include "FreeRTOS.h"
#include "timers.h"
#include "pwrkey.h"
#include "queue.h"
#include "audio_task.h"

#if defined(EVB_AIR780E_CLOUD_SPEAK)
#define BUTTON_GPIO_INSTANCE 1
#define BUTTON_GPIO_PIN 10
#elif defined(EVB_AIR600E_CLOUD_SPEAK) || (EVB_AIR600EAC_CLOUD_SPEAK)
#define BUTTON_GPIO_INSTANCE 1
#define BUTTON_GPIO_PIN 8
#endif

#define KEY1_MESSAGE 0x1
#define KEY2_MESSAGE 0x2
#define PWR_MESSAGE 0x3
static QueueHandle_t padKeyEventQueueHandle;
typedef struct
{
    uint32_t messageId;
} padkeyQueueMsg_t;
TimerHandle_t timerHandlePowerOff = NULL;
TimerHandle_t timerHandlePower = NULL;
extern QueueHandle_t audioQueueHandle;
TimerCallbackFunction_t timerCb(TimerHandle_t xTimer)
{
    if (timerHandlePower == xTimer)
    {
        xTimerStart(timerHandlePowerOff, 3000);
        audioQueueData audioQueueSend = {0};
        audioQueueSend.playType = TTS_PLAY;
        audioQueueSend.priority = MONEY_PLAY;
        char str[] = "正在关机";
        audioQueueSend.message.tts.data = malloc(sizeof(str));
        memcpy(audioQueueSend.message.tts.data, str, sizeof(str));
        audioQueueSend.message.tts.len = sizeof(str);
        if (pdTRUE != xQueueSend(audioQueueHandle, &audioQueueSend, 0))
        {
            DBG("power off send audio fail");
        }
        DBG("power long press");
    }
    else if (timerHandlePowerOff == xTimer)
    {
        DBG("poweroff");
        uniLogFlushOut();
        pwrKeyStartPowerOff();
    }
}

void pwrkeyStatusCb(pwrKeyPressStatus status)
{
    BaseType_t xHigherPriorityTaskWoken;
    xHigherPriorityTaskWoken = pdFALSE;
    uint32_t msgId = PWR_MESSAGE;
    switch (status)
    {
    case PWRKEY_RELEASE:
        if (pdTRUE != xQueueSendFromISR(padKeyEventQueueHandle, &msgId, &xHigherPriorityTaskWoken))
        {
        }
        portYIELD_FROM_ISR(pdTRUE);
        break;
    case PWRKEY_PRESS:
        if (pdTRUE != xTimerStartFromISR(timerHandlePower, &xHigherPriorityTaskWoken))
        {
        }
        portYIELD_FROM_ISR(pdTRUE);
        break;
    case PWRKEY_LONGPRESS:
        break;
    case PWRKEY_REPEAT:
        break;
    default:
        break;
    }
}

static void GPIO_ISR()
{
    uint32_t msgId = KEY1_MESSAGE;
    BaseType_t xHigherPriorityTaskWoken;
    xHigherPriorityTaskWoken = pdFALSE;
    // Save current irq mask and diable whole port interrupts to get rid of interrupt overflow
    uint16_t portIrqMask = GPIO_saveAndSetIrqMask(BUTTON_GPIO_INSTANCE);

    if (GPIO_getInterruptFlags(BUTTON_GPIO_INSTANCE) & (1 << BUTTON_GPIO_PIN))
    {
        if (pdTRUE != xQueueSendFromISR(padKeyEventQueueHandle, &msgId, &xHigherPriorityTaskWoken))
        {
        }
        GPIO_clearInterruptFlags(BUTTON_GPIO_INSTANCE, 1 << BUTTON_GPIO_PIN);
    }

    GPIO_restoreIrqMask(BUTTON_GPIO_INSTANCE, portIrqMask);
    portYIELD_FROM_ISR(pdTRUE);
}
#if defined(EVB_AIR780E_CLOUD_SPEAK)
static void pad3IsrCb()
{
    BaseType_t xHigherPriorityTaskWoken;
    xHigherPriorityTaskWoken = pdFALSE;
    uint8_t status = slpManGetWakeupPinValue();
    uint32_t msgId = KEY2_MESSAGE;
    if ((status & 0x8) == 0) //按下
    {
        if (pdTRUE != xQueueSendFromISR(padKeyEventQueueHandle, &msgId, &xHigherPriorityTaskWoken))
        {
        }
    }
    portYIELD_FROM_ISR(pdTRUE);
}
#elif defined(EVB_AIR600E_CLOUD_SPEAK) || (EVB_AIR600EAC_CLOUD_SPEAK)
static void pad5IsrCb()
{
    BaseType_t xHigherPriorityTaskWoken;
    xHigherPriorityTaskWoken = pdFALSE;
    uint8_t status = slpManGetWakeupPinValue();
    uint32_t msgId = KEY2_MESSAGE;
    DBG("TEST LOG STATUS %d", status);
    if ((status & 0x20) == 0) //按下
    {
        if (pdTRUE != xQueueSendFromISR(padKeyEventQueueHandle, &msgId, &xHigherPriorityTaskWoken))
        {
        }
    }
    portYIELD_FROM_ISR(pdTRUE);
}
#endif
void padkeyIsrCb(int num)
{
    switch (num)
    {
#if defined(EVB_AIR780E_CLOUD_SPEAK)
    case 3:
        pad3IsrCb();
        break;
#elif defined(EVB_AIR600E_CLOUD_SPEAK) || (EVB_AIR600EAC_CLOUD_SPEAK)
    case 5:
        pad5IsrCb();
        break;
#endif
    default:
        break;
    }
}

static void padKeyTask(void *arg)
{
    uint32_t msgId = 0;
    while (1)
    {
        if (xQueueReceive(padKeyEventQueueHandle, &msgId, portMAX_DELAY))
        {
            switch (msgId)
            {
            case KEY1_MESSAGE:
            {
                audioQueueData key1 = {0};
                key1.playType = TTS_PLAY;
                key1.priority = MONEY_PLAY;
                char str[] = "按键一";
                key1.message.tts.data = malloc(sizeof(str));
                memcpy(key1.message.tts.data, str, sizeof(str));
                key1.message.tts.len = sizeof(str);
                if (pdTRUE != xQueueSend(audioQueueHandle, &key1, 0))
                {
                    DBG("key1 off send audio fail");
                }
                break;
            }
            case KEY2_MESSAGE:
            {
                audioQueueData key2 = {0};
                key2.playType = TTS_PLAY;
                key2.priority = MONEY_PLAY;
                char str[] = "按键二";
                key2.message.tts.data = malloc(sizeof(str));
                memcpy(key2.message.tts.data, str, sizeof(str));
                key2.message.tts.len = sizeof(str);
                if (pdTRUE != xQueueSend(audioQueueHandle, &key2, 0))
                {
                    DBG("key1 off send audio fail");
                }
                break;
            }
            case PWR_MESSAGE:
            {
                if (pdFALSE != xTimerIsTimerActive(timerHandlePower))
                {
                    xTimerStop(timerHandlePower, 5000);
                    audioQueueData pwr = {0};
                    pwr.priority = MONEY_PLAY;
                    pwr.playType = TTS_PLAY;
                    char str[] = "开关按下";
                    pwr.message.tts.data = malloc(sizeof(str));
                    memcpy(pwr.message.tts.data, str, sizeof(str));
                    pwr.message.tts.len = sizeof(str);
                    if (pdTRUE != xQueueSend(audioQueueHandle, &pwr, 0))
                    {
                        DBG("power off send audio fail");
                    }
                }
                break;
            }
            default:
                break;
            }
        }
    }
    vTaskDelete(NULL);
}

void key_pad_init(void)
{
    if (timerHandlePower == NULL)
    {
        timerHandlePower = xTimerCreate("test", 3000, false, NULL, timerCb);
    }
    if (timerHandlePowerOff == NULL)
    {
        timerHandlePowerOff = xTimerCreate("test", 2000, false, NULL, timerCb);
    }

    padKeyEventQueueHandle = xQueueCreate(6, sizeof(padkeyQueueMsg_t));

#if defined(EVB_AIR780E_CLOUD_SPEAK)
    APmuWakeupPadSettings_t wakeupPadSetting;
    wakeupPadSetting.negEdgeEn = true;
    wakeupPadSetting.posEdgeEn = false;
    wakeupPadSetting.pullDownEn = false;
    wakeupPadSetting.pullUpEn = true;
    apmuSetWakeupPadCfg(WAKEUP_PAD_3, true, &wakeupPadSetting); // enable wakeup pad 3
    NVIC_EnableIRQ(PadWakeup3_IRQn);
#elif defined(EVB_AIR600E_CLOUD_SPEAK) || (EVB_AIR600EAC_CLOUD_SPEAK)
    APmuWakeupPadSettings_t wakeupPadSetting;
    wakeupPadSetting.negEdgeEn = true;
    wakeupPadSetting.posEdgeEn = false;
    wakeupPadSetting.pullDownEn = false;
    wakeupPadSetting.pullUpEn = true;
    apmuSetWakeupPadCfg(WAKEUP_PAD_5, true, &wakeupPadSetting); // enable wakeup pad 5
    NVIC_EnableIRQ(PadWakeup5_IRQn);
#endif

    set_pad_wakeup_callback(padkeyIsrCb);
    pwrKeyDly_t pwrKeyDlyCfg;
    pwrKeyDlyCfg.longPressTimeout = 3000;
    pwrKeyDlyCfg.repeatTimeout = 3000;
    pwrKeyInit(PWRKEY_WAKEUP_LOWACTIVE_MODE, true, pwrKeyDlyCfg, pwrkeyStatusCb);

    //目前云喇叭开发板上的key1用的是gpio，所以暂时作为gpio中断来使用，后续设计改为wakeup pad
    PadConfig_t padConfig;
    PAD_getDefaultConfig(&padConfig);
    padConfig.mux = PAD_MUX_ALT0;
#if defined(EVB_AIR780E_CLOUD_SPEAK)
    PAD_setPinConfig(46, &padConfig);
#elif defined(EVB_AIR600E_CLOUD_SPEAK) || (EVB_AIR600EAC_CLOUD_SPEAK)
    PAD_setPinConfig(44, &padConfig);
#endif
    
    XIC_SetVector(PXIC1_GPIO_IRQn, GPIO_ISR);
    XIC_EnableIRQ(PXIC1_GPIO_IRQn);
    GpioPinConfig_t config;
    config.pinDirection = GPIO_DIRECTION_INPUT;
    config.misc.interruptConfig = GPIO_INTERRUPT_RISING_EDGE;
    GPIO_pinConfig(BUTTON_GPIO_INSTANCE, BUTTON_GPIO_PIN, &config);
    xTaskCreate(padKeyTask, "", 256, NULL, 20, NULL);
}
