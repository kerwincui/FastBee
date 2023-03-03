#ifndef __LUAT_NW_ADAPTER_H__
#define __LUAT_NW_ADAPTER_H__
#include "luat_base.h"
#define LUAT_USE_LWIP
#define LUAT_USE_TLS
#define LUAT_USE_DNS
#define LWIP_NUM_SOCKETS 8
// #ifdef LUAT_USE_NETWORK
#include "luat_rtos.h"
#include "bsp_common.h"
#ifdef LUAT_USE_TLS
#include "mbedtls/ssl.h"
#include "mbedtls/platform.h"
#include "mbedtls/debug.h"
#include "mbedtls/x509_crt.h"
#include "mbedtls/base64.h"
#include "mbedtls/ctr_drbg.h"
#include "mbedtls/entropy.h"
#include "mbedtls/sha1.h"
#endif
#ifdef LUAT_USE_LWIP
#include "lwip/opt.h"
#include "lwip/netif.h"
#include "lwip/timeouts.h"
#include "lwip/priv/tcp_priv.h"

#include "lwip/def.h"
#include "lwip/memp.h"
#include "lwip/priv/tcpip_priv.h"

#include "lwip/ip4_frag.h"
#include "lwip/etharp.h"
#include "lwip/dhcp.h"
#include "lwip/prot/dhcp.h"
#include "lwip/autoip.h"
#include "lwip/igmp.h"
#include "lwip/dns.h"
#include "lwip/nd6.h"
#include "lwip/ip6_frag.h"
#include "lwip/mld6.h"
#include "lwip/dhcp6.h"
#include "lwip/sys.h"
#include "lwip/pbuf.h"
#include "lwip/inet.h"
#endif
#ifndef __BSP_COMMON_H__
#include "c_common.h"
#endif
#define MAX_DNS_IP		(4)	//每个URL最多保留4个IP

enum
{
	EV_NW_RESET = USER_EVENT_ID_START + 0x1000000,
	EV_NW_STATE,
	EV_NW_TIMEOUT,
	EV_NW_DNS_RESULT,
	EV_NW_SOCKET_TX_OK,
	EV_NW_SOCKET_RX_NEW,
	EV_NW_SOCKET_RX_FULL,
	EV_NW_SOCKET_CLOSE_OK,
	EV_NW_SOCKET_REMOTE_CLOSE,
	EV_NW_SOCKET_CONNECT_OK,

	EV_NW_SOCKET_ERROR,
	EV_NW_SOCKET_LISTEN,
	EV_NW_SOCKET_NEW_CONNECT,	//作为server接收到新的connect，只有允许accept操作的才有，否则直接上报CONNECT_OK
	EV_NW_BREAK_WAIT,
	EV_NW_END,

	NW_STATE_LINK_OFF = 0,
	NW_STATE_OFF_LINE,
	NW_STATE_WAIT_DNS,
	NW_STATE_CONNECTING,
	NW_STATE_SHAKEHAND,
	NW_STATE_ONLINE,
	NW_STATE_LISTEN,
	NW_STATE_DISCONNECTING,

	NW_WAIT_NONE = 0,
	NW_WAIT_LINK_UP,
	NW_WAIT_ON_LINE,
	NW_WAIT_TX_OK,
	NW_WAIT_OFF_LINE,
	NW_WAIT_EVENT,

	//一旦使用高级API，回调会改为下面的，param1 = 0成功，其他失败
	EV_NW_RESULT_BASE = EV_NW_END + 1,
	EV_NW_RESULT_LINK = EV_NW_RESULT_BASE + NW_WAIT_LINK_UP,
	EV_NW_RESULT_CONNECT = EV_NW_RESULT_BASE + NW_WAIT_ON_LINE,
	EV_NW_RESULT_CLOSE = EV_NW_RESULT_BASE + NW_WAIT_OFF_LINE,
	EV_NW_RESULT_TX = EV_NW_RESULT_BASE + NW_WAIT_TX_OK,
	EV_NW_RESULT_EVENT = EV_NW_RESULT_BASE + NW_WAIT_EVENT,

	NW_ADAPTER_INDEX_LWIP_NONE = 0,
	NW_ADAPTER_INDEX_LWIP_GPRS,	//蜂窝网络模块
	NW_ADAPTER_INDEX_LWIP_WIFI_STA,	//WIFI SOC
	NW_ADAPTER_INDEX_LWIP_WIFI_AP,	//WIFI SOC
	NW_ADAPTER_INDEX_LWIP_ETH,		//自带以太网控制器的SOC
	NW_ADAPTER_INDEX_LWIP_NETIF_QTY,
	NW_ADAPTER_INDEX_HW_PS_DEVICE = NW_ADAPTER_INDEX_LWIP_NETIF_QTY,
	NW_ADAPTER_INDEX_ETH0 = NW_ADAPTER_INDEX_HW_PS_DEVICE,	//外挂以太网+硬件协议栈
	NW_ADAPTER_INDEX_USB,			//USB网卡
	NW_ADAPTER_QTY,

	NW_CMD_AUTO_HEART_TIME = 0,



};

#ifdef LUAT_USE_LWIP
#define luat_ip_addr_t ip_addr_t
#else
typedef struct
{
	union
	{
		uint32_t ipv4;
		uint32_t ipv6_u32_addr[4];
	    uint8_t  ipv6_u8_addr[16];
	};
	uint8_t is_ipv6;
}luat_ip_addr_t;
uint8_t network_string_is_ipv4(const char *string, uint32_t len);
uint32_t network_string_to_ipv4(const char *string, uint32_t len);
int network_string_to_ipv6(const char *string, luat_ip_addr_t *ip_addr);
#endif

typedef struct
{
	uint64_t tag;
	void *param;
}luat_network_cb_param_t;

typedef struct
{
	uint32_t ttl_end;
	luat_ip_addr_t ip;
}luat_dns_ip_result;


typedef struct
{
	/* data */
	llist_head node;
	Buffer_Struct uri;
	luat_dns_ip_result result[MAX_DNS_IP];
	uint8_t ip_nums;
}luat_dns_cache_t;

typedef struct
{
	uint64_t tx_size;
	uint64_t ack_size;
	uint64_t tag;
#ifdef LUAT_USE_TLS
	//SSL相关数据均为动态生成的，需要在close的时候释放
    mbedtls_ssl_context *ssl;          /**< mbed TLS control context. */
    mbedtls_ssl_config *config;          /**< mbed TLS configuration context. */
    mbedtls_x509_crt *ca_cert;
#endif

	CBFuncEx_t user_callback;
	void *user_data;			//传递给user_callback的pParam
	void *socket_param;			//一般用来存放network_ctrl本身，用于快速查找
	HANDLE	task_handle;
	HANDLE timer;
	HANDLE tls_short_timer;
	HANDLE tls_long_timer;
	HANDLE mutex;
	uint32_t tcp_keep_idle;
	int socket_id;
	char *domain_name;			//动态生成的，需要在close的时候释放
	uint32_t domain_name_len;
	luat_ip_addr_t remote_ip;
	luat_dns_ip_result *dns_ip;	//动态生成的，需要在close的时候释放
	luat_ip_addr_t *online_ip;	//指向某个ip，无需释放
	uint16_t remote_port;
	uint16_t local_port;
	uint8_t *cache_data;	//动态生成的，需要在close的时候释放
	uint32_t cache_len;
	int tls_timer_state;
	uint32_t tcp_timeout_ms;
	uint8_t tls_mode;
    uint8_t tls_need_reshakehand;
    uint8_t need_close;
    uint8_t new_rx_flag;
    uint8_t dns_ip_cnt;
    uint8_t dns_ip_nums;
    uint8_t tcp_keep_alive;
	uint8_t tcp_keep_interval;
	uint8_t tcp_keep_cnt;
    uint8_t adapter_index;
    uint8_t is_tcp;
    uint8_t is_server_mode;
    uint8_t auto_mode;
    uint8_t wait_target_state;
    uint8_t state;
    uint8_t is_debug;
}network_ctrl_t;

typedef struct
{
	uint64_t tag;
#ifdef LUAT_USE_LWIP
	llist_head wait_ack_head;
#endif
	llist_head tx_head;
	llist_head rx_head;
	uint32_t rx_wait_size;
	uint32_t tx_wait_size;
#ifdef LUAT_USE_LWIP
	union {
		struct ip_pcb  *ip;
		struct tcp_pcb *tcp;
		struct udp_pcb *udp;
		struct raw_pcb *raw;
	} pcb;
	HANDLE mutex;
	uint16_t local_port;
	uint16_t remote_port;
#endif
	void *param;
	uint8_t state;
	uint8_t is_tcp;
	uint8_t is_ipv6;
	uint8_t in_use;
	uint8_t rx_waiting;
}socket_ctrl_t;		//推荐底层协议栈适配用的socket状态结构

/*
 * info内的api必须全部是非阻塞的及任务的，并且对socket_id和tag做合法性检查
 * 目前只支持tcp和udp，不支持raw
 * 如果没有特殊说明，成功返回=0，失败返回<0
 */
typedef struct
{
	//检查网络是否准备好，返回非0准备好，user_data是注册时的user_data，传入给底层api
	uint8_t (*check_ready)(void *user_data);
	//创建一个socket，并设置成非阻塞模式，user_data传入对应适配器, tag作为socket的合法依据，给check_socket_vaild比对用
	//成功返回socketid，失败 < 0
	int (*create_soceket)(uint8_t is_tcp, uint64_t *tag, void *param, uint8_t is_ipv6, void *user_data);
	//作为client绑定一个port，并连接remote_ip和remote_port对应的server
	//成功返回0，失败 < 0
	int (*socket_connect)(int socket_id, uint64_t tag, uint16_t local_port, luat_ip_addr_t *remote_ip, uint16_t remote_port, void *user_data);
	//作为server绑定一个port，开始监听
	//成功返回0，失败 < 0
	int (*socket_listen)(int socket_id, uint64_t tag, uint16_t local_port, void *user_data);
	//作为server接受一个client
	//成功返回0，失败 < 0
	int (*socket_accept)(int socket_id, uint64_t tag, luat_ip_addr_t *remote_ip, uint16_t *remote_port, void *user_data);
	//主动断开一个tcp连接，需要走完整个tcp流程，用户需要接收到close ok回调才能确认彻底断开
	//成功返回0，失败 < 0
	int (*socket_disconnect)(int socket_id, uint64_t tag, void *user_data);
	//释放掉socket的控制权，除了tag异常外，必须立刻生效
	//成功返回0，失败 < 0
	int (*socket_close)(int socket_id, uint64_t tag, void *user_data);
	//强行释放掉socket的控制权，必须立刻生效
	//成功返回0，失败 < 0
	int (*socket_force_close)(int socket_id, void *user_data);
	//tcp时，不需要remote_ip和remote_port，如果buf为NULL，则返回当前缓存区的数据量，当返回值小于len时说明已经读完了
	//udp时，只返回1个block数据，需要多次读直到没有数据为止
	//成功返回实际读取的值，失败 < 0
	int (*socket_receive)(int socket_id, uint64_t tag, uint8_t *buf, uint32_t len, int flags, luat_ip_addr_t *remote_ip, uint16_t *remote_port, void *user_data);
	//tcp时，不需要remote_ip和remote_port
	//成功返回>0的len，缓冲区满了=0，失败 < 0，如果发送了len=0的空包，也是返回0，注意判断
	int (*socket_send)(int socket_id, uint64_t tag, const uint8_t *buf, uint32_t len, int flags, luat_ip_addr_t *remote_ip, uint16_t remote_port, void *user_data);
	//检查socket合法性，成功返回0，失败 < 0
	int (*socket_check)(int socket_id, uint64_t tag, void *user_data);
	//保留有效的socket，将无效的socket关闭
	void (*socket_clean)(int *vaild_socket_list, uint32_t num, void *user_data);
	int (*getsockopt)(int socket_id, uint64_t tag, int level, int optname, void *optval, uint32_t *optlen, void *user_data);
	int (*setsockopt)(int socket_id, uint64_t tag, int level, int optname, const void *optval, uint32_t optlen, void *user_data);
	//非posix的socket，用这个根据实际硬件设置参数
	int (*user_cmd)(int socket_id, uint64_t tag, uint32_t cmd, uint32_t value, void *user_data);

	int (*dns)(const char *domain_name, uint32_t len, void *param,  void *user_data);
	int (*set_dns_server)(uint8_t server_index, luat_ip_addr_t *ip, void *user_data);
#ifdef LUAT_USE_LWIP
	int (*set_mac)(uint8_t *mac, void *user_data);
	int (*set_static_ip)(luat_ip_addr_t *ip, luat_ip_addr_t *submask, luat_ip_addr_t *gateway, luat_ip_addr_t *ipv6, void *user_data);
#endif
	int (*get_local_ip_info)(luat_ip_addr_t *ip, luat_ip_addr_t *submask, luat_ip_addr_t *gateway, void *user_data);
	//所有网络消息都是通过cb_fun回调
	//cb_fun回调时第一个参数为OS_EVENT，包含了socket的必要信息，第二个是luat_network_cb_param_t，其中的param是这里传入的param(就是适配器序号)
	//OS_EVENT ID为EV_NW_XXX，param1是socket id param2是各自参数 param3是create_soceket传入的socket_param(就是network_ctrl *)
	//dns结果是特别的，ID为EV_NW_SOCKET_DNS_RESULT，param1是获取到的IP数据量，0就是失败了，param2是ip组，动态分配的， param3是dns传入的param(就是network_ctrl *)
	void (*socket_set_callback)(CBFuncEx_t cb_fun, void *param, void *user_data);

	char *name;
	int max_socket_num;//最大socket数量，也是最大network_ctrl申请数量的基础值
	uint8_t no_accept;
	uint8_t is_posix;
}network_adapter_info;
/*
 * api有可能涉及到任务安全要求，不可以在中断里运行，只能在task中运行
 */

//获取最后一个注册的适配器序号
int network_get_last_register_adapter(void);
/****************************以下是通用基础api********************************************************/
/*
 * 在使用之后任意API前，必须先注册相关的协议栈接口
 * 没有可逆的api
 */
int network_register_adapter(uint8_t adapter_index, network_adapter_info *info, void *user_data);

void network_register_set_default(uint8_t adapter_index);

void network_set_dns_server(uint8_t adapter_index, uint8_t server_index, luat_ip_addr_t *ip);
/*
 * 申请一个network_ctrl
 */
network_ctrl_t *network_alloc_ctrl(uint8_t adapter_index);
/*
 * 归还一个network_ctrl
 */
void network_release_ctrl(network_ctrl_t *ctrl);
/*
 * 在使用network_ctrl前，必须先初始化
 * lua调用c时，必须使用非阻塞接口，task_handle，callback，param都不需要
 * 在纯c调用时，如果不需要则塞应用，必须有callback和param
 * 在纯c调用时，如果需要阻塞应用，则必须有task_handle，建议有callback，param，可以等待消息时，同时在callback中处理其他类型的消息
 */
void network_init_ctrl(network_ctrl_t *ctrl, HANDLE task_handle, CBFuncEx_t callback, void *param);

/*
 * 设置是tcp还是udp模式及TCP自动保活相关参数，也可以直接改network_ctrl_t中的is_tcp参数
 * 设置必须在socket处于close状态，在进行connect和tls初始之前
 */
void network_set_base_mode(network_ctrl_t *ctrl, uint8_t is_tcp, uint32_t tcp_timeout_ms, uint8_t keep_alive, uint32_t keep_idle, uint8_t keep_interval, uint8_t keep_cnt);
/*
 * 检查网络是否已经连接，注意不是socket
 * 返回非0是已连接，可以开始socket操作
 */
uint8_t network_check_ready(network_ctrl_t *ctrl);

/*
 * 设置本地port，注意不要用60000及以上，如果local_port为0，系统从60000开始随机抽一个
 * 如果local_port不为0，且重复了，则返回-1，其他返回0
 */
int network_set_local_port(network_ctrl_t *ctrl, uint16_t local_port);
//创建一个socket
//成功返回0，失败 < 0
int network_create_soceket(network_ctrl_t *ctrl, uint8_t is_ipv6);

//作为client连接server
//成功返回0，失败 < 0
int network_socket_connect(network_ctrl_t *ctrl, luat_ip_addr_t *remote_ip);
//作为server开始监听
//成功返回0，失败 < 0
int network_socket_listen(network_ctrl_t *ctrl);

uint8_t network_accept_enable(network_ctrl_t *ctrl);
//作为server接受一个client
//成功返回0，失败 < 0
int network_socket_accept(network_ctrl_t *ctrl, network_ctrl_t *accept_ctrl);
//主动断开一个tcp连接，需要走完整个tcp流程，用户需要接收到close ok回调才能确认彻底断开
//成功返回0，失败 < 0
int network_socket_disconnect(network_ctrl_t *ctrl);
//释放掉socket的控制权
//成功返回0，失败 < 0
int network_socket_close(network_ctrl_t *ctrl);
//强行释放掉socket的控制权
//成功返回0，失败 < 0
int network_socket_force_close(network_ctrl_t *ctrl);
//tcp时，不需要remote_ip和remote_port，如果buf为NULL，则返回当前缓存区的数据量，当返回值小于len时说明已经读完了
//udp时，只返回1个block数据，需要多次读直到没有数据为止
//成功返回实际读取的值，失败 < 0
int network_socket_receive(network_ctrl_t *ctrl,uint8_t *buf, uint32_t len, int flags, luat_ip_addr_t *remote_ip, uint16_t *remote_port);
//tcp时，不需要remote_ip和remote_port
//成功返回0，失败 < 0
int network_socket_send(network_ctrl_t *ctrl,const uint8_t *buf, uint32_t len, int flags, luat_ip_addr_t *remote_ip, uint16_t remote_port);

int network_getsockopt(network_ctrl_t *ctrl, int level, int optname, void *optval, uint32_t *optlen);
int network_setsockopt(network_ctrl_t *ctrl, int level, int optname, const void *optval, uint32_t optlen);
//非posix的socket，用这个根据实际硬件设置参数
int network_user_cmd(network_ctrl_t *ctrl,  uint32_t cmd, uint32_t value);
#ifdef LUAT_USE_LWIP
int network_set_mac(uint8_t adapter_index, uint8_t *mac);
int network_set_static_ip_info(uint8_t adapter_index, luat_ip_addr_t *ip, luat_ip_addr_t *submask, luat_ip_addr_t *gateway, luat_ip_addr_t *ipv6);
#endif
int network_get_local_ip_info(network_ctrl_t *ctrl, luat_ip_addr_t *ip, luat_ip_addr_t *submask, luat_ip_addr_t *gateway);
void network_force_close_socket(network_ctrl_t *ctrl);
//url已经是ip形式了，返回1，并且填充remote_ip
//成功返回0，失败 < 0
int network_dns(network_ctrl_t *ctrl);

void network_clean_invaild_socket(uint8_t adapter_index);

const char *network_ctrl_state_string(uint8_t state);
const char *network_ctrl_wait_state_string(uint8_t state);
const char *network_ctrl_callback_event_string(uint32_t event);
/****************************通用基础api结束********************************************************/

/****************************tls相关api************************************************************/
/*
 * 给DTLS设置PSK，给UDP加密传输时用的
 */
int network_set_psk_info(network_ctrl_t *ctrl,
		const unsigned char *psk, size_t psk_len,
		const unsigned char *psk_identity, size_t psk_identity_len);

/*
 * TLS设置验证服务器的证书，可以不用
 */
int network_set_server_cert(network_ctrl_t *ctrl, const unsigned char *cert, size_t cert_len);
/*
 * TLS设置验证客户端的证书，只有双向认证才需要，而且一般只有金融领域才需要
 */
int network_set_client_cert(network_ctrl_t *ctrl,
		const unsigned char *cert, size_t certLen,
        const unsigned char *key, size_t keylen,
        const unsigned char *pwd, size_t pwdlen);
/*
 * 获取证书验证结果
 */
int network_cert_verify_result(network_ctrl_t *ctrl);
/*
 * 初始化加密传输
 * verify_mode参考MBEDTLS_SSL_VERIFY_XXX
 */
void network_init_tls(network_ctrl_t *ctrl, int verify_mode);
/*
 * 结束加密传输模式，恢复成正常模式
 */
void network_deinit_tls(network_ctrl_t *ctrl);
/*
 * 加密传输其他非阻塞api和通用api共用，阻塞api和rtos环境相关阻塞api通用，均由api内部做相关处理
 */
/****************************tls相关api结束************************************************************/


/****************************高级api，用于实现一个完整功能***********************/
//一旦使用下面的api，将由network内部自动判断状态并进行下一步操作，中间处理过程除了主动强制关闭socket，其他用户不能干预，直到达到目标状态，即使非阻塞回调也只回调最终结果。
//所有阻塞状态接口，一旦收到link down，socket close, error之类的消息就会返回错误，如果是timeout，只有wait event会返回成功，其他返回失败
//以下api是阻塞和非则塞均可，当network_ctrl中设置了task_handle 而且 timeout_ms > 0时为阻塞接口
//返回值统一成功返回0，失败 < 0，非阻塞需要等待返回1

int network_wait_link_up(network_ctrl_t *ctrl, uint32_t timeout_ms);
/*
 * 1.进行ready检测和等待ready
 * 2.有remote_ip则开始连接服务器并等待连接结果
 * 3.没有remote_ip则开始对url进行dns解析，解析完成后对所有ip进行尝试连接直到有个成功或者全部失败
 * 4.如果是加密模式，还要走握手环节，等到握手环节完成后才能返回结果
 * local_port如果为0则api内部自动生成一个
 * 使用前必须确保是在close状态，建议先用network_close
 */
int network_connect(network_ctrl_t *ctrl, const char *domain_name, uint32_t domain_name_len, luat_ip_addr_t *remote_ip, uint16_t remote_port, uint32_t timeout_ms);

int network_listen(network_ctrl_t *ctrl, uint32_t timeout_ms);

int network_close(network_ctrl_t *ctrl, uint32_t timeout_ms);
/*
 * timeout_ms=0时，为非阻塞接口
 * UDP的时候，remote_ip和remote_port和connect不一致的时候才需要remote_ip和remote_port
 * TCP不看remote_ip和remote_port
 * 则塞模式，*tx_len不需要看，非则塞模式需要看*tx_len的实际长度是不是和len一致
 */
int network_tx(network_ctrl_t *ctrl, const uint8_t *data, uint32_t len, int flags, luat_ip_addr_t *remote_ip, uint16_t remote_port, uint32_t *tx_len, uint32_t timeout_ms);
/*
 * 实际读到的数据量在read_len里，如果是UDP模式且为server时，需要看remote_ip和remote_port
 */
int network_rx(network_ctrl_t *ctrl, uint8_t *data, uint32_t len, int flags, luat_ip_addr_t *remote_ip, uint16_t *remote_port, uint32_t *rx_len);

/*
 * 接收到socket异常消息均会返回
 * timeout_ms=0时，为非阻塞接口
 * 如果为阻塞接口，out_event保存消息（拷贝，非引用），is_timeout保存是否超时
 * 返回0表示有数据接收或者超时返回，返回1表示切换到非阻塞等待，其他为网络异常
 */
int network_wait_event(network_ctrl_t *ctrl, OS_EVENT *out_event, uint32_t timeout_ms, uint8_t *is_timeout);

/*
 * 接收到socket异常，用户发送EV_NW_BREAK_WAIT，或者有新数据都会返回，如果是其他消息，通过network_init_ctrl里输入的回调函数使用，如果没有回调函数，就直接抛弃了
 * timeout_ms=0时，依然为阻塞接口，而且是永远等待
 * 返回0表示有数据接收，用户打断或者超时返回，其他为网络异常
 * 用户打断，is_break = 1，超时 is_timeout = 1
 */
int network_wait_rx(network_ctrl_t *ctrl, uint32_t timeout_ms, uint8_t *is_break, uint8_t *is_timeout);
/****************************高级api结束********************************************************************/
#endif
// #endif
