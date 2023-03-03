/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: fota_utils.h
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/

#ifndef FOTA_UTILS_H
#define FOTA_UTILS_H

#include <stdio.h>
#include <stdint.h>
#include "fota_pub.h"


#define FOTA_BUF_SIZE_512      (512)
#define FOTA_BUF_SIZE_1K       (1024)
#define FOTA_BUF_SIZE_2K       (FOTA_BUF_SIZE_1K << 1)
#define FOTA_BUF_SIZE_4K       (FOTA_BUF_SIZE_1K << 2)
#define FOTA_BUF_SIZE_8K       (FOTA_BUF_SIZE_1K << 3)
#define FOTA_BUF_SIZE_16K      (FOTA_BUF_SIZE_1K << 4)
#define FOTA_BUF_SIZE_32K      (FOTA_BUF_SIZE_1K << 5)


#define FOTA_SHA256_HWALIGN_SIZE   64


#define FOTA_ABS(v)                   (((v) < 0) ? -(v) : (v))
#define FOTA_BITMASK(nbits,lsh)       (((1 << (nbits)) - 1) << lsh)
#define FOTA_OFFSETOF(type, field)    ((uint32_t)&(((type *)0)->field))


typedef int32_t (*buf_handle_callback)(uint8_t *buf, int32_t buflen);


uint32_t FOTA_convToZoneId(uint32_t fwAttr);
uint32_t FOTA_convToFwAttr(uint32_t zoneId);
int32_t  FOTA_chksumFlashData(uint32_t zid, uint32_t offset, uint32_t size, uint8_t *hash, uint32_t isLast, buf_handle_callback buf_handle_cb);
void     FOTA_dumpOctets(uint8_t *octs, int32_t len);

#endif
