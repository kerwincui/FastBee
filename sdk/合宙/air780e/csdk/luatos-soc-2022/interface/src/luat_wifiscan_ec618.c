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

#include "luat_wifiscan.h"
#include "common_api.h"
#include "ps_lib_api.h"
#include "luat_debug.h"


int32_t luat_get_wifiscan_cell_info(luat_wifiscan_set_info_t * set_info,luat_wifisacn_get_info_t* get_info)
{
    int32_t ret;
    if (set_info == NULL || get_info ==NULL)
    {
        return -1;
    }
    SetWifiScanParams wifiscanreq;
    GetWifiScanInfo pWifiScanInfo;

    wifiscanreq.maxTimeOut=set_info->maxTimeOut;
    wifiscanreq.round=set_info->round;
    wifiscanreq.maxBssidNum=set_info->maxBssidNum;
    wifiscanreq.scanTimeOut=set_info->scanTimeOut;
    wifiscanreq.wifiPriority=set_info->wifiPriority;
    ret=appGetWifiScanInfo(&wifiscanreq, &pWifiScanInfo);
    if (ret == 0)
    {

        if (pWifiScanInfo.bssidNum >= LUAT_MAX_WIFI_BSSID_NUM)
        {
            get_info->bssidNum = LUAT_MAX_WIFI_BSSID_NUM;
        }
        else
        {
            get_info->bssidNum =pWifiScanInfo.bssidNum;
        }
        get_info->rsvd = pWifiScanInfo.rsvd;
        for (int i = 0; i < pWifiScanInfo.bssidNum; i++)
        {
            get_info->ssidHexLen[i] = pWifiScanInfo.ssidHexLen[i];
            for (int j = 0; j < pWifiScanInfo.ssidHexLen[i]; j++)
            {
                get_info->ssidHex[i][j] = pWifiScanInfo.ssidHex[i][j];
            }
            get_info->rssi[i] = pWifiScanInfo.rssi[i];
            get_info->channel[i] = pWifiScanInfo.channel[i];
            for (int n = 0; n < 6; n++)
            {
                get_info->bssid[i][n] = pWifiScanInfo.bssid[i][n];
            }
        }
        return 0;
    }

    return -1;
}
