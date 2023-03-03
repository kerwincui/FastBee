/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    psl1commtype.h
 * Description:
 * History:      25/04/2021    Originated
 *
 ****************************************************************************/

#ifndef _PS_L1_COMMON_TYPE_H_
#define _PS_L1_COMMON_TYPE_H_

/*********************************************************************************
* Includes
*********************************************************************************/
#ifdef WIN32
#include "pssys.h"
#else
#include "CommonTypedef.h"
#endif


/******************************************************************************
 *****************************************************************************
 * MACRO
 *****************************************************************************
******************************************************************************/
#define SUPPORT_MAX_BAND_NUM            32                         //Extend from 16 to 32, 2020-7-28
#define RRC_PHY_SUPPORT_BAND_NUM        SUPPORT_MAX_BAND_NUM       //this value should be the same as PHY_SUPPORT_BAND_NUM



/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/

/******************************************************************************
 * Plmn
 * Numberic PLMN format, 4 bytes,
 * example: CMCC: 46000; mcc = 0x0460, mnc = 0xf000
 *        00101; mcc = 0x0001, mnc = 0xf001
 *        46012; mcc = 0x0460, mnc = 0xf012
 *        460123; mcc = 0x0460, mnc = 0x0123
******************************************************************************/
typedef struct _EPAT_Plmn_Tag
{
    UINT16  mcc;
    UINT16  mncWithAddInfo; // if 2-digit MNC type, the 4 MSB bits should set to 'F',
}Plmn;


/*
 * UE category, ref to 36.306
*/
typedef UINT8 UeCategoryType_t;
typedef enum _EPAT_UeCategoryType_Tag
{
    UeCategory_NB1 = 0x01,
    UeCategory_NB2 = 0x02,
    UeCategory_M1 = 0x11,
    UeCategory_M2 = 0x12,
    UeCategory_Cat1Base = 0x20, //only used for Cat1 start point
    UeCategory_Cat1 = 0x21,
    UeCategory_Cat1bis = 0x22,
}UeCategoryType;

/*
 * As Release, start from Rel-13
*/
typedef UINT8 AsReleaseType_t;
typedef enum _EPAT_AsReleaseType_Tag
{
    AsRelease_13 = 13,
    AsRelease_14,
    AsRelease_15,
}AsReleaseType;


/*
 * CERRC_CFG_UE_POWER_CLASS_SETTING
*/
typedef struct PsCfgConfigedUePowerClassTag
{
    //now support to 255
    UINT8                                   freqBandIndicator;
    /*refer to TS36.101 table 6.2.2F-1,
      -- 3 represents Class3(maxpower: 23dBm)
      -- 5 represents Class5 (maxpower: 20dBm)
      -- 6 represents Class6 (maxpower: 14dBm) and only apply for R14 and later */
    UINT8                                   uePowerClass;
}PsCfgConfigedUePowerClass;

typedef struct PsCfgCerrcUePowerClassSetting_Tag
{
    UINT8           numOfBand;
    UINT8           rsvd0;
    UINT16          rsvd1;
    PsCfgConfigedUePowerClass    bandAndPowerClass[RRC_PHY_SUPPORT_BAND_NUM];
}PsCfgCerrcUePowerClassSetting;     // 68 bytes


#endif

