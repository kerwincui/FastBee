/*
 * ESPRESSIF MIT License
 *
 * Copyright (c) 2019 <ESPRESSIF SYSTEMS (SHANGHAI) PTE LTD>
 *
 * Permission is hereby granted for use on all ESPRESSIF SYSTEMS products, in which case,
 * it is free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the Software is furnished
 * to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 */
#include <stdio.h>
#include <sdkconfig.h>

#ifdef CONFIG_IDF_TARGET_ESP8266
#include "driver/pwm.h"
#else
#include "driver/ledc.h"
#endif
#include "esp_log.h"

typedef struct rgb {
    uint8_t r;  // 0-100 %
    uint8_t g;  // 0-100 %
    uint8_t b;  // 0-100 %
} rgb_t;


typedef struct hsp {
    uint16_t h;  // 0-360
    uint16_t s;  // 0-100
    uint16_t b;  // 0-100
} hsp_t;

/* LED numbers below are for ESP-WROVER-KIT */
/* Red LED */
#define LEDC_IO_0 (0)
/* Green LED */
#define LEDC_IO_1 (2)
/* Blued LED */
#define LEDC_IO_2 (4)

#define PWM_DEPTH (1023)
#define PWM_TARGET_DUTY 8192

static hsp_t s_hsb_val;
static uint16_t s_brightness;
static bool s_on = false;

static const char *TAG = "lightbulb";

#ifdef CONFIG_IDF_TARGET_ESP8266
#define PWM_PERIOD    (500)
#define PWM_IO_NUM    3

// pwm pin number
const uint32_t pin_num[PWM_IO_NUM] = {
    LEDC_IO_0,
    LEDC_IO_1,
    LEDC_IO_2
};

// dutys table, (duty/PERIOD)*depth
uint32_t duties[PWM_IO_NUM] = {
    250, 250, 250,
};

// phase table, (phase/180)*depth
int16_t phase[PWM_IO_NUM] = {
    0, 0, 50,
};

#define LEDC_CHANNEL_0 0
#define LEDC_CHANNEL_1 1
#define LEDC_CHANNEL_2 2

#endif

/**
 * @brief transform lightbulb's "RGB" and other parameter
 */
static void lightbulb_set_aim(uint32_t r, uint32_t g, uint32_t b, uint32_t cw, uint32_t ww, uint32_t period)
{
#ifdef CONFIG_IDF_TARGET_ESP8266
    pwm_stop(0x3);
    pwm_set_duty(LEDC_CHANNEL_0, r);
    pwm_set_duty(LEDC_CHANNEL_1, g);
    pwm_set_duty(LEDC_CHANNEL_2, b);
    pwm_start();
#else
    ledc_set_duty(LEDC_LOW_SPEED_MODE, LEDC_CHANNEL_0, r);
    ledc_set_duty(LEDC_LOW_SPEED_MODE, LEDC_CHANNEL_1, g);
    ledc_set_duty(LEDC_LOW_SPEED_MODE, LEDC_CHANNEL_2, b);
    ledc_update_duty(LEDC_LOW_SPEED_MODE, LEDC_CHANNEL_0);
    ledc_update_duty(LEDC_LOW_SPEED_MODE, LEDC_CHANNEL_1);
    ledc_update_duty(LEDC_LOW_SPEED_MODE, LEDC_CHANNEL_2);
#endif
}

/**
 * @brief transform lightbulb's "HSV" to "RGB"
 */
static bool lightbulb_set_hsb2rgb(uint16_t h, uint16_t s, uint16_t v, rgb_t *rgb)
{
    bool res = true;
    uint16_t hi, F, P, Q, T;

    if (!rgb)
        return false;

    if (h > 360) return false;
    if (s > 100) return false;
    if (v > 100) return false;

    hi = (h / 60) % 6;
    F = 100 * h / 60 - 100 * hi;
    P = v * (100 - s) / 100;
    Q = v * (10000 - F * s) / 10000;
    T = v * (10000 - s * (100 - F)) / 10000;

    switch (hi) {
    case 0:
        rgb->r = v;
        rgb->g = T;
        rgb->b = P;
        break;
    case 1:
        rgb->r = Q;
        rgb->g = v;
        rgb->b = P;
        break;
    case 2:
        rgb->r = P;
        rgb->g = v;
        rgb->b = T;
        break;
    case 3:
        rgb->r = P;
        rgb->g = Q;
        rgb->b = v;
        break;
    case 4:
        rgb->r = T;
        rgb->g = P;
        rgb->b = v;
        break;
    case 5:
        rgb->r = v;
        rgb->g = P;
        rgb->b = Q;
        break;
    default:
        return false;
    }
    return res;
}

/**
 * @brief set the lightbulb's "HSV"
 */
static bool lightbulb_set_aim_hsv(uint16_t h, uint16_t s, uint16_t v)
{
    rgb_t rgb_tmp;
    bool ret = lightbulb_set_hsb2rgb(h, s, v, &rgb_tmp);

    if (ret == false)
        return false;

    lightbulb_set_aim(rgb_tmp.r * PWM_TARGET_DUTY / 100, rgb_tmp.g * PWM_TARGET_DUTY / 100,
            rgb_tmp.b * PWM_TARGET_DUTY / 100, (100 - s) * 5000 / 100, v * 2000 / 100, 1000);

    return true;
}

/**
 * @brief update the lightbulb's state
 */
static void lightbulb_update()
{
    lightbulb_set_aim_hsv(s_hsb_val.h, s_hsb_val.s, s_hsb_val.b);
}


/**
 * @brief initialize the lightbulb lowlevel module
 */
void lightbulb_init(void)
{
#ifdef CONFIG_IDF_TARGET_ESP8266
    pwm_init(PWM_PERIOD, duties, PWM_IO_NUM, pin_num);
    pwm_set_channel_invert(0x1 << 0);
    pwm_set_phases(phase);
    pwm_start();
#else
    // enable ledc module
    periph_module_enable(PERIPH_LEDC_MODULE);

    // config the timer
    ledc_timer_config_t ledc_timer = {
        //set timer counter bit number
        .bit_num = LEDC_TIMER_13_BIT,
        //set frequency of pwm
        .freq_hz = 5000,
        //timer mode,
        .speed_mode = LEDC_LOW_SPEED_MODE,
        //timer index
        .timer_num = LEDC_TIMER_0
    };
    ledc_timer_config(&ledc_timer);

    //config the channel
    ledc_channel_config_t ledc_channel = {
        //set LEDC channel 0
        .channel = LEDC_CHANNEL_0,
        //set the duty for initialization.(duty range is 0 ~ ((2**bit_num)-1)
        .duty = 100,
        //GPIO number
        .gpio_num = LEDC_IO_0,
        //GPIO INTR TYPE, as an example, we enable fade_end interrupt here.
        .intr_type = LEDC_INTR_FADE_END,
        //set LEDC mode, from ledc_mode_t
        .speed_mode = LEDC_LOW_SPEED_MODE,
        //set LEDC timer source, if different channel use one timer,
        //the frequency and bit_num of these channels should be the same
        .timer_sel = LEDC_TIMER_0
    };
    //set the configuration
    ledc_channel_config(&ledc_channel);

    //config ledc channel1
    ledc_channel.channel = LEDC_CHANNEL_1;
    ledc_channel.gpio_num = LEDC_IO_1;
    ledc_channel_config(&ledc_channel);
    //config ledc channel2
    ledc_channel.channel = LEDC_CHANNEL_2;
    ledc_channel.gpio_num = LEDC_IO_2;
    ledc_channel_config(&ledc_channel);
#endif
}

/**
 * @brief deinitialize the lightbulb's lowlevel module
 */
void lightbulb_deinit(void)
{
#ifdef CONFIG_IDF_TARGET_ESP8266
#else
    ledc_stop(LEDC_LOW_SPEED_MODE, LEDC_CHANNEL_0, 0);
    ledc_stop(LEDC_LOW_SPEED_MODE, LEDC_CHANNEL_1, 0);
    ledc_stop(LEDC_LOW_SPEED_MODE, LEDC_CHANNEL_2, 0);
#endif
}

/**
 * @brief turn on/off the lowlevel lightbulb
 */
int lightbulb_set_on(bool value)
{
    ESP_LOGI(TAG, "lightbulb_set_on : %s", value == true ? "true" : "false");

    if (value == true) {
        s_hsb_val.b = s_brightness;
        s_on = true;
    } else {
        s_brightness = s_hsb_val.b;
        s_hsb_val.b = 0;
        s_on = false;
    }
    lightbulb_update();

    return 0;
}

/**
 * @brief set the saturation of the lowlevel lightbulb
 */
int lightbulb_set_saturation(float value)
{
    ESP_LOGI(TAG, "lightbulb_set_saturation : %f", value);

    s_hsb_val.s = value;
    if (true == s_on)
        lightbulb_update();

    return 0;
}

/**
 * @brief set the hue of the lowlevel lightbulb
 */
int lightbulb_set_hue(float value)
{
    ESP_LOGI(TAG, "lightbulb_set_hue : %f", value);

    s_hsb_val.h = value;
    if (true == s_on)
        lightbulb_update();

    return 0;
}

/**
 * @brief set the brightness of the lowlevel lightbulb
 */
int lightbulb_set_brightness(int value)
{
    ESP_LOGI(TAG, "lightbulb_set_brightness : %d", value);

    s_hsb_val.b = value;
    s_brightness = s_hsb_val.b; 
    if (true == s_on)
        lightbulb_update();

    return 0;
}
