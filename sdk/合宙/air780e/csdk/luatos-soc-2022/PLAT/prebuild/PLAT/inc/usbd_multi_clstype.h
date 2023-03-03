#ifndef __USBD_MULTI_CLSTYPE_H__
#define __USBD_MULTI_CLSTYPE_H__

typedef enum
{
    multidev_tp_none = 0,
    multidev_tp_rndis = 1,
    multidev_tp_ecm,
    multidev_tp_vcom_at,
    multidev_tp_vcom_log,    
    multidev_tp_vcom_ppp,        
    multidev_tp_vcom_com,            
}multidev_cls_type;


#endif

