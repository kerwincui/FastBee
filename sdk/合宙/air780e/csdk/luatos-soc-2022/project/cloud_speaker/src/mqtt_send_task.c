#include "luat_debug.h"
#include "luat_rtos.h"
#include "MQTTClient.h"
#include "mqtt_publish.h"
luat_rtos_task_handle mqtt_send_task_handle;

extern luat_rtos_task_handle mqtt_publish_task_handle;

void publish_callback(int result)
{
    LUAT_DEBUG_PRINT("mqtt_send_task send mqtt message result %d", result);
}

static void mqtt_send_task(void)
{
    while (1)
    {
        mqtt_publish_para_t *publish_para = NULL;
        publish_para = (mqtt_publish_para_t *)malloc(sizeof(mqtt_publish_para_t));
        memset(publish_para, 0x00, sizeof(mqtt_publish_para_t));

        publish_para->publish = (mqttSendMsg *)malloc(sizeof(mqttSendMsg));
        memset(publish_para->publish, 0x00, sizeof(mqttSendMsg));

        char topic[] = "/cloud_speaker/publish/test_topic";
        publish_para->publish->topic = malloc(sizeof(topic));
        memcpy(publish_para->publish->topic, topic, sizeof(topic));
        publish_para->publish->topicLen = sizeof(topic);

        char payload[] = "{\"time\": \"2000-00-00\"}";
        publish_para->publish->message.payload = malloc(sizeof(payload));
        memcpy(publish_para->publish->message.payload, payload, sizeof(payload));

        publish_para->publish->message.payloadlen = sizeof(payload) - 1;
        publish_para->publish->message.qos = 1;
        publish_para->callback = publish_callback;
        uint32_t id = 0;
        if (luat_rtos_message_send(mqtt_publish_task_handle, &id, (void *)publish_para) != 0)
        {
            LUAT_DEBUG_PRINT("colud_speaker_mqtt publish message send error");
            free(publish_para->publish->topic);
            free(publish_para->publish->message.payload);
            free(publish_para->publish);
            free(publish_para);
            
        }
        luat_rtos_task_sleep(5000);
    }
}

void mqtt_send_task_init(void)
{
    luat_rtos_task_create(&mqtt_send_task_handle, 2048, 20, "mqtt_send_task", mqtt_send_task, NULL, 0);
}