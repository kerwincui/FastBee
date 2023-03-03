/**
 * @file
 * DNS API
 */

/**
 * lwip DNS resolver header file.

 * Author: Jim Pettinato
 *   April 2007

 * ported from uIP resolv.c Copyright (c) 2002-2003, Adam Dunkels.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote
 *    products derived from this software without specific prior
 *    written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef LWIP_HDR_DNS_H
#define LWIP_HDR_DNS_H

#include "lwip/opt.h"

#if LWIP_DNS

#include "lwip/ip_addr.h"

#ifdef __cplusplus
extern "C" {
#endif

/** DNS timer period */
#ifndef DNS_TMR_INTERVAL
#define DNS_TMR_INTERVAL          1000
#endif

#if ENABLE_PSIF
#define NETIF_DNS_SERVER_NUM_MAX 4
#endif


/* DNS resolve types: */
#define LWIP_DNS_ADDRTYPE_IPV4      0
#define LWIP_DNS_ADDRTYPE_IPV6      1
#define LWIP_DNS_ADDRTYPE_IPV4_IPV6 2 /* try to resolve IPv4 first, try IPv6 if IPv4 fails only */
#define LWIP_DNS_ADDRTYPE_IPV6_IPV4 3 /* try to resolve IPv6 first, try IPv4 if IPv6 fails only */
#if LWIP_IPV4 && LWIP_IPV6
#ifndef LWIP_DNS_ADDRTYPE_DEFAULT
#define LWIP_DNS_ADDRTYPE_DEFAULT   LWIP_DNS_ADDRTYPE_IPV4_IPV6
#endif
#elif LWIP_IPV4
#define LWIP_DNS_ADDRTYPE_DEFAULT   LWIP_DNS_ADDRTYPE_IPV4
#else
#define LWIP_DNS_ADDRTYPE_DEFAULT   LWIP_DNS_ADDRTYPE_IPV6
#endif

#if ENABLE_PSIF
struct dns_server_tag {
    ip_addr_t dns_server; //dns server address
    struct netif* net_if; // the dns server address belong to
};
#endif


/** DNS table entry */
struct dns_result_tag {
  u32_t ttl;
  ip_addr_t ipaddr;
};
struct dns_table_entry {
struct dns_result_tag result[LWIP_DNS_RESULT_NUM_MAX]; //dns result
  u16_t txid;
  u8_t  state;
  u8_t  server_idx;
  u8_t  tmr;
  u8_t  retries;
  u8_t  seqno;
#if ((LWIP_DNS_SECURE & LWIP_DNS_SECURE_RAND_SRC_PORT) != 0)
  u8_t pcb_idx;
#endif
  char name[DNS_MAX_NAME_LENGTH];
#if LWIP_IPV4 && LWIP_IPV6
  u8_t reqaddrtype;
#endif /* LWIP_IPV4 && LWIP_IPV6 */
#if LWIP_DNS_SUPPORT_MDNS_QUERIES
  u8_t is_mdns;
#endif

  //indicate wtherthe disable dns cache
  u8_t   disable_cache_flag;

#if PS_ENABLE_TCPIP_HIB_SLEEP2_MODE
  u8_t  is_from_hib;
  u32_t active_time;
#endif

#if LWIP_TIMER_ON_DEMOND
  u32_t retry_timeout;
#endif

 void *netif;

};

struct dns_relay_server_mapping_table
{
    ip4_addr_t lan_server;
    struct dns_server_tag *wan_server;
};

#define DNS_RELAY_SERVER_NUM 2

struct dns_relay_ip4_server_data {
    struct dns_relay_server_mapping_table table[DNS_RELAY_SERVER_NUM];
};


#if DNS_LOCAL_HOSTLIST
/** struct used for local host-list */
struct local_hostlist_entry {
  /** static hostname */
  const char *name;
  /** static host address in network byteorder */
  ip_addr_t addr;
  struct local_hostlist_entry *next;
};
#define DNS_LOCAL_HOSTLIST_ELEM(name, addr_init) {name, addr_init, NULL}
#if DNS_LOCAL_HOSTLIST_IS_DYNAMIC
#ifndef DNS_LOCAL_HOSTLIST_MAX_NAMELEN
#define DNS_LOCAL_HOSTLIST_MAX_NAMELEN  DNS_MAX_NAME_LENGTH
#endif
#define LOCALHOSTLIST_ELEM_SIZE ((sizeof(struct local_hostlist_entry) + DNS_LOCAL_HOSTLIST_MAX_NAMELEN + 1))
#endif /* DNS_LOCAL_HOSTLIST_IS_DYNAMIC */
#endif /* DNS_LOCAL_HOSTLIST */

#if LWIP_IPV4
extern const ip_addr_t dns_mquery_v4group;
#endif /* LWIP_IPV4 */
#if LWIP_IPV6
extern const ip_addr_t dns_mquery_v6group;
#endif /* LWIP_IPV6 */

/** Callback which is invoked when a hostname is found.
 * A function of this type must be implemented by the application using the DNS resolver.
 * @param name pointer to the name that was looked up.
 * @param ipaddr pointer to an ip_addr_t containing the IP address of the hostname,
 *        or NULL if the name could not be found (or on any other error).
 * @param callback_arg a user-specified callback argument passed to dns_gethostbyname
*/
typedef void (*dns_found_callback)(const char *name, const ip_addr_t *ipaddr, u32_t ttl, void *callback_arg);

void             dns_init(void);
void             dns_tmr(void);

#if ENABLE_PSIF  //add for multi pdn case
void dns_setserver(struct netif *net_if, const ip_addr_t *dnsserver);
void dns_clearserver(struct netif *net_if, u8_t type);
const ip_addr_t* dns_getserver(u8_t numdns);
void dns_getadptserver(struct netif *net_if, u8_t type, ip_addr_t serverresult[2]);
void dns_get_netif_ipv4_dns_server(struct netif *net_if, ip4_addr_t *p_out_dns, u8_t *in_out_dns_num);
void dns_get_netif_ipv6_dns_server(struct netif *net_if, ip6_addr_t *p_out_dns, u8_t *in_out_dns_num);
void dns_clear_cache(u8_t type);
void dns_clear_entry(char name[DNS_MAX_NAME_LENGTH]);
void dns_clear_all_entry(void);
err_t dns_get_dns_server_info(struct netif *netif, UINT8 *serverNum, ip_addr_t servers[NETIF_DNS_SERVER_NUM_MAX]);
void dns_disable_all_cache(void);
void dns_enable_all_cache(void);
struct dns_server_tag *dns_get_netif_ip4_dns_server_by_index(struct netif *net_if, u8_t index);
#else
void             dns_setserver(u8_t numdns, const ip_addr_t *dnsserver);
void             dns_clearserver(u8_t type);
const ip_addr_t* dns_getserver(u8_t numdns);

#endif

err_t            dns_gethostbyname(const char *hostname, ip_addr_t *addr,
                                   dns_found_callback found, void *callback_arg, uint8_t cid);
err_t            dns_gethostbyname_addrtype(const char *hostname, ip_addr_t *addr,
                                   dns_found_callback found, void *callback_arg,
                                   u8_t dns_addrtype, u32_t *ttl, uint8_t cid);


#if DNS_LOCAL_HOSTLIST
size_t         dns_local_iterate(dns_found_callback iterator_fn, void *iterator_arg);
err_t          dns_local_lookup(const char *hostname, ip_addr_t *addr, u8_t dns_addrtype);
#if DNS_LOCAL_HOSTLIST_IS_DYNAMIC
int            dns_local_removehost(const char *hostname, const ip_addr_t *addr);
err_t          dns_local_addhost(const char *hostname, const ip_addr_t *addr);
#endif /* DNS_LOCAL_HOSTLIST_IS_DYNAMIC */
#endif /* DNS_LOCAL_HOSTLIST */

#if LWIP_TIMER_ON_DEMOND
void dns_entry_retry_timer_handler(void* arg);
void dns_entry_cache_timer_handler(void* arg);

#endif

#if PS_ENABLE_TCPIP_HIB_SLEEP2_MODE
struct dns_table_entry * dns_find_adpt_hib_tiny_entry(void);
void dns_add_cache_entry(struct dns_result_tag *result, u32_t active_time, char *name);
#endif


#ifdef __cplusplus
}
#endif

#endif /* LWIP_DNS */

#endif /* LWIP_HDR_DNS_H */
