#include "i2s.h"

#define ES8311_FS_NUM       256


i2sI2cCfg_t es8311_regInfo[] = 
{
	
	{0x45,0x00},
	{0x01,0x30},
	{0x02,0x10},

	
	//Ratio=MCLK/LRCK=256：12M288-48K；4M096-16K; 2M048-8K
	{0x02,0x00},//MCLK DIV=1		
	{0x03,0x10},	
	{0x16,0x24},	
	{0x04,0x20},	
	{0x05,0x00},
	{0x06,(0<<5) + 4 -1},//(0x06,(SCLK_INV<<5) + SCLK_DIV -1);
	{0x07,0x00},
	{0x08,0xFF},
		
		
	{0x09,(0<<7) + 0x00 + (0x00<<2)},//(0x09,(DACChannelSel<<7) + Format + (Format_Len<<2));
	{0x0A,0x00 + (0x00<<2)},//(0x0A,Format + (Format_Len<<2));



	{0x0B,0x00},
	{0x0C,0x00},	

//	{0x10,(0x1C*0) + (0x60*0x01) + 0x03},	//(0x10,(0x1C*DACHPModeOn) + (0x60*VDDA_VOLTAGE) + 0x03);	//VDDA_VOLTAGE=1.8V  close es8311MasterInit 3.3PWR setting
	{0x10,(0x1C*0) + (0x60*0x00) + 0x03},	//(0x10,(0x1C*DACHPModeOn) + (0x60*VDDA_VOLTAGE) + 0x03);	//VDDA_VOLTAGE=3.3V open es8311MasterInit 3.3PWR setting
	
	{0x11,0x7F},
	
	{0x00,0x80 + (0<<6)},//Slave  Mode	(0x00,0x80 + (MSMode_MasterSelOn<<6));//Slave  Mode	
	
	{0x0D,0x01},

	{0x01,0x3F + (0x00<<7)},//(0x01,0x3F + (MCLK<<7));
	
	{0x14,(0<<6) + (1<<4) + 0},//选择CH1输入+30DB GAIN	(0x14,(Dmic_Selon<<6) + (ADCChannelSel<<4) + ADC_PGA_GAIN);

	{0x12,0x28},
	{0x13,0x00 + (0<<4)},	//(0x13,0x00 + (DACHPModeOn<<4));	
	
	{0x0E,0x02},
	{0x0F,0x44},	
	{0x15,0x00},	
	{0x1B,0x0A},	
	{0x1C,0x6A},	
	{0x37,0x48},
	{0x44,(0 <<7)},	//(0x44,(ADC2DAC_Sel <<7));	
	{0x17,210},//(0x17,ADC_Volume);
	{0x32,100},//(0x32,DAC_Volume);


};

uint16_t es8311GetRegCnt(char* regName)
{
    if (strcmp(regName, "es8311_master") == 0)
    {
        return (sizeof(es8311_regInfo) / sizeof(es8311_regInfo[0]));
    }
    else if (strcmp(regName, "es8311_slave") == 0)
    {
        return (sizeof(es8311_regInfo) / sizeof(es8311_regInfo[0]));
    }

    return 0;
}

void codecI2cInit(void);
void codecI2cWrite(char* codecName, uint8_t slaveAddr, i2sI2cCfg_t* i2sI2cCfg);
uint8_t codecI2cRead(uint8_t slaveAddr, uint8_t regAddr);



void es8311MasterInit()
{
    uint8_t dataRead = 0xff; 
    codecI2cInit();

    for (int i = 0; i < es8311GetRegCnt("es8311_master"); i++)
    {
        codecI2cWrite("es8311", ES8311_IICADDR, (i2sI2cCfg_t*)&es8311_regInfo[i]);
        delay_us(10000); 
    }
    

#if 1
    for (int i = 0; i < es8311GetRegCnt("es8311_master"); i++)
    {
        dataRead = codecI2cRead(ES8311_IICADDR, es8311_regInfo[i].regAddr);
        printf("reg = 0x%02x, val = 0x%02x\n", es8311_regInfo[i].regAddr, dataRead);
    }
#endif    
}

void es8311SlaveInit()
{
//	uint8_t dataRead = 0xff; 
    es8311MasterInit();

    i2sI2cCfg_t i2sI2cCfg;
	i2sI2cCfg.regAddr = 0x80;
    i2sI2cCfg.regVal  = 0<<6; // Bit7 --> 1: master(default); 0: slave
    codecI2cWrite("es8311", ES8311_IICADDR, (i2sI2cCfg_t*)&i2sI2cCfg);

#if 0
    for (int i = 0; i < es8311GetRegCnt("es8311_slave"); i++)
    {
        dataRead = codecI2cRead(ES8311_IICADDR, es8311_regInfo[i].regAddr);
        printf("reg = 0x%02x, val = 0x%02x\n", es8311_regInfo[i].regAddr, dataRead);
    }
#endif 
}


uint16_t es8311GetFs()
{
	
    return ES8311_FS_NUM;
}

void es8311SetMode(i2sMode_e mode)
{
	uint8_t val = 0;
	switch(mode)
	{
		case MSB_MODE:
			val = 0x0F;
		break;

		case I2S_MODE:
			val = 0x0C;

		break;

		case LSB_MODE:
			val = 0x0D;
		break;

		case PCM_MODE:
			val = 0x2F;
		break;
	}
	codecWriteVal(CODEC_ES8311, 0x09, val);
}

