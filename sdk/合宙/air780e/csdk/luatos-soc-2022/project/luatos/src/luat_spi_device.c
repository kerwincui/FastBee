#include "luat_base.h"
#include "luat_gpio.h"
#include "luat_spi.h"

#define LUAT_WEAK                     __attribute__((weak))
#define LUAT_SPI_CS_SELECT 0
#define LUAT_SPI_CS_CLEAR  1


// luat_spi_device_t* 在lua层看到的是一个userdata
LUAT_WEAK int luat_spi_device_setup(luat_spi_device_t* spi_dev) {
    luat_spi_bus_setup(spi_dev);
    if (spi_dev->spi_config.cs != 255)
        luat_gpio_mode(spi_dev->spi_config.cs, Luat_GPIO_OUTPUT, Luat_GPIO_DEFAULT, Luat_GPIO_HIGH); // CS
    return 0;
}

//关闭SPI设备，成功返回0
LUAT_WEAK int luat_spi_device_close(luat_spi_device_t* spi_dev) {
    return luat_spi_close(spi_dev->bus_id);
}

//收发SPI数据，返回接收字节数
LUAT_WEAK int luat_spi_device_transfer(luat_spi_device_t* spi_dev, const char* send_buf, size_t send_length, char* recv_buf, size_t recv_length) {
    int ret = -1;
    luat_spi_device_config(spi_dev);
    if (spi_dev->spi_config.cs != 255)
        luat_gpio_set(spi_dev->spi_config.cs, LUAT_SPI_CS_SELECT);
    if (spi_dev->spi_config.mode){
        ret = luat_spi_transfer(spi_dev->bus_id, send_buf, send_length, recv_buf, recv_length);
    }else{
        ret = luat_spi_send(spi_dev->bus_id, send_buf, send_length);
        ret = luat_spi_recv(spi_dev->bus_id, recv_buf, recv_length);
    }
    if (spi_dev->spi_config.cs != 255)
        luat_gpio_set(spi_dev->spi_config.cs, LUAT_SPI_CS_CLEAR);
    return ret;
}

//收SPI数据，返回接收字节数
LUAT_WEAK int luat_spi_device_recv(luat_spi_device_t* spi_dev, char* recv_buf, size_t length) {
    luat_spi_device_config(spi_dev);
    if (spi_dev->spi_config.cs != 255)
        luat_gpio_set(spi_dev->spi_config.cs, LUAT_SPI_CS_SELECT);
    int ret = luat_spi_recv(spi_dev->bus_id, recv_buf, length);
    if (spi_dev->spi_config.cs != 255)
        luat_gpio_set(spi_dev->spi_config.cs, LUAT_SPI_CS_CLEAR);
    return ret;
}

//发SPI数据，返回发送字节数
LUAT_WEAK int luat_spi_device_send(luat_spi_device_t* spi_dev, const char* send_buf, size_t length) {
    luat_spi_device_config(spi_dev);
    if (spi_dev->spi_config.cs != 255)
        luat_gpio_set(spi_dev->spi_config.cs, LUAT_SPI_CS_SELECT);
    int ret = luat_spi_send(spi_dev->bus_id, send_buf, length);
    if (spi_dev->spi_config.cs != 255)
        luat_gpio_set(spi_dev->spi_config.cs, LUAT_SPI_CS_CLEAR);
    return ret;
}

