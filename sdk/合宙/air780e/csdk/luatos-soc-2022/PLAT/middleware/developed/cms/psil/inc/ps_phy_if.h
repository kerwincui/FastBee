/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    ps_phy_if.h
 * Description:  API interface implementation header file for PHY service
 * History:      Rev1.0   2018-10-12
 *
 ****************************************************************************/
#ifndef __PS_PHY_IF_H__
#define __PS_PHY_IF_H__

#include "commontypedef.h"

/******************************************************************************
 * If no parameters carried in signal, just pass a reserved UINT32
******************************************************************************/
typedef UINT32 PhyCmiEmptySig;

/*
 * defined fast signal Id between CMS task<- IPC -> PHY for PHY/RF AT CMD
 * Id: 0x0930 - 0x093F
*/
typedef enum _EPAT_SIG_PHYCMISIGID_Tag
{
    SIG_FAST_PHY_CMI_BASE = 0x0930,

    SIG_FAST_PHY_CMI_REQ, // PhyCmiReq
    SIG_FAST_PHY_CMI_CNF, // PhyCmiCnf
    SIG_FAST_PHY_CMI_IND, // PhyCmiInd

    SIG_FAST_PHY_CMI_END  = 0x093F
}PHYCMISIGID;

typedef enum CMI_PHY_PRIM_ID_TAG   /* PRIM Id*/
{
    CMI_PHY_PRIM_BASE,

    CMI_PHY_SET_CFG_PARAM_REQ, //CmiPhySetCfgParamReq, AT+ECPHYCFG=<>
    CMI_PHY_SET_CFG_PARAM_CNF,
    CMI_PHY_SET_RF_TEST_CMD_REQ,
    CMI_PHY_SET_RF_TEST_CMD_CNF,
    CMI_PHY_SET_RF_NST_RST_REQ,
    CMI_PHY_SET_RF_NST_RST_CNF,
    CMI_PHY_SET_RF_NST_RST_IND,
    CMI_PHY_SET_RF_NST_RST_DEBUG,
    CMI_PHY_SET_RF_CFG_REQ,
    CMI_PHY_SET_RF_CFG_CNF,

    CMI_PHY_PRIM_END
}CMI_PHY_PRIM_ID;


/******************************************************************************
 * PhyCmiReq - SIG_FAST_PHY_CMI_REQ
 * CMI interface request for PHY/RF AT CMD
 * Int16 reqId; 4 MSB bits SG ID | 12 bits PRIM ID;
 * Int16 srcHandler; ID use to identify which module send this request
 * Int8 body[0]; request PRIM entity
******************************************************************************/
typedef struct PhyCmiReqTag
{
    struct {
        UINT16 reqId;
        UINT16 srcHandler;
    }header;

    UINT8 body[];
}PhyCmiReq;


/******************************************************************************
 * PhyCmiCnf - SIG_FAST_PHY_CMI_CNF
******************************************************************************/
typedef struct PhyCmiCnfTag
{
    struct {
        UINT16      cnfId;      //4 MSB bits SG ID | 12 bits PRIM ID
        UINT16      srcHandler; //Handler from PhyCmiReq
        UINT16      rc;
        UINT16      reserved;
    }header;

    UINT8 body[];
}PhyCmiCnf;

typedef struct PhyCmiIndTag
{
    struct {
        UINT16      indId;      //4 MSB bits SG ID | 12 bits PRIM ID
        /*
         * As some indication is triggered by some AT request, in such as need to fill this "reqHandler",
         *  otherwise set to "BROADCAST_IND_HANDLER".
        */
        UINT16      reqHandler;
    }header;

    UINT8 body[];
}PhyCmiInd;

BOOL phyGetDebugModule(CHAR *strName, UINT8 *phyModule);

INT32 phySetDebugCfgInfo(UINT16 atHandle, UINT32 phyModId, INT32 *pCfgParams, UINT8 paramNum);

void phyGetPhyDebugAtCmdInfo(CHAR *pAtRspBuf, UINT16 bufLen);

void phyRestorePhyDebugAtCmdInfo(void);

void phySavePhyDebugAtCmdInfo(void);

#endif

