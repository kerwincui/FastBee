/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_mqtt_cnf_ind.h
*
*  Description: Process MQTT related AT commands
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef _ATEC_MQTT_CNF_IND_H
#define _ATEC_MQTT_CNF_IND_H

#include "at_util.h"
#include "atec_mqtt.h"

CmsRetId mqttOpenInd(UINT16 indHandle, void *paras);
CmsRetId mqttCloseInd(UINT16 indHandle, void *paras);
CmsRetId mqttConnInd(UINT16 indHandle, void *paras);
CmsRetId mqttDiscInd(UINT16 indHandle, void *paras);
CmsRetId mqttSubInd(UINT16 indHandle, void *paras);
CmsRetId mqttUnSubInd(UINT16 indHandle, void *paras);
CmsRetId mqttPubInd(UINT16 indHandle, void *paras);

CmsRetId mqttStatInd(UINT16 indHandle, void *paras);
CmsRetId mqttRecvInd(UINT16 indHandle, void *paras);

void atApplMqttProcCmsCnf(CmsApplCnf *pCmsCnf);
void atApplMqttProcCmsInd(CmsApplInd *pCmsInd);
#endif

