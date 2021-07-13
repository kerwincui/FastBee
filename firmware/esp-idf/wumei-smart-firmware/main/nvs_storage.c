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
#include "nvs_storage.h"
#include "common.h"
#include <string.h>


static const char *TAG = "nvs";

//读取字符数据
static esp_err_t nvs_read_str(const char *key,char *out_value)
{  
    nvs_handle_t read_handle;
    esp_err_t err;
 
    err = nvs_open("wificonfig", NVS_READWRITE, &read_handle);
    if (err != ESP_OK) {
        ESP_LOGE( TAG,"Error (%s) opening NVS handle! key=%s", esp_err_to_name(err),key);
    } 
    else 
    {
        size_t required_size = 0;  
        err = nvs_get_str(read_handle, key, NULL, &required_size);
        if (err != ESP_OK && err != ESP_ERR_NVS_NOT_FOUND) return err;
        if (required_size == 0) {
            ESP_LOGI( TAG,"Nothing saved yet! key=%s",key);
        } else {
            err = nvs_get_str(read_handle, key, out_value, &required_size);
            if(err==ESP_OK)
            {
                ESP_LOGI( TAG, "Get %s success!",key);
            }
            else
            {
                ESP_LOGI( TAG, "get err =0x%x",err);
                ESP_LOGI( TAG, "Get %s fail!",key);
            }
        }

        err = nvs_commit(read_handle);
        if(err!= ESP_OK){
            ESP_LOGE(TAG,"nvs_commit Failed!");
        }else{
            ESP_LOGI(TAG," nvs_commit Done");
        }
    }
    // 关闭
    nvs_close(read_handle);
    return ESP_OK;
}

//读取uint8数据
static esp_err_t nvs_read_u8(const char *key,uint8_t *out_value)
{  
    nvs_handle_t read_handle;
    esp_err_t err;
 
    err = nvs_open("wificonfig", NVS_READWRITE, &read_handle);
    if (err != ESP_OK) {
        ESP_LOGE( TAG, "Error (%s) opening NVS handle! key=%s", esp_err_to_name(err),key);
    } 
    else 
    {
        err = nvs_get_u8(read_handle, key, out_value);
        if(err==ESP_OK)
        {
             ESP_LOGI( TAG, "Get %s success!",key);
        }
        else
        {
             ESP_LOGI( TAG, "get err =0x%x",err);
             ESP_LOGI( TAG, "Get %s fail!",key);
        } 
        err = nvs_commit(read_handle);
        if(err!= ESP_OK){
            ESP_LOGE(TAG,"nvs_commit Failed!");
        }else{
            ESP_LOGI(TAG," nvs_commit Done");
        }
    }
    // 关闭
    nvs_close(read_handle);
    return ESP_OK;
}

//读取uint32数据
static esp_err_t nvs_read_u32(const char *key,uint32_t *out_value)
{  
    nvs_handle_t read_handle;
    esp_err_t err;
 
    err = nvs_open("wificonfig", NVS_READWRITE, &read_handle);
    if (err != ESP_OK) {
         ESP_LOGE( TAG, "Error (%s) opening NVS handle! key=%s", esp_err_to_name(err),key);
    } 
    else 
    {
        err = nvs_get_u32(read_handle, key, out_value);
        if(err==ESP_OK)
        {
             ESP_LOGI( TAG, "Get %s success!",key);
        }
        else
        {
             ESP_LOGI( TAG, "get err =0x%x",err);
             ESP_LOGI( TAG, "Get %s fail!",key);
        } 
        err = nvs_commit(read_handle);
        if(err!= ESP_OK){
            ESP_LOGE(TAG,"nvs_commit Failed!");
        }else{
            ESP_LOGI(TAG," nvs_commit Done");
        }
    }
    // 关闭
    nvs_close(read_handle);
    return ESP_OK;
}


//写入字符数据
static void nvs_write_str(const char *key, const char *value)
{
    nvs_handle_t write_handle;    
    esp_err_t err;  
    err = nvs_open("wificonfig", NVS_READWRITE, &write_handle);
    if (err != ESP_OK) {
         ESP_LOGE( TAG, "Error (%s) opening NVS handle! key=%s", esp_err_to_name(err),key);
    } 
    else 
    {
        err=nvs_set_str(write_handle,key,value);
        if(err==ESP_OK)
             ESP_LOGI( TAG, "set %s success!",key);
        else
        {
             ESP_LOGI( TAG, "set %s fail!",key);
        }  
        err = nvs_commit(write_handle);
        if(err!= ESP_OK){
            ESP_LOGE(TAG,"nvs_commit Failed!");
        }else{
            ESP_LOGI(TAG," nvs_commit Done");
        }
    }
    nvs_close(write_handle);
}

//写入uint8数据
static void nvs_write_u8(const char *key, uint8_t value)
{
    nvs_handle_t write_handle;    
    esp_err_t err;  
    err = nvs_open("wificonfig", NVS_READWRITE, &write_handle);
    if (err != ESP_OK) {
        ESP_LOGE( TAG, "Error (%s) opening NVS handle! key=%s", esp_err_to_name(err),key);
    } 
    else 
    {
        err=nvs_set_u8(write_handle,key,value);
        if(err==ESP_OK)
             ESP_LOGI( TAG,"set %s success!",key);
        else
        {
             ESP_LOGI( TAG, "set %s fail!",key);
        }  
        err = nvs_commit(write_handle);
        if(err!= ESP_OK){
            ESP_LOGE(TAG,"nvs_commit Failed!");
        }else{
            ESP_LOGI(TAG," nvs_commit Done");
        }
    }
    nvs_close(write_handle);
}

//写入uint32数据
static void nvs_write_u32(const char *key, uint32_t value)
{
    nvs_handle_t write_handle;    
    esp_err_t err;  
    err = nvs_open("wificonfig", NVS_READWRITE, &write_handle);
    if (err != ESP_OK) {
         ESP_LOGE( TAG, "Error (%s) opening NVS handle! key=%s", esp_err_to_name(err),key);
    } 
    else 
    {
        err=nvs_set_u32(write_handle,key,value);
        if(err==ESP_OK)
            ESP_LOGI( TAG, "set %s success!",key);
        else
        {
             ESP_LOGI( TAG, "set %s fail!",key);
        }  
        err = nvs_commit(write_handle);
        if(err!= ESP_OK){
            ESP_LOGE(TAG,"nvs_commit Failed!");
        }else{
            ESP_LOGI(TAG," nvs_commit Done");
        }
    }
    nvs_close(write_handle);
}



//--------------------------------------------char----------------------------------------------//

// 读取配置信息
void read_config_data(){
    read_ssid();
    read_pwd();
    read_owner_id();
    read_relay_status();
    read_light_status();
    read_red();
    read_green();
    read_blue();
    read_light_mode();
    read_brightness();
    read_is_smart_config();
    read_is_radar();
    read_is_alarm();
    read_is_wifi_offline();
    read_light_interval();
    read_radar_interval();
    read_fade_time();
    read_open_broken_url();
    read_open_account();
    read_open_pwd();
    read_is_open_certifi();
    read_is_host();
    read_is_rf_control();
    read_rf_one_func();
    read_rf_two_func();
    read_rf_three_func();
    read_rf_four_func();
}

// 写入配置信息
void write_config_data(){
    write_ssid();
    write_pwd();
    write_owner_id();
    write_relay_status();
    write_light_status();
    write_red();
    write_green();
    write_blue();
    write_light_mode();
    write_brightness();
    write_is_smart_config();
    write_is_radar();
    write_is_alarm();
    write_is_wifi_offline();
    write_light_interval();
    write_radar_interval();
    write_fade_time();
    write_open_broken_url();
    write_open_account();
    write_open_pwd();
    write_is_open_certifi();
    write_is_host();
    write_is_rf_control();
    write_rf_one_func();
    write_rf_two_func();
    write_rf_three_func();
    write_rf_four_func();
}

//写入wifi的SSID
void write_ssid(void){
    nvs_write_str("ssid", ssid);
}
//读取wifi的SSID
void read_ssid(void)
{
    nvs_read_str("ssid",ssid);
}

//写入wifi密码
void write_pwd(void){
    nvs_write_str("pwd",pwd);
}
//读取wifi密码
void read_pwd(void){
    nvs_read_str("pwd",pwd);
}

//写入用户ID
void write_owner_id(void){
    nvs_write_str("owner_id",owner_id);
}
//读取用户ID
void read_owner_id(void){
    nvs_read_str("owner_id",owner_id);
}

//写入二次开发mqtt地址
void write_open_broken_url(void){
    nvs_write_str("open_broken_url",open_broken_url);
}
//读取二次开发mqtt地址
void read_open_broken_url(void){
    nvs_read_str("open_broken_url",open_broken_url);
}

//写入二次开发mqtt账号
void write_open_account(void){
    nvs_write_str("open_account",open_account);
}
//读取二次开发mqtt账号
void read_open_account(void){
    nvs_read_str("open_account",open_account);
}

//写入二次开发mqtt密码
void write_open_pwd(void){
    nvs_write_str("open_pwd",open_pwd);
}
//读取二次开发mqtt密码
void read_open_pwd(void){
    nvs_read_str("open_pwd",open_pwd);
}

//--------------------------------------------uint8----------------------------------------------//

void write_relay_status(void){
    nvs_write_u8("relay_status",relay_status);
}
void read_relay_status(void){
    nvs_read_u8("relay_status",&relay_status);
}

void write_light_status(void){
    nvs_write_u8("light_status",light_status);
}
void read_light_status(void){
    nvs_read_u8("light_status",&light_status);
}

void write_light_mode(void){
    nvs_write_u8("light_mode",light_mode);
}
void read_light_mode(void){
    nvs_read_u8("light_mode",&light_mode);
}

void write_is_smart_config(void){
    nvs_write_u8("is_smart_config",is_smart_config);
}
void read_is_smart_config(void){
    nvs_read_u8("is_smart_config",&is_smart_config);
}

void write_is_radar(void){
    nvs_write_u8("is_radar",is_radar);
}
void read_is_radar(void){
    nvs_read_u8("is_radar",&is_radar);
}

void write_is_alarm(void){
    nvs_write_u8("is_alarm",is_alarm);
}
void read_is_alarm(void){
    nvs_read_u8("is_alarm",&is_alarm);
}

void write_is_wifi_offline(void){
    nvs_write_u8("is_wifi_offline",is_wifi_offline);
}
void read_is_wifi_offline(void){
    nvs_read_u8("is_wifi_offline",&is_wifi_offline);
}

void write_is_open_certifi(void){
    nvs_write_u8("is_open_certifi",is_open_certifi);
}
void read_is_open_certifi(void){
    nvs_read_u8("is_open_certifi",&is_open_certifi);
}

void write_is_host(void){
    nvs_write_u8("is_host",is_host);
}
void read_is_host(void){
    nvs_read_u8("is_host",&is_host);
}

void write_is_rf_control(void){
    nvs_write_u8("is_rf_control",is_rf_control);
}
void read_is_rf_control(void){
    nvs_read_u8("is_rf_control",&is_rf_control);
}

void write_rf_one_func(void){
    nvs_write_u8("rf_one_func",rf_one_func);
}
void read_rf_one_func(void){
    nvs_read_u8("rf_one_func",&rf_one_func);
}

void write_rf_two_func(void){
    nvs_write_u8("rf_two_func",rf_two_func);
}
void read_rf_two_func(void){
    nvs_read_u8("rf_two_func",&rf_two_func);
}

void write_rf_three_func(void){
    nvs_write_u8("rf_three_func",rf_three_func);
}
void read_rf_three_func(void){
    nvs_read_u8("rf_three_func",&rf_three_func);
}

void write_rf_four_func(void){
    nvs_write_u8("rf_four_func",rf_four_func);
}
void read_rf_four_func(void){
    nvs_read_u8("rf_four_func",&rf_four_func);
}

//--------------------------------------------------uint32----------------------------------------------//

void write_red(void){
    nvs_write_u32("red",red);
}
void read_red(void){
    nvs_read_u32("red",&red);
}

void write_green(void){
    nvs_write_u32("green",green);
}
void read_green(void){
    nvs_read_u32("green",&green);
}

void write_blue(void){
    nvs_write_u32("blue",blue);
}
void read_blue(void){
    nvs_read_u32("blue",&blue);
}

void write_brightness(void){
    nvs_write_u32("brightness",brightness);
}
void read_brightness(void){
    nvs_read_u32("brightness",&brightness);
}

void write_light_interval(void){
    nvs_write_u32("light_interval",light_interval);
}
void read_light_interval(void){
    nvs_read_u32("light_interval",&light_interval);
}

void write_radar_interval(void){
    nvs_write_u32("radar_interval",radar_interval);
}
void read_radar_interval(void){
    nvs_read_u32("radar_interval",&radar_interval);
}

void write_fade_time(void){
    nvs_write_u32("fade_time",fade_time);
}
void read_fade_time(void){
    nvs_read_u32("fade_time",&fade_time);
}


