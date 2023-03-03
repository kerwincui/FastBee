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
 * ADC操作
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
#include "luat_adc.h"

#include "adc.h"
#include "hal_adc.h"
#include "ic.h"
#include "hal_trim.h"


/*
注意, 按硬件应用手册的描述, ADC0 对应的是 AIO3, ADC1 对应的 AIO4

而 VBAT和TEMP 则使用LuatOS定义的, 与硬件无关.

*/

typedef struct
{
    LUAT_ADC_RANGE_E range;
    AdcAioResDiv_e resdiv;
    float ratio;
}adc_range_resdiv_map_item_t;

extern void delay_us(uint32_t us);

static uint8_t adc_state[4] = {0}; // 注意实际映射, 当前不支持 AIO1/AIO2的映射
static LUAT_ADC_RANGE_E adc_range[4] = {LUAT_ADC_AIO_RANGE_3_8, LUAT_ADC_AIO_RANGE_3_8, LUAT_ADC_VBAT_RANGE_5_3_RATIO, LUAT_ADC_VBAT_RANGE_5_3_RATIO}; 
static volatile uint32_t aio3ChannelResult = 0;
static volatile uint32_t aio4ChannelResult = 0;
static volatile uint32_t vbatChannelResult = 0;
static volatile uint32_t thermalChannelResult = 0;

static int adc_exist(int id) {
    if (id >= 0 && id < 5)
        return 1;
    if (id == LUAT_ADC_CH_CPU || id == LUAT_ADC_CH_VBAT)
        return 1;
    return 0;
}

static int adc_range_to_resdiv(int id, int range, AdcAioResDiv_e *resdiv, float *ratio)
{
    adc_range_resdiv_map_item_t map[]=
    {
        {LUAT_ADC_AIO_RANGE_1_2, ADC_AIO_RESDIV_RATIO_1, (float)1},
        {LUAT_ADC_AIO_RANGE_1_4, ADC_AIO_RESDIV_RATIO_14OVER16, (float)16/14},
        {LUAT_ADC_AIO_RANGE_1_6, ADC_AIO_RESDIV_RATIO_12OVER16, (float)16/12},
        {LUAT_ADC_AIO_RANGE_1_9, ADC_AIO_RESDIV_RATIO_10OVER16, (float)16/10},
        {LUAT_ADC_AIO_RANGE_2_4, ADC_AIO_RESDIV_RATIO_8OVER16, (float)16/8},
        {LUAT_ADC_AIO_RANGE_2_7, ADC_AIO_RESDIV_RATIO_7OVER16, (float)16/7},
        {LUAT_ADC_AIO_RANGE_3_2, ADC_AIO_RESDIV_RATIO_6OVER16, (float)16/6},
        {LUAT_ADC_AIO_RANGE_3_8, ADC_AIO_RESDIV_RATIO_5OVER16, (float)16/5},
        // 不再支持以下配置，无意义
        // {LUAT_ADC_AIO_RANGE_4_8, ADC_AIO_RESDIV_RATIO_4OVER16, (float)16/4},
        // {LUAT_ADC_AIO_RANGE_6_4, ADC_AIO_RESDIV_RATIO_3OVER16, (float)16/3},
        // {LUAT_ADC_AIO_RANGE_9_6, ADC_AIO_RESDIV_RATIO_2OVER16, (float)16/2},
        // {LUAT_ADC_AIO_RANGE_19_2, ADC_AIO_RESDIV_RATIO_1OVER16, (float)16/1},

        {LUAT_ADC_VBAT_RANGE_2_0_RATIO, ADC_VBAT_RESDIV_RATIO_8OVER16, (float)16/8},
        {LUAT_ADC_VBAT_RANGE_2_2_RATIO, ADC_VBAT_RESDIV_RATIO_7OVER16, (float)16/7},
        {LUAT_ADC_VBAT_RANGE_2_6_RATIO, ADC_VBAT_RESDIV_RATIO_6OVER16, (float)16/6},
        {LUAT_ADC_VBAT_RANGE_3_2_RATIO, ADC_VBAT_RESDIV_RATIO_5OVER16, (float)16/5},
        {LUAT_ADC_VBAT_RANGE_4_0_RATIO, ADC_VBAT_RESDIV_RATIO_4OVER16, (float)16/4},
        {LUAT_ADC_VBAT_RANGE_5_3_RATIO, ADC_VBAT_RESDIV_RATIO_3OVER16, (float)16/3},
        {LUAT_ADC_VBAT_RANGE_8_0_RATIO, ADC_VBAT_RESDIV_RATIO_2OVER16, (float)16/2},
        {LUAT_ADC_VBAT_RANGE_16_0_RATIO, ADC_VBAT_RESDIV_RATIO_1OVER16, (float)16/1},
    };

    size_t i = 0;

    for (i = 0; i < sizeof(map)/sizeof(map[0]); i++)
    {
        if(map[i].range == range)
        {
            if (resdiv)
            {
                *resdiv = map[i].resdiv;
            }
            
            if (ratio)
            {
                *ratio = map[i].ratio;
            }            

            return 0;
        }
    }
    
    return 1;
}

static void adc0_cb(uint32_t result) {
    aio3ChannelResult = result;
    adc_state[0] = 1;
}

static void adc1_cb(uint32_t result) {
    aio4ChannelResult = result;
    adc_state[1] = 1;
}

static void adc_vbat_cb(uint32_t result) {
    vbatChannelResult = result;
    adc_state[2] = 1;
}
static void adc_temp_cb(uint32_t result) {
    thermalChannelResult = result;
    adc_state[3] = 1;
}

static volatile uint8_t adc_init = 1;

int luat_adc_open(int id, void* ptr) {
    AdcConfig_t adcConfig;
    if (!adc_exist(id))
        return -1;
    ADC_getDefaultConfig(&adcConfig);
    if (adc_init){
        trimAdcSetGolbalVar();
        adc_init = 0;
    }

    AdcAioResDiv_e resdiv;
    if (LUAT_ADC_CH_CPU == id)
    {
       adc_range_to_resdiv(id, adc_range[2], &resdiv, NULL);
    }
    else if (LUAT_ADC_CH_VBAT == id)
    {
       adc_range_to_resdiv(id, adc_range[3], &resdiv, NULL);
    }
    else
    {
        adc_range_to_resdiv(id, adc_range[id], &resdiv, NULL);
    }    
    
    switch (id)
    {
    case 0:
        adcConfig.channelConfig.aioResDiv = resdiv;
        ADC_channelInit(ADC_CHANNEL_AIO3, ADC_USER_APP, &adcConfig, adc0_cb);
        adc_state[0] = 0;
        break;
    case 1:
        adcConfig.channelConfig.aioResDiv = resdiv;
        ADC_channelInit(ADC_CHANNEL_AIO4, ADC_USER_APP, &adcConfig, adc1_cb);
        adc_state[1] = 0;
        break;
    case LUAT_ADC_CH_VBAT: // vbat
        adcConfig.channelConfig.vbatResDiv = resdiv;
        ADC_channelInit(ADC_CHANNEL_VBAT, ADC_USER_APP, &adcConfig, adc_vbat_cb);
        adc_state[2] = 0;
        break;
    case LUAT_ADC_CH_CPU: // temp
        adcConfig.channelConfig.vbatResDiv = resdiv;
        ADC_channelInit(ADC_CHANNEL_THERMAL, ADC_USER_APP, NULL, adc_temp_cb);
        adc_state[3] = 0;
        break;
    default:
        return -1;
    }
    
    return 0;
}

int luat_adc_read(int id, int* val, int* val2) {
    if (!adc_exist(id))
        return -1;
    int t = 1000;
    switch (id)
    {
    case 0:
        ADC_startConversion(ADC_CHANNEL_AIO3, ADC_USER_APP);
        while(adc_state[0] == 0 && t > 0) {
            delay_us(10);
            t --;
        }; // 1w个循环,通常需要4000个循环
        if (adc_state[0] == 0) return -1;
        break;
    case 1:
        ADC_startConversion(ADC_CHANNEL_AIO4, ADC_USER_APP);
        while(adc_state[1] == 0 && t > 0) {
            delay_us(10);
            t --;
        }; // 1w个循环,通常需要4000个循环
        if (adc_state[1] == 0) return -1;
        break;
    case LUAT_ADC_CH_VBAT:
        ADC_startConversion(ADC_CHANNEL_VBAT, ADC_USER_APP);
        while(adc_state[2] == 0 && t > 0) {
            delay_us(10);
            t --;
        }; // 1w个循环,通常需要4000个循环
        if (adc_state[2] == 0) return -1;
        break;
    case LUAT_ADC_CH_CPU:
        ADC_startConversion(ADC_CHANNEL_THERMAL, ADC_USER_APP);
        while(adc_state[3] == 0 && t > 0) {
            delay_us(10);
            t --;
        }; // 1w个循环,通常需要4000个循环
        if (adc_state[3] == 0) return -1;
        break;
    default:
        return -1;
    }

    float ratio;
    if (LUAT_ADC_CH_CPU == id)
    {
       adc_range_to_resdiv(id, adc_range[2], NULL, &ratio);
    }
    else if (LUAT_ADC_CH_VBAT == id)
    {
       adc_range_to_resdiv(id, adc_range[3], NULL, &ratio);
    }
    else
    {
        adc_range_to_resdiv(id, adc_range[id], NULL, &ratio);
    } 
    
    switch (id)
    {
    case 0:
        *val = aio3ChannelResult;
#ifdef __LUATOS__
        *val2 = (int)HAL_ADC_CalibrateRawCode(aio3ChannelResult) * ratio /1000;
#else
        *val2 = (int)HAL_ADC_CalibrateRawCode(aio3ChannelResult) * ratio ;
#endif
        break;
    case 1:
        *val = aio4ChannelResult;
#ifdef __LUATOS__
        *val2 = (int)HAL_ADC_CalibrateRawCode(aio4ChannelResult) * ratio /1000;
#else
        *val2 = (int)HAL_ADC_CalibrateRawCode(aio4ChannelResult) * ratio ;
#endif
        break;
    case LUAT_ADC_CH_VBAT:
        *val = vbatChannelResult;
        *val2 =  (int)HAL_ADC_CalibrateRawCode(vbatChannelResult) * ratio / 1000;
        break;
    case LUAT_ADC_CH_CPU:
        *val = thermalChannelResult;
        *val2 = (int)HAL_ADC_ConvertThermalRawCodeToTemperature(thermalChannelResult);
        break;
    default:
        return -1;
    }

    return 0;
}

int luat_adc_close(int id) {
    switch (id)
    {
    case 0:
        ADC_channelDeInit(ADC_CHANNEL_AIO3, ADC_USER_APP);
        break;
    case 1:
        ADC_channelDeInit(ADC_CHANNEL_AIO4, ADC_USER_APP);
        break;
    case LUAT_ADC_CH_VBAT:
        ADC_channelDeInit(ADC_CHANNEL_VBAT, ADC_USER_APP);
        break;
    case LUAT_ADC_CH_CPU:
        ADC_channelDeInit(ADC_CHANNEL_THERMAL, ADC_USER_APP);
        break;
    default:
        return -1;
    }
    return 0;
}


int luat_adc_global_config(int tp, int val) {
    return -1;
}

int luat_adc_ctrl(int id, LUAT_ADC_CTRL_CMD_E cmd, luat_adc_ctrl_param_t param)
{
    if (!adc_exist(id))
    {
        return -1;
    }

    switch (cmd)
    {
    case LUAT_ADC_SET_GLOBAL_RANGE:
        
        if (LUAT_ADC_CH_CPU == id)
        {
            adc_range[2] = param.range;
        }
        else if (LUAT_ADC_CH_VBAT == id)
        {
            adc_range[3] = param.range;
        }
        else
        {
            adc_range[id] = param.range;
        }
        break;
    
    default:
        return -1;
        break;
    }  

    return 0;      
}


