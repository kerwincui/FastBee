
#include "common_api.h"
#include "FreeRTOS.h"
#include "task.h"

#include "luat_base.h"
#include "luat_log.h"
#include "luat_uart.h"
#include "printf.h"
#include "luat_cmux.h"
#include "luat_conf_bsp.h"

#include "cms_def.h"

extern luat_cmux_t cmux_ctx;
extern void soc_debug_out(char *string, uint32_t size);
static uint32_t luat_log_uart_port = 0;
static uint32_t luat_log_level_cur = LUAT_LOG_DEBUG;

#define LOGLOG_SIZE 1024
static char log_printf_buff[LOGLOG_SIZE] __attribute__((aligned (16)));

void luat_log_set_uart_port(int port) {
    luat_log_uart_port = port;
}

uint8_t luat_log_get_uart_port(void) {
    return luat_log_uart_port;
}

void luat_nprint(char *s, size_t l) {
#ifdef LUAT_USE_SHELL
    if (cmux_ctx.state == 1 && cmux_ctx.log_state ==1){
        luat_cmux_write(LUAT_CMUX_CH_LOG,  CMUX_FRAME_UIH & ~ CMUX_CONTROL_PF,s, l);
    }else
#endif
    soc_debug_out(s, l);
}

void luat_log_write(char *s, size_t l) {
#ifdef LUAT_USE_SHELL
    if (cmux_ctx.state == 1 && cmux_ctx.log_state ==1){
        luat_cmux_write(LUAT_CMUX_CH_LOG,  CMUX_FRAME_UIH & ~ CMUX_CONTROL_PF,s, l);
    }else
#endif
    soc_debug_out(s, l);
}

void luat_log_set_level(int level) {
    luat_log_level_cur = level;
}

int luat_log_get_level() {
    return luat_log_level_cur;
}

void luat_log_log(int level, const char* tag, const char* _fmt, ...) {
    if (luat_log_level_cur > level) return;
    char *tmp = (char *)log_printf_buff;
    switch (level)
        {
        case LUAT_LOG_DEBUG:
            log_printf_buff[0] = 'D';
            break;
        case LUAT_LOG_INFO:
            log_printf_buff[0] = 'I';
            break;
        case LUAT_LOG_WARN:
            log_printf_buff[0] = 'W';
            break;
        case LUAT_LOG_ERROR:
            log_printf_buff[0] = 'E';
            break;
        default:
            log_printf_buff[0] = '?';
            break;
        }
    log_printf_buff[1] = '/';
    tmp += 2;
    memcpy(tmp, tag, strlen(tag));
    log_printf_buff[2+strlen(tag)] = ' ';
    tmp += strlen(tag) + 1;

    va_list args;
    va_start(args, _fmt);
    size_t len = vsnprintf_(tmp, LOGLOG_SIZE - (2 + strlen(tag) + 1 + 1 + 1), _fmt, args);
    va_end(args);
    if (len > 0) {
        len += 2 + strlen(tag) + 1;
        log_printf_buff[len] = 0;
        luat_log_write(log_printf_buff, len+1);
    }
}

void luat_log_printf(int level, const char* _fmt, ...) {
    size_t len;
    va_list args;
    if (luat_log_level_cur > level) return;
    va_start(args, _fmt);
    len = vsnprintf_(log_printf_buff, LOGLOG_SIZE, _fmt, args);
    va_end(args);
    if (len > 0) {
        luat_log_write(log_printf_buff, len);
    }
}
