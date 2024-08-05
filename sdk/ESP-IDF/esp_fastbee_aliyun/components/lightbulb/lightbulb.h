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
#ifndef _LIGHTBULB_H_
#define _LIGHTBULB_H_

#include <stdbool.h>

/**
 * @brief initialize the lightbulb lowlevel module
 *
 * @param none
 *
 * @return none
 */
void lightbulb_init(void);

/**
 * @brief deinitialize the lightbulb's lowlevel module
 *
 * @param none
 *
 * @return none
 */
void lightbulb_deinit(void);

/**
 * @brief turn on/off the lowlevel lightbulb
 *
 * @param value The "On" value
 *
 * @return none
 */
int lightbulb_set_on(bool value);

/**
 * @brief set the saturation of the lowlevel lightbulb
 *
 * @param value The Saturation value
 *
 * @return 
 *     - 0 : OK
 *     - others : fail
 */
int lightbulb_set_saturation(float value);

/**
 * @brief set the hue of the lowlevel lightbulb
 *
 * @param value The Hue value
 *
 * @return 
 *     - 0 : OK
 *     - others : fail
 */
int lightbulb_set_hue(float value);

/**
 * @brief set the brightness of the lowlevel lightbulb
 *
 * @param value The Brightness value
 *
 * @return 
 *     - 0 : OK
 *     - others : fail
 */
int lightbulb_set_brightness(int value);

#endif /* _LIGHTBULB_H_ */
