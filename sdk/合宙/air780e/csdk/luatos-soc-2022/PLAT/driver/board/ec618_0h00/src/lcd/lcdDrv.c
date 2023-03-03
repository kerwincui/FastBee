#include "lcdDrv.h"


extern  void delay_us(uint32_t us);
int8_t lcdDmaTxCh; // dma tx channel
DmaDescriptor_t __ALIGNED(16) lcdDmaTxDesc[HEIGHT];
//uint8_t dmaTxData[WIDTH*2];

static DmaTransferConfig_t lcdDmaTxCfg =
{
    NULL,
    (void *)&(SPI->DR),
    DMA_FLOW_CONTROL_TARGET,
    DMA_ADDRESS_INCREMENT_SOURCE,
    DMA_DATA_WIDTH_ONE_BYTE,
    DMA_BURST_8_BYTES, 
    WIDTH * 2
};



void mDelay(uint32_t mDelay)
{
    delay_us(mDelay * 1000);
}

void lcdWriteData(uint8_t data)
{
    SPI_CS_LOW;
    LCD_DS_HIGH;
    SPI_SEND_DATA(data);
    //SPI_WAIT_TX_DONE;
    SPI_IS_BUSY;
    SPI_CS_HIGH;
}



void lcdWriteCmd(uint8_t cmd)
{
    SPI_CS_LOW;
    LCD_DS_LOW;
    SPI_SEND_DATA(cmd);
    SPI_WAIT_TX_DONE;
    SPI_CS_HIGH;
}

uint8_t lcdReadData()
{
    SPI_WAIT_TX_DONE;
    SPI_SEND_DATA(0xff); // Dummy data
    SPI_WAIT_TX_DONE;
    uint8_t data = SPI_READ_DATA;
    SPI_IS_BUSY;
    return data;
}

void lcdDispWindows()
{
	lcdWriteCmd(0x2A);
	lcdWriteData(0x00);
	lcdWriteData(0x00);
	lcdWriteData(0x00);
	lcdWriteData(0xEF);

	lcdWriteCmd(0x2B);
	lcdWriteData(0x00);
	lcdWriteData(0x00);
	lcdWriteData(0x01);
	lcdWriteData(0x3f);
	lcdWriteCmd(0x2C);
}

void lcdWriteSetup(uint8_t * dataBuf, uint16_t dataCnt)
{
    lcdDispWindows();

    // Configure tx DMA and start it
    lcdDmaTxCfg.sourceAddress = (void *)dataBuf;
    //lcdDmaTxCfg.totalLength   = dataCnt; // every descriptor transfer this trunk of data

    SPI_CS_LOW;
    LCD_DS_HIGH;
    DMA_buildDescriptorChain(lcdDmaTxDesc, &lcdDmaTxCfg, dataCnt / LCD_TRANSFER_SIZE_ONCE, false);
    SPI_ENABLE_TX_DMA;
}

void lcdWriteCtrl(bool startOrStop)
{
    if (startOrStop)
    {
        DMA_loadChannelDescriptorAndRun(DMA_INSTANCE_MP, lcdDmaTxCh, lcdDmaTxDesc);
    }
    else
    {    
        extern void DMA_stopChannelNoWait(DmaInstance_e instance, uint32_t channel);
        DMA_stopChannelNoWait(DMA_INSTANCE_MP, lcdDmaTxCh);
        SPI_CS_HIGH;
    }
}

void lcdDispColor(uint16_t color)
{
    //lcdFillColorBuf(color);
    
    for (int i = 0; i < HEIGHT; i++)
    {
        lcdWriteCtrl(true);
    }
}



void lcdReadId()
{
    uint8_t id1, id2, id3;

    LCD_RST_HIGH;
    mDelay(150); // Delay 200ms
    LCD_RST_LOW;
    mDelay(300); // Delay 400ms
    LCD_RST_HIGH;
    mDelay(400); // Delay 500ms

    lcdWriteData(0x04);
    (void)lcdReadData(); // Dummy
    id1 = lcdReadData();
    id2 = lcdReadData();
    id3 = lcdReadData();
    printf("LCD ID: %02x, %02x, %02x \r\n", id1, id2, id3);
}

static void lcdGpioInit()
{
    PadConfig_t config;

    PAD_getDefaultConfig(&config);

    // Cs pin
    config.mux = SPI_CS_PAD_ALT_FUNC;
    PAD_setPinConfig(SPI_CS_PAD_ADDR, &config);

    GpioPinConfig_t gpioCfg;
    gpioCfg.pinDirection = GPIO_DIRECTION_OUTPUT;
    GPIO_pinConfig(SPI_CS_GPIO_INSTANCE, SPI_CS_GPIO_PIN, &gpioCfg);

    // Rst pin
    config.mux = LCD_RST_PAD_ALT_FUNC;
    PAD_setPinConfig(LCD_RST_PAD_ADDR, &config);

    gpioCfg.pinDirection = GPIO_DIRECTION_OUTPUT;
    //gpioCfg.misc.initOutput = 1;
    GPIO_pinConfig(LCD_RST_GPIO_INSTANCE, LCD_RST_GPIO_PIN, &gpioCfg);

    // Ds pin
    config.mux = LCD_DS_PAD_ALT_FUNC;
    PAD_setPinConfig(LCD_DS_PAD_ADDR, &config);

    gpioCfg.pinDirection = GPIO_DIRECTION_OUTPUT;
    GPIO_pinConfig(LCD_DS_GPIO_INSTANCE, LCD_DS_GPIO_PIN, &gpioCfg);

#if (ST7571_ENABLE)
#if 0 // if used in environment with os, use this api to adjust voltage
    slpManAONIOVoltSet(IOVOLT_2_95V); // 54
    APmuWakeupPadSettings_t cfg;
    cfg.pullUpEn = 1;
    slpManSetWakeupPadCfg(WAKEUP_PAD_4, false, &cfg); //gpio21   50
	slpManAONIOPowerOn();//70
#else // used in environment without os
	*(uint32_t*)0x4d020018 = 0x1; // Normal gpio: 2.8V
	*(uint32_t*)0x4d020054 = 0x1b; // AON IO: 3.35V, 2.8V
	*(uint32_t*)0x4d020150 = 0x7; // Enable AON gpio as wakeup pin
	*(uint32_t*)0x4d020170 = 0x1; // Enable AON IO
#endif

	// Lcd en pin
	config.mux = LCD_EN_PAD_ALT_FUNC;
    PAD_setPinConfig(LCD_EN_PAD_ADDR, &config);
    
	gpioCfg.pinDirection = GPIO_DIRECTION_OUTPUT;
	gpioCfg.misc.initOutput = 1;
    GPIO_pinConfig(LCD_EN_GPIO_INSTANCE, LCD_EN_GPIO_PIN, &gpioCfg);
#endif
}

static void lcdSpiInit()
{
    PadConfig_t config;

    PAD_getDefaultConfig(&config);

    config.mux = SPI_CLK_PAD_ALT_FUNC;
    PAD_setPinConfig(SPI_CLK_PAD_ADDR, &config);
    
    config.mux = SPI_MOSI_PAD_ALT_FUNC;
    PAD_setPinConfig(SPI_MOSI_PAD_ADDR, &config);
    
    config.mux = SPI_MISO_PAD_ALT_FUNC;
    PAD_setPinConfig(SPI_MISO_PAD_ADDR, &config);

    // Enable spi clock
    GPR_clockEnable(SPI_APB_CLOCK);
    GPR_clockEnable(SPI_FUNC_CLOCK);

    // Disable spi first
    SPI->CR1 = 0;

    // Pol = 0; PHA = 0; Data width = 8
    SPI->CR0 = 0x7;

    // lcd spi clock choose 26M by default to speed up the fps.
    CLOCK_clockEnable(CLK_HF51M); // open 51M
    CLOCK_setClockSrc(FCLK_SPI0, FCLK_SPI0_SEL_51M); // choose 51M
    SPI->CPSR = 2 & SPI_CPSR_CPSDVSR_Msk; // 2 division, to 26M
    SPI->CR0 = (SPI->CR0 & ~SPI_CR0_SCR_Msk) | 0;

    // Enable spi
    SPI->CR1 = SPI_CR1_SSE_Msk;
}



void lcdWriteData16(uint16_t data)
{
    lcdWriteData(data >> 8);
    lcdWriteData(data);
}

void lcdDispPic(uint8_t * pic)
{
#if (ST7789V2_ENABLE)
    int i, j;

    lcdDispWindows();
    for (i = 0; i < HEIGHT; i++)
    {
        for (j = 0; j < WIDTH; j++)
        {
            lcdWriteData16(pic[j*2 + HEIGHT*i*2]);
        }
    }
#elif  (ST7571_ENABLE)
	displayPic_60x80(pic);
#endif
}

void lcdClearScreen()
{
#if (ST7571_ENABLE)
	st7571CleanScreen();
#endif
}

void lcdInit(pTxCb txCb)
{
    lcdSpiInit();
    lcdGpioInit();
    
    lcdReadId();
#if (ST7789V2_ENABLE)
    st7789v2_init();
#endif

#if (ST7571_ENABLE)
	st7571_init();
	lcdClearScreen();
#else

    // Tx config
    DMA_init(DMA_INSTANCE_MP);
    lcdDmaTxCh = DMA_openChannel(DMA_INSTANCE_MP);

    DMA_setChannelRequestSource(DMA_INSTANCE_MP, lcdDmaTxCh, (DmaRequestSource_e)SPI_DMA_TX_REQID);
    DMA_rigisterChannelCallback(DMA_INSTANCE_MP, lcdDmaTxCh, txCb);
    //DMA_transferSetup(DMA_INSTANCE_MP, lcdDmaTxCh, &lcdDmaTxCfg);
    //DMA_transferSetup(DMA_INSTANCE_MP, lcdDmaTxCh, &lcdDmaConfig);
#endif    
}


