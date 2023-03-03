/****************************************************************************
 *
 * Copy right:   2020-, Copyrigths of AirM2M Ltd.
 * File name:    kpc_ec616.c
 * Description:  EC618 kpc driver source file
 * History:      Rev1.0   2021-07-23
 *
 ****************************************************************************/

#include "kpc.h"
#include "ic.h"
#include "clock.h"
#include "slpman.h"

//#define KPC_DEBUG

/** \brief Internal used data structure */
typedef struct
{
    uint8_t                            isInited;                      /**< flag indicating intialized or not */

    uint8_t                            scanState;                     /**< For key release detect */

    uint8_t                            enableAutoRepeat;              /**< autorepeat feature is enabled */

    uint8_t                            padding0;

    uint32_t                           keyEnableMask;                 /**< Bitmap of enabled keys */
    uint32_t                           keyState;                      /**< Bitmap of key state, 0-release, 1-press */

    struct
    {
        uint32_t                       repeatCount;                   /**< counter for autorepeat */
        uint8_t                        delay;                         /**< autorepeat event delay */
        uint8_t                        period;                        /**< autorepeat event period */
        uint16_t                       padding1;
    } autoRepeat;

    struct
    {
        uint32_t DEBCTL;                           /**< Debounce Control Register */
        uint32_t KPCTL;                            /**< Keypad Control Register */
        uint32_t DICTL;                            /**< Direct Input Control Register */
        uint32_t KPENCTL;                          /**< Keypad Enable Register */
        uint32_t DIENCTL;                          /**< Direct Input Enable Register */
    } configRegisters;

    kpc_callback_t                  eventCallback;                 /**< Callback function passed in by application */
} KpcDataBase_t;

static KpcDataBase_t gKpcDataBase = {0};


#ifdef PM_FEATURE_ENABLE
/**
  \fn        void KPC_enterLowPowerStatePrepare(void* pdata, slpManLpState state)
  \brief     Backup KPC configurations before sleep.
  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state
 */
void KPC_enterLowPowerStatePrepare(void* pdata, slpManLpState state)
{
    switch(state)
    {
        case SLPMAN_SLEEP1_STATE:

            if(gKpcDataBase.isInited == 1)
            {
                gKpcDataBase.configRegisters.DEBCTL = KPC->DEBCTL;
                gKpcDataBase.configRegisters.KPCTL = KPC->KPCTL;
                gKpcDataBase.configRegisters.DICTL = KPC->DICTL;
                gKpcDataBase.configRegisters.KPENCTL = KPC->KPENCTL;
                gKpcDataBase.configRegisters.DIENCTL = KPC->DIENCTL;
            }

            break;

        default:
            break;
    }

}

/**
 \fn        void KPC_exitLowPowerStateRestore(void* pdata, slpManLpState state)
 \brief     Restore KPC configurations after exit from sleep.
 \param[in] pdata pointer to user data, not used now
 \param[in] state low power state
 */
void KPC_exitLowPowerStateRestore(void* pdata, slpManLpState state)
{
    switch(state)
    {
        case SLPMAN_SLEEP1_STATE:

            if(gKpcDataBase.isInited == 1)
            {
                KPC->DEBCTL = gKpcDataBase.configRegisters.DEBCTL;
                KPC->KPCTL = gKpcDataBase.configRegisters.KPCTL;
                KPC->DICTL = gKpcDataBase.configRegisters.DICTL;
                KPC->KPENCTL = gKpcDataBase.configRegisters.KPENCTL;
                KPC->DIENCTL = gKpcDataBase.configRegisters.DIENCTL;
            }

            break;

        default:
            break;
    }

}
#endif


static __FORCEINLINE uint32_t KPC_findFirstSet(uint32_t value)
{
    return __CLZ(__RBIT(value));
}

/**
  construct key enable bitmap

    24              20 19              15 14              10 9                5 4                 0
   +------------------+------------------+------------------+------------------+------------------+
   |  row 4, col[4:0] |  row 3, col[4:0] |  row 2, col[4:0] |  row 1,col[4:0]  |  row 0, col[4:0] |
   +------------------+------------------+------------------+------------------+------------------+

 */
static void KPC_setKeyMask(uint32_t rowMask, uint32_t colMask, uint32_t* keyEnableMask, uint32_t* rowMsb, uint32_t* rowCounts)
{
    uint32_t keyMask = 0;
    uint32_t rowIndex = 0;
    uint32_t cnt = 0;

    // Max 5x5 matrix keypad
    rowMask &= 0x1f;
    colMask &= 0x1f;

    while(rowMask)
    {
        rowIndex = KPC_findFirstSet(rowMask);
        keyMask |= (colMask << (rowIndex * 5));
        rowMask &= (rowMask - 1);
        cnt++;
    }

    *keyEnableMask = keyMask;
    *rowMsb = rowIndex;
    *rowCounts = cnt;
}

static void KPC_eventReport(void)
{
    uint32_t lsb, keyScanResult, keyScanResultBackup, changed, report = 0;

    KpcReportEvent_t event;

    // Get current key scan result
    keyScanResult = KPC->KPSTAT & gKpcDataBase.keyEnableMask;

    keyScanResultBackup =  keyScanResult;

    // Find out changed key
    changed = keyScanResult ^ gKpcDataBase.keyState;

#ifdef KPC_DEBUG
    printf("report: [%x]-[%x]-[%x]\r\n", keyScanResult, gKpcDataBase.keyState, changed);
#endif

    // First to handle key release
    if(changed)
    {
        lsb = KPC_findFirstSet(changed);

        // Check key released during two consecutive rounds of scan
        if((keyScanResultBackup & ( 1 << lsb)) == 0)
        {
            event.row = lsb / 5;
            event.column = lsb % 5;
            event.value = KPC_REPORT_KEY_RELEASE;

            gKpcDataBase.autoRepeat.repeatCount = 0;

            if(gKpcDataBase.eventCallback)
            {
                gKpcDataBase.eventCallback(event);
            }

        }
    }

    // Check key press
    if(keyScanResult)
    {
        lsb = KPC_findFirstSet(keyScanResult);

        // repeat key?
        if((gKpcDataBase.keyState & (1 << lsb)) && (gKpcDataBase.enableAutoRepeat == 1))
        {
            gKpcDataBase.autoRepeat.repeatCount++;

            if((gKpcDataBase.autoRepeat.repeatCount >= gKpcDataBase.autoRepeat.delay) && ((gKpcDataBase.autoRepeat.repeatCount - gKpcDataBase.autoRepeat.delay) % gKpcDataBase.autoRepeat.period == 0))
            {
                event.row = lsb / 5;
                event.column = lsb % 5;
                event.value = KPC_REPORT_KEY_REPEAT;
                report = 1;
            }
        }
        else
        {
            event.row = lsb / 5;
            event.column = lsb % 5;
            event.value = KPC_REPORT_KEY_PRESS;
            gKpcDataBase.autoRepeat.repeatCount = 0;
            report = 1;
        }

        if(gKpcDataBase.eventCallback && report)
        {
            gKpcDataBase.eventCallback(event);
        }
    }

    // save current result
    gKpcDataBase.keyState = keyScanResultBackup;
}

static void KPC_keyPadModeIsr(void)
{
    KPC_eventReport();

    // If any key is pressed, enable direct input interrupt which works as a periodic timer for key release detect purpose
    KPC->DIENCTL = KPC_DIENCTL_ENABLE_Msk;
    KPC->KPENCTL = KPC_KPENCTL_ENABLE_Msk;

    gKpcDataBase.scanState = 1;  // Indicating at least one key is pressed

}

// Enter at the end of one round of scan period
static void KPC_directInputModeIsr(void)
{
    KPC->CLRCTL = KPC_CLRCTL_INPUT_INT_CLR_Msk;

    // Check if all keys are released
    if((KPC->KPSTAT == 0) && (gKpcDataBase.scanState == 2))
    {
        KPC->DIENCTL = 0;
        gKpcDataBase.scanState = 0;

#ifdef KPC_DEBUG
        printf("release,%x\r\n", KPC->DISTAT);
#endif
        KPC_eventReport();
    }

    gKpcDataBase.scanState = 2;

}

void KPC_getDefaultConfig(KpcConfig_t *config)
{
    ASSERT(config);

    config->debounceConfig.debounceClkDivRatio = KPC_DEBOUNCE_CLK_DIV_RATIO_16384;
    config->debounceConfig.debounceWidth       = KPC_DEBOUNCE_WIDTH_7_CYCLES;

    config->validRowMask                       = KPC_ROW_ALL;
    config->validColumnMask                    = KPC_COLUMN_ALL;

    config->scanPolarity                       = KPC_SCAN_POLARITY_0;
    config->scanDivRatio                       = KPC_SCAN_DIV_RATIO_16;

    config->autoRepeat.enable                  = 1;
    config->autoRepeat.delay                   = 10;
    config->autoRepeat.period                  = 1;
}

int32_t KPC_init(const KpcConfig_t *config, kpc_callback_t callback)
{
    ASSERT(config);

    uint32_t mask, validRowCounts, msbOfValidRows;

    mask = SaveAndSetIRQMask();

    // Initialization
    if(gKpcDataBase.isInited == 0)
    {
        CLOCK_setClockSrc(FCLK_KPC, FCLK_KPC_SEL_26M);

        CLOCK_clockEnable(FCLK_KPC);
        CLOCK_clockEnable(PCLK_KPC);

        GPR_swResetModule(RESET_VECTOR_PTR(KPC_RESET_VECTOR));

        // enable KPC IRQ
        XIC_SetVector(PXIC0_KPC_DIRECT_IRQn, KPC_directInputModeIsr);
        XIC_EnableIRQ(PXIC0_KPC_DIRECT_IRQn);

        XIC_SetVector(PXIC0_KPC_KEYPAD_IRQn, KPC_keyPadModeIsr);
        XIC_EnableIRQ(PXIC0_KPC_KEYPAD_IRQn);

    }
    else
    {
        RestoreIRQMask(mask);
        return ARM_DRIVER_OK;
    }

    RestoreIRQMask(mask);

    KPC_setKeyMask(config->validRowMask, config->validColumnMask, &gKpcDataBase.keyEnableMask, &msbOfValidRows, &validRowCounts);

    if(validRowCounts < 2)
    {
        return ARM_DRIVER_ERROR_PARAMETER;
    }

    KPC->DEBCTL = EIGEN_VAL2FLD(KPC_DEBCTL_DEBOUNCER_DEPTH, config->debounceConfig.debounceWidth) | \
                  EIGEN_VAL2FLD(KPC_DEBCTL_DEBOUNCER_TO0_THRD, config->debounceConfig.debounceWidth) | \
                  EIGEN_VAL2FLD(KPC_DEBCTL_DEBOUNCER_TO1_THRD, config->debounceConfig.debounceWidth) | \
                  EIGEN_VAL2FLD(KPC_DEBCTL_DEBOUNCER_TO_MCLK_RATIO, config->debounceConfig.debounceClkDivRatio);

    KPC->KPCTL = EIGEN_VAL2FLD(KPC_KPCTL_POLARITY, config->scanPolarity) | \
                 EIGEN_VAL2FLD(KPC_KPCTL_ROW_VLD_BITMAP, config->validRowMask & 0x1FU) | \
                 EIGEN_VAL2FLD(KPC_KPCTL_COL_VLD_BITMAP, config->validColumnMask & 0x1FU) | \
                 EIGEN_VAL2FLD(KPC_KPCTL_SCAN_TO_DEBOUNCE_RATIO, config->scanDivRatio);

    // Enable rising/falling edge interrupt of ending row for key release detect
    if(config->scanPolarity == KPC_SCAN_POLARITY_0)
    {
        KPC->DICTL = EIGEN_VAL2FLD(KPC_DICTL_INT_EN, 1 << (msbOfValidRows + 5)) | EIGEN_VAL2FLD(KPC_DICTL_INT_MODE, 0x1);
    }
    else
    {
        KPC->DICTL = EIGEN_VAL2FLD(KPC_DICTL_INT_EN, 1 << (msbOfValidRows + 5)) | EIGEN_VAL2FLD(KPC_DICTL_INT_MODE, 0x2);
    }

    KPC->AUTOCG = KPC_AUTOCG_ENABLE_Msk;

    gKpcDataBase.eventCallback = callback;

    gKpcDataBase.enableAutoRepeat  = config->autoRepeat.enable;
    gKpcDataBase.autoRepeat.delay  = config->autoRepeat.delay;
    gKpcDataBase.autoRepeat.period = config->autoRepeat.period;

#ifdef PM_FEATURE_ENABLE
    slpManRegisterPredefinedBackupCb(SLP_CALLBACK_KPC_MODULE, KPC_enterLowPowerStatePrepare, NULL);
    slpManRegisterPredefinedRestoreCb(SLP_CALLBACK_KPC_MODULE, KPC_exitLowPowerStateRestore, NULL);
#endif

    gKpcDataBase.isInited = 1;

    return ARM_DRIVER_OK;
}

void KPC_deInit(void)
{
    uint32_t mask = SaveAndSetIRQMask();

    if(gKpcDataBase.isInited == 1)
    {
        KPC_stopScan();

        // disable clock
        CLOCK_clockDisable(FCLK_KPC);
        CLOCK_clockDisable(PCLK_KPC);

        XIC_DisableIRQ(PXIC0_KPC_DIRECT_IRQn);
        XIC_DisableIRQ(PXIC0_KPC_KEYPAD_IRQn);
        XIC_ClearPendingIRQ(PXIC0_KPC_DIRECT_IRQn);
        XIC_ClearPendingIRQ(PXIC0_KPC_KEYPAD_IRQn);

#ifdef PM_FEATURE_ENABLE
        slpManUnregisterPredefinedBackupCb(SLP_CALLBACK_KPC_MODULE);
        slpManUnregisterPredefinedRestoreCb(SLP_CALLBACK_KPC_MODULE);
#endif

        gKpcDataBase.isInited = 0;
    }

    RestoreIRQMask(mask);
}

void KPC_startScan(void)
{
    uint32_t mask = SaveAndSetIRQMask();

    if(gKpcDataBase.isInited == 1)
    {
        KPC->KPENCTL = KPC_KPENCTL_ENABLE_Msk;
    }

    RestoreIRQMask(mask);
}

void KPC_stopScan(void)
{
    uint32_t mask = SaveAndSetIRQMask();

    if(gKpcDataBase.isInited == 1)
    {
        KPC->DIENCTL = 0;
        KPC->CLRCTL = KPC_CLRCTL_INPUT_INT_CLR_Msk;
        KPC->DICTL = 0;
    }

    RestoreIRQMask(mask);

}


