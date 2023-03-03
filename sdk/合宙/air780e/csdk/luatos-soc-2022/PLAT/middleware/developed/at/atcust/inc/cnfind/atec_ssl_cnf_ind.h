/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_ssl_cnf_ind.h
*
*  Description: Process ssl client related AT commands
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _ATEC_SSL_CNF_IND_H_
#define _ATEC_SSL_CNF_IND_H_

#include "at_util.h"

CmsRetId sslOpenCnf(uint16_t reqHandle, uint16_t rc, void *paras);
CmsRetId httpReadCnf(uint16_t reqHandle, uint16_t rc, void *paras);
CmsRetId httpCloseCnf(uint16_t reqHandle, uint16_t rc, void *paras);

void atApplSslProcCmsCnf(CmsApplCnf *pCmsCnf);
void atApplSslProcCmsInd(CmsApplInd *pCmsInd);

#endif


