#include "pm_uart3.h"

// 校验 
// 校验正确--0xff 校验错误--0x00
uint8_t PMD4_CheckSum(uint8_t *data) {
    uint8_t i = 0, result = 0;
    uint16_t sum = 0;
    
    if( (data[0] == 0x42) && (data[1] == 0x4d) )
    {
        for(i = 0; i < 30; i++)
        {
            sum += data[i];
        }
        if( sum == ((data[30]<<8) + data[31]) )
        {
            result = 0xff;
        }
    }
    return result;
}
// PM 初始化
void PMD4_Init(void) {
    Power_PMD4(1);
    
    Delay_ms(200);
    
    BSP_UART3Init(9600);
    
    Delay_ms(200);
}

// 请求获取空气信息
void PMD4_ReqGetAirInfor(uint8_t Code)  {
    uint16_t sum = 0;
    uint8_t  data[20] = {0};
    uint8_t  i = 0;
    
    data[0] = 0x42;
    data[1] = 0x4d;
    
    data[2] = Code;
    
    data[3] = 0x00;
    data[4] = 0x00;

    for(i = 0; i < 5; i++)
    {
        sum += data[i];
    }
    data[5] = (uint8_t)(sum>>8);
    data[6] = (uint8_t)(sum>>0);
    
    BSP_UART3SendData(data, 7);
}
/*PMD4，获取空气信息*/
void PMD4_GetAirInfor(void) 
{
    #ifdef Device_LCD
    uint16_t x = 0, y = 0;
    uint8_t  i = 0;
    #endif
    
    if(UART3ReadFlag&0x8000)
	{
        if( PMD4_CheckSum(UART3ReadBuf)==0xff)
        {
            DevParam.PM1_0 = (uint16_t)(UART3ReadBuf[4]<<8) + (uint16_t)(UART3ReadBuf[5]<<0);
            DevParam.PM2_5 = (uint16_t)(UART3ReadBuf[6]<<8) + (uint16_t)(UART3ReadBuf[7]<<0);
            DevParam.PM10  = (uint16_t)(UART3ReadBuf[8]<<8) + (uint16_t)(UART3ReadBuf[9]<<0);
        }
		UART3ReadFlag = 0;
		memset((void *)UART3ReadBuf, 0, sizeof(UART3ReadBuf));
	}    
    if(DevParam.AirInforGetTime >= 2000)
    {
        //PMD4_ReqGetAirInfor(0xE2);
        DevParam.AirInforGetTime = 0;
    }
    /**********显示实时空气信息*****************/
    #ifdef Device_LCD
    // PM1.0
    if(DevParam.ShowPM1_0 != DevParam.PM1_0)  
    {
        x = (uint16_t)(SimLCD.width/2/2-20);
        y = 260;              

        // 1
        i = (uint8_t)(DevParam.PM1_0/100);
        SimLCD_NewShowChar( (x+8),  y, (i + 16));
        // 1
        i = (uint8_t)(DevParam.PM1_0/10%10);
        SimLCD_NewShowChar( (x+16), y, (i + 16));
        // 0
        i = (uint8_t)(DevParam.PM1_0%10);
        SimLCD_NewShowChar( (x+24), y, (i + 16));            

        DevParam.ShowPM1_0 = DevParam.PM1_0;      
    }
    // PM2.5
    if(DevParam.ShowPM2_5 != DevParam.PM2_5)  
    {
        x = (uint16_t)(SimLCD.width/2-20);
        y = 80;
       
        // 1
        i = (uint8_t)(DevParam.PM2_5/100);
        SimLCD_NewShowChar( (x+8),  y, (i + 16));
        // 1
        i = (uint8_t)(DevParam.PM2_5/10%10);
        SimLCD_NewShowChar( (x+16), y, (i + 16));
        // 0
        i = (uint8_t)(DevParam.PM2_5%10);
        SimLCD_NewShowChar( (x+24), y, (i + 16));  
        
        DevParam.ShowPM2_5 = DevParam.PM2_5;      
    }
    // PM10    
    if(DevParam.PM10 != DevParam.ShowPM10)    
    {
        x = (uint16_t)(SimLCD.width/2/2*3-16);
        y = 260;

        // 1
        i = (uint8_t)(DevParam.PM10/100);
        SimLCD_NewShowChar( (x+8),  y, (i + 16));
        // 1
        i = (uint8_t)(DevParam.PM10/10%10);
        SimLCD_NewShowChar( (x+16), y, (i + 16));
        // 0
        i = (uint8_t)(DevParam.PM10%10);
        SimLCD_NewShowChar( (x+24), y, (i + 16));
        
        DevParam.ShowPM10 = DevParam.PM10;      
    }
    #endif
}
/*显示部分，基础外形刷新*/
void Show_BasicShapeRefresh(void) {
    #ifdef Device_LCD
    uint16_t x = 0, y = 0;
    
    // 画上边内圆  
    x = (uint16_t)(SimLCD.width/2);
    y = (uint16_t)(SimLCD.height/3) + 10;
    
    // 填充圆环 r0外圆 r1内圆
    SimLCD_PointColor = SimLCDColor_CYAN;
    SimLCD_FillTorus( x, y, 100, 90);

    // 画下边两个圆
    x = (uint16_t)(SimLCD.width/2/2*3);
    y = (uint16_t)(SimLCD.height/3*2) + (uint16_t)(SimLCD.height/3/2);   
    
    // 填充圆环 r0外圆 r1内圆
    SimLCD_PointColor = SimLCDColor_YELLOW;
    SimLCD_FillTorus( x, y, 50, 45);    
    
    x = (uint16_t)(SimLCD.width/2/2);
    y = (uint16_t)(SimLCD.height/3*2) + (uint16_t)(SimLCD.height/3/2);
    SimLCD_PointColor = SimLCDColor_LIGHTGREEN;
    SimLCD_FillTorus( x, y, 50, 45);

    // 显示字符串 PM2.5 ug/m3 PM1.0 PM10
    x = (uint16_t)(SimLCD.width/2-24);
    y = 40; 
    SimLCD_Show_PM2_5( x, y);

    x = (uint16_t)(SimLCD.width/2-20);
    y = 180; 
    SimLCD_Show_ug_m3( x, y);
    x = (uint16_t)(SimLCD.width/2/2-20);
    y = 230; 
    SimLCD_Show_PM1_0( x, y);  
    x = (uint16_t)(SimLCD.width/2/2*3-16);
    y = 230; 
    SimLCD_Show_PM10( x, y);
    #endif
}



















