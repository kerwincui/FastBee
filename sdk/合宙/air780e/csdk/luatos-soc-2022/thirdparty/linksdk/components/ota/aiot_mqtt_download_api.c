/**
 * @file aiot_mqtt_download_api.c
 * @brief mqtt文件下载的实现文件
 * @date 2019-12-27
 *
 * @copyright Copyright (C) 2015-2018 Alibaba Group Holding Limited
 *
 */

#include "aiot_ota_api.h"
#include "core_mqtt.h"
#include "core_string.h"
#include "core_sha256.h"
#include "ota_md5.h"
#include "core_log.h"
#include "core_global.h"
#include "mqtt_download_private.h"
#include "aiot_mqtt_download_api.h"
#include "ota_private.h"
#include "core_string.h"

static int32_t _md_send_request(void *handle);
static void _md_recv_data_reply_handler(void *handle, const aiot_mqtt_recv_t *msg, void *userdata);

/*
 * CRC lookup table for bytes, generating polynomial is 0x8005
 * input: reflexed (LSB first)
 * output: reflexed also...
 */

const uint16_t crc_ibm_table[256] = {
    0x0000, 0xc0c1, 0xc181, 0x0140, 0xc301, 0x03c0, 0x0280, 0xc241,
    0xc601, 0x06c0, 0x0780, 0xc741, 0x0500, 0xc5c1, 0xc481, 0x0440,
    0xcc01, 0x0cc0, 0x0d80, 0xcd41, 0x0f00, 0xcfc1, 0xce81, 0x0e40,
    0x0a00, 0xcac1, 0xcb81, 0x0b40, 0xc901, 0x09c0, 0x0880, 0xc841,
    0xd801, 0x18c0, 0x1980, 0xd941, 0x1b00, 0xdbc1, 0xda81, 0x1a40,
    0x1e00, 0xdec1, 0xdf81, 0x1f40, 0xdd01, 0x1dc0, 0x1c80, 0xdc41,
    0x1400, 0xd4c1, 0xd581, 0x1540, 0xd701, 0x17c0, 0x1680, 0xd641,
    0xd201, 0x12c0, 0x1380, 0xd341, 0x1100, 0xd1c1, 0xd081, 0x1040,
    0xf001, 0x30c0, 0x3180, 0xf141, 0x3300, 0xf3c1, 0xf281, 0x3240,
    0x3600, 0xf6c1, 0xf781, 0x3740, 0xf501, 0x35c0, 0x3480, 0xf441,
    0x3c00, 0xfcc1, 0xfd81, 0x3d40, 0xff01, 0x3fc0, 0x3e80, 0xfe41,
    0xfa01, 0x3ac0, 0x3b80, 0xfb41, 0x3900, 0xf9c1, 0xf881, 0x3840,
    0x2800, 0xe8c1, 0xe981, 0x2940, 0xeb01, 0x2bc0, 0x2a80, 0xea41,
    0xee01, 0x2ec0, 0x2f80, 0xef41, 0x2d00, 0xedc1, 0xec81, 0x2c40,
    0xe401, 0x24c0, 0x2580, 0xe541, 0x2700, 0xe7c1, 0xe681, 0x2640,
    0x2200, 0xe2c1, 0xe381, 0x2340, 0xe101, 0x21c0, 0x2080, 0xe041,
    0xa001, 0x60c0, 0x6180, 0xa141, 0x6300, 0xa3c1, 0xa281, 0x6240,
    0x6600, 0xa6c1, 0xa781, 0x6740, 0xa501, 0x65c0, 0x6480, 0xa441,
    0x6c00, 0xacc1, 0xad81, 0x6d40, 0xaf01, 0x6fc0, 0x6e80, 0xae41,
    0xaa01, 0x6ac0, 0x6b80, 0xab41, 0x6900, 0xa9c1, 0xa881, 0x6840,
    0x7800, 0xb8c1, 0xb981, 0x7940, 0xbb01, 0x7bc0, 0x7a80, 0xba41,
    0xbe01, 0x7ec0, 0x7f80, 0xbf41, 0x7d00, 0xbdc1, 0xbc81, 0x7c40,
    0xb401, 0x74c0, 0x7580, 0xb541, 0x7700, 0xb7c1, 0xb681, 0x7640,
    0x7200, 0xb2c1, 0xb381, 0x7340, 0xb101, 0x71c0, 0x7080, 0xb041,
    0x5000, 0x90c1, 0x9181, 0x5140, 0x9301, 0x53c0, 0x5280, 0x9241,
    0x9601, 0x56c0, 0x5780, 0x9741, 0x5500, 0x95c1, 0x9481, 0x5440,
    0x9c01, 0x5cc0, 0x5d80, 0x9d41, 0x5f00, 0x9fc1, 0x9e81, 0x5e40,
    0x5a00, 0x9ac1, 0x9b81, 0x5b40, 0x9901, 0x59c0, 0x5880, 0x9841,
    0x8801, 0x48c0, 0x4980, 0x8941, 0x4b00, 0x8bc1, 0x8a81, 0x4a40,
    0x4e00, 0x8ec1, 0x8f81, 0x4f40, 0x8d01, 0x4dc0, 0x4c80, 0x8c41,
    0x4400, 0x84c1, 0x8581, 0x4540, 0x8701, 0x47c0, 0x4680, 0x8641,
    0x8201, 0x42c0, 0x4380, 0x8341, 0x4100, 0x81c1, 0x8081, 0x4040,
};

uint16_t crc_ibm(uint8_t const *buffer, size_t len)
{
    uint16_t crc = 0x0000;
    uint8_t lut;

    while (len--) {
        lut = (crc ^ (*buffer++)) & 0xFF;
        crc = (crc >> 8) ^ crc_ibm_table[lut];
    }
    return crc;
}

int32_t _md_sub_response_topic(void *handle)
{
    char topic[128];
    mqtt_download_handle_t *md_handle = (mqtt_download_handle_t *)handle;
    if(handle == NULL) {
        return STATE_DOWNLOAD_DEINIT_HANDLE_IS_NULL;
    }
    memset(topic, 0, sizeof(topic));
    snprintf(topic, sizeof(topic) - 1, MQTT_DOWNLOAD_RESPONSE_TOPIC,
             core_mqtt_get_product_key(md_handle->task_desc->mqtt_handle), core_mqtt_get_device_name(md_handle->task_desc->mqtt_handle));

    return aiot_mqtt_sub(md_handle->task_desc->mqtt_handle, topic, _md_recv_data_reply_handler, 0, handle);
}

int32_t _md_unsub_response_topic(void *handle)
{
    char topic[128];
    mqtt_download_handle_t *md_handle = (mqtt_download_handle_t *)handle;
    if(handle == NULL) {
        return STATE_DOWNLOAD_DEINIT_HANDLE_IS_NULL;
    }
    memset(topic, 0, sizeof(topic));
    snprintf(topic, sizeof(topic) - 1, MQTT_DOWNLOAD_RESPONSE_TOPIC,
             core_mqtt_get_product_key(md_handle->task_desc->mqtt_handle), core_mqtt_get_device_name(md_handle->task_desc->mqtt_handle));

    return aiot_mqtt_unsub(md_handle->task_desc->mqtt_handle, topic);
}

void *aiot_mqtt_download_init(void)
{
    mqtt_download_handle_t *md_handle = NULL;
    aiot_sysdep_portfile_t *sysdep = NULL;

    sysdep = aiot_sysdep_get_portfile();
    if (sysdep == NULL) {
        return NULL;
    }

    md_handle = sysdep->core_sysdep_malloc(sizeof(mqtt_download_handle_t), MQTT_DOWNLOAD_MODULE_NAME);
    if (md_handle == NULL) {
        return NULL;
    }
    memset(md_handle, 0, sizeof(mqtt_download_handle_t));

    md_handle->status = STATE_MQTT_DOWNLOAD_INIT;
    md_handle->sysdep = sysdep;
    md_handle->request_size = MQTT_DOWNLOAD_DEFAULT_REQUEST_SIZE;
    md_handle->last_request_time = 0;
    md_handle->data_mutex = sysdep->core_sysdep_mutex_init();
    md_handle->recv_mutex = sysdep->core_sysdep_mutex_init();

    return md_handle;
}

static void _md_core_mqtt_process_handler(void *context, aiot_mqtt_event_t *event, core_mqtt_event_t *core_event)
{
    mqtt_download_handle_t *md_handle = (mqtt_download_handle_t *)context;

    if (core_event != NULL) {
        switch (core_event->type) {
        case CORE_MQTTEVT_DEINIT: {
            md_handle->task_desc->mqtt_handle = NULL;
            return;
        }
        default: {

        }
        break;
        }
    }
}

int32_t aiot_mqtt_download_deinit(void **handle)
{
    int32_t res = STATE_SUCCESS;
    if (NULL == handle || NULL == *handle) {
        return STATE_DOWNLOAD_DEINIT_HANDLE_IS_NULL;
    }
    mqtt_download_handle_t *md_handle = *(mqtt_download_handle_t **)handle;

    if (NULL != md_handle->task_desc) {
        if (AIOT_OTA_DIGEST_MD5 == md_handle->task_desc->digest_method) {
            if (NULL != md_handle->digest_ctx) {
                utils_md5_free(md_handle->digest_ctx);
                md_handle->sysdep->core_sysdep_free(md_handle->digest_ctx);
                md_handle->digest_ctx = NULL;
            }
        }
        if(md_handle->task_desc->mqtt_handle != NULL) {
            core_mqtt_process_data_t process_data;
            memset(&process_data, 0, sizeof(core_mqtt_process_data_t));
            process_data.handler = _md_core_mqtt_process_handler;
            process_data.context = handle;
            core_mqtt_setopt(md_handle->task_desc->mqtt_handle, CORE_MQTTOPT_REMOVE_PROCESS_HANDLER, &process_data);
            _md_unsub_response_topic(md_handle);
        }
        _download_deep_free_task_desc(md_handle->sysdep, md_handle->task_desc);
        md_handle->sysdep->core_sysdep_free(md_handle->task_desc);
        md_handle->task_desc = NULL;
    }

    md_handle->sysdep->core_sysdep_mutex_deinit(&md_handle->data_mutex);
    md_handle->sysdep->core_sysdep_mutex_deinit(&md_handle->recv_mutex);

    md_handle->sysdep->core_sysdep_free(md_handle);
    *handle = NULL;

    return res;
}

/* 根据下载到的固件的内容, 计算其digest值 */
static int32_t _download_digest_update(mqtt_download_handle_t *download_handle, uint8_t *buffer, uint32_t buffer_len)
{
    int32_t res = STATE_SUCCESS;
    if (AIOT_OTA_DIGEST_SHA256 == download_handle->task_desc->digest_method) {
        core_sha256_update(download_handle->digest_ctx, buffer, buffer_len);
    } else if (AIOT_OTA_DIGEST_MD5 == download_handle->task_desc->digest_method) {
        res = utils_md5_update(download_handle->digest_ctx, buffer, buffer_len);
    }
    return res;
}

/* 对计算出来的digest值, 与云端下发的digest值进行比较 */
static int32_t _download_digest_verify(mqtt_download_handle_t *download_handle)
{
    uint8_t output[32] = {0};
    uint8_t expected_digest[32] = {0};

    if (AIOT_OTA_DIGEST_SHA256 == download_handle->task_desc->digest_method) {
        core_str2hex(download_handle->task_desc->expect_digest, OTA_SHA256_LEN, expected_digest);
        core_sha256_finish(download_handle->digest_ctx, output);
        if (memcmp(output, expected_digest, 32) == 0) {
            return STATE_SUCCESS;
        }
    } else if (AIOT_OTA_DIGEST_MD5 == download_handle->task_desc->digest_method) {
        core_str2hex(download_handle->task_desc->expect_digest, OTA_MD5_LEN, expected_digest);
        utils_md5_finish(download_handle->digest_ctx, output);
        if (memcmp(output, expected_digest, 16) == 0) {
            return STATE_SUCCESS;
        }
    }
    return STATE_OTA_DIGEST_MISMATCH;
}

static int32_t _download_report_progress(void *handle, int32_t percent)
{
    int32_t res = STATE_SUCCESS;
    mqtt_download_handle_t *md_handle = NULL;
    aiot_sysdep_portfile_t *sysdep = NULL;
    char out_buffer[4] = {0};
    uint8_t out_len;
    char *payload_string;

    if (NULL == handle) {
        return STATE_MQTT_DOWNLOAD_MQTT_HANDLE_NULL;
    }

    md_handle = (mqtt_download_handle_t *)handle;
    sysdep = md_handle->sysdep;

    if (NULL == md_handle->task_desc) {
        return STATE_MQTT_DOWNLOAD_TASK_DEINIT;
    }

    core_int2str(percent, out_buffer, &out_len);

    if (md_handle->task_desc->module) {
        char *src[] = {"{\"step\":\"", out_buffer, "\",\"desc\":\"\",\"module\":\"", md_handle->task_desc->module, "\"}"};
        uint8_t topic_len = sizeof(src) / sizeof(char *);
        core_sprintf(sysdep, &payload_string, "%s%s%s%s%s", src, topic_len, OTA_MODULE_NAME);
    } else {
        char *src[] = {"{\"step\":\"", out_buffer, "\",\"desc\":\"\"}"};
        uint8_t topic_len = sizeof(src) / sizeof(char *);
        core_sprintf(sysdep, &payload_string, "%s%s%s", src, topic_len, OTA_MODULE_NAME);
    }

    res = _ota_publish_base(md_handle->task_desc->mqtt_handle, OTA_PROGRESS_TOPIC_PREFIX,
                            md_handle->task_desc->product_key,
                            md_handle->task_desc->device_name, NULL, payload_string);
    sysdep->core_sysdep_free(payload_string);
    return res;
}

static int32_t _parse_json_header(void *handle, char *data, uint32_t data_len, aiot_mqtt_download_recv_t *pakcet)
{
    mqtt_download_handle_t *md_handle = (mqtt_download_handle_t *)handle;
    char *header = data, *file_info = NULL, *value = NULL;
    uint32_t header_len = data_len, file_info_len = 0, value_len = 0;
    uint32_t code = 0;
    uint32_t size = 0, offset = 0, fileLenth = 0;
    int32_t res = STATE_SUCCESS;

    if ((res = core_json_value((char *)header, header_len, "code", strlen("code"),
                               &value, &value_len)) < 0 ||
            ((res = core_str2uint(value, value_len, &code)) < 0) ||
            code != 200 ) {
        core_log1(md_handle->sysdep, 0, "recv handle parse err code %d\r\n", &code);
        return res;
    }

    if ((res = core_json_value((char *)header, header_len, "data", strlen("data"),
                               &value, &value_len)) < 0 ) {
        core_log(md_handle->sysdep, 0, "json parse error data\r\n");
        return res;
    }

    /* 解析文件的描述信息 */
    file_info = value;
    file_info_len = value_len;
    if ((res = core_json_value((char *)file_info, file_info_len, "bSize", strlen("bSize"),
                               &value, &value_len)) < 0  ||
            ((res = core_str2uint(value, value_len, &size)) < 0)) {
        core_log(md_handle->sysdep, 0, "json parse error bSize\r\n");
        return res;
    }
    if ((res = core_json_value((char *)file_info, file_info_len, "bOffset", strlen("bOffset"),
                               &value, &value_len)) < 0  ||
            ((res = core_str2uint(value, value_len, &offset)) < 0)) {
        core_log(md_handle->sysdep, 0, "json parse error bOffset\r\n");
        return res;
    }
    if ((res = core_json_value((char *)file_info, file_info_len, "fileLength", strlen("fileLength"),
                               &value, &value_len)) < 0  ||
            ((res = core_str2uint(value, value_len, &fileLenth)) < 0)) {
        core_log(md_handle->sysdep, 0, "json parse error bOffset\r\n");
        return res;
    }
    if ((res = core_json_value((char *)file_info, file_info_len, "fileToken", strlen("fileToken"),
                               &value, &value_len)) == 0 ) {
        memcpy(pakcet->data.data_resp.filename, value, value_len);
    }

    pakcet->data.data_resp.data_size = size;
    pakcet->data.data_resp.offset = offset;
    pakcet->data.data_resp.file_lenth = fileLenth;

    return res;
}

static void _md_resend_request(mqtt_download_handle_t *md_handle)
{
    md_handle->failed_counter++;
    if(md_handle->failed_counter > 3) {
        md_handle->status = STATE_MQTT_DOWNLOAD_FAILED_TIMEOUT;
        return;
    }

    _md_send_request(md_handle);
}

static void _md_recv_data_reply_handler(void *handle, const aiot_mqtt_recv_t *msg, void *userdata)
{
    mqtt_download_handle_t *md_handle = (mqtt_download_handle_t *)userdata;
    /*有效文件数据*/
    uint8_t *data = NULL;
    uint32_t data_len = 0;
    /*json头解析变量定义*/
    char *header = NULL;
    uint16_t header_len = 0;
    char file_token[MQTT_DOWNLOAD_TOKEN_MAXLEN];
    uint16_t crc16 = 0, cal_crc16 = 0;
    aiot_mqtt_download_recv_t packet;
    memset(file_token, 0, sizeof(file_token));
    packet.type = AIOT_MDRECV_DATA_RESP;
    packet.data.data_resp.filename = file_token;

    if(md_handle == NULL || md_handle->status != STATE_MQTT_DOWNLOAD_ING) {
        return;
    }

    /*获取并解析json头*/
    header = (char *)(msg->data.pub.payload + 2);
    header_len = *msg->data.pub.payload << 8 | *(msg->data.pub.payload + 1);
    if(_parse_json_header(md_handle, header, header_len, &packet) < 0) {
        _md_resend_request(md_handle);
        return;
    }

    /* 校验数据长度 */
    if(msg->data.pub.payload_len != sizeof(header_len) + header_len + packet.data.data_resp.data_size + sizeof(crc16)) {
        core_log(md_handle->sysdep, 0, "payload lenth dismatch data lenth\r\n");
        _md_resend_request(md_handle);
        return;
    }

    /* 有效的文件数据 */
    data = msg->data.pub.payload + sizeof(header_len) + header_len;
    data_len = packet.data.data_resp.data_size;

    /* CRC校验 */
    crc16 = *(uint16_t *)(msg->data.pub.payload + msg->data.pub.payload_len - sizeof(crc16));
    cal_crc16 = crc_ibm(data, data_len);
    if(cal_crc16 != crc16) {
        _md_resend_request(md_handle);
        return;
    }

    /* 判断接收的数据偏移是否为请求的偏移,可能存在重复请求，这里校验失败，不主动重发请求，等超时 */
    if(packet.data.data_resp.offset != md_handle->size_fetched + md_handle->range_start) {
        return;
    }

    /* 生成回调packet包回调用户接口 */
    md_handle->size_fetched += data_len;
    packet.data.data_resp.data = (char *)data;
    packet.data.data_resp.percent = md_handle->size_fetched * 100 / md_handle->range_size;

    /* 计算digest, 如果下载完成, 还要看看是否与云端计算出来的一致 */
    if(md_handle->md5_enabled) {
        _download_digest_update(md_handle, (uint8_t *)packet.data.data_resp.data, packet.data.data_resp.data_size);
    }

    /* 数据接收成功，失败统计复位 */
    md_handle->failed_counter = 0;

    /* 回调用户接口, 通知存储数据 */
    if(md_handle->recv_handler != NULL) {
        md_handle->recv_handler(md_handle, &packet, md_handle->userdata);
    }

    if(md_handle->size_fetched < md_handle->range_size) {
        /*请求下一包*/
        _md_send_request(md_handle);
    } else if(md_handle->size_fetched == md_handle->range_size) {
        /*下载完成, 如果有md5还需要做整个文件的校验*/
        md_handle->percent = 100;
        md_handle->status = STATE_MQTT_DOWNLOAD_FINISHED;
    } else {
        md_handle->status = STATE_MQTT_DOWNLOAD_FAILED_RECVERROR;
    }
}

int32_t aiot_mqtt_download_setopt(void *handle, aiot_mqtt_download_option_t option, void *data) {
    int32_t res = STATE_SUCCESS;
    if (NULL == handle) {
        return STATE_DOWNLOAD_DEINIT_HANDLE_IS_NULL;
    }
    mqtt_download_handle_t *md_handle = (mqtt_download_handle_t *)handle;

    md_handle->sysdep->core_sysdep_mutex_lock(md_handle->data_mutex);
    switch (option) {
    case AIOT_MDOPT_USERDATA: {
        md_handle->userdata = data;
    }
    break;
    case AIOT_MDOPT_TASK_DESC: {
        void *new_task_desc = _download_deep_copy_task_desc(md_handle->sysdep, data);
        if (NULL == new_task_desc) {
            res = STATE_DOWNLOAD_SETOPT_COPIED_DATA_IS_NULL;
            break;
        }

        md_handle->task_desc = (aiot_download_task_desc_t *)new_task_desc;
        core_mqtt_process_data_t process_data;
        memset(&process_data, 0, sizeof(core_mqtt_process_data_t));
        process_data.handler = _md_core_mqtt_process_handler;
        process_data.context = handle;

        core_mqtt_setopt(md_handle->task_desc->mqtt_handle, CORE_MQTTOPT_APPEND_PROCESS_HANDLER, &process_data);
    }
    break;
    case  AIOT_MDOPT_RANGE_START: {
        md_handle->range_start = *(uint32_t *)data;
    }
    break;
    case  AIOT_MDOPT_RANGE_END: {
        md_handle->range_end = *(uint32_t *)data;
    }
    break;
    case AIOT_MDOPT_RECV_HANDLE: {
        md_handle->recv_handler = (aiot_mqtt_download_recv_handler_t)data;
    }
    break;
    case  AIOT_MDOPT_DATA_REQUEST_SIZE: {
        md_handle->request_size = *(uint32_t *)data;
    }
    break;
    default: {
        res = STATE_USER_INPUT_OUT_RANGE;
    }
    break;
    }
    md_handle->sysdep->core_sysdep_mutex_unlock(md_handle->data_mutex);
    return res;
}

static int32_t _md_send_request(void *handle)
{
    mqtt_download_handle_t *md_handle = (mqtt_download_handle_t *)handle;

    char *payload_fmt = "{\"id\":\"%s\",\"version\":\"1.0\",\"params\":%s}";
    char *params_fmt = "{\"fileToken\":\"%s\",\"fileInfo\":{\"streamId\":%s,\"fileId\":%s,},\"fileBlock\":{\"size\":%s,\"offset\":%s}}";
    char *params = NULL, *payload = NULL, *topic = NULL;
    char stream_id_string[21], file_id_string[21], request_size_string[21], offset_string[21];
    char *params_src[] = {"default", stream_id_string, file_id_string, request_size_string, offset_string };
    char id_string[21];
    char *payload_src[2] = { id_string };
    char *topic_src[2] = { id_string };
    uint32_t res = STATE_SUCCESS;
    uint32_t offset = md_handle->size_fetched + md_handle->range_start;
    /* 生成params */
    int32_t size = md_handle->request_size;
    if(md_handle->request_size + md_handle->size_fetched > md_handle->range_size)
    {
        size = md_handle->range_size - md_handle->size_fetched;
    }
    memset(stream_id_string, 0, sizeof(stream_id_string));
    core_uint2str(md_handle->task_desc->stream_id, stream_id_string, NULL);

    memset(file_id_string, 0, sizeof(file_id_string));
    core_uint2str(md_handle->task_desc->stream_file_id, file_id_string, NULL);

    memset(request_size_string, 0, sizeof(request_size_string));
    core_uint2str(size, request_size_string, NULL);

    memset(offset_string, 0, sizeof(offset_string));
    core_uint2str(offset, offset_string, NULL);

    core_sprintf(md_handle->sysdep, &params, params_fmt, params_src, sizeof(params_src) / sizeof(char *),
                 MQTT_DOWNLOAD_MODULE_NAME);

    /*生成payload */
    md_handle->msg_id++;
    memset(id_string, 0, sizeof(id_string));
    core_uint2str(md_handle->msg_id, id_string, NULL);
    payload_src[1] = params;
    core_sprintf(md_handle->sysdep, &payload, payload_fmt, payload_src, sizeof(payload_src) / sizeof(char *),
                 MQTT_DOWNLOAD_MODULE_NAME);

    topic_src[0] = core_mqtt_get_product_key(md_handle->task_desc->mqtt_handle);
    topic_src[1] = core_mqtt_get_device_name(md_handle->task_desc->mqtt_handle);
    core_sprintf(md_handle->sysdep, &topic, MQTT_DOWNLOAD_REQUEST_TOPIC, topic_src, sizeof(topic_src) / sizeof(char *),
                 MQTT_DOWNLOAD_MODULE_NAME);

    if( payload != NULL && topic != NULL) {
        res = aiot_mqtt_pub(md_handle->task_desc->mqtt_handle, topic, (uint8_t *)payload, strlen(payload), 0);
    }
    md_handle->last_request_time = md_handle->sysdep->core_sysdep_time();

    if(topic != NULL) {
        md_handle->sysdep->core_sysdep_free(topic);
    }
    if(payload != NULL) {
        md_handle->sysdep->core_sysdep_free(payload);
    }
    if(params != NULL) {
        md_handle->sysdep->core_sysdep_free(params);
    }

    return res;
}
static int32_t _md_reset_handle(mqtt_download_handle_t *md_handle)
{
    if(md_handle == NULL) {
        return STATE_MQTT_DOWNLOAD_MQTT_HANDLE_NULL;
    }

    md_handle->msg_id = 0;
    md_handle->size_fetched = 0;
    md_handle->percent = 0;
    md_handle->last_request_time = 0;
    md_handle->failed_counter = 0;
    md_handle->last_percent = 0;
    md_handle->range_size = 0;

    return STATE_SUCCESS;
}
int32_t aiot_mqtt_download_process(void *handle)
{
    uint64_t now;
    mqtt_download_handle_t *md_handle = (mqtt_download_handle_t *)handle;
    int32_t percent = 0;
    int32_t res = 0;
    if(md_handle == NULL) {
        return STATE_MQTT_DOWNLOAD_MQTT_HANDLE_NULL;
    }

    if(md_handle->task_desc == NULL || md_handle->task_desc->mqtt_handle == NULL) {
        return STATE_MQTT_DOWNLOAD_TASK_DEINIT;
    }

    res = md_handle->status;
    switch(md_handle->status) {
    case STATE_MQTT_DOWNLOAD_INIT: {
        /* 没有设置片段下载结尾，设置下载至文件结尾 */
        if(md_handle->range_end == 0) {
            md_handle->range_end = md_handle->task_desc->size_total;
        }

        md_handle->range_size = md_handle->range_end - md_handle->range_start;
        if(md_handle->range_size <= 0) {
            return STATE_MQTT_DOWNLOAD_FILESIZE_ERROR;
        }

        /* 订阅数据返回的topic */
        _md_sub_response_topic(md_handle);
        /* 完整的文件下载做md5校验 */
        if(md_handle->range_size == md_handle->task_desc->size_total
                && AIOT_OTA_DIGEST_MD5 == md_handle->task_desc->digest_method
                && NULL != md_handle->task_desc->expect_digest) {
            utils_md5_context_t *ctx = md_handle->sysdep->core_sysdep_malloc(sizeof(utils_md5_context_t), MQTT_DOWNLOAD_MODULE_NAME);
            if (NULL == ctx) {
                res = STATE_DOWNLOAD_SETOPT_MALLOC_MD5_CTX_FAILED;
                break;
            }
            md_handle->md5_enabled = 1;
            utils_md5_init(ctx);
            utils_md5_starts(ctx);
            md_handle->digest_ctx = (void *) ctx;
        }

        _md_send_request(handle);
        md_handle->last_request_time = md_handle->sysdep->core_sysdep_time();
        md_handle->status = STATE_MQTT_DOWNLOAD_ING;
        res = STATE_MQTT_DOWNLOAD_ING;
    }
    break;
    case STATE_MQTT_DOWNLOAD_ING: {
        now = md_handle->sysdep->core_sysdep_time();
        if(now - md_handle->last_request_time > MQTT_DOWNLOAD_DEFAULT_RECV_TIMEOUT) {
            _md_resend_request(md_handle);
        }

        percent = md_handle->size_fetched * 100 / md_handle->range_size;
        if(percent - md_handle->last_percent >= MQTT_DOWNLOAD_REPORT_INTERNEL) {
            md_handle->last_percent = percent;
            _download_report_progress(md_handle, percent);
        }
    }
    break;
    case STATE_MQTT_DOWNLOAD_FINISHED: {
        if(md_handle->md5_enabled) {
            int32_t ret = _download_digest_verify(md_handle);
            if (ret != STATE_SUCCESS) {
                md_handle->status = STATE_MQTT_DOWNLOAD_FAILED_MISMATCH;
                core_log(md_handle->sysdep, ret, "digest mismatch\r\n");
            } else {
                md_handle->status = STATE_MQTT_DOWNLOAD_SUCCESS;
                core_log(md_handle->sysdep, STATE_OTA_DIGEST_MATCH, "digest matched\r\n");
            }
            if (NULL != md_handle->digest_ctx) {
                utils_md5_free(md_handle->digest_ctx);
                md_handle->sysdep->core_sysdep_free(md_handle->digest_ctx);
                md_handle->digest_ctx = NULL;
            }
        } else {
            md_handle->status = STATE_MQTT_DOWNLOAD_SUCCESS;
        }
    }
    break;
    case STATE_MQTT_DOWNLOAD_SUCCESS: {
        _download_report_progress(md_handle, 100);
        _md_reset_handle(md_handle);
        md_handle->status = STATE_MQTT_DOWNLOAD_INIT;
    }
    break;
    case STATE_MQTT_DOWNLOAD_FAILED_MISMATCH: {
        _download_report_progress(md_handle, AIOT_OTAERR_CHECKSUM_MISMATCH);
        _md_reset_handle(md_handle);
        md_handle->status = STATE_MQTT_DOWNLOAD_INIT;
    }
    break;

    case STATE_MQTT_DOWNLOAD_FAILED_RECVERROR:
    case STATE_MQTT_DOWNLOAD_FAILED_TIMEOUT: {
        _download_report_progress(md_handle, AIOT_OTAERR_BURN_FAILED);
        _md_reset_handle(md_handle);
        md_handle->status = STATE_MQTT_DOWNLOAD_INIT;
    }
    break;
    }
    return res;
}