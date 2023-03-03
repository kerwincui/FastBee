/**
 * @file
 *
 * Neighbor discovery and stateless address autoconfiguration for IPv6.
 * Aims to be compliant with RFC 4861 (Neighbor discovery) and RFC 4862
 * (Address autoconfiguration).
 */

/*
 * Copyright (c) 2010 Inico Technologies Ltd.
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
 * Author: Ivan Delamer <delamer@inicotech.com>
 *
 *
 * Please coordinate changes and requests with Ivan Delamer
 * <delamer@inicotech.com>
 */

#ifndef LWIP_HDR_ND6_H
#define LWIP_HDR_ND6_H

#include "lwip/opt.h"

#if LWIP_IPV6  /* don't build if not configured for use in lwipopts.h */

#include "lwip/ip6_addr.h"
#include "lwip/err.h"
#include "lwip/netif.h"

#ifdef __cplusplus
extern "C" {
#endif

/** 1 second period */
#define ND6_TMR_INTERVAL 1000


#if LWIP_ENABLE_IPV6_RA_SERVER
typedef struct nd6_prefix_info_tag
{
    u8_t prefix_len;
    u8_t rsvd1;
    u16_t rsvd2;
    u32_t valid_life_time;
    u32_t prefer_life_time;
    ip6_addr_t prefix;
}nd6_prefix_info;
typedef struct nd6_ipv6_ra_server_data_tag
{
    u16_t mtu;
    u16_t default_life_time;
    u32_t reachable_time;
    u32_t retransmit_time;
    ip6_addr_t dns[LWIP_IP6_RA_MAX_RDNSS_NUM];
    nd6_prefix_info prefix_info;
}nd6_ipv6_ra_server_data;
#endif


struct pbuf;
struct netif;

void nd6_tmr(void);
void nd6_input(struct pbuf *p, struct netif *inp);
void nd6_clear_destination_cache(void);
struct netif *nd6_find_route(const ip6_addr_t *ip6addr);
err_t nd6_get_next_hop_addr_or_queue(struct netif *netif, struct pbuf *q, const ip6_addr_t *ip6addr, const u8_t **hwaddrp);
u16_t nd6_get_destination_mtu(const ip6_addr_t *ip6addr, struct netif *netif);

u8_t nd6_find_netif_neighbor_cache_entry(struct netif* netif, ip6_addr_t *ip6prefix, ip6_addr_t *ip6dest, u8_t lladdr[NETIF_MAX_HWADDR_LEN], u8_t index);

u8_t nd6_find_netif_neighbor_link_local_cache_entry(struct netif* netif,  ip6_addr_t *ip6dest, u8_t lladdr[NETIF_MAX_HWADDR_LEN]);

#if LWIP_ND6_TCP_REACHABILITY_HINTS
void nd6_reachability_hint(const ip6_addr_t *ip6addr);
#endif /* LWIP_ND6_TCP_REACHABILITY_HINTS */
void nd6_cleanup_netif(struct netif *netif);
#if LWIP_IPV6_MLD
void nd6_adjust_mld_membership(struct netif *netif, s8_t addr_idx, u8_t new_state);
#endif /* LWIP_IPV6_MLD */

#if LWIP_TIMER_ON_DEMOND
void nd6_router_entry_timer_handler(void *arg);
void nd6_prefix_entry_timer_handler(void *arg);
void nd6_address_dad_timer_handler(void *arg);
void nd6_rs_retry_timer_handler(void *arg);
void nd6_rs_refresh_timer_handler(void *arg);
void nd6_start_rs_process(struct netif *netif, u16_t delay);
void nd6_ns_retry_timer_handler(void *arg);
#if LWIP_ENABLE_IPV6_RA_SERVER
void nd6_ra_retrans_timer_handler(void *arg);
#endif


#endif

#if PS_ENABLE_TCPIP_HIB_SLEEP2_MODE

struct nd6_prefix_list_entry *nd6_new_onlink_prefix_info(ip6_addr_t *prefix, struct netif *netif);

#endif

#if LWIP_ENABLE_IPV6_RA_SERVER
BOOL nd6_enable_ip6_ra_server(struct netif *pNetif, nd6_ipv6_ra_server_data *server_data, BOOL bPendingUnsolicitateRa, BOOL bWakeUp);
void nd6_disable_ip6_ra_server(struct netif *pNetif);
void nd6_resend_ip6_ra_server(struct netif *pNetif);


#endif

#ifdef __cplusplus
}
#endif

#endif /* LWIP_IPV6 */

#endif /* LWIP_HDR_ND6_H */
