/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename:
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/


#ifndef _NVRAM_H
#define _NVRAM_H

 /*----------------------------------------------------------------------------*
  *                    INCLUDES                                                *
  *----------------------------------------------------------------------------*/

#ifdef __cplusplus
 extern "C" {
#endif
#ifndef WIN32
#else
#pragma pack(1)
#include "win32_config.h"
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/

#define NVRAM_SECTOR_SIZE   4096
#define NVRAM_PAGE_SIZE     256

#define NVRAM_FAC_RESTORE_ERR	0xFFFFFFFE

/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/

typedef enum
{
    NVRAM_OK=0,
    NVRAM_ERR,
    NVRAM_FORMAT_ERR,
    NVRAM_ERASE_FLASH_ERR,
    NVRAM_WRITE_FLASH_ERR,
    NVRAM_CHECK_ITEM_ERR,
    NVRAM_CHECK_ITEM_NO_EXIST,
    NVRAM_FAC_BROKEN,
} NvErr_e;

typedef enum 
{
	NV = 0x0,
	NV_FAC,
	NV_BANK_MAX,
} NvBank_e;

typedef enum 
{
    SAVE_ALL = 0x0,
    SAVE_CALI,
    SAVE_OTHER,
} NvSaveFac_e;

typedef enum 
{
    APNV1 = 0x0,
    APNV2,
    APNV3,
    APNV4,
    CPNV1,
    CPNV2,
    CPNV3,
    CPNV4,
    CPNV5,
    CPNV6,
    NV_MAX,
} NvType_t;

typedef struct
{
    uint32_t nv_flag;
    uint32_t time_counter; //default:0x00000001
    uint16_t used_size;
    uint16_t size_dummy;    //0xFFFF
    uint32_t chksum;    //CRC32
    uint32_t dummy1; //0xFFFFFFFF
    uint32_t dummy2; //0xFFFFFFFF
    uint32_t dummy3; //0xFFFFFFFF
    uint16_t header_chk_dummy; //0xFFFF
    uint16_t header_chk;
} NvHeader_t;

/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

NvErr_e nvramInit(void);
uint32_t nvramRead(NvType_t nvt,uint8_t * data,uint32_t size,uint32_t offset);
uint32_t nvramWrite(NvType_t nvt,uint8_t * data,uint32_t size);
uint32_t nvramGetAddr(NvType_t nvt);
uint32_t nvramSave2Fac(void);
uint32_t nvramSav2FacAt(NvSaveFac_e sel);
uint32_t nvramGetnvAddr(NvType_t nvt);

#ifdef CORE_IS_AP
uint32_t nvramGetnvFacAddr(NvType_t nvt);
uint32_t nvramGetnvLength(NvType_t nvt);
#endif

#ifdef __cplusplus
}
#endif

#endif /* _NVRAM_H */
