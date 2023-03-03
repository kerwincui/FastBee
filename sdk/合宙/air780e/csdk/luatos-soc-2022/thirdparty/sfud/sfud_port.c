/*
 * This file is part of the Serial Flash Universal Driver Library.
 *
 * Copyright (c) 2016-2018, Armink, <armink.ztl@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * 'Software'), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * Function: Portable interface for each platform.
 * Created on: 2016-04-23
 */

#include <sfud.h>
#include <stdarg.h>

#include "luat_debug.h"
#include "luat_gpio.h"
#include "luat_spi.h"

static char log_buf[256];

void sfud_log_debug(const char *file, const long line, const char *format, ...);
#include "RTE_Device.h"
/**
 * SPI write data then read data
 */
static sfud_err spi_write_read(const sfud_spi *spi, const uint8_t *write_buf, size_t write_size, uint8_t *read_buf,
        size_t read_size) {
    sfud_err result = SFUD_SUCCESS;
    if (write_size) {
        SFUD_ASSERT(write_buf);
    }
    if (read_size) {
        SFUD_ASSERT(read_buf);
    }

    luat_spi_t* spi_flash = (luat_spi_t*) (spi->user_data);
    if (write_size) {
        SFUD_ASSERT(write_buf);
    }
    if (read_size) {
        SFUD_ASSERT(read_buf);
    }

    if (spi_flash -> id == 0){
        if (RTE_SPI0_SSN_BIT==0xFF && spi_flash->cs){
            luat_gpio_set(spi_flash->cs, 0);
        }
    }else if(spi_flash -> id == 1){
        if (RTE_SPI1_SSN_BIT==0xFF && spi_flash->cs){
            luat_gpio_set(spi_flash->cs, 0);
        }
    }

    if (write_size) {
        if (luat_spi_send(spi_flash -> id,  write_buf, write_size) <= 0) {
            result = SFUD_ERR_WRITE;
        }
    } 
    if (read_size) {
        if (luat_spi_recv(spi_flash -> id, read_buf, read_size) <= 0) {
            result = SFUD_ERR_READ;
        }
    }
    if (spi_flash -> id == 0){
        if (RTE_SPI0_SSN_BIT==0xFF && spi_flash->cs){
            luat_gpio_set(spi_flash->cs, 1);
        }
    }else if(spi_flash -> id == 1){
        if (RTE_SPI1_SSN_BIT==0xFF && spi_flash->cs){
            luat_gpio_set(spi_flash->cs, 1);
        }
    }
    return result;
}

#ifdef SFUD_USING_QSPI
/**
 * read flash data by QSPI
 */
static sfud_err qspi_read(const struct __sfud_spi *spi, uint32_t addr, sfud_qspi_read_cmd_format *qspi_read_cmd_format,
        uint8_t *read_buf, size_t read_size) {
    sfud_err result = SFUD_SUCCESS;

    /**
     * add your qspi read flash data code
     */

    return result;
}
#endif /* SFUD_USING_QSPI */

/* about 100 microsecond delay */
static void retry_delay_100us(void) {
    uint32_t delay = 120;
    while(delay--);
}

sfud_err sfud_spi_port_init(sfud_flash *flash) {
    sfud_err result = SFUD_SUCCESS;

    extern luat_spi_t sfud_spi_flash;

    if (sfud_spi_flash.id == 0){
        if (RTE_SPI0_SSN_BIT==0xFF && sfud_spi_flash.cs){
            luat_gpio_cfg_t gpio_cfg;
            luat_gpio_set_default_cfg(&gpio_cfg);
            gpio_cfg.mode = Luat_GPIO_OUTPUT;
            gpio_cfg.pull = LUAT_GPIO_DEFAULT;
            gpio_cfg.output_level = Luat_GPIO_HIGH;
            gpio_cfg.pin = sfud_spi_flash.cs;
            luat_gpio_open(&gpio_cfg); 
        }
    }else if(sfud_spi_flash.id == 1){
            if (RTE_SPI1_SSN_BIT==0xFF && sfud_spi_flash.cs){
            luat_gpio_cfg_t gpio_cfg;
            luat_gpio_set_default_cfg(&gpio_cfg);
            gpio_cfg.mode = Luat_GPIO_OUTPUT;
            gpio_cfg.pull = LUAT_GPIO_DEFAULT;
            gpio_cfg.output_level = Luat_GPIO_HIGH;
            gpio_cfg.pin = sfud_spi_flash.cs;
            luat_gpio_open(&gpio_cfg); 
        }
    }
    /* port SPI device interface */
    flash->spi.wr = spi_write_read;
    // flash->spi.user_data = flash;
    flash->spi.user_data = &sfud_spi_flash;
    /* 100 microsecond delay */
    flash->retry.delay = retry_delay_100us;
    /* 60 seconds timeout */
    flash->retry.times = 60 * 10000;

    flash->name = "LuatOS-sfud";

    return result;
}

/**
 * This function is print debug info.
 *
 * @param file the file which has call this function
 * @param line the line number which has call this function
 * @param format output format
 * @param ... args
 */
void sfud_log_debug(const char *file, const long line, const char *format, ...) {
    va_list args;

    /* args point to the first variable parameter */
    va_start(args, format);
    // printf("[SFUD](%s:%ld) ", file, line);
    /* must use vprintf to print */
    vsnprintf(log_buf, sizeof(log_buf), format, args);
    // printf("%s\n", log_buf);
    LUAT_DEBUG_PRINT("%s ", log_buf);
    va_end(args);
}

/**
 * This function is print routine info.
 *
 * @param format output format
 * @param ... args
 */
void sfud_log_info(const char *format, ...) {
    va_list args;

    /* args point to the first variable parameter */
    va_start(args, format);
    // printf("[SFUD]");
    /* must use vprintf to print */
    vsnprintf(log_buf, sizeof(log_buf), format, args);
    // printf("%s\n", log_buf);
    LUAT_DEBUG_PRINT("%s ", log_buf);
    va_end(args);
}
