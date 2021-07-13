/****************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ****************************************************************************/
#ifndef _NVS_H_ 
#define _NVS_H_


#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_system.h"
#include "nvs_flash.h"
#include "nvs.h"

void read_config_data(); //读取nvs存储的配置信息
void write_config_data(); //写入nvs存储的配置信息


//----------------------------char----------------------------//

//写入wifi的SSID
void write_ssid(void);
//读取wifi的SSID
void read_ssid(void);

//写入wifi密码
void write_pwd(void);
//读取wifi密码
void read_pwd(void);

// 写入用户ID
void write_owner_id(void);
// 读取用户ID
void read_owner_id(void);

// 写入二次开发mqtt地址
void write_open_broken_url(void);
// 读取二次开发mqtt地址
void read_open_broken_url(void);

// 写入二次开发mqtt账号
void write_open_account(void);
// 读取二次开发mqtt账号
void read_open_account(void);

// 写入二次开发mqtt密码
void write_open_pwd(void);
// 读取二次开发mqtt密码
void read_open_pwd(void);

//------------------------uint8-----------------------//

void write_relay_status(void);
void read_relay_status(void);

void write_light_status(void);
void read_light_status(void);

void write_red(void);
void read_red(void);

void write_green(void);
void read_green(void);

void write_blue(void);
void read_blue(void);

void write_light_mode(void);
void read_light_mode(void);

void write_brightness(void);
void read_brightness(void);

void write_is_smart_config(void);
void read_is_smart_config(void);

void write_is_ap(void);
void read_is_ap(void);

void write_is_radar(void);
void read_is_radar(void);

void write_is_alarm(void);
void read_is_alarm(void);

void write_is_wifi_offline(void);
void read_is_wifi_offline(void);

void write_is_open_certifi(void);
void read_is_open_certifi(void);

void write_is_host(void);
void read_is_host(void);

void write_is_rf_control(void);
void read_is_rf_control(void);

void write_rf_one_func(void);
void read_rf_one_func(void);

void write_rf_two_func(void);
void read_rf_two_func(void);

void write_rf_three_func(void);
void read_rf_three_func(void);

void write_rf_four_func(void);
void read_rf_four_func(void);

//----------------------------uint32-----------------------------//

void write_light_interval(void);
void read_light_interval(void);

void write_radar_interval(void);
void read_radar_interval(void);

void write_fade_time(void);
void read_fade_time(void);


#endif
