#ifndef __PS_TRACE_H__
#define __PS_TRACE_H__

/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017, All rights reserved by AirM2M
 File name:      - pstrace.h
 Description:    - PS unilog trace header
 History:        - 2020/11/24, Originated by Jason
 ******************************************************************************
******************************************************************************/

/******************************************************************************
 * include OS header files
******************************************************************************/
#ifndef WIN32
#include "debug_trace.h"
#endif

/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/

/*
 * EC618 unilog header/Payload0 (UINT32) struct:
 * 31    28 27     23  21 20     16 15        9   8 7             0
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 * | ownId |     modId   |       subId       |     payLoadLen      |
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 * A> ownId[28:31], 4 bits
 *    UniLogOwnerIdType: UNILOG_PLAT/UNILOG_MIDWARE/UNILOG_PS1/UNILOG_PS2/
 *                       UNILOG_PHY_ONLINE/UNILOG_PHY_OFFLINE/UNILOG_APP/...
 * B> modId[21:27], 7 bits, MAX: 127
 * C> subId[11:20], 10 bits, MAX: 1023
 * D> payLoadLen[0:10], 11 bits
 *    Log length MAX: 2023 bytes
*/



/******************************************************************************
 *****************************************************************************
 * STRUCT/ENUM
 *****************************************************************************
******************************************************************************/

/*
 * Module ID defination for owner: UNILOG_PS1
*/
typedef enum UniLogPs1ModIdType_enum
{
    UNILOG_PS_DUMP = 0,   /**< used for PS HEX dump */

    UNILOG_NB_RRC_BCCH_BCH_DUMP = 1,
    UNILOG_NB_RRC_BCCH_DL_SCH_DUMP,
    UNILOG_NB_RRC_DL_CCCH_DUMP,
    UNILOG_NB_RRC_DL_DCCH_DUMP,
    UNILOG_NB_RRC_DL_PCCH_DUMP,
    UNILOG_NB_RRC_UL_CCCH_DUMP,
    UNILOG_NB_RRC_UL_DCCH_DUMP,

    UNILOG_LTE_RRC_BCCH_BCH_DUMP,
    UNILOG_LTE_RRC_BCCH_DL_SCH_DUMP,
    UNILOG_LTE_RRC_BCCH_DL_SCH_BR_DUMP,
    UNILOG_LTE_RRC_DL_CCCH_DUMP,
    UNILOG_LTE_RRC_DL_DCCH_DUMP,
    UNILOG_LTE_RRC_DL_PCCH_DUMP,
    UNILOG_LTE_RRC_SC_MCCH_DUMP,
    UNILOG_LTE_RRC_UL_CCCH_DUMP,
    UNILOG_LTE_RRC_UL_DCCH_DUMP,
    UNILOG_LTE_RRC_VAR_MEASCONFIG_DUMP,

    UNILOG_EPS_SECURITY_DUMP,
    UNILOG_EPS_PLAIN_DUMP,

    UNILOG_PS = 30,
    UNILOG_PS_SIG_DUMP,
    UNILOG_PS_INTER_MSG,
    UNILOG_UP,
    UNILOG_MAC,
    UNILOG_RLC,
    UNILOG_PDCP,
    UNILOG_BM,
    UNILOG_DR,
    UNILOG_CERRC = 40,
    UNILOG_NAS = 50,
    UNILOG_CEMM,
    UNILOG_CESM,
    UNILOG_SMS,
    UNILOG_SS,
    UNILOG_NAS_PLMN,
    UNILOG_UICC = 60,
    UNILOG_UICC_DRV,
    UNILOG_CCM = 70,
    UNILOG_CCM_REG,
    UNILOG_CCM_DEV,
    UNILOG_CCM_PS,
    UNILOG_CCM_SMS,
    UNILOG_CCM_SIM,
    UNILOG_CAM = 80,
    UNILOG_CAM_DEV,
    UNILOG_CAM_MM,
    UNILOG_CAM_PS,
    UNILOG_CAM_SIM,
    UNILOG_CAM_SMS,

    /*
     * PS1 modID add here
    */

    UNILOG_PS1_MOD_MAX = 127
}UniLogPs1ModIdType;


#ifndef WIN32
/*
 * used to compate: ECOMM_TRACE()
*/
#define ECPS_TRACE(moduleId, subId, debugLevel, argLen, format,  ...)           \
do                                                                              \
{                                                                               \
    swLogPrintf(UNILOG_PS1##__##moduleId##__##subId, debugLevel, ##__VA_ARGS__);    \
    {(void)format;}                                                             \
}while(0)

/*
 * New API: ECPS_PRINTF(), could print atmost: 8 parameters, and support string print
*/
#define ECPS_PRINTF(moduleId, subId, debugLevel, format, ...)                   \
do                                                                              \
{                                                                               \
    swLogPrintf(UNILOG_PS1##__##moduleId##__##subId, debugLevel, ##__VA_ARGS__);   \
    {(void)format;}                                                             \
}while(0)

/*
 * #define ECOMM_DUMP(moduleId, subId, debugLevel, format, dumpLen, dump)
*/
#define ECPS_DUMP(moduleId, subId, debugLevel, format, dumpLen, dump)           \
do                                                                              \
{                                                                               \
    swLogDump(UNILOG_PS1##__##moduleId##__##subId, debugLevel, dumpLen, dump);  \
    {(void)format;}                                                             \
}while(0)

/*
 * #define ECOMM_DUMP_POLLING(moduleID, subID, debugLevel, format, dumpLen, dump)
*/
#define ECPS_DUMP_POLLING(moduleId, subId, debugLevel, format, dumpLen, dump)   \
do                                                                              \
{                                                                               \
    swLogDumpPolling(UNILOG_PS1##__##moduleId##__##subId, debugLevel, dumpLen, dump);  \
    {(void)format;}                                                             \
}while(0)


#endif

/******************************************************************************
 ******************************************************************************
 * API
 ******************************************************************************
******************************************************************************/



#endif

