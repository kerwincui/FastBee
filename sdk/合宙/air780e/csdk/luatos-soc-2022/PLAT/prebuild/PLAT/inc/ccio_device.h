
/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: ccio_device.h
*
*  Description:
*
*  History: 2021/1/19 created by xuwang
*
*  Notes: channel device of Channel Centre for Input/Output(CCIO) service
*
******************************************************************************/
#ifndef CCIO_DEVICE_H
#define CCIO_DEVICE_H

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

/* build device status flag begin & end Idx
  1      1     1
  6      3     2                            0
   |--ht--+-irq-+----------------code-------|
   |======+=====+===========================|
   |             CCIO Device FLAG           |
   |======+=====+===========================|
 --[NOTE]
   ht : hw type
*/
#define CCIO_DSF_BASE_BUILD(ht)   ((0x0D5F << 16) | ((ht) << 13))
#define CCIO_DSF_END_BUILD(ht)    (CCIO_DSF_BASE_BUILD(ht) | CCIO_BITMASK(13, 0))

/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/
/* 'flags' definition of 'chdevExecFunc' */
typedef enum
{
    CCIO_DEF_BEGIN = 0x0DEF0000,

    CCIO_DEF_CHG_SERL_CONF = CCIO_DEF_BEGIN,
    CCIO_DEF_GET_RECV_CONF,
    CCIO_DEF_SET_RECV_CONF,
    CCIO_DEF_SET_STATIC_CONF,
    CCIO_DEF_SET_DATA_CONF,

    CCIO_DEF_ULDP_RESET,
    CCIO_DEF_ULDP_RESUME,
    CCIO_DEF_ULDP_START_SW,
    CCIO_DEF_ULDP_SET_SW_CONF,
    CCIO_DEF_ULDP_CLR_NPT_STATE,

    CCIO_DEF_SET_PPP_ACCM,
    CCIO_DEF_SET_PPP_SPEC,
    CCIO_DEF_ETH_MEDIA_STATUS,
    CCIO_DEF_FLUSH_TX_FIFO,
    CCIO_DEF_DIRECT_OUTPUT,
    CCIO_DEF_UNBLOCK_SCT_EP,
    CCIO_DEF_SERL_DCD_STATUS,
    CCIO_DEF_SERL_RI_STATUS,
    CCIO_DEF_GET_CTS_SIGNAL,

    CCIO_DEF_CUST_RSVD_BEGIN = 0x0DEFC000,
    /*
     * rsvd for customers
     * refer to 'CcioCustDevExecFlags_e'
     */
    CCIO_DEF_CUST_RSVD_END = 0x0DEFFFFF,

    CCIO_DEF_END = CCIO_DEF_CUST_RSVD_END,
    CCIO_DEF_UNDEF = CCIO_DEF_END
}CcioDevExecFlags_e;

/* CCIO_DEF_CHG_SERL_CONF */
typedef struct
{
    uint32_t baudRate;
    uint32_t frameFmt;
    struct CcioDevice *chdev;
}CcioDeaChgSerlConf_t;

/* CCIO_DEF_GET_RECV_CONF */
typedef struct
{
    uint8_t   llsn;
    uint8_t   isRxWinEn :1;
    uint8_t   isXferChk :1;
    uint8_t   rsvdBits  :6;
    uint16_t  rxWinSize;    /* recv window size */
    uint16_t  dummySti;     /* dummy startIdx, valid @dummyCnt != 0 */
    uint16_t  dummyCnt;     /* dummy cnt, for uart rbuf flush */
    uint16_t  xferCnt;
    uint16_t  writeIdx;     /* in: last writeIdx, out: latest writeIdx */
}CcioDeaGetRecvConf_t;

/* CCIO_DEF_SET_RECV_CONF */
typedef struct
{
    uint8_t   llsn;
    uint8_t   isCctEn    :1;
    uint8_t   forceTrigg :1;
    uint8_t   rsvdBits   :6;
    uint16_t  readIdx;
    uint16_t  writeIdx;
}CcioDeaSetRecvConf_t;

/* CCIO_DEF_SET_STATIC_CONF */
typedef struct
{
    uint8_t   llsn;
    uint8_t   rsvd[3];
    uint16_t  ahcbSize  :6;     /* Additional-Header-Control-Block */
    uint16_t  alignVal  :3;
    uint16_t  isThresEn :1;
    uint16_t  rsvdBits  :6;
    uint16_t  cctSize;
    uint16_t  avlbThres;
    uint16_t  writeIdx;
    uint16_t  readIdx;
    uint16_t  bufLen;
    uint8_t  *buffer;
}CcioDeaSetStaticConf_t;

/* CCIO_DEF_SET_DATA_CONF */
typedef struct
{
    uint8_t   llsn;
    uint8_t   bmHwAcm;
    uint16_t  cctSize;
    uint8_t   alignVal;
    uint8_t   rsvd[2];
    uint8_t   dtype;    /* CcioDevType_e */
    union
    {
        CsioDevType_e stype;
        CnioDevType_e ntype;
        CuioDevType_e utype;
    }subtype;
}CcioDeaSetDataConf_t;

/* CCIO_DEF_ULDP_RESET */
typedef struct
{
    uint8_t   rsvd[4];
}CcioDeaUldpReset_t;

/* CCIO_DEF_ULDP_RESUME */
typedef struct
{
    uint8_t   rsvd[4];
}CcioDeaUldpResume_t;

/* CCIO_DEF_ULDP_START_SW */
typedef struct
{
    uint8_t   rsvd[4];
}CcioDeaUldpStartSw_t;

/* CCIO_DEF_ULDP_SET_SW_CONF */
typedef struct
{
    uint8_t  *srcAddr;
    uint16_t  len;
    uint8_t   rsvd[2];
}CcioDeaUldpSetSwConf_t;

/* CCIO_DEF_ULDP_CLR_NPT_STATE */
typedef struct
{
    uint8_t   rsvd[4];
}CcioDeaUldpClrNptState_t;

/* CCIO_DEF_SET_PPP_ACCM */
typedef struct
{
    uint8_t   llsn;
    uint8_t   isOut;  /* is accm for output or input? */
    uint8_t   rsvd[2];
    uint32_t  accm[8];
}CcioDeaSetPppAccm_t;

/* CCIO_DEF_SET_PPP_SPEC */
typedef struct
{
    uint8_t   data[3];
    uint8_t   rsvd;
}CcioDeaSetPppSpec_t;

/* CCIO_DEF_ETH_MEDIA_STATUS */
typedef struct
{
    uint8_t   lanType;    /* refer to 'CcioLanMediaType_e' */
    uint8_t   isWanAvlb;
    uint8_t   rsvd[2];
}CcioDeaEthMediaStatus_t;

/* CCIO_DEF_FLUSH_TX_FIFO */
typedef struct
{
    uint8_t   llsn;
    uint8_t   rsvd[3];
    void     *extras;
}CcioDeaFlushTxFifo_t;

/* CCIO_DEF_DIRECT_OUTPUT */
typedef struct
{
    uint8_t   llsn;
    uint8_t   rsvd[3];
    void     *dlpdu;
}CcioDeaDirectOutput_t;

/* CCIO_DEF_UNBLOCK_SCT_EP */
typedef struct
{
    uint8_t   llsn;
    uint8_t   rsvd[3];
}CcioDeaUnblockSctEp_t;

/* CCIO_DEF_SERL_DCD_STATUS */
typedef struct
{
    uint8_t   llsn;
    uint8_t   state;   /* CcioSerlDcdState_e */
    uint8_t   rsvd[2];
}CcioDeaSerlDcdStatus_t;

/* CCIO_DEF_SERL_RI_STATUS */
typedef struct
{
    uint8_t   llsn;
    uint8_t   rsvd[3];
    uint16_t  cycleCnt;
    uint16_t  dutyCyclePct;
    uint32_t  cycleTimeMs;
}CcioDeaSerlRiStatus_t;

/* CCIO_DEF_GET_CTS_SIGNAL */
typedef struct
{
    uint8_t   llsn;
    uint8_t   isAllowed;
    uint8_t   rsvd[2];
}CcioDeaGetCtsSignal_t;

/* 'flags' definition of 'chdevStatusCallback' */
typedef enum
{
    CCIO_DSF_USB_BEGIN = CCIO_DSF_BASE_BUILD(CCIO_HT_USB),
    CCIO_DSF_QUERY_PEER_MAC = CCIO_DSF_USB_BEGIN,
    CCIO_DSF_QUERY_LOCAL_MAC,
    CCIO_DSF_RNDIS_INIT,
    CCIO_DSF_RNDIS_HALT,
    CCIO_DSF_RNDIS_RESET,
    CCIO_DSF_ECM_SET_FILTER,
    CCIO_DSF_PPP_SPEC_PATTN,
    CCIO_DSF_RBUF_EBNA,
    CCIO_DSF_RNDIS_ESIZE,
    CCIO_DSF_USB_ESTATUS,
    CCIO_DSF_AHB_EADDR,
    CCIO_DSF_SCT_TX_FDBACK,
    CCIO_DSF_SCT_TX_DONE,
    CCIO_DSF_SCT_USB_STATE,
    CCIO_DSF_SCT_USB_TMEXPR,
    CCIO_DSF_SCT_USB_UNBLKEP,
    CCIO_DSF_USB_STATE,
    CCIO_DSF_USB_END = CCIO_DSF_END_BUILD(CCIO_HT_USB),

    CCIO_DSF_UART_BEGIN = CCIO_DSF_BASE_BUILD(CCIO_HT_UART),
    CCIO_DSF_AUTO_BAUDRATE = CCIO_DSF_UART_BEGIN,
    CCIO_DSF_WAIT_TX_DONE,
    CCIO_DSF_SET_TX_DONE,
    CCIO_DSF_IPR_FLUSH,
    CCIO_DSF_UART_END = CCIO_DSF_END_BUILD(CCIO_HT_UART),

    CCIO_DSF_RADIO_BEGIN = CCIO_DSF_BASE_BUILD(CCIO_HT_RADIO),
    CCIO_DSF_ULPDU_FREE = CCIO_DSF_RADIO_BEGIN,
    CCIO_DSF_DLPDU_FREE,
    CCIO_DSF_WAN_MEDIA_NOTIF,
    CCIO_DSF_RADIO_END = CCIO_DSF_END_BUILD(CCIO_HT_RADIO),

    CCIO_DSF_HWIND_BEGIN = CCIO_DSF_BASE_BUILD(CCIO_HT_HWIND),
    CCIO_DSF_DEV_ADD,
    CCIO_DSF_DEV_DEL,
    CCIO_DSF_CTS_CHG,
    CCIO_DSF_DTR_CHG,
    CCIO_DSF_RI_DONE,
    CCIO_DSF_HWIND_END = CCIO_DSF_END_BUILD(CCIO_HT_HWIND),

    CCIO_DSF_CUSTOM_BEGIN = CCIO_DSF_BASE_BUILD(CCIO_BITMASK(3, 0)),
    /*
     * rsvd for customers
     * refer to 'CcioCustDevStatusFlags_e'
     */
    CCIO_DSF_CUSTOM_END = CCIO_DSF_END_BUILD(CCIO_BITMASK(3, 0)),

    CCIO_DSF_UNDEF = 0x0D5FFFFF
}CcioDevStatusFlags_e;

typedef struct
{
    uint16_t  xferCnt;
    uint16_t  startIdx;
    uint32_t  xferCos;  /* refer to CCIO_CHAN_MSG_CF_COS0/1/2 */
    uint32_t  flags;    /* for CcioDevStatusFlags_e */
    struct CcioDevice *chdev;
}CcioDevInXfer_t;

typedef enum
{
    CCIO_OXT_PDU_LIST_WITHOUT_TAIL, /* "DlPduBlock_t" one node/list need output, only pass the header, carried in: "CcioDevOutXfer_t->dlpdu" */
    CCIO_OXT_PDU_LIST_WITH_TAIL,    /* "DlPduBlock_t" list need output, pass the header and tail,
                                     * header: "CcioDevOutXfer_t->dlpdu"
                                     * tail  : "CcioDevOutXfer_t->extra"
                                     */
    CCIO_OXT_PDU_LIST_EVENT         /* "DlPduBlock_t" is in a shared list, notify Tx task to get from the list when proc this type
                                     * Only used for PS DL PDU (IP), sent from L2
                                     */
}CcioOutXferType_e;

typedef enum
{
    CCIO_OXF_RAW_DATA,
    CCIO_OXF_CMD_LINE,

    CCIO_OXF_MAXNUM
}CcioOutXferFormat_e;

typedef struct
{
    uint8_t   outType;   /* CcioOutXferType_e */
    uint8_t   outFmt;    /* CcioOutXferFormat_e */
    uint8_t   xtag;      /* some kind of private info */
    uint8_t   rsvd;      /* used for 4 byte aligned */
    void     *head;      /* DlPduBlock_t */
    void     *tail;
    struct CcioDevice *chdev;
}CcioDevOutXfer_t;

typedef CcioDevInXfer_t CcioDsaRxStatus_t;

/* CCIO_DSF_QUERY_PEER_MAC */
typedef CcioMacAddr_t CcioDsaQueryPeerMac_t;

/* CCIO_DSF_QUERY_LOCAL_MAC */
typedef CcioMacAddr_t CcioDsaQueryLocalMac_t;

/* CCIO_DSF_RNDIS_INIT */
typedef struct
{
    struct CcioDevice *chdev;
}CcioDsaRndisInit_t;

/* CCIO_DSF_RNDIS_HALT */
/* CCIO_DSF_RNDIS_RESET */
typedef struct
{
    struct CcioDevice *chdev;
}CcioDsaRndisDeinit_t;

/* CCIO_DSF_ECM_SET_FILTER */
typedef struct
{
    struct CcioDevice *chdev;
}CcioDsaEcmSetFilter_t;

/* CCIO_DSF_SCT_TX_FDBACK */
typedef struct
{
    uint8_t isCmplt;
    uint8_t rsvd[3];
    struct CcioDevice *chdev;
}CcioDsaSctTxFdback_t;

/* CCIO_DSF_SCT_TX_DONE */
typedef struct
{
    uint32_t txEvt;
    struct CcioDevice *chdev;
}CcioDsaSctTxDone_t;

/* CCIO_DSF_SCT_USB_STATE */
typedef struct
{
    uint32_t stateEvt;
    struct CcioDevice *chdev;
}CcioDsaSctUsbState_t;

/* CCIO_DSF_SCT_USB_TMEXPR */
typedef struct
{
    uint32_t timerId;
    struct CcioDevice *chdev;
}CcioDsaSctUsbTmExpr_t;

/* CCIO_DSF_SCT_USB_UNBLKEP */
typedef struct
{
    uint32_t epNum;
    struct CcioDevice *chdev;
}CcioDsaSctUsbUnblkEp_t;

/* CCIO_DSF_USB_STATE */
typedef struct
{
    uint16_t isEnable;
    uint16_t devState;
    struct CcioDevice *chdev;
}CcioDsaUsbState_t;

/* CCIO_DSF_AUTO_BAUDRATE */
typedef struct
{
    uint32_t baudRate;
    struct CcioDevice *chdev;
}CcioDsaAutoBaudRate_t;

/* CCIO_DSF_WAIT_TX_DONE */
typedef struct
{
    struct CcioDevice *chdev;
}CcioDsaWaitTxDone_t;

/* CCIO_DSF_SET_TX_DONE */
typedef struct
{
    struct CcioDevice *chdev;
}CcioDsaSetTxDone_t;

/* CCIO_DSF_ULPDU_FREE */
typedef struct
{
    void  *ulpdu;  /* maybe a list */
    void  *extras;
}CcioDsaUlPduFree_t;

/* CCIO_DSF_DLPDU_FREE */
typedef struct
{
    uint8_t    isFast;  /* If TRUE, "list" set to PNULL, and Tx task call: NetifLanDlPkgListGet() to get the DL PDu to free */
    uint8_t    xtag;    /* some kind of private info */
    uint8_t    rsvd[2];
    void      *dlpdu;   /* maybe a list */
    void      *chdev;
}CcioDsaDlPduFree_t;

/* CCIO_DSF_WAN_MEDIA_NOTIF */
typedef CcioDataPathCap_t CcioDsaWanMediaNotif_t;

/* CCIO_DSF_DEV_ADD */
typedef struct
{
    struct CcioDevice *chdev;
}CcioDsaDevAdd_t;

/* CCIO_DSF_DEV_DEL */
typedef struct
{
    struct CcioDevice *chdev;
}CcioDsaDevDel_t;

/* CCIO_DSF_CTS_CHG */
typedef struct
{
    uint8_t   isAllowed;
    uint8_t   epNum;
    uint8_t   rsvd[2];
    struct CcioDevice *chdev;
}CcioDsaCtsChg_t;

/* CCIO_DSF_DTR_CHG */
typedef struct
{
    struct CcioDevice *chdev;
}CcioDsaDtrChg_t;

/* CCIO_DSF_RI_DONE */
typedef struct
{
    struct CcioDevice *chdev;
}CcioDsaRiDone_t;


typedef int32_t (*chdevPostHandleFunc)(CcioDevice_t *chdev, void *extras);

/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
/**
 * get rigestered device ctlr map in DeviceMan;
 */
uint32_t ccioGetDevRdcm(void);
/**
 * Add an I/O device to the list of CCIO devices by driver
 * And it is disabled by default if not referred by an entity,
 * In which state drivers cannot input anything.
 */
CcioDevice_t* ccioAddDevice(CcioDevice_t *chdev);
/**
 * Delete an I/O device from the list of CCIO devices by driver;
 */
int32_t ccioDelDevice(CcioDevice_t *chdev);
/**
 * Find a device by searching for its device Id
 */
CcioDevice_t* ccioFindDevice(uint16_t devId);
/**
 * Find a device by searching for its device type and subtype
 */
CcioDevice_t* ccioFindDeviceByTypes(CcioHwType_e hwtype, CcioDevType_e dtype, uint8_t subtype);
/**
 * assign an unused device to channel entity via specific device types
 */
CcioDevice_t* ccioAssignDeviceByTypes(CcioDevType_e dtype, uint8_t subtype);
/**
 * assign an unused device to channel entity via device type
 */
CcioDevice_t* ccioAssignDeviceByType(CcioDevType_e dtype);
/**
 * traverse all devices by searching for its hw type
 */
int32_t ccioTraverseDeviceByHwType(CcioHwType_e hwtype, void *extras, chdevPostHandleFunc postHandleFn);
/**
 * check if there are any free device in the list
 */
bool_t ccioHasFreeDevice(void);
/**
 * release the device ever used by channel entity
 */
int32_t ccioReleaseDevice(CcioDevice_t* chdev);
/**
 * set the device neccesary facility.
 */
void ccioSetDeviceEntity(CcioDevice_t *chdev, chdevInCallback chdevInCb, void *chent);
/**
 * set the working state of device.
 */
void ccioSetDeviceState(CcioDevice_t *chdev, CcioDevWorkState_e state, uint8_t bmHwAcm);

uint8_t ccioAsgnDeviceTxCos(CcioHwType_e htype, uint8_t idx);

/**
 * free the ulpdu list for a certain kind of device.
 */
void  ccioFreeDeviceUlPdu(CcioDevice_t *chdev, void *ulpduList);

#ifdef __cplusplus
}
#endif
#endif


