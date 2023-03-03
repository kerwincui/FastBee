/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: eutra_entity.h
*
*  Description:
*
*  History: 2021/1/19 created by xuwang
*
*  Notes:
*
******************************************************************************/
#ifndef EUTRA_ENTITY_H
#define EUTRA_ENTITY_H

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

typedef struct
{
    /* inherited field & MUST be placed on the top! */
    CcioEntity_t  base;

    uint8_t  isPrimary:1;
    uint8_t  rsvdBit:7;
    uint8_t  rsvd[3];

    struct netif  *eutraIf;     /* lwip netif, via user/monitor */
    void  *extras;              /* for user context. */
}EutraEntity_t;



/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

/**
 * @brief cuioInitEntity(EutraEntity_t *eutraEnt, struct netif *eutraIf, chentStatusCallback statusCb, void *extras)
 * @details create a rndis entity
 *
 * @param eutraEnt The entity to be created
 * @param eutraIf The eutra(ps) netif info
 * @param status_cb The handler of entity status
 * @param extras The user's extra info/useful context
 * @return 0 succ; < 0 failure with errno.
 */
int32_t cuioInitEntity(EutraEntity_t *eutraEnt,
                       struct netif *eutraIf,
                       chentStatusCallback statusCb,
                       void *extras);

/**
 * @brief cuioDeinitEntity(EutraEntity_t *eutraEnt)
 * @details delete/reset a rndis entity
 *
 * @param eutraEnt The entity to be deleted
 * @return 0 succ; < 0 failure with errno.
 */
int32_t cuioDeinitEntity(EutraEntity_t *eutraEnt);

/**
 * @brief cuioSetUpChannel(EutraEntity_t *eutraEnt)
 * @details establish a eutra channel
 *
 * @param eutraEnt The entity to be established the channel
 * @return 0 succ; < 0 failure with errno.
 */
int32_t cuioSetUpChannel(EutraEntity_t *eutraEnt);

/**
 * @brief cuioPullDownChannel(EutraEntity_t *eutraEnt)
 * @details destroy a eutra channel
 *
 * @param eutraEnt The entity to be destroied the channel
 * @return 0 succ; < 0 failure with errno.
 */
int32_t cuioPullDownChannel(EutraEntity_t *eutraEnt);


#ifdef __cplusplus
}
#endif
#endif

