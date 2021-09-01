#include "dev_work.h"

void Dev_ScanExtIndicate(void)
{
    /*开机检测*/
    if(DevParam.RunPhase==0)
    {
        if(Read_BootKey())
        {
            Delay_ms(200);
            if(Read_BootKey())
            {
                while(Read_BootKey());               
                DevParam.ShortRunPhase = RunPhase_Runing;
            }
        }
        else
        {
            DevParam.ShortRunPhase = RunPhase_Standby;
        }
    }
    // 待机模式
    if(DevParam.RunPhase==RunPhase_Standby)
    {
        if(Read_BootKey())
        {
            Delay_ms(200);
            if(Read_BootKey())
            {
                while(Read_BootKey());               
                DevParam.ShortRunPhase = RunPhase_Runing;
            }
        }       
    }
    // 运行模式
    if(DevParam.RunPhase==RunPhase_Runing) 
    {               
        if(Read_BootKey())
        {
            Delay_ms(200);
            if(Read_BootKey())
            {
                while(Read_BootKey());

                // 关机/进入待机状态
                if(DevParam.BatCharging)
                    DevParam.ShortRunPhase = RunPhase_Standby;                
                else
                    DevParam.ShortRunPhase = RunPhase_Close;                
            }
        }
    }  
}

/*切换工作模式*/
void Dev_SwitchWorkMode(void)
{
    if(DevParam.RunPhase!=DevParam.ShortRunPhase) 
    { 
        if(DevParam.ShortRunPhase == RunPhase_Runing)
        {
            // 显示初始化
            #ifdef Device_LCD
            Power_LCD(0);

            /*显示部分，基础外形刷新*/
            Show_BasicShapeRefresh();
        
            /*显示部分，电池图标外形刷新*/
            if(DevParam.RunPhase == 0)
                Show_BatIconShapeRefresh();                
            else
                Power_LCD(1);  
            #endif

            // 侧边跳动初始化
            DevParam.SideBeat = 1;

            /*空气检测仪初始化*/
            PMD4_Init();

            DevParam.RunPhase = RunPhase_Runing;
        }
        if(DevParam.ShortRunPhase == RunPhase_Standby)
        {
            Power_PMD4(0);
            
            #ifdef Device_LCD
            Power_LCD(0);            
            
            if(DevParam.RunPhase==0)
            {
                /*显示部分，电池图标外形刷新*/
                Show_BatIconShapeRefresh();  
            }   
            else if(DevParam.RunPhase==RunPhase_Runing)
            {
                // 进行清屏操作
                SimLCD_Clear(SimLCDColor_BLACK);
                
                /*显示部分，电池图标外形刷新*/
                Show_BatIconShapeRefresh(); 
                
                // 数据部分清零
                DevParam.BatSOC = 0;
                
                Power_LCD(1);
            }                
            #endif

            DevParam.RunPhase = RunPhase_Standby;
        }
        // 关机模式
        if(DevParam.ShortRunPhase == RunPhase_Close)
        {
            Delay_ms(1000);
            Power_PMD4(0);
            Power_LCD(0);
            Power_3V3(0); 
            DevParam.RunPhase = RunPhase_Close;       
            while(1);
        }
    }    
}



