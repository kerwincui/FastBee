/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
#include "i2c_temp.h"
#include "common.h"
#include <stdio.h>
#include "unity.h"
#include "driver/i2c.h"
#include "i2c_bus.h"
#include "esp_system.h"
#include "sht3x.h"

#define I2C_MASTER_SCL_IO          (gpio_num_t)IO_SENSOR_SCL         /*!< gpio number for I2C master clock */
#define I2C_MASTER_SDA_IO          (gpio_num_t)IO_SENSOR_SDA         /*!< gpio number for I2C master data  */
#define I2C_MASTER_NUM              I2C_NUM_1              /*!< I2C port number for master dev */
#define I2C_MASTER_FREQ_HZ          100000                 /*!< I2C master clock frequency */

static i2c_bus_handle_t i2c_bus = NULL;
static sht3x_handle_t sht3x = NULL;

/**
 * @brief i2c master initialization
 */
static void sht3x_init()
{
    i2c_config_t conf = {
        .mode = I2C_MODE_MASTER,
        .sda_io_num = I2C_MASTER_SDA_IO,
        .sda_pullup_en = GPIO_PULLUP_ENABLE,
        .scl_io_num = I2C_MASTER_SCL_IO,
        .scl_pullup_en = GPIO_PULLUP_ENABLE,
        .master.clk_speed = I2C_MASTER_FREQ_HZ,
    };
    i2c_bus = i2c_bus_create(I2C_MASTER_NUM, &conf);
    sht3x = sht3x_create(i2c_bus, SHT3x_ADDR_PIN_SELECT_VSS);
    sht3x_set_measure_mode(sht3x, SHT3x_PER_2_MEDIUM);  /*!< here read data in periodic mode*/
}

void sht3x_deinit()
{
    sht3x_delete(&sht3x);
    i2c_bus_delete(&i2c_bus);
}

static void sht3x_get_data()
{
    float Tem_val, Hum_val;
    int cnt = 1000;

    while (cnt--) {
        if (sht3x_get_humiture(sht3x, &Tem_val, &Hum_val) == 0) {
            printf("temperature %.2f°C    ", Tem_val);
            printf("humidity:%.2f %%\n", Hum_val);
        }
        vTaskDelay(3000 / portTICK_RATE_MS);
    }
}

void i2c_temp_start(void)
{
    sht3x_init();
    // vTaskDelay(1000 / portTICK_RATE_MS);
    // sht3x_get_data();
    // sht3x_deinit();
}

//获取空气温湿度
void get_temp_humi(){    
    if (sht3x_get_humiture(sht3x, &air_temperature, &air_humidity) == 0) {
        printf("temperature %.2f°C    ", air_temperature);
        printf("humidity:%.2f %%\n", air_humidity);
    }
    
}
