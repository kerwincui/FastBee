/*
 * Copyright (c) 2022 OpenLuat & AirM2M
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#include "common_api.h"
#include "luat_rtos.h"
#include "luat_debug.h"

#include "luat_gpio.h"
#include "luat_spi.h"
#include "sfud.h"

luat_rtos_task_handle sfud_task_handle;


luat_spi_t sfud_spi_flash = {
        .id = 0,
        .CPHA = 0,
        .CPOL = 0,
        .dataw = 8,
        .bit_dict = 0,
        .master = 1,
        .mode = 0,
        .bandrate=25*1000*1000,
        .cs = 8
};

uint8_t send_data[64] = {0};
uint8_t read_data[64] = {0};

#include "common_api.h"
#include "bsp_custom.h"

static void task_test_sfud(void *param)
{
    int re = -1;
    uint8_t data[8] = {0};
    luat_spi_setup(&sfud_spi_flash);

    if (re = sfud_init()!=0){
        LUAT_DEBUG_PRINT("sfud_init error is %d\n", re);
    }
    const sfud_flash *flash = sfud_get_device_table();
    if (re = sfud_erase(flash,1024, 6)!=0){
        LUAT_DEBUG_PRINT("sfud_erase error is %d\n", re);
    }
    if (re = sfud_write(flash, 1024, 6, "luatos")!=0){
        LUAT_DEBUG_PRINT("sfud_write error is %d\n", re);
    }
    if (re = sfud_read(flash, 1024, 6, &data)!=0){
        LUAT_DEBUG_PRINT("sfud_read error is %d\n", re);
    }else{
        LUAT_DEBUG_PRINT("sfud_read %s\n", data);
    }
    

extern ARM_DRIVER_SPI Driver_SPI0;
// static ARM_DRIVER_SPI *spiDrv0 = &CREATE_SYMBOL(Driver_SPI, 0);

    int t1 = luat_mcu_tick64();
    Driver_SPI0.Transfer(send_data, read_data, 64);
    // sfud_read(flash, 0, 64, &read_data);
    int t2 = luat_mcu_tick64();
    LUAT_DEBUG_PRINT("ticks: %u\n", (uint32_t)(t2-t1));

    while (1)
    {
        luat_rtos_task_sleep(1000);
    }
}

#define FLASH_EN	HAL_GPIO_26
#define FLASH_EN_ALT_FUN	0

static void task_demo_sfud(void)
{
    luat_gpio_cfg_t gpio_cfg;
	luat_gpio_set_default_cfg(&gpio_cfg);

	gpio_cfg.pin = FLASH_EN;
	gpio_cfg.alt_fun = FLASH_EN_ALT_FUN;
	luat_gpio_open(&gpio_cfg);
	luat_gpio_set(FLASH_EN, LUAT_GPIO_HIGH);

    luat_rtos_task_create(&sfud_task_handle, 1024, 20, "sfud", task_test_sfud, NULL, NULL);
}

INIT_TASK_EXPORT(task_demo_sfud,"1");



