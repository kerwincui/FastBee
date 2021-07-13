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
#include "common.h"
#include "smart_config.h"
#include "led.h"
#include "wifi.h"
#include "mqtt.h"
#include "nvs_storage.h"
#include "driver/temp_sensor.h"


char ssid[33]="tp-six";            // wifi的SSID
char pwd[65]="clh15108665817";      // wifi的密码
char owner_id[64]="1";              // 用户ID
    
char open_broken_url[128]="";       // 二次开发mqtt服务器地址
char open_account[64]="";           // 二次开发mqtt账号
char open_pwd[64]="";               // 二次开发mqtt密码
    
uint8_t relay_status=0;             // 继电器状态 0-关闭，1-打开
uint8_t light_status=0;             // 灯的状态 0-关闭 1-打开
uint8_t light_mode=0;               // 颜色模式 0-固定颜色 1-七彩渐变 2-七彩动感 3-单色渐变 4-白光 5-暖光
    
uint8_t is_radar=0;                 // 是否进入雷达感应
uint8_t is_alarm=0;                 // 是否打开报警
uint8_t is_wifi_offline=0;          // 是否离线模式
uint8_t is_open_certifi=0;          // 二次开发是否使用证书
uint8_t is_host=1;                  // 是否托管
uint8_t is_rf_control=1;            // 是否使用RF遥控
uint8_t rf_one_func=1;              // 第一个遥控按键功能，1-继电器通断，2-开关灯，开关雷达，4-报警开关，5-智能配网
uint8_t rf_two_func=2;              // 第二个遥控按键功能
uint8_t rf_three_func=3;            // 第三个遥控按键功能
uint8_t rf_four_func=4;             // 第四个遥控按键功能
    
uint32_t red=255;                      // 红色值 0-255
uint32_t gree=255;                     // 绿色值
uint32_t blue=0;                     // 蓝色值
uint32_t brightness=100;               // 亮度0-100
uint32_t light_interval=1000;       // 颜色闪烁间隔
uint32_t radar_interval=5;          // 雷达开灯持续时间,单位秒
uint32_t fade_time=100;             // 灯渐变时间
    
// 全局变量-不需要存储
char device_num[13]="";             // 设备编号，mac地址
int8_t rssi=-100;                   // wifi信号强度(信号极好4格[-55—— 0]，信号好3格[-70—— -55]，信号一般2格[-85—— -70]，信号差1格[-100—— -85])
uint8_t wifi_status=0;              // wifi连接状态：0-未联网，1-已联网
uint8_t trigger_source=0;           // 触发源：0-无、1-按键、2.手机、3-浏览器、4-射频遥控、5-雷达、6-报警、7-定时
uint8_t is_reset=0;                 // 是否重启
uint8_t is_ap=0;                    // 是否打开AP
uint8_t is_rf_learn=0;              // 遥控配对
uint8_t is_rf_clear=0;              // 遥控清码
uint8_t is_smart_config=0;          // 智能配网
float device_temp=0;                // 设备温度
float air_temperature=0;            // 空气温度
float air_humidity=0;               // 空气湿度

static const char* TAG = "common";


//关闭继电器
void close_relay(void)
{
    ESP_LOGI(TAG, "close relay");
    gpio_set_level(IO_RELAY, 0);
}

//打开继电器
void open_relay(void)
{
    ESP_LOGI(TAG, "open relay");
    gpio_set_level(IO_RELAY, 1);
}

//设备重启
void device_restart(void)
{
    printf("Restarting now...\n");
    mqtt_stop();
    esp_wifi_stop();
    fflush(stdout);
    esp_restart();
}

// 获取AP中的rssi
void get_ap_info(void)
{
    if(wifi_status==1){
        //获取AP信息
        wifi_ap_record_t ap_info;
        esp_wifi_sta_get_ap_info(&ap_info);
        ESP_LOGI(TAG,"ap signal:%4d\n",ap_info.rssi);
        rssi=ap_info.rssi;
    }else{
        rssi=-110;
    }
}

// -----------------------------------------------------------------
// 函数功能: 字节数组转字符串类型
// 函数名称: hexbyte_to_hex_str
// 参数1   : src 源字符串
// 参数2   : obj 目标字节数组
// 说明    : {0x01,0x03,0x03,x04} --> "01020304"
// 返回值  : 1 成功
// -----------------------------------------------------------------
static int hexbyte_to_hex_str (uint8_t *src, char *obj, uint16_t length)
{
	for (int i = 0; i < length; i++)
	{
		sprintf (obj, "%02X", src[i]);
		obj += 2;
	}
	return 1;
}

//获取设备mac地址
void get_device_num(void)
{
    uint8_t base_mac_addr[6] = {0};
    esp_err_t ret = ESP_OK;
    ret=esp_efuse_mac_get_default(base_mac_addr); //获取工厂编程的基本MAC，这是唯一的
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to get base MAC address from EFUSE BLK0. (%s)", esp_err_to_name(ret));
        ESP_LOGE(TAG, "Aborting");
        abort();
    } else {
        ESP_LOGI(TAG, "Base MAC Address read from EFUSE BLK0");
    }
    //获取基本mac地址
    ESP_LOGI(TAG, "Using \"0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x\" as base MAC address",
             base_mac_addr[0], base_mac_addr[1], base_mac_addr[2], base_mac_addr[3], base_mac_addr[4], base_mac_addr[5]);
    
    hexbyte_to_hex_str(base_mac_addr,device_num,sizeof(base_mac_addr));
    device_num[12]='\0';
    ESP_LOGI(TAG,"mac address:%s",device_num);

}



//读取spiffs中的证书
void read_cert(void)
{
    ESP_LOGI(TAG, "Initializing SPIFFS");
    
    esp_vfs_spiffs_conf_t conf = {
      .base_path = "/spiffs",
      .partition_label = NULL,
      .max_files = 5,
      .format_if_mount_failed = true
    };
    
    esp_err_t ret = esp_vfs_spiffs_register(&conf);

    if (ret != ESP_OK) {
        if (ret == ESP_FAIL) {
            ESP_LOGE(TAG, "Failed to mount or format filesystem");
        } else if (ret == ESP_ERR_NOT_FOUND) {
            ESP_LOGE(TAG, "Failed to find SPIFFS partition");
        } else {
            ESP_LOGE(TAG, "Failed to initialize SPIFFS (%s)", esp_err_to_name(ret));
        }
        return;
    }
    
    size_t total = 0, used = 0;
    ret = esp_spiffs_info(conf.partition_label, &total, &used);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to get SPIFFS partition information (%s)", esp_err_to_name(ret));
    } else {
        ESP_LOGI(TAG, "Partition size: total: %d, used: %d", total, used);
    }

    // Open renamed file for reading
    ESP_LOGI(TAG, "Reading file");
    FILE* f = fopen("/spiffs/ca_cert.pem", "r");
    if (f == NULL) {
        ESP_LOGE(TAG, "Failed to open file for reading");
        return;
    }
    char line[256]={0};
    char all_line[2048] ={0};
    printf("sizeof:%d\n",sizeof(line));
    while(fgets(line, sizeof(all_line), f)!=NULL){
        strcat(all_line,line);
        printf("Read from file: '%s'", line);
    }
    fclose(f);

    // All done, unmount partition and disable SPIFFS
    esp_vfs_spiffs_unregister(conf.partition_label);
    ESP_LOGI(TAG, "SPIFFS unmounted");
}

//设备温度初始化
void device_temp_init(void){
    // 初始化触摸板外围设备，它将启动计时器以运行过滤器
    ESP_LOGI(TAG, "Initializing Temperature sensor");
    temp_sensor_config_t temp_sensor = TSENS_CONFIG_DEFAULT();
    temp_sensor_get_config(&temp_sensor);
    ESP_LOGI(TAG, "default dac %d, clk_div %d", temp_sensor.dac_offset, temp_sensor.clk_div);
    temp_sensor.dac_offset = TSENS_DAC_DEFAULT; // 默认: 范围:-10℃ ~  80℃, 错误 < 1℃.
    temp_sensor_set_config(temp_sensor);
    temp_sensor_start();
    ESP_LOGI(TAG, "Temperature sensor started");
    temp_sensor_read_celsius(&device_temp);
    ESP_LOGI(TAG, "Temperature out celsius %f°C", device_temp);
}

// 433接收模块清码
void rf_clear_code(void){
    for(int i=0;i<8;i++)
    {
        gpio_set_level(IO_RF_LEARN_KEY,1);
        vTaskDelay(pdMS_TO_TICKS(100));
        gpio_set_level(IO_RF_LEARN_KEY,0);
        vTaskDelay(pdMS_TO_TICKS(100));
    }
}

// 433接收模块对码
void rf_learn(void){
    gpio_set_level(IO_RF_LEARN_KEY,1);
    vTaskDelay(pdMS_TO_TICKS(100));
    gpio_set_level(IO_RF_LEARN_KEY,0);
}











