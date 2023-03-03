#ifndef  BSP_LCD_H
#define  BSP_LCD_H

#ifdef __cplusplus
extern "C" {
#endif
#include "stdio.h"
#include "string.h"
#include "ec618.h"
#include "bsp.h"

// Only need to choose which LCD you use
#define ST7789V2_ENABLE         0
#define ST7571_ENABLE			1




#if (ST7789V2_ENABLE)
#include "st7789v2.h"
#endif

#if (ST7571_ENABLE)
#include "st7571.h"
#endif



#define SPI                     SPI_INSTANCE
#define SPI_CS_LOW              do {GPIO_pinWrite(SPI_CS_GPIO_INSTANCE, 1 << SPI_CS_GPIO_PIN, 0);}while(0)
#define SPI_CS_HIGH             do {GPIO_pinWrite(SPI_CS_GPIO_INSTANCE, 1 << SPI_CS_GPIO_PIN, 1 << SPI_CS_GPIO_PIN);}while(0)
#define LCD_DS_LOW              do {GPIO_pinWrite(LCD_DS_GPIO_INSTANCE, 1 << LCD_DS_GPIO_PIN, 0);}while(0)
#define LCD_DS_HIGH             do {GPIO_pinWrite(LCD_DS_GPIO_INSTANCE, 1 << LCD_DS_GPIO_PIN, 1 << LCD_DS_GPIO_PIN);}while(0)
#define LCD_RST_LOW             do {GPIO_pinWrite(LCD_RST_GPIO_INSTANCE, 1 << LCD_RST_GPIO_PIN, 0);}while(0)
#define LCD_RST_HIGH            do {GPIO_pinWrite(LCD_RST_GPIO_INSTANCE, 1 << LCD_RST_GPIO_PIN, 1 << LCD_RST_GPIO_PIN);}while(0)

#define SPI_SEND_DATA(data)     do {SPI->DR = data;}while(0)
#define SPI_READ_DATA           (SPI->DR)
#define SPI_WAIT_TX_DONE        do {}while(!((SPI->SR & (SPI_SR_BSY_Msk | SPI_SR_TFE_Msk)) == SPI_SR_TFE_Msk))
#define SPI_IS_BUSY             do {}while((SPI->SR & SPI_SR_BSY_Msk) == SPI_SR_BSY_Msk)

#define SPI_START_DMA_CHANNEL(channel)  do {*((uint32_t*)(0x4d1f0000 + (channel << 2))) |= 0x80000000;}while(0)
#define SPI_STOP_DMA_CHANNEL(channel)   do {*((uint32_t*)(0x4d1f0000 + (channel << 2))) &= ~0x80000000;}while(0)
#define SPI_ENABLE_TX_DMA               do {SPI->DMACR |= SPI_DMACR_TXDMAE_Msk;}while(0)

// Spi cs pin
#define SPI_CS_GPIO_INSTANCE    (CS_GPIO_INSTANCE)
#define SPI_CS_GPIO_PIN         (CS_GPIO_PIN)
#define SPI_CS_PAD_ADDR         (CS_GPIO_ADDR)
#define SPI_CS_PAD_ALT_FUNC     (CS_PAD_ALT_FUNC)

// Spi clk pin
#define SPI_CLK_GPIO_INSTANCE   (CLK_GPIO_INSTANCE)
#define SPI_CLK_GPIO_PIN        (CLK_GPIO_PIN)
#define SPI_CLK_PAD_ADDR        (CLK_GPIO_ADDR)
#define SPI_CLK_PAD_ALT_FUNC    (CLK_PAD_ALT_FUNC)

// Spi mosi pin
#define SPI_MOSI_GPIO_INSTANCE  (MOSI_GPIO_INSTANCE)
#define SPI_MOSI_GPIO_PIN       (MOSI_GPIO_PIN)
#define SPI_MOSI_PAD_ADDR       (MOSI_GPIO_ADDR)
#define SPI_MOSI_PAD_ALT_FUNC   (MOSI_PAD_ALT_FUNC)

// Spi miso pin
#define SPI_MISO_GPIO_INSTANCE  (MISO_GPIO_INSTANCE)
#define SPI_MISO_GPIO_PIN       (MISO_GPIO_PIN)
#define SPI_MISO_PAD_ADDR       (MISO_GPIO_ADDR)
#define SPI_MISO_PAD_ALT_FUNC   (MISO_PAD_ALT_FUNC)


// Lcd rst pin
#define LCD_RST_GPIO_INSTANCE   (RST_GPIO_INSTANCE)
#define LCD_RST_GPIO_PIN        (RST_GPIO_PIN)
#define LCD_RST_PAD_ADDR        (RST_GPIO_ADDR)
#define LCD_RST_PAD_ALT_FUNC    (RST_PAD_ALT_FUNC)

// Lcd ds pin
#define LCD_DS_GPIO_INSTANCE    (DS_GPIO_INSTANCE)
#define LCD_DS_GPIO_PIN         (DS_GPIO_PIN)
#define LCD_DS_PAD_ADDR         (DS_GPIO_ADDR)
#define LCD_DS_PAD_ALT_FUNC     (DS_PAD_ALT_FUNC)

#if (ST7571_ENABLE)
// Lcd en pin
#define LCD_EN_GPIO_INSTANCE    (EN_GPIO_INSTANCE)
#define LCD_EN_GPIO_PIN         (EN_GPIO_PIN)
#define LCD_EN_PAD_ADDR         (EN_GPIO_ADDR)
#define LCD_EN_PAD_ALT_FUNC     (EN_PAD_ALT_FUNC)
#endif

typedef void (*pTxCb)(uint32_t event);

uint8_t lcdReadData(void);
void lcdReadId(void);
void lcdWriteCmd(uint8_t cmd);
void lcdWriteData(uint8_t data);
void lcdInit(pTxCb txCb);
void mDelay(uint32_t mDelay);
//void lcdWriteData16(uint16_t data);
//void lcdDispColor(uint16_t color);
void lcdDispWindows(void);
//void lcdWriteDataDma(uint16_t color);
void lcdWriteSetup(uint8_t * dataBuf, uint16_t dataCnt);
void lcdWriteCtrl(bool startOrStop);
void lcdClearScreen();
void lcdDispPic(uint8_t * pic);



#ifdef __cplusplus
}
#endif
#endif /* BSP_LCD_H */

