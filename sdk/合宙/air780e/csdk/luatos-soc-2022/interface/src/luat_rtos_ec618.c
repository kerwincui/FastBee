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

#include "luat_rtos.h"
#include "common_api.h"
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"
#include "timers.h"
#include "cmsis_os2.h"
typedef struct
{
	void *timer;
	luat_rtos_timer_callback_t call_back;
	void *user_param;
	uint8_t is_repeat;
}luat_rtos_user_timer_t;

int luat_rtos_task_create(luat_rtos_task_handle *task_handle, uint32_t stack_size, uint8_t priority, const char *task_name, luat_rtos_task_entry task_fun, void* user_data, uint16_t event_cout)
{
	if (!task_handle) return -1;
	*task_handle = create_event_task(task_fun, user_data, stack_size, priority, event_cout, task_name);
	return (*task_handle)?0:-1;
}

int luat_rtos_task_delete(luat_rtos_task_handle task_handle)
{
	if (!task_handle) return -1;
	delete_event_task(task_handle);
	return 0;
}

int luat_rtos_task_suspend(luat_rtos_task_handle task_handle)
{
	if (!task_handle) return -1;
	vTaskSuspend(task_handle);
	return 0;
}

int luat_rtos_task_resume(luat_rtos_task_handle task_handle)
{
	if (!task_handle) return -1;
	vTaskResume(task_handle);
	return 0;
}
uint32_t luat_rtos_task_get_high_water_mark(luat_rtos_task_handle task_handle)
{
	if (!task_handle) return -1;
	return uxTaskGetStackHighWaterMark(task_handle);
}
void luat_rtos_task_sleep(uint32_t ms)
{
	vTaskDelay(ms);
}

void luat_task_suspend_all(void)
{
	vTaskSuspendAll();
}
void luat_task_resume_all(void)
{
	xTaskResumeAll();
}

void *luat_get_current_task(void)
{
	return xTaskGetCurrentTaskHandle();
}

int luat_rtos_event_send(luat_rtos_task_handle task_handle, uint32_t id, uint32_t param1, uint32_t param2, uint32_t param3, uint32_t timeout)
{
	if (!task_handle) return -1;
	return send_event_to_task(task_handle, NULL, id, param1, param2, param3, timeout);
}

LUAT_RET luat_send_event_to_task(void *task_handle, uint32_t id, uint32_t param1, uint32_t param2, uint32_t param3)
{
	if (!task_handle) return -1;
	return send_event_to_task(task_handle, NULL, id, param1, param2, param3, LUAT_WAIT_FOREVER);
}
LUAT_RET luat_wait_event_from_task(void *task_handle, uint32_t wait_event_id, luat_event_t *out_event, void *call_back, uint32_t ms)
{
	if (!task_handle) return -1;
	return get_event_from_task(task_handle, wait_event_id, (void *)out_event, call_back, ms);
}

/**
 * 等同于luat_rtos_semaphore_create时init_count = 0
 */
void *luat_mutex_create(void)
{
	SemaphoreHandle_t sem = xSemaphoreCreateBinary();
	if (sem)
	{
		xSemaphoreGive(sem);
	}
	return sem;
}
LUAT_RET luat_mutex_lock(void *mutex)
{
	return luat_rtos_semaphore_take(mutex, LUAT_WAIT_FOREVER);
}
LUAT_RET luat_mutex_unlock(void *mutex)
{
	return luat_rtos_semaphore_release(mutex);
}
void luat_mutex_release(void *mutex)
{
	luat_rtos_semaphore_delete(mutex);
}

int luat_rtos_semaphore_create(luat_rtos_semaphore_t *semaphore_handle, uint32_t init_count)
{
	if (!semaphore_handle) return -1;
	SemaphoreHandle_t sem = NULL;
	if (init_count <= 1)
	{
		sem = xSemaphoreCreateBinary();
		if (!sem)
			return -1;
		if (!init_count)
			xSemaphoreGive(sem);
	}
	else
	{
		sem = xSemaphoreCreateCounting(init_count, init_count);
		if (!sem)
			return -1;
	}
	*semaphore_handle = (luat_rtos_semaphore_t)sem;
	return 0;
}

int luat_rtos_semaphore_delete(luat_rtos_semaphore_t semaphore_handle)
{
	if (!semaphore_handle) return -1;
	vSemaphoreDelete(semaphore_handle);
	return 0;
}

int luat_rtos_semaphore_take(luat_rtos_semaphore_t semaphore_handle, uint32_t timeout)
{
	if (!semaphore_handle) return -1;
	if (pdTRUE == xSemaphoreTake(semaphore_handle, timeout))
		return 0;
	return -1;
}

int luat_rtos_semaphore_release(luat_rtos_semaphore_t semaphore_handle)
{
	if (!semaphore_handle) return -1;
	if (osIsInISRContext())
	{
		BaseType_t yield = pdFALSE;
		if (pdTRUE == xSemaphoreGiveFromISR(semaphore_handle, &yield))
		{
			portYIELD_FROM_ISR(yield);
			return 0;
		}
		return -1;
	}
	else
	{
		if (pdTRUE == xSemaphoreGive(semaphore_handle))
			return 0;
		return -1;
	}
}

int luat_rtos_mutex_create(luat_rtos_mutex_t *mutex_handle)
{
	if (!mutex_handle) return -1;
	QueueHandle_t pxNewQueue = NULL;
	pxNewQueue = xSemaphoreCreateRecursiveMutex();
	if (!pxNewQueue)
		return -1;
	*mutex_handle = pxNewQueue;
	return 0;
}

int luat_rtos_mutex_lock(luat_rtos_mutex_t mutex_handle, uint32_t timeout)
{
	if (!mutex_handle) return -1;
	if (pdFALSE == xSemaphoreTakeRecursive(mutex_handle, timeout))
		return -1;
	return 0;
}

int luat_rtos_mutex_unlock(luat_rtos_mutex_t mutex_handle)
{
	if (!mutex_handle) return -1;
	if (pdFALSE == xSemaphoreGiveRecursive(mutex_handle))
		return -1;
	return 0;
}

int luat_rtos_mutex_delete(luat_rtos_mutex_t mutex_handle)
{
	if (!mutex_handle) return -1;
	vSemaphoreDelete(mutex_handle);
	return 0;
}

int luat_rtos_queue_create(luat_rtos_queue_t *queue_handle, uint32_t item_count, uint32_t item_size)
{
	if (!queue_handle) return -1;
	QueueHandle_t pxNewQueue;
	pxNewQueue = xQueueCreate(item_count, item_size);
	if (!pxNewQueue)
		return -1;
	*queue_handle = pxNewQueue;
	return 0;
}

int luat_rtos_queue_delete(luat_rtos_queue_t queue_handle)
{
	if (!queue_handle) return -1;
    vQueueDelete ((QueueHandle_t)queue_handle);
	return 0;
}

int luat_rtos_queue_send(luat_rtos_queue_t queue_handle, void *item, uint32_t item_size, uint32_t timeout)
{
	if (!queue_handle || !item) return -1;
	if (osIsInISRContext())
	{
		BaseType_t pxHigherPriorityTaskWoken;
		if (xQueueSendToBackFromISR(queue_handle, item, &pxHigherPriorityTaskWoken) != pdPASS)
			return -1;
		portYIELD_FROM_ISR(pxHigherPriorityTaskWoken);
		return 0;
	}
	else
	{
		if (xQueueSendToBack (queue_handle, item, timeout) != pdPASS)
			return -1;
	}
	return 0;
}

int luat_rtos_queue_recv(luat_rtos_queue_t queue_handle, void *item, uint32_t item_size, uint32_t timeout)
{
	if (!queue_handle || !item)
		return -1;
	BaseType_t yield = pdFALSE;
	if (osIsInISRContext())
	{
		if (xQueueReceiveFromISR(queue_handle, item, &yield) != pdPASS)
			return -1;
		portYIELD_FROM_ISR(yield);
		return 0;
	}
	else
	{
		if (xQueueReceive(queue_handle, item, timeout) != pdPASS)
			return -1;
	}
	return 0;
}
static void s_timer_callback(TimerHandle_t hTimer)
{
	luat_rtos_user_timer_t *timer = (luat_rtos_user_timer_t *)pvTimerGetTimerID(hTimer);
	if (!timer)
		return;
	if (!timer->is_repeat)
	{
		xTimerStop(hTimer, 0);
	}
	if (timer->call_back)
	{
		timer->call_back(timer->user_param);
	}
}


/* ----------------------------------- timer ----------------------------------- */
void *luat_create_rtos_timer(void *cb, void *param, void *task_handle)
{
	luat_rtos_user_timer_t *timer = malloc(sizeof(luat_rtos_user_timer_t));
	if (timer)
	{
		timer->timer = xTimerCreate(NULL, 1, 1, timer, s_timer_callback);
		if (!timer->timer)
		{
			free(timer);
			return NULL;
		}
		timer->call_back = cb;
		timer->user_param = param;
		timer->is_repeat = 0;
	}
	return timer;
}
int luat_start_rtos_timer(void *timer, uint32_t ms, uint8_t is_repeat)
{
	luat_rtos_user_timer_t *htimer = (luat_rtos_user_timer_t *)timer;
	BaseType_t pxHigherPriorityTaskWoken;
    if (osIsInISRContext())
    {
		if ((xTimerStopFromISR(htimer->timer, &pxHigherPriorityTaskWoken) != pdPASS))
			return -1;
		htimer->is_repeat = is_repeat;
		if ((xTimerChangePeriodFromISR(htimer->timer, ms, &pxHigherPriorityTaskWoken) != pdPASS))
			return -1;
		portYIELD_FROM_ISR(pxHigherPriorityTaskWoken);
    }
    else
    {
        if (xTimerIsTimerActive (htimer->timer))
    	{
    		if (xTimerStop(htimer->timer, LUAT_WAIT_FOREVER) != pdPASS)
    			return -1;
        }
        htimer->is_repeat = is_repeat;
		if (xTimerChangePeriod(htimer->timer, ms, LUAT_WAIT_FOREVER) != pdPASS)
			return -1;
    }
	return 0;
}

void luat_stop_rtos_timer(void *timer)
{
	luat_rtos_user_timer_t *htimer = (luat_rtos_user_timer_t *)timer;

	if (osIsInISRContext())
	{
		BaseType_t pxHigherPriorityTaskWoken;
		if ((xTimerStopFromISR(htimer->timer, &pxHigherPriorityTaskWoken) != pdPASS))
			return ;
		portYIELD_FROM_ISR(pxHigherPriorityTaskWoken);
	}
	else
	{
		if (xTimerIsTimerActive (htimer->timer))
		{
			xTimerStop(htimer->timer, LUAT_WAIT_FOREVER);
		}
	}

}

void luat_release_rtos_timer(void *timer)
{
	luat_rtos_user_timer_t *htimer = (luat_rtos_user_timer_t *)timer;
	xTimerDelete(htimer->timer, LUAT_WAIT_FOREVER);
	free(htimer);
}


int luat_rtos_timer_start(luat_rtos_timer_t timer_handle, uint32_t timeout, uint8_t repeat, luat_rtos_timer_callback_t callback_fun, void *user_param)
{
	if (!timer_handle) return -1;
	luat_rtos_user_timer_t *htimer = (luat_rtos_user_timer_t *)timer_handle;
	BaseType_t pxHigherPriorityTaskWoken;
    if (osIsInISRContext())
    {
		if ((xTimerStopFromISR(htimer->timer, &pxHigherPriorityTaskWoken) != pdPASS))
			return -1;
	    htimer->is_repeat = repeat;
	    htimer->call_back = callback_fun;
	    htimer->user_param = user_param;
		if ((xTimerChangePeriodFromISR(htimer->timer, timeout, &pxHigherPriorityTaskWoken) != pdPASS))
			return -1;
		portYIELD_FROM_ISR(pxHigherPriorityTaskWoken);
    }
    else
    {
        if (xTimerIsTimerActive (htimer->timer))
    	{
    		if (xTimerStop(htimer->timer, LUAT_WAIT_FOREVER) != pdPASS)
    			return -1;
        }
        htimer->is_repeat = repeat;
        htimer->call_back = callback_fun;
        htimer->user_param = user_param;
		if (xTimerChangePeriod(htimer->timer, timeout, LUAT_WAIT_FOREVER) != pdPASS)
			return -1;
    }
	return 0;

}

int luat_rtos_timer_is_active(luat_rtos_timer_t timer_handle)
{
	if (!timer_handle) return -1;
	luat_rtos_user_timer_t *htimer = (luat_rtos_user_timer_t *)timer_handle;
	if (pdTRUE == xTimerIsTimerActive (htimer->timer))
		return 1;
	else
		return 0;
}

/*------------------------------------------------ timer   end----------------------------------------------- */

/* ------------------------------------------------ critical begin----------------------------------------------- */
/**
 * @brief 进入临界保护
 *
 * @return uint32_t 退出临界保护所需参数
 */
uint32_t luat_rtos_entry_critical(void)
{
	return OS_EnterCritical();
}

/**
 * @brief 退出临界保护
 *
 * @param critical 进入临界保护时返回的参数
 */
void luat_rtos_exit_critical(uint32_t critical)
{
	OS_ExitCritical(critical);
}
