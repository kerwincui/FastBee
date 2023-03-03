
#include "luat_base.h"
#include "luat_malloc.h"
#include "luat_timer.h"
#include "luat_msgbus.h"
#include "FreeRTOS.h"
#include "task.h"
#include "timers.h"
#define LUAT_LOG_TAG "timer"
#include "luat_log.h"

#define FREERTOS_TIMER_COUNT 64
static luat_timer_t* timers[FREERTOS_TIMER_COUNT] __attribute__((aligned (16)));

static void luat_timer_callback(TimerHandle_t xTimer) {
    //LLOGD("timer callback");
    rtos_msg_t msg;
    size_t timer_id = (size_t)pvTimerGetTimerID(xTimer);
    luat_timer_t *timer = luat_timer_get(timer_id);
    if (timer == NULL)
        return;
    msg.handler = timer->func;
    msg.ptr = timer;
    msg.arg1 = timer_id;
    msg.arg2 = 0;
    luat_msgbus_put(&msg, 0);
    // int re = luat_msgbus_put(&msg, 0);
    //LLOGD("timer msgbus re=%ld", re);
}

static int nextTimerSlot() {
    for (size_t i = 0; i < FREERTOS_TIMER_COUNT; i++)
    {
        if (timers[i] == NULL) {
            return i;
        }
    }
    return -1;
}

int luat_timer_start(luat_timer_t* timer) {
    TimerHandle_t os_timer;
    int timerIndex;
    //LLOGD(">>luat_timer_start timeout=%ld", timer->timeout);
    timerIndex = nextTimerSlot();
    if (timerIndex < 0) {
        LLOGE("too many timers");
        return 1; // too many timer!!
    }
    os_timer = xTimerCreate("luat_timer", timer->timeout, 0 == timer->repeat ? 0 : 1, (void*)(timer->id), luat_timer_callback);
    //LLOGD("timer id=%ld, osTimerNew=%p", timerIndex, os_timer);
    if (!os_timer) {
        LLOGE("xTimerCreate FAIL");
        return -1;
    }
    timers[timerIndex] = timer;
    
    timer->os_timer = os_timer;
    int re = xTimerStart(os_timer, 5);
    //LLOGD("timer id=%ld timeout=%ld start=%ld", timerIndex, timer->timeout, re);
    if (re != pdPASS) {
        LLOGE("xTimerStart FAIL");
        xTimerDelete(os_timer, 5);
        timers[timerIndex] = NULL;
    }
    return re == pdPASS ? 0 : -1;
}

int luat_timer_stop(luat_timer_t* timer) {
    if (timer == NULL || timer->os_timer == NULL)
        return 1;
    for (size_t i = 0; i < FREERTOS_TIMER_COUNT; i++)
    {
        if (timers[i] == timer) {
            timers[i] = NULL;
            break;
        }
    }
    xTimerStop((TimerHandle_t)timer->os_timer, 1);
    xTimerDelete((TimerHandle_t)timer->os_timer, 1);
    timer->os_timer = NULL;
    return 0;
};

luat_timer_t* luat_timer_get(size_t timer_id) {
    for (size_t i = 0; i < FREERTOS_TIMER_COUNT; i++)
    {
        if (timers[i] && timers[i]->id == timer_id) {
            return timers[i];
        }
    }
    return NULL;
}


int luat_timer_mdelay(size_t ms) {
    if (ms > 0) {
        vTaskDelay(ms);
    }
    return 0;
}

