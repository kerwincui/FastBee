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
#ifndef __EC_CTW_API_H__
#define __EC_CTW_API_H__

typedef enum AT_CTW_ERROR
{
    CTW_PARAM_ERROR = 1,                  
    CTW_NOT_SUPPORT = 2,                  
    CTW_HTTP_CONNECT_FAIL = 3,
    CTW_REG_FAIL = 4,
    CTW_NO_SET_PARAM = 5,
    CTW_NO_REGISTER = 6,  
    CTW_SEND_FAIL = 7,  
}_AtCTWError;


#endif

