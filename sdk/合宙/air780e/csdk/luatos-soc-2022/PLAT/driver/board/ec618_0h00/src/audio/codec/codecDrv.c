#include "codecDrv.h"

void delay_us(uint32_t us);

extern ARM_DRIVER_I2C Driver_I2C0;
static ARM_DRIVER_I2C   *i2cDrvInstance = &CREATE_SYMBOL(Driver_I2C, 0);

void codecI2cInit()
{
    i2cDrvInstance->Initialize(NULL);
    i2cDrvInstance->PowerControl(ARM_POWER_FULL);
    i2cDrvInstance->Control(ARM_I2C_BUS_SPEED, ARM_I2C_BUS_SPEED_STANDARD);
    i2cDrvInstance->Control(ARM_I2C_BUS_CLEAR, 0);
}

void codecI2cWrite(char* codecName, uint8_t slaveAddr, i2sI2cCfg_t* i2cCfg)
{
    uint8_t  cmd[2] = {0, 0};
    uint8_t  regAddr  = i2cCfg->regAddr;
    uint16_t regData  = i2cCfg->regVal;

    if (strcmp(codecName, "es8388") == 0)
    {
        cmd[0] = regAddr;
        cmd[1] = regData & 0xff;

    }
    else if (strcmp(codecName, "NAU88C22") == 0)
    {
        cmd[0] = (regAddr << 1) | ((regData & 0x100) >> 8);
        cmd[1] = regData & 0xff;
    }
    else if(strcmp(codecName, "es8311") == 0)
    {
        cmd[0] = regAddr;
        cmd[1] = regData & 0xff;
    }

    i2cDrvInstance->MasterTransmit(slaveAddr, cmd, 2, false);
	//delay_us(30 * 1000); // need to add delay in app layer which call it
}

uint8_t codecI2cRead(uint8_t slaveAddr, uint8_t regAddr)
{
    uint8_t a;
    a = regAddr;
    uint8_t readData;
    i2cDrvInstance->MasterTransmit(slaveAddr, (uint8_t *)&a, 1, true);   
    i2cDrvInstance->MasterReceive(slaveAddr, &readData, 1, false);
    return readData;
}

uint16_t es8388GetFs(void);
uint16_t es8311GetFs(void);

uint16_t codecGetFs(codecType_e codecType)
{
    switch (codecType)
    {
        case ES8388:
            return es8388GetFs();
        
        case NAU88C22:
            return 1;

        case ES7148:
            return 1;

        case ES7149:
            return 1;

        case ES8311:
            return es8311GetFs();

    }

    return 0;
}

#if 0
/**
  \fn          void codecCtrlVolume(uint8_t raise, uint8_t step)
  \brief       Raise or decrease volume.
  \param[in]   codecType  codec type.
  \param[in]   raise      true means raise volume; false means decrease volume.
  \param[in]   step       Raise or decrease vlume'samplitude everytime.
  \return      none.
*/ 
void codecCtrlVolume(codecType_e codecType, bool raise, uint8_t step)
{
    i2sI2cCfg_t i2cCfg = {0,0,0};
    
    switch (codecType)
    {
        case ES8388:
        {
            i2cCfg.regAddr = 0x1b;
            raise? (i2cCfg.regVal  += step) : (i2cCfg.regVal  -= step);
            i2cCfg.delayMs = 1;
            
            codecI2cWrite("es8388", ES8388_IICADDR, (i2sI2cCfg_t*)&i2cCfg); // register27. Digital part
            codecI2cWrite("es8388", ES8388_IICADDR, (i2sI2cCfg_t*)&i2cCfg); // register49. Analog part
            return;
        }
            
        case NAU88C22:
        return;
        
    }
}
#endif

void codecWriteVal(codecType_e codecType, uint8_t regAddr, uint16_t regVal)
{
    i2sI2cCfg_t i2cCfg;

    i2cCfg.regAddr = regAddr;
    i2cCfg.regVal  = regVal;
    
    switch (codecType)
    {
        case ES8388:
        {
            codecI2cWrite("es8388", ES8388_IICADDR, (i2sI2cCfg_t*)&i2cCfg); 
            return;
        }

        case NAU88C22:
        {
            codecI2cWrite("NAU88C22", NAU88C22_IICADDR, (i2sI2cCfg_t*)&i2cCfg); 
            return;
        }
        case ES7148:
        {
            return;
        }
        case ES7149:
        {
            return;
        }
         case ES8311:
        {
            codecI2cWrite("es8311", ES8311_IICADDR, (i2sI2cCfg_t*)&i2cCfg); 
            return;
        }
    }
}

uint8_t codecReadVal(codecType_e codecType, uint8_t regAddr)
{
	uint8_t dataRead = 0x55;
    switch (codecType)
    {
        case ES8388:
        {
            dataRead = codecI2cRead(ES8388_IICADDR, regAddr);
            break;
        }
        case ES8311:
        {
            dataRead = codecI2cRead(ES8311_IICADDR, regAddr);
            break;
        }
        case ES7148:
        case ES7149:
        case NAU88C22:
            break;
    }
    
    return dataRead;
}

