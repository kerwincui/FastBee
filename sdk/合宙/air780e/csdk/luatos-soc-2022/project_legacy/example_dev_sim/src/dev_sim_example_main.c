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

#include "common_api.h"
#include "FreeRTOS.h"
#include "task.h"
#include "ps_lib_api.h"
#include "ps_sim_if.h"
#include "cmisim.h"

#define CCID_LEN 24
#define IMEI_LEN 18
#define IMSI_LEN 18
static void usb_serial_input_dummy_cb(uint8_t channel, uint8_t *input, uint32_t len)
{
	DBG("dev_sim_example usb serial get %dbyte, test mode, send back", len);
	usb_serial_output(channel, input, len);
}

static void hw_demoA_init(void)
{
	DBG("dev_sim_example this hw demo1");
	set_usb_serial_input_callback(usb_serial_input_dummy_cb);
}

static void hw_demoB_init(void)
{
	DBG("dev_sim_example this hw demo2");
}

static void dr_demoC_init(void)
{
	DBG("dev_sim_example this dr demo1");
}

static void dr_demoD_init(void)
{
	DBG("dev_sim_example this dr demo2");
}



/**
  \fn          CmsRetId appGetImeiNumSync(CHAR* imei)
  \brief       Send cmi request to get IMEI
  \param[out]  CHAR* imei point to the stored result
  \returns     CmsRetId
*/


/**
  \fn          BOOL appGetSNNumSync(CHAR* sn)
  \brief       Send cmi request to get sn num
  \param[out]  CHAR* sn point to the stored result
  \returns     true---success false---fail
*/

/**
  \fn          BOOL appSetSNNumSync(CHAR* sn, UINT8 len)
  \brief       Send cmi request to set sn num
  \param[in]   CHAR* sn point to sn num
  \param[in]   len SN num length with max length 32 bytes
  \returns     true---success false---fail
*/
static void task1(void *param)
{
	while (1)
	{
		//测试获取IMEI号
		CHAR imei[IMEI_LEN + 1] = {0};
		if (sizeof(imei) < 18)
		{
			DBG("dev_sim_example get imei fail!!! not enough buf size");
		}
		else
		{
			CmsRetId ret = appGetImeiNumSync(imei);
			if (CMS_RET_SUCC == ret)
			{
				DBG("dev_sim_example get imei success %s", imei);
			}
			else
			{
				DBG("dev_sim_example get imei fail");
			}
		}
		// 测试获取SN号
		CHAR sn[34] = {0};
		if (sizeof(sn) < 32)
		{
			DBG("dev_sim_example get sn fail!!! not enough buf size");
		}
		else
		{
			BOOL ret = appGetSNNumSync(sn);
			if (ret)
			{
				DBG("dev_sim_example get sn success %s", sn);
			}
			else
			{
				DBG("dev_sim_example get sn fail");
			}
		}

		//测试写SN号的功能，有需要可打开
		/* char *snstr = "12345678910111213";
		BOOL ret = appSetSNNumSync(snstr, strlen(snstr));
		if (ret)
		{
			BOOL ret = appGetSNNumSync(sn);
			if (ret)
			{
				char * retstr = strstr(snstr, sn);
				if (retstr != NULL)
				{
					DBG("dev_sim_example set sn success %s", retstr);
				}
				else
				{
					DBG("dev_sim_example set sn fail1");
				}

			}
			else
			{
				DBG("dev_sim_example set sn fail2");
			}
		}
		else
		{
			DBG("dev_sim_example set sn fail");
		} */
		osDelay(5000);
	}
	vTaskDelete(NULL);
}




/**
  \fn          CmiRcCode simGetPinStateSync(UINT8 *pPinState)
  \brief       get SIM PIN state
  \param[out]  pPinState    CmiSimPinState
  \returns     CmiRcCode    MtErrorResultCode
*/

/**
  \fn          CmsRetId appGetIccidNumSync(CHAR* pIccid)
  \brief       get USIM iccid number
  \param[out]  *iccid  Pointer to stored USIM ICCID(max len 20 bytes) result
  \returns     CmsRetId
*/

/**
  \fn          CmsRetId appGetImsiNumSync(CHAR* pImsi)
  \brief       get IMSI number
  \param[out]  *imsi  Pointer to stored IMSI(max length 16 bytes) result
  \returns     CmsRetId
*/
static void task2(void *param)
{
	DBG("dev_sim_example this task demo2");
	while (1)
	{
		CHAR tmp[CCID_LEN + 1] = {0};
		CHAR iccid[CCID_LEN + 1] = {0};
		CHAR imsi[IMSI_LEN + 1] = {0};
		UINT8 pinState;
		CmiRcCode result = simGetPinStateSync(&pinState);
		DBG("dev_sim_example sim get status result %d, %d", result, pinState);
		if (CME_SUCC == result)
		{
			switch (pinState)
			{
			case CMI_SIM_PIN_STATE_READY:
				DBG("dev_sim_example sim ready");
				appGetIccidNumSync(iccid);
				appGetImsiNumSync(imsi);
				if (strcmp(tmp, iccid) != 0)
				{
					DBG("dev_sim_example get iccid %s", iccid);
				}
				if (strcmp(tmp, imsi) != 0)
				{
					DBG("dev_sim_example get imsi %s", imsi);
				}
				break;
			case CMI_SIM_PIN_STATE_PIN_REQUIRED:
			case CMI_SIM_PIN_STATE_PIN2_REQUIRED:
			case CMI_SIM_PIN_STATE_PH_NET_PIN_REQUIRED:
			case CMI_SIM_PIN_STATE_PH_NETSUB_PIN_REQUIRED:
			case CMI_SIM_PIN_STATE_PH_SP_PIN_REQUIRED:
			case CMI_SIM_PIN_STATE_PH_CORP_PIN_REQUIRED:
				DBG("dev_sim_example sim pin");
				break;

			case CMI_SIM_PIN_STATE_UNBLOCK_PIN_REQUIRED:
			case CMI_SIM_PIN_STATE_UNBLOCK_PIN2_REQUIRED:
			case CMI_SIM_PIN_STATE_UNBLOCK_PH_NET_PIN_REQUIRED:
			case CMI_SIM_PIN_STATE_UNBLOCK_PH_NETSUB_PIN_REQUIRED:
			case CMI_SIM_PIN_STATE_UNBLOCK_PH_SP_PIN_REQUIRED:
			case CMI_SIM_PIN_STATE_UNBLOCK_PH_CORP_PIN_REQUIRED:
				DBG("dev_sim_example sim puk");
				break;
			default:
				DBG("dev_sim_example other status %d", pinState);
				break;
			}
		}
		else if(CME_SIM_NOT_INSERT == result)
		{
			DBG("dev_sim_example sim not insert");
		}
		else
		{
			DBG("dev_sim_example other result %d", result);
		}
		osDelay(1000);
	}
	vTaskDelete(NULL);
}

static void task_demoE_init(void)
{
	xTaskCreate(task1, "", 256, NULL, 20, NULL);
}

static void task_demoF_init(void)
{
	xTaskCreate(task2, "", 256, NULL, 20, NULL);
}

//启动hw_demoA_init，启动位置硬件初始1级
INIT_HW_EXPORT(hw_demoA_init, "1");
//启动hw_demoB_init，启动位置硬件初始2级
INIT_HW_EXPORT(hw_demoB_init, "2");
//启动dr_demoC_init，启动位置驱动1级
INIT_DRV_EXPORT(dr_demoC_init, "1");
// 启动dr_demoD_init，启动位置驱动2级
INIT_DRV_EXPORT(dr_demoD_init, "2");
//启动task_demoE_init，启动位置任务1级
INIT_TASK_EXPORT(task_demoE_init, "1");
//启动task_demoF_init，启动位置任务2级
INIT_TASK_EXPORT(task_demoF_init, "2");
