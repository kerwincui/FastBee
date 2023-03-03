#include "FreeRTOS.h"
#include "cmsis_os2.h"
#include "usb_wkmon.h"
#include "apmu_external.h"
#include "plat_config.h"
#include "string.h"
#include "bsp_custom.h"
#include "slpman.h"
#include DEBUG_LOG_HEADER_FILE
#include "usb_ext_inc.h"
#include "task.h"
#include "usbd_errinfo.h"
//#include "gpr.h"

#if (USB_WKMON_TASK_EXIST==1)
typedef enum {
    usb_wkmon_state_uninit = 0,
    usb_wkmon_state_idle = 1,
    usb_wkmon_state_start,

    usb_wkmon_state_detecting,
    usb_wkmon_state_actv,
    usb_wkmon_state_succ ,
    usb_wkmon_state_terminate,

}usb_wkmon_state_type;

uint32_t usb_wkmon_stat = usb_wkmon_state_uninit;

void usb_wkmon_setstat(usb_wkmon_state_type stat);


osEventFlagsId_t LPUsbWkStatEvtFlags = NULL;
osEventFlagsId_t LPUsbWkDetEvtFlags = NULL;

#define USB_RETWKUP_STAT_EVT_UPD_FLAG (1UL<0)
#define USB_RETWKUP_STAT_EVT_START_FLAG (1UL<<1)
#define USB_RETWKUP_STAT_EVT_RESET_FLAG (1UL<<2)

#define USB_RETWKUP_DEV_EVT_UPD_FLAG (1UL<0)
#define USB_RETWKUP_DEV_EVT_TRIG_FLAG (1UL<<1)
#define USB_RETWKUP_DEV_EVT_RESET_FLAG (1UL<<2)

typedef int (*pfn_LPUsbWkupHook)(void);
extern int RegLPUSBWkupIntrHook(pfn_LPUsbWkupHook pfunc);


int usb_wkmon_intr_cb(void);
int USBMonLPWkupIRQHook(void);
//#define TEST_LOW_USB_HCLK
int usb_wkmon_pre_init(void)
{
    uint32_t ret;

    usb_wkmon_stat = usb_wkmon_state_uninit;

#ifdef TEST_LOW_USB_HCLK
    GPR_clockEnable(CLK_HF102M);
    GPR_setClockSrc(CLK_CC, CLK_CC_SEL_102M);
#endif

    LPUsbWkStatEvtFlags = osEventFlagsNew(NULL);
    if (LPUsbWkStatEvtFlags== NULL)
    {
        EC_ASSERT((0), 0, 0, 0);
    }

    LPUsbWkDetEvtFlags = osEventFlagsNew(NULL);
    if (LPUsbWkDetEvtFlags== NULL)
    {
        EC_ASSERT((0), 0, 0, 0);
    }

    if (NVIC_GetEnableIRQ(LpusbWakeup_IRQn))
    {
        //illegal LpusbWakeup_IRQn before start
        EC_ASSERT(0, usbd_get_mod_last_err(), usblpw_retothwk_get_cur_stg(), usblpw_get_retothwk_proc_stat());
    }

    ret = RegLPUSBWkupIntrHook(USBMonLPWkupIRQHook);
    EC_ASSERT((ret==0), 0, 0, 0);
    usb_wkmon_setstat(usb_wkmon_state_idle);

    return 0;
}


int usb_wkmon_cmmon_clear(void){
    usblpw_wkmon_ll_enter_ctx_clear();
    usblpw_wkmon_lpusbwkup_flag_clear();

#ifdef TEST_LOW_USB_HCLK
    GPR_clockEnable(CLK_HF102M);

    GPR_setClockSrc(CLK_CC, CLK_CC_SEL_102M);
#endif
    return 0;
}

int usb_wkmon_deinit(void){
    if (LPUsbWkStatEvtFlags !=NULL){
        osEventFlagsDelete(LPUsbWkStatEvtFlags);
        LPUsbWkStatEvtFlags = NULL;
    }
    if (LPUsbWkDetEvtFlags !=NULL){
        osEventFlagsDelete(LPUsbWkDetEvtFlags);
        LPUsbWkDetEvtFlags = NULL;
    }


    usb_wkmon_setstat(usb_wkmon_state_uninit);
    return 0;
}

int usb_wkmon_hibslp2_stat_evt_start(void)
{
    uint32_t stat_evtflag;
    uint32_t det_evtflag;
    if (LPUsbWkDetEvtFlags)
    {
        det_evtflag = USB_RETWKUP_DEV_EVT_RESET_FLAG |USB_RETWKUP_DEV_EVT_TRIG_FLAG | USB_RETWKUP_DEV_EVT_UPD_FLAG;
        osEventFlagsClear(LPUsbWkDetEvtFlags, det_evtflag);

        //any uncleared stat abort
        det_evtflag = USB_RETWKUP_DEV_EVT_UPD_FLAG;
        osEventFlagsSet (LPUsbWkDetEvtFlags, det_evtflag);
    }

    if (LPUsbWkStatEvtFlags)
    {
        stat_evtflag = USB_RETWKUP_STAT_EVT_RESET_FLAG | USB_RETWKUP_STAT_EVT_START_FLAG|USB_RETWKUP_STAT_EVT_UPD_FLAG;
        osEventFlagsClear (LPUsbWkStatEvtFlags, stat_evtflag);

        stat_evtflag = USB_RETWKUP_STAT_EVT_START_FLAG|USB_RETWKUP_STAT_EVT_UPD_FLAG;
        osEventFlagsSet (LPUsbWkStatEvtFlags, stat_evtflag);
    }
    return 0;
}

int usb_wkmon_slp1_stat_evt_start(void)
{
    uint32_t stat_evtflag;
    uint32_t det_evtflag;
    uint32_t irqflag;

    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_slp1_stat_evt_start_1, P_WARNING, 3,"usb_wkmon_stat %d, det evt 0x%x, stat evt 0x%x", usb_wkmon_stat, LPUsbWkDetEvtFlags, LPUsbWkStatEvtFlags);
    irqflag = SaveAndSetIRQMask();

    switch (usb_wkmon_stat)
    {
    case usb_wkmon_state_idle:
        if (LPUsbWkDetEvtFlags)
        {
            det_evtflag = USB_RETWKUP_DEV_EVT_RESET_FLAG |USB_RETWKUP_DEV_EVT_TRIG_FLAG | USB_RETWKUP_DEV_EVT_UPD_FLAG;
            osEventFlagsClear(LPUsbWkDetEvtFlags, det_evtflag);

            //any uncleared stat abort
            det_evtflag = USB_RETWKUP_DEV_EVT_UPD_FLAG;
            osEventFlagsSet (LPUsbWkDetEvtFlags, det_evtflag);
        }

        if (LPUsbWkStatEvtFlags)
        {
            stat_evtflag = USB_RETWKUP_STAT_EVT_RESET_FLAG | USB_RETWKUP_STAT_EVT_START_FLAG|USB_RETWKUP_STAT_EVT_UPD_FLAG;
            osEventFlagsClear (LPUsbWkStatEvtFlags, stat_evtflag);

            stat_evtflag = USB_RETWKUP_STAT_EVT_START_FLAG|USB_RETWKUP_STAT_EVT_UPD_FLAG;
            osEventFlagsSet (LPUsbWkStatEvtFlags, stat_evtflag);
        }
        break;

    case usb_wkmon_state_start:
        //unlikely here, this stat is sleep disabled
    case usb_wkmon_state_actv:
        //unlikely , this stat is sleep disabled, deal as all reset
        ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_slp1_stat_evt_start_2, P_WARNING, 0,"usb_wkmon_stat unlikely");

    case usb_wkmon_state_detecting:

        //abort detecting and reset to none
        if (LPUsbWkDetEvtFlags)
        {
            det_evtflag = USB_RETWKUP_DEV_EVT_RESET_FLAG |USB_RETWKUP_DEV_EVT_TRIG_FLAG | USB_RETWKUP_DEV_EVT_UPD_FLAG;
            osEventFlagsClear(LPUsbWkDetEvtFlags,det_evtflag);

            //any uncleared stat abort
            det_evtflag = USB_RETWKUP_DEV_EVT_RESET_FLAG;
            osEventFlagsSet (LPUsbWkDetEvtFlags, det_evtflag);
        }

        //start
        if (LPUsbWkStatEvtFlags)
        {
            stat_evtflag = USB_RETWKUP_STAT_EVT_RESET_FLAG | USB_RETWKUP_STAT_EVT_START_FLAG|USB_RETWKUP_STAT_EVT_UPD_FLAG;
            osEventFlagsClear (LPUsbWkStatEvtFlags, stat_evtflag);

            stat_evtflag = USB_RETWKUP_STAT_EVT_START_FLAG|USB_RETWKUP_STAT_EVT_UPD_FLAG;
            osEventFlagsSet (LPUsbWkStatEvtFlags, stat_evtflag);
        }

        break;
    case usb_wkmon_state_succ:
        //start
        if (LPUsbWkStatEvtFlags)
        {
            stat_evtflag = USB_RETWKUP_STAT_EVT_RESET_FLAG | USB_RETWKUP_STAT_EVT_START_FLAG|USB_RETWKUP_STAT_EVT_UPD_FLAG;
            osEventFlagsClear (LPUsbWkStatEvtFlags, stat_evtflag);

            stat_evtflag = USB_RETWKUP_STAT_EVT_RESET_FLAG|USB_RETWKUP_STAT_EVT_START_FLAG|USB_RETWKUP_STAT_EVT_UPD_FLAG;
            osEventFlagsSet (LPUsbWkStatEvtFlags, stat_evtflag);
        }
        break;
    default:
        EC_ASSERT(0, usbd_get_mod_last_err(), usblpw_retothwk_get_cur_stg(), usb_wkmon_stat);
        break;
    }
    RestoreIRQMask(irqflag);

    return 0;
}


int usb_wkmon_slp1_nothwk_evt_reset(void)
{
    uint32_t stat_evtflag;
    uint32_t det_evtflag;
    uint32_t irqflag;

    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_slp1_nothwk_evt_reset_1, P_WARNING, 3,"usb_wkmon_stat %d, det evt 0x%x, stat evt 0x%x", usb_wkmon_stat, LPUsbWkDetEvtFlags, LPUsbWkStatEvtFlags);
    irqflag = SaveAndSetIRQMask();

    switch (usb_wkmon_stat)
    {
    case usb_wkmon_state_uninit:
        ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_slp1_stat_evt_start_uninit, P_WARNING, 0," ");
        break;
    case usb_wkmon_state_idle:
        if (LPUsbWkDetEvtFlags)
        {
            det_evtflag = USB_RETWKUP_DEV_EVT_RESET_FLAG |USB_RETWKUP_DEV_EVT_TRIG_FLAG | USB_RETWKUP_DEV_EVT_UPD_FLAG;
            osEventFlagsClear(LPUsbWkDetEvtFlags, det_evtflag);
        }

        if (LPUsbWkStatEvtFlags)
        {
            stat_evtflag = USB_RETWKUP_STAT_EVT_RESET_FLAG | USB_RETWKUP_STAT_EVT_START_FLAG|USB_RETWKUP_STAT_EVT_UPD_FLAG;
            osEventFlagsClear (LPUsbWkStatEvtFlags, stat_evtflag);
        }
        break;

    case usb_wkmon_state_start:
        //unlikely here, this stat is sleep disabled
    case usb_wkmon_state_actv:
        //unlikely , this stat is sleep disabled, deal as all reset
        ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_slp1_stat_evt_start_2, P_WARNING, 0,"usb_wkmon_stat unlikely");

    case usb_wkmon_state_detecting:

        //abort detecting and reset to none
        if (LPUsbWkDetEvtFlags)
        {
            det_evtflag = USB_RETWKUP_DEV_EVT_RESET_FLAG |USB_RETWKUP_DEV_EVT_TRIG_FLAG | USB_RETWKUP_DEV_EVT_UPD_FLAG;
            osEventFlagsClear(LPUsbWkDetEvtFlags,det_evtflag);

            //any uncleared stat abort
            det_evtflag = USB_RETWKUP_DEV_EVT_RESET_FLAG;
            osEventFlagsSet (LPUsbWkDetEvtFlags, det_evtflag);
        }

        //start
        if (LPUsbWkStatEvtFlags)
        {
            stat_evtflag = USB_RETWKUP_STAT_EVT_RESET_FLAG | USB_RETWKUP_STAT_EVT_START_FLAG|USB_RETWKUP_STAT_EVT_UPD_FLAG;
            osEventFlagsClear (LPUsbWkStatEvtFlags, stat_evtflag);

            stat_evtflag = USB_RETWKUP_STAT_EVT_RESET_FLAG;
            osEventFlagsSet (LPUsbWkStatEvtFlags, stat_evtflag);
        }

        break;
    case usb_wkmon_state_succ:
        //start
        if (LPUsbWkStatEvtFlags)
        {
            stat_evtflag = USB_RETWKUP_STAT_EVT_RESET_FLAG | USB_RETWKUP_STAT_EVT_START_FLAG|USB_RETWKUP_STAT_EVT_UPD_FLAG;
            osEventFlagsClear (LPUsbWkStatEvtFlags, stat_evtflag);

            stat_evtflag = USB_RETWKUP_STAT_EVT_RESET_FLAG;
            osEventFlagsSet (LPUsbWkStatEvtFlags, stat_evtflag);
        }
        break;
    default:
        EC_ASSERT(0, usbd_get_mod_last_err(), usblpw_retothwk_get_cur_stg(), usb_wkmon_stat);
        break;
    }
    RestoreIRQMask(irqflag);

    return 0;
}


usb_wkmon_state_type usb_wkmon_getstat(void)
{
    return usb_wkmon_stat;
}

void usb_wkmon_setstat(usb_wkmon_state_type stat)
{
    usb_wkmon_stat = stat;
}

void BSP_UsbWkIRQLog(void);
//uint8_t BSP_UsbRetOthWkLaterRestOnly(void);


uint8_t usbwkm_vote_handle = 0xff;

//5ms
//#define USBWKM_DET_WAIT_TIME 5
uint8_t usblpw_rd_reg_retwkup_ctxstat(void);

void usb_wkmon_task(void *arg)
{
    uint32_t stat_evtflag;
    uint32_t det_evtflag;

    uint32_t stat_evt_retval;
    uint32_t det_evt_retval;

    uint32_t irqflag;

    uint8_t ret;
    uint8_t stage;
    usb_wkmon_setstat(usb_wkmon_state_idle);

    slpManApplyPlatVoteHandle("usbwk", &usbwkm_vote_handle);
    //slpManPlatVoteDisableSleep(usbwkm_vote_handle, SLP_SLP1_STATE);
    while(1)
    {
        switch (usb_wkmon_getstat())
        {
            case usb_wkmon_state_idle:
                stat_evtflag = USB_RETWKUP_STAT_EVT_START_FLAG | USB_RETWKUP_STAT_EVT_UPD_FLAG;
                ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_state_none_0, P_INFO, 0,"start");
                stat_evt_retval = osEventFlagsWait (LPUsbWkStatEvtFlags, stat_evtflag, osFlagsWaitAny, portMAX_DELAY);
                stage = usblpw_retothwk_get_cur_stg();

                ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_state_none_1, P_INFO, 2,"stage 0x%x, stat_evt_retval:0x%x", stage, stat_evt_retval);

                if (stat_evt_retval&USB_RETWKUP_STAT_EVT_START_FLAG)
                {
                    if ((usblpw_retothwk_cur_stg_hibslp2_wkmon()==0) &&(usblpw_retothwk_cur_stg_slp1_wkmon()==0))
                    {
                        //only enabled from wkmon is legal
                        //ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_state_none_2, P_WARNING, 1,"wkmon stage %d not match", stage);
                        EC_ASSERT(0, usbd_get_mod_last_err(), usblpw_retothwk_get_cur_stg(), usblpw_get_retothwk_proc_stat());
                        break;
                        //continue;
                    }

                    slpManPlatVoteDisableSleep(usbwkm_vote_handle, SLP_SLP1_STATE);
                    usb_wkmon_setstat(usb_wkmon_state_start);
                    break;
                }
                else if (stat_evt_retval&0x80000000)
                {
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_state_none_3, P_WARNING, 1,"stat_evt_retval err 0x%x", stat_evt_retval);
                }
                else
                {
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_state_none_4, P_WARNING, 1,"stat_evt_retval no proc 0x%x", stat_evt_retval);
                }
                break;
            case usb_wkmon_state_start:
                if (NVIC_GetEnableIRQ(LpusbWakeup_IRQn))
                {
                    //illegal LpusbWakeup_IRQn before start
                    EC_ASSERT(0, usbd_get_mod_last_err(), usblpw_retothwk_get_cur_stg(), usblpw_get_retothwk_proc_stat());
                    break;
                }

                irqflag = SaveAndSetIRQMask();
                //enable here after the wkup irq hook, otherwise the irq may not clear in irq hook
                usblpw_enable_lpusbwkup_src();
                usblpw_wkmon_lpusbwkup_flag_set();
                usb_wkmon_setstat(usb_wkmon_state_detecting);
                slpManPlatVoteEnableSleep(usbwkm_vote_handle, SLP_SLP1_STATE);
                //because no usb drv is active here, so enable
                slpManDrvVoteSleep(SLP_VOTE_LPUSB, SLP_SLP1_STATE);
                RestoreIRQMask(irqflag);
                break;

            case usb_wkmon_state_detecting:
                det_evt_retval = 0;
                det_evtflag =  USB_RETWKUP_DEV_EVT_RESET_FLAG | USB_RETWKUP_DEV_EVT_TRIG_FLAG | USB_RETWKUP_DEV_EVT_UPD_FLAG;
                ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_1_0_0, P_INFO, 0,"usb_wkmon_state_detecting start");
                ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_1_0_1, P_INFO, 1,"ctx stat reg %d", usblpw_rd_reg_retwkup_ctxstat());

                //may sleep here, current is enable sleep default
                det_evt_retval = osEventFlagsWait (LPUsbWkDetEvtFlags, det_evtflag, osFlagsWaitAny, portMAX_DELAY);

                ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_1_1, P_INFO, 1,"det_evt_retval:0x%x", det_evt_retval);
                if (det_evt_retval&USB_RETWKUP_DEV_EVT_TRIG_FLAG)
                {
                    //tirg stat, sleep is disabled by irq hook
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_1_2, P_WARNING, 0,"detect evt succ");
                    ret = usblpw_retothwk_wkmon_idle_to_actv_proc();
                    if (ret !=0)
                    {
                        ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_1_3_1, P_WARNING, 0,"usblpw_retothwk_wkmon_idle_to_actv_proc fail");
                        usb_wkmon_setstat(usb_wkmon_state_terminate);
                        EC_ASSERT(0, usbd_get_mod_last_err(), usblpw_retothwk_get_cur_stg(), usblpw_get_retothwk_proc_stat());
                        //assert here
                        break;
                    }
                    if (usblpw_retothwk_cur_proc_stat_gpwr_umatch())
                    {
                        ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_1_3_2, P_WARNING, 0,"usblpw_retothwk_wkmon_idle_to_actv_proc more detecting");

                        irqflag = SaveAndSetIRQMask();
                        //enable here after the wkup irq hook, otherwise the irq may not clear in irq hook
                        usblpw_enable_lpusbwkup_src();
                        usblpw_wkmon_lpusbwkup_flag_set();
                        usb_wkmon_setstat(usb_wkmon_state_detecting);
                        slpManPlatVoteEnableSleep(usbwkm_vote_handle, SLP_SLP1_STATE);
                        //because no usb drv is active here, so enable
                        slpManDrvVoteSleep(SLP_VOTE_LPUSB, SLP_SLP1_STATE);
                        RestoreIRQMask(irqflag);
                        break;
                    }
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_1_4, P_WARNING, 0,"usblpw_retothwk_wkmon_idle_to_actv_proc succ");

                    usb_wkmon_setstat(usb_wkmon_state_actv);
                }
                else if (det_evt_retval&USB_RETWKUP_DEV_EVT_RESET_FLAG)
                {
                    //must be triggered by sleep1
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_1_5, P_WARNING, 0,"detecting reset event ");

                    //unlikely just wait for next trigger, restart
                    usb_wkmon_setstat(usb_wkmon_state_idle);
                }
                else if (det_evt_retval == osErrorTimeout)
                {
                    //slpManPlatVoteEnableSleep(usbwkm_vote_handle, SLP_SLP1_STATE);
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_1_6, P_WARNING, 0,"detect (to) ");
                    usb_wkmon_setstat(usb_wkmon_state_detecting);
                }
                else
                {
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_1_7, P_WARNING, 0,"unknown event ");

                    //unlikely just wait for next trigger, restart
                    slpManPlatVoteEnableSleep(usbwkm_vote_handle, SLP_SLP1_STATE);
                    usb_wkmon_setstat(usb_wkmon_state_start);
                }
                break;

            case usb_wkmon_state_actv:
                ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_2_0, P_WARNING, 0,"usblpw_retothwk_wkmon_actv_proc start");

                ret = usblpw_retothwk_wkmon_actv_proc();
                if (ret != 0)
                {
                    //terminate laterdet or assert
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_2_1, P_WARNING, 0,"usblpw_retothwk_wkmon_actv_proc fail");
                    usb_wkmon_setstat(usb_wkmon_state_terminate);
                    EC_ASSERT(0, usbd_get_mod_last_err(), usblpw_retothwk_get_cur_stg(), usblpw_get_retothwk_proc_stat());
                    break;
                }

                if (usblpw_retothwk_cur_stg_success()==0)
                {
                    usb_wkmon_setstat(usb_wkmon_state_terminate);
                    EC_ASSERT(0, usbd_get_mod_last_err(), usblpw_retothwk_get_cur_stg(), usblpw_get_retothwk_proc_stat());
                }
                ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_2_2, P_WARNING, 0,"usblpw_retothwk_wkmon_actv_proc succ");

                usblpw_wkmon_lpusbwkup_flag_clear();
                usb_wkmon_setstat(usb_wkmon_state_succ);// try next loopo

                break;
            case usb_wkmon_state_succ:
                stat_evtflag = USB_RETWKUP_STAT_EVT_RESET_FLAG;
                ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_state_succ_0, P_INFO, 0,"start");

                slpManPlatVoteEnableSleep(usbwkm_vote_handle, SLP_SLP1_STATE);
                stat_evt_retval = osEventFlagsWait (LPUsbWkStatEvtFlags, stat_evtflag, osFlagsWaitAny, portMAX_DELAY);
                ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_state_succ_1, P_INFO, 1,"stat_evt_retval:0x%x", stat_evt_retval);
                if (stat_evt_retval&USB_RETWKUP_STAT_EVT_RESET_FLAG)
                {
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_state_succ_2, P_WARNING, 0,"stat_evt_retval reset");
                    usb_wkmon_setstat(usb_wkmon_state_idle);
                    break;
                }
                else if (stat_evt_retval&0x80000000)
                {
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_state_succ_3, P_WARNING, 0,"stat_evt_retval err ");
                }
                else
                {
                    ECOMM_TRACE(UNILOG_PLA_DRIVER, usb_wkmon_task_state_succ_4, P_WARNING, 0, "stat_evt_retval default proc as reset");
                    usb_wkmon_setstat(usb_wkmon_state_idle);
                }
                break;

            default:
                EC_ASSERT(0, usbd_get_mod_last_err(), usblpw_retothwk_get_cur_stg(), usb_wkmon_getstat());
                break;
        }
    }
}

void BSP_LPUsbWkIRQLog(void)
{
    ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_LPUsbWkIRQLog_1, P_VALUE, "othwkup stage %d, proc_stat %d", usblpw_get_retothwk_stage(), usblpw_get_retothwk_proc_stat());
}


int usb_wkmon_intr_cb(void)
{
    if ((usblpw_retothwk_cur_stg_hibslp2_wkmon()) || (usblpw_retothwk_cur_stg_slp1_wkmon()))
    {
        if (usb_wkmon_getstat()==usb_wkmon_state_detecting)
        {
            //the legal wkmon stat is usb_wkmon_state_detecting for dev event
            osEventFlagsSet (LPUsbWkDetEvtFlags, USB_RETWKUP_DEV_EVT_TRIG_FLAG|USB_RETWKUP_DEV_EVT_UPD_FLAG);
            NVIC_DisableIRQ(LpusbWakeup_IRQn);
            slpManPlatVoteDisableSleep(usbwkm_vote_handle, SLP_SLP1_STATE);
        }
        else
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, usb_wkmon_intr_cb_1_0, P_VALUE, "usb_wkmon_stat %d not match, no event sent", usb_wkmon_getstat());
        }

        if (usblpw_wkmon_ll_enter_ctx_get())
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, usb_wkmon_intr_cb_1_1, P_VALUE, "chk_abort_ll_inirq, wkmon_lpusbwkup_flag %x", usblpw_wkmon_lpusbwkup_flag_get());

            usblpw_enter_wkmon_chk_abort_ll_inirq();
        }
    }
    else if (usblpw_retothwk_cur_stg_none()==0)
    {
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, usb_wkmon_intr_cb_2, P_VALUE, "unlegal stag");
    }

    return 0;
}

int USBMonLPWkupIRQHook(void)
{
    BSP_LPUsbWkIRQLog();
    return usb_wkmon_intr_cb();
}

#define USBWKM_TASK_STACK_SIZE        (1024)
//#define USB_WKMON_PRIVATE_STACK
#ifdef USB_WKMON_PRIVATE_STACK
static uint8_t                  usb_wkmon_task_stack[USBWKM_TASK_STACK_SIZE];
static StaticTask_t             usb_wkmon_task_tcb;

uint8_t *usb_wkmon_get_stack_ptr(void)
{
    return &(usb_wkmon_task_stack[0]);
}

uint32_t usb_wkmon_get_stack_size(void)
{
    return USBWKM_TASK_STACK_SIZE;
}
#else
static StaticTask_t             usb_wkmon_task_tcb;

extern uint8_t *usb_wkmon_portmon_share_stack_ptr(void);
extern uint32_t usb_wkmon_portmon_share_stack_size(void);

#endif
void usb_wkmon_task_init(void)
{
    osThreadAttr_t task_attr;
    uint8_t * stack_ptr = usb_wkmon_portmon_share_stack_ptr();
    uint32_t stack_size = usb_wkmon_portmon_share_stack_size();
    memset(&task_attr,0,sizeof(task_attr));
    memset(stack_ptr, 0xA5,stack_size);
    task_attr.name = "usbwkm";
    task_attr.stack_mem = stack_ptr;
    task_attr.stack_size = stack_size;
    task_attr.priority = osPriorityNormal;
    task_attr.cb_mem = &usb_wkmon_task_tcb;//task control block
    task_attr.cb_size = sizeof(StaticTask_t);//size of task control block

    osThreadNew(usb_wkmon_task, NULL, &task_attr);
}
#endif

