#ifndef __USB_EXT_INC_H__
#define __USB_EXT_INC_H__
uint8_t usblpw_retwkup_stack_restore(void);
void usblpw_retwkup_stack_enable(void);


//Important, do not modify this macro
#define USBC_CTRL_HIB_LITE_MODE 1

#if (USBC_CTRL_HIB_LITE_MODE==1)

#define USB_WKMON_TASK_EXIST 0
#else
#define USB_WKMON_TASK_EXIST 1

#endif


uint8_t usblpw_is_retwkups2_start(void);
uint8_t usblpw_is_retothwks2_start(void);

typedef enum {
    usblpw_retothwk_stg_none =0,
    usblpw_retothwk_stg_bt_pre_idle,
    usblpw_retothwk_stg_bt_later_idle,
    usblpw_retothwk_stg_bt_actv,
    usblpw_retothwk_stg_hibslp2_wkmon,
    usblpw_retothwk_stg_slp1_wkmon,
    usblpw_retothwk_stg_succ,
    usblpw_retothwk_stg_teminate,
}usblpw_retothwk_stg_type;



uint8_t usblpw_retothwk_set_bt_pre_idle_stage(void);
uint8_t usblpw_retothwk_set_bt_later_idle_stage(void);
uint8_t usblpw_retothwk_set_bt_actv_stage(void);
uint8_t usblpw_retothwk_set_hibslp2_wkmon_stage(void);
uint8_t usblpw_retothwk_set_slp1_wkmon_stage(void);
uint8_t usblpw_retothwk_set_terminate_stage(void);
uint8_t usblpw_retothwk_set_succ_stage(void);

void usblpw_clear_retothwk_proc_stat(void);

uint8_t usblpw_get_retothwk_stage(void);

usblpw_retothwk_stg_type usblpw_retothwk_get_cur_stg(void);

uint8_t usblpw_retothwk_cur_stg_none(void);
uint8_t usblpw_retothwk_cur_stg_bt_pre_idle(void);
uint8_t usblpw_retothwk_cur_stg_bt_later_idle(void);
uint8_t usblpw_retothwk_cur_stg_bt_actv(void);
uint8_t usblpw_retothwk_cur_stg_hibslp2_wkmon(void);
uint8_t usblpw_retothwk_cur_stg_slp1_wkmon(void);

uint8_t usblpw_retothwk_cur_stg_terminate(void);
uint8_t usblpw_retothwk_cur_stg_success(void);


#if (USBC_CTRL_HIB_LITE_MODE==0)

void usblpw_retothwk_set_pre_rest_illegal(uint8_t stage);
uint8_t usblpw_retothwk_pre_rest_chk_illegal(uint8_t stage);
uint8_t usblpw_retothwk_poll_gpwr_match(uint8_t stage);

uint8_t usblpw_retothwk_chk_pre_rest_worth(void);
uint8_t usblpw_retothwk_try_pre_restore(uint8_t stage);

uint8_t usblpw_retothwk_stackrest_chk_illegal(uint8_t stage);
void usblpw_retothwk_set_stack_rest_illegal(uint8_t stage);
void usblpw_retothwk_set_stack_rest_fail(uint8_t stage);

uint8_t usblpw_retwkup_slp1_stack_restore(void);

uint8_t usblpw_retothwk_hibslp2_stack_restore(uint8_t stage);
uint8_t usblpw_retothwk_hibslp2_try_stack_rest(uint8_t stage);
uint8_t usblpw_retothwk_slp1_try_stack_rest(uint8_t stage);

uint8_t usblpw_retothwk_bt_pre_idle_stage_proc(void);

uint8_t usblpw_retothwk_hibslp2_bt_later_idle_stage_proc(void);
uint8_t usblpw_retothwk_slp1_bt_later_idle_stage_proc(void);

uint8_t usblpw_retothwk_hibslp2_bt_actv_stage_proc(void);
uint8_t usblpw_retothwk_slp1_bt_actv_stage_proc(void);



uint8_t usblpw_retothwk_wkmon_idle_to_actv_proc(void);

uint8_t usblpw_retothwk_hibslp2_wkmon_actv_proc(void);
uint8_t usblpw_retothwk_slp1_wkmon_actv_proc(void);

uint8_t usblpw_retothwk_wkmon_actv_proc(void);


uint8_t usblpw_get_retothwk_proc_stat(void);
uint8_t usblpw_retothwk_cur_proc_stat_gpwr_umatch(void);

void usblpw_retothwk_clear_errinfo(void);

int usb_wkmon_pre_init(void);
int usb_wkmon_cmmon_clear(void);
void usb_wkmon_task_init(void);

int usb_wkmon_hibslp2_stat_evt_start(void);
int usb_wkmon_slp1_stat_evt_start(void);

extern void usblpw_wkmon_ll_enter_ctx_clear(void);
extern uint8_t usblpw_wkmon_ll_enter_ctx_get(void);
extern void usblpw_enter_wkmon_chk_abort_ll_inirq(void);

extern void usblpw_wkmon_lpusbwkup_flag_clear(void);
extern void usblpw_wkmon_lpusbwkup_flag_set(void);
extern uint8_t usblpw_wkmon_lpusbwkup_flag_get(void);
#endif

#if (USBC_CTRL_HIB_LITE_MODE==1)
uint8_t usblpw_retothwk_hibslp2_stack_restore(uint8_t stage);
#endif

void usblpw_enable_lpusbwkup_src(void);
uint32_t usblpw_clear_lpusbwkup_src(void);



uint8_t usbstack_init(void);
uint8_t usbstack_deinit(void);

void usblpw_get_pwr_info(uint8_t* p_pwr_state, uint8_t* p_boot_stat, uint8_t* p_last_wkup);
uint8_t usblpw_is_retwkup_support(void);


void usbc_trace_cfg(uint32_t usb_sw_trace);


#endif
