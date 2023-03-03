/*
 * Copyright (c) 2022 OpenLuat & AirM2M
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include "common_api.h"
#include "luat_base.h"
#include "luat_mem.h"
#include "luat_pm.h"
#include "FreeRTOS.h"
#include "apmu_external.h"
#include "slpman.h"
#include "reset.h"
#include "pwrkey.h"

extern void soc_usb_onoff(uint8_t onoff);
extern void soc_set_usb_sleep(uint8_t onoff);
static uint32_t reportMode[LUAT_PM_SLEEP_MODE_STANDBY + 1][10] = {0};

int luat_pm_set_sleep_mode(int mode, const char *vote_tag)
{
    if (mode < LUAT_PM_SLEEP_MODE_NONE || mode > LUAT_PM_SLEEP_MODE_STANDBY || vote_tag == NULL)
    {
        return -1;
    }

    bool findFirst = true;
    for (int sleepMode = LUAT_PM_SLEEP_MODE_NONE; sleepMode < LUAT_PM_SLEEP_MODE_STANDBY + 1; sleepMode++)
    {
        for (int j = 0; j < 9; j++)
        {
            if (strcmp((const char *)reportMode[sleepMode][j], vote_tag) == 0)
            {
                findFirst = false;
                if (mode == sleepMode)
                {
                    break;
                }
                else
                {
                    luat_heap_free(reportMode[sleepMode][j]);
                    reportMode[sleepMode][j] = (uint32_t)NULL;
                    reportMode[sleepMode][9] = reportMode[sleepMode][9] - 1;
                    if (reportMode[mode][9] < 9)
                    {
                        reportMode[mode][j] = (uint32_t)luat_heap_malloc(strlen(vote_tag) + 1);
                        memset((uint32_t *)reportMode[mode][j], 0x00, strlen(vote_tag) + 1);
                        memcpy((uint32_t *)reportMode[mode][j], vote_tag, strlen(vote_tag) + 1);
                        reportMode[mode][9] = reportMode[mode][9] + 1;
                    }
                    break;
                }
            }
        }
    }
    if (findFirst)
    {
        int count = 0;
        for (int sleepMode = LUAT_PM_SLEEP_MODE_NONE; sleepMode < LUAT_PM_SLEEP_MODE_STANDBY + 1; sleepMode++)
        {
            count += reportMode[sleepMode][9];
        }

        if (count >= 8)
            return -1;

        if (reportMode[mode][9] < 9)
        {
            reportMode[mode][reportMode[mode][9]] = (uint32_t)luat_heap_malloc(strlen(vote_tag) + 1);
            memset((uint32_t *)reportMode[mode][reportMode[mode][9]], 0x00, strlen(vote_tag) + 1);
            memcpy((uint32_t *)reportMode[mode][reportMode[mode][9]], vote_tag, strlen(vote_tag) + 1);
            reportMode[mode][9] = reportMode[mode][9] + 1;
        }
    }
    for (int sleepMode = LUAT_PM_SLEEP_MODE_NONE; sleepMode < LUAT_PM_SLEEP_MODE_STANDBY + 1; sleepMode++)
    {
        for (int j = 0; j < 9; j++)
        {
            if (reportMode[sleepMode][j] != (uint32_t)NULL)
            {
                switch (sleepMode)
                {
                case LUAT_PM_SLEEP_MODE_NONE:
                    apmuSetDeepestSleepMode(AP_STATE_ACTIVE);
                    break;
                case LUAT_PM_SLEEP_MODE_IDLE:
                    apmuSetDeepestSleepMode(AP_STATE_IDLE);
                    break;
                case LUAT_PM_SLEEP_MODE_LIGHT:
                    apmuSetDeepestSleepMode(AP_STATE_SLEEP1);
                    break;
                case LUAT_PM_SLEEP_MODE_DEEP:
                    apmuSetDeepestSleepMode(AP_STATE_SLEEP2);
                    break;
                case LUAT_PM_SLEEP_MODE_STANDBY:
                    apmuSetDeepestSleepMode(AP_STATE_HIBERNATE);
                    break;
                default:
                    apmuSetDeepestSleepMode(AP_STATE_IDLE);
                    break;
                }
                return 0;
            }
        }
    }
}

int luat_pm_get_sleep_mode(const char *vote_tag)
{
    for (int sleepMode = LUAT_PM_SLEEP_MODE_NONE; sleepMode < LUAT_PM_SLEEP_MODE_STANDBY + 1; sleepMode++)
    {
        for (int j = 0; j < 9; j++)
        {
            if (strcmp((const char *)reportMode[sleepMode][j], vote_tag) == 0)
            {
                return sleepMode;
            }
        }
    }
    return -1;
}

static luat_pm_sleep_callback_t g_s_user_pre_callback = NULL;
static luat_pm_sleep_callback_t g_s_user_post_callback = NULL;

static slpManBackupCb_t sleep_pre_callback(void *param, slpManLpState mode)
{
    if (g_s_user_pre_callback != NULL)
    {
        g_s_user_pre_callback(mode);
    }
}

static slpManBackupCb_t sleep_post_callback(void *param, slpManLpState mode)
{
    if (g_s_user_post_callback != NULL)
    {
        g_s_user_post_callback(mode);
    }
}

int luat_pm_sleep_register_pre_handler(luat_pm_sleep_callback_t callback_fun)
{
    g_s_user_pre_callback = callback_fun;
    return slpManRegisterUsrdefinedBackupCb(sleep_pre_callback, NULL);
}
int luat_pm_sleep_deregister_pre_handler(void)
{
    g_s_user_pre_callback = NULL;
    return slpManUnregisterUsrdefinedBackupCb(sleep_pre_callback);
}
int luat_pm_sleep_register_post_handler(luat_pm_sleep_callback_t callback_fun)
{
    g_s_user_post_callback = callback_fun;
    return slpManRegisterUsrdefinedRestoreCb(sleep_post_callback, NULL);
}
int luat_pm_sleep_deregister_post_handler(void)
{
    g_s_user_post_callback = NULL;
    return slpManUnregisterUsrdefinedRestoreCb(sleep_post_callback);
}

int luat_pm_wakeup_pad_set_callback(luat_pm_wakeup_pad_isr_callback_t callback_fun)
{
    soc_set_pad_wakeup_callback(callback_fun);
    return 0;
}

int luat_pm_wakeup_pad_set(uint8_t enable, LUAT_PM_WAKEUP_PAD_E source_id, luat_pm_wakeup_pad_cfg_t *cfg)
{
    if ((enable != 1 && enable != 0) || ((source_id < LUAT_PM_WAKEUP_PAD_0) && (source_id > LUAT_PM_WAKEUP_PAD_5)) || cfg == NULL)
    {
        return -1;
    }
    APmuWakeupPadSettings_t padConfig = {0};
    padConfig.negEdgeEn = cfg->neg_edge_enable;
    padConfig.posEdgeEn = cfg->pos_edge_enable;
    padConfig.pullDownEn = cfg->pull_down_enable;
    padConfig.pullUpEn = cfg->pull_up_enable;
    apmuSetWakeupPadCfg(source_id, enable, &padConfig);
    if(enable)
        NVIC_EnableIRQ(source_id);
    else
        NVIC_DisableIRQ(source_id);
    return 0;
}

int luat_pm_wakeup_pad_get_value(LUAT_PM_WAKEUP_PAD_E source_id)
{
    if ((source_id < LUAT_PM_WAKEUP_PAD_0) && (source_id > LUAT_PM_WAKEUP_PAD_5))
    {
        return -1;
    }
    return slpManGetWakeupPinValue() & (1 << source_id);
}

int luat_pm_set_pwrkey(LUAT_PM_POWERKEY_MODE_E mode, bool pullUpEn, luat_pm_pwrkey_cfg_t *cfg, luat_pm_pwrkey_callback_t callback)
{
    pwrKeyDly_t dlyCfg = {0};
    dlyCfg.longPressTimeout = cfg->long_press_timeout;
    dlyCfg.repeatTimeout = cfg->repeat_timeout;

    pwrKeyInit(mode, pullUpEn, dlyCfg, (pwrKeyCallback_t) callback);
    return 0;
}

int luat_pm_get_poweron_reason(void)
{
    return 0;
}

int luat_pm_poweroff(void)
{
    pwrKeyStartPowerOff();
    return 0;
}

int luat_pm_reboot(void)
{
    ResetECSystemReset();
    return 0;
}

int luat_pm_get_vbus_status(uint8_t *status)
{
    *status = usb_portmon_vbuspad_level();
    return 0;
}

int luat_pm_event_register_handler(luat_pm_event_callback_t callback_fun)
{
    return 0;
}
int luat_pm_set_usb_power(uint8_t onoff)
{
	soc_set_usb_sleep(!onoff);
	soc_usb_onoff(onoff);
}

int luat_pm_deep_sleep_mode_timer_start(LUAT_PM_DEEPSLEEP_TIMERID_E timer_id, int timeout)
{
    if (timer_id < LUAT_PM_DEEPSLEEP_TIMER_ID0 || timer_id > LUAT_PM_DEEPSLEEP_TIMER_ID6 || timeout <= 0)
        return -1;
    if ((timer_id == LUAT_PM_DEEPSLEEP_TIMER_ID0 || timer_id == LUAT_PM_DEEPSLEEP_TIMER_ID1) && (timeout > 9000000))
        timeout = 9000000;
    if ((timer_id >= LUAT_PM_DEEPSLEEP_TIMER_ID2 && timer_id <= LUAT_PM_DEEPSLEEP_TIMER_ID6) && (timeout > 2664000000))
        timeout = 2664000000;
    slpManDeepSlpTimerStart(timer_id, timeout);
    return 0;
}

int luat_pm_deep_sleep_mode_timer_stop(LUAT_PM_DEEPSLEEP_TIMERID_E timer_id)
{
    if (timer_id < LUAT_PM_DEEPSLEEP_TIMER_ID0 || timer_id > LUAT_PM_DEEPSLEEP_TIMER_ID6)
        return -1;
    slpManDeepSlpTimerDel(timer_id);
    return 0;
}

int luat_pm_deep_sleep_mode_timer_is_running(LUAT_PM_DEEPSLEEP_TIMERID_E timer_id)
{
    if (timer_id < LUAT_PM_DEEPSLEEP_TIMER_ID0 || timer_id > LUAT_PM_DEEPSLEEP_TIMER_ID6)
        return -1;
    return slpManDeepSlpTimerIsRunning(timer_id) == true ? 1 : 0;
}

int luat_pm_deep_sleep_mode_register_timer_cb(LUAT_PM_DEEPSLEEP_TIMERID_E timer_id, luat_pm_deep_sleep_mode_timer_callback_t callback)
{
    if (timer_id < LUAT_PM_DEEPSLEEP_TIMER_ID0 || timer_id > LUAT_PM_DEEPSLEEP_TIMER_ID6 || callback == NULL)
        return -1;
    slpManDeepSlpTimerRegisterExpCb(timer_id, callback);
    return 0;
}

int luat_pm_get_wakeup_reason()
{
    return slpManGetWakeupSrc();
}