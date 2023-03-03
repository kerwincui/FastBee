#ifndef __PS_DIAL_H__
#define __PS_DIAL_H__
/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017- Copyrights of AirM2M Ltd.
 File name:      - psdial.h
 Description:    - DIAL functions
 History:        - 04/12/2018
 ******************************************************************************
******************************************************************************/
#include "cms_api.h"
#include "osasys.h"
#include "cmicomm.h"
#include "lwip/ip_addr.h"

/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/

/*
 * whether auto dial after power on
*/
#ifndef AT_POWER_ON_AUTO_DIAL
#define AT_POWER_ON_AUTO_DIAL 1
#endif

/*
 * DNS config parameter
*/
#define PS_DAIL_DEFAULT_DNS_NUM     2
#define PS_DAIL_IPV4_ADDR_LEN       4
#define PS_DAIL_IPV6_ADDR_LEN       16


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/*
 * PS DAIL context
*/
typedef struct PsDialContext_Tag
{
    UINT32      psTaskCreated : 1;  /* Whether PS tasks (CCM/NAS/RRC/AS/UICC) created.
                                     * 1> As PS tasks is not created when power on/wake up from deep sleep by default.
                                     *    Here, involved a flag to record it.
                                     * 2> When APP/AT need PS service, need to check this flag firstly, and if PS task
                                     *    is not created, need let/trigger PSDAIL to create PS tasks.
                                    */
    UINT32      psTaskReady : 1;    /* Whether PS tasks is ready to be accessed.
                                     * 1> If first power on, after PS task created, then set it to TRUE
                                     * 2> If wake up from deep sleep. after PS task created and PS wake up procedure done, then set it
                                     *     to TRUE.
                                    */
    UINT32      psNeedWakeup : 1;   /* Whether PS task need wake up before set to "Ready"
                                     * 1> Set to TRUE, when AP wake up from deep sleep, and PS task has created before.
                                     * 2> Set to TRUE, when AP OS (IDLE task) called enter deep sleep callback to cover the case:
                                     *    enter deep sleep failed, if a interrupt comes during enter deep sleep procedure.
                                     * 3> Set to TRUE, after PS task woken up.
                                     * Note:
                                     * 1> "psTaskReady" & "psNeedWakeup" can not both set to TRUE, just
                                     *   a) if "psNeedWakeup" = TRUE, "psTaskReady" must be FALSE
                                     *   b) if "psTaskReady" = TRUE, "psNeedWakeup" must be FALSE
                                     *   c) if "psNeedWakeup" = FALSE, "psTaskReady" could be TRUE or FALSE
                                    */


    //UINT32      bNetifActed : 1;    //netif/PDP state, in fact this flag should set in LWIP net-manager side
    UINT32      bActIfDuringWakeup : 1;  /* whether active bearer/netif during sleep2/hib wake up, proc:
                                          * 1> CGCONTRDP, to read all default bearers, linkup netmgr/lwip
                                          * 2> CGSCONTRDP, to read all dedicated bearers, linkup netmgr/lwip
                                          * 3> CGTFTRDP, to read all TFT config, config to netmgr/lwip
                                          * Set this value to FALSE, after all these done
                                         */
    UINT32      bSilentReset : 1;
    UINT32      rsvd0 : 3;

    UINT32      actingCid : 8;      /* current activating CID */
    UINT32      actingCidCgevReason: 4;     /* CmiPsPdnTypeReason, 1> psdail need it decide whether need to init another PDP, 2> netif also need it */
    UINT32      psConnStatus : 1;   /* 0 - RRC IDLE, 1- RRC connected */
    UINT32      bTrafficIdleTriggerTau:1; /* When Pdcp monitor traffic idle after a <idle_time> (set by AT+ECSCLKEX), notify psDial, then do as follows:
                                           * 1> Trigger UE to force to go idle
                                           * 2> After UE go idle, trigger a TAU to sync with NW.
                                           * 3> False: no need to trigger TAU after go idle as above.
                                           *    True : need to trigger TAU after go idle as above.
                                          */
    UINT32      rsvd1 : 10;

    CmiSimImsiStr   ueImsi;     //20 bytes
}PsDialContext;     //24 bytes


/*
 * PS DIAL AON info, save to flash, when enter HIB
*/
typedef struct PsDialAonInfo_Tag
{
    UINT32      cfunState   : 8;            /* CFUN state, CmiFuncValueEnum */
    UINT32      ceregState  : 4;            /* CEREG, CmiCeregStateEnum */
    UINT32      psTaskCreatedBefore : 1;    /* Whether PS task has been created before.
                                             * 1> Set to TRUE, once PS task created.
                                             * 2> No way to set FALSE.
                                             * Note: need it to decide whether need PS wakeup prcedure when PS task created
                                            */
    UINT32      bSmsReady : 1; /* Whether SMS init ready or not */
    UINT32      rsvd0 : 2;

    UINT32      rsvd1 : 16;
}PsDialAonInfo;


/*
 * PS DAIL DNS CONFIG
 * DNS order:
 * 1> NW configed DNS;
 * 2> DNS configed in NVM by AT CMD: AT+ECDNSCFG
 * 3> default configed DNS indexed by UE IMSI
*/
typedef struct PsDialDnsCfg_Tag
{
    UINT8 ipv4DnsNum ; //ipv4 valid dns num
    UINT8 ipv6DnsNum ; //ipv6 valid dns num
    UINT16 rsvd;
    ip4_addr_t ipv4Dns[PS_DAIL_DEFAULT_DNS_NUM];
    ip6_addr_t ipv6Dns[PS_DAIL_DEFAULT_DNS_NUM];

}PsDialDnsCfg;     //44 bytes

typedef enum {
    PS_DIAL_NET_TYPE_IPV4     = 0,
    PS_DIAL_NET_TYPE_IPV6     = 1,
    PS_DIAL_NET_TYPE_IPV4V6   = 2,
    PS_DIAL_NET_TYPE_INVALID  = 3,
}PsDialNetType;


/******************************************************************************
 ******************************************************************************
 * External global variable
 ******************************************************************************
******************************************************************************/

/*
 * This context save in AON memory
*/
extern PsDialAonInfo    *pDialAonInfo;

/*
 * PS dial static context
*/
extern PsDialContext    psDialCtx;

/******************************************************************************
 *****************************************************************************
 * Functions
 *****************************************************************************
******************************************************************************/

CmsRetId psDialProcCmiInd(const SignalBuf *indSignalPtr);
CmsRetId psDialProcCmiCnf(const SignalBuf *cnfSignalPtr);
void psDailGetCfgDnsByUeImsi(PsDialDnsCfg *pDnsCfg);


/*
 * check whether netif is acted
*/
//BOOL psDialLwipNetIfIsAct(void);
BOOL psDailBeCfun1State(void);
BOOL psDialBeActNetifDoneDuringWakeup(void);

/******************************************************************************
 * psDialSetAdptDnsServerInfo
 * Description: Set DNS server address
 * input:   UINT8 cid, PsDialDnsCfg *pPcoDns, PsDialDnsCfg *pAdptDns, BOOL bWakeUp
 * output:  BOOL
 * Comment:
******************************************************************************/
BOOL psDialSetAdptDnsServerInfo(UINT8 cid, UINT8 type, PsDialDnsCfg *pPcoDns, PsDialDnsCfg *pAdptDns, BOOL bWakeUp);

/*
 * return current CFUN state: CMI_DEV_MIN_FUNC/CMI_DEV_FULL_FUNC/CMI_DEV_TURN_OFF_RF_FUNC
*/
UINT8 psDialGetCfunState(void);

/*
 * return current RRC connection state: 0 - IDLE state, 1 - connected state
*/
UINT8 psDialGetPsConnStatus(void);

/*
 * return CEREG state: CmiCeregStateEnum
 *  CMI_PS_NOT_REG = 0,
 *  CMI_PS_REG_HOME = 1,
 *  CMI_PS_NOT_REG_SEARCHING = 2,
 *  CMI_PS_REG_DENIED = 3,
 *  CMI_PS_REG_UNKNOWN = 4,
 *  CMI_PS_REG_ROAMING = 5,
 *  CMI_PS_REG_SMS_ONLY_HOME = 6,        // not applicable
 *  CMI_PS_REG_SMS_ONLY_ROAMING = 7,     // not applicable
 *  CMI_PS_REG_EMERGENCY = 8,
 *  CMI_PS_REG_CSFB_NOT_PREFER_HOME = 9, // not applicable
 *  CMI_PS_REG_CSFB_NOT_PREFER_ROAMING = 10 //not applicable
*/
UINT8 psDialGetCeregState(void);

/*
 * PS dial init, called when CMS task started
*/
void psDialInit(void);

/*
 * Request CMI/PS service, all CMS sub-modules must call it to request PS service
*/
void psCamCmiReq(UINT16 srcHdr, UINT8 sgId, UINT16 primId, UINT16 primSize, void *primBody);

/*
* return PS SMS init ready or not
*/
BOOL psDialBeSmsReady(void);

#endif

