/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_sim_cnf_ind.h
*
*  Description: The header file of atec_sim_cnf_ind
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_SIM_CNF_IND_H__
#define __ATEC_SIM_CNF_IND_H__

#include <stdio.h>
#include "cmsis_os2.h"
#include "at_util.h"
//#include "atec_controller.h"
#include "cmisim.h"
#include "atec_sim.h"
#include "ps_sim_if.h"


void atSimProcCmiCnf(CamCmiCnf *pCmiCnf);
void atSimProcCmiInd(CamCmiInd *pCmiInd);

#endif
