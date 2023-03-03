/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_phy_cnf_ind.h
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_PHY_CNF_IND_H__
#define __ATEC_PHY_CNF_IND_H__

#include <stdlib.h>
#include <string.h>
#include "cmsis_os2.h"
#include "at_util.h"
#include "atec_phy.h"
#include "ctype.h"
#include "cmicomm.h"
#include "atc_reply.h"
#include "ps_phy_if.h"


void atPhyProcCmiCnf(PhyCmiCnf *pCmiCnf);
void atPhyProcCmiInd(PhyCmiInd *pCmiInd);

#endif

