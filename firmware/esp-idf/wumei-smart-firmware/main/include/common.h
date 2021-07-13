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
#ifndef _COMMON_H_ 
#define _COMMON_H_


#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_system.h"
#include "nvs_flash.h"
#include "nvs.h"
#include "freertos/queue.h"
#include "freertos/timers.h"
#include <freertos/semphr.h>
#include "driver/gpio.h"
#include "driver/ledc.h"
#include "unity.h"
#include "iot_button.h"
#include "esp_system.h"
#include "esp_log.h"
#include "esp_err.h"
#include "driver/gpio.h"
#include <string.h>
#include <sys/unistd.h>
#include <sys/stat.h>
#include "esp_spiffs.h"

#define IO_SENSOR_SCL      1   // IIC-SCL
#define IO_SENSOR_SDA      2   // IIC-SDA
#define IO_RADAR_OUT       3   // 雷达模块输入
#define IO_RADAR_CDS       4   // 雷达模块CDS
#define IO_RELAY           5   // 继电器


// 电源灯：红色（接通电源）、 绿色（已经联网）、蓝色闪烁（智能配网，长按配网按钮2s进入）、黄色闪烁（遥控学习，长按配置按钮5s进入）
// 接收消息和发送消息时、mqtt连接成功 蓝色灯闪烁一次
#define IO_LED_R            11
#define IO_LED_G            12
#define IO_LED_B            13

#define IO_SWITCH_BUTTON          15    // 短按开关、连续短按断网/联网、长按3s重启

#define IO_RF_RECEIVER_D          19    // 433M射频遥控接收
#define IO_RF_RECEIVER_C          20
#define IO_RF_RECEIVER_B          21
#define IO_RF_RECEIVER_A          26
#define IO_RF_LEARN_KEY           33    // RF遥控学习

#define OTA_DIAGNOSTIC            35    // ota升级回滚确认引脚

// #define BROKEN_URL               "mqtt://wumei.live:1883"
#define BROKEN_URL               "mqtt://wumei.live:1884"
#define BROKEN_SSL_URL           "mqtts://test.mosquitto.org:8884"
#define BROKEN_ADMIN             "admin"
#define BROKEN_PWD               "admin"
#define VERSION                  "1.0"
#define CATEGORY                 1  //1-wifi通断器,2-智能灯,3-智能门锁,4-智能水阀


char ssid[33];                // wifi的SSID
char pwd[65];                 // wifi的密码
char owner_id[64];            // 用户ID

char open_broken_url[128];    // 二次开发mqtt服务器地址
char open_account[64];        // 二次开发mqtt账号
char open_pwd[64];            // 二次开发mqtt密码

uint8_t relay_status;         // 继电器状态 0-关闭，1-打开
uint8_t light_status;         // 灯的状态 0-关闭 1-打开
uint8_t light_mode;           // 颜色模式 0-固定颜色 1-七彩渐变 2-七彩动感 3-单色渐变 4-白光 5-暖光

uint8_t is_radar;             // 是否进入雷达感应
uint8_t is_alarm;             // 是否打开报警
uint8_t is_wifi_offline;      // 是否离线模式
uint8_t is_open_certifi;      // 二次开发是否使用证书
uint8_t is_host;              // 是否托管
uint8_t is_rf_control;        // 是否使用RF遥控
uint8_t rf_one_func;          // 第一个遥控按键功能，1-继电器通断，2-开关灯，开关雷达，4-报警开关，5-智能配网
uint8_t rf_two_func;          // 第二个遥控按键功能
uint8_t rf_three_func;        // 第三个遥控按键功能
uint8_t rf_four_func;         // 第四个遥控按键功能

uint32_t red;                  // 红色值
uint32_t green;                // 绿色值
uint32_t blue;                 // 蓝色值
uint32_t brightness;           // 亮度0-100
uint32_t light_interval;      // 颜色闪烁间隔
uint32_t radar_interval;      // 雷达开灯持续时间,单位秒
uint32_t fade_time;           // 灯渐变时间

// 全局变量-不需要存储
char device_num[13];          // 设备编号，mac地址
int8_t rssi;                  // wifi信号强度(信号极好4格[-55—— 0]，信号好3格[-70—— -55]，信号一般2格[-85—— -70]，信号差1格[-100—— -85])
uint8_t wifi_status;          // wifi连接状态：0-未联网，1-已联网
uint8_t trigger_source;       // 触发源：0-无、1-按键、2.手机、3-浏览器、4-射频遥控、5-雷达、6-报警、7-定时
uint8_t is_reset;             // 是否重启
uint8_t is_ap;                // 是否打开AP
uint8_t is_rf_learn;          // 遥控配对
uint8_t is_rf_clear;          // 遥控清码
uint8_t is_smart_config;      // 智能配网
float device_temp;            // 设备温度
float air_temperature;        // 空气温度
float air_humidity;           // 空气湿度

// 设备重启
void device_restart(void);
// 获取设备编号
void get_device_num(void);
//设备温度初始化
void device_temp_init(void);
// 读取证书
void read_cert(void);
// 打开继电器
void open_relay(void);
//关闭继电器
void close_relay(void);
// 获取rssi
void get_ap_info(void);
// 433接收模块清码
void rf_clear_code(void);
// 433接收模块对码
void rf_learn(void);


#endif
