#include "common_api.h"
#include "network_service.h"
#include "socket_service.h"
#include "usb_service.h"

extern void test_service_init(void);

INIT_TASK_EXPORT(network_service_init, "0");
INIT_TASK_EXPORT(socket_service_init, "1");
INIT_TASK_EXPORT(usb_service_init, "2");
INIT_TASK_EXPORT(test_service_init, "2");

