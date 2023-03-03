#include "i2s.h"

#define ES8388_FS_NUM       256


i2sI2cCfg_t es8388_regInfo[] = 
{
    {0x00,0x80},
	{0x00,0x06},
	{0x02,0xf3},
	{0x35,0xa0},
	{0x36,0x08},
	
	{0x08,0x84}, // Bit7: 1 means master(default); 0 means slave; 0x84: master 32bit;  0x86: master 16bit
	{0x0d,0x02}, // 256 ratio
	{0x18,0x02}, // 256 ratio
	
	{0x07,0x7c},
	{0x2b,0x80},
	{0x2d,0x10},
	{0x00,0x30},
	{0x01,0x00},
	{0x03,0x00},
	{0x06,0xff},
	{0x09,0x88}, // Analog PGA: +24dB
	{0x0a,0xfc},
	{0x0b,0x02}, 
	{0x0c,0x0D}, // 0x0d: 16bit Left; 0x0c: 16bit I2S;  0x0e: 16bit Right; 0x0f: 16bit PCM;
    {0x10,0x00}, // digital gain ADCL
	{0x11,0x00}, // digital gain ADCR
	{0x12,0x05},
	{0x17,0x1B}, // 0x1b: 16bit Left; 0x19: 16bit I2S;  0x1d: 16bit Right; 0x1f: 16bit PCM; 
	{0x19,0x76},
	{0x1a,0x45}, // digital gain DACL
	{0x1b,0x00}, // digital gain DACR
	{0x26,0x12},
	{0x2e,0x00},
	{0x2f,0x00},
	{0x30,0x00},
    {0x31,0x00},
	{0x02,0x00},
	{0x00,0x37},
	{0x01,0x20},
    {0x27,0xb8},
	{0x2a,0xb8},
	{0x04,0x3c},
	{0x00,0x36},
    {0x19,0x72},
	{0x2e,0x1e},
	{0x2f,0x1e},
	{0x30,0x1e},
	{0x31,0x1e},
};

uint16_t es8388GetRegCnt(char* regName)
{
    if (strcmp(regName, "es8388_master") == 0)
    {
        return (sizeof(es8388_regInfo) / sizeof(es8388_regInfo[0]));
    }
    else if (strcmp(regName, "es8388_slave") == 0)
    {
        return (sizeof(es8388_regInfo) / sizeof(es8388_regInfo[0]));
    }

    return 0;
}

void codecI2cInit(void);
void codecI2cWrite(char* codecName, uint8_t slaveAddr, i2sI2cCfg_t* i2sI2cCfg);
uint8_t codecI2cRead(uint8_t slaveAddr, uint8_t regAddr);



void es8388MasterInit()
{
    //uint8_t dataRead = 0xff; 
    
    codecI2cInit();

    for (int i = 0; i < es8388GetRegCnt("es8388_master"); i++)
    {
        codecI2cWrite("es8388", ES8388_IICADDR, (i2sI2cCfg_t*)&es8388_regInfo[i]);
        //delay_us(10000); 
    }

#if 0
    for (int i = 0; i < es8388GetRegCnt("es8388_master"); i++)
    {
        dataRead = codecI2cRead(ES8388_IICADDR, es8388_regInfo[i].regAddr);
        printf("reg = 0x%02x, val = 0x%02x\n", es8388_regInfo[i].regAddr, dataRead);
    }
#endif    
}

void es8388SlaveInit()
{
	//uint8_t dataRead = 0xff; 
    es8388MasterInit();

    i2sI2cCfg_t i2sI2cCfg;
    i2sI2cCfg.regAddr = 0x08;
    i2sI2cCfg.regVal  = 0<<7; // Bit7 --> 1: master(default); 0: slave
    codecI2cWrite("es8388", ES8388_IICADDR, (i2sI2cCfg_t*)&i2sI2cCfg);

#if 0
    for (int i = 0; i < es8388GetRegCnt("es8388_slave"); i++)
    {
        dataRead = codecI2cRead(ES8388_IICADDR, es8388_regInfo[i].regAddr);
        printf("reg = 0x%02x, val = 0x%02x\n", es8388_regInfo[i].regAddr, dataRead);
    }
#endif 
}


uint16_t es8388GetFs()
{
    return ES8388_FS_NUM;
}

void es8388SetMode(i2sMode_e mode)
{
	uint8_t val = 0;
	
	switch(mode)
	{
		case MSB_MODE:
			val = 0x1b;
		break;

		case I2S_MODE:
			val = 0x19;
		break;

		case LSB_MODE:
			val = 0x1d;
		break;

		case PCM_MODE:
			val = 0x1f;
		break;
	}

	codecWriteVal(CODEC_ES8388, 0x17, val);
}

