#ifndef __SOC_SPI_H__
#define __SOC_SPI_H__
#include "bsp_common.h"
void SPI_MasterInit(uint8_t SpiID, uint8_t DataBit, uint8_t Mode, uint32_t Speed, CBFuncEx_t CB, void *pUserData);
void SPI_SetCallbackFun(uint8_t SpiID, CBFuncEx_t CB, void *pUserData);
int32_t SPI_TransferEx(uint8_t SpiID, const uint8_t *TxData, uint8_t *RxData, uint32_t Len, uint8_t IsBlock, uint8_t UseDMA);
int32_t SPI_BlockTransfer(uint8_t SpiID, const uint8_t *TxData, uint8_t *RxData, uint32_t Len);
void SPI_FastTransfer(uint8_t SpiID, const uint8_t *TxData, uint8_t *RxData, uint32_t Len);
void SPI_SetNoBlock(uint8_t SpiID);
int32_t SPI_FlashBlockTransfer(uint8_t SpiID, const uint8_t *TxData, uint32_t WLen, uint8_t *RxData, uint32_t RLen);
void SPI_TransferStop(uint8_t SpiID);
uint8_t SPI_IsTransferBusy(uint8_t SpiID);
void SPI_SetNewConfig(uint8_t SpiID, uint32_t Speed, uint8_t NewMode);
void SPI_SetDMATrigger(uint8_t SpiID, uint32_t UpValue, uint32_t DownValue);
#endif
