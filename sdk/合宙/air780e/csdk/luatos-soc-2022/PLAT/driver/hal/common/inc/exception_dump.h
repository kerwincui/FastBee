/**************************************************************************//**
 * @file     exception_dump.h
 * @brief    CMSIS OS Tick header file
 * @version  V1.0.0
 * @date     05. June 2017
 ******************************************************************************/
/*
 * Copyright (c) 2017-2017 ARM Limited. All rights reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the License); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an AS IS BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef _EXCEPTION_DUMP_H
#define _EXCEPTION_DUMP_H
#include "cmsis_compiler.h"
#include "commontypedef.h"
#include "mem_map.h"

#define MAX_DELAYHHH 0//0xffffff
#define MAX_DELAY 0//0xff

#define DUMP_UART_INSTANCE    0
#define DUMP_SYNC_RSP_LEN 8
//#define DUMP_SYNC_RSP_LEN 2

#define DUMP_RECV_FIFO_LEN 16
#define CMD_FIX_LEN 8
#define CMD_FCS_LEN 4

#define PROTOCOL_RSP_FIX_LEN 8
#define PREAMBLE_CNT 1
#define PREAMBLE_STRING_LEN 10
#define PREAMBLE_WITH_NULL 1
#define MAX_CMD_DATALEN 32 //maximum data size for cmd
#define MAX_READ_DATALEN (48*1024) //maximum data size for cmd

#define MAX_RETRY_COUNT 32
#define DATA_DUMP_WAIT_SYNC_MAX_RETRY_COUNT    10
#define DATA_DUMP_GET_CMD_MAX_RETRY_COUNT      100
#define DUMP_CID 0xdc
#define N_DUMP_CID 0x23

#define READ_ONECE_DATA_LEN   256

#define ACK 0
#define NACK 1

#define GetDataCmd 0x20
#define GetInfoCmd 0x21
#define FinishCmd 0x25

#define WaitPeriod_1s 1000000

#define DUMP_RETRY_CMD_COUNT     1
#define DUMP_RETRY_CMD_RESEND    2

#define DUMP_RETRY_ADDR          0x00C000
#define DUMP_RETRY_COUNT_MAX     2

#define DUMP_END_FLAG_INIT     0xEC00
#define DUMP_END_FLAG_SUCC     0xEC88


typedef struct {
    uint32_t ReadDataAddr;
    uint32_t ReadLen;
}ReadDataReqCell;

typedef struct {
    uint8_t Command;
    uint8_t Sequence;
    uint8_t CID;
    uint8_t NCID;
    uint16_t Status;
    uint16_t Length;//Length for Data filed
    //uint8_t Data[MAX_CMD_DATALEN];
    uint32_t FCS;
}DumpRspWrap, *PtrDumpRspWrap;

typedef struct {
    uint8_t Command;
    uint8_t Sequence;
    uint8_t CID;
    uint8_t NCID;
    uint32_t Length;//Length for Data filed
    uint8_t Data[MAX_CMD_DATALEN];
    uint32_t FCS;
}DumpReqWrap, *PtrDumpReqWrap;

uint32_t EcDumpTopFlow(void);

#ifdef FEATURE_UART_HELP_DUMP_ENABLE
#define EC_UART_HELP_DUMP_BUFF_LEN    128   
uint32_t EcDumpHandshakeProcUart(uint32_t SyncPeriod);
uint32_t EcDumpDataFlowUart(void);
#endif
#endif  /* _EXCEPTION_DUMP_H */
