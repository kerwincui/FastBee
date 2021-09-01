#include "bsp_uart3.h"

// 串口3 PB10 TX  PB11 RX
void BSP_UART3SendStr(char *ch){  
    uint16_t i = 0,j = 0;
    j = strlen(ch);
    
	for(i = 0;i < j;i++)
    {
		while(USART_GetFlagStatus(USART3,USART_FLAG_TC)==RESET){};
        USART_SendData(USART3,ch[i]);
    }
	while(USART_GetFlagStatus(USART3,USART_FLAG_TC)==RESET);        
}

// 发送数据
void BSP_UART3SendData(uint8_t *ch,uint16_t len){  
    uint16_t i = 0;
    for(i = 0;i < len;i++)
    {
		while(USART_GetFlagStatus(USART3,USART_FLAG_TC)==RESET){};
        USART_SendData(USART3,ch[i]);
    }
	while(USART_GetFlagStatus(USART3,USART_FLAG_TC)==RESET);        
}

void BSP_UART3Init(uint32_t bound){
    GPIO_InitTypeDef  GPIO_InitStructure;
    USART_InitTypeDef USART_InitStructure;
    NVIC_InitTypeDef  NVIC_InitStructure;
    
	//使能USART3,GPIOB
    RCC_APB1PeriphClockCmd(RCC_APB1Periph_USART3,ENABLE);
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB, ENABLE);
    
	//USART3_TX   GPIOB10
    GPIO_InitStructure.GPIO_Pin   = GPIO_Pin_10;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_AF_PP;
    GPIO_Init(GPIOB, &GPIO_InitStructure);

    //USART3_RX   GPIOB11
    GPIO_InitStructure.GPIO_Pin  = GPIO_Pin_11;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
    GPIO_Init(GPIOB, &GPIO_InitStructure);

    //Usart3 NVIC 配置
    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);
    
    NVIC_InitStructure.NVIC_IRQChannel 			        = USART3_IRQn;
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority= 3;
    NVIC_InitStructure.NVIC_IRQChannelSubPriority       = 3;
    NVIC_InitStructure.NVIC_IRQChannelCmd               = ENABLE; 
    NVIC_Init(&NVIC_InitStructure);
  
    //USART 初始化设置
    USART_InitStructure.USART_BaudRate   = bound;
    USART_InitStructure.USART_WordLength = USART_WordLength_8b;
    USART_InitStructure.USART_StopBits   = USART_StopBits_1; 
    USART_InitStructure.USART_Parity     = USART_Parity_No;
    USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
    USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
    USART_Init(USART3, &USART_InitStructure);
    
	USART_ITConfig(USART3, USART_IT_RXNE, ENABLE);//开启串口接受中断
    USART_Cmd(USART3, ENABLE);                    //使能串口
}

// 读取USARTx->SR能避免莫名其妙的错误  	
uint8_t  Usart3ReadBuf[60] = {0};
uint16_t Usart3ReadFlag = 0;
void USART3_IRQHandler(void)
{
	uint8_t res = 0;
    if(USART_GetITStatus(USART3, USART_IT_RXNE) != RESET) 
	{
		res = USART_ReceiveData(USART3);

		// 是否存在数据没有处理
		if( (Usart3ReadFlag&0x8000)==0 )
		{
			Usart3ReadBuf[Usart3ReadFlag] = res;
			Usart3ReadFlag++;
			if(Usart3ReadFlag>=59)
			{
				Usart3ReadFlag |= (1 << 15);
			}
		}           
	}
	//溢出-如果发生溢出需要先读SR,再读DR寄存器则可清除不断入中断的问题
    if( USART_GetFlagStatus(USART3,USART_FLAG_ORE)==SET )
    {
        USART_ReceiveData(USART3);
        USART_ClearFlag(USART3,USART_FLAG_ORE);
    }
	USART_ClearFlag(USART3,USART_IT_RXNE);
} 












