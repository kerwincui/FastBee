/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_dm.h
*
*  Description: Device manager
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_ALARM_H__
#define __ATEC_ALARM_H__

#include "at_util.h"


typedef enum applAlarmPrimId_Enum
{
    APPL_ALARM_PRIM_ID_BASE = 0,

    APPL_ALARM_VOLT_IND,
    APPL_ALARM_THERM_IND,
    APPL_ALARM_PRIM_ID_END = 0xFF
}applAlarmPrimId;


void atApplAlarmProcCmsInd(CmsApplInd *pCmsInd);

#endif

/* END OF FILE */
