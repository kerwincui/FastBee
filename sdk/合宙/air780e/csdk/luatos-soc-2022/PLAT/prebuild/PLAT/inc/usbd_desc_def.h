#ifndef __USBD_DESC_DEF_H__
#define __USBD_DESC_DEF_H__

 struct tag_usb_config_desc
{
    uint8_t bLength; //config desc size
    uint8_t bDescriptorType;
    uint8_t wTotalLength_Low; // wTotalLength 
    uint8_t wTotalLength_High; // wTotalLength 
    uint8_t  bNumInterfaces;
    uint8_t  bConfigurationValue;
    uint8_t  iConfiguration;
    uint8_t  bmAttributes;
    uint8_t  bMaxPower;    
}__attribute__ ((packed));

struct tag_usb_intf_assoc_desc {
	uint8_t  bLength;
	uint8_t  bDescriptorType;

	uint8_t  bFirstInterface;
	uint8_t  bInterfaceCount;
	uint8_t  bFunctionClass;
	uint8_t  bFunctionSubClass;
	uint8_t  bFunctionProtocol;
	uint8_t  iFunction;
} __attribute__ ((packed));

struct tag_usb_interface_descriptor {
	uint8_t  bLength;
	uint8_t  bDescriptorType;

	uint8_t  bInterfaceNumber;
	uint8_t  bAlternateSetting;
	uint8_t  bNumEndpoints;
	uint8_t  bInterfaceClass;
	uint8_t  bInterfaceSubClass;
	uint8_t  bInterfaceProtocol;
	uint8_t  iInterface;
}  __attribute__ ((packed));

struct tag_usb_endpoint_descriptor {
	uint8_t  bLength;
	uint8_t  bDescriptorType;

	uint8_t  bEndpointAddress;
	uint8_t  bmAttributes;
	uint8_t  wMaxPacketSize_Low;
	uint8_t  wMaxPacketSize_High;    
	uint8_t  bInterval;
} __attribute__ ((packed));

typedef struct tag_usb_config_desc usb_config_desc_st;
typedef struct tag_usb_intf_assoc_desc usb_intf_assoc_desc_st;
typedef struct tag_usb_interface_descriptor usb_interface_descriptor_st;
typedef struct tag_usb_endpoint_descriptor usb_endpoint_descriptor_st;

#endif
