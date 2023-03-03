/*
 * 这个例程用于用户在移植后验证是否移植成功的。
 * 通过一系列的测试case，验证移植的相关接口是否正常工作；
 *  + 正常结束后会输出TEST SUCCESS，其它会输出TEST ERROR + ERRORCODE
 *  + 如遇长时间卡住也为测试失败
 *
 * 该测试工具会使用多线程/多任务的能力，在RTOS下使用需要自行适配任务创建。
 * 需要用户关注或修改的部分, 已经用 TODO 在注释中标明
 *
 */

#include "aiot_sysdep_api.h"
#include "aiot_state_api.h"
#include <stdio.h>
#include <string.h>
#include <inttypes.h>

#define DEBUG_INFO(...) do{ printf("Line[%d]: ",__LINE__); printf(__VA_ARGS__); printf("\r\n");}while(0);
/* 定义入口函数类型 */
typedef void *(*TASK_FUNC)(void* argv);
/* 定义适配任务创建函数*/
void task_start(TASK_FUNC entry,void* argv);
/*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> TODO START >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/*
 * TODO: task_start功能实现，创建任务，并执行任务，待任务结束后自行退出
 * @param[in] entry  任务函数入口
 * @param[in] argv   任务函数参数
 */
#include<pthread.h>
void task_start(TASK_FUNC entry,void* argv)
{
    pthread_t id;
    pthread_create(&id, NULL, (void*(*)(void *))entry, argv);
}
/*TODO: 堆最大空间，单位字节 */
#define HEAP_MAX    ( 20 * 1024 )
/*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< TODO END <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/

/**
 * 系统接口测试结果
 */
typedef enum {
    TEST_SUCCESS,
    TEST_ERR_RANDOM,
    TEST_ERR_MALLOC,
    TEST_ERR_HEAP,
    TEST_ERR_SLEEP,
    TEST_ERR_MUTEX,
    TEST_ERR_NETWORK,
    TEST_ERR_GENERIC,
} sysdep_test_result_t;

static const char *result_string[] = {
    "TEST_SUCCESS", 
    "TEST_ERR_RANDOM",
    "TEST_ERR_MALLOC",
    "TEST_ERR_HEAP", 
    "TEST_ERR_SLEEP",
    "TEST_ERR_MUTEX",
    "TEST_ERR_NETWORK",
    "TEST_ERR_GENERIC",
};

typedef struct {
    aiot_sysdep_portfile_t *sysdep;
    void* user_data;
    char* name;
} task_handler_input_t;

/**
 * sysdep测试入口原型定义
 */
typedef sysdep_test_result_t (*sysdep_test_func)(aiot_sysdep_portfile_t* sysdep);

typedef struct
{
    uint32_t total_size;//堆总大小
} heap_cfg_t;

typedef struct
{
    uint16_t count;
    /* 最大重复次数 */
    uint16_t repeat_cnt_max;
} random_cfg_t;

typedef struct
{
    uint64_t sleep_ms;
    uint8_t  sleep_end;
} time_cfg_t;

typedef struct
{
    void* mutex;
    int32_t  value;
    uint32_t timeout_ms;
} mutex_cfg_t;

typedef struct
{
    char*       host;
    uint16_t    port;
    uint32_t    connect_timeout_ms;
    uint32_t    recv_timeout_ms;
    int32_t     recv_buf_len;
    uint32_t    send_timeout_ms;
    uint32_t    cycle_test_times;
} network_cfg_t;

/**
 * 随机生成随机数列表，重复出现次数不高于指定值
 */
static sysdep_test_result_t random_repeat_test(aiot_sysdep_portfile_t* sysdep, random_cfg_t* rd)
{
    typedef  uint8_t random_value_t;
    random_value_t *random_values = NULL;
    int count = 0;
    random_value_t temp = 0;
    sysdep_test_result_t ret = TEST_SUCCESS;
    /* 差值 */
    int diff = 0;
    /* 递变标志 */
    int flag = 0;

    random_values = sysdep->core_sysdep_malloc(sizeof(random_value_t) * rd->count, NULL);
    if(random_values == NULL){
        DEBUG_INFO("\r\nmalloc fail");
        ret = TEST_ERR_MALLOC;
        goto end;
    }
    memset(random_values, 0, sizeof(random_value_t) * rd->count);

    /* 生成随机数，并统计重复次数 计算差值*/
    for(count = 0; count < rd->count; count++) {
        sysdep->core_sysdep_rand((uint8_t*)&temp, sizeof(random_value_t));
        temp %= rd->count;
        
        /* 检测是否为规律递变 */
        if(count == 1 ){
            diff = random_values[count] - random_values[count - 1];
        }else if (count >= 2){
            if(diff == random_values[count] - random_values[count - 1]){
                flag++;
            }
        }
        
        if(random_values[temp] <= rd->repeat_cnt_max) {
            random_values[temp]++;
        }
        else {
            DEBUG_INFO("randowm value [%d] times [%d] over max counter [%d]", temp, random_values[temp], rd->repeat_cnt_max);
            ret = TEST_ERR_RANDOM;
            goto end;
        }
    }
    /* 规律递变则返回错误 */
    if(rd->count >= 3 && flag >= rd->count - 2){
        DEBUG_INFO("random value error");
        ret = TEST_ERR_RANDOM;
        goto end;
    }
    ret = TEST_SUCCESS;
end:
    if(random_values != NULL){
        sysdep->core_sysdep_free(random_values);
    }
    return ret;
}

/**
 * 随机数测试入口
 */
sysdep_test_result_t random_test(aiot_sysdep_portfile_t* sysdep)
{
    random_cfg_t rd;
    /* 随机数接口要求生成的随机数按字节随机 */
    rd.count = 256;
    /* 随机数重复次数不能超过该值 */
    rd.repeat_cnt_max = 10;
    return random_repeat_test(sysdep, &rd);
}

static sysdep_test_result_t heap_malloc_max_test(aiot_sysdep_portfile_t* sysdep, heap_cfg_t* hp)
{
    /**
     * 最大空间申请、释放
     */
    uint32_t user_malloc_max = hp->total_size - 100;
    void * ptr = sysdep->core_sysdep_malloc(user_malloc_max, "");
    if(ptr == NULL) {
        DEBUG_INFO("malloc error");
        return TEST_ERR_MALLOC;
    }
    /* 空间读写测试 */
    uint8_t read_value;
    for(int i = 0; i < user_malloc_max; i++) {
        ((uint8_t*)ptr)[i] = (uint8_t)i;
        read_value = ((uint8_t*)ptr)[i];
        if(read_value != (uint8_t)i) {
            sysdep->core_sysdep_free(ptr);
            DEBUG_INFO("heap read and write fail");
            return TEST_ERR_MALLOC;
        }
    }
    sysdep->core_sysdep_free(ptr);
    return TEST_SUCCESS;
}

/**
 *  堆回收测试
 */
static sysdep_test_result_t heap_recycle_test(aiot_sysdep_portfile_t* sysdep, heap_cfg_t* hp)
{
    /* 待申请的堆空间大小 */
    const uint32_t size_list[]= {1,2,4,8,16,32,64,128,256,512,1024,10*1024,100*1024,1024*1024};
    /* 存储堆指针 */
    void* malloc_list[sizeof(size_list) / sizeof(uint32_t)] = {NULL};
    int malloc_list_size = sizeof(size_list) / sizeof(uint32_t);
    /* 申请空间 */
    int malloc_cnt = 0;
    int i = 0;
    for(i = 0; i < malloc_list_size; i++) {
        malloc_list[i] = sysdep->core_sysdep_malloc(size_list[i], "");
        if(malloc_list[i] == NULL) {
            break;
        }
    }
    malloc_cnt = i;
    /**
     * 非相邻空间释放
     */
    for(i = 0; i < malloc_cnt; i+=2) {
        sysdep->core_sysdep_free(malloc_list[i]);
    }
    for(i = 1; i < malloc_cnt; i+=2) {
        sysdep->core_sysdep_free(malloc_list[i]);
    }
    /**
     * 最后申请最大空间
     */
    return heap_malloc_max_test(sysdep, hp);
}

/**
 * 堆测试入口
 */

sysdep_test_result_t heap_test(aiot_sysdep_portfile_t* sysdep)
{
    sysdep_test_result_t ret = TEST_SUCCESS;
    heap_cfg_t hp;
    hp.total_size = HEAP_MAX;
    ret = heap_malloc_max_test(sysdep,&hp);
    if(ret != TEST_SUCCESS) {
        return ret;
    }
    return heap_recycle_test(sysdep, &hp);
}

static sysdep_test_result_t network_tcp_test(aiot_sysdep_portfile_t* sysdep, network_cfg_t* cfg)
{
    void* network_hd = sysdep->core_sysdep_network_init();
    core_sysdep_socket_type_t type = CORE_SYSDEP_SOCKET_TCP_CLIENT;
    sysdep->core_sysdep_network_setopt(network_hd, CORE_SYSDEP_NETWORK_SOCKET_TYPE, &type);
    sysdep->core_sysdep_network_setopt(network_hd, CORE_SYSDEP_NETWORK_HOST, cfg->host);
    sysdep->core_sysdep_network_setopt(network_hd, CORE_SYSDEP_NETWORK_PORT, (void*)&cfg->port);
    sysdep->core_sysdep_network_setopt(network_hd, CORE_SYSDEP_NETWORK_CONNECT_TIMEOUT_MS, &cfg->connect_timeout_ms);

    /**
     * 建连测试
    */
    if(0 != sysdep->core_sysdep_network_establish(network_hd)) {
        DEBUG_INFO("network establish test error:%d", TEST_ERR_NETWORK);
        return TEST_ERR_NETWORK;
    }

    /**
     * 接收等待超时测试
    */
    char* buf = sysdep->core_sysdep_malloc(cfg->recv_buf_len + 1, "");
    if(buf == NULL){
        DEBUG_INFO("malloc fail");
        return TEST_ERR_MALLOC;
    }
    uint64_t start = sysdep->core_sysdep_time();
    sysdep->core_sysdep_network_recv(network_hd, (uint8_t*)buf, cfg->recv_buf_len, cfg->recv_timeout_ms, NULL);
    uint64_t stop = sysdep->core_sysdep_time();
    if(stop - start < cfg->recv_timeout_ms) {
        DEBUG_INFO("network receive test error:%d, start [%"PRIu64"], end [%"PRIu64"]", TEST_ERR_NETWORK, start, stop);
        return TEST_ERR_NETWORK;
    }

    /**
     * 通过Http Get请求来验证TCP是否工作正常
    */
    char* http_get = "GET / HTTP/1.1\r\n"\
                     "Host: www.aliyun.com\r\n"\
                     "Connection: keep-alive\r\n"\
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36\r\n"\
                     "Origin: https://www.aliyun.com\r\n"\
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9\r\n"\
                     "\r\n";
                     
    int32_t send_len = strlen(http_get);
    int32_t send_result = sysdep->core_sysdep_network_send(network_hd, (uint8_t*)http_get, send_len, cfg->send_timeout_ms, NULL);
    if(send_result != send_len) {
        DEBUG_INFO("network send length test error:%d, send [%d], result [%d]", TEST_ERR_NETWORK, send_len, send_result);
        return TEST_ERR_NETWORK;
    }

    int32_t buf_len = 0;
    uint8_t byte_read;
    int32_t content_len = 0;
    int32_t ret;
    char* str_ptr = NULL;
    char* target_str = "Content-Length:";
    int state = 0;
    while(1) {
        ret = sysdep->core_sysdep_network_recv(network_hd, (uint8_t*)&byte_read, 1, cfg->recv_timeout_ms, NULL);
        /* 需支持按字节读取 */
        if(ret == 1) {
            if(state == 0) {
                /* 提取一行 */
                buf[buf_len++] = byte_read;
                if(byte_read != '\n') {
                    continue;
                }
                buf[buf_len] = '\0';
                /*空行表示header结束*/
                if(buf_len == 2 && buf[0] == '\r' && buf[1] == '\n') {
                    state = 1;
                    buf_len = 0;
                    continue;
                }
                /*搜索应答长度*/
                str_ptr = strstr(buf,target_str);
                if(str_ptr == NULL) {
                    buf_len = 0;
                    continue;
                }
                str_ptr += strlen(target_str);
                if(str_ptr >= &buf[buf_len]) {
                    buf_len = 0;
                    continue;
                }
                if( 1 == sscanf(str_ptr,"%d",&content_len)) {
                    buf_len = 0;
                }
            } else {
                buf[buf_len++] = byte_read;
            }
        }
        else {
            break;
        }
    }
    sysdep->core_sysdep_network_deinit(&network_hd);
    sysdep->core_sysdep_free(buf);
    buf = NULL;
    if(network_hd != NULL){
        DEBUG_INFO("network deinit error");
        return TEST_ERR_NETWORK;
    }
    /* http的正文长度校验 */
    if(buf_len == 0 || buf_len != content_len) {
        DEBUG_INFO("[NETWORK_TEST.RECV] test error:%d, send [%d], result [%d]", TEST_ERR_NETWORK, buf_len, content_len);
        return TEST_ERR_NETWORK;
    } else {
        DEBUG_INFO("[NETWORK_TEST.RECV] test success");
        return TEST_SUCCESS;
    }
}

sysdep_test_result_t network_tcp_cycle_test(aiot_sysdep_portfile_t* sysdep, network_cfg_t* cfg)
{
    void* network_hd =  NULL;
    int count = cfg->cycle_test_times;
    while(count-- > 0) {
        network_hd = sysdep->core_sysdep_network_init();
        if(network_hd == NULL) {
            DEBUG_INFO("network tcp init test error");
            return TEST_ERR_NETWORK;
        }
        core_sysdep_socket_type_t type = CORE_SYSDEP_SOCKET_TCP_CLIENT;
        sysdep->core_sysdep_network_setopt(network_hd, CORE_SYSDEP_NETWORK_SOCKET_TYPE, &type);
        sysdep->core_sysdep_network_setopt(network_hd, CORE_SYSDEP_NETWORK_HOST, cfg->host);
        sysdep->core_sysdep_network_setopt(network_hd, CORE_SYSDEP_NETWORK_PORT, (void*)&cfg->port);
        sysdep->core_sysdep_network_setopt(network_hd, CORE_SYSDEP_NETWORK_CONNECT_TIMEOUT_MS, &cfg->connect_timeout_ms);

        if(0 != sysdep->core_sysdep_network_establish(network_hd)) {
            DEBUG_INFO("network tcp establish test error:%d", TEST_ERR_NETWORK);
            return TEST_ERR_NETWORK;
        }
        sysdep->core_sysdep_network_deinit(&network_hd);
    }
    if( TEST_SUCCESS != heap_test(sysdep) ) {
        DEBUG_INFO("network deinit then heap test error:%d", TEST_ERR_NETWORK);
        return TEST_ERR_NETWORK;
    } else {
        return TEST_SUCCESS;
    }
}

static sysdep_test_result_t network_tcp_send_length_test(aiot_sysdep_portfile_t* sysdep, network_cfg_t* cfg)
{
    sysdep_test_result_t ret = TEST_SUCCESS;
    void* network_hd = sysdep->core_sysdep_network_init();

    core_sysdep_socket_type_t type = CORE_SYSDEP_SOCKET_TCP_CLIENT;
    sysdep->core_sysdep_network_setopt(network_hd, CORE_SYSDEP_NETWORK_SOCKET_TYPE, &type);
    sysdep->core_sysdep_network_setopt(network_hd, CORE_SYSDEP_NETWORK_HOST, cfg->host);
    sysdep->core_sysdep_network_setopt(network_hd, CORE_SYSDEP_NETWORK_PORT, (void*)&cfg->port);
    sysdep->core_sysdep_network_setopt(network_hd, CORE_SYSDEP_NETWORK_CONNECT_TIMEOUT_MS, &cfg->connect_timeout_ms);

    /**
     * 建连测试
    */
    if(0 != sysdep->core_sysdep_network_establish(network_hd)) {
        DEBUG_INFO("network establish test error:%d", TEST_ERR_NETWORK);
        return TEST_ERR_NETWORK;
    }
    /**
     * 通过Http Get请求来验证TCP发送接口是否具备长包发送能力
    */
    const char* http_get = "GET / HTTP/1.1\r\n"\
                     "Host: www.aliyun.com\r\n"\
                     "Connection: keep-alive\r\n"\
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36\r\n"\
                     "Origin: https://www.aliyun.com\r\n"\
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9\r\n"\
                     "\r\n"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,"\
                     "invalid test append data,invalid test append data,invalid test append data,invalid test append data,";
                                 
    int32_t send_len = strlen(http_get);
    int32_t send_result = sysdep->core_sysdep_network_send(network_hd, (uint8_t*)http_get, send_len, cfg->send_timeout_ms, NULL);
    if(send_result != send_len) {
        DEBUG_INFO("network send length test error:%d, send [%d], result [%d]", TEST_ERR_NETWORK, send_len, send_result);
        ret = TEST_ERR_NETWORK;
    }
    sysdep->core_sysdep_network_deinit(&network_hd);
    return ret;
}


sysdep_test_result_t network_test(aiot_sysdep_portfile_t* sysdep)
{
    sysdep_test_result_t ret;
    sysdep->core_sysdep_sleep(100);

    network_cfg_t cfg;
    cfg.host = "www.aliyun.com";
    cfg.port = 80;
    cfg.connect_timeout_ms = 5000;
    cfg.recv_timeout_ms = 5000;
    cfg.recv_buf_len = 1024;
    cfg.send_timeout_ms = 5000;
    cfg.cycle_test_times = 10;

    ret = network_tcp_test(sysdep, &cfg);
    if(ret != TEST_SUCCESS) {
        return ret;
    }

    ret = network_tcp_send_length_test(sysdep,&cfg);
    if(ret != TEST_SUCCESS){
        return ret;
    }
    ret = network_tcp_cycle_test(sysdep, &cfg);
    return ret;
}

static void *enter_sleep(void* user_data)
{
    task_handler_input_t* user = (task_handler_input_t*)user_data;
    time_cfg_t* tm = user->user_data;

    DEBUG_INFO("%s enter wanna sleep: %"PRIu64"ms", user->name, tm->sleep_ms);
    user->sysdep->core_sysdep_sleep(tm->sleep_ms);

    tm->sleep_end = 1;
    return 0;
}

sysdep_test_result_t time_sleep_test(aiot_sysdep_portfile_t* sysdep)
{
    uint64_t start,stop;
    time_cfg_t time_cfg;
    sysdep_test_result_t ret= TEST_SUCCESS;
    time_cfg_t* sleep1 = NULL;
    time_cfg_t* sleep2 = NULL;
    task_handler_input_t input1;
    task_handler_input_t input2;
    int64_t wait_total;
    uint64_t temp;

    time_cfg.sleep_ms = 30 * 1000;
    DEBUG_INFO("sleep %llu ms test",(long long unsigned int)time_cfg.sleep_ms);
    start = sysdep->core_sysdep_time();
    sysdep->core_sysdep_sleep(time_cfg.sleep_ms);
    stop = sysdep->core_sysdep_time();

    /* 睡眠异常 */
    if(stop - start < time_cfg.sleep_ms) {
        DEBUG_INFO("sleep test error: %d",TEST_ERR_SLEEP);
        ret = TEST_ERR_SLEEP;
        goto end;
    }

    /* 睡眠时间超过10% */
    if(stop - start > (uint64_t)(time_cfg.sleep_ms * 1.1)) {
        DEBUG_INFO("sleep test error: %d",TEST_ERR_SLEEP);
        ret = TEST_ERR_SLEEP;
        goto end;
    }

    /**
     * 并发睡眠测试，两个并发睡眠消耗的时间应小于两次睡眠时间之和
    */
    sleep1 = sysdep->core_sysdep_malloc(sizeof(time_cfg_t),"");
    sleep2 = sysdep->core_sysdep_malloc(sizeof(time_cfg_t),"");
    if(sleep1 == NULL || sleep2 == NULL){
        ret = TEST_ERR_SLEEP;
        goto end;
    }

    sleep1->sleep_ms = 10 * 1000;
    sleep1->sleep_end = 0;
    sleep2->sleep_ms = 10 * 1000;
    sleep2->sleep_end = 0;

    input1.name = "sleep_test_task_1";
    input1.sysdep = sysdep;
    input1.user_data = sleep1;

    input2.name = "sleep_test_task_2";
    input2.sysdep = sysdep;
    input2.user_data = sleep2;

    start = sysdep->core_sysdep_time();
    task_start(enter_sleep,&input1);
    task_start(enter_sleep,&input2);

    /**
     * 等待睡眠结束
    */
    wait_total = sleep1->sleep_ms + sleep2->sleep_ms + 100;
    while((sleep1->sleep_end == 0 || sleep2->sleep_end == 0) && wait_total-- > 0) {
        sysdep->core_sysdep_sleep(1);
    }

    /**
     * 检查所有线程是否都退出
    */
    while (sleep1->sleep_end == 0 || sleep2->sleep_end == 0){
        sysdep->core_sysdep_sleep(1);
    }

    /* 两个线程应该在规定时间内退出 */
    if(wait_total < 0) {
        DEBUG_INFO("concurrent sleep test error: wait sleep timeout fail");
        ret = TEST_ERR_SLEEP;
        goto end;
    }

    /* 总睡眠时间应小于各睡眠时间之和 */
    stop = sysdep->core_sysdep_time();
    temp = sleep1->sleep_ms + sleep2->sleep_ms;
    if(stop - start >= temp) {
        DEBUG_INFO("sleep %"PRIu64"ms start:[%"PRIu64"] stop:[%"PRIu64"]\r\n unexpected ", sleep1->sleep_ms, start, stop);
        ret = TEST_ERR_SLEEP;
    }
    else {
        DEBUG_INFO("sleep %"PRIu64"ms start:[%"PRIu64"] stop:[%"PRIu64"] expected ", sleep1->sleep_ms, start, stop);
        ret = TEST_SUCCESS;
    }
end:
    if(sleep1 != NULL)
        sysdep->core_sysdep_free(sleep1);
    if(sleep2 != NULL)
        sysdep->core_sysdep_free(sleep2);
    return ret;
}

static void* mutex_synchronize_test(void* user_data)
{
    task_handler_input_t* input = (task_handler_input_t*)user_data;
    mutex_cfg_t* cfg = input->user_data;
    while(1) {
        input->sysdep->core_sysdep_mutex_lock(cfg->mutex);
        if(cfg->value < 0) {
            input->sysdep->core_sysdep_mutex_unlock(cfg->mutex);
            break;
        }
        cfg->value++;
        input->sysdep->core_sysdep_mutex_unlock(cfg->mutex);
        input->sysdep->core_sysdep_sleep(cfg->timeout_ms);
    }
    return NULL;
}

/**
 * 互斥锁测试
*/
sysdep_test_result_t mutex_test(aiot_sysdep_portfile_t* sysdep)
{
    sysdep_test_result_t ret;
    void* mutex = NULL;
    mutex_cfg_t *mutex_cfg_2 = NULL;
    task_handler_input_t *input_1 = NULL;
    task_handler_input_t *input_2 = NULL;
    int32_t wait_ms = 3000;
    /**
     * 互斥锁申请释放及内存泄漏测试
    */
    for(int i = 0; i < 1000; i++) {
        mutex = sysdep->core_sysdep_mutex_init();
        sysdep->core_sysdep_mutex_lock(mutex);
        sysdep->core_sysdep_mutex_unlock(mutex);
        sysdep->core_sysdep_mutex_deinit(&mutex);
    }
    if( TEST_SUCCESS != heap_test(sysdep)) {
        DEBUG_INFO("[MUTEX_TEST.CYCLE] test failed\r\n");
        return ret = TEST_ERR_MUTEX;
    }

    /**
     * 互斥锁功能测试
    */
    mutex_cfg_t *mutex_cfg_1 = sysdep->core_sysdep_malloc(sizeof(mutex_cfg_t), "");
    if(mutex_cfg_1 == NULL) {
        DEBUG_INFO("mutex test but malloc fail");
        ret = TEST_ERR_MUTEX;
        goto end;
    }
    mutex_cfg_1->mutex = sysdep->core_sysdep_mutex_init();
    if(mutex_cfg_1->mutex == NULL) {
        ret = TEST_ERR_MALLOC;
        DEBUG_INFO("[MUTEX_TEST]malloc fail:%d", ret);
        goto end;
    }
    input_1 = sysdep->core_sysdep_malloc(sizeof(task_handler_input_t), "");
    if(input_1 == NULL){
        DEBUG_INFO("mutex test but malloc fail");
        ret = TEST_ERR_MALLOC;
        goto end;
    }
    input_1->name = "mutex_test_task1";
    input_1->sysdep = sysdep;
    input_1->user_data = mutex_cfg_1;
    mutex_cfg_1->timeout_ms = 100;
    mutex_cfg_1->value = 0;
    task_start(mutex_synchronize_test,input_1);

    mutex_cfg_2 = sysdep->core_sysdep_malloc(sizeof(mutex_cfg_t), "");
    if(mutex_cfg_2 == NULL) {
        ret = TEST_ERR_MALLOC;
        DEBUG_INFO("[MUTEX_TEST]malloc fail:%d", ret);
        goto end;
    }
    mutex_cfg_2->mutex = sysdep->core_sysdep_mutex_init();
    if(mutex_cfg_2->mutex == NULL) {
        ret = TEST_ERR_MALLOC;
        DEBUG_INFO("[MUTEX_TEST]malloc fail:%d", ret);
        goto end;
    }
    input_2 = sysdep->core_sysdep_malloc(sizeof(task_handler_input_t), "");
    input_2->name = "mutex_test_task2";
    input_2->sysdep = sysdep;
    input_2->user_data = mutex_cfg_2;
    mutex_cfg_2->timeout_ms = 100;
    mutex_cfg_2->value = 0;

    task_start(mutex_synchronize_test,input_2);

    sysdep->core_sysdep_sleep(wait_ms);
    /**
     * 对mutex_cfg_1->mutex加锁，mutex_test_task1会被锁住，mutex_cfg_1->value应该不会发生变化
    */
    int32_t v1,v2;
    DEBUG_INFO("mutex lock task1, unlock task2 %d ms", wait_ms);
    sysdep->core_sysdep_mutex_lock(mutex_cfg_1->mutex);

    v1 = mutex_cfg_1->value;
    v2 = mutex_cfg_2->value;

    sysdep->core_sysdep_sleep(wait_ms);

    int32_t v1_,v2_;
    v1_ = mutex_cfg_1->value;
    v2_ = mutex_cfg_2->value;
    DEBUG_INFO("task1 value [%d --> %d], task2 value [%d --> %d] ", v1, v1_, v2, v2_);
    if(v1 != v1_ || v2 == v2_) {
        DEBUG_INFO("mutex test failed ");
        ret = TEST_ERR_MUTEX;
        goto end;
    }
    sysdep->core_sysdep_mutex_unlock(mutex_cfg_1->mutex);


    /**
     * 对mutex_cfg_2->mutex加锁，mutex_test_task2会被锁住，mutex_cfg_2->value应该不会发生变化
    */
    DEBUG_INFO("unlock task1, lock task2 %d ms", wait_ms);
    sysdep->core_sysdep_mutex_lock(mutex_cfg_2->mutex);
    v1 = mutex_cfg_1->value;
    v2 = mutex_cfg_2->value;

    sysdep->core_sysdep_sleep(wait_ms);

    v1_ = mutex_cfg_1->value;
    v2_ = mutex_cfg_2->value;

    DEBUG_INFO("task1 value [%d --> %d], task2 value [%d --> %d] ", v1, v1_, v2, v2_);
    if(v1 == v1_ || v2 != v2_) {
        DEBUG_INFO("mutex test failed");
        ret = TEST_ERR_MUTEX;
        goto end;
    }
    sysdep->core_sysdep_mutex_unlock(mutex_cfg_2->mutex);

    /**
     * mutex_cfg_2->mutex不加锁，mutex_cfg_1->mutex不加锁，对应value应该正常变化
    */
    DEBUG_INFO("unlock task1, lock task2 %d ms\r\n", wait_ms);
    v1 = mutex_cfg_1->value;
    v2 = mutex_cfg_2->value;
    sysdep->core_sysdep_sleep(wait_ms);
    v1_ = mutex_cfg_1->value;
    v2_ = mutex_cfg_2->value;
    DEBUG_INFO("task1 value [%d --> %d], task2 value [%d --> %d]\r\n", v1, v1_, v2, v2_);
    if(v1 == v1_ || v2 == v2_) {
        DEBUG_INFO("[MUTEX_TEST.UNLOCK] test failed \r\n");
        ret = TEST_ERR_MUTEX;
        goto end;
    }
end:
    /**
     * 线程退出，回归
    */
    if(mutex_cfg_1 != NULL) {
        mutex_cfg_1->value = -10;
        sysdep->core_sysdep_sleep(500);
        if(mutex_cfg_1->mutex != NULL){
            sysdep->core_sysdep_mutex_deinit(&(mutex_cfg_1->mutex));
        }

        sysdep->core_sysdep_free(mutex_cfg_1);
    }
    
    if(mutex_cfg_2 != NULL){
        mutex_cfg_2->value = -10;
        sysdep->core_sysdep_sleep(500);
        if(mutex_cfg_2->mutex != NULL){
            sysdep->core_sysdep_mutex_deinit(&(mutex_cfg_2->mutex));
        }
        sysdep->core_sysdep_free(mutex_cfg_2);
    }

    if(input_1 != NULL){
        sysdep->core_sysdep_free(input_1);
    }
    if(input_2 != NULL){
        sysdep->core_sysdep_free(input_2);
    }

    return TEST_SUCCESS;
}

typedef struct {
    char*            name;
    sysdep_test_func func;
} sysdep_test_suite;

/**
 * 测试项列表
 */
sysdep_test_suite test_list[]= {
    {"RANDOM_TEST ", random_test},
    {"HEAP_TEST   ", heap_test},
    {"TIME_TEST   ", time_sleep_test},
    {"NETWORK_TEST", network_test},
    {"MUTEX_TEST  ", mutex_test},
};

/**
 * sysdep的接口实现，包含系统时间、内存管理、网络、锁、随机数、等接口实现
 */
extern aiot_sysdep_portfile_t g_aiot_sysdep_portfile;

int main(int argc, char *argv[])
{
    aiot_sysdep_portfile_t *sysdep = &g_aiot_sysdep_portfile;
    int32_t size = sizeof(test_list) / sizeof(test_list[0]);
    sysdep_test_result_t ret = TEST_SUCCESS;
    DEBUG_INFO("TOTAL TEST START");
    for(int32_t i = 0; i < size; i++) {
        DEBUG_INFO("TEST [%d/%d] [%s] .....................................[START]", i + 1, size, test_list[i].name);
        ret = (test_list[i].func)(sysdep);
        if(TEST_SUCCESS != ret) {
            DEBUG_INFO("TEST [%d/%d] [%s] .....................................[FAILED] [%s]", i + 1, size, test_list[i].name, result_string[ret]);
            break;
        } else {
            DEBUG_INFO("TEST [%d/%d] [%s] .....................................[SUCCESS]", i + 1, size, test_list[i].name);
        }
    }
    if(ret == TEST_SUCCESS) {
        DEBUG_INFO("TOTAL TEST SUCCESS");
    } else {
        DEBUG_INFO("TOTAL TEST FAILED %s", result_string[ret]);
    }
    return 0;
}
