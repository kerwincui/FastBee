#include "core_adapter.h"
#include "aiot_state_api.h"
#include "core_log.h"

static aiot_sysdep_portfile_t *g_origin_portfile = NULL;
static aiot_sysdep_portfile_t g_aiot_portfile;
/*
 *  CORE_ADAPTER_MBEDTLS_ENABLED 不是一个用户需要关心的编译开关
 *
 *  大多数情况下, 就保持它如下的设置即可
 *  只有少数时候, SDK的用户关心对接层代码的ROM尺寸, 并且也没有选择用TLS连接服务器
 *  那时才会出现, 将 CORE_ADAPTER_MBEDTLS_ENABLED 宏定义关闭的改动, 以减小对接尺寸
 *
 *  我们不建议去掉 #define CORE_ADAPTER_MBEDTLS_ENABLED 这行代码
 *  虽然物联网平台接收TCP方式的连接, 但我们不推荐这样做, TLS是更安全的通信方式
 *
 */
#define CORE_ADAPTER_MBEDTLS_ENABLED
typedef struct {
    void    *(*core_sysdep_network_init)(void);
    int32_t (*core_sysdep_network_setopt)(void *handle, core_sysdep_network_option_t option, void *data);
    int32_t (*core_sysdep_network_establish)(void *handle);
    int32_t (*core_sysdep_network_recv)(void *handle, uint8_t *buffer, uint32_t len, uint32_t timeout_ms,
                                        core_sysdep_addr_t *addr);
    int32_t (*core_sysdep_network_send)(void *handle, uint8_t *buffer, uint32_t len, uint32_t timeout_ms,
                                        core_sysdep_addr_t *addr);
    int32_t (*core_sysdep_network_deinit)(void **handle);
} aiot_network_t;

#ifdef CORE_ADAPTER_MBEDTLS_ENABLED
#include "mbedtls/net_sockets.h"
#include "mbedtls/ssl.h"
#include "mbedtls/ctr_drbg.h"
#include "mbedtls/debug.h"
#include "mbedtls/platform.h"
#include "mbedtls/timing.h"

typedef struct {
    mbedtls_net_context          net_ctx;
    mbedtls_ssl_context          ssl_ctx;
    mbedtls_ssl_config           ssl_config;
    mbedtls_timing_delay_context timer_delay_ctx;
    mbedtls_x509_crt             x509_server_cert;
    mbedtls_x509_crt             x509_client_cert;
    mbedtls_pk_context           x509_client_pk;
} core_sysdep_mbedtls_t;
#endif


typedef struct {
    void *network_handle;
    core_sysdep_socket_type_t socket_type;
    aiot_sysdep_network_cred_t *cred;
    char *host;
    char backup_ip[16];
    uint16_t port;
    uint32_t connect_timeout_ms;
#ifdef CORE_ADAPTER_MBEDTLS_ENABLED
    core_sysdep_psk_t psk;
    core_sysdep_mbedtls_t mbedtls;
#endif
} adapter_network_handle_t;

#ifdef CORE_ADAPTER_MBEDTLS_ENABLED
#define MBEDTLS_MEM_INFO_MAGIC  (0x12345678)

static uint32_t g_mbedtls_total_mem_used = 0;
static uint32_t g_mbedtls_max_mem_used = 0;
typedef struct {
    int32_t magic;
    int32_t size;
} mbedtls_mem_info_t;

static uint8_t _host_is_ip(char *host)
{
    uint32_t idx = 0;

    if (strlen(host) >= 16) {
        return 0;
    }

    for (idx = 0; idx < strlen(host); idx++) {
        if ((host[idx] != '.') && (host[idx] < '0' || host[idx] > '9')) {
            return 0;
        }
    }

    return 1;
}

static void *_core_mbedtls_calloc(size_t n, size_t size)
{
    uint8_t *buf = NULL;
    mbedtls_mem_info_t *mem_info = NULL;

    if (n == 0 || size == 0) {
        return NULL;
    }
    buf = (uint8_t *)g_origin_portfile->core_sysdep_malloc(n * size + sizeof(mbedtls_mem_info_t), "TLS");
    if (NULL == buf) {
        core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "error -- mbedtls malloc: %d failed\r\n", &size);
        return NULL;
    } else {
        memset(buf, 0, n * size + sizeof(mbedtls_mem_info_t));
    }

    mem_info = (mbedtls_mem_info_t *)buf;
    mem_info->magic = MBEDTLS_MEM_INFO_MAGIC;
    mem_info->size = n * size;
    buf += sizeof(mbedtls_mem_info_t);

    g_mbedtls_total_mem_used += mem_info->size;
    if (g_mbedtls_total_mem_used > g_mbedtls_max_mem_used) {
        g_mbedtls_max_mem_used = g_mbedtls_total_mem_used;
    }

    /*core_log3(g_origin_portfile, STATE_ADAPTER_COMMON, "INFO -- mbedtls malloc: %d  total used: %d  max used: %d\r\n",
                       &size, &g_mbedtls_total_mem_used, &g_mbedtls_max_mem_used);*/

    return buf;
}

static void _core_mbedtls_free(void *ptr)
{
    mbedtls_mem_info_t *mem_info = NULL;
    if (NULL == ptr) {
        return;
    }

    mem_info = (mbedtls_mem_info_t *)((uint8_t *)ptr - sizeof(mbedtls_mem_info_t));
    if (mem_info->magic != MBEDTLS_MEM_INFO_MAGIC) {
        core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "Warning - invalid mem info magic: %d\r\n", &mem_info->magic);
        return;
    }

    g_mbedtls_total_mem_used -= mem_info->size;
    /*core_log3(g_origin_portfile, STATE_ADAPTER_COMMON, "INFO -- mbedtls free: %d  total used: %d  max used: %d\r\n",
                       &mem_info->size, &g_mbedtls_total_mem_used, &g_mbedtls_max_mem_used);*/

    g_origin_portfile->core_sysdep_free(mem_info);
}

static int32_t _core_mbedtls_random(void *handle, uint8_t *output, size_t output_len)
{
    g_origin_portfile->core_sysdep_rand(output, output_len);
    return 0;
}

static void _core_mbedtls_debug(void *ctx, int32_t level, const char *file, int32_t line, const char *str)
{
    ((void) level);
    if (NULL != ctx) {
        core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "%s\r\n", (char *)str);
    }
}


static int32_t _core_mbedtls_net_send(void *ctx, const uint8_t *buf, size_t len)
{
    int32_t ret = g_origin_portfile->core_sysdep_network_send(ctx, (uint8_t *)buf, len, 5000, NULL);
    /*core_log2(g_origin_portfile, STATE_ADAPTER_COMMON, "_core_mbedtls_net_send %d, ret %d\r\n", &len, &ret);*/
    return ret;
}

static int32_t _core_mbedtls_net_recv(void *ctx, uint8_t *buf, size_t len)
{
    int32_t ret = g_origin_portfile->core_sysdep_network_recv(ctx, buf, len, 5000, NULL);
    if (ret < 0) {
        return (MBEDTLS_ERR_NET_RECV_FAILED);
    } else {
        return ret;
    }
}
static int32_t _core_mbedtls_net_recv_timeout(void *ctx, uint8_t *buf, size_t len,
        uint32_t timeout)
{
    int32_t ret = g_origin_portfile->core_sysdep_network_recv(ctx, buf, len, timeout, NULL);
    /*core_log2(g_origin_portfile, STATE_ADAPTER_COMMON, "_core_mbedtls_net_recv_timeout %d, ret %d\r\n", &len, &ret);*/
    if (ret < 0) {
        return (MBEDTLS_ERR_NET_RECV_FAILED);
    } else {
        return ret;
    }
}


unsigned long _core_mbedtls_timing_get_timer(struct mbedtls_timing_hr_time *val, int32_t reset)
{
    unsigned long delta;
    unsigned long offset;
    unsigned long *p_hr_time = (unsigned long *)&val->opaque;

    offset = g_origin_portfile->core_sysdep_time();
    if (reset) {
        *p_hr_time = offset;
        return (0);
    }
    delta = offset - *p_hr_time;

    return (delta);
}

void _core_mbedtls_timing_set_delay(void *data, uint32_t int_ms, uint32_t fin_ms)
{
    mbedtls_timing_delay_context *ctx = (mbedtls_timing_delay_context *) data;

    ctx->int_ms = int_ms;
    ctx->fin_ms = fin_ms;
    if (fin_ms != 0) {
        (void) _core_mbedtls_timing_get_timer(&ctx->timer, 1);
    }
}

/*
 * Get number of delays expired
 */
int32_t _core_mbedtls_timing_get_delay(void *data)
{
    mbedtls_timing_delay_context *ctx = (mbedtls_timing_delay_context *) data;
    unsigned long elapsed_ms;

    if (ctx->fin_ms == 0) {
        return (-1);
    }

    elapsed_ms = _core_mbedtls_timing_get_timer(&ctx->timer, 0);
    if (elapsed_ms >= ctx->fin_ms) {
        return (2);
    }

    if (elapsed_ms >= ctx->int_ms) {
        return (1);
    }

    return (0);
}

int32_t _tls_network_establish(void *handle)
{
    adapter_network_handle_t *adapter_handle = (adapter_network_handle_t *)handle;
    int32_t res = 0;
    core_log2(g_origin_portfile, STATE_ADAPTER_COMMON, "establish mbedtls connection with server(host='%s', port=[%d])\r\n",
              adapter_handle->host, &adapter_handle->port);

    if (adapter_handle->cred->max_tls_fragment == 0) {
        core_log(g_origin_portfile, STATE_ADAPTER_COMMON, "invalid max_tls_fragment parameter\r\n");
        return STATE_PORT_TLS_INVALID_MAX_FRAGMENT;
    }
    if (adapter_handle->cred->max_tls_fragment <= 512) {
        res = mbedtls_ssl_conf_max_frag_len(&adapter_handle->mbedtls.ssl_config, MBEDTLS_SSL_MAX_FRAG_LEN_512);
    } else if (adapter_handle->cred->max_tls_fragment <= 1024) {
        res = mbedtls_ssl_conf_max_frag_len(&adapter_handle->mbedtls.ssl_config, MBEDTLS_SSL_MAX_FRAG_LEN_1024);
    } else if (adapter_handle->cred->max_tls_fragment <= 2048) {
        res = mbedtls_ssl_conf_max_frag_len(&adapter_handle->mbedtls.ssl_config, MBEDTLS_SSL_MAX_FRAG_LEN_2048);
    } else if (adapter_handle->cred->max_tls_fragment <= 4096) {
        res = mbedtls_ssl_conf_max_frag_len(&adapter_handle->mbedtls.ssl_config, MBEDTLS_SSL_MAX_FRAG_LEN_4096);
    } else {
        res = mbedtls_ssl_conf_max_frag_len(&adapter_handle->mbedtls.ssl_config, MBEDTLS_SSL_MAX_FRAG_LEN_NONE);
    }
    if (res < 0) {
        core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "mbedtls_ssl_conf_max_frag_len error, res: %x\r\n", &res);
        return res;
    }
    if (adapter_handle->socket_type == CORE_SYSDEP_SOCKET_TCP_CLIENT) {
        res = mbedtls_ssl_config_defaults(&adapter_handle->mbedtls.ssl_config, MBEDTLS_SSL_IS_CLIENT,
                                          MBEDTLS_SSL_TRANSPORT_STREAM, MBEDTLS_SSL_PRESET_DEFAULT);
    } else if (adapter_handle->socket_type == CORE_SYSDEP_SOCKET_UDP_CLIENT) {
        res = mbedtls_ssl_config_defaults(&adapter_handle->mbedtls.ssl_config, MBEDTLS_SSL_IS_CLIENT,
                                          MBEDTLS_SSL_TRANSPORT_DATAGRAM, MBEDTLS_SSL_PRESET_DEFAULT);
    }

    if (res < 0) {
        core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "mbedtls_ssl_config_defaults error, res: %x\r\n", &res);
        return res;
    }

    mbedtls_ssl_conf_max_version(&adapter_handle->mbedtls.ssl_config, MBEDTLS_SSL_MAJOR_VERSION_3,
                                 MBEDTLS_SSL_MINOR_VERSION_3);
    mbedtls_ssl_conf_min_version(&adapter_handle->mbedtls.ssl_config, MBEDTLS_SSL_MAJOR_VERSION_3,
                                 MBEDTLS_SSL_MINOR_VERSION_3);
    mbedtls_ssl_conf_handshake_timeout(&adapter_handle->mbedtls.ssl_config, (MBEDTLS_SSL_DTLS_TIMEOUT_DFL_MIN * 2),
                                       (MBEDTLS_SSL_DTLS_TIMEOUT_DFL_MIN * 2 * 4));
    mbedtls_ssl_conf_rng(&adapter_handle->mbedtls.ssl_config, _core_mbedtls_random, NULL);
    mbedtls_ssl_conf_dbg(&adapter_handle->mbedtls.ssl_config, _core_mbedtls_debug, stdout);

    if (adapter_handle->cred->option == AIOT_SYSDEP_NETWORK_CRED_SVRCERT_CA) {
        if (adapter_handle->cred->x509_server_cert == NULL && adapter_handle->cred->x509_server_cert_len == 0) {
            core_log(g_origin_portfile, STATE_ADAPTER_COMMON, "invalid x509 server cert\r\n");
            return STATE_PORT_TLS_INVALID_SERVER_CERT;
        }
        mbedtls_x509_crt_init(&adapter_handle->mbedtls.x509_server_cert);

        res = mbedtls_x509_crt_parse(&adapter_handle->mbedtls.x509_server_cert,
                                     (const uint8_t *)adapter_handle->cred->x509_server_cert, (size_t)adapter_handle->cred->x509_server_cert_len + 1);
        if (res < 0) {
            core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "mbedtls_x509_crt_parse server cert error, res: %x\r\n", &res);
            return STATE_PORT_TLS_INVALID_SERVER_CERT;
        }

        if (adapter_handle->cred->x509_client_cert != NULL && adapter_handle->cred->x509_client_cert_len > 0 &&
            adapter_handle->cred->x509_client_privkey != NULL && adapter_handle->cred->x509_client_privkey_len > 0) {
            mbedtls_x509_crt_init(&adapter_handle->mbedtls.x509_client_cert);
            mbedtls_pk_init(&adapter_handle->mbedtls.x509_client_pk);
            res = mbedtls_x509_crt_parse(&adapter_handle->mbedtls.x509_client_cert,
                                         (const uint8_t *)adapter_handle->cred->x509_client_cert, (size_t)adapter_handle->cred->x509_client_cert_len + 1);
            if (res < 0) {
                core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "mbedtls_x509_crt_parse client cert error, res: %x\r\n", &res);
                return STATE_PORT_TLS_INVALID_CLIENT_CERT;
            }
            res = mbedtls_pk_parse_key(&adapter_handle->mbedtls.x509_client_pk,
                                       (const uint8_t *)adapter_handle->cred->x509_client_privkey,
                                       (size_t)adapter_handle->cred->x509_client_privkey_len + 1, NULL, 0);
            if (res < 0) {
                core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "mbedtls_pk_parse_key client pk error, res: %x\r\n", &res);
                return STATE_PORT_TLS_INVALID_CLIENT_KEY;
            }
            res = mbedtls_ssl_conf_own_cert(&adapter_handle->mbedtls.ssl_config, &adapter_handle->mbedtls.x509_client_cert,
                                            &adapter_handle->mbedtls.x509_client_pk);
            if (res < 0) {
                core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "mbedtls_ssl_conf_own_cert error, res: %x\r\n", &res);
                return STATE_PORT_TLS_INVALID_CLIENT_CERT;
            }
        }
        mbedtls_ssl_conf_ca_chain(&adapter_handle->mbedtls.ssl_config, &adapter_handle->mbedtls.x509_server_cert, NULL);
    } else if (adapter_handle->cred->option == AIOT_SYSDEP_NETWORK_CRED_SVRCERT_PSK) {
        static const int32_t ciphersuites[1] = {MBEDTLS_TLS_PSK_WITH_AES_128_CBC_SHA};
        res = mbedtls_ssl_conf_psk(&adapter_handle->mbedtls.ssl_config,
                                   (const uint8_t *)adapter_handle->psk.psk, (size_t)strlen(adapter_handle->psk.psk),
                                   (const uint8_t *)adapter_handle->psk.psk_id, (size_t)strlen(adapter_handle->psk.psk_id));
        if (res < 0) {
            core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "mbedtls_ssl_conf_psk error, res: %x\r\n", &res);
            return STATE_PORT_TLS_CONFIG_PSK_FAILED;
        }

        mbedtls_ssl_conf_ciphersuites(&adapter_handle->mbedtls.ssl_config, ciphersuites);
    } else {
        core_log(g_origin_portfile, STATE_ADAPTER_COMMON, "unsupported security option\r\n");
        return STATE_PORT_TLS_INVALID_CRED_OPTION;
    }

    res = mbedtls_ssl_setup(&adapter_handle->mbedtls.ssl_ctx, &adapter_handle->mbedtls.ssl_config);
    if (res < 0) {
        core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "mbedtls_ssl_setup error, res: %x\r\n", &res);
        return res;
    }

    if (_host_is_ip(adapter_handle->host) == 0) {
        res = mbedtls_ssl_set_hostname(&adapter_handle->mbedtls.ssl_ctx, adapter_handle->host);
        if (res < 0) {
            core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "mbedtls_ssl_set_hostname error, res: %x\r\n", &res);
            return res;
        }
    }

    if (adapter_handle->socket_type == CORE_SYSDEP_SOCKET_UDP_CLIENT) {
        mbedtls_ssl_set_timer_cb(&adapter_handle->mbedtls.ssl_ctx, (void *)&adapter_handle->mbedtls.timer_delay_ctx,
                                 _core_mbedtls_timing_set_delay, _core_mbedtls_timing_get_delay);
    }
    mbedtls_ssl_set_bio(&adapter_handle->mbedtls.ssl_ctx, adapter_handle->network_handle, _core_mbedtls_net_send,
                        _core_mbedtls_net_recv, _core_mbedtls_net_recv_timeout);
    mbedtls_ssl_conf_read_timeout(&adapter_handle->mbedtls.ssl_config, adapter_handle->connect_timeout_ms);

    while ((res = mbedtls_ssl_handshake(&adapter_handle->mbedtls.ssl_ctx)) != 0) {
        if ((res != MBEDTLS_ERR_SSL_WANT_READ) && (res != MBEDTLS_ERR_SSL_WANT_WRITE)) {
            core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "mbedtls_ssl_handshake error, res: %x\r\n", &res);
            if (res == MBEDTLS_ERR_SSL_INVALID_RECORD) {
                res = STATE_PORT_TLS_INVALID_RECORD;
            } else {
                res = STATE_PORT_TLS_INVALID_HANDSHAKE;
            }
            return res;
        }
    }

    res = mbedtls_ssl_get_verify_result(&adapter_handle->mbedtls.ssl_ctx);
    if (res < 0) {
        core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "mbedtls_ssl_get_verify_result error, res: %x\r\n", &res);
        return res;
    }

    core_log2(g_origin_portfile, STATE_ADAPTER_COMMON,
              "success to establish mbedtls connection, (cost %d bytes in total, max used %d bytes)\r\n",
              &g_mbedtls_total_mem_used, &g_mbedtls_max_mem_used);
    return 0;
}
int32_t _tls_network_recv(void *handle, uint8_t *buffer, uint32_t len, uint32_t timeout_ms,
                          core_sysdep_addr_t *addr)
{
    int32_t res = 0;
    int32_t recv_bytes = 0;
    adapter_network_handle_t *adapter_handle = (adapter_network_handle_t *)handle;
    if (handle == NULL) {
        return STATE_PORT_INPUT_NULL_POINTER;
    }
    /*core_log2(g_origin_portfile, STATE_ADAPTER_COMMON, "_tls_network_recv， (cost %d bytes in total, max used %d bytes)\r\n",
        &len, &timeout_ms);*/
    _core_mbedtls_timing_set_delay(&adapter_handle->mbedtls.timer_delay_ctx, 0, 0);
    mbedtls_ssl_conf_read_timeout(&adapter_handle->mbedtls.ssl_config, timeout_ms);
    do {
        res = mbedtls_ssl_read(&adapter_handle->mbedtls.ssl_ctx, buffer + recv_bytes, len - recv_bytes);
        if (res < 0) {
            if (res == MBEDTLS_ERR_SSL_TIMEOUT) {
                break;
            } else if (res != MBEDTLS_ERR_SSL_WANT_READ &&
                       res != MBEDTLS_ERR_SSL_WANT_WRITE &&
                       res != MBEDTLS_ERR_SSL_CLIENT_RECONNECT) {
                if (recv_bytes == 0) {
                    core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "mbedtls_ssl_recv error, res: %x\r\n", &res);
                    if (res == MBEDTLS_ERR_SSL_PEER_CLOSE_NOTIFY) {
                        return STATE_PORT_TLS_RECV_CONNECTION_CLOSED;
                    } else if (res == MBEDTLS_ERR_SSL_INVALID_RECORD) {
                        return STATE_PORT_TLS_INVALID_RECORD;
                    } else {
                        return STATE_PORT_TLS_RECV_FAILED;
                    }
                }
                break;
            }
        } else if (res == 0) {
            break;
        } else {
            recv_bytes += res;
        }
    } while (recv_bytes < len);

    return recv_bytes;
}
int32_t _tls_network_send(void *handle, uint8_t *buffer, uint32_t len, uint32_t timeout_ms,
                          core_sysdep_addr_t *addr)
{
    int32_t res = 0;
    int32_t send_bytes = 0;
    uint64_t timestart_ms = 0, timenow_ms = 0;
    adapter_network_handle_t *adapter_handle = (adapter_network_handle_t *)handle;
    if (handle == NULL) {
        return STATE_PORT_INPUT_NULL_POINTER;
    }
    /* Start Time */
    timestart_ms = g_origin_portfile->core_sysdep_time();
    timenow_ms = timestart_ms;

    do {
        timenow_ms = g_origin_portfile->core_sysdep_time();

        if (timenow_ms - timestart_ms >= timenow_ms ||
            timeout_ms - (timenow_ms - timestart_ms) > timeout_ms) {
            break;
        }

        res = mbedtls_ssl_write(&adapter_handle->mbedtls.ssl_ctx, buffer + send_bytes, len - send_bytes);
        if (res < 0) {
            if (res != MBEDTLS_ERR_SSL_WANT_READ &&
                res != MBEDTLS_ERR_SSL_WANT_WRITE) {
                if (send_bytes == 0) {
                    core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "mbedtls_ssl_send error, res: %x\r\n", &res);
                    if (res == MBEDTLS_ERR_SSL_PEER_CLOSE_NOTIFY) {
                        return STATE_PORT_TLS_SEND_CONNECTION_CLOSED;
                    } else if (res == MBEDTLS_ERR_SSL_INVALID_RECORD) {
                        return STATE_PORT_TLS_INVALID_RECORD;
                    } else {
                        return STATE_PORT_TLS_SEND_FAILED;
                    }
                }
                break;
            } else {
                g_origin_portfile->core_sysdep_sleep(100);
            }
        } else if (res == 0) {
            break;
        } else {
            send_bytes += res;
        }
    } while (((timenow_ms - timestart_ms) < timeout_ms) && (send_bytes < len));

    return send_bytes;
}
#endif

void *adapter_network_init(void)
{
    adapter_network_handle_t *adapter_handle = NULL;

    adapter_handle = g_origin_portfile->core_sysdep_malloc(sizeof(adapter_network_handle_t), "TLS");
    if (adapter_handle == NULL) {
        return NULL;
    }
    memset(adapter_handle, 0, sizeof(adapter_network_handle_t));
    adapter_handle->network_handle = g_origin_portfile->core_sysdep_network_init();
#ifdef CORE_ADAPTER_MBEDTLS_ENABLED
    adapter_handle->psk.psk_id = NULL;
    adapter_handle->psk.psk = NULL;
    mbedtls_debug_set_threshold(0);
    mbedtls_ssl_init(&adapter_handle->mbedtls.ssl_ctx);
    mbedtls_ssl_config_init(&adapter_handle->mbedtls.ssl_config);
    //mbedtls_platform_set_calloc_free(_core_mbedtls_calloc, _core_mbedtls_free);
    g_mbedtls_total_mem_used = g_mbedtls_max_mem_used = 0;
#endif

    return adapter_handle;
}

int32_t adapter_network_setopt(void *handle, core_sysdep_network_option_t option, void *data)
{
    adapter_network_handle_t *adapter_handle = (adapter_network_handle_t *)handle;
    int32_t res = STATE_SUCCESS;

    if (handle == NULL || data == NULL) {
        return STATE_PORT_INPUT_NULL_POINTER;
    }

    if (option >= CORE_SYSDEP_NETWORK_MAX) {
        return STATE_PORT_INPUT_OUT_RANGE;
    }
    res = g_origin_portfile->core_sysdep_network_setopt(adapter_handle->network_handle, option, data);

#ifdef CORE_ADAPTER_MBEDTLS_ENABLED
    switch (option) {
        case CORE_SYSDEP_NETWORK_SOCKET_TYPE: {
            adapter_handle->socket_type = *(core_sysdep_socket_type_t *)data;
        }
        break;
        case CORE_SYSDEP_NETWORK_HOST: {
            adapter_handle->host = g_origin_portfile->core_sysdep_malloc(strlen(data) + 1, "TLS");
            if (adapter_handle->host == NULL) {
                core_log(g_origin_portfile, STATE_ADAPTER_COMMON, "malloc failed\r\n");
                return STATE_PORT_MALLOC_FAILED;
            }
            memset(adapter_handle->host, 0, strlen(data) + 1);
            memcpy(adapter_handle->host, data, strlen(data));
        }
        break;
        case CORE_SYSDEP_NETWORK_BACKUP_IP: {
            memcpy(adapter_handle->backup_ip, data, strlen(data));
        }
        break;
        case CORE_SYSDEP_NETWORK_PORT: {
            adapter_handle->port = *(uint16_t *)data;
        }
        break;
        case CORE_SYSDEP_NETWORK_CONNECT_TIMEOUT_MS: {
            adapter_handle->connect_timeout_ms = *(uint32_t *)data;
        }
        break;

        case CORE_SYSDEP_NETWORK_CRED: {
            adapter_handle->cred = g_origin_portfile->core_sysdep_malloc(sizeof(aiot_sysdep_network_cred_t), "TLS");
            if (adapter_handle->cred == NULL) {
                core_log(g_origin_portfile, STATE_ADAPTER_COMMON, "g_origin_portfile->core_sysdep_malloc failed\r\n");
                return STATE_PORT_MALLOC_FAILED;
            }
            memset(adapter_handle->cred, 0, sizeof(aiot_sysdep_network_cred_t));
            memcpy(adapter_handle->cred, data, sizeof(aiot_sysdep_network_cred_t));
        }
        break;
        case CORE_SYSDEP_NETWORK_PSK: {
            core_sysdep_psk_t *psk = (core_sysdep_psk_t *)data;
            adapter_handle->psk.psk_id = g_origin_portfile->core_sysdep_malloc(strlen(psk->psk_id) + 1, "TLS");
            if (adapter_handle->psk.psk_id == NULL) {
                core_log(g_origin_portfile, STATE_ADAPTER_COMMON, "g_origin_portfile->core_sysdep_malloc failed\r\n");
                return STATE_PORT_MALLOC_FAILED;
            }
            memset(adapter_handle->psk.psk_id, 0, strlen(psk->psk_id) + 1);
            memcpy(adapter_handle->psk.psk_id, psk->psk_id, strlen(psk->psk_id));
            adapter_handle->psk.psk = g_origin_portfile->core_sysdep_malloc(strlen(psk->psk) + 1, "TLS");
            if (adapter_handle->psk.psk == NULL) {
                g_origin_portfile->core_sysdep_free(adapter_handle->psk.psk_id);
                core_log(g_origin_portfile, STATE_ADAPTER_COMMON, "g_origin_portfile->core_sysdep_malloc failed\r\n");
                return STATE_PORT_MALLOC_FAILED;
            }
            memset(adapter_handle->psk.psk, 0, strlen(psk->psk) + 1);
            memcpy(adapter_handle->psk.psk, psk->psk, strlen(psk->psk));
        }
        break;

        default: {
            core_log1(g_origin_portfile, STATE_ADAPTER_COMMON, "adapter_network_setopt unkown option %d\r\n", &option);
        }
        break;
    }
#endif

    return res;
}

int32_t adapter_network_establish(void *handle)
{
    adapter_network_handle_t *adapter_handle = (adapter_network_handle_t *)handle;
    if (handle == NULL) {
        return STATE_PORT_INPUT_NULL_POINTER;
    }
    int32_t res = g_origin_portfile->core_sysdep_network_establish(adapter_handle->network_handle);
    if (res < STATE_SUCCESS) {
        return res;
    }
#ifdef CORE_ADAPTER_MBEDTLS_ENABLED
    if (adapter_handle->cred != NULL && adapter_handle->cred->option != AIOT_SYSDEP_NETWORK_CRED_NONE) {
        res = _tls_network_establish(adapter_handle);
    }
#endif
    return res;
}
int32_t adapter_network_recv(void *handle, uint8_t *buffer, uint32_t len, uint32_t timeout_ms,
                             core_sysdep_addr_t *addr)
{
    int32_t res = STATE_SUCCESS;
    adapter_network_handle_t *adapter_handle = (adapter_network_handle_t *)handle;
    if (handle == NULL) {
        return STATE_PORT_INPUT_NULL_POINTER;
    }
#ifdef CORE_ADAPTER_MBEDTLS_ENABLED
    if (adapter_handle->cred != NULL && adapter_handle->cred->option != AIOT_SYSDEP_NETWORK_CRED_NONE) {
        res = _tls_network_recv(handle, buffer, len, timeout_ms, addr);
    } else
#endif
    {
        res = g_origin_portfile->core_sysdep_network_recv(adapter_handle->network_handle, buffer, len, timeout_ms, addr);
    }

    return res;
}
int32_t adapter_network_send(void *handle, uint8_t *buffer, uint32_t len, uint32_t timeout_ms,
                             core_sysdep_addr_t *addr)
{
    int32_t res = STATE_SUCCESS;
    adapter_network_handle_t *adapter_handle = (adapter_network_handle_t *)handle;
    if (handle == NULL) {
        return STATE_PORT_INPUT_NULL_POINTER;
    }
#ifdef CORE_ADAPTER_MBEDTLS_ENABLED
    if (adapter_handle->cred != NULL && adapter_handle->cred->option != AIOT_SYSDEP_NETWORK_CRED_NONE) {
        res = _tls_network_send(handle, buffer, len, timeout_ms, addr);
    } else
#endif
    {
        res = g_origin_portfile->core_sysdep_network_send(adapter_handle->network_handle, buffer, len, timeout_ms, addr);
    }

    return res;
}

int32_t adapter_network_deinit(void **handle)
{
    adapter_network_handle_t *adapter_handle = NULL;

    if (handle == NULL || *handle == NULL) {
        return STATE_PORT_INPUT_NULL_POINTER;
    }
    adapter_handle = *(adapter_network_handle_t **)handle;


    if (adapter_handle->host != NULL) {
        g_origin_portfile->core_sysdep_free(adapter_handle->host);
        adapter_handle->host = NULL;
    }
#ifdef CORE_ADAPTER_MBEDTLS_ENABLED
    mbedtls_ssl_close_notify(&adapter_handle->mbedtls.ssl_ctx);
    if (adapter_handle->cred != NULL && adapter_handle->cred->option == AIOT_SYSDEP_NETWORK_CRED_SVRCERT_CA) {
        mbedtls_x509_crt_free(&adapter_handle->mbedtls.x509_server_cert);
        mbedtls_x509_crt_free(&adapter_handle->mbedtls.x509_client_cert);
        mbedtls_pk_free(&adapter_handle->mbedtls.x509_client_pk);
    }
    mbedtls_ssl_free(&adapter_handle->mbedtls.ssl_ctx);
    mbedtls_ssl_config_free(&adapter_handle->mbedtls.ssl_config);

    g_mbedtls_total_mem_used = g_mbedtls_max_mem_used = 0;
    if (adapter_handle->psk.psk_id != NULL) {
        g_origin_portfile->core_sysdep_free(adapter_handle->psk.psk_id);
        adapter_handle->psk.psk_id = NULL;
    }
    if (adapter_handle->psk.psk != NULL) {
        g_origin_portfile->core_sysdep_free(adapter_handle->psk.psk);
        adapter_handle->psk.psk = NULL;
    }
#endif
    if (adapter_handle->cred != NULL) {
        g_origin_portfile->core_sysdep_free(adapter_handle->cred);
        adapter_handle->cred = NULL;
    }
    core_log(g_origin_portfile, STATE_ADAPTER_COMMON, "adapter_network_deinit\r\n");
    g_origin_portfile->core_sysdep_network_deinit(&adapter_handle->network_handle);
    g_origin_portfile->core_sysdep_free(adapter_handle);
    *handle = NULL;

    return STATE_SUCCESS;
}

static aiot_network_t adapter_network = {
    adapter_network_init,
    adapter_network_setopt,
    adapter_network_establish,
    adapter_network_recv,
    adapter_network_send,
    adapter_network_deinit,
};

aiot_sysdep_portfile_t *aiot_sysdep_get_adapter_portfile(aiot_sysdep_portfile_t *portfile)
{
    if (portfile == NULL) {
        return NULL;
    }
    g_origin_portfile = portfile;
    g_aiot_portfile = *portfile;
    g_aiot_portfile.core_sysdep_network_init = adapter_network.core_sysdep_network_init;
    g_aiot_portfile.core_sysdep_network_setopt = adapter_network.core_sysdep_network_setopt;
    g_aiot_portfile.core_sysdep_network_establish = adapter_network.core_sysdep_network_establish;
    g_aiot_portfile.core_sysdep_network_recv = adapter_network.core_sysdep_network_recv;
    g_aiot_portfile.core_sysdep_network_send = adapter_network.core_sysdep_network_send;
    g_aiot_portfile.core_sysdep_network_deinit = adapter_network.core_sysdep_network_deinit;
    return &g_aiot_portfile;
}

