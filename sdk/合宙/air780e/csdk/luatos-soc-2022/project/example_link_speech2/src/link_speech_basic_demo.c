#include "common_api.h"
#include <stdio.h>
#include <string.h>
// #include <unistd.h>
// #include <pthread.h>
// #include <sys/stat.h>
// #include <dirent.h>
// #include <stdlib.h>
#include "aiot_state_api.h"
#include "aiot_sysdep_api.h"
#include "aiot_mqtt_api.h"
#include "aiot_linkspeech_api.h"
#include "aiot_fs_api.h"

#include "luat_mobile.h"
#include "bsp_custom.h"
#include "luat_rtos.h"
#include "luat_audio_play_ec618.h"
#include "luat_i2s_ec618.h"
#include "luat_gpio.h"
#include "luat_debug.h"

static luat_rtos_semaphore_t audio_semaphore_handle;
/* TODO: 替换为自己设备的三元组 */
char *product_key       = "${YourProductKey}";
char *device_name       = "${YourDeviceName}";
char *device_secret     = "${YourDeviceSecret}";

char  *host = "${YourProductKey}.iot-as-mqtt.cn-shanghai.aliyuncs.com";
uint16_t port = 443;

/* 位于portfiles/aiot_port文件夹下的系统适配函数集合 */
extern aiot_sysdep_portfile_t g_aiot_sysdep_portfile;
    luat_rtos_task_handle linkspeech_init_task_handle;
/* 位于external/ali_ca_cert.c中的服务器证书 */
extern const char *ali_ca_cert;

static luat_rtos_task_handle g_mqtt_process_thread;
static luat_rtos_task_handle g_mqtt_recv_thread;
static uint8_t g_mqtt_process_thread_running = 0;
static uint8_t g_mqtt_recv_thread_running = 0;
static luat_rtos_task_handle g_linkspeech_thread;

typedef struct play_info {
    char filename[128];
    play_param_t *ext_params;
} play_info_t;
/* 音频播放信息，由千里传音模块在回调中赋值 */
play_info_t *g_play_info = NULL;

luat_rtos_mutex_t player_mutex;

int32_t file_size(char *path) {
    // struct stat st;
    // return 0 == stat(path, &st) ? st.st_size : -1;
    size_t filesize = luat_fs_fsize(path);
    return filesize >= 0 ? filesize : -1;
}

int32_t file_delete(char *path) {
    return luat_fs_remove(path);
}

uint8_t g_s_is_link_up = 0;


int32_t file_write(char *path, uint32_t offset, uint8_t *data, uint32_t len)
{
    int32_t res = -1;
    /* 以读/写方式打开一个二进制文件，允许读或在文件末追加数据。*/
    FILE* f = luat_fs_fopen(path, "ab+");
    if (f == NULL) {
        return -1;
    }

    // if(0 != luat_fs_fseek(f, offset, SEEK_SET)) {
    //     luat_fs_fclose(f);
    //     return -1;
    // }

    res = luat_fs_fwrite(data, len, 1, f);
    luat_fs_fclose(f);
    return res;
}

int32_t file_read(char *path, uint32_t offset, uint8_t *data, uint32_t len)
{
    int32_t res = -1;
    FILE* f = luat_fs_fopen(path, "rb");
    if (f == NULL) {
        return -1;
    }

    if(0 != luat_fs_fseek(f, offset, SEEK_SET)) {
        luat_fs_fclose(f);
        return -1;
    }

    res = luat_fs_fread(data, 1, len, f);
    luat_fs_fclose(f);
    return res;
}

aiot_fs_t posix_fs = {
    .file_size = file_size,
    .file_delete = file_delete,
    .file_write = file_write,
    .file_read = file_read,
};

void player(const char *filename, play_param_t *params)
{
    LUAT_DEBUG_PRINT("this is filename %s %d %d", filename, luat_fs_fexist(filename), luat_fs_fsize(filename));
    luat_rtos_mutex_lock(player_mutex, LUAT_WAIT_FOREVER);
    if(g_play_info != NULL) {
        luat_rtos_mutex_unlock(player_mutex);
        return;
    }

    g_play_info = malloc(sizeof(play_info_t));
    memset(g_play_info, 0, sizeof(play_info_t));
    if(strlen(filename) > sizeof(g_play_info->filename)) {
        luat_rtos_mutex_unlock(player_mutex);
        return;
    }
    memcpy(g_play_info->filename, filename, strlen(filename));
    g_play_info->ext_params = params;
    luat_rtos_mutex_unlock(player_mutex);
}

/* TODO: 如果要关闭日志, 就把这个函数实现为空, 如果要减少日志, 可根据code选择不打印
 *
 * 上面这条日志的code就是0317(十六进制), code值的定义见core/aiot_state_api.h
 *
 */

/* 日志回调函数, SDK的日志会从这里输出 */
int32_t demo_state_logcb(int32_t code, char *message)
{
    LUAT_DEBUG_PRINT("%s", message);
    return 0;
}

/* MQTT事件回调函数, 当网络连接/重连/断开时被触发, 事件定义见core/aiot_mqtt_api.h */
void demo_mqtt_event_handler(void *handle, const aiot_mqtt_event_t *event, void *userdata)
{
    switch (event->type) {
    /* SDK因为用户调用了aiot_mqtt_connect()接口, 与mqtt服务器建立连接已成功 */
    case AIOT_MQTTEVT_CONNECT: {
        LUAT_DEBUG_PRINT("AIOT_MQTTEVT_CONNECT\n");
    }
    break;

    /* SDK因为网络状况被动断连后, 自动发起重连已成功 */
    case AIOT_MQTTEVT_RECONNECT: {
        LUAT_DEBUG_PRINT("AIOT_MQTTEVT_RECONNECT\n");
    }
    break;

    /* SDK因为网络的状况而被动断开了连接, network是底层读写失败, heartbeat是没有按预期得到服务端心跳应答 */
    case AIOT_MQTTEVT_DISCONNECT: {
        char *cause = (event->data.disconnect == AIOT_MQTTDISCONNEVT_NETWORK_DISCONNECT) ? ("network disconnect") :
                      ("heartbeat disconnect");
        LUAT_DEBUG_PRINT("AIOT_MQTTEVT_DISCONNECT: %s\n", cause);
    }
    break;

    default: {

    }
    }
}

/* 执行aiot_mqtt_process的线程, 包含心跳发送和QoS1消息重发 */
void *demo_mqtt_process_thread(void *args)
{
    int32_t res = STATE_SUCCESS;

    while (g_mqtt_process_thread_running) {
        res = aiot_mqtt_process(args);
        if (res == STATE_USER_INPUT_EXEC_DISABLED) {
            break;
        }
        luat_rtos_task_sleep(1);
    }
    luat_rtos_task_delete(g_mqtt_process_thread);
    return NULL;
}

/* 执行aiot_mqtt_recv的线程, 包含网络自动重连和从服务器收取MQTT消息 */
void *demo_mqtt_recv_thread(void *args)
{
    int32_t res = STATE_SUCCESS;

    while (g_mqtt_recv_thread_running) {
        res = aiot_mqtt_recv(args);
        if (res < STATE_SUCCESS) {
            if (res == STATE_USER_INPUT_EXEC_DISABLED) {
                break;
            }
            luat_rtos_task_sleep(1);
        }
    }
    luat_rtos_task_delete(g_mqtt_recv_thread);
    return NULL;
}

void *mqtt_service_init() {
    int32_t     res = STATE_SUCCESS;
    aiot_sysdep_network_cred_t cred; /* 安全凭据结构体, 如果要用TLS, 这个结构体中配置CA证书等参数 */
    void       *mqtt_handle;

    /* 创建SDK的安全凭据, 用于建立TLS连接 */
    memset(&cred, 0, sizeof(aiot_sysdep_network_cred_t));
    cred.option = AIOT_SYSDEP_NETWORK_CRED_SVRCERT_CA;  /* 使用RSA证书校验MQTT服务端 */
    cred.max_tls_fragment = 16384; /* 最大的分片长度为16K, 其它可选值还有4K, 2K, 1K, 0.5K */
    cred.sni_enabled = 1;                               /* TLS建连时, 支持Server Name Indicator */
    cred.x509_server_cert = ali_ca_cert;                 /* 用来验证MQTT服务端的RSA根证书 */
    cred.x509_server_cert_len = strlen(ali_ca_cert);     /* 用来验证MQTT服务端的RSA根证书长度 */


    /* 创建1个MQTT客户端实例并内部初始化默认参数 */
    mqtt_handle = aiot_mqtt_init();
    if (mqtt_handle == NULL) {
        LUAT_DEBUG_PRINT("aiot_mqtt_init failed\n");
        return NULL;
    }

    {
        memset(&cred, 0, sizeof(aiot_sysdep_network_cred_t));
        cred.option = AIOT_SYSDEP_NETWORK_CRED_NONE;
    }

    /* 配置MQTT服务器地址 */
    aiot_mqtt_setopt(mqtt_handle, AIOT_MQTTOPT_HOST, (void *)host);
    /* 配置MQTT服务器端口 */
    aiot_mqtt_setopt(mqtt_handle, AIOT_MQTTOPT_PORT, (void *)&port);
    /* 配置设备productKey */
    aiot_mqtt_setopt(mqtt_handle, AIOT_MQTTOPT_PRODUCT_KEY, (void *)product_key);
    /* 配置设备deviceName */
    aiot_mqtt_setopt(mqtt_handle, AIOT_MQTTOPT_DEVICE_NAME, (void *)device_name);
    /* 配置设备deviceSecret */
    aiot_mqtt_setopt(mqtt_handle, AIOT_MQTTOPT_DEVICE_SECRET, (void *)device_secret);
    /* 配置网络连接的安全凭据, 上面已经创建好了 */
    aiot_mqtt_setopt(mqtt_handle, AIOT_MQTTOPT_NETWORK_CRED, (void *)&cred);
    /* 配置MQTT事件回调函数 */
    aiot_mqtt_setopt(mqtt_handle, AIOT_MQTTOPT_EVENT_HANDLER, (void *)demo_mqtt_event_handler);

    /* 与服务器建立MQTT连接 */
    res = aiot_mqtt_connect(mqtt_handle);
    if (res < STATE_SUCCESS) {
        /* 尝试建立连接失败, 销毁MQTT实例, 回收资源 */
        aiot_mqtt_deinit(&mqtt_handle);
        LUAT_DEBUG_PRINT("aiot_mqtt_connect failed: -0x%04X\n", -res);
        return NULL;
    }

    /* 创建一个单独的线程, 专用于执行aiot_mqtt_process, 它会自动发送心跳保活, 以及重发QoS1的未应答报文 */
    g_mqtt_process_thread_running = 1;
    luat_rtos_task_create(&g_mqtt_process_thread, 20 * 1024, 20, "process_task", demo_mqtt_process_thread, mqtt_handle, 0);
    if (g_mqtt_process_thread == NULL) {
        LUAT_DEBUG_PRINT("luat_rtos_task_create demo_mqtt_process_thread failed: %d\n", res);
        aiot_mqtt_disconnect(mqtt_handle);
        aiot_mqtt_deinit(&mqtt_handle);
        return NULL;
    }

    /* 创建一个单独的线程用于执行aiot_mqtt_recv, 它会循环收取服务器下发的MQTT消息, 并在断线时自动重连 */
    g_mqtt_recv_thread_running = 1;
    luat_rtos_task_create(&g_mqtt_recv_thread, 20 * 1024, 20, "recv_task", demo_mqtt_recv_thread, mqtt_handle, 0);
    if (g_mqtt_recv_thread == NULL) {
        LUAT_DEBUG_PRINT("luat_rtos_task_create demo_mqtt_recv_thread failed: %d\n", res);
        aiot_mqtt_disconnect(mqtt_handle);
        aiot_mqtt_deinit(&mqtt_handle);
        return NULL;
    }

    return mqtt_handle;
}

// /* 执行千里传音服务的线程 */
void *demo_linkspeech_thread(void *args)
{
    aiot_linkspeech_start(args);
    luat_rtos_task_delete(g_linkspeech_thread);
    return NULL;
}

int linkspeech_init(void *args)
{
    while(!g_s_is_link_up){
		luat_rtos_task_sleep(1000);
	}
    int32_t res = STATE_SUCCESS;
    void *linkspeech_handle = NULL;
    void *mqtt_handle = NULL;
    char *work_dir = ""; /* 语料保存的文件夹 */
    int32_t https_enable = 0;

    /* 配置SDK的底层依赖 */
    aiot_sysdep_set_portfile(&g_aiot_sysdep_portfile);
    /* 配置SDK的日志输出 */
    aiot_state_set_logcb(demo_state_logcb);
    /* 创建mqtt示例，并初始化mqtt连接服务 */
    mqtt_handle = mqtt_service_init();
    if(mqtt_handle == NULL) {
        luat_rtos_task_delete(linkspeech_init_task_handle);
        return -1;
    }

    /* 创建千里传音实例 */
    linkspeech_handle = aiot_linkspeech_init();
    if (linkspeech_handle == NULL) {
        LUAT_DEBUG_PRINT("aiot_dm_init failed");
        luat_rtos_task_delete(linkspeech_init_task_handle);
        return -1;
    }

    /* 设置保存语料的文件夹 */
    // memset(work_dir, 0, sizeof(work_dir));
    // char *s = getcwd(work_dir, sizeof(work_dir));
    // if(s == NULL) {
    //     return -1;
    // }
    // strncat(work_dir, "/speech_src", strlen("/speech_src"));
    // DIR *dir = NULL;
    // if(NULL == (dir = opendir(work_dir))) {
    //     if(0 != mkdir(work_dir, 0775)) {
    //         return -1;
    //     }
    // } else {
    //     closedir(dir);
    // }
    aiot_linkspeech_setopt(linkspeech_handle, AIOT_LSOPT_WORK_DIR, (void *)work_dir);

    /* 关联mqtt */
    aiot_linkspeech_setopt(linkspeech_handle, AIOT_LSOPT_MQTT_HANDLE, mqtt_handle);
    /* 设置文件系统操作 */
    aiot_linkspeech_setopt(linkspeech_handle, AIOT_LSOPT_FILE_OPS, (void *)&posix_fs);
    /* 设置音频播放接口 */
    aiot_linkspeech_setopt(linkspeech_handle, AIOT_LSOPT_PLAYER_CALLBACK, (void *)player);
    /* 设置文件下载协议，0:http  1:https*/
    aiot_linkspeech_setopt(linkspeech_handle, AIOT_LSOPT_HTTPS_ENABLE, (void *)&https_enable);
    /* 创建线程处理千里传音逻辑，该线程主要用于语料下载 */
    luat_rtos_task_create(&g_linkspeech_thread, 20 * 1024, 20, "link_task", demo_linkspeech_thread, linkspeech_handle, 0);
    if (res < 0) {
        LUAT_DEBUG_PRINT("luat_rtos_task_create demo_mqtt_recv_thread failed: %d\n", res);
        aiot_linkspeech_deinit(&linkspeech_handle);
        aiot_mqtt_disconnect(mqtt_handle);
        aiot_mqtt_deinit(&mqtt_handle);
        luat_rtos_task_delete(linkspeech_init_task_handle);
        return -1;
    }

    /* 主循环处理播放任务，创建锁保护音频播放对象不会被并发访问导致异常 */
    // luat_rtos_mutex_create(&player_mutex);
    while (1) {
        play_info_t info;
        luat_rtos_mutex_lock(player_mutex, LUAT_WAIT_FOREVER);
        if(g_play_info != NULL) {
            memcpy(&info, g_play_info, sizeof(play_info_t));
            free(g_play_info);
            g_play_info = NULL;
            luat_rtos_mutex_unlock(player_mutex);
            // char cmd[256];
            // memset(cmd, 0, sizeof(cmd));
            // snprintf(cmd, sizeof(cmd), "play %s", info.filename);
            /* 阻塞式播放 */
            // res = system(cmd);
            luat_audio_play_info_t tainfo[1];
            tainfo[0].path = info.filename;
            luat_audio_play_multi_files(0, tainfo, 1);
            luat_rtos_semaphore_take(audio_semaphore_handle, LUAT_WAIT_FOREVER);
            // if(res < 0) {
            //     LUAT_DEBUG_PRINT("AAAAAAAAAAAAA  555555555555");
            //     luat_rtos_task_delete(linkspeech_init_task_handle);
            //     return -1;
            // }
            /* 该动作会触发下一条播放 */
            info.ext_params->on_finish((char *)info.filename, info.ext_params->userdata);
            continue;
        } else {
            luat_rtos_mutex_unlock(&player_mutex);
        }

        luat_rtos_task_sleep(10000);
    }
    luat_rtos_mutex_delete(player_mutex);

    /* 停止收发动作 */
    g_mqtt_process_thread_running = 0;
    g_mqtt_recv_thread_running = 0;

    /* 停止千里传音服务 */
    aiot_linkspeech_stop(linkspeech_handle);

    /* 断开MQTT连接, 一般不会运行到这里 */
    res = aiot_mqtt_disconnect(mqtt_handle);
    if (res < STATE_SUCCESS) {
        aiot_linkspeech_deinit(&linkspeech_handle);
        aiot_mqtt_deinit(&mqtt_handle);
        LUAT_DEBUG_PRINT("aiot_mqtt_disconnect failed: -0x%04X\n", -res);
        luat_rtos_task_delete(linkspeech_init_task_handle);
        return -1;
    }

    /* 销毁千里传音实例, 一般不会运行到这里 */
    res = aiot_linkspeech_deinit(&linkspeech_handle);
    if (res < STATE_SUCCESS) {
        LUAT_DEBUG_PRINT("aiot_dm_deinit failed: -0x%04X\n", -res);
        luat_rtos_task_delete(linkspeech_init_task_handle);
        return -1;
    }

    /* 销毁MQTT实例, 一般不会运行到这里 */
    res = aiot_mqtt_deinit(&mqtt_handle);
    if (res < STATE_SUCCESS) {
        LUAT_DEBUG_PRINT("aiot_mqtt_deinit failed: -0x%04X\n", -res);
        luat_rtos_task_delete(linkspeech_init_task_handle);
        return -1;
    }

    return 0;
}

static void linkspeech_task_init(void)
{
    luat_rtos_task_create(&linkspeech_init_task_handle, 20 * 1024, 20, "init_task", linkspeech_init, NULL, 0);
}
static void mobile_event_cb(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status)
{
	switch(event)
	{
	case LUAT_MOBILE_EVENT_CFUN:
		LUAT_DEBUG_PRINT("CFUN消息，status %d", status);
		break;
	case LUAT_MOBILE_EVENT_SIM:
		LUAT_DEBUG_PRINT("SIM卡消息");
		switch(status)
		{
		case LUAT_MOBILE_SIM_READY:
			LUAT_DEBUG_PRINT("SIM卡正常工作");
			break;
		case LUAT_MOBILE_NO_SIM:
			LUAT_DEBUG_PRINT("SIM卡不存在");
			break;
		case LUAT_MOBILE_SIM_NEED_PIN:
			LUAT_DEBUG_PRINT("SIM卡需要输入PIN码");
			break;
		}
		break;
	case LUAT_MOBILE_EVENT_REGISTER_STATUS:
		LUAT_DEBUG_PRINT("移动网络服务状态变更，当前为%d", status);
		break;
	case LUAT_MOBILE_EVENT_CELL_INFO:
		switch(status)
		{
		case LUAT_MOBILE_CELL_INFO_UPDATE:
			break;
		case LUAT_MOBILE_SIGNAL_UPDATE:
			break;
		}
		break;
	case LUAT_MOBILE_EVENT_PDP:
		LUAT_DEBUG_PRINT("CID %d PDP激活状态变更为 %d", index, status);
		break;
	case LUAT_MOBILE_EVENT_NETIF:
		LUAT_DEBUG_PRINT("internet工作状态变更为 %d", status);
		switch (status)
		{
		case LUAT_MOBILE_NETIF_LINK_ON:
			LUAT_DEBUG_PRINT("可以上网");
            g_s_is_link_up = 1;
			break;
		default:
            g_s_is_link_up = 0;
			LUAT_DEBUG_PRINT("不能上网");
			break;
		}
		break;
	case LUAT_MOBILE_EVENT_TIME_SYNC:
		LUAT_DEBUG_PRINT("通过移动网络同步了UTC时间");
		break;
	case LUAT_MOBILE_EVENT_CSCON:
		LUAT_DEBUG_PRINT("RRC状态 %d", status);
		break;
	default:
		break;
	}
}

static void task_init(void){
    luat_mobile_event_register_handler(mobile_event_cb);
}



// AIR780E+TM8211开发板配置
#define CODEC_PWR_PIN HAL_GPIO_12
#define CODEC_PWR_PIN_ALT_FUN 4
#define PA_PWR_PIN HAL_GPIO_25
#define PA_PWR_PIN_ALT_FUN 0
#define CHARGE_EN_PIN HAL_GPIO_2
#define CHARGE_EN_PIN_ALT_FUN 0


static luat_rtos_task_handle audio_task_handle;
static uint8_t audio_sleep_handler = 0xff;
static HANDLE g_s_delay_timer;

void audio_data_cb(uint8_t *data, uint32_t len, uint8_t bits, uint8_t channels)
{
    HAL_I2sSrcAdjustVolumn(data, len, 10);
    LUAT_DEBUG_PRINT("%x,%d,%d,%d,%d", data, len, bits, channels);
}
void app_pa_on(uint32_t arg)
{
    luat_gpio_set(PA_PWR_PIN, 1); // 如果是780E+音频扩展小板,可以注释掉此行代码，因为PA长开
}
void audio_event_cb(uint32_t event, void *param)
{
    LUAT_DEBUG_PRINT("event_cb %d", event);
    switch (event)
    {
    case MULTIMEDIA_CB_AUDIO_DECODE_START:
        luat_gpio_set(CODEC_PWR_PIN, 1);
        luat_audio_play_write_blank_raw(0, 6, 1);
        break;
    case MULTIMEDIA_CB_AUDIO_OUTPUT_START:
        luat_rtos_timer_start(g_s_delay_timer, 200, 0, app_pa_on, NULL); // 如果是780E+音频扩展小板,可以注释掉此行代码，因为PA长开
        break;
    case MULTIMEDIA_CB_TTS_INIT:
        break;
    case LUAT_MULTIMEDIA_CB_TTS_DONE:
        if (!luat_audio_play_get_last_error(0))
        {
            luat_audio_play_write_blank_raw(0, 1, 0);
        }
        break;
    case MULTIMEDIA_CB_AUDIO_DONE:
        luat_rtos_timer_stop(g_s_delay_timer);
        LUAT_DEBUG_PRINT("audio play done, result=%d!", luat_audio_play_get_last_error(0));
        luat_gpio_set(PA_PWR_PIN, 0); // 如果是780E+音频扩展小板,可以注释掉此行代码，因为PA长开
        luat_gpio_set(CODEC_PWR_PIN, 0);
        luat_rtos_semaphore_release(audio_semaphore_handle);
        break;
    }
}

void audio_task_init(void)
{
    luat_rtos_timer_create(&g_s_delay_timer);

    luat_gpio_cfg_t gpio_cfg;
    luat_gpio_set_default_cfg(&gpio_cfg);

    gpio_cfg.pull = LUAT_GPIO_DEFAULT;

    // 如果是780E+音频扩展小板,可以注释掉下面两行代码，因为PA长开
    gpio_cfg.pin = PA_PWR_PIN;
    luat_gpio_open(&gpio_cfg);

    gpio_cfg.pin = CODEC_PWR_PIN;
    luat_gpio_open(&gpio_cfg);
    gpio_cfg.alt_fun = CODEC_PWR_PIN_ALT_FUN;
    luat_gpio_open(&gpio_cfg);

    luat_audio_play_global_init(audio_event_cb, audio_data_cb, luat_audio_play_file_default_fun, NULL, NULL);
    // luat_i2s_base_setup(0, I2S_MODE_I2S, I2S_FRAME_SIZE_16_16);   //如果是780E+音频扩展小板，打开这行注释代码，这个配置对应ES7148/ES7149
    luat_i2s_base_setup(0, I2S_MODE_MSB, I2S_FRAME_SIZE_16_16); // 此处配置对应TM8211
    luat_rtos_semaphore_create(&audio_semaphore_handle, 1);
}


INIT_HW_EXPORT(task_init, "0");
INIT_TASK_EXPORT(linkspeech_task_init, "1");
INIT_TASK_EXPORT(audio_task_init, "1");