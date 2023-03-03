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

#ifndef LUAT_SMS_H
#define LUAT_SMS_H

#include "luat_base.h"

#define LUAT_MSG_MAX_ADDR_LEN 80
#define LUAT_SMS_MAX_TXT_SIZE 640
#define LUAT_SMS_MAX_PDU_SIZE 180
#define LUAT_SMS_MAX_LENGTH_OF_ADDRESS_VALUE 40
#define LUAT_SMS_MAX_ADDR_STR_MAX_LEN ((LUAT_SMS_MAX_LENGTH_OF_ADDRESS_VALUE + 1) * 4)
typedef void (*LUAT_SMS_HANDLE_CB)(uint8_t event, void* param);
typedef void (*LUAT_SMS_HANDLE_SEND_CB)(int ret);

typedef enum
{
    SMS_SEND_OK = 0,
    SMS_ME_FAILURE = 300,
    SMS_SERVICE_OF_ME_RESV,
    SMS_OPERATION_NOT_ALLOWED,
    SMS_OPERATION_NOT_SUPPORTED,
    SMS_INVALID_PDU_MODE_PARAMETER,
    SMS_INVALID_TEXT_MODE_PARAMETER,
    SMS_USIM_NOT_INSERTED = 310,
    SMS_USIM_PIN_REQUIRED,
    SMS_PHSIM_PIN_REQUIRED,
    SMS_USIM_FAILURE,
    SMS_USIM_BUSY,
    SMS_USIM_WRONG,
    SMS_USIM_PUK_REQUIRED,
    SMS_USIM_PIN2_REQUIRED,
    SMS_USIM_PUK2_REQUIRED,
    SMS_MEMORY_FAILURE = 320,
    SMS_INVALID_MEM_INDEX,
    SMS_MEM_FULL,
    SMS_SMSC_ADDR_UNKNOWN = 330,
    SMS_NO_NETWORK_SERVICE,
    SMS_NETWORK_TIMEOUT,
    SMS_NO_CNMA_ACK_EXPECTED = 340,
    SMS_UNKNOWN_ERROR = 500,
    SMS_INVALID_DATA  = 550,
    SMS_UNSUPPORT_TEXT_WITH_CHINESE = 555,
    SMS_MAX_ERROR = 0xFFFF
}LUAT_SMS_SEND_RET_CODE_E;

typedef struct
{
    LUAT_SMS_HANDLE_CB cb;
    LUAT_SMS_HANDLE_SEND_CB send_cb;
}LUAT_SMS_MAIN_CFG_T;

typedef struct
{
    uint8_t   year;
    uint8_t   month;
    uint8_t   day;
    uint8_t   hour;
    uint8_t   minute;
    uint8_t   second;
    uint8_t   tz;         /* time zone */
    uint8_t   tz_sign;     /* '+'/'-' */
}LUAT_SMS_RECV_MSG_TIME_T;

typedef struct
{
    uint8_t  type;
    uint8_t  msg_class;
    uint8_t  alpha_bet;
    uint8_t  indication;
    uint8_t  dcs;
}LUAT_SMS_RECV_MSG_DCS_T;

//接受的短信信息结构体
typedef struct
{
    uint16_t pdu_length;//PDU 长度
    uint16_t sms_length;//TEXT 的长度
    LUAT_SMS_RECV_MSG_TIME_T time;//时间
    LUAT_SMS_RECV_MSG_DCS_T dcs_info;//Data Coding Scheme
    char pdu_data[LUAT_SMS_MAX_TXT_SIZE + 1];//PDU 数据
    uint8_t sms_buffer[LUAT_SMS_MAX_TXT_SIZE + 1];//TEXT 数据
    uint8_t sc_address[LUAT_MSG_MAX_ADDR_LEN + 1];//中心地址
    uint8_t phone_address[LUAT_MSG_MAX_ADDR_LEN + 1];//来电号码
    uint8_t refNum;
    uint8_t maxNum;
    uint8_t seqNum;
}LUAT_SMS_RECV_MSG_T;

/**
 * @defgroup luatos_sms 短信功能
 * @{
 */
/**
 * @brief 初始化短信
 */
void luat_sms_init(void);

/**
 * @brief 发送短信
 * @param p_input           短信的内容(当 is_pdu = false 时, 只支持英文，数字以及常用符号)
 * @param p_des             接收短信的手机号
 * @param is_pdu            是否是PDU格式的短信(当 false 时, 有效参数为 p_input & pdes, 当 true 时, 有效参数为 p_input & pudLen)
 * @param input_pdu_len     PDU格式短信的长度，注意和p_input长度没有关系
 * @return 0成功,-1失败
 */
int luat_sms_send_msg(uint8_t *p_input, char *p_des, bool is_pdu, int input_pdu_len);

/**
 * @brief 接受短信回调
 * @param callback_fun    回调函数
 */
void luat_sms_recv_msg_register_handler(LUAT_SMS_HANDLE_CB callback_fun);


/**
 * @brief 发送短信回调
 * @param callback_fun    回调函数
 */
void luat_sms_send_msg_register_handler(LUAT_SMS_HANDLE_SEND_CB callback_fun);

#endif