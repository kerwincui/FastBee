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
#ifndef UTFC_H
#define UTFC_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include "ec618.h"

#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/

/*DEFINE UTFC return code*/

#define UTFC_RET_OK           (0)
#define UTFC_RET_ALREADY_EN  (-1)
#define UTFC_PARA_ERROR      (-2)
#define UTFC_NOT_INIT        (-3)
#define UTFC_RET_FAIL        (-4)
#define UTFC_EP_NOT_SUPPORT  (-5)


#define UTFC_REG_BASE        0x40060000

#define UTFC_CODE_BASE_ADDR  0x00400000


#define UTFC_MAX_IF_NUM          (5)// max 5 ifs, 5 code section, --ulg=4 resv 1

#define UTFC_INVALID_EP_NUM      (0xffffffff)


#define UTFC_REL_EP_MAGIC      (0xbcdb0000)

#define UTFC_NUM_OF_USB_CODE 0x03



//base addr for 3 code, same for all ep
#define UTFC_CFG_REG1_BASE_ADDR  (0x1A000000+0x908)
#define UTFC_CFG_REG2_BASE_ADDR  (0x1A000000+0x910)
#define UTFC_CFG_REG3_BASE_ADDR  (0x1A000000+0x900)

#define UTFC_CFG_REG1_VALUE 0x00000001
#define UTFC_CFG_REG2_VALUE 0x03
//bit25-22 txfnum bit21---16=0, bit15=1,USBActEP bit14:11=0, bit10:0 MPS=512=0x200*/
#define UTFC_CFG_REG3_VALUE (0x84088200)

//bit25-22 txfnum bit21---16=0, bit15=1,USBActEP bit14:11=0, bit10:0 MPS=64=0x040*/
#define UTFC_CFG_REG3_FS_VALUE (0x84088040)


//zi setting reg2 val, same for all ep, only for sct
#define UTFC_CFG_ZL_REG2_VALUE ((0x1<<19)|(0x0))//pakcnt=1,xfersize=0 for ZI packet

#define UTFC_ULG_CFG_REG2_VALUE ((0x1<<19)|(448))//pakcnt=1,xfersize=512-64

#define UTFC_ULG_CFG_REG2_FS_VALUE ((0x2<<19)|(96))//pakcnt=2,xfersize=96


#define UTFC_MAX_XFER_SIZE       (1024*64)//64k
#define UTFC_EP_MPS              (512)//may include from USB later
#define UTFC_EP_FS_MPS           (64)// may include from USB later






/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/



// temp define here, should be a common define for ALL EP according to usage
typedef enum
{
    UTFC_START_ADDR_SW= 0,
    UTFC_START_ADDR_HW
} UsbStartAddrSel_e;


// uta request source
typedef enum
{
    UTA_REQ_SRC_SW = 0,
    UTA_REQ_SRC_ULDP = 1,
    UTA_REQ_SRC_SCT = 2,
    UTA_REQ_SRC_ULG = 3,
    UTA_REQ_SRC_MAX
} UtaReqSrc_e;


// utfc code array
typedef enum
{
    UTFC_ULG_CODE = 0,
    UTFC_RNDIS_ZI_CODE = 1,
    UTFC_AT_ZI_CODE = 2,
    UTFC_PPP_ZI_CODE = 3,
    UTFC_CODE_MAX
} UtfcCfgCode_e;


// temp define here, should be a common define for ALL EP according to usage
typedef enum
{
    USB_TX_EP_0= 0,
    USB_TX_EP_1,
    USB_TX_EP_2,
    USB_TX_EP_3,
    USB_TX_EP_4,
    USB_TX_EP_5,
    USB_TX_EP_6,
    USB_TX_EP_7,
    USB_TX_EP_8,
    USB_TX_EP_9,
    USB_TX_EP_10,
    USB_TX_EP_11,
    USB_TX_EP_12,
    USB_TX_EP_MAX
} UsbTxEpNum_e;


typedef enum
{
    UTFC_ERROR_STATE    = -1,   /* SW check error */
    UTFC_IDLE_STATE     = 0,
    UTFC_START_CFG      = 1,    /* UTFC READ the command to config the USB REG  */
    UTFC_PACKET         = 2,    /* UTFC Tx data to USB TxFIFO, and wait for USB Tx_complete */
    UTFC_ZL_PEND        = 3,    /* If ZERO PKG need, after Recv Tx_complete, enter this state */
    UTFC_CL_CFG         = 4,    /* UTFC config ZERO PKG command */
    UTFC_ZL_PACKET      = 5     /* wait for ZERO PKG USB Tx_complete */
}UtfcState_e;


/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/


// typedef of register 'UtfcCfgInfo_t'
typedef struct {

    uint32_t codeBaseAddr;// base address of the code
    UsbStartAddrSel_e  startAddrSel;// 0:select from SW, configure in register 1: select from HW(SCT)
    uint8_t  zlStageEn;// 0:disable 1: enable. normally SW should not enable ZI
    uint16_t swAddrOffset;// code address offset for epn, 9 bits word address
    uint16_t ziAddrOffset;// ZI code address offset for epn,9 bits word address

} UtfcCfgInfo_t;

// typedef of utfc galobal info
typedef struct {

    uint8_t isUtfcEnabled;// whether utfc is enbaled
    //add more global control var here if needed

} UtfcCtrl_t;






/*  |32bits --number of code, 0:3 valid, 4:31 reserved|


    |32bits --usb cfg register address, 0:1 should be 0|
    |32bits --usb cfg register value|

    |32bits --usb cfg register address, 0:1 should be 0|
    |32bits --usb cfg register value|

    .................
    .................

    max 15 cfg
*/


// typedef of utfc usb in ep cfg section
typedef struct {

    uint32_t usbRegAddr;
    uint32_t usbRegVal;

} UtfcUsbRegCfg_t;


// typedef of utfc usb in ep cfg section
typedef struct {

    uint32_t numOfCode;
    UtfcUsbRegCfg_t usbCode[UTFC_NUM_OF_USB_CODE];
    uint32_t rEpInfo;//related ep info, 4B for 4 align

} UtfcUsbCfgCode_t;



/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

/**
  \fn        utfcInit( void )
  \brief     used by unilog and SCT.
  \note      called when when UNILOG/SCT USB direct path enabled
 */
int32_t utfcInit(void);


/**
  \fn        utfcDinit( void )
  \brief     used by USB driver, called when USBC deinit.
  \note
 */
int32_t utfcDinit(void);



/**
  \fn        utfcReset( void )
  \brief     used to reset UTFC
  \note      called when needed
 */
void utfcReset(void);



/**
  \fn        utfcEpnCfg( UtfcCfgInfo_t * utfcCfg, UsbTxEpNum_e epNum )
  \brief     used by unilog/sct driver, called when unilog to USB path en or SCT to USB path en.
  \note      currently, SW only use for unilog, SCT will only need to configure utfcCfg->startAddrSel=1
 */
int32_t utfcEpnCfg( UtfcCfgInfo_t * utfcCfg, UsbTxEpNum_e epNum );


/**
  \fn        utfcEpnStartReq( UsbTxEpNum_e epNum )
  \brief     used by unilog driver, called when unilog first start.
  \note
 */
int32_t utfcEpnStartReq( UsbTxEpNum_e epNum );

/**
  \fn        utfcEpnClear( UtfcCfgInfo_t * utfcCfg, UsbTxEpNum_e epNum )
  \brief     used by unilog/sct, called to clear UTFC EP
  \note
 */
int32_t utfcEpnClear(UsbTxEpNum_e epNum);

/**
  \fn        UtfcState_e utfcEpnGetState(UsbTxEpNum_e epNum)
  \brief     used by unilog/sct, called to get UTFC state
  \note
 */
UtfcState_e utfcEpnGetState(UsbTxEpNum_e epNum);

/**
  \fn        utfcUlgCfg( UsbTxEpNum_e epNum )
  \brief     used by unilog driver, called when unilog first start.
  \note
 */
int32_t utfcUlgCfg( UsbTxEpNum_e epNum );



/**
  \fn        utfcSetZLForSct(uint8_t idx, UsbTxEpNum_e epNum )
  \brief     used by sct driver to set zero length packet cfg code
  \note
 */
int32_t utfcSetZLForSct(uint8_t idx, UsbTxEpNum_e epNum );



/**
  \fn        utfcSetCodeForSct(UsbTxEpNum_e epNum,uint16_t xferSize,uint32_t *codeBuf)
  \brief     used by sct driver to set normal length packet cfg code
  \note
 */
int32_t utfcSetCodeForSct(UsbTxEpNum_e epNum,uint16_t xferSize,uint32_t *codeBuf);

/**
  \fn        utaReqClr( UtaReqSrc_e reqSrc )
  \brief     used by usb TXFIFO master to clear the request, normally used when the request source
             is working, it will also clear the working state
             should be set to 1 to clear, HW self clear
  \note      HW clear
 */
int32_t utaReqClr( UtaReqSrc_e reqSrc );

/**
  \fn        utaReqSrcDisEn( UtaReqSrc_e reqSrc, uint8_t disEn )
  \brief     used by usb TXFIFO master to disable the request
             should be set disEn to 1 to disable, disEn=0 to enable
  \note      !!! 1 is disable, 0 (default) is enable !!!
 */
int32_t utaReqSrcDisEn(UtaReqSrc_e reqSrc, uint8_t disEn);

/**
  \fn        utaSwAckStateRd( void )
  \brief     used by usb sw device IN transfer e.g. VCOM_SEND
             polling this bit until it is set to 0b001, 1 means get the ack, sw could write USB TX FIFO
  \note      usb sw polling
 */
uint32_t utaAckStateRd(void);



#ifdef __cplusplus
}
#endif

#endif

