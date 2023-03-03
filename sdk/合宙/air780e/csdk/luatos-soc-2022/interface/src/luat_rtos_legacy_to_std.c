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

#include "luat_base.h"
#include "luat_rtos.h"
#include "luat_rtos_legacy.h"

LUAT_WEAK void luat_rtos_task_suspend_all(void)
{
	luat_task_suspend_all();
}
LUAT_WEAK void luat_rtos_task_resume_all(void)
{
	luat_task_resume_all();
}

luat_rtos_task_handle luat_rtos_get_current_handle(void)
{
	return luat_get_current_task();
}

LUAT_WEAK int luat_rtos_event_send(luat_rtos_task_handle task_handle, uint32_t id, uint32_t param1, uint32_t param2, uint32_t param3, uint32_t timeout)
{
	if (!task_handle) return -1;
	return luat_send_event_to_task(task_handle, id, param1, param2, param3);
}
LUAT_WEAK int luat_rtos_event_recv(luat_rtos_task_handle task_handle, uint32_t wait_event_id, luat_event_t *out_event, luat_rtos_event_wait_callback_t *callback_fun, uint32_t timeout)
{
	if (!task_handle) return -1;
	return luat_wait_event_from_task(task_handle, wait_event_id, out_event, callback_fun, timeout);
}
LUAT_WEAK int luat_rtos_message_send(luat_rtos_task_handle task_handle, uint32_t message_id, void *p_message)
{
	if (!task_handle) return -1;
	return luat_send_event_to_task(task_handle, message_id, p_message, 0, 0);
}
LUAT_WEAK int luat_rtos_message_recv(luat_rtos_task_handle task_handle, uint32_t *message_id, void **p_p_message, uint32_t timeout)
{
	if (!task_handle) return -1;
	luat_event_t event;
	int result = luat_wait_event_from_task(task_handle, 0, &event, 0, timeout);
	if (!result)
	{
		*message_id = event.id;
		*p_p_message = (void *)event.param1;
	}
	return result;
}

LUAT_WEAK int luat_rtos_timer_create(luat_rtos_timer_t *timer_handle)
{
	if (!timer_handle) return -1;
	*timer_handle = luat_create_rtos_timer(NULL, NULL, NULL);
	return (*timer_handle)?0:-1;
}

LUAT_WEAK int luat_rtos_timer_stop(luat_rtos_timer_t timer_handle)
{
	if (!timer_handle) return -1;
	luat_stop_rtos_timer(timer_handle);
	return 0;
}

LUAT_WEAK int luat_rtos_timer_delete(luat_rtos_timer_t timer_handle)
{
	if (!timer_handle) return -1;
	luat_release_rtos_timer(timer_handle);
	return 0;
}
