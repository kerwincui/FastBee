#include "luat_base.h"
#include "luat_wdt.h"


int luat_wdt_setup(size_t timeout);

int luat_wdt_init(size_t timeout) {
    return luat_wdt_setup(timeout);
}
