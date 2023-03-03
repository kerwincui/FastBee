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

#ifndef LUAT_FOTA_H
#define LUAT_FOTA_H
/**
 * @defgroup luatos_fota 远程升级接口
 * @{
 */


/**
 * @brief 升级包数据的上下文结构体
 * 
 */
typedef void* luat_fota_img_proc_ctx_ptr;


/**
 * @brief 用于初始化fota,创建写入升级包数据的上下文结构体
 * 
 * @param 
 * @return luat_fota_img_proc_ctx_ptr 
 */
luat_fota_img_proc_ctx_ptr luat_fota_init(void);

/**
 * @brief 用于向本地 Flash 中写入升级包数据
 * 
 * @param context - 上下文结构体指针
 * @param data - 升级包数据地址
 * @param len - 升级包数据长度。 单位：字节
 * @return int =0成功，其他失败；
 */
int luat_fota_write(luat_fota_img_proc_ctx_ptr context, void * data, int len);

/**
 * @brief 用于结束升级包下载
 * 
 * @param context - 上下文结构体指针
 * @return int =0成功，其他失败
 */
int luat_fota_done(luat_fota_img_proc_ctx_ptr context);
/** @}*/
#endif