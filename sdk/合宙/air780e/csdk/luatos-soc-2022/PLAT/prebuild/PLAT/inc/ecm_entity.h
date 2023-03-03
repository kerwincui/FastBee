/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: ecm_entity.h
*
*  Description:
*
*  History: 2022/2/22 created by xuwang
*
*  Notes:
*
******************************************************************************/
#ifndef ECM_ENTITY_H
#define ECM_ENTITY_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/


#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/
#if 0
typedef struct
{
    /* inherited field & MUST be placed on the top! */
    CcioEntity_t  base;

    uint8_t  lanState;     /* refer to 'CcioLanMediaState_e', via monitor/user */
    uint8_t  pdp4Cid;      /* ipv4 pdp context Id, via monitor */
    uint8_t  pdp6Cid;      /* ipv6 pdp context Id, via monitor */
    uint8_t  rsvd;

    void  *extras;         /* for user context. */

    /* TODO: statistic, via monitor */
}EcmEntity_t;

#else

typedef EtherEntity_t EcmEntity_t;

#endif


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

/**
 * @brief ceioInitEntity(SerialEntity_t *serlEnt, chentStatusCallback statusCb, void *extras)
 * @details create a ecm entity
 *
 * @param rndisEnt   The entity to be created
 * @param status_cb  The handler of entity status
 * @param extras The user's extra info/useful context
 * @return 0 succ; < 0 failure with errno.
 */
int32_t ceioInitEntity(EcmEntity_t *ecmEnt,
                       chentStatusCallback statusCb,
                       void *extras);

/**
 * @brief ceioDeinitEntity(EcmEntity_t *ecmEnt)
 * @details delete/reset a ecm entity
 *
 * @param rndisEnt The entity to be deleted
 * @return 0 succ; < 0 failure with errno.
 */
int32_t ceioDeinitEntity(EcmEntity_t *ecmEnt);

/**
 * @brief ceioSetUpChannel(EcmEntity_t *ecmEnt)
 * @details establish a ecm channel
 *
 * @param rndisEnt The entity to be established the channel
 * @return 0 succ; < 0 failure with errno.
 */
int32_t ceioSetUpChannel(EcmEntity_t *ecmEnt);

/**
 * @brief ceioPullDownChannel(EcmEntity_t *ecmEnt)
 * @details destroy a ecm channel
 *
 * @param rndisEnt The entity to be destroied the channel
 * @return 0 succ; < 0 failure with errno.
 */
int32_t ceioPullDownChannel(EcmEntity_t *ecmEnt);


#ifdef __cplusplus
}
#endif
#endif








