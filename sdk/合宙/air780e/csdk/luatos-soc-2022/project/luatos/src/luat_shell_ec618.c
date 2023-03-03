
#include "common_api.h"

#include "luat_base.h"
#include "luat_uart.h"
#include "luat_msgbus.h"
#include "luat_shell.h"

#define LUAT_LOG_TAG "usb"
#include "luat_log.h"

void luat_shell_write(char* buff, size_t len) {
    luat_uart_write(LUAT_VUART_ID_0, buff, len);
}
