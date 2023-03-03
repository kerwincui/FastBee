 /****************************************************************************
  *
  * Copy right:   2017-, Copyrigths of AirM2M Ltd.
  * File name:    pad.c
  * Description:  EC618 pad driver source file
  * History:      Rev1.0   2018-11-14
  *
  ****************************************************************************/

#include "pad.h"
#include "clock.h"
#include "slpman.h"

#ifdef PM_FEATURE_ENABLE

static uint32_t gPadBackupRegs[PAD_ADDR_MAX_NUM] = {0};

/**
  \fn        void PAD_enterLowPowerStatePrepare(void* pdata, slpManLpState state)
  \brief     Backup pad configurations before sleep.
  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state
 */
void PAD_enterLowPowerStatePrepare(void* pdata, slpManLpState state)
{
    uint32_t i;

    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            GPR_clockEnable(PCLK_PAD);

            for(i = 0; i < PAD_ADDR_MAX_NUM; i++)
            {
                gPadBackupRegs[i] = PAD->PCR[i];
            }

            GPR_clockDisable(PCLK_PAD);

            break;
        default:
            break;
    }

}

/**
 \fn        void PAD_exitLowPowerStateRestore(void* pdata, slpManLpState state)
 \brief     Restore PAD configurations after exit from sleep.
 \param[in] pdata pointer to user data, not used now
 \param[in] state low power state
 */
void PAD_exitLowPowerStateRestore(void* pdata, slpManLpState state)
{
    uint32_t i;

    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            GPR_clockEnable(PCLK_PAD);

            for(i = 0; i < PAD_ADDR_MAX_NUM; i++)
            {
                PAD->PCR[i] = gPadBackupRegs[i];
            }

            GPR_clockDisable(PCLK_PAD);

            break;

        default:
            break;
    }

}
#endif

void PAD_driverInit(void)
{
#ifdef PM_FEATURE_ENABLE
    slpManRegisterPredefinedBackupCb(SLP_CALLBACK_PAD_MODULE, PAD_enterLowPowerStatePrepare, NULL);
    slpManRegisterPredefinedRestoreCb(SLP_CALLBACK_PAD_MODULE, PAD_exitLowPowerStateRestore, NULL);
#endif
}

void PAD_driverDeInit(void)
{
#ifdef PM_FEATURE_ENABLE
    slpManUnregisterPredefinedBackupCb(SLP_CALLBACK_PAD_MODULE);
    slpManUnregisterPredefinedRestoreCb(SLP_CALLBACK_PAD_MODULE);
#endif
}


void PAD_getDefaultConfig(PadConfig_t *config)
{
    ASSERT(config);

    config->mux = PAD_MUX_ALT0;
    config->inputBufferEnable = PAD_INPUT_BUFFER_DISABLE;
    config->pullSelect = PAD_PULL_AUTO;
    config->pullUpEnable = PAD_PULL_UP_DISABLE;
    config->pullDownEnable = PAD_PULL_DOWN_DISABLE;
}

void PAD_setPinConfig(uint32_t paddr, const PadConfig_t *config)
{
    ASSERT(config);
    ASSERT(paddr < PAD_ADDR_MAX_NUM);

    CLOCK_clockEnable(PCLK_PAD);
    PAD->PCR[paddr] = *((const uint32_t *)config);
    CLOCK_clockDisable(PCLK_PAD);
}

void PAD_setPinMux(uint32_t paddr, PadMux_e mux)
{
    ASSERT(paddr < PAD_ADDR_MAX_NUM);

    CLOCK_clockEnable(PCLK_PAD);
    PAD->PCR[paddr] = (PAD->PCR[paddr] & ~PAD_PCR_MUX_Msk) | EIGEN_VAL2FLD(PAD_PCR_MUX, mux);
    CLOCK_clockDisable(PCLK_PAD);

}

void PAD_enablePinInputBuffer(uint32_t paddr, bool enable)
{
    ASSERT(paddr < PAD_ADDR_MAX_NUM);

    CLOCK_clockEnable(PCLK_PAD);

    if (enable == true)
    {
        PAD->PCR[paddr] |= PAD_PCR_INPUT_BUFFER_ENABLE_Msk;
    }
    else
    {
        PAD->PCR[paddr] &= ~PAD_PCR_INPUT_BUFFER_ENABLE_Msk;
    }

    CLOCK_clockDisable(PCLK_PAD);
}

void PAD_setPinPullConfig(uint32_t paddr, PadPullConfig_e config)
{
    ASSERT(paddr < PAD_ADDR_MAX_NUM);

    CLOCK_clockEnable(PCLK_PAD);

    switch(config)
    {
        case PAD_INTERNAL_PULL_UP:
            PAD->PCR[paddr] = (PAD->PCR[paddr] & ~PAD_PCR_PULL_DOWN_ENABLE_Msk) | PAD_PCR_PULL_UP_ENABLE_Msk | PAD_PCR_PULL_SELECT_Msk;
            break;
        case PAD_INTERNAL_PULL_DOWN:
            PAD->PCR[paddr] = (PAD->PCR[paddr] & ~PAD_PCR_PULL_UP_ENABLE_Msk) | PAD_PCR_PULL_DOWN_ENABLE_Msk | PAD_PCR_PULL_SELECT_Msk;
            break;
        case PAD_AUTO_PULL:
            PAD->PCR[paddr] = (PAD->PCR[paddr] & ~PAD_PCR_PULL_SELECT_Msk);
            break;
        default:
            break;
    }

    CLOCK_clockDisable(PCLK_PAD);

}

