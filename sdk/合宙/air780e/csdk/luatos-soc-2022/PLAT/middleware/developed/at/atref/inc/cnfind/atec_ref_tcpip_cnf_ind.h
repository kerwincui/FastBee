/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_ref_tcpip_cnf_ind.h
*
*  Description:Process TCP/IP service related AT commands
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_REF_TCPIP_CNF_IND_H__
#define __ATEC_REF_TCPIP_CNF_IND_H__
#include "at_util.h"

void atTcpIpProcRefNmApplCnf(CmsApplCnf *pApplCnf);
void atTcpIpProcRefNmApplInd(CmsApplInd *pApplInd);
void atTcpIpProcRefSoclCnf(CmsApplCnf *pApplCnf);
void atTcpIpProcRefSoclInd(CmsApplInd *pApplInd);

/*
 * When AT channel enter: ATC_REF_SOCKET_PASSTHROUGH_STATE/ATC_ONLINE_COMMAND_STATE, the AT channel data/Event callback API
*/
CmsRetId nmRefSockPSTHAndOnlineCmdCallback(UINT8 chanId, UINT8 curChanState, AtDataAndOnlineCmdSEvt eventId, void *pArg);


#endif

