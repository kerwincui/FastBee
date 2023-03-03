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
#ifndef ULDP_H
#define ULDP_H

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

/*DEFINE ULDP return code*/

#define ULDP_RET_OK           (0)
#define ULDP_RET_ALREADY_EN  (-1)
#define ULDP_PARA_ERROR      (-2)
#define ULDP_NOT_INIT        (-3)
#define ULDP_RET_FAIL        (-4)


#define MAX_OEP_NUM  14


#define ULDP_REG_BASE 0x40070000
//#define USBC_REG_BASE 0x1A000000

//#define USBC_GRXSTSP_ADDR (USBC_REG_BASE+0x20)

//#define USBC_RXFIFO_BASE_ADDR (USBC_REG_BASE+0x1000)

#define DEST_BUFF_BASE_ADDR   0x00400000



#define RING_BUF_SIZE      (0x2000)

#define PT_TEST_DATA_SIZE  0x20



/*5 USB devices
VCOM1: OUT=EP1 IN=EP2
VCOM2: OUT=EP2 IN=EP4
VCOM3: OUT=EP3 IN=EP6
VCOM4: OUT=EP4 IN=EP8
VCOM5: OUT=EP5 IN=EP10


RNDIS simulation use COM1, RX EP NUM=1 SCT TX EP NUM=2
AT use COM2, RX EP NUM=2,SCT TX EP NUM=4
UNILOG use  COM3 RX EP NUM=3 TX EP=6
PPP use COM4 ,RX EP NUM=4 SCT TX EP NUM=8

TXFIFO NUM should be same as EP NUM

*/



#define ULDP_HDR_MAGIC     0x5B8E


/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/


// temp define here, should be a common define for ALL EP according to usage
typedef enum
{
    USB_RX_EP_0= 0,
    USB_RX_EP_1,
    USB_RX_EP_2,
    USB_RX_EP_3,
    USB_RX_EP_4,
    USB_RX_EP_5,
    USB_RX_EP_6,
    USB_RX_EP_7,
    USB_RX_EP_8,
    USB_RX_EP_9,
    USB_RX_EP_10,
    USB_RX_EP_11,
    USB_RX_EP_12,
    USB_RX_EP_13,
    USB_RX_EP_SW=USB_RX_EP_13,
    USB_RX_EP_MAX
} UsbRxEpNum_e;



// epn process mode
typedef enum
{
    EPN_DATA_PROCESS_MODE_PT=0,
    EPN_DATA_PROCESS_MODE_EXTRACT,
    EPN_DATA_PROCESS_MODE_MAX
} UldpEPnMode_e;



// pt mode input data endian(byte order)
typedef enum
{
    PT_MODE_RXDATA_LITTLE_ENDIAN=0,//default
    PT_MODE_RXDATA_BIG_ENDIAN,
    PT_MODE_RXDATA_ENDIAN_MAX
} UldpPTRxEndian_e;



//CRC method select
typedef enum
{
    CRC_METHOD_RNDIS=0,//default
    CRC_METHOD_PPP,
    CRC_METHOD_COMMON,
    CRC_METHOD_MAX
} UldpCrcMethod_e;


//RNDIS/PPP rx data(input to ULDP) endian(byte order)
typedef enum
{
    RNDIS_PPP_RXDATA_BYTE_ORDER_NO_CHANGE=0,//default
    RNDIS_PPP_RXDATA_BYTE_ORDER_CHANGE,
    RNDIS_PPP_RXDATA_BYTE_ORDER_MAX
} UldpRdsPppRxByteOrder_e;


//uldp work mode
typedef enum
{
    ULDP_RNDIS_MODE=0,
    ULDP_PPP_MODE=1,
    ULDP_PASS_THROUGH_MODE=2
 }UldpWorkMode_e;


//rndis crc byte cnt
typedef enum
{
    RNDIS_CRC_1_BYTE=0,//default
    RNDIS_CRC_2_BYTE,
    RNDIS_CRC_3_BYTE,
    RNDIS_CRC_4_BYTE,
    RNDIS_CRC_BYTE_MAX
 }UldpRdsCrcByteCnt_e;


//rndis input byte bit swap
typedef enum
{
    RNDIS_INBYTE_FROM_BIT7=0,
    RNDIS_INBYTE_FROM_BIT0,//default
    RNDIS_INBYTE_MAX
 }UldpRdsInByteBitSwap_e;


//rndis CRC output bit swap
typedef enum
{
    RNDIS_CRC_OUT_BIT_NO_SWAP=0,
    RNDIS_CRC_OUT_BIT_SWAP,//default
    RNDIS_CRC_OUT_BIT_SWAP_MAX
 }UldpRdsCrcOutBitSwap_e;


//rndis CRC output bit complement
typedef enum
{
    RNDIS_CRC_OUT_BIT_NO_COMPLE=0,
    RNDIS_CRC_OUT_BIT_COMPLE,//default
    RNDIS_CRC_OUT_BIT_COMPLE_MAX
 }UldpRdsCrcOutBitComple_e;



//ppp input byte bit swap
typedef enum
{
    PPP_INBYTE_FROM_BIT7=0,//default
    PPP_INBYTE_FROM_BIT0,
    PPP_INBYTE_MAX
 }UldpPppInByteBitSwap_e;



//common CRC output bit swap
typedef enum
{
    COMMON_CRC_OUT_BIT_NO_SWAP=0,
    COMMON_CRC_OUT_BIT_SWAP,//default
    COMMON_CRC_OUT_BIT_SWAP_MAX
 }UldpComCrcOutBitSwap_e;


//common input byte bit swap
typedef enum
{
    COMMON_INBYTE_FROM_BIT7=0,//default
    COMMON_INBYTE_FROM_BIT0,
    COMMON_INBYTE_MAX
 }UldpComInByteBitSwap_e;

//common CRC output bit complement
typedef enum
{
    COMMON_CRC_OUT_BIT_NO_COMPLE=0,//default
    COMMON_CRC_OUT_BIT_COMPLE,
    COMMON_CRC_OUT_BIT_COMPLE_MAX
 }UldpComCrcOutBitComple_e;

//common crc byte cnt
typedef enum
{
    COMMON_CRC_1_BYTE=0,//default
    COMMON_CRC_2_BYTE,
    COMMON_CRC_3_BYTE,
    COMMON_CRC_4_BYTE,
    COMMON_CRC_BYTE_MAX
 }UldpComCrcByteCnt_e;



typedef struct UldpHdrInfo
{

    uint32_t    magicNum : 16;                 /* magic number use as a flag */
    uint32_t    descpInvalidDataNum : 8;       /* PPP de-escape invalid data number*/
    uint32_t    resv24to31 : 8;                /* reserve 8 bits */

    uint32_t    crcValue;                      /* crc value caculated by ULDP, SW may use it */

    uint32_t    msgLen: 16;                    /* byte counter only for data , no need to 4 bytes aligned */
    uint32_t    isRdsPppCmpl: 1;                /* whether current RNDIS (PPP)packets in the transfer is complete 1-cmpl*/
    uint32_t    crcResult: 1;                  /* whether crc checking result is correct 1-correct*/
    uint32_t    resv18to23: 6;                 /* reserve 6 bits*/
    uint32_t    isPppHasInvalidData: 1;        /* whether PPP has invalid data when de-escape 1-ppp has invalid data*/
	uint32_t    firstNoStartFlagPppPkt: 1;     /* first PPP packet without 7E at the begainning*/
    uint32_t    resv26to27: 2;                 /* reserve 2 bits*/
    uint32_t    errRndisMsgType: 1;            /* whether RNDIS message type is error, should be 0x1 1-error*/
    uint32_t    errRndisMsgLen: 1;             /* whether RNDIS message length is error, should be >MinLen configured  < MaxLen configured 1-error*/
    uint32_t    errRndisDataLen: 1;            /* whether RNDIS data len is error,dataOffset+((dataLen+3)/4)*4 > msgLen  1-error*/
    uint32_t    errRndisMsgOfst: 1;            /* whether RNDIS data offset is error, dataOffset should >=8 and 4 Bytes aligned, 1-error*/
}UldpHdrInfo_t; // 3*4=12 bytes



// typedef of register 'uldp_err_int_info'
typedef struct {

    uint8_t uldpMode;// set uldp to PPP/RNIDS/PT(pass through)
    uint8_t uldpHdrLen;//ULDP header len, should be 0 when PT mode, and should set to uldphdr(hw fill)+dlpduhdr(sw)
    uint8_t crcEn;       // CRC enable
    uint8_t crcMethodSel;// PPP/RNDNIS/COMMON(defined by user)


    //PT mode
    uint8_t ptModeByteOrder;// only for PT mode ,0-- default little endian 1--big endian

    //PPP mode
    uint32_t pppInDataEndian;//0--default fetch RX data as little endian 1--fetch RX data as big endian
    uint32_t pppCrcInitVal;//CRC init value,default 0xffff
    uint32_t pppCrcFinalVal;//CRC expected final value, used to match with CRC result,default 0xf0b8
    uint32_t pppInByteSwap;// 0--default CRC from in data[7], 1--CRC from in data[0]
    uint32_t pppSpecData;  // special match data pattern, should be "+++"

    //RNDIS mode
    uint32_t rndisMinLen;// min valid RNDIS length
    uint32_t rndisInByteOrder;//0--default not change RX data byte order  1-- change RX data byte order
    uint32_t rndisMaxLen;//RNDIS max length, if received length exceed this value, trigger int
    uint32_t rndisCrcInitVal;//RNDIS init CRC value
    uint32_t rndisCrcByteCnt;//0--1 byte  1--2 bytes 2--3 bytes 3--4 bytes, also for common CRC!!!!
    uint32_t rndisInDataSwap;//1--default crc from in data[0]  0---crc from in data[7]
    uint32_t rndisCrcInCompleCnt;//how many bytes should be ~ ,should be 4 and default is 4
    uint32_t rndisOutBitSwap;// swap bit in CRC result
    uint32_t rndisCrcBitComple;//0--CRC bit not ~  1--default CRC bit ~

    //common crc
    uint32_t comCrcPoly;// Poly to direct how to do CRC
    uint32_t comCrcInitVal;//CRC init value
    uint32_t comCrcOutBitSwap;//CRC result bit swap
    uint32_t comCrcInByteSwap; //0--default CRC from in data[7], 1--CRC from in data[0]
    uint32_t comCrcOutComple;//0--default CRC reuslt not ~ 1--CRC reuslt ~
    uint32_t comCrcInCompleCnt;//how many bytes shold be ~
    uint32_t comCrcBitCnt;//0--8 bits 1-- 16 bits 2--24 bits 3--32 bits

} UldpCfgInfo_t;

typedef void (*uldpCallback_t)(uint8_t epNum, uint32_t xferCnt,uint32_t event);

// typedef of uldp galobal info
typedef struct {

    uint8_t isUldpEnabled;// whether uldp is enbaled
    uldpCallback_t uldpCallback;

} UldpCtrl_t;


/****** ULDP Event *****/
#define ULDP_EVENT_XFER_COMPLETE            (1UL << 0)  ///< current ULDP transfer is complete
#define ULDP_EVENT_PPP_SPECIAL_MATCH        (1UL << 1)  ///< current ULDP trasnfer is complete and last 3 bytes match special pattern,only for PPP OEP
#define ULDP_EVENT_BUF_NOT_AVLB             (1UL << 2)  ///< buffer is not enough
#define ULDP_EVENT_RNDIS_LEN_ERROR          (1UL << 3)  ///< RNDIS length is not correct
#define ULDP_EVENT_USB_STATUS_ERROR         (1UL << 4)  ///< USB fatal error, receive invalid rx status
#define ULDP_EVENT_AHB_ADDR_ERROR           (1UL << 5)  ///< USB AHB access error, sw bug





/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

/**
\fn        uldpInit(uldpCallback_t callback)
\brief     used by USB driver, called when USBC init.
\param[in] callback pointer to ULDP int callback function
\note      called when usb init, ULDP global and static configure
*/
int32_t uldpInit(uldpCallback_t callback);


/**
\fn        uldpDinit( void )
\brief     used by USB driver, called when USBC deinit.
\note      called when usb init, ULDP global and static configure
*/
int32_t uldpDinit( void );


/**
\fn        uldpCfgDataProc(UldpCfgInfo_t * pUldpCfg,UsbRxEpNum_e epNum)
\brief     used by USB driver, called before enable next RX.
\param[in] pUldpCfg pointer to the configuration set by user
\param[in] epNum out endpoint number
\note      2 level configure for the ULDP process
     1st level, ep configure pass through or data extract mode
     2nd level: ep select data extract mode, configure PPP/RDNIS
     select a need CRC method.
*/
int32_t uldpCfgDataProc(UldpCfgInfo_t * pUldpCfg,UsbRxEpNum_e epNum);


/**
\fn        uldpCfgRxEpStaticPara(UsbRxEpNum_e epNum, uint32_t bufAddr,uint32_t buflen)
\brief     static ep rx buffer configure, only need in case of ringbuf change e.g. BNA triggered
\param[in] epNum out endpoint number
\param[in] bufAddr buffer start address, should be 4 bytes aligned
\param[in] buflen  buffer total length,  should be 4 bytes aligned
\note      called during init stage or BNA triggered stage
*/
int32_t uldpCfgRxEpStaticPara(UsbRxEpNum_e       epNum, uint32_t bufAddr,uint32_t buflen);




/**
\fn        int32_t uldpCfgRxEpPara(UsbRxEpNum_e epNum, uint8_t needUpdIdx, uint32_t idx,uint32_t avlbSize)
\brief     used by USB driver, called before enable next RX.
\param[in] epNum out endpoint num
\param[in] needUpdIdx whether need to update rx index
\param[in] idx  index which need tobe configured
\param[in] avlbSize  avlbSize which need tobe configured
\note      dynamic configure when transfer complete,called by USB driver
*/
int32_t uldpCfgRxEpPara(UsbRxEpNum_e       epNum, uint8_t needUpdIdx, uint32_t idx,uint32_t avlbSize);


/**
  \fn        int32_t uldpEpBufInfoGet(uint8_t * para)
  \brief     used to get epn ringbuf current idx and avlbSize
  \param[in] epNum out endpoint num
  \param[in] pointer of idx used to return idx read from register
  \param[in] pointer of avlbSize used to return avlbSize read from register
  \return    int32_t
  \note      idx and avlbSize is updated automaticly by ULDP HW when receive data from USB FIFO
 */
int32_t uldpEpBufInfoGet(UsbRxEpNum_e      epNum, uint32_t * idx, uint32_t *avlbSize);


/**
\fn        uldpCfgSwEpSrcPara(uint8_t * srcAddr, uint16_t * len)
\brief     ram2ram mode source data setting
\param[in] srcAddr pointer to source address
\param[in] len  data length which need tobe processed by ULDP
\note      called when source data is prepared
*/
int32_t uldpCfgSwEpSrcPara(uint8_t * srcAddr, uint16_t len);


/**
\fn        uldpCfgSwEpSrcPara(uint8_t * srcAddr, uint16_t * len)
\brief     ram2ram mode source data setting
\param[in] srcAddr pointer to source address
\param[in] len  data length which need tobe processed by ULDP
\note      called when source data is prepared
*/
void uldpStartSwEp( void);





/**
\fn        uldpSetPppDescpBmTbl(uint8_t* bmTblPtr,uint8_t offset,uint8_t len)
\brief     used to configure the PPP de-escape bitmap table.
\param[in] bmTblPtr pointer to the table to be set ,should be uint32_t pointer
\param[in] offset the location to start set
\param[in] len actual set length(32bits*length)
\note      called by PPP module when PPP neigoation. should be set per 32bits,
     since ULDP register is 32bits. Offset indicates which 32bits to set,
     offset=0 means set from the 1st register
*/
void uldpSetPppDescpBmTbl(uint32_t* bmTblPtr,uint8_t offset,uint8_t len);


/**
\fn        int32_t uldpResume( void )
\brief     used to resume ULDP after blocked by BNA error.
*/
void uldpResume( void );

/**
  \fn        uldpReset( void )
  \brief     called when need to reset ULDP.
  \note      called when need to reset ULDP.
 */
void uldpReset( void );


/**
\fn        void uldpPppSpecDataSet(uint8_t * para)
\brief     used to set PPP specical matching data, most case it should be "+++".
\param[in] para pointer to specical parameter need to be set
\return    void
\note      called when PPP initialized
*/
void uldpPppSpecDataSet(uint8_t * para);

/**
  \fn        uldpSetSetupAddr( uint32_t addr )
  \brief     used to set setup recv buffer addr.
  \note      called when need to reset ULDP.
 */
void uldpSetSetupAddr( uint32_t addr );

/**
  \fn        uldpRdsPppClr( void )
  \brief     called when need to clear ULDP RNDIS/PPP state.
  \note      called when need to clear ULDP RNDIS/PPP state.
 */
void uldpRdsPppClr( void );


/**
  \fn        uldpUsbEp0RecvHandle( void )
  \brief     used to handle EP0 recv data in polling mode
  \return    void
  \note      called only in EEh dump 
 */
int32_t uldpUsbEp0RecvHandle( void );



#ifdef __cplusplus
}
#endif

#endif
