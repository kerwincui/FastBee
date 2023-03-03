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
#ifndef __ATC_REPLY_H__
#define __ATC_REPLY_H__

#include "commontypedef.h"
#include "atc_decoder.h"
#include "pspdu.h"

/******************************************************************************
 *   +-----+                +-----+
 *   | DTE | --> AT CMD --> | DCE |
 *   +-----+                +-----+
 *
 * V.250: Table 3/V.250 ¨C Effect of V parameter on response formats
 * 1> Two types of responses: "information text" and "result codes"
 *  A) "information text" three parts: a header, text, and a trailer
 *     a> ATV0: <text><S3><S4>            (normal: <text>\r\n)
 *     b> ATV1: <S3><S4><text><S3><S4>    (normal: \r\n<text>\r\n)
 *     c> information text returned in response to manufacturer-specific commands
 *        may contain multiple lines, may therefore include: CR,LF (\r\n)
 *
 *  B) "result codes" three parts: a header, the result text, and a trailer
 *     a> ATV0: <numeric code><S3>        (normal: <numeric code>\r)
 *         example: 0\r (OK)
 *
 *     b> ATV1: <S3><S4><verbose code><S3><S4>    (normal: \r\n<verbose code>\r\n)
 *         example: \r\nOK\r\n
 *
 *     c> Three types of result codes: "final", "intermediate", and "unsolicited".
 *        i> "final": indicates the completion of a full DCE action and a willingness
 *                    to accept new commands from the DTE
 *        ii> "intermediate": suc as: the DCE moves from "command state" to
 *                            "online data state", and issues a: "CONNECT"
 *        iii> "Unsolicited": URC
 *
 *  C) "Extended syntax result codes"
 *     a> "extended syntax result codes" format is the same as "result codes" regard to
 *        headers and trailers; (Note: also controlled by ATV)
 *     b> "extended syntax result codes" have no numeric equivalent,
 *        and are always issued in alphabetic form, so only: ===  ATV1 ===?
 *     c> "Extended syntax result codes" may be:
 *         "final", "intermediate", "unsolicited"
 *     d> "Extended syntax result codes" shall be prefixed by the "+" character
 *        example: \r\n+<name>\r\n  => \r\n+CME ERROR: <err>\r\n
 *
 *  D) "Information text formats for test commands"
 *    example:
 *     a> (0)
 *     b> (0,1,4)
 *     c> (1-5)
 *     d> (0,4-6,9,11-12)
******************************************************************************/

/******************************************************************************
 * 1. Additional commands may follow an extended syntax command on the same command line if a
 *    semicolon (";", IA5 3/11) is inserted after the preceding extended command as a separator.
 * 2. Extended syntax commands may appear on the same command line after a basic syntax command
 *    without a separator
 * 3. So whether a basic syntax command could be following after an command? - maybe can't --TBD
 *
 * Example:
 * AT command:
 *  ATCMD1 CMD2=12; +CMD1; +CMD2=,,15; +CMD2?; +CMD2=?<CR>
 *  ^basic|       |                                    ^
 *        ^       ^                                    |
 * ================================================================
 * Information responses and result codes:
 * A) If ATV1 (default)
 *    <CR><LF>+CMD2: 3,0,15,"GSM"<CR><LF>   --> information text
 *    <CR><LF>+CMD2: (0-3),(0,1),(0-12,15),("GSM","IRA")<CR><LF>    --> information text
 *    <CR><LF>OK<CR><LF>                    --> final result code
 * B) If ATV0
 *    +CMD2: 3,0,15,"GSM"<CR><LF>           --> information text
 *    +CMD2: (0-3),(0,1),(0-12,15),("GSM","IRA")<CR><LF>    --> information text
 *    0<CR>                                 --> final result code
 *
 * =============================================================
 * Error command, or process error, response:
 * A) If command is not accepted/right, such cases:
 *     a> command itself is invalid, as: ATBCDFG
 *     b> command cannot be performed for some reasons, such as:
 *        i>  one or more mandatory values are omitted, or
 *        ii> one or more values are of the wrong type or
 *        iii> outside the permitted range.
 *   if AT1:
 *     <CR><LF>ERROR<CR><LF>                --> final result code
 *   if AT0
 *     4<CR>                                --> final result code
 * B) If command was not processed due to an error related to MT operation,
 *    response (no matter the ATV value):
 *    <CR><LF>+CME ERROR: <err><CR><LF>
 *
******************************************************************************/


/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/
//basicResultStr
#define ATC_BASIC_RESULT_STR_LEN        64
#define ATC_EXTENDED_RESULT_STR_LEN     128
#define ATC_IND_RESP_MAX_STR_LEN        8192


#define ATC_SUCC_CODE               0

/******************************************************************************
 *****************************************************************************
 * Enum & structure
 *****************************************************************************
******************************************************************************/
/*
 * <n>: integer type.
 *  0 disable +CME ERROR: <err> result code and use ERROR instead
 *  1 enable +CME ERROR: <err> result code and use numeric <err> values (refer subclause 9.2)
 *  2 enable +CME ERROR: <err> result code and use verbose <err> values (refer subclause 9.2)
*/
typedef enum AtcCMEERetType_Enum
{
    ATC_CMEE_DISABLE_ERROR_CODE = 0,
    ATC_CMEE_NUM_ERROR_CODE,
    ATC_CMEE_VERBOSE_ERROR_CODE
}AtcCMEERetType;


/*
 * REFER: V.250, 5.7.1, Table 1/V.250 esult codes
*/
typedef enum AtResultCode_Tag
{
    AT_RC_OK = 0,           /* 1> AT command done/acknowledged, guard timer should stop
                             * 2> add "\r\n" at start&end of response
                             * 3> add "\r\nOK\r\n" after response
                            */
    AT_RC_CONNECT = 1,      /* A connection has been established;
                               the DCE is moving from command state to online data state */
    AT_RC_RING = 2,         /* An incoming call signal from the network, -- not used now */
    AT_RC_NO_CARRIER = 3,   /* The connection has been terminated or the attempt to establish
                               a connection failed*/
    AT_RC_ERROR = 4,        /* Command not recognized, command line maximum length exceeded,
                               parameter value invalid, or other problem with processing the command line*/
    AT_RC_NO_DIALTONE = 6,  /* No dial tone detected, -- not used now*/
    AT_RC_BUSY = 7,         /* Engaged (busy) signal detected -- not used now*/

    AT_RC_NO_ANSWER = 8,    /* (Wait for Quiet Answer) dial modifier was used, but
                               remote ringing followed by five seconds of silence was not
                               detected before expiration of the connection timer -- not used now */

    /*
     * Extended syntax result codes:
    */
    AT_RC_CONTINUE = 10,    /* 1> AT procedure not finished/continued, guard timer should not stop
                             * 2> only add: "\r\n" at start of response
                             *    example: <CR><LF>+CGPADDR: <cid>[,<PDP_addr_1>[,<PDP_addr_2>]]            ==> AT_RC_CONTINUE
                             *             <CR><LF>+CGPADDR: <cid>,[<PDP_addr_1>[,<PDP_addr_2>]]<S3><S4>    ==> AT_RC_OK
                            */
    AT_RC_NO_RESULT = 11,   /* 1> AT command done, guard timer should stop,
                             * 2> but no "result code" ("\r\nOK\r\n") replied/printed
                             * 3> add "\r\n" at start&end of response
                            */
    AT_RC_RAW_INFO,         /* 1> AT command done, guard timer should stop
                             * 2> but no "result code" ("\r\nOK\r\n") replied/printed
                             * 3> not add "\r\n"
                            */
    AT_RC_RAW_INFO_CONTINUE,/* 1> AT procedure not finished/continued, guard timer should not stop,
                             * 2> not add "\r\n"
                            */

    AT_RC_CME_ERROR,        /* +CME ERROR */
    AT_RC_CMS_ERROR,        /* +CMS ERROR */



    AT_RC_CUSTOM_ERROR = 20,
    AT_RC_HTTP_ERROR,           //Timer will Stop, +HTTP ERROR
    AT_RC_SOCKET_ERROR,         //Timer will Stop, +SOCKET ERROR
    AT_RC_MQTT_ERROR,           //Timer will Stop, +MQTT ERROR
    AT_RC_DM_ERROR,             //DM ERROR
    AT_RC_ADC_ERROR,            //ADC ERROR
    AT_RC_EXAMPLE_ERROR,        //EC ERROR
    AT_RC_ECSOC_ERROR,          //Timer will Stop, +CME ERROR
    AT_RC_ECSRVSOC_ERROR,       //EC server soc error
    AT_RC_REFSOC_ERROR,          //Timer will Stop, ERROR
    AT_RC_REFPS_ERROR = AT_RC_REFSOC_ERROR,  //Timer will Stop, ERROR
    AT_RC_FILE_ERROR,           //File ERROR
    AT_RC_SSL_ERROR,            //Timer will Stop, +SSL ERROR
    AT_RC_FWUPD_ERROR,          //FWUPD ERROR
    AT_RC_CTW_ERROR,            //CTW ERROR
}AtResultCode;


/*
 * AT URC type
*/
typedef enum AtUrcType_enum
{
    AT_OTHER_URC    = 0,
    AT_SMS_URC,
    AT_RING_URC
}AtUrcType;

/*
 * AT reply/URC PDU mode
*/
typedef struct AtOutPdu_Tag
{
    DlPduBlock  *pPdu;

    /*
     * |<---------------- pPdu->length ----------------->|
     * +-+-+---------------+-----------------------+-+-+-+
     * | | |+CEREG: 2,0\r\n                        | | | |
     * +-+-+---------------+-----------------------+-+-+-+
     * ^    ^               ^                       ^
     * |    |startOffset    |inOffset               |endOffset
     * |pPdu->pPdu
     *
     * Note:
     * 1> Two bytes reserved in header for "\r\n"
     * 2> Three bytes reserved at end for "\r\n\0"
    */
    BOOL        bFail;      /* whether AT out PDU print OK */
    UINT8       rsvd;

    UINT16      startOffset;
    UINT16      inOffset;
    UINT16      endOffset;
}AtOutPdu;  // 12 bytes

/******************************************************************************
 *****************************************************************************
 * external API
 *****************************************************************************
******************************************************************************/

/*
 * AT REPLY
*/
CmsRetId atcReply(UINT16 srcHandle, AtResultCode resCode, UINT32 errCode, const CHAR *pRespInfo);

/*
 * AT URC
 * Note:
 * 1> In this API, will add: "\r\n" at start/end of URC string.
*/
CmsRetId atcURC(UINT32 chanId, const CHAR *pUrcStr);

/*
 * AT SMS MT URC
 * Note:
 * 1> In this API, will add: "\r\n" at start/end of URC string.
 * 2> MT SMS URC: +CMTI, +CMT, +CDS, +CBM
*/
CmsRetId atcSmsURC(UINT32 chanId, const CHAR *pUrcStr);


/*
 * send the result code string
*/
CmsRetId atcSendResultCode(AtChanEntity *pAtChanEty, AtResultCode resCode, const CHAR *pResultStr);

/*
 * send echo string
*/
CmsRetId atcEchoString(AtChanEntityP pAtChanEty, const CHAR *pStr, UINT32 strLen);

/*
 * Send response string: "pStr" via AT channel, without any modification, or suppression
*/
CmsRetId atcSendRawRespStr(AtChanEntity *pAtChanEty, const CHAR *pStr, UINT32 strLen);

/*
 * whether URC API configured
*/
BOOL atcBeURCConfiged(UINT32 chanId);

/*
 * AT REPLY in PDU.
 * Note: pAtPdu will send to Tx task in this API, if want to re-use, need to call: atPduInit() to init again.
*/
CmsRetId atcPduReply(UINT16 srcHandler, AtResultCode resCode, UINT32 errCode, AtOutPdu *pAtPdu);

/*
 * AT URC in PDU
 * Note:
 * 1> pAtPdu will send to Tx task in this API, if want to re-use, need to call: atPduInit() to init again.
 * 2> In this API, will add: "\r\n" at start/end of URC string.
*/
CmsRetId atcPduURC(UINT32 chanId, AtOutPdu *pAtPdu);


/*
 * 1> "DlPduBlock" not changed any in this API, only send the "DlPduBlock"
 *     to Tx task (or RIL APP task) transparently
 * 2> As the "DlPduBlock" is sent, tha caller can't use it anymore
*/
CmsRetId atcRawPduURC(UINT32 chanId, DlPduBlock *pPdu);

/*
 * Diff with atcURC():
 * a) URC maybe pended in URC list when AT channel in data state, but not in this API
 * b) URC maybe pended when one AT command is ongoing (not replied), but not in this API
 * c) "\r\n" will be added at the beginning\ending of URC in API: atcURC(), but not in this API
*/
CmsRetId atcPassThrough(UINT32 chanId, const UINT8 *pData, UINT32 length);

/*
 * Diff with atcRawPduURC():
 * a) URC maybe pended in URC list when AT channel in data state,
 * b) URC maybe pended when one AT command is ongoing (not replied), but
 * c) this API no such limitions, just pass the PDU to Tx task
*/
CmsRetId atcPduPassThrough(UINT32 chanId, DlPduBlock *pPdu);

/*
 * AT action, after one AT line done
*/
CmsRetId atcLineEndProc(UINT32 chanId, AtResultCode resCode);

/**
  \brief        Only used in case of sending "OK"/etc, when exist online data state
  \Note:
  \ 1> Example: when in PPP online data state, if recv '+++'(or DTR event),
  \     AT channel should enter: ATC_ONLINE_COMMAND_STATE. and reply "OK".
  \ 2> Why not using "atcURC()"? as the string result "OK" should be changed to numeric format: 0 if ATV0 configed
  \     and URC maybe cached/delayed, so involved this new API
*/
CmsRetId atcResultCode(UINT32 chanId, AtResultCode resCode);

/*
 * check whether any URC need to flush to send out
 * API called in CMS task
*/
void atcCheckFlushUrc(UINT8 chanId);

/*
 * URC RI done callback
*/
void atcUrcRiDoneCallback(UINT16 paramSize, void *pParam);

/*
 * AT URC delaty timer expiry, URC could be flush/Tx
*/
void atcUrcDelayTimerExpiry(UINT16 timeId);


#endif

