
#include "luat_msgbus.h"

#include "FreeRTOS.h"
#include "queue.h"

#define QUEUE_LENGTH 0xFF
#define ITEM_SIZE sizeof(rtos_msg_t)

static StaticQueue_t xStaticQueue = {0};
static QueueHandle_t xQueue = {0};

#if configSUPPORT_STATIC_ALLOCATION
static uint8_t ucQueueStorageArea[ QUEUE_LENGTH * ITEM_SIZE ] __attribute__((aligned (16)));
#endif

void luat_msgbus_init(void) {
    if (!xQueue) {
        #if configSUPPORT_STATIC_ALLOCATION
        xQueue = xQueueCreateStatic( QUEUE_LENGTH,
                                 ITEM_SIZE,
                                 ucQueueStorageArea,
                                 &xStaticQueue );
        #else
        xQueue = xQueueCreate(QUEUE_LENGTH, ITEM_SIZE);
        #endif
    }
}
uint32_t luat_msgbus_put(rtos_msg_t* msg, size_t timeout) {
    if (xQueue == NULL)
        return 1;
    return xQueueSendFromISR(xQueue, msg, NULL) == pdTRUE ? 0 : 1;
}
uint32_t luat_msgbus_get(rtos_msg_t* msg, size_t timeout) {
    if (xQueue == NULL)
        return 1;
    return xQueueReceive(xQueue, msg, timeout) == pdTRUE ? 0 : 1;
}
uint32_t luat_msgbus_freesize(void) {
    if (xQueue == NULL)
        return 1;
    return 1;
}
