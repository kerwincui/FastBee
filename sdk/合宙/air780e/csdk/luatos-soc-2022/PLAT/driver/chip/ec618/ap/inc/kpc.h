/****************************************************************************
 *
 * Copy right:   2020-, Copyrigths of AirM2M Ltd.
 * File name:    kpc_ec618.h
 * Description:  EC618 kpc driver header file
 * History:      Rev1.0   2021-07-23
 *
 ****************************************************************************/

#ifndef _KPC_EC618_H
#define _KPC_EC618_H

#include "ec618.h"
#include "Driver_Common.h"

/**
  \addtogroup kpc_interface_gr
  \{
 */

/*******************************************************************************
 * Definitions
 ******************************************************************************/

/** \brief List of debounce clock divider ratio */
typedef enum
{
    KPC_DEBOUNCE_CLK_DIV_RATIO_2          = 1U,  /**< KPC debounce clock divider ratio select as 2 */
    KPC_DEBOUNCE_CLK_DIV_RATIO_4          = 2U,  /**< KPC debounce clock divider ratio select as 4 */
    KPC_DEBOUNCE_CLK_DIV_RATIO_8          = 3U,  /**< KPC debounce clock divider ratio select as 8 */
    KPC_DEBOUNCE_CLK_DIV_RATIO_16         = 4U,  /**< KPC debounce clock divider ratio select as 16 */
    KPC_DEBOUNCE_CLK_DIV_RATIO_32         = 5U,  /**< KPC debounce clock divider ratio select as 32 */
    KPC_DEBOUNCE_CLK_DIV_RATIO_64         = 6U,  /**< KPC debounce clock divider ratio select as 64 */
    KPC_DEBOUNCE_CLK_DIV_RATIO_128        = 7U,  /**< KPC debounce clock divider ratio select as 128 */
    KPC_DEBOUNCE_CLK_DIV_RATIO_256        = 8U,  /**< KPC debounce clock divider ratio select as 256 */
    KPC_DEBOUNCE_CLK_DIV_RATIO_512        = 9U,  /**< KPC debounce clock divider ratio select as 512 */
    KPC_DEBOUNCE_CLK_DIV_RATIO_1024       = 10U, /**< KPC debounce clock divider ratio select as 1024 */
    KPC_DEBOUNCE_CLK_DIV_RATIO_2048       = 11U, /**< KPC debounce clock divider ratio select as 2048 */
    KPC_DEBOUNCE_CLK_DIV_RATIO_4096       = 12U, /**< KPC debounce clock divider ratio select as 4096 */
    KPC_DEBOUNCE_CLK_DIV_RATIO_8192       = 13U, /**< KPC debounce clock divider ratio select as 8192 */
    KPC_DEBOUNCE_CLK_DIV_RATIO_16384      = 14U, /**< KPC debounce clock divider ratio select as 16384 */
    KPC_DEBOUNCE_CLK_DIV_RATIO_32768      = 15U, /**< KPC debounce clock divider ratio select as 32768 */
} KpcDebounceClkDivRatio_t;

/** \brief List of debounce width */
typedef enum
{
    KPC_DEBOUNCE_WIDTH_5_CYCLES           = 5U,   /**< KPC debounce width is 5 Cycles of debounce clock */
    KPC_DEBOUNCE_WIDTH_6_CYCLES           = 6U,   /**< KPC debounce width is 6 Cycles of debounce clock */
    KPC_DEBOUNCE_WIDTH_7_CYCLES           = 7U,   /**< KPC debounce width is 7 Cycles of debounce clock */
    KPC_DEBOUNCE_WIDTH_8_CYCLES           = 8U,   /**< KPC debounce width is 8 Cycles of debounce clock */
    KPC_DEBOUNCE_WIDTH_9_CYCLES           = 9U,   /**< KPC debounce width is 9 Cycles of debounce clock */
    KPC_DEBOUNCE_WIDTH_10_CYCLES          = 10U,  /**< KPC debounce width is 10 Cycles of debounce clock */
    KPC_DEBOUNCE_WIDTH_11_CYCLES          = 11U,  /**< KPC debounce width is 11 Cycles of debounce clock */
    KPC_DEBOUNCE_WIDTH_12_CYCLES          = 12U,  /**< KPC debounce width is 12 Cycles of debounce clock */
    KPC_DEBOUNCE_WIDTH_13_CYCLES          = 13U,  /**< KPC debounce width is 13 Cycles of debounce clock */
    KPC_DEBOUNCE_WIDTH_14_CYCLES          = 14U,  /**< KPC debounce width is 14 Cycles of debounce clock */
    KPC_DEBOUNCE_WIDTH_15_CYCLES          = 15U,  /**< KPC debounce width is 15 Cycles of debounce clock */
} KpcDebounceWidth_t;

/** \brief List of key scan polarity */
typedef enum
{
    KPC_SCAN_POLARITY_0                   = 0U,   /**< KPC outputs low level scan waveform for active row while other valid rows is high */
    KPC_SCAN_POLARITY_1                   = 1U,   /**< KPC outputs high level scan waveform for active row while other valid rows is low */
} KpcScanPolarity_t;

/** \brief List of key scan divider ratio */
typedef enum
{
    KPC_SCAN_DIV_RATIO_2                  = 1U,   /**< KPC scan frequence divider ratio set as 2 */
    KPC_SCAN_DIV_RATIO_4                  = 2U,   /**< KPC scan frequence divider ratio set as 4 */
    KPC_SCAN_DIV_RATIO_8                  = 3U,   /**< KPC scan frequence divider ratio set as 8 */
    KPC_SCAN_DIV_RATIO_16                 = 4U,   /**< KPC scan frequence divider ratio set as 16 */
    KPC_SCAN_DIV_RATIO_32                 = 5U,   /**< KPC scan frequence divider ratio set as 32 */
    KPC_SCAN_DIV_RATIO_64                 = 6U,   /**< KPC scan frequence divider ratio set as 64 */
    KPC_SCAN_DIV_RATIO_128                = 7U,   /**< KPC scan frequence divider ratio set as 128 */
} KpcScanDivRatio_t;

/** \brief List of debounce width */
typedef enum
{
    KPC_ROW_0                             = 1U,   /**< KPC row0 enable mask */
    KPC_ROW_1                             = 2U,   /**< KPC row1 enable mask */
    KPC_ROW_2                             = 4U,   /**< KPC row2 enable mask */
    KPC_ROW_3                             = 8U,   /**< KPC row3 enable mask */
    KPC_ROW_4                             = 16U,  /**< KPC row4 enable mask */
    KPC_ROW_ALL                           = 0x1FU /**< KPC all rows enable mask */
} KpcRow_t;

/** \brief List of debounce width */
typedef enum
{
    KPC_COLUMN_0                          = 1U,   /**< KPC column0 enable mask */
    KPC_COLUMN_1                          = 2U,   /**< KPC column1 enable mask */
    KPC_COLUMN_2                          = 4U,   /**< KPC column2 enable mask */
    KPC_COLUMN_3                          = 8U,   /**< KPC column3 enable mask */
    KPC_COLUMN_4                          = 16U,  /**< KPC column4 enable mask */
    KPC_COLUMN_ALL                        = 0x1FU /**< KPC all columns enable mask */
} KpcColumn_t;

/** \brief KPC debounce configuration, decounce exits when consecutive debounceWidth scans give the same result */
typedef struct
{
    KpcDebounceClkDivRatio_t    debounceClkDivRatio;        /**< debounce clock divider ratio */
    KpcDebounceWidth_t          debounceWidth;              /**< debounce width */
} KpcDebounceConfig_t;

/** \brief KPC auto repeat configuration */
typedef struct
{
    uint8_t enable;                       /**< enable auto repeat or not */
    uint8_t delay;                        /**< auto repeat delay cycles of scan period, if scan period is 50ms and this value is set as 10,
                                               then autorepeat event will start to be reported 500ms later after key press is detected and key press keeps hold */

    uint8_t period;                       /**< auto repeat report interval of scan period, if scan period is 50ms and this value is set as 2,
                                               then autorepeat event will be reported in interval of 100ms until key is released */
} KpcAutoRepeatConfig_t;

/** \brief KPC configuration structure */
typedef struct
{
    uint8_t                       validRowMask;                   /**< Bitmap of valid rows */
    uint8_t                       validColumnMask;                /**< Bitmap of valid columns */
    KpcDebounceConfig_t           debounceConfig;                 /**< KPC debounce configuration */
    KpcAutoRepeatConfig_t         autoRepeat;                     /**< KPC auto repeat configuration */
    KpcScanPolarity_t             scanPolarity;                   /**< KPC scan polarity */
    KpcScanDivRatio_t             scanDivRatio;                   /**< KPC scan divider ratio */
} KpcConfig_t;

/** \brief List of kpc report key value */
typedef enum
{
    KPC_REPORT_KEY_RELEASE      = 0U,                      /**< Key is released */
    KPC_REPORT_KEY_PRESS        = 1U,                      /**< Key is pressed  */
    KPC_REPORT_KEY_REPEAT       = 2U,                      /**< Key holds pressed */
} KpcReportValue_t;

typedef struct
{
    uint8_t    value  : 2;                                 /**< Key value */
    uint8_t    column : 3;                                 /**< Key column */
    uint8_t    row    : 3;                                 /**< Key row */
} KpcReportEvent_t;

/**
  \brief Defines callback function prototype.
         Callback function will be called in KPC interrupt service routine
  \param report key event value
 */

typedef void (*kpc_callback_t)(KpcReportEvent_t event);

/*******************************************************************************
 * API
 ******************************************************************************/

#if defined(__cplusplus)
extern "C" {
#endif

/** \name KPC Configuration */
/** \{ */

/**
  \fn        void KPC_getDefaultConfig(KpcConfig_t *config)
  \brief     Gets the KPC default configuartion.
             This function sets the configuration structure to default values as below:
  \code
             config->debounceConfig.debounceClkDivRatio = KPC_DEBOUNCE_CLK_DIV_RATIO_16384;
             config->debounceConfig.debounceWidth       = KPC_DEBOUNCE_WIDTH_7_CYCLES;

             config->validRowMask                       = KPC_ROW_ALL;
             config->validColumnMask                    = KPC_COLUMN_ALL;

             config->scanPolarity                       = KPC_SCAN_POLARITY_0;
             config->scanDivRatio                       = KPC_SCAN_DIV_RATIO_16;

             config->autoRepeat.enable                  = 1;
             config->autoRepeat.delay                   = 10;
             config->autoRepeat.period                  = 1;

  \endcode

  \details   debouncer and scan setting explaination:
             KPC input clock is 26M, if debouncer divider is set as KPC_DEBOUNCE_CLK_DIV_RATIO_16384, then one cycle is 16384/26M = 630us,
             debouncer depth set as 7, means we can filter out 630*7us(4.4ms) jitter

             scan clock is sourced from debouncer clock, which means if scan frequency divider ratio is set as KPC_SCAN_DIV_RATIO_16 and
             when 5 rows are enabled, the scan frequency is 26M/16384/16/5 = 20HZ, each row scan signal width will be 1/20/5 = 10ms

  \param[in] config      Pointer to KPC configuration structure
 */
void KPC_getDefaultConfig(KpcConfig_t *config);

/**
  \fn        void KPC_init(const KpcConfig_t *config, kpc_callback_t callback)
  \brief     Initialize KPC
  \param[in] config      Pointer to KPC configuration
  \param[in] callback    Function to be called when KPC interrupt occurs
  \return    ARM_DRIVER_OK if the setting is successful
             ARM_DRIVER_ERROR_PARAMETER on parameter check failure
 */
int32_t KPC_init(const KpcConfig_t *config, kpc_callback_t callback);

/**
  \fn        void KPC_deInit(void)
  \brief     Deinitialize KPC
 */
void KPC_deInit(void);

/**
  \fn        void KPC_startScan(void)
  \brief     Starts KPC scan
 */
void KPC_startScan(void);

/**
  \fn        void KPC_stopScan(void)
  \brief     Stops KPC scan
 */
void KPC_stopScan(void);


/** \} */

/** \} */

#ifdef __cplusplus
}
#endif

#endif /* _KPC_EC618_H */
