/****************************************************************************
 *
 * Copy right:   2020-, Copyrigths of AirM2M Ltd.
 * File name:    eepRom.h
 * Description:  EC618 eepRom driver file
 * History:      Rev1.0   2020-12-17
 *
 ****************************************************************************/

#ifndef _EEPROM_EC618_H
#define _EEPROM_EC618_H

#include "ec618.h"
#include "Driver_Common.h"
#include "oneWire.h"

/**
  \addtogroup eepRom_interface_gr
  \{
 */

/*******************************************************************************
 * Definitions
 ******************************************************************************/



/*******************************************************************************
 * API
 ******************************************************************************/

 #ifdef __cplusplus
 extern "C" {
#endif


/** \brief ROM Operation Command */
#define ROM_READ_CMD                0x33
#define ROM_MATCH_CMD               0x55
#define ROM_SKIP_CMD                0xCC
#define ROM_SEARCH_CMD              0xF0

/** \brief Memory Operation Command */
#define MEM_READ_CMD                0xF0
#define SCRATCHPAD_READ_CMD         0xAA
#define SCRATCHPAD_WRITE_CMD        0x0F
#define SCRATCHPAD_COPY_CMD         0x55

/** \brief EEPROM Status */
#define EEPROMDRV_OK                    (0)
#define EEPROMDRV_RESET_ERR             (-1)
#define EEPROMDRV_RESETPD_ERR           (-2)
#define EEPROMDRV_ROMREAD_ERR           (-3)
#define EEPROMDRV_ROMMATCH_ERR          (-4)
#define EEPROMDRV_ROMSKIP_ERR           (-5)
#define EEPROMDRV_ROMSEARCH_ERR         (-6)
#define EEPROMDRV_MEMREAD_ERR           (-7)
#define EEPROMDRV_SCRATCHPADREAD_ERR    (-8)
#define EEPROMDRV_SCRATCHPADWRITE_ERR   (-9)
#define EEPROMDRV_SCRATCHPADCOPY_ERR    (-10)

/**
  \fn        int32_t eePromReadRom(uint8_t* romCode)
  \brief     EEPROM read ROM code
  \param[out] romCode     ROM infomation read back.
  \return  read ROM status
 */
int32_t eePromReadRom(uint8_t* romCode);

/**
  \fn        eePromReadMem(uint8_t targetAddr, uint8_t len, uint8_t* buffer)
  \brief     EEPROM read memory.
  \param[in] targetAddr     The target address of EEPROM.
  \param[in] len     Length of this read.
  \param[out] buffer     Data read back.
  \return  read memory status
 */
int32_t eePromReadMem(uint8_t targetAddr, uint8_t len, uint8_t* buffer);

/**
  \fn        int32_t eePromWriteMem(uint8_t targetAddr, uint8_t len, uint8_t* buffer)
  \brief     EEPROM write memory
  \param[in] targetAddr     The target address of EEPROM.
  \param[in] len     Length of this write.
  \param[in] buffer     Data needs to write into memory.
  \return  Write memory status
 */
int32_t eePromWriteMem(uint8_t targetAddr, uint8_t len, uint8_t* buffer);

void eepRomInit(OwModeSel_e mode);

#ifdef __cplusplus
}
#endif

#endif
