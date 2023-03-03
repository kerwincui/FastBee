/**
 * @file aiot_mqtt_download_api.h
 * @brief mqtt_download模块头文件, 提供mqtt文件传输的能力
 *
 * @copyright Copyright (C) 2015-2020 Alibaba Group Holding Limited
 *
 */
#ifndef __AIOT_MQTT_DOWNLOAD_API_H__
#define __AIOT_MQTT_DOWNLOAD_API_H__

#if defined(__cplusplus)
extern "C" {
#endif

#include <stdint.h>

/**
 * @brief -0x1D00~-0x1DFF表达SDK在mqtt_download模块内的状态码
 */
#define STATE_MQTT_DOWNLOAD_BASE                                             (-0x1D00)

/**
 * @brief mqtt_download_handle为空
 */
#define STATE_MQTT_DOWNLOAD_MQTT_HANDLE_NULL                                 (-0x1D01)

/**
 * @brief 任务未初始化
 */
#define STATE_MQTT_DOWNLOAD_TASK_DEINIT                                      (-0x1D02)

/**
 * @brief 初始化完，第一次执行请求
 */
#define STATE_MQTT_DOWNLOAD_INIT                                             (-0x1D03)

/**
 * @brief 正在下载文件
 */
#define STATE_MQTT_DOWNLOAD_ING                                              (-0x1D04)

/**
 * @brief 文件已经下载完，但未校验
 */
#define STATE_MQTT_DOWNLOAD_FINISHED                                         (-0x1D05)

/**
 * @brief 文件下载完成，并且校验通过
 */
#define STATE_MQTT_DOWNLOAD_SUCCESS                                          (-0x1D06)

/**
 * @brief 文件下载接收失败，重试几个后还是失败，认定为超时
 */
#define STATE_MQTT_DOWNLOAD_FAILED_TIMEOUT                                   (-0x1D07)

/**
 * @brief 完整文件下载时，MD5校验失败
 */
#define STATE_MQTT_DOWNLOAD_FAILED_MISMATCH                                  (-0x1D08)

/**
 * @brief 接收长度校验错误
 */
#define STATE_MQTT_DOWNLOAD_FAILED_RECVERROR                                 (-0x1D09)

/**
 * @brief 用户主动取消下载任务
 */
#define STATE_MQTT_DOWNLOAD_ABORT                                            (-0x1D0A)

/**
 * @brief 设置的下载长度为空
 */
#define STATE_MQTT_DOWNLOAD_FILESIZE_ERROR                                   (-0x1D0B)



/**
 * @brief mqtt_download模块收到从网络上来的报文时, 通知用户的报文类型
 */
typedef enum {
    /**
     * @brief 文件分片下载请求的返回报文
     */
    AIOT_MDRECV_DATA_RESP,
} aiot_mqtt_download_recv_type_t;

/**
 * @brief mqtt_download模块收到从网络上来的报文时, 通知用户的报文内容
 */
typedef struct {
    /**
     * @brief 报文内容所对应的报文类型, 更多信息请参考@ref aiot_mqtt_download_recv_type_t
     */
    aiot_mqtt_download_recv_type_t  type;
    union {
        /**
         * @brief data_resp_type的说明
         */
        struct {
            /**
             * @brief 用户标准的文件名称，一般为设置的文件名
             */
            char *filename;
            /**
             * @brief 文件的偏移
             */
            uint32_t offset;
            /**
             * @brief 接收到的数据长度
             */
            uint32_t data_size;
            /**
             * @brief 接收到的数据
             */
            char *data;
            /**
             * @brief 接收到的数据
             */
            int32_t percent;
            /**
             * @brief 文件的总大小
             */
            int32_t file_lenth;
        } data_resp;
    } data;
} aiot_mqtt_download_recv_t;

/**
 * @brief mqtt_download模块收到从网络上来的报文时, 通知用户所调用的数据回调函数
 *
 * @param[in] handle mqtt_download会话句柄
 * @param[in] packet mqtt_download消息结构体, 存放收到的mqtt_download报文内容
 * @param[in] userdata 用户上下文
 *
 * @return void
 */
typedef void (* aiot_mqtt_download_recv_handler_t)(void *handle,
        const aiot_mqtt_download_recv_t *packet, void *userdata);


/**
 * @brief @ref aiot_mqtt_download_setopt 接口的option参数可选值.
 *
 * @details 下文每个选项中的数据类型, 指的是@ref aiot_mqtt_download_setopt 中, data参数的数据类型
 */
typedef enum {
    /**
     * @brief 设置处理OTA消息的用户回调函数
     *
     * @details
     *
     * 数据类型: (aiot_mqtt_download_recv_handler_t)
     */
    AIOT_MDOPT_RECV_HANDLE,

    /**
     * @brief 设置MQTT的handle
     *
     * @details
     *
     * 文件下载过程中使用MQTT的通道能力, 用以请求数据及接收数据
     *
     * 数据类型: (void *)
     */
    AIOT_MDOPT_MQTT_HANDLE,

    /**
      * @brief 用户需要SDK暂存的上下文
      *
      * @details
      *
      * 该上下文会在@ref AIOT_OTAOPT_RECV_HANDLER 中传回给用户
      *
      * 数据类型: (void *)
      */
    AIOT_MDOPT_USERDATA,
    /**
     * @brief 设置download实例句柄所包含下载任务的具体内容
     *
     * @details
     *
     * 用户在收到OTA的mqtt消息后, 如果决定升级, 则需要通过该选项, 在download实例句柄中开辟内存,
     * 将OTA消息中携带的url, version, digest method, sign等信息复制过来, 有了这些信息后才能开始下载任务
     *
     * 数据类型: (aiot_download_task_desc_t *)
     *
     **/
    AIOT_MDOPT_TASK_DESC,

    /**
     * @brief 设置按照range下载的起始地址
     *
     * @details
     *
     * MQTT 范围请求(range requests)特性中, 表示从第该byte开始下载
     * 如果指定从头开始下载, 则start的值为0
     *
     * 数据类型: (uint32_t *)
     *
     **/
    AIOT_MDOPT_RANGE_START,
    /**
    * @brief 设置按照range下载的结束地址
    *
    * @details
    * MQTT 范围请求(range requests)特性中, 表示下载到该byte后结束.
    * 如果指定从头开始下载到10个byte后结束,
    * 则需要指定start = 0, end = 9, 这样总共10个byte
    *
    * 数据类型: (uint32_t *)
    *
    **/
    AIOT_MDOPT_RANGE_END,

    /**
    * @brief 单次请求数据的最大长度
    *
    * @details
    *
    * 数据类型: (uint32_t *) 默认值: (2 *1024) Bytes
    */
    AIOT_MDOPT_DATA_REQUEST_SIZE,

    AIOT_MDOPT_MAX,
} aiot_mqtt_download_option_t;

/**
 * @brief 创建mqtt_download会话实例, 并以默认值配置会话参数
 *
 * @return void *
 * @retval 非NULL mqtt_download实例的句柄
 * @retval NULL   初始化失败, 一般是内存分配失败导致
 *
 */
void *aiot_mqtt_download_init(void);

/**
 * @brief 配置mqtt_download会话
 *
 * @param[in] handle mqtt_download会话句柄
 * @param[in] option 配置选项, 更多信息请参考@ref aiot_mqtt_download_option_t
 * @param[in] data   配置选项数据, 更多信息请参考@ref aiot_mqtt_download_option_t
 *
 * @return int32_t
 * @retval <STATE_SUCCESS  参数配置失败
 * @retval >=STATE_SUCCESS 参数配置成功
 *
 */
int32_t aiot_mqtt_download_setopt(void *handle, aiot_mqtt_download_option_t option, void *data);

/**
 * @brief 结束mqtt_download会话, 销毁实例并回收资源
 *
 * @param[in] handle 指向mqtt_download会话句柄的指针
 *
 * @return int32_t
 * @retval <STATE_SUCCESS  执行失败
 * @retval >=STATE_SUCCESS 执行成功
 *
 */
int32_t aiot_mqtt_download_deinit(void **handle);

/**
 * @brief 处理下载逻辑
 *
 * @param handle mqtt_download会话句柄
 *
 * @return int32_t
 * @retval STATE_MQTT_DOWNLOAD_INIT             初始化完成
 * @retval STATE_MQTT_DOWNLOAD_ING              正在下载
 * @retval STATE_MQTT_DOWNLOAD_SUCCESS          下载完成
 * @retval STATE_MQTT_DOWNLOAD_FAILED_RECVERROR 数据接收错误
 * @retval STATE_MQTT_DOWNLOAD_FAILED_TIMEOUT   接收超时
 * @retval STATE_MQTT_DOWNLOAD_FAILED_MISMATCH  校验错误
 * @retval STATE_MQTT_DOWNLOAD_MQTT_HANDLE_NULL handle没有初始化
 * @retval STATE_MQTT_DOWNLOAD_TASK_DEINIT      没有设置task
 */
int32_t aiot_mqtt_download_process(void *handle);



#if defined(__cplusplus)
}
#endif

#endif  /* __AIOT_MQTT_DOWNLOAD_API_H__ */

