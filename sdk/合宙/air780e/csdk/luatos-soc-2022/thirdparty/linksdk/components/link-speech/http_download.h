#ifndef _HTTP_DOWNLOAD_H_
#define _HTTP_DOWNLOAD_H_

#if defined(__cplusplus)
extern "C" {
#endif

#include <stdint.h>

#define      HTTP_DOWNLOAD_ERR_URL_INVALID        -0x8001
#define      HTTP_DOWNLOAD_ERR_UNKOWN             -0x8002
#define      HTTP_DOWNLOAD_ERR_FETCH_FAILED       -0x8003
#define      HTTP_DOWNLOAD_ERR_CHECKSUM_MISMATCH  -0x8004

/**
 * @brief 文件下载的额外参数
 */
typedef struct {
    /* 文件区间下载，起始偏移地址, 默认为0 */
    uint32_t range_start;
    /* 文件区间下载，终止偏移地址，如若不设置，置为0即可 */
    uint32_t range_end;
    /* 1: 使用https下载  0:使用http下载，默认为0 */
    int32_t https_enable;
} http_download_params_t;

/**
 * @brief 文件数据保存回调函数类型定义
 * @details
 *      文件正常保存时，返回写入的数据长度
 *      文件保存异常时，返回-1, 会中断下载流程
 */
typedef int32_t (*file_save_func_t)(uint32_t offset, uint8_t *data, uint32_t data_len, void *userdata);


/**
 * @brief http下载文件
 *
 * @param[in] url 文件下载地址
 * @param[in] extra_params 其它扩展参数，没有时可填NULL
 * @param[in] save_func 文件数据保存回调函数
 * @param[in] userdata 执行回调时返回的用户指针
 *
 * @return http_download_result_t
 * @retval <HTTP_DOWNLOAD_SUCCESS  执行失败
 * @retval HTTP_DOWNLOAD_SUCCESS   执行成功
 */
int32_t core_http_download_request(char *url, http_download_params_t *extra_params, file_save_func_t save_func, void* userdata);

#if defined(__cplusplus)
}
#endif

#endif /* #ifndef _CORE_HTTP_H_ */