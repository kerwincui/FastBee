/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: ec_fwupd_api.h
 *
 *  Description: API interface implementation header file for adc service
 *
 *  History:
 *
 *  Notes:
 *
******************************************************************************/
#ifndef __EC_FWUPD_API_H__
#define __EC_FWUPD_API_H__

typedef enum
{
    FWUPD_EC_PARAM_INVALID = 1,
    FWUPD_EC_OPER_UNSUPP,
    FWUPD_EC_PKGSZ_ERROR,
    FWUPD_EC_PKGSN_ERROR,
    FWUPD_EC_CRC8_ERROR,
    FWUPD_EC_FLERASE_UNDONE,
    FWUPD_EC_FLERASE_ERROR,
    FWUPD_EC_FLWRITE_ERROR,
    FWUPD_EC_FLREAD_ERROR,
    FWUPD_EC_UNDEF_ERROR
}AtFwupdErrCode_e;


#endif

