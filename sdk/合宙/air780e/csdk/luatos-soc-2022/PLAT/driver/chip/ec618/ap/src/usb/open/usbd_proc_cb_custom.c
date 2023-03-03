#include <stdio.h>
#include "usbd_multi_clstype.h"


#define  USB_DEV_QUALIFIER_DESC_ARR_SIZE                     0x0A


#define DEF_LANGID_STR  0x409
#define DEF_MANUFACT_STR "AirM2M";
#define DEF_PRODUCT_HS_STR "AirM2M Compo";
#define DEF_SER_NUM_HS_STR     "000000000001"

#define DEF_CFG_HS_STR    "Compo Config"
#define DEF_INTF_HS_STR        "Compo Interface"


#define USB_DEVICE_DESCRIPTOR_TYPE              0x01
#define USB_STRING_DESCRIPTOR_TYPE              0x03
#define USB_SIZ_STRING_LANGID                   4
#define USB_SIZ_DEVICE_DESC                     0x12

#define LOBYTE(x)  ((uint8_t)(x & 0x00FF))
#define HIBYTE(x)  ((uint8_t)((x & 0xFF00) >>8))


#define  USB_DESC_TYPE_DEVICE                              1
#define  USB_DESC_TYPE_CONFIGURATION                       2
#define  USB_DESC_TYPE_STRING                              3
#define  USB_DESC_TYPE_INTERFACE                           4
#define  USB_DESC_TYPE_ENDPOINT                            5
#define  USB_DESC_TYPE_DEVICE_QUALIFIER                    6
#define  USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION           7


uint32_t udev_last_err  = 0;



uint8_t usbd_dev_desc_arr[USB_SIZ_DEVICE_DESC] =
{
    0x12,						/* bLength */
    USB_DEVICE_DESCRIPTOR_TYPE,	/* bDescriptorType */
    0x00,
    0x02,						/* bcdUSB = 2.00 */
    0xEF,	/* bDeviceClass: IAD */
    0x02,	/* bDeviceSubClass */
    0x01,	/* bDeviceProtocol */

    0x40,	/* bMaxPacketSize0 */
    
    0xd1,
    0x19,	/* idVendor = 0x19d1 */
    0x01,
    0x00,	/* idProduct = 0x0001 */

    0x00,
    0x02,	/* bcdDevice = 2.00 */
    1,		/* Index of string descriptor describing manufacturer */
    2,		/* Index of string descriptor describing product */
    3,		/* Index of string descriptor describing the device's serial number */
    0x01	/* bNumConfigurations */    
};


/* USB Standard Device Descriptor */
uint8_t usbd_dev_qualifier_desc_arr[USB_DEV_QUALIFIER_DESC_ARR_SIZE] =
{
    USB_DEV_QUALIFIER_DESC_ARR_SIZE,
    USB_DESC_TYPE_DEVICE_QUALIFIER,
    0x00,
    0x02,
    0xEF,
    0x02,
    0x01,
    0x40,
    0x01,
    0x00,
};

/* USB Standard Device Descriptor */
uint8_t usbd_dev_langid_desc[USB_SIZ_STRING_LANGID] =
{
     USB_SIZ_STRING_LANGID,         
     USB_DESC_TYPE_STRING,       
     LOBYTE(DEF_LANGID_STR),
     HIBYTE(DEF_LANGID_STR), 
};

uint8_t *usbcustom_product_str_desc(void)
{
    return (uint8_t *)DEF_PRODUCT_HS_STR;
}

uint8_t *usbcustom_manufacture_str_desc(void)
{
    return (uint8_t *)DEF_MANUFACT_STR;
}

uint8_t *usbcustom_ser_str_desc(void)
{
    return (uint8_t *)DEF_SER_NUM_HS_STR;
}

uint8_t *usbcustom_cfg_str_desc(void)
{
    return (uint8_t *)DEF_CFG_HS_STR;
}

uint8_t *usbcustom_intf_str_desc(void)
{
   return (uint8_t *)DEF_INTF_HS_STR;
}

uint8_t *usbcustom_qulifier_desc(void)
{
    return usbd_dev_qualifier_desc_arr;  
}

uint8_t usbcustom_cfg_remote_wkup_bit(void)
{
    return 1;
}

uint8_t usbcustom_cfg_self_powered_bit(void)
{
    return 0;
}

uint8_t usbcustom_cfg_max_power(void)
{
    return 100;
}

void udev_notify_init(void)
{
}

void udev_notify_device_reset (uint8_t speed)
{
}

void udev_notify_device_config (void)
{
}

void udev_notify_device_suspend(void)
{
}

void udev_notify_device_resume(void)
{
}

void udev_notify_device_connect (void)
{
}

void udev_notify_device_disconnect (void)
{
}

void udev_set_last_err(uint32_t err_no)
{
    udev_last_err = err_no;
}


uint32_t udev_get_last_err(void)
{
    return udev_last_err;
}



