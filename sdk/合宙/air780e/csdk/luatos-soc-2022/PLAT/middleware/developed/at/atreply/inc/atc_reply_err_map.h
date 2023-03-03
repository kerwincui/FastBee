/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename:
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATC_REPLY_ERR_MAP_H__
#define __ATC_REPLY_ERR_MAP_H__

#include "CommonTypedef.h"

/*
 * ERROR CODE ID -> ERROR STRING mapping
*/
typedef struct AtcErrStrMapping_Tag
{
    UINT32  errId;
    const CHAR *pStr;
}AtcErrStrMapping;


/******************************************************************************
 *****************************************************************************
 * external API
 *****************************************************************************
******************************************************************************/

/*
 * AT REPLY
*/
const CHAR* atcGetCMEEStr(const UINT32 errId);

#endif

