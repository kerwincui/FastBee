#include "common_api.h"
void fdb_init(void)
{
    am_kv_init();
    char value[2];
    int ret = am_kv_get("flag", &value, 2);
    //读取kv数据库用户是否初始化过，如果没有，则写入一个flag和需要初始化的值，表示用户已初始化；如果用户初始化过，则不做任何操作
    DBG("get value result %d", ret);
    if (ret > 0)
    {
        DBG("get value %s", value);
        if(memcmp("1", value, strlen("1")))
        {
            DBG("need init");
            ret = am_kv_set("flag", "1", 2);
            DBG("init result1 %d", ret);
            int volume = 4;
            ret = am_kv_set("volume", &volume, 1);
        }
        else
        {
            DBG("no need init");
        }
    }
    else
    {
        ret = am_kv_set("flag", "1", 2);
        int volume = 4;
        ret = am_kv_set("volume", &volume, 1);
        DBG("init result2 %d", ret);
    }
}