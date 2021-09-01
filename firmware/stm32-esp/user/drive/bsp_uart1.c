#include "bsp_uart1.h"

void BSP_UART1SendStr(char *ch){  
    uint16_t i = 0,j = 0;
    j = strlen(ch);
    
	for(i = 0;i < j;i++)
    {
		while(USART_GetFlagStatus(USART1,USART_FLAG_TC)==RESET){};
        USART_SendData(USART1,ch[i]);
    }
	while(USART_GetFlagStatus(USART1,USART_FLAG_TC)==RESET);        
}

// 发送数据
void BSP_UART1SendData(uint8_t *ch,uint16_t len){  
    uint16_t i;
    for(i = 0;i < len;i++)
    {
		while(USART_GetFlagStatus(USART1,USART_FLAG_TC)==RESET){};
        USART_SendData(USART1,ch[i]);
    }
	while(USART_GetFlagStatus(USART1,USART_FLAG_TC)==RESET);        
}

void BSP_UART1Init(uint32_t bound){
    GPIO_InitTypeDef  GPIO_InitStructure;
    USART_InitTypeDef USART_InitStructure;
    NVIC_InitTypeDef  NVIC_InitStructure;
    //使能USART1,GPIOA
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_USART1|RCC_APB2Periph_GPIOA,ENABLE);
      
    //USART1_TX   GPIOA.9
    GPIO_InitStructure.GPIO_Pin   = GPIO_Pin_9;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_AF_PP;
    GPIO_Init(GPIOA, &GPIO_InitStructure);

    //USART1_RX GPIOA.10初始化
    GPIO_InitStructure.GPIO_Pin  = GPIO_Pin_10;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
    GPIO_Init(GPIOA, &GPIO_InitStructure);

    //Usart1 NVIC 配置
    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);
    
    NVIC_InitStructure.NVIC_IRQChannel 					= USART1_IRQn;
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority= 3;
    NVIC_InitStructure.NVIC_IRQChannelSubPriority 		= 1;
    NVIC_InitStructure.NVIC_IRQChannelCmd			    = ENABLE; 
    NVIC_Init(&NVIC_InitStructure);
  
   //USART 初始化设置
    USART_InitStructure.USART_BaudRate   = bound;
    USART_InitStructure.USART_WordLength = USART_WordLength_8b;
    USART_InitStructure.USART_StopBits   = USART_StopBits_1; 
    USART_InitStructure.USART_Parity     = USART_Parity_No;
    USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
    USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
    USART_Init(USART1,&USART_InitStructure);
	
	USART_ITConfig(USART1,USART_IT_RXNE,ENABLE);
    USART_Cmd(USART1, ENABLE);
}

// 读取USARTx->SR能避免莫名其妙的错误  	
uint8_t  Usart1ReadBuf[100] = {0};
uint16_t Usart1ReadFlag = 0;
void USART1_IRQHandler(void){
	uint8_t res = 0;
    if(USART_GetITStatus(USART1,USART_IT_RXNE) != RESET) 
	{
		res =USART_ReceiveData(USART1);

		// 是否存在数据没有处理
		if( (Usart1ReadFlag&0x8000)==0 )
		{
			Usart1ReadBuf[Usart1ReadFlag] = res;
			Usart1ReadFlag++;

			// 判断是否接收结束
			if(Usart1ReadFlag>=90)
			{
				Usart1ReadFlag |= (1 << 15);
			}
		}           
	}
	//溢出-如果发生溢出需要先读SR,再读DR,则可清除不断入中断的问题
    if( USART_GetFlagStatus(USART1,USART_FLAG_ORE)==SET )
    {
        USART_ReceiveData(USART1);
        USART_ClearFlag(USART1,USART_FLAG_ORE);
    }
	USART_ClearFlag(USART1,USART_IT_RXNE);
} 












