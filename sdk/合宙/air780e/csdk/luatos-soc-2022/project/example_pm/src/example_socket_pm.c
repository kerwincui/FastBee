#include "common_api.h"
#include "sockets.h"
#include "dns.h"
#include "lwip/ip4_addr.h"
#include "netdb.h"
#include "luat_debug.h"
#include "luat_rtos.h"
#include "luat_mobile.h"
#include "string.h"
#include "luat_pm.h"
#define DEMO_SERVER_TCP_IP "112.125.89.8"
#define DEMO_SERVER_TCP_PORT 34724
#define TEST_TAG "test_tag"
static uint8_t link_UP; // 网络状态指示
static luat_rtos_task_handle tcp_task_handle;
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
            LUAT_DEBUG_PRINT("SIM卡未插入");
        default:
            break;
        }
    default:
        break;
    }
}
static void register_moblie_callback(void)
{
    luat_mobile_event_register_handler(mobile_event_callback_t);
}

static luat_pm_deep_sleep_mode_timer_callback_t timer2_cb(LUAT_PM_DEEPSLEEP_TIMERID_E id)
{
    LUAT_DEBUG_PRINT("test timeout timer id %d", id);
}

static void init_deepsleep_timer_cb(void)
{
    luat_pm_deep_sleep_mode_register_timer_cb(LUAT_PM_DEEPSLEEP_TIMER_ID2, timer2_cb);
}

static void demo_socket_pm_task(void *arg)
{
    int retry_times = 0;
    char helloworld[] = "helloworld";
    char txbuf[128] = {0};

    ip_addr_t remote_ip;
    struct sockaddr_in name;
    socklen_t sockaddr_t_size = sizeof(name);
    int ret, h_errnop;
    struct timeval to;
    int socket_id = -1;
    struct hostent dns_result;
    struct hostent *p_result;

    luat_pm_wakeup_pad_cfg_t cfg = {0};
    cfg.neg_edge_enable = 1;
    cfg.pos_edge_enable = 0;
    cfg.pull_up_enable = 1;
    cfg.pull_down_enable = 0;
    luat_pm_wakeup_pad_set(true, LUAT_PM_WAKEUP_PAD_0, &cfg); // 配置wakeup中断，深度休眠也可以通过wakeup唤醒
    luat_pm_wakeup_pad_set(true, LUAT_PM_WAKEUP_PAD_3, &cfg);
    luat_pm_wakeup_pad_set(true, LUAT_PM_WAKEUP_PAD_4, &cfg);
    luat_rtos_task_sleep(2000);
    int wakeup_reason = luat_pm_get_wakeup_reason();
    LUAT_DEBUG_PRINT("wakeup reason %d", wakeup_reason);
    if (wakeup_reason != LUAT_PM_WAKEUP_FROM_POR)
    {
        if (LUAT_PM_WAKEUP_FROM_PAD == wakeup_reason)
        {
            int timer2_status = luat_pm_deep_sleep_mode_timer_is_running(LUAT_PM_DEEPSLEEP_TIMER_ID2);
            LUAT_DEBUG_PRINT("this is timer running status %d", timer2_status);
            if (1 == timer2_status)
            {
                luat_pm_deep_sleep_mode_timer_stop(LUAT_PM_DEEPSLEEP_TIMER_ID2);
            }
            timer2_status = luat_pm_deep_sleep_mode_timer_is_running(LUAT_PM_DEEPSLEEP_TIMER_ID2);
            LUAT_DEBUG_PRINT("this is timer running status %d", timer2_status);
        }
        luat_mobile_set_flymode(0, 0); // 进休眠模式前控制进入了飞行模式，唤醒后需要退出飞行模式
    }

    while (!link_UP)
    {
        luat_rtos_task_sleep(1000);
        LUAT_DEBUG_PRINT("等待网络注册");
    }

    ret = lwip_gethostbyname_r(DEMO_SERVER_TCP_IP, &dns_result, txbuf, 128, &p_result, &h_errnop);
    if (!ret)
    {
        remote_ip = *((ip_addr_t *)dns_result.h_addr_list[0]);
    }
    else
    {
        luat_rtos_task_sleep(1000);
        LUAT_DEBUG_PRINT("dns fail");
    }

    while (retry_times < 3)
    {
        socket_id = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
        memset(&name, 0, sizeof(name));
        name.sin_family = AF_INET;
        name.sin_addr.s_addr = remote_ip.u_addr.ip4.addr;
        name.sin_port = htons(DEMO_SERVER_TCP_PORT);
        ret = connect(socket_id, (const struct sockaddr *)&name, sockaddr_t_size);
        if (0 == ret)
        {
            LUAT_DEBUG_PRINT("tcp demo connect success %d", ret);
            ret = send(socket_id, helloworld, strlen(helloworld), 0);
            if (ret == strlen(helloworld)) // 发送数据成功后进入深度休眠模式测试
            {
                close(socket_id);
                socket_id = -1;
                LUAT_DEBUG_PRINT("tcp demo send data success");
                goto exit;
            }
            else
            {
                LUAT_DEBUG_PRINT("tcp demo send data fail");
            }
        }
        else
        {
            LUAT_DEBUG_PRINT("tcp demo connect fail %d", ret);
        }
        close(socket_id);
        socket_id = -1;
        retry_times++;
        luat_rtos_task_sleep(5000);
    }
exit:
    LUAT_DEBUG_PRINT("socket quit");
    luat_rtos_task_sleep(3000);
    luat_mobile_set_flymode(0, 1); // 进入飞行模式
    luat_rtos_task_sleep(2000);
    luat_pm_set_usb_power(0); // 关闭usb电源
    luat_rtos_task_sleep(2000);
    luat_pm_deep_sleep_mode_timer_start(LUAT_PM_DEEPSLEEP_TIMER_ID2, 86400000); // 开启深度休眠定时器，24小时
    luat_pm_set_sleep_mode(LUAT_PM_SLEEP_MODE_STANDBY, TEST_TAG);               // 进入深度休眠模式
    luat_rtos_task_sleep(5000);
    LUAT_DEBUG_PRINT("entry deepsleep mode fail");
    luat_rtos_task_delete(tcp_task_handle);
}

void demo_socket_pm_init(void)
{
    luat_rtos_task_create(&tcp_task_handle, 4 * 2048, 80, "socket_pm", demo_socket_pm_task, NULL, NULL);
}

INIT_HW_EXPORT(register_moblie_callback, "1");
INIT_HW_EXPORT(init_deepsleep_timer_cb, "1");
INIT_TASK_EXPORT(demo_socket_pm_init, "1");
