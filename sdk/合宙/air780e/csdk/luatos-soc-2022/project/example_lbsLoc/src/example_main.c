#include "common_api.h"
#include "luat_debug.h"
#include "luat_rtos.h"
#include "luat_mobile.h"
#include "lbsLoc.h"
uint8_t link_UP = 0;
static void mobile_event_callback_t(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status)
{
    switch (event)
    {
    case LUAT_MOBILE_EVENT_NETIF:
        switch (status)
        {
        case LUAT_MOBILE_NETIF_LINK_ON:
            link_UP = 1;
            LUAT_DEBUG_PRINT("网络注册成功\r\n");
            break;
        default:
            LUAT_DEBUG_PRINT("网络未注册成功\r\n");
            link_UP = 0;
            break;
        }
    case LUAT_MOBILE_EVENT_SIM:
        switch (status)
        {
        case LUAT_MOBILE_SIM_READY:
            LUAT_DEBUG_PRINT("SIM卡已插入\r\n");
            break;
        case LUAT_MOBILE_NO_SIM:
        default:
            break;
        }
    case LUAT_MOBILE_EVENT_CELL_INFO:
        switch (status)
        {
        case LUAT_MOBILE_CELL_INFO_UPDATE:
            LUAT_DEBUG_PRINT("周期性搜索小区信息完成一次\r\n");
            break;
        default:
            break;
        }
    }
}



void lbsloc_demo_task(void *param)
{
    while (!link_UP)
    {
        luat_rtos_task_sleep(1000);
        LUAT_DEBUG_PRINT("等待网络注册");
    }
    luat_rtos_task_sleep(15000);
    while (1)
    {
        lbsloc_Init();
        luat_rtos_task_sleep(30000);
    }
}

void lbsloc_demo_Init(void)
{
    luat_rtos_task_handle lbsloc_demo_task_handle;
    luat_rtos_task_create(&lbsloc_demo_task_handle, 4 * 2048, 60, "lbsloc_demo_task", lbsloc_demo_task, NULL, NULL);
}
void mobile_event_task(void)
{
    luat_mobile_event_register_handler(mobile_event_callback_t);
}
INIT_HW_EXPORT(mobile_event_task, "0");
INIT_TASK_EXPORT(lbsloc_demo_Init,"1");
