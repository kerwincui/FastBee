/******************************************************************************
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * All Rights Reserved
*******************************************************************************
 *  Filename: ps_sms_if.h
 *
 *  Description: API interface for SMS service
 *
 *  History:
 *
 *  Notes:
 *
******************************************************************************/
#ifndef __PS_SMS_IF_H__
#define __PS_SMS_IF_H__

#include "cms_util.h"
#include "cmisms.h"

/******************************************************************************
 * SMS/CB Parameter Definitions: (27.005)
 * ============================================================================
 * A) Message storage param
 * 1. <index>: integer type
 *          value in the range of location numbers supported by the associated memory
 * 2. <mem1>: string type
 *          memory from which messages are READ and DELETED; +CMGL/+CMGR/+CMGD
 *   "BM"   - broadcast message storage
 *   "ME"   - ME message storage
 *   "MT"   - any of the storages associated with ME
 *   "SM"   - (U)SIM message storage
 *   "TA"   - TA message storage
 *   "SR"   - status report storage
 * 3. <mem2>: memory to which writing and sending operations
 *    <mem3>: memory to which received SMs are preferred to be stored
 *            unless forwarded directly to TE: +CNMI
 * 4. <stat>: integer type in PDU mode; string type in text mode
 *            the status of message in memory
 *    0 "REC UNREAD"    received unread message (i.e. new message)
 *    1 "REC READ"      received read message
 *    2 "STO UNSENT"    stored unsent message (only applicable to SMs)
 *    3 "STO SENT"      stored sent message (only applicable to SMs)
 *    4 "ALL"           all messages (only applicable to +CMGL command)
 *
 * ============================================================================
 * B) Message data param
 * 1. <ackpdu>: string type
            RP-ACK PDU
 * 2. <alpha>:  string type
 *          alphanumeric representation of <da> or <oa>;
 * 3. <cdata>:  string type
 *          TP-Command-Data in text mode responses,
 *          example: int: 42 (0x2A) => "2A"
 * 4. <ct>:     integer type
 *          TP-Command-Type (default: 0)
 * 5. <da>:     string format
 *          TP-Destination-Address, type of address given by <toda>
 * 6. <data>
 *          TP-User-Data in text mode response
 * 7. <dcs>     integer format
 *           SMS Data Coding Scheme (default 0)
 * 8. <dt>      time-string format
 *          TP-Discharge-Time: "yy/MM/dd,hh:mm:ss+zz or-zz"
 * 9. <fo>      integer format
 *          first octet of SMS-DELIVER, SMSSUBMIT (default 0x21), SMS-STATUS-REPORT, or SMS-COMMAND (default 2)
 * 10.<length>  integer format
 *          the length of the message body <data> in characters, in the text mode (+CMGF=1)
 *          the length of the actual TP data unit in octets (INT8), in the PDU mode (+CMGF=0)
 * 11.<mid>     integer format
 *          CBM Message Identifier
 * 12.<mn>      integer format
 *          TP-Message-Number
 * 13.<mr>      integer format
 *          TP-Message-Reference
 * 14.<oa>      string format
 *          TP-Originating-Address, type of address given by <tooa>
 * 15.<page>    integer format
 *          23.041 CBM Page Parameter bits 4-7
 * 16.<pages>   integer format
 *          23.041 CBM Page Parameter bits 0-3
 * 17.<pdu>     hexadecimal format
 *          SMS TPDU in hexadecimal format: ME/TA converts each octet of TP data unit into two IRA character
 *          example: int: 42 (0x2A) => "2A"
 * 18.<pid>     integer format
 *          23.040 TP-Protocol-Identifier in integer format (default 0)
 * 19.<ra>      string format
 *          23.040 TP-Recipient-Address, type of address given by <tora>
 * 20.<sca>     string format
 *          24.011 RP SC (SMS service centre) address Address, type of address given by <tosca>
 * 21.<scts>    time-string format
 *          23.040 TP-Service-Centre-Time-Stamp
 * 22.<sn>      integer format
 *          23.041 CBM Serial Number
 * 23.<st>      integer format
 *          23.040 TP-Status
 * 24.<toda>    integer format
 *          24.011 TP-Destination-Address Type-of-Address
 *          when first character of <da> is + (IRA 43) default is 145, otherwise default is 129
 * 25.<tooa>/<tora>/<tosca>
 *          Type-of-Address octet in integer format
 * 26.<vp>      integer format/time-string format
 *          depending on SMS-SUBMIT <fo> setting: 3GPP TS 23.040 [3] TP-Validity-Period
 *          either in integer format (default 167) or in time-string format (refer <dt>)
 *
*******************************************************************************
 * Memory:
 * 1> AT+CSMP, +CSCA and +CSCB settings are stored directly to non-volatile memory of ME
 *   a) AT+CSMP, param saved in mwconfig.nvm;
 *   b) +CSCA=<sca>[,<tosca>], param saved in UICC
 *
******************************************************************************/



/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/

#define PSIL_SMS_ADDR_INTERNATIONAL_PREFIX      ((UINT8)'+')
#define PSIL_SMS_MAX_PDU_SIZE                   CMI_SMS_MAX_PDU_SIZE    //180
#define PSIL_SMS_MAX_PDU_SIZE_OF_DELIVER_REPORT 164  /* 23.040 9.2.2.1a MAX length of SMS-DELIVER-REPORT */

/*
 * 1> DCS 7bit, max size is 160, max size of CSCS Char Set UCS2 is 160 * 4 = 640
 * 2> DCS 8bit, max size is 140
 * 3> DCS UCS2, max size is 280, HEX string type, example: "4F60" just means: 0x4F60.
*/
#define PSIL_SMS_MAX_7BIT_TXT_SIZE              160
#define PSIL_SMS_MAX_TXT_SIZE                   640

#define PSIL_SMS_MAX_UD_SIZE                    140
#define PSIL_SMS_INVALID_MEM_INDEX              255
#define PSIL_BITS_NUMBER_OF_DIGIT               4

/*
 * Service Centre address, refer to TS-24.011 8.2.5.1
 * +----------------+
 * |    length      |   Length of SC Address contents
 * +----------------+
 * |      TOA       |   Type-of-Address
 * +----------------+
 * | dig 2 | dig 1  |   Address value, 0 - 10 bytes
 * +----------------+
 * | dig 4 | dig 3  |
 * +----------------+
 * length: byte length, include: TOA and address.
 * TOA:
 *   7                           0
 * +---+---+---+---+---+---+---+---+
 * | 1 |  type-num |    num-plan   |
 * +---+---+---+---+---+---+---+---+
 *  type-num:   CmiSmsTypeOfNumberEnum
 *  num-plan:   CmiSmsNumberPlanIdEnum
*/

/* The maximum length of the full address field (Address-Length, Type-of-Address and Address-Value) is 12 octets */
#define PSIL_SMS_ADDR_ENCODE_MAX_SIZE   12


/*
 * From 27.005:
 * 1> <pdu>: In the case of SMS: 3GPP TS 24.011 [6] SC address followed by 3GPP TS 23.040 [3] TPDU in
 *        hexadecimal format.
 * 2> AT input is "HEX" (hexadecimal) string type, example: "2A" just means: 0x2A.
 * 3> So the input max string size should be: 2*(180+12)
*/
#define PSIL_SMS_HEX_PDU_STR_MAX_SIZE   (2*(PSIL_SMS_MAX_PDU_SIZE+PSIL_SMS_ADDR_ENCODE_MAX_SIZE))

#define PSIL_SMS_VP_OCTET_MAX_LENGTH    7

/* The TP-Validity-Period-Format is a 2-bit field, located within bit no 3 and 4 of the first octet of SMS-SUBMIT */
#define PSIL_SMS_FO_VPF_BIT_MASK        0x18

/*
 * FO:
 * SMS-SUBMIT first octet, refer to TS-23.040 9.2.2.2
 *  bit7                               bit0
 * +----+----+----+----+----+----+----+----+
 * | RP |UDHI|SRR |   VPF   | RD |   MTI   |
 * +----+----+----+----+----+----+----+----+
 * RP:  Reply Path, 0 - not set
 * UDHI:User-Data-Header-Indicator, 0 - The TP-UD field contains only the short message
 * SRR: Status-Report-Request , 1 - A status report is requested
 * VPF: Validity-Period-Format, 00 - TP-VP field not present
 * RD:  Reject-Duplicates, 0 - SC not reject the duplicate SMS
 * MTI: Message-Type-Indicator, 01 - SMS-SUBMIT
 *
 * Default FO: 0x21; SMS-SUBMIT PDU, status report required
*/
#define PSIL_MSG_FO_SUBMIT_DEFAULT      ((UINT8)0x21)
#define PSIL_MSG_FO_DELIVER_DEFAULT     ((UINT8)0)
#define PSIL_MSG_VP_DEFAULT             ((UINT8)167)        /* 24 hours - refer to TS-23.040 */
#define PSIL_MSG_PID_DEFAULT            ((UINT8)0)          /* Refer to TS-23.040 9.2.3.9 */
#define PSIL_MSG_REF_DEFAULT            ((UINT8)0)          /* Reference = 0 */

/*
 * SMS-SUBMIT T-PDU format/basic element, refer to TS-23.040 9.2.2.2
 * +----------------+
 * |      FO        |   First Octet
 * +----------------+
 * |      MR        |   Message-Reference
 * +----------------+
 * \      DA        \   Destination-Address, length: 2 - 12 bytes
 * +----------------+
 * |      PID       |   Protocol-Identifier
 * +----------------+
 * |      DCS       |   Data-Coding-Scheme
 * +----------------+
 * :      VP        :   Validity-Period, 0/1/7 bytes
 * +----------------+
 * |      UDL       |   User-Data-Length
 * +----------------+
 * \      UD        \   User-Data, 0 - 140 bytes
 * +----------------+
*/

/*
 * SM-TL, address field (Destination-Address), refer to TS-23.040 9.1.2.5
 * +----------------+
 * |      AL        |   Address length
 * +----------------+
 * |      TOA       |   Type-of-Address
 * +----------------+
 * \      AV        \   Address value, 0 - 10 bytes
 * +----------------+
 * AL:  Number of useful semi-octets within the Address-Value field. !! (1 byte -> 2 length) !!
 * TOA:
 *   7                           0
 * +---+---+---+---+---+---+---+---+
 * | 1 |  type-num |    num-plan   |
 * +---+---+---+---+---+---+---+---+
 *  type-num:   CmiSmsTypeOfNumberEnum
 *  num-plan:   CmiSmsNumberPlanIdEnum
*/


/*
 * MSG/SMS ADDRESS LEN, encoded MAX 10 bytes, so for UCS2 MAX 80 length here
*/
#define PSIL_MSG_MAX_ADDR_LEN   80


/* Refer to TS-27.005 case 3.1 Parameter definitions Parameter <Stat> for Text mode */
#define PSIL_SMS_STATUS_STRING_REC_UNREAD   "REC UNREAD"
#define PSIL_SMS_STATUS_STRING_REC_READ     "REC READ"
#define PSIL_SMS_STATUS_STRING_STO_UNSENT   "STO UNSENT"
#define PSIL_SMS_STATUS_STRING_STO_SENT     "STO SENT"
#define PSIL_SMS_STATUS_STRING_ALL          "ALL"

/*
 * A CBS page comprises of 82 octets, which, using the default character set, equates to 93 characters.
*/
#define PSIL_SMS_CBS_MAX_DATA_LENGTH             93

/*
 * This code is an escape to an extension of GSM 7 bit Default Alphabet table
 * 3GPP TS 23.038, 6.2.1
*/
#define PSIL_SMS_ESCAPE_EXTERN_TBL_CODE 0x1B

#define PSIL_SMS_SEND_RP_ACK_WITHOUT_TPDU                    0
#define PSIL_SMS_SEND_RP_ACK                                 1
#define PSIL_SMS_SEND_RP_ERROR                               2

#define PSIL_SMS_TP_CAUSE_NO_SMS_STORAGE_CAPABILITY_IN_SIM   0xD1
#define PSIL_SMS_TP_CAUSE_MEMORY_CAPACITY_EXCEEDED           0xD3
#define PSIL_SMS_TP_CAUSE_UNSPECIFIED_ERR                    0xFF

/******************************************************************************
 *****************************************************************************
 * ENUM
 *****************************************************************************
******************************************************************************/

typedef enum PsilSmsDCSType_enum
{
    PSIL_SMS_DCS_GENERAL_CODING  = 0,
    PSIL_SMS_DCS_MESSAGE_WAITING = 1,
    PSIL_SMS_DCS_MESSAGE_CLASS   = 2
}PsilSmsDCSType;

typedef enum PsilSmsDCSClass_enum
{
    PSIL_SMS_DCS_MESSAGE_CLASS_0 = 0,
    PSIL_SMS_DCS_MESSAGE_CLASS_1 = 1,
    PSIL_SMS_DCS_MESSAGE_CLASS_2 = 2,
    PSIL_SMS_DCS_MESSAGE_CLASS_3 =3
}PsilSmsDCSClass;

typedef enum PsilSmsDCSIndicationType_Tag
{
    PSIL_SMS_DCS_VOICEMAIL_MESSAGE_WAITING       = 0,
    PSIL_SMS_DCS_FAX_MESSAGE_WAITING             = 1,
    PSIL_SMS_DCS_ELECTRONIC_MAIL_MESSAGE_WAITING = 2,
    PSIL_SMS_DCS_OTHER_MESSAGE_WAITING           = 3
}PsilSmsDCSIndicationType;

/* Refer to TS-23.404 9.2.3.3 TP-VPF:TP-Validity-Period-Format */
typedef enum PsilSmsValidityPeriodFormat_Enum
{
    PSIL_SMS_VPF_NOT_PRESENT    = 0,  /* TP-VP field not present  */
    PSIL_SMS_VPF_ENHANCE        = 1,  /* TP-VP field present and enhanced format */
    PSIL_SMS_VPF_RELATIVE       = 2,  /* TP-VP field present and Relative format */
    PSIL_SMS_VPF_ABSOLUTE       = 3,  /* TP-VP field present and Absolute format */
    PSIL_SMS_VPF_NUM_OF

}PsilSmsValidityPeriodFormat;

/*
 * enum used in encoding/decoding SMS text
*/
typedef enum
{
    PSIL_MSG_CODING_DEFAULT_7BIT  = 0x00,
    PSIL_MSG_CODING_8BIT          = 0x01,
    PSIL_MSG_CODING_UCS2          = 0x02,
    PSIL_MSG_CODING_NUM_OF
}PsilMsgCodingType;

/*
 * current SMS input/output format
*/
typedef enum PsilSmsFormatMode_enum
{
    PSIL_SMS_FORMAT_PDU_MODE = 0,
    PSIL_SMS_FORMAT_TXT_MODE = 1,
    PSIL_SMS_FORMAT_NUM_MODE
}PsilSmsFormatMode;

/*
 * SMS show format in text mode for command +CSDH
*/
typedef enum PsilSmsShowMode_enum
{
    PSIL_SMS_SHOW_DETAIL_INFO_DISABLE = 0,
    PSIL_SMS_SHOW_DETAIL_INFO_ENABLE  = 1,
    PSIL_SMS_SHOW_DETAIL_INFO_END
}PsilSmsShowMode;

/*
 * <toda>, type of dest address
 * 3GPP TS-24.011 [6] TP-Destination-Address Type-of-Address octet in integer format (when first
 * character of <da> is + (IRA 43) default is 145, otherwise default is 129)
 * 3GPP TS-23.040, 9.1.2.5
*/
typedef enum PsilSmsTypeOfAddress_enum
{
    PSIL_SMS_TOA_NUMBER_RESTRICTED       = 0x80,   /* 128, Unknown type, unknown number format */
    PSIL_SMS_TOA_NUMBER_UNKNOWN          = 0x81,   /* 129, Unknown type, IDSN format number */
    PSIL_SMS_TOA_NUMBER_INTERNATIONAL    = 0x91,   /* 145, International number type, ISDN format */
    PSIL_SMS_TOA_NUMBER_NATIONAL         = 0xA1,   /* 161, National number type, IDSN format */
    PSIL_SMS_TOA_NUMBER_NETWORK_SPECIFIC = 0xB1,   /* 177, Network specific number, ISDN format */
    PSIL_SMS_TOA_NUMBER_DEDICATED        = 0xC1,   /* 193, Subscriber number, ISDN format */
    PSIL_SMS_TOA_NUMBER_EXTENSION        = 0xF1,   /* 241, extension, ISDN format */
    PSIL_SMS_TOA_NUMBER_INVALID
}PsilSmsTypeOfAddress;

/* Ref to TS-27.005 3.1 Parameter definitions Parameter <mem1>/<mem2>/<mem3> */
typedef enum PsilSmsStoreMemType_Enum
{
    PSIL_SMS_STOR_MEM_TYPE_ME   = 1,  /* ME message storage */
    PSIL_SMS_STOR_MEM_TYPE_SM   = 2,  /* (U)SIM message storage */
    PSIL_SMS_STOR_MEM_TYPE_BM   = 3,  /* broadcast message storage  */
    PSIL_SMS_STOR_MEM_TYPE_MT   = 4,  /* Any of the storage associated whit ME */
    PSIL_SMS_STOR_MEM_TYPE_TA   = 5,  /* TA message storage */
    PSIL_SMS_STOR_MEM_TYPE_SR   = 6,  /* status report storage */
    PSIL_SMS_STOR_MEM_TYPE_END
}PsilSmsStoreMemType;

typedef enum PsilSmsStoreMemNum_Enum
{
    PSIL_SMS_STOR_MEM_1   = 1,  /* typedef <mem1> */
    PSIL_SMS_STOR_MEM_2   = 2,  /* typedef <mem2> */
    PSIL_SMS_STOR_MEM_3   = 3,  /* typedef <mem3>  */
    PSIL_SMS_STOR_MEM_END
}PsilSmsStoreMemNum;

/*
 * 3GPP TS-23.040 9.2.3.23 Information Element Identifier
 * Only UDH_IEI_CONCATENATED_SMS_8_BIT is supported
*/
typedef enum TypeOfUdhIeId_Tag
{
    UDH_IEI_CONCATENATED_SMS_8_BIT                  = 0,
    UDH_IEI_SPECIAL_SMS_IND                         = 1,
    UDH_IEI_RESERVED                                = 2,
    UDH_IEI_VALUE_NOT_USED                          = 3,
    UDH_IEI_APPLICATION_PORT_ADDRESSING_SCH_8_BIT   = 4,
    UDH_IEI_APPLICATION_PORT_ADDRESSING_SCH_16_BIT  = 5,
    UDH_IEI_SMSC_CTRL_PARAM                         = 6,
    UDH_IEI_UDH_SOURCE_IND                          = 7,
    UDH_IEI_CONCATENATED_SMS_16_BIT                 = 8,
    UDH_IEI_WIRELESS_CONTROL                        = 9,
    UDH_IEI_TEXT_FORMATTING                         = 0xA
}TypeOfUdhIeId;

typedef enum PsilSmsCharSet_Enum
{
    PSIL_SMS_CHAR_SET_GSM                           = 0,
    PSIL_SMS_CHAR_SET_IRA                           = 1,
    PSIL_SMS_CHAR_SET_UCS2                          = 2,
    PSIL_SMS_CHAR_SET_END
}PsilSmsCharSet;

/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/*
 * SMS send message/command info, used for AT:
 * 1> AT+CMGS
 *   a) text mode
 *      AT+CMGS=<da>[,<toda>]<CR>
 *       text is entered<ctrl-Z/ESC>
 *   b) PDU mode
 *      +CMGS=<length><CR>
 *       PDU is given<ctrl-Z/ESC>
 * 2> AT+CMGC
 *   a) text mode
 *      AT+CMGC=<fo>,<ct>[,<pid>[,<mn>[,<da>[,<toda>]]]]<CR>
 *       text is entered<ctrl-Z/ESC>
 *   b) PDU mode
 *      +CMGC=<length><CR>
 *       PDU is given<ctrl-Z/ESC>
 *
 * SMS write and save draft message info, used for AT
 * 2> AT+CMGW
 *   a) text mode
 *      +CMGW[=<oa/da>[,<tooa/toda>[,<stat>]]]<CR>
 *       text is entered<ctrl-Z/ESC>
 *   b) PDU mode
 *      +CMGC=<length>[,<stat>]<CR>
 *       PDU is given<ctrl-Z/ESC>
 * =====================================
 * Note: According to 27.005
 *
 *
*/
typedef struct PsilSmsSendInfo_Tag
{
    UINT16              reqHander;  /* if set to zero, just means no sending request */

    /*
     * Used for PDU mode, input of: +CMGS=<length><CR> or +CMGW=<length>[,<stat>]<CR>
     * <length> must indicate the number of octets coded in the TP layer data unit to be given
     * (i.e. SMSC address octets are excluded)
     * If set to 0, just means not set.
     *
    */
    UINT16              reqPduLen;

    /*
     * For Text mode,
     * +CMGS=<da>[,<toda>]<CR>...
     *
     * +CMGW[=<oa/da>[,<tooa/toda>[,<stat>]]]<CR>
     *
     * example:
     * DA: "+8613813801380"
     * daInfo.len = 13
     * daInfo.digits = "8613813801380\0" => string format
     */
    CmiSmsAddressInfo   daInfo; /* If is MO SMS message, it will be destination address. */

    /*
     * Concatenated SMS
     * +ECCMGS=<da>[,<toda>][,<msg_ref>,<msg_max>,<msg_seq>]<CR>
     *
    */
    BOOL                udhPresent;
    UINT8               refNum;
    UINT8               maxNum;
    UINT8               seqNum;

    UINT16              inputOffset;
    BOOL                bCommand;       /* Whether is AT+CMGC command */
    UINT8               reserved0;
    UINT8               input[PSIL_SMS_MAX_TXT_SIZE + 1];
}PsilSmsSendInfo;

/*
 * SMS send RP-ACK/RP-ERROR info, used for AT:
 * 1> AT+CNMA
 *   a) PDU mode
 *      +CNMA=<n>,<length><CR>
 *       PDU is given<ctrl-Z/ESC>
 * =====================================
 * Note: According to 27.005
 *
 *
*/
typedef struct PsilSmsSendAckInfo_Tag
{
    UINT16              reqHander;
    UINT8               reply;
    UINT16              ackPduLen;
    UINT16              ackPduOffset;
    UINT8               ackPdu[PSIL_SMS_MAX_PDU_SIZE_OF_DELIVER_REPORT*2+1];
}PsilSmsSendAckInfo;

/* for +CMGW command */
typedef struct PsilSmsWriteInfo_Tag
{
    UINT8                   smsMsgType;     /* SMS message type defined CmiSmsMessageType */
    UINT8                   stat;           /* defined CmiSmsRecStorStatus */
    UINT16                  reserved0;
    CmiSmsOptAddressInfo    scaInfo;        /* service centre address */
    PsilSmsSendInfo         smsSendInfo;
}PsilSmsWriteInfo;

/* for +CMGR/+CMGL/+CMSS */
typedef struct PsilSmsStoreItemInfo_tag
{
    UINT8                   smsRecStatus;   /* SMS record status. Enum CmiSmsRecStorStatus */
    UINT8                   smsRecMsgType;  /* SMS message type, defined type CmiSmsMessageType */
    BOOL                    scAddrPresent;  /* SC Address info present or not */
    UINT8                   memIndex;       /* memory index */
    CmiSmsAddressInfo       scAddrInfo;     /* SC address info */
    CmiSmsPdu               smsPduData;     /* SMS PDU contents */
}PsilSmsStoreItemInfo;

typedef struct PsilSmsTimeStampInfo_tag
{
    UINT8   year;
    UINT8   month;
    UINT8   day;
    UINT8   hour;
    UINT8   minute;
    UINT8   second;
    UINT8   tz;         /* time zone */
    UINT8   tzSign;     /* '+'/'-' */
}PsilSmsTimeStampInfo;

typedef struct PsilSmsDcsInfo_Tag
{
    UINT8  type;
    UINT8  msgClass;
    UINT8  alphabet;
    UINT8  indication;
    UINT8  dcs;
}PsilSmsDcsInfo;

typedef union
{
    UINT8                   vpRelativeFormat;   /* Relative Format: 1 octet, TS-23.040 9.23.12.1 */
    PsilSmsTimeStampInfo    vpAbsoluteFormat;   /* Absolute Format: as TP-SCTS, TS-23.040 9.23.12.2 */
    UINT8                   vpEnhancedFormat[PSIL_SMS_VP_OCTET_MAX_LENGTH + 1]; /* Enhanced Format: TS-23.040 9.23.12.3 */
}PsilSmsValidityPeriodValue;

typedef struct PsilSmsValidityPeriodInfo_tag
{
    UINT8                       vpfType;    /* defined PsilSmsValidityPeriodFormat */
    UINT8                       reserved0;
    UINT16                      reserved1;
    PsilSmsValidityPeriodValue  vpValue;
}PsilSmsValidityPeriodInfo;

/* SMS sumbit message structure info for Text mode
 * Refer to TS-23.040 9.2.2.2 */
typedef struct AtecMoSubmitSmsInfo_Tag
{
    UINT8                       firstOctet;                             /* first octet */
    UINT8                       protocolId;                             /* TP-PD */
    UINT8                       smsMsgRef;                              /* message reference */
    UINT8                       destAddrType;                           /* type of mumber for dest address */
    UINT16                      smsLength;                              /* length of body */
    UINT16                      reserved0;
    UINT8                       destAddr[PSIL_MSG_MAX_ADDR_LEN + 1];    /* TP Destination Address */
    PsilSmsValidityPeriodInfo   validityPreriod;                        /* TP-VP */
    PsilSmsDcsInfo              dcsInfo;                                /* TP-DCS */
    UINT8                       cnctRefNum;                             /* Concatenated short message reference number */
    UINT8                       cnctMaxNum;                             /* Maximum number of short messages in the concatenated short message */
    UINT8                       cnctSeqNum;                             /* Sequence number of the current short message */
    UINT8                       smsBuffer[PSIL_SMS_MAX_TXT_SIZE + 1];       /* msg body buffer, Hex string format */
}AtecMoSubmitSmsInfo;

typedef struct AtecMtDeliverSmsInfo_Tag
{
    UINT8                       firstOctet;                             /* first octet */
    UINT8                       protocolId;                             /* TP-PID */
    UINT8                       srcAddrType;                            /* type of mumber for originating address */
    UINT16                      smsLength;                              /* length of body */
    UINT8                       srcAddr[PSIL_MSG_MAX_ADDR_LEN + 1];     /* originating address string */
    PsilSmsTimeStampInfo        timeStamp;                              /* TP-SCTS */
    PsilSmsDcsInfo              dcsInfo;                                /* TP-DCS */
    UINT8                       cnctRefNum;                             /* Concatenated short message reference number */
    UINT8                       cnctMaxNum;                             /* Maximum number of short messages in the concatenated short message */
    UINT8                       cnctSeqNum;                             /* Sequence number of the current short message */
    UINT8                       smsBuffer[PSIL_SMS_MAX_TXT_SIZE + 1];   /* message body buffer pdu string */
}AtecMtDeliverSmsInfo;

/* SMS status report structure info for Text mode */
typedef struct AtecStatusRptSmsInfo_Tag
{
    UINT8                       firstOctet;                             /* <fo>   first octet */
    UINT8                       tpMr;                                   /* <mr>   TP-MR */
    UINT8                       reciptAddr[PSIL_MSG_MAX_ADDR_LEN + 1];  /* <ra>   TP-Recipient-Address string */
    UINT8                       reciptAddrType;                         /* <tora> type of mumber for TP-Recipient-Address */
    PsilSmsTimeStampInfo        scTimeStamp;                            /* <scts> TP-Service-Centre-Time-Stamp */
    PsilSmsTimeStampInfo        destTime;                               /* <dt>   TP-Discharge-Time */
    UINT8                       tpStatus;                               /* <st>   TpStatus */
}AtecStatusRptSmsInfo;

/* SMS submit report structure info for Text mode */
typedef struct AtecSubmitRptSmsInfo_Tag
{
    UINT8                       firstOctet;                             /* first octet */
    UINT8                       tpFcs;                                  /* TP-Failure-Cause */
    UINT8                       tpPi;                                   /* TP-Parameter-Indicator */
    PsilSmsTimeStampInfo        scTimeStamp;                            /* <scts> TP-Service-Centre-Time-Stamp */
}AtecSubmitRptSmsInfo;

/* concatnated SMS 8Bit IE data
 * Refer to TS-23.040 9.2.3.24.1 */
typedef struct UdhIeConcatenatedSms8Bit_Tag
{
    UINT8   refNum;     /* Octet 1 Concatenated short message reference number */
    UINT8   maxNum;     /* Octet 2 Maximum number of short messages in the concatenated short message */
    UINT8   seqNum;     /* Octet 3 Sequence number of the current short message */
}UdhIeConcatenatedSms8Bit;

typedef struct UdhIe_Tag
{
    TypeOfUdhIeId   ieId;

    union
    {
        UdhIeConcatenatedSms8Bit concatenatedSms8Bit;   /* UDH_IEI_CONCATENATED_SMS_8_BIT */
        /* TS-23.040 9.2.3.24 TP-User Data (TP-UD).The support of other Information Element Identifier is not implemented now */
    }ieData;
}UdhIe;

/* TS-23.038 5 CBS Data Coding Scheme */
typedef enum PsilCbsLanguage_Tag
{
    PSIL_SMS_CBS_LANG_GERMAN       = 0x00,
    PSIL_SMS_CBS_LANG_ENGLISH      = 0x01,
    PSIL_SMS_CBS_LANG_ITALIAN      = 0x02,
    PSIL_SMS_CBS_LANG_FRENCH       = 0x03,
    PSIL_SMS_CBS_LANG_SPANISH      = 0x04,
    PSIL_SMS_CBS_LANG_DUTCH        = 0x05,
    PSIL_SMS_CBS_LANG_SWEDISH      = 0x06,
    PSIL_SMS_CBS_LANG_DANISH       = 0x07,
    PSIL_SMS_CBS_LANG_PORTUGUESE   = 0x08,
    PSIL_SMS_CBS_LANG_FINNISH      = 0x09,
    PSIL_SMS_CBS_LANG_NORWEGIAN    = 0x0A,
    PSIL_SMS_CBS_LANG_GREEK        = 0x0B,
    PSIL_SMS_CBS_LANG_TURKISH      = 0x0C,
    PSIL_SMS_CBS_LANG_HUNGARIAN    = 0x0D,
    PSIL_SMS_CBS_LANG_POLISH       = 0x0E,
    PSIL_SMS_CBS_LANG_UNSPECIFIED  = 0x0F,
    PSIL_SMS_CBS_LANG_CZECH        = 0x20,
    PSIL_SMS_CBS_LANG_HEBREW       = 0x21,
    PSIL_SMS_CBS_LANG_ARABIC       = 0x22,
    PSIL_SMS_CBS_LANG_RUSSIAN      = 0x23,
    PSIL_SMS_CBS_LANG_ICELANDIC    = 0x24
}PsilCbsLanguage;

typedef struct PsilCbsDcsInfo_Tag
{
    BOOL                isCompressed;
    BOOL                isLanguageIncluded;
    UINT8               cbLanguage; //PsilCbsLanguage
    UINT8               alphabet;
    UINT8               cbClass;    //CmiSmsMessageClass
}PsilCbsDcsInfo;

/******************************************************************************
 *****************************************************************************
 * API
 *****************************************************************************
******************************************************************************/
CmsRetId smsQuerySmsService(UINT32 atHandle);
CmsRetId smsGetSmsService(UINT32 atHandle);
CmsRetId smsSetSmsService(UINT32 atHandle, const UINT32 service);
BOOL smsGetSCAddrFromNvm(CmiSmsAddressInfo          *pSmscAddr);
CmsRetId smsGetSrvCenterAddr(UINT32 atHandle, CmiSmsAddressInfo *pScAddressinfo);
CmsRetId smsSetSrvCenterAddr(UINT32 atHandle, const UINT8 *addressStr, UINT16 addrStrLen, UINT32 toaOctType);
void smsResetSrvCenterAddr(void);
void smsPduDecodeAddress(UINT8 *pduData, UINT8 *pOffset, UINT8 *pAddressType, UINT8 *pAddress, UINT8 addressSize);
void smsPduDecodeDcs(UINT8 *pduData, UINT8 *pOffset, PsilSmsDcsInfo *pDcsInfo);
void smsPduDecodeTimeStamp(UINT8 *pduData, UINT8 *pOffset, PsilSmsTimeStampInfo *pTimeStamp);
void smsPduDecodeUserData(UINT8                 *pUserData,
                          UINT8                 pduDataLen,
                          PsilMsgCodingType     codingType,
                          BOOL                  hdrPresent,
                          UINT8                 *pOutData,
                          UINT16                *pSmsLength,
                          UINT16                dstBufSize,
                          UdhIe                 *pUdhIe);

CmsRetId smsSendSms(UINT8 smsFormat, PsilSmsSendInfo *pSendInfo);
CmsRetId smsWriteSms(UINT8 smsFormat, PsilSmsWriteInfo *pWriteInfo, UINT8 smsMemType, UINT8* memIndex);
CmsRetId smsSendStoredSms(UINT32 atHandle, BOOL daPresent, CmiSmsAddressInfo *pDestAddrInfo, PsilSmsStoreItemInfo *pSendInfo);
CmsRetId smsPduReplaceDestAddress(CmiSmsAddressInfo *pNewDestAddrInfo, CmiSmsPdu *pInSmsPdu, CmiSmsPdu *pOutSmsPdu);
CmsRetId smsReadSmsFromNvm(UINT8 memIndex, PsilSmsStoreItemInfo *pReadSmsInfo);

BOOL SmsSubmitPduToText(AtecMoSubmitSmsInfo *pMoSumbitInfo, CmiSmsPdu *pPduData);
BOOL SmsDeliverPduToText(AtecMtDeliverSmsInfo *pMtDeliverInfo, CmiSmsPdu *pPduData);

UINT16 errorCauseofSendSms(UINT16 rc, UINT8 rpCause, UINT8 tpCause, UINT16 errorCode);
void smsSmscToHexStrPdu(CmiSmsAddressInfo *pScaInfo, CHAR *pSmsc, UINT16 *pSmscLen);
CmsRetId smsSetMoreMessageMode(UINT32 atHandle, const UINT8 mode);
CmsRetId smsGetMoreMessageState(UINT32 atHandle);
CmsRetId smsGetCscbSetting(UINT32 atHandle);
CmsRetId smsSetCscbSetting(UINT32 atHandle, BOOL mode, CHAR *pMids, CHAR *pDcss);
CmsRetId smsGetStoredInSimSmsMsg(UINT32 atHandle, UINT8 readIndex, UINT8 readMode);
CmsRetId smsSetStoredInSimSmsMsg(UINT32 atHandle, UINT8 savedMode, UINT8 smsStatus, BOOL scAddrPresent, CmiSmsAddressInfo * pScAddr, CmiSmsPdu * pSavedSmsPdu);
CmsRetId smsDelStoredInSimSmsMsg(UINT32 atHandle, UINT8 delIndex, UINT8 delFlag);
CmsRetId smsGetPrefMemStorageInfoInSim(UINT32 atHandle, UINT8 listMode);
CmsRetId smsListSmsStoredInSimSmsMsg(UINT32 atHandle, UINT8 listStatus);

BOOL smsStateStrToInt(CHAR *statString, UINT8 *pStat);
BOOL smsStateIntToStr(UINT8 stat, CHAR *pStatString);
PsilSmsStoreMemType smsGetSmsPrefMsgStorageType(PsilSmsStoreMemNum memDomain);
CmsRetId smsReadSmsStoreRecord(UINT32 atHandle, UINT8 memIndex, UINT8 smsMemType, UINT8 readCmd, PsilSmsStoreItemInfo * pReadSmsInfo);
CmsRetId smsUpdateSmsToNvm( UINT8 memIndex, PsilSmsStoreItemInfo *pStoreSmsInfo);
CmsRetId smsUpdateSmsStoreRecord(UINT8 memIndex, UINT8 smsMemType, PsilSmsStoreItemInfo * pReadSmsInfo);
CmsRetId smsDeleteSmsStoreRecord(UINT32 atHandle, CmiSmsOperationMode delOperat, UINT8 smsMemType, UINT8 delIndex, CmiSmsDelFlag delFlag);
CmsRetId smsSetSmsp(UINT32 atHandle);
CmsRetId smsSendSMMA(UINT32 atHandle);
BOOL smsSubmitTpduLen(UINT8 *pTpduLen, CmiSmsPdu *pPduData);
BOOL smsDeliverTpduLen(UINT8 *pTpduLen, CmiSmsPdu *pPduData);
BOOL SmsStatusRptPduToText(AtecStatusRptSmsInfo *pStatusRptInfo, CmiSmsPdu *pPduData);
void smsDecodeCbsData(UINT8 *pPdu, UINT8 pduDataLen, PsilMsgCodingType codingType, UINT8 *pOutData, UINT8 *pOutLength, UINT8 dstBufSize);
UINT16 smsAsciiToUcs2(const UINT8 *pAscii, UINT16 iLengh, UINT8 *pUcs2, UINT16 oLengh);
UINT16 smsUcs2ToAscii(const UINT8 *pUcs2, UINT16 iLengh, UINT8 *pAscii, UINT16 oLengh);
CmsRetId smsSetMemCap(UINT32 atHandle, BOOL isMemCapExceed);
BOOL SmsSubmitRptPduToText(AtecSubmitRptSmsInfo *pSubmitRptInfo, CmiSmsPdu *pPduData, BOOL bePositiveAck);
void smsPduDecodeCbsDCS(UINT8 *pduData, UINT8 *pOffset, PsilCbsDcsInfo *pDcsInfo);
void smsSendNewMsgRsp(UINT32 reqHandle, UINT8 smsId, UINT32 reply, UINT8 tpCause, UINT16 ackPduLen, UINT8 *ackPdu);
CmsRetId smsSrvCenterAddrToText(CHAR *smscBuf, UINT8 smscBufLen, CmiSmsAddressInfo *scAddrInfo);

#endif

