/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: ccio_netdata.h
*
*  Description:
*
*  History: 2021/1/19 created by xuwang
*
*  Notes:
*
******************************************************************************/
#ifndef CCIO_NETDATA_H
#define CCIO_NETDATA_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include "ccio_misc.h"


#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
void  netifSetFastChkInfo(void *fastChkInfo, UINT16 infoLen);
void* netifGetFastChkInfo(void);

int32_t ethDataInput(UlPduBlock_t *ulpdu, void *extras);
int32_t ethDataOutput(uint8_t lanType, DlPduBlock_t *head, DlPduBlock_t *tail);
int32_t ethDataFastOutput(uint8_t lanType);

int32_t netDataInput(UlPduBlock_t *ulpdu, void *extras);
int32_t netDataOutput(DlPduBlock_t *head, DlPduBlock_t *tail);
int32_t netDataFastOutput(void);

#ifdef __cplusplus
}
#endif
#endif

