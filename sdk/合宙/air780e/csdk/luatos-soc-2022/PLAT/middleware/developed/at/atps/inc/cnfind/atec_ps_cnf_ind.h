/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_ps_cnf_ind.h
*
*  Description: Process packet switched service related AT commands
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_PS_CNF_IND_H__
#define __ATEC_PS_CNF_IND_H__

#include <stdio.h>
#include "cmsis_os2.h"
#include "at_util.h"
#include "cmips.h"
#include "atec_ps.h"
#include "ps_ps_if.h"

#define ATEC_CGCONTRDP_RESP_BUF_SIZE  1280

/*
 * Cause ID -> Cause STRING mapping
*/
typedef struct AtcCeerCauseMapping_Tag
{
    UINT16      causeId;
    const CHAR *pStr;
}AtcCeerCauseMapping;


void atPsProcCmiCnf(CamCmiCnf *pCmiCnf);
void atPsProcCmiInd(CamCmiInd *pCmiInd);



#endif
