#ifndef __MW_NVM_INFO_H__
#define __MW_NVM_INFO_H__
/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    mw_nvm_info.h
 * Description:  middleware NVM info header file
 * History:      2021/04/12, Originated by Jason
 ****************************************************************************/
#include "osasys.h"
#include "mw_common.h"
//#include "acmsgtype.h"

/*
 * Differences between these MW config/AON files:
 * 1> mw_nvm_config.h
 *   a) parameter value is still VALID, after reboot.
 *   b) parameter value is still VALID, after FOTA (SW upgrading) if not erase the NVM in flash.
 *   c) if not configed in NVM/flash, use the default value.
 * 2> mw_nvm_info.h
 *   a) parameter value is still VALID, after reboot.
 *   b) parameter value is not VALID (reset to default value), after FOTA (SW upgrading), if:
 *       i> NVM in flash is erased, or
 *       ii> NVM info structure size is changed, or
 *       ii> NVM file version is changed.
 *   c) if not configed in NVM/flash, use the default value.
 * 3> mw_aon_info.h
 *   a) parameter value is still VALID, after wakeup from deep sleep
 *   b) parameter value is not VALID, after reboot
 * 4> mw_common.h
 *   a) middleware common header file, which included by "mw_nvm_config.h"&"mw_nvm_info.h"&"mw_aon_info.h"
 *   b) As customers maybe have different requirements about how to maintain the config,
 *      here could set the common structure in this file
*/


/******************************************************************************
 *****************************************************************************
 * MARCO/MARCO
 *****************************************************************************
******************************************************************************/
/*
 *
*/
#define MID_WARE_NVM_INFO_FILE_NAME     "mwinfo.nvm"

#define MID_WARE_NVM_INFO_CUR_VER       0x0

#define MID_WARE_PHY_DEBUG_AT_CONT_SIZE     64

/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/*
 * Useless, if struct size is changed, or NVM version changed
*/
typedef struct _NVM_EPAT_mwinfo
{
    /*
     * used for PHY debug/config AT, struct: PhyDebugAtCmdInfo
     */
    UINT8           phyDebugAtCont[MID_WARE_PHY_DEBUG_AT_CONT_SIZE];



}MidWareNvmInfo;



/******************************************************************************
 *****************************************************************************
 * API
 *****************************************************************************
******************************************************************************/

/**
  \fn           void mwNvmInfoInit(void)
  \brief        Called in CMS task, when task start up
  \param[in]    void
  \returns      void
*/
void mwNvmInfoInit(void);


/**
  \fn           void mwNvmInfoGetPhyDebugAtCmdInfo(void *pPhyAtOutBuf, UINT16 bufSize)
  \brief        Get "PhyDebugAtCmdInfo" from NVM
  \param[out]   pPhyAtOutBuf        PHY debug output buffer
  \param[in]    bufSize             outbuf size
  \returns      void
*/
void mwNvmInfoGetPhyDebugAtCmdInfo(void *pPhyAtOutBuf, UINT16 bufSize);


/**
  \fn           void mwNvmInfoSetPhyDebugAtCmdInfo(void *pPhyAtInfo, UINT16 infoSize)
  \brief        set and save "PhyDebugAtCmdInfo" into NVM
  \param[in]    pPhyAtInfo          PHY debug info
  \param[in]    infoSize            PHY debug info size
  \returns      void
*/
void mwNvmInfoSetPhyDebugAtCmdInfo(void *pPhyAtInfo, UINT16 infoSize);



#endif

