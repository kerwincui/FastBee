/*
 * Copyright (c) 2022 OpenLuat & AirM2M
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/*
 * PWM操作
 * 
 */
#include "common_api.h"
#include "FreeRTOS.h"
#include "task.h"

#include "luat_base.h"
#ifdef __LUATOS__
#include "luat_malloc.h"
#include "luat_msgbus.h"
#include "luat_timer.h"
#endif
#include "luat_pwm.h"
#include "luat_rtos.h"

#include "timer.h"
#include "hal_adc.h"
#include "ic.h"
#include "hal_trim.h"
#include "timer.h"
#include "ec618.h"
#include "clock.h"
#include "pad.h"
#include "luat_debug.h"
#include "RTE_Device.h"
#define EIGEN_TIMER(n)             ((TIMER_TypeDef *) (AP_TIMER0_BASE_ADDR + 0x1000*n))

static signed char if_initialized_timer(const int channel)
{
   if( 0 != EIGEN_TIMER(channel)->TCCR )
    {

        return -1;
    }

    return 0;
}

#define PWM_CH_MAX (6)


static int g_s_pnum_set[PWM_CH_MAX] = {0}; /*设置PWM脉冲个数*/
static volatile int g_s_pnum_update[PWM_CH_MAX] = {0};/*当前PWM个数*/
/*最高频率应是26M*/ 
#define MAX_FREQ (26*1000*1000)
typedef struct pwm_ctx
{
    TimerPwmConfig_t timer_config;
    uint32_t freq;
    uint32_t pulse;
    uint32_t pnum;
}pwm_ctx_t;

typedef struct pwm_map
{
    int pwm_ch; // 对外展示的pwm id
    int clockId;
    int clockId_slect;
    int time_req;
    int pad;
}pwm_map_t;

static const pwm_map_t maps[] = {
#ifdef RTE_PWM0
    {.pwm_ch=0, .clockId=FCLK_TIMER0, .clockId_slect=FCLK_TIMER0_SEL_26M, .time_req=PXIC0_TIMER0_IRQn, .pad=RTE_PWM0},
#endif
#ifdef RTE_PWM1
    {.pwm_ch=1, .clockId=FCLK_TIMER1, .clockId_slect=FCLK_TIMER1_SEL_26M, .time_req=PXIC0_TIMER1_IRQn, .pad=RTE_PWM1},
#endif
#ifdef RTE_PWM2
    {.pwm_ch=2, .clockId=FCLK_TIMER2, .clockId_slect=FCLK_TIMER2_SEL_26M, .time_req=PXIC0_TIMER2_IRQn, .pad=RTE_PWM2},
#endif
// #ifdef RTE_PWM3
//     {.pwm_ch=3, .clockId=FCLK_TIMER3, .clockId_slect=FCLK_TIMER3_SEL_26M, .time_req=PXIC0_TIMER3_IRQn, .pad=RTE_PWM3},
// #endif
#ifdef RTE_PWM4
    {.pwm_ch=4, .clockId=FCLK_TIMER4, .clockId_slect=FCLK_TIMER4_SEL_26M, .time_req=PXIC0_TIMER4_IRQn, .pad=RTE_PWM4},
#endif
// #ifdef RTE_PWM5
//     {.pwm_ch=5, .clockId=FCLK_TIMER5, .clockId_slect=FCLK_TIMER5_SEL_26M, .time_req=PXIC0_TIMER5_IRQn, .pad=RTE_PWM5},
// #endif

    // 以下为固定映射
    /*
    10 -- GPIO 01 -- PAD 16  ---> LCD_RST
    11 -- GPIO 02 -- PAD 17
    12 -- GPIO 16 -- PAD 31
    13 -- GPIO 17 -- PAD 32  xxx 不可用
    14 -- GPIO 18 -- PAD 33  ---> UART1_RX
    15 -- GPIO 19 -- PAD 34  ---> UART1_TX xxx 不可用
    */
    {.pwm_ch=10, .clockId=FCLK_TIMER0, .clockId_slect=FCLK_TIMER0_SEL_26M, .time_req=PXIC0_TIMER0_IRQn, .pad=16},
    {.pwm_ch=11, .clockId=FCLK_TIMER1, .clockId_slect=FCLK_TIMER1_SEL_26M, .time_req=PXIC0_TIMER1_IRQn, .pad=17},
    {.pwm_ch=12, .clockId=FCLK_TIMER2, .clockId_slect=FCLK_TIMER2_SEL_26M, .time_req=PXIC0_TIMER2_IRQn, .pad=31},
    // {.pwm_ch=13, .clockId=FCLK_TIMER3, .clockId_slect=FCLK_TIMER3_SEL_26M, .time_req=PXIC0_TIMER3_IRQn, .pad=32},
    {.pwm_ch=14, .clockId=FCLK_TIMER4, .clockId_slect=FCLK_TIMER4_SEL_26M, .time_req=PXIC0_TIMER4_IRQn, .pad=33},
    // {.pwm_ch=15, .clockId=FCLK_TIMER5, .clockId_slect=FCLK_TIMER5_SEL_26M, .time_req=PXIC0_TIMER5_IRQn, .pad=34},

};



static pwm_ctx_t pwms[PWM_CH_MAX];

static int luat_pwm_mapid(int channel) {
    int map_id = -1;
    for (size_t i = 0; i < sizeof(maps) / sizeof(pwm_map_t); i++)
    {
        if (maps[i].pwm_ch == channel) {
            map_id = i;
            break;
        }
    }
    return map_id;
}

PLAT_PA_RAMCODE static void Timer_ISR()
{

    volatile int i = 0;

    // PWM 3/5 通道需要跳过, 其中 3 是 tick64, 5是CP占用了
    for(i = 0;i < 5;i++)
    {
        if (i == 3)
            continue;
        if (TIMER_getInterruptFlags(i) & TIMER_MATCH2_INTERRUPT_FLAG)
        {
            TIMER_clearInterruptFlags(i, TIMER_MATCH2_INTERRUPT_FLAG);
            g_s_pnum_update[i]++;
            if (g_s_pnum_update[i] >= g_s_pnum_set[i])
            {
                //luat_pwm_close(i);
                TIMER_updatePwmDutyCycle(i,0);
                //luat_pwm_update_dutycycle(i,0);
                TIMER_stop(i);
                //LUAT_DEBUG_PRINT("PWM STOP %d",g_s_pnum_update[i]);
                g_s_pnum_update[i] = 0;
            }
        }
    }
}

int luat_pwm_open(int channel, size_t freq,  size_t pulse, int pnum) {
    PadConfig_t config = {0};

    int map_id = luat_pwm_mapid(channel);
    if (map_id == -1)
        return -1;

    if (freq > MAX_FREQ)
        return -2;
    if (pulse > 100)
        pulse = 100;

    if(if_initialized_timer(channel % 10) < 0)
    {
        return -4;   // hardware timer is used
    }

    // LUAT_DEBUG_PRINT("luat_pwm_open get timer_id %d",timer_id);
    PAD_getDefaultConfig(&config);
    config.mux = PAD_MUX_ALT5;
    
    // 为支持复用, 只取低位
    channel = channel % 10;

    g_s_pnum_set[channel] = pnum;
    PAD_setPinConfig(maps[map_id].pad, &config);

    CLOCK_setClockSrc(maps[map_id].clockId, maps[map_id].clockId_slect);
    CLOCK_setClockDiv(maps[map_id].clockId, 1);
    TIMER_driverInit();

    pwms[channel].timer_config.pwmFreq_HZ = freq;
    pwms[channel].timer_config.srcClock_HZ = GPR_getClockFreq(maps[map_id].clockId);  
    pwms[channel].timer_config.dutyCyclePercent = pulse;
    TIMER_setupPwm(channel, &pwms[channel].timer_config);
    if(0 != pnum)
    {
        TIMER_interruptConfig(channel, TIMER_MATCH0_SELECT, TIMER_INTERRUPT_DISABLED);
        TIMER_interruptConfig(channel, TIMER_MATCH1_SELECT, TIMER_INTERRUPT_DISABLED);
        TIMER_interruptConfig(channel, TIMER_MATCH2_SELECT, TIMER_INTERRUPT_LEVEL);

        XIC_SetVector(maps[map_id].time_req,Timer_ISR);
        XIC_EnableIRQ(maps[map_id].time_req);
    }

    TIMER_start(channel);

    return 0;
}

int luat_pwm_update_dutycycle(int channel,size_t pulse)
{
    int map_id = luat_pwm_mapid(channel);
    if (map_id == -1)
        return -1;
    channel = channel % 10;

    pwms[channel].timer_config.dutyCyclePercent = pulse;
    TIMER_setupPwm(channel, &pwms[channel].timer_config);
    return 0;
}

int luat_pwm_setup(luat_pwm_conf_t* conf)
{
    int channel = conf->channel;
    int map_id = luat_pwm_mapid(channel);
    if (map_id == -1)
        return -1;
    if (conf->precision != 100) {
        // 当且仅支持100分辨率,等驱动重构完再改
        return -1;
    }
    channel = channel % 10;
    // 判断一下是否只修改了占空比. 当且仅当频率相同,pnum为0(即持续输出),才支持单独变更
    if (pwms[channel].timer_config.pwmFreq_HZ == conf->period && conf->pnum == 0) {
        if (conf->pulse != pwms[channel].timer_config.dutyCyclePercent) {
            pwms[channel].timer_config.dutyCyclePercent = conf->pulse;
            TIMER_updatePwmDutyCycle(conf->channel % 10, conf->pulse);
            return 0;
        }
    }
    return luat_pwm_open(conf->channel,conf->period,conf->pulse,conf->pnum);
}

int luat_pwm_capture(int channel,int freq)
{
    int map_id = luat_pwm_mapid(channel);
    if (map_id == -1)
        return -1;
    return EIGEN_TIMER(channel % 10)->TMR[0];
}

int luat_pwm_close(int channel)
{
    int map_id = luat_pwm_mapid(channel);
    if (map_id == -1)
        return -1;
    luat_pwm_update_dutycycle(channel, 0);
    luat_rtos_task_sleep(1);
    TIMER_stop(channel % 10);
    pwms[channel % 10].timer_config.pwmFreq_HZ = 0; // 作为标志位
    g_s_pnum_update[channel % 10] = 0;
    g_s_pnum_set[channel % 10] = 0;
    // 恢复GPIO默认配置

    return 0;
}

