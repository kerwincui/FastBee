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
#include "FreeRTOS.h"
#include "task.h"

#include "ps_event_callback.h"
#include "ps_lib_api.h"
#include "sockets.h"
#include "networkmgr.h"
#include "netdb.h"
#include "slpman.h"
#include "time.h"
#include "sntp.h"
#include "plat_config.h"
#include "semphr.h"
typedef struct
{
	ip_addr_t remote_ip;
	ip_addr_t local_ip;
	void *wait_link_sem;
	void *wait_dns_sem;
	void *heart_timer;
	void *pa_delay_timer;
	int socket_id;
	uint8_t is_link_up;
	uint8_t ipv4_cid;
	uint8_t ipv6_cid;
}demo_ctrl_t;

static demo_ctrl_t g_s_demo;

static INT32 ps_callback(PsEventID eventID, void *param, UINT32 paramLen)
{
    CmiSimImsiStr *imsi = NULL;
    CmiPsCeregInd *creg = NULL;
    NmAtiNetInfoInd *net_info = NULL;

    switch(eventID)
    {
        case PS_URC_ID_SIM_READY:
        {
            imsi = (CmiSimImsiStr *)param;
            DBG("SIM ready(imsi=%s len=%d)", imsi->contents, imsi->length);
            break;
        }
        case PS_URC_ID_PS_BEARER_ACTED:
        {
        	DBG("Default bearer activated");
            break;
        }
        case PS_URC_ID_PS_BEARER_DEACTED:
        {
        	DBG("Default bearer Deactivated");
            break;
        }
        case PS_URC_ID_PS_CEREG_CHANGED:
        {
            creg = (CmiPsCeregInd *)param;
            DBG("CREG message act:%d celId:%d locPresent:%d state:%d", creg->act, creg->celId, creg->locPresent, creg->state);
            break;
        }
        case PS_URC_ID_PS_NETINFO:
        {
            net_info = (NmAtiNetInfoInd *)param;
			DBG("%d,%d,%d,%d", net_info->indCause, net_info->netifInfo.netStatus, net_info->netifInfo.ipv4Cid, net_info->netifInfo.ipv6Cid);
			switch(net_info->indCause)
			{
			case NM_STATUS_CHANGE_LINK_UP:
			case NM_STATUS_CHANGE_LINK_UP_IPV4:
			case NM_STATUS_CHANGE_LINK_UP_IPV6:
			case NM_STATUS_CHANGE_RA_SUCCESS:
				DBG("network ready");
				if (!g_s_demo.is_link_up)
				{
					g_s_demo.is_link_up = 1;
					xSemaphoreGive(g_s_demo.wait_link_sem);
				}
				break;
			default:
				g_s_demo.is_link_up = 0;
				DBG("network not ready");
				break;
			}

			if (NM_NETIF_ACTIVATED == net_info->netifInfo.netStatus)
			{
				g_s_demo.ipv4_cid = net_info->netifInfo.ipv4Cid;
				g_s_demo.ipv6_cid = net_info->netifInfo.ipv6Cid;
				g_s_demo.local_ip.type = IPADDR_TYPE_V4;
				g_s_demo.local_ip.u_addr.ip4 = net_info->netifInfo.ipv4Info.ipv4Addr;
			}
            break;
        }
        default:
            break;

    }
    return 0;
}

static int32_t ntp_callback(void *data, void *param)
{
	sntp_result_t *result = (sntp_result_t *)data;
	DBG("%d,%d,%d", result->succ, result->sec, result->us);
	return 0;
}

static void task_test_ntp(void *param)
{
	uint8_t ntp_sleep_handler;
	slpManSetPmuSleepMode(true, SLP_HIB_STATE, false);
	slpManApplyPlatVoteHandle("ntp", &ntp_sleep_handler);
	slpManPlatVoteDisableSleep(ntp_sleep_handler, SLP_SLP2_STATE);

    g_s_demo.wait_link_sem = xSemaphoreCreateBinary();

    registerPSEventCallback(PS_GROUP_ALL_MASK, ps_callback);

    xSemaphoreTake(g_s_demo.wait_link_sem, portMAX_DELAY);
    SntpInit("ntp1.aliyun.com", SNTP_DEFAULT_PORT, 1, g_s_demo.ipv4_cid, ntp_callback, NULL);
    while(1)
    {
        vTaskDelay(300000);
        if (!g_s_demo.is_link_up)
        {
        	xSemaphoreTake(g_s_demo.wait_link_sem, portMAX_DELAY);
        }
        SntpInit("ntp1.aliyun.com", SNTP_DEFAULT_PORT, 1, g_s_demo.ipv4_cid, ntp_callback, NULL);
    }

	vTaskDelete(NULL);
}

static void task_demo_ntp(void)
{
	xTaskCreate(task_test_ntp, "ntp", 1024, NULL, 20, NULL);
}
//启动task_demoF_init，启动位置任务2级
INIT_TASK_EXPORT(task_demo_ntp, "1");

