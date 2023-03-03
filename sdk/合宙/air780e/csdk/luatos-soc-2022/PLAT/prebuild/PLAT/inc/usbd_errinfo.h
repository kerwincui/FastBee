#ifndef __USBD_ERRINFO_H__
#define __USBD_ERRINFO_H__

typedef enum 
{
    usb_ctrl_mod = 0x10,

    usb_lpwmod = 0x20,

    usb_func_vcom_mod = 0x100,
    usb_func_ecm_mod ,
    usb_func_rndis_mod ,
    usb_dev_vcom_mod,
    usb_dev_ecm_mod ,
    usb_dev_rndis_mod ,
    usb_mdev_lib_mod,

    usb_user_base_mod = 0x1000,
    usb_ccinst_inhrnt_mod ,
}usb_stat_mod_type;


typedef enum 
{
    usbc_ctrl_fifo_cfg_err = 110,
    usbc_ctrl_fifo_retwkup_cfg_err,
    usbpcd_deinit_terminate_err,
    usbpcd_deinit_bsp_err,
    
        
    mdev_lib_load_reset_err = 180,
    mdev_lib_load_init_err,
        
    mdev_lib_load_upd_err,
    mdev_lib_load_end_err,
    mdev_lib_load_stat_err,
    mdev_lib_load_cnt_err,
    mdev_lib_bind_upd_err,    

    mdev_lib_init_start_ptr_nul_err = 190,    
    mdev_lib_init_fin_ptr_nul_err,    
    mdev_lib_init_func_bind_err,    
    mdev_lib_init_clstype_bind_err,    

    
    mdev_lib_cust_ptr_nul_err =210,
    mdev_lib_devnm_nul_err,
    mdev_lib_elem_cnt_err,
    mdev_lib_elem_swap_err,
    mdev_lib_map_residx_err,
    mdev_lib_func_nul_err,
    mdev_lib_cls_nul_err,
    mdev_lib_clsbase_nul_err,
    
    
    mdev_lib_ccinfo_map_err,
    mdev_lib_ccinst_nul_err,
    mdev_lib_ccset_nul_err,   

    mdev_cls_deinit_terminate_start_err = 230,
    mdev_cls_deinit_terminate_finish_err,    
    mdev_cls_deinit_unbind_err,    
    

    func_bind_flag_err = 240,
    func_data_null_err,
    func_malloc_fail_err,    
    func_intf_cnt_err,
    func_intf_id_err,
    func_oep_id_err,
    func_iep_id_err,
    func_cmdep_id_err,
    
    func_buf_type_err,
    
    func_txbuf_null_err,
    func_rxbuf_null_err,
    func_terminate_initstat_err,

    func_ccinst_bind_fail_err,
    func_ccinst_invalid_err,
    func_ccinst_maintp_err,
    func_ccinst_desc_ass_err,
    func_ccinst_desc_parse_err,    
    func_inst_id_err ,
    func_str_id_err,
        
    func_set_strdesc_err,

    desc_parse_err_base = 280,
    desc_parse_err_tpinvalid,        
    desc_parse_err_ass0,
    desc_parse_err_len0,
    desc_parse_err_len_ovf,    
    desc_parse_err_epdesclen,    
    
    desc_parse_err_epdescptr_1,    
    desc_parse_err_epdescptr_2,  
    desc_parse_err_intfdesclen,    
    desc_parse_err_parserslt,    
    
    usblpw_retothwk_pre_rest_illegal = 0x300,
    usblpw_retothwk_pre_rest_fail,
    usblpw_retothwk_gpwr_match_fail,
    usblpw_retothwk_stack_rest_illeagl,
    usblpw_retothwk_stack_rest_fail,
}usb_mod_err_type;

void usbd_set_mod_last_err(uint16_t mod, uint16_t err_no);
uint32_t usbd_get_mod_last_err(void);

#endif

