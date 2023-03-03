/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    wdt.c
 * Description:  EC618 wdt driver source file
 * History:      Rev1.0   2018-07-18
 *
 ****************************************************************************/

#include "wdt.h"
#include "clock.h"
#include "slpman.h"

#ifdef PM_FEATURE_ENABLE

/** \brief Internal used data structure */
typedef struct _wdt_database
{
    bool                   isInited;            /**< whether wdt has been initialized */
    bool                   wdtStartStatus;      /**< wdt enable status, used for low power restore */
    WdtConfig_t           wdtConfig;           /**< wdt configuration, used for low power restore */
} WdtDatabase_t;

static WdtDatabase_t gWdtDataBase = {0};

/**
  \fn        static void WDT_enterLowPowerStatePrepare(void* pdata, slpManLpState state)
  \brief     Perform necessary preparations before sleep
  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state
 */
static void WDT_enterLowPowerStatePrepare(void* pdata, slpManLpState state)
{
    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            if(gWdtDataBase.isInited == true)
            {
                gWdtDataBase.wdtStartStatus = WDT_getStartStatus();
                //disable clock
                CLOCK_clockDisable(PCLK_WDG);
                CLOCK_clockDisable(FCLK_WDG);
            }

            break;
        default:
            break;
    }

}

/**
  \fn        static void WDT_exitLowPowerStateRestore(void* pdata, slpManLpState state)
  \brief     Restore after exit from sleep
  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state

 */
static void WDT_exitLowPowerStateRestore(void* pdata, slpManLpState state)
{
    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            if(gWdtDataBase.isInited == true)
            {
                //enable clock
                CLOCK_clockEnable(PCLK_WDG);
                CLOCK_clockEnable(FCLK_WDG);

                WDT_unlock();
                WDT->CTRL = (WDT->CTRL &~ WDT_CTRL_MODE_Msk) | EIGEN_VAL2FLD(WDT_CTRL_MODE, gWdtDataBase.wdtConfig.mode);
                WDT_unlock();
                WDT->TOVR = gWdtDataBase.wdtConfig.timeoutValue;

                if(gWdtDataBase.wdtStartStatus)
                    WDT_start();
            }

            break;

        default:
            break;
    }
}
#endif


void WDT_unlock(void)
{
    WDT->LOCK = 0xABABU;
}

void WDT_kick(void)
{
    uint32_t mask = SaveAndSetIRQMask();

    WDT_unlock();
    WDT->CCR = WDT_CCR_CNT_CLR_Msk;

    RestoreIRQMask(mask);
}

void WDT_getDefaultConfig(WdtConfig_t *config)
{
    ASSERT(config);

    config->mode = WDT_INTERRUPT_ONLY_MODE;
    config->timeoutValue = 0xFFFFU;
}

void WDT_init(const WdtConfig_t *config)
{
    ASSERT(config);

#ifdef PM_FEATURE_ENABLE

    if(gWdtDataBase.isInited == true)
    {
        return;
    }

    slpManRegisterPredefinedBackupCb(SLP_CALLBACK_WDT_MODULE, WDT_enterLowPowerStatePrepare, NULL);
    slpManRegisterPredefinedRestoreCb(SLP_CALLBACK_WDT_MODULE, WDT_exitLowPowerStateRestore, NULL);

    gWdtDataBase.isInited = true;
    gWdtDataBase.wdtConfig = *config;

#endif

    //enable clock
    CLOCK_clockEnable(PCLK_WDG);
    CLOCK_clockEnable(FCLK_WDG);


    WDT_unlock();
    WDT->CTRL = (WDT->CTRL &~ WDT_CTRL_MODE_Msk) | EIGEN_VAL2FLD(WDT_CTRL_MODE, config->mode);
    WDT_unlock();
    WDT->TOVR = config->timeoutValue;
}

void WDT_deInit(void)
{
#ifdef PM_FEATURE_ENABLE

    if(gWdtDataBase.isInited == false)
    {
        return;
    }

    slpManUnregisterPredefinedBackupCb(SLP_CALLBACK_WDT_MODULE);
    slpManUnregisterPredefinedRestoreCb(SLP_CALLBACK_WDT_MODULE);

    gWdtDataBase.isInited = false;
#endif

    //disable clock
    CLOCK_clockDisable(PCLK_WDG);
    CLOCK_clockDisable(FCLK_WDG);

}

void WDT_start(void)
{
    uint32_t mask = SaveAndSetIRQMask();

    WDT_unlock();
    WDT->CTRL |= WDT_CTRL_ENABLE_Msk;

    RestoreIRQMask(mask);
}

void WDT_stop(void)
{
    uint32_t mask = SaveAndSetIRQMask();

    WDT_unlock();
    WDT->CTRL &= ~WDT_CTRL_ENABLE_Msk;

    RestoreIRQMask(mask);

}

uint32_t WDT_getInterruptFlags(void)
{
    return WDT->STAT & WDT_STAT_ISTAT_Msk;
}

void WDTclearInterruptFlags(uint32_t mask)
{
    uint32_t msk = SaveAndSetIRQMask();

    WDT_unlock();
    WDT->ICR = WDT_ICR_ICLR_Msk;

    RestoreIRQMask(msk);
}

WdtMode_e WDT_getMode(void)
{
    return (WdtMode_e)EIGEN_FLD2VAL(WDT_CTRL_MODE, WDT->CTRL);
}

bool WDT_getStartStatus(void)
{
    return (bool)EIGEN_FLD2VAL(WDT_CTRL_ENABLE, WDT->CTRL);
}

