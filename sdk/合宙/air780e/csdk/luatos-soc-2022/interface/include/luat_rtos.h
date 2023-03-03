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

#ifndef LUAT_RTOS_H
#define LUAT_RTOS_H

#include "luat_base.h"
#include "luat_rtos_legacy.h"

/**
 * @defgroup luatos_os  操作系统接口
 * @{
 */

/**
 * @brief LUAT_RTOS 超时时间枚举值
 */
typedef enum LUAT_RTOS_WAIT
{
	LUAT_NO_WAIT = 0,						 /**< 超时时间为0 */
	LUAT_WAIT_FOREVER = (uint32_t)0xFFFFFFFF /**< 最大超时时间0xFFFFFFFF*/
} LUAT_RTOS_WAIT_E;

/* ------------------------------------------------ task begin------------------------------------------------ */
/**
 * @defgroup  luatos_os_Task 线程任务接口函数
 * @{
 */

/**
 *@brief task的入口函数,函数类型
 */
typedef void (*luat_rtos_task_entry) (void*);
/**
 *@brief 定义task任务句柄
 */
typedef void * luat_rtos_task_handle;
/**
 * @brief 创建一个可以带mailbox机制的task
 * 
 * @param task_handle[OUT] 返回创建的句柄
 * @param stack_size task的栈空间大小，单位byte，必须4字节对齐
 * @param priority 优先级，单位是百分比，0%~100%,100%为最高等级，由具体实现转换到底层SDK用的优先级
 * @param task_name task名字
 * @param task_fun task的入口函数
 * @param user_data task的入口参数
 * @param event_cout =0表示不需要使用mailbox机制，>0表示启用mailbox，可以使用下列event和massage api，同时如果底层SDK不支持mailbox，会创建一个queue模拟mailbox，queue里元素为luat_event_t，数量为event_cout
 * @return int =0成功，其他失败
 */
int luat_rtos_task_create(luat_rtos_task_handle *task_handle, uint32_t stack_size, uint8_t priority, const char *task_name, luat_rtos_task_entry task_fun, void* user_data, uint16_t event_cout);

/**
 * @brief 删除task
 * 
 * @param task_handle 
 * @return int =0成功，其他失败
 */
int luat_rtos_task_delete(luat_rtos_task_handle task_handle);

/**
 * @brief 挂起某个task
 * 
 * @param task_handle task句柄
 * @return int =0成功，其他失败
 */
int luat_rtos_task_suspend(luat_rtos_task_handle task_handle);

/**
 * @brief 恢复挂起的task
 * 
 * @param task_handle task句柄
 * @return int =0成功，其他失败
 */
int luat_rtos_task_resume(luat_rtos_task_handle task_handle);

/**
 * @brief 挂起全部task
 * 
 */
void luat_rtos_task_suspend_all(void);

/**
 * @brief 恢复全部task
 * 
 */
void luat_rtos_task_resume_all(void);

/**
 * @brief task休眠一段时间
 * 
 * @param ms 休眠时间，单位ms
 */
void luat_rtos_task_sleep(uint32_t ms);

/**
 * @brief 获取当前task的句柄
 * 
 * @return luat_rtos_task_handle 当前task的句柄
 */
luat_rtos_task_handle luat_rtos_get_current_handle(void);

/**
 * @brief 获取task堆栈剩余的最小值，叫做“高水位线”
 * 
 * @param luat_rtos_task_handle task的句柄
 * @return task堆栈剩余的最小值,单位为字
 */

uint32_t luat_rtos_task_get_high_water_mark(luat_rtos_task_handle task_handle);

/** @}*/
/* ------------------------------------------------ task   end------------------------------------------------ */
/**
 * @defgroup  luatos_os_event 消息事件函数
 * @{
 */
/* ----------------------------------------------- event begin---------------------------------------------- */
/**
 * @brief 在等待event中，如果设置了目标event id，而到来的不是目标event id，可以通过回调函数交给用户处理
 * 
 */
typedef LUAT_RT_RET_TYPE (*luat_rtos_event_wait_callback_t)(LUAT_RT_CB_PARAM);

/**
 * @brief 发送一个event给task的mailbox，只有设置了mailbox启用的task能接收
 * 
 * @param task_handle 需要接收event的task句柄
 * @param id event id
 * @param param1 event参数1
 * @param param2 event参数2
 * @param param3 event参数3
 * @param timeout 发送超时，在task发送才有，单位ms，特殊值见LUAT_RTOS_WAIT_E
 * @return int =0成功，其他失败
 */
int luat_rtos_event_send(luat_rtos_task_handle task_handle, uint32_t id, uint32_t param1, uint32_t param2, uint32_t param3, uint32_t timeout);

/**
 * @brief 接收一个event，只能在task里接收
 * 
 * @param task_handle 需要接收event的task句柄
 * @param wait_event_id 目标event的ID，=0表示不限制，任意event id都会返回
 * @param out_event[OUT] 接收到的event
 * @param callback_fun event的ID不是目标ID时，用户回调函数，可以为NULL，从而抛弃掉这个event
 * @param timeout 接收超时，单位ms，特殊值见LUAT_RTOS_WAIT_E
 * @return int =0成功，其他失败
 */
int luat_rtos_event_recv(luat_rtos_task_handle task_handle, uint32_t wait_event_id, luat_event_t *out_event, luat_rtos_event_wait_callback_t *callback_fun, uint32_t timeout);

/* ----------------------------------------------- event end---------------------------------------------- */

/* ----------------------------------------------- message begin---------------------------------------------- */
/**
 * @brief 发送一个message给task的mailbox，只有设置了mailbox启用的task能接收，message可以动态创建的，可以任意大小
 * 
 * @param task_handle 需要接收massage的task句柄
 * @param message_id message id
 * @param p_message message内容，传入指针，如果动态创建，需要在接收时释放
 * @return int =0成功，其他失败
 */
int luat_rtos_message_send(luat_rtos_task_handle task_handle, uint32_t message_id, void *p_message);

/**
 * @brief 接收一个message，只能在task里接收
 * 
 * @param task_handle 需要接收massage的task句柄
 * @param message_id[OUT] 接收到的message id
 * @param p_p_message[OUT] message内容，输出一个void *指针，如果是发送时动态创建的，需要释放掉
 * @param timeout 接收超时，单位ms，特殊值见LUAT_RTOS_WAIT_E
 * @return int =0成功，其他失败
 */
int luat_rtos_message_recv(luat_rtos_task_handle task_handle, uint32_t *message_id, void **p_p_message, uint32_t timeout);
/** @}*/

/* ----------------------------------------------- message   end---------------------------------------------- */

/**
 * @defgroup  luatos_os_semaphore 信号量接口函数
 * @{
 */

/* ---------------------------------------------- semaphore begin--------------------------------------------- */
/**
 * @brief 定义信号量句柄
 */
typedef void * luat_rtos_semaphore_t;
/**
 * @brief 信号量创建，可以在中断中release
 * 
 * @param semaphore_handle[OUT] 信号量句柄
 * @param init_count 初始值
 * @return int =0成功，其他失败
 */
int luat_rtos_semaphore_create(luat_rtos_semaphore_t *semaphore_handle, uint32_t init_count);

/**
 * @brief 删除信号量
 * 
 * @param semaphore_handle 信号量句柄
 * @return int =0成功，其他失败
 */
int luat_rtos_semaphore_delete(luat_rtos_semaphore_t semaphore_handle);

/**
 * @brief 信号量等待获取
 * 
 * @param semaphore_handle 信号量句柄
 * @param timeout 接收超时，单位ms，特殊值见LUAT_RTOS_WAIT_E
 * @return int =0成功，其他失败
 */
int luat_rtos_semaphore_take(luat_rtos_semaphore_t semaphore_handle, uint32_t timeout);

/**
 * @brief 信号量释放发送
 * 
 * @param semaphore_handle 信号量句柄
 * @return int =0成功，其他失败
 */
int luat_rtos_semaphore_release(luat_rtos_semaphore_t semaphore_handle);
/* ---------------------------------------------- semaphore   end--------------------------------------------- */
/** @}*/

/**
 * @defgroup  luatos_os_mutex 互斥锁接口函数
 * @{
 */
/* ------------------------------------------------ mutex begin----------------------------------------------- */
/**
 * @brief 定义mutex句柄
 */
typedef void * luat_rtos_mutex_t;
/**
 * @brief 互斥锁创建，不能在中断中unlock
 * 
 * @param mutex_handle[OUT] 互斥锁句柄
 * @return int =0成功，其他失败
 */
int luat_rtos_mutex_create(luat_rtos_mutex_t *mutex_handle);

/**
 * @brief 获得锁
 * 
 * @param mutex_handle 互斥锁句柄
 * @param timeout 超时，单位ms，特殊值见LUAT_RTOS_WAIT_E
 * @return int =0成功，其他失败
 */
int luat_rtos_mutex_lock(luat_rtos_mutex_t mutex_handle, uint32_t timeout);

/**
 * @brief 释放锁
 * 
 * @param mutex_handle 互斥锁句柄
 * @return int =0成功，其他失败
 */
int luat_rtos_mutex_unlock(luat_rtos_mutex_t mutex_handle);

/**
 * @brief 删除互斥锁
 * 
 * @param mutex_handle 互斥锁句柄
 * @return int =0成功，其他失败
 */
int luat_rtos_mutex_delete(luat_rtos_mutex_t mutex_handle);

/* ------------------------------------------------ mutex   end----------------------------------------------- */
/** @}*/

/**
 * @defgroup  luatos_os_queue 队列接口函数
 * @{
 */
/* ------------------------------------------------ queue begin----------------------------------------------- */

/**
 * @brief 定义队列句柄
 */
typedef void * luat_rtos_queue_t;
/**
 * @brief 创建队列
 * 
 * @param queue_handle[OUT] 返回的队列句柄
 * @param msgcount 队列里元素的最大数量
 * @param msgsize 队列里单个元素的大小
 * @return int =0成功，其他失败
 */
int luat_rtos_queue_create(luat_rtos_queue_t *queue_handle, uint32_t item_count, uint32_t item_size);

/**
 * @brief 删除队列
 * 
 * @param queue_handle 队列句柄
 * @return int =0成功，其他失败
 */
int luat_rtos_queue_delete(luat_rtos_queue_t queue_handle);

/**
 * @brief 往队列里发送一个元素
 * 
 * @param queue_handle 队列句柄
 * @param item 元素指针
 * @param item_size 元素大小，这个是兼容性参数，实际上必须于创建时的item_size一致，所以忽略
 * @param timeout 超时，单位ms，特殊值见LUAT_RTOS_WAIT_E
 * @return int =0成功，其他失败
 */
int luat_rtos_queue_send(luat_rtos_queue_t queue_handle, void *item, uint32_t item_size, uint32_t timeout);

/**
 * @brief 从队列里取出一个元素
 * 
 * @param queue_handle 队列句柄
 * @param item 元素指针
 * @param item_size 元素大小，这个是兼容性参数，实际上必须于创建时的item_size一致，所以忽略
 * @param timeout 超时，单位ms，特殊值见LUAT_RTOS_WAIT_E
 * @return int =0成功，其他失败
 */
int luat_rtos_queue_recv(luat_rtos_queue_t queue_handle, void *item, uint32_t item_size, uint32_t timeout);
/* ------------------------------------------------ queue   end----------------------------------------------- */
/** @}*/

/**
 * @defgroup  luatos_os_timer 软件定时器接口函数
 * @{
 */

/* ------------------------------------------------ timer begin----------------------------------------------- */
/**
 * @brief 定时器头数据类型
 */
typedef void * luat_rtos_timer_t;
/**
 * @brief 定义定时器处理函数
 */
typedef LUAT_RT_RET_TYPE (*luat_rtos_timer_callback_t)(LUAT_RT_CB_PARAM);
/**
 * @brief 创建软件定时器
 * 
 * @param timer_handle[OUT] 返回定时器句柄
 * @return int =0成功，其他失败
 */
int luat_rtos_timer_create(luat_rtos_timer_t *timer_handle);

/**
 * @brief 删除软件定时器
 * 
 * @param timer_handle 定时器句柄
 * @return int =0成功，其他失败
 */
int luat_rtos_timer_delete(luat_rtos_timer_t timer_handle);

/**
 * @brief 启动软件定时器
 * 
 * @param timer_handle 定时器句柄
 * @param timeout 超时时间，单位ms，没有特殊值
 * @param repeat 0不重复，其他重复
 * @param callback_fun 定时时间到后的回调函数
 * @param user_param 回调函数时的最后一个输入参数
 * @return int =0成功，其他失败
 */
int luat_rtos_timer_start(luat_rtos_timer_t timer_handle, uint32_t timeout, uint8_t repeat, luat_rtos_timer_callback_t callback_fun, void *user_param);

/**
 * @brief 停止软件定时器
 * 
 * @param timer_handle 定时器句柄
 * @return int =0成功，其他失败
 */
int luat_rtos_timer_stop(luat_rtos_timer_t timer_handle);

/**
 * @brief 检测软件定时器是否处于激活状态
 * 
 * @param timer_handle 定时器句柄
 * @return int =0未激活，1激活，其他失败
 */
int luat_rtos_timer_is_active(luat_rtos_timer_t timer_handle);

/*------------------------------------------------ timer   end----------------------------------------------- */
/** @}*/

/**
 * @defgroup  luatos_os_critical 临界保护接口函数
 * @{
 */

/* ------------------------------------------------ critical begin----------------------------------------------- */
/**
 * @brief 进入临界保护
 * 
 * @return uint32_t 退出临界保护所需参数
 */
uint32_t luat_rtos_entry_critical(void);

/**
 * @brief 退出临界保护
 * 
 * @param critical 进入临界保护时返回的参数
 */
void luat_rtos_exit_critical(uint32_t critical);
/*------------------------------------------------ critical   end----------------------------------------------- */
/** @}*/
/** @}*/
#endif
