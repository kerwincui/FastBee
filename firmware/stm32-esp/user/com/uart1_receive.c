#include "uart1_receive.h"

void BSP_UART1ReceiveInfor(void)
{
    if(UART1ReadFlag&0x8000)
	{
		UART1ReadFlag = 0;
		memset((void *)UART1ReadBuf,0,sizeof(UART1ReadBuf));
	}
}






























