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
#include "wdt.h"
#include "luat_pm.h"
#include "luat_rtos.h"
#include "luat_mobile.h"
#include "luat_sms.h"
#include "luat_network_adapter.h"
#include "ps_event_callback.h"
#include "networkmgr.h"
#include "plat_config.h"
#include "driver_gpio.h"
#ifdef LUAT_USE_LVGL
#include "lvgl.h"
#include "luat_lvgl.h"
#endif
#include "luat_errdump.h"

extern int luat_main(void);
extern void luat_heap_init(void);
const char *soc_get_sdk_type(void)
{
	return "LuatOS-SoC";
}
const char *soc_get_sdk_version(void)
{
	return LUAT_BSP_VERSION;
}
luat_rtos_timer_t lvgl_timer_handle;
#ifdef LUAT_USE_LVGL
#define LVGL_TICK_PERIOD	10
unsigned int g_lvgl_flash_time;
static uint32_t lvgl_tick_cnt;

static int luat_lvg_handler(lua_State* L, void* ptr) {
//	DBG("%u", lv_tick_get());
	if (lvgl_tick_cnt) lvgl_tick_cnt--;
    lv_task_handler();
    return 0;
}

static void luat_lvgl_callback(void *param){
	if (lvgl_tick_cnt < 5)
	{
		lvgl_tick_cnt++;
	    rtos_msg_t msg = {0};
	    msg.handler = luat_lvg_handler;
	    luat_msgbus_put(&msg, 0);
	}
}

void luat_lvgl_tick_sleep(uint8_t OnOff)
{
	if (!OnOff)
	{
		luat_rtos_timer_start(lvgl_timer_handle, LVGL_TICK_PERIOD, true, luat_lvgl_callback, NULL);
	}
	else
	{
		luat_rtos_timer_stop(lvgl_timer_handle);
	}
}

#else
void luat_lvgl_tick_sleep(uint8_t OnOff)
{

}
#endif
extern int soc_mobile_get_default_pdp_part_info(uint8_t *ip_type, uint8_t *apn,uint8_t *apn_len, uint8_t *dns_num, ip_addr_t *dns_ip);


//static INT32 ps_callback(PsEventID eventID, void *param, UINT32 paramLen)
//{
//	NmAtiNetInfoInd *net_info = (NmAtiNetInfoInd *)param;
//	ip_addr_t dns_ip;
//	if(PS_URC_ID_PS_NETINFO == eventID)
//	{
//		if (NM_NETIF_ACTIVATED == net_info->netifInfo.netStatus)
//		{
//			if (net_info->netifInfo.ipv4Cid != 0xFF)
//			{
//				dns_ip.type = IPADDR_TYPE_V4;
//				dns_ip.u_addr.ip4 = net_info->netifInfo.ipv4Info.dns[0];
//				network_set_dns_server(NW_ADAPTER_INDEX_LWIP_GPRS, 2, &dns_ip);
//				dns_ip.u_addr.ip4 = net_info->netifInfo.ipv4Info.dns[1];
//				network_set_dns_server(NW_ADAPTER_INDEX_LWIP_GPRS, 3, &dns_ip);
//
//			}
//			else if (net_info->netifInfo.ipv6Cid != 0xFF)
//			{
//				// dns_ip.type = IPADDR_TYPE_V6;
//				// dns_ip.u_addr.ip6 = net_info->netifInfo.ipv6Info.dns[0];
//				// network_set_dns_server(NW_ADAPTER_INDEX_LWIP_GPRS, 3, &dns_ip);
//				//dns_ip.u_addr.ip6 = net_info->netifInfo.ipv6Info.dns[1];
//				//network_set_dns_server(NW_ADAPTER_INDEX_LWIP_GPRS, 3, &dns_ip);
//			}
//			net_lwip_set_link_state(NW_ADAPTER_INDEX_LWIP_GPRS, 1);
//		}
//	}
//	return 0;
//}

//static void dft_usb_recv_cb(uint8_t channel, uint8_t *input, uint32_t len){
//    if (input == NULL) {
//        switch(len){
//            case 0:
//                LLOGD("usb serial connected");
//                break;
//            default:
//                LLOGD("usb serial disconnected");
//                break;
//		}
//    }
//#ifdef LUAT_USE_SHELL
//    else {
//        luat_shell_push(input, len);
//    }
//#endif
//}
extern int soc_get_model_name(char *model);

static void luat_main_print_model(void)
{
	char temp[40] = {0};
	soc_get_model_name(temp);
	DBG("model %s", temp);
}

static void luatos_task(void *param)
{
	BSP_SetPlatConfigItemValue(PLAT_CONFIG_ITEM_FAULT_ACTION, EXCEP_OPTION_DUMP_FLASH_EPAT_RESET);
    if(BSP_GetPlatConfigItemValue(PLAT_CONFIG_ITEM_FAULT_ACTION) == EXCEP_OPTION_SILENT_RESET)
        ResetLockupCfg(true, true);
    else
        ResetLockupCfg(false, false);

	luat_heap_init();
	luat_main_print_model();
#ifdef LUAT_USE_MEDIA
	luat_audio_global_init();
#endif
//	set_usb_serial_input_callback(dft_usb_recv_cb);
	//DBG("LuatOS starting ...");

#ifdef LUAT_USE_LVGL
	g_lvgl_flash_time = 33;
    lv_init();
	luat_rtos_timer_create(&lvgl_timer_handle);

#ifdef __LVGL_SLEEP_ENABLE__
    luat_lvgl_tick_sleep(1);
#else
    luat_rtos_timer_start(lvgl_timer_handle, LVGL_TICK_PERIOD, true, luat_lvgl_callback, NULL);
#endif

#endif
	luat_pm_init();
	luat_main();
	while (1) {
		DBG("LuatOS exit"); // TODO 咋就没重启呢
		luat_rtos_task_sleep(15000);
		luat_os_reboot(0);
	}
}

void luat_mobile_event_cb(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status);
void luat_sms_recv_cb(uint32_t event, void *param);

static void luatos_mobile_event_callback(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status)
{
	if (LUAT_MOBILE_EVENT_NETIF == event)
	{
		if (LUAT_MOBILE_NETIF_LINK_ON == status)
		{
			ip_addr_t dns_ip[2];
			uint8_t type, dns_num;
			dns_num = 2;
			soc_mobile_get_default_pdp_part_info(&type, NULL, NULL, &dns_num, dns_ip);
			if (dns_num > 0)
			{
				network_set_dns_server(NW_ADAPTER_INDEX_LWIP_GPRS, 2, &dns_ip[0]);
				if (dns_num > 1)
				{
					network_set_dns_server(NW_ADAPTER_INDEX_LWIP_GPRS, 3, &dns_ip[1]);
				}
			}
			net_lwip_set_link_state(NW_ADAPTER_INDEX_LWIP_GPRS, 1);
		}
	}
	luat_mobile_event_cb(event, index, status);
}

static void luatos_task_init(void)
{
	GPIO_GlobalInit(NULL);
	luat_mobile_event_register_handler(luatos_mobile_event_callback);
	luat_sms_init();
	luat_sms_recv_msg_register_handler(luat_sms_recv_cb);
	net_lwip_init();
	net_lwip_register_adapter(NW_ADAPTER_INDEX_LWIP_GPRS);
	network_register_set_default(NW_ADAPTER_INDEX_LWIP_GPRS);
	luat_rtos_task_handle task_handle;
	// xTaskCreateStatic(task1, "luatos", VM_STACK_SIZE, NULL, 20, s_vm_stackbuff, pxVMTaskTCBBuffer);
	luat_rtos_task_create(&task_handle, 16 * 1024, 80, "luatos", luatos_task, NULL, 0);

}
extern void luat_pm_preinit(void);
INIT_DRV_EXPORT(luat_pm_preinit, "1");
INIT_HW_EXPORT(luatos_task_init, "1");


