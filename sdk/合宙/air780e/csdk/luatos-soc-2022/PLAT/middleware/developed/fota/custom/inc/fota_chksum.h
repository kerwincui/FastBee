/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: fota_chksum.h
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/

#ifndef FOTA_CHKSUM_H
#define FOTA_CHKSUM_H

int32_t fotaInitChksum(uint8_t flags, void *args);
int32_t fotaDeinitChksum(uint8_t flags, void *args);
int32_t fotaCalcChksum(uint8_t flags, void *args);


#endif
