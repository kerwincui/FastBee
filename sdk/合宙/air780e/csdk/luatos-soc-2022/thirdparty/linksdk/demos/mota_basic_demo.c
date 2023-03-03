/*
 * 这个例程适用于不支持通过pthread函数在主线程外开独立的固件下载线程的设备
 * 它演示了用SDK配置MQTT参数并建立连接, 并在接收到OTA的mqtt消息后开始下载升级固件的过程
 * 同时, 它演示了如何将固件的大小分为两半, 每次下载一半的做法. 用户可以进一步将固件分成更多更小的分段
 *
 * 需要用户关注或修改的部分, 已用 `TODO` 在注释中标明
 *
 */

/* TODO: 本例子用到了sleep函数, 所以包含了unistd.h. 如果用户自己的库中有可以替代的函数, 则可以将unistd.h替换掉
 *
 * 本例子用到了malloc/free函数, 所以用到了stdlib.h, 用户如果自己库中有可以替代的函数, 则需要将stdlib.h替换掉
 *
 */
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include "aiot_state_api.h"
#include "aiot_sysdep_api.h"
#include "aiot_mqtt_api.h"
#include "aiot_ota_api.h"
#include "aiot_mqtt_download_api.h"

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

/* 位于external/ali_ca_cert.c中的服务器证书 */
extern const char *ali_ca_cert;
void *g_ota_handle = NULL;
void *g_dl_handle = NULL;
uint32_t g_firmware_size = 0;

/* 位于portfiles/aiot_port文件夹下的系统适配函数集合 */
extern aiot_sysdep_portfile_t g_aiot_sysdep_portfile;

/* TODO: 如果要关闭日志, 就把这个函数实现为空, 如果要减少日志, 可根据code选择不打印
 *
 * 例如: [1578463098.611][LK-0309] pub: /ota/device/upgrade/a13FN5TplKq/ota_demo
 *
 * 上面这条日志的code就是0309(十六进制), code值的定义见core/aiot_state_api.h
 *
 */

/* 日志回调函数, SDK的日志会从这里输出 */
int32_t demo_state_logcb(int32_t code, char *message)
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
void demo_mqtt_default_recv_handler(void *handle, const aiot_mqtt_recv_t *const packet, void *userdata)
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

/* 下载收包回调, 用户调用 aiot_download_recv() 后, SDK收到数据会进入这个函数, 把下载到的数据交给用户 */
/* TODO: 一般来说, 设备升级时, 会在这个回调中, 把下载到的数据写到Flash上 */
void user_download_recv_handler(void *handle, const aiot_mqtt_download_recv_t *packet, void *userdata)
{
    uint32_t data_buffer_len = 0;

    /* 目前只支持 packet->type 为 AIOT_DLRECV_HTTPBODY 的情况 */
    if (!packet || AIOT_MDRECV_DATA_RESP != packet->type) {
        return;
    }

    /* 用户应在此实现文件本地固化的操作 */
    FILE *file = fopen("mota_demo.bin", "ab");
    fwrite(packet->data.data_resp.data, packet->data.data_resp.data_size, sizeof(int8_t), file);
    fclose(file);

    data_buffer_len = packet->data.data_resp.data_size;

    printf("download %03d%% done, +%d bytes\r\n", packet->data.data_resp.percent, data_buffer_len);
}

/* 用户通过 aiot_ota_setopt() 注册的OTA消息处理回调, 如果SDK收到了OTA相关的MQTT消息, 会自动识别, 调用这个回调函数 */
void user_ota_recv_handler(void *ota_handle, aiot_ota_recv_t *ota_msg, void *userdata)
{
    uint32_t request_size = 10 * 1024;
    switch (ota_msg->type) {
    case AIOT_OTARECV_FOTA: {
        if (NULL == ota_msg->task_desc || ota_msg->task_desc->protocol_type != AIOT_OTA_PROTOCOL_MQTT) {
            break;
        }

        if(g_dl_handle != NULL) {
            aiot_mqtt_download_deinit(&g_dl_handle);
        }

        printf("OTA target firmware version: %s, size: %u Bytes\r\n", ota_msg->task_desc->version,
               ota_msg->task_desc->size_total);
        void *md_handler = aiot_mqtt_download_init();
        aiot_mqtt_download_setopt(md_handler, AIOT_MDOPT_TASK_DESC, ota_msg->task_desc);
        /* 设置下载一包的大小，对于资源受限设备可以调整该值大小 */
        aiot_mqtt_download_setopt(md_handler, AIOT_MDOPT_DATA_REQUEST_SIZE, &request_size);

        /* 部分场景下，用户如果只需要下载文件的一部分，即下载指定range的文件，可以设置文件起始位置、终止位置。
         * 若设置range区间下载，单包报文的数据有CRC校验，但SDK将不进行完整文件MD5校验，
         * 默认下载全部文件，单包报文的数据有CRC校验，并且SDK会对整个文件进行md5校验 */
        // uint32_t range_start = 10, range_end = 50 * 1024 + 10;
        // aiot_mqtt_download_setopt(md_handler, AIOT_MDOPT_RANGE_START, &range_start);
        // aiot_mqtt_download_setopt(md_handler, AIOT_MDOPT_RANGE_END, &range_end);

        aiot_mqtt_download_setopt(md_handler, AIOT_MDOPT_RECV_HANDLE, user_download_recv_handler);
        g_dl_handle = md_handler;
    }
    break;
    default:
        break;
    }
}


int main(int argc, char *argv[])
{
    int32_t res = STATE_SUCCESS;
    void *mqtt_handle = NULL;
    uint16_t port = 1883; /* 无论设备是否使用TLS连接阿里云平台, 目的端口都是443 */
    aiot_sysdep_network_cred_t cred; /* 安全凭据结构体, 如果要用TLS, 这个结构体中配置CA证书等参数 */
    char *cur_version = NULL;
    void *ota_handle = NULL;

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
        goto exit;
    }

    /* 用以下语句, 把OTA会话和MQTT会话关联起来 */
    aiot_ota_setopt(ota_handle, AIOT_OTAOPT_MQTT_HANDLE, mqtt_handle);
    /* 用以下语句, 设置OTA会话的数据接收回调, SDK收到OTA相关推送时, 会进入这个回调函数 */
    aiot_ota_setopt(ota_handle, AIOT_OTAOPT_RECV_HANDLER, user_ota_recv_handler);
    g_ota_handle = ota_handle;

    /* 与服务器建立MQTT连接 */
    res = aiot_mqtt_connect(mqtt_handle);
    if (res < STATE_SUCCESS) {
        printf("aiot_mqtt_connect failed: -0x%04X\r\n\r\n", -res);
        printf("please check variables like mqtt_host, produt_key, device_name, device_secret in demo\r\n");
        /* 尝试建立连接失败, 销毁MQTT实例, 回收资源 */
        goto exit;
    }

    /*   TODO: 非常重要!!!
     *
     *   cur_version 要根据用户实际情况, 改成从设备的配置区获取, 要反映真实的版本号, 而不能像示例这样写为固定值
     *
     *   1. 如果设备从未上报过版本号, 在控制台网页将无法部署升级任务
     *   2. 如果设备升级完成后, 上报的不是新的版本号, 在控制台网页将会显示升级失败
     *
     */

    cur_version = "1.0.0";
    /* 演示MQTT连接建立起来之后, 就可以上报当前设备的版本号了 */
    res = aiot_ota_report_version(ota_handle, cur_version);
    if (res < STATE_SUCCESS) {
        printf("report version failed, code is -0x%04X\r\n", -res);
    }

    while (1) {
        aiot_mqtt_process(mqtt_handle);
        aiot_mqtt_recv(mqtt_handle);
        if(g_dl_handle != NULL) {
            int32_t res = aiot_mqtt_download_process(g_dl_handle);

            if(STATE_MQTT_DOWNLOAD_SUCCESS == res) {
                /* 升级成功，这里重启并且上报新的版本号 */
                printf("mqtt download ota success \r\n");
                aiot_mqtt_download_deinit(&g_dl_handle);
                break;
            } else if(STATE_MQTT_DOWNLOAD_FAILED_RECVERROR == res
                      || STATE_MQTT_DOWNLOAD_FAILED_TIMEOUT == res
                      || STATE_MQTT_DOWNLOAD_FAILED_MISMATCH == res) {
                printf("mqtt download ota failed \r\n");
                aiot_mqtt_download_deinit(&g_dl_handle);
                break;
            }
        }
    }

    aiot_ota_deinit(&ota_handle);
    /* 断开MQTT连接, 一般不会运行到这里 */
    res = aiot_mqtt_disconnect(mqtt_handle);
    if (res < STATE_SUCCESS) {
        printf("aiot_mqtt_disconnect failed: -0x%04X\r\n", -res);
        goto exit;
    }

exit:
    while (1) {
        /* 销毁MQTT实例, 一般不会运行到这里 */
        res = aiot_mqtt_deinit(&mqtt_handle);

        if (res < STATE_SUCCESS) {
            printf("aiot_mqtt_deinit failed: -0x%04X\r\n", -res);
            return -1;
        } else {
            break;
        }
    }

    /* 销毁OTA实例, 一般不会运行到这里 */
    aiot_ota_deinit(&ota_handle);

    return 0;
}


