#ifndef __USBD_MULTI_EXTMSG_H__
#define __USBD_MULTI_EXTMSG_H__

typedef enum
{
    MULTIDEV_EXT_MSG_NONE = 0,
    MULTIDEV_EXT_NTF_REQ = 1,
}multidev_extmsg_type;

struct tag_multidev_ext_msg
{
    uint8_t multidev_load_idx;
    uint8_t dev_cls_type;

    uint16_t msgtype;
    uint16_t msg_len;
    uint8_t *p_msg;
    uint8_t mid_para_valid;  //  for internal usage
    void  * p_mid_para;       //  for internal usage
} __attribute__ ((packed));

typedef struct tag_multidev_ext_msg multidev_ext_msg_st;


int usbd_multi_lib_dev_extmsg(multidev_ext_msg_st *p_ext_msg);


#endif

