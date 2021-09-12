#ifndef _SIMULATION_LCD_H_
#define _SIMULATION_LCD_H_	

#include "stm32f10x.h"

#include "bsp_clock.h" 

#include "stdlib.h"

typedef struct  
{										    
	uint16_t width;			// LCD 宽度
	uint16_t height;	    // LCD 高度
	uint16_t id;		    // LCD ID
	uint8_t  dir;			// 横屏还是竖屏控制：0，竖屏；1，横屏。	
	
	uint8_t	 wramcmd;		// 开始写gram指令
	uint8_t  setxcmd;		// 设置x坐标指令
	uint8_t  setycmd;		// 设置y坐标指令	 
}SimLCD_t; 	  
extern SimLCD_t SimLCD;	//管理LCD重要参数

//LCD的画笔颜色和背景色	 
extern uint16_t SimLCD_PointColor;// 画笔颜色
extern uint16_t SimLCD_BackColor;// 背景色

//扫描方向定义
#define SimLCD_L2R_U2D  0 //从左到右,从上到下
#define SimLCD_L2R_D2U  1 //从左到右,从下到上
#define SimLCD_R2L_U2D  2 //从右到左,从上到下
#define SimLCD_R2L_D2U  3 //从右到左,从下到上

#define SimLCD_U2D_L2R  4 //从上到下,从左到右
#define SimLCD_U2D_R2L  5 //从上到下,从右到左
#define SimLCD_D2U_L2R  6 //从下到上,从左到右
#define SimLCD_D2U_R2L  7 //从下到上,从右到左

// 默认的扫描方向
#define SimLCD_DefScanDir  SimLCD_L2R_U2D  

void SimLCD_Init(void);
void SimLCD_Clear(uint16_t color);
void SimLCD_DrawPoint(uint16_t x, uint16_t y);
uint16_t SimLCD_ReadPoint(uint16_t x, uint16_t y);
void SimLCD_Fill(uint16_t sx,uint16_t sy,uint16_t ex,uint16_t ey,uint16_t color);
void SimLCD_ColorFill(uint16_t sx,uint16_t sy,uint16_t ex,uint16_t ey,uint16_t *color);
void SimLCD_DrawLine(uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2);
void SimLCD_DrawCircle(uint16_t x0,uint16_t y0,uint8_t r);
void SimLCD_DrawRectangle(uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2);
void SimLCD_ShowNum(uint16_t x,uint16_t y,uint32_t num,uint8_t len,uint8_t size);
void SimLCD_ShowxNum(uint16_t x,uint16_t y,uint32_t num,uint8_t len,uint8_t size,uint8_t mode);
void SimLCD_ShowString(uint16_t x,uint16_t y,uint16_t width,uint16_t height,uint8_t size,uint8_t *p);

void SimLCD_FillTorus(uint16_t x0,uint16_t y0,uint16_t r0,uint16_t r1);

void SimLCD_Show_PM2_5(uint16_t x, uint16_t y);
void SimLCD_Show_ug_m3(uint16_t x, uint16_t y);
void SimLCD_Show_PM1_0(uint16_t x, uint16_t y);
void SimLCD_Show_PM10(uint16_t x, uint16_t y);

void SimLCD_NewShowChar(uint16_t x, uint16_t y, uint16_t ziti);
void SimLCD_NewShowNum32(uint16_t x, uint16_t y, uint16_t ziti);

//画笔颜色
#define SimLCDColor_WHITE         	 0xFFFF
#define SimLCDColor_BLACK         	 0x0000	  
#define SimLCDColor_BLUE         	 0x001F  
#define SimLCDColor_BRED              0XF81F
#define SimLCDColor_GRED 			 0XFFE0
#define SimLCDColor_GBLUE			 0X07FF
#define SimLCDColor_RED           	 0xF800
#define SimLCDColor_MAGENTA       	 0xF81F
#define SimLCDColor_GREEN         	 0x07E0
#define SimLCDColor_CYAN          	 0x7FFF
#define SimLCDColor_YELLOW        	 0xFFE0
#define SimLCDColor_BROWN 			 0XBC40 //棕色
#define SimLCDColor_BRRED 			 0XFC07 //棕红色
#define SimLCDColor_GRAY  			 0X8430 //灰色
//GUI颜色
#define SimLCDColor_DARKBLUE      	 0X01CF	//深蓝色
#define SimLCDColor_LIGHTBLUE      	 0X7D7C	//浅蓝色  
#define SimLCDColor_GRAYBLUE       	 0X5458 //灰蓝色
//以上三色为PANEL的颜色 
#define SimLCDColor_LIGHTGREEN     	 0X841F //浅绿色
//#define SimLCDColor_LIGHTGRAY        0XEF5B //浅灰色(PANNEL)
#define SimLCDColor_LGRAY 			 0XC618 //浅灰色(PANNEL),窗体背景色

#define SimLCDColor_LGRAYBLUE        0XA651 //浅灰蓝色(中间层颜色)
#define SimLCDColor_LBBLUE           0X2B12 //浅棕蓝色(选择条目的反色)

//9320/9325 LCD寄存器  
#define SimLCD_R0             0x00
#define SimLCD_R1             0x01
#define SimLCD_R2             0x02
#define SimLCD_R3             0x03
#define SimLCD_R4             0x04
#define SimLCD_R5             0x05
#define SimLCD_R6             0x06
#define SimLCD_R7             0x07
#define SimLCD_R8             0x08
#define SimLCD_R9             0x09
#define SimLCD_R10            0x0A
#define SimLCD_R12            0x0C
#define SimLCD_R13            0x0D
#define SimLCD_R14            0x0E
#define SimLCD_R15            0x0F
#define SimLCD_R16            0x10
#define SimLCD_R17            0x11
#define SimLCD_R18            0x12
#define SimLCD_R19            0x13
#define SimLCD_R20            0x14
#define SimLCD_R21            0x15
#define SimLCD_R22            0x16
#define SimLCD_R23            0x17
#define SimLCD_R24            0x18
#define SimLCD_R25            0x19
#define SimLCD_R26            0x1A
#define SimLCD_R27            0x1B
#define SimLCD_R28            0x1C
#define SimLCD_R29            0x1D
#define SimLCD_R30            0x1E
#define SimLCD_R31            0x1F
#define SimLCD_R32            0x20
#define SimLCD_R33            0x21
#define SimLCD_R34            0x22
#define SimLCD_R36            0x24
#define SimLCD_R37            0x25
#define SimLCD_R40            0x28
#define SimLCD_R41            0x29
#define SimLCD_R43            0x2B
#define SimLCD_R45            0x2D
#define SimLCD_R48            0x30
#define SimLCD_R49            0x31
#define SimLCD_R50            0x32
#define SimLCD_R51            0x33
#define SimLCD_R52            0x34
#define SimLCD_R53            0x35
#define SimLCD_R54            0x36
#define SimLCD_R55            0x37
#define SimLCD_R56            0x38
#define SimLCD_R57            0x39
#define SimLCD_R59            0x3B
#define SimLCD_R60            0x3C
#define SimLCD_R61            0x3D
#define SimLCD_R62            0x3E
#define SimLCD_R63            0x3F
#define SimLCD_R64            0x40
#define SimLCD_R65            0x41
#define SimLCD_R66            0x42
#define SimLCD_R67            0x43
#define SimLCD_R68            0x44
#define SimLCD_R69            0x45
#define SimLCD_R70            0x46
#define SimLCD_R71            0x47
#define SimLCD_R72            0x48
#define SimLCD_R73            0x49
#define SimLCD_R74            0x4A
#define SimLCD_R75            0x4B
#define SimLCD_R76            0x4C
#define SimLCD_R77            0x4D
#define SimLCD_R78            0x4E
#define SimLCD_R79            0x4F
#define SimLCD_R80            0x50
#define SimLCD_R81            0x51
#define SimLCD_R82            0x52
#define SimLCD_R83            0x53
#define SimLCD_R96            0x60
#define SimLCD_R97            0x61
#define SimLCD_R106           0x6A
#define SimLCD_R118           0x76
#define SimLCD_R128           0x80
#define SimLCD_R129           0x81
#define SimLCD_R130           0x82
#define SimLCD_R131           0x83
#define SimLCD_R132           0x84
#define SimLCD_R133           0x85
#define SimLCD_R134           0x86
#define SimLCD_R135           0x87
#define SimLCD_R136           0x88
#define SimLCD_R137           0x89
#define SimLCD_R139           0x8B
#define SimLCD_R140           0x8C
#define SimLCD_R141           0x8D
#define SimLCD_R143           0x8F
#define SimLCD_R144           0x90
#define SimLCD_R145           0x91
#define SimLCD_R146           0x92
#define SimLCD_R147           0x93
#define SimLCD_R148           0x94
#define SimLCD_R149           0x95
#define SimLCD_R150           0x96
#define SimLCD_R151           0x97
#define SimLCD_R152           0x98
#define SimLCD_R153           0x99
#define SimLCD_R154           0x9A
#define SimLCD_R157           0x9D
#define SimLCD_R192           0xC0
#define SimLCD_R193           0xC1
#define SimLCD_R229           0xE5	

#endif  
	 
	 



