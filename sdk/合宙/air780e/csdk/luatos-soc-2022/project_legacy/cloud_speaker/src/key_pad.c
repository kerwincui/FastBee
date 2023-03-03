#include "gpio.h"
#include "pad.h"
#include "slpman.h"
#include "apmu_external.h"
#include "common_api.h"
#include "FreeRTOS.h"
#include "timers.h"
#include "pwrkey.h"
#include "queue.h"
#include "charge_management.h"
#include "audio_task.h"
#include "audio_extern.h"
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
#define BUTTON_GPIO_INSTANCE 1
#define BUTTON_GPIO_PIN 10
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

void padkeyIsrCb(int num)
{
    switch (num)
    {
    case 3:
        pad3IsrCb();
        break;
    default:
        break;
    }
}

static void padKeyTask(void *arg)
{
    uint32_t msgId = 0;
    int volume = 4;
    int ret = 0;
    while (1)
    {
        if (xQueueReceive(padKeyEventQueueHandle, &msgId, portMAX_DELAY))
        {
            switch (msgId)
            {
            case KEY1_MESSAGE:
            {
                audioQueueData volPlus = {0};
                volPlus.playType = TTS_PLAY;
                volPlus.priority = MONEY_PLAY;
                volume = 4;
                ret = am_kv_get("volume", &volume, 1);
                if (ret > 0)
                {
                    if (volume < 7)
                    {
                        volume++;
                        if (volume > 7)
                        {
                            volume = 7;
                        }
                        am_kv_set("volume", &volume, 1);
                    }
                    if (volume == 7)
                    {
                        char str[] = "音量最大";
                        volPlus.message.tts.data = malloc(sizeof(str));
                        memcpy(volPlus.message.tts.data, str, sizeof(str));
                        volPlus.message.tts.len = sizeof(str);
                    }
                    else
                    {
                        char str[] = "音量加";
                        volPlus.message.tts.data = malloc(sizeof(str));
                        memcpy(volPlus.message.tts.data, str, sizeof(str));
                        volPlus.message.tts.len = sizeof(str);
                    }
                }
                else
                {
                    char str[] = "音量加";
                    volPlus.message.tts.data = malloc(sizeof(str));
                    memcpy(volPlus.message.tts.data, str, sizeof(str));
                    volPlus.message.tts.len = sizeof(str);
                }
                if (pdTRUE != xQueueSend(audioQueueHandle, &volPlus, 0))
                {
                    DBG("key1 off send audio fail");
                }
                break;
            }
            case KEY2_MESSAGE:
            {
                audioQueueData volMinus = {0};
                volMinus.playType = TTS_PLAY;
                volMinus.priority = MONEY_PLAY;
                volume = 4;
                ret = am_kv_get("volume", &volume, 1);
                if (ret > 0)
                {
                    if (volume > 1)
                    {
                        volume--;
                        if (volume < 1)
                        {
                            volume = 1;
                        }
                        am_kv_set("volume", &volume, 1);
                    }
                    if (volume == 1)
                    {
                        char str[] = "音量最小";
                        volMinus.message.tts.data = malloc(sizeof(str));
                        memcpy(volMinus.message.tts.data, str, sizeof(str));
                        volMinus.message.tts.len = sizeof(str);
                    }
                    else
                    {
                        char str[] = "音量减";
                        volMinus.message.tts.data = malloc(sizeof(str));
                        memcpy(volMinus.message.tts.data, str, sizeof(str));
                        volMinus.message.tts.len = sizeof(str);
                    }
                }
                else
                {
                    char str[] = "音量减";
                    volMinus.message.tts.data = malloc(sizeof(str));
                    memcpy(volMinus.message.tts.data, str, sizeof(str));
                    volMinus.message.tts.len = sizeof(str);
                }
                if (pdTRUE != xQueueSend(audioQueueHandle, &volMinus, 0))
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
                    uint16_t vbat = getVbat();
                    audioQueueData currentPower = {0};
                    currentPower.priority = MONEY_PLAY;
                    currentPower.playType = TTS_PLAY;
                    if (vbat > 4000)
                    {
                        char str[] = "当前电量高";
                        currentPower.message.tts.data = malloc(sizeof(str));
                        memcpy(currentPower.message.tts.data, str, sizeof(str));
                        currentPower.message.tts.len = sizeof(str);
                    }
                    else if (vbat > 3700 && vbat < 4000)
                    {
                        char str[] = "当前电量中";
                        currentPower.message.tts.data = malloc(sizeof(str));
                        memcpy(currentPower.message.tts.data, str, sizeof(str));
                        currentPower.message.tts.len = sizeof(str);
                    }
                    else
                    {
                        char str[] = "当前电量低";
                        currentPower.message.tts.data = malloc(sizeof(str));
                        memcpy(currentPower.message.tts.data, str, sizeof(str));
                        currentPower.message.tts.len = sizeof(str);
                    }
                    if (pdTRUE != xQueueSend(audioQueueHandle, &currentPower, 0))
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

    APmuWakeupPadSettings_t wakeupPadSetting;
    wakeupPadSetting.negEdgeEn = true;
    wakeupPadSetting.posEdgeEn = false;
    wakeupPadSetting.pullDownEn = false;
    wakeupPadSetting.pullUpEn = true;
    apmuSetWakeupPadCfg(WAKEUP_PAD_3, true, &wakeupPadSetting); // enable wakeup pad 3
    NVIC_EnableIRQ(PadWakeup3_IRQn);

    set_pad_wakeup_callback(padkeyIsrCb);
    pwrKeyDly_t pwrKeyDlyCfg;
    pwrKeyDlyCfg.longPressTimeout = 3000;
    pwrKeyDlyCfg.repeatTimeout = 3000;
    pwrKeyInit(PWRKEY_WAKEUP_LOWACTIVE_MODE, true, pwrKeyDlyCfg, pwrkeyStatusCb);

    //目前云喇叭开发板上的key1用的是gpio，所以暂时作为gpio中断来使用，agpio休眠时仅可保持电平，不可用于中断,后续设计改为wakeup pad
    PadConfig_t padConfig;
    PAD_getDefaultConfig(&padConfig);
    padConfig.mux = PAD_MUX_ALT0;
    PAD_setPinConfig(46, &padConfig);
    XIC_SetVector(PXIC1_GPIO_IRQn, GPIO_ISR);
    XIC_EnableIRQ(PXIC1_GPIO_IRQn);
    GpioPinConfig_t config;
    config.pinDirection = GPIO_DIRECTION_INPUT;
    config.misc.interruptConfig = GPIO_INTERRUPT_RISING_EDGE;
    GPIO_pinConfig(BUTTON_GPIO_INSTANCE, BUTTON_GPIO_PIN, &config);
    xTaskCreate(padKeyTask, "", 256, NULL, 20, NULL);
}
