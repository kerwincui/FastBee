#include "luat_debug.h"
#include "luat_rtos.h"
#include "mqtt_publish.h"
#include "MQTTClient.h"
luat_rtos_task_handle mqtt_publish_task_handle = NULL;
extern uint8_t g_s_is_link_up;
void mqtt_publish_task(void *args)
{
    uint32_t id; // 暂时没什么用，因为只有publish的时候才会触发这条消息
    int rc;
    MQTTClient *mqttClient;
    mqttClient = (MQTTClient *)(args);
    mqtt_publish_para_t *publish_para = NULL;
    while (1)
    {
        if (luat_rtos_message_recv(mqtt_publish_task_handle, &id, (void **)&publish_para, LUAT_WAIT_FOREVER) == 0)
        {
            if (!g_s_is_link_up)
            {
                if (publish_para->callback != NULL)
                    publish_para->callback(NETWORK_NOT_READY);
            }
            else if (MQTTIsConnected(&mqttClient) == 0)
            {
                if (publish_para->callback != NULL)
                    publish_para->callback(MQTT_NOT_READY);
            }
            else
            {
                rc = MQTTPublish(mqttClient, publish_para->publish->topic, &publish_para->publish->message);
                if (rc != 0)
                {
                    LUAT_DEBUG_PRINT("MQTTPublish error %d", rc);
                    if (publish_para->callback != NULL)
                        publish_para->callback(MQTT_PUBLISH_FAIL);
                }
                else
                {
                    if (publish_para->callback != NULL)
                        publish_para->callback(MQTT_PUBLISH_SUCCESS);
                }
            }
            if (publish_para->publish->topic != NULL)
            {
                free(publish_para->publish->topic);
            }

            if (publish_para->publish->message.payload != NULL)
            {
                free(publish_para->publish->message.payload);
            }

            if (publish_para->publish != NULL)
            {
                free(publish_para->publish);
            }

            if (publish_para != NULL)
            {
                free(publish_para);
            }
        }
    }
}