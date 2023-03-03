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
#ifndef __EC_FILE_API_H__
#define __EC_FILE_API_H__

#include "cms_util.h"

typedef enum AT_FILE_ERROR
{
    FILE_PARAM_ERROR = 1,                          /**/
    FILE_OPERATION_NOT_SUPPORT = 2,                /**/
    FILE_OPEN_ERROR     = 3,                          /**/
    FILE_READ_ERROR     = 4,                          /**/
    FILE_WRITE_ERROR    = 5,                          /**/
    FILE_CLOSE_ERROR    = 6,                          /**/
    FILE_SEEK_ERROR     = 7,                          /**/
    FILE_POSITION_ERROR = 8,                          /**/
    FILE_TUCAT_ERROR    = 9,                          /**/
    FILE_ERASE_ERROR    = 10,                          /**/
    FILE_DELETE_ERROR   = 11,                          /**/
}_AtFileCmdError;

typedef enum applFilePrimId_Enum
{
    APPL_FILE_PRIM_ID_BASE = 0,

    APPL_FILE_OPEN_REQ, //
    APPL_FILE_OPEN_CNF,
    APPL_FILE_OPEN_IND,

    APPL_FILE_READ_REQ, //
    APPL_FILE_READ_CNF,
    APPL_FILE_READ_IND,

    APPL_FILE_WRITE_REQ, //
    APPL_FILE_WRITE_CNF,
    APPL_FILE_WRITE_IND,

    APPL_FILE_SEEK_REQ, //
    APPL_FILE_SEEK_CNF,
    APPL_FILE_SEEK_IND,

    APPL_FILE_POSITION_REQ, //
    APPL_FILE_POSITION_CNF,
    APPL_FILE_POSITION_IND,

    APPL_FILE_TUCAT_REQ, //
    APPL_FILE_TUCAT_CNF,
    APPL_FILE_TUCAT_IND,

    APPL_FILE_CLOSE_REQ, //
    APPL_FILE_CLOSE_CNF,
    APPL_FILE_CLOSE_IND,

    APPL_FILE_RENAME_REQ, //
    APPL_FILE_RENAME_CNF,
    APPL_FILE_RENAME_IND,
        
    APPL_FILE_ERASE_REQ, //
    APPL_FILE_ERASE_CNF,
    APPL_FILE_ERASE_IND,
    
    APPL_FILE_DELETE_REQ, //
    APPL_FILE_DELETE_CNF,
    APPL_FILE_DELETE_IND,

    APPL_FILE_MSLDS_REQ, //
    APPL_FILE_MSLDS_CNF,
    APPL_FILE_MSLDS_IND,

    APPL_FILE_MSLST_REQ, //
    APPL_FILE_MSLST_CNF,
    APPL_FILE_MSLST_IND,

    APPL_FILE_MSDEL_REQ, //
    APPL_FILE_MSDEL_CNF,
    APPL_FILE_MSDEL_IND,

    APPL_FILE_MSUPL_REQ, //
    APPL_FILE_MSUPL_CNF,
    APPL_FILE_MSUPL_IND,

    APPL_FILE_MSDWL_REQ, //
    APPL_FILE_MSDWL_CNF,
    APPL_FILE_MSDWL_IND,

    APPL_FILE_PRIM_ID_END = 0xFF
}applFilePrimId;


#endif

