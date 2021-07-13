/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
#include "statistic_perfmon.h"

static const char* TAG = "perfmon";

static void exec_test_function(void *params)
{
    for (int i = 0 ; i < 100 ; i++) {
        __asm__ __volatile__("   nop");
    }
}

// 具有专用性能计数器的表
static uint32_t pm_check_table[] = {
    XTPERF_CNT_CYCLES, XTPERF_MASK_CYCLES,                   // 总周期
    XTPERF_CNT_INSN, XTPERF_MASK_INSN_ALL,                   // 总的说明
    XTPERF_CNT_D_LOAD_U1, XTPERF_MASK_D_LOAD_LOCAL_MEM,      // 内存读取
    XTPERF_CNT_D_STORE_U1, XTPERF_MASK_D_STORE_LOCAL_MEM,    // 内存写入
    XTPERF_CNT_BUBBLES, XTPERF_MASK_BUBBLES_ALL &(~XTPERF_MASK_BUBBLES_R_HOLD_REG_DEP),  // 等待其他原因
    XTPERF_CNT_BUBBLES, XTPERF_MASK_BUBBLES_R_HOLD_REG_DEP,                              // 等待注册依赖项
    XTPERF_CNT_OVERFLOW, XTPERF_MASK_OVERFLOW,                                           // 最后一个测试周期
};

#define TOTAL_CALL_AMOUNT 200
#define PERFMON_TRACELEVEL -1 // -1将忽略跟踪级别

void perfmon_start(void)
{
    ESP_LOGI(TAG, "Start");
    ESP_LOGI(TAG, "Start test with printing all available statistic");
    xtensa_perfmon_config_t pm_config = {};
    pm_config.counters_size = sizeof(xtensa_perfmon_select_mask_all) / sizeof(uint32_t) / 2;
    pm_config.select_mask = xtensa_perfmon_select_mask_all;
    pm_config.repeat_count = TOTAL_CALL_AMOUNT;
    pm_config.max_deviation = 1;
    pm_config.call_function = exec_test_function;
    pm_config.callback = xtensa_perfmon_view_cb;
    pm_config.callback_params = stdout;
    pm_config.tracelevel = PERFMON_TRACELEVEL;
    xtensa_perfmon_exec(&pm_config);

    ESP_LOGI(TAG, "Start test with user defined statistic");
    pm_config.counters_size = sizeof(pm_check_table) / sizeof(uint32_t) / 2;
    pm_config.select_mask = pm_check_table;
    pm_config.repeat_count = TOTAL_CALL_AMOUNT;
    pm_config.max_deviation = 1;
    pm_config.call_function = exec_test_function;
    pm_config.callback = xtensa_perfmon_view_cb;
    pm_config.callback_params = stdout;
    pm_config.tracelevel = PERFMON_TRACELEVEL;

    xtensa_perfmon_exec(&pm_config);

    ESP_LOGI(TAG, "The End");
}
