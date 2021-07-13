/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
#ifndef _I2C_TEMP_H_ 
#define _I2C_TEMP_H_

#include <stdio.h>
#include "esp_log.h"
#include "driver/i2c.h"

//##被称为连接符（concatenator），用来将两个Token连接为一个Token。
#define _I2C_NUMBER(num) I2C_NUM_##num
#define I2C_NUMBER(num) _I2C_NUMBER(num)

// #define I2C_MASTER_NUM I2C_NUMBER(0)         // I2C主机端口号
#define I2C_MASTER_FREQ_HZ 100000            // I2C主机时钟频率
#define I2C_MASTER_TX_BUF_DISABLE 0          //I2C主机不需要缓冲区
#define I2C_MASTER_RX_BUF_DISABLE 0          //I2C主机不需要缓冲区

#define WRITE_BIT I2C_MASTER_WRITE           // I2C主机写   
#define READ_BIT I2C_MASTER_READ             // I2C主机读
#define ACK_CHECK_EN 0x1                     // I2C主机将检查从机的ack
#define ACK_CHECK_DIS 0x0                    // I2C主机将不检查从机的ack 
#define ACK_VAL 0x0                          // I2C ack值
#define NACK_VAL 0x1                         // I2C nack值

//SHT30
#define SHT30_WRITE_ADDR 0x44 //地址
#define CMD_FETCH_DATA_H 0x22 //循环采样，参考sht30 datasheet
#define CMD_FETCH_DATA_L 0x36

void i2c_temp_start(void);
//获取空气温湿度
void get_temp_humi();

#endif
