/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: ccio_tfc.h
*
*  Description:
*
*  History: 2021/1/19 created by xuwang
*
*  Notes: flow controlling policy for Transmitting
*
******************************************************************************/
#ifndef CCIO_TFC_H
#define CCIO_TFC_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/


#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/
#define CCIO_TFC_PID_UNDEF   0xFFFF

/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/
typedef uint16_t  CcioTfcPid_t;

typedef enum
{
    CCIO_TOI_SOCK = 0,
    CCIO_TOI_HTTP,
    CCIO_TOI_SSL,
    CCIO_TOI_MQTT,
    CCIO_TOI_RSVD_1,
    CCIO_TOI_RSVD_2,

    CCIO_TOI_MAXNUM
}CcioTfcObjId_e;

typedef struct
{
    uint8_t  mediaType;  /* CcioLanMediaType_e */
    uint8_t  mediaCid;   /* such as atCid/... */
    uint8_t  rsvd[2];
}CcioTfcObjKeys_t;

typedef struct
{
    uint8_t  objId;      /* CcioTfcObjId_e */
    uint8_t  rsvd[3];
}CcioTfcObjAttr_t;

typedef struct
{
    void          *handle;
    CcioDevice_t  *chdev;
}CcioTfcPolicyEnable_t;

/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
CcioTfcPid_t ccioCreateTfcPolicy(CcioTfcObjKeys_t *keys, CcioTfcObjAttr_t *attr);
int32_t ccioDeleteTfcPolicy(CcioTfcPid_t afcPid, CcioTfcObjAttr_t *attr);
int32_t ccioEnableTfcPolicy(CcioTfcPid_t afcPid);
uint8_t ccioIsTfcPolicyEnable(CcioTfcObjKeys_t *keys, CcioTfcObjAttr_t *attr);


#ifdef __cplusplus
}
#endif
#endif

