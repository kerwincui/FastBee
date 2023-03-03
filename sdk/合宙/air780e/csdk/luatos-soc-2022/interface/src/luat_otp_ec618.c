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

#include "luat_base.h"
#include "luat_otp.h"

// EC618提供的头文件没有OTP相关的API, 以下调用的均为隐藏API
typedef enum
{
    FLASH_OTP_ERASE = 0,
    FLASH_OTP_WRITE,
    FLASH_OTP_READ,
    FLASH_OTP_LOCK
}FLASH_OTP_OPS;

uint8_t QSPI_FLASH_OTP_Handle(FLASH_OTP_OPS opType, uint32_t addr, uint8_t* bufPtr, uint8_t length);

int luat_otp_read(int zone, char* buff, size_t offset, size_t len) {
    uint8_t ret = 0;
    if (zone >= 1 && zone <= 3) {
        ret = QSPI_FLASH_OTP_Handle(FLASH_OTP_READ, ((uint32_t)zone << 16) + (offset), (uint8_t*)buff, len);
        if (ret == 0) {
            return (offset + len) > luat_otp_size(zone) ? luat_otp_size(zone) - offset : len;
        }
        return 0;
    }
    return -1;
}

int luat_otp_write(int zone, char* buff, size_t offset, size_t len) {
    uint8_t ret = 0;
    if (zone >= 1 && zone <= 3) {
        ret = QSPI_FLASH_OTP_Handle(FLASH_OTP_WRITE, ((uint32_t)zone << 16) + (offset), (uint8_t*)buff, len);
        if (ret == 0) {
            return (offset + len) > luat_otp_size(zone) ? luat_otp_size(zone) - offset : len;
        }
        return 0;
    }
    return -1;
}

int luat_otp_erase(int zone, size_t offset, size_t len) {
    if (zone >= 1 && zone <= 3) {
        return QSPI_FLASH_OTP_Handle(FLASH_OTP_ERASE, (uint32_t)zone << 16, NULL, 0);
    }
    return -1;
}

int luat_otp_lock(int zone) {
    if (zone >= 1 && zone <= 3) {
        return QSPI_FLASH_OTP_Handle(FLASH_OTP_LOCK, (uint32_t)zone << 16, NULL, 0);
    }
    return -1;
}

int luat_otp_size(int zone) {
    if (zone >= 1 && zone <= 3) {
        return 256;
    }
    return 0;
}
