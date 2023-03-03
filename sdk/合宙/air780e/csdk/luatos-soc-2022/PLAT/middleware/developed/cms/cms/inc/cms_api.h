/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: cms_api.h
 *
 *  Description: CMS (Communication Modem Service layer/task) external API & signal definition
 *
 *  History:
 *
 *  Notes:
 *  1> This is the API file which should (only) included by other modules, such as APP task
 *      which need CMS serives.
 *  2> Other modules (not runing in CMS task), must not include other CMS header files
******************************************************************************/
#ifndef __CMS_API_H__
#define __CMS_API_H__

#include <stdint.h>
#include "string.h"
#include "commontypedef.h"
#include "osasys.h"
#include "cms_def.h"


/******************************************************************************
 *****************************************************************************
 * CMS EXTERNAL COMMON MARCO
 *****************************************************************************
******************************************************************************/


#define CMS_MAX_DELAY_MS            0xEFFFFFFF  //without time out

/******************************************************************************
 *****************************************************************************
 * CMS EXTERNAL COMMON ENUM
 *****************************************************************************
******************************************************************************/


/*
 * Signal ID between CMS task and other tasks
*/
typedef enum _SIG_EPAT_cmsSigId_Enum
{
    /*
     * 0x0900 - 0x09FF, reserved for CMS task signals
    */

    SIG_CMS_BASE = 0x0900,

    /*
     * 0x0900 - 0x090F, used between URAT/USB <-> CMS (AT CMD SRV)
    */
    AT_CMD_SIGNAL_BASE = 0x0900,
    SIG_AT_CMD_STR_REQ,     //AtCmdStrReq
    SIG_AT_CMD_CONTINUE_REQ,    //AtCmdContinueReq

    //SIG_AT_CMD_DATA_MODE_HS_REQ,
    SIG_AT_CMD_DATA_MODE_HS_CNF,


    AT_CMD_SIGNAL_END  = 0x090F,

    /*
     * 0x0910 - 0x091F, used between APP (LWM2M/COAP/MQTT, etc) <-> CMS(AT CMD SRV) (cms_comm.h)
    */
    APP_SIGNAL_BASE = 0x0910,
    SIG_CMS_APPL_REQ,       //CmsApplReq
    SIG_CMS_APPL_CNF,       //CmsApplCnf
    SIG_CMS_APPL_IND,       //CmsApplInd

    APP_SIGNAL_END  = 0x091F,

    /*
     * 0x0928 - 0x092F, used between SIMBIP <-> STK PS Proxy (psstk_bip.h)
    */

    /*
     * 0x0930 - 0x093F, used between CMS task <- IPC -> PHY for PHY/RF AT CMD (acmsgtype.h)
    */

    /*
     * 0x0940 - 0x095F, used for others CMS signal
    */
    SIG_CMS_OTHER_BASE = 0x0940,
    SIG_CMS_PHY_WAKEUP_READY_IND,   //usless for CAT1, OsaEmptySignal, after PHY wake up ready, send this signal to CMS to schedule PS tasks
    SIG_CMS_SYN_API_REQ,            //CmsSynApiReq
    SIG_CMS_HIGH_PRI_SYN_API_REQ,   //CmsSynApiReq, this called with high priority without any block in CMS task
    SIG_CMS_BLOCK_API_REQ,          //CmsBlockApiReq
    SIG_CMS_NON_BLOCK_API_REQ,      //CmsNonBlockApiReq
    SIG_CMS_APMU_SC_CALIBR_REQ,     // C2A_SLOWCLOCK_CALIBR_REQ
    SIG_CMS_APMU_SC_CALIBR_CANCEL_REQ,
    SIG_CMS_DCXO_NVM_UPDT_REQ,      // C2A_DCXO_NVM_UPDT_REQ
    SIG_CMS_AUXADC_REQ,             // C2A_AUXADC_REQ
    SIG_CMS_SEND_UART_STR_REQ,      // C2A_SEND_UART_STR_REQ
    SIG_CMS_UTC_TIME_REQ,           // C2A_UTC_TIME_REQ
    SIG_CMS_CP_BTOFFSET_UPD_REQ,	// CP indicate ap to update BT offset
    SIG_CMS_APMU_COMM_TEST_REQ,     // C2A_COMM_TEST_REQ
    SIG_CMS_CP_PAGING_EVENT_IND_ISR,    //CmsCpPagingEventIndIsr
    SIG_CMS_SIM_HOT_SWAP_IND,       //CmsSimHotSwapInd--fast signal
    //SIG_CMS_PMU_PS_WAKEUP_IND = 0x0950,
    SIG_CMS_PMU_PS_MODEM_START_IND,     //CmsPmuInd
    SIG_CMS_OTHER_END = 0x0960,

    /*
     * 0x0980 - 0x09FF, reserved for customer, an example
    */
    CUSTOMER_SIGNAL_BASE = 0x0980,
    SIG_CUSTOMER_MSG_CALLBACK,
    SIG_CUSTOMER_REQ,
    SIG_CUSTOMER_CNF,
    SIG_CUSTOMER_IND,
#ifdef __USER_CODE__
	SIG_CUSTOMER_LOG,
#endif
    CUSTOMER_SIGNAL_END = 0x09FF

}cmsSigId;

/*
 * CMS ERROR CODE, at_api/cms_api common return error code
*/
typedef enum CmsRetId_enum
{
    CMS_RET_SUCC = 0,

    CMS_FAIL            = -1,
    CMS_INVALID_PARAM   = -2,
    CMS_BUSY            = -3,
    CMS_LIST_FULL       = -4,
    CMS_LIST_NOT_FOUND  = -5,
    CMS_SEMP_ERROR      = -6,   //Semaphore not created/error
    CMS_TIME_OUT        = -7,
    CMS_SIM_NOT_INSERT  = -8,   //SIM not inserted
    CMS_OPER_NOT_SUPPROT    = -9,   //operation not supported
    CMS_SIM_WRONG       = -10,  //SIM wrong, excute command while returned invalid data
    CMS_NOT_POWER_ON    = -11,  //Not power on, maybe cfun0 state
    CMS_SIM_BUSY        = -12,  //SIM busy, cannot process any instruction
    CMS_NO_MEM          = -13,
    CMS_NO_RESOURCE     = -14,
    CMS_AT_SENT_FAIL    = -15,

    CMS_RET_CONTINUE    = -127, /* specical ERR ID */

}_CmsRetId;


/*
 * refer _CmsRetId
*/
typedef INT32 CmsRetId;



/*
 * APP layer ID, value: 0 - 255
 *  CmsApplCnf->header.appId
*/
typedef enum CmsAppLayerId_Enum
{
    APPL_BASE   = 1,
    APPL_NM     = 2,
    APPL_SOCKET = 3,
    APPL_MQTT   = 4,
    APPL_CTW    = 5,
    APPL_LWM2M  = 6,
    APPL_HTTP   = 7,
    APPL_SSL    = 8,
    APPL_DTLS   = 9,
    APPL_ECSOC  = 10,
    APPL_ONENET = 11,
    APPL_CTLWM2M = 12,
    APPL_ADC     = 13,
    APPL_EXAMPLE = 14,
    APPL_ECSRVSOC = 16,
    APPL_DM = 17,
    APPL_FWUPD = 18,

    /*
     * new APPL add here
    */
    APPL_ALARM    = 19,
    APPL_FILE    = 20,

    APPL_REF_SOC = 21,



    APPL_END    = 0xFF
}CmsAppId;


/*
 * ApplRetCode
 * value of "ApplRetCnf->header.rc"
 * Note:
 * 1> If some APP has their own error code, need to defined in their own header file, such as: at_sock_task.h
 * 2> But the "0" is reserved for SUCC
*/
typedef enum applRetCode_Enum
{
    APPL_RET_SUCC = 0,
    APPL_RET_FAIL = 1,
    APPL_RET_NETWORK_FAIL = 2,
    APPL_RET_END,
}ApplRetCode;


/*
 * LWM2M error code
*/

typedef enum AT_LWM2M_ERROR
{
    LWM2M_PARAM_ERROR = 1,                             //parameter error
    LWM2M_SEMPH_ERROR = 2,                             //cannot create semph
    LWM2M_CONFIG_ERROR = 3,                            //config error
    LWM2M_NO_FREE_CLIENT = 4,                          //no free client
    LWM2M_NO_FIND_CLIENT = 5,                          //no find client
    LWM2M_OPERATION_NOT_SUPPORT = 6,                   //operation not support
    LWM2M_ADDOBJ_FAILED = 7,                           //add object failed
    LWM2M_NO_FIND_OBJ = 8,                             //no find object
    LWM2M_DELOBJ_FAILED = 9,                           //delete object failed
    LWM2M_NO_NETWORK = 10,                             //network not ready
    LWM2M_INTER_ERROR = 11,                            //internal error
    LWM2M_REG_BAD_REQUEST = 12,                        //register fail bad request
    LWM2M_REG_FORBIDEN = 13,                           //register fail forbden
    LWM2M_REG_PRECONDITION = 14,                       //register fail parameter error
    LWM2M_REG_TIMEOUT = 15,                            //register fail timeout
    LWM2M_SESSION_INVALID = 16,                        //create session fail
    LWM2M_ALREADY_ADD = 17                             //already has object
}_AtLwm2mError;



typedef enum AT_CTLWM2M_ERROR
{
    CTLWM2M_OTHER_ERROR = 1,
    CTLWM2M_PARAM_NUM_ERROR = 2,
    CTLWM2M_PARAM_VALUE_ERROR = 3,
    CTLWM2M_TERMINAL_NOT_READY = 4,
    CTLWM2M_NOT_SUPPORT_SECURITY_MODE = 5,
    CTLWM2M_OPERATION_NOT_SUPPORT = 6,
    CTLWM2M_ADDOBJ_FAILED = 7,
    CTLWM2M_PARAM_NOT_INT = 8,
    CTLWM2M_DELOBJ_FAILED = 9,
    CTLWM2M_SEMPH_ERROR = 10,
    CTLWM2M_PARAM_LEN_OVERFLOW = 14,
    CTLWM2M_PLATFORM_NOT_READY = 15,
    CTLWM2M_DATALEN_NOT_EVEN = 17,
    CTLWM2M_NOT_ALLOWED_CONNECT  = 32,
    CTLWM2M_NOT_SEND_COMMAND  = 33,
    CTLWM2M_CREATE_SESSION_FAILED  = 34
}_AtCtLwm2mError;



/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/*
 * SigId: SIG_CMS_APPL_REQ
 *  Signal send to other APP task
*/
typedef struct CmsApplReq_Tag
{
    struct {
        UINT8       appId;      //CmsAppId
        UINT8       primId;     //prim ID in each APP group
        UINT16      srcHandler;
    }header;

    UINT8 body[];
}CmsApplReq;

/*
 * SigId: SIG_CMS_APPL_CNF
 * Signal sent from APP tasks
*/
typedef struct CmsApplCnf_Tag
{
    struct {
        UINT8       appId;      //CmsAppId
        UINT8       primId;     //prim ID in each APP group
        UINT16      srcHandler; //Handler
        UINT16      rc;
        UINT16      rsvd;
    }header;

    UINT8 body[];
}CmsApplCnf;

/*
 * SigId: SIG_CMS_APPL_IND
 * Signal sent from APP tasks
*/
typedef struct CmsApplInd_Tag
{
    struct {
        UINT8       appId;      //CmsAppId
        UINT8       primId;     //prim ID in each APP group

        /*
         * As some indication is triggered by some AT request, in such as need to fill this "reqHandler",
         *  otherwise set to "BROADCAST_IND_HANDLER".
        */
        UINT16      reqHandler;
    }header;

    UINT8 body[];
}CmsApplInd;



/*
 * SigIg: SIG_PMU_IND
 * Signal: send from pmu module to cms task
*/
typedef struct CmsPmuIndTag
{
    UINT16      indId;
    UINT16      reserved;
}CmsPmuInd;

/*
 * SigIg: SIG_CMS_SIM_HOT_SWAP_IND
 * Signal: send from APP tasks or ISR to cms task
*/
typedef struct CmsSimHotSwapIndTag
{
    BOOL        bSimPlugIn;// indicated whether the SIM card plugged in or out
    UINT8       reserved1;
    UINT16      reserved2;
}CmsSimHotSwapInd;


/*
 * SigId: SIG_CUSTOMER_CNF, used as an example
*/
typedef struct custRetCnfTag
{
    struct {
        UINT16      cnfId;
        UINT16      srcHandler; //Handler from CamCmiReq
        UINT16      rc;
        UINT16      reserved;
    }header;

    UINT8 body[];
}custRetCnf;

/*
 * SigIg: SIG_CUSTOMER_IND, used as an example
*/
typedef struct custRetIndTag
{
    struct {
        UINT16      indId;
        UINT16      srcHandler;
        UINT16      rc;
        UINT16      reserved;
    }header;

    UINT8 body[];
}custRetInd;





/******************************************************************************
 *****************************************************************************
 * CMS EXTERNAL API
 *****************************************************************************
******************************************************************************/

/*
 * init and create CMS task
*/
void cmsTaskInit(void);

/*
 * APP send the "SIG_CMS_APPL_CNF" to CMS task
*/
CmsRetId applSendCmsCnf(UINT16 reqHandler, UINT16 rcCode, UINT8 appId, UINT8 primId, UINT16 primSize, void *pPrimBody);

/*
 * APP send the "SIG_CMS_APPL_IND" to CMS task
*/
CmsRetId applSendCmsInd(UINT16 reqHandler, UINT8 appId, UINT8 primId, UINT16 primSize, void *pPrimBody);

/*
 * Pmu Module send the "SIG_CMS_PMU_PS_WAKEUP_IND" to CMS task
*/
CmsRetId apmuWakeupPsNoneBlock(void);

/*
 * Pmu Module send the "SIG_CMS_PMU_PS_MODEM_START_IND" to CMS task
*/
CmsRetId apmuSendCmsCpStartSig(void);

/*
 * must remove later - TBD
*/
//CmsRetId appCallbackWithNoBlock(app_callback_fn function, void *ctx);;

/**
  \fn           void cmsStartPs(void)
  \brief        start protocl stack (tasks), if PS is not ready
  \returns      void
  \Note: a) could only be called in task.
  \      b) this is a blocked (sync) API, after PS task started, than return
  \      c) if the caller not want to blocked, please call: cmsStartPsNonBlock()
*/
void cmsStartPs(void);

/**
  \fn           void cmsStartPs(void)
  \brief        start protocl stack (tasks), if PS is not ready
  \returns      void
  \Note: a) could only be called in task.
  \      b) this is a non blocked API, API return, not means PS is already
*/
void cmsStartPsNonBlock(void);

/**
  \fn           BOOL cmsIsPsReady(void)
  \brief        Whether protocol stack is ready to send/recv signals
  \returns      BOOL
*/
BOOL cmsIsPsReady(void);


#endif

