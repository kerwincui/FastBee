#ifndef __USBMST_EXTERNAL_H__
#define __USBMST_EXTERNAL_H__

#define ERR_DEV_BASE  (-200)
#define ERR_DEV_NUM_REDEF(err) (ERR_DEV_BASE + err)

#define ERR_DEV_NO_INIT  ERR_DEV_NUM_REDEF(-1)
#define ERR_DEV_NO_CONNECT  ERR_DEV_NUM_REDEF(-2)

#define ERR_DEV_NOTIFY_COND_DEFAULT_ERR  ERR_DEV_NUM_REDEF(-40)
#define ERR_DEV_NOTIFY_COND_EXIST_ERR  ERR_DEV_NUM_REDEF(-41)
#define ERR_DEV_NOTIFY_HOSTNODET_ERR  ERR_DEV_NUM_REDEF(-43)

int serial_vcom0_uplink_xfer_cfg(uint16_t xfsiz);
int serial_vcom0_uplink_get_epnum(void);
int serial_vcom0_downlink_get_epnum(void);

int serial_vcom1_uplink_xfer_cfg(uint16_t xfsiz);
int serial_vcom1_uplink_get_epnum(void);
int serial_vcom1_downlink_get_epnum(void);

int serial_vcom2_uplink_xfer_cfg(uint16_t xfsiz);
int serial_vcom2_uplink_get_epnum(void);
int serial_vcom2_downlink_get_epnum(void);


typedef enum
{
    rndis_stat_connect = 0,
    rndis_stat_disconn = 1
}rndis_conn_stat_type;

typedef enum
{
    ecm_stat_disconn = 0,
    ecm_stat_connect = 1,
}ecm_conn_stat_type;

typedef struct tag_ecm_ext_conn_info 
{
    uint8_t conn_stat;
    uint32_t speed;    
}ecm_ext_conninfo_msg_st;

int32_t rndis0_uplink_xfer_cfg(uint16_t xfsiz);
int32_t rndis0_uplink_get_epnum(void);
int32_t rndis0_downlink_get_epnum(void);

int32_t rndis0_sig_conn_test(rndis_conn_stat_type conn_stat);
int32_t rndis0_sig_conn_stat(rndis_conn_stat_type conn_stat);

int ecm0_sig_conn_stat(ecm_conn_stat_type conn_stat);
int ecm0_sig_conn_info(ecm_ext_conninfo_msg_st *p_conn_info);

#define NOTIFY_MSG_INIT 0x00000002
#define NOTIFY_MSG_HALT 0x00000003
#define NOTIFY_MSG_RESET 0x00000004

extern void usbDevNotifyRndisEvent(uint32_t flag, void* args);

#endif
