/*
 * Copyright © 2014 Kosma Moczek <kosma@cloudyourcar.com>
 * This program is free software. It comes without any warranty, to the extent
 * permitted by applicable law. You can redistribute it and/or modify it under
 * the terms of the Do What The Fuck You Want To Public License, Version 2, as
 * published by Sam Hocevar. See the COPYING file for more details.
 */

#include "minmea.h"
#include "common_api.h"
#include "luat_rtos.h"
#include "luat_debug.h"
#include "luat_uart.h"
#include "luat_gpio.h"
#include "HTTPClient.h"
#include "luat_mobile.h"

// 注意：780EG内部gps与串口2相连
#define UART_ID 2
#define HTTP_RECV_BUF_SIZE      (6000)
#define HTTP_HEAD_BUF_SIZE      (800)
#define TEST_HOST "http://download.openluat.com/9501-xingli/HXXT_GPS_BDS_AGNSS_DATA.dat"


static HttpClientContext        gHttpClient = {0};

static luat_rtos_task_handle gps_task_handle;
static luat_rtos_semaphore_t net_semaphore_handle;
static luat_rtos_task_handle https_task_handle;

void mobile_event_callback(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status){
    if (event == LUAT_MOBILE_EVENT_NETIF && status == LUAT_MOBILE_NETIF_LINK_ON){
        LUAT_DEBUG_PRINT("network ready");
        luat_rtos_semaphore_release(net_semaphore_handle);
    }
}

static int libminmea_parse_data(const char* data, size_t len) {
    size_t prev = 0;
    static char nmea_tmp_buff[86] = {0}; // nmea 最大长度82,含换行符
    for (size_t offset = 0; offset < len; offset++)
    {
        // \r == 0x0D  \n == 0x0A
        if (data[offset] == 0x0A) {
            // 最短也需要是 OK\r\n
            // 应该\r\n的
            // 太长了
            if (offset - prev < 3 || data[offset - 1] != 0x0D || offset - prev > 82) {
                prev = offset + 1;
                continue;
            }
            memcpy(nmea_tmp_buff, data + prev, offset - prev - 1);
            nmea_tmp_buff[offset - prev - 1] = 0x00;
            if(strstr(nmea_tmp_buff, "GNRMC"))
            {
                parse_nmea((const char*)nmea_tmp_buff);
            }
            prev = offset + 1;
        }
    }
    return 0;
}

void luat_uart_recv_cb(int uart_id, uint32_t data_len){
    char* data_buff = malloc(data_len+1);
    memset(data_buff,0,data_len+1);
    luat_uart_read(uart_id, data_buff, data_len);
    LUAT_DEBUG_PRINT("uart_id:%d gnssdata:\n %s",uart_id,data_buff);
    libminmea_parse_data(data_buff, data_len);
    free(data_buff);
}

static INT32 httpGetData(CHAR *getUrl, CHAR *buf, UINT32 len, UINT32 *dataLen)
{
    HTTPResult result = HTTP_INTERNAL;
    HttpClientData    clientData = {0};
    UINT32 count = 0;
    uint16_t headerLen = 0;

    LUAT_DEBUG_ASSERT(buf != NULL,0,0,0);

    clientData.headerBuf = malloc(HTTP_HEAD_BUF_SIZE);
    clientData.headerBufLen = HTTP_HEAD_BUF_SIZE;
    clientData.respBuf = buf;
    clientData.respBufLen = len;

    result = httpSendRequest(&gHttpClient, getUrl, HTTP_GET, &clientData);
    LUAT_DEBUG_PRINT("send request result=%d", result);
    if (result != HTTP_OK)
        goto exit;
    do {
    	LUAT_DEBUG_PRINT("recvResponse loop.");
        memset(clientData.headerBuf, 0, clientData.headerBufLen);
        memset(clientData.respBuf, 0, clientData.respBufLen);
        result = httpRecvResponse(&gHttpClient, &clientData);
        if(result == HTTP_OK || result == HTTP_MOREDATA){
            headerLen = strlen(clientData.headerBuf);
            if(headerLen > 0)
            {
            	LUAT_DEBUG_PRINT("total content length=%d", clientData.recvContentLength);
            }

            if(clientData.blockContentLen > 0)
            {
            	LUAT_DEBUG_PRINT("response content:{%s}", (uint8_t*)clientData.respBuf);
            }
            count += clientData.blockContentLen;
            *dataLen = *dataLen + count;
            LUAT_DEBUG_PRINT("has recv=%d", count);
        }
    } while (result == HTTP_MOREDATA || result == HTTP_CONN);

    LUAT_DEBUG_PRINT("result=%d", result);
    if (gHttpClient.httpResponseCode < 200 || gHttpClient.httpResponseCode > 404)
    {
    	LUAT_DEBUG_PRINT("invalid http response code=%d",gHttpClient.httpResponseCode);
    } else if (count == 0 || count != clientData.recvContentLength) {
    	LUAT_DEBUG_PRINT("data not receive complete");
    } else {
    	LUAT_DEBUG_PRINT("receive success");
    }
exit:
    free(clientData.headerBuf);
    return result;
}


static void task_test_https(void *param)
{
    luat_rtos_semaphore_create(&net_semaphore_handle, 1);

	char *recvBuf = malloc(HTTP_RECV_BUF_SIZE);
	HTTPResult result = HTTP_INTERNAL;
    uint32_t dataLen = 0;
    luat_mobile_event_register_handler(mobile_event_callback);
    gHttpClient.timeout_s = 2;
    gHttpClient.timeout_r = 20;
    luat_rtos_semaphore_take(net_semaphore_handle, LUAT_WAIT_FOREVER);
    result = httpConnect(&gHttpClient, TEST_HOST);
    if (result == HTTP_OK)
    {
        result = httpGetData(TEST_HOST, recvBuf, HTTP_RECV_BUF_SIZE, &dataLen);
        httpClose(&gHttpClient);

        if (result == HTTP_OK)
        {
            LUAT_DEBUG_PRINT("http client get data success %d", dataLen);

            for (size_t i = 0; i < dataLen; i = i + 512)
            {
                if (i + 512 < dataLen)
                    luat_uart_write(UART_ID, &recvBuf[i], 512);
                else
                    luat_uart_write(UART_ID, &recvBuf[i], dataLen - i);
                luat_rtos_task_sleep(100);
            }
        }
        demo_udp_init();
    }
    else
    {
        LUAT_DEBUG_PRINT("http client connect error");
    }
    memset(recvBuf, 0x00, HTTP_RECV_BUF_SIZE);
    free(recvBuf);
	luat_rtos_task_delete(https_task_handle);
}

static void task_demo_https(void)
{
    // https所需的栈空间会大很多
	luat_rtos_task_create(&https_task_handle, 32*1024, 20, "https", task_test_https, NULL, NULL);
}

//启动task_demoF_init，启动位置任务2级

static void task_test_gps(void *param)
{
    
    luat_uart_t uart = {
        .id = UART_ID,
        .baud_rate = 115200,
        .data_bits = 8,
        .stop_bits = 1,
        .parity    = 0
    };
    luat_uart_pre_setup(UART_ID, 1);
    luat_uart_setup(&uart);

    luat_uart_ctrl(UART_ID, LUAT_UART_SET_RECV_CALLBACK, luat_uart_recv_cb);

    // gps电源
    luat_gpio_cfg_t cfg = {0};
    cfg.pin = HAL_GPIO_13;
    cfg.mode = LUAT_GPIO_OUTPUT;
    cfg.output_level = 1;
    cfg.alt_fun = 4;
    luat_gpio_open(&cfg);
    luat_rtos_task_sleep(200);
    while (1)
    {
        char cmd2[] = "$AIDINFO";
        luat_uart_write(UART_ID, cmd2, strlen(cmd2));
        luat_rtos_task_sleep(5000);
    }
    luat_rtos_task_delete(gps_task_handle);
}


#define INDENT_SPACES "  "

int parse_nmea(const char *gpsdata)
{
    switch (minmea_sentence_id(gpsdata, false)) {
        case MINMEA_SENTENCE_RMC: {
            struct minmea_sentence_rmc frame;
            if (minmea_parse_rmc(&frame, gpsdata)) {
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxRMC: raw coordinates and speed: (%d/%d,%d/%d) %d/%d\n",
                        frame.latitude.value, frame.latitude.scale,
                        frame.longitude.value, frame.longitude.scale,
                        frame.speed.value, frame.speed.scale);
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxRMC fixed-point coordinates and speed scaled to three decimal places: (%d,%d) %d\n",
                        minmea_rescale(&frame.latitude, 1000),
                        minmea_rescale(&frame.longitude, 1000),
                        minmea_rescale(&frame.speed, 1000));
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxRMC floating point degree coordinates and speed: (%f,%f) %f\n",
                        minmea_tocoord(&frame.latitude),
                        minmea_tocoord(&frame.longitude),
                        minmea_tofloat(&frame.speed));
            }
            else {
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxRMC sentence is not parsed\n");
            }
        } break;
        case MINMEA_SENTENCE_GGA: {
            struct minmea_sentence_gga frame;
            if (minmea_parse_gga(&frame, gpsdata)) {
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxGGA: fix quality: %d\n", frame.fix_quality);
            }
            else {
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxGGA sentence is not parsed\n");
            }
        } break;
        case MINMEA_SENTENCE_GST: {
            struct minmea_sentence_gst frame;
            if (minmea_parse_gst(&frame, gpsdata)) {
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxGST: raw latitude,longitude and altitude error deviation: (%d/%d,%d/%d,%d/%d)\n",
                        frame.latitude_error_deviation.value, frame.latitude_error_deviation.scale,
                        frame.longitude_error_deviation.value, frame.longitude_error_deviation.scale,
                        frame.altitude_error_deviation.value, frame.altitude_error_deviation.scale);
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxGST fixed point latitude,longitude and altitude error deviation"
                       " scaled to one decimal place: (%d,%d,%d)\n",
                        minmea_rescale(&frame.latitude_error_deviation, 10),
                        minmea_rescale(&frame.longitude_error_deviation, 10),
                        minmea_rescale(&frame.altitude_error_deviation, 10));
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxGST floating point degree latitude, longitude and altitude error deviation: (%f,%f,%f)",
                        minmea_tofloat(&frame.latitude_error_deviation),
                        minmea_tofloat(&frame.longitude_error_deviation),
                        minmea_tofloat(&frame.altitude_error_deviation));
            }
            else {
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxGST sentence is not parsed\n");
            }
        } break;
        case MINMEA_SENTENCE_GSV: {
            struct minmea_sentence_gsv frame;
            if (minmea_parse_gsv(&frame, gpsdata)) {
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxGSV: message %d of %d\n", frame.msg_nr, frame.total_msgs);
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxGSV: satellites in view: %d\n", frame.total_sats);
                for (int i = 0; i < 4; i++)
                    LUAT_DEBUG_PRINT(INDENT_SPACES "$xxGSV: sat nr %d, elevation: %d, azimuth: %d, snr: %d dbm\n",
                        frame.sats[i].nr,
                        frame.sats[i].elevation,
                        frame.sats[i].azimuth,
                        frame.sats[i].snr);
            }
            else {
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxGSV sentence is not parsed\n");
            }
        } break;
        case MINMEA_SENTENCE_VTG: {
           struct minmea_sentence_vtg frame;
           if (minmea_parse_vtg(&frame, gpsdata)) {
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxVTG: true track degrees = %f\n",
                       minmea_tofloat(&frame.true_track_degrees));
                LUAT_DEBUG_PRINT(INDENT_SPACES "        magnetic track degrees = %f\n",
                       minmea_tofloat(&frame.magnetic_track_degrees));
                LUAT_DEBUG_PRINT(INDENT_SPACES "        speed knots = %f\n",
                        minmea_tofloat(&frame.speed_knots));
                LUAT_DEBUG_PRINT(INDENT_SPACES "        speed kph = %f\n",
                        minmea_tofloat(&frame.speed_kph));
           }
           else {
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxVTG sentence is not parsed\n");
           }
        } break;
        case MINMEA_SENTENCE_ZDA: {
            struct minmea_sentence_zda frame;
            if (minmea_parse_zda(&frame, gpsdata)) {
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxZDA: %d:%d:%d %02d.%02d.%d UTC%+03d:%02d\n",
                       frame.time.hours,
                       frame.time.minutes,
                       frame.time.seconds,
                       frame.date.day,
                       frame.date.month,
                       frame.date.year,
                       frame.hour_offset,
                       frame.minute_offset);
            }
            else {
                LUAT_DEBUG_PRINT(INDENT_SPACES "$xxZDA sentence is not parsed\n");
            }
        } break;
        case MINMEA_INVALID: {
            LUAT_DEBUG_PRINT(INDENT_SPACES "$xxxxx sentence is not valid\n");
        } break;
        default: {
            LUAT_DEBUG_PRINT(INDENT_SPACES "$xxxxx sentence is not parsed\n");
        } break;
    }
    return 0;
}

static void task_demo_gps(void)
{
    luat_rtos_task_create(&gps_task_handle, 1024 * 20, 20, "gps", task_test_gps, NULL, NULL);
}


INIT_TASK_EXPORT(task_demo_gps,"1");
INIT_TASK_EXPORT(task_demo_https, "2");
/* vim: set ts=4 sw=4 et: */
