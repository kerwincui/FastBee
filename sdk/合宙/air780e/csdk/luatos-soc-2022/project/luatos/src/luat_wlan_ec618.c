#include "luat_base.h"
#include "luat_wlan.h"
#include "luat_rtos.h"

#include "common_api.h"
#include "ps_lib_api.h"

#define WLAN_SCAN_DONE 1

static const SetWifiScanParams wifiscanreq = {
    .maxTimeOut = 10000,
    .round = 1,
    .maxBssidNum = CMI_DEV_MAX_WIFI_BSSID_NUM,
    .scanTimeOut = 5,
    .wifiPriority = 0
};

static GetWifiScanInfo *pWifiScanInfo = PNULL;

static luat_rtos_task_handle wlan_task_handle;

static int l_wlan_handler(lua_State *L, void* ptr) {
    rtos_msg_t* msg = (rtos_msg_t*)lua_topointer(L, -1);
    int32_t event_id = msg->arg1;
    lua_getglobal(L, "sys_pub");
    switch (event_id)
    {
    case WLAN_SCAN_DONE:
        DBG("wifi scan done");
        lua_pushstring(L, "WLAN_SCAN_DONE");
        lua_call(L, 1, 0);
        break;
    default:
        DBG("unkown event %d", event_id);
        break;
    }
    return 0;
}

static void wlan_task(void *param){
    rtos_msg_t msg = {0};
    msg.handler = l_wlan_handler;
    msg.arg1 = WLAN_SCAN_DONE;
    if (pWifiScanInfo == NULL)
        pWifiScanInfo = (GetWifiScanInfo *)malloc(sizeof(GetWifiScanInfo));
    if (pWifiScanInfo) {
        memset(pWifiScanInfo, 0, sizeof(GetWifiScanInfo));
        appGetWifiScanInfo(&wifiscanreq, pWifiScanInfo);
        luat_msgbus_put(&msg, 0);
    }
    else {
        DBG("out of memory when malloc GetWifiScanInfo");
    }
    luat_rtos_task_delete(wlan_task_handle);
}

int luat_wlan_init(luat_wlan_config_t *conf){
    DBG("wifi support scan only");
    return 0;
}

int luat_wlan_scan(void){
    if (luat_rtos_task_create(&wlan_task_handle, 2048, 20, "wlan", wlan_task, NULL, NULL)){
    	return -1;
    }
    return 0;
}

int luat_wlan_scan_get_result(luat_wlan_scan_result_t *results, int ap_limit){
    if (pWifiScanInfo == NULL) {
        return 0;
    }
    if (ap_limit > pWifiScanInfo->bssidNum){
        ap_limit = pWifiScanInfo->bssidNum;
    }
    for (size_t i = 0; i < ap_limit; i++){
        memcpy(results[i].ssid, pWifiScanInfo->ssidHex[i], pWifiScanInfo->ssidHexLen[i]);
        memcpy(results[i].bssid, pWifiScanInfo->bssid[i], 6);
        results[i].rssi = pWifiScanInfo->rssi[i];
    }
    return ap_limit;
}
