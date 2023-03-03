/*
 * 这个例程适用于`Linux`这类支持pthread的POSIX设备, 它演示了用SDK配置MQTT参数并建立连接, 之后创建2个线程
 *
 * + 一个线程用于保活长连接
 * + 一个线程用于接收消息, 并在有消息到达时进入默认的数据回调, 在连接状态变化时进入事件回调
 *
 * 接着在MQTT连接上发送TASK查询请求, 如果云平台的回应报文到达, 从接收线程会调用TASK消息处理的回调函数, 把对时后的本地时间打印出来
 *
 * 需要用户关注或修改的部分, 已经用 TODO 在注释中标明
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>

#include "aiot_state_api.h"
#include "aiot_sysdep_api.h"
#include "aiot_mqtt_api.h"
#include "aiot_task_api.h"


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


/* 位于portfiles/aiot_port文件夹下的系统适配函数集合 */
extern aiot_sysdep_portfile_t g_aiot_sysdep_portfile;

/* 位于external/ali_ca_cert.c中的服务器证书 */
extern const char *ali_ca_cert;

static task_desc_t *g_local_task_desc = NULL;
static pthread_t g_mqtt_process_thread;
static pthread_t g_mqtt_recv_thread;
static pthread_t g_task_thread;     /* 用于执行任务的线程 */
static uint8_t g_mqtt_process_thread_running = 0;
static uint8_t g_mqtt_recv_thread_running = 0;

void demo_free_local_task(task_desc_t **task);

void *demo_task_thread(void *data)
{
#if 0
    while (1) {
        /* TODO: 执行任务 */
    }
#endif
    sleep(5);
    return NULL;
}

/* 日志回调函数, SDK的日志会从这里输出 */
static int32_t demo_state_logcb(int32_t code, char *message)
{
    printf("%s", message);
    return 0;
}

/* MQTT事件回调函数, 当网络连接/重连/断开时被触发, 事件定义见core/aiot_mqtt_api.h */
void demo_mqtt_event_handler(void *handle, const aiot_mqtt_event_t *event, void *userdata)
{
    switch (event->type) {
        /* SDK因为用户调用了aiot_mqtt_connect()接口, 与mqtt服务器建立连接已成功 */
        case AIOT_MQTTEVT_CONNECT: {
            printf("AIOT_MQTTEVT_CONNECT\n");
        }
        break;

        /* SDK因为网络状况被动断连后, 自动发起重连已成功 */
        case AIOT_MQTTEVT_RECONNECT: {
            printf("AIOT_MQTTEVT_RECONNECT\n");
        }
        break;

        /* SDK因为网络的状况而被动断开了连接, network是底层读写失败, heartbeat是没有按预期得到服务端心跳应答 */
        case AIOT_MQTTEVT_DISCONNECT: {
            char *cause = (event->data.disconnect == AIOT_MQTTDISCONNEVT_NETWORK_DISCONNECT) ? ("network disconnect") :
                          ("heartbeat disconnect");
            printf("AIOT_MQTTEVT_DISCONNECT: %s\n", cause);
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
            printf("heartbeat response\n");
        }
        break;

        case AIOT_MQTTRECV_SUB_ACK: {
            printf("suback, res: -0x%04X, packet id: %d, max qos: %d\n",
                   -packet->data.sub_ack.res, packet->data.sub_ack.packet_id, packet->data.sub_ack.max_qos);
        }
        break;

        case AIOT_MQTTRECV_PUB: {
            printf("pub, qos: %d, topic: %.*s\n", packet->data.pub.qos, packet->data.pub.topic_len, packet->data.pub.topic);
            printf("pub, payload: %.*s\n", packet->data.pub.payload_len, packet->data.pub.payload);
        }
        break;

        case AIOT_MQTTRECV_PUB_ACK: {
            printf("puback, packet id: %d\n", packet->data.pub_ack.packet_id);
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
        sleep(1);
    }
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
            sleep(1);
        }
    }
    return NULL;
}

int32_t demo_mqtt_start(void **handle)
{
    int32_t     res = STATE_SUCCESS;
    void       *mqtt_handle = NULL;
    uint16_t    port = 1883;      /* 无论设备是否使用TLS连接阿里云平台, 目的端口都是443 */
    aiot_sysdep_network_cred_t cred; /* 安全凭据结构体, 如果要用TLS, 这个结构体中配置CA证书等参数 */


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
    if (mqtt_handle == NULL) {
        printf("aiot_mqtt_init failed\n");
        return -1;
    }

    /* TODO: 如果以下代码不被注释, 则例程会用TCP而不是TLS连接云平台 */
    /*
    {
        memset(&cred, 0, sizeof(aiot_sysdep_network_cred_t));
        cred.option = AIOT_SYSDEP_NETWORK_CRED_NONE;
    }
    */

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

    /* 与服务器建立MQTT连接 */
    res = aiot_mqtt_connect(mqtt_handle);
    if (res < STATE_SUCCESS) {
        /* 尝试建立连接失败, 销毁MQTT实例, 回收资源 */
        aiot_mqtt_deinit(&mqtt_handle);
        printf("aiot_mqtt_connect failed: -0x%04X\n\r\n", -res);
        printf("please check variables like mqtt_host, produt_key, device_name, device_secret in demo\r\n");
        return -1;
    }

    /* 创建一个单独的线程, 专用于执行aiot_mqtt_process, 它会自动发送心跳保活, 以及重发QoS1的未应答报文 */
    g_mqtt_process_thread_running = 1;
    res = pthread_create(&g_mqtt_process_thread, NULL, demo_mqtt_process_thread, mqtt_handle);
    if (res < 0) {
        printf("pthread_create demo_mqtt_process_thread failed: %d\n", res);
        aiot_mqtt_deinit(&mqtt_handle);
        return -1;
    }

    /* 创建一个单独的线程用于执行aiot_mqtt_recv, 它会循环收取服务器下发的MQTT消息, 并在断线时自动重连 */
    g_mqtt_recv_thread_running = 1;
    res = pthread_create(&g_mqtt_recv_thread, NULL, demo_mqtt_recv_thread, mqtt_handle);
    if (res < 0) {
        printf("pthread_create demo_mqtt_recv_thread failed: %d\n", res);
        g_mqtt_process_thread_running = 0;
        pthread_join(g_mqtt_process_thread, NULL);
        aiot_mqtt_deinit(&mqtt_handle);
        return -1;
    }

    *handle = mqtt_handle;

    return 0;
}

int32_t demo_mqtt_stop(void **handle)
{
    int32_t res = STATE_SUCCESS;
    void *mqtt_handle = NULL;

    mqtt_handle = *handle;

    g_mqtt_process_thread_running = 0;
    g_mqtt_recv_thread_running = 0;
    pthread_join(g_mqtt_process_thread, NULL);
    pthread_join(g_mqtt_recv_thread, NULL);

    /* 断开MQTT连接 */
    res = aiot_mqtt_disconnect(mqtt_handle);
    if (res < STATE_SUCCESS) {
        aiot_mqtt_deinit(&mqtt_handle);
        printf("aiot_mqtt_disconnect failed: -0x%04X\n", -res);
        return -1;
    }

    /* 销毁MQTT实例 */
    res = aiot_mqtt_deinit(&mqtt_handle);
    if (res < STATE_SUCCESS) {
        printf("aiot_mqtt_deinit failed: -0x%04X\n", -res);
        return -1;
    }

    return 0;
}

static void _demo_deep_free_base(char *in)
{
    if (NULL == in) {
        return;
    }
    free(in);
}

static void *_demo_deep_copy_base(char *in)
{
    uint32_t len = 0;
    void *tmp = NULL;
    if (NULL == in) {
        return NULL;
    }
    len = strlen(in) + 1;
    tmp = (char *)malloc(len);
    if (NULL == tmp) {
        return NULL;
    }
    memset(tmp, 0, len);
    memcpy(tmp, in, strlen(in));
    return tmp;
}

void demo_copy_task_to_local_task(task_desc_t **dst_desc, const task_desc_t *in_desc)
{
    if (NULL == *dst_desc) {
        *dst_desc = (task_desc_t *)malloc(sizeof(task_desc_t));
    }

    (*dst_desc)->status = in_desc->status;
    (*dst_desc)->progress = in_desc->progress;
    (*dst_desc)->handle = in_desc->handle;
    (*dst_desc)->task_id = _demo_deep_copy_base(in_desc->task_id);
    (*dst_desc)->job_document = _demo_deep_copy_base(in_desc->job_document);
    (*dst_desc)->sign_method = _demo_deep_copy_base(in_desc->sign_method);
    (*dst_desc)->sign = _demo_deep_copy_base(in_desc->sign);
    (*dst_desc)->document_file_url = _demo_deep_copy_base(in_desc->document_file_url);
    (*dst_desc)->status_details = _demo_deep_copy_base(in_desc->status_details);
}

void demo_free_local_task(task_desc_t **task)
{
    if (NULL != *task) {
        _demo_deep_free_base((*task)->task_id);
        _demo_deep_free_base((*task)->job_document);
        _demo_deep_free_base((*task)->sign_method);
        _demo_deep_free_base((*task)->sign);
        _demo_deep_free_base((*task)->document_file_url);
        _demo_deep_free_base((*task)->status_details);
        free(*task);
    }

    *task = NULL;
}

void demo_task_recv_handler(void *handle, const aiot_task_recv_t *packet, void *userdata)
{
    switch (packet->type) {
        case AIOT_TASKRECV_NOTIFY: {
            const task_desc_t *in_desc = &(packet->data.notify);

            printf("revice task notify, task_id:[%s],status:[%d],job_document[%s],document_file_url:[%s],\
            sign_method:[%s],sign[%s]\r\n",
                   in_desc->task_id, in_desc->status, in_desc->job_document,
                   in_desc->document_file_url, in_desc->sign_method, in_desc->sign);

            /* 1.在handle里面没有任务记录的情况下, 把云端下行的task保存到handle里面的default_task_desc字段 */
            if (NULL == g_local_task_desc) {
                demo_copy_task_to_local_task(&g_local_task_desc, in_desc);
                /* 启动任务. 这里仅为参考实现, 用户可以根据实际情况来适配 */
                int res = pthread_create(&g_task_thread, NULL, demo_task_thread, g_local_task_desc);
                if (res != 0) {
                    printf("pthread_create demo_task_thread failed: %d\r\n", res);
                } else {
                    /* 下载线程被设置为 detach 类型, 固件内容获取完毕后可自主退出 */
                    pthread_detach(g_task_thread);
                }
                /* 变更任务状态.TODO: 这里仅为参考实现, 任务执行完毕时, 要将状态设置为AIOT_TASK_STATUS_SUCCEEDED*/
                g_local_task_desc->status = AIOT_TASK_STATUS_IN_PROGRESS;
                aiot_task_update(handle, g_local_task_desc);
                demo_free_local_task(&g_local_task_desc);
                break;
            }

            /* 2.如果状态被云端设置为终态, 则在这里将本地的任务清理掉 */
            if (in_desc->status == AIOT_TASK_STATUS_CANCELLED || in_desc->status == AIOT_TASK_STATUS_REMOVED
                || in_desc->status == AIOT_TASK_STATUS_TIMED_OUT) {
                /* TODO: 清理本地任务, 停下线程 */
                /* 如果该任务是记录在handle里面的默认任务, 则要把它的内存清理掉; 如果是记录在handle外的, 需要用户自己维护内存 */
                if (NULL != g_local_task_desc && 0 == strcmp(in_desc->task_id, g_local_task_desc->task_id)) {
                    /* 释放本地任务内存 */
                    demo_free_local_task(&g_local_task_desc);
                }
                break;
            }

            /* 3.在本地已有任务记录的情况,云端可能更新了当前这个任务的描述, 需要检查一下更新的内容 */
            if (in_desc->status == AIOT_TASK_STATUS_IN_PROGRESS) {
                if (NULL != g_local_task_desc && 0 == strcmp(in_desc->task_id, g_local_task_desc->task_id)) {
                    /* TODO: 更新本地的任务描述. 用户可能要暂停当前的任务再更新, 这一点取决于用户 */
                    break;
                }
            }

            /* 4.如果不是上述情况, 说明来了一个新任务. 此时用户已经有一个任务在执行了, 又来了一个任务, 用户可以在main中自己创建一个列表 */
            /* 将这个列表作为userdata传进来, 并把任务记录在这个列表里面, 自己维护*/
            break;
        }
        case AIOT_TASKRECV_GET_DETAIL_REPLY: {
            const task_get_detail_reply_t *in_reply = &(packet->data.get_detail_reply);
            printf("revice task get detail, code:[%d]\r\n", in_reply->code);
            if (200 == in_reply->code) {
                printf("revice task get detail reply, task_id:[%s],status:[%d]\r\n",
                       in_reply->task.task_id, in_reply->task.status);
                if (in_reply->task.status != AIOT_TASK_STATUS_NOT_FOUND) {
                    printf("job_document[%s],document_file_url:[%s], sign_method:[%s],sign[%s]\r\n",
                           in_reply->task.job_document, in_reply->task.document_file_url,
                           in_reply->task.sign_method, in_reply->task.sign);
                    task_desc_t task;
                    memset(&task, 0, sizeof(task));
                    memcpy(&task, &(in_reply->task), sizeof(task));
                    /* TODO: 执行任务, 可以通过起线程的方式 */

                    /* 变更任务状态. TODO: 这里仅为参考实现, 用户可以根据实际情况来适配. 任务执行完毕时, 要将状态设置为AIOT_TASK_STATUS_SUCCEEDED */
                    task.status = AIOT_TASK_STATUS_IN_PROGRESS;
                    task.progress = 88;
                    aiot_task_update(handle, &task);
                }
            }
            break;
        }
        case AIOT_TASKRECV_GET_LIST_REPLY: {
            const task_get_list_reply_t *in_reply = &(packet->data.get_list_reply);
            printf("revice task get list reply, number:[%d]\r\n", in_reply->number);
            for (int i = 0; i < in_reply->number; i++) {
                printf("task list[%d]:task_id[%s],status[%d]\r\n", i, in_reply->tasks[i].task_id,
                       in_reply->tasks[i].status);
                aiot_task_get_task_detail(handle, in_reply->tasks[i].task_id);
            }
            break;
        }
        case AIOT_TASKRECV_UPDATE_REPLY: {
            const task_update_reply_t *update_reply = &(packet->data.update_reply);
            printf("revice task update reply, code:[%d]\r\n", update_reply->code);

            if (200 == update_reply->code) {
                printf("revice task update reply, task_id:[%s]\r\n", update_reply->task_id);
            }

            if (71012 == update_reply->code) {
                printf("aiot_task_update task's status_details value must be json format\r\n");
            }
            /* TODO */
            break;
        }
        default:
            /* TODO */
            break;
    }
}

int main(int argc, char *argv[])
{
    int32_t     res = STATE_SUCCESS;
    void       *mqtt_handle = NULL, *task_handle = NULL;

    /* 建立MQTT连接, 并开启保活线程和接收线程 */
    res = demo_mqtt_start(&mqtt_handle);
    if (res < 0) {
        printf("demo_mqtt_start failed\n");
        return -1;
    }

    /* 创建1个task客户端实例并内部初始化默认参数 */
    task_handle = aiot_task_init();
    if (task_handle == NULL) {
        demo_mqtt_stop(&mqtt_handle);
        printf("aiot_task_init failed\n");
        return -1;
    }

    res = aiot_task_setopt(task_handle, AIOT_TASKOPT_MQTT_HANDLE, mqtt_handle);
    if (res < STATE_SUCCESS) {
        printf("aiot_task_setopt AIOT_TASKOPT_MQTT_HANDLE failed, res: -0x%04X\n", -res);
        aiot_task_deinit(&task_handle);
        demo_mqtt_stop(&mqtt_handle);
        return -1;
    }

    res = aiot_task_setopt(task_handle, AIOT_TASKOPT_RECV_HANDLER, demo_task_recv_handler);
    if (res < STATE_SUCCESS) {
        printf("aiot_task_setopt AIOT_TASKOPT_RECV_HANDLER failed, res: -0x%04X\n", -res);
        aiot_task_deinit(&task_handle);
        demo_mqtt_stop(&mqtt_handle);
        return -1;
    }

    /* 发送task获取下一个可执行的任务的请求给云平台 */
    res = aiot_task_get_task_detail(task_handle, NULL);
    if (res < STATE_SUCCESS) {
        aiot_task_deinit(&task_handle);
        demo_mqtt_stop(&mqtt_handle);
        return -1;
    }

    /* 主线程进入休眠, 等云平台的task回应到达时, 接收线程会调用 demo_task_recv_handler() */
    while (1) {
        sleep(1);
    }

    /* 销毁task实例, 一般不会运行到这里 */
    res = aiot_task_deinit(&task_handle);
    if (res < STATE_SUCCESS) {
        demo_mqtt_stop(&mqtt_handle);
        printf("aiot_task_deinit failed: -0x%04X\n", -res);
        return -1;
    }

    /* 销毁MQTT实例, 退出线程, 一般不会运行到这里 */
    res = demo_mqtt_stop(&mqtt_handle);
    if (res < 0) {
        printf("demo_start_stop failed\n");
        return -1;
    }

    return 0;
}
