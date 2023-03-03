/****************************************************************************
 *
 * Copy right:   2020-, Copyrigths of AirM2M Ltd.
 * File name:    oneWire.h
 * Description:  EC618 one wire bus driver file
 * History:      Rev1.0   2020-12-17
 *
 ****************************************************************************/

#ifndef _ONEWIRE_EC618_H
#define _ONEWIRE_EC618_H

#include "ec618.h"
#include "Driver_Common.h"

/**
  \addtogroup onewire_interface_gr
  \{
 */

/*******************************************************************************
 * Definitions
 ******************************************************************************/ 
    
/** \brief OW Mode Select */
typedef enum
{
    STANDARD = 0,   /**< Stand speed of onewire */
    OVERDRIVE       /**< High speed of onewire */
}OwModeSel_e;

/** \brief OW Status */
typedef enum
{
    OW_IDLE             = 0x0,
    OW_RESET_SUCCESS    = 0x2,
    OW_RESETPD_SUCCESS  = 0x4,
    OW_READ_SUCCESS     = 0x8,
    OW_WRITE_SUCCESS    = 0x10,
    OW_TIMEOUT          = 0x20,
}OwStats_e;

typedef struct
{
    uint8_t *dataWrite;
    uint8_t *dataRead;
    uint8_t mode;
}OwRes_t;

#define OWDRV_OK                (0)
#define OWDRV_RESET_ERR         (-1)
#define OWDRV_RESETPD_ERR       (-2)
#define OWDRV_READ_ERR          (-3)
#define OWDRV_WRITE_ERR         (-4)
#define OWDRV_TIMEOUT           (-5)


/*******************************************************************************
 * API
 ******************************************************************************/
#ifdef __cplusplus
         extern "C" {
#endif

/**
  \fn        void owInit()
  \brief     Initialize ow
 */
void owInit(void);

/**
  \fn        void owDeInit()
  \brief     DeInitialize ow
 */
void owDeInit(void);


/**
  \fn        void owSetMode(OwModeSel_e mode)
  \brief     ow set mode
  \param[in] mode     ow mode
 */
void owSetMode(OwModeSel_e mode);

/**
  \fn        int32_t owReset()
  \brief     ow reset
 \return  ow reset status
 */
int32_t owReset(void);

/**
  \fn        int32_t owResetPd()
  \brief     ow reset for presence detect
  \return  ow reset presence detect status
 */
int32_t owResetPd(void);

/**
  \fn        int32_t owWriteBit(uint8_t data)
  \brief     write 1bit data to ow
  \param[in] data     data to write to ow, LSB is effective
  \return  ow write 1 bit status
 */
int32_t owWriteBit(uint8_t data);

/**
  \fn        int32_t owWriteByte(uint8_t data)
  \brief     write 1byte data to ow
  \param[in] data     1 byte data to write to ow
  \return  ow write 1 byte status
 */
int32_t owWriteByte(uint8_t data);

/**
  \fn        int32_t owReadBit()
  \brief     read 1bit data
  \return  ow read 1 bit status
 */
int32_t owReadBit(uint8_t * dataRead);

/**
  \fn        int32_t owReadByte()
  \brief     ow read 1 byte
  \return  ow read 1 byte status
 */
int32_t owReadByte(uint8_t * dataRead);

/**
  \fn        int32_t owTouchByte(uint8_t data)
  \brief     read and write ow at the same time
  \return  ow touch 1 byte status
 */
int32_t owTouchByte(uint8_t data);

/** \} */


#ifdef __cplusplus
}
#endif

#endif
