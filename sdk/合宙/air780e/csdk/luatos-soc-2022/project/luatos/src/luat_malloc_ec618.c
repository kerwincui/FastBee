
#include "common_api.h"
#include "FreeRTOS.h"
#include "task.h"

#include <stdlib.h>
#include <string.h>//add for memset
#include "bget.h"
#include "luat_base.h"
#include "luat_malloc.h"

#define LUAT_LOG_TAG "vmheap"
#include "luat_log.h"


#include "mm_debug.h"//add for memory leak debug
#include "exception_process.h"
#include "cmsis_compiler.h"
#include "tlsf.h"
#include "mem_map.h"
#ifndef LUAT_HEAP_SIZE
#ifdef LOW_SPEED_SERVICE_ONLY
#define LUAT_HEAP_SIZE (200*1024)
#else
#define LUAT_HEAP_SIZE (128*1024)
#endif
#endif
static uint8_t vmheap[LUAT_HEAP_SIZE] __attribute__((aligned(8)));


//------------------------------------------------
// ---------- 管理 LuaVM所使用的内存----------------

#if 1
void luat_heap_init(void) {
    bpool(vmheap, LUAT_HEAP_SIZE);
}

void* luat_heap_alloc(void *ud, void *ptr, size_t osize, size_t nsize) {
    if (ptr == NULL && nsize == 0)
        return NULL;
#if LUAT_USE_MEMORY_OPTIMIZATION_CODE_MMAP
    if (ptr != NULL) {
        uint32_t addr = (uint32_t) ptr;
        if (addr <= (uint32_t)vmheap || addr >= (uint32_t)(vmheap + LUAT_HEAP_SIZE)) {
            //LLOGD("skip ROM free %p", ptr);
            return NULL;
        }
    }
#endif

    if (nsize)
    {
    	void* ptmp = bgetr(ptr, nsize);
    	if(ptmp == NULL && osize >= nsize)
    	{
    		return ptr;
    	}
        return ptmp;
    }
    brel(ptr);
    return NULL;
}

void luat_meminfo_luavm(size_t *total, size_t *used, size_t *max_used) {
	long curalloc, totfree, maxfree;
	unsigned long nget, nrel;
	bstats(&curalloc, &totfree, &maxfree, &nget, &nrel);
	*used = curalloc;
	*max_used = bstatsmaxget();
    *total = curalloc + totfree;
}

#else
static tlsf_t luavm_tlsf;

void luat_heap_init(void) {
    luavm_tlsf = tlsf_create_with_pool((void*)vmheap, LUAT_HEAP_SIZE);
}

void* luat_heap_alloc(void *ud, void *ptr, size_t osize, size_t nsize) {
    if (ptr == NULL && nsize == 0)
        return NULL;
#if LUAT_USE_MEMORY_OPTIMIZATION_CODE_MMAP
    if (ptr != NULL && nsize == 0) {
        uint32_t addr = (uint32_t) ptr;
        if (addr <= (uint32_t)vmheap || addr >= (uint32_t)(vmheap + LUAT_HEAP_SIZE)) {
            //LLOGD("skip ROM free %p", ptr);
            return NULL;
        }
    }
#endif
    return tlsf_realloc(luavm_tlsf, ptr, nsize, (size_t)luat_heap_alloc);
}
void luat_meminfo_luavm(size_t *total, size_t *used, size_t *max_used) {
    *total = LUAT_HEAP_SIZE;
    *used = LUAT_HEAP_SIZE - tlsf_mem_size_free(luavm_tlsf);
    *max_used = LUAT_HEAP_SIZE - tlsf_mem_size_ever_min(luavm_tlsf);
}
#endif

//-----------------------------------------------------------------------------

