/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: ccio_atcmd.h
*
*  Description:
*
*  History: Rev1.0   2020-02-24
*
*  Notes: uart/usb at command header file
*
******************************************************************************/
#ifndef CCIO_ATCMD_H
#define CCIO_ATCMD_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include "ccio_misc.h"
#include "ccio_base.h"

#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/
/* dummy atCid when AT channel is removed! */
#define CCIO_DUMMY_AT_CHANID     1

/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/
typedef struct
{
    uint32_t delayMs;
    void    *chdev;
}AtCmdResetSystem_t;

typedef struct
{
    uint8_t  mode;
    uint8_t  atCid;
    uint8_t  rsvd[2];
    void    *chdev;
}AtCmdPwOffSystem_t;

typedef struct
{
    uint8_t  mode;
    uint8_t  rsvd[3];
    void    *chdev;
}AtCmdSwitchSlpMode_t;

typedef struct
{
    uint8_t  isSave;
    uint8_t  rsvd[3];
    uint32_t baudRate;
    uint32_t frameFmt;
    void    *chdev;
}AtCmdChgSerlConf_t;

typedef struct
{
    void    *chdev;
}AtCmdReqDataModeHS_t;

typedef struct
{
    uint8_t  pdp4Cid;    /* bit7: 0/1 exist or not; others: cid info! */
    uint8_t  pdp6Cid;    /* bit7: 0/1 exist or not; others: cid info! */
    uint16_t flags;
    void    *chdev;
}AtCmdStartPppSessn_t;

typedef struct
{
    uint8_t  isClosed;
    uint8_t  rsvd[3];
    void    *chdev;
}AtCmdStopPppSessn_t;

typedef struct
{
    uint8_t  rsvd[4];
    void    *chdev;
}AtCmdResumePppSessn_t;

/* timing-controlling */
typedef struct
{
    uint32_t  msgId;  /* CcioChanMessageId_e */
    uint32_t  data;
    uint32_t  extras;
    void     *chdev;
}AtCmdTmCtrlPppSessn_t;


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
int32_t atCmdInput(uint8_t atCid, uint8_t *atStr, uint16_t atStrLen);
int32_t atCmdOutput(uint8_t atCid, uint8_t *atStr, uint16_t atStrLen);
int32_t atCmdOutputDlPdu(uint8_t atCid, uint8_t outFmt, DlPduBlock_t *dlpdu);

/**
  \brief    Bypass SEND task and send string to uart directly
  \param[in] atCid   at chanId from PS
  \param[in] strPtr  pointer to string body
  \param[in] strLen  string length
  \return    void
  \note     Used only in specific cases, such as sleep entering procedure where we should not switch out from IDLE task
 */
int32_t atCmdDirectOutput(uint8_t atCid, uint8_t *strPtr, uint16_t strLen);

uint8_t atCmdGetChanNo(uint8_t atCid);

void atCmdResetOutMode(void);

void atCmdRestoreOutMode(void);

/*
 * dcdState: 0 - DCD off (high level), 1 - DCD on (low level)
*/
int32_t atCmdSetDcdState(uint8_t atCid, uint8_t dcdState);

/**
  \brief    request to set pstn serial ri signal to mcu or host
  \param[in] atCid          at chanId from PS
  \param[in] cycleCnt       the count of cycle(0-unset ri, 0xffff(CCIO_INFINITE_CYCLE_CNT)-square wave)
  \param[in] dutyCyclePct   percentage of duty cycle(0-100)
  \param[in] cycleTimeMs    cycle time in msec unit
  \return    0-succ, < 0-failure
  \note
 */
int32_t atCmdReqSetRiState(uint8_t atCid, uint16_t cycleCnt, uint16_t dutyCyclePct, uint32_t cycleTimeMs);

/**
  \brief Get IPR string for AT CMD AT+IPR print out
  \param[in] atCid  at chanId from PS
  \return pointer to IPR string
 */
uint8_t* atCmdGetIPRString(uint8_t atCid);

/**
  \brief Get supported baudrate list string for AT CMD print out
  \param[in] atCid  at chanId from PS
  \return pointer to ECIPR string
 */
uint8_t* atCmdGetBaudRateString(uint8_t atCid);

/**
  \brief Check if UART baud rate valid or not
  \param[in] atCid     at chanId from PS
  \param[in] baudRate  baud rate need to check
  \return true if pass otherwise false
 */
bool_t atCmdIsBaudRateValid(uint8_t atCid, uint32_t baudRate);

int32_t atCmdStartPppSessn(uint8_t atCid, uint8_t pdp4Cid, uint8_t pdp6Cid, bool_t needAct);
int32_t atCmdStopPppSessn(uint8_t atCid, uint32_t args);
int32_t atCmdResumePppSessn(uint8_t atCid, uint32_t args);

int32_t atCmdReqDataModeHS(uint8_t atCid, uint32_t args);

void atCmdPowerOff(uint8_t atCid, uint8_t mode);


#ifdef __cplusplus
}
#endif
#endif

