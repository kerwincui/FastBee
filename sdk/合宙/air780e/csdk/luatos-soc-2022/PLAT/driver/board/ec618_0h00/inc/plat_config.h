/****************************************************************************
 *
 * Copy right:   2019-, Copyrigths of AirM2M Ltd.
 * File name:    plat_config.h
 * Description:  platform configuration header file
 * History:      Rev1.0   2019-01-18
 *               Rev1.1   2019-11-27   Reimplement file operations with OSA APIs(LFS wrapper), not directly using LFS APIs in case of file system replacement
 *               Rev1.2   2020-01-01   Separate plat config into two parts, FS and raw flash
 *
 ****************************************************************************/

#ifndef  _PLAT_CONFIG_H
#define  _PLAT_CONFIG_H

#include "Driver_Common.h"
#include "cmsis_compiler.h"

/*******************************************************************************
 * Definitions
 ******************************************************************************/

#define FS_PLAT_CONFIG_FILE_CURRENT_VERSION           (0)

#define RAW_FLASH_PLAT_CONFIG_FILE_CURRENT_VERSION    (1)


 /** \brief config file header typedef */
__PACKED_STRUCT _config_file_header
{
    uint16_t fileBodySize;     /**< size of file body, in unit of byte */
    uint8_t  version;          /**< file version, this field shall be updated when file structure is changed */
    uint8_t  checkSum;         /**< check sum value of file body */
};
typedef struct _config_file_header config_file_header_t;

/** \brief typedef of platform configuration stored in fs */
typedef __PACKED_UNION _EPAT_atPortFrameFormat
{
    uint32_t wholeValue;
    __PACKED_STRUCT _config
    {
        uint32_t dataBits    : 3;
        uint32_t parity      : 2;
        uint32_t stopBits    : 2;
        uint32_t flowControl : 3;
    } config;
} atPortFrameFormat_t;



// ulg port enum
typedef enum
{
    PLAT_CFG_ULG_PORT_USB=0,
    PLAT_CFG_ULG_PORT_UART,
    PLAT_CFG_ULG_PORT_MIX,
    PLAT_CFG_ULG_PORT_MAX
} PlatCfgUlgPort_e;



/** \brief typedef of platform configuration stored in fs */
typedef __PACKED_STRUCT _NVM_EPAT_plat_config
{
    /** PM on/off flag
     *  valid value:
     *        0x504D5544 -- PM is disabled, "PMUD"
     *        0x504D5545 -- PM is enabled, "PMUE"
     */
    uint32_t enablePM;

    /** sleep mode
     *  valid value:
     *        0 -- dummy
     *        1 -- dummy
     */
    uint8_t sleepMode;

    /** wait n ms before sleep, when wakeup from pad
     *  valid value:
     *        0 -- do not wait
     *        x -- wait x ms
     */
    uint32_t slpWaitTime;

    /** AT baudrate,for AP only
     *  should be equal to 'atPortBaudRate' in struct plat_config_raw_flash_t
     */
    uint32_t atPortBaudRate;

    /** AT port frame format*/
    atPortFrameFormat_t atPortFrameFormat;

    /** ECQSCLK config
    *  valid value:
    *        0 -- ECQSCLK set to 0
    *        1 -- ECQSCLK set to 1
    */
    uint8_t ecSclkCfg;
} plat_config_fs_t;


/** \brief typedef of platform configuration stored in raw flash --old v0*/
__PACKED_STRUCT _plat_config_raw_flash_v0
{
    /** action to perform when assert or hard fault occurs
     *  valid value:
     *        0 -- dump full exception info to flash and EPAT tool then trapped in endless loop(while(1))
     *        1 -- print necessary exception info then reset
     *        2 -- dump full exception info to flash then reset
     *        3 -- dump full exception info to flash and EPAT tool then reset
     *        4 -- reset directly
     *       10 -- enable uart help dump and dump full exception info to flash and EPAT tool then trapped in endless loop(while(1))
     *       13 -- enable uart help dump and dump full exception info to flash and EPAT tool, and then reset
     */
    uint8_t faultAction;

    /** port select for dump info output when exception occurs
     *  valid value:
     *        0,1,2,3,(4) -- specify which port
     *        0xff -- disable this function
     */
    uint8_t uartDumpPort;

    /** WDT start/stop control
     *  valid value:
     *        0 -- stop WDT
     *        1 -- start WDT
     */
    uint8_t startWDT;

    /** unilog on/off flag
     *  valid value:
     *        0 -- unilog is disabled
     *        1 -- only sw log is enabled
     *        2 -- All log is enabled
     */
    uint8_t logControl;

    /** uart baudrate for unilog output */
    uint32_t uartBaudRate;

    /** debug trace log level setting, refer to 'DebugTraceLevelType_e' */
    uint32_t logLevel;

    /** unilog output port select
     *  valid value:
     *        0 -- USB
     *        1 -- UART
     *        2 -- MIX(for future use UART/USB dynamic select)
     **/
    PlatCfgUlgPort_e logPortSel;

    /** RNDIS enum control
     *  valid value:
     *        0 -- enable USB init and enum RNDIS
     *        1 -- enable USB init but not enum RNDIS
     *        2 -- disable USB init
     */
    uint8_t usbCtrl;

    /** usb software trace control
     *  valid value:
     *        0 -- disable all usb software trace
     *        1 -- enable all usb software trace
     *        others -- misc usb software trace
     */
    uint8_t usbSwTrace;



    /** USB sleep mask
     * valid value:
     *       0 -- usb should vote to enter sleep
     *       1 -- do not consider usb vote before sleep
     */
    uint8_t usbSlpMask;

    /** USB sleep thd
     * valid value:
     *       set the minimal time to sleep, when usbSlpMask=1
     */
    uint16_t usbSlpThd;

    /** pwrkey mode
     * valid value:
     *       1    power key mode
     *       0    normal key mode
     */
    uint8_t pwrKeyMode;
};

// fota urc port type
typedef enum
{
    PLAT_CFG_FOTA_URC_PORT_USB=0,
    PLAT_CFG_FOTA_URC_PORT_UART,
    PLAT_CFG_FOTA_URC_PORT_MAXTYPE
} PlatCfgFotaUrcPortType_e;

#define PLAT_CFG_FOTA_URC_USB_PORT_IDX_MIN    0
#define PLAT_CFG_FOTA_URC_USB_PORT_IDX_MAX    2

#define PLAT_CFG_FOTA_URC_UART_PORT_IDX_MIN   0
#define PLAT_CFG_FOTA_URC_UART_PORT_IDX_MAX   1


#define PLAT_CFG_RAW_FLASH_RSVD_SIZE    21

/** \brief typedef of platform configuration stored in raw flash */
__PACKED_STRUCT _plat_config_raw_flash
{
    /** action to perform when assert or hard fault occurs
     *  valid value:
     *        0 -- dump full exception info to flash and EPAT tool then trapped in endless loop(while(1))
     *        1 -- print necessary exception info then reset
     *        2 -- dump full exception info to flash then reset
     *        3 -- dump full exception info to flash and EPAT tool then reset
     *        4 -- reset directly
     *       10 -- enable uart help dump and dump full exception info to flash and EPAT tool then trapped in endless loop(while(1))
     *       13 -- enable uart help dump and dump full exception info to flash and EPAT tool, and then reset
     */
    uint8_t faultAction;

    /** port select for dump info output when exception occurs
     *  valid value:
     *        0,1,2,3,(4) -- specify which port
     *        0xff -- disable this function
     */
    uint8_t uartDumpPort;


    /** WDT start/stop control
     *  valid value:
     *        0 -- stop WDT
     *        1 -- start WDT
     */
    uint8_t startWDT;

    /** unilog on/off flag
     *  valid value:
     *        0 -- unilog is disabled
     *        1 -- only sw log is enabled
     *        2 -- All log is enabled
     */
    uint8_t logControl;

    /** uart baudrate for unilog output */
    uint32_t uartBaudRate;

    /** debug trace log level setting, refer to 'DebugTraceLevelType_e' */
    uint32_t logLevel;

    /** unilog output port select
     *  valid value:
     *        0 -- USB
     *        1 -- UART
     *        2 -- MIX(for future use UART/USB dynamic select)
     **/
    PlatCfgUlgPort_e logPortSel;

    /** RNDIS enum control
     *  valid value:
     *        0 -- enable USB init and enum RNDIS
     *        1 -- enable USB init but not enum RNDIS
     *        2 -- disable USB init
     */
    uint8_t usbCtrl;

    /** usb software trace control
     *  valid value:
     *        0 -- disable all usb software trace
     *        1 -- enable all usb software trace
     *        others -- misc usb software trace
     */
    uint8_t usbSwTrace;



    /** USB sleep mask
     * valid value:
     *       0 -- usb should vote to enter sleep
     *       1 -- do not consider usb vote before sleep
     */
    uint8_t usbSlpMask;

    /** USB sleep thd
     * valid value:
     *       set the minimal time to sleep, when usbSlpMask=1
     */
    uint16_t usbSlpThd;

    /** pwrkey mode
     * valid value:
     *       1    power key mode
     *       0    normal key mode
     */
    uint8_t pwrKeyMode;

    /** USB VBUS MODE Enable,Disable Flag
     * valid value:
     *       0 -- usb vbus mode disable
     *       1 -- usb vbus mode enable
     */
    uint8_t usbVBUSModeEn;

    /** USB VBUS MODE Wakup Pad Index
     * valid value:
     * 0,1,2,3,4,5 PAD IDX FOR USB VBUS WKUP PAD
     */
    uint8_t usbVBUSWkupPad;

    /** USB NET IF SEL
     * valid value:
     * 0----RNDIS,default
     * 1----ECM
     */
    uint8_t usbNet;

    /** USB VCOM EN bitmap
     * valid value:
     * bit0---vcom0
     * bit1---vcom1
     * ----
     * ----
     */
    uint8_t usbVcomEnBitMap;

    /** AT/fotaURC baudrate, for AP & BL*/
    uint32_t atPortBaudRate;

    /** FOTA URC output port select
     *  valid value(Bit4-7):
     *        0 -- USB
     *        1 -- UART
     **
     *  valid value(Bit0-3):
     *        0-2 -- USB
     *        0-1 -- UART
     **/
    uint8_t  fotaUrcPortSel;

    /** pmuInCdrx
     * valid value:
     * 0----
     * 1----
     */
    uint8_t pmuInCdrx;

    /** slpLimitEn
     * valid value:
     * 0---- disable
     * 1---- enable
     */
    uint8_t slpLimitEn;

    /** slpLimitTime
     * valid value:
     * 0---0xFFFFFFFF
     */
    uint32_t slpLimitTime;
	
    /* 'PLAT_CFG_RAW_FLASH_RSVD_SIZE' bytes rsvd for future */
    uint8_t resv[PLAT_CFG_RAW_FLASH_RSVD_SIZE];
};

typedef struct _plat_config_raw_flash plat_config_raw_flash_t;//current
typedef struct _plat_config_raw_flash_v0 plat_config_raw_flash_v0_t;//old v0

/** \brief typedef of platform info layout stored in raw flash */
__PACKED_STRUCT _plat_info_layout
{
    config_file_header_t header;           /**< raw flash plat config header */
    plat_config_raw_flash_t config;        /**< raw flash plat config body */
    uint32_t fsAssertCount;                /**< count for monitoring FS assert, when it reaches specific number, FS region will be re-formated */
};
typedef struct _plat_info_layout plat_info_layout_t;

/** @brief List of platform configuration items used to set/get sepecific setting */
typedef enum _plat_config_id
{
    PLAT_CONFIG_ITEM_FAULT_ACTION = 0,       /**< faultAction item */
    PLAT_CONFIG_ITEM_UART_DUMP_PORT,         /**< uartDumpPort item */
    PLAT_CONFIG_ITEM_START_WDT,              /**< startWDT item */
    PLAT_CONFIG_ITEM_LOG_CONTROL,            /**< logControl item */
    PLAT_CONFIG_ITEM_LOG_BAUDRATE,           /**< uart baudrate for log output */
    PLAT_CONFIG_ITEM_LOG_LEVEL,              /**< logLevel item */
    PLAT_CONFIG_ITEM_ENABLE_PM,              /**< enablePM item */
    PLAT_CONFIG_ITEM_SLEEP_MODE,             /**< sleepMode item */
    PLAT_CONFIG_ITEM_WAIT_SLEEP,             /**< wait ms before sleep */
    PLAT_CONFIG_ITEM_AT_PORT_BAUDRATE,       /**< AT port baudrate */
    PLAT_CONFIG_ITEM_AT_PORT_FRAME_FORMAT,   /**< AT port frame format */
    PLAT_CONFIG_ITEM_ECSCLK_CFG,             /**< ECSCLK config */
    PLAT_CONFIG_ITEM_LOG_PORT_SEL,           /**< ULG output port select */
    PLAT_CONFIG_ITEM_USB_CTRL,               /**< USB control */
    PLAT_CONFIG_ITEM_USB_SW_TRACE_FLAG,      /**< USB control */
    PLAT_CONFIG_ITEM_USB_SLEEP_MASK,         /**< USB Sleep Vote Mask */
    PLAT_CONFIG_ITEM_USB_SLEEP_THD,          /**< USB Sleep Thread */
    PLAT_CONFIG_ITEM_PWRKEY_MODE,            /**< PWRKEY Mode */
    PLAT_CONFIG_ITEM_USB_VBUS_MODE_EN,       /**< USB VBUS MODE ENABLE, DISABLE*/
    PLAT_CONFIG_ITEM_USB_VBUS_WKUP_PAD,      /**< USB VBUS MODE WKUP PAD INDEX*/
    PLAT_CONFIG_ITEM_USB_NET,                /**< USB NET Select*/
    PLAT_CONFIG_ITEM_USB_VCOM_EN_BMP,        /**< USB VCOM Enabled Bitmap*/
    PLAT_CONFIG_ITEM_FOTA_URC_PORT_SEL,      /**< FOTA URC Port Select*/
    PLAT_CONFIG_ITEM_PMUINCDRX,              /**< PMUINCDRX Select*/
    PLAT_CONFIG_ITEM_SLP_LIMIT_EN,           /**< enable sleep time limit*/
    PLAT_CONFIG_ITEM_SLP_LIMIT_TIME,         /**< set maximum sleep time in mili second*/
    PLAT_CONFIG_ITEM_TOTAL_NUMBER            /**< total number of items */
} plat_config_id_t;


/*******************************************************************************
 * API
 ******************************************************************************/

#ifdef __cplusplus
    extern "C" {
#endif

/**
  \fn        void BSP_SavePlatConfigToFs(void)
  \brief     Save platform configuration into FS
  \return    void
 */
void BSP_SavePlatConfigToFs(void);

/**
  \fn        void BSP_LoadPlatConfigFromFs(void)
  \brief     Load platform configuration from FS
  \return    void
 */
void BSP_LoadPlatConfigFromFs(void);

/**
  \fn        plat_config_fs_t* BSP_GetFsPlatConfig(void)
  \brief     Get FS platform configuration variable pointer
  \return    pointer to internal platform configuration loaded from FS
 */
plat_config_fs_t* BSP_GetFsPlatConfig(void);

/**
  \fn        void BSP_SavePlatConfigToRawFlash(void)
  \brief     Save platform configuration into raw flash
  \return    void
 */
void BSP_SavePlatConfigToRawFlash(void);

/**
  \fn        void BSP_LoadPlatConfigFromRawFlash(void)
  \brief     Load platform configuration from raw flash
  \return    void
 */
void BSP_LoadPlatConfigFromRawFlash(void);

/**
  \fn        plat_config_raw_flash_t* BSP_GetRawFlashPlatConfig(void)
  \brief     Get raw flash platform configuration variable pointer
  \return    pointer to internal platform configuration loaded from raw flash
 */
plat_config_raw_flash_t* BSP_GetRawFlashPlatConfig(void);

/**
  \fn        uint32_t BSP_GetPlatConfigItemValue(plat_config_id_t id)
  \brief     Get value of specific platform configuration item
  \param[in] id    id of platform configuration item, \ref plat_config_id_t
  \return    value of current configuration item
 */
uint32_t BSP_GetPlatConfigItemValue(plat_config_id_t id);

/**
  \fn        void BSP_SetPlatConfigItemValue(plat_config_id_t id, uint32_t value)
  \brief     Set value of specific platform configuration item
  \param[in] id    id of platform configuration item, \ref plat_config_id_t
  \param[in] value value of configuration item to set
  \return    void
 */
void BSP_SetPlatConfigItemValue(plat_config_id_t id, uint32_t value);

/**
  \fn        uint32_t BSP_GetFSAssertCount(void)
  \brief     Fetch current 'fsAssertCount' value from PLAT_INFO region
  \return    current fsAssertCount value
 */
uint32_t BSP_GetFSAssertCount(void);

/**
  \fn        void BSP_SetFSAssertCount(uint32_t value);
  \brief     Update 'fsAssertCount' value
  \param[in] value  new value assigned to 'fsAssertCount'
  \return    void
  \note      Internal use only on FS assert occurs
 */
void BSP_SetFSAssertCount(uint32_t value);

/**
  \fn        void BSP_SetFsPorDefaultValue(void);
  \brief     when por happened some data may retore to it's default
  \return    void
 */
void BSP_SetFsPorDefaultValue(void);

#ifdef __cplusplus
}
#endif

#endif /* _PLAT_CONFIG_H */
