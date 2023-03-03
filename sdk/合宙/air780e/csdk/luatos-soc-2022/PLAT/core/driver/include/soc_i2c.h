/**
 * @file driver_gpio.h
 * @brief 使用本模块API时，不可以使用原厂的I2C API，所有API都是任务不安全的和中断不安全的！！！
 * @version 0.1
 * @date 2022-10-25
 *
 * @copyright
 *
 */

#ifndef __CORE_I2C_H__
#define __CORE_I2C_H__
#include "bsp_common.h"
/**
 * @brief i2c主机配置
 *
 * @param I2CID I2C通道号
 * @param Speed 速度，只有100000和400000
 */
void I2C_MasterSetup(uint8_t I2CID, uint32_t Speed);
/*
 * @brief i2c传输前配置，如果配置和上次一致，则不用设置
 *
 * @param I2CID I2C通道号
 * @param ChipAddress I2C设备地址
 * @param ChipAddressLen I2C设备地址长度 ，1或者2
 * @param CB 完成后回调函数
 * @param pParam 完成后回调函数中的pParam
 */
void I2C_Prepare(uint8_t I2CID, uint16_t ChipAddress, uint8_t ChipAddressLen, CBFuncEx_t CB, void *pParam);
/**
 * @brief i2c主机传输，兼容直接读写和先写寄存器地址后读数据
 *
 * @param I2CID I2C通道号
 * @param Operate 操作类型
 *  I2C_OP_READ_REG = 0,	//i2c通用读寄存器，一写一读，自动带start信号
	I2C_OP_READ,		//i2c通用读，只读
	I2C_OP_WRITE,		//i2c通用写，只写
 * @param RegAddress 寄存器地址的数据缓存，在通用读和通用写时忽略
 * @param RegLen 寄存器地址长度，在通用读和通用写时忽略
 * @param Data 读写数据缓存，直接使用用户的空间，在完成前不可以释放空间
 * @param Len 读写数据长度
 * @param Toms 传输单个字节超时时间，单位ms
 */
void I2C_MasterXfer(uint8_t I2CID, uint8_t Operate, uint8_t *RegAddress, uint32_t RegLen, uint8_t *Data, uint32_t Len, uint16_t Toms);

/**
 * @brief i2c主机传输结果查询
 *
 * @param I2CID I2C通道号
 * @param Result 传输结果 =0成功，其他失败，只有return != 0才有效
 * @return =0 传输还未完成 其他已完成
 */
int I2C_WaitResult(uint8_t I2CID, int32_t *Result);

int32_t I2C_BlockWrite(uint8_t I2CID, uint16_t ChipAddress, uint8_t *Data, uint32_t Len, uint16_t Toms, CBFuncEx_t CB, void *pParam);

int32_t I2C_BlockRead(uint8_t I2CID, uint16_t ChipAddress, uint8_t *Reg, uint32_t RegLen, uint8_t *Data, uint32_t Len, uint16_t Toms, CBFuncEx_t CB, void *pParam);

void I2C_ChangeBR(uint8_t I2CID, uint32_t Baudrate);

#endif
