/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    nvram_flash.h
 * Description:  EC618 NVRAM header file
 * History:      11/29/2017    Originated by cheng fang
 *
 ****************************************************************************/

#ifndef _NVRAM_FLASH_H
#define _NVRAM_FLASH_H

#ifdef __cplusplus
 extern "C" {
#endif

#ifndef WIN32

#if (defined CHIP_EC618)
#define nvram_flash_init()	HAL_QSPI_Init()
#define nvram_flash_earse(a)	BSP_QSPI_Erase_Safe(a, 0x1000)
#define nvram_flash_write(a,b,c) BSP_QSPI_Write_Safe(a,b,c)
#define nvram_flash_earse_raw(a)	BSP_QSPI_Erase_Sector(a)
#define nvram_flash_write_raw(a,b,c) BSP_QSPI_Write(a,b,c)
#define nvram_flash_read(a,b,c) BSP_QSPI_Read_Safe(a,b,c)
#define cp_nvram_flash_init()	CPXIP_QSPI_Init()
#define cp_nvram_flash_earse(a)	CPXIP_QSPI_Erase_Sector(a)
#define cp_nvram_flash_write(a,b,c) CPXIP_QSPI_Write(a,b,c)
#define cp_nvram_flash_earse_raw(a)	CPXIP_QSPI_Erase_Sector(a)
#define cp_nvram_flash_write_raw(a,b,c) CPXIP_QSPI_Write(a,b,c)
#elif (defined CHIP_EC718)
#define nvram_flash_earse(a)	FLASH_eraseSafe(a, 0x1000)
#define nvram_flash_write(a,b,c) FLASH_writeSafe(a,b,c)
#define nvram_flash_earse_raw(a)	FLASH_eraseSector(a)
#define nvram_flash_write_raw(a,b,c) FLASH_write(a,b,c)
#define nvram_flash_read(a,b,c) FLASH_readSafe(a,b,c)
#define cp_nvram_flash_earse(a) FLASH_eraseSector(a)
#define cp_nvram_flash_write(a,b,c) FLASH_write(a,b,c)

#endif

#else
#include "ramflash.h"
#define nvram_flash_init() init_ramflash()
#define nvram_flash_earse(a) ramflash_erase(a)
#define nvram_flash_write(a,b,c) ramflash_write(a,b,c)
#define nvram_flash_earse_raw(a)	ramflash_erase(a)
#define nvram_flash_write_raw(a,b,c) ramflash_write(a,b,c)
#define nvram_flash_read(a,b,c) ramflash_read(a,b,c)
#endif

#ifdef __cplusplus
}
#endif

#endif /* _NVRAM_FLASH_H */
