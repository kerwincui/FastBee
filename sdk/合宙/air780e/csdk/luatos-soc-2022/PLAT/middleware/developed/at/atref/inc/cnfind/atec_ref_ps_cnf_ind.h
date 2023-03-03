/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_ref_ps_cnf_ind.h
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_REF_PS_CNF_IND_H__
#define __ATEC_REF_PS_CNF_IND_H__

#include "cmicomm.h"

void atRefDevProcCmiCnf(CamCmiCnf *pCmiCnf);
void atRefSimProcCmiCnf(CamCmiCnf *pCmiCnf);
void atRefPsProcCmiCnf(CamCmiCnf *pCmiCnf);
void atRefPsProcCmiInd(CamCmiInd *pCmiInd);
CmsRetId refPsProcDeactInd(UINT16 reqHandle,void *paras);
void atRefMmProcCmiCnf(CamCmiCnf *pCmiCnf);


#endif

