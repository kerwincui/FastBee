/**
 * @file aiot_linkspeech_api.h
 * @brief LinkSpeech模块头文件, 提供设备千里传音的能力
 * @date 2019-12-27
 *
 * @copyright Copyright (C) 2015-2018 Alibaba Group Holding Limited
 *
 * @details
 *
 */

#ifndef __AIOT_LINKSPEECH_API_H__
#define __AIOT_LINKSPEECH_API_H__

#if defined(__cplusplus)
extern "C" {
#endif

#include <stdint.h>

typedef struct {
    /* 当音频播报结束后执行该回调, 需要带userdata */
    void (*on_finish)(char *filename, void *userdata);
    void *userdata;
} play_param_t;

/* 设置音频播放回调，该接口不能长时间阻塞 */
typedef int32_t (*player_cb_t)(char *filename, play_param_t *ext_params);

typedef enum {
    /**
     * @brief 模块依赖的MQTT句柄
     *
     * @details
     *
     * 千里传音模块依赖底层的MQTT模块, 用户必需配置正确的MQTT句柄, 否则无法正常工作
     *
     * 数据类型: (void *)
     */
    AIOT_LSOPT_MQTT_HANDLE,
    /**
     * @brief 模块依赖的文件系统操作
     *
     * @details
     *
     * 千里传音模块依赖文件系统接口，需要用户实现并设置
     *
     * 数据类型: (aiot_fs_t *)
     */
    AIOT_LSOPT_FILE_OPS,
    /**
     * @brief 模块依赖的语音播放的接口设置
     *
     * @details
     *
     * 千里传音模块依赖音频播放接口
     *
     * 数据类型: (player_cb_t *)
     */
    AIOT_LSOPT_PLAYER_CALLBACK,
    /**
     * @brief 设置千里传音文件保存的文件夹路径
     *
     * @details
     *
     * 数据类型: (char *)
     */
    AIOT_LSOPT_WORK_DIR,
    /**
     * @brief 是否使能https下载，默认为http下载
     *
     * @details
     *
     * 数据类型: (int32_t *) 0:http下载   1:https下载
     */
    AIOT_LSOPT_HTTPS_ENABLE,
    /**
     * @brief 组合播报任务大缓存个数
     *
     * @details
     *  当组合播报的速度小于下发的速度时，SDK会缓存播报任务，该参数用于设置缓存播报任务的个数
     *
     * 数据类型: (int32_t *) 1～255, 默认为10
     */
    AIOT_LSOPT_SPEECH_BUFFER_SIZE,

    AIOT_LSOPT_MAX,
} aiot_linkspeech_option_t;

/**
 * @brief 创建一个LinkSpeech实例
 *
 * @return void*
 * @retval 非NULL linkspeech实例句柄
 * @retval NULL 初始化失败, 或者是因为没有设置portfile, 或者是内存分配失败导致
 *
 */
void   *aiot_linkspeech_init();

/**
 * @brief 销毁LinkSpeech实例句柄
 *
 * @param[in] handle 指向linkspeech实例句柄的指针
 *
 * @return int32_t
 * @retval STATE_SUCCESS 执行成功
 *
 */
int32_t aiot_linkspeech_deinit(void **handle);

/**
 * @brief 设置LinkSpeech句柄的参数
 *
 * @details
 *
 * 对LinkSpeech会话进行配置, 常见的配置选项包括
 *
 * + `AIOT_LSOPT_MQTT_HANDLE`: 把 @ref aiot_mqtt_init 返回的MQTT会话句柄跟OTA会话关联起来
 * + `AIOT_LSOPT_RECV_HANDLER`: 设置OTA消息的数据处理回调, 这个用户回调在有OTA消息的时候, 会被 @ref aiot_mqtt_recv 调用到
 *
 * @param[in] handle linkspeech句柄
 * @param[in] option 配置选项, 更多信息请参考@ref aiot_linkspeech_option_t
 * @param[in] data   配置选项数据, 更多信息请参考@ref aiot_linkspeech_option_t
 *
 * @return int32_t
 * @retval STATE_USER_INPUT_UNKNOWN_OPTION option不支持
 * @retval STATE_SUCCESS 参数设置成功
 *
 */
int32_t aiot_linkspeech_setopt(void *handle, aiot_linkspeech_option_t option, void *data);


/**
 * @brief 启动linkspeech（千里传音）服务，会一直阻塞
 *
 * @param[in] handle 指向linkspeech实例句柄的指针
 *
 * @return int32_t
 * @retval STATE_SUCCESS 执行成功
 *
 */
int32_t aiot_linkspeech_start(void *handle);

/**
 * @brief 关闭linkspeech（千里传音）服务，执行后aiot_linkspeech_start会退出
 *
 * @param[in] handle 指向linkspeech实例句柄的指针
 *
 * @return int32_t
 * @retval STATE_SUCCESS 执行成功
 *
 */
int32_t aiot_linkspeech_stop(void *handle);


#if defined(__cplusplus)
}
#endif

#endif  /* #ifndef __AIOT_LINKSPEECH_API_H__ */

