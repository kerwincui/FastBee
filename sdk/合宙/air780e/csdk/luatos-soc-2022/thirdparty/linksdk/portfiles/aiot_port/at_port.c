#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>

#include "lwip/sockets.h"
#include "lwip/netdb.h"
#include "lwip/netif.h"
#include "lwip/inet.h"
#include "lwip/tcp.h"
#include "lwip/ip_addr.h"
#include "lwip/ip6_addr.h"

#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "common_api.h"

#include "aiot_state_api.h"
#include "aiot_sysdep_api.h"

/* socket建联时间默认最大值 */
#define CORE_SYSDEP_DEFAULT_CONNECT_TIMEOUT_MS (10 * 1000)

#define CORE_SYSDEP_MBEDTLS_ENABLED  
#define DEFAULT_SELECT_TIME_OUT	5000
#define DEFAULT_PDP_INDEX 1

#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
    #include "mbedtls/net_sockets.h"
    #include "mbedtls/ssl.h"
    #include "mbedtls/ctr_drbg.h"
    #include "mbedtls/debug.h"
    #include "mbedtls/platform.h"
    #include "mbedtls/timing.h"
#endif

#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
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
    int fd;
	uint16_t profile_idx;
    core_sysdep_socket_type_t socket_type;
    aiot_sysdep_network_cred_t *cred;
    char *host;
    char backup_ip[16];
    uint16_t port;
    uint32_t connect_timeout_ms;
#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
    core_sysdep_psk_t psk;
    core_sysdep_mbedtls_t mbedtls;
#endif
} core_network_handle_t;

#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
#define MBEDTLS_MEM_INFO_MAGIC  (0x12345678)

static unsigned int g_mbedtls_total_mem_used = 0;
static unsigned int g_mbedtls_max_mem_used = 0;

typedef struct {
    int magic;
    int size;
} mbedtls_mem_info_t;

#endif


void *core_sysdep_malloc(uint32_t size, char *name)
{
    return malloc(size);
}

void core_sysdep_free(void *ptr)
{
    if(ptr)
    	free(ptr);
	return;
}

uint64_t core_sysdep_time(void)
{
    return (xTaskGetTickCount() * portTICK_RATE_MS);
}

void core_sysdep_sleep(uint64_t time_ms)
{
    vTaskDelay(pdMS_TO_TICKS(time_ms));
}

void *core_sysdep_network_init(void)
{
    core_network_handle_t *handle = NULL;

    handle = malloc(sizeof(core_network_handle_t));
    if (handle == NULL) {
        return NULL;
    }
    memset(handle, 0, sizeof(core_network_handle_t));

    handle->connect_timeout_ms = CORE_SYSDEP_DEFAULT_CONNECT_TIMEOUT_MS;

    return handle;
}

int32_t core_sysdep_network_setopt(void *handle, core_sysdep_network_option_t option, void *data)
{
    core_network_handle_t *network_handle = (core_network_handle_t *)handle;

    if (handle == NULL || data == NULL) {
        return STATE_PORT_INPUT_NULL_POINTER;
    }

    if (option >= CORE_SYSDEP_NETWORK_MAX) {
        return STATE_PORT_INPUT_OUT_RANGE;
    }

    switch (option) {
        case CORE_SYSDEP_NETWORK_SOCKET_TYPE: {
            network_handle->socket_type = *(core_sysdep_socket_type_t *)data;
        }
        break;
        case CORE_SYSDEP_NETWORK_HOST: {
            network_handle->host = malloc(strlen(data) + 1);
            if (network_handle->host == NULL) {
                return STATE_PORT_MALLOC_FAILED;
            }
            memset(network_handle->host, 0, strlen(data) + 1);
            memcpy(network_handle->host, data, strlen(data));
        }
        break;
        case CORE_SYSDEP_NETWORK_BACKUP_IP: {
            memcpy(network_handle->backup_ip, data, strlen(data));
        }
        break;
        case CORE_SYSDEP_NETWORK_PORT: {
            network_handle->port = *(uint16_t *)data;
        }
        break;
        case CORE_SYSDEP_NETWORK_CONNECT_TIMEOUT_MS: {
            network_handle->connect_timeout_ms = *(uint32_t *)data;
        }
        break;
#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
        case CORE_SYSDEP_NETWORK_CRED: {
            network_handle->cred = malloc(sizeof(aiot_sysdep_network_cred_t));
            if (network_handle->cred == NULL) {
                return STATE_PORT_MALLOC_FAILED;
            }
            memset(network_handle->cred, 0, sizeof(aiot_sysdep_network_cred_t));
            memcpy(network_handle->cred, data, sizeof(aiot_sysdep_network_cred_t));
        }
        break;
        case CORE_SYSDEP_NETWORK_PSK: {
            core_sysdep_psk_t *psk = (core_sysdep_psk_t *)data;
            network_handle->psk.psk_id = malloc(strlen(psk->psk_id) + 1);
            if (network_handle->psk.psk_id == NULL) {
                return STATE_PORT_MALLOC_FAILED;
            }
            memset(network_handle->psk.psk_id, 0, strlen(psk->psk_id) + 1);
            memcpy(network_handle->psk.psk_id, psk->psk_id, strlen(psk->psk_id));
            network_handle->psk.psk = malloc(strlen(psk->psk) + 1);
            if (network_handle->psk.psk == NULL) {
                free(network_handle->psk.psk_id);
                return STATE_PORT_MALLOC_FAILED;
            }
            memset(network_handle->psk.psk, 0, strlen(psk->psk) + 1);
            memcpy(network_handle->psk.psk, psk->psk, strlen(psk->psk));
        }
        break;
#endif
        default: {
            DBG("unknown option\n");
        }
    }

    return STATE_SUCCESS;
}

static void _port_uint2str(uint16_t input, char *output)
{
    uint8_t i = 0, j = 0;
    char temp[6] = {0};

    do {
        temp[i++] = input % 10 + '0';
    } while ((input /= 10) > 0);

    do {
        output[--i] = temp[j++];
    } while (i > 0);
}

static int32_t _core_sysdep_network_connect(int profile_index, char *host, uint16_t port, int family, int socktype, int protocol, uint32_t timeout_ms, int *fd_out)
{

    int32_t res = STATE_SUCCESS;
    int fd = 0, sock_option = 0;
    char service[6] = {0};
    struct addrinfo  hints;
    struct addrinfo *addrInfoList = NULL, *pos = NULL;

    memset(&hints, 0, sizeof(struct addrinfo));
    hints.ai_family = family; 
    hints.ai_socktype = socktype;
    hints.ai_protocol = protocol;
    hints.ai_flags = 0;
    _port_uint2str(port, service);

    res = getaddrinfo(host, service, &hints, &addrInfoList);
	if(res != 0)
	{
        DBG("*** getaddrinfo_with_pcid fail ret =%d ***\r\n",res);
		return res;
	}
    DBG("getaddrinfo_with_pcid success profile_index=%d",profile_index);

    if (res == 0) 
    {
        for (pos = addrInfoList; pos != NULL; pos = pos->ai_next) {
            fd = socket(pos->ai_family, pos->ai_socktype, pos->ai_protocol);
            if (fd < 0) {
                res = STATE_PORT_NETWORK_SOCKET_CREATE_FAILED;
                continue;
            }
			
            res = fcntl(fd, F_GETFL, 0);
            DBG("fcntl res =%d",res);
            if (res != -1) {
                res = fcntl(fd, F_SETFL, sock_option | O_NONBLOCK);
                DBG("fcntl res =%d",res);
            }
            if (res == -1) {
                if (connect(fd, pos->ai_addr, pos->ai_addrlen) == 0) {
					*fd_out = fd;
                    res = STATE_SUCCESS;
                    break;
                } else {
                    res = STATE_PORT_NETWORK_CONNECT_FAILED;
                }
            } else 
            {
                fd_set read_sets;
				fd_set write_sets;
                struct timeval timeselect;
				socklen_t optlen = 0;
				int sock_error = 0;

                FD_ZERO(&write_sets);
				FD_ZERO(&read_sets);
                FD_SET(fd, &read_sets);
				FD_SET(fd, &write_sets);

				if(timeout_ms == 0 || timeout_ms < 2000)
					timeout_ms = DEFAULT_SELECT_TIME_OUT;
				
                timeselect.tv_sec = timeout_ms / 1000;
                timeselect.tv_usec = timeout_ms % 1000 * 1000;
                res =connect(fd, pos->ai_addr, pos->ai_addrlen);

                if (res == 0) {
                    *fd_out = fd;
                    res = STATE_SUCCESS;
                    DBG("connect success");
                    break;
                } else if (errno != EINPROGRESS) {
                    DBG("connect EINPROGRESS errno =%d",errno);
                    res = STATE_PORT_NETWORK_CONNECT_FAILED;
                } else 
                {
                    res = select(fd + 1, &read_sets, &write_sets, NULL, (struct timeval *)&timeselect);
                    if (res == 0 ) {
                        DBG("connect STATE_MQTT_LOG_CONNECT_TIMEOUT");                        
                        res = STATE_MQTT_LOG_CONNECT_TIMEOUT;
                    } else if (res < 0) {
                        DBG("connect STATE_PORT_NETWORK_CONNECT_FAILED");                        
                        res = STATE_PORT_NETWORK_CONNECT_FAILED;
                    } else {
						if(!FD_ISSET(fd, &read_sets) && !FD_ISSET(fd, &write_sets))
						{
							DBG("*** connect fail ***\r\n");
							res = STATE_PORT_NETWORK_CONNECT_FAILED;
						}
						else if(FD_ISSET(fd, &read_sets) && FD_ISSET(fd, &write_sets))
						{
							optlen = sizeof(sock_error);
							if(getsockopt(fd, SOL_SOCKET, SO_ERROR, &sock_error, &optlen) == 0 && sock_error == 0)
							{
								DBG("connect success\r\n");
                                *fd_out = fd;
                                res = STATE_SUCCESS;
                                break;
							}
							else
							{
								DBG("*** connect fail, sock_err = %d, errno = %u ***\r\n", sock_error, errno);
								res = STATE_PORT_NETWORK_CONNECT_FAILED;
							}
						}
						else if(!FD_ISSET(fd, &read_sets) && FD_ISSET(fd, &write_sets))
						{
							DBG("connect success\r\n");
                            *fd_out = fd;
                            res = STATE_SUCCESS;
                            break;
						}
						else if(FD_ISSET(fd, &read_sets) && !FD_ISSET(fd, &write_sets))
						{
							DBG("*** connect fail ***\r\n");
							res = STATE_PORT_NETWORK_CONNECT_FAILED;
						}
						else
						{
							DBG("*** connect fail ***\r\n");
							res = STATE_PORT_NETWORK_CONNECT_FAILED;
						}
                    }
                }				
            }
            close(fd);
            DBG("connect error, errno: %d\n", errno);
        }
    } else {
        res = STATE_PORT_NETWORK_DNS_FAILED;
    }

    if (res < 0) {
        DBG("fail to establish tcp , res: %d\r\n\r\n",res);
    } else {
        DBG("success to establish tcp, fd=%d\n", *fd_out);
        res = STATE_SUCCESS;
    }
    freeaddrinfo(addrInfoList);

    return res;
}

static int32_t _core_sysdep_network_tcp_establish(core_network_handle_t *network_handle)
{
    int32_t res = STATE_SUCCESS;

    DBG("establish tcp connection with server(host='%s', port=[%u])\n", network_handle->host, network_handle->port);

    res = _core_sysdep_network_connect(network_handle->profile_idx, network_handle->host, network_handle->port,
            AF_UNSPEC, SOCK_STREAM, IPPROTO_TCP, network_handle->connect_timeout_ms, &network_handle->fd);
    if (res == STATE_PORT_NETWORK_DNS_FAILED && strlen(network_handle->backup_ip) > 0) {
        DBG("using backup ip: %s\n", network_handle->backup_ip);
        res = _core_sysdep_network_connect(network_handle->profile_idx, network_handle->backup_ip, network_handle->port,
                AF_UNSPEC, SOCK_STREAM, IPPROTO_TCP, network_handle->connect_timeout_ms, &network_handle->fd);
    }

    return res;
}

static int32_t _core_sysdep_network_udp_server_establish(core_network_handle_t *network_handle)
{
    int32_t sockfd;
    struct sockaddr_in servaddr;
    int opt_val = 1;

    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) {
        return STATE_PORT_NETWORK_SOCKET_CREATE_FAILED;
    }

    if (0 != setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &opt_val, sizeof(opt_val))) {
       DBG("setsockopt(SO_REUSEADDR) falied, errno: %d\n", errno);
        //perror("setsockopt(SO_REUSEADDR) error");
        close(sockfd);
        return STATE_PORT_NETWORK_SOCKET_CONFIG_FAILED;
    }

    memset(&servaddr, 0, sizeof(struct sockaddr_in));
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(network_handle->port);

    if (-1 == bind(sockfd, (struct sockaddr *)&servaddr, sizeof(struct sockaddr_in))) {
        DBG("bind(%d) falied, errno: %d\n", (int)sockfd, errno);
        //perror("bind(%d) error");
        close(sockfd);
        return STATE_PORT_NETWORK_SOCKET_BIND_FAILED;
    }

    network_handle->fd = sockfd;
    DBG("success to establish udp, fd=%d\n", (int)sockfd);

    return 0;
}

#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
void core_sysdep_rand(uint8_t *output, uint32_t output_len);
static int _mbedtls_random(void *handle, unsigned char *output, size_t output_len)
{
    core_sysdep_rand(output, output_len);
    return 0;
}

static uint8_t _host_is_ip(char *host)
{
    uint32_t idx = 0;

    if (strlen(host) >= 16) {
        return 0;
    }

    for (idx = 0;idx < strlen(host);idx++) {
        if ((host[idx] != '.') && (host[idx] < '0' || host[idx] > '9')) {
            return 0;
        }
    }

    return 1;
}

static void _mbedtls_debug(void *ctx, int level, const char *file, int line, const char *str)
{
    ((void) level);
    if (NULL != ctx) {
        DBG("%s\n", str);
    }
}

//设置自定义证书校验,经过实际测试aliyun证书需要忽略Common Name (CN) 选项才可以校验通过
static int my_verify(void *data, mbedtls_x509_crt *crt,
                     int depth, uint32_t *flags)
{
    char buf[1024];
    ((void)data);

    DBG("\nVerify requested for (Depth %d):\n", depth);
    mbedtls_x509_crt_info(buf, sizeof(buf) - 1, "", crt);
    DBG("%s", buf);

    DBG("user ignore flags: 0x%08X, peer cert verify flags on curt way: 0x%08X", MBEDTLS_X509_BADCERT_NOT_TRUSTED, *flags);
    if (*flags & MBEDTLS_X509_BADCERT_NOT_TRUSTED)
    {
        *flags &= ~(MBEDTLS_X509_BADCERT_NOT_TRUSTED);
        mbedtls_x509_crt_verify_info(buf, sizeof(buf), "  ! ", *flags);
        DBG("%s\n", buf);
        return (0);
    }

    return (0);
}

static int32_t _core_sysdep_network_mbedtls_establish(core_network_handle_t *network_handle)
{
    int32_t res = 0;
    char port_str[6] = {0};
#if defined(MBEDTLS_DEBUG_C)
    mbedtls_debug_set_threshold(4);
#endif /* #if defined(MBEDTLS_DEBUG_C) */
    mbedtls_net_init(&network_handle->mbedtls.net_ctx);
    mbedtls_ssl_init(&network_handle->mbedtls.ssl_ctx);
    mbedtls_ssl_config_init(&network_handle->mbedtls.ssl_config);
//    mbedtls_platform_set_calloc_free(_core_mbedtls_calloc, _core_mbedtls_free);
    g_mbedtls_total_mem_used = g_mbedtls_max_mem_used = 0;

    if (network_handle->cred->max_tls_fragment == 0) {
        DBG("invalid max_tls_fragment parameter\n");
        return STATE_PORT_TLS_INVALID_MAX_FRAGMENT;
    }
    DBG("establish mbedtls connection with server(host='%s', port=[%u], profile_idx=[%d])\n", network_handle->host, network_handle->port,network_handle->profile_idx);

    _port_uint2str(network_handle->port, port_str);

    if (network_handle->cred->max_tls_fragment <= 512) {
        res = mbedtls_ssl_conf_max_frag_len(&network_handle->mbedtls.ssl_config, MBEDTLS_SSL_MAX_FRAG_LEN_512);
    } else if (network_handle->cred->max_tls_fragment <= 1024) {
        res = mbedtls_ssl_conf_max_frag_len(&network_handle->mbedtls.ssl_config, MBEDTLS_SSL_MAX_FRAG_LEN_1024);
    } else if (network_handle->cred->max_tls_fragment <= 2048) {
        res = mbedtls_ssl_conf_max_frag_len(&network_handle->mbedtls.ssl_config, MBEDTLS_SSL_MAX_FRAG_LEN_2048);
    } else if (network_handle->cred->max_tls_fragment <= 4096) {
        res = mbedtls_ssl_conf_max_frag_len(&network_handle->mbedtls.ssl_config, MBEDTLS_SSL_MAX_FRAG_LEN_4096);
    } else {
        res = mbedtls_ssl_conf_max_frag_len(&network_handle->mbedtls.ssl_config, MBEDTLS_SSL_MAX_FRAG_LEN_NONE);
    }

    if (res < 0) {
        DBG("mbedtls_ssl_conf_max_frag_len error, res: -0x%04X\n", -res);
        return res;
    }

    if (network_handle->socket_type == CORE_SYSDEP_SOCKET_TCP_CLIENT) {
        res = _core_sysdep_network_connect(network_handle->profile_idx, network_handle->host, network_handle->port,
                AF_UNSPEC, SOCK_STREAM, IPPROTO_TCP, network_handle->connect_timeout_ms, &network_handle->mbedtls.net_ctx.fd);
    } else if (network_handle->socket_type == CORE_SYSDEP_SOCKET_UDP_CLIENT) {
        res = _core_sysdep_network_connect(network_handle->profile_idx, network_handle->host, network_handle->port,
                AF_UNSPEC, SOCK_DGRAM, IPPROTO_UDP, network_handle->connect_timeout_ms, &network_handle->mbedtls.net_ctx.fd);
    }

    if (res == STATE_PORT_NETWORK_DNS_FAILED && (strlen(network_handle->backup_ip) > 0)) {
        DBG("using backup ip: %s\n", network_handle->backup_ip);
        if (network_handle->socket_type == CORE_SYSDEP_SOCKET_TCP_CLIENT) {
            res = _core_sysdep_network_connect(network_handle->profile_idx, network_handle->host, network_handle->port,
                    AF_UNSPEC, SOCK_STREAM, IPPROTO_TCP, network_handle->connect_timeout_ms, &network_handle->mbedtls.net_ctx.fd);
        } else if (network_handle->socket_type == CORE_SYSDEP_SOCKET_UDP_CLIENT) {
            res = _core_sysdep_network_connect(network_handle->profile_idx, network_handle->host, network_handle->port,
                    AF_UNSPEC, SOCK_DGRAM, IPPROTO_UDP, network_handle->connect_timeout_ms, &network_handle->mbedtls.net_ctx.fd);
        }
    }

    if (res < STATE_SUCCESS) {
        return res;
    }

    if (network_handle->socket_type == CORE_SYSDEP_SOCKET_TCP_CLIENT) {
        res = mbedtls_ssl_config_defaults(&network_handle->mbedtls.ssl_config, MBEDTLS_SSL_IS_CLIENT,
                                        MBEDTLS_SSL_TRANSPORT_STREAM, MBEDTLS_SSL_PRESET_DEFAULT);
    } else if (network_handle->socket_type == CORE_SYSDEP_SOCKET_UDP_CLIENT) {
        res = mbedtls_ssl_config_defaults(&network_handle->mbedtls.ssl_config, MBEDTLS_SSL_IS_CLIENT,
                                        MBEDTLS_SSL_TRANSPORT_DATAGRAM, MBEDTLS_SSL_PRESET_DEFAULT);
    }

    if (res < 0) {
        DBG("mbedtls_ssl_config_defaults error, res: -0x%04X\n", -res);
        return res;
    }

    mbedtls_ssl_conf_max_version(&network_handle->mbedtls.ssl_config, MBEDTLS_SSL_MAJOR_VERSION_3,
                                 MBEDTLS_SSL_MINOR_VERSION_3);
    mbedtls_ssl_conf_min_version(&network_handle->mbedtls.ssl_config, MBEDTLS_SSL_MAJOR_VERSION_3,
                                 MBEDTLS_SSL_MINOR_VERSION_3);
    mbedtls_ssl_conf_handshake_timeout(&network_handle->mbedtls.ssl_config,(MBEDTLS_SSL_DTLS_TIMEOUT_DFL_MIN * 2),
                                (MBEDTLS_SSL_DTLS_TIMEOUT_DFL_MIN * 2 * 4));
    mbedtls_ssl_conf_rng(&network_handle->mbedtls.ssl_config, _mbedtls_random, NULL);
    mbedtls_ssl_conf_dbg(&network_handle->mbedtls.ssl_config, _mbedtls_debug, "[MBEDTLS]");
    mbedtls_ssl_conf_verify(&network_handle->mbedtls.ssl_config, my_verify, NULL);

    if (network_handle->cred->option == AIOT_SYSDEP_NETWORK_CRED_SVRCERT_CA) {
        if (network_handle->cred->x509_server_cert == NULL && network_handle->cred->x509_server_cert_len == 0) {
            DBG("invalid x509 server cert\n");
            return STATE_PORT_TLS_INVALID_SERVER_CERT;
        }
        mbedtls_x509_crt_init(&network_handle->mbedtls.x509_server_cert);

        res = mbedtls_x509_crt_parse(&network_handle->mbedtls.x509_server_cert,
                                     (const unsigned char *)network_handle->cred->x509_server_cert, (size_t)network_handle->cred->x509_server_cert_len + 1);
        if (res < 0) {
            DBG("mbedtls_x509_crt_parse server cert error, res: -0x%04X\n", -res);
            return STATE_PORT_TLS_INVALID_SERVER_CERT;
        }

        if (network_handle->cred->x509_client_cert != NULL && network_handle->cred->x509_client_cert_len > 0 &&
            network_handle->cred->x509_client_privkey != NULL && network_handle->cred->x509_client_privkey_len > 0) {
            mbedtls_x509_crt_init(&network_handle->mbedtls.x509_client_cert);
            mbedtls_pk_init(&network_handle->mbedtls.x509_client_pk);
            res = mbedtls_x509_crt_parse(&network_handle->mbedtls.x509_client_cert,
                                         (const unsigned char *)network_handle->cred->x509_client_cert, (size_t)network_handle->cred->x509_client_cert_len + 1);
            if (res < 0) {
                DBG("mbedtls_x509_crt_parse client cert error, res: -0x%04X\n", -res);
                return STATE_PORT_TLS_INVALID_CLIENT_CERT;
            }
            res = mbedtls_pk_parse_key(&network_handle->mbedtls.x509_client_pk,
                                       (const unsigned char *)network_handle->cred->x509_client_privkey,
                                       (size_t)network_handle->cred->x509_client_privkey_len + 1, NULL, 0);
            if (res < 0) {
                DBG("mbedtls_pk_parse_key client pk error, res: -0x%04X\n", -res);
                return STATE_PORT_TLS_INVALID_CLIENT_KEY;
            }
            res = mbedtls_ssl_conf_own_cert(&network_handle->mbedtls.ssl_config, &network_handle->mbedtls.x509_client_cert,
                                            &network_handle->mbedtls.x509_client_pk);
            if (res < 0) {
                DBG("mbedtls_ssl_conf_own_cert error, res: -0x%04X\n", -res);
                return STATE_PORT_TLS_INVALID_CLIENT_CERT;
            }
        }
        mbedtls_ssl_conf_ca_chain(&network_handle->mbedtls.ssl_config, &network_handle->mbedtls.x509_server_cert, NULL);
    } else if (network_handle->cred->option == AIOT_SYSDEP_NETWORK_CRED_SVRCERT_PSK) {
        static const int ciphersuites[1] = {MBEDTLS_TLS_PSK_WITH_AES_128_CBC_SHA};
        res = mbedtls_ssl_conf_psk(&network_handle->mbedtls.ssl_config,
                                   (const unsigned char *)network_handle->psk.psk, (size_t)strlen(network_handle->psk.psk),
                                   (const unsigned char *)network_handle->psk.psk_id, (size_t)strlen(network_handle->psk.psk_id));
        if (res < 0) {
            DBG("mbedtls_ssl_conf_psk error, res = -0x%04X\n", -res);
            return STATE_PORT_TLS_CONFIG_PSK_FAILED;
        }

        mbedtls_ssl_conf_ciphersuites(&network_handle->mbedtls.ssl_config, ciphersuites);
    } else {
        DBG("unsupported security option\n");
        return STATE_PORT_TLS_INVALID_CRED_OPTION;
    }

    res = mbedtls_ssl_setup(&network_handle->mbedtls.ssl_ctx, &network_handle->mbedtls.ssl_config);
    if (res < 0) {
        DBG("mbedtls_ssl_setup error, res: -0x%04X\n", -res);
        return res;
    }

    if (_host_is_ip(network_handle->host) == 0) {
        res = mbedtls_ssl_set_hostname(&network_handle->mbedtls.ssl_ctx, network_handle->host);
        if (res < 0) {
            DBG("mbedtls_ssl_set_hostname error, res: -0x%04X\n", -res);
            return res;
        }
    }

    if (network_handle->socket_type == CORE_SYSDEP_SOCKET_UDP_CLIENT) {
        mbedtls_ssl_set_timer_cb(&network_handle->mbedtls.ssl_ctx, (void *)&network_handle->mbedtls.timer_delay_ctx,
                            mbedtls_timing_set_delay, mbedtls_timing_get_delay);
    }
    mbedtls_ssl_set_bio(&network_handle->mbedtls.ssl_ctx, &network_handle->mbedtls.net_ctx, mbedtls_net_send,
                        mbedtls_net_recv, mbedtls_net_recv_timeout);
    mbedtls_ssl_conf_read_timeout(&network_handle->mbedtls.ssl_config, network_handle->connect_timeout_ms);

	mbedtls_ssl_conf_authmode(&network_handle->mbedtls.ssl_config, MBEDTLS_SSL_VERIFY_OPTIONAL);

    while ((res = mbedtls_ssl_handshake(&network_handle->mbedtls.ssl_ctx)) != 0) {
        if ((res != MBEDTLS_ERR_SSL_WANT_READ) && (res != MBEDTLS_ERR_SSL_WANT_WRITE)) {
            DBG("mbedtls_ssl_handshake error, res: -0x%04X\n", -res);
            if (res == MBEDTLS_ERR_SSL_INVALID_RECORD) {
                res = STATE_PORT_TLS_INVALID_RECORD;
            } else {
                res = STATE_PORT_TLS_INVALID_HANDSHAKE;
            }
            return res;
        }
    }

    res = mbedtls_ssl_get_verify_result(&network_handle->mbedtls.ssl_ctx);
    if (res < 0) {
        DBG("mbedtls_ssl_get_verify_result error, res: -0x%04X\n", -res);
        return res;
    }

    DBG("success to establish mbedtls connection, fd = %d(cost %d bytes in total, max used %d bytes)\n",
           (int)network_handle->mbedtls.net_ctx.fd,
           g_mbedtls_total_mem_used, g_mbedtls_max_mem_used);

    return 0;
}
#endif



int32_t core_sysdep_network_establish(void *handle)
{
    core_network_handle_t *network_handle = (core_network_handle_t *)handle;

    if (handle == NULL) {
        return STATE_PORT_INPUT_NULL_POINTER;
    }

    if (network_handle->socket_type == CORE_SYSDEP_SOCKET_TCP_CLIENT) {
        if (network_handle->host == NULL) {
            return STATE_PORT_MISSING_HOST;
        }
        if (network_handle->cred == NULL) {
            return _core_sysdep_network_tcp_establish(network_handle);
        } else {
            if (network_handle->cred->option == AIOT_SYSDEP_NETWORK_CRED_NONE) {
                return _core_sysdep_network_tcp_establish(network_handle);
            }
#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
            else {
                return  _core_sysdep_network_mbedtls_establish(network_handle);
            }
#endif
        }

    } else if (network_handle->socket_type == CORE_SYSDEP_SOCKET_TCP_SERVER) {
        return STATE_PORT_TCP_SERVER_NOT_IMPLEMENT;
    } else if (network_handle->socket_type == CORE_SYSDEP_SOCKET_UDP_CLIENT) {
        if (network_handle->host == NULL) {
            return STATE_PORT_MISSING_HOST;
        }
        if (network_handle->cred == NULL) {
            return STATE_PORT_UDP_CLIENT_NOT_IMPLEMENT;
        } else {
            if (network_handle->cred->option == AIOT_SYSDEP_NETWORK_CRED_NONE) {
                return STATE_PORT_UDP_CLIENT_NOT_IMPLEMENT;
            }
#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
            else {
                return _core_sysdep_network_mbedtls_establish(network_handle);
            }
#endif
        }
    } else if (network_handle->socket_type == CORE_SYSDEP_SOCKET_UDP_SERVER) {
        return _core_sysdep_network_udp_server_establish(network_handle);
    }

    DBG("unknown nwk type or tcp host absent\n");

    return STATE_PORT_NETWORK_UNKNOWN_SOCKET_TYPE;
}


static int32_t _core_sysdep_network_tcp_recv(core_network_handle_t *network_handle, uint8_t *buffer, uint32_t len,
        uint32_t timeout_ms)
{
    int res = 0;
    int32_t recv_bytes = 0;
    ssize_t recv_res = 0;
    uint64_t timestart_ms = 0, timenow_ms = 0, timeselect_ms = 0;
    fd_set recv_sets;
    struct timeval timestart, timenow, timeselect;

    FD_ZERO(&recv_sets);
    FD_SET(network_handle->fd, &recv_sets);

    /* Start Time */
    timestart_ms = core_sysdep_time();
    timenow_ms = timestart_ms;

    do {
        timenow_ms = core_sysdep_time();

        if (timenow_ms - timestart_ms >= timenow_ms ||
            timeout_ms - (timenow_ms - timestart_ms) > timeout_ms) {
            break;
        }

        timeselect_ms = timeout_ms - (timenow_ms - timestart_ms);
        timeselect.tv_sec = timeselect_ms / 1000;
        timeselect.tv_usec = timeselect_ms % 1000 * 1000;

        res = select(network_handle->fd + 1, &recv_sets, NULL, NULL, (struct timeval *)&timeselect);
        if (res == 0) {
            /* DBG("_core_sysdep_network_tcp_recv, nwk select timeout\n"); */
            continue;
        } else if (res < 0) {
            DBG("_core_sysdep_network_tcp_recv, errno: %d\n", errno);
          //  perror("_core_sysdep_network_tcp_recv, nwk select failed: ");
            return STATE_PORT_NETWORK_SELECT_FAILED;
        } else {
            if (FD_ISSET(network_handle->fd, &recv_sets)) {
                recv_res = recv(network_handle->fd, buffer + recv_bytes, len - recv_bytes, 0);
                if (recv_res == 0) {
                    DBG("_core_sysdep_network_tcp_recv, nwk connection closed\n");
                    return STATE_PORT_NETWORK_RECV_CONNECTION_CLOSED;
                } else if (recv_res < 0) {
                    DBG("_core_sysdep_network_tcp_recv, errno: %d\n", errno);
                 //   perror("_core_sysdep_network_tcp_recv, nwk recv error: ");
                    if (errno == EINTR) {
                        continue;
                    }
                    return STATE_PORT_NETWORK_RECV_FAILED;
                } else {
                    recv_bytes += recv_res;
                    /* DBG("recv_bytes: %d, len: %d\n",recv_bytes,len); */
                    if (recv_bytes == len) {
                        break;
                    }
                }
            }
        }
    } while (((timenow_ms - timestart_ms) < timeout_ms) && (recv_bytes < len));

    /* DBG("%s: recv over\n",__FUNCTION__); */
    return recv_bytes;
}

static int32_t _core_sysdep_network_udp_recv(core_network_handle_t *network_handle, uint8_t *buffer, uint32_t len, uint32_t timeout_ms, core_sysdep_addr_t *addr)
{
    int res;
    struct sockaddr_in cliaddr;
    socklen_t addr_len = sizeof(cliaddr);
    fd_set read_fds;
    struct timeval timeout = {timeout_ms / 1000, (timeout_ms % 1000) * 1000};

    FD_ZERO(&read_fds);
    FD_SET(network_handle->fd, &read_fds);

    res = select(network_handle->fd + 1, &read_fds, NULL, NULL, (struct timeval *)&timeout);
    if (res == 0) {
        DBG("select timeout\n");
        return 0;
    }
    else if (res < 0) {
        DBG("_linux_nwk_udp_read select errno: %d\n", errno);
      //  perror("_linux_nwk_udp_read select error: ");
        return STATE_PORT_NETWORK_SELECT_FAILED;
    }

    res = recvfrom(network_handle->fd, buffer, len, 0, (struct sockaddr *)&cliaddr, &addr_len);
    if (res >= 0) {
        if (NULL != addr) {
            addr->port = ntohs(cliaddr.sin_port);
            strcpy((char *)addr->addr, inet_ntoa(cliaddr.sin_addr));
        }

        return res;
    } else {
        DBG("_linux_nwk_udp_read errno: %d\n", errno);
      //  perror("_linux_nwk_udp_read error: ");
        return STATE_PORT_NETWORK_RECV_FAILED;
    }
}

#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
static int32_t _core_sysdep_network_mbedtls_recv(core_network_handle_t *network_handle, uint8_t *buffer, uint32_t len,
        uint32_t timeout_ms)
{
    int res = 0;
    int32_t recv_bytes = 0;

    mbedtls_ssl_conf_read_timeout(&network_handle->mbedtls.ssl_config, timeout_ms);
    do {
        res = mbedtls_ssl_read(&network_handle->mbedtls.ssl_ctx, buffer + recv_bytes, len - recv_bytes);
        if (res < 0) {
            if (res == MBEDTLS_ERR_SSL_TIMEOUT) {
                break;
            } else if (res != MBEDTLS_ERR_SSL_WANT_READ &&
                       res != MBEDTLS_ERR_SSL_WANT_WRITE &&
                       res != MBEDTLS_ERR_SSL_CLIENT_RECONNECT) {
                if (recv_bytes == 0) {
                    DBG("mbedtls_ssl_recv error, res: -0x%04X\n", -res);
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
#endif


int32_t core_sysdep_network_recv(void *handle, uint8_t *buffer, uint32_t len, uint32_t timeout_ms,
                                 core_sysdep_addr_t *addr)
{
    core_network_handle_t *network_handle = (core_network_handle_t *)handle;

    if (handle == NULL || buffer == NULL) {
        return STATE_PORT_INPUT_NULL_POINTER;
    }

    if (len == 0 || timeout_ms == 0) {
        return STATE_PORT_INPUT_OUT_RANGE;
    }

    if (network_handle->socket_type == CORE_SYSDEP_SOCKET_TCP_CLIENT) {
        if (network_handle->cred == NULL) {
            return _core_sysdep_network_tcp_recv(network_handle, buffer, len, timeout_ms);
        } else {
            if (network_handle->cred->option == AIOT_SYSDEP_NETWORK_CRED_NONE) {
                return _core_sysdep_network_tcp_recv(network_handle, buffer, len, timeout_ms);
            }
#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
            else {
                return _core_sysdep_network_mbedtls_recv(network_handle, buffer, len, timeout_ms);
            }
#endif
        }
    } else if (network_handle->socket_type == CORE_SYSDEP_SOCKET_TCP_SERVER) {
        return STATE_PORT_TCP_SERVER_NOT_IMPLEMENT;
    } else if (network_handle->socket_type == CORE_SYSDEP_SOCKET_UDP_CLIENT) {
        if (network_handle->cred == NULL) {
            return STATE_PORT_UDP_CLIENT_NOT_IMPLEMENT;
        } else {
            if (network_handle->cred->option == AIOT_SYSDEP_NETWORK_CRED_NONE) {
                return STATE_PORT_UDP_CLIENT_NOT_IMPLEMENT;
            }
#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
            else {
                return _core_sysdep_network_mbedtls_recv(network_handle, buffer, len, timeout_ms);
            }
#endif
        }
    } else if (network_handle->socket_type == CORE_SYSDEP_SOCKET_UDP_SERVER) {
        return _core_sysdep_network_udp_recv(network_handle, buffer, len, timeout_ms, addr);
    }

    DBG("unknown nwk type\n");

    return STATE_PORT_NETWORK_UNKNOWN_SOCKET_TYPE;
}


int32_t _core_sysdep_network_tcp_send(core_network_handle_t *network_handle, uint8_t *buffer, uint32_t len,
                                      uint32_t timeout_ms)
{
    int res = 0;
    int32_t send_bytes = 0;
    ssize_t send_res = 0;
    uint64_t timestart_ms = 0, timenow_ms = 0, timeselect_ms = 0;
    fd_set send_sets;
    struct timeval timestart, timenow, timeselect;

    FD_ZERO(&send_sets);
    FD_SET(network_handle->fd, &send_sets);

    /* Start Time */
    timestart_ms = core_sysdep_time();
    timenow_ms = timestart_ms;

    do {
        timenow_ms = core_sysdep_time();

        if (timenow_ms - timestart_ms >= timenow_ms ||
            timeout_ms - (timenow_ms - timestart_ms) > timeout_ms) {
            break;
        }

        timeselect_ms = timeout_ms - (timenow_ms - timestart_ms);
        timeselect.tv_sec = timeselect_ms / 1000;
        timeselect.tv_usec = timeselect_ms % 1000 * 1000;

        res = select(network_handle->fd + 1, NULL, &send_sets, NULL, (struct timeval *)&timeselect);
        if (res == 0) {
            DBG("_core_sysdep_network_tcp_send, nwk select timeout\n");
            continue;
        } else if (res < 0) {
            DBG("_core_sysdep_network_tcp_send, errno: %d\n", errno);
          //  perror("_core_sysdep_network_tcp_send, nwk select failed: ");
            return STATE_PORT_NETWORK_SELECT_FAILED;
        } else {
            if (FD_ISSET(network_handle->fd, &send_sets)) {
                send_res = send(network_handle->fd, buffer + send_bytes, len - send_bytes, 0);
                if (send_res == 0) {
                    DBG("_core_sysdep_network_tcp_send, nwk connection closed\n");
                    return STATE_PORT_NETWORK_SEND_CONNECTION_CLOSED;
                } else if (send_res < 0) {
                    DBG("_core_sysdep_network_tcp_send, errno: %d\n", errno);
                 //   perror("_core_sysdep_network_tcp_send, nwk recv error: ");
                    if (errno == EINTR) {
                        continue;
                    }
                    return STATE_PORT_NETWORK_SEND_FAILED;
                } else {
                    send_bytes += send_res;
                    if (send_bytes == len) {
                        break;
                    }
                }
            }
        }
    } while (((timenow_ms - timestart_ms) < timeout_ms) && (send_bytes < len));

    return send_bytes;
}


int32_t _core_sysdep_network_udp_send(core_network_handle_t *network_handle, uint8_t *buffer, uint32_t len, uint32_t timeout_ms, core_sysdep_addr_t *addr)
{
    struct sockaddr_in cliaddr;
    fd_set write_fds;
    struct timeval timeout = {timeout_ms / 1000, (timeout_ms % 1000) * 1000};
    int res;

    if (addr == NULL) {
        DBG("invalid parameter addr\n");
        return STATE_PORT_NETWORK_SEND_FAILED;
    }

    FD_ZERO(&write_fds);
    FD_SET(network_handle->fd, &write_fds);

    res = select(network_handle->fd + 1, NULL, &write_fds, NULL, (struct timeval *)&timeout);
    if (res == 0) {
        DBG("select timeout\n");
        return 0;
    } else if (res < 0) {
        DBG("_linux_nwk_udp_write select errno: %d\n", errno);
      //  perror("_linux_nwk_udp_write select error");
        return STATE_PORT_NETWORK_SELECT_FAILED;
    }

    res = inet_aton((char *)addr->addr, &cliaddr.sin_addr);
    if (res < 0) {
        DBG("sys_nwk_write, addr error\r\n");
        return STATE_PORT_NETWORK_SEND_FAILED;
    }

    cliaddr.sin_family = AF_INET;
    cliaddr.sin_port = htons(addr->port);

    res = sendto(network_handle->fd, buffer, len, 0, (struct sockaddr *)&cliaddr, sizeof(struct sockaddr_in));
    if (res < 0) {
        DBG("_linux_nwk_udp_write errno: %d\n", errno);
      //  perror("_linux_nwk_udp_write error");
        return STATE_PORT_NETWORK_SEND_FAILED;
    }

    return res;
}

#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
int32_t _core_sysdep_network_mbedtls_send(core_network_handle_t *network_handle, uint8_t *buffer, uint32_t len,
        uint32_t timeout_ms)
{
    int32_t res = 0;
    int32_t send_bytes = 0;
    uint64_t timestart_ms = 0, timenow_ms = 0;
    struct timeval timestart, timenow;// timeout;

    /* timeout */
 //   timeout.sec = timeout_ms / 1000;
 //   timeout.usec = (timeout_ms % 1000) * 1000;

    /* Start Time */
    timestart_ms = core_sysdep_time();
    timenow_ms = timestart_ms;
/*
    res = setsockopt(network_handle->mbedtls.net_ctx.fd, SOL_SOCKET, SO_SNDTIMEO, &timeout, sizeof(timeout));
    if (res < 0) {
        DBG("setsockopt error, errno: %d\r\n", errno);
        return STATE_PORT_TLS_SEND_FAILED;
    }
*/
    do {
        timenow_ms = core_sysdep_time();

        if (timenow_ms - timestart_ms >= timenow_ms ||
            timeout_ms - (timenow_ms - timestart_ms) > timeout_ms) {
            break;
        }

        res = mbedtls_ssl_write(&network_handle->mbedtls.ssl_ctx, buffer + send_bytes, len - send_bytes);
        if (res < 0) {
            if (res != MBEDTLS_ERR_SSL_WANT_READ &&
                res != MBEDTLS_ERR_SSL_WANT_WRITE) {
                if (send_bytes == 0) {
                    DBG("mbedtls_ssl_send error, res: -0x%04X\n", -res);
                    if (res == MBEDTLS_ERR_SSL_PEER_CLOSE_NOTIFY) {
                        return STATE_PORT_TLS_SEND_CONNECTION_CLOSED;
                    } else if (res == MBEDTLS_ERR_SSL_INVALID_RECORD) {
                        return STATE_PORT_TLS_INVALID_RECORD;
                    } else {
                        return STATE_PORT_TLS_SEND_FAILED;
                    }
                }
                break;
            }
        } else if (res == 0) {
            break;
        } else {
            send_bytes += res;
        }
        vTaskDelay(100);
    } while (((timenow_ms - timestart_ms) < timeout_ms) && (send_bytes < len));

    return send_bytes;
}
#endif



int32_t core_sysdep_network_send(void *handle, uint8_t *buffer, uint32_t len, uint32_t timeout_ms,
                                 core_sysdep_addr_t *addr)
{
    core_network_handle_t *network_handle = (core_network_handle_t *)handle;

    if (handle == NULL || buffer == NULL) {
        DBG("invalid parameter\n");
        return STATE_PORT_INPUT_NULL_POINTER;
    }
    if (len == 0 || timeout_ms == 0) {
        return STATE_PORT_INPUT_OUT_RANGE;
    }

    if (network_handle->socket_type == CORE_SYSDEP_SOCKET_TCP_CLIENT) {
        if (network_handle->cred == NULL) {
            return _core_sysdep_network_tcp_send(network_handle, buffer, len, timeout_ms);
        } else {
            if (network_handle->cred->option == AIOT_SYSDEP_NETWORK_CRED_NONE) {
                return _core_sysdep_network_tcp_send(network_handle, buffer, len, timeout_ms);
            }
#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
            else {
                return _core_sysdep_network_mbedtls_send(network_handle, buffer, len, timeout_ms);
            }
#endif
        }
    } else if (network_handle->socket_type == CORE_SYSDEP_SOCKET_TCP_SERVER) {
        return STATE_PORT_TCP_SERVER_NOT_IMPLEMENT;
    } else if (network_handle->socket_type == CORE_SYSDEP_SOCKET_UDP_CLIENT) {
        if (network_handle->cred == NULL) {
            return STATE_PORT_UDP_CLIENT_NOT_IMPLEMENT;
        } else {
            if (network_handle->cred->option == AIOT_SYSDEP_NETWORK_CRED_NONE) {
                return STATE_PORT_UDP_CLIENT_NOT_IMPLEMENT;
            }
#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
            else {
                return _core_sysdep_network_mbedtls_send(network_handle, buffer, len, timeout_ms);
            }
#endif
        }
    } else if (network_handle->socket_type == CORE_SYSDEP_SOCKET_UDP_SERVER) {
        return _core_sysdep_network_udp_send(network_handle, buffer, len, timeout_ms, addr);
    }

    DBG("unknown nwk type\n");

    return STATE_PORT_NETWORK_UNKNOWN_SOCKET_TYPE;
}


static void _core_sysdep_network_tcp_disconnect(core_network_handle_t *network_handle)
{
    shutdown(network_handle->fd, 2);
    close(network_handle->fd);
}

#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
static void _core_sysdep_network_mbedtls_disconnect(core_network_handle_t *network_handle)
{
    mbedtls_ssl_close_notify(&network_handle->mbedtls.ssl_ctx);
    mbedtls_net_free(&network_handle->mbedtls.net_ctx);
    if (network_handle->cred->option == AIOT_SYSDEP_NETWORK_CRED_SVRCERT_CA) {
        mbedtls_x509_crt_free(&network_handle->mbedtls.x509_server_cert);
        mbedtls_x509_crt_free(&network_handle->mbedtls.x509_client_cert);
        mbedtls_pk_free(&network_handle->mbedtls.x509_client_pk);
    }
    mbedtls_ssl_free(&network_handle->mbedtls.ssl_ctx);
    mbedtls_ssl_config_free(&network_handle->mbedtls.ssl_config);
    g_mbedtls_total_mem_used = g_mbedtls_max_mem_used = 0;
}
#endif



int32_t core_sysdep_network_deinit(void **handle)
{
    core_network_handle_t *network_handle = NULL;

    if (handle == NULL || *handle == NULL) {
        return STATE_PORT_INPUT_NULL_POINTER;
    }

    network_handle = *(core_network_handle_t **)handle;

    if ((network_handle->socket_type == CORE_SYSDEP_SOCKET_TCP_CLIENT ||
            network_handle->socket_type == CORE_SYSDEP_SOCKET_UDP_CLIENT) && network_handle->host != NULL) {
        if (network_handle->cred == NULL) {
            _core_sysdep_network_tcp_disconnect(network_handle);
        } else {
            if (network_handle->cred->option == AIOT_SYSDEP_NETWORK_CRED_NONE) {
                _core_sysdep_network_tcp_disconnect(network_handle);
            }
#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
            else {
                _core_sysdep_network_mbedtls_disconnect(network_handle);
            }
#endif
        }
    }

    if (network_handle->host != NULL) {
        free(network_handle->host);
        network_handle->host = NULL;
    }
    if (network_handle->cred != NULL) {
        free(network_handle->cred);
        network_handle->cred = NULL;
    }
#ifdef CORE_SYSDEP_MBEDTLS_ENABLED
    if (network_handle->psk.psk_id != NULL) {
        free(network_handle->psk.psk_id);
        network_handle->psk.psk_id = NULL;
    }
    if (network_handle->psk.psk != NULL) {
        free(network_handle->psk.psk);
        network_handle->psk.psk = NULL;
    }
#endif

    free(network_handle);
    *handle = NULL;

    return 0;
}

void core_sysdep_rand(uint8_t *output, uint32_t output_len)
{
    uint32_t idx = 0, bytes = 0, rand_num = 0;

    srand((unsigned int)core_sysdep_time() + rand());

    for (idx = 0; idx < output_len;) {
        if (output_len - idx < 4) {
            bytes = output_len - idx;
        } else {
            bytes = 4;
        }
        rand_num = rand();
        while (bytes-- > 0) {
            output[idx++] = (uint8_t)(rand_num >> bytes * 8);
        }
    }
}

void *core_sysdep_mutex_init(void)
{
    return xSemaphoreCreateMutex();
}

void core_sysdep_mutex_lock(void *mutex)
{
    xSemaphoreTake((SemaphoreHandle_t)mutex, portMAX_DELAY);
}

void core_sysdep_mutex_unlock(void *mutex)
{
    xSemaphoreGive((SemaphoreHandle_t)mutex);
}

void core_sysdep_mutex_deinit(void **mutex)
{
    if (mutex != NULL || *mutex != NULL) {
        vSemaphoreDelete((SemaphoreHandle_t)*mutex);
        *mutex = NULL;
    }
}

aiot_sysdep_portfile_t g_aiot_sysdep_portfile = {
    .core_sysdep_malloc = core_sysdep_malloc,
    .core_sysdep_free = core_sysdep_free,
    .core_sysdep_time = core_sysdep_time,
    .core_sysdep_sleep = core_sysdep_sleep,
    .core_sysdep_network_init = core_sysdep_network_init,
    .core_sysdep_network_setopt = core_sysdep_network_setopt,
    .core_sysdep_network_establish = core_sysdep_network_establish,
    .core_sysdep_network_recv = core_sysdep_network_recv,
    .core_sysdep_network_send = core_sysdep_network_send,
    .core_sysdep_network_deinit = core_sysdep_network_deinit,
    .core_sysdep_rand = core_sysdep_rand,
    .core_sysdep_mutex_init = core_sysdep_mutex_init,
    .core_sysdep_mutex_lock = core_sysdep_mutex_lock,
    .core_sysdep_mutex_unlock = core_sysdep_mutex_unlock,
    .core_sysdep_mutex_deinit = core_sysdep_mutex_deinit,
};

