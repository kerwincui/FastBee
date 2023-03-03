/******************************************************************************
 * (C) Copyright 2018 AirM2M International Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: at_api.h
 *
 *  Description: AT CMD entity/task (in CMS task) api
 *
 *  History:
 *
 *  Notes: All other tasks if need to use AT CMD functions, should ONLY include this header file
 *
******************************************************************************/
#ifndef __AT_API_H__
#define __AT_API_H__

#include "cms_api.h"
#include "at_def.h"

/******************************************************************************
 *****************************************************************************
 * EXTERNAL COMMON MARCO
 *****************************************************************************
******************************************************************************/
#define AT_CHAN_NAME_SIZE   8
#define AT_UART_PRINT_MAX   256


#define UARTAT_CHAN_NAME          "UARTAT"
#define UARTAT_CHAN_NAME_LEN      6

#define USBAT_CHAN_NAME           "USBAT"
#define USBAT_CHAN_NAME_LEN       5

#define USBPPP_CHAN_NAME          "USBPP"
#define USBPPP_CHAN_NAME_LEN      5

/*
 * DEFAULT AT CHANNEL NAME, if registered, assign the fixed chanID: AT_CHAN_DEFAULT
 * USB AT is set to default channel
*/
#define AT_DEFAULT_CHAN_NAME      USBAT_CHAN_NAME
#define AT_DEFAULT_CHAN_NAME_LEN  USBAT_CHAN_NAME_LEN


/*
 * AT CMD MAC string size
*/
#define AT_CMD_STR_MAX_LEN                  3072

/*
 * Return the succ sent length.
 * 1> if all sent to CCIO Tx task, return: strLen
 * 2> if failed, return < 0
*/
typedef INT32 (*AtRespFunctionP)(UINT8 chanId, const CHAR *pStr, UINT32 strLen, void *pArg);
typedef INT32 (*AtUrcFunctionP)(UINT8 chanId, const CHAR *pStr, UINT32 strLen);

/*
 * AT resp and URC interface, the resp/urc string is carried in "DlPduBlock", and "DlPduBlock" should be freed in caller.
 * Return the succ sent length.
 * 1> if all sent to CCIO Tx task, return: DlPduBlock->length
 * 2> if failed, return < 0
*/
typedef INT32 (*AtRespPduFunctionP)(UINT8 chanId, DlPduBlock *pPdu, void *pArg);
typedef INT32 (*AtUrcPduFunctionP)(UINT8 chanId, DlPduBlock *pPdu);


/******************************************************************************
 *****************************************************************************
 * EXTERNAL COMMON STRUCT
 *****************************************************************************
******************************************************************************/

/*
 * SigId: SIG_AT_CMD_STR_REQ
*/
typedef struct AtCmdStrReq_Tag
{
    UINT8       atChanId;       //AT channel ID
    UINT8       rsvd0;

    #if 0   //if AT STRING need to pass a copy in the signal, not suggest
    UINT16      atStrLen;
    UINT8       atStr[];
    #else
    UINT16      atStrLen;
    CHAR        *pAtStr;        //memory allocated in heap by OsaAllocateMemory()
    #endif
}AtCmdStrReq;


/*
 * SigId: SIG_AT_CMD_DATA_MODE_HS_CNF */
typedef struct AtCmdDataModeHSCnf_Tag
{
    UINT8       atChanId;       //AT channel ID
    UINT8       rsvd[3];
}AtCmdDataModeHSCnf;


/*
*/
typedef struct AtChanRegInfo_tag
{
    CHAR    chanName[AT_CHAN_NAME_SIZE];

    AtRespFunctionP atRespFunc;
    void            *pRespArg;  //passed in atRespFunc(chanId, str, pRespArg), or atRespPduFunc(chanId, pdu, pRespArg);

    AtUrcFunctionP  atUrcFunc;

    /*
     * AT RESP/URC PDU mode, the resp/urc string is carried in "DlPduBlock", and "DlPduBlock" should be freed in caller
     * 1> "atRespFunc" & "atUrcFunc" is must, and "atRespPduFunc"/"atUrcPduFunc" is optional
     * 2> "atRespPduFunc"/"atUrcPduFunc" is more efficient, expecially for longer RESP/URC string
     * 3> "DlPduBlock" should be freed in caller via API: OsaFreeDlPduBlockList()
    */
    AtRespPduFunctionP atRespPduFunc;
    AtUrcPduFunctionP  atUrcPduFunc;
}AtChanRegInfo; //28 bytes


/*
 * SIGID: SIG_AT_CMD_CONTINUE_REQ
*/
typedef struct AtCmdContinueReq_tag
{
    UINT8       atChanId;       //AT channel ID
    UINT8       rsvd0;
    UINT16      rsvd1;
}AtCmdContinueReq;


/*
*/
typedef struct AtRilAtCmdReqData_Tag
{
    CHAR    *pCmdLine;      /* memory alloacted in heap by: OsaAllocateMemory() */

    UINT16  cmdLen;
    UINT16  rsvd;

    AtRespFunctionP     respCallback;
    void    *respData;
}AtRilAtCmdReqData; //16 bytes

/******************************************************************************
 *****************************************************************************
 * EXTERNAL API
 *****************************************************************************
******************************************************************************/

/*
 * register a AT channel;
 * 1> if succ, return the "channId" (>=0);
 * 2> else, return "CmsRetId" (< 0)
*/
INT32 atRegisterAtChannel(AtChanRegInfo *pAtRegInfo);

/*
 * deregister AT channel by AT channel ID
*/
void atDeRegisterAtChannel(UINT8 atChanId);

/*
 * send the AT command to AT CMD task: CMS_TASK_ID
*/
void atSendAtcmdStrSig(UINT8 atChanId, const UINT8 *pCmdStr, UINT32 len);

/*
 * send the DATA MODE Handshake cnf to AT CMD task: CMS_TASK_ID
*/
void atSendAtcmdDataModeHSCnfSig(UINT8 atChanId);

/*
 * at UART print callback
*/
void atUartPrintCallback(UINT16 paramSize, void *pParam);

/*
 * print LOG to AT UART port
*/
#define atUartPrint(fmt, ...)                                   \
do {                                                            \
    CHAR *PSTRUARTPRINT = (CHAR *)OsaAllocMemory(AT_UART_PRINT_MAX);     \
    if (PSTRUARTPRINT == PNULL)                                          \
    {                                                           \
        OsaDebugBegin(FALSE, AT_UART_PRINT_MAX, 0, 0);          \
        OsaDebugEnd();                                          \
    }                                                           \
    else                                                        \
    {                                                           \
        snprintf(PSTRUARTPRINT, AT_UART_PRINT_MAX, fmt, ##__VA_ARGS__);      \
                                                                \
        cmsNonBlockApiCall(atUartPrintCallback, sizeof(void *), &PSTRUARTPRINT); \
    }   \
}while(FALSE)


/*
 * AT RIL API
*/
CmsRetId atRilAtCmdReq(const CHAR *pAtCmdLine, UINT32 cmdLen, AtRespFunctionP respCallback, void *respData, UINT32 timeOutMs);

/*
 * register AT RIL URC callback
*/
CmsRetId atRilRegisterUrcCallback(AtUrcFunctionP urcCallback);

/*
 * unregister AT RIL URC callback
*/
CmsRetId atRilDeRegisterUrcCallback(void);

/*
 * get dtr (Data Terminal Ready) config: AT&D value
 * Comment: called by CCIO
*/
UINT8 atGetDtrCfg(UINT8 atChanId);

/*
 * get dcd (Data Carrier Detect) config: AT&C value
 * Comment: called by CCIO
*/
UINT8 atGetDcdCfg(UINT8 atChanId);

/*
 * get DCD (Data Carrier Detect) state: TRUE - DCD on (low level), FALSE - DCD off (High level)
 * Comment: called by CCIO
*/
BOOL atGetDcdState(UINT8 atChanId);

/*
 * whether there is an RI type is enablee : TRUE - At least one of the RI Type is not "off", FALSE - All RI Type is "off".
 * Comment: called by CCIO
*/
BOOL atIsRITypeEnable(UINT8 atChanId);

/*
 * Indicate the RING IND operation is done
 * Comment: called by CCIO
*/
void atRingIndDone(UINT8 atChanId);

/*
 * notify AT the DTR (Data Terminal Ready) event: on-to-off transition
 * Comment: called by CCIO
*/
void atDtrEventInd(UINT8 atChanId);


#endif

