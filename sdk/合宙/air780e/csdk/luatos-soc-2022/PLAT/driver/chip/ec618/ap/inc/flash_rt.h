/******************************************************************************

 *(C) Copyright 2018 AirM2M International Ltd.

 * All Rights Reserved

 ******************************************************************************
 *  Filename:flash_rt.h
 *
 *  Description:EC618 flash header file
 *
 *  History:
 *
 *  Notes:
 *
 ******************************************************************************/


#ifndef _FLASH_EC618_RT_H
#define _FLASH_EC618_RT_H
/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/

#ifdef __cplusplus
    extern "C" {
#endif

/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/

/* QSPI Error codes */
#define QSPI_OK            ((uint8_t)0x00)
#define QSPI_ERROR         ((uint8_t)0x01)
#define QSPI_BUSY          ((uint8_t)0x02)
#define QSPI_NOT_SUPPORTED ((uint8_t)0x04)
#define QSPI_SUSPENDED     ((uint8_t)0x08)

/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/
typedef enum
{
    QSPI_OP_ERASE = 0,
    QSPI_OP_WRITE,
}QSPI_OpType_e;


/**
  \brief       definition of the flash operation callback, register using BSP_QSPI_Reg_Operation_Cb
               call when flash erase and write happens. 
  \param[in]   result          the QSPI Error codes, listed above
  \param[in]   type            to indicate erase or write
  \param[in]   address         operation address
  \param[in]   size            operation size  
  \return      null
*/
typedef void (*BSP_QSPI_OperCallback_t)(uint8_t result, QSPI_OpType_e type, uint32_t address, uint32_t size);

/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

uint8_t BSP_QSPI_Cfg_Gran_Size(uint16_t WriteGranSize);
uint8_t BSP_QSPI_Erase_Safe(uint32_t SectorAddress, uint32_t Size);
uint8_t BSP_QSPI_Write_Safe(uint8_t* pData, uint32_t WriteAddr, uint32_t Size);
uint8_t BSP_QSPI_Read_Safe(uint8_t* pData, uint32_t WriteAddr, uint32_t Size);

/**
  \fn          void BSP_QSPI_Reg_Operation_Cb(BSP_QSPI_OperCallback_t cb);
  \brief       register a user callback to get flash operation info. No time consuming operation allowed in this callback.
*/
void BSP_QSPI_Reg_Operation_Cb(BSP_QSPI_OperCallback_t cb);

#ifdef __cplusplus
}
#endif

#endif
