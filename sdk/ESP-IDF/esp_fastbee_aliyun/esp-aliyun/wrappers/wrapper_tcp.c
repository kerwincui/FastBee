/*
 * ESPRESSIF MIT License
 *
 * Copyright (c) 2019 <ESPRESSIF SYSTEMS (SHANGHAI) PTE LTD>
 *
 * Permission is hereby granted for use on all ESPRESSIF SYSTEMS products, in which case,
 * it is free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the Software is furnished
 * to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 */

#include <stdio.h>
#include <string.h>
#include <netdb.h>
#include <sys/socket.h>

#include "infra_types.h"
#include "wrappers_defs.h"

#include "esp_system.h"
#include "esp_log.h"

static const char *TAG = "iot_import_tcp";

uint64_t HAL_UptimeMs(void);

static uint64_t _esp_get_time_ms(void)
{
    return HAL_UptimeMs();
}

static uint64_t _esp_time_left(uint64_t t_end, uint64_t t_now)
{
    uint64_t t_left;

    if (t_end > t_now) {
        t_left = t_end - t_now;
    } else {
        t_left = 0;
    }

    return t_left;
}

uintptr_t HAL_TCP_Establish(const char *host, uint16_t port)
{
    struct addrinfo hints;
    struct addrinfo *addrInfoList = NULL;
    struct addrinfo *cur = NULL;
    int fd = 0;
    int rc = 0;
    char service[6];
    int sockopt = 1;
    memset(&hints, 0, sizeof(hints));

    ESP_LOGI(TAG, "establish tcp connection with server(host=%s port=%u)", host, port);

    hints.ai_family = AF_INET; /* only IPv4 */
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;
    sprintf(service, "%u", port);

    if ((rc = getaddrinfo(host, service, &hints, &addrInfoList)) != 0) {
        ESP_LOGE(TAG, "getaddrinfo error");
        return -1;
    }

    for (cur = addrInfoList; cur != NULL; cur = cur->ai_next) {
        if (cur->ai_family != AF_INET) {
            ESP_LOGE(TAG, "socket type error");
            rc = -1;
            continue;
        }

        fd = socket(cur->ai_family, cur->ai_socktype, cur->ai_protocol);
        if (fd < 0) {
            ESP_LOGE(TAG, "create socket error");
            rc = -1;
            continue;
        }

        setsockopt(fd, SOL_SOCKET, SO_REUSEADDR,&sockopt, sizeof(sockopt));
        setsockopt(fd, SOL_SOCKET, SO_REUSEPORT,&sockopt, sizeof(sockopt));

        if (connect(fd, cur->ai_addr, cur->ai_addrlen) == 0) {
            rc = fd;
            break;
        }

        close(fd);
        ESP_LOGE(TAG, "connect error");
        rc = -1;
    }

    if (-1 == rc) {
        ESP_LOGI(TAG, "fail to establish tcp");
    } else {
        ESP_LOGI(TAG, "success to establish tcp, fd=%d", rc);
    }
    freeaddrinfo(addrInfoList);
    return (uintptr_t)rc;
}

int HAL_TCP_Destroy(uintptr_t fd)
{
    int rc;

    /* Shutdown both send and receive operations. */
    rc = shutdown((int) fd, 2);
    if (0 != rc) {
        ESP_LOGE(TAG, "shutdown error");
        return -1;
    }

    rc = close((int) fd);
    if (0 != rc) {
        ESP_LOGE(TAG, "closesocket error");
        return -1;
    }

    return 0;
}

int32_t HAL_TCP_Write(uintptr_t fd, const char *buf, uint32_t len, uint32_t timeout_ms)
{
    int ret;
    uint32_t len_sent;
    uint64_t t_end, t_left;
    fd_set sets;

    t_end = _esp_get_time_ms() + timeout_ms;
    len_sent = 0;
    ret = 1; /* send one time if timeout_ms is value 0 */

    do {
        t_left = _esp_time_left(t_end, _esp_get_time_ms());

        if (0 != t_left) {
            struct timeval timeout;

            FD_ZERO(&sets);
            FD_SET(fd, &sets);

            timeout.tv_sec = t_left / 1000;
            timeout.tv_usec = (t_left % 1000) * 1000;

            ret = select(fd + 1, NULL, &sets, NULL, &timeout);
            if (ret > 0) {
                if (0 == FD_ISSET(fd, &sets)) {
                    ESP_LOGI(TAG, "Should NOT arrive");
                    /* If timeout in next loop, it will not sent any data */
                    ret = 0;
                    continue;
                }
            } else if (0 == ret) {
                ESP_LOGI(TAG, "select-write timeout %d", (int)fd);
                break;
            } else {
                if (EINTR == errno) {
                    ESP_LOGI(TAG, "EINTR be caught");
                    continue;
                }

                ESP_LOGE(TAG, "select-write fail");
                break;
            }
        }

        if (ret > 0) {
            ret = send(fd, buf + len_sent, len - len_sent, 0);
            if (ret > 0) {
                len_sent += ret;
            } else if (0 == ret) {
                ESP_LOGI(TAG, "No data be sent");
            } else {
                if (EINTR == errno) {
                    ESP_LOGI(TAG, "EINTR be caught");
                    continue;
                }

                ESP_LOGE(TAG, "send fail");
                break;
            }
        }
    } while ((len_sent < len) && (_esp_time_left(t_end, _esp_get_time_ms()) > 0));

    return len_sent;
}

int32_t HAL_TCP_Read(uintptr_t fd, char *buf, uint32_t len, uint32_t timeout_ms)
{
    int ret, err_code;
    uint32_t len_recv;
    uint64_t t_end, t_left;
    fd_set sets;
    struct timeval timeout;

    t_end = _esp_get_time_ms() + timeout_ms;
    len_recv = 0;
    err_code = 0;

    do {
        t_left = _esp_time_left(t_end, _esp_get_time_ms());
        if (0 == t_left) {
            break;
        }
        FD_ZERO(&sets);
        FD_SET(fd, &sets);

        timeout.tv_sec = t_left / 1000;
        timeout.tv_usec = (t_left % 1000) * 1000;

        ret = select(fd + 1, &sets, NULL, NULL, &timeout);
        if (ret > 0) {
            ret = recv(fd, buf + len_recv, len - len_recv, 0);
            if (ret > 0) {
                len_recv += ret;
            } else if (0 == ret) {
                ESP_LOGE(TAG, "connection is closed");
                err_code = -1;
                break;
            } else {
                if (EINTR == errno) {
                    ESP_LOGI(TAG, "EINTR be caught");
                    continue;
                }
                ESP_LOGE(TAG, "recv fail");
                err_code = -2;
                break;
            }
        } else if (0 == ret) {
            break;
        } else {
            ESP_LOGE(TAG, "select-recv fail");
            err_code = -2;
            break;
        }
    } while ((len_recv < len));

    /* priority to return data bytes if any data be received from TCP connection. */
    /* It will get error code on next calling */
    return (0 != len_recv) ? len_recv : err_code;
}

