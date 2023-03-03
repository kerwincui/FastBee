/****************************************************************************
 *
 * Copy right:   2017-, Copyrigths of AirM2M Ltd.
 * File name:    timer.c
 * Description:  EC618 timer driver source file
 * History:      Rev1.0   2018-07-18
 *
 ****************************************************************************/

#include "timer.h"
#include "clock.h"
#include "slpman.h"
#include DEBUG_LOG_HEADER_FILE

#define EIGEN_TIMER(n)             ((TIMER_TypeDef *) (AP_TIMER0_BASE_ADDR + 0x1000*n))

#ifdef PM_FEATURE_ENABLE

/** \brief Internal used data structure */
typedef struct
{
    bool                            isInited;            /**< Whether timer has been initialized */
    struct
    {
        uint32_t TCTLR;                                  /**< Timer Control Register */
        uint32_t TIVR;                                   /**< Timer Init Value Register */
        uint32_t TMR[3];                                 /**< Timer Match N Register */
    } backupRegisters;                                   /**< Backup registers for low power restore */
} TimerDatabase_t;

static bool   gIsTimerDriverInited = false;

static TimerDatabase_t gTimerDataBase[TIMER_INSTANCE_NUM];

#endif

static ClockId_e gTimerClocks[TIMER_INSTANCE_NUM*2] =   {PCLK_TIMER0, FCLK_TIMER0,
                                                         PCLK_TIMER1, FCLK_TIMER1,
                                                         PCLK_TIMER2, FCLK_TIMER2,
                                                         PCLK_TIMER3, FCLK_TIMER3,
                                                         PCLK_TIMER4, FCLK_TIMER4,
                                                         PCLK_TIMER5, FCLK_TIMER5
                                                        };

#ifdef PM_FEATURE_ENABLE

/**
  \brief Bitmap of TIMER working status,
         when all TIMER instances are not working, we can vote to enter to low power state.
 */
static uint32_t gTimerWorkingStatus;

/**
  \fn        static void TIMER_enterLowPowerStatePrepare(void* pdata, slpManLpState state)
  \brief     Perform necessary preparations before sleep.
             After recovering from SLPMAN_SLEEP1_STATE, TIMER hareware is repowered, we backup
             some registers here first so that we can restore user's configurations after exit.
  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state
 */
static void TIMER_enterLowPowerStatePrepare(void* pdata, slpManLpState state)
{
    uint32_t i;

    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            for(i = 0; i < TIMER_INSTANCE_NUM; i++)
            {
                if(gTimerDataBase[i].isInited == true)
                {
                    gTimerDataBase[i].backupRegisters.TCTLR = EIGEN_TIMER(i)->TCTLR;
                    gTimerDataBase[i].backupRegisters.TIVR = EIGEN_TIMER(i)->TIVR;
                    gTimerDataBase[i].backupRegisters.TMR[0] = EIGEN_TIMER(i)->TMR[0];
                    gTimerDataBase[i].backupRegisters.TMR[1] = EIGEN_TIMER(i)->TMR[1];
                    gTimerDataBase[i].backupRegisters.TMR[2] = EIGEN_TIMER(i)->TMR[2];
                }
            }
            break;
        default:
            break;
    }

}

/**
  \fn        static void TIMER_exitLowPowerStateRestore(void* pdata, slpManLpState state)
  \brief     Restore after exit from sleep.
             After recovering from SLPMAN_SLEEP1_STATE, TIMER hareware is repowered, we restore user's configurations
             by aidding of the stored registers.

  \param[in] pdata pointer to user data, not used now
  \param[in] state low power state

 */
static void TIMER_exitLowPowerStateRestore(void* pdata, slpManLpState state)
{
    uint32_t i;

    switch (state)
    {
        case SLPMAN_SLEEP1_STATE:

            for(i = 0; i < TIMER_INSTANCE_NUM; i++)
            {
                if(gTimerDataBase[i].isInited == true)
                {
                     GPR_clockEnable(gTimerClocks[i*2]);
                     GPR_clockEnable(gTimerClocks[i*2+1]);

                     EIGEN_TIMER(i)->TCTLR = gTimerDataBase[i].backupRegisters.TCTLR;
                     EIGEN_TIMER(i)->TIVR = gTimerDataBase[i].backupRegisters.TIVR;
                     EIGEN_TIMER(i)->TMR[0] = gTimerDataBase[i].backupRegisters.TMR[0];
                     EIGEN_TIMER(i)->TMR[1] = gTimerDataBase[i].backupRegisters.TMR[1];
                     EIGEN_TIMER(i)->TMR[2] = gTimerDataBase[i].backupRegisters.TMR[2];
                }
            }
            break;

        default:
            break;
    }
}
#endif

void TIMER_driverInit(void)
{

#ifdef PM_FEATURE_ENABLE
    uint32_t i;

    if(gIsTimerDriverInited == false)
    {
        for(i = 0; i < TIMER_INSTANCE_NUM; i++)
        {
            gTimerDataBase[i].isInited = false;
        }

        gTimerWorkingStatus = 0;
        slpManRegisterPredefinedBackupCb(SLP_CALLBACK_TIMER_MODULE, TIMER_enterLowPowerStatePrepare, NULL);
        slpManRegisterPredefinedRestoreCb(SLP_CALLBACK_TIMER_MODULE, TIMER_exitLowPowerStateRestore, NULL);

        gIsTimerDriverInited = true;
    }
#endif

}

void TIMER_getDefaultConfig(TimerConfig_t *config)
{
    ASSERT(config);

    config->clockSource = TIMER_INTERNAL_CLOCK;
    config->reloadOption = TIMER_RELOAD_ON_MATCH1;
    config->initValue = 0;
    config->match0 = 0x10000 >> 1U;
    config->match1 = 0x10000;
    config->match2 = 0xFFFFFFFFU;
}

void TIMER_init(uint32_t instance, const TimerConfig_t *config)
{
    ASSERT(instance < TIMER_INSTANCE_NUM);
    ASSERT(config);

    TIMER_driverInit();

#ifdef PM_FEATURE_ENABLE
     if(gTimerDataBase[instance].isInited == false)
     {
#endif

        CLOCK_clockEnable(gTimerClocks[instance*2]);
        CLOCK_clockEnable(gTimerClocks[instance*2+1]);

        /* Stop timer counter */
        EIGEN_TIMER(instance)->TCCR = 0;

        EIGEN_TIMER(instance)->TCTLR = EIGEN_VAL2FLD(TIMER_TCTLR_MODE, config->clockSource) | \
                                       EIGEN_VAL2FLD(TIMER_TCTLR_MCS, config->reloadOption);
        EIGEN_TIMER(instance)->TIVR = config->initValue;
        EIGEN_TIMER(instance)->TMR[0] = config->match0;
        EIGEN_TIMER(instance)->TMR[1] = config->match1;
        EIGEN_TIMER(instance)->TMR[2] = config->match2;

#ifdef PM_FEATURE_ENABLE
        gTimerDataBase[instance].isInited = true;
    }
#endif
}

void TIMER_deInit(uint32_t instance)
{
#ifdef PM_FEATURE_ENABLE
    if(gTimerDataBase[instance].isInited == true)
    {
#endif
        CLOCK_clockDisable(gTimerClocks[instance*2]);
        CLOCK_clockDisable(gTimerClocks[instance*2+1]);

#ifdef PM_FEATURE_ENABLE
        gTimerDataBase[instance].isInited = false;
    }
#endif
}
void TIMER_setMatch(uint32_t instance, TimerMatchSelect_t matchNum, uint32_t matchValue)
{
    ASSERT(instance < TIMER_INSTANCE_NUM);

    EIGEN_TIMER(instance)->TMR[matchNum] = matchValue;
}

void TIMER_setInitValue(uint32_t instance, uint32_t initValue)
{
    ASSERT(instance < TIMER_INSTANCE_NUM);

    EIGEN_TIMER(instance)->TIVR = initValue;
}

void TIMER_setReloadOption(uint32_t instance, TimerReloadOption_t option)
{
    ASSERT(instance < TIMER_INSTANCE_NUM);

    EIGEN_TIMER(instance)->TCTLR = (EIGEN_TIMER(instance)->TCTLR &~ TIMER_TCTLR_MCS_Msk) | EIGEN_VAL2FLD(TIMER_TCTLR_MCS, option);
}

void TIMER_start(uint32_t instance)
{
    ASSERT(instance < TIMER_INSTANCE_NUM);

#ifdef PM_FEATURE_ENABLE
    if(instance != 5)       // timer 5 do not vote sleep
    {
        uint32_t mask = SaveAndSetIRQMask();

        gTimerWorkingStatus |= (1U << instance);
        slpManDrvVoteSleep(SLP_VOTE_TIMER, SLP_ACTIVE_STATE);

        RestoreIRQMask(mask);
    }
#endif
    EIGEN_TIMER(instance)->TCCR = 1U;
}

void TIMER_stop(uint32_t instance)
{
    ASSERT(instance < TIMER_INSTANCE_NUM);

    EIGEN_TIMER(instance)->TCCR = 0;

#ifdef PM_FEATURE_ENABLE
    if(instance != 5)       // timer 5 do not vote sleep
    {
        uint32_t mask = SaveAndSetIRQMask();

        gTimerWorkingStatus &= ~(1U << instance);
        if (gTimerWorkingStatus == 0)
            slpManDrvVoteSleep(SLP_VOTE_TIMER, SLP_SLP1_STATE);

        RestoreIRQMask(mask);
    }
#endif

}

uint32_t TIMER_getCount(uint32_t instance)
{
    ASSERT(instance < TIMER_INSTANCE_NUM);

    EIGEN_TIMER(instance)->TCLR = TIMER_TCLR_LATCH_Msk;

    while((EIGEN_TIMER(instance)->TCLR & TIMER_TCLR_LATCH_Msk) == TIMER_TCLR_LATCH_Msk);

    return EIGEN_TIMER(instance)->TCR;
}

int32_t TIMER_setupPwm(uint32_t instance, const TimerPwmConfig_t *config)
{
    ASSERT(instance < TIMER_INSTANCE_NUM);
    ASSERT(config);

    uint32_t period;

    CLOCK_clockEnable(gTimerClocks[instance*2]);
    CLOCK_clockEnable(gTimerClocks[instance*2+1]);

    if(config->srcClock_HZ == 0 || config->pwmFreq_HZ == 0 || config->srcClock_HZ <= config->pwmFreq_HZ)
        return ARM_DRIVER_ERROR_PARAMETER;

    period = config->srcClock_HZ / config->pwmFreq_HZ;

    /* Set PWM period */
    EIGEN_TIMER(instance)->TMR[1] = period - 1;

    /* Set duty cycle */
    if(config->dutyCyclePercent == 0)
    {
        EIGEN_TIMER(instance)->TMR[0] = period;      // if TMR[0] > TMR[1], PWM output keeps low
    }
    else if(config->dutyCyclePercent == 100)
    {
        EIGEN_TIMER(instance)->TMR[0] = period - 1;  // let TMR[0] == TMR[1]
    }
    else
    {
        /*
            Note the higher pwm frequency is, the lower reslution of dutyCycle we'll get.
            Below calculation may overflow for specific dutyCyclePercent and in such case, TMR[0] > TMR[1], PWM output keeps low
        */
        EIGEN_TIMER(instance)->TMR[0] = ((uint64_t)period) * (100U - config->dutyCyclePercent) / 100U - 1;
    }
    EIGEN_TIMER(instance)->TIVR = 0;

    /* Enable PWM out */
    EIGEN_TIMER(instance)->TCTLR = (EIGEN_TIMER(instance)->TCTLR & ~ TIMER_TCTLR_MCS_Msk) | \
                                   EIGEN_VAL2FLD(TIMER_TCTLR_MCS, 2U) | TIMER_TCTLR_PWMOUT_Msk;

#ifdef PM_FEATURE_ENABLE
    gTimerDataBase[instance].isInited = true;
#endif

    return ARM_DRIVER_OK;

}

void TIMER_updatePwmDutyCycle(uint32_t instance, uint32_t dutyCyclePercent)
{
    ASSERT(instance < TIMER_INSTANCE_NUM);

    if(dutyCyclePercent == 0)
    {
        EIGEN_TIMER(instance)->TMR[0] = EIGEN_TIMER(instance)->TMR[1] + 1;      // if TMR[0] > TMR[1], PWM output keeps low
    }
    else if(dutyCyclePercent >= 100)
    {
        EIGEN_TIMER(instance)->TMR[0] = EIGEN_TIMER(instance)->TMR[1];          // let TMR[0] == TMR[1]
    }
    else
    {
        EIGEN_TIMER(instance)->TMR[0] = ((uint64_t)EIGEN_TIMER(instance)->TMR[1] + 1) * (100U - dutyCyclePercent) / 100U - 1;
    }

}

void TIMER_interruptConfig(uint32_t instance, TimerMatchSelect_t match, TimerInterruptConfig_t config)
{
    ASSERT(instance < TIMER_INSTANCE_NUM);

    uint32_t enableMask, typeMask, registerValue;

    enableMask = 1U << (match + TIMER_TCTLR_IE_0_Pos);
    typeMask = 1U << (match + TIMER_TCTLR_IT_0_Pos);
    registerValue = EIGEN_TIMER(instance)->TCTLR;

    switch(config)
    {
        case TIMER_INTERRUPT_DISABLED:

            registerValue &= ~enableMask;
            EIGEN_TIMER(instance)->TCTLR = registerValue;
            break;

        case TIMER_INTERRUPT_LEVEL:

            registerValue |= enableMask;
            registerValue &= ~typeMask;
            EIGEN_TIMER(instance)->TCTLR = registerValue;
            break;

        case TIMER_INTERRUPT_PULSE:

            registerValue |= enableMask;
            registerValue |= typeMask;
            EIGEN_TIMER(instance)->TCTLR = registerValue;
            break;

        default:
            break;
    }
}

TimerInterruptConfig_t TIMER_getInterruptConfig(uint32_t instance, TimerMatchSelect_t match)
{
    ASSERT(instance < TIMER_INSTANCE_NUM);

    uint32_t enableMask, typeMask, registerValue;

    enableMask = 1U << (match + TIMER_TCTLR_IE_0_Pos);
    typeMask = 1U << (match + TIMER_TCTLR_IT_0_Pos);
    registerValue = EIGEN_TIMER(instance)->TCTLR;

    if ((enableMask & registerValue) == 0)
        return TIMER_INTERRUPT_DISABLED;
    else if ((typeMask & registerValue) == 0)
        return TIMER_INTERRUPT_LEVEL;
    else
        return TIMER_INTERRUPT_PULSE;
}

uint32_t TIMER_getInterruptFlags(uint32_t instance)
{
    ASSERT(instance < TIMER_INSTANCE_NUM);

    return EIGEN_TIMER(instance)->TSR;
}

void TIMER_clearInterruptFlags(uint32_t instance, uint32_t mask)
{
    ASSERT(instance < TIMER_INSTANCE_NUM);

    EIGEN_TIMER(instance)->TSR = mask;
}


static uint8_t gNetLightInstance = 0xff;
void TIMER_netlightEnable(uint8_t instance)        // call by user in bsp_custom.c
{
    gNetLightInstance = instance;
}

/////// Internal use for Netlight Function /////////////////
void TIMER_netlightPWM(uint8_t mode)
{
    extern void delay_us(uint32_t us);
    uint8_t instance = gNetLightInstance;
    static uint8_t curMode;

#ifdef PM_FEATURE_ENABLE
    uint32_t mask;
    ECPLAT_PRINTF(UNILOG_PLA_DRIVER, TIMER_netlightPWM_1, P_SIG, "Netlight mode=%u Instance=%d",mode, instance);
#endif

    if(instance == 0xff)
        return;

    ASSERT(instance < TIMER_INSTANCE_NUM);

    if(curMode == mode)    // do nothing if mode not change
        return;

    EIGEN_TIMER(instance)->TCCR = 0;

    if(mode == 0)
    {
        EIGEN_TIMER(instance)->TMR[0] = 0xFFFFFFFF;
        EIGEN_TIMER(instance)->TMR[1] = 0;      // TMR[0] > TMR[1], PWM output keeps low
        EIGEN_TIMER(instance)->TCCR = 1;
        delay_us(10);
        EIGEN_TIMER(instance)->TCCR = 0;
#ifdef PM_FEATURE_ENABLE
      if(gTimerWorkingStatus & (1U << instance))
        {
            CLOCK_clockDisable(gTimerClocks[instance*2]);
            CLOCK_clockDisable(gTimerClocks[instance*2+1]);
        }
        mask = SaveAndSetIRQMask();
        gTimerWorkingStatus &= ~(1U << instance);
        if (gTimerWorkingStatus == 0)
            slpManDrvVoteSleep(SLP_VOTE_TIMER, SLP_SLP1_STATE);
        RestoreIRQMask(mask);
#endif
        curMode = 0;
        return;
    }

#ifdef PM_FEATURE_ENABLE
    if((gTimerWorkingStatus & (1U << instance)) == 0)
    {
        CLOCK_clockEnable(gTimerClocks[instance*2]);
        CLOCK_clockEnable(gTimerClocks[instance*2+1]);
    }
    mask = SaveAndSetIRQMask();
    gTimerWorkingStatus |= (1U << instance);
    slpManDrvVoteSleep(SLP_VOTE_TIMER, SLP_ACTIVE_STATE);
    RestoreIRQMask(mask);
#endif

    /* Enable PWM out */
    EIGEN_TIMER(instance)->TCTLR = (EIGEN_TIMER(instance)->TCTLR & ~ TIMER_TCTLR_MCS_Msk) | \
                                   EIGEN_VAL2FLD(TIMER_TCTLR_MCS, 2U) | TIMER_TCTLR_PWMOUT_Msk;

    if(mode == 1)       // fast flash:  64ms high and 800ms low
    {
        EIGEN_TIMER(instance)->TMR[0] = 0x13D61FF;

        EIGEN_TIMER(instance)->TMR[1] = 0x156C5FE;

        EIGEN_TIMER(instance)->TCCR = 1;

        curMode = mode;
    }
    else if(mode == 2)  // slow flash:  64ms high and 2000ms low
    {
        EIGEN_TIMER(instance)->TMR[0] = 0x31974FF;

        EIGEN_TIMER(instance)->TMR[1] = 0x332D8FE;

        EIGEN_TIMER(instance)->TCCR = 1;

        curMode = mode;
    }
    else
    {
        ASSERT(0);
    }

}

