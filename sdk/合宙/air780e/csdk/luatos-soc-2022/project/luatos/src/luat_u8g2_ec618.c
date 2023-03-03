#include "luat_base.h"
#include "u8g2.h"
#include "luat_u8g2.h"

uint8_t u8x8_luat_gpio_and_delay(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr);
uint8_t u8x8_luat_byte_hw_i2c(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr);
uint8_t u8x8_luat_byte_4wire_hw_spi(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr);

uint8_t u8x8_luat_gpio_and_delay_default(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr);
uint8_t u8x8_luat_byte_hw_i2c_default(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr);
uint8_t u8x8_luat_byte_4wire_hw_spi_default(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr);

int luat_u8g2_setup_default(luat_u8g2_conf_t *conf);

int luat_u8g2_setup(luat_u8g2_conf_t *conf) {
    return luat_u8g2_setup_default(conf);
}

uint8_t u8x8_luat_gpio_and_delay(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr) {
    return u8x8_luat_gpio_and_delay_default(u8x8, msg, arg_int, arg_ptr);
}

uint8_t u8x8_luat_byte_hw_i2c(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr) {
    return u8x8_luat_byte_hw_i2c_default(u8x8, msg, arg_int, arg_ptr);
}

uint8_t u8x8_luat_byte_4wire_hw_spi(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr) {
    return u8x8_luat_byte_4wire_hw_spi_default(u8x8, msg, arg_int, arg_ptr);
}
