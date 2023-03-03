/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: ec_adc_api.h
 *
 *  Description: API interface implementation header file for adc service
 *
 *  History:
 *
 *  Notes:
 *
******************************************************************************/
#ifndef __EC_ADC_API_H__
#define __EC_ADC_API_H__

#include "cms_util.h"

typedef enum AT_ADC_ERROR
{
    ADC_PARAM_ERROR = 1,                          /**/
    ADC_OPERATION_NOT_SUPPORT = 2,                /**/
    ADC_TASK_NOT_CREATE = 3,                      /**/
    ADC_CONVERSION_TIMEOUT = 4,                   /**/
}_AtAdcCmdError;


#endif

