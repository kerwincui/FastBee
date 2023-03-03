#ifndef __SCT_REG_H__
#define __SCT_REG_H__

/******************************************************************************
 ******************************************************************************
  Copy right:   2017-, Copyrigths of AirM2M Ltd.
  File name:    sctreg.h
  Description:  SCT register, Security Top is a HW use to do:
  *             1) cipher & integrity check
  *             2) AES/SHA
  *             3) PPP escape & CRC
  *             4) USB TX
  History:      2020/12/04      Originated by Jason
 ******************************************************************************
******************************************************************************/
#include "ec618.h"

#if defined(__CC_ARM)
#pragma anon_unions
#endif

/******************************************************************************
 ******************************************************************************
 * SCT control registers
 ******************************************************************************
******************************************************************************/

/*
 * Cipher   0x4005-0000~0x4005-FFFF (64KB)
*/
#define SCT_REG_ADDR        0x40050000


/******************************************************************************
 * SCT enable/disable register
******************************************************************************/

#define SCT_EN_CTRL_REG                 ((__IO    UINT32 *)SCT_REG_ADDR)


/*
 * __IO    UINT32  SCTEN;
 * Bit  WIDTH       DESP
 * 0        1       0 - SCT disable (reset value)
 *                  1-  SCT enable
 * 1:31     31      RSVD
*/
#define ENABLE_SCT()                ((*(SCT_EN_CTRL_REG)) = 1)
#define DISABLE_SCT()               ((*(SCT_EN_CTRL_REG)) = 0)


/******************************************************************************
 ******************************************************************************
 * SCT RNDIS/PPP config register
 ******************************************************************************
******************************************************************************/

/*
 * SctRndisCrcCfgReg RNDIS_CRC_CFG
 * Bit  WIDTH       DESP
 * 0        1       rndis_crc_in_bit_swap,
 *                  0 - CRC calc from bit: inByte[0]
 *                  1 - CRC calc from bit: inByte[7] (reset value)
 * 1        1       rndis_crc_comple_out
 *                  0 - CRC out bit not comple
 *                  1 - CRC out bit comple (reset value)
 * 2        1       rndis_crc_out_bit_swap
 *                  0 - CRC out bit not swap
 *                  1 - CRC out bit swap (reset value)
 * 3:6      4       rndis_crc_comple_in_num, how many input bytes need to be compled
 *
*/
typedef union
{
    struct {
        UINT32  crcInBitSwap    : 1;
        UINT32  crcCompleOut    : 1;
        UINT32  crcOutBitSwap   : 1;
        UINT32  crcCompleInNum  : 4;
        UINT32                  : 25;
    };

    UINT32  value32;
}SctRndisCrcCfgReg;


/*
 * SctPPPCrcInitReg PPP_CRC_INIT
 * Bit  WIDTH       DESP
 * 0:15    16       PPP CRC init value, reset value: 0xFFFF
*/
typedef union
{
    struct  {
        UINT32  crcInitValue    : 16;
        UINT32                  : 16;
    };

    UINT32  value32;
}SctPPPCrcInitReg;


/*
 * SctPPPCrcCfgReg  PPP_CRC_CFG
 * Bit  WIDTH       DESP
 * 0        1       ppp_crc_in_bit_swap
 *                  0 - CRC calc from bit: inByte[0], (reset value)
 *                  1 - CRC calc from bit: inByte[7]
 * 1        1       ppp_crc_comple_out
 *                  0 - CRC out bit not comple
 *                  1 - CRC out bit comple, (reset value)
 * 2        1       ppp_crc_out_bit_swap
 *                  0 - CRC out bit not swap
 *                  1 - CRC out bit swap (reset value)
 *
*/
typedef union
{
    struct {
        UINT32  crcInBitSwap    : 1;
        UINT32  crcCompleOut    : 1;
        UINT32  crcOutBitSwap   : 1;
        UINT32                  : 29;
    };

    UINT32  value32;
}SctPPPCrcCfgReg;

/*
 * PPP escape/deescape bitmap table
*/
#define SCT_PPP_ESCP_BITMAP_WORD_NUM        8
#define SCT_PPP_DE_ESCP_BITMAP_WORD_NUM     8


/*
 * SCT RNDIS PPP config register struct
*/
typedef struct SctRndisPPPCfgReg_Tag
{
    __IO    UINT32              RNDIS_CRC_INIT;         /* RNDIS (802.3) CRC init value, reset value: 0,    offset: 0x04 */
    __IO    SctRndisCrcCfgReg   RNDIS_CRC_CFG;          /* RNDIS (802.3) CRC config.                        offset: 0x08 */
    __IO    SctPPPCrcInitReg    PPP_CRC_INIT;           /* PPP CRC init value, reset value: 0xFFFF,         offset: 0x0C */
    __IO    SctPPPCrcCfgReg     PPP_CRC_CFG;            /* PPP CRC config,                                  offset: 0x10 */

    __IO    UINT32              PPP_ESCP_BITMAP[SCT_PPP_ESCP_BITMAP_WORD_NUM];      /* PPP escape bitmap,   offset: 0x14 */
    __IO    UINT32              PPP_DE_ESCP_BITMAP[SCT_PPP_DE_ESCP_BITMAP_WORD_NUM];/* PPP de-escape bitmap, offset: 0x34 */
}SctRndisPPPCfgReg;

/*
 * SCT RNDIS PPP config register start address
*/
#define SCT_RNDIS_PPP_CTRL_REG_ADDR                 (SCT_REG_ADDR + 0x04)

/*
 * SCT RNDIS PPP register pointer
*/
#define SCT_RNDIS_PPP_CFG_REG                       ((SctRndisPPPCfgReg *)SCT_RNDIS_PPP_CTRL_REG_ADDR)



/******************************************************************************
 ******************************************************************************
 * SCT (cipher/integrity) common config register
 ******************************************************************************
******************************************************************************/

/*
 * SctCommCfgWord0     COMM_CFG0
 * Bit  WIDTH       DESP
 * 0        1       sct_cfg_acg_en_rmi_acg
 *                  0 - not enable auto gate, (reset value)
 *                  1 - enable auto gate
 * 1        1       sct_cfg_acg_en_ahb_acg
 *                  0 - not enable auto gate, (reset value)
 *                  1 - enable auto gate
 * 16       1       sct_cfg_unilog_SCT_ChainStart
 *                  0 - no unilog output, (reset value)
 *                  1 - unilog output
 * 17       1       sct_cfg_unilog_SCT_Descriptor_done
 *                  0 - no unilog output, (reset value)
 *                  1 - unilog output
 * 18       1       sct_cfg_unilog_SCT_ChainEnd
 *                  0 - no unilog output, (reset value)
 *                  1 - unilog output
 * 19       1       sct_cfg_unilog_error_int
 *                  0 - no unilog output, (reset value)
 *                  1 - unilog output
 * 20       1       sct_usb_lb_ind, USB Tx big/Little endian output
 *                  0 - little endian, (reset value)
 *                  1 - big endian
 * 24:31    8       sct_cfg_high_addr_offst
 *
*/
typedef union
{
    struct {
        UINT32  rmiAcg      : 1;
        UINT32  ahbAcg      : 1;
        UINT32              : 14;
        UINT32  chainStartUnilog : 1;
        UINT32  descDoneUnilog : 1;
        UINT32  chainEndUnilog : 1;
        UINT32  errorIntUnilog : 1;
        UINT32  usbLBEndianInd : 1;
        UINT32                 : 3;
        UINT32  memHighAddrOffset : 8;
    };

    UINT32  value32;
}SctCommCfgWord0;


/*
 * SctCommCfgWord1     COMM_CFG1
 * Bit  WIDTH       DESP
 * 0:19    20       sct_cfg_d_max_time, (reset value: 0)
 *                  descriptor max process time, in unit of 32K ticks, if timeout, tigger interrupt: sct_dscrpt_time_out
 *
*/
typedef union
{
    struct {
        UINT32  descMaxProcTickTime : 20;
        UINT32                      : 12;
    };

    UINT32  value32;
}SctCommCfgWord1;


/*
 * SCT common config register struct
*/
typedef struct SctCommCfgReg_Tag
{
    __IO    SctCommCfgWord0     COMM_CFG0;              /* SCT common CFG0,     offset: 0x54 */
    __IO    SctCommCfgWord1     COMM_CFG1;              /* SCT common CFG1,     offset: 0x58 */
}SctCommCfgReg;

/*
 * SCT common control register start address
*/
#define SCT_COMM_CFG_REG_ADDR           (SCT_REG_ADDR + 0x54)

/*
 * SCT RNDIS PPP register pointer
*/
#define SCT_COMM_CFG_REG                ((SctCommCfgReg *)SCT_COMM_CFG_REG_ADDR)


/******************************************************************************
 ******************************************************************************
 * SCT (cipher/integrity) channel config register
 ******************************************************************************
******************************************************************************/

/*
 *
 * Bit  WIDTH       DESP
 * 0:7      8       sct_fifo_len_ch0
 *                  Chain FIFO length, MAX set to 255, (reset value: 0)
 * 8        1       sct_chain_int_en_ch0, (reset value: 0)
 *                  Generate interrupt when each chain in this channel is finished
 * 9        1       sct_fifo_empty_int_en_ch0, (reset value: 0)
 *                  FIFO empty interrupt enable, Generate interrupt when chain FIFO is empty (all done)
 * 10       1       sct_fifo_full_int_en_ch0, (reset value: 0)
 *                  FIFI full interrupt enable, Generate interrupt when chain FIFO is full (>sct_fifo_len_ch0)
 * 11       1       sct_ck_bl_ch0, input CK is big/little endian
 *                  0 - little endian, (reset value: 0)
 *                  1 - big endian
 * 12       1       sct_aes_iv_bl_ch0, input AES IV is big/little endian
 *                  0 - little endian, (reset value: 0)
 *                  1 - big endian
 * 13       1       sct_ck_opt_dis_ch0, whether disable CK optimization, whether need to re-load CK from SRAM, when process descriptors in the same chain
 *                  0 - enable CK opt, (reset value: 0)
 *                  1 - disable CK opt
 * 16:17    1       comm_crc_poly_len_ch0, common CRC poly length
 *                  0 每 8 bits CRC, (reset value: 0)
 *                  1 每 16 bits CRC
 *                  2 每 24 bits CRC
 *                  3 每 32 bits CRC
 * 19       1       comm_crc_comple_out_ch0
 *                  0 - CRC output not need to comple, (reset value: 0)
 *                  1 - CRC output need to comple
 * 20:23    4       comm_crc_comple_in_num_ch0, how many input bytes need to comple, before start CRC,
 * 24       1       comm_crc_out_bit_swap_ch0
 *                  0 每 crcbyte from s[x] to s[x+7], s[x+7] is placed in LSB, (reset value: 0)
 *                  1 每 crcbyte from s[x+7] to s[x], s[x+7] is placed in MSB
 * 25       1       comm_crc_in_bit_swap_ch0
 *                  0 每 CRC start from bit[0] of input byte, (reset value: 0)
 *                  1 每 CRC start from bit[7] of input byte
 *
*/
typedef union
{
    struct {
        UINT32  fifoLen         : 8;
        UINT32  chainIntEn      : 1;
        UINT32  chainEmptyIntEn : 1;
        UINT32  chainFullIntEn  : 1;
        UINT32  ckBLEndian      : 1;
        UINT32  aesIvBLEndian   : 1;    /* bit: 12 */
        UINT32  ckOptDis        : 1;    /* bit: 13 */
        UINT32                  : 2;
        UINT32  crcPolyLen      : 2;    /* bit: 16:17 */
        UINT32                  : 1;
        UINT32  crcOutComple    : 1;    /* bit: 19 */
        UINT32  crcInCompleByteNum  : 4;    /* bit: 20:23 */
        UINT32  crcOutBitSwap   : 1;    /* bit: 24 */
        UINT32  crcInBitSwap    : 1;    /* bit: 25 */
        UINT32                  : 6;
    };

    UINT32  value32;
}SctChCfgWord0;

/*
 * UINT32              CHA_BASE_ADDR
 *  Chain Base Address. Chain FIFO start address, should be 4 bytes aligned, and with length: 4*CHAINFIFOLEN
*/

/*
 * UINT32              CK_BASE_ADDR, EEA/EIA CK Base Address
 * 1. Should be 4 bytes aligned
 * 2. one CK/IK 16 bytes
 * 3. Total 8 CK/IK keys, so total byte length: 8*16 = 128
*/

/*
 * SctChCtrlReg        CH_CTRL  //write only
 * Bit  WIDTH       DESP
 * 0        1       sct_chain_trigger_ch0
 *                  Set 1, Chain trigger, a chain already insert into the chain list, and trigger SCT to process
 * 1        1       sct_channel_reset_ch0
 *                  Set 1, to reset current channel
 *
*/
typedef union
{
    struct {
        UINT32  chainTrg    : 1;
        UINT32  chnReset    : 1;
        UINT32              : 30;
    };

    UINT32  value32;
}SctChCtrlReg;

/*
 * SCT channel config register struct
*/
typedef struct SctChannelCfgReg_Tag
{
    __IO    SctChCfgWord0       CH_CFG0;                /* SCT channel CFG0,                    offset: 0x5C */
    __IO    UINT32              CHA_BASE_ADDR;          /* SCT channel chain base address,      offset: 0x60 */
    __IO    UINT32              CK_BASE_ADDR;           /* SCT channel CK/IK base address,      offset: 0x64 */
    __IO    UINT32              CRC_POLY;               /* SCT channel common CRC poly,         offset: 0x68 */
    __IO    UINT32              CRC_INIT;               /* SCT channel common CRC init value,   offset: 0x6C */
    __O     SctChCtrlReg        CH_CTRL;                /* SCT channel control register,  write only,  offset: 0x70 */
}SctChannelCfgReg;

/*
 * SCT totoal channel number: 6
*/
#define SCT_CHANNEL_NUM                 6

/*
 * SCT channels config register struct
*/
typedef struct SctCHSCfgReg_Tag
{
    SctChannelCfgReg    chCfg[SCT_CHANNEL_NUM];
}SctCHSCfgReg;


/*
 * SCT channels config register start address
*/
#define SCT_CHANNEL_CFG_REG_ADDR            (SCT_REG_ADDR + 0x5C)


/*
 * SCT channels config register pointer
*/
#define SCT_CHANNELS_CFG_REG                ((SctCHSCfgReg *)SCT_CHANNEL_CFG_REG_ADDR)


/******************************************************************************
 ******************************************************************************
 * SCT memory guard register
 ******************************************************************************
******************************************************************************/

typedef struct
{
    __IO    UINT32  hAddr0;                 /*sct_mpr_addr_h0,         offset: 0xEC */
    __IO    UINT32  lAddr0;                 /*sct_mpr_addr_l0,         offset: 0xF0 */
    __IO    UINT32  hAddr1;                 /*sct_mpr_addr_h1,         offset: 0xF4 */
    __IO    UINT32  lAddr1;                 /*sct_mpr_addr_l1,         offset: 0xF8 */
    __IO    UINT32  hAddr2;                 /*sct_mpr_addr_h2,         offset: 0xFC */
    __IO    UINT32  lAddr2;                 /*sct_mpr_addr_l2,         offset: 0x100 */
    __IO    UINT32  hAddr3;                 /*sct_mpr_addr_h3,         offset: 0x104 */
    __IO    UINT32  lAddr3;                 /*sct_mpr_addr_l3,         offset: 0x108 */
}SctMemGuardReg;

/*
 * SCT memory guard register start address
*/
#define SCT_MEM_GUARD_REG_ADDR              (SCT_REG_ADDR + 0xEC)

/*
 * SCT memory guard register pointer
*/
#define SCT_MEM_GUARD_CFG_REG               ((SctMemGuardReg *)SCT_MEM_GUARD_REG_ADDR)



/******************************************************************************
 ******************************************************************************
 * SCT channel state register
 ******************************************************************************
******************************************************************************/

/*
 * SCT channel state register
 * Bit  WIDTH       DESP
 * 0:7      8       sct_cfg_fifo_idx_ch0, Channel next configure index
 *                  a) reset/init value: 0
 *                  b) increase 1, when chain triggered.
 *                  c) Range: [0: fifoLen-1]
 * 8:15     8       sct_done_fifo_idx_ch0, Channel next done index
 *                  a) reset/init value: 0
 *                  b) increase 1, when one chain process done.
 *                  c) Range: [0: fifoLen-1]
 * 16:23    8       sct_free_fifo_space_ch0
 *                  Channel FIFO free space
 * 24       1       sct_fifo_full_ch0
 *                  Whether chain full (overflow), 0 - not, 1 - full
 * 25       1       sct_fifo_empty_ch0
 *                  Whether chain empty (all done), 0 - not, 1 - empty
 * 26       1       sct_dscrpt_act_ch0
 *                  Whether channel is activate, if descriptor in current channel is ongoing, then set 1, so only one channel could be set to 1
 * 27       1       sct_rst_done_ch0, Whether channel reset done.
 *                  a) SW: "SctChCtrlReg->chnReset" set 1, tigger SCT reset current channel
 *                  b) HW: SCT should stop current descriptor, and ignore all the pending chain request
 *                  c) HW: After reset done, SCT set this flag, and trigger ISR
 *                  d) SW: when process this ISR, if need to write USB EP in this channel, need to reflush/reset USB
 *                  e) HW: When this channel config/trigger again (SctChCtrlReg->chainTrg = 1), SCT clear this flag
 * 28       1       sct_dscrpt_time_out_ch0, whether SCT process this descriptor time out
 *                  a) HW: SCT start a guard timer, when start processing a descriptor, and stop it when done
 *                  b) HW: When timeout, SCT set this flag, and trigger ISR
 *                  c) HW: when SW reset current channel (SctChCtrlReg->chnReset = 1), SCT clear this flag
 *
 *
*/
typedef union
{
    struct {
        UINT32  chaNextCfgIdx   : 8;
        UINT32  chaNextDoneIdx  : 8;
        UINT32  chnFreeLen      : 8;
        UINT32  chnBeFull       : 1;
        UINT32  chnBeEmpty      : 1;
        UINT32  chnBeAct        : 1;
        UINT32  chnBeRstDone    : 1;
        UINT32  descBeTimeOut   : 1;

        UINT32                  : 3;
    };

    UINT32  value32;
}SctChannelStateReg;

/*
 * SCT channels state registers
*/
typedef struct
{
    __I SctChannelStateReg      chState[SCT_CHANNEL_NUM];   /* SCT channel state, read only,        offset: 0x120 */
}SctCHSStateReg;

/*
 * SCT channels state register start address
*/
#define SCT_CHS_STATE_REG_ADDR              (SCT_REG_ADDR + 0x120)

/*
 * SCT channels state register pointer
*/
#define SCT_CHS_STATE_REG                   ((SctCHSStateReg *)SCT_CHS_STATE_REG_ADDR)



/******************************************************************************
 ******************************************************************************
 * SCT error status register
 ******************************************************************************
******************************************************************************/

/*
 * SctErrStatusWord0       errStatus
 * Bit  WIDTH       DESP
 * 0:5      6       master error (AHB error)
 * 6:11     6       memory guard error
 * 12:17    6       descriptor info error (PPP/CRC not byte aligned)
 *
*/
typedef union
{
    struct {
        UINT32  masterErr       : 6;
        UINT32  mgrErr          : 6;
        UINT32  descErr         : 6;
        UINT32                  : 14;
    };

    UINT32  value32;
}SctErrStatusWord0;


/*
 * SCT error status register struct
*/
typedef struct
{
    __I SctErrStatusWord0       errStatus;          /* sct_err_status, read only,               offset: 0x138 */
    __I UINT32                  rdErrMem;           /* sct_err_mpr_rd, SCT read error address,  offset: 0x13C */
    __I UINT32                  wtErrMem;           /* sct_err_mpr_wt, SCT write error address, offset: 0x140 */
}SctErrStatusReg;

/*
 * SCT error status register start address
*/
#define SCT_ERR_STATUS_REG_ADDR             (SCT_REG_ADDR + 0x138)

/*
 * SCT error status register pointer
*/
#define SCT_ERR_STATUS_REG                  ((SctErrStatusReg *)SCT_ERR_STATUS_REG_ADDR)

#endif

