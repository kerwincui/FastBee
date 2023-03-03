#include "i2s.h"

#define NAU88C22_FS_NUM       256


i2sI2cCfg_t NAU88C22_slaveRegInfo[] = 
{
    {0x00,0x000},
	{0x01,0x1FD},
	{0x02,0x1BF},
	{0x03,0x1EF},
	//{0x04,0x008},
    {0x06,0x000},
	
	{0x0A,0x008},
    //{0x0B,0x1FF},
    //{0x0C,0x1FF},
    
    {0x2C,0x033},
    {0x2D,0x012},
    {0x2E,0x012},

    {0x32,0x001},
    {0x33,0x001},
    {0x34,0x139},
    {0x35,0x139},

};

uint16_t NAU88C22GetRegCnt(char* regName)
{
    if (strcmp(regName, "NAU88C22_slave") == 0)
    {
        return (sizeof(NAU88C22_slaveRegInfo) / sizeof(NAU88C22_slaveRegInfo[0]));
    }
    else if (strcmp(regName, "NAU88C22_master") == 0)
    {
        return (sizeof(NAU88C22_slaveRegInfo) / sizeof(NAU88C22_slaveRegInfo[0]));
    }

    return 0;
}

void codecI2cInit(void);
void codecI2cWrite(char* codecName, uint8_t slaveAddr, i2sI2cCfg_t* i2sI2cCfg);
uint8_t codecI2cRead(uint8_t slaveAddr, uint8_t regAddr);


void nau88c22MasterInit()
{

}

void nau88c22SlaveInit()
{
    uint8_t dataRead = 0xff; 
    
    codecI2cInit();

    for (int i = 0; i < NAU88C22GetRegCnt("NAU88C22_slave"); i++)
    {
        codecI2cWrite("NAU88C22", NAU88C22_IICADDR, (i2sI2cCfg_t*)&NAU88C22_slaveRegInfo[i]);
    }

    for (int i = 0; i < NAU88C22GetRegCnt("NAU88C22_slave"); i++)
    {
        dataRead = codecI2cRead(NAU88C22_IICADDR, NAU88C22_slaveRegInfo[i].regAddr);
        printf("reg = 0x%02x, val = 0x%02x\n", NAU88C22_slaveRegInfo[i].regAddr, dataRead);
    }
}

uint16_t NAU88C22GetFs()
{
    return NAU88C22_FS_NUM;
}




