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
#ifndef __ATC_DECODER_H__
#define __ATC_DECODER_H__

#include "osasys.h"
#include "at_api.h"


/******************************************************************************
 *   +-----+                +-----+
 *   | DTE | --> AT CMD --> | DCE |
 *   +-----+                +-----+
 *
 *   +-----+                +-----+             +-----+
 *   |  TE | --> AT CMD --> |  TA |-->MT ctrl-->| MT  |
 *   +-----+                +-----+             +-----+
 *  TE: Terminal Equipment
 *  TA: Terminal Adaptor
 *  MT: Mobile Termination
 *
 * V.250
 * 1. Two types of commands: "action commands" and "parameter commands".
 *   A) "action commands" maybe: "executed" or "tested";
 *       example: AT+CMD1           //"executed"
 *                AT+CMD1=<param>   //"executed"
 *                AT+CMD1=?         //"tested"
 *                AT+CMD1?  (ERROR)
 *   B) "parameter commands" maybe: "set", "read", or "tested";
 *       example: AT+CMD2=<param>   //"set"
 *                AT+CMD2?          //"read"
 *                AT+CMD2=?         //"tested"
 *
 *=============================================================================
 * 1. <value> shall consist of either a "numeric" constant or a "string" constant.
 *  A) "numeric constants" are expressed in "numValue", "hexadecimal", or "binary"
 *     a) "numValue": "0" - "9"
 *     b) "hexadecimal": "0"-"9", "A"-"F", "a"-"f", should not contain: "0x"
 *     c) "binary": "0"-"1"
 *  B) "string"
 *     a) String constants shall consist of displayable displayable, in the range from
 *        0x20 (Space or blank) to 0x7F (delete), inclusive, except for the characters:
 *        """ and "\"
 *     a) String constants shall be bounded at the beginning and end by the
 *        ouble-quote character: "
 *     b) Any character value may be included in the string by representing it
 *        as a backslash ("\") character followed by two hexadecimal digits;
 *        example: "\" => "\5C"
 *                 <CR> => "\0D"
 *                 """  => "\22"
 *
 *==============================================================================
 * 1. A command line is made up of three elements: the prefix, the body, and the termination character.
 * 2. The command line prefix consists of the characters "AT" (IA5 4/1, 5/4) or "at" (IA5 6/1, 7/4), or,
 *    to repeat the execution of the previous command line, the characters "A/" (IA5 4/1, 2/15) or "a/"
 *    (IA5 6/1, 2/15).
 * 3. The body is made up of individual commands, Space characters (IA5 2/0) are ignored and may be used
 *    freely for formatting purposes, unless they are embedded in numeric or string constants (see 5.4.2.1 or 5.4.2.2).
 *    The termination character may not appear in the body.
 * 4. The termination character may be selected by a user option (parameter S3),
 *    the default being CR (IA5 0/13).
******************************************************************************/


/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/


/*
 * ignore: <SP>
*/
#define AT_IGNORE_SPACE_CHAR(pChr, pEnd)                                \
do {                                                                    \
    while (((*(pChr)) == ' ') && ((UINT32)(pChr) < (UINT32)(pEnd)))     \
        (pChr)++;                                                       \
}while(FALSE)

/*
 * ignore: <SP><S3><S4>
*/
#define AT_IGNORE_SPACE_S3_S4_CHAR(pChr, S3, S4, pEnd)                  \
do {                                                                    \
    while (((*(pChr)) == ' ' || (*(pChr)) == (S3) || (*(pChr)) == (S4)) && ((UINT32)(pChr) < (UINT32)(pEnd)))   \
        (pChr)++;                                                       \
}while(FALSE)



/*
 * AT channel real number, this ID:0 is reserved for internal, so the real number should: CMS_CHAN_NUM -1
*/
#define  ATC_CHAN_REAL_ENTITY_NUM       (CMS_CHAN_NUM-1)



/*
 * Time out value for a AT CMD,
 * When time out, just return ERROR
*/
#define AT_DEFAULT_TIMEOUT_SEC    ((UINT16)5)  //5*sys tick

#define AT_CMD_PARAM_MAX_NUM        32      //max parameters number
#define AT_CMD_MAX_NAME_LEN         32


#define AT_CMD_MAX_PENDING_STR_LEN      8192        //MAX pending 8KB AT CMD
#define AT_CMD_MAX_PENDING_NODE_NUM     64          //MAX pending AT CMD input string node


/*
 * S-parameter and special AT charcters
*/
#define AT_S3_CMD_LINE_TERM_CHAR_DEFAULT    '\r'
#define AT_S4_RESP_FORMAT_CHAR_DEFAULT      '\n'
#define AT_S5_CMD_LINE_EDIT_CHAR_DEFAULT    0x08
#define AT_SEPA_PARM_COMMA_CHAR             ','     /*separator between compound values*/
#define AT_SEPA_CMD_SEMICOLON_CHAR          ';'
#define AT_EXT_CMD_PLUS_CHAR                '+'
#define AT_EXT_CMD_STAR_CHAR                '*'
#define AT_EXT_CMD_CARET_CHAR               '^'
#define AT_SMALLEST_VALID_CHAR              0x20

#define AT_BE_VALID_CHAR(chr)   \
    ((chr) >= 0x20 || (chr) == '\r' || (chr) == '\n')


/*
 *
*/
#define AT_BE_EXT_CMD_CHAR(cr)        \
    ((cr) == AT_EXT_CMD_PLUS_CHAR || (cr) == AT_EXT_CMD_STAR_CHAR || (cr) == AT_EXT_CMD_CARET_CHAR)


/*
 * set by ATS3/ATS4/ATS5
*/
#define AT_S3_CMD_LINE_TERM_CHAR_IDX     (0)        /* S3, Command line termination character, default: \r <CR> */
#define AT_S4_RESP_FORMAT_CHAR_IDX       (1)        /* S4, Response formatting character, default: \n <LF> */
#define AT_S5_CMD_LINE_EDIT_CHAR_IDX     (2)        /* S5, Command line editing character, default: Backspace <BS>, useless now */

#define AT_S_PARM_NUM               (4)

#if 0
/*
 * DEFAULT AT CHANNEL maybe not need to do "channel register" procedure,
 *  just set the default config/callback here
*/
#define AT_DEFAULT_CHAN_NAME     "UARTAT"
#endif

/*
 * AT RIL API CHANNEL not need to do "channel register" procedure,
*/
#define AT_RIL_API_CHAN_NAME     "RILAPI"

/*
 * For some solution (PMU enabled), UART maybe down, use this handshake string, to let MCU/PC know
 *  the chip is wake uped.
 * MCU/PC -> UE: "HDSK"
 * UE -> MCU/PC: "KSHD\r\n"
*/
#define AT_HANDSHAKE_REQ_STR    "HDSK"
#define AT_HANDSHAKE_RESP_STR   "KSDH\r\n"
#define AT_HANDSHAKE_REQ_STR_LEN    6   //strlen("HDSK\r\n")
#define AT_HANDSHAKE_RESP_STR_LEN   6   //strlen("KSDH\r\n")


/******************************************************************************
 *****************************************************************************
 * COMMON ENUM
 *****************************************************************************
******************************************************************************/

/******************************************************************************
 * 1. Two types of commands: "action commands" and "parameter commands".
 *   A) "action commands" maybe: "executed" or "tested";
 *       example: AT+CMD1           //"executed"
 *                AT+CMD1=<param>   //"set"
 *                AT+CMD1=?         //"tested"
 *                AT+CMD1?  (ERROR)
 *   B) "parameter commands" maybe: "set", "read", or "tested";
 *       example: AT+CMD2           //"executed", ==> whether this is right? - TBD
 *                AT+CMD2=<param>   //"set"
 *                AT+CMD2?          //"read"
 *                AT+CMD2=?         //"tested"
 *============================================================
 * Case: AT+CMD1    => type: AT_EXEC_REQ, and AtCmdInputContext->paramRealNum = 0
 * Case: AT+CMD2=   => type: AT_SET_REQ, and AtCmdInputContext->paramRealNum = 0
 * Basic AT:
 * 1. ATE0          => AT_SET_REQ
 *       ^
 * 2. AT            => AT_EXEC_REQ
 *       ^
 * 3. ATI           => AT_EXEC_REQ
 *       ^
 * 4. ATS3?         => AT_READ_REQ
 *         ^
 * 5. ATS3=13       => AT_SET_REQ
 *         ^
 * 6. AT&F0         => AT_SET_REQ
 *        ^
 * 7. AT&F=?        => AT_TEST_REQ
 *         ^
 * 8. AT&F?         => AT_READ_REQ
 *        ^
 * 9. AT&F=0        => AT_BASIC_EXT_SET_REQ, some customer need to support such type of input
 *         ^           and act as: AT&F0. In fact, this is not a standard input. So here, we
 *                     involve a new type: AT_BASIC_EXT_SET_REQ (Basic AT extended set request).
******************************************************************************/
typedef enum AtCmdReqType_enum
{
    AT_INVALID_REQ_TYPE = 0,
    AT_EXEC_REQ         = 1,        //AT+CMD1, ATI/AT&F, no parameter
    AT_SET_REQ          = 2,        //AT+CMD2=<param>, AT&F0/ATE0/ATS3=13
    AT_READ_REQ         = 3,        //AT+CMD2?
    AT_TEST_REQ         = 4,        //AT+CMD2=?
    AT_BASIC_EXT_SET_REQ= 5,        //AT&F=<param>

    AT_MAX_REQ          = 15,
}AtCmdReqType;

/******************************************************************************
 * 1. <value> shall consist of either a "numeric" constant or a "string" constant.
 *  A) "numeric constants" are expressed in "numValue", "hexadecimal", or "binary"
 *     a) "numValue": "0" - "9"
 *     b) "hexadecimal": "0"-"9", "A"-"F", "a"-"f", should not contain: "0x"
 *     c) "binary": "0"-"1"
 *  B) "string"
 *     a) String constants shall consist of displayable displayable, in the range from
 *        0x20 (Space or blank) to 0x7F (delete), inclusive, except for the characters:
 *        """ and "\"
 *     a) String constants shall be bounded at the beginning and end by the
 *        ouble-quote character: "
 *     b) Any character value may be included in the string by representing it
 *        as a backslash ("\") character followed by two hexadecimal digits;
 *        example: "\" => "\5C"
 *                 <CR> => "\0D"
 *                 """  => "\22"
******************************************************************************/
typedef enum AtValueType_enum
{
    AT_DEC_VAL,     /* INT32, value range: [-2147483648, 2147483647] */
    AT_HEX_VAL,     /* INT32, only support range: [0, 0x7FFFFFFF] */
    AT_BIN_VAL,     /* INT32, only support range: [0, 0x7FFFFFFF] */
    AT_STR_VAL,

    /*
     * input parameters, could be "numeric" or "string"
     * 1> AT decoder try to decode according to the input value, and set the valueType to: AT_DEC_VAL or AT_STR_VAL
     * 2> If this parameter not input/present, then the parameter valueType is still: AT_MIX_VAL, let caller to descide it.
     * Example:
     * AT+CMD1=<param1>[,<param2>]  //param2 is "AT_MIX_VAL" type
     * a) AT+CMD1=1,2
     *    AtParamValueCP[1].type = AT_DEC_VAL
     * b) AT+CMD1=1,"abc"
     *    AtParamValueCP[1].type = AT_STR_VAL
     * c) AT+CMD1=1
     *    AtParamValueCP[1].type = AT_MIX_VAL
     *    AtParamValueCP[1].bDefault = TRUE
    */
    AT_MIX_VAL,
    AT_JSON_VAL,    /*input parameter is JSON string format */

    /*
     * AT CMD last parameter, maybe a MIX value, contain special characters: ','';','\r\n',
     *  AT decoder don't care it, just pass the whole string to the AT processor
    */
    AT_LAST_MIX_STR_VAL,
    AT_MAX_VAL
}AtValueType;

/******************************************************************************
 * 1. If <name> is not recognized, one or more mandatory values are omitted,
 *    or one or more values are of the wrong type or outside the permitted range,
 *    the DCE issues the ERROR result code and terminates processing of the command line
 *    SO:
 *    a) mandatory, or optional;
******************************************************************************/
typedef enum AtPresentType_enum
{
    AT_MUST_VAL,    //mandatory
    AT_OPT_VAL      //optional
}AtPresentType;

/******************************************************************************
 * 1. Basic Syntax commands
 *   a) Basic Syntax command format:
 *      <command>[<number>]
 *      where <command> is either a single character, or the "&" character (IA5 2/6)
 *      followed by a single character
 *     Example: ATE0/ATE1 AT&F0
 *   b) S-parameters:
 *      S<parameter_number>?
 *      S<parameter_number>= [<value>]
 *     Example: ATS3?
 *
 * 2. Extended Syntax commands, two types: "action commands" and "parameter commands"
 *   a) action commands:
 *      +<name>                     //execute
 *      +<name>[=<value>]           //set
 *      +<name>[=<compound_value>]  //set
 *      +<name>=?                   //test
 *   b) parameter commands
 *      +<name>                     //execute
 *      +<name>=[<value>]           //set
 *      +<name>=[<compound_value>]  //set
 *      +<name>?                    //read
 *      +<name>=?                   //test
******************************************************************************/
typedef enum AtCmdSyntaxType_enum
{
    AT_BASIC_CMD,
    AT_EXT_PARAM_CMD,
    AT_EXT_ACT_CMD
}AtCmdSyntaxType;

/*
 * AT decoder return code
*/
typedef enum AtcDecRetCode_enum
{
    ATC_DEC_OK,             //AT command decode & proc OK,
    ATC_DEC_NO_AT,          //No AT command in line;
    ATC_DEC_SYNTAX_ERR,     //AT command format is not right
    ATC_DEC_PROC_ERR        //AT command procFunc error
}AtcDecRetCode;

/*
 * AT channel state
*/
typedef enum AtcState_enum
{
    /*
     * V250 3.1
     * Data signals from the DTE on circuit 103 are treated as command lines and processed by the DCE,
     *  and DCE responses are sent to the DTE on circuit 104. The DCE enters this state upon power-up.
    */
    ATC_COMMAND_STATE,   //default: command state

    /*
     * V250 3.1
     * 1> Signals from the DTE on circuit 103 as command lines and sends responses to the DTE on circuit 104.
     *    Note: Data recv from MCU is treated as AT command.
     * 2> Depending on the implementation, data received from the remote station during Online Command State may be
     *    either discarded or retained in the DCE until Online Data State is once again entered (by a command: ATO from the DTE).
     * 3> Online Command State may be entered from Online Data state by a mechanism defined in 6.2.9 (DTR on-to-off transition if AT&D1) or
     *    by other manufacturer-defined means("+++").
     * Note, example:
     *   a) when in PPP online data state, if "+++" recv from MCU, then enter this state: ATC_ONLINE_COMMAND_STATE,
     *      and, PPP DL pkg recv from network, will be discard for easy.
    */
    ATC_ONLINE_COMMAND_STATE,

    /*
     * V250 3.1
     * Following states are all: online data state
     * 1> In Online Data State, the DCE is communicating with a remote station. Data signals from the DTE on circuit 103 are treated as data and
     *    transmitted to the remote station, and data received from the remote station are delivered to the DTE on circuit 104.
     *
    */
    ATC_ONLINE_DATA_STATE,  //online data state

    /*
     * For SMS:
     * The "Text" and "PDU" modes are transitory states and after each operation,
     *  control is automatically returned to the V.25ter "command" state or "on-line command" state.
     * 1>  "AT+CMGS=<length><CR>" (PDU mode) or "+CMGC=<fo>,<ct>[,<pid>[,<mn>[,<da>[,<toda>]]]]<CR>"
     * 2> ATEC SMS submodule. change the "atcState" to : ATC_SMS_CMGS_DATA_STATE;
     * 3> ATC decoder, discard pending input sting, and forard following input to ATEC SMS mode;
     * 4> ATEC SMS parse the input, and when meet: ctrl-z/ESC, then change the "atcState" to : ATC_COMMAND_STATE, and send/cancel this SMS
    */
    ATC_SMS_CMGS_CMGC_DATA_STATE,

    /*
     * For SMS:
     *  AT+CMGC, - TBD
    */
    //ATC_SMS_CMGC_DATA_STATE,

    /*
     * For SMS:
     *  AT+CMGW
     * 1>  "+CMGW=<length>[,<stat>]<CR>" (PDU mode) or "+CMGW[=<oa/da>[,<tooa/toda>[,<stat>]]]<CR>"
     * 2> ATEC SMS submodule. change the "atcState" to : ATC_SMS_CMGW_DATA_STATE;
     * 3> ATC decoder, discard pending input sting, and forard following input to ATEC SMS mode;
     * 4> ATEC SMS parse the input, and when meet: ctrl-z/ESC, then change the "atcState" to : ATC_COMMAND_STATE, and send/cancel this SMS
    */
    ATC_SMS_CMGW_DATA_STATE,

    ATC_SMS_CNMA_DATA_STATE,

    ATC_MQTT_PUB_DATA_STATE,

    ATC_COAP_SEND_DATA_STATE,

    ATC_HTTP_INPUT_STATE,

    ATC_FILE_WRITE_DATA_STATE,

    ATC_SSL_SEND_INPUT_STATE,

    ATC_SOCKET_SEND_DATA_STATE,

    ATC_REF_SOCKET_SEND_DATA_STATE,

    ATC_REF_SOCKET_PASSTHROUGH_STATE,

    ATC_PPP_ONLINE_DATA_STATE,

    ATC_SSL_PASSTHROUGH_STATE,

    ATC_STATE_MAX = 0xFF
}AtcState;


/*
 * AT channel config parameter
*/
typedef enum AtcChanCfgItem_enum
{
    ATC_CFG_S3_PARAM,
    ATC_CFG_S4_PARAM,
    ATC_CFG_S5_PARAM,
    ATC_CFG_ECHO_PARAM,
    ATC_CFG_SUPPRESS_PARAM,
    ATC_CFG_VERBOSE_PARAM,

    ATC_CFG_PARAM_NUM
}AtcChanCfgItem;

/*
 * URC RI (Ring indication) event state
*/
typedef enum
{
    AT_URC_RI_NONE,
    AT_URC_RI_TIGGER,       /* RI tiggered, and wait for done */
    AT_RI_DONE_URC_DELAY,   /* RI done, and URC need delay */
    AT_URC_RI_DONE          /* RI done, and delay timeout, could Tx URC */
}AtUrcRiState;


/*
*/
typedef enum
{
    AT_DATA_STATE_DATA_INPUT,   /* "pArg" => AtDataStateDataInput */
    AT_DATA_STATE_DTR_EVT,      /* DTR (Data Terminal Ready) on-to-off transition event, when recv in online data state
                                 * 1> if AT&D1 cfg, channel enters: ATC_ONLINE_COMMAND_STATE, and could back to data state
                                 *     via AT: ATO
                                 * 2> if AT&D2 cfg, online data should be disconnnected, and enters: ATC_COMMAND_STATE
                                */
    AT_ONLINE_CMD_ATO_EVT,      /* when ATC_ONLINE_COMMAND_STATE, recv ATO event, return to online data state.
                                 * "pArg" => AtOnlineCmdATOInput
                                */
}AtDataAndOnlineCmdSEvt;

/*
 * API func, which called when AT channel enter: DATA_STATE and ATC_ONLINE_COMMAND_STATE.
 * Note
 * 1> for event: AT_DATA_STATE_DATA_INPUT
 *   a) if this callback not return CMS_RET_SUCC, the AT channel state will change back to: ATC_COMMAND_STATE, in the caller
 * 2> for event: AT_ONLINE_CMD_ATO_EVT,
 *   a) AT response should be replied (atcReply()) in this callback, and return CMS_RET_SUCC
 *   b) If not return CMS_RET_SUCC, the caller will call: atcReply()
*/
typedef CmsRetId (*AtDataAndOnlineCmdStateFuncP)(UINT8 chanId, UINT8 curChanState, AtDataAndOnlineCmdSEvt eventId, void *pArg);


/******************************************************************************
 *****************************************************************************
 * STRUCTURE
 *****************************************************************************
******************************************************************************/

/*
 * AT input parameter value
*/
typedef struct AtParamValue_Tag
{
    UINT8               type;           //AtValueType, parameter value type
    BOOL                bDefault;       //if not set, just need to use the default value
    BOOL                inputQuote;     //whether input string contain quote (""), for "AT_STR_VAL" type
    UINT8               rsvd;


    //AtDataValueType     value;
    union
    {
        /*
         * AT_DEC_VAL,      value range: [-2147483648, 2147483647]
         * AT_HEX_VAL,      only support range: [0, 0x7FFFFFFF]
         * AT_BIN_VAL,      only support range: [0, 0x7FFFFFFF]
        */
        INT32   numValue;

        /*
         * AT_STR_VAL,
         * 1> don't need to free it, as point to the input AT command string,
         *    will free the whole AT CMD string, when all AT processed.
         * 2> if input: "", then: bDefault = FALSE, pStr = PNULL;
         * 3> if input: "abcdef", then
         *               ^pStr      and "inputQuote" = TRUE
         * 4> if input: abcdef, then:
         *              ^pStr       and "inputQuote" = FALSE
        */
        CHAR    *pStr;
    } value;
}AtParamValue;  //8 bytes

typedef const AtParamValue  *AtParamValueCP;

/*
 * input context
*/
typedef struct AtCmdInputContext_Tag
{
    UINT16          operaType : 4;      //AtCmdReqType, AT REQ type
    UINT16          chanId    : 4;      //channel ID, 0 - 15
    UINT16          tid       : 5;      //asyn guard timer index, 0 - 31;
    UINT16          rsvd      : 3;

    /*
     * MAX parameters number of this AT CMD, set when this AT predefined in: AT_CMD_PRE_DEFINE()
    */
    UINT8           paramMaxNum;

    /*
     * Input paramters number at this time.
     * Example:
     *  1> AT defination: AT+CMD1=<param1>[,<param2>[,<param3>[,<param4>]]]
     *  2> AT input: AT+CMD1="test",,9
     * Here: paramMaxNum = 4;
     *       paramRealNum = 3;
     *       pParamList[0].type = AT_STR_VAL;
     *       pParamList[0].bDefault = FALSE;
     *       pParamList[0].value.pStr = "test"; //"test" allocated in a heap memory
     *       pParamList[1].type = ... ;         //type value pre-defined
     *       pParamList[1].bDefault = TRUE;
     *       pParamList[2].type = AT_DEC_VAL;
     *       pParamList[2].bDefault = FALSE;
     *       pParamList[2].value.numValue = 9
    */
    UINT8           paramRealNum;


    /*
     * Input parameters value list;
     * 1> An array pointer, allocated in stack memory, don't need to free
     * 2> Size = sizeof(AtParamValue)*AT_CMD_PARAM_MAX_NUM
    */
    AtParamValue    *pParamList;

}AtCmdInputContext; //8 bytes


/******************************************************************************
 * V 250
 * AT parameter value attributes
 * AT+<name>=[<value>]
 * AT+<name>=[<compound_value>]
 * ==========================================================================
 * 1. If <name> is not recognized, one or more mandatory values are omitted,
 *    or one or more values are of the wrong type or outside the permitted range,
 *    the DCE issues the ERROR result code and terminates processing of the command line
 *    SO:
 *    a) mandatory, or optional;
 *    b) type: numeric, or string;
 *    c) Range: numeric: [min, max]
 *              string: [minlength, maxLength]
 *
 * 2. Parameters may be defined as "read-only" or "read-write". "Read-only" parameters
 *    are used to provide status or identifying information to the DTE, but are not
 *    settable by the DTE   //seems useless -TBD
 *
******************************************************************************/
typedef struct AtValueAttr_Tag
{
    AtValueType     type;
    AtPresentType   presentType;

    /*
     * Range, -TBD
    */
    /*
     * ACCESS ATTR: RO/RW - useless?
    */
}AtValueAttr;

/*
 * MARCO to per-define the AT parameter value attributes
*/
#define AT_PARAM_ATTR_DEF(valuetype, presentType)    {valuetype, presentType}


typedef CmsRetId (*AtCallbackFunctionP)(const AtCmdInputContext *pAtInputCtx);


typedef struct AtCmdPreDefInfo_Tag
{
    const CHAR          *pName;     //AT name, MAX length: AT_CMD_MAX_NAME_LEN = 32

    UINT16              timeOutS;   //time out value in seconds
    UINT8               cmdType;    //AtCmdSyntaxType, basic/extended action command/extended parameter command
    UINT8               paramMaxNum;    //max parameters number

    const AtValueAttr   *pParamList;

    const AtCallbackFunctionP atProcFunc;
}AtCmdPreDefInfo;   //16 bytes

typedef const AtCmdPreDefInfo AtCmdPreDefInfoC;


/******************************************************************************
 ******************************************************************************
 * AT CHANNEL ENTITY
 ******************************************************************************
******************************************************************************/

/*
 * AT channel configuration
*/
typedef struct AtChanConfig_Tag
{
    CHAR    S[AT_S_PARM_NUM];   //4 bytes

    UINT8   echoFlag;           /*set by ATE0/ATE1*/
    UINT8   respFormat;         /*set by ATV0/ATV1*/
    UINT8   suppressValue;      /*set by ATQ0/ATQ1*/
    UINT8   rsvd;
}AtChanConfig;  //8 bytes

/*
 * Input AT string info
*/
typedef struct AtCmdInputNode_Tag
{
    struct AtCmdInputNode_Tag *pNextNode;

    /*
     * example:
     * 1st node:
     *  "AT+CEREG=5\r\nAT+\0"
     * 2dn node:
     *  "CEREG?\r\n\0"
     *
     * After decoded first AT: AT+CEREG=5, then
     *  "AT+CEREG=5\r\nAT+\0"
     *  ^              ^
     *  pStart         pNextDec
    */

    CHAR    *pStart;    /*start of input string, !!!! MEMORY Allocated in heap by: OsaAllcateMemory() !!!!*/
    CHAR    *pEnd;      /*end of input string*/
    CHAR    *pNextDec;  /*Next decode header, AT decode line by line*/
}AtCmdInputNode;    //16 bytes

/*
 * AT command send via SDK API
*/
typedef struct AtApiInputNode_Tag
{
    struct AtApiInputNode_Tag   *pNextNode;

    /*
     * Must be a whole/valid AT CMD, end with: \r\n
     * "AT+CEREG?\r\n"
     *             ^
     *             |pEnd
    */
    CHAR    *pStart;    /*start of input string, !!!! MEMORY Allocated in heap by: OsaAllcateMemory() !!!!*/
    CHAR    *pEnd;      /*end of input string*/

    AtRespFunctionP     respFunc;
    void                *pArg;
    UINT32              timeOutMs;
    osSemaphoreId_t     sem;        //the caller API, maybe wait for this "semaphore"
}AtApiInputNode;    //28 bytes


typedef struct AtInputInfo_Tag
{
    /*
     * If "bApiMode" == TRUE, pHdr & pTailer point to "AtApiInputNode";
     * Else, (AT from UART), pHdr & pTailer point to "AtCmdInputNode";
    */
    union
    {
        struct
        {
            AtCmdInputNode  *pHdr;
            AtCmdInputNode  *pTailer;
        }cmdInput;

        struct
        {
            AtApiInputNode  *pHdr;
            AtApiInputNode  *pTailer;
        }apiInput;
    }input;

    UINT8           pendingNodeNum;
    INT8            rsvd;
    UINT16          pendingLen;
}AtInputInfo;   //12 bytes

/*
 * AT command line info
*/
typedef struct AtCmdLineInfo_Tag
{
    /*
     * ATC decoder decode/parse the AT command line by line, and maybe several AT CMDs in one line,
     * example: AT+CFUN=1;+COPS?\r\0
     * Note:
     * 1> "pLine" point to the head of the line;
     * 2> "pNextHdr" point to the next CMD header;
    */
    CHAR    *pLine;     /* !!! MEMORY Allocated in heap by: OsaAllcateMemory() !!!! */
    CHAR    *pEnd;      /* ending: <S3> */
    CHAR    *pNextHdr;  //point to start char of next AT CMD

    /*
     * Note:
     * 1> if "pNextHdr" == PNULL, just means all AT are processed, and "startLine" == FALSE & "startAt" == FALSE;
     * 2> if "startLine" == TRUE, means prefix characeters: "AT" is needed;
     * 3> if "startLine" == TRUE, then: "startAt" == TRUE and "pNextHdr" != PNULL;
     * 4> if "startLine" == FALSE, and "startAt" == TRUE, then "pNextHdr" != PNULL, just means next AT CMD in one/same line
     *    example: AT+CFUN=1;+CEREG?
     *                       ^
     *                       |pNextHdr, here "startLine" = FALSE, "startAt" = TRUE
     * 5> if several AT line in current line, example:
     *    AT+CFUN=1\r\nAT+CEREG?\r\n
     *    ^            ^
     *    |pLine       |pNextHdr, here "startLine" = TRUE, "startAt" = TRUE
    */
    BOOL    startLine;  /* if "pNextHdr" point to start of one line, if so, prefix: "AT" needed */
    BOOL    startAt;    /* if "pNextHdr" point to start of one AT command */
    UINT16  rsvd0;

    /*
     * For AT API mode, current AT command guard time maybe set via API, if so store here
     * If this value is zero, find the time value in AT command table.
    */
    UINT32  timeOutMs;
}AtCmdLineInfo; //20 bytes

/*
 * AT channel miscellaneous info/control
*/
typedef struct AtChanMiscellaneous_Tag
{
    UINT32  endSetbaud  : 1;    /* Whether need to set serial baudrate, after AT proc done, if return OK */
    UINT32  endReset    : 1;    /* whether need to reset UE, after AT proc done */
    UINT32  endPowerOff : 1;    /* whether need to power off UE, after AT proc done */
    UINT32  rsvd        : 20;
    UINT32  baudSaveFlag: 1;    /* when when endSetbaud == TRUE */
    UINT32  poweroffMode : 8;   /* when endPowerOff == TRUE, pass to power off action */

    UINT32  baudrate;           /* when endSetbaud == TRUE */
    UINT32  baudFrameFormat;    /* when endSetbaud == TRUE */
    UINT32  resetDelayMs;       /* when endRest == TRUE */
}AtChanMiscellaneous;



typedef struct AtChanUrcInfo_Tag
{
    UINT8       riState;        /* AtUrcRiState, URC RI state */
    UINT8       urcNum;         /* How many URC in pending list: pUrcHead/pUrcTail */

    /*
     * As RI (Ring Indication) for SMS is different, here we record to indicate which URC is SMS
     * Example:
     * a) Bit0: pUrcHead, 0 - not SMS, 1 - SMS URC.
    */
    UINT16      smsUrcBitmap;

    /*
     * URC pending list, max number: 16
    */
    DlPduBlock  *pUrcHead;
    DlPduBlock  *pUrcTail;

    osTimerId_t     urcDelayTimer;      /* URC delay timer, URC maybe delayed after RI indication done */
}AtChanUrcInfo;     //16 bytes

/*
 * AT_DATA_STATE_DATA_INPUT, pArgv
*/
typedef struct AtDataStateDataInput_Tag
{
    UINT16      dataLen;
    UINT16      rsvd0;

    UINT8       *pData;     //data allocated in heap, and freed after the API: AtDataAndOnlineCmdStateFuncP() called
}AtDataStateDataInput;

/*
 * AT_ONLINE_CMD_ATO_EVT, pArgv
*/
typedef struct AtOnlineCmdATOHInput_Tag
{
    UINT16      atHandle;
    UINT16      atVal;      /* ATO input value */
}AtOnlineCmdATOInput;


typedef struct AtChanEntity_tag
{
    UINT8   chanId;     //channel ID
    BOOL    bInited;    //whether this channel inited
    UINT8   chanState;  //AtcState
    BOOL    bApiMode;   //whether this AT channel is used for SDK API mode

    UINT32  nextTid : 5;    //next asyn timer ID, start from 0, range: [0 - 31]
    UINT32  curTid :  5;    //current TID, in fact: nextTid = curTid + 1, TID of "asynTimer"
    UINT32  bWaitDataModeHSCnf : 1;    // whether the CCIO task confirms that data mode handshake succ.
    UINT32  rsvd1 :   21;

    CHAR    chanName[AT_CHAN_NAME_SIZE];

    AtChanConfig    cfg;            //8 bytes
    AtInputInfo     atInputInfo;    //12 bytes
    AtCmdLineInfo   atLineInfo;     //20 bytes

    AtChanUrcInfo   urcInfo;        //16 bytes

    struct
    {
        AtRespFunctionP     respFunc;
        void                *pArg;
        osSemaphoreId_t     apiSem;     //the caller API, maybe wait for this "semaphore", only used for API mode

        /*
         * if response separate several string, need to buffer here, and when final result arrived, sent it totally
         * Used for API mode. !!! memory used in heap !!!
        */
        CHAR                *pBufResp;
        UINT16              respBufLen;
        UINT16              respBufOffset;

        AtUrcFunctionP      urcFunc;

        /*
         * AT resp and URC interface, the resp/urc string is carried in "DlPduBlock", and "DlPduBlock" should be freed in caller
        */
        AtRespPduFunctionP  respPduFunc;
        AtUrcPduFunctionP   urcPduFunc;

        AtDataAndOnlineCmdStateFuncP    dataAndOnlineCmdFunc;   /* when AT state enters: ATC_ONLINE_COMMAND_STATE/DATA_STATE, how to proc the input data/event */
    }callBack;      //36 bytes


    UINT16              preDefCmdNum;
    UINT16              preDefCustCmdNum;
    AtCmdPreDefInfoC    *pPreDefCmdList;
    AtCmdPreDefInfoC    *pPreDefCustCmdList;

    UINT16              preDefRefCmdNum;
    UINT16              rsvd2;
    AtCmdPreDefInfoC    *pPreDefRefCmdList;

    /*
     * AT channel is an asynchronous interface, AT command should be processed in serial,
     *  so one guard timer is enough;
    */
    osTimerId_t         asynTimer;

    /*
     * AT channel miscellaneous info/control
    */
    AtChanMiscellaneous *pMiscell;
}AtChanEntity;  // 136 bytes

typedef struct AtChanEntity_tag *AtChanEntityP;


/******************************************************************************
 *****************************************************************************
 * EXTERNAL FUNCTION
 *****************************************************************************
******************************************************************************/

/*
*/
AtChanEntityP atcGetEntityById(UINT32 chanId);

/*
 * whether previous AT line all decoded
*/
BOOL atcBePreAtLineDone(AtChanEntity *pAtChanEty);

/*
 * any pending AT need to decode
*/
BOOL atcAnyPendingAt(AtChanEntity *pAtChanEty);

/*
 * send: SIG_AT_CMD_CONTINUE_REQ signal
*/
void atcSendAtCmdContinueReqSig(AtChanEntityP pAtChanEty);

/*
 * abort current AT line, ubsequent commands in the same line all need aborted
*/
void atcAbortAtCmdLine(AtChanEntity *pAtChanEty);

/*
 * decode init
*/
void atcDecInit(void);

/*
 * register the AT channel
*/
CmsRetId atcRegisterAtChannelCallback(UINT16 inputSize, void *pInput, UINT16 outputSize, void *pOutput);

/*
 * de-register the AT channel by chanID
*/
CmsRetId atcDeRegisterAtChannelCallback(UINT16 inputSize, void *pInput, UINT16 outputSize, void *pOutput);

/*
*/
void atcAsynTimerExpiry(UINT16 timeId);

/*
*/
void atcStopAsynTimer(AtChanEntityP pAtChanEty, UINT8 tid);

/*
 * restart AT asynchronoous response guard timer
*/
void atcRestartGuardTimer(UINT8 chanId, UINT8 tid, UINT32 timeValueMs);

/*
*/
void atcProcAtCmdStrReqSig(AtCmdStrReq *pAtReq);

/*
*/
void atcProcAtCmdContinueReqSig(AtCmdContinueReq *pContReq);

void atcProcAtCmdDataModeHSCnfSig(AtCmdDataModeHSCnf *pAtCmdDataCnf);

/*
*/
CmsRetId atcSetConfigValue(UINT8 chanId, AtcChanCfgItem item, UINT32 value);

/*
*/
CmsRetId atcChangeChannelState(UINT8 chanId, AtcState newState);

/*
*/
void atcRilAtCmdApiCallback(void *pArg);

/*
*/
CmsRetId atcRilRegisterUrcSynCallback(UINT16 inputSize, void *pInput, UINT16 outputSize, void *pOutput);

/*
*/
CmsRetId atcRilDeRegisterUrcSynCallback(UINT16 inputSize, void *pInput, UINT16 outputSize, void *pOutput);


UINT8  atcQueryChannelState(UINT8 chanId);

/*
*/
CmsRetId atcEndResetSystem(UINT8 chanId, UINT32 delayMs);

/*
*/
CmsRetId atcEndPowerOff(UINT8 chanId, UINT8 poweroffMode);

/*
*/
CmsRetId atcEndSetBaudrate(UINT8 chanId, UINT32 baudrate, UINT32 frameFormat, BOOL saveFlag);

/*
*/
CmsRetId atcDiscardAllPendingAt(UINT8 chanId);


/**
  \brief        AT channel state enter online data state, data recv from AT channel pass to dataStateFunc directly
  \Note:        API only can be called in CMS task
*/
CmsRetId atcEnterOnlineDataState(UINT8 chanId, AtcState dataState, AtDataAndOnlineCmdStateFuncP dataStateFunc);

/**
  \brief        AT channel state enter: ATC_ONLINE_COMMAND_STATE, data recv from AT channel act as AT command, and could
  \             backup to online data state, when recv ATH
  \Note:        API only can be called in CMS task
*/
CmsRetId atcEnterOnlineCommandState(UINT8 chanId, AtDataAndOnlineCmdStateFuncP onlineCmdStateFunc);

/**
  \brief        AT channel state enter: ATC_COMMAND_STATE
  \Note:        API only can be called in CMS task
*/
CmsRetId atcEnterCommandState(UINT8 chanId);

/**
 \brief        DTR event: on-to-off transition
*/
void atcDtrEventCallback(UINT16 paramSize, void *pParam);

#endif

