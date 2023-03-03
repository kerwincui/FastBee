/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    ps_event_callback.h
 * Description:  API interface implementation header file for event callback service
 * History:      Rev1.0   2018-10-12
 *
 ****************************************************************************/
#ifndef __PS_EVENT_CALLBACK_H__
#define __PS_EVENT_CALLBACK_H__
#include "cmicomm.h"
#include "cms_api.h"
#include "ostask.h"

/**
  \addtogroup psEventCallback_typedef Typedef
  \{
 */
/*******************************************************************************
 * Definitions
 ******************************************************************************/

/** \brief List of the event IDs for URC */
typedef enum
{
    PS_URC_ID_START = 0,      /**< URC event ID for command +CREG*/

    PS_URC_GROUP_DEV = (CAM_DEV << 12), //0x2000

    PS_URC_GROUP_MM = (CAM_MM << 12),   //0x3000
    PS_URC_ID_MM_SIGQ,
    PS_URC_ID_MM_TAU_EXPIRED,
    PS_URC_ID_MM_BLOCK_STATE_CHANGED,
    PS_URC_ID_MM_CERES_CHANGED,
    PS_URC_ID_MM_NITZ_REPORT,
    PS_URC_ID_MM_PSM_STATE_CHANGED,

    PS_URC_GROUP_PS = (CAM_PS << 12),   //0x4000
    PS_URC_ID_PS_BEARER_ACTED,
    PS_URC_ID_PS_BEARER_DEACTED,
    PS_URC_ID_PS_CEREG_CHANGED,
    PS_URC_ID_PS_NETINFO,
    PS_URC_ID_PS_PKG_DATA_TRANS_STATE_CHANGED,

    PS_URC_GROUP_SIM = (CAM_SIM << 12), //0x5000
    PS_URC_ID_SIM_READY,      /**< SIM card is ready*/
    PS_URC_ID_SIM_REMOVED,    /**< SIM card is removed*/

    PS_URC_ID_END,            /**< End of the URC event ID enumeration*/
}PsEventID;

/*
 * which PS event group need to monitor
*/
typedef enum
{
    PS_GROUP_BASE_MASK = (0X01 << CAM_BASE),    //0x00000002
    PS_GROUP_DEV_MASK  = (0X01 << CAM_DEV),     //0x00000004
    PS_GROUP_MM_MASK   = (0X01 << CAM_MM),      //0x00000008
    PS_GROUP_PS_MASK   = (0X01 << CAM_PS),      //0x00000010
    PS_GROUP_SIM_MASK  = (0X01 << CAM_SIM),     //0x00000020
    PS_GROUP_SMS_MASK  = (0X01 << CAM_SMS),     //0x00000040
    PS_GROUP_ALL_MASK  = 0X7FFFFFFF
}PsEventGpMask;


typedef struct {
    UINT32 messageId;
    void *param;
}eventCallbackMessage_t;


/**
  \fn    INT32 (*psEventCallback_t)(PsEventID eventId, void *param, UINT32 paramLen)
  \brief A function pointer prototype for the URC event callback.
  \param[in] eventId    Event ID
  \param[in] param      Pointer to the data structure with URC parameters.
  \param[in] paramLen   Indicates the length of the URC parameters.
  \Note: this callback API running in CMS task, and can't be delayed too much in this API
 */
typedef INT32 (*psEventCallback_t)(PsEventID eventId, void *param, UINT32 paramLen);


/**
  \fn    CmsRetId registerPSEventCallback(UINT32 groupMask, psEventCallback_t callback)
  \brief Function to register certain PS event callback.
  \param[in] groupMask  Group mask.
  \param[in] callback   Callback function to be registered.
 */
CmsRetId registerPSEventCallback(PsEventGpMask groupMask, psEventCallback_t callback);

/**
  \fn    CmsRetId deregisterPSEventCallback(psEventCallback_t callback)
  \brief Function to deregister certain PS event callback.
 */
CmsRetId deregisterPSEventCallback(psEventCallback_t callback);

/**
  \fn    void PSTriggerEvent(PsEventID eventID, void *param, UINT32 paramLen)
  \brief Function to trigger certain PS event.
  \param[in] eventID  Event ID.
  \param[in] param    Parameter to be transfered.
  \param[in] paramLen Parameter length to be transfered.
 */
void PSTriggerEvent(PsEventID eventID, void *param, UINT32 paramLen);

/**
  \fn    void psCmiIndToAppEventTrigger(const SignalBuf *indSignalPtr)
  \brief Function to transfer indication to event trigger.
 */
void psCmiIndToAppEventTrigger(const SignalBuf *indSignalPtr);


/*
 \fn    void applIndToAppEventTrigger(CmsApplInd *pAppInd)
*/
void applIndToAppEventTrigger(CmsApplInd *pAppInd);

/*
 \fn    void psEventCallbackInit(void)
 \Called in main task, to init the PS event callback table
*/
void psEventCallbackInit(void);


#endif

