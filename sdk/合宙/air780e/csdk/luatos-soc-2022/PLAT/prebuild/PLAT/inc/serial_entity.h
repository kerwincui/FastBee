/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: serial_entity.h
*
*  Description:
*
*  History: 2021/1/19 created by xuwang
*
*  Notes:
*
******************************************************************************/
#ifndef SERIAL_ENTITY_H
#define SERIAL_ENTITY_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include "lwip/netif.h"



#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/
#define ATOS_ENTITY_FLAGS_INIT    0x01    /* created */
#define ATOS_ENTITY_FLAGS_ACT     0x02    /* activated */
typedef uint8_t AtosEntFlags;

typedef enum
{
    SERIAL_CHM_CMD_OFFLINE = 0,
    SERIAL_CHM_CMD_ONLINE,
    SERIAL_CHM_DATA_ONLINE,

    SERIAL_CHM_MAXNUM
}SerialChanMode_e;

typedef struct
{
    uint8_t  flags;      /* AtosEntFlags */
    uint8_t  atCid;      /* at context Id between ps  */
    uint8_t  outFmt;     /* CcioOutXferFormat_e */
    uint8_t  rsvd;

    void    *extras;     /* for user context. */
}AtosEntity_t;

typedef struct
{
    uint8_t       lanState;     /* refer to 'CcioLanMediaState_e', via monitor/user */
    uint8_t       pdp4Cid;      /* ipv4 pdp context Id, via monitor */
    uint8_t       pdp6Cid;      /* ipv6 pdp context Id, via monitor */
    uint8_t       needAct;      /* 0/1: need to activate pdp context or not? */
    struct netif  pppIf;

    void         *extras;       /* for user context. */

    //struct stats_proto link;  /* statistic, via user */
}PpposEntity_t;

typedef struct
{
    /* inherited field & MUST be placed on the top! */
    CcioEntity_t  base;

    uint8_t  baseOnly  :1;  /* if set 1, other fields are meaningless except baseEnt. */
    uint8_t  isChgMode :1;  /* is channel mode changing or not? */
    uint8_t  rsvdBits  :6;
    uint8_t  chanMode;      /* refer to 'SerialChanMode_e', via monitor */
    uint8_t  rsvd[2];
    uint32_t memThres;      /* dlfc memory threshold */
    osSemaphoreId_t semaId;

    UlPduBlockList_t inList;    /* for raw ppp via sct */
    DlPduBlockList_t outList;   /* for uart raw ppp */

    AtosEntity_t   at;
    PpposEntity_t *ppp;
}SerialEntity_t;

/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

/**
 * @brief csioInitAtEntity(SerialEntity_t *serlEnt, chentStatusCallback statusCb, void *extras)
 * @details create an AToS entity
 *
 * @param serlEnt   The entity to be created
 * @param isForPpp  The entity is for ppp service or not
 * @param status_cb The handler of entity status
 * @param extras    The user's extra info/useful context
 * @return 0 succ; < 0 failure with errno.
 */
int32_t csioInitAtEntity(SerialEntity_t *serlEnt,
                         uint8_t isForPpp,
                         chentStatusCallback statusCb,
                         void *extras);

/**
 * @brief csioDeinitAtEntity(SerialEntity_t *serlEnt)
 * @details delete/reset an AToS entity
 *
 * @param serlEnt The entity to be deleted
 * @return 0 succ; < 0 failure with errno.
 */
int32_t csioDeinitAtEntity(SerialEntity_t *serlEnt);

/**
 * @brief csioInitPppEntity(SerialEntity_t *serlEnt, void *extras)
 * @details create an PPPoS entity
 *
 * @param serlEnt   The entity to be created
 * @param extras The user's extra info/useful context
 * @return 0 succ; < 0 failure with errno.
 */
int32_t csioInitPppEntity(SerialEntity_t *serlEnt, void *extras);

/**
 * @brief csioDeinitPppEntity(SerialEntity_t *serlEnt)
 * @details delete/reset an PPPoS entity
 *
 * @param serlEnt The entity to be deleted
 * @return 0 succ; < 0 failure with errno.
 */
int32_t csioDeinitPppEntity(SerialEntity_t *serlEnt);

/**
 * @brief csioInitDiagEntity(SerialEntity_t *serlEnt, chentStatusCallback statusCb, void *extras)
 * @details create an DIAGoS entity
 *
 * @param serlEnt The entity to be created
 * @param status_cb The handler of entity status
 * @param extras The user's extra info/useful context
 * @return 0 succ; < 0 failure with errno.
 */
int32_t csioInitDiagEntity(SerialEntity_t *serlEnt,
                           chentStatusCallback statusCb,
                           void *extras);

/**
 * @brief csioDeinitDiagEntity(SerialEntity_t *serlEnt)
 * @details delete/reset an DIAGoS entity
 *
 * @param serlEnt The entity to be deleted
 * @return 0 succ; < 0 failure with errno.
 */
int32_t csioDeinitDiagEntity(SerialEntity_t *serlEnt);

/**
 * @brief csioInitOpaqEntity(SerialEntity_t *serlEnt, chentStatusCallback statusCb, void *extras)
 * @details create an opaqos entity
 *
 * @param serlEnt The entity to be created
 * @param status_cb The handler of entity status
 * @param extras The user's extra info/useful context
 * @return 0 succ; < 0 failure with errno.
 */
int32_t csioInitOpaqEntity(SerialEntity_t *serlEnt,
                           chentStatusCallback statusCb,
                           void *extras);

/**
 * @brief csioDeinitOpaqEntity(SerialEntity_t *serlEnt)
 * @details delete/reset an opaqoS entity
 *
 * @param serlEnt The entity to be deleted
 * @return 0 succ; < 0 failure with errno.
 */
int32_t csioDeinitOpaqEntity(SerialEntity_t *serlEnt);

/**
 * @brief csioSetUpChannel(SerialEntity_t *serlEnt)
 * @details establish a serial(AT or PPP) channel
 *
 * @param serlEnt The entity to be established the channel
 * @return 0 succ; < 0 failure with errno.
 */
int32_t csioSetUpChannel(SerialEntity_t *serlEnt);

/**
 * @brief csioPullDownChannel(SerialEntity_t *serlEnt)
 * @details destroy a serial(AT or PPP) channel
 *
 * @param serlEnt The entity to be destroied the channel
 * @return 0 succ; < 0 failure with errno.
 */
int32_t csioPullDownChannel(SerialEntity_t *serlEnt);

/**
 * @brief csioSetChanMode(SerialEntity_t *serlEnt, SerialChanMode_e chanMode)
 * @details set/change the serial channel mode
 *
 * @param serlEnt  The serial entity whose chanMode is changed
 * @param chanMode The value of new chan mode
 * @return 0 succ; < 0 failure with errno.
 */
int32_t csioSetChanMode(SerialEntity_t *serlEnt, SerialChanMode_e chanMode);

/**
 * @brief csioTryAdjustDlfcMemThres(SerialEntity_t *serlEnt)
 * @details try to adjust dlfc memory threshold according the serial baudrate
 *
 * @param serlEnt  The serial entity whose dlfc memory threshold will be adjusted
 * @return 0 succ; < 0 failure with errno.
 */
int32_t csioTryAdjustDlfcMemThres(SerialEntity_t *serlEnt);

/**
 * @brief csioTryRestoreDlfcMemThres(SerialEntity_t *serlEnt)
 * @details try to restore dlfc memory threshold if adjusted
 *
 * @param serlEnt  The serial entity whose dlfc memory threshold will be restored
 * @return 0 succ; < 0 failure with errno.
 */
int32_t csioTryRestoreDlfcMemThres(SerialEntity_t *serlEnt);

/**
 * @brief ccioHoldOnPppSessn(SerialEntity_t *serlEnt)
 * @details switch to online command mode and hold on ppp sessn
 *
 * @param serlEnt  The serial entity whose ppp sessn will be hold on
 * @return 0 succ; < 0 failure with errno.
 */
int32_t ccioHoldOnPppSessn(SerialEntity_t *serlEnt);

#ifdef __cplusplus
}
#endif
#endif


