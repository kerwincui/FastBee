/*
 * Copyright (C) 2015-2018 Alibaba Group Holding Limited
 */

#ifndef _INFRA_REDIRECT_REGION_H_
#define _INFRA_REDIRECT_REGION_H_

#include "infra_types.h"

int iotx_redirect_region_subscribe(void);
int iotx_redirect_set_flag(int flag);
int iotx_redirect_get_flag(void);
int iotx_redirect_get_iotId_iotToken(char *iot_id,char *iot_token,char *host, uint16_t *pport);

#endif