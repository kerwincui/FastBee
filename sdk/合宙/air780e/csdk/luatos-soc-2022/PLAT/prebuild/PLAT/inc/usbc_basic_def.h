#ifndef __USBC_BASIC_DEF_H__
#define __USBC_BASIC_DEF_H__

#include "sctdef.h"

#define USBC_CTRL_CORE_BASE_ADDR                 0x1A000000
#define USBC_MAX_EP_UNUM    (1+12)
#define USBC_GRXSTSP_ADDR   (USBC_CTRL_CORE_BASE_ADDR+0x20)

//ALIGN TO USBC_CTRL_DATA_FIFO_OFFSET
#define USBC_FIFO_BASE_ADDR (USBC_CTRL_CORE_BASE_ADDR+0x1000)


#define MAX_EP_IN_NUM  USBC_MAX_EP_UNUM
#define MAX_EP_OUT_NUM USBC_MAX_EP_UNUM

typedef  struct  usb_setup_req {
    
    uint8_t   bmRequest;                      
    uint8_t   bRequest;                           
    uint16_t  wValue;                             
    uint16_t  wIndex;                             
    uint16_t  wLength;                            
} usb_setup_req_st;


typedef enum {
   EPOUT_TYPE = 0,
   EPIN_TYPE =1,
   EP_MAX_TYPE = 2
}USBC_EP_TYPE;

typedef struct 
{
    uint16_t func_idx  :4;      /* usb func idx */
    uint16_t cls_type      :4;   /* cls type */
    uint16_t bulk_epin_valid :1;
    uint16_t bulk_epout_valid :1;
    uint16_t int_epin_valid :1;
    uint16_t resv_0 :1;
    uint16_t bulk_epin_idx        :4;     
    uint16_t bulk_epout_idx       :4;    
    uint16_t int_epin_idx       :4;   
    uint16_t resv_1          :8;  
}usbd_locmap_elem_st;
typedef struct 
{
    uint8_t func_elem_arr_cnt;
    uint8_t epout_func_idx_arr_cnt;
    usbd_locmap_elem_st *p_func_elem_arr;
    uint8_t * p_epout_func_idx_arr;
}usbd_locmap_para_st;
#endif

