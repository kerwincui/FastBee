/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: ec_misc_api.h
 *
 *  Description:
 *
 *  History:
 *
 *  Notes:
 *
******************************************************************************/
#ifndef __EC_MISC_API_H__
#define __EC_MISC_API_H__

#include "cms_util.h"

#define PRODMODE_ENTER_FLAG           (0x1)
#define PRODMODE_EXIT_FLAG            (0x2)

/**
  \fn           void npiSetProdModeEnterFlag(void)
  \brief        Set prodMode enter flag
  \returns      void
*/
void npiSetProdModeEnterFlag(void);

/**
  \fn           void npiSetProdModeExitFlag(void)
  \brief        Set prodMode exit flag
  \returns      void
*/
void npiSetProdModeExitFlag(void);

/**
  \fn           bool npiIsProdModeOngoing(void)
  \brief        Check if prodMode is ongoing
  \returns      void
*/
bool npiIsProdModeOngoing(void);

/**
  \fn           int32_t npiCheckProdMode(uint32_t timeout_ms)
  \brief        This function will first check if prodMode is enabled, if yes, it'll keep blocking unitl prodMode enter flag is set in given timeout_ms time.
  \returns      osOK if no error happens, otherwise error code, such as osFlagsErrorTimeout
*/
int32_t npiCheckProdMode(uint32_t timeout_ms);

/**
  \fn           void npiClearProdMode(void)
  \brief        Clear prodMode Enable flag
  \returns      void
*/
void npiClearProdMode(void);
#endif

