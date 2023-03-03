#ifndef __USBD_CDC_CUSTQUEC_H__
#define __USBD_CDC_CUSTQUEC_H__

//#include "usbd_conf.h"
#include "usbd_desc_def.h"
//#include "usbd_function.h"
//#include "usbd_clsdev.h"


#define USBD_CDC_QUEC_TP1 1
#define USBD_CDC_QUEC_TP2 2


#define CDC_QUEC_ASSO_SUPP 0

struct tag_usbd_cdc_desc_custp1
{
    usb_interface_descriptor_st     intf_ctrl_desc;
    usb_endpoint_descriptor_st     cdc_doep_desc;
    usb_endpoint_descriptor_st     cdc_diep_desc;
    
}__attribute__ ((packed));


struct tag_usbd_cdc_desc_custp2
{
    usb_interface_descriptor_st     intf_ctrl_desc;
    usb_cdc_header_desc_st         cdc_head_desc;
    usb_cdc_call_mgmt_descriptor_st  cdc_callmgr_desc;
    usb_cdc_acm_descriptor_st     cdc_acm_desc;     
    usb_cdc_union_desc_st           cdc_union_desc;    
    usb_endpoint_descriptor_st     cdc_cmd_ep_desc;
    usb_endpoint_descriptor_st     cdc_diep_desc;
    usb_endpoint_descriptor_st     cdc_doep_desc;    
}__attribute__ ((packed));

#ifndef EPIN_MARK_DIR
#define EPIN_MARK_DIR(FUNC_EP) ((FUNC_EP)|0x80)
#endif

typedef struct tag_usbd_cdc_desc_custp1 usbd_cdc_desc_custp1_st;
typedef struct tag_usbd_cdc_desc_custp2 usbd_cdc_desc_custp2_st;

#endif

