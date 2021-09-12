#ifndef _BASIC_DATA_H_
#define _BASIC_DATA_H_

#include "stm32f10x.h"

#define Device_LCD    1

#define MQTT_SCode    1
//#define MQTT_AT       1

extern uint8_t  UART1ReadBuf[500];
extern uint16_t UART1ReadFlag;

extern uint8_t  UART2ReadBuf[500];
extern uint16_t UART2ReadFlag;

extern uint8_t  UART3ReadBuf[500];
extern uint16_t UART3ReadFlag;

typedef enum
{
	RunPhase_Standby = 0x01,
	RunPhase_Runing  = 0x02,
    RunPhase_Close   = 0x03
}RunPhase_E;

typedef struct
{  
    uint16_t U3GetTime;
    
    uint8_t  BatCheck;   // 电池检测
    float    BatVoltage; // 电池电压
    uint8_t  BatSOC;     // 电池SOC
    uint8_t  ShortBatSOC;// 显示电池SOC
    uint8_t  BatCharging;// 电池充电中

    uint16_t BatInforGetTime;   // 电池信息获取时间
    uint16_t BatIconRefreshTime;// 电池图标刷新时间
    
    uint16_t AirInforGetTime;   // 空气信息获取时间
    
    uint8_t  ServerRelay;       // 服务器继电器
    uint8_t  ServerRed;

    uint16_t ESP8266SendTime;
    uint16_t MQTTSendTime;
    
    // 运行阶段
    RunPhase_E RunPhase;
    RunPhase_E ShortRunPhase;
    
    uint8_t  SideBeat;     // 侧边标识
    uint16_t SideBeatTime; // 侧边跳动时间
    
    uint16_t Server;
    uint16_t ServerUpdateTime;

    uint16_t ShowPM1_0;
    uint16_t ShowPM2_5;
    uint16_t ShowPM10;
    
    uint16_t PM1_0;
    uint16_t PM2_5;
    uint16_t PM10;
    
    uint16_t tes;
}DevParam_t;
extern DevParam_t DevParam;

#endif




