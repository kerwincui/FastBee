/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: usb_device.h
*
*  Description:
*
*  History: 2021/1/19 created by xuwang
*
*  Notes:
*
******************************************************************************/
#ifndef USB_DEVICE_H
#define USB_DEVICE_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include "ccio_pub.h"


#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/
#define INVALID_USB_IF_NUM        (0xf)//4 bit
#define INVALID_USB_EP_NUM        (0xf)//4 bit
#define INVALID_USB_IF_TYEP_NUM   (0x0)//3 bit,=USB_INTERFACE_NONE
#define MAX_USB_IF_NUM_PER_TYEP   (4)//max 4 ifs per if type. e.g. max 4 AT ifs, enough


#define MAX_OUT_EP_NUM       (13)





/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/


typedef struct UsbIf2Ep
{
    uint16_t usbIfIdx       :4;    /* usb interface Id, used to  */
    uint16_t usbIfType      :3;    /* usb interface type, refer to UsbIfType_e */
    uint16_t inEpNum        :4;    /* in ep number of this interface */
    uint16_t outEpNum       :4;    /* out ep number of this interface */
    uint16_t hasIntEp       :1;    /* is this interface has an interrupt ep */
    uint16_t intEpNum       :4;    /* interrupt ep number of this interface */
    uint16_t resv           :12;    /* reserved */
    uint16_t maxNextXferSize;         /*next usb recv size for this if, set by ccio*/

}UsbIf2Ep_t;


typedef struct UsbType2If
{
    uint32_t ethIfIdx       :4;    /* eth(rndis/ecm) If idx, get from usr define table */
    uint32_t atIfIdx        :4;    /* at If idx, get from usr define table */
    uint32_t logIfIdx       :4;    /* log If idx, get from usr define table */
    uint32_t pppIfIdx       :4;    /* ppp If idx, get from usr define table */
    uint32_t rawIfIdx       :4;    /* raw If idx, get from usr define table */
    uint32_t resv           :12;   /* reserved */

}UsbType2If_t;



/**
 * configuration about a usb device.
 */
typedef struct
{
    uint8_t        bmCreateFlag;    /**< refer to 'CcioTaskOperFlag_e', bitmap type */
    uint8_t        rsvd[3];
}UsbDevConf_t;



// max support 5 interfaces
typedef enum
{
    USB_INTERACE_0 = 0,
    USB_INTERACE_1,
    USB_INTERACE_2,
    USB_INTERACE_3,
    USB_INTERACE_4,
    USB_INTERACE_MAXCNT
} UsbIfIdx_e;


typedef struct UsbIfEpMap
{
    UsbIf2Ep_t usbIf2Ep[USB_INTERACE_MAXCNT];

    uint8_t epNum2IfIdx[MAX_OUT_EP_NUM];/*get If idx from oep num, used by uldp recv callback*/

    uint8_t ulgInepNum;

    UsbType2If_t type2If;

    uint8_t usbEnumSpeed;

}UsbIfEpMap_t;

/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

/**
 * @brief usbDevCreate(uint32_t usbIfIdx, UsbDevConf_t *usbConf)
 * @details create a usb device of 'usbIfIdx'
 *
 * @param usbIfIdx  idx of usb port
 * @param usbConf   The configurattion of a usb port
 * @return NULL failure; !NULL the created uart device.
 */
CcioDevice_t* usbDevCreate(uint32_t usbIfIdx, UsbDevConf_t *usbConf);

/**
 * @brief usbDevDestroy(uint32_t usbIfIdx)
 * @details destroy/delete a usb device of 'usbIfIdx'
 *
 * @param usbIfIdx  idx of usb port
 * @return 0 succ; < 0 failure with errno.
 */
int32_t usbDevDestroy(uint32_t usbIfIdx);

/**
 * @brief usbDevInput(uint32_t usbIfIdx, uint32_t xferCnt, uint32_t event)
 * @details handle the IRQ from usb driver
 *
 * @param epNum     out epNum of usb port
 * @param xferCnt   The xfer data size
 * @param event     usb IRQ event
 * @return void.
 */
void usbDevInput(uint8_t epNum, uint32_t xferCnt, uint32_t event);

/**
 * @brief usbDevNotifyEcmEvent(uint32_t flags, void *args)
 * @details ecm ctrl event notification
 *
 * @param flags  ecm event flags
 * @param args   ecm event args
 * @return void.
 */
void usbDevNotifyEcmEvent(uint32_t flags, void *args);

/**
 * @brief usbDevNotifyRndisEvent(uint32_t flags, void *args)
 * @details rndis ctrl event notification
 *
 * @param flags  rndis event flags
 * @param args   rndis event args
 * @return void.
 */
void usbDevNotifyRndisEvent(uint32_t flags, void *args);

/**
 * @brief usbDevNotifySerlEvent(uint32_t flags, void *args)
 * @details serial ctrl event notification
 *
 * @param flags  serial event flags
 * @param args   serial event args
 * @return void.
 */
void usbDevNotifySerlEvent(uint32_t flags, void *args);

/**
 * @brief usbDevNotifyTxDoneToSct(void)
 * @details notify sct that usb tx is completed
 *
 * @return void.
 */
void usbDevNotifyTxDoneToSct(uint32_t evt);

/**
 * @brief usbDevNotifyStateToSct(uint32_t stateEvt)
 * @details notify sct that usb device state is changed
 *
 * @param stateEvt  state event id of usb device
 * @return void.
 */
void usbDevNotifyStateToSct(uint32_t stateEvt);

uint8_t usbDevGetEpNumFromIf(UsbIfIdx_e ifIdx);
void usbDevGetIfRbAddrLen(UsbIfIdx_e ifIdx, uint32_t *len, uint32_t *addr );
int32_t usbDevCfgOutXfer(UsbIfIdx_e ifIdx);
uint8_t usbDevGetUlgInEpNum( void );
uint8_t usbDevGetLogIfIdx( void );
uint8_t usbDevGetEnumSpd( void );


#ifdef __cplusplus
}
#endif
#endif

