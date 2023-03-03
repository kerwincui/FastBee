/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    apmu_external.h
 * Description:  EC618 platform power management header file
 * History:      05/28/2018    Originated by bchang
 * A77F40058A2024A1DB6C8CDCD7888A53
 ****************************************************************************/

#ifndef _EC_PM_EXT_H
#define _EC_PM_EXT_H

#ifdef __cplusplus
 extern "C" {
#endif
#include <stdbool.h>
#include "mem_map.h"
#include "commontypedef.h"


extern uint8_t apFlashMem[];
extern uint8_t psSleep2Mem[];


#define PS_PMUTIME_TEST             (1)

#define PMU_ENABLE_MAGIC    0x504D5545  //"PMUE"
#define PMU_DISABLE_MAGIC   0x504D5544  //"PMUD"

/* HIBCNT maximum value is 745 hours  */
#define HIBCNT_10MS_MAXIMUM  0x0FFFFFFF

#define DEEPSLP_TIMER_MAXRANGE          0x9EC96A00          // ticks in 740 hours

/******************************************************************************
 * For CAT1bis:
 * AP total AON RAM (Flash) 12 KB memory:
 * AON MEM
 * |<-------------------------- 4KB ------------------------------->|
 * +---------+-----------------+---------+-------------+------------+
 * |PLAT (1K)|     MIDWARE     |LWIP (1K)|  CERRC BOOT |  ERASECNT  |
 * +---------+-----------------+---------+-------------+------------+
 * |<- 1KB ->|<-- 1792 Byte -->|<- 1KB ->|<- 252 Byte->|<- 4 Byte ->|
 *
 * |<-------------------------- 4KB ------------------------------->|
 * +---------------------------------------------------+------------+
 * |                  RRC Tiny Context                 |  ERASECNT  |
 * +---------------------------------------------------+------------+
 * |                                                   |<- 4 Byte ->|
 *
 * |<-------------------------- 4KB ------------------------------->|
 * +---------------------------------------------------+------------+
 * |      CAM CCM NAS(CEPLMN/CEMM/CESM/SMS) UICC L2    |  ERASECNT  |
 * +---------------------------------------------------+------------+
 *                                                     |<- 4 Byte ->|
 *
 *=============================================================================
 * Note:
 * 1> All these 12 KB RAM, located in ASMB, and write back to flash before enter
 *    HIB state, if any context changed.
 * 2> Only the first 4KB context need read to ASMB when wakeup from HIB to receive
 *     paging.
 *
******************************************************************************/

/*****
 * 4KB AON MEM 0
*****/
#define APMU_PLAT_AON_MEM_SIZE          (1024)   //1KB
#define APMU_MID_WARE_AON_MEM_SIZE      (1792)   //1024+768
#define APMU_TCPIP_AON_MEM_SIZE         (1024)
#define APMU_CERRC_BOOT_AON_MEM_SIZE    (252)


#define PLAT_AON_MEM_ADDR               (apFlashMem)
#define MID_WARE_AON_MEM_ADDR           (apFlashMem + APMU_PLAT_AON_MEM_SIZE)
#define TCPIP_AON_MEM_ADDR              (MID_WARE_AON_MEM_ADDR + APMU_MID_WARE_AON_MEM_SIZE)
#define CERRC_BOOT_AON_MEM_ADDR         (TCPIP_AON_MEM_ADDR + APMU_TCPIP_AON_MEM_SIZE)

/*****
 * 4KB AON MEM 1
*****/
#define PS_AON_MEM_1_ADDR               (apFlashMem + 4096)


/*****
 * 4KB AON MEM 2
*****/
#define PS_AON_MEM_2_ADDR               (apFlashMem + 8192)



/******************************************************************************
 * SLEEP2 AP MEM
 *  4KB memory which could remain during SLEEP2 PMU state
 *  Total
 * +-----------------------------+
 * |   PS SLEEP2 MEM (4KB)       |
 * +-----------------------------+
 * |<----------- 4K ------------>|
 *
******************************************************************************/
#define PS_SLEEP2_MEM_ADDR              psSleep2Mem
#define PS_SLEEP2_MEM_SIZE              4096    //4KB


#define HIB_SECONDS_TO_TICKS(S) (UINT32)(S)
#define HIB_MINUTES_TO_TICKS(M) (HIB_SECONDS_TO_TICKS(M)*60)


//list which module should vote before system enter sleep state
typedef enum PmuVoteSleepModule_enum
{
    PMU_SLEEP_UICC_MOD,
    PMU_SLEEP_SCT_MOD,
    PMU_SLEEP_AT_UART_MOD,
    PMU_SLEEP_NUM_OF_MOD
}PmuVoteSleepModule;

/*
 * list which module should vote before system enter hib state
 */
typedef enum PmuVoteDeepSlpModule_enum
{
    PMU_DEEPSLP_PS_CCM_MOD,
    PMU_DEEPSLP_PS_CEMM_MOD,
    PMU_DEEPSLP_PS_CERRC_MOD,
    PMU_DEEPSLP_PS_UICC_MOD,
    PMU_DEEPSLP_PS_LWIP_MOD,
    PMU_DEEPSLP_CMS_MOD,

    PMU_DEEPSLP_PS_CEUP_MOD,    /* Note, CEUP MOD should be last,
                                 * as the UP preSleep Callback need check whether other module tiny context changed
                                */
    //...
    PMU_DEEPSLP_NUM_OF_MOD
}PmuVoteDeepSlpModule;


/*
 * list which module should vote before system enter off state
 */
typedef enum PmuVoteOffModule_enum
{
    PMU_OFF_MODEM_MOD,          /* modem vote off state, call when cfun0 success */
    PMU_OFF_USR_MOD,            /* user vote off state, user call api to enable off state*/

    PMU_OFF_NUM_OF_MOD
}PmuVoteOffModule;


/*
* |<-------------------------- 4KB ------------------------------->|
* +---------+-----------------+---------+-------------+------------+
* |PLAT (1K)|     MIDWARE     |LWIP (1K)|  CERRC BOOT |  ERASECNT  |
* +---------+-----------------+---------+-------------+------------+
* |<- 1KB ->|<-- 1792 Byte -->|<- 1KB ->|<- 252 Byte->|<- 4 Byte ->|
*
* |<-------------------------- 4KB ------------------------------->|
* +---------------------------------------------------+------------+
* |                  RRC Tiny Context                 |  ERASECNT  |
* +---------------------------------------------------+------------+
* |                                                   |<- 4 Byte ->|
*
* |<-------------------------- 4KB ------------------------------->|
* +---------------------------------------------------+------------+
* |      CAM CCM NAS(CEPLMN/CEMM/CESM/SMS) UICC L2    |  ERASECNT  |
* +---------------------------------------------------+------------+
*                                                     |<- 4 Byte ->|
*/
typedef enum
{
    /* 4KB, flash sector 0 */
    AP_FLASHREQ_HIBTIMER = 0,
    AP_FLASHREQ_GLOBALCNT,
    AP_FLASHREQ_MIDWARE_CFG,
    AP_FLASHREQ_MIDWARE_AON,
    AP_FLASHREQ_LWIP,
    AP_FLASHREQ_CERRC_BOOT,
    AP_FLASHREQ_SECTOR0_END = AP_FLASHREQ_CERRC_BOOT,

    /* 4KB, flash sector 1 */
    AP_FLASHREQ_RRC,
    AP_FLASHREQ_SECTOR1_END = AP_FLASHREQ_RRC,

    /* 4KB, flash sector 2 */
    AP_FLASHREQ_CCM,
    AP_FLASHREQ_NAS,
    AP_FLASHREQ_UICC,
    AP_FLASHREQ_L2,
    AP_FLASHREQ_PDCP_PKG_STATIS,
    AP_FLASHREQ_SECTOR2_END = AP_FLASHREQ_PDCP_PKG_STATIS,

    /* 4KB, flash sector 3 */
    AP_FLASHREQ_RSVD,
    AP_FLASHREQ_SECTOR3_END = AP_FLASHREQ_RSVD,

}APFlashWrReq_e;

typedef enum _EPAT_APSleepState_TAG
{
    AP_STATE_ACTIVE=0,
    AP_STATE_IDLE,
    AP_STATE_SLEEP1,
    AP_STATE_SLEEP2,
    AP_STATE_HIBERNATE,
    AP_STATE_OFF,
    NUM_AP_LP_MODE
} APSleepState;

typedef enum _EPAT_APBootFlag_e_TAG
{
    AP_BOOT_FROM_POWER_ON = 0x0,
    AP_BOOT_FROM_UNDEF = 0x1,
    AP_BOOT_FROM_AS1 = 0x2,
    AP_BOOT_FROM_AS2 = 0x3,
    AP_BOOT_FROM_AH = 0x4,
    AP_BOOT_FROM_AO = 0x5,
}APBootFlag_e;


typedef enum _pmuen_config_id
{
    PLAT_DISABLE_CONFIG_ACTION = 0,     /**< pmu disable item */
    PLAT_ENABLE_CONFIG_ACTION,          /**< pmu enable item */
    PLAT_ENABLE_ITEM_TOTAL_NUMBER       /**< total number of items */
} PmuEnCfgId;


//internal pmu vote for platform use
typedef enum PmuVotePlatInternal_enum
{
    PMU_SLEEP_ATCMD_MOD,        // vote to sleep when receive some at command
    PMU_SLEEP_NUM_OF_Other_MOD
}PmuVotePlatInternal;


typedef enum
{
	WAKEUP_PAD_0 = 0,
	WAKEUP_PAD_1,
	WAKEUP_PAD_2,
	WAKEUP_PAD_3,
	WAKEUP_PAD_4,
	WAKEUP_PAD_5,
	WAKEUP_LPUART,
	WAKEUP_LPUSB,
	WAKEUP_PWRKEY,
	WAKEUP_CHARGE,
	WAKEUP_PAD_MAX
}APmuWakeupPad_e;

typedef struct
{
	bool posEdgeEn;
	bool negEdgeEn;
	bool pullUpEn;
	bool pullDownEn;
}APmuWakeupPadSettings_t;


typedef void(* pmuPreDeepSlpCb_t)(void *pdata, APSleepState state);
typedef void(* pmuPostDeepSlpCb_t)(void *pdata, APSleepState state);


void apmuVoteToSleep1State(PmuVoteSleepModule pmuMod, BOOL bAllow);
void apmuVoteToSleep2State(PmuVoteDeepSlpModule pmuMod, BOOL bAllow);
void apmuVoteToHibState(PmuVoteDeepSlpModule pmuMod, BOOL bAllow);
void apmuVoteToOffState(PmuVoteOffModule pmuMod, BOOL bAllow);
BOOL apmuBVoteToSleep1State(PmuVoteSleepModule pmuMod);
BOOL apmuBVoteToSleep2State(PmuVoteDeepSlpModule pmuMod);
BOOL apmuBVoteToHibState(PmuVoteDeepSlpModule pmuMod);
BOOL apmuBVoteToSleep1State(PmuVoteSleepModule pmuMod);
void apmuGetSDKVoteDetail(uint32_t *sleepVoteFlag, uint32_t *sleep2VoteFlag, uint32_t *hibVoteFlag);
void apmuSetDeepestSleepMode(APSleepState state);
APSleepState apmuGetDeepestSleepMode(void);
BOOL apmuBWakeupFromHib(void);
BOOL apmuBWakeupFromSleep1(void);
BOOL apmuBWakeupFromSleep2(void);
BOOL pmuBPsVoteToDeepSAPSleepState(void);
uint32_t apmuBuildWaitSlpCfg(uint32_t value);
uint32_t apmuGetWaitSlpCfg(uint32_t value);
void apmuSdkFlashWrReq(APFlashWrReq_e reqID);
BOOL apmuSdkFlashBlockBeWr(APFlashWrReq_e reqID);
void apmuPreDeepSlpCbRegister(PmuVoteDeepSlpModule module, pmuPreDeepSlpCb_t cb, void *pdata);
void apmuPostDeepSlpCbRegister(PmuVoteDeepSlpModule module, pmuPostDeepSlpCb_t cb, void *pdata);
void apmuGetPMUSettings(APSleepState defaultState);
BOOL apmuBPsVoteToDeepSlpState(void);
bool apmuGetSleepedFlag(void);
void apmuPrintPostPagingSlowCnt(void);
uint16_t apmuGetLatchExternalInt(void);
void ApmuWakeupProc(uint8_t wakeupEvent, uint8_t branchFlag);

/**
* @brief apmuSetWakeupPadCfg
* @details set a specific pad as a wakeup pad and control the wakeup edge and pull settings
* @return
* @note
*/
void apmuSetWakeupPadCfg(APmuWakeupPad_e padNum, bool wakeupEn, APmuWakeupPadSettings_t *cfg);
/**
* @brief apmuGetWakeupPadCfg
* @details get wakeup pad config
* @return
* @note
*/
void apmuGetWakeupPadCfg(APmuWakeupPad_e padNum, bool *isWakeupEn, APmuWakeupPadSettings_t *cfg);
/**
* @brief apmuGetAPBootFlag
* @details get AP Boot Flag
* @return
* @note
*/
APBootFlag_e apmuGetAPBootFlag(void);
/**
* @brief apmuGetAPLLBootFlag
* @details get AP LLBoot Flag
* @return
* @note
*/
APBootFlag_e apmuGetAPLLBootFlag(void);
/**
* @brief apmuIntInit
* @details enable ap interrupt
* @return
* @note
*/
void apmuIntInit(void);
/**
* @brief apmuRestoreHibTimer
* @details retore hib timer
* @return
* @note
*/
void apmuRestoreHibTimer(void);
/**
* @brief apmuSetSwWakeupSlowCnt
* @details get a slowcnt as soon as the software wakeup, this api call in ram
* @note
*/
void apmuSetSwWakeupSlowCnt(void);
/**
* @brief apmuSetSwWakeupSlowCnt
* @details get a slowcnt as soon as the software wakeup, this api call in flash
* @note
*/
void apmuSetSwWakeupSlowCntFlash(void);
/**
* @brief apmuGetBT10MsCnt
* @details get BT counter in 10ms, for hibcnt
* @note
*/
uint32_t apmuGetBT10MsCnt(void);
/**
* @brief apmuGetBTMsCnt
* @details get BT counter in 1ms, for system time check
* @note
*/
uint32_t apmuGetBTMsCnt(void);
/**
* @brief apmuGetBTSampleCnt
* @details get accurate BT counter in 30.72M
            [31:15]: in milisecond
            [14: 0]: 30720 in 1 milisecond
* @note
*/
uint32_t apmuGetBTSampleCnt(void);
/**
* @brief apmuSetCPFastBoot
* @details set cp fast boot, but not power on cp

* @param force_on =true if cp code is not valid still config fast boot
         force_on=false if cp code is not valid do not config fast boot

* @note
*/
void apmuSetCPFastBoot(bool force_on);
/**
* @brief apmuPsFullImageTransfer
* @details set toFullImage = true if ps want to go full image

* @param toFullImage =true if ps want to go full image
         toFullImage=false continue to loop in ap paging
* @note
*/
void apmuPsFullImageTransfer(bool toFullImage);
/**
* @brief ApmuWtdgStop
* @details aon watchdog is start in closed source api when power on, but can close through calling this api

* @note
*/
void ApmuWtdgStop(void);
/**
* @brief ApmuWtdgStop
* @details feed aon watch dog
* @note
*/
void ApmuFeedWtdg(void);
/**
* @brief restore boot flag to RAM var
* @details called when paltform boot up to record golbal boot flag

* @note
*/
void apmuRestoreBootFlag(void);
/**
* @brief AonRegGetAPBootFlag
* @details get ap bootflag

* @note
*/
uint8_t AonRegGetAPBootFlag(void);
/**
* @brief AonRegSetSimLatchEnable
* @details for uicc use

* @note
*/
void AonRegSetSimLatchEnable(bool en);
/**
* @brief AonRegGetSimLatchState
* @details for uicc use

* @note
*/
bool AonRegGetSimLatchState(void);
/**
* @brief apmuGetImageType
* @details get current image type
* @note
*/
uint8_t apmuGetImageType(void);
/**
* @brief apmuSetBootTimeStamp
* @details set and store time stamp in boot flow
* @note
*/
void apmuSetBootTimeStamp(bool isPostPaging, uint8_t index);
/**
* @brief apmuPrintBootTimeStamp
* @details print time stamp in boot flow
* @note
*/
void apmuPrintBootTimeStamp(bool isPostPaging);
/**
* @brief apmuBTChangedFlag(int value)
* @details indicate bt has changed, param value is for debug, always set to 0
* @note
*/
void apmuBTChangedFlag(int value);
/**
* @brief void apmuInit(void)
* @details apmu init
* @note
*/
void apmuInit(void);

#define BOOT_TIMESTAMP_SET(type, index)     apmuSetBootTimeStamp(type, index)
#define BOOT_TIMESTAMP_PRINT(type)          apmuPrintBootTimeStamp(type)


#ifdef __cplusplus
}
#endif

#endif

