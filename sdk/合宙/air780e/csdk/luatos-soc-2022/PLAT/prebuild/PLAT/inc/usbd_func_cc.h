#ifndef __USBD_FUNC_CC_H__
#define __USBD_FUNC_CC_H__


typedef enum
{
    ccinst_setting_mainttp_none = 0,
    ccinst_setting_cdc_vcom_maintp = 1,
}ccinst_setting_maintype;

typedef enum
{
    ccinst_setting_subtp_none = 0,
    ccinst_setting_vcom_subtp0_inhrnt =1,
    ccinst_setting_vcom_subtp1_2ep,
    ccinst_setting_vcom_subtp2_3ep,
}ccinst_setting_subtype;

#define USB_DEVICE_DESCRIPTOR_TYPE              0x01
#define USB_CONFIGURATION_DESCRIPTOR_TYPE       0x02
#define USB_STRING_DESCRIPTOR_TYPE              0x03
#define USB_INTERFACE_DESCRIPTOR_TYPE           0x04
#define USB_ENDPOINT_DESCRIPTOR_TYPE            0x05

#define STANDARD_ENDPOINT_DESC_SIZE             0x07


struct tag_usb_func_ccinst;

typedef struct {
    uint8_t *p_desc_buff_ptr;
    uint16_t desc_buff_size;

    uint8_t b_intf_ctrl_desc_upd: 1;
    uint8_t rsv: 7;
    uint8_t  bInterfaceClass;
    uint8_t  bInterfaceSubClass;
    uint8_t  bInterfaceProtocol;
}ccinst_desc_call_data_st;


typedef struct {
    uint8_t intf_str_id;
    
    uint8_t ep_ctrl_num : 4;
    uint8_t ep_datain_num: 4;
    uint8_t ep_dataout_num: 4;
    
    uint8_t interface_cnt:4;
    uint8_t intf_base_idx: 4;
    uint8_t  intf_1st_idx :4;
    uint8_t  intf_2nd_idx:4;
    uint8_t rsv:4;
    
}ccinst_bind_call_data_st;


typedef struct tag_ccinst_setting_base
{
    ccinst_setting_maintype setting_maintp;
    ccinst_setting_subtype  setting_subtp;  
}ccinst_setting_base_st;


typedef struct tag_ccinst_cdc_setting
{
    ccinst_setting_base_st bs_set;
    uint8_t map_flag : 1;
    uint8_t desc_assigned : 1;
    uint8_t desc_parsed : 1;
    uint8_t binded          :1;
    uint8_t epctrl_valid : 1;
    uint8_t epout_valid : 1;
    uint8_t epin_valid: 1;
    uint8_t rsv_1: 2;
    
    uint8_t interface_cnt:4;
    uint8_t  rsv_2:4;    
    
    uint8_t ep_ctrl_num : 4;
    uint8_t ep_datain_num: 4;
    uint8_t ep_dataout_num: 4;
    uint8_t intf_base_idx: 4;
    
    uint8_t  intf_1st_idx :4;
    uint8_t  intf_2nd_idx:4;
    
    uint8_t intf_str_id;

    uint16_t  desc_src_size;
    
    usb_endpoint_descriptor_st  * p_epctrl_d;
    usb_endpoint_descriptor_st  * p_epin_d;
    usb_endpoint_descriptor_st  * p_epout_d;    
    const uint8_t  *p_desc_src;

}ccinst_cdc_setting_st;

struct tag_usb_func_ccinst;


typedef uint8_t (*pfn_func_ccinst_desc_ass)(struct tag_usb_func_ccinst *p_func_ccinst);
typedef uint8_t (*pfn_func_ccinst_desc_parse)(struct tag_usb_func_ccinst *p_func_ccinst);
typedef uint8_t (*pfn_func_ccinst_bind)(struct tag_usb_func_ccinst *p_func_ccinst, ccinst_bind_call_data_st *p_bind_call_data);

typedef void (*pfn_func_ccinst_reset)(struct tag_usb_func_ccinst *p_func_ccinst, uint8_t speed);
typedef uint8_t (*pfn_func_ccinst_init)(struct tag_usb_func_ccinst *p_func_ccinst, uint8_t cfgidx);
typedef uint8_t (* pfn_func_ccinst_deinit)(struct tag_usb_func_ccinst *p_func_ccinst, uint8_t cfgidx);
typedef uint8_t (* pfn_func_ccinst_get_desc)(struct tag_usb_func_ccinst *p_func_ccinst, ccinst_desc_call_data_st* p_desc_call_data);
typedef uint8_t (*pfn_func_ccisnt_unbind)(struct tag_usb_func_ccinst *p_func_ccinst);




typedef struct tag_usb_func_ccinst
{
    void * p_cc_setting;
    pfn_func_ccinst_desc_ass func_desc_ass;
    pfn_func_ccinst_desc_parse func_desc_parse;
    pfn_func_ccinst_bind func_bind;
    pfn_func_ccinst_get_desc func_get_desc;
    pfn_func_ccinst_get_desc func_get_othspd_desc;    
    pfn_func_ccinst_init  func_init;
    pfn_func_ccinst_deinit  func_deinit;
    pfn_func_ccisnt_unbind func_unbind;
        
#if 0    
    pfn_func_setup func_setup;
    pfn_func_ep0_din_stage_comp func_ep0_din_stage_comp;
    pfn_func_ep0_dout_stage_comp func_ep0_dout_stage_comp;

    pfn_func_data_in_proc func_data_in_proc;
    pfn_func_data_out_proc func_data_out_proc;
    pfn_func_sof_proc func_sof_proc;
        
    pfn_func_desc_get_ptr func_desc_get_ptr;
    pfn_func_desc_get_size func_desc_get_size;    
    pfn_func_desc_get_othcfg_ptr func_desc_get_othcfg_ptr;
    pfn_func_desc_get_othcfg_size func_desc_get_othcfg_size;        
    pfn_func_desc_get_intf_num func_desc_get_intf_num;    
    pfn_func_desc_get_clstype func_desc_get_clstype; 
    pfn_func_desc_get_cfginfo func_desc_get_cfginfo;      
#endif    
}usb_func_ccinst_st;


#endif

