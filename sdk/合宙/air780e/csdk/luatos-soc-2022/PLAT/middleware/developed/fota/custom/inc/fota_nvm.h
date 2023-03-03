/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: fota_nvm.h
*
*  Description:
*
*  History: 2021/10/24 created by xuwang
*
*  Notes:
*
******************************************************************************/
#ifndef FOTA_NVM_H
#define FOTA_NVM_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/

#include "fota_pub.h"

#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/
/* will file system is enabled? */
//#define FOTA_NVM_FS_ENABLE

#define fotaNvmClearDelta(offset, len)       fotaNvmClear(FOTA_NVM_ZONE_DELTA, offset, len)
#define fotaNvmWriteDelta(offset, buf, len)  fotaNvmWrite(FOTA_NVM_ZONE_DELTA, offset, buf, len)
#define fotaNvmReadDelta(offset, buf, len)   fotaNvmRead(FOTA_NVM_ZONE_DELTA, offset, buf, len)
#define fotaNvmGetDeltaSize(exclOvhd)        fotaNvmGetSize(FOTA_NVM_ZONE_DELTA, exclOvhd)

/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

/**
 * @brief fotaNvmInit(void)
 * @details init fota nvm region
 *
 * @return 0 succ; < 0 failure with errno.
 */
int32_t fotaNvmInit(void);

/**
 * @brief fotaNvmDeinit(void)
 * @details deinit fota nvm region
 *
 * @return 0 succ; < 0 failure with errno.
 */
int32_t fotaNvmDeinit(void);

/**
 * @brief fotaNvmClear(uint32_t zid, uint32_t offset, uint32_t len)
 * @details clear fota nvm
 *
 * @param zid     zone Id of fota nvm
 * @param offset  offset to starting address
 * @param len     size of the nvm to be cleared
 * @return 0 succ; < 0 failure with errno.
 */
int32_t fotaNvmClear(uint32_t zid, uint32_t offset, uint32_t len);

/**
 * @brief fotaNvmWrite(uint32_t zid, uint32_t offset, uint8_t *buf, uint32_t bufLen)
 * @details write the content to fota nvm
 *
 * @param zid     zone Id of fota nvm
 * @param offset  offset to starting address
 * @param buf     buffer to be written from
 * @param bufLen  size of the buffer to be written from
 * @return 0 succ; < 0 failure with errno.
 */
int32_t fotaNvmWrite(uint32_t zid, uint32_t offset, uint8_t *buf, uint32_t bufLen);

/**
 * @brief fotaNvmRead(uint32_t zid, uint32_t offset, uint8_t *buf, uint32_t bufLen)
 * @details read the content from fota nvm
 *
 * @param zid     zone Id of fota nvm
 * @param offset  offset to starting address
 * @param buf     buffer to be read into
 * @param bufLen  size of the buffer to be read into
 * @return 0 succ; < 0 failure with errno.
 */
int32_t fotaNvmRead(uint32_t zid, uint32_t offset, uint8_t *buf, uint32_t bufLen);

/**
 * @brief fotaNvmGetSize(uint32_t zid, uint8_t isOvhdExcl)
 * @details get the nvm size of specific fota zone
 *
 * @param zid     zone Id of fota nvm
 * @param isOvhdExcl  overhead size of the zone is excluded or not
 * @return !0 succ; 0 failure.
 */
uint32_t fotaNvmGetSize(uint32_t zid, uint8_t isOvhdExcl);

/**
 * @brief fotaNvmGetHandle(uint32_t zid)
 * @details get the nvm handle(addr or fd) of specific fota zone
 *
 * @param zid     zone Id of fota nvm
 * @return !0 succ; 0 failure.
 */
int32_t fotaNvmGetHandle(uint32_t zid);

/**
 * @brief fotaNvmGetExtras(uint32_t zid)
 * @details get the nvm extras(xip addr or etc) of specific fota zone
 *
 * @param zid     zone Id of fota nvm
 * @return !0 succ; 0 failure.
 */
int32_t fotaNvmGetExtras(uint32_t zid);

/**
 * @brief fotaNvmDoExtension(uint32_t flags, void *args)
 * @details externsion api
 *
 * @param flags   FotaNvmDoExtFlags_e
 * @param args    arguements of flags
 * @return 0 succ; < 0 failure with errno.
 */
int32_t fotaNvmDoExtension(uint32_t flags, void *args);

#ifdef __cplusplus
}
#endif
#endif

