#include "bsp_timer3.h"

/*如果Period=N*10，那么每隔N毫秒中断一次。*/
void BSP_Timer3Init(void){
	TIM_TimeBaseInitTypeDef  TIM_TimeBaseStructure;
	NVIC_InitTypeDef NVIC_InitStructure;

	RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM3, ENABLE); //时钟使能

	TIM_TimeBaseStructure.TIM_Period = 9; //设置在下一个更新事件装入活动的自动重装载寄存器周期的值	 计数到N*10为Nms
	TIM_TimeBaseStructure.TIM_Prescaler =(7200-1); //设置用来作为TIMx时钟频率除数的预分频值  10Khz的计数频率  
	TIM_TimeBaseStructure.TIM_ClockDivision = 0; //设置时钟分割:TDTS = Tck_tim
	TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;  //TIM向上计数模式
	TIM_TimeBaseInit(TIM3, &TIM_TimeBaseStructure); //根据TIM_TimeBaseInitStruct中指定的参数初始化TIMx的时间基数单位
 
	TIM_ITConfig(      //使能或者失能指定的TIM中断
		TIM3,          //TIM3
		TIM_IT_Update| //TIM 中断源
		TIM_IT_Trigger,//TIM 触发中断源 
		ENABLE         //使能
		);
	/*配置中断优先级*/
	NVIC_InitStructure.NVIC_IRQChannel = TIM3_IRQn;  //TIM3中断
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0; //先占优先级0级
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 3;  //从优先级3级
	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE; //IRQ通道被使能
	NVIC_Init(&NVIC_InitStructure);//根据NVIC_InitStruct中指定的参数初始化外设NVIC寄存器

	TIM_Cmd(TIM3, ENABLE);         //使能TIMx外设					 
}

uint16_t UART2Count = 0;
uint8_t  UART2RecTime  = 0;

uint16_t UART3Count = 0;
uint8_t  UART3RecTime = 0;

void TIM3_IRQHandler(void)   //TIM3中断服务程序
{
	if (TIM_GetITStatus(TIM3, TIM_IT_Update) != RESET)//检查指定的TIM中断发生与否 
	{
		TIM_ClearITPendingBit(TIM3,TIM_IT_Update);    //清除TIMx的中断标志位

        // 串口2接收判断
        if((UART2ReadFlag!=0)&&(!(UART2ReadFlag&0x8000))) 
        {
            if(UART2RecTime<=200)
                UART2RecTime++;
            if(UART2RecTime >= 20)
            {
                if(UART2Count == UART2ReadFlag)
                {
                    UART2ReadFlag |= (1 << 15);
                    UART2Count   = 0;
                    UART2RecTime = 0;     
                }
                else
                {
                    UART2Count   = UART2ReadFlag;
                    UART2RecTime = 0;                   
                }
            }
        }
        else { UART2RecTime = 0; UART2Count = 0; }
        // 串口3接收判断
        if((UART3ReadFlag!=0)&&(!(UART3ReadFlag&0x8000))) 
        {
            if(UART3RecTime <= 100)
                UART3RecTime++;
            if(UART3RecTime >= 20)
            {
                if(UART3Count == UART3ReadFlag)
                {
                    UART3ReadFlag |= (1 << 15);
                    UART3Count = 0;
                    UART3RecTime  = 0;     
                }
                else
                {
                    UART3Count   = UART3ReadFlag;
                    UART3RecTime = 0;                   
                }
            }
        }
        else { UART3RecTime = 0; UART3Count = 0; }
        
        // 空气信息获取时间
        if(DevParam.AirInforGetTime<65000)    
            DevParam.AirInforGetTime++;
        // 电池图标刷新时间
        if(DevParam.BatIconRefreshTime<65000) 
            DevParam.BatIconRefreshTime++;
        // 电池信息获取时间
        if(DevParam.BatInforGetTime<65000)    
            DevParam.BatInforGetTime++;       
        // 侧边跳动时间
        if(DevParam.SideBeatTime<65000)
            DevParam.SideBeatTime++;    
        // 上报到服务器状态时间
        if(DevParam.ServerUpdateTime<65000)
            DevParam.ServerUpdateTime++;       
        // 发送时间
        if(DevParam.ESP8266SendTime<65000)
            DevParam.ESP8266SendTime++;         
    }	
}

















