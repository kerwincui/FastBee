/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: at_def.h
 *
 *  Description: AT common defination
 *
 *  History:
 *
 *  Notes:
 *
******************************************************************************/
#ifndef __AT_DEF_H__
#define __AT_DEF_H__

#include "cms_def.h"

/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/

/******************************************************************************
 * SRC HANDLER
 *  15          12  11          8   7       5   4                0
 * +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
 * |       R       |  channel ID   | SUB AT ID |       TID         |
 * +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
 * Note:
 * 1> Channel ID:
 *  Channel ID 0, is reserved for internal.
 *  Channel ID 1, used for AT CMD from UART (default).
 * 2> SUB AT ID
 *  If several AT CMD correlated with same CMI REQ ID, this "AT ID" is used to distinguish
 *   which AT CMD when CMI CNF comes; so MAX 8 AT CMD could use one same CMI REQ ID
 * 3> TID: AT Asynchronous Timer index
 *  Used to index AT CMD guard timer
******************************************************************************/
#define AT_SET_SRC_HANDLER(TID, atId, chanId)       CMS_SET_SRC_HANDLER(TID, atId, chanId)
#define AT_GET_HANDLER_TID(srcHandler)              CMS_GET_HANDLER_TID(srcHandler)
#define AT_GET_HANDLER_SUB_ATID(srcHandler)         CMS_GET_HANDLER_SUB_ATID(srcHandler)
#define AT_GET_HANDLER_CHAN_ID(srcHandler)          CMS_GET_HANDLER_CHAN_ID(srcHandler)
#define AT_GET_UINT16_HANDLER(srcHandler)           CMS_GET_UINT16_HANDLER(srcHandler)
#define AT_MAX_ASYN_GUARD_TIMER_TID                 31


/*
 * 1> CMS task OSA timer ID defination:
 *
 * 16 bits timerID
 * 15      12                    0
 * +-------+---------------------+
 * | modId |   timerId in modId  |
 * +-------+---------------------+
 *  MSB 4 bits: use to distinguish which sub-module in CMS task, so MAX 16 sub-modes
 *
 * 2> AT timer sub-module ID: CMS_TIMER_AT_SUB_MOD_ID
 *
 * 3> AT sub timer ID defination:
 * 15      12    8 7     4      0
 * +-------+------+-----+-------+
 * |   0   |  CID | R(0)|  TID  |
 * +-------+------+-----+-------+
 *  CID: AT channel ID, 4 bits
 *  R:   reserved, 3 bits
 *  TID: AT Asynchronous Timer index, 5 bits
 *
 * 4> AT URC delay timer:
 * 15      12    8 7   5 4      0
 * +-------+------+-----+-------+
 * |   0   |  CID | 001 | 00000 |
 * +-------+------+-----+-------+
*/
#define AT_SET_ASYN_TIMER_ID(chanId, tid)   (UINT16)((((CMS_TIMER_AT_SUB_MOD_ID)<<12)&0xF000) | (((chanId)<<8)&0x0F00) | ((tid)&0x1F))
#define AT_GET_ASYN_TIMER_CHAN_ID(timerId)  (((timerId)>>8)&0x0F)
#define AT_GET_ASYN_TIMER_TID(timerId)      ((timerId)&0x1F)

#define AT_SET_URC_DELAY_TIMER_ID(chanId)   (UINT16)((((CMS_TIMER_AT_SUB_MOD_ID)<<12)&0xF000) | (((chanId)<<8)&0x0F00) | 0x20)
#define AT_IS_URC_DELAY_TIMER(timerId)      (((timerId)&0xF0FF) == 0x0020)
#define AT_GET_URC_DELAY_TIMER_CHAN_ID(timerId)     (((timerId)>>8)&0x0F)



/******************************************************************************
 * CMI REQ/CNF/IND ID:
 *  15          11                               0
 * +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 * |   SG ID   |           PRIM ID                 |
 * +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 *
 * CMI: CIOT Modem Interface
******************************************************************************/
#define AT_GET_CMI_SG_ID(reqId)                     CMS_GET_CMI_SG_ID(reqId)
#define AT_GET_CMI_PRIM_ID(reqId)                   CMS_GET_CMI_PRIM_ID(reqId)
#define AT_SET_CMI_REQ_CNF_ID(sgId, primId)         CMS_SET_CMI_REQ_CNF_ID(sgId, primId)


/*
*/
#define ATEC_IND_RESP_1024_STR_LEN      1024        //must using heap for this size
#define ATEC_IND_RESP_512_STR_LEN       512         //must using heap for this size
#define ATEC_IND_RESP_256_STR_LEN       256
#define ATEC_IND_RESP_128_STR_LEN       128
#define ATEC_IND_RESP_64_STR_LEN        64
#define ATEC_IND_RESP_48_STR_LEN        48
#define ATEC_IND_RESP_32_STR_LEN        32

#define AT_DEC_NUM_STR_MAX_LEN          11  //0xFFFFFFFF="4294967295", len("4294967295") = 10 + 1
#define AT_HEX_NUM_STR_MAX_LEN          9   //FFFFFFFF, 8 + 1
#define AT_BIN_NUM_STR_MAX_LEN          33  //len("11111111")*4 + 1

/*
 * CTRL-Z/ESC ASCI value
*/
#define AT_ASCI_CTRL_Z                  0x1A
#define AT_ASCI_ESC                     0x1B

/*
 * AT CMD buffer size
*/
#define AT_CMD_BUF_MAX_LEN                  (1024 * 3)


/*
 * Number of array
*/
#define AT_NUM_OF_ARRAY(array)      (sizeof(array)/sizeof((array)[0]))

/*
 * typedef struct AtCmdPreDefInfo_Tag
 * {
 *   const CHAR          *pName;     //AT name
 *
 *   UINT16              timeOutS;   //time out value in seconds
 *   UINT8               cmdType;    //AtCmdSyntaxType, basic/extended action command/extended parameter command
 *   UINT8               paramMaxNum;    //max parameters number
 *
 *   const AtValueAttr   *pParamList;
 *
 *   const AtCallbackFunctionP atProcFunc;
 * }AtCmdPreDefInfo;   //16 bytes
*/
#define AT_CMD_PRE_DEFINE(name, atProcFunc, paramAttrList, cmdType, timeOutS)    \
    {name, (timeOutS), cmdType, (paramAttrList == PNULL ? 0 : (sizeof(paramAttrList)/sizeof(AtValueAttr))), paramAttrList, atProcFunc}



#if 0
/* number of seconds between 1900 and 1970 (MSB=1)*/
#define TIME_SEC_1900_1970         (2208988800UL)
/* number of seconds between 1970 and Feb 7, 2036 (6:28:16 UTC) (MSB=0) */
#define TIME_SEC_1970_2036         (2085978496UL)
#endif



#endif

