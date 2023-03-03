
#include "common_api.h"

#include "fal.h"
#include "flashdb.h"


int am_kv_init(void);
int am_kv_del(const char* key);
int am_kv_set(const char* key, void* data, size_t len);
int am_kv_get(const char* key, void* data, size_t len);
int am_kv_clear(void);

