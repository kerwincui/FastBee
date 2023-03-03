/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: radio_device.h
*
*  Description:
*
*  History: 2021/1/19 created by xuwang
*
*  Notes:
*
******************************************************************************/
#ifndef RADIO_DEVICE_H
#define RADIO_DEVICE_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include "ccio_base.h"
#include "ccio_misc.h"

#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/
/* only one device for ctrl plane */
#define RADIO_DEV_REAL_MAXNUM    1

#define EUTRA_DEV_CTRLPLANE_CID  0


/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/

/**
 * configuration about a uart device.
 */
typedef struct
{
    uint8_t    bmCreateFlag;    /**< refer to 'CcioTaskOperFlag_e', bitmap type */
    uint8_t    rsvd[3];
}RadioDevConf_t;

typedef struct
{
    uint8_t    lanType;  /* refer to 'CcioLanMediaType_e' */
    uint8_t    isWakeUp;
    uint16_t   mtu;
}CcioLanLinkUp_t;

typedef struct
{
    uint8_t    lanType;  /* refer to 'CcioLanMediaType_e' */
    uint8_t    rsvd[3];
}CcioLanLinkDown_t;


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

/**
 * @brief radioDevCreate(uint8_t cid)
 * @details create a radio device of dtype with 'cid'
 *
 * @param pdpCid    pdp context id
 * @param radioConf The configuration about a radio device
 * @return 0 succ; < 0 failure with errno.
 */
int32_t radioDevCreate(uint8_t pdpCid, RadioDevConf_t *radioConf);

/**
 * @brief radioDevDestroy(uint8_t cid)
 * @details destroy/delete a radio device of dtype with 'cid'
 *
 * @param cid pdp context id
 * @return 0 succ; < 0 failure with errno.
 */
int32_t radioDevDestroy(uint8_t pdpCid);

/**
 * @brief radioDevFreeUlPduList(UlPduBlock_t *list)
 * @details free ulpdu block list.
 *
 * @param ulpdu  head of ulpdu list
 * @return void
 */
void  radioDevFreeUlPduList(UlPduBlock_t *list);

/**
 * @brief radioDevQueryLocalMac(CcioMacAddr_t *localMac)
 * @details get local mac addr
 *
 * @param localMac  info of local mac
 * @return void.
 */
void radioDevQueryLocalMac(CcioMacAddr_t *localMac);

/**
 * @brief radioDevNotifyTcpipDataPathCapability(void *lanDataPathCap)
 * @details lan data path capability notification from ps/lwip
 *
 * @param lanDataPathCap  capability of lan data path
 * @return void.
 */
void radioDevNotifyTcpipDataPathCapability(void *lanDataPathCap);

/**
 * @brief radioDevQueryTcpipDataPathCapability(CcioLanMediaType_e lanType, CcioDataPathCap_t *dataPath)
 * @details query lan data path capability
 *
 * @param lanType   lan(ecm/rndis/ppp) media type
 * @param dataPath  query capability of lan data path
 * @return void.
 */
void radioDevQueryTcpipDataPathCapability(CcioLanMediaType_e lanType, CcioDataPathCap_t *dataPath);

/**
 * @brief radioDevQueryDataPathHostConf(CcioLanMediaType_e lanType, CcioDataPathHostConf_t *hostConf)
 * @details query host addr/dns config
 *
 * @param lanType   lan(rndis/ppp) media type
 * @param queryWan  query info of wan media
 * @return void.
 */
void radioDevQueryDataPathHostConf(CcioLanMediaType_e lanType, CcioDataPathHostConf_t *hostConf);

/**
 * @brief radioDevLanLinkStatusChange(CcioLanMedia_t *linkStatus)
 * @details lan media state report to ps/lwip
 *
 * @param changeLan  info of lan link status change
 * @return void.
 */
void radioDevLanLinkStatusChange(CcioLanMedia_t *linkStatus);

/**
 * @brief radioDevLanLinkUp(CcioLanLinkUp_t *linkUp)
 * @details notify ps/lwip that LAN link is up
 *
 * @param linkUp  info of LAN link up
 * @return void.
 */
void radioDevLanLinkUp(CcioLanLinkUp_t *linkUp);

/**
 * @brief radioDevLanLinkDown(CcioLanLinkDown_t *linkDown)
 * @details notify ps/lwip that LAN link is down
 *
 * @param linkDown info of LAN link down
 * @return void.
 */
void radioDevLanLinkDown(CcioLanLinkDown_t *linkDown);

/**
 * @brief radioDevHoldOnPppSessn(uint8_t atCid)
 * @details notify ps to switch to online command mode
 *
 * @param atCid  at cid No from PS
 * @return 0 succ; < 0 failure with errno.
 */
int32_t radioDevHoldOnPppSessn(uint8_t atCid);

/**
 * @brief radioDevAbortPppSessn(uint8_t atCid, uint8_t pdp4Cid, uint8_t pdp6Cid)
 * @details notify ps that ppp sessn is disconnected
 *
 * @param atCid   at cid No from PS
 * @param pdp4Cid ipv4 pdp context id
 * @param pdp6Cid ipv6 pdp context id
 * @return 0 succ; < 0 failure with errno.
 */
int32_t radioDevAbortPppSessn(uint8_t atCid, uint8_t pdp4Cid, uint8_t pdp6Cid);

/**
 * @brief radioDevSetPppAuth(uint8_t pdpCid, CcioAuthType_e authType, CcioAuthInfo_t *authInfo)
 * @details set auth for ppp sessn
 *
 * @param pdpCid   pdp context id
 * @param authType auth type(pap/chap/none)
 * @param authInfo auth info
 * @return 0 succ; < 0 failure with errno.
 */
int32_t radioDevSetPppAuth(uint8_t pdpCid, CcioAuthType_e authType, CcioAuthInfo_t *authInfo);

/**
 * @brief radioDevActPppBearer(uint8_t pdpCid)
 * @details activate pdp context for ppp sessn
 *
 * @param pdpCid   pdp context id
 * @return 0 succ; < 0 failure with errno.
 */
int32_t radioDevActPppBearer(uint8_t pdpCid);


#ifdef __cplusplus
}
#endif
#endif

