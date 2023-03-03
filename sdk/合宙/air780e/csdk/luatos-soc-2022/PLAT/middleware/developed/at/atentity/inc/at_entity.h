/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: at_entity.h
 *
 *  Description: Entracne of AT CMD
 *
 *  History:
 *
 *  Notes:
 *
******************************************************************************/

#ifndef __AT_ENTITY_H__
#define __AT_ENTITY_H__
#include "osasys.h"
#include "atc_decoder.h"

/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/


/******************************************************************************
 *****************************************************************************
 * ENUM
 *****************************************************************************
******************************************************************************/

/*
 * AT APP to process the "SIG_CMS_APPL_CNF" signal
*/
typedef void (*AtProcApplCnfFunc)(CmsApplCnf *pApplCnf);

typedef struct AtApplCnfFuncTable_Tag
{
    UINT32  appId;
    AtProcApplCnfFunc   applCnfFunc;
}AtApplCnfFuncTable;

/*
 * AT APP to process the "SIG_CMS_APPL_IND" signal
*/
typedef void (*AtProcApplIndFunc)(CmsApplInd *pApplInd);

typedef struct AtApplIndFuncTable_Tag
{
    UINT32  appId;
    AtProcApplIndFunc   applIndFunc;
}AtApplIndFuncTable;


/******************************************************************************
 *****************************************************************************
 * API
 *****************************************************************************
******************************************************************************/

/*
 * process signal
*/
void atProcSignal(const SignalBuf *pSig);

/*
 * AT module init
*/
void atInit(void);

#endif

