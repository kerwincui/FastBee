/**
 * @file driver_i2s.h
 * @brief 使用本模块API时，不可以使用原厂的I2S API。所有API都是任务不安全的和中断不安全的！！！
 * @version 0.1
 * @date 2023-1-9
 *
 * @copyright
 *
 */

#ifndef __CORE_I2S_H__
#define __CORE_I2S_H__
#include "bsp_common.h"
#include "i2s.h"
void I2S_FullConfig(uint8_t I2SID, i2sDataFmt_t DataFmt, i2sSlotCtrl_t SlotCtrl, i2sBclkFsCtrl_t BclkFsCtrl, i2sDmaCtrl_t DmaCtrl);
void I2S_BaseConfig(uint8_t I2SID, uint8_t Mode, uint8_t FrameSize);
int32_t I2S_Start(uint8_t I2SID, uint8_t IsPlay, uint32_t SampleRate, uint8_t ChannelNum);
void I2S_Tx(uint8_t I2SID, uint8_t* Data, uint32_t ByteLen, CBFuncEx_t cb, void *param);
void I2S_Rx(uint8_t I2SID, uint32_t ByteLen, CBFuncEx_t cb, void *param);
void I2S_TxStop(uint8_t I2SID);
void I2S_RxStop(uint8_t I2SID);
void I2S_TxPause(uint8_t I2SID);
void I2S_TxDebug(uint8_t I2SID);
void I2S_RxDebug(uint8_t I2SID);
#endif
