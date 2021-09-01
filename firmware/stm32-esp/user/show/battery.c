#include "battery.h"

/*电池，获取电池信息*/
void Bat_GetWorkInfor(void)
{
    /***读取正在充电指示***/
    if(Read_BatCharging()==0)
        DevParam.BatCharging = 1;
    else
        DevParam.BatCharging = 0;
    
    if(DevParam.BatInforGetTime >= 300)
    {
        if(DevParam.BatCheck < 100)
            DevParam.BatCheck++;
        /***获取电池电压***/
        DevParam.BatVoltage  = ADC_GetSimpleData();
        if(DevParam.BatVoltage >= 3.58)        
        {
            /***转换电池容量***/
            if(DevParam.BatVoltage>=4.16)
                DevParam.ShortBatSOC = 100;
            else if(DevParam.BatVoltage>=4.08)
                DevParam.ShortBatSOC = 90;
            else if(DevParam.BatVoltage>=3.97)
                DevParam.ShortBatSOC = 80;            
            else if(DevParam.BatVoltage>=3.90)
                DevParam.ShortBatSOC = 70;
            else if(DevParam.BatVoltage>=3.84)
                DevParam.ShortBatSOC = 60;
            else if(DevParam.BatVoltage>=3.79)
                DevParam.ShortBatSOC = 50;
            else if(DevParam.BatVoltage>=3.76)
                DevParam.ShortBatSOC = 40;
            else if(DevParam.BatVoltage>=3.73)
                DevParam.ShortBatSOC = 30;
            else if(DevParam.BatVoltage>=3.71)
                DevParam.ShortBatSOC = 20;
            else if(DevParam.BatVoltage>=3.65)
                DevParam.ShortBatSOC = 10;
        }
        else
        {
            DevParam.ShortBatSOC = 0;
        }
        DevParam.BatInforGetTime = 0;
    }   
}
/*显示部分，电池图标外形刷新*/
void Show_BatIconShapeRefresh(void) 
{
    #ifdef Device_LCD 
    // 电池外形
    SimLCD_PointColor = SimLCDColor_WHITE;
    SimLCD_DrawLine( 200, 9,  222, 9);
    SimLCD_DrawLine( 200, 21, 222, 21);
    
    SimLCD_DrawLine( 200, 9, 200, 21);
    SimLCD_DrawLine( 222, 9, 222, 21);
    
    SimLCD_DrawLine( 197, 13, 200, 13); // 上横线
    SimLCD_DrawLine( 197, 13, 197, 17); // 中横线   
    SimLCD_DrawLine( 197, 17, 200, 17); // 下横线 
    #endif     
}
/*显示部分，电池图标刷新*/
void Show_BatIconRefresh(void)
{
    if((DevParam.BatIconRefreshTime>=500)&&(DevParam.BatCheck>=2))
    {
        #ifdef Device_LCD 
        uint8_t  i = 0;
        uint16_t FontColor = 0;
        if( (DevParam.BatCharging==1)&&(DevParam.RunPhase!=0) )
        {// 充电中，电池图标变成绿色
            FontColor = SimLCDColor_GREEN;
        }
        else if(DevParam.RunPhase==RunPhase_Runing)
        {// 其他，电池图标变成白色
            FontColor = SimLCDColor_WHITE;
        }
        // 显示SOC
        if(DevParam.ShortBatSOC!=DevParam.BatSOC)
        {
            if( DevParam.ShortBatSOC >= 80 )                  {
                SimLCD_PointColor = FontColor;
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 202, i, 205, i);     
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 207, i, 210, i);
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 212, i, 215, i);
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 217, i, 220, i);                   
            }
            else if( DevParam.ShortBatSOC >= 60 )            {
                SimLCD_PointColor = SimLCDColor_BLACK;
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 202, i, 205, i);
                SimLCD_PointColor = FontColor;                    
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 207, i, 210, i);
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 212, i, 215, i);
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 217, i, 220, i);                    
            }
            else if( DevParam.ShortBatSOC >= 40 )             {
                SimLCD_PointColor = SimLCDColor_BLACK;
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 202, i, 205, i);                                       
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 207, i, 210, i);
                
                SimLCD_PointColor = FontColor;
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 212, i, 215, i);
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 217, i, 220, i);                       
            }
            else if( DevParam.ShortBatSOC >= 20 )             {
                SimLCD_PointColor = SimLCDColor_BLACK;
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 202, i, 205, i);      
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 207, i, 210, i);
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 212, i, 215, i);
                SimLCD_PointColor = FontColor;
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 217, i, 220, i);                       
            }   
            else if( DevParam.ShortBatSOC >= 1 )              {
                SimLCD_PointColor = SimLCDColor_BLACK;
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 202, i, 205, i);                 
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 207, i, 210, i);
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 212, i, 215, i);
                for( i = 12; i < 19; i++)
                    SimLCD_DrawLine( 217, i, 220, i);                       
            } 
            Power_LCD(1);         
            DevParam.BatSOC =DevParam.ShortBatSOC;  
        }
        #endif        
        DevParam.BatIconRefreshTime = 0;      
    }
}
/*显示部分，侧边跳动*/
void Show_BroadSideBeat(void)
{
    if(DevParam.SideBeatTime>=2000) 
    {
        #ifdef Device_LCD
        uint8_t i = 0;
        if(DevParam.SideBeat==1) {
            SimLCD_PointColor = SimLCDColor_CYAN;
            for(i = 0; i < 13; i++)
                SimLCD_DrawLine( 0, i, 32, i);   
            DevParam.SideBeat = 2;                        
        }
        else if(DevParam.SideBeat==2) {
            SimLCD_PointColor = SimLCDColor_CYAN;
            for(i = 15; i < 28; i++)
                SimLCD_DrawLine( 0, i, 24, i); 
            DevParam.SideBeat = 3;                      
        }
        else if(DevParam.SideBeat==3) {
            SimLCD_PointColor = SimLCDColor_CYAN;
            for(i = 30; i < 43; i++)
                SimLCD_DrawLine( 0, i, 16, i);
            DevParam.SideBeat = 4;
        }
        else if(DevParam.SideBeat==4) {
            SimLCD_PointColor = SimLCDColor_CYAN;
            for(i = 45; i < 58; i++)
                SimLCD_DrawLine( 0, i, 8, i); 
            DevParam.SideBeat = 5;                    
        }
        else if(DevParam.SideBeat==5) {
            SimLCD_PointColor = SimLCDColor_BLACK;
            for(i = 0; i < 13; i++)
                SimLCD_DrawLine( 0, i, 32, i);
            for(i = 15; i < 28; i++)
                SimLCD_DrawLine( 0, i, 24, i);    
            for(i = 30; i < 43; i++)
                SimLCD_DrawLine( 0, i, 16, i);    
            for(i = 45; i < 58; i++)
                SimLCD_DrawLine( 0, i, 8, i); 
            DevParam.SideBeat = 1;
        }
        #endif
        DevParam.SideBeatTime = 0;
    }   
}























