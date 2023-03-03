/**
 * @file mqtt_download_private.h
 * @brief mqtt_download模块内部的宏定义和数据结构声明, 不面向其它模块, 更不面向用户
 *
 * @copyright Copyright (C) 2015-2020 Alibaba Group Holding Limited
 *
 */
#ifndef __MQTT_DOWNLOAD_PRIVATE_H__
#define __MQTT_DOWNLOAD_PRIVATE_H__

#if defined(__cplusplus)
extern "C" {
#endif

#include "core_stdinc.h"
#include "aiot_state_api.h"
#include "aiot_sysdep_api.h"
#include "aiot_ota_api.h"
#include "aiot_mqtt_download_api.h"      /* 内部头文件是用户可见头文件的超集 */

/* 定义mqtt_download模块内部的会话句柄结构体, SDK用户不可见, 只能得到void *handle类型的指针 */
typedef struct {
    aiot_sysdep_portfile_t               *sysdep;       /* 底层依赖回调合集的引用指针 */
    aiot_mqtt_download_recv_handler_t    recv_handler;  /* 组件从协议栈读到内容时, 通知用户的回调 */
    void                                 *userdata;     /* 组件调用以上2个 mqtt_download_handler 时的入参之一 */
    aiot_download_task_desc_t            *task_desc;    /* 某次下载活动的目标描述信息, 如URL等 */
    uint32_t                             range_start;
    uint32_t                             range_end;
    uint32_t                             request_size;  /* 每次请求的size */
    /*---- 以上都是用户在API可配 ----*/
    uint32_t        msg_id;
    uint32_t        size_fetched;
    int32_t         percent;
    uint64_t        last_request_time;
    uint64_t        failed_counter;
    int32_t         status;
    int32_t         last_percent;
    uint32_t        range_size;
    int8_t          md5_enabled;

    void            *digest_ctx;
    void            *data_mutex;
    void            *recv_mutex;
} mqtt_download_handle_t;

/* 用于内存统计的模块名字符串 */
#define MQTT_DOWNLOAD_MODULE_NAME                    "mqtt_download"

/* 发送请求后，等待回复的超时时间设置 */
#define MQTT_DOWNLOAD_DEFAULT_RECV_TIMEOUT           (10 * 1000)
/* 默认的单次请求长度 */
#define MQTT_DOWNLOAD_DEFAULT_REQUEST_SIZE           (5 * 1024)

/* 请求及回复的topic定义 */
#define MQTT_DOWNLOAD_REQUEST_TOPIC                  "/sys/%s/%s/thing/file/download"
#define MQTT_DOWNLOAD_RESPONSE_TOPIC                 "/sys/%s/%s/thing/file/download_reply"

/* TOKEN的最长长度  */
#define MQTT_DOWNLOAD_TOKEN_MAXLEN                   (128)
/* 上报进度的间隔，单位：%  */
#define MQTT_DOWNLOAD_REPORT_INTERNEL                (5)


#if defined(__cplusplus)
}
#endif
#endif  /* __MQTT_DOWNLOAD_PRIVATE_H__ */

