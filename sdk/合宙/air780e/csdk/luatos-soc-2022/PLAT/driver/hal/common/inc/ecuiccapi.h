#ifndef __EC_UICC_API_H__
#define __EC_UICC_API_H__
/******************************************************************************
Copyright:      - 2017, All rights reserved by AirM2M Ltd.
File name:      - ecuiccapi.h
Description:    - the header file for UICC open API.
Function List:  -
History:        - 09/20/2022, Originated by xlhu
******************************************************************************/

/*********************************************************************************
* Includes
*********************************************************************************/
#include "commontypedef.h"

/*********************************************************************************
* Macros
*********************************************************************************/

/*********************************************************************************
* Type Definition
*********************************************************************************/


/******************************************************************************
 *****************************************************************************
 * Functions
 *****************************************************************************
******************************************************************************/

/******************************************************************************
 * SoftSimReset
 * Description: This API called by modem/uiccdrv task to reset softsim and get ATR parameter from softsim,
 *         as same as code/warm reset with physical SIM card.
 * param[out]   UINT16 *atrLen, the pointer to the length of ATR, this memory don't need to be free.
 * param[out]   UINT8 *atrData, the pointer to the ATR data,  this memory don't need to be free.
 *               atrData buffer size is 33, fill atrData shall not exceed 33 bytes.
 * Comment: This API will be called only if softsim feature is enabled by AT CMD.
 *        Shall send signal/msg to softsim task and block to wait response .
 *        Softsim internal process running in this func is not allowed.
******************************************************************************/
void SoftSimReset(UINT16 *atrLen, UINT8 *atrData);

/******************************************************************************
 * SoftSimApduReq
 * Description: This API will be called by modem/uiccdrv task to send APDU(TPDU) request and get response from softsim,
 *         support case 1/2/3/4 command/response process.
 * param[in]   UINT16 txDataLen, the length of tx data
 * param[in]   UINT8 *txData, the pointer to the tx data, this memory don't need to be free.
 * param[out]   UINT16 *rxDataLen, the pointer to the length of rx data, this memory don't need to be free.
 * param[out]   UINT8 *rxData, the pointer to the rx data, this memory don't need to be free.
 *               rxData buffer size is 258, fill rxData shall not exceed 258 bytes.
 * Comment: This API will be called only if softsim feature is enabled by AT CMD.
 *        Shall send signal/msg to softsim task and block to wait response.
 *        Softsim internal process running in this func is not allowed.
******************************************************************************/
void SoftSimApduReq(UINT16 txDataLen, UINT8 *txData, UINT16 *rxDataLen, UINT8 *rxData);

/******************************************************************************
 * SoftSimInit
 * Description: This api called by modem/uiccdrv task to start softsim task if softsim feature is enabled.
 * input: void
 * output: void
 * Comment:
******************************************************************************/
void SoftSimInit(void);

#endif


