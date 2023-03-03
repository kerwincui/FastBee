/*
 * Copyright (c) 2022 OpenLuat & AirM2M
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


#include "common_api.h"

#include "luat_base.h"
#include "luat_debug.h"
#include "luat_kv.h"
#include "fal.h"
#include "flashdb.h"

struct fdb_kvdb* luat_kvdb;
size_t luat_kvdb_debug_mode = 0;

int luat_kv_init(void)
{
    if (luat_kvdb != NULL) {
        return 0;
    }
    luat_kvdb = malloc(sizeof(struct fdb_kvdb));
    if (luat_kvdb == NULL) {
        LUAT_DEBUG_PRINT("out of memory when malloc fdb_kvdb");
        return -1;
    }
    memset(luat_kvdb, 0, sizeof(struct fdb_kvdb));
	fdb_err_t ret = fdb_kvdb_init(luat_kvdb, "env", "onchip_fdb", NULL, NULL);
    LUAT_DEBUG_PRINT("fdb_kvdb_init ret %d", ret);
    return ret;
}

int luat_kv_del(const char* key) {
    if (luat_kvdb == NULL) {
        LUAT_DEBUG_PRINT("luat_kv NEED init!!!");
        return -1;
    }
	return fdb_kv_del(luat_kvdb, key);
}

int luat_kv_set(const char* key, void* data, size_t len) {
    if (luat_kvdb == NULL) {
        LUAT_DEBUG_PRINT("luat_kv NEED init!!!");
        return -1;
    }
	struct fdb_blob blob = {0};
	blob.buf = data;
	blob.size = len;
	int ret = fdb_kv_set_blob(luat_kvdb, key, &blob);
    if (luat_kvdb_debug_mode)
	    LUAT_DEBUG_PRINT("luat_kv_set %s %p %d %d", key, data, len, ret);
	return ret;
}


int luat_kv_get(const char* key, void* data, size_t len) {
    if (luat_kvdb == NULL) {
        LUAT_DEBUG_PRINT("luat_kv NEED init!!!");
        return -1;
    }
	struct fdb_blob blob = {0};
	blob.buf = data;
	blob.size = len;
	int ret = fdb_kv_get_blob(luat_kvdb, key, &blob);
	if (luat_kvdb_debug_mode)
	    LUAT_DEBUG_PRINT("luat_kv_get %s %p %d %d", key, data, len, ret);
	return ret;
}

int luat_kv_clear(void) {
    if (luat_kvdb == NULL) {
        LUAT_DEBUG_PRINT("luat_kv NEED init!!!");
        return -1;
    }
    fdb_kv_set_default(luat_kvdb);
    return 0;
}
