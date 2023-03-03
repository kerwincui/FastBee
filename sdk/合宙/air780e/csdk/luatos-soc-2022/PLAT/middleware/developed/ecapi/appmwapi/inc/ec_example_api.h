/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: ec_tcpip_api.h
 *
 *  Description: API interface implementation header file for socket/tcpip service
 *
 *  History:
 *
 *  Notes:
 *
******************************************************************************/
#ifndef __EC_EXAMPLE_API_H__
#define __EC_EXAMPLE_API_H__

#include "cms_util.h"

typedef enum AT_EXAMPLE_ERROR
{
    EXAMPLE_PARAM_ERROR = 1,                             /**/
    EXAMPLE_OPERATION_NOT_SUPPORT = 2,                     /**/
	EXAMPLE_TASK_NOT_CREATE = 3,					  /**/
}_AtExampleCmdError;


#endif

