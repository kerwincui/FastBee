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

#ifndef LUAT_DEBUG_H
#define LUAT_DEBUG_H

/**
 * @defgroup luatos_debug  调式接口
 * @{
 */

/**
 * @brief 出现异常后系统处理
 * 
 */
typedef enum LUAT_DEBUG_FAULT_MODE
{
	LUAT_DEBUG_FAULT_RESET, /**< 出现异常后重启 */
	LUAT_DEBUG_FAULT_HANG /**< 出现异常后死机 */
}LUAT_DEBUG_FAULT_MODE_E;

/**
 * @brief 格式打印并输出到LOG口
 * 
 * @param fmt 格式
 * @param ... 后续变量
 */
void luat_debug_print(const char *fmt, ...);
/**
 * @brief luat_debug_print宏定义为LUAT_DEBUG_PRINT
 * @param fmt 格式
 * @param ... 后续变量
 */
#define LUAT_DEBUG_PRINT(fmt, argv...) luat_debug_print("%s %d:"fmt, __FUNCTION__,__LINE__, ##argv)

/**
 * @brief 断言处理，并格式打印输出到LOG口
 * 
 * @param fun_name 断言的函数 
 * @param line_no 行号
 * @param fmt 格式
 * @param ... 后续变量
 */
void luat_debug_assert(const char *fun_name, unsigned int line_no, const char *fmt, ...);


#define LUAT_DEBUG_ASSERT(condition, fmt, argv...)  do {  \
														{ \
															if((condition) == 0) \
															{ \
																luat_debug_assert(__FUNCTION__, __LINE__, fmt, ##argv); \
															}\
														} \
													} while(0) ///< luat_debug_assert宏定义为LUAT_DEBUG_ASSERT

/**
 * @brief 设置出现异常后系统处理模式
 * 
 * @param mode 处理模式  LUAT_DEBUG_FAULT_RESET 重启模式
                        LUAT_DEBUG_FAULT_HANG  死机模式
 */
void luat_debug_set_fault_mode(LUAT_DEBUG_FAULT_MODE_E mode);

/** @}*/

#endif
