/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename:hal_dumpMedia.h
*
*  Description: used to provid adapt API for ram dump
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef HAL_DUMPMEDIA_H
#define HAL_DUMPMEDIA_H

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
  \fn        eehDumpMediaInit( void )
  \brief     used to init dump media for eeh dump, map to UART or USB
  \note      only called in eeh dump procedure
*/
void eehDumpMediaInit( void );



/**
  \fn        eehDumpMediaFlush(uint32_t instance)
  \brief     used to flush FIFO, only valid for UART now
  \param[in] instance UART instance
  \note      only called in eeh dump procedure
*/
void eehDumpMediaFlush(uint32_t instance);

/**
  \fn        eehDumpMediaPurgeRx(uint32_t instance)
  \brief     used to flush FIFO, only valid for UART now
  \param[in] instance UART instance
  \note      only called in eeh dump procedure
*/
void eehDumpMediaPurgeRx(uint32_t instance);

/**
  \fn        eehDumpMediaRecv(uint32_t instance, uint8_t *data, uint32_t num, uint32_t timeout_us)
  \brief     used to recv data from host via polling, uldp is still involved
  \param[in] instance    ep number or uart instance for recv
  \param[in] data        data pointer to store recv data
  \param[in] num         recv data length
  \param[in] timeout_us  timeout value when nothing recv
  \note      only called in eeh dump procedure
 */
uint32_t eehDumpMediaRecv(uint32_t instance, uint8_t *data, uint32_t num, uint32_t timeout_us);



/**
  \fn        eehDumpMediaSend(uint32_t instance, uint8_t *data, uint32_t num, uint32_t timeout_us)
  \brief     used to recv data from host via polling, uldp is still involved
  \param[in] instance    ep number or uart instance for recv
  \param[in] data        data pointer to send
  \param[in] num         send data length
  \param[in] timeout_us  timeout value when nothing recv
  \note      only called in eeh dump procedure
 */
uint32_t eehDumpMediaSend(uint32_t instance, uint8_t *data, uint32_t num, uint32_t timeout_us);



/**
  \fn        eehDumpMediaPollingEp0(uint32_t loopCnt, uint32_t loopInr)
  \brief     polling EP0 ctrl info and handle it, e.g. VCOM open
  \param[in] loopCnt       how many loop times
  \param[in] loopInr  internalval for each loop
  \note      only called in eeh dump procedure
 */
void eehDumpMediaPollingEp0(uint32_t loopCnt, uint32_t loopInr);



/**
  \fn        eehDumpMediaPollingRndisHalt(uint32_t loopCnt, uint32_t loopInr)
  \brief     request rndis halt to host, need polling send sucesss or timeout
  \param[in] loopCnt       how many loop times
  \param[in] loopInr  internalval for each loop
  \note      only called in eeh dump procedure
 */
int32_t eehDumpMediaPollingRndisHalt(uint32_t loopCnt, uint32_t loopInr);




#ifdef __cplusplus
}
#endif

#endif
