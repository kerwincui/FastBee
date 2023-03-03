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
#ifndef HAL_PHY_H
#define HAL_PHY_H

#include "commontypedef.h"

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/


#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/





/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/




/**
  \fn           void Phy2ApPlatSignalProc(UINT16 sigId)
  \brief        handle phy to plat ipc signal
  \param[in]    sigId
  \returns      void
*/
void Phy2ApPlatSignalProc(UINT16 sigId, void *msgBdyPtr);

/**
  \fn           void halPhyGetDebugModule(CHAR *strName, UINT8 *phyModule)
  \brief        STRING -> PHY debug module ID
  \returns      BOOL
*/
BOOL halPhyGetDebugModule(CHAR *strName, UINT8 *phyModule);

/**
  \fn           INT32 halPhySetDebugCfgInfo(UINT16 atHandle, UINT32 phyModId, INT32 *pCfgParams, UINT8 paramNum)
  \brief        Set PHY debug config
  \returns      INT32   // 0 - succ, < 0 fail
*/
INT32 halPhySetDebugCfgInfo(UINT16 atHandle, UINT32 phyModId, INT32 *pCfgParams, UINT8 paramNum);

/**
  \fn           void halPhyGetDebugAtStringInfo(CHAR *pAtRspBuf, UINT16 bufLen)
  \brief        print the PHY debug info
  \returns      void
*/
void halPhyGetDebugAtStringInfo(CHAR *pAtRspBuf, UINT16 bufLen);

#endif /* _HAL_PHY_H */

