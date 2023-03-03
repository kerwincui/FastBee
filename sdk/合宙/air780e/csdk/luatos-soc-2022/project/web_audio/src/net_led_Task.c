#include "net_led_Task.h"
#include "audio_Task.h"
extern QueueHandle_t audioQueueHandle;
uint8_t link_UP = 0;
/*-----------------------------------------------------------mobile event----------------------------------------------------------*/
static void mobile_event_callback_t(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status)
{
    switch (event)
    {
    case LUAT_MOBILE_EVENT_NETIF:
        switch (status)
        {
        case LUAT_MOBILE_NETIF_LINK_ON:
            LUAT_DEBUG_PRINT("ÍøÂç×¢²á³É¹¦");
            link_UP = 1;
            audioQueueData net_link = {0};
            net_link.playType = TTS_PLAY;
            net_link.priority = MONEY_PLAY;
            char str[] = "ÍøÂç×¢²á³É¹¦";
            net_link.message.tts.data = malloc(sizeof(str));
            memcpy(net_link.message.tts.data, str, sizeof(str));
            net_link.message.tts.len = sizeof(str);
            if (pdTRUE != xQueueSend(audioQueueHandle, &net_link, 0))
            {
                LUAT_DEBUG_PRINT("start send audio fail");
            }
            break;
        default:
            link_UP = 0;
            LUAT_DEBUG_PRINT("ÍøÂç×¢²áÊ§°Ü");
            break;
        }
    case LUAT_MOBILE_EVENT_SIM:
        switch (status)
        {
        case LUAT_MOBILE_SIM_READY:break;
        case LUAT_MOBILE_NO_SIM:
            LUAT_DEBUG_PRINT("Çë²åÈëSIM¿¨");
            audioQueueData sim_state = {0};
            sim_state.playType = TTS_PLAY;
            sim_state.priority = MONEY_PLAY;
            char str[] = "Çë²åÈëÎ÷Ä¾¿¨";
            sim_state.message.tts.data = malloc(sizeof(str));
            memcpy(sim_state.message.tts.data, str, sizeof(str));
            sim_state.message.tts.len = sizeof(str);
            if (pdTRUE != xQueueSend(audioQueueHandle, &sim_state, 0))
            {
                LUAT_DEBUG_PRINT("start send audio fail");
            }
        default:
            break;
        }
    default:
        break;
    }
}
void Task_netinfo_call(void)
{
    luat_mobile_event_register_handler(mobile_event_callback_t);
}
/*-----------------------------------------------------------mobile event-------------------------------------------------------*/


/*-----------------------------------------------------------NET_LED begin-------------------------------------------------------*/
static void NET_LED_FUN(void *param)
{
    luat_gpio_cfg_t net_led_cfg;
    luat_gpio_set_default_cfg(&net_led_cfg);

    net_led_cfg.pin=NET_LED_PIN;
    luat_gpio_open(&net_led_cfg);
    while (1)
    {
        if (link_UP)
        {
            luat_gpio_set(NET_LED_PIN,1);
            luat_rtos_task_sleep(500);
            luat_gpio_set(NET_LED_PIN,0);
            luat_rtos_task_sleep(500);
        }
        else
        {
            luat_gpio_set(NET_LED_PIN,0);
            luat_rtos_task_sleep(500);
        }
        
    }
    
}

void NET_LED_Task(void)
{
    luat_rtos_task_handle NET_LED_Task_HANDLE;
    luat_rtos_task_create(&NET_LED_Task_HANDLE,1*1024,20,"NET_LED_TASK",NET_LED_FUN,NULL,NULL);
}