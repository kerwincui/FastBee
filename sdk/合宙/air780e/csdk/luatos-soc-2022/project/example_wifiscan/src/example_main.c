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


#include "common_api.h"
#include "luat_rtos.h"
#include "luat_mem.h"
#include "luat_debug.h"
#include "luat_wifiscan.h"
#include "luat_mobile.h"

luat_rtos_task_handle Wifiscan_Task_Handle;
uint8_t link_UP = 0;
static void Wifiscan_Task(void *param)
{
    int32_t ret;
    CHAR Wifiscan_req[64] = {0};
    while (!link_UP)
    {
        luat_rtos_task_sleep(1000);
    }
    luat_wifiscan_set_info_t wifiscan_info;
    luat_wifisacn_get_info_t wifiscan_getinfo;
    wifiscan_info.maxTimeOut = 10000;
    wifiscan_info.round = 1;
    wifiscan_info.maxBssidNum = LUAT_MAX_WIFI_BSSID_NUM;
    wifiscan_info.scanTimeOut = 3;
    wifiscan_info.wifiPriority = LUAT_WIFISCAN_DATA_PERFERRD;
    while (1)
    {
        luat_rtos_task_sleep(2000);
        ret = luat_get_wifiscan_cell_info(&wifiscan_info, &wifiscan_getinfo);
        if (ret == 0)
        {
            for (size_t i = 0; i < wifiscan_getinfo.bssidNum; i++)
            {
                memset(Wifiscan_req, 0, sizeof(Wifiscan_req));
                snprintf(Wifiscan_req, 64, "\"%02x:%02x:%02x:%02x:%02x:%02x\",%d,%d", wifiscan_getinfo.bssid[i][0], wifiscan_getinfo.bssid[i][1], wifiscan_getinfo.bssid[i][2],
                         wifiscan_getinfo.bssid[i][3], wifiscan_getinfo.bssid[i][4], wifiscan_getinfo.bssid[i][5], wifiscan_getinfo.rssi[i], wifiscan_getinfo.channel[i]);
                LUAT_DEBUG_PRINT("wifiscan result %s", Wifiscan_req);
            }
        }
    }
}

static void mobile_event_callback_t(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status)
{
    switch (event)
    {
    case LUAT_MOBILE_EVENT_NETIF:
        switch (status)
        {
        case LUAT_MOBILE_NETIF_LINK_ON:
            link_UP = 1;
            LUAT_DEBUG_PRINT("网络注册成功");
            break;
        default:
            LUAT_DEBUG_PRINT("网络未注册成功");
            link_UP = 0;
            break;
        }
    case LUAT_MOBILE_EVENT_SIM:
        switch (status)
        {
        case LUAT_MOBILE_SIM_READY:
            LUAT_DEBUG_PRINT("SIM卡已插入");
            break;
        case LUAT_MOBILE_NO_SIM:
        default:
            break;
        }
    default:
        break;
    }
}
void Mobile_event_Task(void)
{
    luat_mobile_event_register_handler(mobile_event_callback_t);
}

static void Wifiscan_demo_Init(void)
{
	luat_rtos_task_create(&Wifiscan_Task_Handle, 4*1024, 60, "Wifiscan_Task", Wifiscan_Task, NULL, NULL);
}
INIT_HW_EXPORT(Mobile_event_Task, "1");
INIT_TASK_EXPORT(Wifiscan_demo_Init, "2");