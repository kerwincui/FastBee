#ifndef __COMMON_API_H__
#define __COMMON_API_H__
#include "stdint.h"
#include "stdarg.h"
#include "string.h"
#include "stdio.h"
#include "stdbool.h"
#include "bsp_common.h"
#include "platform_define.h"

#ifdef LOW_SPEED_SERVICE_ONLY
#define PS_DIAL_PS_UP_MEM_SIZE      248000
#else   //Full speed version
#define PS_DIAL_PS_UP_MEM_SIZE      421000
#endif

enum
{
	I2S_MODE_I2S,
	I2S_MODE_LSB,
	I2S_MODE_MSB,
	I2S_FRAME_SIZE_16_16,
	I2S_FRAME_SIZE_16_32,
	I2S_FRAME_SIZE_24_32,
	I2S_FRAME_SIZE_32_32,
};

typedef void (* usb_serial_in)(uint8_t channel, uint8_t *input, uint32_t len);
typedef void (*pad_wakeup_fun_t)(uint32_t pad_num);
/**
 * @brief 格式化打印输出log，在EPAT工具里是customer luatos
 * @param fmt 打印格式
 * @param ... 参数
 */
void soc_printf(const char *fmt, ...);

/**
 * @brief 直接输出string，在EPAT工具里是customer luatos
 * 
 * @param string 需要输出的字符串
 * @param size 字符串长度，可以选为0
 */
void soc_debug_out(char *string, uint32_t size);

/**
 * @brief 设置USB串口输入的回调函数
 * 
 * @param cb_fun 回调函数
 */
void soc_set_usb_serial_input_callback(usb_serial_in cb_fun);
#define set_usb_serial_input_callback(x)	soc_set_usb_serial_input_callback(x)

/**
 * @brief USB串口输出
 * 
 * @param channel USB串口通道，目前默认是4，或者与输入时的channel保持一致 * @param output 输出的数据
 * @param len 输出的数据长度
 * @return int 0成功，其他失败
 */
int soc_usb_serial_output(uint8_t channel, uint8_t *output, uint32_t len);
#define usb_serial_output(x,y,z)	soc_usb_serial_output(x,y,z)
/**
 * @brief 设置低功耗模式下,wakeuppad唤醒中断回调，注意这是在中断回调
 * 
 * @param cb_fun 
 */
void soc_set_pad_wakeup_callback(pad_wakeup_fun_t cb_fun);
#define set_pad_wakeup_callback(x)	soc_set_pad_wakeup_callback(x)
/**
 * @brief 创建一个带event收发机制的task，event就是一个16byte的queue，在创建task的时候，同时创建好了一个queue，event结构见OS_EVENT
 * 
 * @param task_fun task的入口函数
 * @param param task的入口参数
 * @param stack_bytes task的堆栈长度，单位byte，会强制4字节对齐
 * @param priority task的任务优先级，注意是百分比，0~100，100为底层OS允许的最高级，0为底层OS允许的最低级
 * @param task_name task的name
 * @param event_max_cnt，如果OS不带mailbox，就需要本参数来创建queue
 * @return void* task的句柄，后续收发event都需要这个参数，NULL为创建失败
 */
void *create_event_task(TaskFun_t task_fun, void *param, uint32_t stack_bytes, uint8_t priority, uint16_t event_max_cnt, const char *task_name);

/**
 * @brief 删除掉一个带event收发机制的task，比正常删除task多了一步删除event queue。
 * 
 * @param task_handle task的句柄
 */
void delete_event_task(void *task_handle);

/**
 * @brief 发送一个event给task
 * 
 * @param task_handle task的句柄
 * @param event 一个已经构建好的event，如果传入指针不为NULL，将忽略后续4个参数，反之，会由后续4个参数构建一个event，每个函数参数对应event内同名参数
 * @param event_id 需要构建的event id
 * @param param1 需要构建的param1
 * @param param2 需要构建的param2
 * @param param3 需要构建的param3
 * @param timeout_ms 发送的超时时间，0不等待，0xffffffff永远等待，建议就直接写0
 * @return int 成功返回0，其他都是失败
 */
int send_event_to_task(void *task_handle, OS_EVENT *event, uint32_t event_id, uint32_t param1, uint32_t param2, uint32_t param3, uint32_t timeout_ms);

/**
 * @brief 获取一个event，并根据需要返回
 * 如果target_event_id != 0 && != 0xffffffff，那么收到对应event id时返回，如果不是，则由callback交给用户临时处理，如果callback为空，则抛弃掉
 * 如果target_event_id == 0，收到消息就返回
 * 如果target_event_id == 0xffffffff，收到消息则由callback交给用户临时处理，如果callback为空，则抛弃掉
 * 
 * @param task_handle task的句柄
 * @param target_event_id 指定收到的event id
 * @param event 缓存event的空间，当收到需要的event时，缓存在这里
 * @param callback 在收到不需要的event时，回调给用户处理，回调函数中的第一个参数就是event指针，第二个参数是task句柄。这里可以为NULL，直接抛弃event
 * @param timeout_ms 0和0xffffffff永远等待，建议就直接写0
 * @return int 收到需要的event返回0
 */
int get_event_from_task(void *task_handle, uint32_t target_event_id, OS_EVENT *event,  CBFuncEx_t callback, uint32_t timeout_ms);

/**
 * @brief 获取开机到现在的ms时间
 * 
 * @return uint64_t 
 */
uint64_t soc_get_poweron_time_ms(void);

uint64_t soc_get_poweron_time_tick(void);
/**
 * @brief 获取堆信息
 * 
 * @param total 总量
 * @param total_free 剩余量
 * @param min_free 历史最小运行量，同时也对应历史最大使用量
 */
void soc_get_heap_info(uint32_t *total, uint32_t *total_free, uint32_t *min_free);
/**
 * @brief 请求改变全局低功耗状态
 *
 * @param state 0全速 1IDLE 2SLEEP
 */
void soc_require_lowpower_state(uint8_t state);

/**
 * @brief 初始成sleep1，必须在init fun里，在task里就无效了
 */
void soc_force_init_sleep(void);
/**
 * @brief usb交由用户决定开启和关闭，必须在init fun里，在task里就无效了
 */
void soc_force_usb_user_ctrl(void);
/**
 * @brief 用户手动控制USB开关
 *
 * @param onoff 1打开，0关闭
 */
void soc_usb_onoff(uint8_t onoff);

uint8_t soc_usb_stack_onoff_state(void);
uint32_t soc_get_utc(void);
uint64_t soc_get_utc_ms(void);
int soc_get_sn(char *sn, uint8_t buf_size);
/**
 * @brief 中断里释放动态分配的ram，本质上是放到一个专门的task里去free
 *
 * @param point malloc得到的指针
 * @return 0成功，其他失败
 */
int soc_free_later(void *point);
/*
 * 函数放到系统服务里运行，堆栈小，优先级高
 */
int soc_call_function_in_service(CBDataFun_t CB, uint32_t data, uint32_t param, uint32_t timeout);
/*
 * 函数放到audio服务里运行，堆栈大，优先级低，必须先初始化audio
 */
int soc_call_function_in_audio(CBDataFun_t CB, uint32_t data, uint32_t param, uint32_t timeout);
/**
 * @brief 带函数名称和位置的格式化打印
 * 
 */
#define DBG(X,Y...) soc_printf("%s %d:"X, __FUNCTION__,__LINE__,##Y)

#endif
