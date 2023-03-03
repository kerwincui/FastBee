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
#ifndef __ATEC_ADC_CNF_IND_H__
#define __ATEC_ADC_CNF_IND_H__

#include "at_util.h"

CmsRetId ecAdcCnf(UINT16 reqHandle, UINT16 rc, void *paras);
void atApplAdcProcCmsCnf(CmsApplCnf *pCmsCnf);

#endif

/* END OF FILE */
