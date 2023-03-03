#ifndef __USBD_MULTI_USRCFG_H__
#define __USBD_MULTI_USRCFG_H__

#include "usbd_multi_clstype.h"
#include "usbd_errinfo.h"


/*----------------------------------------------------------------------------*
 *                   USB CUSTOM MULTIDEV CFG MACRO DEFINE          * 
 *----------------------------------------------------------------------------*/

#define VCOM_CCINST_ORG_CASE 0
#define VCOM_CCINST_CUST_CASE 1

#define VCOM_CCINST_CASE_SEL VCOM_CCINST_ORG_CASE
//#define VCOM_CCINST_CASE_SEL VCOM_CCINST_CUST_CASE

#if (VCOM_CCINST_CASE_SEL==VCOM_CCINST_ORG_CASE)
#define VCOM_CCINST_SUBTP0_INHERENT_CNT 4
#define VCOM_CCINST_SUBTP1_2EP_CNT 0
#define VCOM_CCINST_SUBTP2_3EP_CNT 0
#endif

#if (VCOM_CCINST_CASE_SEL==VCOM_CCINST_CUST_CASE)
#define VCOM_CCINST_SUBTP0_INHERENT_CNT 0
#define VCOM_CCINST_SUBTP1_2EP_CNT 1
#define VCOM_CCINST_SUBTP2_3EP_CNT 2
#endif

#define VCOM_CCINST_TOTAL_CNT (VCOM_CCINST_SUBTP0_INHERENT_CNT+ \
                                                      VCOM_CCINST_SUBTP1_2EP_CNT + \
                                                   VCOM_CCINST_SUBTP2_3EP_CNT)

/*----------------------------------------------------------------------------*
 *                   USB CUSTOM MULTIDEV CFG DESCRIPTOR          * 
 *----------------------------------------------------------------------------*/
struct tag_usbcust_md_intf_assoc_desc {
	uint8_t  bFunctionClass;
	uint8_t  bFunctionSubClass;
	uint8_t  bFunctionProtocol;
} __attribute__ ((packed));


struct tag_usbcust_md_interface_descriptor
{
	uint8_t  bInterfaceClass;
	uint8_t  bInterfaceSubClass;
	uint8_t  bInterfaceProtocol;
}__attribute__ ((packed));


typedef struct tag_usbcust_md_intf_assoc_desc ucmd_intf_assoc_desc_st;
typedef struct tag_usbcust_md_interface_descriptor ucmd_interface_descriptor_st;






//md renamed to mdcd md call data

typedef struct {
    uint8_t cls_type;
    uint8_t inst_id;  
    uint8_t *p_func_name;
    uint8_t string_id;
    uint8_t valid;
    uint8_t * p_str;
}usbcust_mdcd_strdesc_st;

struct tag_usbcust_cmndesc_data{
    //uint8_t b_intf_asso_desc_upd: 1;
    uint8_t b_intf_ctrl_desc_upd: 1;
    //uint8_t b_intf_data_desc_upd: 1;
    uint8_t rsv: 7;
    
    //ucmd_intf_assoc_desc_st           intf_asso_desc;
    ucmd_interface_descriptor_st     intf_ctrl_desc;
    //ucmd_interface_descriptor_st     intf_data_desc;
}__attribute__ ((packed));

typedef struct tag_usbcust_cmndesc_data usbcust_cmndesc_data_st;


typedef struct {
    uint8_t cls_type;
    uint8_t inst_id;  
    uint8_t *p_func_name;
    usbcust_cmndesc_data_st t_cmndesc_data;    
}usbcust_mdcd_cmndesc_st;

typedef struct {
    uint8_t cls_type;
    uint8_t inst_id;  
    uint8_t *p_func_name;
    ccinst_setting_maintype setting_maintp;
    ccinst_setting_subtype setting_subtp;    
    usb_func_ccinst_st *p_func_ccinst;
}usbcust_mdcd_ccinfo_st;

typedef struct {
    uint32_t cmd;  //Bit 31 : 0 host to dev,  1 dev to host
    uint8_t* buf; 
    uint32_t len;
}usbcust_mdctl_req_st;


typedef struct {
    uint8_t cls_type;
    uint8_t inst_id;  
    uint8_t func_idx;  
    
    uint8_t *p_func_name;
    usbcust_mdctl_req_st t_ctl_req;
}usbcust_md_ctrl_st;

typedef struct {
    uint8_t cls_type;
    uint8_t inst_id;  
    uint8_t *p_func_name;
}usbcust_md_cb_paradef_st;




#define  USBD_DEV_NAME_LEN_MAX 10
#define  MULTI_DEV_RESOURCE_NUM 6


#define MULTI_DEV_CNT_MAX 6
#define MULTI_DEV_LOADCNT_MAX (MULTI_DEV_CNT_MAX-1)

#define MULTI_DEV_LOAD_NONE 0
#define MULTI_DEV_LOAD_RESET 1
#define MULTI_DEV_LOAD_UPDATED 2
#define MULTI_DEV_LOAD_END_SUC 3

#define MULTI_DEV_LOAD_BIND_SUC 4


//cust concrete type
#define MULTI_DEV_CUST_CC_TYPE_NONE 0

typedef struct {
    const uint8_t* p_dev_name;
    multidev_cls_type cls_type;   
    ccinst_setting_maintype setting_maintp;
    ccinst_setting_subtype setting_subtp;
}multidev_custom_element;

typedef struct {
    uint8_t elem_cnt;
    multidev_custom_element elem_arr[MULTI_DEV_CNT_MAX];
}multidev_custom_info_st;

typedef struct {
    uint8_t dev_enable;
    uint8_t map_res_index;    
    multidev_cls_type cls_type;
    ccinst_setting_maintype setting_maintp;
    ccinst_setting_subtype setting_subtp;
    
    const uint8_t* p_dev_name;
}multidev_load_element;

typedef struct {
    uint8_t load_stat;    
    uint8_t load_cnt;   
    uint8_t filter_cnt;
    multidev_load_element elem_arr[MULTI_DEV_CNT_MAX];
}multidev_load_info_st;

extern uint8_t usbcustom_multidev_cfg_reset(void);
extern multidev_custom_info_st*  usbcustom_multidev_cfg_update(void);
extern uint8_t usbcustom_multidev_cfg_end(multidev_load_info_st *p_multidev_load);


#define USBD_CUST_MAX_INEP_CNT 4
#define USBD_CUST_MAX_OUTEP_CNT 4

typedef struct {
    uint8_t epin_num;
    uint8_t epout_num;
    uint8_t epin_idx_arr[USBD_CUST_MAX_INEP_CNT];
    uint8_t epout_idx_arr[USBD_CUST_MAX_OUTEP_CNT];
    uint8_t epin_trans_attr[USBD_CUST_MAX_INEP_CNT];
    uint8_t epout_trans_attr[USBD_CUST_MAX_OUTEP_CNT];    
    uint16_t epin_maxpkt_sz[USBD_CUST_MAX_INEP_CNT];
    uint16_t epout_maxpkt_sz[USBD_CUST_MAX_OUTEP_CNT];    
}usbd_cust_ep_info_st;


#define USBD_CUST_MAX_INTFNUM 2
typedef struct
{
    uint8_t custCfgValid;
    uint8_t wTotalLength;
    uint8_t *pDesc;
    uint8_t  bNumInterfaces;
    usbd_cust_ep_info_st tEpInfo;
}usbd_cust_config_st;


typedef struct 
{
  uint8_t (*multidev_reset)(void);   
  multidev_custom_info_st* (*multidev_update)(void); 
  uint8_t (*multidev_end)(multidev_load_info_st *p_multidev_load);
  uint8_t (*multidev_ccinfo_map)(usbcust_mdcd_ccinfo_st *p_mdcd_ccinfo);
  uint8_t * (*multidev_strdesc)(usbcust_mdcd_strdesc_st *p_mdcd_strdesc);
  uint8_t (*multidev_cmndesc)(usbcust_mdcd_cmndesc_st *p_mdcd_cmndesc);
  uint8_t (*multidev_ctrl_proc)(usbcust_md_ctrl_st* p_usbcust_md_ctrl);
  
}usbcustom_multidev_cb_ops_st, *ptr_usbcustom_multidev_cb_ops_st;



/*----------------------------------------------------------------------------*
 *                    FUNCTIONS DECLEARATION FOR MULTIDEV DESCRIPTOR          * 
 *----------------------------------------------------------------------------*/
uint8_t usbcustom_multidev_ccinfo_map(usbcust_mdcd_ccinfo_st *p_mdcd_ccinfo);


uint8_t *usbcustom_multidev_strdesc(usbcust_mdcd_strdesc_st *p_mdcd_strdesc);
uint8_t usbcustom_multidev_cmndesc(usbcust_mdcd_cmndesc_st *p_mdcd_cmndesc);
uint8_t usbcustom_multidev_ctrl_proc(usbcust_md_ctrl_st* p_usbcust_md_ctrl);


uint8_t *usbd_multi_lib_strdesc_cb(usbcust_mdcd_strdesc_st *p_mdcd_strdesc);
uint8_t usbd_multi_lib_cmndesc_cb(usbcust_mdcd_cmndesc_st *p_mdcd_cmndesc);

//#define usbd_multi_libcall_intfstr_desc usbd_multi_lib_intfstr_desc_cb
//uint8_t *usbd_multi_libcall_intfstr_desc(usbcust_mdcd_desc_st *p_usbcust_md_desc);

//extern uint8_t usbd_multi_lib_set_cmndesc_para(usb_func_st *p_usb_func, 
//                                                                usbcust_mdcd_cmndesc_st*  p_mdcd_cmndesc);

extern uint8_t usbd_multi_libcall_cmndesc(usbcust_mdcd_cmndesc_st *p_mdcd_cmndesc);

extern uint8_t* usbd_multi_libcall_strdesc(usbcust_mdcd_strdesc_st *p_mdcd_strdesc);



#endif

