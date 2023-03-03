#include "i2cGpio.h"

// We only act as I2C master

typedef enum
{
    INPUT,
    OUTPUT,
}pinDirection_e;

static void setSdaDirection(pinDirection_e direction)
{
    GpioPinConfig_t config;

    if (direction == INPUT)
    {
        config.pinDirection = GPIO_DIRECTION_INPUT;
        config.misc.interruptConfig = GPIO_INTERRUPT_DISABLED;
        GPIO_pinConfig(SDA_GPIO_INSTANCE, SDA_GPIO_PIN, &config); 
    }
    else
    {
        config.pinDirection = GPIO_DIRECTION_OUTPUT;
        //config.initOutput = 0;
        GPIO_pinConfig(SDA_GPIO_INSTANCE, SDA_GPIO_PIN, &config); 
    }
}

void i2cStart()
{
    I2C_SDA_1;
    I2C_SCL_1;
    delay_us(20);
    I2C_SDA_0;
    delay_us(19);
    I2C_SCL_0;
}

void i2cStop()
{
    setSdaDirection(OUTPUT);
    
    I2C_SDA_0;
    I2C_SCL_1;
    delay_us(18);

    I2C_SDA_1;
    delay_us(18);
}

static uint32_t i2cSdaRead()
{
    return (((((GPIO_TypeDef *) (MP_GPIO_BASE_ADDR + 0x1000*SDA_GPIO_INSTANCE))->DATA) >> SDA_GPIO_PIN) & 0x01);
}

void i2cWritebyte(uint8_t byte)
{
    setSdaDirection(OUTPUT);

    for (uint8_t i=0; i<8; i++)
    {
        I2C_SCL_0;
        delay_us(18);
        
        // Send data every bit
        if (byte&0x80)
        {
            I2C_SDA_1;
        }
        else
        {
            I2C_SDA_0;
        }
        
        byte <<= 1;

        I2C_SCL_1;
        delay_us(18);
    }

    I2C_SCL_0;
    delay_us(18);
    I2C_SDA_1;
    delay_us(18);
}

void i2cAck()
{
    uint8_t i = 0;
    
    setSdaDirection(INPUT);
    I2C_SCL_1;
    delay_us(18);

    while ((i2cSdaRead()==1) && (i<255))
        i++;

    I2C_SCL_0;
    delay_us(18);
    
    setSdaDirection(OUTPUT);
}

uint8_t i2cReadByte()
{
    uint8_t i, receveData = 0;

    setSdaDirection(INPUT);
    delay_us(18);

    for (i = 0; i < 8; i++)
    {
        I2C_SCL_1;
        delay_us(18);
        receveData |= (i2cSdaRead() << (7-i));
        I2C_SCL_0;
        delay_us(18);
    }

    setSdaDirection(OUTPUT);

    return receveData;
}


void i2cGpioInit()
{
    PadConfig_t config;

    PAD_getDefaultConfig(&config);

    // scl pin
    config.mux = SCL_PAD_ALT_FUNC;
    PAD_setPinConfig(SCL_GPIO_ADDR, &config);

    GpioPinConfig_t gpioCfg;
    gpioCfg.pinDirection = GPIO_DIRECTION_OUTPUT;
    gpioCfg.misc.initOutput= 1;
    GPIO_pinConfig(SCL_GPIO_INSTANCE, SCL_GPIO_PIN, &gpioCfg);

    // sda pin
    config.mux = SDA_PAD_ALT_FUNC;
    PAD_setPinConfig(SDA_GPIO_ADDR, &config);

    gpioCfg.pinDirection = GPIO_DIRECTION_OUTPUT;
    gpioCfg.misc.initOutput= 1;
    GPIO_pinConfig(SDA_GPIO_INSTANCE, SDA_GPIO_PIN, &gpioCfg);
}

