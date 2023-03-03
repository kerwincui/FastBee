/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: ccio_custom.h
*
*  Description:
*
*  History: 2021/1/19 created by xuwang
*
*  Notes: customized features of Channel Centre for Input/Output(CCIO) service
*
******************************************************************************/
#ifndef CCIO_CUSTOM_H
#define CCIO_CUSTOM_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/


#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/

/*
 * customed device executed flags definition, which is a subset of 'CcioDevExecFlags_e'
 */
typedef enum
{
    CCIO_DEF_CUST_BEGIN = 0x0DEFC000,
    CCIO_DEF_CUST_A = CCIO_DEF_CUST_BEGIN,
    CCIO_DEF_CUST_B,
    CCIO_DEF_CUST_END = 0x0DEFFFFF
}CcioCustDevExecFlags_e;

/*
 * customed device status flags definition, which is a subset of 'CcioDevStatusFlags_e'
 */
 typedef enum
 {
     CCIO_DSF_CUST_BEGIN = 0x0D5FE000,
     CCIO_DSF_CUST_A = CCIO_DSF_CUST_BEGIN,
     CCIO_DSF_CUST_B,
     CCIO_DSF_CUST_END = 0x0D5FFFFF
 }CcioCustDevStatusFlags_e;

/*
* customed entity status flags definition, which is a subset of 'CcioEntStatusFlags_e'
*/
 typedef enum
 {
     CCIO_ESF_CUST_BEGIN = 0x0E5FC000,
     CCIO_ESF_CUST_A = CCIO_DSF_CUST_BEGIN,
     CCIO_ESF_CUST_B,
     CCIO_ESF_CUST_END = 0x0E5FFFFF
 }CcioCustEntStatusFlags_e;

typedef enum
{
    /* control msg */
    CCIO_CHAN_CMSG_CUST_BEGIN = CCIO_CHAN_CMSG_CUST_FLAG,
    CCIO_CHAN_CMSG_CUST_A = CCIO_CHAN_CMSG_CUST_BEGIN,
    CCIO_CHAN_CMSG_CUST_B,

    CCIO_CHAN_CMSG_CUST_MAXID,
    CCIO_CHAN_CMSG_CUST_END = (CCIO_CHAN_CMSG_CUST_FLAG | CCIO_CHAN_MSG_CODE_MASK),

    /* data msg */
    CCIO_CHAN_DMSG_CUST_BEGIN = CCIO_CHAN_DMSG_CUST_FLAG,
    CCIO_CHAN_DMSG_CUST_A = CCIO_CHAN_DMSG_CUST_BEGIN,
    CCIO_CHAN_DMSG_CUST_B,

    CCIO_CHAN_DMSG_CUST_MAXID,
    CCIO_CHAN_DATA_CUST_END = (CCIO_CHAN_DMSG_CUST_FLAG | CCIO_CHAN_MSG_CODE_MASK),

    /* error msg */
    CCIO_CHAN_EMSG_CUST_BEGIN = CCIO_CHAN_EMSG_CUST_FLAG,
    CCIO_CHAN_EMSG_CUST_A = CCIO_CHAN_EMSG_CUST_BEGIN,
    CCIO_CHAN_EMSG_CUST_B,

    CCIO_CHAN_EMSG_CUST_MAXID,
    CCIO_CHAN_EMSG_CUST_END = (CCIO_CHAN_EMSG_CUST_FLAG | CCIO_CHAN_MSG_CODE_MASK)
}CcioCustChanMessageId_e;


/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/

/* CCIO_DEF_CUST_A */
typedef struct
{
    uint8_t   rsvd[4];
}CcioDeaCustA_t;

/* CCIO_DEF_CUST_B */
typedef struct
{
    uint8_t   rsvd[4];
}CcioDeaCustB_t;

/* CCIO_DSF_CUST_A */
typedef struct
{
    uint8_t   rsvd[4];
}CcioDsaCustA_t;

/* CCIO_DSF_CUST_B */
typedef struct
{
    uint8_t   rsvd[4];
}CcioDsaCustB_t;

/* CCIO_ESF_CUST_A */
typedef struct
{
    uint8_t   rsvd[4];
}CcioEsaCustA_t;

/* CCIO_ESF_CUST_B */
typedef struct
{
    uint8_t   rsvd[4];
}CcioEsaCustB_t;


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
int32_t ccioInitCustTxTask(void *args);
int32_t ccioDeinitCustTxTask(void *args);
int32_t ccioSendToCustTxTask(void *msg, uint32_t timeout);

int32_t usbdExecCustInstr(uint32_t flags, void *args);
int32_t uartdExecCustInstr(uint32_t flags, void *args);
int32_t radiodExecCustInstr(uint32_t flags, void *args);

int32_t ccioHandleCustDevStatus(uint32_t flags, void *args);
int32_t ccioHandleCustEntStatus(uint32_t flags, void *args);

int32_t ccioHandleCustChanMsg(CcioChanMessage_t *chmsg);


#ifdef __cplusplus
}
#endif
#endif

