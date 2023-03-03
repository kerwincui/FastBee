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
#include "luat_mobile.h"
#include "luat_debug.h"

static void sms_event_cb(uint32_t event, void *param)
{
	LUAT_DEBUG_PRINT("短信event%d,%x",event, param);
}

static void mobile_event_cb(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status)
{
	luat_mobile_cell_info_t cell_info;
	luat_mobile_signal_strength_info_t signal_info;
	uint8_t csq, i;
	char imsi[20];
	char iccid[24] = {0};
	char apn[32] = {0};
	ip_addr_t ipv4;
	ip_addr_t ipv6;
	switch(event)
	{
	case LUAT_MOBILE_EVENT_CFUN:
		LUAT_DEBUG_PRINT("CFUN消息，status %d", status);
		break;
	case LUAT_MOBILE_EVENT_SIM:
		LUAT_DEBUG_PRINT("SIM卡消息，卡槽%d", index);
		switch(status)
		{
		case LUAT_MOBILE_SIM_READY:
			LUAT_DEBUG_PRINT("SIM卡正常工作");
			luat_mobile_get_iccid(0, iccid, sizeof(iccid));
			LUAT_DEBUG_PRINT("ICCID %s", iccid);
			luat_mobile_get_imsi(0, imsi, sizeof(imsi));
			LUAT_DEBUG_PRINT("IMSI %s", imsi);
			break;
		case LUAT_MOBILE_NO_SIM:
			LUAT_DEBUG_PRINT("SIM卡不存在");
			break;
		case LUAT_MOBILE_SIM_NEED_PIN:
			LUAT_DEBUG_PRINT("SIM卡需要输入PIN码");
			break;
		}
		break;
	case LUAT_MOBILE_EVENT_REGISTER_STATUS:
		LUAT_DEBUG_PRINT("移动网络服务状态变更，当前为%d", status);
		break;
	case LUAT_MOBILE_EVENT_CELL_INFO:
		switch(status)
		{
		case LUAT_MOBILE_CELL_INFO_UPDATE:
			LUAT_DEBUG_PRINT("周期性搜索小区信息完成一次");
			luat_mobile_get_last_notify_cell_info(&cell_info);
			if (cell_info.lte_service_info.cid)
			{
				LUAT_DEBUG_PRINT("服务小区信息 mcc %x mnc %x cellid %u band %d tac %u pci %u earfcn %u is_tdd %d rsrp %d rsrq %d snr %d rssi %d",
						cell_info.lte_service_info.mcc, cell_info.lte_service_info.mnc, cell_info.lte_service_info.cid,
						cell_info.lte_service_info.band, cell_info.lte_service_info.tac, cell_info.lte_service_info.pci, cell_info.lte_service_info.earfcn,
						cell_info.lte_service_info.is_tdd, cell_info.lte_service_info.rsrp, cell_info.lte_service_info.rsrq,
						cell_info.lte_service_info.snr, cell_info.lte_service_info.rssi);
			}
			for (i = 0; i < cell_info.lte_neighbor_info_num; i++)
			{
				if (cell_info.lte_info[i].cid)
				{
					LUAT_DEBUG_PRINT("邻小区 %d mcc %x mnc %x cellid %u tac %u pci %u", i + 1, cell_info.lte_info[i].mcc,
							cell_info.lte_info[i].mnc, cell_info.lte_info[i].cid, cell_info.lte_info[i].tac, cell_info.lte_info[i].pci);
					LUAT_DEBUG_PRINT("邻小区 %d earfcn %u rsrp %d rsrq %d snr %d", i + 1, cell_info.lte_info[i].earfcn, cell_info.lte_info[i].rsrp,
							cell_info.lte_info[i].rsrq, cell_info.lte_info[i].snr);
				}
			}
			break;
		case LUAT_MOBILE_SIGNAL_UPDATE:
			LUAT_DEBUG_PRINT("服务小区信号状态变更");
			luat_mobile_get_last_notify_signal_strength_info(&signal_info);
			luat_mobile_get_last_notify_signal_strength(&csq);
			if (signal_info.luat_mobile_lte_signal_strength_vaild)
			{
				LUAT_DEBUG_PRINT("rsrp %d, rsrq %d, snr %d, rssi %d, csq %d %d", signal_info.lte_signal_strength.rsrp,
						signal_info.lte_signal_strength.rsrq, signal_info.lte_signal_strength.snr,
						signal_info.lte_signal_strength.rssi, csq, luat_mobile_rssi_to_csq(signal_info.lte_signal_strength.rssi));
			}

			break;
		}
		break;
	case LUAT_MOBILE_EVENT_PDP:
		LUAT_DEBUG_PRINT("CID %d PDP激活状态变更为 %d", index, status);
		break;
	case LUAT_MOBILE_EVENT_NETIF:
		LUAT_DEBUG_PRINT("internet工作状态变更为 %d", status);
		switch (status)
		{
		case LUAT_MOBILE_NETIF_LINK_ON:
			LUAT_DEBUG_PRINT("可以上网");
			if (luat_mobile_get_apn(0, 0, apn, sizeof(apn)))
			{
				LUAT_DEBUG_PRINT("默认apn %s", apn);
			}
			luat_mobile_get_local_ip(0, 1, &ipv4, &ipv6);
			if (ipv4.type != 0xff)
			{
				LUAT_DEBUG_PRINT("IPV4 %s", ip4addr_ntoa(&ipv4.u_addr.ip4));
			}
			if (ipv6.type != 0xff)
			{
				LUAT_DEBUG_PRINT("IPV6 %s", ip6addr_ntoa(&ipv4.u_addr.ip6));
			}
			break;
		default:
			LUAT_DEBUG_PRINT("不能上网");
			break;
		}
		break;
	case LUAT_MOBILE_EVENT_TIME_SYNC:
		LUAT_DEBUG_PRINT("通过移动网络同步了UTC时间");
		break;
	case LUAT_MOBILE_EVENT_CSCON:
		LUAT_DEBUG_PRINT("RRC状态 %d", status);
		break;
	default:
		break;
	}
}

static void task_run(void *param)
{
	int i;
	luat_mobile_cell_info_t  cell_info;

	char imei[20] = {0};
	luat_mobile_get_imei(0, imei, sizeof(imei));
	LUAT_DEBUG_PRINT("IMEI %s", imei);

	luat_mobile_set_sn("1234567890abcdefghijklmnopqrstuv",32);
	char sn[33] = {0};
	luat_mobile_get_sn(sn, sizeof(sn));
	LUAT_DEBUG_PRINT("SN %s", sn);

	char muid[64] = {0};
	luat_mobile_get_muid(muid, sizeof(muid));
	LUAT_DEBUG_PRINT("MUID %s", muid);


	while(1)
	{
		luat_rtos_task_sleep(10000);
		luat_mobile_set_sim_id(0);
		luat_rtos_task_sleep(10000);
		luat_mobile_set_sim_id(1);
		luat_rtos_task_sleep(10000);
		luat_mobile_set_sim_id(2);	//自动识别时，需要手动重启协议栈，或者启动SIM卡自动恢复功能
		luat_mobile_reset_stack();
		luat_rtos_task_sleep(15000);
		LUAT_DEBUG_PRINT("手动获取一次周围小区信息，异步方式");
		luat_mobile_get_cell_info_async(6);
		luat_rtos_task_sleep(15000);
		LUAT_DEBUG_PRINT("手动获取一次周围小区信息，同步方式");
		luat_mobile_get_cell_info(&cell_info);
		if (cell_info.lte_service_info.cid)
		{
			LUAT_DEBUG_PRINT("服务小区信息 mcc %x mnc %x cellid %u band %d tac %u pci %u earfcn %u is_tdd %d rsrp %d rsrq %d snr %d rssi %d",
					cell_info.lte_service_info.mcc, cell_info.lte_service_info.mnc, cell_info.lte_service_info.cid,
					cell_info.lte_service_info.band, cell_info.lte_service_info.tac, cell_info.lte_service_info.pci, cell_info.lte_service_info.earfcn,
					cell_info.lte_service_info.is_tdd, cell_info.lte_service_info.rsrp, cell_info.lte_service_info.rsrq,
					cell_info.lte_service_info.snr, cell_info.lte_service_info.rssi);
		}
		for (i = 0; i < cell_info.lte_neighbor_info_num; i++)
		{
			if (cell_info.lte_info[i].cid)
			{
				LUAT_DEBUG_PRINT("邻小区 %d mcc %x mnc %x cellid %u tac %u pci %u", i + 1, cell_info.lte_info[i].mcc,
						cell_info.lte_info[i].mnc, cell_info.lte_info[i].cid, cell_info.lte_info[i].tac, cell_info.lte_info[i].pci);
				LUAT_DEBUG_PRINT("邻小区 %d earfcn %u rsrp %d rsrq %d snr %d", i + 1, cell_info.lte_info[i].earfcn, cell_info.lte_info[i].rsrp,
						cell_info.lte_info[i].rsrq, cell_info.lte_info[i].snr);
			}
		}

	}
}

void task_init(void)
{
	luat_mobile_event_register_handler(mobile_event_cb);
	luat_mobile_sms_event_register_handler(sms_event_cb);
	luat_mobile_set_period_work(90000, 0, 4);
	luat_mobile_set_sim_id(2);
	luat_rtos_task_handle task_handle;
	luat_rtos_task_create(&task_handle, 4 * 1204, 50, "test", task_run, NULL, 32);
}

INIT_TASK_EXPORT(task_init, "0");
