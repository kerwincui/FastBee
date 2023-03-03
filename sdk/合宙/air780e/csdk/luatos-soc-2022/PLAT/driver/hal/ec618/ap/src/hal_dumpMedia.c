/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename:hal_dumpMedia.c
*
*  Description: used to provid adapt API for ram dump
*
*  History: initiated by bchang
*
*  Notes:
*
******************************************************************************/

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include "RTE_Device.h"
#include "Driver_Common.h"
#include "usbmst_top.h"
#include "uldp.h"
#if FEATURE_CCIO_ENABLE
#include "usb_device.h"
#endif
//#include "usbc_ctrl.h"
#include "uart.h"



/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*
 *                    DATA TYPE DEFINITION                                    *
 *----------------------------------------------------------------------------*/




/*----------------------------------------------------------------------------*
 *                      GLOBAL VARIABLES                                      *
 *----------------------------------------------------------------------------*/




/*----------------------------------------------------------------------------*
 *                      PRIVATE FUNCTION DECLEARATION                         *
 *----------------------------------------------------------------------------*/
extern int32_t uldpUsbClrCmpltFlg(usbmst_top_st  *ptop,uint8_t epNum);
extern void delay_us(uint32_t us);
extern uint32_t usbc_dev_int_handler (void);
extern int32_t uldpUsbGetCmpltFlg(usbmst_top_st  *ptop);
extern int32_t ulog_vcom_chkdtr( void );



/*----------------------------------------------------------------------------*
 *                      PRIVATE FUNCTIONS                                     *
 *----------------------------------------------------------------------------*/


#if (RTE_USB_EN == 1)

/**
  \fn        usbPollingRecv(uint32_t epNum, uint8_t *data, uint32_t num, uint32_t timeout_us)
  \brief     used to recv data from host via polling, uldp is still involved
  \param[in] epNum       ep number for recv
  \param[in] data        data pointer to store recv data
  \param[in] num         recv data length
  \param[in] timeout_us  timeout value when nothing recv
  \note      only called in eeh dump procedure
 */
static uint32_t usbPollingRecv(uint32_t epNum, uint8_t *data, uint32_t num, uint32_t timeout_us)
{
    uint32_t rbIdx=0,avaSize=0;
    uint32_t rbAddr,rbLen;

    if(num == 0)
        return num;

    //wait until cmplt flag set for epNum or timeout
    while((!(uldpUsbGetCmpltFlg(NULL)&(1<<epNum)))&&timeout_us)
    {
        delay_us(1);
        timeout_us--;
    }

    if(timeout_us == 0)//timeout, recv nothing
        return 0;

    //get recv data length
    uldpEpBufInfoGet((UsbRxEpNum_e)epNum,&rbIdx,&avaSize);

    extern void ccioGetLogRbAddrLen(uint32_t *len, uint32_t *addr );
    ccioGetLogRbAddrLen(&rbLen,&rbAddr);

   //clr cmplt flag
    uldpUsbClrCmpltFlg(NULL,epNum);

    //cfg next rx
    uldpCfgRxEpPara((UsbRxEpNum_e)epNum, 1,0,rbLen);
    usbDevCfgOutXfer(usbDevGetLogIfIdx());

    if(rbIdx<=num)
    {
        memcpy(data,(uint8_t *)rbAddr,rbIdx);
        return rbIdx;
    }
    else
    {
        memcpy(data,(uint8_t *)rbAddr,num);// more data recv than expected
        return num;
    }

}


/**
  \fn        usbUldpEehInit(uint32_t epNum)
  \brief     used to reinit uldp recv in polling mode
  \param[in] epNum       ep number for recv
  \note      only called in eeh dump procedure
*/
static void usbUldpEehInit(uint32_t epNum)
{
    uint32_t rbLen;
    uint32_t addr;


    ECPLAT_PRINTF(UNILOG_CCIO, usbUldpEehInit_1, P_SIG, "dump outep num %d", epNum);

    //step1 static and working mode should inherent from CCIO LOG devive, ignore!

    //step2 clear LOG outep cmplt int,maybe a int is coming during dump

    uldpUsbClrCmpltFlg(NULL,epNum);

    //step3 configure a new transfer, from beginning of RB
    extern void ccioGetLogRbAddrLen(uint32_t *len, uint32_t *addr );
    ccioGetLogRbAddrLen(&rbLen,&addr);

    uldpCfgRxEpStaticPara(epNum, addr, rbLen);

    uldpCfgRxEpPara((UsbRxEpNum_e)epNum, 1,0,rbLen);
    usbDevCfgOutXfer(usbDevGetLogIfIdx());

}
#endif



/*----------------------------------------------------------------------------*
 *                      GLOBAL FUNCTIONS                                      *
 *----------------------------------------------------------------------------*/

/**
  \fn        eehDumpMediaInit( void )
  \brief     used to init dump media for eeh dump, map to UART or USB
  \param[in] N/A
  \note      only called in eeh dump procedure
*/
void eehDumpMediaInit( void )
{
    #if (RTE_USB_EN == 1)
    uint8_t epNum = 0;
    #endif

    if(uniLogGetPherType() == UART_0_FOR_UNILOG)
    {
        UART_init(0,/*DUMP_UART_INSTANCE--TBD!!*/ 921600, false);
    }
    else//USB
    {
        #if (RTE_USB_EN == 1)
        //usbTxRxFifoFlush();//to be added


        epNum = usbDevGetEpNumFromIf(usbDevGetLogIfIdx());


        extern void usbc_ctrl_diep_unmask(uint32_t epnum);
        usbc_ctrl_diep_unmask((uint32_t)((epNum>>4)&0xf));

        //usbc_ctrl_flush_txfifo(&t_usbc_core_top, epNum);
        //usbc_ctrl_flush_rxfifo(&t_usbc_core_top);

        usbUldpEehInit((epNum&0xf));//low 4 bit is outep num
        #endif

    }

}


/**
  \fn        eehDumpMediaFlush(uint32_t instance)
  \brief     used to flush FIFO, only valid for UART now
  \param[in] instance UART instance
  \note      only called in eeh dump procedure
*/
void eehDumpMediaFlush(uint32_t instance)
{

    if(uniLogGetPherType() == UART_0_FOR_UNILOG)
    {
         UART_flush(instance);//flush both TX/RX FIFO
    }
    else//USB
    {
       // TBD: no need to flush, flushed when init

    }

}

/**
  \fn        eehDumpMediaPurgeRx(uint32_t instance)
  \brief     used to flush FIFO, only valid for UART now
  \param[in] instance UART instance
  \note      only called in eeh dump procedure
*/
void eehDumpMediaPurgeRx(uint32_t instance)
{

    if(uniLogGetPherType() == UART_0_FOR_UNILOG)
    {
         UART_purgeRx(instance);//flush both RX FIFO
    }
    else//USB
    {
       // TBD: no need to flush, flushed when init

    }

}

/**
  \fn        eehDumpMediaRecv(uint32_t instance, uint8_t *data, uint32_t num, uint32_t timeout_us)
  \brief     used to recv data from host via polling, uldp is still involved
  \param[in] instance    ep number or uart instance for recv
  \param[in] data        data pointer to store recv data
  \param[in] num         recv data length
  \param[in] timeout_us  timeout value when nothing recv
  \note      only called in eeh dump procedure
 */
uint32_t eehDumpMediaRecv(uint32_t instance, uint8_t *data, uint32_t num, uint32_t timeout_us)
{

    if(uniLogGetPherType() == UART_0_FOR_UNILOG)
    {
        return  UART_receive(instance, data, num, timeout_us);
    }
    else//USB
    {
        #if (RTE_USB_EN == 1)
        return  usbPollingRecv(instance, data, num, timeout_us);
        #else
        return 0;
        #endif
    }

}


/**
  \fn        eehDumpMediaSend(uint32_t instance, uint8_t *data, uint32_t num, uint32_t timeout_us)
  \brief     used to recv data from host via polling, uldp is still involved
  \param[in] instance    ep number or uart instance for recv
  \param[in] data        data pointer to send
  \param[in] num         send data length
  \param[in] timeout_us  timeout value when nothing recv
  \note      only called in eeh dump procedure
 */
uint32_t eehDumpMediaSend(uint32_t instance, uint8_t *data, uint32_t num, uint32_t timeout_us)
{

    if(uniLogGetPherType() == UART_0_FOR_UNILOG)
    {
         return  UART_send(instance, data, num, timeout_us);
    }
    else//USB
    {
        #if (RTE_USB_EN == 1)
        #if 0
	    //check ep0 recv data from uldp
        if((uldpUsbGetCmpltFlg(NULL)&0x1) == 0x1)
        {
           uldpUsbEp0RecvHandle();
        }
        #endif
        // to be added: call USB polling send API
        extern int ulog_vcom_polling_write(uint32_t instance, uint8_t *data, uint16_t num, uint32_t timeout_us);
        return ulog_vcom_polling_write(instance, data, (uint16_t)num, timeout_us);
        #else
        return 0;
        #endif
    }

}




/**
  \fn        eehDumpMediaPollingEp0(uint32_t loopCnt, uint32_t loopInr)
  \brief     polling EP0 ctrl info and handle it, e.g. VCOM open
  \param[in] loopCnt       how many loop times
  \param[in] loopInr  internalval for each loop
  \note      only called in eeh dump procedure
             host will first send request(set/get line coding etc) on every interface(not by EPAT)
             then EPAT will open VCOM
             serial_vcom1_chkdtr will check setcontrolline state is active
             after active, host will not stop and will send more request,
             that's why we will loop more times after active

             !!but if host send addtional request after this API, will not response.!!
 */
void eehDumpMediaPollingEp0(uint32_t loopCnt, uint32_t loopInr)
{
    #if (RTE_USB_EN == 1)
    uint32_t loop = 200;
    while(loopCnt--)
    {
        //check ep0 recv data from uldp
        if((uldpUsbGetCmpltFlg(NULL)&0x1) == 0x1)
        {
            uldpUsbEp0RecvHandle();
        }

        //delay_us(loopInr);

        //loop if any pending usb int
        usbc_dev_int_handler( );

        delay_us(loopInr);


        if((loopCnt%500 == 0)&&(uniLogGetPherType() == USB_FOR_UNILOG))//add log per 500ms to avoid host suspend
        {
            ECPLAT_PRINTF(UNILOG_CCIO, eehDumpMediaPollingEp0_1, P_INFO, "eehDumpMediaPollingEp0:avoid host suspend %d",loopCnt);
            uniLogForceOut(true);
        }

        if(ulog_vcom_chkdtr()==1)
        {

            while(loop--)
            {
                //check ep0 recv data from uldp
                if((uldpUsbGetCmpltFlg(NULL)&0x1) == 0x1)
                {
                    uldpUsbEp0RecvHandle();
                }
                //delay_us(loopInr);
                //loop if any pending usb int
                usbc_dev_int_handler( );

                delay_us(loopInr);
            }


            break;

        }
    }
    #endif
}



/**
  \fn        eehDumpMediaPollingRndisHalt(uint32_t loopCnt, uint32_t loopInr)
  \brief     request rndis halt to host, need polling send sucesss or timeout
  \param[in] loopCnt       how many loop times
  \param[in] loopInr  internalval for each loop
  \note      only called in eeh dump procedure
 */
int32_t eehDumpMediaPollingRndisHalt(uint32_t loopCnt, uint32_t loopInr)
{
    #if (RTE_USB_EN == 1)
    int32_t ret = -1;
    uint16_t cntBefore = 0, cntAfter = 0;

    extern uint16_t get_rndis_func_notifyok_cnt( void );
    extern int rndis0_sig_set_halt(void);

    //step1: loop request send ok
    while(loopCnt--)
    {
        ret=rndis0_sig_set_halt();
        if(ret == 0)
            break;
        delay_us(loopInr);


        if((loopCnt%500 == 0)&&(uniLogGetPherType() == USB_FOR_UNILOG))//add log per 500ms to avoid host suspend
        {
            ECPLAT_PRINTF(UNILOG_CCIO, eehDumpMediaPollingRndisHalt_0, P_INFO, "eehDumpMediaPollingRndisHalt0:avoid host suspend %d",loopCnt);
            uniLogForceOut(true);
        }
    }

    if(ret < 0)
        return ret ;

    cntBefore=get_rndis_func_notifyok_cnt();


    while(loopCnt--)
    {
        //loop if any pending usb int
        usbc_dev_int_handler( );

        delay_us(loopInr);

        if((loopCnt%500 == 0)&&(uniLogGetPherType() == USB_FOR_UNILOG))//add log per 500ms to avoid host suspend
        {
            ECPLAT_PRINTF(UNILOG_CCIO, eehDumpMediaPollingRndisHalt_1, P_INFO, "eehDumpMediaPollingRndisHalt1:avoid host suspend %d",loopCnt);
            uniLogForceOut(true);
        }

        cntAfter = get_rndis_func_notifyok_cnt();

        if(cntAfter > cntBefore)
            return 0;
    }

    return -1;

    #else
    return 0;
    #endif

}


