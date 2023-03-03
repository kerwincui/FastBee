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


#ifndef LUAT_OTP_H
#define LUAT_OTP_H
#include "luat_base.h"
/**
 * @defgroup luatos_otp OTP操作
 * @{
 */

/**
 * @brief 读取指定区域的OTP数据
 * 
 * @param zone OTP的区域, 通常为1,2,3等整数,与设备相关
 * @param buff[OUT] 读出的数据
 * @param offset 偏移量, 通常为0
 * @param len 读取长度, offset+len不能超过OTP区域的长度
 * @return int <= 0错误 >0实际传出的大小
 */
int luat_otp_read(int zone, char* buff, size_t offset, size_t len);

/**
 * @brief 写入指定区域的OTP数据
 * 
 * @param zone OTP的区域, 通常为1,2,3等整数,与设备相关
 * @param buff[IN] 写入的数据
 * @param offset 偏移量, 通常为0
 * @param len 读取长度, offset+len不能超过OTP区域的长度
 * @return int <= 0错误 >0实际写入的大小
 */
int luat_otp_write(int zone, char* buff, size_t offset, size_t len);
/**
 * @brief 抹除指定区域的OTP数据
 * 
 * @param zone OTP的区域, 通常为1,2,3等整数,与设备相关
 * @param offset 偏移量, 通常为0, 大部分设备只支持整个区域的抹除,该参数无效
 * @param len 抹除长度,通常为区域大小. 若设备只支持正常抹除,该参数无效
 * @return int != 0错误 =0 正常
 */
int luat_otp_erase(int zone, size_t offset, size_t len);
/**
 * @brief 锁定指定区域的OTP数据,不再可写,不可抹除
 * 
 * @param zone OTP的区域, 通常为1,2,3等整数,与设备相关
 * @return int != 0错误 =0 正常
 */
int luat_otp_lock(int zone);
/**
 * @brief 指定区域的OTP区域大小
 * 
 * @param zone OTP的区域, 通常为1,2,3等整数,与设备相关
 * @return int == 0 无该区域, > 0 区域大小, 例如 256, 512
 */
int luat_otp_size(int zone);


/**
 * @}
 */
#endif
