/**
 * @file aiot_fs_api.h
 * @brief SDK linkspeech依赖的文件操作，所有依赖的文件操作将在此列出
 * @date 2019-12-27
 *
 * @copyright Copyright (C) 2015-2025 Alibaba Group Holding Limited
 *
 */

#ifndef _AIOT_FS_API_H_
#define _AIOT_FS_API_H_

#if defined(__cplusplus)
extern "C" {
#endif

#include <stdint.h>


/**
 * @brief 用以向SDK描述其运行硬件平台的资源如何使用的方法结构体
 */
typedef struct {
    /**
     * @brief 查询文件大小
     *
     * @return int32_t
     * @retval -1 文件不存在
     * @retval >=0 实际文件大小
     */
    int32_t (*file_size)(char *path);
    /**
     * @brief 删除文件
     *
     * @return int32_t
     * @retval 0 文件删除成功
     * @retval -1 文件修改失败
     */
    int32_t (*file_delete)(char *path);
    /**
     * @brief 写文件数据
     *
     * @details 如果文件不存在，则创建新文件
     * @return int32_t
     * @retval 成功，返回写入的文件长度
     * @retval 失败，返回-1
     */
    int32_t (*file_write)(char *path, uint32_t offset, uint8_t *data, uint32_t len);
    /**
     * @brief 写文件数据
     *
     * @details open操作需用户执行
     * @return int32_t
     * @retval 成功，返回读取到的文件长度
     * @retval 失败，返回-1
     */
    int32_t (*file_read)(char *path, uint32_t offset, uint8_t *data, uint32_t len);
} aiot_fs_t;

#if defined(__cplusplus)
}
#endif

#endif

