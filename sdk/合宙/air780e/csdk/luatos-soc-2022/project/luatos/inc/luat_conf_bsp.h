
#ifndef LUAT_CONF_BSP
#define LUAT_CONF_BSP

#define LUAT_BSP_VERSION "V1003"

// 启用64位虚拟机
// #define LUAT_CONF_VM_64bit

//-----------------------------
// 内存配置, 默认200k, 128 ~ 300k 可调
// 一般无需修改. 若不需要使用SSL/TLS/TTS,可适当增加,但不应该超过300k
//#define LUAT_HEAP_SIZE (200*1024)
//-----------------------------

//------------------------------------------------------
// 以下custom --> 到  <-- custom 之间的内容,是供用户配置的
// 同时也是云编译可配置的部分. 提交代码时切勿删除会修改标识
//custom -->
//------------------------------------------------------

// 外设,按需启用, 最起码启用uart和wdt库
#define LUAT_USE_UART 1
#define LUAT_USE_GPIO 1
#define LUAT_USE_I2C  1
#define LUAT_USE_SPI  1
#define LUAT_USE_ADC  1
#define LUAT_USE_PWM  1
#define LUAT_USE_WDT  1
#define LUAT_USE_PM  1
#define LUAT_USE_MCU  1
#define LUAT_USE_RTC 1
#define LUAT_USE_OTP 1

#define LUAT_USE_HMETA 1

#define LUAT_USE_IOTAUTH 1
#define LUAT_USE_WEBSOCKET 1

//----------------------------
// 常用工具库, 按需启用, cjson和pack是强烈推荐启用的
#define LUAT_USE_CRYPTO  1
#define LUAT_USE_CJSON  1
#define LUAT_USE_ZBUFF  1
#define LUAT_USE_PACK  1
#define LUAT_USE_LIBGNSS  1
#define LUAT_USE_FS  1
#define LUAT_USE_SENSOR  1
#define LUAT_USE_SFUD  1
// #define LUAT_USE_SFD   1
// #define LUAT_USE_STATEM 1
// 性能测试
//#define LUAT_USE_COREMARK 1
#define LUAT_USE_IR 1
// FDB 提供kv数据库, 与nvm库类似
#define LUAT_USE_FDB 1
// fskv提供与fdb兼容的API,旨在替代fdb库
#define LUAT_USE_FSKV 1
#define LUAT_USE_I2CTOOLS 1
#define LUAT_USE_LORA 1
// #define LUAT_USE_MLX90640 1
// zlib压缩,更快更小的实现
#define LUAT_USE_MINIZ 1
#define LUAT_USE_SNTP 1
#define LUAT_USE_FTP 1

#define LUAT_USE_WLAN 1
#define LUAT_USE_WLAN_SCANONLY 1

//---------------SDIO-FATFS特别配置
// sdio库对接的是fatfs
// fatfs的长文件名和非英文文件名支持需要180k的ROM, 非常奢侈
// #define LUAT_USE_FATFS
// #define FF_USE_LFN 3
// #define FF_LFN_UNICODE 3

#define LUAT_USE_PROFILER 1

//----------------------------
// 高通字体, 需配合芯片使用
#define LUAT_USE_GTFONT 1
// #define LUAT_USE_GTFONT_UTF8

//----------------------------
// 高级功能, 其中shell是推荐启用, 除非你打算uart0也读数据
// #define LUAT_USE_SHELL 1
// #define LUAT_USE_DBG
// 多虚拟机支持,实验性,一般不启用
// #define LUAT_USE_VMX 1
#define LUAT_USE_PROTOBUF 1

#define LUAT_USE_RSA      1
#define LUAT_USE_MEDIA    1
// #define LUAT_USE_TTS    1
//---------------------
// UI
// LCD  是彩屏, 若使用LVGL就必须启用LCD
#define LUAT_USE_LCD
#define LUAT_USE_TJPGD
// EINK 是墨水屏
#define LUAT_USE_EINK

//---------------------
// U8G2
// 单色屏, 支持i2c/spi
// #define LUAT_USE_DISP
#define LUAT_USE_U8G2

/**************FONT*****************/
#define LUAT_USE_FONTS
/**********U8G2&LCD&EINK FONT*************/
#define USE_U8G2_OPPOSANSM_ENGLISH 1
// #define USE_U8G2_OPPOSANSM8_CHINESE
// #define USE_U8G2_OPPOSANSM10_CHINESE
// #define USE_U8G2_OPPOSANSM12_CHINESE
// #define USE_U8G2_OPPOSANSM16_CHINESE
// #define USE_U8G2_OPPOSANSM24_CHINESE
// #define USE_U8G2_OPPOSANSM32_CHINESE
/**********LVGL FONT*************/
// #define LV_FONT_OPPOSANS_M_8
// #define LV_FONT_OPPOSANS_M_10
// #define LV_FONT_OPPOSANS_M_12
// #define LV_FONT_OPPOSANS_M_16

//---------------------
// LVGL
// 主推的UI库, 功能强大但API繁琐
//#define LUAT_USE_LVGL

#define LUAT_USE_LVGL_ARC   //圆弧 无依赖
#define LUAT_USE_LVGL_BAR   //进度条 无依赖
#define LUAT_USE_LVGL_BTN   //按钮 依赖容器CONT
#define LUAT_USE_LVGL_BTNMATRIX   //按钮矩阵 无依赖
#define LUAT_USE_LVGL_CALENDAR   //日历 无依赖
#define LUAT_USE_LVGL_CANVAS   //画布 依赖图片IMG
#define LUAT_USE_LVGL_CHECKBOX   //复选框 依赖按钮BTN 标签LABEL
#define LUAT_USE_LVGL_CHART   //图表 无依赖
#define LUAT_USE_LVGL_CONT   //容器 无依赖
#define LUAT_USE_LVGL_CPICKER   //颜色选择器 无依赖
#define LUAT_USE_LVGL_DROPDOWN   //下拉列表 依赖页面PAGE 标签LABEL
#define LUAT_USE_LVGL_GAUGE   //仪表 依赖进度条BAR 仪表(弧形刻度)LINEMETER
#define LUAT_USE_LVGL_IMG   //图片 依赖标签LABEL
#define LUAT_USE_LVGL_IMGBTN   //图片按钮 依赖按钮BTN
#define LUAT_USE_LVGL_KEYBOARD   //键盘 依赖图片按钮IMGBTN
#define LUAT_USE_LVGL_LABEL   //标签 无依赖
#define LUAT_USE_LVGL_LED   //LED 无依赖
#define LUAT_USE_LVGL_LINE   //线 无依赖
#define LUAT_USE_LVGL_LIST   //列表 依赖页面PAGE 按钮BTN 标签LABEL
#define LUAT_USE_LVGL_LINEMETER   //仪表(弧形刻度) 无依赖
#define LUAT_USE_LVGL_OBJMASK   //对象蒙版 无依赖
#define LUAT_USE_LVGL_MSGBOX   //消息框 依赖图片按钮IMGBTN 标签LABEL
#define LUAT_USE_LVGL_PAGE   //页面 依赖容器CONT
#define LUAT_USE_LVGL_SPINNER   //旋转器 依赖圆弧ARC 动画ANIM
#define LUAT_USE_LVGL_ROLLER   //滚筒 无依赖
#define LUAT_USE_LVGL_SLIDER   //滑杆 依赖进度条BAR
#define LUAT_USE_LVGL_SPINBOX   //数字调整框 无依赖
#define LUAT_USE_LVGL_SWITCH   //开关 依赖滑杆SLIDER
#define LUAT_USE_LVGL_TEXTAREA   //文本框 依赖标签LABEL 页面PAGE
#define LUAT_USE_LVGL_TABLE   //表格 依赖标签LABEL
#define LUAT_USE_LVGL_TABVIEW   //页签 依赖页面PAGE 图片按钮IMGBTN
#define LUAT_USE_LVGL_TILEVIEW   //平铺视图 依赖页面PAGE
#define LUAT_USE_LVGL_WIN   //窗口 依赖容器CONT 按钮BTN 标签LABEL 图片IMG 页面PAGE

//-------------------------------------------------------------------------------
//<-- custom
//------------------------------------------------------------------------------

// 以下选项仅开发人员可修改, 一般用户切勿自行修改

#define LUAT_COMPILER_NOWEAK
#define LUAT_GPIO_PIN_MAX 36

// 内存优化: 减少内存消耗, 会稍微减低性能
#define LUAT_USE_MEMORY_OPTIMIZATION_CODE_MMAP 1

//----------------------------------
// 使用VFS(虚拟文件系统)和内置库文件, 必须启用
#define LUAT_USE_FS_VFS 1
#define LUAT_USE_VFS_INLINE_LIB 1
#define LUA_USE_VFS_FILENAME_OFFSET 1
//----------------------------------

#define LV_DISP_DEF_REFR_PERIOD 30
#define LUAT_LV_DEBUG 0

#define LV_MEM_CUSTOM 1

#define LUAT_USE_LVGL_INDEV 1 // 输入设备

#define LV_HOR_RES_MAX          (160)
#define LV_VER_RES_MAX          (80)
#define LV_COLOR_DEPTH          16

#define LV_COLOR_16_SWAP   1
#define __LVGL_SLEEP_ENABLE__

#undef LV_DISP_DEF_REFR_PERIOD
#define LV_DISP_DEF_REFR_PERIOD g_lvgl_flash_time
extern unsigned int g_lvgl_flash_time;

#define LV_TICK_CUSTOM 1
#define LV_TICK_CUSTOM_INCLUDE  "common_api.h"         /*Header for the system time function*/
#define LV_TICK_CUSTOM_SYS_TIME_EXPR ((uint32_t)GetSysTickMS())     /*Expression evaluating to current system time in ms*/

#define LUAT_LOG_NO_NEWLINE
#define __LUATOS_TICK_64BIT__

#define LUAT_RET int
#define LUAT_RT_RET_TYPE	void
#define LUAT_RT_CB_PARAM void *param

#define time(X)	luat_time(X)

#define LUAT_USE_NETWORK 1
#define LUAT_USE_TLS 1
#define LUAT_USE_LWIP 1
#define LUAT_USE_DNS 1
#define LUAT_USE_ERR_DUMP 1
#define LUAT_USE_DHCP  1
#define LUAT_USE_ERRDUMP 1
#define LUAT_USE_FOTA 1

//目前没用到的宏，但是得写在这里
//#define LUAT_USE_MOBILE

#define LUA_SCRIPT_ADDR (FLASH_FOTA_REGION_START - 732 * 1024)
#define LUA_SCRIPT_OTA_ADDR (FLASH_FOTA_REGION_START - 284 * 1024)

#ifdef LUAT_USE_TTS
#undef LUAT_USE_SFUD
#define LUAT_USE_SFUD  1
#undef LUAT_USE_LCD
#undef LUAT_USE_TJPGD
#undef LUAT_USE_LORA
#undef LUAT_USE_IR
#undef USE_U8G2_OPPOSANSM_ENGLISH
#undef LUAT_USE_EINK
#define LUAT_USE_TTS_16K 1

#endif

#endif
