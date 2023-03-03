#ifndef __PS_DIAL_PAGING_BOOT_H__
#define __PS_DIAL_PAGING_BOOT_H__
/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017- Copyrights of AirM2M Ltd.
 File name:      - psdial_paging_boot.h
 Description:    - PS paging boot header, control paging/measurement wake up procedure
 History:        - 2021/06/02, Originated by Jason
 ******************************************************************************
******************************************************************************/

#include "commontypedef.h"
#include "osasig.h"

/******************************************************************************
 *****************************************************************************
 * MACRO/ENUM
 *****************************************************************************
******************************************************************************/





/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/*
 * SIG_CMS_CP_PAGING_EVENT_IND_ISR
*/
typedef struct CmsCpPagingEventIndIsr
{
    UINT8   eventId;        //CpPagingImgEventId
    UINT8   rsvd;
    UINT16  eventSize;      //event body/buffer size

    void    *pEvent;        /* event body/buffer, !!! not need to free, as using global memory !!!  */
}CmsCpPagingEventIndIsr;    // 8 bytes




/******************************************************************************
 *****************************************************************************
 * CMS EXTERNAL API
 *****************************************************************************
******************************************************************************/

/**
  \fn           void psDialPagingImgInfoInit(void)
  \brief        init "pagingImgInfo" context
  \returns      void
  \Note: a) called in ec_main() before AP start paging image,
  \      b) can not be to re-called when boot from AP paging image to AP full image
*/
void psDialPagingImgInfoInit(void);

/**
  \fn           BOOL psDialPagingImgProcCpEventIsr(UINT8 eventId, void *pEvent, UINT16 eventSize)
  \brief        API called by AP paging image, to process CP/PHY paging event
  \param[in]    eventID     CpPagingImgEventId
  \param[in]    pEvent      event buffer/body, using AP/CP share global memory, !!! NOT need to free !!!
  \param[in]    eventSize   event buffer/body size in bytes
  \returns      BOOL
  \Note: a) return TRUE, caller must wake up to AP big image
  \      b) should only be called in ISR (IPC0)
*/
CpPagingImgEventRet psDialPagingImgProcCpEventIsr(UINT8 eventId, void *pEvent, UINT16 eventSize);


/**
  \fn           void psDialWakeupCheckPagingEvent(void)
  \brief        check whether any paging event is set in AP paging image
  \returns      void
  \Note: a) called when CMS task start/init.
  \      b) if CP paging event need to wake up AP big image, when AP big image wake up
  \         (CMS task created), check any paging event
*/
void psDialWakeupCheckPagingEvent(void);

/**
  \fn           void psDialProcCpPagingEventIndIsrSig(CmsCpPagingEventIndIsr *pCpEventIsr)
  \brief        proc "SIG_CMS_CP_PAGING_EVENT_IND_ISR" signal
  \returns      void
  \Note: a) if CMS task already created, CP paging event don't processed in ISR, just forward
  \         this signal to CMS task
*/
void psDialProcCpPagingEventIndIsrSig(CmsCpPagingEventIndIsr *pCpEventIsr);



#endif

