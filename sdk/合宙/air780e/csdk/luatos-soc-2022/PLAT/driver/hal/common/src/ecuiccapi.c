/******************************************************************************
Copyright:      - 2017, All rights reserved by AirM2M Ltd.
File name:      - ecuiccapi.c
Description:    - UICC open API.
Function List:  -
History:        - 09/20/2022, Originated by xlhu
******************************************************************************/


/******************************************************************************
 * Include Files
*******************************************************************************/
#include "cmsis_os2.h"
#include "FreeRTOS.h"
#include "task.h"
#include "os_common.h"
#include DEBUG_LOG_HEADER_FILE
#include "debug_trace.h"
#include "ecuiccapi.h"

/*********************************************************************************
 * Macros
*********************************************************************************/

/******************************************************************************
 * Extern global variables
*******************************************************************************/

/******************************************************************************
 * Extern functions
*******************************************************************************/

/******************************************************************************
 * Global variables
*******************************************************************************/
/*
 * bSoftSIMTaskCreate
 * Whether the SoftSIM task created.
*/
BOOL    bSoftSIMTaskCreate = FALSE;
/******************************************************************************
 * Types
*******************************************************************************/

/******************************************************************************
 * Local variables
*******************************************************************************/


/******************************************************************************
 * Function Prototypes
*******************************************************************************/

/******************************************************************************
 * Function definition
*******************************************************************************/
#define __DEFINE_SOFTSIM_ADAPT_FUNCTION__ //just for easy to find this position in SS
/******************************************************************************
 * SoftSIM interface adapted note
 * 1> The SoftSIM feature is disable as default, and enabled by AT+ECSIMCFG="softsim",1
 * 2> SoftSIM task shall be created in SoftSimInit func or appinit depended by softsim vender.
 * 3> SoftSIM vender shall adapt  functions SoftSimReset/SoftSimApduReq.
*******************************************************************************/

/******************************************************************************
 * SoftSimReset
 * Description: This API called by modem/uiccdrv task to reset softsim and get ATR parameter from softsim,
 *         as same as code/warm reset with physical SIM card.
 * param[in]   null
 * param[out]   UINT16 *atrLen, the pointer to the length of ATR, this memory don't need to be free.
 * param[out]   UINT8 *atrData, the pointer to the ATR data,  this memory don't need to be free.
 *               atrData buffer size is 33, fill atrData shall not exceed 33 bytes.
 * Comment: This API will be called only if softsim feature is enabled by AT CMD.
 *        Shall send signal/msg to softsim task and block to wait response .
 *        Softsim internal process running in this func is not allowed.
******************************************************************************/
void SoftSimReset(UINT16 *atrLen, UINT8 *atrData)
{
    osSemaphoreId_t sem = osSemaphoreNew(1U, 0, PNULL);
    osStatus_t osState = osOK;

    /*
    * softsim vender shall implement 3 steps as below
    */

    /*
    * 1> create signal/msg
    */

    /*
    * 2> send signal/msg to softsim task with sem/atrLen/atrData
    */

    /*
    * 3> process signal/msg on softsim task, then retrun paramters and release sem on softsim task
    */


    /*
     * wait for sem 2sec
    */
    if ((osState = osSemaphoreAcquire(sem, 2000)) != osOK)
    {
        OsaDebugBegin(FALSE, osState, 0, 0);
        OsaDebugEnd();
    }

    /*
     * Semaphore delete
    */
    osSemaphoreDelete(sem);

}

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
void SoftSimApduReq(UINT16 txDataLen, UINT8 *txData, UINT16 *rxDataLen, UINT8 *rxData)
{
    osSemaphoreId_t sem = osSemaphoreNew(1U, 0, PNULL);
    osStatus_t osState = osOK;

    /*
    * softsim vender shall implement 3 steps as below
    */

    /*
    * 1> create signal/msg
    */

    /*
    * 2> send signal/msg to softsim task with sem/txDataLen/txData/rxDataLen/rxData
    */

    /*
    * 3> process signal/msg on softsim task, then retrun paramters and release sem on softsim task
    */


    /*
     * wait for sem 2sec
    */
    if ((osState = osSemaphoreAcquire(sem, 2000)) != osOK)
    {
        OsaDebugBegin(FALSE, osState, 0, 0);
        OsaDebugEnd();
    }

    /*
     * Semaphore delete
    */
    osSemaphoreDelete(sem);

}



/******************************************************************************
 * SoftSimInit
 * Description: This api called by modem/uiccdrv task to start softsim task if softsim feature is enabled.
 * input: void
 * output: void
 * Comment:
******************************************************************************/
void SoftSimInit(void)
{
    if (bSoftSIMTaskCreate == TRUE)
    {
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, SoftSimInit_0, P_INFO, "Softsim task has already been created");
        return;
    }
    /*
    * start softsim task
    */
    ECPLAT_PRINTF(UNILOG_PLA_DRIVER, SoftSimInit_1, P_INFO, "Start softsim task");
    /*
    * softsim vender implement softsim task created
    */



    //delay 100ms for softsim task init
    osDelay(100);

    //set flag after task created
    bSoftSIMTaskCreate = TRUE;

}


