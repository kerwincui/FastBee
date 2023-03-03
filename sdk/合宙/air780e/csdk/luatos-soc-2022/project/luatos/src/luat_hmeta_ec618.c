#include "luat_base.h"
#include "luat_hmeta.h"

extern int soc_get_model_name(char *model);

int luat_hmeta_model_name(char* buff) {
    soc_get_model_name(buff);
    return 0;
}
