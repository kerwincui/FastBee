#ifndef __MW_NVM_SMS_H__
#define __MW_NVM_SMS_H__
/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    mw_nvm_sms.h
 * Description:  middleware NVM SMS header file
 * History:      2021/05/24, Originated by glwu
 ****************************************************************************/
#include "osasys.h"
#include "mw_common.h"
#include "cmisms.h"
#include "ps_sms_if.h"

/*
 * Differences between these MW config/AON files:
 * 1> mw_nvm_config.h
 *   a) parameter value is still VALID, after reboot.
 *   b) parameter value is still VALID, after FOTA (SW upgrading) if not erase the NVM in flash.
 *   c) if not configed in NVM/flash, use the default value.
 * 2> mw_nvm_info.h
 *   a) parameter value is still VALID, after reboot.
 *   b) parameter value is not VALID (reset to default value), after FOTA (SW upgrading), if:
 *       i> NVM in flash is erased, or
 *       ii> NVM info structure size is changed, or
 *       ii> NVM file version is changed.
 *   c) if not configed in NVM/flash, use the default value.
 * 3> mw_aon_info.h
 *   a) parameter value is still VALID, after wakeup from deep sleep
 *   b) parameter value is not VALID, after reboot
 * 4> mw_common.h
 *   a) middleware common header file, which included by "mw_nvm_config.h"&"mw_nvm_info.h"&"mw_aon_info.h"
 *   b) As customers maybe have different requirements about how to maintain the config,
 *      here could set the common structure in this file
 * 2> mw_nvm_sms.h
 *   a) parameter value is still VALID, after reboot.
 *   b) parameter value is not VALID (reset to default value), after FOTA (SW upgrading), if:
 *       i> NVM in flash is erased, or
 *       ii> NVM info structure size is changed, or
 *       ii> NVM file version is changed.
*/


/******************************************************************************
 *****************************************************************************
 * MARCO/MARCO
 *****************************************************************************
******************************************************************************/
/*
 *
*/
#define MID_WARE_NVM_SMS_FILE_NAME     "mwsms.nvm"

#define MID_WARE_NVM_SMS_CUR_VER       0x0

#define MID_WARE_NVM_SMS_REC_MAX_SIZE  10


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/
/* SMS message shall be stored with PDU mode,
 * the SC address and SMS status shall be saved together with message context
 */
typedef struct _EPAT_MWNvmSmsStorRecord_Tag
{
    BOOL                    isValid;        /* SMS record is valid or not */
    UINT8                   smsRecStatus;   /* SMS record status. Enum CmiSmsRecStorStatus */
    UINT8                   smsRecMsgType;  /* SMS message type, defined type CmiSmsMessageType */
    BOOL                    scAddrPresent;  /* SC Address info present or not */
    CmiSmsAddressInfo       scAddrInfo;     /* SC address info */
    CmiSmsPdu               smsPduData;     /* SMS PDU contents */
}MWNvmSmsStorRecord;

/*
 * Useless, if struct size is changed, or NVM version changed
*/
typedef struct _NVM_EPAT_mwsms
{
    UINT8                   smsStorBoxSize;  /* Total number of message which will be saved in memory */
    UINT8                   smsStoredNumber; /* Number of message currently stored in memory */
    UINT16                  reserved0;
    MWNvmSmsStorRecord      smsNvmStorBox[MID_WARE_NVM_SMS_REC_MAX_SIZE];
}MidWareNvmSms;


/******************************************************************************
 *****************************************************************************
 * API
 *****************************************************************************
******************************************************************************/

BOOL mwNvmSmsRead(MidWareNvmSms  *pMwNvmSms);

void mwNvmSmsSave(MidWareNvmSms * pWriteMwNvmSms);

UINT8 mwNvmSmsGetUsedNumber(void);
BOOL mwNvmSmsGetRecByIndex(UINT8 index, MWNvmSmsStorRecord *pSmsRecord);

BOOL mwNvmSmsUpdateAndSaveRecByIndex(UINT8 index, MWNvmSmsStorRecord *pSmsRecord);
BOOL mwNvmSmsAddAndSaveRec(MWNvmSmsStorRecord *pSmsRecord, UINT8 *pIndex);
BOOL mwNvmSmsDelAndSaveRecByIndex(UINT8 index);
BOOL mwNvmSmsDelRecByStatus(CmiSmsRecStorStatus delStatus, MidWareNvmSms * pMwNvmSms);
BOOL mwNvmSmsDelAndSaveRecByStatus(CmiSmsRecStorStatus delStatus);
UINT8 mwNvmSmsGetUsedList(UINT8 *pUsedList);

#endif /* __MW_NVM_SMS_H__ */


