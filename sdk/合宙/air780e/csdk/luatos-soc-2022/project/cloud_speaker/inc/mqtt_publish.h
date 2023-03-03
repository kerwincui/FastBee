#ifndef __MQTT_PUBLISH_H__
#define __MQTT_PUBLISH_H__
#include "MQTTClient.h"
typedef struct mqtt_publish_para
{
    mqttSendMsg* publish;
    void (*callback)(int result);
}mqtt_publish_para_t;


typedef enum MQTT_PUBLISH_RESULT
{
    MQTT_PUBLISH_SUCCESS,
    MQTT_PUBLISH_FAIL,
    MQTT_NOT_READY,
    NETWORK_NOT_READY
}MQTT_PUBLISH_RESULT_E;
#endif