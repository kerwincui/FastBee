#ifndef __NET_LWIP_H__
#define __NET_LWIP_H__
void net_lwip_register_adapter(uint8_t adapter_index);
void net_lwip_init(void);
int net_lwip_check_all_ack(int socket_id);
void net_lwip_set_netif(uint8_t adapter_index, struct netif *netif, void *init, uint8_t is_default);
struct netif * net_lwip_get_netif(uint8_t adapter_index);
void net_lwip_input_packets(struct netif *netif, struct pbuf *p);
/*
 * 如果是需要使用静态IP，则需要先设置好IP，再设置linkup
 * 如果之前设置了静态IP，现在想用动态IP，需要先删掉静态IP，再linkup
 * 一旦linkup，如果没有使用静态IP，就会启动DHCP
 * 不能用过DHCP获取IP的网卡，必须先设置静态IP！！！！！！，比如GPRS
 */
void net_lwip_set_link_state(uint8_t adapter_index, uint8_t updown);

/*
 * GPRS网卡专用，user_data填adapter_index，不从network_adapter走
 */
int net_lwip_set_static_ip(ip_addr_t *ip, ip_addr_t *submask, ip_addr_t *gateway, ip_addr_t *ipv6, void *user_data);
#endif
