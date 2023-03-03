/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_plat_test.h
*
*  Description: plat verification related AT CMD
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_PLAT_TEST_H__
#define __ATEC_PLAT_TEST_H__

#include "at_util.h"

#define PRINTF_BUF_LEN                              512
#define ATC_MALLOC_MAGIN_32                         32
#define ATC_MALLOC_MAGIN_64                         64

/* AT+ECPERTEST */
#define ATC_ECPERTEST_MODULE_MAX_PARM_STR_LEN       16
#define ATC_ECPERTEST_MODULE_MAX_PARM_STR_DEFAULT   NULL


#define ATC_ECPERTEST_CASENUM_VAL_MIN               0
#define ATC_ECPERTEST_CASENUM_VAL_MAX               256
#define ATC_ECPERTEST_CASENUM_VAL_DEFAULT           0

#define ATC_ECPERTEST_INSNUM_VAL_MIN                0
#define ATC_ECPERTEST_INSNUM_VAL_MAX                256
#define ATC_ECPERTEST_INSNUM_VAL_DEFAULT            0


#define ATC_ECPERTEST_LOOPCNT_VAL_MIN               0
#define ATC_ECPERTEST_LOOPCNT_VAL_MAX               0x7fffffff
#define ATC_ECPERTEST_LOOPCNT_VAL_DEFAULT           0

#define ATC_ECPERTEST_WAKEUPNUM_VAL_MIN             0
#define ATC_ECPERTEST_WAKEUPNUM_VAL_MAX             5
#define ATC_ECPERTEST_WAKEUPNUM_VAL_DEFAULT         0

#define ATC_ECPERTEST_WAKEUPEN_VAL_MIN              0
#define ATC_ECPERTEST_WAKEUPEN_VAL_MAX              1
#define ATC_ECPERTEST_WAKEUPEN_VAL_DEFAULT          0

#define ATC_ECPERTEST_WAKEUPEDGE_VAL_MIN            0
#define ATC_ECPERTEST_WAKEUPEDGE_VAL_MAX            1
#define ATC_ECPERTEST_WAKEUPEDGE_VAL_DEFAULT        0

#define ATC_ECPERTEST_SLEEPMODE_VAL_MIN             0
#define ATC_ECPERTEST_SLEEPMODE_VAL_MAX             9
#define ATC_ECPERTEST_SLEEPMODE_VAL_DEFAULT         0

#define ATC_ECPERTEST_AONIOPWRCTRL_VAL_MIN          0
#define ATC_ECPERTEST_AONIOPWRCTRL_VAL_MAX          1
#define ATC_ECPERTEST_AONIOPWRCTRL_VAL_DEFAULT      0

#define ATC_ECPERTEST_AONIONUM_VAL_MIN              0
#define ATC_ECPERTEST_AONIONUM_VAL_MAX              8
#define ATC_ECPERTEST_AONIONUM_VAL_DEFAULT          0

#define ATC_ECPERTEST_AONIOLEVEL_VAL_MIN            0
#define ATC_ECPERTEST_AONIOLEVEL_VAL_MAX            1
#define ATC_ECPERTEST_AONIOLEVEL_VAL_DEFAULT        0

#define ATC_ECPERTEST_AONIOLATCH_VAL_MIN            0
#define ATC_ECPERTEST_AONIOLATCH_VAL_MAX            1
#define ATC_ECPERTEST_AONIOLATCH_VAL_DEFAULT        0

#define ATC_ECPERTEST_AONIOLDOCASENUM_VAL_MIN       0
#define ATC_ECPERTEST_AONIOLDOCASENUM_VAL_MAX       2
#define ATC_ECPERTEST_AONIOLDOCASENUM_VAL_DEFAULT   0

#define ATC_ECPERTEST_MCUMODECASENUM_VAL_MIN        0
#define ATC_ECPERTEST_MCUMODECASENUM_VAL_MAX        1
#define ATC_ECPERTEST_MCUMODECASENUM_VAL_DEFAULT    0


/* AT+ECI2COPEN */
#define ATC_I2C_INSTANCE_VAL_MIN                    0
#define ATC_I2C_INSTANCE_VAL_MAX                    1
#define ATC_I2C_INSTANCE_VAL_DEFAULT                0

#define ATC_I2C_SPEED_VAL_MIN                       100
#define ATC_I2C_SPEED_VAL_MAX                       1000
#define ATC_I2C_SPEED_VAL_DEFAULT                   100

#define ATC_I2C_SLAVEADDRESS_VAL_MIN                0x1
#define ATC_I2C_SLAVEADDRESS_VAL_MAX                0x3ff
#define ATC_I2C_SLAVEADDRESS_VAL_DEFAULT            0x55

#define ATC_I2C_DATALEN_VAL_MIN                     1
#define ATC_I2C_DATALEN_VAL_MAX                     511
#define ATC_I2C_DATALEN_VAL_DEFAULT                 1

/* AT+ECSPIOPEN */
#define ATC_SPI_INSTANCE_VAL_MIN                    0
#define ATC_SPI_INSTANCE_VAL_MAX                    1
#define ATC_SPI_INSTANCE_VAL_DEFAULT                0

#define ATC_SPI_SPEED_VAL_MIN                       1
#define ATC_SPI_SPEED_VAL_MAX                       10000000  // 10M
#define ATC_SPI_SPEED_VAL_DEFAULT                   100000

#define ATC_SPI_CPOL_VAL_MIN                        0
#define ATC_SPI_CPOL_VAL_MAX                        1
#define ATC_SPI_CPOL_VAL_DEFAULT                    0

#define ATC_SPI_CPHA_VAL_MIN                        0
#define ATC_SPI_CPHA_VAL_MAX                        1
#define ATC_SPI_CPHA_VAL_DEFAULT                    0

#define ATC_SPI_DATALEN_VAL_MIN                     1
#define ATC_SPI_DATALEN_VAL_MAX                     1024
#define ATC_SPI_DATALEN_VAL_DEFAULT                 1

#define ATC_ECONEWREAD_ADDR_STR_LEN            10
#define ATC_ECONEWREAD_ADDR_STR_DEFAULT        NULL

#define ATC_ECREGWRITE_ADDR_STR_LEN            10
#define ATC_ECREGWRITE_ADDR_STR_DEFAULT        NULL

#define ATC_ECREGWRITE_VAL_STR_LEN              10
#define ATC_ECREGWRITE_VAL_STR_DEFAULT          NULL

CmsRetId pdevECPERTEST(const AtCmdInputContext *pAtCmdReq);

CmsRetId pdevECI2COPEN(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECI2CREAD(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECI2CWRITE(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECI2CCLOSE(const AtCmdInputContext *pAtCmdReq);

CmsRetId pdevECONEWOPEN(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECONEWREAD(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECONEWWRITE(const AtCmdInputContext *pAtCmdReq);

CmsRetId pdevECSPIOPEN(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECSPIREAD(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECSPIWRITE(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECSPITRANSFER(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECSPICLOSE(const AtCmdInputContext *pAtCmdReq);

CmsRetId pdevECREGREAD(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECREGWRITE(const AtCmdInputContext *pAtCmdReq);
CmsRetId pdevECSWMODE(const AtCmdInputContext *pAtCmdReq);

#endif

/* END OF FILE */
