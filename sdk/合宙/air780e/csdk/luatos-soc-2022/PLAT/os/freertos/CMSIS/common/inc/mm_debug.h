/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    mm_debug.h
 * Description:  EC618 memory management debug log
 * History:      04/02/2018    Originated by bchang
 *
 ****************************************************************************/
#define MM_DEBUG_EN
#define HEAP_MEM_DEBUG

#define MM_TRACE_ON     0   // 0: mm trace on close  1: trace with 128 node  2: trace with 1024 node


void mm_trace_init(void);
void mm_malloc_trace(void* buffer, unsigned long length,unsigned int func_lr);
void mm_free_trace(void* buffer);
void show_mem_trace(void);
