#include "bsp_adc.h"

void BSP_ADCInit(void)
{
	ADC_InitTypeDef  ADC_InitStructure;
	GPIO_InitTypeDef GPIO_InitStructure;
	
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_ADC1 | RCC_APB2Periph_GPIOA, ENABLE);
	
    RCC_ADCCLKConfig(RCC_PCLK2_Div6); 

    GPIO_InitStructure.GPIO_Pin  = GPIO_Pin_1;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AIN;
    GPIO_Init(GPIOA,&GPIO_InitStructure);

    ADC_DeInit(ADC1);
    
	/* ADC1 configuration ------------------------------------------------------*/
	ADC_InitStructure.ADC_Mode               = ADC_Mode_Independent;
	ADC_InitStructure.ADC_ScanConvMode       = DISABLE;
	ADC_InitStructure.ADC_ContinuousConvMode = DISABLE;
	ADC_InitStructure.ADC_ExternalTrigConv   = ADC_ExternalTrigConv_None;
	ADC_InitStructure.ADC_DataAlign          = ADC_DataAlign_Right;
    ADC_InitStructure.ADC_NbrOfChannel       = 1;
    ADC_Init(ADC1, &ADC_InitStructure);	
    
	ADC_Cmd(ADC1, ENABLE);
	
	ADC_ResetCalibration(ADC1);
	while(ADC_GetResetCalibrationStatus(ADC1));
	ADC_StartCalibration(ADC1);
	while(ADC_GetCalibrationStatus(ADC1));
	ADC_SoftwareStartConvCmd(ADC1,ENABLE); 
}

float ADC_GetSimpleData(void)
{
    float SimpleVoltage = 0;
    uint8_t x = 0;
	uint32_t total = 0;
	for( x = 0;x < 5; x++)
	{
        // 开启转换,等待DMA传输结束
        ADC_RegularChannelConfig(ADC1, ADC_Channel_1, 1, ADC_SampleTime_239Cycles5 );
        ADC_SoftwareStartConvCmd(ADC1, ENABLE);         
		while(!ADC_GetFlagStatus(ADC1, ADC_FLAG_EOC )){}//等待转换结束
        total += ADC_GetConversionValue(ADC1);
        Delay_ms(2);
    }
    total = (uint32_t)(total/5);
    SimpleVoltage = (float)total*3.3/4096.0*2.0;
    return SimpleVoltage;
}

















