#ifndef __PS_DIAL_PS_CTRL_H__
#define __PS_DIAL_PS_CTRL_H__
/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017- Copyrights of AirM2M Ltd.
 File name:      - psdial_ps_ctrl.h
 Description:    - PS control header
 History:        - 2021/04/19, Originated by Jason
 ******************************************************************************
******************************************************************************/
#include "commontypedef.h"
#include "cms_api.h"
#include "apmu_external.h"

/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/



/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/



/******************************************************************************
 ******************************************************************************
 * External global variable
 ******************************************************************************
******************************************************************************/



/******************************************************************************
 *****************************************************************************
 * Functions
 *****************************************************************************
******************************************************************************/

/*
 * CMS task callback, before UE enter HIB/Sleep2 state
 * This API should be called in IDLE task, before PMU decide to enter HIB/Sleep2 state, and task schedule already closed
*/
void psDialDeepSlpEnterCallBack(APSleepState lowPowerState);

/*
 * PS dial first power on, not wake up, called when CMS task started,
*/
void psDialFirstPowerOn(void);

/*
 * whether PS task is ready (created) to access
*/
BOOL psDialPsIsReady(void);

/*
 * start PS and wake up PS, after this API, PS will be ready to access
 *  this API, could only be called in CMS task
*/
void psDialStartPs(void);


/*
 * start PS, sync callback, called in API: void cmsStartPs(void)
*/
CmsRetId psDialStartPsSynCallback(UINT16 inputSize, void *pInput, UINT16 outputSize, void *pOutput);

/*
 * start PS, non-blocked callback, called in API: void cmsStartPsNonBlock(void)
*/
void psDialStartPsNonBlockCallback(UINT16 paramSize, void *pParam);

/*
 * AT+CGCONTRDP to get all default bearer context during wakeup procedure
*/
CmsRetId psDialGetAllCGCONTRDPParamDuringWakeup(UINT16 atHandle);

/*
 * AT+CEREG to get PS REG state
*/
CmsRetId psDialGetCEREGDuringWakeup(UINT16 atHandle);

/*
 * AT+CGSCONTRDP to get all dedicated bearer context during wakeup procedure
*/
CmsRetId psDialGetAllCGSCONTRDPDuringWakeup(UINT16 atHandle);

/*
 * AT+CGTFTRDP to get all activated TFT during wakeup procedure
*/
CmsRetId psDialGetAllCGTFTRDPDuringWakeup(UINT16 atHandle);

#endif

