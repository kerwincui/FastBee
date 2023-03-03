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
#ifndef __ATEC_DM_CNF_IND_H__
#define __ATEC_DM_CNF_IND_H__

#include "at_util.h"

CmsRetId dmCtccRecvInd(UINT16 reqhandle, void *paras);
CmsRetId dmCuccRecvInd(UINT16 reqhandle, void *paras);
CmsRetId dmCmccRecvInd(UINT16 reqhandle, void *paras);

void atApplDmProcCmsInd(CmsApplInd *pCmsInd);

#endif

/* END OF FILE */
