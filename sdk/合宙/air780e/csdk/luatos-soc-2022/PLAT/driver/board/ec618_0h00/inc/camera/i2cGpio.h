#ifndef __I2C_GPIO_H__
#define __I2C_GPIO_H__

#include "stdio.h"
#include "string.h"
#include "ec618.h"
#include "bsp.h"

// sda pin definition. gpio16
#define SDA_GPIO_INSTANCE       (1)
#define SDA_GPIO_PIN            (0)
#define SDA_GPIO_ADDR           (31)
#define SDA_PAD_ALT_FUNC        (PAD_MUX_ALT0)    

// scl pin definition. gpio17
#define SCL_GPIO_INSTANCE       (1)
#define SCL_GPIO_PIN            (1)
#define SCL_GPIO_ADDR           (32)
#define SCL_PAD_ALT_FUNC        (PAD_MUX_ALT0)  

#define I2C_SDA_0               do {GPIO_pinWrite(SDA_GPIO_INSTANCE, 1 << SDA_GPIO_PIN, 0);}while(0)
#define I2C_SDA_1               do {GPIO_pinWrite(SDA_GPIO_INSTANCE, 1 << SDA_GPIO_PIN, 1 << SDA_GPIO_PIN);}while(0)

#define I2C_SCL_0               do {GPIO_pinWrite(SCL_GPIO_INSTANCE, 1 << SCL_GPIO_PIN, 0);}while(0)
#define I2C_SCL_1               do {GPIO_pinWrite(SCL_GPIO_INSTANCE, 1 << SCL_GPIO_PIN, 1 << SCL_GPIO_PIN);}while(0)


void i2cGpioInit();
uint8_t i2cReadByte();
void i2cWritebyte(uint8_t byte);
void i2cStop();
void i2cStart();
void i2cAck();

#endif

