#include "uart2_receive.h"

uint8_t txLen     = 0;
uint8_t txBuf[20] = {0};

static uint8_t Server_CheckSum(uint8_t * buf)
{
    uint8_t  len = 0,i = 0;
    uint16_t CheckSum = 0;
    len = buf[2] - 2;
    
    for( i = 0; i < len; i++)
        CheckSum += buf[i+2];
    
    return (uint8_t)CheckSum;
}

void Server_Protocol(void)
{
    if(UART2ReadFlag&0x8000)
	{
        if(UART2ReadBuf[0]==0xAA && UART2ReadBuf[1]==0xBB)
        {
            // 校验和
            switch(UART2ReadBuf[3])
            {
                case 0x90 : {  } break;  // 返回配网结果
                case 0x91 : { DevParam.Server = UART2ReadBuf[8]; } break;  // 返回网络状态
                
                case 0x94 : {  } break;  // 返回上报属性结果
                case 0x95 : {  } break;  // 返回上报事件结果
                
                case 0x96 : {  } break;  // 下发控制
                case 0x97 : {  } break;  // 下发获取状态
                default : break;                
            }   
        }
		UART2ReadFlag = 0;
		memset((void *)UART2ReadBuf,0,sizeof(UART2ReadBuf));
	}    
    
    // 间隔2秒上报设备状态
    if( (DevParam.Server==2) && (DevParam.ServerUpdateTime>=2000) )
    {
        txLen = 0;
        txBuf[txLen++] = 0xAA; txBuf[txLen++] = 0xBB;
        txBuf[txLen++] = 0x00; // 数据长度，帧头后有效数据长度
        txBuf[txLen++] = 0x84; // 上报属性
        txBuf[txLen++] = 0x01; txBuf[txLen++] = 0x02; txBuf[txLen++] = 0x03; txBuf[txLen++] = 0x04; // 客户端ID
       
        /////////参数////////
        txBuf[txLen++] = 0x01; txBuf[txLen++] = 0x01; 
        txBuf[txLen++] = 0x01; txBuf[txLen++] = 0x01;
        ///////////////////////
        
        txBuf[txLen++] = 0x00; // 校验和
        txBuf[txLen++] = 0x5F; // 帧尾
        
        txBuf[2]       = txLen-2; // 数据长度
        txBuf[txLen-2] = Server_CheckSum(txBuf);// 校验和
        
        // 发送
        ESP8266_SendData( txBuf, txLen);
        
        DevParam.ServerUpdateTime = 0;
    }
}














