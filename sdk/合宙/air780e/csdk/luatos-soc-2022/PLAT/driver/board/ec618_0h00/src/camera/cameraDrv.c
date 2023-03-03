#include "cameraDrv.h"

extern cspiDrvInterface_t   cspiDrvInterface0;
extern cspiDrvInterface_t   cspiDrvInterface1;

extern camI2cCfg_t          sp0A39Cfg[];
extern camI2cCfg_t          sp0821Cfg[];
extern camI2cCfg_t          gc6123Cfg[];
extern camI2cCfg_t          gc032ACfg[];
extern camI2cCfg_t          bf30a2Cfg[];
extern cspiCtrl_t           cspiCtrl;
extern cspiIntCtrl_t        cspiIntCtrl;
extern cspiDataFmt_t        cspiDataFmt;

extern ARM_DRIVER_I2C Driver_I2C0;
static ARM_DRIVER_I2C   *i2cDrvInstance = &CREATE_SYMBOL(Driver_I2C, 0);

#define EIGEN_CSPI(n)             ((CSPI_TypeDef *) (MP_I2S0_BASE_ADDR + 0x1000*n))


#if (CAMERA_ENABLE_SP0A39)
 #if (SP0A39_2SDR)
    char* regName = "sp0a39_2sdr";
 #elif (SP0A39_1SDR)
    char* regName = "sp0a39_1sdr";
 #endif

#elif (CAMERA_ENABLE_SP0821)
 #if (SP0821_2SDR)
    char* regName = "sp0821_2sdr";
 #elif (SP0821_1SDR)
    char* regName = "sp0821_1sdr";
 #endif

#elif (CAMERA_ENABLE_GC6123)
 #if (GC6123_2SDR)
    char* regName = "gc6123_2sdr";
 #elif (GC6123_1SDR)
    char* regName = "gc6123_1sdr";
 #endif

#elif (CAMERA_ENABLE_GC032A)
 #if (GC032A_2SDR)
    char* regName = "gc032a_2sdr";
 #elif (GC032A_1SDR)
    char* regName = "gc032a_1sdr";
 #endif
#elif (CAMERA_ENABLE_BF30A2)
 #if (BF30A2_1SDR)
    char* regName = "bf30a2_1sdr";
 #endif 
#elif (CAMERA_ENABLE_GC6153)
 #if (GC6153_1SDR)
	char* regName = "gc6153_1sdr";
 #endif 
#endif

static uint8_t      slaveAddr;
static uint16_t     regCnt;
static camI2cCfg_t* regInfo = NULL;

#if (RTE_CSPI1 == 1)
static cspiDrvInterface_t   *cspiDrv        = &CREATE_SYMBOL(cspiDrvInterface, 1);
#else
static cspiDrvInterface_t   *cspiDrv        = &CREATE_SYMBOL(cspiDrvInterface, 0);
#endif
extern void delay_us(uint32_t us);

void findRegInfo(char* regName, uint8_t* slaveAddr, uint16_t* regCnt, camI2cCfg_t** regInfo)
{
    if (strcmp(regName, "sp0a39_2sdr") == 0)
    {
        extern camI2cCfg_t sp0A39_2sdrRegInfo[];
        *regInfo = sp0A39_2sdrRegInfo;
        *slaveAddr = SP0A39_I2C_ADDR;
        *regCnt = sp0a39GetRegCnt(regName);
    }
    else if (strcmp(regName, "sp0a39_1sdr") == 0)
    {
        extern camI2cCfg_t sp0A39_1sdrRegInfo[];
        *regInfo = sp0A39_1sdrRegInfo;
        *slaveAddr = SP0A39_I2C_ADDR;
        *regCnt = sp0a39GetRegCnt(regName);
    }
    else if (strcmp(regName, "sp0821_2sdr") == 0)
    {
        extern camI2cCfg_t sp0821_2sdrRegInfo[];
        *regInfo = sp0821_2sdrRegInfo;
        *slaveAddr = SP0821_I2C_ADDR;
        *regCnt = sp0821GetRegCnt(regName);
    }
    else if (strcmp(regName, "sp0821_1sdr") == 0)
    {
        extern camI2cCfg_t sp0821_1sdrRegInfo[];
        *regInfo = sp0821_1sdrRegInfo;
        *slaveAddr = SP0821_I2C_ADDR;
        *regCnt = sp0821GetRegCnt(regName);
    }
    else if (strcmp(regName, "gc6123_2sdr") == 0)
    {
        extern camI2cCfg_t gc6123_2sdrRegInfo[];
        *regInfo = gc6123_2sdrRegInfo;
        *slaveAddr = GC6123_I2C_ADDR;
        *regCnt = gc6123GetRegCnt(regName);
    }
    else if (strcmp(regName, "gc6123_1sdr") == 0)
    {
        extern camI2cCfg_t gc6123_1sdrRegInfo[];
        *regInfo = gc6123_1sdrRegInfo;
        *slaveAddr = GC6123_I2C_ADDR;
        *regCnt = gc6123GetRegCnt(regName);
    }
    else if (strcmp(regName, "gc032a_2sdr") == 0)
    {
        extern camI2cCfg_t gc032A_2sdrRegInfo[];
        *regInfo = gc032A_2sdrRegInfo;
        *slaveAddr = GC032A_I2C_ADDR;
        *regCnt = gc032aGetRegCnt(regName);
    }
    else if (strcmp(regName, "gc032a_1sdr") == 0)
    {
        extern camI2cCfg_t gc032A_1sdrRegInfo[];
        *regInfo = gc032A_1sdrRegInfo;
        *slaveAddr = GC032A_I2C_ADDR;
        *regCnt = gc032aGetRegCnt(regName);
    }
    else if (strcmp(regName, "bf30a2_1sdr") == 0)
    {
        extern camI2cCfg_t bf30a2_1sdrRegInfo[];
        *regInfo = bf30a2_1sdrRegInfo;
        *slaveAddr = BF30A2_I2C_ADDR;
        *regCnt = bf30a2GetRegCnt(regName);
    }
	else if (strcmp(regName, "gc6153_1sdr") == 0)
    {
        extern camI2cCfg_t gc6153_1sdrRegInfo[];
        *regInfo = gc6153_1sdrRegInfo;
        *slaveAddr = GC6153_I2C_ADDR;
        *regCnt = gc6153GetRegCnt(regName);
    }
}


void camI2cInit()
{
    i2cDrvInstance->Initialize(NULL);
    i2cDrvInstance->PowerControl(ARM_POWER_FULL);
    i2cDrvInstance->Control(ARM_I2C_BUS_SPEED, ARM_I2C_BUS_SPEED_STANDARD);
    i2cDrvInstance->Control(ARM_I2C_BUS_CLEAR, 0);

    // Backup some info about this sensor
    findRegInfo(regName, &slaveAddr, &regCnt, &regInfo);
}

void camI2cWrite(uint8_t slaveAddr, uint8_t regAddr, uint8_t regData, uint32_t num)
{
    uint8_t tempBuffer[2];

    tempBuffer[0] = regAddr;
    tempBuffer[1] = regData;
    i2cDrvInstance->MasterTransmit(slaveAddr, tempBuffer, num, false);
}

uint8_t camI2cRead(uint8_t slaveAddr, uint8_t regAddr)
{
    uint8_t a;
    a = regAddr;
    uint8_t readData;
    i2cDrvInstance->MasterTransmit(slaveAddr, (uint8_t *)&a, 1, true);   
    i2cDrvInstance->MasterReceive(slaveAddr, &readData, 1, false);
    return readData;    
}

uint8_t camReadReg(uint8_t regAddr)
{
    uint8_t recvData;

    recvData = camI2cRead(slaveAddr, regAddr);
    return recvData;
}

void camWriteReg(camI2cCfg_t* regInfo)
{
    camI2cWrite(slaveAddr, regInfo->regAddr, regInfo->regVal, 2);
}



void camRegCfg()
{
    //uint8_t dataRead;
    
    camI2cInit();

    // Configure all the registers about this sensor
    for (int i=0; i < regCnt; i++)
    {
        camI2cWrite(slaveAddr, regInfo[i].regAddr, regInfo[i].regVal, 2);
        delay_us(10000); // delay 10ms

#if 0
        dataRead = camI2cRead(slaveAddr, regInfo[i].regAddr);
        printf("reg addr=0x%02x, reg val=0x%02x\n", regInfo[i].regAddr, dataRead);
        delay_us(15000);
#endif
    }
}

void camInterfaceCfg(camParamCfg_t* config)
{
	cspiDataFmt.endianMode 	= config->endianMode;
	cspiCtrl.rxWid 			= config->wireNum;
	cspiCtrl.rxdSeq 		= config->rxSeq;
    cspiCtrl.cpol    		= config->cpol;
    cspiCtrl.cpha    		= config->cpha;
    cspiCtrl.fillYonly    	= config->yOnly;
    cspiCtrl.rowScaleRatio  = config->rowScaleRatio;
    cspiCtrl.colScaleRatio  = config->colScaleRatio;
    cspiCtrl.scaleBytes    	= config->scaleBytes;
}

void camSetMemAddr(uint32_t dataAddr)
{
    cspiDrv->ctrl(CSPI_CTRL_MEM_ADDR , dataAddr); // register the recv memory
}

void camInit(void* dataAddr, cspiCbEvent_fn cb)
{
	camResolution_e camResolution;
	
#if 0 // if used in os environment, use this api to adjust voltage
	slpManNormalIOVoltSet(IOVOLT_3_00V);
#else // used in environment without os	
	// set all pin io to 2.7V since camera max voltage is 2.7V
    GPR_clockEnable(PCLK_PMDIG);
	*(uint32_t*)0x4d020018 = 1;
	*(uint32_t*)0x4d040308 = 7; // 1:2.7V    7:3V
#endif

    // Need to enable cspi first to make camera clock working
	camParamCfg_t camParamCfg;
	
#if (CAMERA_ENABLE_SP0A39)
 #if (SP0A39_2SDR)
 	camParamCfg.wireNum  	= WIRE_2;
 #elif (SP0A39_1SDR)
 	camParamCfg.wireNum  	= WIRE_1;
 #endif
	camParamCfg.endianMode  = LSB_MODE;
	camParamCfg.rxSeq		= SEQ_0;
	camParamCfg.cpha		= 1;
	camParamCfg.cpol		= 0;
	camResolution 			= CAM_CHAIN_COUNT;

#elif (CAMERA_ENABLE_SP0821)
 #if (SP0821_2SDR)
 	camParamCfg.wireNum  	= WIRE_2;
 #elif (SP0821_1SDR)
 	camParamCfg.wireNum  	= WIRE_1;
 #endif
	camParamCfg.endianMode  = LSB_MODE;
	camParamCfg.rxSeq		= SEQ_0;	
	camParamCfg.cpha		= 1;
	camParamCfg.cpol		= 0;
	camResolution 			= CAM_CHAIN_COUNT;

#elif (CAMERA_ENABLE_GC6123)
 #if (GC6123_2SDR)
 	camParamCfg.wireNum  	= WIRE_2;
 #elif (GC6123_1SDR)
 	camParamCfg.wireNum  	= WIRE_1;
 #endif
	camParamCfg.endianMode  = LSB_MODE;
	camParamCfg.rxSeq		= SEQ_1;
	camParamCfg.cpha		= 1;
	camParamCfg.cpol		= 0;
	camParamCfg.yOnly       = 1;
    camParamCfg.rowScaleRatio		= 0;
	camParamCfg.colScaleRatio		= 0;
	camParamCfg.scaleBytes		    = 0;
	camResolution 			= CAM_CHAIN_COUNT;

#elif (CAMERA_ENABLE_GC032A)
 #if (GC032A_2SDR)
 	camParamCfg.wireNum  	= WIRE_2;
 #elif (GC032A_1SDR)
 	camParamCfg.wireNum  	= WIRE_1;
 #endif
	camParamCfg.endianMode  = LSB_MODE;
	camParamCfg.rxSeq		= SEQ_0;
	camParamCfg.cpha		= 0;
	camParamCfg.cpol		= 0;
	camResolution 			= CAM_CHAIN_COUNT;
    if (camResolution == CAM_30W)
    {
        camParamCfg.yOnly               = 0;
        camParamCfg.rowScaleRatio       = 0;
        camParamCfg.colScaleRatio       = 0;
        camParamCfg.scaleBytes          = 0;
    }
    else // CAM_8W
    {
        camParamCfg.yOnly               = 1;
        camParamCfg.rowScaleRatio       = 1;
        camParamCfg.colScaleRatio       = 1;
        camParamCfg.scaleBytes          = 1;
    }

#elif (CAMERA_ENABLE_BF30A2)
 #if (BF30A2_1SDR)
 	camParamCfg.wireNum  	= WIRE_1;
 #endif
	camParamCfg.endianMode  = LSB_MODE;
	camParamCfg.rxSeq		= SEQ_0;
	camParamCfg.cpha		= 0;
	camParamCfg.cpol		= 0;
	camParamCfg.yOnly       = 1;
    camParamCfg.rowScaleRatio		= 0;
	camParamCfg.colScaleRatio		= 0;
	camParamCfg.scaleBytes		    = 0;
	camResolution 			= CAM_CHAIN_COUNT;
#elif (CAMERA_ENABLE_GC6153)
 #if (GC6153_1SDR)
 	camParamCfg.wireNum  	= WIRE_1;
 #endif
	camParamCfg.endianMode  = LSB_MODE;
	camParamCfg.rxSeq		= SEQ_1;
	camParamCfg.cpha		= 1;
	camParamCfg.cpol		= 0;
	camParamCfg.yOnly       = 1;
    camParamCfg.rowScaleRatio       = 0;
    camParamCfg.colScaleRatio       = 0;
    camParamCfg.scaleBytes          = 0;
	camResolution 			= CAM_CHAIN_COUNT;		
#endif

    camInterfaceCfg(&camParamCfg);

	cspiDrv->ctrl(CSPI_CTRL_MEM_ADDR , (uint32_t)dataAddr); // register the recv memory
    cspiDrv->init(cb);
    
    cspiDrv->powerCtrl(CSPI_POWER_FULL);
    cspiDrv->ctrl(CSPI_CTRL_DATA_FORMAT , 0); // control cspi
    cspiDrv->ctrl(CSPI_CTRL_RXTOR , 0);
    cspiDrv->ctrl(CSPI_CTRL_FRAME_INFO0 , 0);
    cspiDrv->ctrl(CSPI_CTRL_INT_CTRL , 0);

	cspiDrv->ctrl(CSPI_CTRL_CSPICTL , 0);
	cspiDrv->ctrl(CSPI_CTRL_DMA_CTRL , 0);
	cspiDrv->ctrl(CSPI_CTRL_RESOLUTION_SET , camResolution);
    cspiDrv->ctrl(CSPI_CTRL_BUS_SPEED, (camFrequence_e)CAM_25_5_M);  // cspi working frequency
}

void camStartStop(cspiStartStop_e startStop)
{
    cspiDrv->ctrl(CSPI_CTRL_START_STOP , (uint32_t)startStop);
}

void cspiIntEnable(cspiIntEnable_e intEnable)
{
	cspiIntCtrl.frameStartIntEn = intEnable;
    cspiDrv->ctrl(CSPI_CTRL_INT_CTRL , 0); // cspi interrupt enable or disable
}

void camFlush()
{
	cspiDrv->ctrl(CSPI_CTRL_FLUSH_RX_FIFO , 0); // flush rx fifo
}

void camRegisterIRQ(cspiInstance_e instance, camIrq_fn irqCb)
{
	IRQn_Type irqNum;

	if (instance == CSPI_0)
	{
		irqNum = PXIC0_I2S0_IRQn;
	}
	else
	{
		irqNum = PXIC0_I2S1_IRQn;
	}
	
    XIC_SetVector(irqNum, irqCb);
    XIC_EnableIRQ(irqNum);	
}

PLAT_FM_RAMCODE void camRecv(uint8_t * dataAddr)
{
    cspiDrv->ctrl(CSPI_CTRL_MEM_ADDR , (uint32_t)dataAddr); // register the recv memory
    cspiDrv->recv();   
}

uint32_t camGetCspiStats(cspiInstance_e instance)
{
    return EIGEN_CSPI(instance)->STAS;
}

void camClearIntStats(cspiInstance_e instance, uint32_t mask)
{
	EIGEN_CSPI(instance)->STAS = mask;
}


