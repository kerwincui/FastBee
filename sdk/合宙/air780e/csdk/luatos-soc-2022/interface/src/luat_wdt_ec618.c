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

#include "wdt.h"
#include "clock.h"
#include "slpman.h"

int luat_wdt_setup(size_t timeout)
{
    if(timeout < 1 || timeout > 60)
    {
        return -1;
    }
    GPR_setClockSrc(FCLK_WDG, FCLK_WDG_SEL_32K);
    GPR_setClockDiv(FCLK_WDG, timeout);

    WdtConfig_t wdtConfig;
    wdtConfig.mode = WDT_INTERRUPT_RESET_MODE;
    wdtConfig.timeoutValue = 32768U;
    WDT_init(&wdtConfig);
    WDT_start();
    return 0;
}

int luat_wdt_set_timeout(size_t timeout)
{
    if(timeout < 1 || timeout > 60)
    {
        return -1;
    }
    WDT_kick();
    WDT_stop();
    WDT_deInit();
    luat_wdt_setup(timeout);
    return 0;
}

int luat_wdt_feed(void)
{
    WDT_kick();
    slpManAonWdtFeed();
    return 0;
}

int luat_wdt_close(void)
{
    WDT_stop();
    WDT_deInit();
    return 0;
}
