#include "FreeRTOS.h"
#include "cmsis_os2.h"
#include "usb_portmon.h"
#include "apmu_external.h"
#include "plat_config.h"
#include "string.h"
#include "bsp_custom.h"
#include "slpman.h"
#include "usb_ext_inc.h"

#include DEBUG_LOG_HEADER_FILE
typedef int (*pfn_PadWakeupHook)(uint32_t pad_num);


osEventFlagsId_t vBusEvtFlags = NULL;
#define USB_VBUS_EVT_FLAG 1
//5 for module AirM2M E3 BOARD vbus pad
//#define USB_WKUP_PAD_IDX 5
//for module AirM2M E1 BOARD vbus pad
uint8_t  usb_wkup_pad_idx = 1;
#define VBUS_FILTER_MAX_SAMPLE_CNT 10

extern uint8_t usbstack_clear_ctx_stat(void);
extern uint8_t usbstack_ctx_stat_ison(void);
extern uint8_t usbstack_ctx_stat_isoff(void);
extern uint8_t usbstack_get_ctx_stat(void);
extern void usbstack_set_ctx_vbus_mode(uint8_t vbus_mode_en, uint8_t vbus_pad_idx);
extern void usbstack_top_var_clear(void);

extern int RegPadWakeupIntrHook(pfn_PadWakeupHook pfunc);




extern void BSP_UsbDeInit(void);
extern void BSP_UsbInit(void);
int usb_portmon_intr_cb(void);
int Pad1WakeupHook(void);
int PadCmnWakeupHook(uint32_t pad_num);

void usb_portmon_padcfg(void)
{
    APmuWakeupPadSettings_t wakeupPadSetting;
    wakeupPadSetting.negEdgeEn = true;
    wakeupPadSetting.posEdgeEn = true;
    wakeupPadSetting.pullDownEn = false;
    wakeupPadSetting.pullUpEn = false;
    apmuSetWakeupPadCfg(usb_wkup_pad_idx, true, &wakeupPadSetting);
}

uint8_t usb_portmon_wkuppad_level(uint32_t idx);

uint8_t usb_portmon_vbuspad_level(void)
{
    return usb_portmon_wkuppad_level(usb_wkup_pad_idx);
}


#define USB_PORTMON_WAIT_INIT_START 10
#define USB_PORTMON_WAIT_FILTER 10
#define USB_PORTMON_WAIT_ALWAYS 0xffffffff

typedef enum {
    usb_portmon_state_none= 0,
    usb_portmon_state_filter_reset = 1,
    usb_portmon_state_filter_sample = 2,
    usb_portmon_state_trigger = 3,
    usb_portmon_state_stable = 4,
}usb_portmon_state_type;

uint32_t usb_portmon_stat = usb_portmon_state_none;

usb_portmon_state_type usb_portmon_getstat(void)
{
    return usb_portmon_stat;
}

void usb_portmon_setstat(usb_portmon_state_type stat)
{
    usb_portmon_stat = stat;
}

uint8_t vbus_val_last = 0;

int usb_portmon_init(void)
{
    uint32_t ret;
    usbstack_clear_ctx_stat();
    vBusEvtFlags = osEventFlagsNew(NULL);
    if (vBusEvtFlags== NULL)
    {
        EC_ASSERT((0), 0, 0, 0);
    }    

    usb_wkup_pad_idx = BSP_UsbGetVBUSWkupPad();
    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_init_1, P_WARNING, 1,"usb_wkup_pad_idx %d", usb_wkup_pad_idx);
    
    if (usb_wkup_pad_idx>WAKEUP_PAD_5)
    {
        EC_ASSERT(0, usb_wkup_pad_idx, WAKEUP_PAD_5, 0);
    }
    
    usbstack_top_var_clear();
    usbstack_set_ctx_vbus_mode(1,usb_wkup_pad_idx);

    NVIC_DisableIRQ(PadWakeup0_IRQn+usb_wkup_pad_idx);    
    NVIC_ClearPendingIRQ(PadWakeup0_IRQn+usb_wkup_pad_idx);    
    
    ret = RegPadWakeupIntrHook(PadCmnWakeupHook);
    EC_ASSERT((ret==0), 0, 0, 0);

    
    usb_portmon_stat = usb_portmon_state_filter_reset;
    usb_portmon_padcfg();    
    NVIC_EnableIRQ(PadWakeup0_IRQn+usb_wkup_pad_idx);
    return 0;
}

int usb_portmon_deinit(void){
    NVIC_DisableIRQ(PadWakeup0_IRQn+usb_wkup_pad_idx);
    if (vBusEvtFlags !=NULL){
        osEventFlagsDelete(vBusEvtFlags);
        vBusEvtFlags = NULL;
    }
    usb_portmon_stat = usb_portmon_state_none;
    return 0;
}


uint8_t usbpm_vote_handle = 0xff;

void usb_portmon_task(void *arg)
{
    uint32_t vbus_evtflag;
    uint32_t vbus_filter_sample_cnt = 0;
    uint8_t vbus_val_cur = 0;
    slpManApplyPlatVoteHandle("usbpm", &usbpm_vote_handle);
    slpManPlatVoteDisableSleep(usbpm_vote_handle, SLP_SLP2_STATE);
    
    usb_portmon_init();
    
    uint32_t usb_portmon_wait = USB_PORTMON_WAIT_ALWAYS;
    while(1)
    {
        switch (usb_portmon_getstat())
        {
        case usb_portmon_state_none:
             usb_portmon_setstat(usb_portmon_state_filter_reset);
             break;
        case  usb_portmon_state_filter_reset:
            
            usb_portmon_wait = USB_PORTMON_WAIT_INIT_START;
            vbus_evtflag = 0;
            vbus_evtflag = osEventFlagsWait (vBusEvtFlags, USB_VBUS_EVT_FLAG, osFlagsWaitAny, usb_portmon_wait);
            vbus_val_last = usb_portmon_vbuspad_level();

            //reset vbus fileter sample cnt
            vbus_filter_sample_cnt = 0;
            if (vbus_evtflag&USB_VBUS_EVT_FLAG)            
            {
                //filtered type 3, likely
                //detect evt in stable state, delay USB_PORTMON_WAIT_FILTER in filter state, detect evt again continuously in USB_PORTMON_WAIT_FILTER
                ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_1_1, P_WARNING, 2,"filter reset detect evt %x, vbus %d", vbus_evtflag, usb_portmon_vbuspad_level() );
            }
            else if (vbus_evtflag == osErrorTimeout)
            {
                ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_1_2, P_WARNING, 2,"filter reset (to) evt %x, vbus %d", vbus_evtflag, usb_portmon_vbuspad_level() );
            }
            usb_portmon_setstat(usb_portmon_state_filter_sample);
            break;
        case  usb_portmon_state_filter_sample:
            usb_portmon_wait = USB_PORTMON_WAIT_FILTER;
            vbus_evtflag = 0;
            vbus_evtflag = osEventFlagsWait (vBusEvtFlags, USB_VBUS_EVT_FLAG, osFlagsWaitAny, usb_portmon_wait);
            if (vbus_evtflag&USB_VBUS_EVT_FLAG)
            {
                //filtered type 3, likely
                //detect evt in stable state, delay USB_PORTMON_WAIT_FILTER in filter state, detect evt again continuously in USB_PORTMON_WAIT_FILTER
                ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_2_1, P_WARNING, 2,"port filtered unstable evt %x, vbus %d", vbus_evtflag, usb_portmon_vbuspad_level() );
                usb_portmon_setstat(usb_portmon_state_filter_reset);
                break;
            }
            
            if (vbus_evtflag == osErrorTimeout)
            {
                vbus_val_cur = usb_portmon_vbuspad_level();

                if (vbus_val_last!=vbus_val_cur)
                {
                    //unlikely
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_2_2, P_WARNING, 2,"port vbus filter unstable level vbus last %d,vbus cur = %d", vbus_val_last, vbus_val_cur);
                    usb_portmon_setstat(usb_portmon_state_filter_reset);
                    
                    vbus_val_last = vbus_val_cur;
                    break;
                }

                //anyway update vbus_val_last
                vbus_val_last = vbus_val_cur;

                //vbus_val_last==vbus_val_cur case
                //add vbus fileter sample cnt
                vbus_filter_sample_cnt++;
                if(vbus_filter_sample_cnt<VBUS_FILTER_MAX_SAMPLE_CNT)
                {
                    //wait for more sample cnt
                    break;
                }
            
                if ((usbstack_ctx_stat_isoff()==1) && (vbus_val_cur ==0))
                {
                    //filtered type 1, unlikely
                    //detect evt in stable state, delay USB_PORTMON_WAIT_FILTER in filter state, but no pad val change
                    //no trigger for vbus 0 and usb ctx stat is not on 
                    usb_portmon_setstat(usb_portmon_state_stable);
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_2_3, P_WARNING, 1,"port filtered type2(to) invalid vbus, evt %x, vbus 0 ", vbus_evtflag);
                }
                else if ((usbstack_ctx_stat_ison()==1) && (vbus_val_cur ==1))
                {
                    //filtered type 2, unlikely
                    //detect evt in stable state, delay USB_PORTMON_WAIT_FILTER in filter state, but no pad val change                        
                    //no trigger for vbus 1 and usb ctx stat is on 
                    usb_portmon_setstat(usb_portmon_state_stable);
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_2_4, P_WARNING, 1,"port filtered type3(to) invalid vbus, evt %x ,vbus 1", vbus_evtflag);
                }
                else 
                {
                
                    if ((usbstack_ctx_stat_isoff()==0) &&(usbstack_ctx_stat_ison()==0))
                    {
                        //anyway pass to trigger state, then cause assert
                        ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_2_5, P_WARNING, 2,"port vbus trigger warning, ctx stat not valid %x, vbus %d", usbstack_get_ctx_stat(), vbus_val_cur);
                    }
                    
                    //most likely
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_2_6, P_INFO, 2,"port vbus trigger, evt %x ,vbus %d", vbus_evtflag, vbus_val_cur);
                    usb_portmon_setstat(usb_portmon_state_trigger);
                }
            }
            break;

        case usb_portmon_state_trigger:   
            //check the vbus if it is plug out 
            
            if (vbus_val_cur==0)
            {
                ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_3_1, P_WARNING, 0,"BSP_UsbDeInit");                
                BSP_UsbDeInit();
                if(usbstack_ctx_stat_isoff()==0)
                {
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_3_2, P_ERROR, 0,"BSP_UsbDeInit, ctx stat not match");                
                }
            }
            else
            {
                //check the vbus if it is plug in 
                ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_3_3, P_WARNING, 0,"BSP_UsbInit");                
                
                usblpw_clear_lpusbwkup_src();
                if (usblpw_retothwk_cur_stg_success()==0)
                {
                    //all other not succ stag anyway set to terminate
                    usblpw_retothwk_set_terminate_stage();        
                }                    

                BSP_UsbInit();
                if(usbstack_ctx_stat_ison()==0)
                {
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_3_4, P_ERROR, 0,"BSP_UsbInit, ctx stat not match");                
                }                    
            }                
            vbus_val_last = usb_portmon_vbuspad_level();
            ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_3_5, P_WARNING, 2,"port vbus last %d,vbus cur = %d", vbus_val_last, vbus_val_cur);
            
            usb_portmon_setstat(usb_portmon_state_stable);
            break;

        case usb_portmon_state_stable:
            //vote enable sleep when stable state
            slpManPlatVoteEnableSleep(usbpm_vote_handle, SLP_SLP2_STATE);
            usb_portmon_wait = USB_PORTMON_WAIT_ALWAYS;
            ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_4_1, P_WARNING, 0,"port stable wait evt change");
            vbus_evtflag = 0;
            vbus_evtflag = osEventFlagsWait (vBusEvtFlags, USB_VBUS_EVT_FLAG, osFlagsWaitAny|osFlagsNoClear, usb_portmon_wait);
            ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_task_4_2, P_WARNING, 1,"port stable detect evt  %x", vbus_evtflag);
            if (vbus_evtflag&USB_VBUS_EVT_FLAG)
            {
                usb_portmon_setstat(usb_portmon_state_filter_reset);
            }

            //vote disable sleep when unstable state
            slpManPlatVoteDisableSleep(usbpm_vote_handle, SLP_SLP2_STATE);
            break;                    
        }
        
    }    
}

int usb_portmon_intr_cb(void)
{
    uint32_t wkup_val = usb_portmon_vbuspad_level();
    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_portmon_intr_cb_1, P_INFO, 1,"wkup_val:0x%x", wkup_val);
    if (usb_portmon_getstat()>usb_portmon_state_none)
    {
        if (vBusEvtFlags)
        {
            osEventFlagsSet (vBusEvtFlags, USB_VBUS_EVT_FLAG);
        }
    }    
    return 0;
}

int Pad1WakeupHook(void)
{
    return usb_portmon_intr_cb();
}

int Pad5WakeupHook(void)
{
    return usb_portmon_intr_cb();
}

int PadCmnWakeupHook(uint32_t pad_num)
{
    if (pad_num==usb_wkup_pad_idx)
    {
        switch (usb_wkup_pad_idx)
        {
            case 1:
                Pad1WakeupHook();
                break;
            case 5:
                Pad5WakeupHook();
                break;
            default:
                break;                    
        }
    }
    return 0;
}

#if (RTE_USB_EN == 1)
#define USBPORTON_TASK_STACK_SIZE        (1024)
static uint8_t                  usb_portmon_task_stack[USBPORTON_TASK_STACK_SIZE];
static StaticTask_t             usb_portmon_task_tcb;

//share task stack_ptr
uint8_t *usb_wkmon_portmon_share_stack_ptr(void)
{
    return &(usb_portmon_task_stack[0]);
}

uint32_t usb_wkmon_portmon_share_stack_size(void)
{
    return USBPORTON_TASK_STACK_SIZE;
}


void usb_portmon_task_init(void)
{
    osThreadAttr_t task_attr;
    uint8_t * stack_ptr = usb_wkmon_portmon_share_stack_ptr();
    uint32_t stack_size = usb_wkmon_portmon_share_stack_size();
    
    memset(&task_attr,0,sizeof(task_attr));
    memset(stack_ptr, 0xA5,stack_size);
    task_attr.name = "usbpm";
    task_attr.stack_mem = stack_ptr;
    task_attr.stack_size = stack_size;
    task_attr.priority = osPriorityNormal;
    task_attr.cb_mem = &usb_portmon_task_tcb;//task control block
    task_attr.cb_size = sizeof(StaticTask_t);//size of task control block

    osThreadNew(usb_portmon_task, NULL, &task_attr);
}
#endif


