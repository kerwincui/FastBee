#ifndef __USBD_VCOM_EXTMSG_H__
#define __USBD_VCOM_EXTMSG_H__

typedef enum
{
    VCOM_EXT_NTF_REQ_NONE = 0,
    VCOM_EXT_NTF_REQ_STAT = 1,
}vcom_ext_ntf_req_type;


struct  tag_vcom_ntf_req_basedef {
    
    uint8_t   bmRequest;                      
    uint8_t   bRequest;                           
    uint16_t  wValue;                             
    uint16_t  wIndex;                             
    uint16_t  wLength;                            
} __attribute__ ((packed));

typedef struct tag_vcom_ntf_req_basedef vcom_ntf_req_basedef_st;

struct tag_vcom_ext_ntf_msg
{
    uint8_t ext_req_used;
    vcom_ntf_req_basedef_st base_req;
    uint16_t len;
    uint8_t *p_data;    
} __attribute__ ((packed));


typedef struct tag_vcom_ext_ntf_msg vcom_ext_ntf_msg_st;




#endif

