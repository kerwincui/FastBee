#include "lcdDrv.h"

void st7789v2_init()
{
    //--------------------------------ST7789V reset sequence------------------------------------//
    LCD_RST_HIGH;
    mDelay(50); //Delay 100ms
    LCD_RST_LOW;
    mDelay(150); //Delay 200ms
    LCD_RST_HIGH;
    mDelay(250); //Delay 500ms
    
    //-------------------------------Color Mode---------------------------------------------//
    lcdWriteCmd(0x11);
    mDelay (120); //Delay 120ms
    
    //--------------------------------Display Setting------------------------------------------//
    lcdWriteCmd(0x36);
    lcdWriteData(0x00);
    lcdWriteCmd(0x3a);
    lcdWriteData(0x05);
    
    //--------------------------------ST7789V Frame rate setting----------------------------------//
    lcdWriteCmd(0xb2);
    lcdWriteData(0x0c);
    lcdWriteData(0x0c);
    lcdWriteData(0x00);
    lcdWriteData(0x33);
    lcdWriteData(0x33);
    lcdWriteCmd(0xb7);
    lcdWriteData(0x35);
    
    //--------------------------------ST7789V Power setting--------------------------------------//
    lcdWriteCmd(0xbb);
    lcdWriteData(0x20);
    lcdWriteCmd(0xc0);
    lcdWriteData(0x2c);
    lcdWriteCmd(0xc2);
    lcdWriteData(0x01);
    lcdWriteCmd(0xc3);
    lcdWriteData(0x0b);
    lcdWriteCmd(0xc4);
    lcdWriteData(0x20);
    lcdWriteCmd(0xc6);
    lcdWriteData(0x0f);
    lcdWriteCmd(0xd0);
    lcdWriteData(0xa4);
    lcdWriteData(0xa1);
    
    //--------------------------------ST7789V gamma setting---------------------------------------//
    lcdWriteCmd(0xe0);
    lcdWriteData(0xd0);
    lcdWriteData(0x03);
    lcdWriteData(0x09);
    lcdWriteData(0x0e);
    lcdWriteData(0x11);
    lcdWriteData(0x3d);
    lcdWriteData(0x47);
    lcdWriteData(0x55);
    lcdWriteData(0x53);
    lcdWriteData(0x1a);
    lcdWriteData(0x16);
    lcdWriteData(0x14);
    lcdWriteData(0x1f);
    lcdWriteData(0x22);
    lcdWriteCmd(0xe1);
    lcdWriteData(0xd0);
    lcdWriteData(0x02);
    lcdWriteData(0x08);
    lcdWriteData(0x0d);
    lcdWriteData(0x12);
    lcdWriteData(0x2c);
    lcdWriteData(0x43);
    lcdWriteData(0x55);
    lcdWriteData(0x53);
    lcdWriteData(0x1e);
    lcdWriteData(0x1b);
    lcdWriteData(0x19);
    lcdWriteData(0x20);
    lcdWriteData(0x22);
    lcdWriteCmd(0x29);
}


