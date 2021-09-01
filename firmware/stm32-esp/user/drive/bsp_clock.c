#include "bsp_clock.h"

static uint8_t  fac_us = 0;
static uint16_t fac_ms = 0;

//功能：systick初始化
void BSP_ClockInit(void)
{
	SysTick_CLKSourceConfig(SysTick_CLKSource_HCLK_Div8);	//选择外部时钟  HCLK/8
    fac_us=SystemCoreClock/8000000;//为系统时钟的1/8  
	fac_ms = (uint16_t)fac_us*1000;
}

//功能：毫秒级延时,最多1864ms
void Delay_ms(uint32_t nms)
{	 		  	  
	uint32_t temp = 0;
	SysTick->LOAD=(uint32_t)nms*fac_ms;//时间加载(SysTick->LOAD为24bit)
	SysTick->VAL =0x00;           //清空计数器
	SysTick->CTRL|=SysTick_CTRL_ENABLE_Msk ;	//开始倒数	
	do
	{
		temp=SysTick->CTRL;
	}
	while( (temp&0x01) && (!(temp&(1<<16))) );//等待时间到达   
	SysTick->CTRL&=~SysTick_CTRL_ENABLE_Msk;  //关闭计数器
	SysTick->VAL =0X00;       //清空计数器	    
}

//功能：微秒级延时，最多1800ms  								   
void Delay_us(uint32_t nus)
{		
	uint32_t temp;	    	 
	SysTick->LOAD=nus*fac_us; //时间加载	  		 
	SysTick->VAL=0x00;        //清空计数器
	SysTick->CTRL|=SysTick_CTRL_ENABLE_Msk ;	//开始倒数	
	do
	{
		temp=SysTick->CTRL;
	}
	while( (temp&0x01) && (!(temp&(1<<16))) );//等待时间到达   
	SysTick->CTRL&=~SysTick_CTRL_ENABLE_Msk;  //关闭计数器
	SysTick->VAL =0X00;       //清空计数器
}









