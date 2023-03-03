#include "FreeRTOS.h"
#include "luat_rtos.h"
#include "luat_gpio.h"
#include "common_api.h"
#include "luat_debug.h"
#include "luat_pm.h"
#include "audio_task.h"
#define KEY1_MESSAGE (0x1)
#define KEY2_MESSAGE (0x2)
#define KEY3_MESSAGE (0x3)
#define PWR_MESSAGE (0x4)
#define CHARGE_START_MESSAGE (0x5)
#define CHARGE_END_MESSAGE (0x6)

#define PAD_PIN_ALT_FUN 0
#define KEY_QUEUE_SIZE 2
extern uint16_t get_vbat();
typedef struct
{
    uint8_t messageId;
} key_message_t;

static luat_rtos_task_handle key_task_handle;
static luat_rtos_queue_t key_queue_handle;
static luat_rtos_timer_t pwrkey_timer_handle;
static luat_rtos_timer_t powoff_timer_handle;
extern luat_rtos_queue_t audio_queue_handle;

static luat_rtos_timer_callback_t pwrkey_long_press_callback(void *param)
{
    if (param == &pwrkey_timer_handle)
    {
        luat_stop_rtos_timer(pwrkey_timer_handle);
        luat_rtos_timer_start(powoff_timer_handle, 3000, 0, pwrkey_long_press_callback, &powoff_timer_handle);
        audioQueueData powerOff = {0};
        powerOff.playType = TTS_PLAY;
        powerOff.priority = MONEY_PLAY;
        char str[] = "正在关机";
        powerOff.message.tts.data = malloc(sizeof(str));
        memcpy(powerOff.message.tts.data, str, sizeof(str));
        powerOff.message.tts.len = sizeof(str);
        if (-1 == luat_rtos_queue_send(audio_queue_handle, &powerOff, NULL, 0))
        {
            free(powerOff.message.tts.data);
            LUAT_DEBUG_PRINT("cloud_speaker_key_task start send audio fail");
        }
    }
    else if (param == &powoff_timer_handle)
    {
        LUAT_DEBUG_PRINT("poweroff");
        luat_pm_poweroff();
    }
}

luat_pm_pwrkey_callback_t pwrkey_callback(LUAT_PM_POWERKEY_STATE_E status)
{
    if (LUAT_PM_PWRKEY_PRESS == status)
    {
        luat_rtos_timer_start(pwrkey_timer_handle, 3000, 0, pwrkey_long_press_callback, &pwrkey_timer_handle);
    }
    else if (LUAT_PM_PWRKEY_RELEASE == status)
    {
        uint8_t id = PWR_MESSAGE;
        luat_rtos_queue_send(key_queue_handle, &id, NULL, 0);
    }
}

static void key_task(void *param)
{
    uint8_t msgId = 0;
    int volume = 15;
    int ret = 0;
    while (1)
    {
        if (luat_rtos_queue_recv(key_queue_handle, &msgId, NULL, LUAT_WAIT_FOREVER) == 0)
        {
            switch (msgId)
            {
            case KEY1_MESSAGE:
            {
                audioQueueData volMinus = {0};
                volMinus.playType = TTS_PLAY;
                volMinus.priority = MONEY_PLAY;
                volume = 15;
                ret = luat_kv_get("volume", &volume, sizeof(int));
                if (ret > 0)
                {
                    if (volume > 3)
                    {
                        volume = volume - 3;
                        if (volume < 3)
                        {
                            volume = 3;
                        }
                        luat_kv_set("volume", &volume, sizeof(int));
                    }
                    if (volume == 3)
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
                if (-1 == luat_rtos_queue_send(audio_queue_handle, &volMinus, NULL, 0))
                {
                    free(volMinus.message.tts.data);
                    LUAT_DEBUG_PRINT("cloud_speaker_key_task start send audio fail");
                }
                break;
            }
            case KEY2_MESSAGE:
            {
                audioQueueData volPlus = {0};
                volPlus.playType = TTS_PLAY;
                volPlus.priority = MONEY_PLAY;
                volume = 4;
                ret = luat_kv_get("volume", &volume, sizeof(int));
                if (ret > 0)
                {
                    if (volume < 21)
                    {
                        volume = volume + 3;
                        if (volume > 21)
                        {
                            volume = 21;
                        }
                        luat_kv_set("volume", &volume, sizeof(int));
                    }
                    if (volume == 21)
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
                if (-1 == luat_rtos_queue_send(audio_queue_handle, &volPlus, NULL, 0))
                {
                    free(volPlus.message.tts.data);
                    LUAT_DEBUG_PRINT("cloud_speaker_key_task start send audio fail");
                }
                break;
            }
            case KEY3_MESSAGE:
            {
                audioQueueData func = {0};
                func.playType = TTS_PLAY;
                func.priority = MONEY_PLAY;
                char str[] = "功能键";
                func.message.tts.data = malloc(sizeof(str));
                memcpy(func.message.tts.data, str, sizeof(str));
                func.message.tts.len = sizeof(str);
                if (-1 == luat_rtos_queue_send(audio_queue_handle, &func, NULL, 0))
                {
                    free(func.message.tts.data);
                    LUAT_DEBUG_PRINT("cloud_speaker_key_task start send audio fail");
                }
                break;
            }
            case PWR_MESSAGE:
            {
                if (1 == luat_rtos_timer_is_active(pwrkey_timer_handle))
                {
                    luat_stop_rtos_timer(pwrkey_timer_handle);
                    uint16_t vbat = get_vbat();
                    audioQueueData currentElec = {0};
                    currentElec.playType = TTS_PLAY;
                    currentElec.priority = MONEY_PLAY;
                    if (vbat > 4000)
                    {
                        char str[] = "当前电量高";
                        currentElec.message.tts.data = malloc(sizeof(str));
                        memcpy(currentElec.message.tts.data, str, sizeof(str));
                        currentElec.message.tts.len = sizeof(str);
                    }
                    else if (vbat > 3700 && vbat < 4000)
                    {
                        char str[] = "当前电量中";
                        currentElec.message.tts.data = malloc(sizeof(str));
                        memcpy(currentElec.message.tts.data, str, sizeof(str));
                        currentElec.message.tts.len = sizeof(str);
                    }
                    else
                    {
                        char str[] = "当前电量低";
                        currentElec.message.tts.data = malloc(sizeof(str));
                        memcpy(currentElec.message.tts.data, str, sizeof(str));
                        currentElec.message.tts.len = sizeof(str);
                    }
                    if (-1 == luat_rtos_queue_send(audio_queue_handle, &currentElec, NULL, 0))
                    {
                        free(currentElec.message.tts.data);
                        LUAT_DEBUG_PRINT("cloud_speaker_key_task start send audio fail");
                    }
                }
                break;
            }
            case CHARGE_START_MESSAGE:
            {
                audioQueueData chargeIn = {0};
                chargeIn.playType = TTS_PLAY;
                chargeIn.priority = MONEY_PLAY;
                char str[] = "正在充电";
                chargeIn.message.tts.data = malloc(sizeof(str));
                memcpy(chargeIn.message.tts.data, str, sizeof(str));
                chargeIn.message.tts.len = sizeof(str);
                if (-1 == luat_rtos_queue_send(audio_queue_handle, &chargeIn, NULL, 0))
                {
                    free(chargeIn.message.tts.data);
                    LUAT_DEBUG_PRINT("cloud_speaker_key_task start send audio fail");
                }
                break;
            }
            case CHARGE_END_MESSAGE:
            {
                audioQueueData chargeOut = {0};
                chargeOut.playType = TTS_PLAY;
                chargeOut.priority = MONEY_PLAY;
                char str[] = "充电结束";
                chargeOut.message.tts.data = malloc(sizeof(str));
                memcpy(chargeOut.message.tts.data, str, sizeof(str));
                chargeOut.message.tts.len = sizeof(str);
                if (-1 == luat_rtos_queue_send(audio_queue_handle, &chargeOut, NULL, 0))
                {
                    free(chargeOut.message.tts.data);
                    LUAT_DEBUG_PRINT("cloud_speaker_key_task start send audio fail");
                }
                break;
            }
            default:
                break;
            }
        }
    }
    luat_rtos_task_delete(key_task_handle);
}

luat_pm_wakeup_pad_isr_callback_t down_key_callback(int num)
{
    if (LUAT_PM_WAKEUP_PAD_0 == num)
    {
        if (0 == luat_pm_wakeup_pad_get_value(LUAT_PM_WAKEUP_PAD_0))
        {
            uint8_t id = KEY1_MESSAGE;
            luat_rtos_queue_send(key_queue_handle, &id, NULL, 0);
        }
    }
    else if (LUAT_PM_WAKEUP_PAD_3 == num)
    {
        if (0 == luat_pm_wakeup_pad_get_value(LUAT_PM_WAKEUP_PAD_3))
        {
            uint8_t id = KEY2_MESSAGE;
            luat_rtos_queue_send(key_queue_handle, &id, NULL, 0);
        }
    }
    else if (LUAT_PM_WAKEUP_PAD_4 == num)
    {
        if (0 == luat_pm_wakeup_pad_get_value(LUAT_PM_WAKEUP_PAD_4))
        {
            uint8_t id = KEY3_MESSAGE;
            luat_rtos_queue_send(key_queue_handle, &id, NULL, 0);
        }
    }
    // 新的开发板如果不接电池只插usb，这个中断会一直触发
    /* else if (LUAT_PM_WAKEUP_PAD_5 == num)
    {
        if (0 == luat_pm_wakeup_pad_get_value(LUAT_PM_WAKEUP_PAD_5))
        {
            uint8_t id = CHARGE_START_MESSAGE;
            luat_rtos_queue_send(key_queue_handle, &id, NULL, 0);
        }
        else
        {
            uint8_t id = CHARGE_END_MESSAGE;
            luat_rtos_queue_send(key_queue_handle, &id, NULL, 0);
        }
    } */
}

void key_task_init(void)
{

    luat_rtos_timer_create(&pwrkey_timer_handle);
    luat_rtos_timer_create(&powoff_timer_handle);

    luat_pm_wakeup_pad_set_callback(down_key_callback);
    luat_pm_wakeup_pad_cfg_t cfg = {0};
    cfg.neg_edge_enable = 1;
    cfg.pos_edge_enable = 0;
    cfg.pull_up_enable = 1;
    cfg.pull_down_enable = 0;
    luat_pm_wakeup_pad_set(true, LUAT_PM_WAKEUP_PAD_0, &cfg);
    luat_pm_wakeup_pad_set(true, LUAT_PM_WAKEUP_PAD_3, &cfg);
    luat_pm_wakeup_pad_set(true, LUAT_PM_WAKEUP_PAD_4, &cfg);
    // 新的开发板如果不接电池只插usb，这个中断会一直触发
    /* cfg.pos_edge_enable = 1;
    luat_pm_wakeup_pad_set(true, LUAT_PM_WAKEUP_PAD_5, &cfg); */
    luat_pm_pwrkey_cfg_t pwrkey_cfg = {0};
    pwrkey_cfg.long_press_timeout = 3000;
    pwrkey_cfg.repeat_timeout = 3000;
    luat_pm_set_pwrkey(LUAT_PM_PWRKEY_WAKEUP_LOWACTIVE_MODE, true, &pwrkey_cfg, pwrkey_callback);

    luat_rtos_queue_create(&key_queue_handle, KEY_QUEUE_SIZE, sizeof(key_message_t));
    int result = luat_rtos_task_create(&key_task_handle, 1024, 20, "key task", key_task, NULL, NULL);
    LUAT_DEBUG_PRINT("cloud_speaker_key_task create task result %d", result);
}