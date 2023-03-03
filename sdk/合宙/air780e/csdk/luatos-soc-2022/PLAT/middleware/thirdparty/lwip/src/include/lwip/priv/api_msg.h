/**
 * @file
 * netconn API lwIP internal implementations (do not use in application code)
 */

/*
 * Copyright (c) 2001-2004 Swedish Institute of Computer Science.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
 * OF SUCH DAMAGE.
 *
 * This file is part of the lwIP TCP/IP stack.
 *
 * Author: Adam Dunkels <adam@sics.se>
 *
 */
#ifndef LWIP_HDR_API_MSG_H
#define LWIP_HDR_API_MSG_H

#include "lwip/opt.h"

#if LWIP_NETCONN || LWIP_SOCKET /* don't build if not configured for use in lwipopts.h */
/* Note: Netconn API is always available when sockets are enabled -
 * sockets are implemented on top of them */

#include "lwip/arch.h"
#include "lwip/ip_addr.h"
#include "lwip/err.h"
#include "lwip/sys.h"
#include "lwip/igmp.h"
#include "lwip/api.h"
#include "lwip/priv/tcpip_priv.h"

#ifdef __cplusplus
extern "C" {
#endif

#if LWIP_MPU_COMPATIBLE
#if LWIP_NETCONN_SEM_PER_THREAD
#define API_MSG_M_DEF_SEM(m)  *m
#else
#define API_MSG_M_DEF_SEM(m)  API_MSG_M_DEF(m)
#endif
#else /* LWIP_MPU_COMPATIBLE */
#define API_MSG_M_DEF_SEM(m)  API_MSG_M_DEF(m)
#endif /* LWIP_MPU_COMPATIBLE */

/* For the netconn API, these values are use as a bitmask! */
#define NETCONN_SHUT_RD   1
#define NETCONN_SHUT_WR   2
#define NETCONN_SHUT_RDWR (NETCONN_SHUT_RD | NETCONN_SHUT_WR)

/* IP addresses and port numbers are expected to be in
 * the same byte order as in the corresponding pcb.
 */
/** This struct includes everything that is necessary to execute a function
    for a netconn in another thread context (mainly used to process netconns
    in the tcpip_thread context to be thread safe). */
struct api_msg {
  /** The netconn which to process - always needed: it includes the semaphore
      which is used to block the application thread until the function finished. */
  struct netconn *conn;
  /** The return value of the function executed in tcpip_thread. */
  err_t err;
  /** Depending on the executed function, one of these union members is used */
  union {
    /** used for lwip_netconn_do_send */
    struct netbuf *b;
    /** used for lwip_netconn_do_newconn */
    struct {
      u8_t proto;
    } n;
    /** used for lwip_netconn_do_bind and lwip_netconn_do_connect */
    struct {
      API_MSG_M_DEF_C(ip_addr_t, ipaddr);
      u16_t port;
#if ENABLE_PSIF
      u8_t cid;
      u8_t reserved;
#endif
    } bc;
        /** used for lwip_netconn_alloc_server_port*/
    struct {
      u8_t type;
      u8_t reserved;
      u16_t server_port;
    } as;

    /** used for lwip_netconn_do_getaddr */
    struct {
      ip_addr_t API_MSG_M_DEF(ipaddr);
      u16_t API_MSG_M_DEF(port);
      u8_t local;
    } ad;
    /** used for lwip_netconn_do_write */
    struct {
      const void *dataptr;
      size_t len;
      u8_t apiflags;

#if ENABLE_PSIF
      u8_t dataRai:2;
      u8_t bExceptData:1;
      u8_t reserve:5;
      u8_t sequence;
#endif

#if LWIP_SO_SNDTIMEO
      u32_t time_started;
#endif /* LWIP_SO_SNDTIMEO */
    } w;
    /** used for lwip_netconn_do_recv */
    struct {
      u32_t len;
    } r;
#if LWIP_TCP
    /** used for lwip_netconn_do_close (/shutdown) */
    struct {
      u8_t shut;
#if LWIP_SO_SNDTIMEO || LWIP_SO_LINGER
      u32_t time_started;
#else /* LWIP_SO_SNDTIMEO || LWIP_SO_LINGER */
      u8_t polls_left;
#endif /* LWIP_SO_SNDTIMEO || LWIP_SO_LINGER */
    } sd;
#endif /* LWIP_TCP */
#if LWIP_IGMP || (LWIP_IPV6 && LWIP_IPV6_MLD)
    /** used for lwip_netconn_do_join_leave_group */
    struct {
      API_MSG_M_DEF_C(ip_addr_t, multiaddr);
      API_MSG_M_DEF_C(ip_addr_t, netif_addr);
      enum netconn_igmp join_or_leave;
    } jl;
#endif /* LWIP_IGMP || (LWIP_IPV6 && LWIP_IPV6_MLD) */
#if TCP_LISTEN_BACKLOG
    struct {
      u8_t backlog;
    } lb;
#endif /* TCP_LISTEN_BACKLOG */
  } msg;
#if LWIP_NETCONN_SEM_PER_THREAD
  sys_sem_t* op_completed_sem;
#elif LWIP_NETCONN_SEM_PER_OPERATION
  sys_sem_t  op_completed_sem;
#endif /* LWIP_NETCONN_SEM_PER_THREAD */
};

#if LWIP_NETCONN_SEM_PER_THREAD
#define LWIP_API_MSG_SEM(msg)          ((msg)->op_completed_sem)
#elif LWIP_NETCONN_SEM_PER_OPERATION
#define LWIP_API_MSG_SEM(msg)          (&(msg)->op_completed_sem)
#else /* LWIP_NETCONN_SEM_PER_THREAD */
#define LWIP_API_MSG_SEM(msg)          (&(msg)->conn->op_completed)
#endif /* LWIP_NETCONN_SEM_PER_THREAD */


#if LWIP_DNS
/** As lwip_netconn_do_gethostbyname requires more arguments but doesn't require a netconn,
    it has its own struct (to avoid struct api_msg getting bigger than necessary).
    lwip_netconn_do_gethostbyname must be called using tcpip_callback instead of tcpip_apimsg
    (see netconn_gethostbyname). */

struct dns_api_msg {
  /** Hostname to query or dotted IP address string */
#if LWIP_MPU_COMPATIBLE
  char name[DNS_MAX_NAME_LENGTH];
  ip_addr_t addr[LWIP_DNS_RESULT_NUM_MAX];
#else /* LWIP_MPU_COMPATIBLE */
  const char *name;
  const ip_addr_t *addr;
#endif /* LWIP_MPU_COMPATIBLE */
  /** The resolved address is stored here */
#if LWIP_IPV4 && LWIP_IPV6
  /** Type of resolve call */
  u8_t dns_addrtype;
#endif /* LWIP_IPV4 && LWIP_IPV6 */
  /** This semaphore is posted when the name is resolved, the application thread
      should wait on it. */
  sys_sem_t API_MSG_M_DEF_SEM(sem);
  /** Errors are given back here */
  err_t API_MSG_M_DEF(err);
  /*reserved for nm_ati async */

  u8_t cid;
  u8_t source;
  u16_t src_handler;

};
#endif /* LWIP_DNS */

#if ENABLE_PSIF

typedef enum {
    LWIP_NETWORK_INVALID_IP_TYPE = 0,
    LWIP_NETWORK_IPV4 = 1,
    LWIP_NETWORK_IPV6 = 2,
    LWIP_NETWORK_IPV4V6 =3,
}LwipNetworkType;

typedef struct NetconnGetNetInfo_Tag{
    struct tcpip_api_call_data call;
    u8_t cid; // if the cid is LWIP_PS_INVALID_CID, will get the default netif status
    u8_t result; //0 ->deactive;1 -> ipv4 active; 2 -> ipv6 active; 3 -> ipv4ipv6 active
}NetconnGetNetInfo;

typedef struct NetconnGetSockInfo_Tag{
    struct tcpip_api_call_data call;
    int req_fd;
    ip_addr_t local_ip;
    ip_addr_t remote_ip;
    u16_t local_port;
    u16_t remote_port;
    int sock_type; //SockInfoType
}NetconnGetSockInfo;

typedef struct NetconnGetSockByPcbInfo_Tag{
    struct tcpip_api_call_data call;
    int sock_type; //SockInfoType
    void *pcb;
    ip_addr_t local_ip;
    ip_addr_t remote_ip;
    u16_t local_port;
    u16_t remote_port;

}NetconnGetSockInfoByPcb;


typedef struct NetconnGetHibSockId_Tag{
    struct tcpip_api_call_data call;
    int udp_hib_sockid;
    int tcp_hib_sockid;
}NetconnGetHibSockId;



typedef struct NetconnGetTcpSendBufferSize_Tag{
    struct tcpip_api_call_data call;
    struct netconn *conn;
    uint16_t send_buffer_size;
    uint16_t rsvd;
}NetconnGetTcpSendBufferSize;



#endif

#if LWIP_TCP
extern u8_t netconn_aborted;
#endif /* LWIP_TCP */

void lwip_netconn_do_newconn         (void *m);
void lwip_netconn_do_delconn         (void *m);
void lwip_netconn_do_bind            (void *m);

#if ENABLE_PSIF
void lwip_netconn_do_bind_cid        (void *m);
void lwip_netconn_alloc_server_port(void *m);
#endif

void lwip_netconn_do_connect         (void *m);
void lwip_netconn_do_disconnect      (void *m);
void lwip_netconn_do_listen          (void *m);
void lwip_netconn_do_send            (void *m);
void lwip_netconn_do_recv            (void *m);
#if TCP_LISTEN_BACKLOG
void lwip_netconn_do_accepted        (void *m);
#endif /* TCP_LISTEN_BACKLOG */
void lwip_netconn_do_write           (void *m);
void lwip_netconn_do_getaddr         (void *m);
void lwip_netconn_do_close           (void *m);
void lwip_netconn_do_shutdown        (void *m);
#if LWIP_IGMP || (LWIP_IPV6 && LWIP_IPV6_MLD)
void lwip_netconn_do_join_leave_group(void *m);
#endif /* LWIP_IGMP || (LWIP_IPV6 && LWIP_IPV6_MLD) */

#if LWIP_DNS
void lwip_netconn_do_gethostbyname(void *arg);
void lwip_netconn_do_gethostbyname_async(void *arg);
void lwip_netconn_do_gethostbyname_async_by_cmsSockMgr(void *arg);

#endif /* LWIP_DNS */

struct netconn* netconn_alloc(enum netconn_type t, netconn_callback callback);
void netconn_free(struct netconn *conn);

#if PS_ENABLE_TCPIP_HIB_SLEEP2_MODE
int netconn_get_socket_id(struct netconn* conn);
#endif


#if ENABLE_PSIF


u8_t lwip_netconn_any_pending_data(void);
err_t lwip_netconn_get_net_info_with_cid(struct tcpip_api_call_data *arg);
err_t lwip_netconn_get_sock_info(struct tcpip_api_call_data *arg);
err_t lwip_netconn_get_hib_sock_id(struct tcpip_api_call_data *arg);
/******************************************************************************
 * lwip_netconn_get_sock_info_by_pcb
 * Description: get the sock info
 * input:struct tcpip_api_call_data *arg
 * output:
 * Comment:
******************************************************************************/
err_t lwip_netconn_get_sock_info_by_pcb(struct tcpip_api_call_data *arg);

err_t lwip_netconn_get_tcp_send_buffer_size(struct tcpip_api_call_data *arg);


#endif

#if LWIP_SUSPEND_UP_DATA_ENABLE
void lwip_netconn_interface_resume_handler(void);
#endif

#ifdef __cplusplus
}
#endif

#endif /* LWIP_NETCONN || LWIP_SOCKET */

#endif /* LWIP_HDR_API_MSG_H */
