/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_ctwing_cnf_ind.h
*
*  Description: Process ctwing related AT commands
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _ATEC_CTWING_CNF_IND_H_
#define _ATEC_CTWING_CNF_IND_H_

#include "at_util.h"

void atApplCtwProcCmsCnf(CmsApplCnf *pCmsCnf);
void atApplCtwProcCmsInd(CmsApplInd *pCmsInd);

#endif

