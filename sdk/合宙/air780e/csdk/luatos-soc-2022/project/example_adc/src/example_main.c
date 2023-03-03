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
#include "common_api.h"
#include "luat_rtos.h"
#include "luat_debug.h"

#include "luat_adc.h"

luat_rtos_task_handle adc_task_handle;

static void task_test_adc(void *param)
{
    int val, val2;

    // adc0和adc1的说明如下：
    // 1、adc引脚允许输入的最大电压是3.4V
    // 2、如果采用内部分压，外部不分压的方式，软件上通过调用luat_adc_ctrl接口来设置量程，支持1.2V、1.4V、1.6、1.9、2.4、2.7、3.2、3.8V几种量程；
    // 3、如果采用外部分压，内部不分压的方式，软件上通过调用luat_adc_ctrl接口来设置量程为1.2V；
    // 4、不建议同时启动内部分压和外部分压的方式，这样的误差会变大

    // 外部输入电压，超过3.4v的话：
    // 只能采用外部分压，内部不分压的方式，软件上通过调用luat_adc_ctrl接口来设置量程为1.2V；

    // 外部输入电压，不超过3.4V的话：
    // 1、可以采用外部分压，内部不分压的方式，软件上通过调用luat_adc_ctrl接口来设置量程为1.2V；
    // 2、也可以采用内部分压，外部不分压的方式，软件上通过调用luat_adc_ctrl接口来设置量程，设置的量程大于等于实际输入的最大电压，选择最接近的量程即可；
    // 从硬件成本考虑，推荐第2种；
    // 从测量精确度来看，第2种方式，12bit表示设置的最大量程，最大量程/4096为测量精度；第1种方式，根据外部硬件电路，自行计算对比下；

    // 内外部分压选择其中一种即可；不能外部分压时，才选择内部分压；
    // 如果采用外部分压，建议一步到位，外部分压后输入电压在0.1-1.2V范围（内部使用直通模式，不再分压），越靠近1.2V越好，精度越高。
    // 如果采用内部分压，在满足测量要求的前提下，配置的量程越靠近1.2V越好，精度越高。

    // adc默认打开了内部分压，配置的量程为3.8V；
    // 以下三行注释掉的代码设置adc0的量程为1.2V，关闭了内部分压；建议用户采用外部分压；
    // 如果采用外部分压方式，用户可根据自己的需要打开以下三行代码；
    // luat_adc_ctrl_param_t ctrl_param;
	// ctrl_param.range = LUAT_ADC_AIO_RANGE_1_2;
	// luat_adc_ctrl(0, LUAT_ADC_SET_GLOBAL_RANGE, ctrl_param);


    // LUAT_ADC_CH_CPU和LUAT_ADC_CH_VBAT的说明如下：
    // LUAT_ADC_CH_CPU被芯片内部用来检测温度，仅支持软件上open、read和close操作，用户不能做其他用途使用；
    // LUAT_ADC_CH_VBAT被芯片内部用来检测VBAT电压，仅支持软件上open、read和close操作，用户不能做其他用途使用；   

    luat_adc_open(0 , NULL);
    luat_adc_open(1 , NULL);
    luat_adc_open(LUAT_ADC_CH_CPU, NULL);
    luat_adc_open(LUAT_ADC_CH_VBAT, NULL);
    while (1)
    {
        luat_rtos_task_sleep(1000);
        luat_adc_read(0 , &val, &val2);
        LUAT_DEBUG_PRINT("adc0: adc 原始值 %d, 电压 %d 微伏",val, val2);
        luat_adc_read(1 , &val, &val2);
        LUAT_DEBUG_PRINT("adc1: adc 原始值 %d, 电压 %d 微伏",val, val2);
        luat_adc_read(LUAT_ADC_CH_CPU, &val, &val2);
        LUAT_DEBUG_PRINT("temp: adc 原始值 %d, %d 摄氏度",val, val2);
        luat_adc_read(LUAT_ADC_CH_VBAT, &val, &val2);
        LUAT_DEBUG_PRINT("vbat: adc 原始值 %d, 电压 %d 毫伏",val, val2);
    }
    
}

static void task_demo_adc(void)
{
    luat_rtos_task_create(&adc_task_handle, 1024, 20, "adc", task_test_adc, NULL, NULL);
}

INIT_TASK_EXPORT(task_demo_adc,"1");



