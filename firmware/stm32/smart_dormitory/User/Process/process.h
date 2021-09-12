/****************************************Copyright (c)****************************************************
**     
** File name:               process.h
** Created by:              XiaoYi
** Created date:            2020-10-16
** Version:                 v1.0
** Descriptions:            The original 
** Link address:            https://blog.csdn.net/weixin_45006076
**
*********************************************************************************************************/

#ifndef __PROCESS_H__
#define __PROCESS_H__

#include "main.h"

/* Ö¸¶¨·äÃùÆ÷Òý½Å */
#define BUZZ    PBout(0)

void start_buzz(void);

void stop_buzz(void);

void process_local_handle(uint16_t value_humi);

void process_report_data(void);

void process_handle_wifi_data(void);

#endif

