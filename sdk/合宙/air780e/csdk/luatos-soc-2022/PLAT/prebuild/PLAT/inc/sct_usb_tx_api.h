#ifndef __SCT_USB_TX_API_H__
#define __SCT_USB_TX_API_H__

/******************************************************************************
 ******************************************************************************
  Copy right:   2017-, Copyrigths of AirM2M Ltd.
  File name:    sct_usb_tx_api.h
  Description:  SCT PPP and CRC API, external provide to app
  History:      2020/12/02    Originated by Jason
 ******************************************************************************
******************************************************************************/
#include "pspdu.h"


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

typedef enum
{
    SCT_USB_TX_RET_OK   = 0,
    SCT_USB_TX_ERR      = -1,
    SCT_USB_TX_BUSY     = -2
}SctUsbTxRetEnum;

typedef INT32   SctUsbTxRet;


/*
 * USB Tx Block
*/
typedef DlPduBlock      SctUsbTxBlock;


/*
 * SCT USB ISR event
*/
typedef enum
{
    SCT_USB_DEINT   = 0,    /* when USB plug out, or suspended */
    SCT_USB_INIT    = 1,    /* USB is OK (EP enumed), and SCT could sent data to USBC TxFIFO, when USB plug in, or resumed */
    SCT_USB_RESET   = 2     /* USB is reseted, SCT USB channel should be reset, and wait USB init(OK) again. */
}SctUsbStateEvent;


/******************************************************************************
 *****************************************************************************
 * Functions
 *****************************************************************************
******************************************************************************/

#define SCT_USB_TX_EP_PARALLEL
#ifdef SCT_USB_TX_EP_PARALLEL


/*
 * SCT USB channel init config, and not enable EEA (Cipher) function.
*/
void SctUsbChanlInitConfig(BOOL timeOutInit);


/******************************************************************************
 * SctUsbTxRawDataNew
 * Description: SCT USB Tx raw data, without cipher/CRC/PPP operation.
 * input:   UINT32 epId     //USB EP ID < 16
 *          SctUsbTxBlock *pTxHead      //input, Tx block header
 *          SctUsbTxBlock *pTxTail      //input, Tx block header
 *          BOOL          allowConcatenated     //input, whether allow serveral PDU Tx in one USB transfer
 * output:  SctUsbTxRet
 * Comment:
 * 1> As the MAX USB Tx transfer size is limited, Tx block maybe can't transmit one time
 *    then, "pRetHead" will return the next not transmited block header
 * 2> This API return OK, just means block inserted into SCT FIFO, not means already
 *    transmited to USB host, so the caller: !!! can't free the block memory !!!
 *    let the SCT responsible for freeing it after SCT done
 * 3> This API could only be called in USB TX task
 * 4> The caller don't need any handling after called this API
******************************************************************************/
SctUsbTxRet SctUsbTxRawDataNew(UINT32 epId, SctUsbTxBlock *pTxHead, SctUsbTxBlock *pTxTail, BOOL allowConcatenated);


/******************************************************************************
 * SctUsbTxPppDataNew
 * Description: SCT USB Tx raw data, data need PPP escaption.
 * input:   UINT32 epId     //USB EP ID < 16
 *          SctUsbTxBlock *pTxHead      //input, Tx block header
 *          SctUsbTxBlock *pTxTail      //input, Tx block header
 * output:  SctUsbTxRet
 * Comment:
 * 1> As the MAX USB Tx transfer size is limited, Tx block maybe can't transmit one time
 *    then, "pRetHead" will return the next not transmited block header
 * 2> This API return OK, just means block inserted into SCT FIFO, not means already
 *    transmited to USB host, so the caller: !!! can't free the block memory !!!
 *    let the SCT responsible for freeing it after SCT done
 * 3> This API could only be called in USB TX task
 * 4> The caller don't need any handling after called this API
******************************************************************************/
SctUsbTxRet SctUsbTxPppDataNew(UINT32 epId, SctUsbTxBlock *pTxHead, SctUsbTxBlock *pTxTail);

#else


/*
 * SCT USB channel init config, and not enable EEA (Cipher) function.
*/
//void SctUsbChanlInitConfig(void);

/******************************************************************************
 * SctUsbTxRawData
 * Description: SCT USB Tx raw data, without cipher/CRC/PPP operation.
 * input:   UINT32 epId     //USB EP ID < 16
 *          SctUsbTxBlock *pTxHdr   //input, Tx block header
 *          SctUsbTxBlock **pRetNext    //output, next not Tx block header
 * output:  SctUsbTxRet
 * Comment:
 * 1> As the MAX USB Tx transfer size is limited, Tx block maybe can't transmit one time
 *    then, "pRetNext" will return the next not transmited block header
 * 2> This API return OK, just means block inserted into SCT FIFO, not means already
 *    transmited to USB host, so the caller: !!! can't free the block memory !!!
 *    let the SCT responsible for freeing it after SCT done
 * 3> This API could only be called in USB TX task
******************************************************************************/
SctUsbTxRet SctUsbTxRawData(UINT32 epId, SctUsbTxBlock *pTxHdr, SctUsbTxBlock **pRetNext);


/******************************************************************************
 * SctUsbTxPppData
 * Description: SCT USB Tx raw data, data need PPP escaption.
 * input:   UINT32 epId     //USB EP ID < 16
 *          SctUsbTxBlock *pTxHdr   //input, Tx block header
 *          SctUsbTxBlock **pRetNext    //output, next not Tx block header
 * output:  SctUsbTxRet
 * Comment:
 * 1> As the MAX USB Tx transfer size is limited, Tx block maybe can't transmit one time
 *    then, "pRetNext" will return the next not transmited block header
 * 2> This API return OK, just means block inserted into SCT FIFO, not means already
 *    transmited to USB host, so the caller: !!! can't free the block memory !!!
 *    let the SCT responsible for freeing it after SCT done
 * 3> This API could only be called in USB TX task
 * 4> The header and tailer PPP flag: "7E" inserted in this API, don't need to fill in caller
******************************************************************************/
SctUsbTxRet SctUsbTxPppData(UINT32 epId, SctUsbTxBlock *pTxHdr, SctUsbTxBlock **pRetNext);
#endif

/******************************************************************************
 * SctUsbProcDoneChainInfo
 * Description: SCT USB process chain done info
 * input:   BOOL *pSctAvailable     //
 * output:  void
 * Comment:
 * 1> Called when USB Tx task scheduled
 * 2> if "pSctAvailable" return TRUE, just means SCT USB channel is available again
 *    and the caller could Tx data again
******************************************************************************/
void SctUsbProcDoneChainInfo(BOOL *pSctAvailable);

/******************************************************************************
 * SctUsbProcUsbEvent
 * Description: SCT USB process USB event notification
 * input:   SctUsbStateEvent usbState
 * output:  void
 * Comment:
 * 1> Called when USB Tx task when USB event signal/message received
******************************************************************************/
void SctUsbProcUsbEvent(SctUsbStateEvent usbEvent);

#ifdef SCT_USB_TX_EP_PARALLEL
/******************************************************************************
 * SctUsbProcTimerExpiry
 * Description: SCT USB retry timer expiry handling
 * input:   UINT32 tid
 * output:  void
 * Comment:  Called when CCIO Tx task
******************************************************************************/
void SctUsbProcTimerExpiry(UINT32 tid);

/*
 * SCT USB proc EP unblock signal, EP unblock now
*/
void SctUsbProcEpUnblock(UINT32 epId);
#endif

/******************************************************************************
 * SctUsbCtsBeAllowSend
 * Description: whether CTS(Clear to Send) signal (trigger in MCU side) allow UE
 *              to send data
 * input:   UINT32  epId
 *          BOOL    bAllow  //TRUE - allow to send, FALSE - not allow
 * output:  void
 * Comment:  Called in Tx task
 * 1> if virtual CTS signal is not allow to send data via current USB EP,
 *    current USB EP will be blocked 10 seconds waiting for CTS allow signal,
 *    data will be pended during this time
 * 2> if exceed 10 seconds, the pending data and following data are all discarded.
******************************************************************************/
void SctUsbCtsBeAllowSend(UINT32 epId, BOOL bAllow);


#endif

