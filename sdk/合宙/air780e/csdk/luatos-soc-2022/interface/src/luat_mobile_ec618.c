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

#include "luat_mobile.h"
#include "ps_lib_api.h"
#include "common_api.h"
#include "cmimm.h"
#include "cmidev.h"
#include "cms_api.h"

extern void soc_mobile_event_deregister_handler(void);
extern void soc_mobile_get_imsi(uint8_t *buf);
extern void soc_mobile_get_iccid(uint8_t *buf);
extern void soc_mobile_event_register_handler(void *handle);
extern void soc_mobile_set_period(uint32_t get_cell_period, uint32_t check_sim_period, uint8_t search_cell_time);
extern void soc_mobile_reset_stack(void);
extern void soc_mobile_get_signal(CmiMmCesqInd *info);
extern void soc_mobile_get_cell_info(CmiDevGetBasicCellListInfoInd *info);
extern void soc_mobile_get_sim_id(uint8_t *sim_id, uint8_t *is_auto);
extern void soc_mobile_set_sim_id(uint8_t sim_id);
extern void soc_mobile_sms_event_register_handler(void *handle);
extern uint8_t soc_mobile_get_csq(void);
extern void soc_mobile_search_cell_info_async(uint8_t param);
int soc_mobile_get_default_pdp_part_info(uint8_t *ip_type, uint8_t *apn,uint8_t *apn_len, uint8_t *dns_num, ip_addr_t *dns_ip);

int luat_mobile_get_imei(int sim_id, char* buff, size_t buf_len)
{
	char temp[20] = {0};
	int result = appGetImeiNumSync(temp);
	if (!result)
	{
		memcpy(buff, temp, (buf_len > sizeof(temp))?sizeof(temp):buf_len);
		return (buf_len > sizeof(temp))?sizeof(temp):buf_len;
	}
	else
	{
		return -1;
	}


}

int luat_mobile_get_sn(char* buff, size_t buf_len)
{
	char temp[32] = {0};
	int result = appGetSNNumSync(temp);
	if (result)
	{
		memcpy(buff, temp, (buf_len > sizeof(temp))?sizeof(temp):buf_len);
		return (buf_len > sizeof(temp))?sizeof(temp):buf_len;
	}
	else
	{
		return -1;
	}
}

int luat_mobile_set_sn(char* buff, uint8_t buf_len)
{
	int result = appSetSNNumSync(buff, buf_len);
	return result==1 ? 0 : -1;
}

int luat_mobile_get_muid(char* buff, size_t buf_len)
{
	char temp[64] = {0};
	int result = soc_get_sn(temp, sizeof(temp));
	if (!result)
	{
		memcpy(buff, temp, (buf_len > sizeof(temp))?sizeof(temp):buf_len);
		return (buf_len > sizeof(temp))?sizeof(temp):buf_len;
	}
	else
	{
		return -1;
	}
}

int luat_mobile_get_iccid(int sim_id, char* buff, size_t buf_len)
{
	char temp[24] = {0};
	soc_mobile_get_iccid(temp);
	if (temp[0])
	{
		memcpy(buff, temp, (buf_len > sizeof(temp))?sizeof(temp):buf_len);
		return (buf_len > sizeof(temp))?sizeof(temp):buf_len;
	}
	else
	{
		return -1;
	}

}

int luat_mobile_get_imsi(int sim_id, char* buff, size_t buf_len)
{
	char temp[20] = {0};
	soc_mobile_get_imsi(temp);
	if (temp[0])
	{
		memcpy(buff, temp, (buf_len > sizeof(temp))?sizeof(temp):buf_len);
		return (buf_len > sizeof(temp))?sizeof(temp):buf_len;
	}
	else
	{
		return -1;
	}
}

int luat_mobile_get_sim_id(int *id)
{
	uint8_t sim_id, is_auto;
	soc_mobile_get_sim_id(&sim_id, &is_auto);
	if (sim_id != 0xff)
	{
		*id = sim_id;
		return 0;
	}
	else
	{
		return -1;
	}

}

int luat_mobile_set_sim_id(int id)
{
	if (id > 2)
	{
		return -1;
	}
	else
	{
		soc_mobile_set_sim_id(id);
		return 0;
	}
}

int luat_mobile_get_apn(int sim_id, int cid, char* buff, size_t buf_len)
{
	uint8_t type;
	int default_cid = soc_mobile_get_default_pdp_part_info(&type, NULL, NULL, NULL, NULL);
	if (cid > 0 && default_cid != cid)
	{
		return -1;
	}
	uint8_t apn_len = buf_len;
	soc_mobile_get_default_pdp_part_info(&type, buff, &apn_len, NULL, NULL);
	return apn_len;
}

int luat_mobile_get_default_apn(int sim_id, char* buff, size_t buf_len)
{
	return luat_mobile_get_apn(sim_id, -1, buff, buf_len);
}

int luat_mobile_set_apn(int sim_id, int cid, const char* buff, size_t buf_len)
{
	return -1;
}


// 进出飞行模式
int luat_mobile_set_flymode(int index, int mode)
{
	return appSetCFUN(!mode);
}

int luat_mobile_get_flymode(int index)
{
	uint8_t state;
	int result = appGetCFUN(&state);
	if (!result)
	{
		return state;
	}
	else
	{
		return -1;
	}
}

int luat_mobile_get_local_ip(int sim_id, int cid, ip_addr_t *ip_v4, ip_addr_t *ip_v6)
{
	int i;
	struct netif *netif = netif_find_by_cid(cid);
	if (netif)
	{
		if (ip_v4)
		{
			*ip_v4 = netif->ip_addr;
		}
		if (ip_v6)
		{
			ip_v6->type = 0xff;
			for(i = 0; i < LWIP_IPV6_NUM_ADDRESSES; i++)
			{
				if (netif->ip6_addr_state[i] & IP6_ADDR_VALID)
				{
					*ip_v6 = netif->ip6_addr[i];
				}
			}

		}
		return 0;
	}
	else
	{
		if (ip_v4)
		{
			ip_v4->type = 0xff;
		}
		if (ip_v6)
		{
			ip_v6->type = 0xff;
		}
		return -1;
	}

}

/* -------------------------------------------------- cell info begin -------------------------------------------------- */
uint8_t luat_mobile_rssi_to_csq(int8_t rssi)
{
	if (rssi <= -113)
	{
		return 0;
	}
	else if (rssi < -52)
	{
		return (rssi + 113) >> 1;
	}
	else
	{
		return 31;
	}
}

static void ec618_cell_to_luat_cell(BasicCellListInfo *bcListInfo, luat_mobile_cell_info_t *info)
{
	info->gsm_info_valid = 0;
	if (!bcListInfo->sCellPresent && !bcListInfo->nCellNum)
	{
		info->lte_info_valid = 0;
		return;
	}
	if (!bcListInfo->sCellPresent)
	{
		info->lte_service_info.cid = 0;
	}
	else
	{
		info->lte_service_info.cid = bcListInfo->sCellInfo.cellId;
		info->lte_service_info.band = bcListInfo->sCellInfo.band;
		info->lte_service_info.dlbandwidth = bcListInfo->sCellInfo.dlBandWidth;
		info->lte_service_info.ulbandwidth = bcListInfo->sCellInfo.ulBandWidth;
		info->lte_service_info.is_tdd = bcListInfo->sCellInfo.isTdd;
		info->lte_service_info.earfcn = bcListInfo->sCellInfo.earfcn;
		info->lte_service_info.pci = bcListInfo->sCellInfo.phyCellId;
		info->lte_service_info.tac = bcListInfo->sCellInfo.tac;
		info->lte_service_info.snr = bcListInfo->sCellInfo.snr;
		info->lte_service_info.rsrp = bcListInfo->sCellInfo.rsrp;
		info->lte_service_info.rsrq = bcListInfo->sCellInfo.rsrq;
		info->lte_service_info.rssi = bcListInfo->sCellInfo.rsrp - bcListInfo->sCellInfo.rsrq + (bcListInfo->sCellInfo.rssiCompensation/100);
		info->lte_service_info.mcc = bcListInfo->sCellInfo.plmn.mcc;
		if (0xf000 == (bcListInfo->sCellInfo.plmn.mncWithAddInfo & 0xf000))
		{
			info->lte_service_info.mnc = bcListInfo->sCellInfo.plmn.mncWithAddInfo & 0x0fff;
		}
		else
		{
			info->lte_service_info.mnc = bcListInfo->sCellInfo.plmn.mncWithAddInfo;
		}

	}

	if (!bcListInfo->nCellNum)
	{
		info->lte_neighbor_info_num = 0;
	}
	else
	{
		uint8_t j = 0;
		for(uint8_t i = 0; i < bcListInfo->nCellNum; i++)
		{
			if (bcListInfo->nCellList[i].cellInfoValid)
			{
				info->lte_info[j].cid = bcListInfo->nCellList[i].cellId;
				info->lte_info[j].tac = bcListInfo->nCellList[i].tac;
				info->lte_info[j].mcc = bcListInfo->nCellList[i].plmn.mcc;

				if (0xf000 == (bcListInfo->nCellList[i].plmn.mncWithAddInfo & 0xf000))
				{
					info->lte_info[j].mnc = bcListInfo->nCellList[i].plmn.mncWithAddInfo & 0x0fff;
				}
				else
				{
					info->lte_info[j].mnc = bcListInfo->nCellList[i].plmn.mncWithAddInfo;
				}
			}
			else
			{
				info->lte_info[j].cid = 0;
				info->lte_info[j].tac = 0;
				info->lte_info[j].mcc = 0;
				info->lte_info[j].mnc = 0;
			}
			info->lte_info[j].earfcn = bcListInfo->nCellList[i].earfcn;
			info->lte_info[j].pci = bcListInfo->nCellList[i].phyCellId;
			info->lte_info[j].snr = bcListInfo->nCellList[i].snr;
			info->lte_info[j].rsrp = bcListInfo->nCellList[i].rsrp;
			info->lte_info[j].rsrq = bcListInfo->nCellList[i].rsrq;
			if ((info->lte_info[j].mcc == 0x0460) && (info->lte_info[j].mnc != 0x0015))
			{
				j++;

			}
		}
		info->lte_neighbor_info_num = j;
	}
}

static void ec618_signal_to_luat_signal(CmiMmCesqInd *cesq_info, luat_mobile_signal_strength_info_t *info)
{
	uint8_t zero[16] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	info->luat_mobile_gw_signal_strength_vaild = 0;
	if (memcmp(zero, cesq_info, sizeof(CmiMmCesqInd)))
	{
		info->luat_mobile_lte_signal_strength_vaild = 1;
	    if (cesq_info->rsrp != CMI_MM_NOT_DETECT_RSRP)
	    {
	        if (cesq_info->rsrp > 0)
	        {
	        	info->lte_signal_strength.rsrp = (cesq_info->rsrp - 141);
	        }
	        else
	        {
	        	info->lte_signal_strength.rsrp = (cesq_info->rsrp - 140);
	        }
	    }
	    else
	    {
	    	info->lte_signal_strength.rsrp = -999;
	    }
	    if (cesq_info->rsrq != CMI_MM_NOT_DETECT_RSRQ)
	    {
	        if (cesq_info->rsrq <= 0)
	        {
	        	info->lte_signal_strength.rsrq = (cesq_info->rsrq - 39) >> 1;
	        }
	        else if (cesq_info->rsrq <= 34)
	        {
	        	info->lte_signal_strength.rsrq = (cesq_info->rsrq - 40) >> 1;
	        }
	        else
	        {
	        	info->lte_signal_strength.rsrq = (cesq_info->rsrq - 41) >> 1;
	        }
	    }
	    else
	    {
	    	info->lte_signal_strength.rsrq = -999;
	    }
		if (cesq_info->rsrp != CMI_MM_NOT_DETECT_RSRP &&
				cesq_info->rsrq != CMI_MM_NOT_DETECT_RSRQ)
		{
			info->lte_signal_strength.rssi = info->lte_signal_strength.rsrp - info->lte_signal_strength.rsrq + (cesq_info->rssiCompensation/100);

		}
		else
		{
			info->lte_signal_strength.rssi = -999;
		}
		info->lte_signal_strength.snr = cesq_info->snr;

	}
	else
	{
		info->luat_mobile_lte_signal_strength_vaild = 0;
	}
}

int luat_mobile_get_cell_info(luat_mobile_cell_info_t  *info)
{
	BasicCellListInfo bcListInfo;
	int result = appGetECBCInfoSync(&bcListInfo);
	if (!result)
	{
		ec618_cell_to_luat_cell(&bcListInfo, info);
		return 0;
	}
	else
	{
		return -1;
	}
}

int luat_mobile_get_cell_info_async(uint8_t max_time)
{
	soc_mobile_search_cell_info_async(max_time);
	return 0;
}

int luat_mobile_get_last_notify_cell_info(luat_mobile_cell_info_t  *info)
{
	BasicCellListInfo bcListInfo;
	soc_mobile_get_cell_info(&bcListInfo);
	ec618_cell_to_luat_cell(&bcListInfo, info);
	return 0;
}


int luat_mobile_get_signal_strength_info(luat_mobile_signal_strength_info_t *info)
{
	return luat_mobile_get_last_notify_signal_strength_info(info);
}

int luat_mobile_get_signal_strength(uint8_t *csq)
{
	return luat_mobile_get_last_notify_signal_strength(csq);
}

int luat_mobile_get_last_notify_signal_strength_info(luat_mobile_signal_strength_info_t *info)
{
	CmiMmCesqInd cesq_info;
	soc_mobile_get_signal(&cesq_info);
	ec618_signal_to_luat_signal(&cesq_info, info);
	return 0;
}

int luat_mobile_get_last_notify_signal_strength(uint8_t *csq)
{
	*csq = soc_mobile_get_csq();
	return 0;
}
/* --------------------------------------------------- cell info end --------------------------------------------------- */


/* ------------------------------------------------ mobile status begin ----------------------------------------------- */
LUAT_MOBILE_REGISTER_STATUS_E luat_mobile_get_register_status(void)
{
	CeregGetStateParams param;
	int result = appGetCeregStateSync(&param);
	if (!result)
	{
		return param.state;
	}
	return LUAT_MOBILE_STATUS_UNKNOW;
}

int luat_mobile_event_register_handler(luat_mobile_event_callback_t callback_fun)
{
	soc_mobile_event_register_handler(callback_fun);
	return 0;
}
int luat_mobile_event_deregister_handler(void)
{
	soc_mobile_event_deregister_handler();
	return 0;
}

int luat_mobile_sms_event_register_handler(luat_mobile_sms_event_callback_t callback_fun)
{
	soc_mobile_sms_event_register_handler(callback_fun);
	return 0;
}

/* ------------------------------------------------- mobile status end ------------------------------------------------ */

extern soc_mobile_set_rrc_release_time(uint8_t s);
void luat_mobile_set_rrc_auto_release_time(uint8_t s)
{
	soc_mobile_set_rrc_release_time(s);
}

extern void soc_mobile_release_rrc_pause(uint8_t onoff);
void luat_mobile_rrc_auto_release_pause(uint8_t onoff)
{
	soc_mobile_release_rrc_pause(onoff);
}

extern void soc_mobile_rrc_release_once(void);
void luat_mobile_rrc_release_once(void)
{
	soc_mobile_rrc_release_once();
}

int luat_mobile_reset_stack(void)
{
	soc_mobile_reset_stack();
	return 0;
}

int luat_mobile_set_period_work(uint32_t get_cell_period, uint32_t check_sim_period, uint8_t search_cell_time)
{
	soc_mobile_set_period(get_cell_period, check_sim_period, search_cell_time);
	return 0;
}
