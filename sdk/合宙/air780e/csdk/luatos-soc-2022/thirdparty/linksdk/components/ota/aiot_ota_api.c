/**
 * @file aiot_ota_api.c
 * @brief OTA模块接口实现文件, 其中包含了OTA的所有用户API
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
#include "ota_private.h"
#include "core_log.h"
#include "core_global.h"

static int32_t _ota_subscribe(void *mqtt_handle, void *ota_handle);
static void    _ota_mqtt_process(void *handle, const aiot_mqtt_recv_t *const packet, void *userdata);
static int32_t _ota_parse_json(aiot_sysdep_portfile_t *sysdep, void *in, uint32_t in_len, char *key_word, char **out);
static void    _http_recv_handler(void *handle, const aiot_http_recv_t *recv_data, void *userdata);
static int32_t _ota_parse_list_array(char *str, int32_t str_len, ota_list_json *array);
static int32_t _process_single_file(aiot_sysdep_portfile_t *sysdep, char *data, uint32_t data_len,
                                    int type, aiot_download_task_desc_t *task_desc, ota_handle_t *ota_handle);
static int32_t _download_parse_url(const char *url, char *host, uint32_t max_host_len, char *path,
                                   uint32_t max_path_len);
static int32_t _download_digest_update(download_handle_t *download_handle, uint8_t *buffer, uint32_t buffer_len);
static int32_t _download_digest_verify(download_handle_t *download_handle);
static void   *_download_deep_copy_base(aiot_sysdep_portfile_t *sysdep, char *in);

static aiot_mqtt_topic_map_t g_ota_topic_map[OTA_TOPIC_NUM];

static void _ota_core_mqtt_process_handler(void *context, aiot_mqtt_event_t *event, core_mqtt_event_t *core_event)
{
    ota_handle_t *ota_handle = (ota_handle_t *)context;

    if (core_event != NULL) {
        switch (core_event->type) {
        case CORE_MQTTEVT_DEINIT: {
            ota_handle->mqtt_handle = NULL;
            return;
        }
        break;
        default: {

        }
        break;
        }
    }
}

static int32_t _ota_core_mqtt_operate_process_handler(ota_handle_t *ota_handle, core_mqtt_option_t option)
{
    core_mqtt_process_data_t process_data;

    memset(&process_data, 0, sizeof(core_mqtt_process_data_t));
    process_data.handler = _ota_core_mqtt_process_handler;
    process_data.context = ota_handle;

    return core_mqtt_setopt(ota_handle->mqtt_handle, option, &process_data);
}

void *aiot_ota_init(void)
{
    ota_handle_t *ota_handle = NULL;
    aiot_sysdep_portfile_t *sysdep = NULL;

    sysdep = aiot_sysdep_get_portfile();
    if (sysdep == NULL) {
        return NULL;
    }

    ota_handle = sysdep->core_sysdep_malloc(sizeof(ota_handle_t), OTA_MODULE_NAME);
    if (ota_handle == NULL) {
        return NULL;
    }
    memset(ota_handle, 0, sizeof(ota_handle_t));
    ota_handle->data_mutex = sysdep->core_sysdep_mutex_init();
    ota_handle->sysdep = sysdep;
    core_global_init(sysdep);
    return ota_handle;
}

int32_t aiot_ota_deinit(void **handle)
{
    ota_handle_t *ota_handle = NULL;
    aiot_sysdep_portfile_t *sysdep = NULL;
    int count = 0;
    int32_t res;

    if (NULL == handle || NULL == *handle) {
        return STATE_OTA_DEINIT_HANDLE_IS_NULL;
    }
    ota_handle = * (ota_handle_t **)handle;

    _ota_core_mqtt_operate_process_handler(ota_handle, CORE_MQTTOPT_REMOVE_PROCESS_HANDLER);

    for (count = 0; count < OTA_TOPIC_NUM; count++) {
        aiot_mqtt_topic_map_t topic_map = g_ota_topic_map[count];
        res = aiot_mqtt_setopt(ota_handle->mqtt_handle, AIOT_MQTTOPT_REMOVE_TOPIC_MAP, (void *)&topic_map);
        if (STATE_SUCCESS != res) {
            continue;
        }
    }

    sysdep = ota_handle->sysdep;
    core_global_deinit(sysdep);
    sysdep->core_sysdep_mutex_deinit(&(ota_handle->data_mutex));
    sysdep->core_sysdep_free(ota_handle);
    *handle = NULL;
    return STATE_SUCCESS;
}

int32_t aiot_ota_setopt(void *handle, aiot_ota_option_t option, void *data)
{
    int32_t res = STATE_SUCCESS;
    ota_handle_t *ota_handle = (ota_handle_t *)handle;
    aiot_sysdep_portfile_t *sysdep = NULL;

    if (NULL == ota_handle) {
        return STATE_OTA_SETOPT_HANDLE_IS_NULL;
    }
    if (NULL == data) {
        return STATE_OTA_SETOPT_DATA_IS_NULL;
    }

    sysdep = ota_handle->sysdep;
    sysdep->core_sysdep_mutex_lock(ota_handle->data_mutex);
    switch (option) {
    case AIOT_OTAOPT_RECV_HANDLER: {
        ota_handle->recv_handler = (aiot_ota_recv_handler_t)data;
    }
    break;
    case AIOT_OTAOPT_USERDATA: {
        ota_handle->userdata = data;
    }
    break;
    case AIOT_OTAOPT_MQTT_HANDLE: {
        ota_handle->mqtt_handle = data;
        res = _ota_subscribe(data, ota_handle);
        if (res >= STATE_SUCCESS) {
            res = _ota_core_mqtt_operate_process_handler(ota_handle, CORE_MQTTOPT_APPEND_PROCESS_HANDLER);
        }
    }
    break;
    case AIOT_OTAOPT_MODULE: {
        ota_handle->module = data;
    }
    break;
    default: {
        res = STATE_USER_INPUT_UNKNOWN_OPTION;
    }
    break;
    }
    sysdep->core_sysdep_mutex_unlock(ota_handle->data_mutex);

    return res;
}

void *aiot_download_init(void)
{
    download_handle_t *download_handle = NULL;
    aiot_sysdep_portfile_t *sysdep = NULL;
    void *http_handle = NULL;
    uint32_t default_body_max_len = OTA_DEFAULT_DOWNLOAD_BUFLEN;
    uint32_t default_timeout_ms = OTA_DEFAULT_DOWNLOAD_TIMEOUT_MS;

    sysdep = aiot_sysdep_get_portfile();
    if (NULL == sysdep) {
        return NULL;
    }

    download_handle = sysdep->core_sysdep_malloc(sizeof(download_handle_t), DOWNLOAD_MODULE_NAME);
    if (NULL == download_handle) {
        return NULL;
    }
    memset(download_handle, 0, sizeof(download_handle_t));
    download_handle->sysdep = sysdep;
    download_handle->data_mutex = sysdep->core_sysdep_mutex_init();
    download_handle->recv_mutex = sysdep->core_sysdep_mutex_init();

    http_handle = core_http_init();
    if (NULL == http_handle) {
        sysdep->core_sysdep_free(download_handle);
        return NULL;
    }
    if ((STATE_SUCCESS != core_http_setopt(http_handle, CORE_HTTPOPT_RECV_HANDLER, _http_recv_handler)) ||
            (STATE_SUCCESS != core_http_setopt(http_handle, CORE_HTTPOPT_USERDATA, (void *)download_handle)) ||
            (STATE_SUCCESS != core_http_setopt(http_handle, CORE_HTTPOPT_BODY_BUFFER_MAX_LEN, (void *)&default_body_max_len)) ||
            (STATE_SUCCESS != core_http_setopt(http_handle, CORE_HTTPOPT_RECV_TIMEOUT_MS, (void *)&default_timeout_ms))) {
        sysdep->core_sysdep_free(download_handle);
        sysdep->core_sysdep_free(http_handle);
        return NULL;
    }
    download_handle->http_handle = http_handle;

    return download_handle;
}

int32_t aiot_download_deinit(void **handle)
{
    int32_t res = STATE_SUCCESS;
    if (NULL == handle || NULL == *handle) {
        return STATE_DOWNLOAD_DEINIT_HANDLE_IS_NULL;
    }

    download_handle_t *download_handle = *(download_handle_t **)(handle);
    aiot_sysdep_portfile_t *sysdep = download_handle->sysdep;
    core_http_deinit(&(download_handle->http_handle));

    if (NULL != download_handle->task_desc) {
        if (AIOT_OTA_DIGEST_SHA256 == download_handle->task_desc->digest_method) {
            if (NULL != download_handle->digest_ctx) {
                core_sha256_free(download_handle->digest_ctx);
                sysdep->core_sysdep_free(download_handle->digest_ctx);
            }
        } else if (AIOT_OTA_DIGEST_MD5 == download_handle->task_desc->digest_method) {
            if (NULL != download_handle->digest_ctx) {
                utils_md5_free(download_handle->digest_ctx);
                sysdep->core_sysdep_free(download_handle->digest_ctx);
            }
        }
        _download_deep_free_task_desc(sysdep, download_handle->task_desc);
        sysdep->core_sysdep_free(download_handle->task_desc);
    }

    sysdep->core_sysdep_mutex_deinit(&(download_handle->data_mutex));
    sysdep->core_sysdep_mutex_deinit(&(download_handle->recv_mutex));
    sysdep->core_sysdep_free(download_handle);
    *handle = NULL;
    return res;
}

int32_t aiot_download_setopt(void *handle, aiot_download_option_t option, void *data)
{
    int32_t res = STATE_SUCCESS;
    download_handle_t *download_handle = (download_handle_t *)handle;

    if (download_handle == NULL) {
        return STATE_DOWNLOAD_SETOPT_HANDLE_IS_NULL;
    }
    if (NULL == data) {
        return STATE_DOWNLOAD_SETOPT_DATA_IS_NULL;
    }

    aiot_sysdep_portfile_t *sysdep = download_handle->sysdep;

    sysdep->core_sysdep_mutex_lock(download_handle->data_mutex);
    switch (option) {
    case AIOT_DLOPT_NETWORK_CRED: {
        res = core_http_setopt(download_handle->http_handle, CORE_HTTPOPT_NETWORK_CRED, data);
    }
    break;
    case AIOT_DLOPT_NETWORK_PORT: {
        res = core_http_setopt(download_handle->http_handle, CORE_HTTPOPT_PORT, data);
    }
    break;
    case AIOT_DLOPT_RECV_TIMEOUT_MS: {
        uint32_t *timeout_ms = (uint32_t *)data;
        void *http_handle = download_handle->http_handle;
        res = core_http_setopt(http_handle, CORE_HTTPOPT_RECV_TIMEOUT_MS, timeout_ms);
    }
    break;
    case AIOT_DLOPT_USERDATA: {
        download_handle->userdata = data;
    }
    break;
    case AIOT_DLOPT_TASK_DESC: {
        void *new_task_desc = _download_deep_copy_task_desc(sysdep, data);
        if (NULL == new_task_desc) {
            res = STATE_DOWNLOAD_SETOPT_COPIED_DATA_IS_NULL;
            break;
        }

        download_handle->task_desc = (aiot_download_task_desc_t *)new_task_desc;
        if (AIOT_OTA_DIGEST_SHA256 == download_handle->task_desc->digest_method) {
            core_sha256_context_t *ctx = sysdep->core_sysdep_malloc(sizeof(core_sha256_context_t), OTA_MODULE_NAME);
            if (NULL == ctx) {
                res = STATE_DOWNLOAD_SETOPT_MALLOC_SHA256_CTX_FAILED;
                break;
            }
            core_sha256_init(ctx);
            core_sha256_starts(ctx);
            download_handle->digest_ctx = (void *) ctx;
        } else if (AIOT_OTA_DIGEST_MD5 == download_handle->task_desc->digest_method) {
            utils_md5_context_t *ctx = sysdep->core_sysdep_malloc(sizeof(utils_md5_context_t), OTA_MODULE_NAME);
            if (NULL == ctx) {
                res = STATE_DOWNLOAD_SETOPT_MALLOC_MD5_CTX_FAILED;
                break;
            }
            utils_md5_init(ctx);
            utils_md5_starts(ctx);
            download_handle->digest_ctx = (void *) ctx;
        }
        download_handle->download_status = DOWNLOAD_STATUS_START;
    }
    break;
    case  AIOT_DLOPT_RANGE_START: {
        download_handle->range_start = *(uint32_t *)data;
        download_handle->range_size_fetched = 0;
    }
    break;
    case  AIOT_DLOPT_RANGE_END: {
        download_handle->range_end = *(uint32_t *)data;
        download_handle->range_size_fetched = 0;
    }
    break;
    case AIOT_DLOPT_RECV_HANDLER: {
        download_handle->recv_handler = (aiot_download_recv_handler_t)data;
    }
    break;
    case AIOT_DLOPT_BODY_BUFFER_MAX_LEN: {
        res = core_http_setopt(download_handle->http_handle, CORE_HTTPOPT_BODY_BUFFER_MAX_LEN, data);
    }
    break;
    default: {
        res = STATE_USER_INPUT_OUT_RANGE;
    }
    break;
    }
    sysdep->core_sysdep_mutex_unlock(download_handle->data_mutex);
    return res;
}

int32_t aiot_ota_report_version(void *handle, char *version)
{
    int32_t res = STATE_SUCCESS;
    ota_handle_t *ota_handle = NULL;
    aiot_sysdep_portfile_t *sysdep;
    char *payload_string;
    char *product_key;
    char *device_name;
    ota_handle = (ota_handle_t *)handle;

    if (NULL == ota_handle) {
        return STATE_OTA_REPORT_HANDLE_IS_NULL;
    }

    if (NULL == version) {
        return STATE_OTA_REPORT_VERSION_IS_NULL;
    }

    if (NULL == ota_handle->mqtt_handle) {
        return STATE_OTA_REPORT_MQTT_HANDLE_IS_NULL;
    }
    product_key = core_mqtt_get_product_key(ota_handle->mqtt_handle);
    device_name = core_mqtt_get_device_name(ota_handle->mqtt_handle);

    sysdep = ota_handle->sysdep;
    if (ota_handle->module) {
        char *src[] = {"{\"version\":\"", version, "\",\"module\":\"", ota_handle->module, "\"}"};
        uint8_t topic_len = sizeof(src) / sizeof(char *);
        core_sprintf(sysdep, &payload_string, "%s%s%s%s%s", src, topic_len, OTA_MODULE_NAME);
    } else {
        char *src[] = {"{\"version\":\"", version, "\"}"};
        uint8_t topic_len = sizeof(src) / sizeof(char *);
        core_sprintf(sysdep, &payload_string, "%s%s%s", src, topic_len, OTA_MODULE_NAME);
    }
    res = _ota_publish_base(ota_handle->mqtt_handle, OTA_VERSION_TOPIC_PREFIX, product_key, device_name, NULL,
                            payload_string);
    sysdep->core_sysdep_free(payload_string);
    return res;
}

int32_t aiot_ota_report_version_ext(void *handle, char *product_key, char *device_name, char *version)
{
    int32_t res = STATE_SUCCESS;
    ota_handle_t *ota_handle = NULL;
    aiot_sysdep_portfile_t *sysdep;
    char *payload_string;
    ota_handle = (ota_handle_t *)handle;

    if (NULL == ota_handle) {
        return STATE_OTA_REPORT_EXT_HANELD_IS_NULL;
    }

    if (NULL == version) {
        return STATE_OTA_REPORT_EXT_VERSION_NULL;
    }

    if (NULL == product_key) {
        return STATE_OTA_REPORT_EXT_PRODUCT_KEY_IS_NULL;
    }
    if (NULL == device_name) {
        return STATE_OTA_REPORT_EXT_DEVICE_NAME_IS_NULL;
    }

    core_mqtt_handle_t *mqtt_handle = ota_handle->mqtt_handle;
    if (NULL == mqtt_handle) {
        return STATE_OTA_REPORT_EXT_MQTT_HANDLE_IS_NULL;
    }

    sysdep = ota_handle->sysdep;
    {
        char *src[] = {"{\"version\":\"", version, "\"}"};
        uint8_t topic_len = sizeof(src) / sizeof(char *);
        core_sprintf(sysdep, &payload_string, "%s%s%s", src, topic_len, OTA_MODULE_NAME);
    }
    res = _ota_publish_base(mqtt_handle, OTA_VERSION_TOPIC_PREFIX, product_key, device_name, NULL, payload_string);
    sysdep->core_sysdep_free(payload_string);
    return res;
}

int32_t aiot_ota_query_firmware(void *handle)
{
    int32_t res = STATE_SUCCESS;
    ota_handle_t *ota_handle = NULL;
    aiot_sysdep_portfile_t *sysdep = NULL;
    char *payload_string;

    if (NULL == handle) {
        return STATE_OTA_QUERY_FIRMWARE_HANDLE_IS_NULL;
    }

    ota_handle = (ota_handle_t *)handle;
    sysdep = ota_handle->sysdep;

    if (ota_handle->module) {
        char *src[] = {"{\"module\":\"", ota_handle->module, "\"}"};
        uint8_t topic_len = sizeof(src) / sizeof(char *);
        core_sprintf(sysdep, &payload_string, "%s%s%s", src, topic_len, OTA_MODULE_NAME);
    } else {
        char *src[] = {"{}"};
        uint8_t topic_len = sizeof(src) / sizeof(char *);
        core_sprintf(sysdep, &payload_string, "%s", src, topic_len, OTA_MODULE_NAME);
    }

    res = _ota_publish_base(ota_handle->mqtt_handle, OTA_GET_TOPIC_PREFIX,
                            core_mqtt_get_product_key(ota_handle->mqtt_handle),
                            core_mqtt_get_device_name(ota_handle->mqtt_handle), OTA_GET_TOPIC_SUFFIX, payload_string);
    sysdep->core_sysdep_free(payload_string);
    return res;
}

int32_t aiot_download_report_progress(void *handle, int32_t percent)
{
    int32_t res = STATE_SUCCESS;
    download_handle_t *download_handle = NULL;
    aiot_sysdep_portfile_t *sysdep = NULL;
    char out_buffer[4] = {0};
    uint8_t out_len;
    char *payload_string;

    if (NULL == handle) {
        return STATE_DOWNLOAD_REPORT_HANDLE_IS_NULL;
    }

    download_handle = (download_handle_t *)handle;
    sysdep = download_handle->sysdep;

    if (NULL == download_handle->task_desc) {
        return STATE_DOWNLOAD_REPORT_TASK_DESC_IS_NULL;
    }

    core_int2str(percent, out_buffer, &out_len);

    if (download_handle->task_desc->module) {
        char *src[] = {"{\"step\":\"", out_buffer, "\",\"desc\":\"\",\"module\":\"", download_handle->task_desc->module, "\"}"};
        uint8_t topic_len = sizeof(src) / sizeof(char *);
        core_sprintf(sysdep, &payload_string, "%s%s%s%s%s", src, topic_len, OTA_MODULE_NAME);
    } else {
        char *src[] = {"{\"step\":\"", out_buffer, "\",\"desc\":\"\"}"};
        uint8_t topic_len = sizeof(src) / sizeof(char *);
        core_sprintf(sysdep, &payload_string, "%s%s%s", src, topic_len, OTA_MODULE_NAME);
    }

    res = _ota_publish_base(download_handle->task_desc->mqtt_handle, OTA_PROGRESS_TOPIC_PREFIX,
                            download_handle->task_desc->product_key,
                            download_handle->task_desc->device_name, NULL, payload_string);
    sysdep->core_sysdep_free(payload_string);
    return res;
}

int32_t aiot_download_recv(void *handle)
{
    int32_t res = STATE_SUCCESS;
    download_handle_t *download_handle = (download_handle_t *)handle;
    aiot_sysdep_portfile_t *sysdep = NULL;
    void *http_handle = NULL;

    if (NULL == download_handle) {
        return STATE_DOWNLOAD_RECV_HANDLE_IS_NULL;
    }
    http_handle = download_handle->http_handle;
    sysdep = download_handle->sysdep;

    sysdep->core_sysdep_mutex_lock(download_handle->recv_mutex);
    switch (download_handle->download_status) {
    case DOWNLOAD_STATUS_RENEWAL: {
        /* 下载中断, 发起断点续传 */
        res = aiot_download_send_request(download_handle);
        if (res == STATE_SUCCESS) {
            res = STATE_DOWNLOAD_RENEWAL_REQUEST_SENT;
        }
    }
    break;
    case DOWNLOAD_STATUS_FETCH: {
        /* 去网络收取报文, 并将各种状态值反馈给用户 */
        res = core_http_recv(http_handle);

        /* 全部固件下载完成 */
        if (download_handle->size_fetched == download_handle->task_desc->size_total) {
            res = STATE_DOWNLOAD_FINISHED;
            break;
        }

        /* 用户用多个range下载, 可能有重合, 导致最终累计的下载长度超出了固件的实际长度 */
        if (download_handle->size_fetched > download_handle->task_desc->size_total) {
            res = STATE_DOWNLOAD_FETCH_TOO_MANY;
            break;
        }

        /* 没有下载完整个固件, 但是下载完成了用户指定的range */
        if (download_handle->content_len > 0 && download_handle->range_size_fetched == download_handle->content_len) {
            res = STATE_DOWNLOAD_RANGE_FINISHED;
            /* range内的固件下载完成后, 要将content_len设置为0, 便于下次重新下载 */
            download_handle->content_len = 0;
            break;
        }

        if (res <= 0) {
            /* 在没有下载完成, 同时又碰到core_http_recv的返回值<=0的情况, 需要做断点续传 */
            uint8_t res_string_len = 0;
            char res_string[OTA_MAX_DIGIT_NUM_OF_UINT32] = {0};
            core_int2str(res, res_string, &res_string_len);
            core_log1(download_handle->sysdep, STATE_DOWNLOAD_RECV_ERROR, "recv got %s, renewal\r\n",
                      &res_string);
            download_handle->download_status = DOWNLOAD_STATUS_RENEWAL;
        } else {
            /* 在下载未完成(或者未开始), 同时core_http_recv的返回值>0的情况, 需要判断是否出现了http返回值403错误, 以及判断包头格式是否异常 */
            if (OTA_RESPONSE_OK != download_handle->http_rsp_status_code
                    && OTA_RESPONSE_PARTIAL != download_handle->http_rsp_status_code) {
                /* HTTP回复报文的code应该是200或者206, 否则这个下载链接不可用 */
                res = STATE_DOWNLOAD_HTTPRSP_CODE_ERROR;
            } else if (0 == download_handle->content_len) {
                /* HTTP回复报文的header里面应该有Content-Length, 否则这个下载链接为trunked编码, 不可用 */
                res = STATE_DOWNLOAD_HTTPRSP_HEADER_ERROR;
            }
            /* 如果没有上述code错误或者content_length字段错误, 则返回正数值, 表示下载到的字节数 */
        }
    }
    break;
    default:
        break;
    }
    sysdep->core_sysdep_mutex_unlock(download_handle->recv_mutex);
    return res;
}


/* 对aiot_download_task_desc_t结构体里面的指针所指向的内容进行深度释放 */
int32_t _download_deep_free_task_desc(aiot_sysdep_portfile_t *sysdep, void *data)
{
    int32_t res = STATE_SUCCESS;
    aiot_download_task_desc_t *task_desc = (aiot_download_task_desc_t *)data;

    if (NULL == task_desc) {
        return res;
    }

    if (NULL != task_desc->product_key) {
        sysdep->core_sysdep_free(task_desc->product_key);
        task_desc->product_key = NULL;
    }
    if (NULL != task_desc->device_name) {
        sysdep->core_sysdep_free(task_desc->device_name);
        task_desc->device_name = NULL;
    }
    if (NULL != task_desc->url) {
        sysdep->core_sysdep_free(task_desc->url);
        task_desc->url = NULL;
    }
    if (NULL != task_desc->expect_digest) {
        sysdep->core_sysdep_free(task_desc->expect_digest);
        task_desc->expect_digest = NULL;
    }
    if (NULL != task_desc->version) {
        sysdep->core_sysdep_free(task_desc->version);
        task_desc->version = NULL;
    }
    if (NULL != task_desc->module) {
        sysdep->core_sysdep_free(task_desc->module);
        task_desc->module = NULL;
    }
    if (NULL != task_desc->extra_data) {
        sysdep->core_sysdep_free(task_desc->extra_data);
        task_desc->extra_data = NULL;
    }
    if (NULL != task_desc->file_name) {
        sysdep->core_sysdep_free(task_desc->file_name);
        task_desc->file_name = NULL;
    }
    return res;
}


/* 从下行报文的topic中, 解析出product_key, device_name, ota的类型 */
int32_t _ota_prase_topic(aiot_sysdep_portfile_t *sysdep, char *topic, uint8_t topic_len,
                         ota_type_t *type, char **product_key, char **device_name)
{
    char *_product_key, *_device_name, *tmp;
    char *_product_key_local, *_device_name_local;
    uint8_t _product_key_len, _device_name_len;
    const char *SLASH = "/";
    uint8_t slash_len = strlen(SLASH);


    if (memcmp(topic, OTA_FOTA_TOPIC_PREFIX, strlen(OTA_FOTA_TOPIC_PREFIX)) == 0) {
        /* 判断是fota的/ota/device/upgrade的topic, 并且从中解出来product_key, device_name */
        _product_key = topic + strlen(OTA_FOTA_TOPIC_PREFIX) + slash_len;
        tmp = strstr((const char *)(_product_key), SLASH);
        _product_key_len = tmp - _product_key;
        _device_name = tmp + slash_len;
        _device_name_len = topic_len - (_device_name - topic);
        *type = OTA_TYPE_FOTA;
    } else if ((topic_len > strlen(OTA_GET_REPLY_TOPIC_SUFFIX))
               && (0 == memcmp(topic + topic_len - strlen(OTA_GET_REPLY_TOPIC_SUFFIX),
                               OTA_GET_REPLY_TOPIC_SUFFIX, strlen(OTA_GET_REPLY_TOPIC_SUFFIX)))) {
        /* 判断是fota的firmware/get的topic, 并且从中解出来product_key, device_name */
        _product_key = topic + strlen(OTA_GET_TOPIC_PREFIX) + slash_len;
        tmp = strstr((const char *)(_product_key), SLASH);
        _product_key_len = tmp - _product_key;
        _device_name = tmp + slash_len;
        _device_name_len = strstr((const char *)topic, OTA_GET_REPLY_TOPIC_SUFFIX) - _device_name - slash_len;
        *type = OTA_TYPE_FOTA;
    } else {
        /* 判断是cota的topic, 同时还区分是config/push还是config/get, 从中解出来product_key, device_name */
        char *postfix = NULL;
        _product_key = topic + strlen(OTA_COTA_TOPIC_PREFIX);
        tmp = strstr((const char *)(_product_key), SLASH);
        _product_key_len = tmp - _product_key;
        _device_name = tmp + slash_len;
        tmp = strstr((const char *)(_device_name), SLASH);
        _device_name_len = tmp - _device_name;
        postfix = _device_name + _device_name_len;
        if (0 != memcmp(postfix, OTA_COTA_PUSH_TOPIC_POSTFIX, strlen(OTA_COTA_PUSH_TOPIC_POSTFIX))) {
            *type = OTA_TYPE_CONFIG_GET;
        } else {
            *type = OTA_TYPE_CONFIG_PUSH;
        };
    }

    if ((NULL == (_product_key_local = sysdep->core_sysdep_malloc(_product_key_len + 1, OTA_MODULE_NAME)))
            || (NULL == (_device_name_local = sysdep->core_sysdep_malloc(_device_name_len + 1, OTA_MODULE_NAME)))) {
        if (NULL != _product_key_local) {
            sysdep->core_sysdep_free(_product_key_local);
        };
        return STATE_SYS_DEPEND_MALLOC_FAILED;
    }

    memset(_product_key_local, 0, _product_key_len + 1);
    memcpy(_product_key_local, _product_key, _product_key_len);
    *product_key = _product_key_local;

    memset(_device_name_local, 0, _device_name_len + 1);
    memcpy(_device_name_local, _device_name, _device_name_len);
    *device_name = _device_name_local;
    return STATE_SUCCESS;
}

/* OTA topic的mqtt回调函数. 主要作用是解析OTA下行的MQTT报文, 从中解析出url/digest等有关的信息 */
void _ota_mqtt_process(void *handle, const aiot_mqtt_recv_t *const packet, void *userdata)
{
    int32_t res = STATE_SUCCESS;
    ota_handle_t *ota_handle = NULL;
    aiot_sysdep_portfile_t *sysdep = NULL;
    char *digest_method_string = NULL;
    char *protocol_type_string = NULL;
    char *protocol_streamid_string = NULL;
    char *product_key = NULL, *device_name = NULL;
    char *data = NULL, *key = NULL;
    uint32_t data_len = 0;
    char *files = NULL;
    uint32_t files_len = 0;
    ota_type_t type;
    aiot_download_task_desc_t task_desc = {0};

    if (AIOT_MQTTRECV_PUB != packet->type) {
        return;
    }

    ota_handle = (ota_handle_t *)userdata;
    if (NULL == userdata) {
        return;
    }
    sysdep = ota_handle->sysdep;
    res = _ota_prase_topic(sysdep, packet->data.pub.topic, packet->data.pub.topic_len,
                           &type, &product_key, &device_name);

    if (res != STATE_SUCCESS) {
        goto exit;
    }
    task_desc.product_key = product_key;
    task_desc.device_name = device_name;
    task_desc.mqtt_handle = ota_handle->mqtt_handle;

    /* 如果是config/push这种topic, 下载有关的信息存放在json报文的params字段里面
     * 如果是其他类型的topic, 则下载有关的信息放在json报文的data字段里面
     */
    key = "data";
    if (OTA_TYPE_CONFIG_PUSH == type) {
        key = "params";
    }
    res = core_json_value((const char *)(packet->data.pub.payload), packet->data.pub.payload_len,
                          key, strlen(key), &data, &data_len);
    if (res != STATE_SUCCESS) {
        goto exit;
    }

    if (OTA_TYPE_FOTA == type) {
        /* 对于FOTA来说, 版本有关的关键字是version */
        if ((STATE_SUCCESS != _ota_parse_json(sysdep, data, data_len, "version", &(task_desc.version)))) {
            goto exit;
        }
    } else {
        /* 对于COTA来说, 版本有关的关键字是configId */
        if (STATE_SUCCESS != _ota_parse_json(sysdep, data, data_len, "configId", &(task_desc.version))) {
            goto exit;
        }
    }

    if ((STATE_SUCCESS != _ota_parse_json(sysdep, data, data_len, "signMethod", &(digest_method_string)))) {
        goto exit;
    }

    task_desc.protocol_type = AIOT_OTA_PROTOCOL_HTTPS;
    if ((STATE_SUCCESS == _ota_parse_json(sysdep, data, data_len, "dProtocol", &(protocol_type_string)))) {
        if (strcmp(protocol_type_string, "mqtt") == 0) {
            task_desc.protocol_type = AIOT_OTA_PROTOCOL_MQTT;
        }
        if(STATE_SUCCESS != _ota_parse_json(sysdep, data, data_len, "streamId", &(protocol_streamid_string))) {
            res = STATE_OTA_PARSE_JSON_ERROR;
            goto exit;
        }
        core_str2uint(protocol_streamid_string, strlen(protocol_streamid_string), &task_desc.stream_id);
    }

    if (strcmp(digest_method_string, "SHA256") == 0 || strcmp(digest_method_string, "Sha256") == 0) {
        task_desc.digest_method = AIOT_OTA_DIGEST_SHA256;
    } else if (strcmp(digest_method_string, "Md5") == 0) {
        task_desc.digest_method = AIOT_OTA_DIGEST_MD5;
    } else {
        res = STATE_OTA_UNKNOWN_DIGEST_METHOD;
        goto exit;
    }

    /* module字段, 并非必选(用户可能没有在云端设置过, 因此如果没有解析出来, 也不能算解析失败 */
    _ota_parse_json(sysdep, data, data_len, "module", &(task_desc.module));
    _ota_parse_json(sysdep, data, data_len, "extData", &(task_desc.extra_data));


    /* 多文件下载的情况 */
    if (STATE_SUCCESS == core_json_value((const char *)(data), data_len,
                                         "files", strlen("files"), &files, &files_len)) {

        uint32_t offset = files - data;
        uint32_t files_len = data_len - offset;

        ota_list_json array[OTA_ARRAY_MAX];
        int num = _ota_parse_list_array(files, files_len, array);
        for (int cnt = 0; cnt < num; cnt++) {
            task_desc.file_id = cnt;
            task_desc.file_num = num;
            int32_t ret = _process_single_file(sysdep, array[cnt].pos, array[cnt].len, type, &task_desc, ota_handle);
            if (ret != STATE_SUCCESS) {
                break;
            }
        }
        goto exit;
    }

    /* 单文件下载的情况 */
    task_desc.file_id = 0;
    task_desc.file_num = 1;
    _process_single_file(sysdep, data, data_len, type, &task_desc, ota_handle);

exit:
    if (NULL != digest_method_string) {
        sysdep->core_sysdep_free(digest_method_string);
    }
    if (NULL != protocol_type_string) {
        sysdep->core_sysdep_free(protocol_type_string);
    }
    if (NULL != protocol_streamid_string) {
        sysdep->core_sysdep_free(protocol_streamid_string);
    }
    _download_deep_free_task_desc(sysdep, (void *)(&task_desc));
}

static int32_t _process_single_file(aiot_sysdep_portfile_t *sysdep, char *data, uint32_t data_len,
                                    int type, aiot_download_task_desc_t *task_desc, ota_handle_t *ota_handle)
{
    char *size_string = NULL, *fileid_string = NULL;
    uint32_t size = 0;
    int32_t ret = STATE_SUCCESS;
    char *size_key = NULL, *url_key = NULL, *sign_key = NULL, *name_key = NULL;
    char *stream_file_id = "streamFileId";

    aiot_ota_recv_t msg = {
        /* 对于用户, 需要屏蔽config/push和config/get的区别, 都归并为AIOT_OTARECV_COTA */
        .type = (OTA_TYPE_FOTA == type) ? AIOT_OTARECV_FOTA : AIOT_OTARECV_COTA,
        .task_desc = task_desc
    };

    if(task_desc->file_num > 1) {
        size_key = "fileSize";
        url_key = "fileUrl";
        sign_key = "fileSign";
        name_key = "fileName";
    } else {
        size_key = (OTA_TYPE_FOTA == type) ? "size" : "configSize";
        url_key = "url";
        sign_key = "sign";
    }

    if ((STATE_SUCCESS != _ota_parse_json(sysdep, data, data_len, size_key, &size_string))
            || (STATE_SUCCESS != _ota_parse_json(sysdep, data, data_len, sign_key, &(task_desc->expect_digest)))) {
        ret = STATE_OTA_PARSE_JSON_ERROR;
        goto exit;
    }

    /* 解析文件下载信息 */
    if(task_desc->protocol_type == AIOT_OTA_PROTOCOL_HTTPS) {
        if(STATE_SUCCESS != _ota_parse_json(sysdep, data, data_len, url_key, &(task_desc->url))) {
            ret = STATE_OTA_PARSE_JSON_ERROR;
            goto exit;
        }
    } else if(task_desc->protocol_type == AIOT_OTA_PROTOCOL_MQTT) {
        if(STATE_SUCCESS != _ota_parse_json(sysdep, data, data_len, stream_file_id, &(fileid_string))) {
            ret = STATE_OTA_PARSE_JSON_ERROR;
            goto exit;
        }
        core_str2uint(fileid_string, strlen(fileid_string), &task_desc->stream_file_id);
    } else {
        goto exit;
    }

    /* 对于多文件下载的情况, 即有指定fileName这个字段的情况, 则要求解析出来,否则为非法格式 */
    if (NULL != name_key && STATE_SUCCESS != _ota_parse_json(sysdep, data, data_len, name_key, &(task_desc->file_name))) {
        ret = STATE_OTA_PARSE_JSON_ERROR;
        goto exit;
    }

    if ((task_desc->digest_method == AIOT_OTA_DIGEST_MD5 && strlen(task_desc->expect_digest) != OTA_MD5_LEN) ||
            (task_desc->digest_method == AIOT_OTA_DIGEST_SHA256 && strlen(task_desc->expect_digest) != OTA_SHA256_LEN)) {
        ret = STATE_OTA_PARSE_JSON_ERROR;
        goto exit;
    }

    core_str2uint(size_string, strlen(size_string), &size);
    task_desc->size_total = size;

    if (ota_handle->recv_handler) {
        ota_handle->recv_handler(ota_handle, &msg, ota_handle->userdata);
    }

exit:
    if (NULL != size_string) {
        sysdep->core_sysdep_free(size_string);
    }
    if (NULL != fileid_string) {
        sysdep->core_sysdep_free(fileid_string);
        fileid_string = NULL;
    }
    if (NULL != task_desc->url) {
        sysdep->core_sysdep_free(task_desc->url);
        task_desc->url = NULL;
    }
    if (NULL != task_desc->expect_digest) {
        sysdep->core_sysdep_free(task_desc->expect_digest);
        task_desc->expect_digest = NULL;
    }
    if (NULL != task_desc->file_name) {
        sysdep->core_sysdep_free(task_desc->file_name);
        task_desc->file_name = NULL;
    }

    return ret;
}

/* 解析URL, 从中解出来host, path */
static int32_t _download_parse_url(const char *url, char *host, uint32_t max_host_len, char *path,
                                   uint32_t max_path_len)
{
    char *host_ptr = (char *) strstr(url, "://");
    uint32_t host_len = 0;
    uint32_t path_len;
    char *path_ptr;
    char *fragment_ptr;

    if (host_ptr == NULL) {
        return STATE_OTA_PARSE_URL_HOST_IS_NULL;
    }
    host_ptr += 3;

    path_ptr = strchr(host_ptr, '/');
    if (NULL == path_ptr) {
        return STATE_OTA_PARSE_URL_PATH_IS_NULL;
    }

    if (host_len == 0) {
        host_len = path_ptr - host_ptr;
    }

    if (host_len >= max_host_len) {
        return STATE_OTA_HOST_STRING_OVERFLOW;
    }

    memcpy(host, host_ptr, host_len);
    host[host_len] = '\0';
    fragment_ptr = strchr(host_ptr, '#');
    if (fragment_ptr != NULL) {
        path_len = fragment_ptr - path_ptr;
    } else {
        path_len = strlen(path_ptr);
    }

    if (path_len >= max_path_len) {
        return STATE_OTA_PATH_STRING_OVERFLOW;
    }

    memcpy(path, path_ptr, path_len);
    path[path_len] = '\0';
    return STATE_SUCCESS;
}

/* 往固件服务器发送下载所需的GET请求 */
int32_t aiot_download_send_request(void *handle)
{
    int32_t res = STATE_SUCCESS;
    char host[OTA_HTTPCLIENT_MAX_URL_LEN] = { 0 };
    char path[OTA_HTTPCLIENT_MAX_URL_LEN] = { 0 };
    char *header_string = NULL;
    aiot_sysdep_portfile_t *sysdep = NULL;
    download_handle_t *download_handle = (download_handle_t *)handle;
    if (NULL == download_handle) {
        return STATE_DOWNLOAD_REQUEST_HANDLE_IS_NULL;
    }
    if (NULL == download_handle->task_desc) {
        return STATE_DOWNLOAD_REQUEST_TASK_DESC_IS_NULL;
    }
    if (NULL == download_handle->task_desc->url) {
        return STATE_DOWNLOAD_REQUEST_URL_IS_NULL;
    }
    sysdep = download_handle->sysdep;

    {
        uint32_t range_start = download_handle->range_start;
        uint32_t range_end = download_handle->range_end;
        uint8_t range_start_string_len = 0;
        uint8_t range_end_string_len = 0;
        char range_start_string[OTA_MAX_DIGIT_NUM_OF_UINT32] = {0};
        char range_end_string[OTA_MAX_DIGIT_NUM_OF_UINT32] = {0};

        /* 判断用户是否打算通过range下载整个固件中的一部分, 非全固件. */
        /* 判断方法是看range_start和range_end是否同时为0, 或者前者为0, 后者为文件最后一个字节-1 */
        /* 符合上述2个条件之一, 则认为用户打算下载整个固件中的一部分 */
        uint8_t user_set_range = 1;
        if (0 == range_start) {
            if (0 == range_end || range_end == (download_handle->task_desc->size_total - 1)) {
                user_set_range = 0;
            }
        }

        /* 对于想下载完整固件的情况,  如果中间出现了断点续传的情况, 则从0开始, 根据已经下载多少字节开始算下载地址 */
        /* 对于只想下载一段固件的情况, 如果中间出现了断点续传的情况, 则从range_start后面开始, 加上已下载的字节数作为一个续传的起始地址  */
        uint32_t renewal_start = (user_set_range == 0) ? download_handle->size_fetched : (range_start +
                                 download_handle->range_size_fetched);

        core_int2str(renewal_start, range_start_string, &range_start_string_len);

        /* 对于按照range下载的情况, 即range_end不为0的情况, 需要将其翻译成字符串 */
        if (0 != range_end) {
            core_int2str(range_end, range_end_string, &range_end_string_len);
        }

        {
            char *prefix = "Accept: text/html, application/xhtml+xml, application/xml;q=0.9, */*;q=0.8\r\nRange: bytes=";
            char *src[] = { prefix, range_start_string, "-", range_end_string};
            uint32_t len = sizeof(src) / sizeof(char *);
            res = core_sprintf(sysdep, &header_string, "%s%s%s%s\r\n", src, len, OTA_MODULE_NAME);
            if (res != STATE_SUCCESS) {
                if (header_string) {
                    sysdep->core_sysdep_free(header_string);
                }
                return res;
            }
        }
    }

    res = _download_parse_url(download_handle->task_desc->url, host, OTA_HTTPCLIENT_MAX_URL_LEN, path,
                              OTA_HTTPCLIENT_MAX_URL_LEN);
    if (res != STATE_SUCCESS) {
        if (header_string) {
            sysdep->core_sysdep_free(header_string);
        }
        return res;
    }

    res = core_http_setopt(download_handle->http_handle, CORE_HTTPOPT_HOST, host);
    if (res != STATE_SUCCESS) {
        if (header_string) {
            sysdep->core_sysdep_free(header_string);
        }
        return res;
    }
    res = core_http_connect(download_handle->http_handle);
    if (res != STATE_SUCCESS) {
        if (header_string) {
            sysdep->core_sysdep_free(header_string);
        }
        return res;
    }
    core_http_request_t request = {
        .method = "GET",
        .path = path,
        .header = header_string,
        .content = NULL,
        .content_len = 0
    };
    res = core_http_send(download_handle->http_handle, &request);
    if (header_string) {
        sysdep->core_sysdep_free(header_string);
    }
    /* core_http_send 返回的是发送的body的长度; 错误返回负数 */
    if (res < STATE_SUCCESS) {
        download_handle->download_status = DOWNLOAD_STATUS_START;
        res = STATE_DOWNLOAD_SEND_REQUEST_FAILED;
    } else {
        download_handle->download_status = DOWNLOAD_STATUS_FETCH;
        aiot_download_report_progress(download_handle, download_handle->percent);
        res = STATE_SUCCESS;
    }
    return res;
}

/* 根据下载到的固件的内容, 计算其digest值 */
static int32_t _download_digest_update(download_handle_t *download_handle, uint8_t *buffer, uint32_t buffer_len)
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
static int32_t _download_digest_verify(download_handle_t *download_handle)
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

/* 对于收到的http报文进行处理的回调函数, 内部处理完后再调用用户的回调函数 */
void _http_recv_handler(void *handle, const aiot_http_recv_t *packet, void *userdata)
{
    download_handle_t *download_handle = (download_handle_t *)userdata;
    if (NULL == download_handle || NULL == packet) {
        return;
    }
    switch (packet->type) {
    case AIOT_HTTPRECV_STATUS_CODE : {
        download_handle->http_rsp_status_code = packet->data.status_code.code;
    }
    break;
    case AIOT_HTTPRECV_HEADER: {
        if ((strlen(packet->data.header.key) == strlen("Content-Length")) &&
                (memcmp(packet->data.header.key, "Content-Length", strlen(packet->data.header.key)) == 0)) {
            uint32_t size = 0;

            /* 在用户指定的range并非全部固件的情况下, content_len < size_total, 所以不能简单替换 */
            core_str2uint(packet->data.header.value, (uint8_t)strlen(packet->data.header.value), &size);

            /* 该字段表示用户期望总共下载多少字节. 如果字段为0, 表示未设置过, 则设置为总共的字节数 */
            download_handle->content_len = (download_handle->content_len > 0) ? download_handle->content_len : size;
        }
    }
    break;
    case AIOT_HTTPRECV_BODY: {
        int32_t percent = 0;
        if (OTA_RESPONSE_OK != download_handle->http_rsp_status_code
                /* HTTP回复报文的code应该是200或者206, 否则这个下载链接不可用 */
                && OTA_RESPONSE_PARTIAL != download_handle->http_rsp_status_code) {
            percent = AIOT_OTAERR_FETCH_FAILED;
            core_log(download_handle->sysdep, STATE_DOWNLOAD_HTTPRSP_CODE_ERROR, "wrong http respond code\r\n");
        } else if (0 == download_handle->content_len) {
            /* HTTP回复报文的header里面应该有Content-Length, 否则这个下载链接为trunked编码, 不可用 */
            percent = AIOT_OTAERR_FETCH_FAILED;
            core_log(download_handle->sysdep, STATE_DOWNLOAD_HTTPRSP_HEADER_ERROR, "wrong http respond header\r\n");
        } else {
            /* 正常的固件的报文 */
            /* 在按照多个range分片下载的情况下, 判断用户下载到的固件的累计大小是否超过了整体的值 */
            if (download_handle->size_fetched > download_handle->task_desc->size_total) {
                core_log(download_handle->sysdep, STATE_DOWNLOAD_FETCH_TOO_MANY, "downloaded exceeds expected\r\n");
                break;
            }

            /* 该字段表示累计下载了多少字节, 不区分range */
            download_handle->size_fetched += packet->data.body.len;
            /* 该字段表示在这个range内总共下载了多少字节 */
            download_handle->range_size_fetched += packet->data.body.len;

            /* 当size_fetched*100超过uint32_t能表达的范围时, 比如239395702, 会导致percent计算错误, 因此需要一个更大的临时变量 */
            uint64_t tmp_size_fetched = 0;
            tmp_size_fetched = download_handle->size_fetched;
            percent = (100 * tmp_size_fetched) / download_handle->task_desc->size_total;

            /* 计算digest, 如果下载完成, 还要看看是否与云端计算出来的一致 */
            _download_digest_update(download_handle, packet->data.body.buffer, packet->data.body.len);
            if (download_handle->size_fetched == download_handle->task_desc->size_total) {
                int32_t ret = _download_digest_verify(download_handle);
                if (ret != STATE_SUCCESS) {
                    percent = AIOT_OTAERR_CHECKSUM_MISMATCH;
                    core_log(download_handle->sysdep, ret, "digest mismatch\r\n");
                    aiot_download_report_progress(download_handle, AIOT_OTAERR_CHECKSUM_MISMATCH);
                } else {
                    core_log(download_handle->sysdep, STATE_OTA_DIGEST_MATCH, "digest matched\r\n");
                }
            }
            download_handle->percent = percent;

            /* 调用用户的回调函数, 将报文传给用户 */
            if (NULL != download_handle->recv_handler) {
                aiot_download_recv_t recv_data = {
                    .type = AIOT_DLRECV_HTTPBODY,
                    .data = {
                        .buffer = packet->data.body.buffer,
                        .len = packet->data.body.len,
                        .percent = percent
                    }
                };
                download_handle->recv_handler(download_handle, &recv_data, download_handle->userdata);
            }
        }
    }
    break;
    default:
        break;
    }
}

/* 提供深度拷贝的底层函数 */
static void *_download_deep_copy_base(aiot_sysdep_portfile_t *sysdep, char *in)
{
    uint32_t len = 0;
    void *tmp = NULL;
    if (NULL == in) {
        return NULL;
    }
    len = strlen(in) + 1;
    tmp = (aiot_download_task_desc_t *)sysdep->core_sysdep_malloc(len,
            DOWNLOAD_MODULE_NAME);
    if (NULL == tmp) {
        return NULL;
    }
    memset(tmp, 0, len);
    memcpy(tmp, in, strlen(in));
    return tmp;
}

/* 对aiot_download_task_desc_t结构体实现深度拷贝 */
void *_download_deep_copy_task_desc(aiot_sysdep_portfile_t *sysdep, void *data)
{
    aiot_download_task_desc_t *src_task_desc = (aiot_download_task_desc_t *)data;
    aiot_download_task_desc_t *dst_task_desc = NULL;

    dst_task_desc = (aiot_download_task_desc_t *)sysdep->core_sysdep_malloc(sizeof(aiot_download_task_desc_t),
                    DOWNLOAD_MODULE_NAME);
    if (NULL == dst_task_desc) {
        return NULL;
    }

    memset(dst_task_desc, 0, sizeof(aiot_download_task_desc_t));
    dst_task_desc->size_total = src_task_desc->size_total;
    dst_task_desc->digest_method = src_task_desc->digest_method;
    dst_task_desc->mqtt_handle = src_task_desc->mqtt_handle;
    dst_task_desc->stream_id = src_task_desc->stream_id;
    dst_task_desc->stream_file_id = src_task_desc->stream_file_id;

    /* 对于module字段, 只有判断云端有下发过module的报文, 才能认为出参是要有module字段的 */
    if (NULL != src_task_desc->module) {
        if (NULL == (dst_task_desc->module = _download_deep_copy_base(sysdep, src_task_desc->module))) {
            return NULL;
        }
    }

    if (NULL != src_task_desc->url && NULL == (dst_task_desc->url = _download_deep_copy_base(sysdep, src_task_desc->url))) {
        _download_deep_free_task_desc(sysdep, dst_task_desc);
        sysdep->core_sysdep_free(dst_task_desc);
        return NULL;
    }

    if ((NULL != src_task_desc->product_key && NULL == (dst_task_desc->product_key = _download_deep_copy_base(sysdep, src_task_desc->product_key)))
            || (NULL != src_task_desc->device_name && NULL == (dst_task_desc->device_name = _download_deep_copy_base(sysdep, src_task_desc->device_name)))
            || (NULL != src_task_desc->version && NULL == (dst_task_desc->version = _download_deep_copy_base(sysdep, src_task_desc->version)))
            || (NULL != src_task_desc->expect_digest && NULL == (dst_task_desc->expect_digest = _download_deep_copy_base(sysdep, src_task_desc->expect_digest)))) {
        _download_deep_free_task_desc(sysdep, dst_task_desc);
        sysdep->core_sysdep_free(dst_task_desc);
        return NULL;
    }

    return dst_task_desc;
}

/* 提供上报版本号与上报进度的底层函数 */
int32_t _ota_publish_base(void *handle, char *topic_prefix, char *product_key,
                          char *device_name, char *suffix, char *params)
{
    int32_t res = STATE_SUCCESS;
    core_mqtt_handle_t *mqtt_handle = (core_mqtt_handle_t *)handle;
    char *topic_string = NULL;
    char *payload_string = NULL;
    aiot_sysdep_portfile_t *sysdep = NULL;

    if (NULL == product_key || NULL == device_name || NULL == mqtt_handle) {
        return STATE_USER_INPUT_NULL_POINTER;
    }

    sysdep = mqtt_handle->sysdep;
    /* 拼装topic */
    if (NULL == suffix) {
        char *src[] = { topic_prefix, product_key, device_name };
        uint8_t topic_len = sizeof(src) / sizeof(char *);
        res = core_sprintf(sysdep, &topic_string, "%s/%s/%s", src, topic_len, OTA_MODULE_NAME);
        if (res != STATE_SUCCESS) {
            goto exit;
        }
    } else {
        char *src[] = { topic_prefix, product_key, device_name, suffix };
        uint8_t topic_len = sizeof(src) / sizeof(char *);
        res = core_sprintf(sysdep, &topic_string, "%s/%s/%s/%s", src, topic_len, OTA_MODULE_NAME);
        if (res != STATE_SUCCESS) {
            goto exit;
        }
    }

    /* 拼装payload, 几种报文都是基于alink协议, 所以需要alink id */
    {
        int32_t alink_id;
        uint8_t alink_id_string_len;
        char alink_id_string[OTA_MAX_DIGIT_NUM_OF_UINT32] = {0};
        res = core_global_alink_id_next(sysdep, &alink_id);
        if (res != STATE_SUCCESS) {
            goto exit;
        }
        core_int2str(alink_id, alink_id_string, &alink_id_string_len);

        {
            char *src[] = {
                "{\"id\":", alink_id_string, ", \"params\":", params, "}"
            };
            uint8_t topic_len = sizeof(src) / sizeof(char *);

            res = core_sprintf(sysdep, &payload_string, "%s%s%s%s%s", src, topic_len, OTA_MODULE_NAME);
            if (res != STATE_SUCCESS) {
                goto exit;
            }
        }
    }

    res = aiot_mqtt_pub(mqtt_handle, topic_string, (uint8_t *)payload_string, strlen(payload_string), 0);

exit:
    if (NULL != topic_string) {
        sysdep->core_sysdep_free(topic_string);
    }
    if (NULL != payload_string) {
        sysdep->core_sysdep_free(payload_string);
    }

    if (res != STATE_SUCCESS) {
        core_log(sysdep, STATE_OTA_REPORT_FAILED, topic_prefix);
    }
    return res;
}

/* 将ota的回调函数挂载到mqtt模块里面 */
static int32_t _ota_subscribe(void *mqtt_handle, void *ota_handle)
{
    int32_t res = STATE_SUCCESS;
    char *topic[OTA_TOPIC_NUM] = { OTA_FOTA_TOPIC, OTA_COTA_PUSH_TOPIC, OTA_COTA_GET_REPLY_TOPIC, OTA_OTA_GET_REPLY_TOPIC };
    uint8_t count = 0;
    memset(&g_ota_topic_map, 0, sizeof(g_ota_topic_map));

    for (count = 0; count < OTA_TOPIC_NUM; count++) {
        char *topic_string = topic[count];
        aiot_mqtt_topic_map_t topic_map = {topic_string, _ota_mqtt_process, (void *)ota_handle};
        g_ota_topic_map[count] = topic_map;
        res = aiot_mqtt_setopt(mqtt_handle, AIOT_MQTTOPT_APPEND_TOPIC_MAP, (void *)&topic_map);
        if (STATE_SUCCESS != res) {
            break;
        }
    }
    return res;
}

/* 解析json报文, 并且将解析出来的内容, 填充到malloc出来的一片内存中 */
static int32_t _ota_parse_json(aiot_sysdep_portfile_t *sysdep, void *input, uint32_t input_len, char *key_word,
                               char **out)
{
    int32_t res = STATE_SUCCESS;
    char *value = NULL, *buffer = NULL;
    uint32_t value_len = 0, buffer_len = 0;

    res = core_json_value((const char *)input, input_len, key_word, strlen(key_word), &value, &value_len);
    if (res != STATE_SUCCESS) {
        return STATE_OTA_PARSE_JSON_ERROR;
    }
    buffer_len = value_len + 1;
    buffer = sysdep->core_sysdep_malloc(buffer_len, OTA_MODULE_NAME);
    if (NULL == buffer) {
        return STATE_OTA_PARSE_JSON_MALLOC_FAILED;
    }
    memset(buffer, 0, buffer_len);
    memcpy(buffer, value, value_len);
    *out = buffer;
    return res;
}

static int32_t _ota_parse_list_array(char *str, int32_t str_len, ota_list_json *array)
{
    int32_t num = 0, len = 0;
    int32_t i = 0, new = 0;

    if ((NULL == str) || (str_len <= 2)) {
        return 0;
    }

    str++;
    if (*str == ']') { /* empty array */
        return 0;
    }

    while ((i < str_len) && (num < OTA_ARRAY_MAX)) {
        if (*str == '{') {
            len = 1;
            new = 1;
            array[num].pos = str;
        } else if (*str == '}') {
            len++;
            if (new == 1) {
                array[num].len = len;
                num++;
                new = 0;
            }
        } else {
            len++;
        }
        str++;
        i++;
    }
    return num;
}


