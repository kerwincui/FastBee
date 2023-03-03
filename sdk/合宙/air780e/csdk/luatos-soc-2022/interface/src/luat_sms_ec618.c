/*
 * Copyright (c) 2022 OpenLuat & AirM2M
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include "ostask.h"
#include "cmisim.h"
#include "cmimm.h"
#include "cmisms.h"
#include "cms_util.h"
#include "cmsis_os2.h"
#include "ps_sms_if.h"
#include "common_api.h"
#include "mw_nvm_config.h"
#include "mw_aon_info.h"
#include "luat_debug.h"
#include "luat_mobile.h"
#include "luat_sms.h"

#define LUAT_SMS_INFO(X,Y...) LUAT_DEBUG_PRINT("[DIO %d]: "X, __LINE__, ##Y)

static PsilSmsSendInfo *luat_p_sms_send_info = PNULL;
LUAT_SMS_MAIN_CFG_T luat_sms_cfg;


static void luat_sms_def_recv_cb(uint8_t event, void* param)
{
    LUAT_SMS_INFO("recv message: [%d | %X]", event, param);
}

static void luat_sms_def_send_cb(int ret)
{
    LUAT_SMS_INFO("send message: [%d]", ret);
}

void luat_sms_recv_msg_register_handler(LUAT_SMS_HANDLE_CB callback_fun)
{
    luat_sms_cfg.cb = callback_fun;
}

void luat_sms_send_msg_register_handler(LUAT_SMS_HANDLE_SEND_CB callback_fun)
{
    luat_sms_cfg.send_cb = callback_fun;
}


static UINT8 luat_sms_encode_concatenated_sms_8_bit(UdhIe *p_udhle, UINT8 *p_ied)
{
    OsaDebugBegin(p_udhle != PNULL && p_ied != PNULL, 0, 0, 0);
    return FALSE;
    OsaDebugEnd();

    if (p_udhle->ieData.concatenatedSms8Bit.maxNum == 0 ||
        p_udhle->ieData.concatenatedSms8Bit.maxNum == 1 ||
        p_udhle->ieData.concatenatedSms8Bit.seqNum == 0 ||
        p_udhle->ieData.concatenatedSms8Bit.seqNum > p_udhle->ieData.concatenatedSms8Bit.maxNum)
    {
        LUAT_SMS_INFO("AT CMD, UDH is illegal: maxNum:%d, seqNum:%d",
                    p_udhle->ieData.concatenatedSms8Bit.maxNum,
                    p_udhle->ieData.concatenatedSms8Bit.seqNum);
        return 0;
    }

    p_ied[0] = p_udhle->ieId;
    p_ied[1] = 3; //IEDL
    p_ied[2] = p_udhle->ieData.concatenatedSms8Bit.refNum;
    p_ied[3] = p_udhle->ieData.concatenatedSms8Bit.maxNum;
    p_ied[4] = p_udhle->ieData.concatenatedSms8Bit.seqNum;

    return 5;
}

static UINT8 luat_sms_pdu_encode_udh(UdhIe *p_udhle, UINT8 *p_udh)
{
    if(p_udhle == PNULL || p_udh == PNULL)
    {
        return FALSE;
    }

    p_udh[0] = 0;

    switch (p_udhle->ieId)
    {
        case UDH_IEI_CONCATENATED_SMS_8_BIT:
            p_udh[0] = luat_sms_encode_concatenated_sms_8_bit(p_udhle, p_udh + 1);
            break;

        default:
            LUAT_SMS_INFO("UDH_IEI: %d is not support", p_udhle->ieId);
            break;
    }

    return  p_udh[0];
}

static UINT16 luat_sms_encode_gsm_7_bit_data(UINT8 *p_input, UINT16 input_length, UINT8 *p_output, UINT16 output_length, UINT16 shift_bits)
{
    UINT16  inIdx = 0, outIdx = 0;
    UINT8   bits = 0;

    GosCheck(p_input != PNULL && p_output != PNULL, p_input, p_output, 0);

    /*
    - eight characters in seven octets:
    - bits number:
      7  6  5  4  3  2  1  0
      2g 1a 1b 1c 1d 1e 1f 1g
      3f 3g 2a 2b 2c 2d 2e 2f
      4e 4f 4g 3a 3b 3c 3d 3e
      5d 5e 5f 5g 4a 4b 4c 4d
      6c 6d 6e 6f 6g 5a 5b 5c
      7b 7c 7d 7e 7f 7g 6a 6b
      8a 8b 8c 8d 8e 8f 8g 7a
    */

    /* shift_bits shoud be from 0 to 6 */
    shift_bits %= 7;

    if (shift_bits != 0)
    {
        p_output[outIdx] |= p_input[inIdx] << shift_bits;
        bits = 8 - shift_bits;

        if (bits == 7)
        {
            bits = 0;
            inIdx++;
        }
        outIdx++;
    }

    while ((inIdx < input_length) && (outIdx < output_length))
    {
        p_output[outIdx] = p_input[inIdx] >> bits;

        if (inIdx + 1 < input_length)
        {
            p_output[outIdx] |= p_input[inIdx + 1] << (7 - bits);

            if (++bits == 7)
            {
                bits = 0;
                inIdx++;
            }
        }
        inIdx++;
        outIdx++;
    }

    /* number of octets encoded */
    return outIdx;
}

static const UINT8 luat_sms_ascii2_gsm_def_alpha_bet_table[] =
{
/*         0     1     2     3     4     5     6     7     8     9     a     b     c     d     e     f */
/* 0 */ 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x0A, 0x3F, 0x3F, 0x0D, 0x3F, 0x3F,
/* 1 */ 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
/* 2 */ 0x20, 0x21, 0x22, 0x23, 0x02, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
/* 3 */ 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F,
/* 4 */ 0x00, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F,
/* 5 */ 0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x28, 0x2F, 0x29, 0x3F, 0x11,
/* 6 */ 0x27, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F,
/* 7 */ 0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x28, 0x2F, 0x29, 0x2D, 0x3F
};

static const UINT8 luat_sms_ascii2_gsm_def_alpha_bet_ext_table[] =
{
/*         0     1     2     3     4     5     6     7     8     9     a     b     c     d     e     f */
/* 0 */ 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
/* 1 */ 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
/* 2 */ 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
/* 3 */ 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
/* 4 */ 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
/* 5 */ 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3C, 0x2F, 0x3E, 0x14, 0x3F,
/* 6 */ 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
/* 7 */ 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x28, 0x40, 0x29, 0x3D, 0x3F,
/* 8 */ 0x65
};

static CmsRetId luat_sms_ascii_gsm_def_alpha_bet(UINT8 *p_ascii, UINT8 ascii_len, UINT8 *p_gsm, UINT8 *gsm_len)
{
    UINT8       idxAscii = 0;
    UINT8       idxGsm   = 0;
    const char  *extGsmAlpha = "^{}\\[~]|\x80";

    for (idxAscii = 0; idxAscii < ascii_len; idxAscii++)
    {
        if (p_ascii[idxAscii] <= 0x80)
        {
            if (strchr(extGsmAlpha, p_ascii[idxAscii]) == PNULL)
            {
                if (idxGsm >= PSIL_SMS_MAX_7BIT_TXT_SIZE)
                {
                    *gsm_len = PSIL_SMS_MAX_7BIT_TXT_SIZE;
                    LUAT_SMS_INFO("PSIL SMS, output length (%d) should not exceed %d", idxGsm, PSIL_SMS_MAX_7BIT_TXT_SIZE);
                    return CMS_FAIL;
                }
                p_gsm[idxGsm++] = luat_sms_ascii2_gsm_def_alpha_bet_table[p_ascii[idxAscii]];
            }
            else
            {
                if (idxGsm >= PSIL_SMS_MAX_7BIT_TXT_SIZE - 1)
                {
                    *gsm_len = PSIL_SMS_MAX_7BIT_TXT_SIZE - 1;
                    LUAT_SMS_INFO("PSIL SMS, input length (%d) should not exceed %d", idxGsm, PSIL_SMS_MAX_7BIT_TXT_SIZE - 1);
                    return CMS_FAIL;
                }
                p_gsm[idxGsm++] = PSIL_SMS_ESCAPE_EXTERN_TBL_CODE;
                p_gsm[idxGsm++] = luat_sms_ascii2_gsm_def_alpha_bet_ext_table[p_ascii[idxAscii]];
            }
        }
        else
        {
            LUAT_SMS_INFO("PSIL SMS, invalid input pInGsm[%d]: 0x%x", idxAscii, p_ascii[idxAscii]);
            return CMS_FAIL;
        }
    }
    *gsm_len = idxGsm;
    return CMS_RET_SUCC;
}

static CmsRetId luat_sms_msg_encode_user_data(PsilMsgCodingType  coding_scheme,
                                 UINT8              *p_tpdu,
                                 PsilSmsSendInfo    *p_send_info,
                                 UINT8              offset,
                                 UINT8              *p_pdu_length)
{
    UINT8               udhl = 0;           /* user data header length */
    UINT8               hdrTotalLen = 0;    /* User data header length + 1 octet 'Length of User Data Header' */
    UINT8               fillBits = 0;       /* fill bits */
    UINT16              length = 0;
    UINT8               *pSrc = p_send_info->input;
    UINT16              msgLen = p_send_info->inputOffset;
    UdhIe               udhIe;              /* user data header */
    PsilSmsCharSet      charSet = PSIL_SMS_CHAR_SET_IRA;
    UINT8               gsm7bitBuf[PSIL_SMS_MAX_TXT_SIZE];
    UINT8               gsm7bitLen = 0;

    MWNvmCfgCSCSParam   cscsParam;

    /* TP-User-Data-Length */
    p_tpdu[offset] = 0;

    if (msgLen)
    {
        switch (coding_scheme)
        {
            case PSIL_MSG_CODING_DEFAULT_7BIT:
                LUAT_SMS_INFO("the coding is PSIL_MSG_CODING_DEFAULT_7BIT");
                mwNvmCfgGetCscsParam(&cscsParam);
                if ((strncmp((const CHAR*)cscsParam.characterSet, "UCS2", strlen(cscsParam.characterSet)) == 0))
                {
                    charSet = PSIL_SMS_CHAR_SET_UCS2;
                }
                if (charSet == PSIL_SMS_CHAR_SET_UCS2)
                {
                    if (p_send_info->inputOffset % 4 != 0)
                    {
                        LUAT_SMS_INFO("PSIL SMS, invalid UCS2 length: %d", p_send_info->inputOffset);
                        return CMS_FAIL;
                    }

                    pSrc = (UINT8 *)malloc(p_send_info->inputOffset/4);

                    msgLen = smsUcs2ToAscii(p_send_info->input, p_send_info->inputOffset, pSrc, p_send_info->inputOffset/4);
                }
                if (p_send_info->udhPresent)
                {
                    udhIe.ieId = UDH_IEI_CONCATENATED_SMS_8_BIT;
                    udhIe.ieData.concatenatedSms8Bit.refNum = p_send_info->refNum;
                    udhIe.ieData.concatenatedSms8Bit.maxNum = p_send_info->maxNum;
                    udhIe.ieData.concatenatedSms8Bit.seqNum = p_send_info->seqNum;

                    udhl = luat_sms_pdu_encode_udh(&udhIe, &p_tpdu[offset + 1]);
                    hdrTotalLen = udhl + 1; /* + 1 octet 'Length of User Data Header' */

                    if (udhl == 0)
                    {
                        LUAT_SMS_INFO("PSIL SMS, user data header length is 0");
                    }

                    if (0 != (hdrTotalLen*8)%7)
                    {
                        fillBits = 7 - (hdrTotalLen*8)%7;
                    }

                    /* encode SM */
                    luat_sms_ascii_gsm_def_alpha_bet(pSrc, (UINT8)msgLen, gsm7bitBuf, &gsm7bitLen);

                    length = (UINT8)luat_sms_encode_gsm_7_bit_data(gsm7bitBuf, gsm7bitLen, &p_tpdu[offset + 1 + hdrTotalLen],
                                                         PSIL_SMS_MAX_PDU_SIZE - (offset + 1 + hdrTotalLen), fillBits);

                    /* TP-User-Data-Length */
                    p_tpdu[offset] = gsm7bitLen + (hdrTotalLen*8 + fillBits)/7;
                    length += hdrTotalLen;
                }
                else
                {
                    luat_sms_ascii_gsm_def_alpha_bet(pSrc, (UINT8)msgLen, gsm7bitBuf, &gsm7bitLen);
                    LUAT_SMS_INFO("gsm7bitLen is %u", gsm7bitLen);

                    length = (UINT8)luat_sms_encode_gsm_7_bit_data(gsm7bitBuf, gsm7bitLen, &p_tpdu[offset + 1], PSIL_SMS_MAX_PDU_SIZE - offset, 0);
                    p_tpdu[offset] = gsm7bitLen;
                    LUAT_SMS_INFO("length: %hu, gsm7bitLen is %u", length, gsm7bitLen);
                }
                LUAT_SMS_INFO("length is %d", length);
                if (charSet == PSIL_SMS_CHAR_SET_UCS2)
                {
                    free(pSrc);
                }
                break;
            case PSIL_MSG_CODING_8BIT:
                if (p_send_info->udhPresent)
                {
                    LUAT_SMS_INFO("PSIL SMS, UDH is not supported in DCS 8BIT");

                    udhIe.ieId = UDH_IEI_CONCATENATED_SMS_8_BIT;
                    udhIe.ieData.concatenatedSms8Bit.refNum = p_send_info->refNum;
                    udhIe.ieData.concatenatedSms8Bit.maxNum = p_send_info->maxNum;
                    udhIe.ieData.concatenatedSms8Bit.seqNum = p_send_info->seqNum;

                    udhl = luat_sms_pdu_encode_udh(&udhIe, &p_tpdu[offset + 1]);
                    hdrTotalLen = udhl + 1; /* + 1 octet 'Length of User Data Header' */

                    if (udhl == 0)
                    {
                        LUAT_SMS_INFO("PSIL SMS, user data header length is 0");
                    }
                }

                length = msgLen + hdrTotalLen;
                p_tpdu[offset] = (UINT8)msgLen;
                if ((length <= PSIL_SMS_MAX_UD_SIZE) &&
                    (length <= PSIL_SMS_MAX_PDU_SIZE - (offset + 1 + hdrTotalLen)))
                {
                    memcpy(&p_tpdu[offset + hdrTotalLen + 1], pSrc, msgLen);
                    p_tpdu[offset] = (UINT8)length;
                }
                else
                {
                    LUAT_SMS_INFO("PSIL SMS, length = %d, user data size should be from 0 to 140", msgLen);
                    return CMS_FAIL;
                }

                break;
            case PSIL_MSG_CODING_UCS2:
                /*+\Bug 7012\sunzhipeng\2022.11.14\text模式下无法发出中文短信*/
                /* hex string -> hex */
                if (msgLen % 2 != 0)
                {
                    return CMS_FAIL;
                }
                /*-\Bug 7012\sunzhipeng\2022.11.14\text模式下无法发出中文短信*/
                if (p_send_info->udhPresent)
                {
                    LUAT_SMS_INFO("PSIL SMS, UDH is not supported in DCS UCS2");
                    udhIe.ieId = UDH_IEI_CONCATENATED_SMS_8_BIT;
                    udhIe.ieData.concatenatedSms8Bit.refNum = p_send_info->refNum;
                    udhIe.ieData.concatenatedSms8Bit.maxNum = p_send_info->maxNum;
                    udhIe.ieData.concatenatedSms8Bit.seqNum = p_send_info->seqNum;

                    udhl = luat_sms_pdu_encode_udh(&udhIe, &p_tpdu[offset + 1]);
                    hdrTotalLen = udhl + 1; /* + 1 octet 'Length of User Data Header' */

                    if (udhl == 0)
                    {
                        LUAT_SMS_INFO("PSIL SMS, user data header length is 0");
                    }
                }
                length = msgLen + hdrTotalLen;
                if ((length <= PSIL_SMS_MAX_UD_SIZE) && (length <= PSIL_SMS_MAX_PDU_SIZE - (offset + 1 + hdrTotalLen)))
                {
                    memcpy(&p_tpdu[offset + hdrTotalLen + 1], pSrc, msgLen);
                    p_tpdu[offset] = (UINT8)length;
                }
                else
                {
                    LUAT_SMS_INFO("PSIL SMS, length = %d, user data size should be from 0 to 140", msgLen);
                    return CMS_FAIL;
                }
                p_tpdu[offset] = (UINT8)length;
                break;
            default:
                LUAT_SMS_INFO("PSIL SMS, invalid coding_scheme = %d", coding_scheme);
                return CMS_FAIL;
        }
    }

    if (length > PSIL_SMS_MAX_UD_SIZE)
    {
        LUAT_SMS_INFO("PSIL SMS, length = %d, user data size should be from 0 to 140", length);
        return CMS_FAIL;
    }

    *p_pdu_length = (UINT8)(length + 1 + offset);  //1: UDL Octet

    return CMS_RET_SUCC;
}


static void luat_sms_fill_number_digit(UINT8 *p_output, UINT8 index, UINT8 number_digit)
{
    UINT8   *pData = &p_output[index/2]; /* two digits encode to one octet */

    if (0 == (index & 0x01))
    {
        /* Put into low 4 bits */
        *pData = (*pData & 0xF0) | (number_digit & 0x0F);
    }
    else
    {
        /* Put into high 4 bits */
        *pData = (*pData & 0x0F) | ((number_digit << 4) & 0xF0);
    }

    return;
}

static CmsRetId luat_sms_submit_text_2_pdu(PsilSmsSendInfo *p_send_info, CmiSmsPdu *p_cmi_pdu)
{
    UINT8                       offset = 0, tmpIdx = 0;
    UINT8                       vpfType = PSIL_SMS_VPF_NOT_PRESENT; /* PsilSmsValidityPeriodFormat */
    UINT8                       pduLength = 0;
    UINT8                       *pDestAddress = PNULL;
    UINT8                       *p_tpdu = p_cmi_pdu->pduData;
    MWNvmCfgCSMPParam           csmpParam = {0};
    MidWareSimSmsParamsAonInfo  mwAonSimSmsp = {0};
    PsilSmsDcsInfo              dcsInfo;

    if ((p_send_info->inputOffset == 0) || (p_send_info->inputOffset > PSIL_SMS_MAX_TXT_SIZE))
    {
        LUAT_SMS_INFO("PSIL SMS, send Text SMS, length: %d is 0, or > MAX: %d", p_send_info->inputOffset, PSIL_SMS_MAX_TXT_SIZE);
        return CMS_FAIL;
    }

    LUAT_SMS_INFO("PSIL SMS, send Text SMS, length: %d, MAX: %d", p_send_info->inputOffset, PSIL_SMS_MAX_TXT_SIZE);

    csmpParam.fo    = PSIL_MSG_FO_SUBMIT_DEFAULT;
    csmpParam.vp[0] = PSIL_MSG_VP_DEFAULT;
    csmpParam.pid   = PSIL_MSG_PID_DEFAULT;
    csmpParam.dcs   = PSIL_MSG_CODING_DEFAULT_7BIT;

    /* get the CSMP config from SIM */
    mwGetSimSmspAonInfo(&mwAonSimSmsp);
    LUAT_SMS_INFO("addr: %s | %u, scAddr: %s | %u | %u | %u",
    mwAonSimSmsp.destAddr.addressDigits, mwAonSimSmsp.destAddr.length,
    mwAonSimSmsp.scAddr.addressDigits, mwAonSimSmsp.scAddr.length, mwAonSimSmsp.scAddr.numberPlanId, mwAonSimSmsp.scAddr.typeOfNumber);

    LUAT_SMS_INFO("proto: %u, %u | %u | %u", mwAonSimSmsp.smsProtocolId,mwAonSimSmsp.bCodingSchemePresent,
    mwAonSimSmsp.bValidityPeriodPresent, mwAonSimSmsp.bProtocolIdPresent);

    /* update vp/pid/dcs if present in EFS SMSP */

    /* TP-VPF(Validitiy-Period-Format):
     * TS-23.040 9.2.3.3 TP-VPF 2 bits
     * bit 4 bit 3:
     * 0     0:     TP-VP field not present,
     * 0     1:     TP-VP field is enhanced format
     * 1     0:     TP-VP field is relative format
     * 1     1:     TP-VP field is absolute format
    */
    vpfType = ((csmpParam.fo & PSIL_SMS_FO_VPF_BIT_MASK) >> 3);

    if (PSIL_SMS_VPF_RELATIVE == vpfType)
    {
        if (mwAonSimSmsp.bValidityPeriodPresent)
        {
            csmpParam.vp[0] = mwAonSimSmsp.validityPeriod;
        }
    }

    if (mwAonSimSmsp.bProtocolIdPresent)
    {
        csmpParam.pid = mwAonSimSmsp.smsProtocolId;
    }

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
     * FO Fromat refer to TS-23.040 9.2.2 and 9.2.3
     *     ---------------------------------------------------
     * FO: TP-RP  | TP-UDHI | TP-SRR | TP-VPF | TP-RD | TP-MTI
     *     ---------------------------------------------------
     *        0   |    0    |    1   |   00   |   0   |  01
     *     ---------------------------------------------------
     * FO:0x21
    */
    if (p_send_info->udhPresent)
    {
        /* set UDHI for concatenated SMS */
        csmpParam.fo |= 0x40;
    }

    p_tpdu[offset++] = csmpParam.fo;

    /*
     * MR, set to zero by default, NAS SMS will set it which read from USIM
    */
    p_tpdu[offset++] = 0;

    /*
     * DA: Address length + Type-of-Address + Address Value, defined in TS-23.040 9.2.2 Layout of SMS-SUBMIT
     * DA length is 2-12 octets
     *
     * parse the Destination Service Centre address firstly
     *
     * Service Centre address, refer to TS-24.011 8.2.5.2
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

    pDestAddress = p_tpdu + offset;

    /* Address length, 1 octet */
    *pDestAddress++ = p_send_info->daInfo.addressLength;
    offset++;

    /* Type-of-Address, 1 octet
     * BIT No.  7   6  5  4       3 2 1 0
     *          1   NumType       NumPlan
     */
    *pDestAddress++ = (UINT8)(((p_send_info->daInfo.addressType.typeOfNumber) << 4) | p_send_info->daInfo.addressType.numberPlanId | 0x80);
    offset++;

    /* Format the BCD digits, fill the DA-address, 0-10 octets,
     * eg: +8613456789021 -> 68 31 54 76 98 20 F1
     */
    for (tmpIdx = 0; tmpIdx < p_send_info->daInfo.addressLength && tmpIdx < PSIL_MSG_MAX_ADDR_LEN; tmpIdx++)
    {
        luat_sms_fill_number_digit(pDestAddress, tmpIdx, p_send_info->daInfo.addressDigits[tmpIdx]);
    }

    /* If the RP-Destination Address contains an odd number of digits, bits 5 to 8 of the
    last octet shall be filled with an end mark coded as "1111" */
    if (tmpIdx & 0x01)
    {
        luat_sms_fill_number_digit(pDestAddress, tmpIdx, 0x0F);
        tmpIdx++;
    }

    /* Upate the PDU byte index */
    offset += tmpIdx/2;

    /* Protocol Identifier(TP-PID) */
    p_tpdu[offset++] = csmpParam.pid;

    /* Data Coding Scheme(TP-DCS), detail TP-DCS defined see TS-24.038 chapter 4: SMS Data Coding Scheme */
    p_tpdu[offset] = csmpParam.dcs;
    smsPduDecodeDcs(p_tpdu, &offset, &dcsInfo);
    
    LUAT_SMS_INFO("dcsInfo: %u | %u | %u | %u | %u", 
    dcsInfo.alphabet, dcsInfo.dcs, dcsInfo.msgClass, dcsInfo.indication, dcsInfo.type);

    /* TP-Validity-Period */
    if (vpfType == PSIL_SMS_VPF_RELATIVE)
    {
        /* TS 23.040, 9.2.3.12.1 Relative Format,
         * VP comprises 1 octet in integer representation
         */
         p_tpdu[offset++] = csmpParam.vp[0];
    }
    else if ((vpfType == PSIL_SMS_VPF_ENHANCE) ||
             (vpfType == PSIL_SMS_VPF_ABSOLUTE))
    {
        /* TS 23.040, 9.2.3.12.2 Absolute Format and 9.2.3.12.3 Enhanched Format
         * VP comprises 7 octet.
         */
        for (tmpIdx = 0; tmpIdx < PSIL_SMS_VP_OCTET_MAX_LENGTH; tmpIdx++)
        {
            p_tpdu[offset++] = csmpParam.vp[tmpIdx];
        }
    }

    /*
     * Message Data (TP-UDL + TP-UD)
    */
    LUAT_SMS_INFO("encode: %d | offset: %d", dcsInfo.alphabet, offset);
    
    LUAT_SMS_INFO("p_send_info: %d | %u | %u | %u |[ %u | %u ]| %d | %s",
    p_send_info->udhPresent, p_send_info->maxNum, p_send_info->refNum, p_send_info->seqNum, p_send_info->inputOffset, offset, p_send_info->udhPresent, p_send_info->input);

    if (CMS_RET_SUCC != luat_sms_msg_encode_user_data(dcsInfo.alphabet,
                                             p_tpdu,
                                             p_send_info,
                                             offset,
                                             &pduLength))
    {
        return CMS_FAIL;
    }
    LUAT_SMS_INFO("pduLength: %d | p_tpdu: %s", pduLength, (char*)p_tpdu);

    p_cmi_pdu->pduLength = pduLength;

    LUAT_SMS_INFO("PSIL SMS, enCode PDU length:%d, offset:%d, DSC:%d", pduLength, offset, csmpParam.dcs);

    return CMS_RET_SUCC;
}

static int luat_sms_get_str_value(char* des_phone, UINT8  *p_out_str, UINT16 *p_out_str_len)
{
    INT16 length = 0;

    *p_out_str = '\0';

    if (p_out_str_len != PNULL)
    {
        *p_out_str_len = 0;
    }

    length = strlen(des_phone);

    if ((length + 1) > LUAT_SMS_MAX_ADDR_STR_MAX_LEN)
    {
        return 1;
    }
    memmove(p_out_str, des_phone, length);
    p_out_str[length] = '\0';

    if (p_out_str_len != PNULL)
    {
        *p_out_str_len = length;
    }

    return 0;
}

static BOOL luat_sms_get_input_addr_info(char* des_phone, CmiSmsAddressInfo *p_sms_addr)
{
    UINT16                  strIdx = 0, addrLen = 0;
    UINT8                   tmpAddrStr[LUAT_SMS_MAX_ADDR_STR_MAX_LEN] = {0};
    UINT8                   addrAsciiStr[CMI_SMS_MAX_LENGTH_OF_ADDRESS_VALUE + 1] = {0};
    UINT8                   *addrStr = PNULL;
    MWNvmCfgCSCSParam       cscsParam;

    memset(p_sms_addr, 0x00, sizeof(CmiSmsAddressInfo));

    /* <addr>, is must */
    if ((luat_sms_get_str_value(des_phone, tmpAddrStr, &addrLen) == 0))
    {
        LUAT_SMS_INFO("addrLen = %d | tmpAddrStr = %s", addrLen, tmpAddrStr);
        
        if (addrLen > 0)
        {
            mwNvmCfgGetCscsParam(&cscsParam);
            LUAT_SMS_INFO("cscsParam.characterSet: [%s]", (CHAR*)cscsParam.characterSet);
            if ((strncasecmp((const CHAR*)cscsParam.characterSet, "UCS2", strlen(cscsParam.characterSet)) == 0))
            {
                if (addrLen % 4 != 0)
                {
                    /* set the addressLength to invalide for +CMSS to return ERROR */
                    p_sms_addr->addressLength = 0xFF;
                    return FALSE;
                }
                addrLen = smsUcs2ToAscii(tmpAddrStr, addrLen, addrAsciiStr, CMI_SMS_MAX_LENGTH_OF_ADDRESS_VALUE);
                addrStr = addrAsciiStr;
            }
            else
            {
                addrStr = tmpAddrStr;
            }

            p_sms_addr->addressType.numberPlanId = CMI_SMS_NUM_PLAN_ID_ISDN_TELEPHONY; /* by default */

            if (addrStr[strIdx] == '+')
            {
                p_sms_addr->addressType.typeOfNumber = CMI_SMS_TYPE_OF_NUM_INTERNATIONAL; /* don't need to read the "<toaddr>" */
                strIdx++;
            }
            else
            {
                p_sms_addr->addressType.typeOfNumber = CMI_SMS_TYPE_OF_NUM_UNKNOWN;
            }

            p_sms_addr->addressLength = addrLen - strIdx;
            if (p_sms_addr->addressLength <= CMI_SMS_MAX_LENGTH_OF_ADDRESS_VALUE)
            {
                memcpy(p_sms_addr->addressDigits, addrStr + strIdx, addrLen - strIdx);
                return TRUE;
            }
        }
    }
    return FALSE;
}


static void luat_send_msg_call_cb(uint16_t param_size, void* p_param)
{
    LUAT_SMS_INFO("luat_send_msg_call_cb is in [%d]", param_size);
    psCamCmiReq(PS_DIAL_REQ_HANDLER, CAM_SMS, CMI_SMS_SEND_MSG_REQ, param_size, (CmiSmsSendMsgReq*)p_param);
}

static CmsRetId luat_sms_send_pdu_sms(PsilSmsSendInfo *p_send_info)
{
    CmiSmsSendMsgReq    cmi_msg_req;
    CmiSmsAddressInfo   *pScAddr = PNULL;

    UINT8   *pAtHexPdu = PNULL;
    INT32   atHexLen = 0;
    INT32   scAddrDigitLen = 0;
    INT32   hexOffset = 0;

    pAtHexPdu = (UINT8 *)malloc((p_send_info->inputOffset >> 1) + 1);

    /* hex string -> hex */
    atHexLen = cmsHexStrToHex(pAtHexPdu, ((p_send_info->inputOffset >> 1) + 1),
                              (const CHAR *)(p_send_info->input), p_send_info->inputOffset);

    if (atHexLen != (p_send_info->inputOffset >> 1))
    {
        return CMS_INVALID_PARAM;
    }

    memset(&cmi_msg_req, 0x00, sizeof(CmiSmsSendMsgReq));

    if (pAtHexPdu[0] + 1 >= atHexLen ||
        pAtHexPdu[0] > 11) /* just means not valid PDU, 11 = 1 byte TOA + 10 bytes Address value */
    {
        return CMS_INVALID_PARAM;
    }

    if (pAtHexPdu[0] > 0)   /* SC address present */
    {
        cmi_msg_req.optSca.present = TRUE;

        pScAddr = &(cmi_msg_req.optSca.addressInfo);

        /* pAtHexPdu[1] -> Type-of-Address */
        pScAddr->addressType.typeOfNumber = ((pAtHexPdu[1] >> 4) & 0x7);
        pScAddr->addressType.numberPlanId = (pAtHexPdu[1] & 0x0F);

        hexOffset = 2;
        /* pAtHexPdu[2] -> digit */
        while (scAddrDigitLen < (CMI_SMS_MAX_LENGTH_OF_ADDRESS_VALUE - 1) && hexOffset < (pAtHexPdu[0] + 1))
        {
            /* should be 0 - 9 digit */
            if ((pAtHexPdu[hexOffset] & 0x0F) <= 9)
            {
                pScAddr->addressDigits[scAddrDigitLen++] = (pAtHexPdu[hexOffset] & 0xF) + '0'; /* string digit */
            }
            else
            {
                /* invalid SC address */
                scAddrDigitLen = -1;
                break;
            }

            if (((pAtHexPdu[hexOffset] >> 4) & 0x0F) <= 9)
            {
                pScAddr->addressDigits[scAddrDigitLen++] = ((pAtHexPdu[hexOffset] >> 4) & 0xF) + '0'; /* string digit */
            }
            else if (((pAtHexPdu[hexOffset] >> 4) & 0x0F) == 0x0F)
            {
                /*
                 * From 24.011: if Address contains an odd number of digits, bits 5 to 8 of the last octet
                 * shall be filled with an end mark coded as "1111"
                */
                hexOffset++;
                break;
            }
            else
            {
                /* invalid SC address */
                scAddrDigitLen = -1;
                break;
            }

            hexOffset++;    /* next HEX */
        }

        if (scAddrDigitLen < 0 || hexOffset != (pAtHexPdu[0] + 1))
        {
            return CMS_INVALID_PARAM;
        }

        pScAddr->addressLength = scAddrDigitLen;
    }
    else
    {
        hexOffset++;
    }
    /* not support long SMS */
    cmi_msg_req.pdu.pduLength = atHexLen - hexOffset;

    memcpy(cmi_msg_req.pdu.pduData, pAtHexPdu + hexOffset, cmi_msg_req.pdu.pduLength);

    cmsNonBlockApiCall(luat_send_msg_call_cb, sizeof(CmiSmsSendMsgReq), &cmi_msg_req);

    free(pAtHexPdu);

    return CMS_RET_SUCC;
}

int luat_sms_send_msg(uint8_t *p_input, char *p_des, bool is_pdu, int input_pdu_len)
{
    int length = 0;
    CmsRetId cmsRet = CMS_RET_SUCC;
    CmiSmsAddressInfo destAddrInfo;
    PsilSmsFormatMode smsFormat;

    if (luat_p_sms_send_info == PNULL)
    {
        luat_p_sms_send_info = (PsilSmsSendInfo*)malloc(sizeof(PsilSmsSendInfo));
        memset(luat_p_sms_send_info, 0, sizeof(PsilSmsSendInfo));
    }

    if (is_pdu)
    {
        smsFormat = PSIL_SMS_FORMAT_PDU_MODE;
        luat_p_sms_send_info->reqPduLen = input_pdu_len;
    }
    else
    {
        smsFormat = PSIL_SMS_FORMAT_TXT_MODE;

        luat_sms_get_input_addr_info(p_des, &destAddrInfo);
        LUAT_SMS_INFO("destAddrInfo: %d | typeOfNumber: %d | numberPlanId: %d", destAddrInfo.addressLength,
                        destAddrInfo.addressType.typeOfNumber, destAddrInfo.addressType.numberPlanId);

        memcpy(&(luat_p_sms_send_info->daInfo), &destAddrInfo, sizeof(CmiSmsAddressInfo));

        char* judgeChinese = (char*)p_input;
        for (int i = 0; i < strlen(judgeChinese); i++)
        {
            if (*(judgeChinese+i) & 0x80)
            {
                LUAT_SMS_INFO("The input is Chinese");
                luat_sms_cfg.send_cb(SMS_UNSUPPORT_TEXT_WITH_CHINESE);
                return -1;
            }
        }
    }
    
    while(p_input[length++] != '\0');
    length -= 1;
    LUAT_SMS_INFO("first p_input len: %d", length);

    /* check the input length */
    if (smsFormat == PSIL_SMS_FORMAT_PDU_MODE)
    {
        /* input data: PDU string + CTRL_Z */
        if (luat_p_sms_send_info->inputOffset + length > (PSIL_SMS_HEX_PDU_STR_MAX_SIZE + 1))
        {
            LUAT_SMS_INFO("format is %d", smsFormat);
        }
    }
    else    //TXT format
    {
        /* input data: Text string + CTRL_Z */
        if (luat_p_sms_send_info->inputOffset + length > (PSIL_SMS_MAX_TXT_SIZE + 1))
        {
            LUAT_SMS_INFO("format is %d", smsFormat);
        }
    }
    luat_p_sms_send_info->inputOffset = 0;

    /* copy the data into buffer */
    memcpy(luat_p_sms_send_info->input + luat_p_sms_send_info->inputOffset, p_input, length);
    luat_p_sms_send_info->inputOffset += length;

    if (smsFormat == PSIL_SMS_FORMAT_PDU_MODE)
    {
        /* reomve the "\r\n" */
        if ((luat_p_sms_send_info->input[luat_p_sms_send_info->inputOffset-2] == '\r') &&
            (luat_p_sms_send_info->input[luat_p_sms_send_info->inputOffset-1] == '\n'))
        {
            luat_p_sms_send_info->inputOffset -= 2;
        }
    }

    LUAT_SMS_INFO("input: %s", luat_p_sms_send_info->input);
    LUAT_SMS_INFO("pdulen: %d", luat_p_sms_send_info->reqPduLen);

    if (smsFormat == PSIL_SMS_FORMAT_TXT_MODE)
    {
        CmiSmsSendMsgReq    cmi_msg_req;
        CmiSmsAddressInfo   sc_address_info = {0};

        memset(&cmi_msg_req, 0x00, sizeof(CmiSmsSendMsgReq));

        if (TRUE == smsGetSCAddrFromNvm(&sc_address_info))
        {
            LUAT_SMS_INFO("smsGetSCAddrFromNvm: is in");
            cmi_msg_req.optSca.present = TRUE;
            cmi_msg_req.optSca.addressInfo.addressLength = sc_address_info.addressLength;
            cmi_msg_req.optSca.addressInfo.addressType.typeOfNumber = sc_address_info.addressType.typeOfNumber;
            cmi_msg_req.optSca.addressInfo.addressType.numberPlanId = sc_address_info.addressType.numberPlanId;
            memcpy(&cmi_msg_req.optSca.addressInfo.addressDigits, sc_address_info.addressDigits, sc_address_info.addressLength);
        }

        LUAT_SMS_INFO("second p_input len: %u", luat_p_sms_send_info->inputOffset);
        cmsRet = luat_sms_submit_text_2_pdu(luat_p_sms_send_info, &(cmi_msg_req.pdu));
        LUAT_SMS_INFO("third pdulen: %hu | %d", cmi_msg_req.pdu.pduLength, cmsRet);

        // 这段日志有点猛,注释掉
        #if 0
        uint16_t index = 0;
        while(index != cmi_msg_req.pdu.pduLength)
        {
            LUAT_SMS_INFO("%u", cmi_msg_req.pdu.pduData[index++]);
        }
        #endif

        cmsNonBlockApiCall(luat_send_msg_call_cb, sizeof(CmiSmsSendMsgReq), &cmi_msg_req);
    }
    else /* PDU mode */
    {
        cmsRet = luat_sms_send_pdu_sms(luat_p_sms_send_info);
    }

    free(luat_p_sms_send_info);
    luat_p_sms_send_info = PNULL;
    return cmsRet;
}

/*************************接受短信****************************/
void luat_sms_nw_report_urc(CmiSmsNewMsgInd *p_cmi_msg_ind)
{
    PsilSmsFormatMode message_format = 0;
    UINT16 rsp_buf_pdu_max_len = p_cmi_msg_ind->pdu.pduLength * 2 + 100 + CMS_NULL_CHAR_LEN;
    CHAR sms_cBuf[PSIL_MSG_MAX_ADDR_LEN * 2 + CMS_NULL_CHAR_LEN];
    UINT16 sms_cLen = 0;

    if ((p_cmi_msg_ind->smsType == CMI_SMS_TYPE_DELIVER) || 
        (p_cmi_msg_ind->smsType ==CMI_SMS_TYPE_STATUS_REPORT) || 
        (p_cmi_msg_ind->smsType == CMI_SMS_TYPE_CB_ETWS_CMAS))
    {
        if (message_format == PSIL_SMS_FORMAT_PDU_MODE)
        {
            char *rsp_buf = (char*)malloc(rsp_buf_pdu_max_len);
            char *p_pdu_buf = (CHAR *)malloc(p_cmi_msg_ind->pdu.pduLength * 2 + 10);
            
            memset(sms_cBuf, 0x00, sizeof(sms_cBuf));
            memset(rsp_buf, 0x00, rsp_buf_pdu_max_len);
            memset(p_pdu_buf, 0x00, (p_cmi_msg_ind->pdu.pduLength * 2 + 10));
            smsSmscToHexStrPdu(&(p_cmi_msg_ind->smscAddress), sms_cBuf, &sms_cLen);

            if (cmsHexToHexStr(p_pdu_buf, p_cmi_msg_ind->pdu.pduLength * 2 + 10, p_cmi_msg_ind->pdu.pduData, p_cmi_msg_ind->pdu.pduLength) > 0)
            {
                switch (p_cmi_msg_ind->smsType)
                {
                    case CMI_SMS_TYPE_STATUS_REPORT:
                    {
                        /* SMSC address */
                        strcat(rsp_buf, sms_cBuf);
                        /* TPDU */
                        strcat(rsp_buf, p_pdu_buf);
                        break;
                    }
                    case CMI_SMS_TYPE_CB_ETWS_CMAS:
                    {
                        /* TPDU */
                        strcat(rsp_buf, p_pdu_buf);
                        break;
                    }
                    case CMI_SMS_TYPE_DELIVER:
                    default:
                    {
                        /* SMSC address */
                        strcat(rsp_buf, sms_cBuf);
                        /* TPDU */
                        strcat(rsp_buf, p_pdu_buf);
                        break;
                    }
                }

                // 这段日志也只需要在调试时使用
                #if 0
                int leng_old = 0;
                while (p_cmi_msg_ind->pdu.pduData[leng_old] != '\0')
                {
                    LUAT_SMS_INFO("[%d]", p_cmi_msg_ind->pdu.pduData[leng_old++]);
                }
                #endif
                
                LUAT_SMS_RECV_MSG_T recv_msg_info = {0};
                uint8_t start_offset = 0;
                uint8_t msg_phone_address_type;
                bool hdr_present = false;
                UdhIe hIe = {0};

                if ((p_cmi_msg_ind->pdu.pduData[start_offset]) & (0x40))
                {
                    hdr_present = true;
                }
                start_offset++;
                //获取发送方手机号
                smsPduDecodeAddress(p_cmi_msg_ind->pdu.pduData, &start_offset, &msg_phone_address_type, recv_msg_info.phone_address, (LUAT_MSG_MAX_ADDR_LEN + 1));
                LUAT_SMS_INFO("The recv msg: phone: %s", recv_msg_info.phone_address);
                start_offset++;
                PsilSmsDcsInfo msg_dcs_info;
                smsPduDecodeDcs(p_cmi_msg_ind->pdu.pduData, &start_offset, &msg_dcs_info);
                recv_msg_info.dcs_info.alpha_bet = msg_dcs_info.alphabet;
                LUAT_SMS_INFO("The recv msg: dcs: %d | %d | %d | %d", msg_dcs_info.alphabet, msg_dcs_info.dcs, msg_dcs_info.msgClass, msg_dcs_info.type);
                //获取发送方中心地址
                if (p_cmi_msg_ind->smscPresent)
                {
                    smsSrvCenterAddrToText(recv_msg_info.sc_address, sizeof(recv_msg_info.sc_address), &(p_cmi_msg_ind->smscAddress));
                    LUAT_SMS_INFO("The recv msg: sca: [%s]", recv_msg_info.sc_address);
                }
                //获取接受短信的时间
                PsilSmsTimeStampInfo tem_time = {0};
                smsPduDecodeTimeStamp(p_cmi_msg_ind->pdu.pduData, &start_offset, &tem_time);
                recv_msg_info.time.year = tem_time.year;
                recv_msg_info.time.month = tem_time.month;
                recv_msg_info.time.day = tem_time.day;
                recv_msg_info.time.hour = tem_time.hour;
                recv_msg_info.time.minute = tem_time.minute;
                recv_msg_info.time.second = tem_time.second;
                recv_msg_info.time.tz_sign = tem_time.tzSign;
                recv_msg_info.time.tz = tem_time.tz;
                LUAT_SMS_INFO("The recv msg: time: [\"%02d/%02d/%02d,%02d:%02d:%02d %c%02d\"]",
                    recv_msg_info.time.year, recv_msg_info.time.month,
                    recv_msg_info.time.day, recv_msg_info.time.hour,
                    recv_msg_info.time.minute, recv_msg_info.time.second,
                    recv_msg_info.time.tz_sign, recv_msg_info.time.tz);
                //获取PDU数据
                smsPduDecodeUserData((p_cmi_msg_ind->pdu.pduData + start_offset),
                                    (p_cmi_msg_ind->pdu.pduLength - start_offset - 1),
                                    (PsilMsgCodingType)recv_msg_info.dcs_info.alpha_bet,
                                    hdr_present,
                                    recv_msg_info.sms_buffer,
                                    &(recv_msg_info.sms_length),
                                    641,
                                    &hIe);
                LUAT_SMS_INFO("The recv msg: pdu: [%d | %d | %d | %s]", start_offset, p_cmi_msg_ind->pdu.pduLength,
                recv_msg_info.sms_length, (char*)(recv_msg_info.sms_buffer));
                recv_msg_info.refNum = hIe.ieData.concatenatedSms8Bit.refNum;
                recv_msg_info.maxNum = hIe.ieData.concatenatedSms8Bit.maxNum;
                recv_msg_info.seqNum = hIe.ieData.concatenatedSms8Bit.seqNum;
                memcpy(recv_msg_info.pdu_data, rsp_buf, rsp_buf_pdu_max_len);
                LUAT_SMS_INFO("The recv msg: ieData %d %d %d", recv_msg_info.refNum, recv_msg_info.maxNum, recv_msg_info.seqNum);
                recv_msg_info.pdu_length = p_cmi_msg_ind->pdu.pduLength;
                LUAT_SMS_INFO("The recv msg: %d[%s]", recv_msg_info.pdu_length, recv_msg_info.pdu_data);
                LUAT_SMS_INFO("The recv msg: [%s]", rsp_buf);
                //发送收到的短信给回调函数
                luat_sms_cfg.cb(p_cmi_msg_ind->smsType, &recv_msg_info);
            }
            //释放内存
            free(rsp_buf);
            free(p_pdu_buf);
        }
    }
}

static void luat_sms_recv_msg(CmiSmsNewMsgInd* param)
{
    // 总是上报给csdk回调, 不需要读取AT相关的配置参数
    if (1)
    {
        switch (param->smsType)
        {
        case CMI_SMS_TYPE_DELIVER:
            luat_sms_nw_report_urc(param);
            break;
        case CMI_SMS_TYPE_STATUS_REPORT:
            luat_sms_nw_report_urc(param);
            break;
        case CMI_SMS_TYPE_CB_ETWS_CMAS:
            luat_sms_nw_report_urc(param);
            break;
        default:
            LUAT_SMS_INFO("unkown param->smsType %d", param->smsType);
            break;
        }
    }

    //确认短信
    CmiSmsNewMsgRsp     new_msg_rsp;
    SignalBuf           *p_signal = PNULL;
    CamCmiRsp           *p_cac_cmi_rsp;

    memset(&new_msg_rsp, 0, sizeof(CmiSmsNewMsgRsp));

    new_msg_rsp.bRPAck = TRUE;
    new_msg_rsp.smsId = ((CmiSmsNewMsgInd *)param)->smsId;

    OsaCreateZeroSignal(SIG_CAM_CMI_RSP, (sizeof(CamCmiRsp) + sizeof(CmiSmsNewMsgRsp)), &p_signal);

    p_cac_cmi_rsp = (CamCmiRsp *)(p_signal->sigBody);
    p_cac_cmi_rsp->header.rspId = CMS_SET_CMI_REQ_CNF_ID(CAM_SMS, CMI_SMS_NEW_MSG_RSP);
    p_cac_cmi_rsp->header.rspHandler = BROADCAST_IND_HANDLER;
    memcpy(p_cac_cmi_rsp->body, &new_msg_rsp, sizeof(CmiSmsNewMsgRsp));

    OsaSendSignal(CCM_TASK_ID, &p_signal);
}

void luat_sms_proc(uint32_t event, void *param)
{
    switch (event)
    {
        case CMI_SMS_NEW_MSG_IND:
            luat_sms_recv_msg((CmiSmsNewMsgInd*)param);
            LUAT_SMS_INFO("CMI_SMS_NEW_MSG_IND is in");
            break;
        case CMI_SMS_SEND_MSG_CNF:
            LUAT_SMS_INFO("CMI_SMS_SEND_MSG_CNF is in");
            CmiSmsSendMsgCnf *send_sms_ret = (CmiSmsSendMsgCnf *)param;
            luat_sms_cfg.send_cb((int)send_sms_ret->errorCode);
            break;
    default:
        break;
    }
}

extern void soc_mobile_sms_event_register_handler(void *handle);
//初始化SMS
void luat_sms_init(void)
{
    luat_sms_cfg.cb = luat_sms_def_recv_cb;
    luat_sms_cfg.send_cb = luat_sms_def_send_cb;
	soc_mobile_sms_event_register_handler(luat_sms_proc);
}