/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: fota_sal.h
*
*  Description:
*
*  History: 2021/10/24 created by xuwang
*
*  Notes:
*
******************************************************************************/
#ifndef FOTA_SAL_H
#define FOTA_SAL_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include <stdint.h>
#include "sctdef.h"
#ifdef FEATURE_FOTA_ENABLE
#include "common.h"
#else
#include "FreeRTOS.h"
#include DEBUG_LOG_HEADER_FILE
#endif

#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/
#define FOTA_NVM_FLASH_ERASE_MIN_SIZE  FOTA_BUF_SIZE_4K


#ifdef FEATURE_FOTA_ENABLE
#define FOTA_PLAT_SCT_ZI               PLAT_BL_SCT_ZI

#define portTICK_RATE_MS               (1)
#define FOTA_NVM_FLASH_ERASE_SIZE      FOTA_BUF_SIZE_4K

#define BSP_QSPI_ERASE_AP_FLASH(addr, size)        BSP_QSPI_Erase_Sector_Safe(addr)//BSP_QSPI_Erase_Sector(addr)
#if defined CHIP_EC618 || defined CHIP_EC618_Z0
#define BSP_QSPI_ERASE_AP_FLASH_32K(addr, size)    BSP_QSPI_Erase_32KBlk_Safe(addr)
#elif defined CHIP_EC718
#define BSP_QSPI_ERASE_AP_FLASH_32K(addr, size)    BSP_QSPI_Erase_Block(addr)
#endif
#define BSP_QSPI_WRITE_AP_FLASH(buf, addr, size)   BSP_QSPI_Write(buf, addr, size)
#define BSP_QSPI_READ_AP_FLASH(buf, addr, size)    BSP_QSPI_XIP_Read(buf, addr, size)//ImageGeneralRead(buf, addr, size)

#if defined CHIP_EC618 || defined CHIP_EC618_Z0
#define BSP_QSPI_ENABLE_CP_FLASH()                 CPXIP_Enable()
#define BSP_QSPI_DISABLE_CP_FLASH()                CPXIP_DeInit()
#define BSP_QSPI_ERASE_CP_FLASH(addr, size)        CPXIP_QSPI_Erase_Sector(addr)
#define BSP_QSPI_ERASE_CP_FLASH_32K(addr, size)    CPXIP_QSPI_Erase_32Kblk(addr)
#define BSP_QSPI_WRITE_CP_FLASH(buf, addr, size)   CPXIP_QSPI_Write(buf, addr, size)
#define BSP_QSPI_READ_CP_FLASH(buf, addr, size)    CPXIP_QSPI_Read(buf, addr, size)
#elif defined CHIP_EC718
#define BSP_QSPI_ENABLE_CP_FLASH()
#define BSP_QSPI_DISABLE_CP_FLASH()
#define BSP_QSPI_ERASE_CP_FLASH(addr, size)        BSP_QSPI_Erase_Sector_Safe(addr)
#define BSP_QSPI_ERASE_CP_FLASH_32K(addr, size)    BSP_QSPI_Erase_Block(addr)
#define BSP_QSPI_WRITE_CP_FLASH(buf, addr, size)   BSP_QSPI_Write(buf, addr, size)
#define BSP_QSPI_READ_CP_FLASH(buf, addr, size)    BSP_QSPI_XIP_Read(buf, addr, size)
#endif

#else
#define FOTA_PLAT_SCT_ZI

#define FOTA_NVM_FLASH_ERASE_SIZE      FOTA_BUF_SIZE_32K

#define BSP_QSPI_ERASE_AP_FLASH(addr, size)        BSP_QSPI_Erase_Safe(addr, size)
#define BSP_QSPI_ERASE_AP_FLASH_32K(addr, size)    BSP_QSPI_Erase_Safe(addr, size)
#define BSP_QSPI_WRITE_AP_FLASH(buf, addr, size)   BSP_QSPI_Write_Safe(buf, addr, size)
#define BSP_QSPI_READ_AP_FLASH(buf, addr, size)    BSP_QSPI_Read_Safe(buf, addr, size)

#if defined CHIP_EC618 || defined CHIP_EC618_Z0
#define BSP_QSPI_ENABLE_CP_FLASH()
#define BSP_QSPI_DISABLE_CP_FLASH()
#define BSP_QSPI_ERASE_CP_FLASH_32K(addr, size)    -1
#define BSP_QSPI_ERASE_CP_FLASH(addr, size)        -1
#define BSP_QSPI_WRITE_CP_FLASH(buf, addr, size)   -1
#define BSP_QSPI_READ_CP_FLASH(buf, addr, size)    CPXIP_QSPI_Read(buf, addr, size)
#elif defined CHIP_EC718
#define BSP_QSPI_ENABLE_CP_FLASH()
#define BSP_QSPI_DISABLE_CP_FLASH()
#define BSP_QSPI_ERASE_CP_FLASH_32K(addr, size)    BSP_QSPI_Erase_Safe(addr, size)
#define BSP_QSPI_ERASE_CP_FLASH(addr, size)        BSP_QSPI_Erase_Safe(addr, size)
#define BSP_QSPI_WRITE_CP_FLASH(buf, addr, size)   BSP_QSPI_Write_Safe(buf, addr, size)
#define BSP_QSPI_READ_CP_FLASH(buf, addr, size)    BSP_QSPI_Read_Safe(buf, addr, size)
#endif

#endif


/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
extern uint8_t  BSP_QSPI_Erase_Sector_Safe(uint32_t SectorAddress);
extern uint8_t  BSP_QSPI_Erase_32KBlk_Safe(uint32_t BlockAddress);
extern uint8_t  BSP_QSPI_Erase_Sector(uint32_t SectorAddress);
extern uint8_t  BSP_QSPI_Erase_Block(uint32_t BlockAddress);
extern uint8_t  BSP_QSPI_Write(uint8_t* pData, uint32_t WriteAddr, uint32_t Size);
extern uint8_t  BSP_QSPI_XIP_Read(uint8_t* pData, uint32_t ReadAddr, uint32_t Size);
//extern uint32_t ImageGeneralRead(uint8_t *pData,uint32_t ReadAddr, uint32_t Size);

extern void     CPXIP_Enable(void);
extern void     CPXIP_DeInit(void);
extern uint8_t  CPXIP_QSPI_Erase_32Kblk(uint32_t SectorAddress);
extern uint8_t  CPXIP_QSPI_Erase_Sector(uint32_t SectorAddress);
extern uint8_t  CPXIP_QSPI_Write(uint8_t* pData, uint32_t WriteAddr, uint32_t Size);
extern uint32_t CPXIP_QSPI_Read(uint8_t *pData,uint32_t ReadAddr, uint32_t Size);


#ifdef __cplusplus
}
#endif
#endif

