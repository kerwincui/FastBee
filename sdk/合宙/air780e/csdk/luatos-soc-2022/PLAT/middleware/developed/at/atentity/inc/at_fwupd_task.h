/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: at_fwupd_task.h
*
*  Description:FW upgrade over serial port via AT command
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __AT_FWUPD_TASK_H__
#define __AT_FWUPD_TASK_H__

#include "at_util.h"

#define FWUPD_MQUE_MSG_MAXNUM         2
#define FWUPD_MQUE_SEND_TIMEOUT       500
#define FWUPD_TASK_STACK_SIZE         2048

#define FWUPD_RESP_BUF_MAXLEN         128

#define FWUPD_FW_VER_MAXLEN           32
#define FWUPD_FW_NAME_MAXLEN          32
#define FWUPD_FW_PSN_MINNUM           0
#define FWUPD_FW_PSN_MAXNUM           65535
#define FWUPD_DATA_BYTES_MAXNUM       256
#define FWUPD_DATA_HEXSTR_MAXLEN      FWUPD_HEXSTR_LEN(FWUPD_DATA_BYTES_MAXNUM)

#define FWUPD_HEXBYTE_NUM(strlen)       ((strlen) >> 1)
#define FWUPD_HEXSTR_LEN(nbytes)        ((nbytes) << 1)
#define FWUPD_HEXCHAR_TO_INTEGER(hex)   ((hex >= '0' && hex <= '9') ? (hex - '0') : \
                                         ((hex >= 'A' && hex <= 'F') ? (hex - 'A' + 10) : \
                                         ((hex >= 'a' && hex <= 'f') ? (hex - 'a' + 10) : 0)))

#define FWUPD_REQMSG_INIT(msg)    \
        do{\
            msg.atHandle = 0;\
            msg.cmdCode  = FWUPD_CMD_CODE_MAXNUM;\
            msg.pkgSn    = FWUPD_FW_PSN_MINNUM;\
            msg.strLen   = 0;\
            msg.crc8     = 0;\
            memset(&msg.hexStr, '\0', (FWUPD_DATA_HEXSTR_MAXLEN + 1));\
        }while(0)

#define FWUPD_CNFMSG_INIT(msg)    \
        do{\
            msg.errCode  = FWUPD_EC_UNDEF_ERROR;\
            msg.strLen   = 0;\
            memset(&msg.respStr, '\0', FWUPD_RESP_BUF_MAXLEN);\
        }while(0)

typedef enum
{
    FWUPD_CMD_CODE_BEGIN = 0,
    FWUPD_CMD_CLEAR_FLASH = FWUPD_CMD_CODE_BEGIN,
    FWUPD_CMD_DOWNLOAD_FW,
    FWUPD_CMD_VERIFY_FW,
    FWUPD_CMD_QUERY_FWNAME,
    FWUPD_CMD_QUERY_FWVER,
    FWUPD_CMD_UPGRADE_FW,
    FWUPD_CMD_DOWNLOAD_OVER,
    FWUPD_CMD_DFU_STATUS,
    FWUPD_CMD_CODE_END = FWUPD_CMD_DFU_STATUS,

    FWUPD_CMD_CODE_MAXNUM		
}FwupdCmdCode_e;

typedef enum
{
    APPL_FWUPD_PRIM_ID_BASE = 0,

    APPL_FWUPD_REQ,
    APPL_FWUPD_CNF,

    APPL_FWUPD_PRIM_ID_END = 0xFF
}ApplFwupdPrimId;


typedef struct
{
    uint32_t atHandle;
    uint16_t cmdCode;
    uint16_t pkgSn;
    uint16_t strLen;
    uint8_t  hexStr[FWUPD_DATA_HEXSTR_MAXLEN + 1];
    uint8_t  crc8;
}FwupdReqMsg_t;

typedef struct
{
    uint8_t  errCode;
    uint8_t  rsvd;
    uint16_t strLen;
    uint8_t  respStr[FWUPD_RESP_BUF_MAXLEN];
}FwupdCnfMsg_t;



int32_t FWUPD_initTask(void);
int32_t FWUPD_deinitTask(void);
int32_t FWUPD_sendMsg(FwupdReqMsg_t *msg);


#endif

/* END OF FILE */

