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

#ifndef LUAT_MEM_H
#define LUAT_MEM_H
/**
 * @defgroup luatos_mem 内存管理
 * @{
 */
#include "stdint.h"
/**
 * @brief 在堆区分配一块指定大小的内存空间，用来存放数据
 * 
 * @param len 开辟内存的长度大小
 * @return NULL 失败 !NULL 成功
 */

void* luat_heap_malloc(size_t len);

/**
 * @brief 释放ptr所指向的内存块,释放的是动态分配的内存空间
 * 
 * @param ptr 所指向的内存块
 */
void  luat_heap_free(void* ptr);

/**
 * @brief 重新分配内存，把内存扩展到 len
 * 
 * @param ptr 所指向的内存块
 * @param len 长度
 */
void* luat_heap_realloc(void* ptr, size_t len);
/**
 * @brief 在内存中动态地分配 count 个长度为 size_t 的连续空间，并将每一个字节都初始化为 0
 * 
 * @param count 长度
 * @param _size 数据类型
 * @return NULL 失败 ，!NULL 成功
 */
void* luat_heap_calloc(size_t count, size_t _size);
/**
 * @brief 获取内存使用信息
 * 
 * @param[out] total 模组总的的内存大小
 * @param[out] used 获取当前已分配的内存堆大小
 * @param[out] max_used 获取当前最大已分配的内存堆大小
 */
void luat_meminfo_sys(size_t* total, size_t* used, size_t* max_used);


#define LUAT_MEM_MALLOC luat_heap_malloc ///< 在堆区分配一块指定大小的内存空间，用来存放数据
#define LUAT_MEM_FREE luat_heap_free ///< 释放ptr所指向的内存块,释放的是动态分配的内存空间
#define LUAT_MEM_REALLOC luat_heap_realloc ///< 重新分配内存，把内存扩展到 len
#define LUAT_MEM_CALLOC luat_heap_calloc ///< 在内存中动态地分配 count 个长度为 size_t 的连续空间，并将每一个字节都初始化为 0

#define LUAT_MEM_INFO luat_meminfo_sys ///< 获取内存使用信息
/**
 * @}
 */
#endif