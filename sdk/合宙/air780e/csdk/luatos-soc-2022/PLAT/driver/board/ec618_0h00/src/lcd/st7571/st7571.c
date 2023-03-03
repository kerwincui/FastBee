#include "lcdDrv.h"

uint8_t clearScreen[128] = {0};

#define USE_DMA	

#ifdef  USE_DMA
static DmaTransferConfig_t st7571DmaTxCfg =
{
    NULL,
    (void *)&(SPI->DR),
    DMA_FLOW_CONTROL_TARGET,
    DMA_ADDRESS_INCREMENT_SOURCE,
    DMA_DATA_WIDTH_ONE_BYTE,
    DMA_BURST_8_BYTES, 
    0
};
static DmaDescriptor_t __ALIGNED(16) st7571DmaTxDesc[1];
int8_t st7571DmaTxCh;
bool isDMADone = false;
uint8_t st7571DmaSrc[128] = {0};
uint8_t *pLcdData = NULL;

static void st7571DmaEventCb(uint32_t event)
{
    switch(event)
    {
        case DMA_EVENT_END:
            isDMADone = true;
			SPI_CS_HIGH;
            //DMA_stopChannel(DMA_INSTANCE_MP, st7571DmaTxCh, false);
            
            break;
        case DMA_EVENT_ERROR:
        default:
            break;
    }
}

void st7571DmaInit()
{
    // Tx config
	DMA_init(DMA_INSTANCE_MP);
    st7571DmaTxCh = DMA_openChannel(DMA_INSTANCE_MP);

    DMA_setChannelRequestSource(DMA_INSTANCE_MP, st7571DmaTxCh, (DmaRequestSource_e)SPI_DMA_TX_REQID);
    DMA_rigisterChannelCallback(DMA_INSTANCE_MP, st7571DmaTxCh, st7571DmaEventCb);
    SPI_ENABLE_TX_DMA;
}

void st7571WriteCtrl(uint32_t totalLen)
{
	// Configure tx DMA and start it
    st7571DmaTxCfg.sourceAddress = (void *)pLcdData;
    st7571DmaTxCfg.totalLength   = totalLen; // every descriptor transfer this trunk of data

	SPI_CS_LOW;
	LCD_DS_HIGH;
    DMA_buildDescriptorChain(st7571DmaTxDesc, &st7571DmaTxCfg, 1, true);
    //SPI_ENABLE_TX_DMA;

	DMA_loadChannelDescriptorAndRun(DMA_INSTANCE_MP, st7571DmaTxCh, st7571DmaTxDesc);
}
#endif


void st7571_init()
{
    //--------------------------------ST7571 reset sequence------------------------------------//
    LCD_RST_HIGH;
    mDelay(50); //Delay 100ms
    LCD_RST_LOW;
    mDelay(150); //Delay 200ms
    LCD_RST_HIGH;
    mDelay(250); //Delay 500ms
	
	lcdWriteCmd(0xAE);
    lcdWriteCmd(0xE2);
	lcdWriteCmd(0x38);	

	lcdWriteCmd(0xE1);	
	lcdWriteCmd(0xAB);	

	lcdWriteCmd(0x54);	
	lcdWriteCmd(0x48);	
	lcdWriteCmd(0x80);	

	
	lcdWriteCmd(0xB8);	

	lcdWriteCmd(0xA2);	 
	lcdWriteCmd(0xA0);	
	lcdWriteCmd(0xc8);	

	lcdWriteCmd(0x25);
	lcdWriteCmd(0x81);
	//lcdWriteCmd(v0); ////////////////////////////////////////////
	lcdWriteCmd(0x23);

	
	lcdWriteCmd(0x40);//START LINE
	lcdWriteCmd(0x00);

	lcdWriteCmd(0x44);//START LINE
	lcdWriteCmd(0x00);

	lcdWriteCmd(0x2c);	mDelay(10);
	lcdWriteCmd(0x2e);	mDelay(10);
	lcdWriteCmd(0x2F);	mDelay(10);



	lcdWriteCmd(0xAF);//DISPLAY ON


	lcdWriteCmd(0x7B);
	lcdWriteCmd(0x11); // 0x11=black/white mode; 0x10=gray mode;
	lcdWriteCmd(0x00);

	mDelay(10);		
	//disp_off();
	mDelay(50);

#ifdef USE_DMA
	st7571DmaInit();
#endif	
}


void lcdAddress(uint8_t page, uint8_t column)
{    
    lcdWriteCmd(0xB0 + page);  
    lcdWriteCmd(((column >> 4) & 0x0f) + 0x10); // column addr MSB  
    lcdWriteCmd(column & 0x0f); // column addr LSB
}

void st7571CleanScreen(void)
{    
    uint8_t j;
#ifdef USE_DMA
	pLcdData = clearScreen;
#else
	uint8_t i;
#endif

    for(j = 0; j < 16; j++)    
    {        
        lcdAddress(j, 0);   
#ifndef	USE_DMA      
        for(i = 0; i < 128; i++)       
        {           
            lcdWriteData(0x00);         
        }    
#else
		st7571WriteCtrl(128);
		
		do
		{
			delay_us(1);
		}while (isDMADone == false);
		isDMADone = false;
#endif
    }
}

void displayPic_60x80(uint8_t *p)
{
#ifndef	USE_DMA      
	uint32_t k;
#endif	
    uint32_t  n;
    st7571CleanScreen();

    for(n = 0; n < 10; n++) // 16 page
    {
        lcdAddress(n, 0);

#ifndef	USE_DMA      
        for(k = 0; k < 60; k++)// every page 64byte, total 1k
        {
            lcdWriteData(p[k + 60 * n]);
        }
#else
		pLcdData = p + 60 * n;
		st7571WriteCtrl(60);
		
		do
		{
			delay_us(1);
		}while (isDMADone == false);
		isDMADone = false;
#endif
    }
}



void testResolution()
{
    st7571CleanScreen();

	uint32_t k, n;

	for (n = 0; n < 16; n++)
	{
		lcdAddress(n, 0); // set page and initial column
        for(k = 0; k < 64/4; k++)// every page 64byte, total 1k
        {
            lcdWriteData(0xff); // write one byte 1
            lcdWriteData(0xff); // write one byte 1 again

            lcdWriteData(0); // write one byte 0
            lcdWriteData(0); // write one byte 0 again
        }
	}
}


