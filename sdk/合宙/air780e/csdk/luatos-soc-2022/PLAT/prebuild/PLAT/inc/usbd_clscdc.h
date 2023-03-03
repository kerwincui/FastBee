#ifndef __USBD_CDC_H__
#define __USBD_CDC_H__

#include "stdint.h"
#include "string.h"

#include "usbd_desc_def.h"


typedef struct
{
  uint32_t bitrate;
  uint8_t  format;
  uint8_t  paritytype;
  uint8_t  datatype;
}line_coding_st;


//cdc class descriptor
struct tag_usb_cdc_header_desc {
	uint8_t	bLength;
	uint8_t	bDescriptorType;
	uint8_t	bDescriptorSubType;
	uint8_t	bcdCDC_Low;
	uint8_t	bcdCDC_High;    
} __attribute__ ((packed));    

struct tag_usb_cdc_call_mgmt_descriptor {
	uint8_t	bLength;
	uint8_t	bDescriptorType;
	uint8_t	bDescriptorSubType;
	uint8_t	bmCapabilities;
	uint8_t	bDataInterface;
} __attribute__ ((packed));

struct tag_usb_cdc_acm_descriptor {
	uint8_t	bLength;
	uint8_t	bDescriptorType;
	uint8_t	bDescriptorSubType;
	uint8_t	bmCapabilities;
} __attribute__ ((packed));

struct tag_usb_cdc_union_desc {
	uint8_t	bLength;
	uint8_t	bDescriptorType;
	uint8_t	bDescriptorSubType;
	uint8_t	bMasterInterface0;
	uint8_t	bSlaveInterface0;
} __attribute__ ((packed));

struct tag_usb_cdc_ether_desc {
	uint8_t	bLength;
	uint8_t	bDescriptorType;
	uint8_t	bDescriptorSubType;
	uint8_t   iMacAddr;
	uint32_t	bmEthStat;  //statis tic
	uint16_t	wMaxSegSz;
	uint16_t	wNumMCFilters;
	uint8_t  bNumPwrFilters;
} __attribute__ ((packed));

struct tag_usb_cdc_notification {
	uint8_t	bmReqType;
	uint8_t	bNotifyType;
	uint16_t	wValue;
	uint16_t	wIndex;
	uint16_t	wLength;
} __attribute__ ((packed));


typedef struct tag_usb_cdc_header_desc usb_cdc_header_desc_st;
typedef struct tag_usb_cdc_call_mgmt_descriptor usb_cdc_call_mgmt_descriptor_st;
typedef struct tag_usb_cdc_acm_descriptor usb_cdc_acm_descriptor_st;
typedef struct tag_usb_cdc_union_desc  usb_cdc_union_desc_st;

typedef struct tag_usb_cdc_ether_desc usb_cdc_ether_desc_st;

typedef struct tag_usb_cdc_notification usb_cdc_notification_st;
struct tag_usbd_cdc_desc 
{
    usb_config_desc_st                 cfg_desc;
    
    usb_intf_assoc_desc_st           intf_asso_desc;
    
    usb_interface_descriptor_st     intf_ctrl_desc;
    usb_cdc_header_desc_st         cdc_head_desc;
    usb_cdc_call_mgmt_descriptor_st  cdc_callmgr_desc;
    usb_cdc_acm_descriptor_st     cdc_acm_desc;     
    usb_cdc_union_desc_st           cdc_union_desc;    
    usb_endpoint_descriptor_st     cdc_cmd_ep_desc;

    usb_interface_descriptor_st     intf_data_desc;
    usb_endpoint_descriptor_st     cdc_doep_desc;
    usb_endpoint_descriptor_st     cdc_diep_desc;
    
}__attribute__ ((packed));

typedef struct tag_usbd_cdc_desc usbd_cdc_desc_st;


struct tag_usbd_cdc_ccinst_desc_inhrnt 
{
    usb_intf_assoc_desc_st           intf_asso_desc;
    
    usb_interface_descriptor_st     intf_ctrl_desc;
    usb_cdc_header_desc_st         cdc_head_desc;
    usb_cdc_call_mgmt_descriptor_st  cdc_callmgr_desc;
    usb_cdc_acm_descriptor_st     cdc_acm_desc;     
    usb_cdc_union_desc_st           cdc_union_desc;    
    usb_endpoint_descriptor_st     cdc_cmd_ep_desc;

    usb_interface_descriptor_st     intf_data_desc;
    usb_endpoint_descriptor_st     cdc_doep_desc;
    usb_endpoint_descriptor_st     cdc_diep_desc;
    
}__attribute__ ((packed));



#endif

