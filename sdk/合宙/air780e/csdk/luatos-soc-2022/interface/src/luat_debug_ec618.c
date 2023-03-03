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

#include "luat_debug.h"
#include "common_api.h"
#include "plat_config.h"
#include "reset.h"

extern void soc_assert(const char *fun_name, uint32_t line_no, const char *fmt, va_list ap);
extern void soc_vsprintf(uint8_t no_print, const char *fmt, va_list ap);
void luat_debug_set_fault_mode(LUAT_DEBUG_FAULT_MODE_E mode)
{
	BSP_SetPlatConfigItemValue(PLAT_CONFIG_ITEM_FAULT_ACTION, (LUAT_DEBUG_FAULT_RESET == mode)?4:0);
    if(BSP_GetPlatConfigItemValue(PLAT_CONFIG_ITEM_FAULT_ACTION) == EXCEP_OPTION_SILENT_RESET)
        ResetLockupCfg(true, true);
    else

        ResetLockupCfg(false, false);
}

void luat_debug_assert(const char *fun_name, unsigned int line_no, const char *fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	soc_assert(fun_name, line_no, fmt, ap);
	va_end(ap);
}

void luat_debug_print(const char *fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	soc_vsprintf(0, fmt, ap);
	va_end(ap);
}
