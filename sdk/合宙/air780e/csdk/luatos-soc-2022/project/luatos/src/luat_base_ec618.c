#include "common_api.h"
#include "luat_base.h"
#include "luat_msgbus.h"
#include "luat_malloc.h"
#include "luat_fs.h"
#include "luat_timer.h"
#include <stdlib.h>
#include "FreeRTOS.h"
#include "task.h"
#include "mbedtls/cipher.h"
#include "mbedtls/sha1.h"
#include "mbedtls/sha256.h"
#include "mbedtls/sha512.h"
#include "mbedtls/md5.h"

#define LUAT_LOG_TAG "base"
#include "luat_log.h"

#ifdef LUAT_USE_LVGL
#include "lvgl.h"
void luat_lv_fs_init(void);
void lv_bmp_init(void);
void lv_png_init(void);
void lv_split_jpeg_init(void);
#endif

static const luaL_Reg loadedlibs[] = {
  {"_G", luaopen_base}, // _G
  {LUA_LOADLIBNAME, luaopen_package}, // require
  {LUA_COLIBNAME, luaopen_coroutine}, // coroutine协程库
  {LUA_TABLIBNAME, luaopen_table},    // table库,操作table类型的数据结构
  {LUA_IOLIBNAME, luaopen_io},        // io库,操作文件
  {LUA_OSLIBNAME, luaopen_os},        // os库,已精简
  {LUA_STRLIBNAME, luaopen_string},   // string库,字符串操作
  {LUA_MATHLIBNAME, luaopen_math},    // math 数值计算
  {LUA_UTF8LIBNAME, luaopen_utf8},
  {LUA_DBLIBNAME, luaopen_debug},     // debug库,已精简
#ifdef LUAT_USE_DBG
#ifndef LUAT_USE_SHELL
#define LUAT_USE_SHELL
#endif
  {"dbg",  luaopen_dbg},               // 调试库
#endif
#if defined(LUA_COMPAT_BITLIB)
  {LUA_BITLIBNAME, luaopen_bit32},    // 不太可能启用
#endif
// 往下是LuatOS定制的库, 如需精简请仔细测试
//----------------------------------------------------------------------
// 核心支撑库, 不可禁用!!
  {"rtos",    luaopen_rtos},              // rtos底层库, 核心功能是队列和定时器
  {"log",     luaopen_log},               // 日志库
  {"timer",   luaopen_timer},             // 延时库
//-----------------------------------------------------------------------
  {"mobile", luaopen_mobile},
  {"sms",    luaopen_sms},
  {"errDump",luaopen_errdump},
#ifdef LUAT_USE_NETWORK
  {"socket", luaopen_socket_adapter},
  {"mqtt", luaopen_mqtt},
  {"websocket", luaopen_websocket},
  {"http", luaopen_http},
#ifdef LUAT_USE_FTP
  {"ftp", luaopen_ftp},
#endif
#endif
#ifdef LUAT_USE_WLAN
  {"wlan", luaopen_wlan},
#endif
// 设备驱动类, 可按实际情况删减. 即使最精简的固件, 也强烈建议保留uart库
#ifdef LUAT_USE_UART
  {"uart",    luaopen_uart},              // 串口操作
#endif
#ifdef LUAT_USE_GPIO
  {"gpio",    luaopen_gpio},              // GPIO脚的操作
#endif
#ifdef LUAT_USE_I2C
  {"i2c",     luaopen_i2c},               // I2C操作
#endif
#ifdef LUAT_USE_SPI
  {"spi",     luaopen_spi},               // SPI操作
#endif
#ifdef LUAT_USE_ADC
  {"adc",     luaopen_adc},               // ADC模块
#endif
#ifdef LUAT_USE_PWM
  {"pwm",     luaopen_pwm},               // PWM模块
#endif
#ifdef LUAT_USE_WDT
  {"wdt",     luaopen_wdt},               // watchdog模块
#endif
#ifdef LUAT_USE_PM
  {"pm",      luaopen_pm},                // 电源管理模块
#endif
#ifdef LUAT_USE_MCU
  {"mcu",     luaopen_mcu},               // MCU特有的一些操作
#endif
#ifdef LUAT_USE_RTC
  {"rtc", luaopen_rtc},                   // 实时时钟
#endif
#ifdef LUAT_USE_OTP
  {"otp", luaopen_otp},                   // OTP
#endif
//-----------------------------------------------------------------------
// 工具库, 按需选用
#ifdef LUAT_USE_CRYPTO
  {"crypto",luaopen_crypto},            // 加密和hash模块
#endif
#ifdef LUAT_USE_CJSON
  {"json",    luaopen_cjson},          // json的序列化和反序列化
#endif
#ifdef LUAT_USE_ZBUFF
  {"zbuff",   luaopen_zbuff},             // 像C语言语言操作内存块
#endif
#ifdef LUAT_USE_PACK
  {"pack",    luaopen_pack},              // pack.pack/pack.unpack
#endif
  // {"mqttcore",luaopen_mqttcore},          // MQTT 协议封装
  // {"libcoap", luaopen_libcoap},           // 处理COAP消息

#ifdef LUAT_USE_LIBGNSS
  {"libgnss", luaopen_libgnss},           // 处理GNSS定位数据
#endif
#ifdef LUAT_USE_FS
  {"fs",      luaopen_fs},                // 文件系统库,在io库之外再提供一些方法
#endif
#ifdef LUAT_USE_SENSOR
  {"sensor",  luaopen_sensor},            // 传感器库,支持DS18B20
#endif
#ifdef LUAT_USE_SFUD
  {"sfud", luaopen_sfud},              // sfud
#endif
#ifdef LUAT_USE_SFD
  {"sfd", luaopen_sfd},              // sfud
#endif
#ifdef LUAT_USE_DISP
  {"disp",  luaopen_disp},              // OLED显示模块
#endif
#ifdef LUAT_USE_U8G2
  {"u8g2", luaopen_u8g2},              // u8g2
#endif

#ifdef LUAT_USE_EINK
  {"eink",  luaopen_eink},              // 电子墨水屏
#endif
#ifdef LUAT_USE_FATFS
  {"fatfs",  luaopen_fatfs},              // SD卡/tf卡
#endif

#ifdef LUAT_USE_LVGL
// #ifndef LUAT_USE_LCD
// #define LUAT_USE_LCD
// #endif
  {"lvgl",   luaopen_lvgl},
#endif

#ifdef LUAT_USE_LCD
  {"lcd",    luaopen_lcd},
#endif
#ifdef LUAT_USE_STATEM
  {"statem",    luaopen_statem},
#endif
#ifdef LUAT_USE_GTFONT
  {"gtfont",    luaopen_gtfont},
#endif
#ifdef LUAT_USE_FSKV
  {"fskv", luaopen_fskv},
// 启用FSKV的时候,自动禁用FDB
#ifdef LUAT_USE_FDB
#undef LUAT_USE_FDB
#endif
#endif
#ifdef LUAT_USE_FDB
  {"fdb",       luaopen_fdb},
#endif
#ifdef LUAT_USE_VMX
  {"vmx",       luaopen_vmx},
#endif
#ifdef LUAT_USE_COREMARK
  {"coremark", luaopen_coremark},
#endif
#ifdef LUAT_USE_FONTS
  {"fonts", luaopen_fonts},
#endif
#ifdef LUAT_USE_ZLIB
  {"zlib", luaopen_zlib},
#endif
#ifdef LUAT_USE_MLX90640
  {"mlx90640", luaopen_mlx90640},
#endif
#ifdef LUAT_USE_IR
  {"ir", luaopen_ir},
#endif
#ifdef LUAT_USE_YMODEM
  {"ymodem", luaopen_ymodem},
#endif
#ifdef LUAT_USE_LORA
  {"lora", luaopen_lora},
#endif
#ifdef LUAT_USE_MINIZ
  {"miniz", luaopen_miniz},
#endif
#ifdef LUAT_USE_PROTOBUF
  {"protobuf", luaopen_protobuf},
#endif
#ifdef LUAT_USE_IOTAUTH
  {"iotauth", luaopen_iotauth},
#endif
#ifdef LUAT_USE_HTTPSRV
  {"httpsrv", luaopen_httpsrv},
#endif
#ifdef LUAT_USE_RSA
  {"rsa", luaopen_rsa},
#endif
#ifdef LUAT_USE_MEDIA
  {"i2s", luaopen_i2s},
  {"audio", luaopen_multimedia_audio},
#ifndef LUAT_USE_TTS
  {"codec", luaopen_multimedia_codec},
#endif
#endif
#ifdef LUAT_USE_HMETA
  {"hmeta", luaopen_hmeta},
#endif
#ifdef LUAT_USE_FOTA
  {"fota", luaopen_fota},
#endif
#ifdef LUAT_USE_PROFILER
  {"profiler", luaopen_profiler},
#endif
  {NULL, NULL}
};

#if MBEDTLS_VERSION_NUMBER >= 0x03000000
#else
void mbedtls_md5( const unsigned char *input,
                  size_t ilen,
                  unsigned char output[16] )
{
    mbedtls_md5_ret( input, ilen, output );
}
#endif

// 按不同的rtconfig加载不同的库函数
void luat_openlibs(lua_State *L) {
    // 初始化队列服务
    luat_msgbus_init();
    //print_list_mem("done>luat_msgbus_init");
    // 加载系统库
    const luaL_Reg *lib;
    /* "require" functions from 'loadedlibs' and set results to global table */
    for (lib = loadedlibs; lib->func; lib++) {
        luaL_requiref(L, lib->name, lib->func, 1);
        lua_pop(L, 1);  /* remove lib */
        //extern void print_list_mem(const char* name);
        //print_list_mem(lib->name);
    }
}

void ResetECSystemReset(void);

void luat_os_reboot(int code){
    (void)code;
    ResetECSystemReset();
}

const char* luat_os_bsp(void) {
    return "EC618";
}

/** 设备进入待机模式 */
void luat_os_standy(int timeout) {
    (void)timeout;
    return; // nop
}

// from reset.h

//void luat_ota_reboot(int timeout_ms) {
//  if (timeout_ms > 0)
//    luat_timer_mdelay(timeout_ms);
//  // nop
//}

uint32_t luat_get_utc(uint32_t *tamp)
{
	uint32_t sec = soc_get_utc();
	if (tamp)
	{
		*tamp = sec;
	}
	return sec;
}

void luat_os_entry_cri(void) {
  portENTER_CRITICAL();
}

void luat_os_exit_cri(void) {
  portEXIT_CRITICAL();
}

// delay_us 是系统函数
extern void delay_us(uint32_t us);
void luat_timer_us_delay(size_t us) {
  if (us > 0)
    delay_us(us);
}

extern void soc_vsprintf(uint8_t no_print, const char *fmt, va_list ap);
void DBG_Printf(const char* fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	soc_vsprintf(0, fmt, ap);
	va_end(ap);
}

extern const uint8_t ByteToAsciiTable[16];
void DBG_HexPrintf(void *Data, unsigned int len)
{
	uint8_t *data = (uint8_t *)Data;
	uint8_t *uart_buf;
    uint32_t i,j;
    j = 0;
    if (!len) return;
    uart_buf = luat_heap_malloc(len * 3 + 2);
    if (!uart_buf) return;
    memset(uart_buf, 0, len * 3 + 2);
    for (i = 0; i < len; i++){
		uart_buf[j++] = ByteToAsciiTable[(data[i] & 0xf0) >> 4];
		uart_buf[j++] = ByteToAsciiTable[data[i] & 0x0f];
		uart_buf[j++] = ' ';
    }
    uart_buf[j++] = '\r';
    uart_buf[j++] = '\n';
	luat_log_write((char*)uart_buf, len * 3 + 2);
	luat_heap_free(uart_buf);
}

struct tm *mbedtls_platform_gmtime_r( const mbedtls_time_t *tt,
                                      struct tm *tm_buf )
{
	Date_UserDataStruct Date;
	Time_UserDataStruct Time;
	Tamp2UTC(*tt, &Date, &Time, 0);
	tm_buf->tm_year = Date.Year - 1900;
	tm_buf->tm_mon = Date.Mon - 1;
	tm_buf->tm_mday = Date.Day;
	tm_buf->tm_hour = Time.Hour;
	tm_buf->tm_min = Time.Min;
	tm_buf->tm_sec = Time.Sec;
	return tm_buf;

}

#include "osasys.h"

time_t luat_time(time_t *_Time) {
  utc_timer_value_t *timeUtc = OsaSystemTimeReadUtc();
  if (_Time != NULL) {
    *_Time = timeUtc->UTCsecs;
  }
  return timeUtc->UTCsecs;
}
