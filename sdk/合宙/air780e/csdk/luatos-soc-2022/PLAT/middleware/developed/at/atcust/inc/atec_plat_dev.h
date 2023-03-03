/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_plat_dev.h
*
*  Description: Device debug related AT CMD
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_DEBUG_H__
#define __ATEC_DEBUG_H__

#include "at_util.h"

#define EC_CMD_BUF_LEN          640
#define EC_PRINT_BUF_LEN        128
#define EC_DUMP_DATA_LEN        32
#define EC_DUMP_DATA_BLOCK      8192
#define ATC_ECRFTEST_STR_MAX_LEN           5000


/* AT+ECUNITTEST */
#define ATC_ECUNITTEST_0_VAL_MIN                0
#define ATC_ECUNITTEST_0_VAL_MAX                16
#define ATC_ECUNITTEST_0_VAL_DEFAULT            0  /* full functionality */



/*AT+ECRST*/
#define ATC_ECRST_MAX_DELAY_MS             2000

/* AT+ECSYSTEST */
#define ATC_SYSTEST_0_VAL_MIN                0
#define ATC_SYSTEST_0_VAL_MAX                512
#define ATC_SYSTEST_0_VAL_DEFAULT            0  /* full functionality */
#define ATC_SYSTEST_0_STR_DEFAULT          NULL
#define ATC_SYSTEST_0_STR_MAX_LEN          256         /* */

/* AT+ECPMUCFG */
#define ATC_ECPMUCFG_0_VAL_MIN                0
#define ATC_ECPMUCFG_0_VAL_MAX                1
#define ATC_ECPMUCFG_0_VAL_DEFAULT            0  /* full functionality */
#define ATC_ECPMUCFG_1_VAL_MIN                0
#define ATC_ECPMUCFG_1_VAL_MAX                5
#define ATC_ECPMUCFG_1_VAL_DEFAULT            0  /* full functionality */

/* AT+ECPCFG */
#define ATC_ECPCFG_MAX_PARM_STR_LEN             32
#define ATC_ECPCFG_MAX_PARM_STR_DEFAULT         NULL

#define ATC_ECPCFG_VAL_MIN                0
#define ATC_ECPCFG_VAL_MAX                0xffff
#define ATC_ECPCFG_VAL_DEFAULT            0  /* full functionality */

#define ATC_ECPCFG_WDT_VAL_MIN                0
#define ATC_ECPCFG_WDT_VAL_MAX                1
#define ATC_ECPCFG_WDT_VAL_DEFAULT            0  /* full functionality */

#define ATC_ECPCFG_UART_DUMP_PORT_VAL_MIN                0
#define ATC_ECPCFG_UART_DUMP_PORT_VAL_MAX                255
#define ATC_ECPCFG_UART_DUMP_PORT_VAL_DEFAULT            1  /* full functionality */

#define ATC_ECPCFG_UNI_CTRL_VAL_MIN                0
#define ATC_ECPCFG_UNI_CTRL_VAL_MAX                2
#define ATC_ECPCFG_UNI_CTRL_VAL_DEFAULT            2  /* full functionality */

#define ATC_ECPCFG_UNI_LEVEL_VAL_MIN                0
#define ATC_ECPCFG_UNI_LEVEL_VAL_MAX                5
#define ATC_ECPCFG_UNI_LEVEL_VAL_DEFAULT            0  /* full functionality */

#define ATC_ECPCFG_LOG_BAUDRATE_VAL_MIN                921600
#define ATC_ECPCFG_LOG_BAUDRATE_VAL_MAX                6000001
#define ATC_ECPCFG_LOG_BAUDRATE_VAL_DEFAULT            6000000  /* full functionality */

#define ATC_ECPCFG_SLEEP_VAL_MIN                0
#define ATC_ECPCFG_SLEEP_VAL_MAX                0xffff
#define ATC_ECPCFG_SLEEP_VAL_DEFAULT            0  /* full functionality */

#define ATC_ECPCFG_FAULT_VAL_MIN                EXCEP_OPTION_DUMP_FLASH_EPAT_LOOP
#define ATC_ECPCFG_FAULT_VAL_MAX                (EXCEP_OPTION_MAX)
#define ATC_ECPCFG_FAULT_VAL_DEFAULT            EXCEP_OPTION_DUMP_FLASH_EPAT_LOOP  /* full functionality */

#define ATC_ECPCFG_LOG_PORT_SEL_MIN             0
#define ATC_ECPCFG_LOG_PORT_SEL_MAX             2
#define ATC_ECPCFG_LOG_PORT_SEL_DEFAULT         0


#define ATC_ECPCFG_USB_CTRL_VAL_MIN             0
#define ATC_ECPCFG_USB_CTRL_VAL_MAX             2
#define ATC_ECPCFG_USB_CTRL_VAL_DEFAULT         0

#define ATC_ECPCFG_USB_SW_TRACEFLAG_VAL_MIN             0
#define ATC_ECPCFG_USB_SW_TRACEFLAG_VAL_MAX             0x0fffffff
#define ATC_ECPCFG_USB_SW_TRACEFLAG_VAL_DEFAULT          0


#define ATC_ECPCFG_USB_SLPMASK_VAL_MIN          0
#define ATC_ECPCFG_USB_SLPMASK_VAL_MAX          1
#define ATC_ECPCFG_USB_SLPMASK_VAL_DEFAULT      0

#define ATC_ECPCFG_USB_SLPTHD_VAL_MIN           0
#define ATC_ECPCFG_USB_SLPTHD_VAL_MAX           0xFFFF
#define ATC_ECPCFG_USB_SLPTHD_VAL_DEFAULT       0

#define ATC_ECPCFG_PWRKEY_MODE_VAL_MIN          0
#define ATC_ECPCFG_PWRKEY_MODE_VAL_MAX          2
#define ATC_ECPCFG_PWRKEY_MODE_VAL_DEFAULT      0

#define ATC_ECPCFG_USBNET_VAL_MIN               0
#define ATC_ECPCFG_USBNET_VAL_MAX               1
#define ATC_ECPCFG_USBNET_VAL_DEFAULT           0

#define ATC_ECPCFG_PMUINCDRX_VAL_MIN               0
#define ATC_ECPCFG_PMUINCDRX_VAL_MAX               1
#define ATC_ECPCFG_PMUINCDRX_VAL_DEFAULT           0

#define ATC_ECPCFG_FOTA_URC_PORT_TYPE_USB       PLAT_CFG_FOTA_URC_PORT_USB
#define ATC_ECPCFG_FOTA_URC_PORT_TYPE_UART      PLAT_CFG_FOTA_URC_PORT_UART

#define ATC_ECPCFG_FOTA_URC_USB_PORT_IDX_MIN    PLAT_CFG_FOTA_URC_USB_PORT_IDX_MIN
#define ATC_ECPCFG_FOTA_URC_USB_PORT_IDX_MAX    PLAT_CFG_FOTA_URC_USB_PORT_IDX_MAX

#define ATC_ECPCFG_FOTA_URC_UART_PORT_IDX_MIN   PLAT_CFG_FOTA_URC_UART_PORT_IDX_MIN
#define ATC_ECPCFG_FOTA_URC_UART_PORT_IDX_MAX   PLAT_CFG_FOTA_URC_UART_PORT_IDX_MAX

#define ATC_ECPCFG_FOTA_URC_PORT_SEL_MIN        ((ATC_ECPCFG_FOTA_URC_PORT_TYPE_USB << 4)  | ATC_ECPCFG_FOTA_URC_USB_PORT_IDX_MIN)
#define ATC_ECPCFG_FOTA_URC_PORT_SEL_MAX        ((ATC_ECPCFG_FOTA_URC_PORT_TYPE_UART << 4) | ATC_ECPCFG_FOTA_URC_UART_PORT_IDX_MAX)
#define ATC_ECPCFG_FOTA_URC_PORT_SEL_DEFAULT    ((ATC_ECPCFG_FOTA_URC_PORT_TYPE_USB << 4)  | 0)

/* AT+ECUSBSYS */
#define ATC_ECUSBSYS_MAX_PARM_STR_LEN           32
#define ATC_ECUSBSYS_MAX_PARM_STR_DEFAULT       NULL

#define ATC_ECUSBSYS_VAL_MIN                    0
#define ATC_ECUSBSYS_VAL_MAX                    0xffff
#define ATC_ECUSBSYS_VAL_DEFAULT                0  /* full functionality */

#define ATC_ECUSBSYS_VBUS_MODE_EN_VAL_MIN                0
#define ATC_ECUSBSYS_VBUS_MODE_EN_VAL_MAX                1
#define ATC_ECUSBSYS_VBUS_MODE_EN_VAL_DEFAULT            0

#define ATC_ECUSBSYS_VBUS_WKUP_PAD_VAL_MIN                0
#define ATC_ECUSBSYS_VBUS_WKUP_PAD_VAL_MAX                5
#define ATC_ECUSBSYS_VBUS_WKUP_PAD_VAL_DEFAULT            1


#define ATC_TASKINFO_LEN                64

/* AT+IPR */
#define ATC_IPR_MAX_PARM_STR_LEN             32
#define ATC_IPR_MAX_PARM_STR_DEFAULT         NULL

/* AT+ECLEDMODE */
#define ATC_ECLED_MODE_VAL_MIN               0
#define ATC_ECLED_MODE_VAL_MAX               1
#define ATC_ECLED_MODE_VAL_DEFAULT           0

/* AT+ECFLASHMONITORINFO */
#define ATC_ECFLASHMONITORINFO_VAL_MIN            0
#define ATC_ECFLASHMONITORINFO_VAL_MAX            3
#define ATC_ECFLASHMONITORINFO_VAL_DEFAULT        1

/* AT+ECPURC */
#define ATC_ECPURC_0_MAX_PARM_STR_LEN                 16
#define ATC_ECPURC_0_MAX_PARM_STR_DEFAULT             NULL
#define ATC_ECPURC_1_VAL_MIN                 0
#define ATC_ECPURC_1_VAL_MAX                 1
#define ATC_ECPURC_1_VAL_DEFAULT             0

/* AT+ECPALARM */
#define ATC_ECPALARM_0_MAX_PARM_STR_LEN             8
#define ATC_ECPALARM_0_MAX_PARM_STR_DEFAULT         NULL
#define ATC_ECPALARM_1_VAL_MIN                      0
#define ATC_ECPALARM_1_VAL_MAX                      1
#define ATC_ECPALARM_1_VAL_DEFAULT                  0
#define ATC_ECPALARM_VOLT_VAL_MIN                   0
#define ATC_ECPALARM_VOLT_VAL_MAX                   25
#define ATC_ECPALARM_VOLT_VAL_DEFAULT               0
#define ATC_ECPALARM_THERM_VAL_MIN                  0
#define ATC_ECPALARM_THERM_VAL_MAX                  3
#define ATC_ECPALARM_THERM_VAL_DEFAULT              3
#define ATC_ECPALARM_HYSTER_VAL_MIN                 0
#define ATC_ECPALARM_HYSTER_VAL_MAX                 3
#define ATC_ECPALARM_HYSTER_VAL_DEFAULT             3

/* AT+ICF */
#define ATC_ICF_FORMAT_VAL_MIN               1
#define ATC_ICF_FORMAT_VAL_MAX               6
#define ATC_ICF_FORMAT_VAL_DEFAULT           3

#define ATC_ICF_PARITY_VAL_MIN               0
#define ATC_ICF_PARITY_VAL_MAX               1
#define ATC_ICF_PARITY_VAL_DEFAULT           0

/* AT+IFC */
#define ATC_IFC_RTS_VAL_MIN               0
#define ATC_IFC_RTS_VAL_MAX               2
#define ATC_IFC_RTS_VAL_DEFAULT           0

#define ATC_IFC_CTS_VAL_MIN               0
#define ATC_IFC_CTS_VAL_MAX               2
#define ATC_IFC_CTS_VAL_DEFAULT           0

/* AT+ECSCLK */
#define ATC_EC_SCLK_VAL_MIN               0
#define ATC_EC_SCLK_VAL_MAX               1
#define ATC_EC_SCLK_VAL_DEFAULT           0

/* AT+ECMEM32 */
#define ATC_ECMEM32_OPMODE_VAL_READ                 0
#define ATC_ECMEM32_OPMODE_VAL_WRITE                1
#define ATC_ECMEM32_OPMODE_VAL_DEFAULT              0

#define ATC_ECMEM32_ADDR_VAL_MIN                    0x80000000
#define ATC_ECMEM32_ADDR_VAL_MAX                    0x7fffffff
#define ATC_ECMEM32_ADDR_VAL_DEFAULT                0


#define ATC_ECMEM32_VAL_MIN                         0x80000000
#define ATC_ECMEM32_VAL_MAX                         0x7fffffff
#define ATC_ECMEM32_VAL_DEFAULT                     0


/* AT+ECPOWD */
#define ATC_ECPOWD_VAL_MIN                          0
#define ATC_ECPOWD_VAL_MAX                          1
#define ATC_ECPOWD_VAL_DEFAULT                      1

/* AT+ECBTOFFSETDBG */
#define ATC_ECBTOFFSETDBG_VAL_MIN                          0x80000000
#define ATC_ECBTOFFSETDBG_VAL_MAX                          0x7fffffff
#define ATC_ECBTOFFSETDBG_VAL_DEFAULT                      0

#define PRINTF_BUF_LEN 512
#define ECFSINFO_PRINT_BUF_LEN     (256)

/* AT+RLCHK */
#define ATC_RLCHK_MAX_PARM_STR_LEN             32
#define ATC_RLCHK_MAX_PARM_STR_DEFAULT         NULL

//CmsRetId pdevHELP(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevRST(const AtCmdInputContext *pAtCmdReq);
//CmsRetId pdevPOWERON(const AtCmdInputContext *pAtCmdReq);
//CmsRetId pdevPOWEROFF(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECTASKINFO(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECTASKHISTINFO(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECSHOWMEM(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECHEAPINFO(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECDLFCMEM(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECFSINFO(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECFSFORMAT(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECFMONITORINFO(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevSYSTEST(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECSYSTEST(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECLOGDBVER(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECPCFG(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECUSBSYS(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECPMUCFG(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECVOTECHK(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevIPR(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevNetLight(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevPMUSTATUS(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECPURC(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECPALARM(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevICF(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevIFC(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECMEM32(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECSCLK(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECDUMPCHK(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECPOWD(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevBTOFFSETDBG(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevRLCHK(const AtCmdInputContext *pAtCmdReq);

#endif

/* END OF FILE */
