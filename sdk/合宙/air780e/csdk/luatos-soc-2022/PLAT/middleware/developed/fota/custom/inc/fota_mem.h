/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: fota_mem.h
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/

#ifndef FOTA_MEM_H
#define FOTA_MEM_H


int32_t fotaInitMem(uint8_t *buf, uint32_t size);
void*   fotaAllocMem(uint32_t size);
void    fotaFreeMem(void *buf);



#endif
