#include "ec618.h"
#include "string.h"
#include "cmsis_os2.h"
#include "hal_misc.h"
#include <stdlib.h>
#include <stdio.h>
#include "bl_bsp.h"
#include "usb_bl_api.h"

int vcomx_isconnect(uint8_t vcom_num);
int vcomx_get_in_waiting(uint8_t vcom_num);
int vcomx_poll_rx(uint8_t vcom_num, uint32_t timeout);
 int vcomx_recv(uint8_t vcom_num, uint8_t* buf, uint16_t len);
 int vcomx_get_out_avail(uint8_t vcom_num);
int vcomx_poll_tx(uint8_t vcom_num, uint32_t timeout);
int vcomx_send(uint8_t vcom_num, uint8_t* buf, uint16_t len);

typedef enum
{
     vcom_step_idle = 0,
     vcom_step_recv ,        
     vcom_step_send ,             
     vcom_step_busy_sending ,             
     
}vcom_app_step_type;

#define VCOM_STATE_IDLE 0
#define VCOM_TEST_BUF_SIZE 0x400
typedef struct 
{
    //uint8_t recv_en;
    //uint8_t send_en;
    vcom_app_step_type step;
    uint32_t received_len;
    uint32_t sended_len;
    uint8_t vcom_rcvbuff[VCOM_TEST_BUF_SIZE];
    uint8_t vcom_sndbuff[VCOM_TEST_BUF_SIZE];
}vcom_app_ctx_st;

#define VCOM_NUM_MAX 3
vcom_app_ctx_st vcom_app_ctx[VCOM_NUM_MAX];

void vcom_app_ctx_init(void)
{
    memset(&vcom_app_ctx, 0, sizeof(vcom_app_ctx));
}

int vcom_app_ctx_is_idlestep(uint8_t vcom_num)
{
    if (vcom_num>=VCOM_NUM_MAX)
    {
        VCDBG_STR_AND_HEX("vcom_num(%d) error \r\n", vcom_num);
        return -1;
    }        
    if(vcom_app_ctx[vcom_num].step == vcom_step_idle)
    {
        return 1;
    }
    return 0;
}

uint8_t vcom_app_ctx_is_recvstep(uint8_t vcom_num)
{    
    if (vcom_num>=VCOM_NUM_MAX)
    {
        VCDBG_STR_AND_HEX("vcom_num(%d) error \r\n", vcom_num);
        return 0;
    }        
    if(vcom_app_ctx[vcom_num].step == vcom_step_recv)
    {
        return 1;
    }
    return 0;
}

uint8_t vcom_app_ctx_is_sendstep(uint8_t vcom_num)
{    
    if (vcom_num>=VCOM_NUM_MAX)
    {
        VCDBG_STR_AND_HEX("vcom_num(%d) error \r\n", vcom_num);
        return 0;
    }        
    if(vcom_app_ctx[vcom_num].step == vcom_step_send)
    {
        return 1;
    }
    return 0;
}

uint8_t vcom_app_ctx_is_busysending(uint8_t vcom_num)
{    
    if (vcom_num>=VCOM_NUM_MAX)
    {
        VCDBG_STR_AND_HEX("vcom_num(%d) error \r\n", vcom_num);
        return 0;
    }        
    if(vcom_app_ctx[vcom_num].step == vcom_step_busy_sending)
    {
        return 1;
    }
    return 0;
}

void vcom_app_ctx_set_step(uint8_t vcom_num, vcom_app_step_type step)
{
    
    if (vcom_num>=VCOM_NUM_MAX)
    {
        VCDBG_STR_AND_HEX("vcom_num(%d) error \r\n", vcom_num);
        return;
    }    
    vcom_app_ctx[vcom_num].step = step;

    return ;
}

int vcom_app_get_rcvbuff_size(uint8_t vcom_num)
{
    if (vcom_num>=VCOM_NUM_MAX)
    {
        VCDBG_STR_AND_HEX("vcom_num(%d) error \r\n", vcom_num);
        return -1;
    }    
    return sizeof(vcom_app_ctx[vcom_num].vcom_rcvbuff);
}

uint8_t* vcom_app_get_rcvbuff_ptr(uint8_t vcom_num)
{
    if (vcom_num>=VCOM_NUM_MAX)
    {
        VCDBG_STR_AND_HEX("vcom_num(%d) error \r\n", vcom_num);
        return NULL;
    }    
    return &(vcom_app_ctx[vcom_num].vcom_rcvbuff[0]);
}

int vcom_app_get_sndbuff_size(uint8_t vcom_num)
{
    if (vcom_num>=VCOM_NUM_MAX)
    {
        VCDBG_STR_AND_HEX("vcom_num(%d) error \r\n", vcom_num);
        return -1;
    }    
    return sizeof(vcom_app_ctx[vcom_num].vcom_sndbuff);
}

uint8_t* vcom_app_get_sndbuff_ptr(uint8_t vcom_num)
{
    if (vcom_num>=VCOM_NUM_MAX)
    {
        VCDBG_STR_AND_HEX("vcom_num(%d) error \r\n", vcom_num);
        return NULL;
    }    
    return &(vcom_app_ctx[vcom_num].vcom_sndbuff[0]);
}

int vcom_app_update_recved_size(uint8_t vcom_num, uint32_t size)
{
    if (vcom_num>=VCOM_NUM_MAX)
    {
        VCDBG_STR_AND_HEX("vcom_num(%d) error \r\n", vcom_num);
        return -1;
    }    
    vcom_app_ctx[vcom_num].received_len = size;
    return 0;
}

int vcom_app_update_sended_size(uint8_t vcom_num, uint32_t size)
{    
    if (vcom_num>=VCOM_NUM_MAX)
    {
        VCDBG_STR_AND_HEX("vcom_num(%d) error \r\n", vcom_num);
        return -1;
    }    
    vcom_app_ctx[vcom_num].sended_len = size;
    return 0;
}

int vcom_app_get_recved_size(uint8_t vcom_num)
{
    if (vcom_num>=VCOM_NUM_MAX)
    {
        VCDBG_STR_AND_HEX("vcom_num(%d) error \r\n", vcom_num);
        return -1;
    }    
    return vcom_app_ctx[vcom_num].received_len;
}

int vcom_app_get_sended_size(uint8_t vcom_num)
{
    if (vcom_num>=VCOM_NUM_MAX)
    {
        VCDBG_STR_AND_HEX("vcom_num(%d) error \r\n", vcom_num);
        return -1;
    }    
    return vcom_app_ctx[vcom_num].sended_len;
}

int vcom_app_send_proc(uint8_t vcom_num, uint8_t* sndbuf_ptr, uint32_t size, uint8_t timeout);
int vcom_app_recv_proc(uint8_t vcom_num, uint8_t* rcvbuf_ptr, uint32_t size, uint8_t timeout);
void vcom_app_delay(uint32_t ticks);

void vcom_loopback_test(void *p)
{
    int ret;
    int txavail_cnt;
//#if DEVICE_VCOM_INSTANCE    
    uint32_t sended_size;
    uint8_t * send_buf_ptr;
    uint8_t * recv_buf_ptr;

    vcom_app_ctx_init();
    int vcom_num = 0;
    VCDBG_STR("uart_loopback_test start \r\n");
    
    while(1)
    {
        vcom_app_delay(10);
        vcom_num = vcom_num+1;
        vcom_num = vcom_num%VCOM_NUM_MAX;

        while(1)
        {
            if (vcomx_isconnect(vcom_num) ==0)
            {
                vcom_app_delay(1000);
                break;
            }

            if (vcom_app_ctx_is_idlestep(vcom_num)==1)
            {

                if (vcomx_isconnect(vcom_num) ==0)
                {
                    vcom_app_delay(20);
                    break;
                }

                vcom_app_ctx_set_step(vcom_num, vcom_step_recv);
                VCDBG_STR_AND_HEX("vcom(%d) [recv]   \r\n", vcom_num);
            }
                
            if (vcom_app_ctx_is_recvstep(vcom_num)==1)
            {
                ret= vcom_app_recv_proc(vcom_num, 
                                                    vcom_app_get_rcvbuff_ptr(vcom_num), 
                                                    vcom_app_get_rcvbuff_size(vcom_num), 1);
                if (ret <=0)
                {
                    vcom_app_delay(1);
                    break;
                }
                vcom_app_update_recved_size(vcom_num, ret);
                vcom_app_update_sended_size(vcom_num, 0);      
                vcom_app_ctx_set_step(vcom_num, vcom_step_send);

                VCDBG_STR_AND_HEX("vcom(%d) [recv] ->[send]  \r\n", vcom_num);
                VCDBG_STR_AND_HEX("ret %d \r\n",ret);
                
                break;
            }

            if (vcom_app_ctx_is_sendstep(vcom_num)==1)
            {
                if (vcom_app_get_recved_size(vcom_num) <0)
                {
                    VCDBG_STR_AND_HEX("vcom(%d) [send] recved_size <0, ->[idle]  \r\n", vcom_num);
                    vcom_app_ctx_set_step(vcom_num, vcom_step_idle);
                    vcom_app_update_recved_size(vcom_num, 0);  
                    break;
                }
                
                sended_size = vcom_app_get_sended_size(vcom_num);
                recv_buf_ptr= vcom_app_get_rcvbuff_ptr(vcom_num);
                send_buf_ptr = vcom_app_get_rcvbuff_ptr(vcom_num);
                if (sended_size >=vcom_app_get_recved_size(vcom_num))
                {
                    VCDBG_STR_AND_HEX("vcom(%d) [send] unneeded->[idle]", vcom_num);
                    VCDBG_STR_AND_HEX("recved %d\r\n",
                                        vcom_app_get_recved_size(vcom_num));
                    VCDBG_STR_AND_HEX("sended %d\r\n",
                                        vcom_app_get_sended_size(vcom_num));     
                    break;
                }

                txavail_cnt = vcom_app_get_sndbuff_size(vcom_num);
                if ((txavail_cnt+sended_size) > vcom_app_get_recved_size(vcom_num))
                {
                    txavail_cnt = vcom_app_get_recved_size(vcom_num) - sended_size;
                }                
                memcpy(send_buf_ptr+sended_size, recv_buf_ptr+sended_size, txavail_cnt);
                
                ret = vcom_app_send_proc(vcom_num, send_buf_ptr+sended_size, txavail_cnt, 1);                
                if (ret <0)
                {
                    VCDBG_STR_AND_HEX("vcom(%d) [send] , ->[idle]  \r\n", vcom_num);
                    VCDBG_STR_AND_HEX("fail %08x %d\r\n",ret);                    
                    vcom_app_ctx_set_step(vcom_num, vcom_step_idle);
                    vcom_app_update_recved_size(vcom_num, 0);
                    break;
                }   

                sended_size+=ret;

                
                vcom_app_update_sended_size(vcom_num, ret);      

                if (sended_size >=vcom_app_get_recved_size(vcom_num))
                {
                    VCDBG_STR_AND_HEX("vcom(%d) [send] ->[idle] finish  \r\n", vcom_num);
                    VCDBG_STR_AND_HEX("recved %d  \r\n", vcom_app_get_recved_size(vcom_num));
                    VCDBG_STR_AND_HEX("sended %d  \r\n", vcom_app_get_sended_size(vcom_num));
                    
                    vcom_app_ctx_set_step(vcom_num, vcom_step_idle);
                    vcom_app_update_recved_size(vcom_num, 0);           
                    break;
                }
                
                vcom_app_ctx_set_step(vcom_num, vcom_step_busy_sending);
                break;
      

            }

            if (vcom_app_ctx_is_busysending(vcom_num)==1)
            {
                vcom_app_delay(1);
                vcom_app_ctx_set_step(vcom_num, vcom_step_send);
                break;

            }
        }
    }
    
    VCDBG_STR("uart_loopback_test end \r\n");
}

void vcom_urcprint_test(void)
{
    uint8_t vcom_num = 0;
    int cnt = 0;
    while(cnt++<2000)
    {
        vcom_app_delay(10);
        vcom_num = vcom_num+1;
        vcom_num = vcom_num%VCOM_NUM_MAX;
        
        SelNormalOrURCPrint(1);
        BSP_URCSetCfg(1, 115200, URCVCom0PrintType+vcom_num, vcom_num);
        printf("URC PRINT %d\r\n", vcom_num);
        
        SelNormalOrURCPrint(0);
        printf("NO URC PRINT\r\n");
        
    }
}
uint32_t BSP_UsbInit(void);
void WDT_stop(void);
void vcom_app_delay(uint32_t ticks);

void vcom_urc_test_entry(void)
{
    WDT_stop();// stop watchdog for test
    extern uint8_t usbstack_clear_ctx_stat(void);
    extern void usbstack_set_ctx_vbus_mode(uint8_t vbus_mode_en, uint8_t vbus_pad_idx);

    usbstack_clear_ctx_stat();
    usbstack_set_ctx_vbus_mode(0,0xf);
    BSP_UsbInit();

    extern void vcom_urcprint_test(void);    
    vcom_urcprint_test();

    void vcom_loopback_test(void *p);    
    vcom_loopback_test(NULL);
    while(1);
}

