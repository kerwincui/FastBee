#include "commontypedef.h"
#include "common_api.h"
#include "cms_api.h"
#include "ps_lib_api.h"
static void usb_serial_input_dummy_cb(uint8_t channel, uint8_t *input, uint32_t len)
{
	DBG("usb serial get %d byte, test mode, send back", len);
    DBG("usb serial get %s", input);

    if (strcmp("AT+CLIENTID?\r\n", (char*)input) == 0)
    {
        char clientId[32] = {0};
        int ret = am_kv_get("clientId", clientId, 16);
        if(ret > 0 )
        {
           usb_serial_output(channel, clientId, strlen(clientId));
        }
        else
        {
            usb_serial_output(channel, "OK", strlen("OK"));
        }
    }
    else if (strstr((char*)input, "AT+CLIENTID=") != NULL)
    {
        char *flag = NULL;
        flag = strstr((char*)input, "=");
        if(flag != NULL)
        {
            flag++;
            char *flag2 = NULL;
            flag2 = strstr(flag, "\r\n");
            if (flag2 != NULL)
            {
                int ret = am_kv_set("clientId", flag, strlen(flag) - 2);
                usb_serial_output(channel, "OK", strlen("OK"));
            }
            
        }
    }
    else if (strcmp("AT+USERNAME?\r\n", (char*)input) == 0)
    {
        int ret = 0;
        char name[32] = {0};
        ret = am_kv_get("username", name, 31);
        if (ret > 0)
        {
            usb_serial_output(channel, name, strlen(name));
        }
        else
        {
            usb_serial_output(channel, "OK", strlen("OK"));
        }
    }
    else if (strstr((char*)input, "AT+USERNAME=")  != NULL)
    {
        char *flag = NULL;
        flag = strstr((char*)input, "=");
        if(flag != NULL)
        {
            flag++;
            char *flag2 = NULL;
            flag2 = strstr(flag, "\r\n");
            if (flag2 != NULL)
            {
                int ret = am_kv_set("username", flag, strlen(flag) - 2);
                usb_serial_output(channel, "OK", strlen("OK"));
            }
            
        }
    }
    else if (strcmp("AT+PASSWORD?\r\n", (char*)input) == 0)
    {
        int ret = 0;
        char name[32] = {0};
        ret = am_kv_get("password", name, 31);
        if (ret > 0)
        {
            usb_serial_output(channel, name, strlen(name));
        }
        else
        {
            usb_serial_output(channel, "OK", strlen("OK"));
        }
    }
    else if (strstr((char*)input, "AT+PASSWORD=") != NULL)
    {
        char *flag = NULL;
        flag = strstr((char*)input, "=");
        if(flag != NULL)
        {
            flag++;
            char *flag2 = NULL;
            flag2 = strstr(flag, "\r\n");
            if (flag2 != NULL)
            {
                int ret = am_kv_set("password", flag, strlen(flag) - 2);
                usb_serial_output(channel, "OK", strlen("OK"));
            }
            
        }
    }
}
void usb_data_init(void)
{
	DBG("this hw demo1");
	set_usb_serial_input_callback(usb_serial_input_dummy_cb);
}