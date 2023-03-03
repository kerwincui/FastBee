#include "common_api.h"
#include "network_service.h"
#include "socket_service.h"

extern void test_service_init(void);

INIT_TASK_EXPORT(network_service_init, "0");
INIT_TASK_EXPORT(test_service_init, "1");

