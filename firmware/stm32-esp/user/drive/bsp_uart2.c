#include "bsp_uart2.h"

// 串口2 PA2 TX  PA3 RX
void Dev_UART2SendStr(char* fmt,...){  
    uint8_t  tbuf[200] = {0};
	uint16_t i = 0,j = 0;
    
    va_list ap;
	va_start(ap,fmt);
	vsprintf((char*)tbuf, fmt, ap);
	va_end(ap);
	
    j = strlen((const char*)tbuf);
	
    for( i = 0; i < j; i++)
	{
		while(USART_GetFlagStatus(USART2, USART_FLAG_TC)==RESET){};
        USART_SendData(USART2, tbuf[i]);
	}
	while(USART_GetFlagStatus(USART2, USART_FLAG_TC)==RESET);   
}
// 发送数据
void Dev_UART2SendData(uint8_t *ch,uint16_t len){  
    uint16_t i = 0;
    for(i = 0;i < len;i++)
    {
		while(USART_GetFlagStatus(USART2,USART_FLAG_TC)==RESET){};
        USART_SendData(USART2,ch[i]);
    }
	while(USART_GetFlagStatus(USART2,USART_FLAG_TC)==RESET);        
}

void BSP_UART2Init(uint32_t bound)
{
    GPIO_InitTypeDef  GPIO_InitStructure;
    USART_InitTypeDef USART_InitStructure;
    NVIC_InitTypeDef  NVIC_InitStructure;
    
	//使能USART,GPIO
    RCC_APB1PeriphClockCmd(RCC_APB1Periph_USART2,ENABLE);
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);
    
    GPIO_InitStructure.GPIO_Pin   = GPIO_Pin_2;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_AF_PP;
    GPIO_Init(GPIOA, &GPIO_InitStructure);

    GPIO_InitStructure.GPIO_Pin  = GPIO_Pin_3;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
    GPIO_Init(GPIOA, &GPIO_InitStructure);

    // NVIC 配置
    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);
    
    NVIC_InitStructure.NVIC_IRQChannel 			        = USART2_IRQn;
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority= 3;
    NVIC_InitStructure.NVIC_IRQChannelSubPriority       = 2;
    NVIC_InitStructure.NVIC_IRQChannelCmd               = ENABLE; 
    NVIC_Init(&NVIC_InitStructure);
  
    // USART 配置
    USART_InitStructure.USART_BaudRate   = bound;
    USART_InitStructure.USART_WordLength = USART_WordLength_8b;
    USART_InitStructure.USART_StopBits   = USART_StopBits_1; 
    USART_InitStructure.USART_Parity     = USART_Parity_No;
    USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
    USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
    USART_Init(USART2, &USART_InitStructure);
    
	USART_ITConfig(USART2, USART_IT_RXNE, ENABLE);//开启串口接受中断
    USART_Cmd(USART2, ENABLE);                    //使能串口
}

/*读取USARTx->SR能避免莫名其妙的错误*/
void USART2_IRQHandler(void)
{
	uint8_t res = 0;
    if(USART_GetITStatus(USART2, USART_IT_RXNE)!=RESET) 
	{
		res = USART_ReceiveData(USART2);

		// 是否存在数据没有处理
		if( (UART2ReadFlag&0x8000)==0 )
		{
			UART2ReadBuf[UART2ReadFlag++] = res;
			if(UART2ReadFlag>=90)
			{
				UART2ReadFlag |= (1 << 15);
			}
		}           
	}
	/*溢出-如果发生溢出需要先读SR,再读DR寄存器则可清除不断入中断的问题*/
    if( USART_GetFlagStatus(USART2, USART_FLAG_ORE)==SET )
    {
        USART_ReceiveData(USART2);
        USART_ClearFlag(USART2, USART_FLAG_ORE);
    }
	USART_ClearFlag(USART2, USART_IT_RXNE);
} 












