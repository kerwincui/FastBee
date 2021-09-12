/****************************************Copyright (c)****************************************************
**     
** File name:               light.h
** Created by:              XiaoYi
** Created date:            2020-10-16
** Version:                 v1.0
** Descriptions:            The original 
** Link address:            https://blog.csdn.net/weixin_45006076
**
*********************************************************************************************************/

#ifndef __RC522_H__
#define __RC522_H__

#include "main.h"

//MF522命令字
/////////////////////////////////////////////////////////////////////
#define PCD_IDLE              0x00               //取消当前命令
#define PCD_AUTHENT           0x0E               //验证密钥
#define PCD_RECEIVE           0x08               //接收数据
#define PCD_TRANSMIT          0x04               //发送数据
#define PCD_TRANSCEIVE        0x0C               //发送并接收数据
#define PCD_RESETPHASE        0x0F               //复位
#define PCD_CALCCRC           0x03               //CRC计算

/////////////////////////////////////////////////////////////////////
//Mifare_One卡片命令字
/////////////////////////////////////////////////////////////////////
#define PICC_REQIDL           0x26               //寻天线区内未进入休眠状态
#define PICC_REQALL           0x52               //寻天线区内全部卡
#define PICC_ANTICOLL1        0x93               //防冲撞
#define PICC_ANTICOLL2        0x95               //防冲撞
#define PICC_AUTHENT1A        0x60               //验证A密钥
#define PICC_AUTHENT1B        0x61               //验证B密钥
#define PICC_READ             0x30               //读块
#define PICC_WRITE            0xA0               //写块
#define PICC_DECREMENT        0xC0               //扣款
#define PICC_INCREMENT        0xC1               //充值
#define PICC_RESTORE          0xC2               //调块数据到缓冲区
#define PICC_TRANSFER         0xB0               //保存缓冲区中数据
#define PICC_HALT             0x50               //休眠

/////////////////////////////////////////////////////////////////////
//MF522 FIFO长度定义
/////////////////////////////////////////////////////////////////////
#define DEF_FIFO_LENGTH       64                 //FIFO size=64byte
#define MAXRLEN  18

/////////////////////////////////////////////////////////////////////
//MF522寄存器定义
/////////////////////////////////////////////////////////////////////
// PAGE 0
#define     RFU00                 0x00    
#define     CommandReg            0x01    
#define     ComIEnReg             0x02    
#define     DivlEnReg             0x03    
#define     ComIrqReg             0x04    
#define     DivIrqReg             0x05
#define     ErrorReg              0x06    
#define     Status1Reg            0x07    
#define     Status2Reg            0x08    
#define     FIFODataReg           0x09
#define     FIFOLevelReg          0x0A
#define     WaterLevelReg         0x0B
#define     ControlReg            0x0C
#define     BitFramingReg         0x0D
#define     CollReg               0x0E
#define     RFU0F                 0x0F
// PAGE 1     
#define     RFU10                 0x10
#define     ModeReg               0x11
#define     TxModeReg             0x12
#define     RxModeReg             0x13
#define     TxControlReg          0x14
#define     TxAutoReg             0x15
#define     TxSelReg              0x16
#define     RxSelReg              0x17
#define     RxThresholdReg        0x18
#define     DemodReg              0x19
#define     RFU1A                 0x1A
#define     RFU1B                 0x1B
#define     MifareReg             0x1C
#define     RFU1D                 0x1D
#define     RFU1E                 0x1E
#define     SerialSpeedReg        0x1F
// PAGE 2    
#define     RFU20                 0x20  
#define     CRCResultRegM         0x21
#define     CRCResultRegL         0x22
#define     RFU23                 0x23
#define     ModWidthReg           0x24
#define     RFU25                 0x25
#define     RFCfgReg              0x26
#define     GsNReg                0x27
#define     CWGsCfgReg            0x28
#define     ModGsCfgReg           0x29
#define     TModeReg              0x2A
#define     TPrescalerReg         0x2B
#define     TReloadRegH           0x2C
#define     TReloadRegL           0x2D
#define     TCounterValueRegH     0x2E
#define     TCounterValueRegL     0x2F
// PAGE 3      
#define     RFU30                 0x30
#define     TestSel1Reg           0x31
#define     TestSel2Reg           0x32
#define     TestPinEnReg          0x33
#define     TestPinValueReg       0x34
#define     TestBusReg            0x35
#define     AutoTestReg           0x36
#define     VersionReg            0x37
#define     AnalogTestReg         0x38
#define     TestDAC1Reg           0x39  
#define     TestDAC2Reg           0x3A   
#define     TestADCReg            0x3B   
#define     RFU3C                 0x3C   
#define     RFU3D                 0x3D   
#define     RFU3E                 0x3E   
#define     RFU3F		  		        0x3F

/////////////////////////////////////////////////////////////////////
//和MF522通讯时返回的错误代码
/////////////////////////////////////////////////////////////////////
#define 	MI_OK                 0x26
#define 	MI_NOTAGERR           0xcc
#define 	MI_ERR                0xbb



/************************端口宏定义**********************************/
#define        macRC522_GPIO_CS_PORT    	              GPIOB	
#define        macRC522_GPIO_CS_PIN		                  GPIO_PIN_12

#define        macRC522_GPIO_RST_PORT    	              GPIOB	   
#define        macRC522_GPIO_RST_PIN		              GPIO_PIN_7

#define        macRC522_GPIO_SCK_PORT    	              GPIOB			   
#define        macRC522_GPIO_SCK_PIN		              GPIO_PIN_13

#define        macRC522_GPIO_MOSI_PORT    	              GPIOB			   
#define        macRC522_GPIO_MOSI_PIN		              GPIO_PIN_15

#define        macRC522_GPIO_MISO_PORT    	              GPIOB			   
#define        macRC522_GPIO_MISO_PIN		              GPIO_PIN_14
/*********************************** RC522 函数宏定义*********************************************/
#define        macRC522_CS_Enable()         HAL_GPIO_WritePin ( macRC522_GPIO_CS_PORT, macRC522_GPIO_CS_PIN ,GPIO_PIN_RESET)
#define        macRC522_CS_Disable()        HAL_GPIO_WritePin ( macRC522_GPIO_CS_PORT, macRC522_GPIO_CS_PIN ,GPIO_PIN_SET)

#define        macRC522_Reset_Enable()      HAL_GPIO_WritePin( macRC522_GPIO_RST_PORT, macRC522_GPIO_RST_PIN,GPIO_PIN_RESET )
#define        macRC522_Reset_Disable()     HAL_GPIO_WritePin ( macRC522_GPIO_RST_PORT, macRC522_GPIO_RST_PIN,GPIO_PIN_SET)

#define        macRC522_SCK_0()             HAL_GPIO_WritePin( macRC522_GPIO_SCK_PORT, macRC522_GPIO_SCK_PIN,GPIO_PIN_RESET )
#define        macRC522_SCK_1()             HAL_GPIO_WritePin ( macRC522_GPIO_SCK_PORT, macRC522_GPIO_SCK_PIN,GPIO_PIN_SET )

#define        macRC522_MOSI_0()            HAL_GPIO_WritePin( macRC522_GPIO_MOSI_PORT, macRC522_GPIO_MOSI_PIN,GPIO_PIN_RESET )
#define        macRC522_MOSI_1()            HAL_GPIO_WritePin ( macRC522_GPIO_MOSI_PORT, macRC522_GPIO_MOSI_PIN,GPIO_PIN_SET )

#define        macRC522_MISO_GET()          HAL_GPIO_ReadPin ( macRC522_GPIO_MISO_PORT, macRC522_GPIO_MISO_PIN )

#define        macRC522_DELAY()             HAL_Delay(20)

#define Dummy_Byte         0xFF


void   PcdReset             ( void );                       //复位
void   M500PcdConfigISOType ( uint8_t type );                    //工作方式
char   PcdRequest           ( uint8_t req_code, uint8_t * pTagType ); //寻卡
char   PcdAnticoll          ( uint8_t * pSnr);                   //读卡号
char   PcdAuthState         ( uint8_t ucAuth_mode, uint8_t ucAddr, uint8_t * pKey, uint8_t * pSnr );//验证卡片密码
char   PcdRead              ( uint8_t ucAddr, uint8_t * pData );      //读卡
char   PcdSelect            ( uint8_t * pSnr );                  //选卡   

#endif

