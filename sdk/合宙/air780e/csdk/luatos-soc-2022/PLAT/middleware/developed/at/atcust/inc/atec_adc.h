/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_adc.h
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_ADC_H__
#define __ATEC_ADC_H__

#include "at_util.h"

#define  EC_ADC_STR_LEN_MAX   32
#define  EC_ADC_STR_BUF_SIZE  (EC_ADC_STR_LEN_MAX + 1)
#define  EC_ADC_STR_DEFAULT   NULL

CmsRetId ecADC(const AtCmdInputContext *pAtCmdReq);
#endif

/* END OF FILE */

