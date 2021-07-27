/****************************************Copyright (c)****************************************************
**     
** File name:               lcd.c
** Created by:              XiaoYi
** Created date:            2020-10-16
** Version:                 v1.0
** Descriptions:            The original 
** Link address:            https://blog.csdn.net/weixin_45006076
**
*********************************************************************************************************/

#include <stdio.h>
#include "main.h"
#include "i2c.h"
#include "oled.h"
#include "codetab.h"

void oled_write_cmd(unsigned char cmd)//写命令
{
	HAL_I2C_Mem_Write(&hi2c1 ,0x78,0x00,I2C_MEMADD_SIZE_8BIT,&cmd,1,0x100);
}

void oled_write_data(unsigned char data)//写数据
{
	HAL_I2C_Mem_Write(&hi2c1 ,0x78,0x40,I2C_MEMADD_SIZE_8BIT,&data,1,0x100);
}

void oled_set_pos(unsigned char x, unsigned char y) //设置起始点坐标
{ 
	oled_write_cmd(0xb0+y);
	oled_write_cmd(((x&0xf0)>>4)|0x10);
	oled_write_cmd((x&0x0f)|0x01);
}

void oled_fill(unsigned char fill_Data)//全屏填充
{
	unsigned char m,n;
	for(m=0;m<8;m++)
	{
		oled_write_cmd(0xb0+m);		//page0-page1
		oled_write_cmd(0x00);		//low column start address
		oled_write_cmd(0x10);		//high column start address
		for(n=0;n<128;n++)
			{
				oled_write_data(fill_Data);
			}
	}
}

void oled_clear_screen(void)//清屏
{
	oled_fill(0x00);
}

//--------------------------------------------------------------
// Prototype      : void oled_wakeup(void)
// Calls          : 
// Parameters     : none
// Description    : 将OLED从休眠中唤醒
//--------------------------------------------------------------
void oled_wakeup(void)
{
	oled_write_cmd(0X8D);  //设置电荷泵
	oled_write_cmd(0X14);  //开启电荷泵
	oled_write_cmd(0XAF);  //OLED唤醒
}

//--------------------------------------------------------------
// Prototype      : void oled_sleep(void)
// Calls          : 
// Parameters     : none
// Description    : 让OLED休眠 -- 休眠模式下,OLED功耗不到10uA
//--------------------------------------------------------------
void oled_sleep(void)
{
	oled_write_cmd(0X8D);  //设置电荷泵
	oled_write_cmd(0X10);  //关闭电荷泵
	oled_write_cmd(0XAE);  //OLED休眠
}

//--------------------------------------------------------------
// Prototype      : void OLED_ShowChar(unsigned char x, unsigned char y, unsigned char ch[], unsigned char TextSize)
// Calls          : 
// Parameters     : x,y -- 起始点坐标(x:0~127, y:0~7); ch[] -- 要显示的字符串; TextSize -- 字符大小(1:6*8 ; 2:8*16)
// Description    : 显示codetab.h中的ASCII字符,有6*8和8*16可选择
//--------------------------------------------------------------
void oled_show_string(unsigned char x, unsigned char y, unsigned char ch[], unsigned char TextSize)
{
	unsigned char c = 0,i = 0,j = 0;
	switch(TextSize)
	{
		case 1:
		{
			while(ch[j] != '\0')
			{
				c = ch[j] - 32;
				if(x > 126)
				{
					x = 0;
					y++;
				}
				oled_set_pos(x,y);
				for(i=0;i<6;i++)
					oled_write_data(F6x8[c][i]);
				x += 6;
				j++;
			}
		}break;
		case 2:
		{
			while(ch[j] != '\0')
			{
				c = ch[j] - 32;
				if(x > 120)
				{
					x = 0;
					y++;
				}
				oled_set_pos(x,y);
				for(i=0;i<8;i++)
					oled_write_data(F8X16[c*16+i]);
				oled_set_pos(x,y+1);
				for(i=0;i<8;i++)
					oled_write_data(F8X16[c*16+i+8]);
				x += 8;
				j++;
			}
		}break;
	}
}

//--------------------------------------------------------------
// Prototype      : void oled_show_chinese(unsigned char x, unsigned char y, unsigned char N)
// Calls          : 
// Parameters     : x,y -- 起始点坐标(x:0~127, y:0~7); N:汉字在codetab.h中的索引
// Description    : 显示codetab.h中的汉字,16*16点阵
//--------------------------------------------------------------
void oled_show_chinese(unsigned char x, unsigned char y, unsigned char N)
{
	unsigned char wm=0;
	unsigned int  adder=32*N;
	oled_set_pos(x , y);
	for(wm = 0;wm < 16;wm++)
	{
		oled_write_data(F16x16[adder]);
		adder += 1;
	}
	oled_set_pos(x,y + 1);
	for(wm = 0;wm < 16;wm++)
	{
		oled_write_data(F16x16[adder]);
		adder += 1;
	}
}

//--------------------------------------------------------------
// Prototype      : void oled_draw_bmp(unsigned char x0,unsigned char y0,unsigned char x1,unsigned char y1,unsigned char BMP[]);
// Calls          : 
// Parameters     : x0,y0 -- 起始点坐标(x0:0~127, y0:0~7); x1,y1 -- 起点对角线(结束点)的坐标(x1:1~128,y1:1~8)
// Description    : 显示BMP位图
//--------------------------------------------------------------
void oled_draw_bmp(unsigned char x0,unsigned char y0,unsigned char x1,unsigned char y1,unsigned char *bmp)
{
	unsigned int j=0;
	unsigned char x,y;

  if(y1%8==0)
		y = y1/8;
  else
		y = y1/8 + 1;
	for(y=y0;y<y1;y++)
	{
		oled_set_pos(x0,y);
    for(x=x0;x<x1;x++)
		{
			oled_write_data(bmp[j++]);
		}
	}
}


void oled_init(void)
{
	delay_ms(100); //这里的延时很重要
	
	oled_write_cmd(0xAE); //display off
	oled_write_cmd(0x20);	//Set Memory Addressing Mode	
	oled_write_cmd(0x10);	//00,Horizontal Addressing Mode;01,Vertical Addressing Mode;10,Page Addressing Mode (RESET);11,Invalid
	oled_write_cmd(0xb0);	//Set Page Start Address for Page Addressing Mode,0-7
	oled_write_cmd(0xc8);	//Set COM Output Scan Direction
	oled_write_cmd(0x00); //---set low column address
	oled_write_cmd(0x10); //---set high column address
	oled_write_cmd(0x40); //--set start line address
	oled_write_cmd(0x81); //--set contrast control register
	oled_write_cmd(0xff); //亮度调节 0x00~0xff
	oled_write_cmd(0xa1); //--set segment re-map 0 to 127
	oled_write_cmd(0xa6); //--set normal display
	oled_write_cmd(0xa8); //--set multiplex ratio(1 to 64)
	oled_write_cmd(0x3F); //
	oled_write_cmd(0xa4); //0xa4,Output follows RAM content;0xa5,Output ignores RAM content
	oled_write_cmd(0xd3); //-set display offset
	oled_write_cmd(0x00); //-not offset
	oled_write_cmd(0xd5); //--set display clock divide ratio/oscillator frequency
	oled_write_cmd(0xf0); //--set divide ratio
	oled_write_cmd(0xd9); //--set pre-charge period
	oled_write_cmd(0x22); //
	oled_write_cmd(0xda); //--set com pins hardware configuration
	oled_write_cmd(0x12);
	oled_write_cmd(0xdb); //--set vcomh
	oled_write_cmd(0x20); //0x20,0.77xVcc
	oled_write_cmd(0x8d); //--set DC-DC enable
	oled_write_cmd(0x14); //
	oled_write_cmd(0xaf); //--turn on oled panel
}

