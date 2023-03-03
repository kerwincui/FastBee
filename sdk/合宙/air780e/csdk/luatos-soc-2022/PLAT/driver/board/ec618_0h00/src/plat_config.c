/****************************************************************************
 *
 * Copy right:   2019-, Copyrigths of AirM2M Ltd.
 * File name:    plat_config.c
 * Description:  platform configuration source file
 * History:
 *
 ****************************************************************************/

#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include "plat_config.h"
#include "exception_process.h"
#ifdef FEATURE_BOOTLOADER_PROJECT_ENABLE
#include "debug_trace.h"
#include "common.h"
#else
#include DEBUG_LOG_HEADER_FILE
#include "osasys.h"

#define PLAT_CONFIG_FS_ENABLE
#endif

/** \brief config file version
 *  \note when the order of struct \ref plat_config_fs_t and \ref plat_config_raw_flash_t field has changed,
 *        for example, from 1,2,3 to 1,3,2, update version to refresh flash,
 *        in other cases(add more fields or remove some fields from struct \ref plat_config_fs_t), it's not a must to update
 */

// external API declarations
extern uint8_t BSP_QSPI_Erase_Safe(uint32_t SectorAddress, uint32_t Size);
extern uint8_t BSP_QSPI_Write_Safe(uint8_t* pData, uint32_t WriteAddr, uint32_t Size);
extern uint8_t BSP_QSPI_Erase_Sector(uint32_t BlockAddress);
extern uint8_t BSP_QSPI_Write(uint8_t* pData, uint32_t WriteAddr, uint32_t Size);
extern uint8_t getOSState(void);


/**
  \fn           uint8_t BSP_CalcCrcValue(const uint8_t *buf, uint16_t bufSize)
  \brief        Calculate the "CRC" value of data buffer
  \param[in]    buf         buffer pointer
  \param[in]    bufSize     buffer size
  \returns      crcValue
*/
static uint8_t BSP_CalcCrcValue(const uint8_t *buf, uint16_t bufSize)
{
    uint32_t i = bufSize;
    uint32_t a = 1, b = 0;

    EC_ASSERT(buf != NULL && bufSize > 0, buf, bufSize, 0);

    for (i = bufSize; i > 0; )
    {
        a += (uint32_t)(buf[--i]);
        b += a;
    }

    return (uint8_t)(((a>>24)&0xFF)^((a>>16)&0xFF)^((a>>8)&0xFF)^((a)&0xFF)^
                     ((b>>24)&0xFF)^((b>>16)&0xFF)^((b>>8)&0xFF)^((b)&0xFF)^
                     (bufSize&0xFF));
}


#ifdef PLAT_CONFIG_FS_ENABLE
static uint8_t          g_fsPlatConfigInitFlag = 0;
static plat_config_fs_t g_fsPlatConfig;

/**
  \fn           void BSP_SetDefaultFsPlatConfig(void)
  \brief        set default value of "g_fsPlatConfig"
  \return       void
*/
static void BSP_SetDefaultFsPlatConfig(void)
{
    g_fsPlatConfigInitFlag = 1;

    memset(&g_fsPlatConfig, 0x0, sizeof(g_fsPlatConfig));
    g_fsPlatConfig.atPortBaudRate = 115200;
}

void BSP_LoadPlatConfigFromFs(void)
{
    OSAFILE fp = PNULL;
    UINT32  readCount = 0;
    UINT8   crcCheck = 0;
    config_file_header_t fileHeader;

    /*
     * open NVM file
     */
    fp = OsaFopen("plat_config", "rb");   //read only
    if (fp == PNULL)
    {
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_LoadPlatConfig_1, P_ERROR,
                    "Can't open 'plat_config' file, use the defult value");

        BSP_SetDefaultFsPlatConfig();
        BSP_SavePlatConfigToFs();

        return;
    }

    /*
     * read file header
     */
    readCount = OsaFread(&fileHeader, sizeof(config_file_header_t), 1, fp);
    if (readCount != 1)
    {
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_LoadPlatConfig_2, P_ERROR,
                    "Can't read 'plat_config' file header, use the defult value");

        OsaFclose(fp);

        BSP_SetDefaultFsPlatConfig();
        BSP_SavePlatConfigToFs();

        return;
    }

    /*
     * read file body, check validation and handle compatiblity issue
     */
    if(fileHeader.version != FS_PLAT_CONFIG_FILE_CURRENT_VERSION)
    {
        if(fileHeader.version == 0)
        {
        }
        // handle future version below
        else if(0)
        {

        }
        else
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_LoadPlatConfig_5, P_ERROR,
                        "'plat_config' version:%d not right, use the defult value", fileHeader.version);

            OsaFclose(fp);

            BSP_SetDefaultFsPlatConfig();
            BSP_SavePlatConfigToFs();
        }
    }
    else
    {
        if(fileHeader.fileBodySize != sizeof(g_fsPlatConfig))
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_LoadPlatConfig_3, P_ERROR,
                        "'plat_config' version:%d file body size not right: (%u/%u), use the defult value",
                        fileHeader.version, fileHeader.fileBodySize, sizeof(plat_config_fs_t));

            OsaFclose(fp);

            BSP_SetDefaultFsPlatConfig();
            BSP_SavePlatConfigToFs();
        }
        else
        {
            readCount = OsaFread(&g_fsPlatConfig, sizeof(g_fsPlatConfig), 1, fp);
            crcCheck = BSP_CalcCrcValue((uint8_t *)&g_fsPlatConfig, sizeof(g_fsPlatConfig));

            OsaFclose(fp);

            if (readCount != 1 || crcCheck != fileHeader.checkSum)
            {
                ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_LoadPlatConfig_4, P_ERROR,
                            "Can't read 'plat_config' version:%d file body, or body not right, (%u/%u), use the defult value",
                            fileHeader.version, crcCheck, fileHeader.checkSum);

                BSP_SetDefaultFsPlatConfig();
                BSP_SavePlatConfigToFs();
            }
            else
            {
                g_fsPlatConfigInitFlag = 1;
            }
        }

    }

    return;
}


void BSP_SetFsPorDefaultValue(void)
{
    bool fsCfgChanged = false;
    if(g_fsPlatConfig.ecSclkCfg != 0)
    {
        g_fsPlatConfig.ecSclkCfg = 0;
        fsCfgChanged = true;
    }
    if(fsCfgChanged)
    {
        BSP_SavePlatConfigToFs();
    }
}



void BSP_SavePlatConfigToFs(void)
{
    OSAFILE fp = PNULL;
    UINT32  writeCount = 0;
    config_file_header_t fileHeader;

    /*
     * open the config file
    */
    fp = OsaFopen("plat_config", "wb");   //write & create
    if (fp == PNULL)
    {
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SavePlatConfig_1, P_ERROR,
                    "Can't open/create 'plat_config' file, save plat_config failed");

        return;
    }

    /*
     * write the header
    */
    fileHeader.fileBodySize   = sizeof(g_fsPlatConfig);
    fileHeader.version        = FS_PLAT_CONFIG_FILE_CURRENT_VERSION;
    fileHeader.checkSum       = BSP_CalcCrcValue((uint8_t *)&g_fsPlatConfig, sizeof(g_fsPlatConfig));

    writeCount = OsaFwrite(&fileHeader, sizeof(config_file_header_t), 1, fp);
    if (writeCount != 1)
    {
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SavePlatConfig_2, P_ERROR,
                   "Write 'plat_config' file header failed");

        OsaFclose(fp);
        return;
    }

    /*
     * write the file body
    */
    writeCount = OsaFwrite(&g_fsPlatConfig, sizeof(g_fsPlatConfig), 1, fp);
    if (writeCount != 1)
    {
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SavePlatConfig_3, P_ERROR,
                   "Write 'plat_config' file body failed");
    }

    OsaFclose(fp);
    return;

}

plat_config_fs_t* BSP_GetFsPlatConfig(void)
{
    return &g_fsPlatConfig;
}

uint32_t BSP_GetFSAssertCount(void)
{
    plat_info_layout_t platInfo;

    // read
    memcpy((uint8_t*)&platInfo, (void*)FLASH_MEM_PLAT_INFO_ADDR, sizeof(plat_info_layout_t));

    return platInfo.fsAssertCount;
}

void BSP_SetFSAssertCount(uint32_t value)
{
    plat_info_layout_t platInfo;

    // read
    memcpy((uint8_t*)&platInfo, (void*)FLASH_MEM_PLAT_INFO_ADDR, sizeof(plat_info_layout_t));

    // modify
    platInfo.fsAssertCount = value;

    // erase
    if(BSP_QSPI_Erase_Safe(FLASH_MEM_PLAT_INFO_NONXIP_ADDR, FLASH_MEM_PLAT_INFO_SIZE) != 0)
    {
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SetFSAssertCount_0, P_ERROR, "Erase flash error!!!");
        return;
    }

    // write back
    if(BSP_QSPI_Write_Safe((uint8_t*)&platInfo, FLASH_MEM_PLAT_INFO_NONXIP_ADDR, sizeof(plat_info_layout_t)) != 0)
    {
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SetFSAssertCount_1, P_ERROR, "Update fsAssertCount value error!!!");
    }

}

#endif


plat_config_raw_flash_t g_rawFlashPlatConfig;

/**
  \fn           void BSP_SetDefaultRawFlashPlatConfig(void)
  \brief        set default value of "g_rawFlashPlatConfig"
  \return       void
*/
static void BSP_SetDefaultRawFlashPlatConfig(void)
{
#ifdef __USER_CODE__
    g_rawFlashPlatConfig.faultAction = EXCEP_OPTION_DUMP_FLASH_RESET;//silent anable
    g_rawFlashPlatConfig.startWDT = 1;//start wdt
    g_rawFlashPlatConfig.uartDumpPort = 0xff; // default at port
#else
#ifdef SDK_REL_BUILD
    g_rawFlashPlatConfig.faultAction = 4;//silent anable
    g_rawFlashPlatConfig.startWDT = 1;//start wdt
#else
    g_rawFlashPlatConfig.faultAction = 0;
    g_rawFlashPlatConfig.startWDT = 0;
#endif

    g_rawFlashPlatConfig.uartDumpPort = 1; // default at port
#endif
    g_rawFlashPlatConfig.logControl = 0x2;

    g_rawFlashPlatConfig.uartBaudRate = 3000000;

    g_rawFlashPlatConfig.logLevel = P_DEBUG;

    g_rawFlashPlatConfig.logPortSel = PLAT_CFG_ULG_PORT_MIX;//default MIX mode

    g_rawFlashPlatConfig.usbCtrl = 0;//all en

    g_rawFlashPlatConfig.usbSlpMask = 0;  // no mask

    g_rawFlashPlatConfig.usbSlpThd = 0;

    g_rawFlashPlatConfig.pwrKeyMode = 0;

    g_rawFlashPlatConfig.usbVBUSModeEn = 0;

    g_rawFlashPlatConfig.usbVBUSWkupPad = 1;

    g_rawFlashPlatConfig.usbNet = 0;

    g_rawFlashPlatConfig.usbVcomEnBitMap = 0;

#ifdef PLAT_CONFIG_FS_ENABLE
    g_rawFlashPlatConfig.atPortBaudRate = g_fsPlatConfigInitFlag ? g_fsPlatConfig.atPortBaudRate : 115200;
#else
    g_rawFlashPlatConfig.atPortBaudRate = 115200;
#endif
    g_rawFlashPlatConfig.fotaUrcPortSel = (PLAT_CFG_FOTA_URC_PORT_USB << 4) | 0;

    g_rawFlashPlatConfig.pmuInCdrx = 1;

    g_rawFlashPlatConfig.slpLimitEn = 0;

    g_rawFlashPlatConfig.slpLimitTime = 0;

    memset(g_rawFlashPlatConfig.resv, 0x0,PLAT_CFG_RAW_FLASH_RSVD_SIZE);
}

void BSP_SavePlatConfigToRawFlash(void)
{
    plat_info_layout_t platInfo;

    // read
    memcpy((uint8_t*)&platInfo, (void*)FLASH_MEM_PLAT_INFO_ADDR, sizeof(plat_info_layout_t));

    // modify start //
    // header part
    platInfo.header.fileBodySize   = sizeof(plat_config_raw_flash_t);
    platInfo.header.version        = RAW_FLASH_PLAT_CONFIG_FILE_CURRENT_VERSION;
    platInfo.header.checkSum       = BSP_CalcCrcValue((uint8_t *)&g_rawFlashPlatConfig, sizeof(g_rawFlashPlatConfig));

    // body part
    platInfo.config = g_rawFlashPlatConfig;
    // modify end //

    // write back

#ifndef FEATURE_BOOTLOADER_PROJECT_ENABLE
    if(1 == getOSState())
    {
        if(BSP_QSPI_Erase_Safe(FLASH_MEM_PLAT_INFO_NONXIP_ADDR, FLASH_MEM_PLAT_INFO_SIZE) != 0)
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SavePlatConfigToRawFlash_1, P_ERROR, "Erase flash error!!!");
            return;
        }

        if(BSP_QSPI_Write_Safe((uint8_t*)&platInfo, FLASH_MEM_PLAT_INFO_NONXIP_ADDR, sizeof(plat_info_layout_t)) != 0)
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SavePlatConfigToRawFlash_2, P_ERROR, "Save plat config to raw flash error!!!");
        }
    }
    else
#endif
    {
        if(BSP_QSPI_Erase_Sector(FLASH_MEM_PLAT_INFO_NONXIP_ADDR) != 0)
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SavePlatConfigToRawFlash_3, P_ERROR, "Erase flash error!!!");
            return;
        }

        if(BSP_QSPI_Write((uint8_t*)&platInfo, FLASH_MEM_PLAT_INFO_NONXIP_ADDR, sizeof(plat_info_layout_t)) != 0)
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SavePlatConfigToRawFlash_4, P_ERROR, "Save plat config to raw flash error!!!");
        }
    }

}

static void BSP_WriteToRawFlash(uint8_t* pBuffer, uint32_t bufferSize)
{
    if(pBuffer == NULL || bufferSize == 0)
    {
        return;
    }

#ifndef FEATURE_BOOTLOADER_PROJECT_ENABLE
    if(1 == getOSState())
    {
        if(BSP_QSPI_Erase_Safe(FLASH_MEM_PLAT_INFO_NONXIP_ADDR, FLASH_MEM_PLAT_INFO_SIZE) != 0)
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_WriteToRawFlash_1, P_ERROR, "Erase flash error!!!");
            return;
        }

        if(BSP_QSPI_Write_Safe(pBuffer, FLASH_MEM_PLAT_INFO_NONXIP_ADDR, bufferSize) != 0)
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_WriteToRawFlash_2, P_ERROR, "Save plat config to raw flash error!!!");
        }
    }
    else
#endif
    {
        if(BSP_QSPI_Erase_Sector(FLASH_MEM_PLAT_INFO_NONXIP_ADDR) != 0)
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_WriteToRawFlash_3, P_ERROR, "Erase flash error!!!");
            return;
        }

        if(BSP_QSPI_Write(pBuffer, FLASH_MEM_PLAT_INFO_NONXIP_ADDR, bufferSize) != 0)
        {
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_WriteToRawFlash_4, P_ERROR, "Save plat config to raw flash error!!!");
        }
    }

}

void BSP_LoadPlatConfigFromRawFlash(void)
{
    plat_info_layout_t platInfo;
    config_file_header_t header;
    uint32_t fsAssertCount;

    /*
     * read file header
     */
    memcpy((uint8_t*)&header, (void*)FLASH_MEM_PLAT_INFO_ADDR, sizeof(header));

    if(header.version != RAW_FLASH_PLAT_CONFIG_FILE_CURRENT_VERSION)
    {
        if(header.version == 0)
        {
            plat_config_raw_flash_v0_t v0Config;

            BSP_SetDefaultRawFlashPlatConfig();

            // migrate from old version
            if(header.fileBodySize == sizeof(plat_config_raw_flash_v0_t))
            {
                memcpy((uint8_t*)&v0Config, (void*)(FLASH_MEM_PLAT_INFO_ADDR + sizeof(config_file_header_t)), sizeof(v0Config));
                memcpy((uint8_t*)&fsAssertCount, (void*)(FLASH_MEM_PLAT_INFO_ADDR + sizeof(config_file_header_t) + sizeof(v0Config)), sizeof(fsAssertCount));

                g_rawFlashPlatConfig.faultAction = v0Config.faultAction;
                g_rawFlashPlatConfig.uartDumpPort = v0Config.uartDumpPort;
                g_rawFlashPlatConfig.startWDT = v0Config.startWDT;
                g_rawFlashPlatConfig.logControl = v0Config.logControl;
                g_rawFlashPlatConfig.uartBaudRate = v0Config.uartBaudRate;
                g_rawFlashPlatConfig.logLevel = v0Config.logLevel;
                g_rawFlashPlatConfig.logPortSel = v0Config.logPortSel;
                g_rawFlashPlatConfig.usbCtrl = v0Config.usbCtrl;
                g_rawFlashPlatConfig.usbSwTrace = v0Config.usbSwTrace;
                g_rawFlashPlatConfig.usbSlpMask = v0Config.usbSlpMask;
                g_rawFlashPlatConfig.usbSlpThd = v0Config.usbSlpThd;
                g_rawFlashPlatConfig.pwrKeyMode = v0Config.pwrKeyMode;

                platInfo.header.fileBodySize   = sizeof(plat_config_raw_flash_t);
                platInfo.header.version        = RAW_FLASH_PLAT_CONFIG_FILE_CURRENT_VERSION;
                platInfo.header.checkSum       = BSP_CalcCrcValue((uint8_t *)&g_rawFlashPlatConfig, sizeof(g_rawFlashPlatConfig));

                platInfo.config = g_rawFlashPlatConfig;

                platInfo.fsAssertCount = fsAssertCount;

            }
            // version matches but size is wrong, use default value
            else
            {
                platInfo.header.fileBodySize   = sizeof(plat_config_raw_flash_t);
                platInfo.header.version        = RAW_FLASH_PLAT_CONFIG_FILE_CURRENT_VERSION;
                platInfo.header.checkSum       = BSP_CalcCrcValue((uint8_t *)&g_rawFlashPlatConfig, sizeof(g_rawFlashPlatConfig));

                platInfo.config = g_rawFlashPlatConfig;
                platInfo.fsAssertCount = 0;
            }

            BSP_WriteToRawFlash((uint8_t*)&platInfo, sizeof(platInfo));

        }
        else if(0)
        {
            // handle future version
        }
        else
        {
            // version is invalid

            BSP_SetDefaultRawFlashPlatConfig();

            platInfo.header.fileBodySize   = sizeof(plat_config_raw_flash_t);
            platInfo.header.version        = RAW_FLASH_PLAT_CONFIG_FILE_CURRENT_VERSION;
            platInfo.header.checkSum       = BSP_CalcCrcValue((uint8_t *)&g_rawFlashPlatConfig, sizeof(g_rawFlashPlatConfig));

            platInfo.config = g_rawFlashPlatConfig;
            platInfo.fsAssertCount = 0;

            BSP_WriteToRawFlash((uint8_t*)&platInfo, sizeof(platInfo));

        }
    }
    else
    {
        // file body check
        memcpy((uint8_t*)&g_rawFlashPlatConfig, (void*)(FLASH_MEM_PLAT_INFO_ADDR + sizeof(config_file_header_t)), sizeof(g_rawFlashPlatConfig));

        if((header.fileBodySize != sizeof(plat_config_raw_flash_t)) ||
           (header.checkSum != BSP_CalcCrcValue((uint8_t *)&g_rawFlashPlatConfig, sizeof(g_rawFlashPlatConfig))))
        {

            BSP_SetDefaultRawFlashPlatConfig();

            platInfo.header.fileBodySize   = sizeof(plat_config_raw_flash_t);
            platInfo.header.version        = RAW_FLASH_PLAT_CONFIG_FILE_CURRENT_VERSION;
            platInfo.header.checkSum       = BSP_CalcCrcValue((uint8_t *)&g_rawFlashPlatConfig, sizeof(g_rawFlashPlatConfig));

            platInfo.config = g_rawFlashPlatConfig;
            platInfo.fsAssertCount = 0;

            BSP_WriteToRawFlash((uint8_t*)&platInfo, sizeof(platInfo));
        }
        else
        {
        #ifdef PLAT_CONFIG_FS_ENABLE
            if(g_fsPlatConfigInitFlag && g_fsPlatConfig.atPortBaudRate != g_rawFlashPlatConfig.atPortBaudRate)
            {
                g_rawFlashPlatConfig.atPortBaudRate = g_fsPlatConfig.atPortBaudRate;

                memcpy((uint8_t*)&fsAssertCount, (void*)(FLASH_MEM_PLAT_INFO_ADDR + sizeof(config_file_header_t) + sizeof(g_rawFlashPlatConfig)), sizeof(fsAssertCount));
                platInfo.header.fileBodySize   = sizeof(plat_config_raw_flash_t);
                platInfo.header.version        = RAW_FLASH_PLAT_CONFIG_FILE_CURRENT_VERSION;
                platInfo.header.checkSum       = BSP_CalcCrcValue((uint8_t *)&g_rawFlashPlatConfig, sizeof(g_rawFlashPlatConfig));

                platInfo.config = g_rawFlashPlatConfig;
                platInfo.fsAssertCount = fsAssertCount;

                BSP_WriteToRawFlash((uint8_t*)&platInfo, sizeof(platInfo));
            }
        #else
            /* do nothing! */
        #endif
        }


    }

}

plat_config_raw_flash_t* BSP_GetRawFlashPlatConfig(void)
{
    return &g_rawFlashPlatConfig;
}

uint32_t BSP_GetPlatConfigItemValue(plat_config_id_t id)
{
    switch(id)
    {
        case PLAT_CONFIG_ITEM_FAULT_ACTION:
            return g_rawFlashPlatConfig.faultAction;

        case PLAT_CONFIG_ITEM_UART_DUMP_PORT:
            return g_rawFlashPlatConfig.uartDumpPort;

        case PLAT_CONFIG_ITEM_START_WDT:
            return g_rawFlashPlatConfig.startWDT;

        case PLAT_CONFIG_ITEM_LOG_CONTROL:
            return g_rawFlashPlatConfig.logControl;

        case PLAT_CONFIG_ITEM_LOG_BAUDRATE:
            return g_rawFlashPlatConfig.uartBaudRate;

        case PLAT_CONFIG_ITEM_LOG_LEVEL:
            return g_rawFlashPlatConfig.logLevel;

        case PLAT_CONFIG_ITEM_ENABLE_PM:
        #ifdef PLAT_CONFIG_FS_ENABLE
            return g_fsPlatConfig.enablePM;
        #else
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_GET_PLAT_CFG_0, P_ERROR, "Get enablePM unsupported yet!");
            return 0;
        #endif

        case PLAT_CONFIG_ITEM_SLEEP_MODE:
        #ifdef PLAT_CONFIG_FS_ENABLE
            return g_fsPlatConfig.sleepMode;
        #else
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_GET_PLAT_CFG_1, P_ERROR, "Get sleepMode unsupported yet!");
            return 0;
        #endif

        case PLAT_CONFIG_ITEM_WAIT_SLEEP:
        #ifdef PLAT_CONFIG_FS_ENABLE
            return g_fsPlatConfig.slpWaitTime;
        #else
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_GET_PLAT_CFG_2, P_ERROR, "Get slpWaitTime unsupported yet!");
            return 0;
        #endif

        case PLAT_CONFIG_ITEM_AT_PORT_BAUDRATE:
        #ifdef PLAT_CONFIG_FS_ENABLE
            #if 0
            EC_ASSERT(g_fsPlatConfig.atPortBaudRate == g_rawFlashPlatConfig.atPortBaudRate,
                      g_fsPlatConfig.atPortBaudRate, g_rawFlashPlatConfig.atPortBaudRate, 0);
            #else
            if(g_fsPlatConfig.atPortBaudRate != g_rawFlashPlatConfig.atPortBaudRate)
            {
                ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_GET_PLAT_CFG_3, P_WARNING, "non-identical baud between fs(%d) & raw(%d)!",
                                                           g_fsPlatConfig.atPortBaudRate, g_rawFlashPlatConfig.atPortBaudRate);
            }
            #endif
            return g_fsPlatConfig.atPortBaudRate;
        #else
            return g_rawFlashPlatConfig.atPortBaudRate;
        #endif

        case PLAT_CONFIG_ITEM_AT_PORT_FRAME_FORMAT:
        #ifdef PLAT_CONFIG_FS_ENABLE
            return g_fsPlatConfig.atPortFrameFormat.wholeValue;
        #else
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_GET_PLAT_CFG_4, P_ERROR, "Get atPortFrameFormat unsupported yet!");
            return 0;
        #endif

        case PLAT_CONFIG_ITEM_ECSCLK_CFG:
        #ifdef PLAT_CONFIG_FS_ENABLE
            return g_fsPlatConfig.ecSclkCfg;
        #else
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_GET_PLAT_CFG_5, P_ERROR, "Get ecSclkCfg unsupported yet!");
            return 0;
        #endif

        case PLAT_CONFIG_ITEM_LOG_PORT_SEL:
            return g_rawFlashPlatConfig.logPortSel;

        case PLAT_CONFIG_ITEM_USB_CTRL:
            return g_rawFlashPlatConfig.usbCtrl;

        case PLAT_CONFIG_ITEM_USB_SW_TRACE_FLAG:
            return g_rawFlashPlatConfig.usbSwTrace;

        case PLAT_CONFIG_ITEM_USB_SLEEP_MASK:
            return g_rawFlashPlatConfig.usbSlpMask;

        case PLAT_CONFIG_ITEM_USB_SLEEP_THD:
            return g_rawFlashPlatConfig.usbSlpThd;

        case PLAT_CONFIG_ITEM_USB_VBUS_MODE_EN:
            return g_rawFlashPlatConfig.usbVBUSModeEn;

        case PLAT_CONFIG_ITEM_USB_VBUS_WKUP_PAD:
            return g_rawFlashPlatConfig.usbVBUSWkupPad;

        case PLAT_CONFIG_ITEM_PWRKEY_MODE:
            return g_rawFlashPlatConfig.pwrKeyMode;

        case PLAT_CONFIG_ITEM_USB_NET:
            return g_rawFlashPlatConfig.usbNet;

        case PLAT_CONFIG_ITEM_USB_VCOM_EN_BMP:
            return g_rawFlashPlatConfig.usbVcomEnBitMap;

        case PLAT_CONFIG_ITEM_FOTA_URC_PORT_SEL:
            return g_rawFlashPlatConfig.fotaUrcPortSel;

        case PLAT_CONFIG_ITEM_PMUINCDRX:
            return g_rawFlashPlatConfig.pmuInCdrx;
			
		case PLAT_CONFIG_ITEM_SLP_LIMIT_EN:
            return g_rawFlashPlatConfig.slpLimitEn;

        case PLAT_CONFIG_ITEM_SLP_LIMIT_TIME:
            return g_rawFlashPlatConfig.slpLimitTime;

        default:
            return 0;
    }
}

void BSP_SetPlatConfigItemValue(plat_config_id_t id, uint32_t value)
{
    switch(id)
    {
        case PLAT_CONFIG_ITEM_FAULT_ACTION:
            if(value <= (EXCEP_OPTION_MAX -1))
                g_rawFlashPlatConfig.faultAction = value;
            break;

        case PLAT_CONFIG_ITEM_UART_DUMP_PORT:
            g_rawFlashPlatConfig.uartDumpPort = value;
            break;

        case PLAT_CONFIG_ITEM_START_WDT:
            if(value <= 1)
                g_rawFlashPlatConfig.startWDT = value;
            break;

        case PLAT_CONFIG_ITEM_LOG_CONTROL:
            if(value <= 2)
                g_rawFlashPlatConfig.logControl = value;
            break;

        case PLAT_CONFIG_ITEM_LOG_BAUDRATE:
            g_rawFlashPlatConfig.uartBaudRate = value;
            break;

        case PLAT_CONFIG_ITEM_LOG_LEVEL:
            if(value <= P_ERROR)
                g_rawFlashPlatConfig.logLevel = (DebugTraceLevelType_e)value;
            break;

        case PLAT_CONFIG_ITEM_ENABLE_PM:
        #ifdef PLAT_CONFIG_FS_ENABLE
            g_fsPlatConfig.enablePM = value;
        #else
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SET_PLAT_CFG_0, P_ERROR, "Set enablePM unsupported yet!");
        #endif
            break;

        case PLAT_CONFIG_ITEM_SLEEP_MODE:
        #ifdef PLAT_CONFIG_FS_ENABLE
            if(value <= 4) g_fsPlatConfig.sleepMode = value;
        #else
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SET_PLAT_CFG_1, P_ERROR, "Set sleepMode unsupported yet!");
        #endif
            break;

        case PLAT_CONFIG_ITEM_WAIT_SLEEP:
        #ifdef PLAT_CONFIG_FS_ENABLE
            g_fsPlatConfig.slpWaitTime = value;
        #else
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SET_PLAT_CFG_2, P_ERROR, "Set slpWaitTime unsupported yet!");
        #endif
            break;

        case PLAT_CONFIG_ITEM_AT_PORT_BAUDRATE:
            g_rawFlashPlatConfig.atPortBaudRate = value;
        #ifdef PLAT_CONFIG_FS_ENABLE
            g_fsPlatConfig.atPortBaudRate = value;
        #else
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SET_PLAT_CFG_3, P_ERROR, "Set atPortBaudRate unsupported yet!");
        #endif
            break;

        case PLAT_CONFIG_ITEM_AT_PORT_FRAME_FORMAT:
        #ifdef PLAT_CONFIG_FS_ENABLE
            g_fsPlatConfig.atPortFrameFormat.wholeValue = value;
        #else
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SET_PLAT_CFG_4, P_ERROR, "Set atPortFrameFormat unsupported yet!");
        #endif
            break;

        case PLAT_CONFIG_ITEM_ECSCLK_CFG:
        #ifdef PLAT_CONFIG_FS_ENABLE
            g_fsPlatConfig.ecSclkCfg = value;
        #else
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, BSP_SET_PLAT_CFG_5, P_ERROR, "Set ecSclkCfg unsupported yet!");
        #endif
            break;

        case PLAT_CONFIG_ITEM_LOG_PORT_SEL:
            g_rawFlashPlatConfig.logPortSel = (PlatCfgUlgPort_e)value;
            break;

        case PLAT_CONFIG_ITEM_USB_CTRL:
            g_rawFlashPlatConfig.usbCtrl = value;
            break;

        case PLAT_CONFIG_ITEM_USB_SW_TRACE_FLAG:
            g_rawFlashPlatConfig.usbSwTrace = value;
            break;

        case PLAT_CONFIG_ITEM_USB_SLEEP_MASK:
            g_rawFlashPlatConfig.usbSlpMask = value;
            break;

        case PLAT_CONFIG_ITEM_USB_SLEEP_THD:
            g_rawFlashPlatConfig.usbSlpThd = value;
            break;

        case PLAT_CONFIG_ITEM_USB_VBUS_MODE_EN:
            g_rawFlashPlatConfig.usbVBUSModeEn = value;
            break;

        case PLAT_CONFIG_ITEM_USB_VBUS_WKUP_PAD:
            g_rawFlashPlatConfig.usbVBUSWkupPad = value;
            break;

        case PLAT_CONFIG_ITEM_PWRKEY_MODE:
            g_rawFlashPlatConfig.pwrKeyMode = value;
            break;

        case PLAT_CONFIG_ITEM_USB_NET:
            g_rawFlashPlatConfig.usbNet = value;
            break;

        case PLAT_CONFIG_ITEM_USB_VCOM_EN_BMP:
            g_rawFlashPlatConfig.usbVcomEnBitMap = value;
            break;

        case PLAT_CONFIG_ITEM_FOTA_URC_PORT_SEL:
            g_rawFlashPlatConfig.fotaUrcPortSel = value;
            break;

        case PLAT_CONFIG_ITEM_PMUINCDRX:
            g_rawFlashPlatConfig.pmuInCdrx = value;
            break;

        case PLAT_CONFIG_ITEM_SLP_LIMIT_EN:
            g_rawFlashPlatConfig.slpLimitEn = value;
            break;

        case PLAT_CONFIG_ITEM_SLP_LIMIT_TIME:
            g_rawFlashPlatConfig.slpLimitTime = value;
            break;
			
        default:
            break;
    }
    return;

}


