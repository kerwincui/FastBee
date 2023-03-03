#ifndef __USBMST_TOP_H__
#define __USBMST_TOP_H__

#include "usbc_basic_def.h"


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/
#if 0
/*usbc low level defination*/
#define USBC_CTRL_CORE_BASE_ADDR                 0x1A000000
#define USBC_GRXSTSP_ADDR   (USBC_CTRL_CORE_BASE_ADDR+0x20)

#define USBC_FIFO_BASE_ADDR (USBC_CTRL_CORE_BASE_ADDR+0x1000)

#define MAX_EP_OUT_NUM    (13)
#endif



/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/

#define LOCMAP_MAX_SUPPORT_FUNCTION 5
#define LOCMAP_MAX_EP_OUT_NUM 13
#define LOCMAP_INVALID_FUNC_NUM 0xf
typedef struct
{
    usbd_locmap_elem_st func_elem_arr[LOCMAP_MAX_SUPPORT_FUNCTION];
    uint8_t epout_func_idx_arr[LOCMAP_MAX_EP_OUT_NUM];
}usbd_locmap_st;

typedef struct {
    //fix len 8
    uint8_t* setup_dest_base_addr;
}usbc_uldpmgr_setup_trans;


typedef struct {
    uint8_t * xfer_buff;
    uint32_t xfer_len;
}usbc_uldpmgr_oep_trans;

typedef struct {
    uint32_t       total_size;
    uint8_t *      extract_addr;//extract mode addr, used only for rndis, ppp
}usbc_uldpmgr_extract_trans;//not used

struct tag_usbmst_top;


typedef struct tag_usbmst_cmn_lowlevel_ops
{
    void (*reset_handler)(void *pdev ,uint8_t speed);

    int32_t  (*init_handler)         (struct tag_usbmst_top *ptop , uint8_t cfgidx);
    int32_t  (*deinit_handler)       (struct tag_usbmst_top  *ptop , uint8_t cfgidx);
    int32_t  (*suspend_handler) (struct tag_usbmst_top  *ptop);
    int32_t  (*resume_handler) (struct tag_usbmst_top  *ptop);
}usbmst_cmn_lowlevel_ops;

typedef struct tag_usbmst_uldp_lowlevel_ops
{
    int32_t  (*cfg_setup_trans) (struct tag_usbmst_top  *p_usbmst_top, usbc_uldpmgr_setup_trans*);
    int32_t  (*cfg_ep_trans) (struct tag_usbmst_top  *p_usbmst_top, uint8_t epnum, usbc_uldpmgr_oep_trans*);
    int32_t  (*get_avail_size)          (struct tag_usbmst_top  *p_usbmst_top, uint8_t epnum);
    int32_t  (*get_ep_all_cmpl_stat) (struct tag_usbmst_top  *p_usbmst_top);
    int32_t  (*clear_epn_cmpl_stat) (struct tag_usbmst_top *p_usbmst_top, uint8_t epnum, uint8_t usb_intr_ctx);
}usbmst_uldp_lowlevel_ops;


typedef struct tag_usbmst_tftc_lowlevel_ops
{
    int32_t (*func_rsv)(struct tag_usbmst_top  *ptop);
}usbmst_tftc_lowlevel_ops;

typedef struct tag_usbmst_uldp_ctrl_ep
{
    uint8_t is_packet_extract_mode;
    uint32_t extract_head_len;


    uint32_t       idx;
    uint32_t       avail_size_end;
    uint32_t       avail_size_start;
    uint32_t       total_size;
    uint8_t *      extract_addr;//extract mode addr, used only for rndis, ppp
}usbmst_uldp_ctrl_ep_st;

typedef struct tag_usbmst_uldp_ep_trans_stat
{
    uint8_t ep_idx;
    uint8_t ep_event;
}usbmst_uldp_ep_trans_stat_st;

typedef struct tag_usbmst_uldp_trans_stat
{
    uint8_t ep_cnt;
    usbmst_uldp_ep_trans_stat_st ep_arr[MAX_EP_OUT_NUM];
}usbmst_uldp_ctrl_trans_stat_st;

struct tag_usbmst_uldp_dev;
typedef uint32_t  (* pfn_usbmst_uldp_handler)(struct tag_usbmst_top *pdev);

typedef struct tag_usbmst_top_dev
{
  uint8_t        wkup_first_reset;
  uint8_t        enum_spd;
  usbmst_uldp_ctrl_ep_st     out_ep[MAX_EP_OUT_NUM];//not used
  usbmst_cmn_lowlevel_ops         *p_usbmst_cmn_lowlevel_ops;//common usb event callback, provided by uplayer, called by usbc
  usbmst_uldp_lowlevel_ops         *p_usbmst_uldp_lowlevel_ops;//uldp event callback, provided by uplayer, called by usbc
  usbmst_tftc_lowlevel_ops   *p_usbmst_tftc_lowlevel_ops;//currently reserved
  usbd_locmap_st t_usbd_locmap;
  uint8_t *setup_pkt_addr;
  uint8_t zlp_xfer_buff_fix[64];
}usbmst_top_dev_st;



typedef struct tag_usbmst_top
{
    usbmst_top_dev_st     dev;
    usbmst_uldp_ctrl_trans_stat_st t_trans_stat;/*filled by uldp rx callback, to pass event info to usbc, current only for ep0*/
    pfn_usbmst_uldp_handler ptr_usbmst_uldp_handler;/*provided by usbc, called by uldp rx callback to indicate ep0 recv info to usbc*/
}
usbmst_top_st;



/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

/**
\fn        uint32_t usbmst_top_early_init(usbmst_top_st *p_usbmst_top)
\brief     provide by uplayer, called by usbc driver to get callbacks
\param[in] p_usbmst_top  pointer to usbmst top var
\return    uint32_t
\note
*/
uint32_t usbmst_top_early_init(usbmst_top_st *p_usbmst_top);

/**
\fn        uint32_t usbmst_get_oep_xfer_reg(uint32_t epnum)
\brief     provide by usbc, called by uldp callback to get transfer info
           raw register info.
\param[in] epnum  out ep number
\return    uint32_t
\note      called in uldp rx callback,interrupt context
*/
uint32_t usbmst_get_oep_xfer_reg(uint32_t epnum);

/**
\fn        uint32_t usbmst_get_oep_real_xfercnt(uint32_t epnum)
\brief     provide by usbc, called by uldp callback to get current
           transfer cnt
\param[in] epnum  out ep number
\return    uint32_t
\note      called in uldp rx callback,interrupt context
           pass to rx task for recv length checking
*/
uint32_t usbmst_get_oep_real_xfercnt(uint32_t epnum);
int serial_vcom0_uplink_xfer_cfg(uint16_t xfsiz);
int serial_vcom1_uplink_xfer_cfg(uint16_t xfsiz);
int serial_vcom2_uplink_xfer_cfg(uint16_t xfsiz);

int32_t usbmst_transfer_devcfg_uplink_transfer(uint8_t multidev_load_idx, uint8_t dev_cls_type, uint16_t xfer_size);
void usbc_usbmst_mgr_resume_hook(void);
void usbc_usbmst_mgr_suspend_hook(void);

#endif

