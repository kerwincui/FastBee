/******************************************************************************
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
#include "mqtt.h"
#include "led.h"
#include "common.h"
#include "cJSON.h"
#include "cJSON_Utils.h"
#include "nvs_storage.h"
#include "driver/temp_sensor.h"
#include "i2c_temp.h"
#include "wifi.h"

static const char *TAG = "MQTT";
static esp_mqtt_client_handle_t mqtt_client=NULL;
static char *update_status_topic;
static char *get_status_topic;
static char *update_setting_topic;
static char *get_setting_topic;

// 发布设备状态
void publishStatus(void){
        // temp_sensor_read_celsius(&device_temp);   //获取设备温度
        // get_temp_humi();                          // 获取空气温湿度
        get_ap_info();                            //获取wifi信号

        cJSON *status = cJSON_CreateObject();        
        cJSON_AddStringToObject(status,"deviceNum",device_num);
        cJSON_AddNumberToObject(status,"relayStatus",relay_status);
        cJSON_AddNumberToObject(status,"lightStatus",light_status);
        cJSON_AddNumberToObject(status,"isOnline",1);
        cJSON_AddNumberToObject(status,"rssi",rssi);
        cJSON_AddNumberToObject(status,"deviceTemperature",device_temp);
        cJSON_AddNumberToObject(status,"airTemperature",air_temperature);
        cJSON_AddNumberToObject(status,"airHumidity",air_humidity);
        cJSON_AddNumberToObject(status,"triggerSource",trigger_source); 
        cJSON_AddNumberToObject(status,"brightness",brightness);
        cJSON_AddNumberToObject(status,"lightInterval",light_interval);
        cJSON_AddNumberToObject(status,"lightMode",light_mode);
        cJSON_AddNumberToObject(status,"fadeTime",fade_time);
        cJSON_AddNumberToObject(status,"red",red);
        cJSON_AddNumberToObject(status,"green",green);
        cJSON_AddNumberToObject(status,"blue",blue);
        char *status_msg = cJSON_Print(status);            
        //释放内存
        cJSON_Delete(status);
        ESP_LOGI(TAG,"status msg: %s",status_msg);
        int msg_id=esp_mqtt_client_publish(mqtt_client,"status",status_msg,0,1,0);
        ESP_LOGI(TAG, "sent publish device status, msg_id=%d",msg_id);
}

//发布设备配置
void publishSetting(void){
        cJSON *setting = cJSON_CreateObject();
        cJSON_AddStringToObject(setting,"deviceNum",device_num);
        cJSON_AddNumberToObject(setting,"isAlarm",is_alarm);
        cJSON_AddNumberToObject(setting,"isRadar",is_radar);
        cJSON_AddNumberToObject(setting,"isHost",is_host);        
        cJSON_AddNumberToObject(setting,"isRfControl",is_rf_control);
        cJSON_AddNumberToObject(setting,"rfOneFunc",rf_one_func);
        cJSON_AddNumberToObject(setting,"rfTwoFunc",rf_two_func);
        cJSON_AddNumberToObject(setting,"rfThreeFunc",rf_three_func);
        cJSON_AddNumberToObject(setting,"rfFourFunc",rf_four_func);
        cJSON_AddStringToObject(setting,"ownerId",owner_id);
        cJSON_AddNumberToObject(setting,"isReset",is_reset);
        cJSON_AddNumberToObject(setting,"isAp",is_ap);
        cJSON_AddNumberToObject(setting,"isRfLearn",is_rf_learn);
        cJSON_AddNumberToObject(setting,"isRfClear",is_rf_clear); 
        cJSON_AddNumberToObject(setting,"isSmartConfig",is_smart_config); 
        cJSON_AddNumberToObject(setting,"radarInterval",radar_interval); 
        cJSON_AddNumberToObject(setting,"isWifiOffline",is_wifi_offline); 
        cJSON_AddNumberToObject(setting,"isOpenCertifi",is_open_certifi); 
        char *setting_msg = cJSON_Print(setting);            
        //释放内存
        cJSON_Delete(setting);
        ESP_LOGI(TAG,"setting msg: %s",setting_msg);
        int msg_id=esp_mqtt_client_publish(mqtt_client,"setting",setting_msg,0,1,0);
        ESP_LOGI(TAG, "sent publish device setting, msg_id=%d",msg_id);
}

// 更新设备状态
static void updateStatus(esp_mqtt_event_handle_t event,char *topic){
    //将字符串格式的json数据转化为JSON对象格式
    cJSON *root = cJSON_Parse(event->data);
    if(root == NULL) { printf("parse error\n"); }

    cJSON *value_relay = cJSON_GetObjectItem(root, "relayStatus");
    char *relay = cJSON_Print(value_relay);     
    relay_status=atoi(relay);
    //打开关闭继电器
    if(relay_status==1){
        open_relay();
    }else{
        close_relay();
    }
    free(relay);

    cJSON *value_trigger = cJSON_GetObjectItem(root, "triggerSource");
    char *trigger = cJSON_Print(value_trigger); 
    trigger_source=atoi(trigger);
    free(trigger);

    cJSON *value_brightness = cJSON_GetObjectItem(root, "brightness");
    char *bright = cJSON_Print(value_brightness);     
    brightness=atoi(bright);    
    free(bright);

    cJSON *value_interval = cJSON_GetObjectItem(root, "lightInterval");
    char *interval = cJSON_Print(value_interval);     
    light_interval=atoi(interval); 
    free(interval);

    cJSON *value_mode = cJSON_GetObjectItem(root, "lightMode");
    char *mode = cJSON_Print(value_mode);     
    light_mode=atoi(mode);
    free(mode);

    cJSON *value_fade = cJSON_GetObjectItem(root, "fadeTime");
    char *fade = cJSON_Print(value_fade);     
    fade_time=atoi(fade);
    free(fade);

    cJSON *value_red = cJSON_GetObjectItem(root, "red");
    char *red_string = cJSON_Print(value_red);     
    red=atoi(red_string);
    free(red_string);

    cJSON *value_green = cJSON_GetObjectItem(root, "green");
    char *green_string = cJSON_Print(value_green);     
    green=atoi(green_string); 
    free(green_string);

    cJSON *value_blue = cJSON_GetObjectItem(root, "blue");
    char *blue_string = cJSON_Print(value_blue);     
    blue=atoi(blue_string);
    free(blue_string);

    cJSON *value_light = cJSON_GetObjectItem(root, "lightStatus");
    char *light = cJSON_Print(value_light);
    light_status=atoi(light); 
    //打开关闭彩灯
    free(light);
    
    //更新灯状态并存储
    led_status();
    write_config_data();
    cJSON_Delete(root);
}

//更新设备配置
static void updateSetting(esp_mqtt_event_handle_t event,char *topic){
    //将字符串格式的json数据转化为JSON对象格式
    cJSON *root = cJSON_Parse(event->data);
    if(root == NULL) { printf("parse error\n"); }

    cJSON *value_alarm = cJSON_GetObjectItem(root, "isAlarm");
    char *alarm = cJSON_Print(value_alarm);     
    is_alarm=atoi(alarm);
    free(alarm);

    cJSON *value_radar = cJSON_GetObjectItem(root, "isRadar");
    char *radar = cJSON_Print(value_radar);     
    is_radar=atoi(radar);
    free(radar);

    cJSON *value_host = cJSON_GetObjectItem(root, "isHost");
    char *host = cJSON_Print(value_host);
    is_host=atoi(host);
    free(host);

    cJSON *value_rf = cJSON_GetObjectItem(root, "isRfControl");
    char *rf = cJSON_Print(value_rf); 
    is_rf_control=atoi(rf);
    free(rf);

    cJSON *value_rf_one = cJSON_GetObjectItem(root, "rfOneFunc");
    char *rf_one = cJSON_Print(value_rf_one);     
    rf_one_func=atoi(rf_one); 
    free(rf_one);

    cJSON *value_rf_two = cJSON_GetObjectItem(root, "rfTwoFunc");
    char *rf_two = cJSON_Print(value_rf_two);     
    rf_two_func=atoi(rf_two);      
    free(rf_two);

    cJSON *value_rf_three = cJSON_GetObjectItem(root, "rfThreeFunc");
    char *rf_three = cJSON_Print(value_rf_three);     
    rf_three_func=atoi(rf_three);      
    free(rf_three);

    cJSON *value_rf_four = cJSON_GetObjectItem(root, "rfFourFunc");
    char *rf_four = cJSON_Print(value_rf_four);     
    rf_four_func=atoi(rf_four);      
    free(rf_four);     

    cJSON *value_rf_learn = cJSON_GetObjectItem(root, "isRfLearn");
    char *rf_learning = cJSON_Print(value_rf_learn);     
    if(strcmp(rf_learning, "1") == 0){
        // 遥控配对
        rf_learn();
    }
    free(rf_learning);

    cJSON *value_rf_clear = cJSON_GetObjectItem(root, "isRfClear");
    char *rf_clear = cJSON_Print(value_rf_clear);     
    if(strcmp(rf_clear, "1") == 0){
        // 遥控清码
        rf_clear_code();
    }  
    free(rf_clear);

    cJSON *value_ap = cJSON_GetObjectItem(root, "isAp");
    char *ap = cJSON_Print(value_ap);     
    if(strcmp(ap, "1") == 0){
        // 打开AP
        if(is_ap!=1){
            // 打开ap
            ESP_LOGI(TAG, "open access point \n");
            is_ap=1;
            ap_start(); 
        }
    }
    free(ap);   

    //写入配置
    write_config_data();

    cJSON *value_reset = cJSON_GetObjectItem(root, "isReset");
    char *reset = cJSON_Print(value_reset);     
    if(strcmp(reset, "1") == 0){
        // 设备重启
        device_restart();
    }
    free(reset);    

    cJSON_Delete(root);
}

static void mqtt_subscribe_event(esp_mqtt_event_handle_t event)
{
    char topic[32];
    ESP_LOGI(TAG,"event topic:%.*s\r", event->topic_len, event->topic);
    ESP_LOGI(TAG,"event data:%.*s\r\n",event->data_len, event->data);
    sprintf(topic,"%.*s", event->topic_len, event->topic);
    if (strcmp(topic, update_status_topic) == 0)
    {
        //更新设备状态
        updateStatus(event,topic);
        // 发布设备状态
        publishStatus();
        
    } else if (strcmp(topic, get_status_topic) == 0)
    {
        publishStatus();
        
    }else if(strcmp(topic,update_setting_topic) == 0){
        // 更新设备配置
        updateSetting(event,topic);
        // 发布设备配置
        publishSetting();
        
    }
    else if(strcmp(topic, get_setting_topic) == 0)
    {
        publishSetting();
    }
}


static esp_err_t mqtt_event_handler_cb(esp_mqtt_event_handle_t event)
{
    int msg_id;
    switch (event->event_id) {
        case MQTT_EVENT_CONNECTED:
            ESP_LOGI(TAG, "MQTT_EVENT_CONNECTED");
            //-----------------------------------订阅消息----------------------------------------
            // 订阅更新设备状态            
            msg_id = esp_mqtt_client_subscribe(mqtt_client, update_status_topic, 1);
            ESP_LOGI(TAG, "sent subscribe set status successful, msg_id=%d,topic=%s", msg_id,update_status_topic);

            // 订阅获取设备状态
            msg_id = esp_mqtt_client_subscribe(mqtt_client, get_status_topic, 1);
            ESP_LOGI(TAG, "sent subscribe get status successful, msg_id=%d,topic=%s", msg_id,get_status_topic);

            // 订阅更新设备配置            
            msg_id = esp_mqtt_client_subscribe(mqtt_client, update_setting_topic, 1);
            ESP_LOGI(TAG, "sent subscribe set setting successful, msg_id=%d,topic=%s", msg_id,update_setting_topic);

            // 订阅获取设备配置            
            msg_id = esp_mqtt_client_subscribe(mqtt_client, get_setting_topic, 1);
            ESP_LOGI(TAG, "sent subscribe get setting successful, msg_id=%d,topic=%s", msg_id,get_setting_topic);  

            //-----------------------------------发布消息--------------------------------------
            //发布设备信息
            cJSON *device_info = cJSON_CreateObject();
            cJSON_AddStringToObject(device_info,"deviceNum",device_num);
            cJSON_AddNumberToObject(device_info,"categoryId",CATEGORY);
            cJSON_AddStringToObject(device_info,"firmwareVersion",VERSION);
            cJSON_AddStringToObject(device_info,"ownerId",owner_id);
            char *device_msg = cJSON_Print(device_info);
            //释放内存
            cJSON_Delete(device_info);
            ESP_LOGI(TAG,"device msg: %s",device_msg);
            msg_id=esp_mqtt_client_publish(mqtt_client,"device_info",device_msg,0,1,0);
            ESP_LOGI(TAG, "sent publish device info, msg_id=%d",msg_id);
            break;
        case MQTT_EVENT_DISCONNECTED:
            ESP_LOGI(TAG, "MQTT_EVENT_DISCONNECTED");
            break;
        case MQTT_EVENT_SUBSCRIBED:            
            ESP_LOGI(TAG, "MQTT_EVENT_SUBSCRIBED, msg_id=%d", event->msg_id);
            break;
        case MQTT_EVENT_UNSUBSCRIBED:
            ESP_LOGI(TAG, "MQTT_EVENT_UNSUBSCRIBED, msg_id=%d", event->msg_id);
            break;
        case MQTT_EVENT_PUBLISHED:
            ESP_LOGI(TAG, "MQTT_EVENT_PUBLISHED, msg_id=%d", event->msg_id);
            break;
        case MQTT_EVENT_DATA:
            ESP_LOGI(TAG, "MQTT_EVENT_DATA");
            //订阅事件处理
            mqtt_subscribe_event(event); 
            break;
        case MQTT_EVENT_ERROR:
            ESP_LOGI(TAG, "MQTT_EVENT_ERROR");
            break;
        default:
            ESP_LOGI(TAG, "Other event id:%d", event->event_id);
            break;
    }
    return ESP_OK;
}

static void mqtt_event_handler(void *handler_args, esp_event_base_t base, int32_t event_id, void *event_data) {
    ESP_LOGD(TAG, "Event dispatched from event loop base=%s, event_id=%d", base, event_id);
    mqtt_event_handler_cb(event_data);
}

// 配置订阅主题
static void config_topic(){
    static char *update_status_path="status/set/";
    static char *get_status_path="status/get/";
    static char *update_setting_path="setting/set/";
    static char *get_setting_path="setting/get/";
    // 更新状态
    update_status_topic=(char *)malloc(strlen(update_status_path)+strlen(device_num)+1);
    if(update_status_topic==NULL){
        ESP_LOGD(TAG, "failed to apply for memory");
    }
    strcpy(update_status_topic,update_status_path);
    strcat(update_status_topic,device_num);
    ESP_LOGI(TAG,"update_status_topic:%s",update_status_topic);
    // 获取状态
    get_status_topic=(char *)malloc(strlen(get_status_path)+strlen(device_num)+1);
    if(get_status_topic==NULL){
        ESP_LOGD(TAG, "failed to apply for memory");
    }
    strcpy(get_status_topic,get_status_path);
    strcat(get_status_topic,device_num);
    ESP_LOGI(TAG,"get_status_topic:%s",get_status_topic);
    // 更新配置
    update_setting_topic=(char *)malloc(strlen(update_setting_path)+strlen(device_num)+1);
    if(update_setting_topic==NULL){
        ESP_LOGD(TAG, "failed to apply for memory");
    }
    strcpy(update_setting_topic,update_setting_path);
    strcat(update_setting_topic,device_num);
    ESP_LOGI(TAG,"update_setting_topic:%s",update_setting_topic);
    // 获取配置
    get_setting_topic=(char *)malloc(strlen(get_setting_path)+strlen(device_num)+1);
    if(get_setting_topic==NULL){
        ESP_LOGD(TAG, "failed to apply for memory");
    }
    strcpy(get_setting_topic,get_setting_path);
    strcat(get_setting_topic,device_num);  
    ESP_LOGI(TAG,"get_setting_topic:%s",get_setting_topic);
}

void mqtt_start(void)
{
    // esp_log_level_set("*", ESP_LOG_INFO);
    esp_log_level_set("MQTT_CLIENT", ESP_LOG_VERBOSE);
    esp_log_level_set("MQTT", ESP_LOG_VERBOSE);
    esp_log_level_set("TRANSPORT_TCP", ESP_LOG_VERBOSE);
    esp_log_level_set("TRANSPORT_SSL", ESP_LOG_VERBOSE);
    esp_log_level_set("TRANSPORT", ESP_LOG_VERBOSE);
    esp_log_level_set("OUTBOX", ESP_LOG_VERBOSE);

    // 配置订阅的主题
    config_topic();

    // 遗嘱消息内容
    cJSON *root = cJSON_CreateObject();
    cJSON_AddStringToObject(root,"deviceNum",device_num);
    cJSON_AddNumberToObject(root,"isOnline",0);
    char *will_msg = cJSON_Print(root);
    //释放内存
	cJSON_Delete(root);

    ESP_LOGI(TAG,"last will: %s", will_msg);
    esp_mqtt_client_config_t mqtt_cfg = {
        .uri = BROKEN_URL,
        .username = BROKEN_ADMIN,
        .password = BROKEN_PWD,
        //设置遗嘱
        .lwt_topic="offline",
        .lwt_msg=will_msg,
        .lwt_msg_len=strlen(will_msg),
        .lwt_qos=1,
        .lwt_retain=0,
        //断开前等待的时间,3秒
        .keepalive=3,
    };

    mqtt_client = esp_mqtt_client_init(&mqtt_cfg);
    esp_mqtt_client_register_event(mqtt_client, ESP_EVENT_ANY_ID, mqtt_event_handler, mqtt_client);
    esp_mqtt_client_start(mqtt_client);
}

void mqtt_stop(void){
    if(mqtt_client!=NULL){
        esp_mqtt_client_stop(mqtt_client);
    }
}
void mqtt_continue(void){
    if(mqtt_client!=NULL){
        esp_mqtt_client_start(mqtt_client);
    }
}
