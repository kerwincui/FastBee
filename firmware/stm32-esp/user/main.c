#include "main.h"

/************************
    ESP8266 UART2
    PMD4    UART3
************************/
int main()
{
    BSP_ClockInit();
    
    BSP_Timer3Init(); 
    
    // 电源控制部分
    BSP_PowerInit();
    Delay_ms(200);

    // 电池电压ADC
    BSP_ADCInit();
    
    // LCD
    #ifdef Device_LCD
    Delay_ms(1000);   
    SimLCD_Init();

    DevParam.AirInforGetTime   = 3000;
    DevParam.BatIconRefreshTime= 3000;
    DevParam.BatInforGetTime   = 3000;
    DevParam.SideBeatTime      = 3000;
    
    DevParam.ShowPM1_0 = 200;
    DevParam.ShowPM2_5 = 200;
    DevParam.ShowPM10  = 200;
    #endif
    while(1)
    {
        // 网络配网部分
        ESP8266_NetWorkFlow();
            
        // 网络数据接收处理
        ESP8266_NetReceiveInfor();
        
        // 电池，获取电池信息
        Bat_GetWorkInfor();
        
        // 读取电路板状态
        Dev_ScanExtIndicate();
        
        // 切换工作模式
        Dev_SwitchWorkMode();
        
        // 系统正常运行处理流程        
        if(DevParam.RunPhase == RunPhase_Runing) 
        {
            // 显示部分，侧边跳动
            Show_BroadSideBeat();
//            
            // PMD4，获取空气信息
            PMD4_GetAirInfor();
        }

        // 显示部分，电池图标刷新
        Show_BatIconRefresh();  
    }
}


