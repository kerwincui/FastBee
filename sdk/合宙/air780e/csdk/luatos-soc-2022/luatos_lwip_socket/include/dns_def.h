/*
 * dns_def.h
 *
 *  Created on: 2022年4月13日
 *      Author: Administrator
 */

#ifndef __ETHERNET_COMMON_DNS_DEF_H__
#define __ETHERNET_COMMON_DNS_DEF_H__

#define DNS_SERVER_PORT                    (53)
#define MAX_DNS_SERVER				4

#include "luat_network_adapter.h"

typedef struct
{
	llist_head node;
	Buffer_Struct uri; //动态需要释放
	luat_dns_ip_result ip_result[MAX_DNS_IP];
	void *param;
	int result;
	uint8_t adapter_index;
}luat_dns_require_t;

typedef struct
{
	luat_ip_addr_t dns_server[MAX_DNS_SERVER];
	llist_head process_head;
	llist_head require_head;
	uint16_t session_id;
	uint8_t is_static_dns[MAX_DNS_SERVER];
	uint8_t is_run;
}dns_client_t;
void dns_init_client(dns_client_t *client);
uint8_t dns_check_uri(const char *uri, uint32_t uri_len);
void dns_require(dns_client_t *client, const char *domain_name, uint32_t len, void *param);
void dns_require_ex(dns_client_t *client, const char *domain_name, void *param, uint8_t adapter_index);
void dns_clear(dns_client_t *client);
void dns_run(dns_client_t *client, Buffer_Struct *in, Buffer_Struct *out, int *server_cnt);
#endif /* __ETHERNET_COMMON_DNS_DEF_H__ */
