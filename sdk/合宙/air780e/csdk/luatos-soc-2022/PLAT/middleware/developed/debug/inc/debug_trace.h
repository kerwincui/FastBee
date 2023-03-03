/****************************************************************************
*
* Copy right:   2017-, Copyrigths of AirM2M Ltd.
* File name:      debug_trace.h
* Description:  Caterpiller software debug trace function header file
* History:      Rev1.0   2018-07-12
*
****************************************************************************/

#ifndef _DEBUG_TRACE_H
#define _DEBUG_TRACE_H

#include <stdbool.h>
#include <stdint.h>
#include "unilog.h"
#include "cmsis_compiler.h"

#ifdef __cplusplus
extern "C" {
#endif

#define UNILOG_CAT2(a, b)             a##b
#define UNILOG_PASTE2(a, b)           UNILOG_CAT2(a, b)
#define UNILOG_PASTE3(a, b, c)        UNILOG_PASTE2(UNILOG_PASTE2(a, b), c)
#define UNILOG_PASTE4(a, b, c, d)     UNILOG_PASTE2(UNILOG_PASTE3(a, b, c), d)
#define UNILOG_UNIQUE_ID(ownerId, moduleId) \
        UNILOG_PASTE4(ownerId##__##moduleId##__, __CURRENT_FILE_NAME__, _, __LINE__)

#define HIGH_LEVEL_LOG_NUM_CHECK_THRD           30
#define HIGH_LEVEL_LOG_PERCENT_IN_EACH_MODULE   50

#if 0
#define coap_log(LogLevel, format, ...) \
do \
{  \
    swLogPrintf(UNILOG_UNIQUE_ID(UNILOG_PHY_LOG, UNILOG_COAP), LogLevel, ##__VA_ARGS__); \
    {(void)format;}                         \
} while(0)

#define LOGE(format, ...) \
do \
{  \
    swLogPrintf(UNILOG_UNIQUE_ID(UNILOG_PS_LOG, UNILOG_ONENET), P_ERROR, ##__VA_ARGS__); \
    {(void)format;}                         \
} while(0)

#define lwm2m_printf(format, ...) \
do \
{  \
    swLogPrintf(UNILOG_UNIQUE_ID(UNILOG_PLA_LOG, UNILOG_LWM2M), P_INFO, ##__VA_ARGS__); \
    {(void)format;}                         \
} while(0)
#endif

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
 *    Log length MAX: 2047 bytes
*/

/*
 * Owner ID, 4 bits
 * !!!! Not suggest to change it, if need to add new one, please contact AirM2M !!!!
*/
typedef enum
{
    UNILOG_PHY_ONLINE        = 0,
    UNILOG_PHY_OFFLINE       = 1,
    UNILOG_PLAT_AP           = 2,
    UNILOG_PLAT_CP           = 3,
    UNILOG_PS1               = 4,
    UNILOG_PS2               = 5,
    UNILOG_CUSTOMER          = 6,
/**< Add new owener ID below */

    UNILOG_OWNERID_MAX       = 15
}UniLogOwnerIdType_e;

/*
 * ModId: 7 bits
 * module ID for owerId: UNILOG_PLAT
 */
typedef enum
{
    UNILOG_SIG_DUMP = 0,    /**< used for SIG dump, only used in internal */
    UNILOG_PLA_STRING = 1,
    UNILOG_PLA_INTERNAL_CMD = 2,/**< used for fix ID log, easy for EPAT to catch the msg e.g. enter dump mode */
    UNILOG_PLA_DRIVER,
    UNILOG_PLA_HAL,
    UNILOG_EXCEP_PRINT,
    UNILOG_OSA,
    UNILOG_PMU,
    UNILOG_CCIO,

    UNILOG_ATCMD = 10,
    UNILOG_ATCMD_PARSER,
    UNILOG_ATCMD_EXEC,
    UNILOG_ATCMD_LWM2M,
    UNILOG_ATCMD_SOCK,
    UNILOG_PS_DIAL,
    UNILOG_PS_STK_BIP,
    UNILOG_CMS,
    UNILOG_SIM_BIP,
    UNILOG_PS_LPP = 20,
    UNILOG_CMS_PS_IL,       //CMS interface layer, CMS/psil
    UNILOG_CMS_SOCK_MGR,
    UNILOG_EC_API,          //ECAPI

    UNILOG_IP_PKG_DUMP = 30,
    UNILOG_LWIP_CORE,
    UNILOG_LWIP_CORE_IP,
    UNILOG_LWIP_API,
    UNILOG_LWIP_OTHER,
    UNILOG_LWIP_PPP,
    UNILOG_TCPIP_NETMGR,
    UNILOG_TCPIP_NETADPT,
    UNILOG_TCPIP_TLS,
    UNILOG_TCPIP_APP,
    UNILOG_TCPIP_DHCPD = 40,
    UNILOG_TCPIP_SDK_API,
    UNILOG_TCPIP_PKG_DUMP,
    UNILOG_ROHC,
    UNILOG_ROHC_COMP,
    UNILOG_ROHC_DECOMP,

    UNILOG_LFS = 50,
    UNILOG_MQTT,
    UNILOG_HTTP,
    UNILOG_SSL,
    UNILOG_PLA_MIDWARE,  //MidWare
    UNILOG_PLA_APP,
    UNILOG_PLA_RAMDUMP = 60,
    UNILOG_DM,
    UNILOG_FOTA,
    UNILOG_ABUP_FOTA,
    UNILOG_ABUP_APP,
    UNILOG_CTWING,

    /*
     * PLAT add here
    */
    UNILOG_PLAT_MOD_MAX = 127
}UniLogPlatModIdType_e;

/*
 * ModId: 7 bits
 * module ID for owerId: UNILOG_CUSTOMER
*/
typedef enum
{
    /*
     * !!! for customer SDK development, please add here !!!!
    */
	UNILOG_LUATOS,
    UNILOG_CUST_MOD_MAX = 127
}UniLogCustModIdType_e;


/** \brief trace level */
typedef enum {
    P_DEBUG,           /**< debug, lowest priority */
    P_INFO,            /**< info */
    P_VALUE,           /**< value */
    P_SIG,             /**< signalling/significant */
    P_WARNING,         /**< warning */
    P_ERROR            /**< error, highest priority */
} DebugTraceLevelType_e;

// Move unilog interface to here
extern void uniLogDebugLevelSet(DebugTraceLevelType_e debugLevel);
extern void uniLogInitStart(UnilogPeripheralType_e periphType);

#define ECOMM_HEX_DUMP(owenerID, moduleID, subID, debugLevel, format, dumpLen, dump)    \
do  \
{   \
    swLogDump(owenerID##__##moduleID##__##subID, debugLevel, dumpLen, dump);    \
    {(void)format;} \
}while(0)



#define ECOMM_PRINTF(ownerId, moduleId, subId, debugLevel, format, ...) \
do  \
{   \
    swLogPrintf(ownerId##__##moduleId##__##subId, debugLevel, ##__VA_ARGS__); \
    {(void)format;} \
}while(0)


/*
 * compat with old API, not suggest to use it anymore
*/
#define ECOMM_TRACE(moduleId, subId, debugLevel, argLen, format,  ...)  \
    ECOMM_PRINTF(UNILOG_PLAT_AP, moduleId, subId, debugLevel, format, ##__VA_ARGS__)

/*
 * compat with old API, not suggest to use it anymore
*/
#define ECOMM_DUMP(moduleID, subID, debugLevel, format, dumpLen, dump)  \
    ECOMM_HEX_DUMP(UNILOG_PLAT_AP, moduleID, subID, debugLevel, format, dumpLen, dump)

/*
 * excep print API, suggest to use it
*/
        
#define EXCEP_PRINTF(ownerId, moduleId, subId, debugLevel, format, ...) \
        do  \
        {   \
            swLogExcep(ownerId##__##moduleId##__##subId, debugLevel, ##__VA_ARGS__); \
            {(void)format;} \
        }while(0)
        
#define EXCEP_TRACE(moduleId, subId, debugLevel, argLen, format,  ...)  \
        EXCEP_PRINTF(UNILOG_PLAT_AP, moduleId, subId, debugLevel, format, ##__VA_ARGS__)

#ifdef CORE_IS_CP
#define ECEXCEP_PRINTF(moduleId, subId, debugLevel, format, ...)    \
    EXCEP_PRINTF(UNILOG_PLAT_CP, moduleId, subId, debugLevel, format, ##__VA_ARGS__)
#else
#define ECEXCEP_PRINTF(moduleId, subId, debugLevel, format, ...)    \
    EXCEP_PRINTF(UNILOG_PLAT_AP, moduleId, subId, debugLevel, format, ##__VA_ARGS__)
#endif

/*
 * PLAT print API, suggest to use it
*/
#ifdef CORE_IS_CP
#define ECPLAT_PRINTF(moduleId, subId, debugLevel, format, ...)    \
    ECOMM_PRINTF(UNILOG_PLAT_CP, moduleId, subId, debugLevel, format, ##__VA_ARGS__)
#else
#define ECPLAT_PRINTF(moduleId, subId, debugLevel, format, ...)    \
    ECOMM_PRINTF(UNILOG_PLAT_AP, moduleId, subId, debugLevel, format, ##__VA_ARGS__)
#endif

/*
 * PLAT dump API, suggest to use it
*/
#ifdef CORE_IS_CP
#define ECPLAT_DUMP(moduleID, subID, debugLevel, format, dumpLen, dump)  \
    ECOMM_HEX_DUMP(UNILOG_PLAT_CP, moduleID, subID, debugLevel, format, dumpLen, dump)
#else
#define ECPLAT_DUMP(moduleID, subID, debugLevel, format, dumpLen, dump)  \
    ECOMM_HEX_DUMP(UNILOG_PLAT_AP, moduleID, subID, debugLevel, format, dumpLen, dump)
#endif

/*
 * !!! used for customer SDK print !!!
*/
#define ECCUST_PRINTF(moduleId, subId, debugLevel, format, ...)    \
    ECOMM_PRINTF(UNILOG_CUSTOMER, moduleId, subId, debugLevel, format, ##__VA_ARGS__)

/*
 * !!! used for customer SDK dump !!!
*/
#define ECCUST_DUMP(moduleID, subID, debugLevel, format, dumpLen, dump)    \
    ECOMM_HEX_DUMP(UNILOG_CUSTOMER,  moduleID, subID, debugLevel, format, dumpLen, dump)


#ifdef __cplusplus
}
#endif

#endif// _DEBUG_TRACE_H

