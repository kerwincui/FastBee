#include "simulation_lcd.h"
#include "simulation_font.h"

// LCD的画笔颜色和背景色	   
uint16_t SimLCD_PointColor = 0x0000;// 画笔颜色
uint16_t SimLCD_BackColor  = 0xFFFF;// 背景色

// 管理LCD参数 默认为竖屏
SimLCD_t SimLCD = {0};

// 读出数据控制线
#define Simulation_RD(x) (x)?(GPIOB->BSRR = (1<<6)):(GPIOB->BRR = (1<<6))
// 写入数据控制线
#define Simulation_WR(x) (x)?(GPIOB->BSRR = (1<<7)):(GPIOB->BRR = (1<<7))
// 数据/命令选择管脚(1:数据读写,0:命令读写)
#define Simulation_RS(x) (x)?(GPIOB->BSRR = (1<<8)):(GPIOB->BRR = (1<<8))
// 片选信号线
#define Simulation_CS(x) (x)?(GPIOB->BSRR = (1<<9)):(GPIOB->BRR = (1<<9))

// 16位双向数据线 1 输入 2 输出
static uint8_t PortDir = 0;
static void Simulation_SetOut(void) {
    if( PortDir != 2 )
    {
       GPIO_InitTypeDef GPIO_InitStructure;

        // PC0/1/2/3/4/5/6/7
        GPIO_InitStructure.GPIO_Pin   = GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3|GPIO_Pin_4|GPIO_Pin_5|GPIO_Pin_6|GPIO_Pin_7;
        GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_Out_PP;
        GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
        GPIO_Init(GPIOC,&GPIO_InitStructure);
        
        // PA5/6/7/8/9/10/11/12
        GPIO_InitStructure.GPIO_Pin   = GPIO_Pin_5|GPIO_Pin_6|GPIO_Pin_7|GPIO_Pin_8|GPIO_Pin_9|GPIO_Pin_10|GPIO_Pin_11|GPIO_Pin_12;
        GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_Out_PP;
        GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
        GPIO_Init(GPIOA,&GPIO_InitStructure);        

        PortDir = 2;
    }
}
static void Simulation_SetIn(void) {  
    if( PortDir != 1 )
    {
       GPIO_InitTypeDef GPIO_InitStructure;

        // PC0/1/2/3/4/5/6/7
        GPIO_InitStructure.GPIO_Pin   = GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3|GPIO_Pin_4|GPIO_Pin_5|GPIO_Pin_6|GPIO_Pin_7;
        GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_IN_FLOATING;
        GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
        GPIO_Init(GPIOC,&GPIO_InitStructure);
        
        // PA5/6/7/8/9/10/11/12
        GPIO_InitStructure.GPIO_Pin   = GPIO_Pin_5|GPIO_Pin_6|GPIO_Pin_7|GPIO_Pin_8|GPIO_Pin_9|GPIO_Pin_10|GPIO_Pin_11|GPIO_Pin_12;
        GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_IN_FLOATING;
        GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
        GPIO_Init(GPIOA,&GPIO_InitStructure);         
        
        PortDir = 1;
    }
}
static void Simulation_WriteData(uint16_t data) {
    uint16_t flag = 0;
    flag = (data>>0)&0x00FF;
    GPIOC->BSRR = flag;
	flag = (~flag)&0x00FF;
    GPIOC->BRR  = flag;
    
    flag = 0;
    flag = (uint16_t)(((data>>8)&0x00FF)<<5);
    GPIOA->BSRR = flag;
    flag = (uint16_t)(((~((data>>8)&0x00FF))&0x00FF)<<5);
    GPIOA->BRR  = flag;
}
static uint16_t Simulation_ReadData(void) {
    uint16_t flag1 = 0;
    uint16_t flag2 = 0;
    flag1 = GPIOC->IDR;
    flag2 = (uint16_t)(flag1&0x00FF);
    
    flag1 = 0;
    flag1 = GPIOA->IDR;
    flag2 = flag2 + (uint16_t)((flag1<<3)&0xFF00); 
    
   return flag2;
}

static void SimLCD_WriteCmd(uint16_t data) {
    Simulation_SetOut();
    
	Simulation_RS(0);
    Simulation_RD(1);
    Simulation_CS(0);
	Delay_us(1);
    Simulation_WriteData(data);
    Delay_us(1);
    Simulation_WR(0);
    Delay_us(1);
    Simulation_WR(1);
    Simulation_CS(1);
}
static void SimLCD_WriteData(uint16_t data) {
    Simulation_SetOut();

	Simulation_RS(1);
	Simulation_RD(1);
    Simulation_CS(0);
	Delay_us(1);
    Simulation_WriteData(data);
    Delay_us(1);
    Simulation_WR(0);
    Delay_us(1);
    Simulation_WR(1);
    Simulation_CS(1);
}

static uint16_t SimLCD_ReadData(void) {
    uint16_t flag = 0;
    
    Simulation_SetIn();

    Simulation_RS(1);
    Simulation_WR(1);
	Simulation_RD(0);
    Simulation_CS(0);    
    Delay_us(1);
    flag = Simulation_ReadData();
	Delay_us(1);
    Simulation_RD(1);
    Simulation_CS(1);
    return flag;
}
// 开始写GRAM
void SimLCD_WriteRAMPrepare(void){
	SimLCD_WriteCmd(SimLCD.wramcmd);	
}

// LCD写GRAM
// RGB_Code:颜色值
void SimLCD_WriteRAM(uint16_t RGB_Code){							    
	SimLCD_WriteData(RGB_Code);
}

//从ILI93xx读出的数据为GBR格式，而我们写入的时候为RGB格式。
//通过该函数转换
//c:GBR格式的颜色值
//返回值：RGB格式的颜色值
uint16_t SimLCD_BGR2RGB(uint16_t c){
	uint16_t r,g,b,rgb;   
	b  = (c>>0)&0x1f;
	g  = (c>>5)&0x3f;
	r  = (c>>11)&0x1f;	 
	rgb=(b<<11)+(g<<5)+(r<<0);		 
	return(rgb);
} 
// 当mdk -O1时间优化时需要设置
void SimLCD_Delay(u8 i){
	while(i--);
}
//设置光标位置
//Xpos:横坐标
//Ypos:纵坐标
void SimLCD_SetCursor(uint16_t Xpos, uint16_t Ypos) {	 
    if( (SimLCD.id==0X9341) || (SimLCD.id==0X6804) )
	{	
		SimLCD_WriteCmd(SimLCD.setxcmd);   /* 设置X坐标 */
		SimLCD_WriteData( Xpos >> 8 );	      	 /* 先高8位，然后低8位 */
		SimLCD_WriteData( Xpos & 0x00ff );	     /* 设置起始点和结束点*/

		SimLCD_WriteCmd( SimLCD.setycmd ); /* 设置Y坐标*/
		SimLCD_WriteData( Ypos >> 8 );
		SimLCD_WriteData( Ypos & 0x00ff );
	}
    else
	{
		if(SimLCD.dir==1)
			Xpos = SimLCD.width-1-Xpos;// 横屏其实就是调转x,y坐标
		SimLCD_WriteCmd(SimLCD.setxcmd);
		SimLCD_WriteData( Xpos );
		SimLCD_WriteCmd(SimLCD.setxcmd);
		SimLCD_WriteData( Ypos );
	}	 
}
// 读取个某点的颜色值	 
// x,y:坐标
// 返回值:此点的颜色
uint16_t SimLCD_ReadPoint(uint16_t x, uint16_t y) {
    uint16_t r = 0,g = 0,b = 0;
    if( (x>=SimLCD.width) || (y>=SimLCD.height) ) return 0;	// 超过了范围,直接返回		   
    SimLCD_SetCursor(x, y);	    
    if( (SimLCD.id==0X9341) || (SimLCD.id==0X6804) )
        SimLCD_WriteCmd(0X2E);   // 9341/6804 发送读GRAM指令
    else 
        SimLCD_WriteCmd(SimLCD_R34); //其他IC发送读GRAM指令
    if(SimLCD.id==0X9320)
        SimLCD_Delay(2);		 // FOR 9320,延时2us	    
    
	if(SimLCD_ReadData())
        r = 0;						 // dummy Read	   
    SimLCD_Delay(2);	  
    r = SimLCD_ReadData();  		  						//实际坐标颜色
    if(SimLCD.id==0X9341)	 // 9341要分2次读出
    {
        SimLCD_Delay(2);	
        b = 0;        
		b = SimLCD_ReadData(); 
        g = r&0xFF;//对于9341,第一次读取的是RG的值,R在前,G在后,各占8位
        g <<= 8;
    }
    else if(SimLCD.id==0X6804)
        r = SimLCD_ReadData();//6804第二次读取的才是真实值
    if(SimLCD.id==0X9325||SimLCD.id==0X4535||SimLCD.id==0X4531||SimLCD.id==0X8989||SimLCD.id==0XB505)
        return r;//这几种IC直接返回颜色值
    else if(SimLCD.id==0X9341)
        return (((r>>11)<<11)|((g>>10)<<5)|(b>>11));	//ILI9341需要公式转换一下
    else 
        return SimLCD_BGR2RGB(r);				//其他IC
}			 
//LCD开启显示
void SimLCD_DisplayOn(void){					   
	if(SimLCD.id==0X9341||SimLCD.id==0X6804)
		SimLCD_WriteCmd(0X29);		 //开启显示
	else 
	{
		//开启显示
		SimLCD_WriteCmd(SimLCD_R7);
		SimLCD_WriteData(0x0173);
	}
}	 
//LCD关闭显示
void SimLCD_DisplayOff(void){	   
	if(SimLCD.id==0X9341||SimLCD.id==0X6804)
		SimLCD_WriteCmd(0X28);
	else 
	{
		SimLCD_WriteCmd(SimLCD_R7);
		SimLCD_WriteData(0x0);
	}
}   
 		 
//设置LCD的自动扫描方向
//注意:其他函数可能会受到此函数设置的影响(尤其是9341/6804这两个奇葩),
//所以,一般设置为L2R_U2D即可,如果设置为其他扫描方式,可能导致显示不正常.
//dir:0~7,代表8个方向(具体定义见lcd.h)
//9320/9325/9328/4531/4535/1505/b505/8989/5408/9341等IC已经实际测试	   	   
void SimLCD_ScanDir(uint8_t dir) {
	uint16_t regval = 0, temp = 0;
	uint8_t  dirreg = 0;
	// 横屏时，对6804不改变扫描方向！
	if(SimLCD.dir==1 && SimLCD.id!=0X6804) {			   
		switch(dir)//方向转换
		{
			case 0:dir=6;break;
			case 1:dir=7;break;
			case 2:dir=4;break;
			case 3:dir=5;break;
			case 4:dir=1;break;
			case 5:dir=0;break;
			case 6:dir=3;break;
			case 7:dir=2;break;	     
		}
	}
	// 9341/6804,很特殊
	if(SimLCD.id==0x9341||SimLCD.id==0X6804) {
		switch(dir)
		{
			case SimLCD_L2R_U2D://从左到右,从上到下
				regval|=(0<<7)|(0<<6)|(0<<5); 
				break;
			case SimLCD_L2R_D2U://从左到右,从下到上
				regval|=(1<<7)|(0<<6)|(0<<5); 
				break;
			case SimLCD_R2L_U2D://从右到左,从上到下
				regval|=(0<<7)|(1<<6)|(0<<5); 
				break;
			case SimLCD_R2L_D2U://从右到左,从下到上
				regval|=(1<<7)|(1<<6)|(0<<5); 
				break;	 
			case SimLCD_U2D_L2R://从上到下,从左到右
				regval|=(0<<7)|(0<<6)|(1<<5); 
				break;
			case SimLCD_U2D_R2L://从上到下,从右到左
				regval|=(0<<7)|(1<<6)|(1<<5); 
				break;
			case SimLCD_D2U_L2R://从下到上,从左到右
				regval|=(1<<7)|(0<<6)|(1<<5); 
				break;
			case SimLCD_D2U_R2L://从下到上,从右到左
				regval|=(1<<7)|(1<<6)|(1<<5); 
				break;	 
		}
		dirreg = 0X36;
 		regval|= 0X08;// BGR   
		if(SimLCD.id==0X6804) 
			regval |= 0x02;			// 6804的BIT6和9341的反了	   
		
		SimLCD_WriteCmd(dirreg);
		SimLCD_WriteData(regval);		
 		
		if(regval&0X20)
		{
			if(SimLCD.width < SimLCD.height)//交换X,Y
			{
				temp = SimLCD.width;
				SimLCD.width = SimLCD.height;
				SimLCD.height= temp;
 			}
		}else  
		{
			if(SimLCD.width > SimLCD.height)//交换X,Y
			{
				temp = SimLCD.width;
				SimLCD.width  = SimLCD.height;
				SimLCD.height = temp;
 			}
		}
		
		SimLCD_WriteCmd(SimLCD.setxcmd); 
		SimLCD_WriteData(0); 
		SimLCD_WriteData(0);
		SimLCD_WriteData((SimLCD.width-1)>>8);
		SimLCD_WriteData((SimLCD.width-1)&0XFF);
		
		SimLCD_WriteCmd(SimLCD.setycmd); 
		SimLCD_WriteData(0);
		SimLCD_WriteData(0);
		SimLCD_WriteData((SimLCD.height-1)>>8);
		SimLCD_WriteData((SimLCD.height-1)&0XFF);  
  	}
	else  {
		switch(dir)
		{
			case SimLCD_L2R_U2D://从左到右,从上到下
				regval|=(1<<5)|(1<<4)|(0<<3); 
				break;
			case SimLCD_L2R_D2U://从左到右,从下到上
				regval|=(0<<5)|(1<<4)|(0<<3); 
				break;
			case SimLCD_R2L_U2D://从右到左,从上到下
				regval|=(1<<5)|(0<<4)|(0<<3);
				break;
			case SimLCD_R2L_D2U://从右到左,从下到上
				regval|=(0<<5)|(0<<4)|(0<<3); 
				break;	 
			case SimLCD_U2D_L2R://从上到下,从左到右
				regval|=(1<<5)|(1<<4)|(1<<3); 
				break;
			case SimLCD_U2D_R2L://从上到下,从右到左
				regval|=(1<<5)|(0<<4)|(1<<3); 
				break;
			case SimLCD_D2U_L2R://从下到上,从左到右
				regval|=(0<<5)|(1<<4)|(1<<3); 
				break;
			case SimLCD_D2U_R2L://从下到上,从右到左
				regval|=(0<<5)|(0<<4)|(1<<3); 
				break;	 
		}
		if(SimLCD.id==0x8989)//8989 IC
		{
			dirreg=0X11;
			regval|=0X6040;	//65K   
	 	}else//其他驱动IC		  
		{
			dirreg=0X03;
			regval|=1<<12;  
		}
		SimLCD_WriteCmd(dirreg);
		SimLCD_WriteData(regval);
	}
}   
//画点
//x,y:坐标
//POINT_COLOR:此点的颜色
void SimLCD_DrawPoint(uint16_t x, uint16_t y) {
	SimLCD_SetCursor(x,y);		//设置光标位置 
	SimLCD_WriteRAMPrepare();	//开始写入GRAM
	SimLCD_WriteData(SimLCD_PointColor);
}
//快速画点
//x,y:坐标
//color:颜色
void SimLCD_FastDrawPoint(uint16_t x,uint16_t y,uint16_t color) {	   
	if(SimLCD.id==0X9341||SimLCD.id==0X6804)
	{	
		SimLCD_WriteCmd(SimLCD.setxcmd);
		SimLCD_WriteData(x>>8); 
		SimLCD_WriteData(x&0XFF);	
		
		SimLCD_WriteCmd(SimLCD.setycmd); 
		SimLCD_WriteData(y>>8); 
		SimLCD_WriteData(y&0XFF);
	}
	else
	{
 		if(SimLCD.dir==1) 
			x = SimLCD.width-1-x;//横屏其实就是调转x,y坐标
		
		SimLCD_WriteCmd(SimLCD.setxcmd);
		SimLCD_WriteData(x); 	
		
		SimLCD_WriteCmd(SimLCD.setycmd); 
		SimLCD_WriteData(y);
	}	
	SimLCD_WriteCmd(SimLCD.wramcmd); 
	SimLCD_WriteData(color);
}

// 设置LCD显示方向（6804不支持横屏显示）
// dir:0,竖屏；1,横屏
void SimLCD_DisplayDir(uint8_t dir) {
	if(dir==0)//竖屏
	{
		SimLCD.dir   = 0;  //竖屏
		SimLCD.width = 240;//--宽度
		SimLCD.height= 320;//--高度
		if(SimLCD.id==0X9341||SimLCD.id==0X6804)
		{
			SimLCD.wramcmd=0X2C;	//--开始写grammer指令
	 		SimLCD.setxcmd=0X2A;
			SimLCD.setycmd=0X2B;  	 
			if(SimLCD.id==0X6804)
			{
				SimLCD.width =320;
				SimLCD.height=480;
			}
		}
	}
	else if(SimLCD.id!=0X6804)//6804不支持横屏显示	
	{	  
		SimLCD.dir   =1;//横屏
		SimLCD.width =320;
		SimLCD.height=240;
		if(SimLCD.id==0X9341)
		{
			SimLCD.wramcmd=0X2C;
	 		SimLCD.setxcmd=0X2A;
			SimLCD.setycmd=0X2B;  	 
		}else if(SimLCD.id==0X8989)
		{
			SimLCD.wramcmd = SimLCD_R34;
	 		SimLCD.setxcmd = 0X4F;
			SimLCD.setycmd = 0X4E;  
		}else
		{
			SimLCD.wramcmd = SimLCD_R34;
	 		SimLCD.setxcmd = SimLCD_R33;
			SimLCD.setycmd = SimLCD_R32;  
		}
	} 
	SimLCD_ScanDir(SimLCD_DefScanDir);	//默认扫描方向
}
//清屏函数
//color:要清屏的填充色
void SimLCD_Clear(uint16_t color) {
	uint32_t index=0;      
	uint32_t totalpoint = SimLCD.width;
	totalpoint *= SimLCD.height;         // 得到总点数
	
	SimLCD_SetCursor(0x0000, 0x0000);    // 设置光标位置 
	
	SimLCD_WriteRAMPrepare();            // 开始写入GRAM	 	  
	for(index = 0; index < totalpoint; index++)
		SimLCD_WriteData(color);
}
static void SimLCD9341_Init(void){
	SimLCD_WriteCmd(0xCF);  
	SimLCD_WriteData(0x00); 
	SimLCD_WriteData(0xC1); 
	SimLCD_WriteData(0X30); 

	SimLCD_WriteCmd(0xED);  
	SimLCD_WriteData(0x64); 
	SimLCD_WriteData(0x03); 
	SimLCD_WriteData(0X12); 
	SimLCD_WriteData(0X81);

	SimLCD_WriteCmd(0xE8);  
	SimLCD_WriteData(0x85); 
	SimLCD_WriteData(0x10); 
	SimLCD_WriteData(0x7A); 

	SimLCD_WriteCmd(0xCB);  
	SimLCD_WriteData(0x39); 
	SimLCD_WriteData(0x2C); 
	SimLCD_WriteData(0x00); 
	SimLCD_WriteData(0x34); 
	SimLCD_WriteData(0x02); 

	SimLCD_WriteCmd(0xF7);  
	SimLCD_WriteData(0x20);

	SimLCD_WriteCmd(0xEA);  
	SimLCD_WriteData(0x00); 
	SimLCD_WriteData(0x00); 

	SimLCD_WriteCmd(0xC0);    //Power control 
	SimLCD_WriteData(0x1B);   //VRH[5:0] 

	SimLCD_WriteCmd(0xC1);    //Power control 
	SimLCD_WriteData(0x01);   //SAP[2:0];BT[3:0] 

	SimLCD_WriteCmd(0xC5);    //VCM control 
	SimLCD_WriteData(0x30); 	 //-3F
	SimLCD_WriteData(0x30); 	 //=3C

	SimLCD_WriteCmd(0xC7);    //VCM control2 
	SimLCD_WriteData(0XB7); 

	SimLCD_WriteCmd(0x36);    //Memory Access Control 
	SimLCD_WriteData(0x48); 

	SimLCD_WriteCmd(0x3A);   
	SimLCD_WriteData(0x55); 

	SimLCD_WriteCmd(0xB1);   
	SimLCD_WriteData(0x00); 
	SimLCD_WriteData(0x1A); 

	SimLCD_WriteCmd(0xB6);    //Display Function Control 
	SimLCD_WriteData(0x0A); 
	SimLCD_WriteData(0xA2); 

	SimLCD_WriteCmd(0xF2);    //3Gamma Function Disable 
	SimLCD_WriteData(0x00); 

	SimLCD_WriteCmd(0x26);    //Gamma curve selected 
	SimLCD_WriteData(0x01); 

	SimLCD_WriteCmd(0xE0);    //Set Gamma 
	SimLCD_WriteData(0x0F); 
	SimLCD_WriteData(0x2A); 
	SimLCD_WriteData(0x28); 
	SimLCD_WriteData(0x08); 
	SimLCD_WriteData(0x0E); 
	SimLCD_WriteData(0x08); 
	SimLCD_WriteData(0x54); 
	SimLCD_WriteData(0XA9); 
	SimLCD_WriteData(0x43); 
	SimLCD_WriteData(0x0A); 
	SimLCD_WriteData(0x0F); 
	SimLCD_WriteData(0x00); 
	SimLCD_WriteData(0x00); 
	SimLCD_WriteData(0x00); 
	SimLCD_WriteData(0x00); 

	SimLCD_WriteCmd(0XE1);    //Set Gamma 
	SimLCD_WriteData(0x00); 
	SimLCD_WriteData(0x15); 
	SimLCD_WriteData(0x17); 
	SimLCD_WriteData(0x07); 
	SimLCD_WriteData(0x11); 
	SimLCD_WriteData(0x06); 
	SimLCD_WriteData(0x2B); 
	SimLCD_WriteData(0x56); 
	SimLCD_WriteData(0x3C); 
	SimLCD_WriteData(0x05); 
	SimLCD_WriteData(0x10); 
	SimLCD_WriteData(0x0F); 
	SimLCD_WriteData(0x3F); 
	SimLCD_WriteData(0x3F); 
	SimLCD_WriteData(0x0F); 

	SimLCD_WriteCmd(0x2B); 
	SimLCD_WriteData(0x00);
	SimLCD_WriteData(0x00);
	SimLCD_WriteData(0x01);
	SimLCD_WriteData(0x3f);

	SimLCD_WriteCmd(0x2A); 
	SimLCD_WriteData(0x00);
	SimLCD_WriteData(0x00);
	SimLCD_WriteData(0x00);
	SimLCD_WriteData(0xef);	

	SimLCD_WriteCmd(0x11); //Exit Sleep
	Delay_ms(120);
	SimLCD_WriteCmd(0x29); //display on		
}

static void SimLCD6804_Init(void){
	SimLCD_WriteCmd(0X11);
	Delay_ms(20);

	SimLCD_WriteCmd(0XD0);//VCI1  VCL  VGH  VGL DDVDH VREG1OUT power amplitude setting
	SimLCD_WriteData(0X07); 
	SimLCD_WriteData(0X42); 
	SimLCD_WriteData(0X1D); 

	SimLCD_WriteCmd(0XD1);//VCOMH VCOM_AC amplitude setting
	SimLCD_WriteData(0X00);
	SimLCD_WriteData(0X1a);
	SimLCD_WriteData(0X09); 

	SimLCD_WriteCmd(0XD2);//Operational Amplifier Circuit Constant Current Adjust , charge pump frequency setting
	SimLCD_WriteData(0X01);
	SimLCD_WriteData(0X22);

	SimLCD_WriteCmd(0XC0);//REV SM GS 
	SimLCD_WriteData(0X10);
	SimLCD_WriteData(0X3B);
	SimLCD_WriteData(0X00);
	SimLCD_WriteData(0X02);
	SimLCD_WriteData(0X11);

	SimLCD_WriteCmd(0XC5);// Frame rate setting = 72HZ  when setting 0x03
	SimLCD_WriteData(0X03);

	SimLCD_WriteCmd(0XC8);//Gamma setting
	SimLCD_WriteData(0X00);
	SimLCD_WriteData(0X25);
	SimLCD_WriteData(0X21);
	SimLCD_WriteData(0X05);
	SimLCD_WriteData(0X00);
	SimLCD_WriteData(0X0a);
	SimLCD_WriteData(0X65);
	SimLCD_WriteData(0X25);
	SimLCD_WriteData(0X77);
	SimLCD_WriteData(0X50);
	SimLCD_WriteData(0X0f);
	SimLCD_WriteData(0X00);	  
				  
	SimLCD_WriteCmd(0XF8);
	SimLCD_WriteData(0X01);	  

	SimLCD_WriteCmd(0XFE);
	SimLCD_WriteData(0X00);
	SimLCD_WriteData(0X02);

	SimLCD_WriteCmd(0X20);//Exit invert mode

	SimLCD_WriteCmd(0X36);
	SimLCD_WriteData(0X08);//原来是a

	SimLCD_WriteCmd(0X3A);
	SimLCD_WriteData(0X55);//16位模式

	SimLCD_WriteCmd(0X2B);
	SimLCD_WriteData(0X00);
	SimLCD_WriteData(0X00);
	SimLCD_WriteData(0X01);
	SimLCD_WriteData(0X3F);

	SimLCD_WriteCmd(0X2A);
	SimLCD_WriteData(0X00);
	SimLCD_WriteData(0X00);
	SimLCD_WriteData(0X01);
	SimLCD_WriteData(0XDF);
	Delay_ms(120);
	SimLCD_WriteCmd(0X29); 	 
}
//初始化lcd
//该初始化函数可以初始化各种ILI93XX液晶,但是其他函数是基于ILI9320的!!!
//在其他型号的驱动芯片上没有测试! 
/*******************************************************
    CS： TFTLCD 片选信号。
    WR：向 TFTLCD 写入数据。
    RD：从 TFTLCD 读取数据。
    D[15:0]: 16 位双向数据线。
    RST：硬复位 TFTLCD。
    RS：命令/数据标志（ 0，读写命令； 1，读写数据）
*******************************************************/
void SimLCD_Init(void) {  
    GPIO_InitTypeDef GPIO_InitStructure;
    
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA|RCC_APB2Periph_GPIOB|RCC_APB2Periph_GPIOC,ENABLE);
 	// B6/B7/B8/B9
    GPIO_InitStructure.GPIO_Pin   = GPIO_Pin_6|GPIO_Pin_7|GPIO_Pin_8|GPIO_Pin_9;
	GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_Out_PP;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOB,&GPIO_InitStructure);
    
    Simulation_CS(1);Simulation_RD(1);Simulation_WR(1);Simulation_RS(1);
	
    // 设置端口位输出模式
    Simulation_SetOut();
    
 	Delay_ms(50);
    Delay_ms(50);
    // 读到ID不正确,新增lcddev.id==0X9300判断，因为9341在未被复位的情况下会被读成9300    
  	if( (SimLCD.id<0XFF) || (SimLCD.id==0XFFFF) || (SimLCD.id==0X9300) )
	{
 		//尝试9341 ID的读取		
		SimLCD_WriteCmd(0xD3);				   
		SimLCD_ReadData(); 				//dummy read 	
 		SimLCD_ReadData();   	    	//读到0X00
        SimLCD.id  = ((SimLCD_ReadData()<<8)&0xff00);//读取93								   
		SimLCD.id |= (SimLCD_ReadData()&0x00ff);     //读取41 	   			   
 		if(SimLCD.id!=0x9341)		    //非9341,尝试是不是6804
		{	
 			SimLCD_WriteCmd(0xBF);				   
			SimLCD_ReadData(); 			//dummy read 	 
	 		SimLCD_ReadData();   	    //读回0X01
			SimLCD.id  = ((SimLCD_ReadData()<<8)&0xff00);//读取0X68 							   
			SimLCD.id |= (SimLCD_ReadData()&0x00ff);     //读取0X04	  
 		} 
		if(SimLCD.id!=0x9341&&SimLCD.id!=0x6804)
			SimLCD.id=0x9341;//新增，用于识别9341 	     
	}
    // 9341初始化
    if(SimLCD.id==0X9341)
        SimLCD9341_Init();
    // 6804初始化
    else if(SimLCD.id==0x6804)
        SimLCD6804_Init();

    SimLCD_DisplayDir(0);		 	// 默认为竖屏
    SimLCD_Clear(SimLCDColor_BLACK);
} 

#if 1
void SimLCD_AllPic(uint16_t *PIC) {
	uint32_t index=0;      
	uint32_t totalpoint=SimLCD.width;
	totalpoint*=SimLCD.height; 	 //得到总点数
	SimLCD_SetCursor(0x00,0x0000);//设置光标位置 
	SimLCD_WriteRAMPrepare();     //开始写入GRAM	 	  
	for(index=0;index < 320*480;index++)
		SimLCD_WriteData(PIC[index]);
}
#endif

//在指定区域内填充单个颜色
//(sx,sy),(ex,ey):填充矩形对角坐标,区域大小为:(ex-sx+1)*(ey-sy+1)   
//color:要填充的颜色
void SimLCD_Fill(uint16_t sx,uint16_t sy,uint16_t ex,uint16_t ey,uint16_t color) {          
	uint16_t i,j;
	uint16_t xlen=0;
	xlen=ex-sx+1;	   
	for(i=sy;i<=ey;i++)
	{
	 	SimLCD_SetCursor(sx,i);  // 设置光标位置 
		SimLCD_WriteRAMPrepare();// 开始写入GRAM	  
		for(j = 0;j < xlen; j++) 	    // 设置光标位置 	    
			SimLCD_WriteData(color);	
	}
}  
//在指定区域内填充指定颜色块			 
//(sx,sy),(ex,ey):填充矩形对角坐标,区域大小为:(ex-sx+1)*(ey-sy+1)   
//color:要填充的颜色
void SimLCD_ColorFill(uint16_t sx,uint16_t sy,uint16_t ex,uint16_t ey,uint16_t *color) {  
	uint16_t height,width;
	uint16_t i,j;
	width=ex-sx+1; 		//得到填充的宽度
	height=ey-sy+1;		//高度
 	for(i = 0;i < height;i++)
	{
 		SimLCD_SetCursor(sx,sy+i); //设置光标位置 
		SimLCD_WriteRAMPrepare();  //开始写入GRAM
		for(j = 0;j < width;j++)
			SimLCD_WriteData(color[i*width+j]);	
	}
}  
//画线
//x1,y1:起点坐标
//x2,y2:终点坐标  
void SimLCD_DrawLine(uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2) {
	uint16_t t = 0; 
	int xerr=0,yerr=0,delta_x,delta_y,distance; 
	int incx,incy,uRow,uCol; 
	delta_x=x2-x1; //计算坐标增量 
	delta_y=y2-y1; 
	uRow=x1; 
	uCol=y1; 
	if(delta_x>0)incx=1; //设置单步方向 
	else if(delta_x==0)incx=0;//垂直线 
	else {incx=-1;delta_x=-delta_x;} 
	if(delta_y>0)incy=1; 
	else if(delta_y==0)incy=0;//水平线 
	else{incy=-1;delta_y=-delta_y;} 
	if( delta_x>delta_y)distance=delta_x; //选取基本增量坐标轴 
	else distance=delta_y; 
	for(t=0;t<=distance+1;t++ )//画线输出 
	{  
		SimLCD_DrawPoint(uRow,uCol);//画点 
		xerr+=delta_x; 
		yerr+=delta_y; 
		if(xerr>distance) 
		{ 
			xerr-=distance; 
			uRow+=incx; 
		} 
		if(yerr>distance) 
		{ 
			yerr-=distance; 
			uCol+=incy; 
		} 
	}  
}    
//画矩形	  
//(x1,y1),(x2,y2):矩形的对角坐标
void SimLCD_DrawRectangle(uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2) {
	SimLCD_DrawLine(x1,y1,x2,y1);
	SimLCD_DrawLine(x1,y1,x1,y2);
	SimLCD_DrawLine(x1,y2,x2,y2);
	SimLCD_DrawLine(x2,y1,x2,y2);
}

//在指定位置画一个指定大小的圆
//(x,y):中心点
//r    :半径
void SimLCD_DrawCircle(uint16_t x0,uint16_t y0,uint8_t r) {
	int a  = 0,b = 0;
	int di = 0;
	a = 0; b = r;	  
	di = 3-(r<<1);             //判断下个点位置的标志
	while(a <= b)
	{
		SimLCD_DrawPoint(x0+a,y0-b);             //5
 		SimLCD_DrawPoint(x0+b,y0-a);             //0           
		SimLCD_DrawPoint(x0+b,y0+a);             //4               
		SimLCD_DrawPoint(x0+a,y0+b);             //6 
		SimLCD_DrawPoint(x0-a,y0+b);             //1       
 		SimLCD_DrawPoint(x0-b,y0+a);             
		SimLCD_DrawPoint(x0-a,y0-b);             //2             
  		SimLCD_DrawPoint(x0-b,y0-a);             //7     	         
		a++;
		
        //使用Bresenham算法画圆     
		if(di<0) di +=4*a+6;	  
		else
		{
			di+=10+4*(a-b);   
			b--;
		} 						    
	}
}

#if 1
//-在指定位置显示一个字符
//-x,y:起始坐标
//-num:要显示的字符:" "--->"~"
//-size:字体大小 12/16   这是字体的高度
//-mode:叠加方式(1)还是非叠加方式(0)
void SimLCD_ShowChar(uint16_t x,uint16_t y,uint8_t num,uint8_t size,uint8_t mode) {  							  
	uint8_t temp = 0, t1 = 0, t = 0;
	uint16_t y0 = y, colortemp = SimLCD_PointColor;
	
	// 设置窗口		   
	num=num-' ';	//得到偏移后的值
	if(!mode) 		//非叠加方式
	{
	    for(t = 0;t < size;t++)
	    {   
			if(size==12)
				temp=Simulation_Asc1206[num][t];//调用1206字体
			else 
				temp=Simulation_Asc1608[num][t];//调用1608字体 
				
	        for(t1=0;t1<8;t1++)
			{			    
		        if(temp&0x80)
					SimLCD_PointColor = colortemp;
				else 
					SimLCD_PointColor = SimLCD_BackColor;
				
				SimLCD_DrawPoint(x,y);	
				temp<<=1;
				y++;
				if(x>=SimLCD.width){SimLCD_PointColor=colortemp;return;}//超区域了
				if((y-y0)==size)	//--达到高度值
				{
					y=y0;
					x++;
					if(x>=SimLCD.width){SimLCD_PointColor=colortemp;return;}//超区域了
					break;
				}
			}  	 
	    }    
	}
    else//叠加方式
	{
	    for(t=0;t<size;t++)
	    {   
			if(size==12)
				temp=Simulation_Asc1206[num][t];//调用1206字体
			else 
				temp=Simulation_Asc1608[num][t];//调用1608字体 
			
	        for(t1=0;t1<8;t1++)
			{			    
		        if(temp&0x80) SimLCD_DrawPoint(x,y); 
				temp<<=1;
				y++;
				if(x>=SimLCD.height){SimLCD_PointColor=colortemp;return;}//超区域了
				if((y-y0)==size)
				{
					y=y0;
					x++;
					if(x>=SimLCD.width){SimLCD_PointColor=colortemp;return;}//超区域了
					break;
				}
			}  	 
	    }     
	}
	SimLCD_PointColor = colortemp;	    	   	 	  
}
#endif
//m^n函数
//返回值:m^n次方.
uint32_t SimLCD_Pow(uint8_t m,uint8_t n) {
	uint32_t result = 1;	 
	while(n--)result*=m;    
	return result;
}
/* 显示数字,高位为0,则不显示
    x,y :起点坐标	 
    len :数字的位数
    size:字体大小
    color:颜色 
    num:数值(0~4294967295);	
*/
void SimLCD_ShowNum(uint16_t x,uint16_t y,uint32_t num,uint8_t len,uint8_t size) {         	
	uint8_t t = 0, temp = 0, enshow = 0;	   
	for(t = 0; t < len; t++)
	{
		temp=(num/SimLCD_Pow(10,len-t-1))%10;
		if(enshow==0&&t<(len-1))
		{
			if(temp==0)
			{
				SimLCD_ShowChar(x+(size/2)*t,y,' ',size,1);
				continue;
			}
			else enshow=1; 
		 	 
		}
	 	SimLCD_ShowChar(x+(size/2)*t,y,temp+'0',size,1); 
	}
} 
/* 显示数字,高位为0,还是显示
    x,y:起点坐标
    num:数值(0~999999999);	 
    len:长度(即要显示的位数)
    size:字体大小
    mode:
    [7]:0,不填充;1,填充0.
    [6:1]:保留
    [0]:0,非叠加显示;1,叠加显示.
*/
void SimLCD_ShowxNum(uint16_t x,uint16_t y,uint32_t num,uint8_t len,uint8_t size,uint8_t mode) {  
	uint8_t t = 0, temp = 0, enshow = 0;				   
	for(t = 0;t < len; t++)
	{
		temp=(num/SimLCD_Pow(10,len-t-1))%10;
		if(enshow==0&&t<(len-1))
		{
			if(temp==0)
			{
				if(mode&0X80)
                    SimLCD_ShowChar(x+(size/2)*t,y,'0',size,mode&0X01);  
				else 
                    SimLCD_ShowChar(x+(size/2)*t,y,' ',size,mode&0X01);  
 				continue;
			}
            else 
                enshow=1; 
		}
	 	SimLCD_ShowChar(x+(size/2)*t,y,temp+'0',size,mode&0X01); 
	}
}
/*  显示字符串
    x,y:起点坐标
    width,height:区域大小  
    size:字体大小
    *p:字符串起始地址	
*/
void SimLCD_ShowString(uint16_t x,uint16_t y,uint16_t width,uint16_t height,uint8_t size,uint8_t *p) {         
	uint8_t x0 = x;
	width+=x;
	height+=y;
    while((*p<='~')&&(*p>=' '))//判断是不是非法字符!
    {       
        if(x>=width){x=x0;y+=size;}
        if(y>=height)break;//退出
        SimLCD_ShowChar(x,y,*p,size,0);
        x+=size/2;
        p++;
    }  
}
void SimLCD_NewShowChar(uint16_t x, uint16_t y, uint16_t ziti){
 	uint8_t temp = 0, t = 0, t1 = 0;
    uint16_t y0 = y;
    for(t = 0;t < 16;t++)
    {   
        temp = Simulation_Asc1608[ziti][t];//调用1608字体 
            
        for(t1 = 0; t1 < 8; t1++)
        {			    
            if(temp&0x80)
                SimLCD_PointColor = SimLCDColor_WHITE;
            else 
                SimLCD_PointColor = SimLCDColor_BLACK;				
            SimLCD_DrawPoint(x, y);	
            temp<<=1;
            y++;
            if(x>=SimLCD.width){SimLCD_PointColor=SimLCDColor_WHITE;return;}//超区域了
            if((y-y0)==16)	//--达到高度值
            {
                y=y0;
                x++;
                if(x>=SimLCD.width){SimLCD_PointColor=SimLCDColor_WHITE;return;}//超区域了
                break;
            }
        }  	 
    }    
}

void SimLCD_NewShowNum32(uint16_t x, uint16_t y, uint16_t ziti){
 	uint8_t temp = 0, t = 0, t1 = 0;
    uint16_t y0 = y;
    for(t = 0;t < 36;t++)
    {   
        temp = Simulation_Asc3838[ziti][t];
            
        for(t1 = 0; t1 < 8; t1++)
        {			    
            if(temp&0x80)
                SimLCD_PointColor = SimLCDColor_WHITE;
            else 
                SimLCD_PointColor = SimLCDColor_BLACK;				
            SimLCD_DrawPoint(x, y);	
            temp<<=1;
            y++;
            if((y-y0)==32)	//--达到高度值
            {
                y=y0;
                x++;
                break;
            }
        }  	 
    }    
}

// 写到LCD的PM2.5
void SimLCD_ShowPM2_5(uint16_t x, uint16_t y, uint16_t ziti){
 	uint8_t temp = 0, t = 0, t1 = 0;
    uint16_t y0 = y;
    for(t = 0;t < 36;t++)
    {   
        temp = Simulation_Asc3636[ziti][t];//调用1608字体 
            
        for(t1 = 0; t1 < 8; t1++)
        {			    
            if(temp&0x80)
                SimLCD_PointColor = SimLCDColor_WHITE;
            else 
                SimLCD_PointColor = SimLCDColor_BLACK;				
            SimLCD_DrawPoint(x, y);	
            temp <<= 1;
            y++;
            if((y-y0)==24)	//--达到高度值
            {
                y=y0;
                x++;
                break;
            }
        }  	 
    }    
}

void SimLCD_Show_PM2_5(uint16_t x, uint16_t y) {         
    // P
    SimLCD_ShowPM2_5( (x+0),  y, 0);
    // M
    SimLCD_ShowPM2_5( (x+12),  y, 1);
    // 2
    SimLCD_ShowPM2_5( (x+24), y, 2);
    // .
    SimLCD_ShowPM2_5( (x+36), y, 3);
    // 5
    SimLCD_ShowPM2_5( (x+48), y, 4);
}

void SimLCD_Show_ug_m3(uint16_t x, uint16_t y) {         
    // u
    SimLCD_NewShowChar( (x+0),  y, 85);
    // g
    SimLCD_NewShowChar( (x+8),  y, 71);
    // /
    SimLCD_NewShowChar( (x+16), y, 15);
    // m
    SimLCD_NewShowChar( (x+24), y, 77);
    // 3
    SimLCD_NewShowChar( (x+32), y, 19);
}

void SimLCD_Show_PM1_0(uint16_t x, uint16_t y) {         
    // P
    SimLCD_NewShowChar( (x+0),  y, 48);
    // M
    SimLCD_NewShowChar( (x+8),  y, 45);
    // 1
    SimLCD_NewShowChar( (x+16), y, 17);
    // .
    SimLCD_NewShowChar( (x+24), y, 14);
    // 0
    SimLCD_NewShowChar( (x+32), y, 16);
}

void SimLCD_Show_PM10(uint16_t x, uint16_t y) {         
    // P
    SimLCD_NewShowChar( (x+0),  y, 48);
    // M
    SimLCD_NewShowChar( (x+8),  y, 45);
    // 1
    SimLCD_NewShowChar( (x+16), y, 17);
    // 0
    SimLCD_NewShowChar( (x+24), y, 16);
}

//x0,y0:坐标
//r半径
//color:颜色
void SimLCD_FillCircle(uint16_t x0,uint16_t y0,uint16_t r0) {                                                                                          
    uint16_t x,y,r = r0;
    for(y = y0 - r;y < y0 +r;y++)
    {
        for(x=x0 - r;x < x0+r;x++)
        {
            if(((x-x0)*(x-x0)+(y-y0)*(y-y0)) <= r*r)
            {
                SimLCD_DrawPoint(x,y);
            }
        }
    }
}
// 填充圆环 r0外圆 r1内圆
void SimLCD_FillTorus(uint16_t x0,uint16_t y0,uint16_t r0,uint16_t r1) {                                                                                          
    uint16_t x = 0,y = 0,r = r0;
    
    uint32_t area0 = 0,area1 = 0;
    
    if(r0 < r1)
        return;
    
    area0 = r0 * r0; area1 = r1 * r1;
    
    for(y = y0 - r; y < y0+r; y++)
    {
        for(x=x0 - r; x < x0+r; x++)
        {
            // 外圆填充
            if(((x-x0)*(x-x0)+(y-y0)*(y-y0)) <= area0)
            {
                // 内圆填充
                if(((x-x0)*(x-x0)+(y-y0)*(y-y0)) > area1)
                    SimLCD_DrawPoint(x,y);
            }
        }
    }
}






