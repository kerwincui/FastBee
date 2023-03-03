/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: ccio_entity.h
*
*  Description:
*
*  History: 2021/1/19 created by xuwang
*
*  Notes: Channel Centre for Input/Output(CCIO) service
*
******************************************************************************/
#ifndef CCIO_ENTITY_H
#define CCIO_ENTITY_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/
#include "ccio_base.h"
#include "ccio_pub.h"


#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/

#define CCIO_CHAN_OPEN(chent)       (chent)->open = 1
#define CCIO_CHAN_CLOSE(chent)      (chent)->open = 0

/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/
/* 'flags' definition of 'chentStatusCallback' */
typedef enum
{
    CCIO_ESF_BEGIN = 0x0E5F0000,
    CCIO_ESF_SET_WAN_ENTITY  = CCIO_ESF_BEGIN,
    CCIO_ESF_UNSET_WAN_ENTITY,
    CCIO_ESF_SET_LAN_ENTITY,
    CCIO_ESF_UNSET_LAN_ENTITY,
    CCIO_ESF_SET_DIAG_ENTITY,
    CCIO_ESF_UNSET_DIAG_ENTITY,

    CCIO_ESF_CUST_RSVD_BEGIN = 0x0E5FC000,
    /*
     * rsvd for customers
     * refer to 'CcioCustEntStatusFlags_e'
     */
    CCIO_ESF_CUST_RSVD_END = 0x0E5FFFFF,

    CCIO_ESF_END = CCIO_ESF_CUST_RSVD_END,
    CCIO_ESF_UNDEF = CCIO_ESF_END
}CcioEntStatusFlags_e;

/* CCIO_ESF_SET_WAN_ENTITY */
typedef struct
{
    uint8_t    pdpCid;
    uint8_t    rsvd[3];
    void      *chent;
}CcioEsaSetWanEntity_t;

/* CCIO_ESF_UNSET_WAN_ENTITY */
typedef struct
{
    uint8_t    pdpCid;
    uint8_t    rsvd[3];
}CcioEsaUnsetWanEntity_t;

/* CCIO_ESF_SET_LAN_ENTITY */
typedef struct
{
    uint8_t    lanType;  /* refer to 'CcioLanMediaType_e' */
    uint8_t    rsvd[3];
    void      *chent;
}CcioEsaSetLanEntity_t;

/* CCIO_ESF_UNSET_LAN_ENTITY */
typedef struct
{
    uint8_t    lanType;  /* refer to 'CcioLanMediaType_e' */
    uint8_t    rsvd[3];
}CcioEsaUnsetLanEntity_t;

/* CCIO_ESF_SET_DIAG_ENTITY */
typedef struct
{
    void      *chent;
}CcioEsaSetDiagEntity_t;

/* CCIO_ESF_UNSET_DIAG_ENTITY */
typedef struct
{
    void      *chent;
}CcioEsaUnsetDiagEntity_t;


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/

/**
 * @brief ccioSetBaseEntity(CcioEntity_t *chent,
                          uint8_t hasRbuf,
                          uint8_t chanType,
                          uint8_t servType,
                          chentStatusCallback statusCb)
 * @details base entity settings
 *
 * @param chent The base entity to be set
 * @param chanType The channel type
 * @param servType The service type
 * @param status_cb The handler of entity status
 * @return 0 succ; < 0 failure with errno.
 */
int32_t ccioSetBaseEntity(CcioEntity_t *chent,
                          uint8_t hasRbuf,
                          uint8_t chanType,
                          uint8_t servType,
                          chentStatusCallback statusCb);

/**
 * @brief ccioResetBaseEntity(CcioEntity_t *chent)
 * @details base entity clearing
 *
 * @param chent The base entity to be set
 * @return 0 succ; < 0 failure with errno.
 */
int32_t ccioResetBaseEntity(CcioEntity_t *chent);

/**
 * @brief ccioAddEntity(CcioEntity_t *chent)
 * @details add the entity to the list
 *
 * @param chent The chan entity to be added
 * @return !NULL the 1st entity in list; NULL failure.
 */
CcioEntity_t* ccioAddEntity(CcioEntity_t *chent);

/**
 * @brief ccioDelEntity(void *chent)
 * @details delete the entity from the list
 *
 * @param chent The entity to be deleted
 * @return 0 succ; < 0 failure with errno.
 */
int32_t ccioDelEntity(CcioEntity_t *chent);

/**
 * @brief ccioFindEntity(uint16_t chanId)
 * @details find the channel entity in the list by chanId or chanNo
 *
 * @param chanId The channel ID/No
 * @return NULL if not found; != NULL the found entity.
 */
CcioEntity_t* ccioFindEntity(uint16_t chanId);

/**
 * @brief ccioFindEntityByTypes(uint8_t chanType, uint8_t servType)
 * @details find the channel entity in the list by chanType & servType
 *
 * @param chanType The channel type
 * @param servType The service type
 * @return NULL if not found; != NULL the found entity.
 */
CcioEntity_t* ccioFindEntityByTypes(uint8_t chanType, uint8_t servType);

/**
 * @brief ccioCheckNoDevEntity(uint8_t *nodevNum)
 * @details check the entity which is not assigned with device in the list
 *
 * @param nodevNum output the count of entity that has no device
 * @return NULL if not found; != NULL the found entity.
 */
CcioEntity_t* ccioCheckNoDevEntity(uint8_t *nodevNum);

/**
 * @brief ccioGetEntityRbuf(uint16_t chanId)
 * @details find the channel entity in the list by an ID
 *
 * @param chanId The channel ID
 * @return NULL if not found; != NULL the found entity.
 */
void* ccioGetEntityRbuf(uint16_t chanId);

/**
 * @brief ccioTryAssignDevice(CcioEntity_t *chent)
 * @details assign an unused device to channel entity in the specific mode
 *
 * @param chent the entity to be assigned
 * @return 0 succ; < 0 failure with errno.
 */
int32_t ccioTryAssignDevice(CcioEntity_t *chent);


#ifdef __cplusplus
}
#endif
#endif

