#include <stdio.h>
#include "http_download.h"
#include "aiot_state_api.h"
#include "core_http.h"
#include "aiot_sysdep_api.h"

#define HTTP_DOWNLOAD_HOST_MAX_LEN        512
#define HTTP_DOWNLOAD_PATH_MAX_LEN        512
#define HTTP_DOWNLOAD_DEFAULT_TLS_PORT    80
#define HTTP_DOWNLOAD_BUFFER_LEN          (2 * 1024)
#define HTTP_DOWNLOAD_RECV_TIMEOUT_MS     (5 * 1000)

#define HTTP_DOWNLOAD_HTTPCLIENT_MAX_URL_LEN           (256)
#define HTTP_DOWNLOAD_MAX_DIGIT_NUM_OF_UINT32          (20)
#define HTTP_DOWNLOAD_RESPONSE_PARTIAL                 (206)
#define HTTP_DOWNLOAD_RESPONSE_OK                      (200)

static const uint64_t crc64_table[256] = {
    0x0000000000000000, 0xb32e4cbe03a75f6f, 0xf4843657a840a05b, 0x47aa7ae9abe7ff34,
    0x7bd0c384ff8f5e33, 0xc8fe8f3afc28015c, 0x8f54f5d357cffe68, 0x3c7ab96d5468a107,
    0xf7a18709ff1ebc66, 0x448fcbb7fcb9e309, 0x0325b15e575e1c3d, 0xb00bfde054f94352,
    0x8c71448d0091e255, 0x3f5f08330336bd3a, 0x78f572daa8d1420e, 0xcbdb3e64ab761d61,
    0x7d9ba13851336649, 0xceb5ed8652943926, 0x891f976ff973c612, 0x3a31dbd1fad4997d,
    0x064b62bcaebc387a, 0xb5652e02ad1b6715, 0xf2cf54eb06fc9821, 0x41e11855055bc74e,
    0x8a3a2631ae2dda2f, 0x39146a8fad8a8540, 0x7ebe1066066d7a74, 0xcd905cd805ca251b,
    0xf1eae5b551a2841c, 0x42c4a90b5205db73, 0x056ed3e2f9e22447, 0xb6409f5cfa457b28,
    0xfb374270a266cc92, 0x48190ecea1c193fd, 0x0fb374270a266cc9, 0xbc9d3899098133a6,
    0x80e781f45de992a1, 0x33c9cd4a5e4ecdce, 0x7463b7a3f5a932fa, 0xc74dfb1df60e6d95,
    0x0c96c5795d7870f4, 0xbfb889c75edf2f9b, 0xf812f32ef538d0af, 0x4b3cbf90f69f8fc0,
    0x774606fda2f72ec7, 0xc4684a43a15071a8, 0x83c230aa0ab78e9c, 0x30ec7c140910d1f3,
    0x86ace348f355aadb, 0x3582aff6f0f2f5b4, 0x7228d51f5b150a80, 0xc10699a158b255ef,
    0xfd7c20cc0cdaf4e8, 0x4e526c720f7dab87, 0x09f8169ba49a54b3, 0xbad65a25a73d0bdc,
    0x710d64410c4b16bd, 0xc22328ff0fec49d2, 0x85895216a40bb6e6, 0x36a71ea8a7ace989,
    0x0adda7c5f3c4488e, 0xb9f3eb7bf06317e1, 0xfe5991925b84e8d5, 0x4d77dd2c5823b7ba,
    0x64b62bcaebc387a1, 0xd7986774e864d8ce, 0x90321d9d438327fa, 0x231c512340247895,
    0x1f66e84e144cd992, 0xac48a4f017eb86fd, 0xebe2de19bc0c79c9, 0x58cc92a7bfab26a6,
    0x9317acc314dd3bc7, 0x2039e07d177a64a8, 0x67939a94bc9d9b9c, 0xd4bdd62abf3ac4f3,
    0xe8c76f47eb5265f4, 0x5be923f9e8f53a9b, 0x1c4359104312c5af, 0xaf6d15ae40b59ac0,
    0x192d8af2baf0e1e8, 0xaa03c64cb957be87, 0xeda9bca512b041b3, 0x5e87f01b11171edc,
    0x62fd4976457fbfdb, 0xd1d305c846d8e0b4, 0x96797f21ed3f1f80, 0x2557339fee9840ef,
    0xee8c0dfb45ee5d8e, 0x5da24145464902e1, 0x1a083bacedaefdd5, 0xa9267712ee09a2ba,
    0x955cce7fba6103bd, 0x267282c1b9c65cd2, 0x61d8f8281221a3e6, 0xd2f6b4961186fc89,
    0x9f8169ba49a54b33, 0x2caf25044a02145c, 0x6b055fede1e5eb68, 0xd82b1353e242b407,
    0xe451aa3eb62a1500, 0x577fe680b58d4a6f, 0x10d59c691e6ab55b, 0xa3fbd0d71dcdea34,
    0x6820eeb3b6bbf755, 0xdb0ea20db51ca83a, 0x9ca4d8e41efb570e, 0x2f8a945a1d5c0861,
    0x13f02d374934a966, 0xa0de61894a93f609, 0xe7741b60e174093d, 0x545a57dee2d35652,
    0xe21ac88218962d7a, 0x5134843c1b317215, 0x169efed5b0d68d21, 0xa5b0b26bb371d24e,
    0x99ca0b06e7197349, 0x2ae447b8e4be2c26, 0x6d4e3d514f59d312, 0xde6071ef4cfe8c7d,
    0x15bb4f8be788911c, 0xa6950335e42fce73, 0xe13f79dc4fc83147, 0x521135624c6f6e28,
    0x6e6b8c0f1807cf2f, 0xdd45c0b11ba09040, 0x9aefba58b0476f74, 0x29c1f6e6b3e0301b,
    0xc96c5795d7870f42, 0x7a421b2bd420502d, 0x3de861c27fc7af19, 0x8ec62d7c7c60f076,
    0xb2bc941128085171, 0x0192d8af2baf0e1e, 0x4638a2468048f12a, 0xf516eef883efae45,
    0x3ecdd09c2899b324, 0x8de39c222b3eec4b, 0xca49e6cb80d9137f, 0x7967aa75837e4c10,
    0x451d1318d716ed17, 0xf6335fa6d4b1b278, 0xb199254f7f564d4c, 0x02b769f17cf11223,
    0xb4f7f6ad86b4690b, 0x07d9ba1385133664, 0x4073c0fa2ef4c950, 0xf35d8c442d53963f,
    0xcf273529793b3738, 0x7c0979977a9c6857, 0x3ba3037ed17b9763, 0x888d4fc0d2dcc80c,
    0x435671a479aad56d, 0xf0783d1a7a0d8a02, 0xb7d247f3d1ea7536, 0x04fc0b4dd24d2a59,
    0x3886b22086258b5e, 0x8ba8fe9e8582d431, 0xcc0284772e652b05, 0x7f2cc8c92dc2746a,
    0x325b15e575e1c3d0, 0x8175595b76469cbf, 0xc6df23b2dda1638b, 0x75f16f0cde063ce4,
    0x498bd6618a6e9de3, 0xfaa59adf89c9c28c, 0xbd0fe036222e3db8, 0x0e21ac88218962d7,
    0xc5fa92ec8aff7fb6, 0x76d4de52895820d9, 0x317ea4bb22bfdfed, 0x8250e80521188082,
    0xbe2a516875702185, 0x0d041dd676d77eea, 0x4aae673fdd3081de, 0xf9802b81de97deb1,
    0x4fc0b4dd24d2a599, 0xfceef8632775faf6, 0xbb44828a8c9205c2, 0x086ace348f355aad,
    0x34107759db5dfbaa, 0x873e3be7d8faa4c5, 0xc094410e731d5bf1, 0x73ba0db070ba049e,
    0xb86133d4dbcc19ff, 0x0b4f7f6ad86b4690, 0x4ce50583738cb9a4, 0xffcb493d702be6cb,
    0xc3b1f050244347cc, 0x709fbcee27e418a3, 0x3735c6078c03e797, 0x841b8ab98fa4b8f8,
    0xadda7c5f3c4488e3, 0x1ef430e13fe3d78c, 0x595e4a08940428b8, 0xea7006b697a377d7,
    0xd60abfdbc3cbd6d0, 0x6524f365c06c89bf, 0x228e898c6b8b768b, 0x91a0c532682c29e4,
    0x5a7bfb56c35a3485, 0xe955b7e8c0fd6bea, 0xaeffcd016b1a94de, 0x1dd181bf68bdcbb1,
    0x21ab38d23cd56ab6, 0x9285746c3f7235d9, 0xd52f0e859495caed, 0x6601423b97329582,
    0xd041dd676d77eeaa, 0x636f91d96ed0b1c5, 0x24c5eb30c5374ef1, 0x97eba78ec690119e,
    0xab911ee392f8b099, 0x18bf525d915feff6, 0x5f1528b43ab810c2, 0xec3b640a391f4fad,
    0x27e05a6e926952cc, 0x94ce16d091ce0da3, 0xd3646c393a29f297, 0x604a2087398eadf8,
    0x5c3099ea6de60cff, 0xef1ed5546e415390, 0xa8b4afbdc5a6aca4, 0x1b9ae303c601f3cb,
    0x56ed3e2f9e224471, 0xe5c372919d851b1e, 0xa26908783662e42a, 0x114744c635c5bb45,
    0x2d3dfdab61ad1a42, 0x9e13b115620a452d, 0xd9b9cbfcc9edba19, 0x6a978742ca4ae576,
    0xa14cb926613cf817, 0x1262f598629ba778, 0x55c88f71c97c584c, 0xe6e6c3cfcadb0723,
    0xda9c7aa29eb3a624, 0x69b2361c9d14f94b, 0x2e184cf536f3067f, 0x9d36004b35545910,
    0x2b769f17cf112238, 0x9858d3a9ccb67d57, 0xdff2a94067518263, 0x6cdce5fe64f6dd0c,
    0x50a65c93309e7c0b, 0xe388102d33392364, 0xa4226ac498dedc50, 0x170c267a9b79833f,
    0xdcd7181e300f9e5e, 0x6ff954a033a8c131, 0x28532e49984f3e05, 0x9b7d62f79be8616a,
    0xa707db9acf80c06d, 0x14299724cc279f02, 0x5383edcd67c06036, 0xe0ada17364673f59
};


uint64_t crc64_update(uint64_t crc, const unsigned char *s, uint64_t l) {

    crc = ~crc;
    while (l != 0) {
        crc = crc64_table[*s++ ^ (crc & 0xFF)] ^ (crc >> 8);
        --l;
    }
    return ~crc;
}

typedef struct {
    char host[HTTP_DOWNLOAD_HOST_MAX_LEN];
    char path[HTTP_DOWNLOAD_PATH_MAX_LEN];
    uint16_t port;
    file_save_func_t save_func;
    void *userdata;
    uint32_t range_start;
    uint32_t range_end;
    int32_t  https_enable;


    /* 运行时参数 */
    void            *http_handle;
    uint32_t        size_fetched;
    uint32_t        content_len;
    int32_t         http_rsp_status_code;
    int32_t         result;
    uint64_t        content_crc64;
    uint64_t        calc_crc64;
} http_download_t;

/* 位于external/ali_ca_cert.c中的服务器证书 */
extern const char *ali_ca_cert;
extern aiot_sysdep_portfile_t g_aiot_sysdep_portfile;

/* 解析URL, 从中解出来host, path */
static int32_t _download_parse_url(const char *url, char *host, uint32_t max_host_len, char *path,
                                   uint32_t max_path_len)
{
    char *host_ptr = (char *) strstr(url, "://");
    uint32_t host_len = 0;
    uint32_t path_len;
    char *path_ptr;
    char *fragment_ptr;

    if (host_ptr == NULL) {
        return HTTP_DOWNLOAD_ERR_URL_INVALID;
    }
    host_ptr += 3;

    path_ptr = strchr(host_ptr, '/');
    if (NULL == path_ptr) {
        return HTTP_DOWNLOAD_ERR_URL_INVALID;
    }

    if (host_len == 0) {
        host_len = path_ptr - host_ptr;
    }

    memcpy(host, host_ptr, host_len);
    host[host_len] = '\0';
    fragment_ptr = strchr(host_ptr, '#');
    if (fragment_ptr != NULL) {
        path_len = fragment_ptr - path_ptr;
    } else {
        path_len = strlen(path_ptr);
    }

    memcpy(path, path_ptr, path_len);
    path[path_len] = '\0';
    return STATE_SUCCESS;
}

static http_download_t *_http_download_init()
{
    http_download_t *download = g_aiot_sysdep_portfile.core_sysdep_malloc(sizeof(http_download_t), "");
    if(download == NULL) {
        return download;
    }

    memset(download, 0, sizeof(http_download_t));
    download->port = HTTP_DOWNLOAD_DEFAULT_TLS_PORT;
    download->result = STATE_SUCCESS;
    download->https_enable = 0;

    return download;
}

static void _http_download_deinit(http_download_t *download)
{
    if(download->http_handle != NULL) {
        core_http_deinit(&download->http_handle);
    }
    g_aiot_sysdep_portfile.core_sysdep_free(download);
}
/* 对于收到的http报文进行处理的回调函数, 内部处理完后再调用用户的回调函数 */
void _http_download_recv_handler(void *handle, const aiot_http_recv_t *packet, void *userdata)
{
    http_download_t *download = (http_download_t *)userdata;
    if (NULL == download || NULL == packet) {
        return;
    }
    switch (packet->type) {
    case AIOT_HTTPRECV_STATUS_CODE : {
        download->http_rsp_status_code = packet->data.status_code.code;
    }
    break;
    case AIOT_HTTPRECV_HEADER: {
        if ((strlen(packet->data.header.key) == strlen("Content-Length")) &&
                (memcmp(packet->data.header.key, "Content-Length", strlen(packet->data.header.key)) == 0)) {
            uint32_t size = 0;

            /* 在用户指定的range并非全部固件的情况下, content_len < size_total, 所以不能简单替换 */
            core_str2uint(packet->data.header.value, (uint8_t)strlen(packet->data.header.value), &size);

            /* 该字段表示用户期望总共下载多少字节. 如果字段为0, 表示未设置过, 则设置为总共的字节数 */
            download->content_len = (download->content_len > 0) ? download->content_len : size;
        }

        /* 只有整个文件下载触发校验 */
        if(download->range_start == 0 && download->range_end == 0) {
            if ((strlen(packet->data.header.key) == strlen("x-oss-hash-crc64ecma")) &&
                    (memcmp(packet->data.header.key, "x-oss-hash-crc64ecma", strlen(packet->data.header.key)) == 0)) {
                core_str2uint64(packet->data.header.value, (uint8_t)strlen(packet->data.header.value), &download->content_crc64);
                download->calc_crc64 = 0;
            }
        }
    }
    break;
    case AIOT_HTTPRECV_BODY: {
        if (HTTP_DOWNLOAD_RESPONSE_OK != download->http_rsp_status_code
                /* HTTP回复报文的code应该是200或者206, 否则这个下载链接不可用 */
                && HTTP_DOWNLOAD_RESPONSE_PARTIAL != download->http_rsp_status_code) {
            download->result = HTTP_DOWNLOAD_ERR_FETCH_FAILED;
            core_log(NULL, 0, "wrong http respond code\r\n");
        } else if (0 == download->content_len) {
            /* HTTP回复报文的header里面应该有Content-Length, 否则这个下载链接为trunked编码, 不可用 */
            download->result = HTTP_DOWNLOAD_ERR_FETCH_FAILED;
            core_log(NULL, 0, "wrong http respond header\r\n");
        } else {
            /* 正常的固件的报文 */
            /* 在按照多个range分片下载的情况下, 判断用户下载到的固件的累计大小是否超过了整体的值 */
            if (download->size_fetched > download->content_len) {
                core_log(NULL, 0, "downloaded exceeds expected\r\n");
                break;
            }

            if(download->result >= 0) {
                int32_t offset = download->size_fetched + download->range_start;
                download->save_func(offset, packet->data.body.buffer, packet->data.body.len, download->userdata);
            }

            /* 该字段表示累计下载了多少字节, 不区分range */
            download->size_fetched += packet->data.body.len;

            /* 计算digest, 如果下载完成, 还要看看是否与云端计算出来的一致 */
            download->calc_crc64 = crc64_update(download->calc_crc64, packet->data.body.buffer, packet->data.body.len);
            if (download->size_fetched == download->content_len) {
                /* 不需要校验或者校验成功 */
                if(download->content_crc64 == 0) {
                    /* 不需要校验 */
                    download->result = STATE_SUCCESS;
                }
                else if(download->content_crc64 == download->calc_crc64) {
                    download->result = STATE_SUCCESS;
                    core_log(NULL, 0, "crc64 matched\r\n");
                } else {
                    download->result = HTTP_DOWNLOAD_ERR_CHECKSUM_MISMATCH;
                    core_log(NULL, 0, "crc64 mismatch\r\n");
                }
            }
        }
    }
    break;
    default:
        break;
    }
}

static int32_t _http_download_connect(http_download_t *download)
{
    int32_t res = STATE_SUCCESS;
    uint32_t default_body_max_len = HTTP_DOWNLOAD_BUFFER_LEN;
    uint32_t default_timeout_ms = HTTP_DOWNLOAD_RECV_TIMEOUT_MS;
    void *http_handle = core_http_init();
    if(http_handle == NULL) {
        return STATE_PORT_MALLOC_FAILED;
    }

    aiot_sysdep_network_cred_t cred;
    memset(&cred, 0, sizeof(aiot_sysdep_network_cred_t));
    if(download->https_enable == 0) {
        download->port = 80;
    } else {
        download->port = 443;
        cred.option = AIOT_SYSDEP_NETWORK_CRED_SVRCERT_CA;  /* 使用RSA证书校验MQTT服务端 */
        cred.max_tls_fragment = 16384; /* 最大的分片长度为16K, 其它可选值还有4K, 2K, 1K, 0.5K */
        cred.sni_enabled = 1;                               /* TLS建连时, 支持Server Name Indicator */
        cred.x509_server_cert = ali_ca_cert;                 /* 用来验证MQTT服务端的RSA根证书 */
        cred.x509_server_cert_len = strlen(ali_ca_cert);     /* 用来验证MQTT服务端的RSA根证书长度 */
    }

    if ((STATE_SUCCESS != core_http_setopt(http_handle, CORE_HTTPOPT_RECV_HANDLER, _http_download_recv_handler)) ||
            (STATE_SUCCESS != core_http_setopt(http_handle, CORE_HTTPOPT_USERDATA, (void *)download)) ||
            (STATE_SUCCESS != core_http_setopt(http_handle, CORE_HTTPOPT_BODY_BUFFER_MAX_LEN, (void *)&default_body_max_len)) ||
            (STATE_SUCCESS != core_http_setopt(http_handle, CORE_HTTPOPT_NETWORK_CRED, (void *)&cred)) ||
            (STATE_SUCCESS != core_http_setopt(http_handle, CORE_HTTPOPT_HOST, (void *)download->host)) ||
            (STATE_SUCCESS != core_http_setopt(http_handle, CORE_HTTPOPT_PORT, (void *)&download->port)) ||
            (STATE_SUCCESS != core_http_setopt(http_handle, CORE_HTTPOPT_RECV_TIMEOUT_MS, (void *)&default_timeout_ms))) {
        core_http_deinit(&http_handle);
        return STATE_PORT_MALLOC_FAILED;
    }

    res = core_http_connect(http_handle);
    if (res != STATE_SUCCESS) {
        core_http_deinit(&http_handle);
        return res;
    }

    download->http_handle = http_handle;
    return res;
}
static char header[1024];
static int32_t _http_download_send_request(http_download_t *download)
{
    int32_t pos = 0;
    core_http_request_t request = {
        .method = "GET",
        .path = download->path,
        .header = header,
        .content = NULL,
        .content_len = 0
    };

    memset(header, 0, sizeof(header));
    pos += sprintf(header + pos, "Accept: text/html, application/xhtml+xml, application/xml;q=0.9, */*;q=0.8\r\n");
    if(download->range_end != 0) {
        pos += sprintf(header + pos, "Range: bytes=%d-%d\r\n", download->range_start, download->range_end);
    } else {
        pos += sprintf(header + pos, "Range: bytes=%d-\r\n", download->range_start);
    }
    if(pos < 0) {
        return HTTP_DOWNLOAD_ERR_UNKOWN;
    }

    return core_http_send(download->http_handle, &request);
}

static int32_t _http_download_recv(http_download_t *download)
{
    int32_t res = STATE_SUCCESS;
    while(1) {
        res = core_http_recv(download->http_handle);
        if(res < 0) {
            break;
        }
    }

    if(res == STATE_HTTP_READ_BODY_FINISHED) {
        res = STATE_SUCCESS;
    }

    return res;
}

int32_t core_http_download_request(char *url, http_download_params_t *extra_params, file_save_func_t save_func, void* userdata)
{
    int32_t res = STATE_SUCCESS;
    http_download_t *download = NULL;

    if(url == NULL || save_func == NULL) {
        return -1;
    }

    download = _http_download_init();
    if(download == NULL) {
        return -1;
    }

    res = _download_parse_url(url, download->host, HTTP_DOWNLOAD_HOST_MAX_LEN, download->path,
                              HTTP_DOWNLOAD_PATH_MAX_LEN);
    if (res != STATE_SUCCESS) {
        _http_download_deinit(download);
        return HTTP_DOWNLOAD_ERR_URL_INVALID;
    }

    if(extra_params != NULL) {
        download->range_start = extra_params->range_start;
        download->range_end = extra_params->range_end;
        download->https_enable = extra_params->https_enable;
    }
    download->save_func = save_func;
    download->userdata = userdata;

    /* 建立连接 */
    res = _http_download_connect(download);
    if(res < STATE_SUCCESS) {
        _http_download_deinit(download);
        return HTTP_DOWNLOAD_ERR_URL_INVALID;
    }

    /* 发送请求 */
    res = _http_download_send_request(download);
    if(res != STATE_SUCCESS) {
        _http_download_deinit(download);
        return res;
    }

    /* 接收数据 */
    res = _http_download_recv(download);
    res = download->result;

    _http_download_deinit(download);
    return res;
}
