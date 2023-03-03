

/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: hal_rfCali.h
*
*  Description: header of hal_rfCali.c
*
*  History: 2021.07.28 initiated by Jinxin Huang
*
*  Notes:
*
******************************************************************************/
#ifndef HAL_RF_CALI_H
#define HAL_RF_CALI_H

#include <stdint.h>
//#include "at_util.h"

#include DEBUG_LOG_HEADER_FILE
#include "debug_trace.h"
#include "shareinfo.h"

#if defined(__CC_ARM)
#pragma anon_unions
#endif

/*********************************************************************************
* Defines
*********************************************************************************/
#define  RF_NST_A2C_BUFF_ADDR                     ShareInfoAPSetPhyCaliMem()  // 0xC800 : 50K
#define  RF_NST_C2A_BUFF_ADDR                     (RF_NST_A2C_BUFF_ADDR+0xC800)
#define  RF_NST_TEMP_BUFF_ADDR1                   (RF_NST_C2A_BUFF_ADDR+0x3C00)//(RF_NST_C2A_BUFF_ADDR+0xC800)  // 50K -> 30K
#define  RF_NST_TEMP_BUFF_ADDR2                   (RF_NST_TEMP_BUFF_ADDR1+0x7800)//(RF_NST_TEMP_BUFF_ADDR1+0xC800) // 50K -> 15K
#define  RF_NST_TABLE_BUFF_ADDR                   (RF_NST_TEMP_BUFF_ADDR2+0x3C00)//(RF_NST_TEMP_BUFF_ADDR2+0xC800) //100K


#define  RF_CALNST_CRC16_LENGTH_HEX               (2)
#define  RF_CALNST_CRC16_LENGTH_CHAR              (RF_CALNST_CRC16_LENGTH_HEX * 2)
#define  RF_CALNST_RSP_HEADER_LENGTH_HEX          (4)
#define  RF_CALNST_RSP_HEADER_LENGTH_CHAR         (RF_CALNST_RSP_HEADER_LENGTH_HEX * 2)
#define  RF_CALNST_CRC_ENABLE_IND_BITMASK         (0x2) // indicate crc check enable or not 0-disable, 1-enable
#define  RF_CALNST_PC_CRC_IND_BITMASK             (0x4) // indicate crc check value by pc
#define  RF_CALNST_NEXT_DATA_BLOCK_BITMASK        (0xF8) // indicate ue next send data block counter
#define  RF_CALNST_DATA_END_IND_BITMASK           (0x1) // indicate data end, 0-end, 1- not end
#define  SIZE_OF_COMMANDID                        (2)
#define  RF_CAL_RSP_HEADER_BYTES                  (10) // (2+4+4) MT00000000
#define  NO_ERR_DATA_FINISH_NOT                   (2)
#define  NO_ERR_DATA_FINISH                       (1)
#define  NO_ERR                                   (0)
#define  ERR_WR_FLASH                             (-14)
#define  ERR_AFC_FAILURE_RC32K_CALI_ERR           (-15)
#define  ERR_AFC_FAILURE_RC32K_CALI_ERR_TIMEOUT   (-16)
#define  ERR_WR_FLASH_AT_TYPE                     (-17)


// define RF factory calibration Response message Buffer Maximum Length. Unit: bytes(Hex)
#define  RF_FC_RESPONSE_OTHER_LEN                 (16) // 2(MT)+4(status+errInd)+4(length)+4(crc)+2(\r\n)
#define  RF_FC_RESPONSE_ONE_MSG_MAX_HEX_LEN       ((8000 - RF_FC_RESPONSE_OTHER_LEN)/2) // 4-finishstatus+errInd, 2-crc
#define  RF_FC_RESPONSE_ONE_MSG_MAX_CHAR_LEN      (8000)
#define  C2A_BUFFER_DATA_LENGTH_IND_SIZE          (12) // 4bytes-cmdid,4bytes-retvalue, 4bytes-datalength

/* AT+ECRFTEST */
#define ATC_ECRFTEST_0_STR_DEFAULT                NULL
#define ATC_ECRFTEST_0_STR_MAX_LEN                8000         /* */

/* AT+ECRFNST */
#define ATC_ECRFNST_0_STR_DEFAULT                 NULL
#define ATC_ECRFNST_0_STR_MAX_LEN                 8000         /* */

/* Command Handle in AP*/

#define RF_CAL_SELFCAL                            (0x03)
#define RF_CAL_WRITE_TABLE                        (0x0f)
#define RF_CAL_READ_TABLE                         (0x10)
#define RF_CAL_AFC_GET_DATA                       (0x0e)

/* AT^PHYDEBUG */

/* RF CaliTable struct*/
#define FCALI_COMN_TABLE_SIZE                96
#define FCALI_AFC_TABLE_SIZE                 5
#define FCALI_AGC_ONEFREQ_TABLE_SIZE         12
#define FCALI_FREQ_MAX_NUM                   10
#define RX_IP2_FREQ_MAX_NUM                  32
#define FCALI_APC_FREQCMPST_POINTS_MAX_NUM   20
#define FCALI_BAND_BTMP_MAX_NUM              20     // Ec618,EC718P
#define FCALI_BAND_BTMP_MAX_NUM_718          11     // EC718
#define FCALI_POWER_SWP_MAX_NUM              8
#define FCALI_APC_CENTRA_CMDS_MAX_NUM        100
#define RX_IP2_TABLE_SIZE                    (RX_IP2_FREQ_MAX_NUM+1)

#define FCALI_AGC_ONEBAND_TABLE_SIZE         (FCALI_AGC_ONEFREQ_TABLE_SIZE+1)*FCALI_FREQ_MAX_NUM
#define FCALI_APC_ONEBAND_TABLE_SIZE         ((FCALI_FREQ_MAX_NUM/2)+(FCALI_FREQ_MAX_NUM*(3+FCALI_APC_FREQCMPST_POINTS_MAX_NUM))+(FCALI_POWER_SWP_MAX_NUM*2)+(FCALI_APC_CENTRA_CMDS_MAX_NUM*2))
#define NV_HEADER_SIZE                       32
#define SELFCALI_TABLE_MAX_DATA_SIZE         (8*1024 - NV_HEADER_SIZE)
#define FCALI_TABLE_MAX_DATA_SIZE            (60*1024 - NV_HEADER_SIZE)

//#define FPGA_DEBUG_ADI

#define RF_NST_CP_GOTO_WHILE           0x80
#define RF_NST_CP_DO_NOTHING           0x81


#define FCALI_AFC_TABLE_SIZE                 5

#ifdef FPGA_DEBUG_ADI
#define RF_RC32K_CALI_THRESHOLD              94     // error = 3125*3% ~= 94
#define RF_RC32K_CALI_RADIO                  3125    // 102.4MHz / 32768 = 3125
#else
#define RF_RC32K_CALI_THRESHOLD              250     // error = 12500*2% = 250
#define RF_RC32K_CALI_RADIO                  12500   // 409.6MHz / 32768 = 12500
#endif
#define ABS(a)  ((a)>0 ? (a) : -(a))

/* AT+ECRFTEST */
#define ATC_ECRFTEST_0_STR_DEFAULT                NULL
#define ATC_ECRFTEST_0_STR_MAX_LEN                8000         /* */

/* AT+ECRFNST */
#define ATC_ECRFNST_0_STR_DEFAULT                 NULL
#define ATC_ECRFNST_0_STR_MAX_LEN                 8000         /* */

#define  RF_CALNST_PREHANDLE_CRC_ERROR            (-2)  // preHandle error
#define  RF_CALNST_TRANSDATABLOCK_INDEX_ERROR     (-3)


/*********************************************************************************
* Enums
*********************************************************************************/
enum
{
    DATA_END   = 0,
    DATA_NOEND = 1,
};

enum
{
    PC_CRC_CHECK_OK = 0,
    PC_CRC_CHECK_ERROR = 1,
};

enum
{
    CRC_CHECK_DISABLE = 0,
    CRC_CHECK_ENABLE = 1,
};

enum
{
    RF_FCCALI_TABLE_Start = 0,
    RF_FCCALI_TABLE_COMMINFO = 1,
    RF_FCCALI_TABLE_AFC = 2,
    RF_FCCALI_TABLE_AGC_1 = 3,
    RF_FCCALI_TABLE_AGC_2 = 4,
    RF_FCCALI_TABLE_RXIP2_1 = 5,
    RF_FCCALI_TABLE_RXIP2_2 = 6,
    RF_FCCALI_TABLE_APC = 7,
    RF_FCCALI_TABLE_END = 8,
    RF_FCCALI_TABLE_SELFCAL = 9,
};

// EC+ECRFTEST command Index
enum
{
    RF_UNIT_TEST = 0x0,
    RF_TX_POWER_FIXED = 0x1,
    RF_APT_DAC_FIXED = 0x2,
    RF_TX_CMD_FIXED = 0x3,
    RF_THERMAL_VAL_GET = 0x4,
    RF_TMPRT_COMP_ONOFF = 0x5,
    RF_SIGNALING_DEBUG_ENA = 0x6,
    RF_VOLTG_COMP_ONOFF = 0x7,
    RF_TX_PABIAS_MIPI_REGS_FIXED = 0x8,
    RF_FEM_GPIO_SET = 0x9,
    RF_RC32K_LATCH_URC = 0x30,
    RF_RC32K_GAP_GET = 0x31,
    RF_RC32K_PTEST = 0x50,
    RF_LDORET_SET = 0x60,
    RF_DCDCVPA_ENA_DEBUG = 0x70,
};

//extern UINT16  dataPos = C2A_BUFFER_DATA_LENGTH_IND_SIZE; // first 4 bytes is total data length
//extern UINT16  lstDataSize = 0;
//extern UINT16  lstDataAddrOfst = 0;
//extern UINT8 transCount = 0;

enum
{
    ADC_CVT_IDLE = 0x0,
    ADC_CVT_BUSY
};



enum
{
    RF_DEBUG_CMD_OUT_FLAG_NONE = 0x0,
    RF_DEBUG_CMD_OUT_FLAG_REGS,
    RF_DEBUG_CMD_OUT_FLAG_SARADC,
    RF_DEBUG_CMD_OUT_FLAG_DUPLEXLOSS,
};


/*********************************************************************************
* struct
*********************************************************************************/

typedef union
{
    struct
    {
        UINT16 finishInd       :1; // data finish indication, 0-finished, 1-unfinshed
        UINT16 crcEnaFlag      :1; // crc check enable 0-disable, 1-enable
        UINT16 pcCrcErrInd     :1; // pc crc check indication, 0-no error, 1-error
        UINT16 dbCounter       :5; // data blocker counter
        UINT16 cmdId           :8; // commandId 
    };

    UINT16 u16;
}CmdInfo;


typedef union
{
    UINT32 u32[FCALI_COMN_TABLE_SIZE];
}RfFcComInfos; // 384 bytes

typedef  union
{
    UINT32 u32[FCALI_AFC_TABLE_SIZE];
}RfAfcTable;  // 20 bytes

typedef union
{
    UINT32 u32[FCALI_AGC_ONEBAND_TABLE_SIZE];
     
}RfAgcOneBandTable;  // 520Bytes

typedef union
{
    UINT32 u32[RX_IP2_TABLE_SIZE];
}RfRxIp2Table;  // 132Bytes

typedef union 
{
    UINT32 u32[FCALI_APC_ONEBAND_TABLE_SIZE];
}RfApcOneBandTable;    // 2*10+92*10+64+800 = 1804 bytes

typedef struct // for ec618, ec718p
{
    RfFcComInfos comInfo;
    RfAfcTable afc;
    RfAgcOneBandTable agcTb1[FCALI_BAND_BTMP_MAX_NUM];
    RfAgcOneBandTable agcTb2[FCALI_BAND_BTMP_MAX_NUM];
    RfRxIp2Table rxIp2Tb1;
    RfRxIp2Table rxIp2Tb2;
    RfApcOneBandTable apc[FCALI_BAND_BTMP_MAX_NUM];
}RfFcaliTable;

typedef struct // for ec718
{
    RfFcComInfos comInfo;
    RfAfcTable afc;
    RfAgcOneBandTable agcTb1[FCALI_BAND_BTMP_MAX_NUM_718];
    RfRxIp2Table rxIp2Tb1;
    RfRxIp2Table rxIp2Tb2;
    RfApcOneBandTable apc[FCALI_BAND_BTMP_MAX_NUM_718];
}RfFcaliTable718;

typedef struct
{
    __IO UINT16 cvtStatus;
    __IO UINT16 cvtCode;
}RfCaliAdcStatus;

//define Afc info sections
typedef union RfAfcTableAp_Tag
{
    struct
    {
        UINT32 freq100KHz;         // unit:100KHz
        INT32  dcxoDeltaFreq;
        UINT32 dcxoCbank;
        INT16 dcxoT0; // fwl=4, 1/16 degree.
        UINT16 dcxoT0Code;
        UINT32 rc32KCap;
    };

    UINT32 u32[FCALI_AFC_TABLE_SIZE];
}RfAfcTableAp;  // 20 bytes

void atRfNstRspInd(INT32 chanId, UINT8 *dataOutReq, UINT32 outLen, BOOL phyRspEna);
INT32 ResumeTrans(UINT16 dataBlockCounter,UINT8* dataOut, UINT16* lenOut);
void atRfCaliGetThermal(RfAfcTableAp *pAfcTb);
INT32 atRf32KCapCali(UINT32 *cTuneRst);
BOOL atRf32KEnaGet(void);
INT32 RfAtNstCmdPreHandle(UINT16 atHandle, UINT8* data, UINT16 length, UINT8* dataOut, UINT16* lenOut);
UINT16 crc16_ccitt(void *dataptr, int len);
void RfHexToChar(UINT8* inHex);
void RfHexToString(UINT8* outStr, UINT8* rawData, UINT16 rawDataLen);
INT32 RfFcWriteTable(UINT16 *pDataIn, UINT16 srcHdr);
void RfAtTestCmd(UINT16 atHandle, UINT8* dataIn, UINT16 length);
void RfRc32KTestTmExp(void* arg);
void atRfNstRspDebug(INT32 chanId);
BOOL RfOpenApiDcdcVpaCfg (UINT8 ena, UINT8 voltage);
void RfCmiReqNoAt(UINT16 primId, UINT16 primSize, void *primBody);
//void RfOpenApiDcdcVpaRsp ( void );

#endif

