#include "luat_base.h"
#include "luat_pm.h"
#include "luat_msgbus.h"

#include "bsp.h"
#include "bsp_custom.h"
#include "osasys.h"
#include "ostask.h"
#include "slpman.h"
#include "reset.h"
//#include "psproxytask.h"
#include "driver_gpio.h"
#include "common_api.h"
#include "plat_config.h"
#include "ps_event_callback.h"
#include "cmips.h"
#include "ps_lib_api.h"

#define LUAT_LOG_TAG "luat.pm"
#include "luat_log.h"

static uint8_t lastRequestMode = SLP_IDLE_STATE; // 在APP启动时设置
static uint8_t wakeupSrc = 0;
static uint8_t firstSlpstate;
static uint8_t wakeup_deeptimer_id = 0xFF;

static const char slpStateText[5][5]={{"Actv"},{"Idle"},{"Slp1"},{"Slp2"},{"Hibn"}};
static const char wakeupSrcStr[3][4] = {{"POR"}, {"RTC"}, {"IO"}};
extern void soc_set_usb_sleep(uint8_t onoff);
uint32_t inParam = 0xAABBCCDD;

static int luat_dtimer_cb(lua_State *L, void* ptr) {
    rtos_msg_t* msg = (rtos_msg_t*)lua_topointer(L, -1);
    lua_getglobal(L, "sys_pub");
    if (lua_isfunction(L, -1)) {
        lua_pushstring(L, "DTIMER_WAKEUP");
        lua_pushinteger(L, msg->arg1);
        lua_call(L, 2, 0);
    }
    return 0;
}

static void appTimerExpFunc(uint8_t id) {
    wakeup_deeptimer_id = id;
    LLOGI("DeepTimer Wakeup by id=%d", id);
}

static slpManSlpState_t luat_user_slp_state(void)
{
	return lastRequestMode;
}

int luat_pm_request(int mode) {

    LLOGI("request mode=%ld, prev mode=%ld", mode, lastRequestMode);
    if (mode < 0 || mode > LUAT_PM_SLEEP_MODE_STANDBY) {
        LLOGW("bad mode=%ld", mode);
        return -2;
    }
    lastRequestMode = mode;
    soc_set_usb_sleep(0);
    return 0;
}

int luat_pm_release(int mode) {
	soc_set_usb_sleep(0);
	lastRequestMode = LUAT_PM_SLEEP_MODE_IDLE;
    return 0;
}

int luat_pm_dtimer_start(int id, size_t timeout) {
    if (id < 0 || id > DEEPSLP_TIMER_ID6) {
        return -1;
    }
    slpManDeepSlpTimerStart(id, timeout);
    return 0;
}

int luat_pm_dtimer_stop(int id) {
    if (id < 0 || id > DEEPSLP_TIMER_ID6) {
        return -1;
    }
    slpManDeepSlpTimerDel(id);
    return 0;
}

int luat_pm_dtimer_check(int id) {
    if (id < 0 || id > DEEPSLP_TIMER_ID6) {
        return false;
    }
    LLOGD("dtimer check id %d, remain %d ms", id, slpManDeepSlpTimerRemainMs(id));
    if (slpManDeepSlpTimerRemainMs(id) <= 500)
    {
    	slpManDeepSlpTimerDel(id);
    }
    return slpManDeepSlpTimerIsRunning(id);
}

int luat_pm_last_state(int *lastState, int *rtcOrPad) {
    *lastState = firstSlpstate;
    *rtcOrPad = wakeupSrc;
    return 0;
}

int luat_pm_force(int mode) {
    if (mode < 0 || mode > LUAT_PM_SLEEP_MODE_STANDBY) {
        LLOGW("bad mode=%ld", mode);
        return -2;
    }
    LLOGI("request mode=%ld, prev mode=%ld", mode, lastRequestMode);
	lastRequestMode = mode;
    return 0;
}

int luat_pm_check(void) {
    
    return lastRequestMode;
}

int luat_pm_dtimer_list(size_t* c, size_t* dlist) {
    for (uint8_t i = 0; i<= DEEPSLP_TIMER_ID6; i++) {
        if (slpManDeepSlpTimerIsRunning(i)) {
            uint32_t retime = slpManDeepSlpTimerRemainMs(i);
            if (retime != 0xffffffff) {
                *(dlist+i) = retime;
            }
        }
    }
    return 0;
}

int luat_pm_dtimer_wakeup_id(int* id) {
    if (wakeup_deeptimer_id != 0xFF) {
        *id = wakeup_deeptimer_id;
        return 0;
    }
    return -1;
}

//---------------------------------------------------------------
void luat_pm_preinit(void)
{
	for(uint8_t i = 0; i <= DEEPSLP_TIMER_ID6; i++)
	{
	    slpManDeepSlpTimerRegisterExpCb(i, appTimerExpFunc);
	}
}

void luat_pm_init(void) {
	LLOGI("pm mode %d", apmuGetDeepestSleepMode());
    apmuSetDeepestSleepMode(AP_STATE_HIBERNATE);
    soc_set_usb_sleep(0);
    slpManSlpState_t slpstate = slpManGetLastSlpState();
    slpManWakeSrc_e src = slpManGetWakeupSrc();
    wakeupSrc = (uint8_t)src;
    if (src > WAKEUP_FROM_PAD)
    {
    	src = WAKEUP_FROM_PAD;
    }
    if (slpstate == SLP_SLP2_STATE) {
        LLOGI("poweron: Wakup Sleep2 by %s %d", wakeupSrcStr[src], wakeup_deeptimer_id);
        firstSlpstate = LUAT_PM_SLEEP_MODE_DEEP;
    }
    else if (slpstate == SLP_HIB_STATE) {
        LLOGI("poweron: Wakup Hib by %s %d", wakeupSrcStr[src], wakeup_deeptimer_id);
        firstSlpstate = LUAT_PM_SLEEP_MODE_STANDBY;
    }
    else {
        firstSlpstate = LUAT_PM_SLEEP_MODE_NONE;
        LLOGI("poweron: Power/Reset");
    }
    slpManRegisterUsrSlpDepthCb(luat_user_slp_state);
    if (wakeup_deeptimer_id != 0xff)
    {
        rtos_msg_t msg = {0};
        msg.handler = luat_dtimer_cb;
        msg.arg1 = wakeup_deeptimer_id;
        luat_msgbus_put(&msg, 0);
    }
}

int luat_pm_get_poweron_reason(void)
{
	LastResetState_e apRstState,cpRstState;
	ResetStateGet(&apRstState, &cpRstState);
	int id = 0;
	switch(apRstState)
	{
	case LAST_RESET_POR:
	case LAST_RESET_NORMAL:
		id = 0;
		break;
	case LAST_RESET_SWRESET:
		id = 3;
		break;
	case LAST_RESET_HARDFAULT:
	case LAST_RESET_ASSERT:
		id = 6;
		break;
	case LAST_RESET_WDTSW:
	case LAST_RESET_WDTHW:
	case LAST_RESET_LOCKUP:
	case LAST_RESET_AONWDT:
		id = 8;
		break;
	case LAST_RESET_BATLOW:
	case LAST_RESET_TEMPHI:
		id = 9;
		break;
	case LAST_RESET_FOTA:
		id = 1;
		break;
	default:
		id = 4;
		break;
	}
	return id;
}
///---------------------------------------

extern void pwrKeyStartPowerOff(void);
int luat_pm_poweroff(void)
{
    pwrKeyStartPowerOff();
    return 0;
}

int luat_pm_power_ctrl(int id, uint8_t onoff)
{
	switch(id)
	{
	case LUAT_PM_POWER_USB:
		soc_set_usb_sleep(!onoff);
		soc_usb_onoff(onoff);
		break;
	case LUAT_PM_POWER_GPS:
		GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_13, 4), 4, 0, 0);
		GPIO_Config(HAL_GPIO_13, 0, onoff);
		break;
	case LUAT_PM_POWER_GPS_ANT:
	case LUAT_PM_POWER_DAC_EN_PIN:
		GPIO_IomuxEC618(GPIO_ToPadEC618(HAL_GPIO_12, 4), 4, 0, 0);
		GPIO_Config(HAL_GPIO_12, 0, onoff);
		break;
	default:
		return -1;
	}
	return 0;
}

