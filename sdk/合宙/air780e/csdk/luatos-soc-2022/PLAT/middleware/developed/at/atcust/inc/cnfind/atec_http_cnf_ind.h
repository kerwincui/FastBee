/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_http_cnf_ind.h
*
*  Description: Process http(s) client related AT commands
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _ATEC_HTTP_CNF_IND_H_
#define _ATEC_HTTP_CNF_IND_H_

#include "at_util.h"

//CmsRetId httpSendCnf(uint16_t reqHandle, uint16_t rc, void *paras);
//CmsRetId httpReadCnf(uint16_t reqHandle, uint16_t rc, void *paras);
//CmsRetId httpCloseCnf(uint16_t reqHandle, uint16_t rc, void *paras);

void atApplHttpProcCmsCnf(CmsApplCnf *pCmsCnf);
void atApplHttpProcCmsInd(CmsApplInd *pCmsInd);

#endif

