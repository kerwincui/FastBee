#ifndef __SOC_DMA_H__
#define __SOC_DMA_H__
#include "dma.h"
void DMA_ForceStartStream(uint8_t DMAStream, uint8_t TxDir, const void *Data, uint32_t Len, DmaTransferConfig_t* Config, uint8_t NeedIrq);
#endif
