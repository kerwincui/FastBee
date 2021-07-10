/******************************************************************************
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
#include "wifi.h"

#define LISTEN_INTERVAL  3 //站监听AP信标的间隔。监听间隔的单位是一个信标间隔。例如，如果信标间隔为100 ms，侦听间隔为3，则站侦听信标的间隔为300 ms。
#define WIFI_CONNECTED_BIT BIT0
#define WIFI_FAIL_BIT      BIT1

char ssid[33]="ssid";          // wifi的SSID
char pwd[65]="password";       // wifi的密码


static const char *TAG = "WIFI";
static EventGroupHandle_t s_wifi_event_group;
static esp_event_handler_instance_t instance_any_id;
static esp_event_handler_instance_t instance_got_ip;

// 回调函数
static void station_event_handler(void* arg, esp_event_base_t event_base, int32_t event_id, void* event_data)
{
    printf("station event handler begin \n\n\n");
    if (event_base == WIFI_EVENT && event_id == WIFI_EVENT_STA_START) {
        esp_wifi_connect();
    } else if (event_base == WIFI_EVENT && event_id == WIFI_EVENT_STA_DISCONNECTED) {
        esp_wifi_connect();
    } else if (event_base == IP_EVENT && event_id == IP_EVENT_STA_GOT_IP) {
        ip_event_got_ip_t* event = (ip_event_got_ip_t*) event_data;
        ESP_LOGI(TAG, "got ip: " IPSTR, IP2STR(&event->ip_info.ip));
        xEventGroupSetBits(s_wifi_event_group, WIFI_CONNECTED_BIT);
    }
}


//站点模式初始化
static void wifi_station_init(void)
{    
    esp_netif_create_default_wifi_sta();
    ESP_ERROR_CHECK(esp_event_handler_instance_register(WIFI_EVENT, ESP_EVENT_ANY_ID, &station_event_handler, NULL, &instance_any_id));
    ESP_ERROR_CHECK(esp_event_handler_instance_register(IP_EVENT, IP_EVENT_STA_GOT_IP, &station_event_handler, NULL, &instance_got_ip));
    wifi_config_t wifi_config = {
        .sta = {
            .listen_interval = LISTEN_INTERVAL,
            /* 设置密码意味着工作站将连接到包括WEP/WPA在内的所有安全模式。但是，这些模式已被弃用，不建议使用。
             *  如果您的接入点不支持WPA2，可以通过在下面的行注释来启用这些模式 */
	        //.threshold.authmode = WIFI_AUTH_WPA2_PSK,

            //PMF功能
            .pmf_cfg = {
                .capable = true,
                .required = false
            },
        },
    };
    // wifi配置赋值
    strcpy((char *)wifi_config.sta.ssid,(char *)ssid);
    strcpy((char *)wifi_config.sta.password,(char *)pwd);
    ESP_ERROR_CHECK(esp_wifi_set_config(ESP_IF_WIFI_STA, &wifi_config));
}


//启动wifi站点
void wifi_start(void)
{
    s_wifi_event_group = xEventGroupCreate();
    ESP_ERROR_CHECK(esp_netif_init());
    
    wifi_init_config_t cfg = WIFI_INIT_CONFIG_DEFAULT();
    ESP_ERROR_CHECK(esp_wifi_init(&cfg));
    ESP_ERROR_CHECK(esp_wifi_set_mode(WIFI_MODE_STA));

    ESP_LOGI(TAG, "ESP_WIFI_MODE_STA");
    wifi_station_init();
    ESP_ERROR_CHECK(esp_wifi_start());

    //STATION模式，等待建立连接或者超过连接最大次数后连接失败，比特位是通过事件处理程序设置
    EventBits_t bits = xEventGroupWaitBits(s_wifi_event_group,
            WIFI_CONNECTED_BIT | WIFI_FAIL_BIT,
            pdFALSE,
            pdFALSE,
            portMAX_DELAY);

    if (bits & WIFI_CONNECTED_BIT) {
        ESP_LOGI(TAG, "connected to ap SSID:%s password:%s",ssid, pwd);
    } else if (bits & WIFI_FAIL_BIT) {
        ESP_LOGI(TAG, "Failed to connect to SSID:%s, password:%s", ssid, pwd);
    } else {
        ESP_LOGE(TAG, "UNEXPECTED EVENT");
    }
}



