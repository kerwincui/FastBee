/**
 * @file aiot_sysdep_api.h
 * @brief SDK Core系统依赖头文件, 所有Core中的系统依赖均在此文件中列出
 * @date 2021-07-14
 *
 * @copyright Copyright (C) 2015-2018 Alibaba Group Holding Limited
 *
 */

#ifndef _POXIS_PORT_H_
#define _POXIS_PORT_H_

#if defined(__cplusplus)
extern "C" {
#endif

#include <stdint.h>
#include "aiot_sysdep_api.h"

/**
 * @brief 用以向SDK描述其运行硬件平台的资源如何使用的方法结构体
 */
typedef struct {
    /**
     * @brief 申请内存
     */
    void *(*malloc)(uint32_t size);
    /**
     * @brief 释放内存
     */
    void (*free)(void *ptr);
    /**
     * @brief 获取当前的时间戳，SDK用于差值计算
     */
    uint64_t (*time)(void);
    /**
     * @brief 睡眠指定的毫秒数
     */
    void (*sleep)(uint64_t time_ms);
    /**
     * @brief 随机数生成方法
     */
    void (*rand)(uint8_t *output, uint32_t output_len);
    /**
     * @brief 创建互斥锁
     */
    void    *(*mutex_init)(void);
    /**
     * @brief 申请互斥锁
     */
    void (*mutex_lock)(void *mutex);
    /**
     * @brief 释放互斥锁
     */
    void (*mutex_unlock)(void *mutex);
    /**
     * @brief 销毁互斥锁
     */
    void (*mutex_deinit)(void **mutex);
} aiot_os_al_t;


/**
 * @brief 用以向SDK描述其运行硬件平台的资源如何使用的方法结构体
 */

typedef struct {
    /**
     * @brief 建立1个网络会话, 作为MQTT/HTTP等协议的底层承载
     */
    int32_t (*establish)(int type, char *host, int port, int timeout_ms, int *fd_out);
    /**
     * @brief 从指定的网络会话上读取
     */
    int32_t (*recv)(int fd, uint8_t *buffer, uint32_t len, uint32_t timeout_ms, core_sysdep_addr_t *addr);
    /**
     * @brief 在指定的网络会话上发送
     */
    int32_t (*send)(int fd, uint8_t *buffer, uint32_t len, uint32_t timeout_ms,
                    core_sysdep_addr_t *addr);
    /**
     * @brief 销毁1个网络会话
     */
    int32_t (*close)(int fd);
} aiot_net_al_t;

void aiot_install_os_api(aiot_os_al_t *os);
void aiot_install_net_api(aiot_net_al_t *net);

void *core_sysdep_malloc(uint32_t size, char *name);
void core_sysdep_free(void *ptr);
uint64_t core_sysdep_time(void);
void core_sysdep_sleep(uint64_t time_ms);
void *core_sysdep_network_init(void);
int32_t core_sysdep_network_setopt(void *handle, core_sysdep_network_option_t option, void *data);
int32_t core_sysdep_network_establish(void *handle);
int32_t core_sysdep_network_recv(void *handle, uint8_t *buffer, uint32_t len, uint32_t timeout_ms,core_sysdep_addr_t *addr);
int32_t core_sysdep_network_send(void *handle, uint8_t *buffer, uint32_t len, uint32_t timeout_ms,core_sysdep_addr_t *addr);
int32_t core_sysdep_network_deinit(void **handle);
void core_sysdep_rand(uint8_t *output, uint32_t output_len);
void *core_sysdep_mutex_init(void);
void core_sysdep_mutex_lock(void *mutex);
void core_sysdep_mutex_unlock(void *mutex);
void core_sysdep_mutex_deinit(void **mutex);

#if defined(__cplusplus)
}
#endif
#endif
