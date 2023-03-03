
/******************************************************************************
 ******************************************************************************
 Copyright:      - 2018- Copyrights of AirM2M Ltd.
 File name:      - tcpipmgrutil.h
 Description:    - tcpip manager utility API header file
 History:        - 01/02/2018, Originated by xwang
 ******************************************************************************
******************************************************************************/
#ifndef TCPIP_MGR_UTIL_HDR_H
#define TCPIP_MGR_UTIL_HDR_H

#include "commontypedef.h"
#include "lwip/opt.h"
#include "lwip/err.h"
#include "lwip/priv/tcpip_priv.h"



/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/

#define TCPIP_MGR_MAGIC_WORD               0xA5B7
#define TCPIP_MGR_MAGIC_WORDS              0xA3B5C7D9


/******************************************************************************
 *****************************************************************************
 * STRUCT/ENUM
 *****************************************************************************
******************************************************************************/
typedef enum
{
    TCPIP_MGR_SUCCESS = 0,
    TCPIP_MGR_FAIL = 1,
}TcpipMgrResult;


/******************************************************************************
 * A blocked callback designation, which called in LWIP task
******************************************************************************/

typedef err_t (*TcpipMgrBlockCallback)(void *pInput, UINT16 inputSize, void *pOutput, UINT16 outputSize);


#if 0
typedef struct TcpipMgrBlockCallbackHdr_Tag
{
    UINT8   blcokMsgId;
    UINT8   rsvd0;
    UINT16  inputParaLen;
    UINT16  outputParaLen;
    UINT16  magicWord;      //2 bytes magic
    TcpipMgrBlockCallback callback;
}TcpipMgrBlockCallbackHdr;    //12 bytes
#endif

typedef struct TcpipMgrBlockCallbackInfo_Tag
{
    struct tcpip_api_call_data  tcpApiData;

    UINT16  inputParaLen;
    UINT16  outputParaLen;

    void    *pInput;
    void    *pOutput;

    UINT32  magicWords;     // 4 bytes magic words

    TcpipMgrBlockCallback       callback;
}TcpipMgrBlockCallbackInfo;    //28 bytes




/******************************************************************************
 *****************************************************************************
 * FUNCTION
 *****************************************************************************
******************************************************************************/

/******************************************************************************
 * TcpipMgrLwipCallbackNonBlock
 * Description: Let LWIP task process the callback API, this API will return
 *              without any block
 * input: tcpip_callback_fn api;    //Callback API
 *        void              *pCtx;  //input parameters
 *        UINT32            ctxSize //context size
 * output:
 * Comment:
 * 1> A dynamic memory will create in this API, if "ctxSize" is not zero
******************************************************************************/
void TcpipMgrLwipCallbackNonBlock(tcpip_callback_fn api, void *pCtx, UINT32 ctxSize);

/******************************************************************************
 * TcpipMgrLwipCallbackNonBlockWithoutPsStatusCheck
 * Description: Let LWIP task process the callback API, this API will return(without PS status check)
 *              without any block
 * input: tcpip_callback_fn api;    //Callback API
 *        void              *pCtx;  //input parameters
 *        UINT32            ctxSize //context size
 * output:
 * Comment:
 * 1> A dynamic memory will create in this API, if "ctxSize" is not zero
******************************************************************************/
void TcpipMgrLwipCallbackNonBlockWithoutPsStatusCheck(tcpip_callback_fn api, void *pCtx, UINT32 ctxSize);


/******************************************************************************
 * TcpipMgrLwipCallbackBlock
 * Description: Let LWIP task process the callback API, and wait for the response
 *              from LWIP task
 * input: UINT8     blockMsgId; //block callback msg ID
 *        void      *pInCtx     //input parameters
 *        UINT32    inSize      //input context size
 *        void      *pOutCtx    //output parameters
 *        UINT32    outSize     //output context
 * output:
 * Comment:
 * 1> This is a blocked API;
******************************************************************************/
err_t TcpipMgrLwipCallbackBlock(TcpipMgrBlockCallback callback, void *pInCtx, UINT32 inSize, void *pOutCtx, UINT32 outSize);

/******************************************************************************
 * TcpipMgrLwipCallbackBlockWithoutPsStatusCheck
 * Description: Let LWIP task process the callback API, and wait for the response(without Ps status check)
 *              from LWIP task
 * input: UINT8     blockMsgId; //block callback msg ID
 *        void      *pInCtx     //input parameters
 *        UINT32    inSize      //input context size
 *        void      *pOutCtx    //output parameters
 *        UINT32    outSize     //output context
 * output:
 * Comment:
 * 1> This is a blocked API;
******************************************************************************/
err_t TcpipMgrLwipCallbackBlockWithoutPsStatusCheck(TcpipMgrBlockCallback callback, void *pInCtx, UINT32 inSize, void *pOutCtx, UINT32 outSize);


/******************************************************************************
 * TcpipMgrSendAtiAsyncCnfSig
 * Description: net manager send the "SIG_NM_ATI_CNF" to AT CMD SRV for async request
 * input:   TcpipMgrResult result;
 *          UINT16  srcHdr;
 *          UINT8   cnfPrimId;
 *          void *cnfBody;
 *          UINT16 bodySize
 * output:
 * Comment:
******************************************************************************/
void TcpipMgrSendAtiAsyncCnfSig(TcpipMgrResult result, UINT16 srcHdr, UINT8 cnfPrimId, void *pCnfBody, UINT16 bodySize);


/******************************************************************************
 * TcpipMgrSendAtiIndSig
 * Description: net manager async indication function
 * input:   UINT8 indPrimId,
 *          void *pIndBody,
 *          UINT16 bodySize
 * output:
 * Comment:
******************************************************************************/
void TcpipMgrSendAtiIndSig(UINT8 indPrimId, void *pIndBody, UINT16 bodySize, UINT16 reqHandle);

/******************************************************************************
 * TcpipMgrAtiSyncReq
 * Description: tcpip mgr sync request API.
 * input:   UINT16 reqId, void *reqBody, void *result
 * output:
 * Comment:
******************************************************************************/
TcpipMgrResult TcpipMgrAtiSyncReq(UINT16 reqId, TcpipMgrBlockCallback callback, UINT16 reqLen, void *reqBody, UINT16 retLen, void *pRet);



#endif

