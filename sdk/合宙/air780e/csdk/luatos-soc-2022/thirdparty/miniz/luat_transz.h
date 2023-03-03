
#include "stdlib.h"
#include "stdint.h"

enum TZ_COMPRESS_MODE {
    TZ_COMPRESS_NONE = 0,
    TZ_COMPRESS_GZ   = 1
};

typedef struct luat_transz_cache
{
    const char *data_ptr; // 需指向luat_transz_data_t.datas, 如不相同,会禁用cache
    int   addr;           // luat_transz_read 函数自行维护的块地址,第一次传入时应该设置为-1
    char *buff; // 按实际block_size长度进行malloc
}luat_transz_cache_t;


typedef struct luat_transz_data
{
    size_t total_size;
    size_t block_size;
    size_t compress_mode;
    const char *fragments;
    const char *datas;
}luat_transz_data_t;


int luat_transz_read(luat_transz_data_t* data, uint8_t* buff, size_t offset, size_t len);

