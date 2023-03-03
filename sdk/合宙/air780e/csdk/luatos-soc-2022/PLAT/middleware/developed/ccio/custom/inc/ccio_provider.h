/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: ccio_provider.h
*
*  Description:
*
*  History: 2021/1/19 created by xuwang
*
*  Notes:
*
******************************************************************************/
#ifndef CCIO_PROVIDER_H
#define CCIO_PROVIDER_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include "ccio_base.h"
#include "ccio_misc.h"


#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/

/**
 * The size of a ring buffer malloced actually.
 * CCIO_RBUF_XTRA_SIZE is used only when the data is splitted
 * into two blocks and not cycled in the ring.
*/
#define CCIO_RBUF_REAL_SIZE(sz)  ((sz) + CCIO_RBUF_XTRA_SIZE)
#ifdef __USER_CODE__
#define DIAG_RBUF_REAL_SIZE       CCIO_RBUF_REAL_SIZE(CCIO_BUF_SIZE_128)
#define ATOSN_RBUF_REAL_SIZE      CCIO_RBUF_REAL_SIZE(CCIO_BUF_SIZE_2K)  /* Normal atos */
#define ATOSC_RBUF_REAL_SIZE      CCIO_RBUF_REAL_SIZE(CCIO_BUF_SIZE_8)  /* atos for rf calibration */
#define PPPOS_RBUF_REAL_SIZE      CCIO_RBUF_REAL_SIZE(CCIO_BUF_SIZE_2K)
#define OPAQOS_RBUF_REAL_SIZE     CCIO_RBUF_REAL_SIZE(CCIO_BUF_SIZE_8)  /* opaque or raw data */
#define ETHER_RBUF_REAL_SIZE      CCIO_RBUF_REAL_SIZE(CCIO_BUF_SIZE_16K)
#else
#define DIAG_RBUF_REAL_SIZE       CCIO_RBUF_REAL_SIZE(CCIO_BUF_SIZE_128)
#define ATOSN_RBUF_REAL_SIZE      CCIO_RBUF_REAL_SIZE(CCIO_BUF_SIZE_4K)  /* Normal atos */
#define ATOSC_RBUF_REAL_SIZE      CCIO_RBUF_REAL_SIZE(CCIO_BUF_SIZE_8K)  /* atos for rf calibration */
#define PPPOS_RBUF_REAL_SIZE      CCIO_RBUF_REAL_SIZE(CCIO_BUF_SIZE_8K)
#define OPAQOS_RBUF_REAL_SIZE     CCIO_RBUF_REAL_SIZE(CCIO_BUF_SIZE_4K)  /* opaque or raw data */
#define ETHER_RBUF_REAL_SIZE      CCIO_RBUF_REAL_SIZE(CCIO_BUF_SIZE_16K)
#endif
#define RNDIS_RBUF_REAL_SIZE      ETHER_RBUF_REAL_SIZE
#define ECM_RBUF_REAL_SIZE        ETHER_RBUF_REAL_SIZE

#define DIAG_RBUF_AVLB_THRES      CCIO_BUF_SIZE_32
#define ATOS_RBUF_AVLB_THRES      1600 /* ceiling of ETH MTU */
#define PPPOS_RBUF_AVLB_THRES     1600
#define OPAQOS_RBUF_AVLB_THRES    1600
#define RNDIS_RBUF_AVLB_THRES    (CCIO_RNDIS_XFER_MAXSIZE + CCIO_RBUF_NPT_HDR_SIZE * (CCIO_RNDIS_MAX_PKT_PER_XFER + 1))
#define ECM_RBUF_AVLB_THRES       1600

/**
 * cycle ctrl tail size of rbuf,
 * determining when writeIdx is started from the beginning.
*/
#define USB_RBUF_PT_CCT_SIZE      0
#define USB_RBUF_NPT_CCT_SIZE     CCIO_RBUF_NPT_HDR_SIZE
#define UART_RBUF_CCT_SIZE        0

/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/

typedef struct
{
    void    *chent;
    void    *respArgs;  //passed in atRespFunc/atRespPduFunc
}CcioAtCmdCtx_t;

/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

/**
  \fn     void ccioInitAtServProvider(CcioDevice_t *chdev, uint8_t isForPpp)
  \brief  init AT service provider
  \return
*/
void ccioInitAtServProvider(CcioDevice_t *chdev, uint8_t isForPpp);

/**
  \fn     void ccioDeinitAtServProvider(CcioEntity_t *chent, uint8_t isForPpp)
  \brief  deinit AT service provider
  \return
*/
void ccioDeinitAtServProvider(CcioEntity_t *chent, uint8_t isForPpp);

/**
  \fn     void ccioInitDiagServProvider(CcioDevice_t *chdev)
  \brief  init diag service provider
  \return
*/
void ccioInitDiagServProvider(CcioDevice_t *chdev);

/**
  \fn     void ccioDeinitDiagServProvider(CcioEntity_t *chent)
  \brief  deinit diag service provider
  \return
*/
void ccioDeinitDiagServProvider(CcioEntity_t *chent);

/**
  \fn     void ccioInitOpaqServProvider(CcioDevice_t *chdev)
  \brief  init opaque service provider
  \return
*/
void ccioInitOpaqServProvider(CcioDevice_t *chdev);

/**
  \fn     void ccioDeinitOpaqServProvider(CcioEntity_t *chent)
  \brief  deinit opaque service provider
  \return
*/
void ccioDeinitOpaqServProvider(CcioEntity_t *chent);

/**
  \fn     void ccioInitRndisServProvider(CcioDevice_t *chdev)
  \brief  init rndis service provider
  \return
*/
void ccioInitRndisServProvider(CcioDevice_t *chdev);

/**
  \fn     void ccioDeinitRndisServProvider(CcioEntity_t *chent)
  \brief  deinit rndis service provider
  \return
*/
void ccioDeinitRndisServProvider(CcioEntity_t *chent);

/**
  \fn     void ccioInitEcmServProvider(CcioDevice_t *chdev)
  \brief  init ecm service provider
  \return
*/
void ccioInitEcmServProvider(CcioDevice_t *chdev);

/**
  \fn     void ccioDeinitEcmServProvider(CcioEntity_t *chent)
  \brief  deinit ecm service provider
  \return
*/
void ccioDeinitEcmServProvider(CcioEntity_t *chent);

/**
  \fn     void ccioInitEutraServProvider(CcioDevice_t *chdev)
  \brief  init eutra service provider
  \return
*/
void ccioInitEutraServProvider(CcioDevice_t *chdev);

/**
  \fn     void ccioDeinitEutraServProvider(CcioEntity_t *chent)
  \brief  deinit eutra service provider
  \return
*/
void ccioDeinitEutraServProvider(CcioEntity_t *chent);

/**
  \fn     void* ccioPreGetDeviceRbuf(CcioRbufUsage_e rbUsage, uint8_t hwtype, uint8_t llsn, CcioRbufXtras_t *rbXtras)
  \brief  get the rbuf of a certain device in advance
  \return void*
*/
void* ccioPreGetDeviceRbuf(CcioRbufUsage_e rbUsage, uint8_t hwtype, uint8_t llsn, CcioRbufXtras_t *rbXtras);

/**
  \fn     void ccioPreUngetDeviceRbuf(CcioRbufUsage_e rbUsage, uint8_t* rbuf)
  \brief  get the rbuf of related provider
  \return
*/
void ccioPreUngetDeviceRbuf(CcioRbufUsage_e rbUsage, uint8_t* rbuf);

/**
  \fn     void* ccioGetProviderRbuf(CcioRbufUsage_e rbUsage, uint16_t chanId, CcioRbufXtras_t *rbXtras)
  \brief  get the rbuf of related provider
  \return void*
*/
void* ccioGetProviderRbuf(CcioRbufUsage_e rbUsage, uint16_t chanId, CcioRbufXtras_t *rbXtras);

/**
  \fn     void ccioUngetProviderRbuf(CcioRbufUsage_e rbUsage, uint8_t* rbuf)
  \brief  get the rbuf of related provider
  \return
*/
void ccioUngetProviderRbuf(CcioRbufUsage_e rbUsage, uint8_t* rbuf);

/**
  \fn     uint16_t ccioGetRbufCctSize(uint8_t hwType, CcioDevHwAcm_e bmHwAcm, CcioRbufUsage_e rbUsage)
  \brief  get the cct size of the rbuf
  \return void*
*/
uint16_t ccioGetRbufCctSize(uint8_t hwType, CcioDevHwAcm_e bmHwAcm, CcioRbufUsage_e rbUsage);

/**
  \fn     uint8_t ccioIsMultiLanDevEnabled(void)
  \brief  enable single or multiple devices
  \return uint8_t
*/
uint8_t ccioIsMultiLanDevEnabled(void);


#ifdef __cplusplus
}
#endif
#endif

