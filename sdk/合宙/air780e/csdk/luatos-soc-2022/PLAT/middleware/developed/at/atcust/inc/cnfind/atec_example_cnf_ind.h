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
#ifndef __ATEC_EXAMPLE_CNF_IND_H__
#define __ATEC_EXAMPLE_CNF_IND_H__

#include "at_util.h"


CmsRetId ecTestbCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId ecTestcCnf(UINT16 reqHandle, UINT16 rc, void *paras);

CmsRetId ecTestcInd(UINT16 indHandle, void *paras);

void atApplExampleProcCmsCnf(CmsApplCnf *pCmsCnf);
void atApplExampleProcCmsInd(CmsApplInd *pCmsInd);


#endif

/* END OF FILE */
