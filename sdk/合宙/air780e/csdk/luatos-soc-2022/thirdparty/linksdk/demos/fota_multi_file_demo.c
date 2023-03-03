/*
 * 这个例程适用于`Linux`这类支持pthread的POSIX设备, 它演示了用SDK配置MQTT参数并建立连接, 之后创建3个线程
 *
 * + 一个线程用于保活长连接
 * + 一个线程用于接收消息, 并在有消息到达时进入默认的数据回调, 在连接状态变化时进入事件回调
 * + 一个线程用于从网络上HTTP下载待升级的固件, 这个线程由接收消息线程得到OTA升级的MQTT消息后启动
 *
 * 本例讲述了单个升级包中多个url情况下设备如何升级的用例
 * 需要用户关注或修改的部分, 已用 `TODO` 在注释中标明
 *
 */
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <stdlib.h>

#include "aiot_state_api.h"
#include "aiot_sysdep_api.h"
#include "aiot_ota_api.h"
#include "aiot_mqtt_api.h"

/* TODO: 替换为自己设备的三元组 */
char *product_key       = "${YourProductKey}";
char *device_name       = "${YourDeviceName}";
char *device_secret     = "${YourDeviceSecret}";

/*
    TODO: 替换为自己实例的接入点

    对于企业实例, 或者2021年07月30日之后（含当日）开通的物联网平台服务下公共实例
    mqtt_host的格式为"${YourInstanceId}.mqtt.iothub.aliyuncs.com"
    其中${YourInstanceId}: 请替换为您企业/公共实例的Id

    对于2021年07月30日之前（不含当日）开通的物联网平台服务下公共实例
    需要将mqtt_host修改为: mqtt_host = "${YourProductKey}.iot-as-mqtt.${YourRegionId}.aliyuncs.com"
    其中, ${YourProductKey}：请替换为设备所属产品的ProductKey。可登录物联网平台控制台，在对应实例的设备详情页获取。
    ${YourRegionId}：请替换为您的物联网平台设备所在地域代码, 比如cn-shanghai等
    该情况下完整mqtt_host举例: a1TTmBPIChA.iot-as-mqtt.cn-shanghai.aliyuncs.com

    详情请见: https://help.aliyun.com/document_detail/147356.html
*/
char  *mqtt_host = "${YourInstanceId}.mqtt.iothub.aliyuncs.com";

/* 收发包动作是要结束 */
int should_stop = 0;

/* 位于portfiles/aiot_port文件夹下的系统适配函数集合 */
extern aiot_sysdep_portfile_t g_aiot_sysdep_portfile;

/* 位于external/ali_ca_cert.c中的服务器证书 */
extern const char *ali_ca_cert;

static pthread_t g_mqtt_process_thread; /* 用于MQTT的长连接保活线程 */
static pthread_t g_mqtt_recv_thread;    /* 用于MQTT的循环收消息线程 */
static pthread_t g_download_thread;     /* 用于HTTP的固件下载线程 */

/* TODO: 如果要关闭日志, 就把这个函数实现为空, 如果要减少日志, 可根据code选择不打印
 *
 * 例如: [1578463098.611][LK-0309] pub: /ota/device/upgrade/a13FN5TplKq/ota_demo
 *
 * 上面这条日志的code就是0309(十六进制), code值的定义见core/aiot_state_api.h
 *
 */

/* 单升级包多文件情况下的整体任务进度描述 */
typedef struct {
    int32_t last_percent;
    uint32_t file_id;
    uint32_t file_num;
} multi_download_status_t;

int32_t g_finished_task_num = 0;

/* 日志回调函数, SDK的日志会从这里输出 */
int32_t demo_state_logcb(int32_t code, char *message)
{
    /* 下载固件的时候会有大量的HTTP收包日志, 通过code筛选出来关闭 */
    if (STATE_HTTP_LOG_RECV_CONTENT != code) {
        printf("%s", message);
    }
    return 0;
}

/* 下载收包回调, 用户调用 aiot_download_recv() 后, SDK收到数据会进入这个函数, 把下载到的数据交给用户 */
/* TODO: 一般来说, 设备升级时, 会在这个回调中, 把下载到的数据写到Flash上 */
void demo_download_recv_handler(void *handle, const aiot_download_recv_t *packet, void *userdata)
{
    uint32_t data_buffer_len = 0;
    int32_t last_percent = 0;
    int32_t  percent = 0;
    multi_download_status_t *download_status = (multi_download_status_t *)userdata;

    /* 目前只支持 packet->type 为 AIOT_DLRECV_HTTPBODY 的情况 */
    if (!packet || AIOT_DLRECV_HTTPBODY != packet->type) {
        return;
    }
    percent = packet->data.percent;

    /* userdata可以存放 demo_download_recv_handler() 的不同次进入之间, 需要共享的数据 */
    /* 这里用来存放上一次进入本回调函数时, 下载的固件进度百分比 */
    if (userdata) {
        last_percent = (download_status->last_percent);
    }

    data_buffer_len = packet->data.len;

    /* 如果 percent 为负数, 说明发生了收包异常或者digest校验错误 */
    if (percent < 0) {
        printf("exception: percent = %d\r\n", percent);
        if (userdata) {
            free(userdata);
        }
        return;
    }

    /*
     * TODO: 下载一段固件成功, 这个时候, 用户应该将
     *       起始地址为 packet->data.buffer, 长度为 packet->data.len 的内存, 保存到flash上
     *
     *       如果烧写flash失败, 还应该调用 aiot_download_report_progress(handle, -4) 将失败上报给云平台
     *       备注:协议中, 与云平台商定的错误码在 aiot_ota_protocol_errcode_t 类型中, 例如
     *           -1: 表示升级失败
     *           -2: 表示下载失败
     *           -3: 表示校验失败
     *           -4: 表示烧写失败
     *
     *       详情可见 https://help.aliyun.com/document_detail/85700.html
     */

    /* percent 入参的值为 100 时, 说明SDK已经下载固件内容全部完成 */
    if (percent == 100) {
        g_finished_task_num++;
        /*
         * TODO: 这个时候, 一般用户就应该完成所有的固件烧录, 保存当前工作, 重启设备, 切换到新的固件上启动了
                 并且, 新的固件必须要以

                 aiot_ota_report_version(ota_handle, new_version);

                 这样的操作, 将升级后的新版本号(比如1.0.0升到1.1.0, 则new_version的值是"1.1.0")上报给云平台
                 云平台收到了新的版本号上报后, 才会判定升级成功, 否则会认为本次升级失败了
                 如果下载成功后升级失败, 还应该调用 aiot_download_report_progress(handle, -1) 将失败上报给云平台
         */
    }

    /* 简化输出, 只有距离上次的下载进度增加5%以上时, 才会打印进度, 并向服务器上报进度 */
    if (percent - last_percent >= 5 || percent == 100) {
        if (NULL != download_status) {
            printf("file_id %d, download %03d%% done, +%d bytes\r\n", download_status->file_id, percent, data_buffer_len);
            download_status->last_percent = percent;
            if (g_finished_task_num == download_status->file_num) {
                /* 考虑到多个线程并发下载, 仅仅在所有文件下载完成后才上报100%的进度 */
                aiot_download_report_progress(handle, 100);
            }
        }

        if (percent == 100 && userdata) {
            free(userdata);
        }
    }
}

/* 执行aiot_download_recv的线程, 实现固件内容的请求和接收 */
void *demo_ota_download_thread(void *dl_handle)
{
    int32_t     ret = 0;

    printf("\r\nstarting download thread in 2 seconds ......\r\n");
    sleep(2);

    /* 向固件服务器请求下载 */
    /*
     * TODO: 下面这样的写法, 就是以1个请求, 获取全部的固件内容
     *       设备资源比较少, 或者网络较差时, 也可以分段下载, 需要组合
     *
     *       aiot_download_setopt(dl_handle, AIOT_DLOPT_RANGE_START, ...);
     *       aiot_download_setopt(dl_handle, AIOT_DLOPT_RANGE_END, ...);
     *       aiot_download_send_request(dl_handle);
     *
     *       实现, 这种情况下, 需要把以上组合语句放置到循环中, 多次 send_request 和 recv
     *
     */
    aiot_download_send_request(dl_handle);
    while (should_stop == 0) {
        /* 从网络收取服务器回应的固件内容 */
        ret = aiot_download_recv(dl_handle);

        /* 固件全部下载完时, aiot_download_recv() 的返回值会等于 STATE_DOWNLOAD_FINISHED, 否则是当次获取的字节数 */
        if (STATE_DOWNLOAD_FINISHED == ret) {
            printf("download completed\r\n");
            break;
        }
        if (STATE_DOWNLOAD_RENEWAL_REQUEST_SENT == ret) {
            printf("download renewal request has been sent successfully\r\n");
            continue;
        }
        if (ret <= STATE_SUCCESS) {
            printf("download failed, error code is %d, try to send renewal request\r\n", ret);
            continue;
        }
    }

    /* 下载所有固件内容完成, 销毁下载会话, 线程自行退出 */
    aiot_download_deinit(&dl_handle);
    printf("download thread exit\r\n");

    return NULL;
}


/* 用户通过 aiot_ota_setopt() 注册的OTA消息处理回调, 如果SDK收到了OTA相关的MQTT消息, 会自动识别, 调用这个回调函数 */
void demo_ota_recv_handler(void *ota_handle, aiot_ota_recv_t *ota_msg, void *userdata)
{
    switch (ota_msg->type) {
    case AIOT_OTARECV_FOTA: {
        uint32_t res = 0;
        uint16_t port = 443;
        uint32_t max_buffer_len = (8 * 1024);
        aiot_sysdep_network_cred_t cred;
        void *dl_handle = NULL;
        multi_download_status_t *download_status = NULL;

        if (NULL == ota_msg->task_desc || ota_msg->task_desc->protocol_type != AIOT_OTA_PROTOCOL_HTTPS) {
            break;
        }

        dl_handle = aiot_download_init();
        if (NULL == dl_handle) {
            break;
        }

        if (NULL != ota_msg->task_desc->file_name) {
            printf("\r\nTotal file number is %d, current file id is %d, with file_name %s\r\n", ota_msg->task_desc->file_num,
                   ota_msg->task_desc->file_id, ota_msg->task_desc->file_name);
        }

        printf("OTA target firmware version: %s,  size: %u Bytes \r\n", ota_msg->task_desc->version,
               ota_msg->task_desc->size_total);


        if (NULL != ota_msg->task_desc->extra_data) {
            printf("extra data: %s\r\n", ota_msg->task_desc->extra_data);
        }

        memset(&cred, 0, sizeof(aiot_sysdep_network_cred_t));
        cred.option = AIOT_SYSDEP_NETWORK_CRED_SVRCERT_CA;
        cred.max_tls_fragment = 16384;
        cred.x509_server_cert = ali_ca_cert;
        cred.x509_server_cert_len = strlen(ali_ca_cert);

        /* 设置下载时为TLS下载 */
        aiot_download_setopt(dl_handle, AIOT_DLOPT_NETWORK_CRED, (void *)(&cred));
        /* 设置下载时访问的服务器端口号 */
        aiot_download_setopt(dl_handle, AIOT_DLOPT_NETWORK_PORT, (void *)(&port));
        /* 设置下载的任务信息, 通过输入参数 ota_msg 中的 task_desc 成员得到, 内含下载地址, 固件大小, 固件签名等 */
        aiot_download_setopt(dl_handle, AIOT_DLOPT_TASK_DESC, (void *)(ota_msg->task_desc));
        /* 设置下载内容到达时, SDK将调用的回调函数 */
        aiot_download_setopt(dl_handle, AIOT_DLOPT_RECV_HANDLER, (void *)(demo_download_recv_handler));
        /* 设置单次下载最大的buffer长度, 每当这个长度的内存读满了后会通知用户 */
        aiot_download_setopt(dl_handle, AIOT_DLOPT_BODY_BUFFER_MAX_LEN, (void *)(&max_buffer_len));
        /* 设置 AIOT_DLOPT_RECV_HANDLER 的不同次调用之间共享的数据, 比如例程把进度存在这里 */
        download_status = malloc(sizeof(multi_download_status_t));
        if (NULL == download_status) {
            aiot_download_deinit(&dl_handle);
            break;
        }
        memset(download_status, 0, sizeof(multi_download_status_t));
        download_status->file_id = ota_msg->task_desc->file_id;
        download_status->file_num = ota_msg->task_desc->file_num;
        aiot_download_setopt(dl_handle, AIOT_DLOPT_USERDATA, (void *)download_status);

        /* 如果是第一个下载任务, 则上报进度0 */
        if (0 == ota_msg->task_desc->file_id) {
            aiot_download_report_progress(dl_handle, 0);
        }

        /* 启动专用的下载线程, 去完成固件内容的下载 */
        res = pthread_create(&g_download_thread, NULL, demo_ota_download_thread, dl_handle);
        if (res != 0) {
            printf("pthread_create demo_ota_download_thread failed: %d\r\n", res);
            aiot_download_deinit(&dl_handle);
            free(download_status);
        } else {
            /* 下载线程被设置为 detach 类型, 固件内容获取完毕后可自主退出 */
            pthread_detach(g_download_thread);
        }
        break;
    }

    default:
        break;
    }
}

/* MQTT事件回调函数, 当网络连接/重连/断开时被触发, 事件定义见core/aiot_mqtt_api.h */
void demo_mqtt_event_handler(void *handle, const aiot_mqtt_event_t *event, void *userdata)
{
    switch (event->type) {
    /* SDK因为用户调用了aiot_mqtt_connect()接口, 与mqtt服务器建立连接已成功 */
    case AIOT_MQTTEVT_CONNECT: {
        printf("AIOT_MQTTEVT_CONNECT\r\n");
        /* TODO: 处理SDK建连成功, 不可以在这里调用耗时较长的阻塞函数 */
    }
    break;

    /* SDK因为网络状况被动断连后, 自动发起重连已成功 */
    case AIOT_MQTTEVT_RECONNECT: {
        printf("AIOT_MQTTEVT_RECONNECT\r\n");
        /* TODO: 处理SDK重连成功, 不可以在这里调用耗时较长的阻塞函数 */
    }
    break;

    /* SDK因为网络的状况而被动断开了连接, network是底层读写失败, heartbeat是没有按预期得到服务端心跳应答 */
    case AIOT_MQTTEVT_DISCONNECT: {
        char *cause = (event->data.disconnect == AIOT_MQTTDISCONNEVT_NETWORK_DISCONNECT) ? ("network disconnect") :
                      ("heartbeat disconnect");
        printf("AIOT_MQTTEVT_DISCONNECT: %s\r\n", cause);
        /* TODO: 处理SDK被动断连, 不可以在这里调用耗时较长的阻塞函数 */
    }
    break;

    default: {

    }
    }
}

/* MQTT默认消息处理回调, 当SDK从服务器收到MQTT消息时, 且无对应用户回调处理时被调用 */
void demo_mqtt_default_recv_handler(void *handle, const aiot_mqtt_recv_t *packet, void *userdata)
{
    switch (packet->type) {
    case AIOT_MQTTRECV_HEARTBEAT_RESPONSE: {
        printf("heartbeat response\r\n");
        /* TODO: 处理服务器对心跳的回应, 一般不处理 */
    }
    break;

    case AIOT_MQTTRECV_SUB_ACK: {
        printf("suback, res: -0x%04X, packet id: %d, max qos: %d\r\n",
               -packet->data.sub_ack.res, packet->data.sub_ack.packet_id, packet->data.sub_ack.max_qos);
        /* TODO: 处理服务器对订阅请求的回应, 一般不处理 */
    }
    break;

    case AIOT_MQTTRECV_PUB: {
        printf("pub, qos: %d, topic: %.*s\r\n", packet->data.pub.qos, packet->data.pub.topic_len, packet->data.pub.topic);
        printf("pub, payload: %.*s\r\n", packet->data.pub.payload_len, packet->data.pub.payload);
        /* TODO: 处理服务器下发的业务报文 */
    }
    break;

    case AIOT_MQTTRECV_PUB_ACK: {
        printf("puback, packet id: %d\r\n", packet->data.pub_ack.packet_id);
        /* TODO: 处理服务器对QoS1上报消息的回应, 一般不处理 */
    }
    break;

    default: {

    }
    }
}

/* 执行aiot_mqtt_process的线程, 包含心跳发送和QoS1消息重发 */
void *demo_mqtt_process_thread(void *args)
{
    while (should_stop == 0) {
        aiot_mqtt_process(args);
        sleep(1);
    }
    return NULL;
}

/* 执行aiot_mqtt_recv的线程, 包含网络自动重连和从服务器收取MQTT消息 */
void *demo_mqtt_recv_thread(void *args)
{
    int32_t res = STATE_SUCCESS;

    while (should_stop == 0) {
        res = aiot_mqtt_recv(args);
        if (res < STATE_SUCCESS) {
            sleep(1);
        }
    }
    return NULL;
}

int main(int argc, char *argv[])
{
    int32_t     res = STATE_SUCCESS;
    void       *mqtt_handle = NULL;
    uint16_t    port = 443;      /* 无论设备是否使用TLS连接阿里云平台, 目的端口都是443 */
    aiot_sysdep_network_cred_t cred; /* 安全凭据结构体, 如果要用TLS, 这个结构体中配置CA证书等参数 */
    void       *ota_handle = NULL;
    char       *cur_version = NULL;

    /* 配置SDK的底层依赖 */
    aiot_sysdep_set_portfile(&g_aiot_sysdep_portfile);

    /* 配置SDK的日志输出 */
    aiot_state_set_logcb(demo_state_logcb);

    /* 创建SDK的安全凭据, 用于建立TLS连接 */
    memset(&cred, 0, sizeof(aiot_sysdep_network_cred_t));
    cred.option = AIOT_SYSDEP_NETWORK_CRED_SVRCERT_CA;  /* 使用RSA证书校验MQTT服务端 */
    cred.max_tls_fragment = 16384; /* 最大的分片长度为16K, 其它可选值还有4K, 2K, 1K, 0.5K */
    cred.sni_enabled = 1;                               /* TLS建连时, 支持Server Name Indicator */
    cred.x509_server_cert = ali_ca_cert;                 /* 用来验证MQTT服务端的RSA根证书 */
    cred.x509_server_cert_len = strlen(ali_ca_cert);     /* 用来验证MQTT服务端的RSA根证书长度 */

    /* 创建1个MQTT客户端实例并内部初始化默认参数 */
    mqtt_handle = aiot_mqtt_init();
    if (NULL == mqtt_handle) {
        printf("aiot_mqtt_init failed\r\n");
        return -1;
    }

    /* 配置MQTT服务器地址 */
    aiot_mqtt_setopt(mqtt_handle, AIOT_MQTTOPT_HOST, (void *)mqtt_host);
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
    /* 配置MQTT默认消息接收回调函数 */
    aiot_mqtt_setopt(mqtt_handle, AIOT_MQTTOPT_RECV_HANDLER, (void *)demo_mqtt_default_recv_handler);
    /* 配置MQTT事件回调函数 */
    aiot_mqtt_setopt(mqtt_handle, AIOT_MQTTOPT_EVENT_HANDLER, (void *)demo_mqtt_event_handler);

    /* 与MQTT例程不同的是, 这里需要增加创建OTA会话实例的语句 */
    ota_handle = aiot_ota_init();
    if (NULL == ota_handle) {
        printf("aiot_ota_init failed\r\n");
        aiot_mqtt_deinit(&mqtt_handle);
        return -2;
    }

    /* 用以下语句, 把OTA会话和MQTT会话关联起来 */
    aiot_ota_setopt(ota_handle, AIOT_OTAOPT_MQTT_HANDLE, mqtt_handle);
    /* 用以下语句, 设置OTA会话的数据接收回调, SDK收到OTA相关推送时, 会进入这个回调函数 */
    aiot_ota_setopt(ota_handle, AIOT_OTAOPT_RECV_HANDLER, demo_ota_recv_handler);

    /* 与服务器建立MQTT连接 */
    res = aiot_mqtt_connect(mqtt_handle);
    if (res < STATE_SUCCESS) {
        /* 尝试建立连接失败, 销毁MQTT实例, 回收资源 */
        aiot_mqtt_deinit(&mqtt_handle);
        aiot_ota_deinit(&ota_handle);
        printf("aiot_mqtt_connect failed: -0x%04X\r\n\r\n", -res);
        printf("please check variables like mqtt_host, produt_key, device_name, device_secret in demo\r\n");
        return -3;
    }

    /*   TODO: 非常重要!!!
     *
     *   cur_version 要根据用户实际情况, 改成从设备的配置区获取, 要反映真实的版本号, 而不能像示例这样写为固定值
     *
     *   1. 如果设备从未上报过版本号, 在控制台网页将无法部署升级任务
     *   2. 如果设备升级完成后, 上报的不是新的版本号, 在控制台网页将会显示升级失败
     *
     */

    /* 演示MQTT连接建立起来之后, 就可以上报当前设备的版本号了 */
    cur_version = "1.0.0";
    res = aiot_ota_report_version(ota_handle, cur_version);
    if (res < STATE_SUCCESS) {
        printf("aiot_ota_report_version failed: -0x%04X\r\n", -res);
    }

    /* 创建一个单独的线程, 专用于执行aiot_mqtt_process, 它会自动发送心跳保活, 以及重发QoS1的未应答报文 */
    res = pthread_create(&g_mqtt_process_thread, NULL, demo_mqtt_process_thread, mqtt_handle);
    if (res != 0) {
        printf("pthread_create demo_mqtt_process_thread failed: %d\r\n", res);
        return -1;
    }

    /* 创建一个单独的线程用于执行aiot_mqtt_recv, 它会循环收取服务器下发的MQTT消息, 并在断线时自动重连 */
    res = pthread_create(&g_mqtt_recv_thread, NULL, demo_mqtt_recv_thread, mqtt_handle);
    if (res != 0) {
        printf("pthread_create demo_mqtt_recv_thread failed: %d\r\n", res);
        return -1;
    }

    /* 主循环进入休眠 */
    while (1) {
        sleep(1);
    }

    should_stop = 1;
    sleep(5);

    /* 断开MQTT连接, 一般不会运行到这里 */
    res = aiot_mqtt_disconnect(mqtt_handle);
    if (res < STATE_SUCCESS) {
        aiot_mqtt_deinit(&mqtt_handle);
        aiot_ota_deinit(&ota_handle);
        printf("aiot_mqtt_disconnect failed: -0x%04X\r\n", -res);
        return -1;
    }

    /* 销毁OTA实例, 一般不会运行到这里 */
    aiot_ota_deinit(&ota_handle);
    return 0;
}

