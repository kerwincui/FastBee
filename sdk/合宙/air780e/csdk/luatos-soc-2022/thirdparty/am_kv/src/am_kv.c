
#include "common_api.h"
#include "FreeRTOS.h"
#include "task.h"

#include "lfs_port.h"
#include "rng.h"
#include "lfs_util.h"
#include "flash_rt.h"

#include "mem_map.h"
#include DEBUG_LOG_HEADER_FILE
#include "osasys.h"
#include "plat_config.h"

#include "fal.h"
#include "flashdb.h"

struct fdb_kvdb* am_kvdb;
size_t am_kvdb_debug_mode = 0;

int am_kv_init(void)
{
    if (am_kvdb != NULL) {
        return 0;
    }
    am_kvdb = malloc(sizeof(struct fdb_kvdb));
    if (am_kvdb == NULL) {
        DBG("out of memory when malloc fdb_kvdb");
        return -1;
    }
    memset(am_kvdb, 0, sizeof(struct fdb_kvdb));
	fdb_err_t ret = fdb_kvdb_init(am_kvdb, "env", "onchip_fdb", NULL, NULL);
    DBG("fdb_kvdb_init ret %d", ret);
    return ret;
}

int am_kv_del(const char* key) {
	return fdb_kv_del(am_kvdb, key);
}

int am_kv_set(const char* key, void* data, size_t len) {
    if (am_kvdb == NULL) {
        DBG("am_kv NEED init!!!");
        return -1;
    }
	struct fdb_blob blob = {0};
	blob.buf = data;
	blob.size = len;
	int ret = fdb_kv_set_blob(am_kvdb, key, &blob);
    if (am_kvdb_debug_mode)
	    DBG("am_kv_set %s %p %d %d", key, data, len, ret);
	return ret;
}


int am_kv_get(const char* key, void* data, size_t len) {
    if (am_kvdb == NULL) {
        DBG("am_kv NEED init!!!");
        return -1;
    }
	struct fdb_blob blob = {0};
	blob.buf = data;
	blob.size = len;
	int ret = fdb_kv_get_blob(am_kvdb, key, &blob);
	if (am_kvdb_debug_mode)
	    DBG("am_kv_get %s %p %d %d", key, data, len, ret);
	return ret;
}

int am_kv_clear(void) {
    if (am_kvdb == NULL) {
        DBG("am_kv NEED init!!!");
        return -1;
    }
    fdb_kv_set_default(am_kvdb);
    return 0;
}
