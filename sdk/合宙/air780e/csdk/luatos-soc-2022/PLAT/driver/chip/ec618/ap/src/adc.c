/****************************************************************************
 *
 * Copy right:   2019-, Copyrigths of AirM2M Ltd.
 * File name:    adc.c
 * Description:  EC618 adc driver source file
 * History:
 *
 ****************************************************************************/

#include "adc.h"
#include "ic.h"
#include "slpman.h"
#include "ec618.h"
#include "alarm.h"

#define LDO_AIO_CTRL_REG_ADDR           (0x4D020180)

#define ADC_ENABLE()                    do                                                               \
                                        {                                                                \
                                            ADC->CTRL |= ADC_CTRL_LDO_EN_Msk;                            \
                                            *(uint32_t*)(LDO_AIO_CTRL_REG_ADDR) = 1;                     \
                                            while((*(uint32_t*)(LDO_AIO_CTRL_REG_ADDR)) == 0);           \
                                        } while(0)

#define ADC_DISABLE()                   do                                                               \
                                        {                                                                \
                                            ADC->CTRL &= ~ADC_CTRL_LDO_EN_Msk;                           \
                                            *(uint32_t*)(LDO_AIO_CTRL_REG_ADDR) = 0;                     \
                                            while((*(uint32_t*)(LDO_AIO_CTRL_REG_ADDR)) == 1);           \
                                        } while(0)

#define ADC_CHANNEL_NUMBER              (6)

#ifdef PM_FEATURE_ENABLE
#define  LOCK_SLEEP()                   do                                                                  \
                                        {                                                                   \
                                            slpManDrvVoteSleep(SLP_VOTE_ADC, SLP_ACTIVE_STATE);             \
                                        }                                                                   \
                                        while(0)

#define  UNLOCK_SLEEP()                 do                                                                  \
                                        {                                                                   \
                                             slpManDrvVoteSleep(SLP_VOTE_ADC, SLP_SLP1_STATE);              \
                                        }                                                                   \
                                        while(0)
#endif

#define ADC_DEFAULT_CLOCK_DIVIDER        (ADC_CLOCK_DIV_8)

#define ADC_CHANNEL_ENABLE_BIT_POSITION  (ADC_AIOCFG_THM_EN_Pos)

/**
    \brief size of ADC request queue, value shall be integer power of 2 for fast calcualtion of MOD.
    \note The valid number of requests is (this_macro_value - 1)
 */
#define ADC_REQUEST_QUEUE_SIZE          (8)
#define ADC_REQUEST_QUEUE_SIZE_MASK     (ADC_REQUEST_QUEUE_SIZE - 1)

/**
   \brief ADC conversion request queue typedef
 */
typedef struct
{
    uint32_t requestArray[ADC_REQUEST_QUEUE_SIZE];
    uint32_t head;
    uint32_t tail;
} AdcReqeustQueue_t;

static AdcReqeustQueue_t gAdcRequestqueue;

/**
   \brief variable for keeping track the index of current request bitmap, see below bitmap layout
 */
static volatile uint32_t gCurrentRequestIndex;

/** \brief Internal used data structure */
typedef struct
{
    struct
    {
        uint32_t AIOCFG;                                           /**< AIO configuration Register */
        uint32_t CFG;                                              /**< ADC configuration Register */
    } configRegisters;

    adcCallback_t                  eventCallback;                 /**< Callback function passed in by application */
} AdcChannelDatabase_t;

/**
 ****************************** Bitmap layout *****************************
 *
 *      18      17     15   14     12  11       9  8        6  5        3   2       0
 *+-----------+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
 *| VREF OUT  |  CH AIO1  |  CH AIO2  |  CH AIO3  |  CH AIO4  |  CH Vbat  | CH thermal|
 *+-----------+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
 *                                                                        /           \
 *                                                                       /             \
 *                                                                      /               \
 *                                                                      |APP | PLAT | PHY|
 */
#define CHANNEL_ID_TO_INDEX(channel, userID)  ((userID & 0x3U) + (channel & 0x7U) * 3U)

#define ADC_MAX_LOGIC_CHANNELS           (ADC_CHANNEL_NUMBER * ADC_USER_MAX)

/** \brief Internal used data structure */
typedef struct
{
    uint32_t channelConfigValidBitMap;                                           /**< Bitmap of channel configuration valid flag */
    AdcChannelDatabase_t channelDataBase[ADC_MAX_LOGIC_CHANNELS];              /**< Array of channel database, each element represents one configuration */
} AdcDatabase_t;

static AdcDatabase_t g_adcDataBase = {0};
void delay_us(uint32_t us);

static void ADC_requestQueueInit(void)
{
    gAdcRequestqueue.head = 0;
    gAdcRequestqueue.tail = 0;
    gCurrentRequestIndex = ADC_MAX_LOGIC_CHANNELS;
}

// no need to perform atomic access since this function is called only in ISR
static int32_t ADC_requestQueueRead(uint32_t *request)
{
    if(gAdcRequestqueue.tail  == gAdcRequestqueue.head)
    {
        // queue is empty
        return -1;
    }

    *request = gAdcRequestqueue.requestArray[gAdcRequestqueue.head];
    gAdcRequestqueue.head = (gAdcRequestqueue.head + 1) & ADC_REQUEST_QUEUE_SIZE_MASK;

    return 0;

}

static int32_t ADC_requestQueueWrite(uint32_t *request)
{
    uint32_t mask;

    mask = SaveAndSetIRQMask();
    if(((gAdcRequestqueue.tail + 1) & ADC_REQUEST_QUEUE_SIZE_MASK) == gAdcRequestqueue.head)
    {
        // queue is full
        RestoreIRQMask(mask);
        return -1;
    }

    gAdcRequestqueue.requestArray[gAdcRequestqueue.tail] = *request;
    gAdcRequestqueue.tail = (gAdcRequestqueue.tail + 1) & ADC_REQUEST_QUEUE_SIZE_MASK;

    RestoreIRQMask(mask);

    return 0;
}

static void ADC_loadConfigAndStartConversion(uint32_t requestIndex)
{
    uint32_t aiocfg;
    // clear status first
    // LDO has been enabled during initialization phase, here we shall keep this bit set
    ADC->CTRL = ADC_CTRL_LDO_EN_Msk | ADC_CTRL_EN_Msk;

    // Protect VREF2AIO1 control bit, take care not to overwrite!!!
    aiocfg = (ADC->AIOCFG & ADC_AIOCFG_VREF2AIO1_EN_Msk) | g_adcDataBase.channelDataBase[requestIndex].configRegisters.AIOCFG;

#ifdef PM_FEATURE_ENABLE
    // thermmal comparator close when sample thm channel
    if(aiocfg & ADC_AIOCFG_THM_EN_Msk)
    {
        alarmThmDisableInAdc();
    }
#endif
    // Protect VREF2AIO1 control bit, take care not to overwrite!!!
    ADC->AIOCFG = aiocfg;
    ADC->CFG = g_adcDataBase.channelDataBase[requestIndex].configRegisters.CFG;

#ifdef PM_FEATURE_ENABLE
    // thermal channel closed
    if((ADC->AIOCFG & ADC_AIOCFG_THM_EN_Msk) == 0)
    {
        if(alarmThmEnableInAdc() == false)
        {
            delay_us(10);
        }
    }
    else
#endif
        delay_us(10);
    
    // start conversion
    ADC->CTRL = (ADC_CTRL_LDO_EN_Msk | ADC_CTRL_EN_Msk | ADC_CTRL_RSTN_Msk);
}


static void ADC_interruptHandler(void)
{
    uint32_t requestIndex;

    int32_t ret;

    ADC->AIOCFG &= ~(ADC_AIOCFG_THM_EN_Msk | ADC_AIOCFG_BATSENS_EN_Msk | ADC_AIOCFG_AIO4_EN_Msk |
                      ADC_AIOCFG_AIO3_EN_Msk | ADC_AIOCFG_AIO2_EN_Msk | ADC_AIOCFG_AIO1_EN_Msk |
                      ADC_AIOCFG_AIO4_NO_DIVR_EN_Msk | ADC_AIOCFG_AIO3_NO_DIVR_EN_Msk |
                      ADC_AIOCFG_AIO2_NO_DIVR_EN_Msk | ADC_AIOCFG_AIO1_NO_DIVR_EN_Msk);

    if(g_adcDataBase.channelDataBase[gCurrentRequestIndex].eventCallback != NULL)
    {
        g_adcDataBase.channelDataBase[gCurrentRequestIndex].eventCallback(ADC->RESULT);
    }

    // Shall check config validation here since config could be changed in user callback(Deinit is called)
    /*
           R1 R2 R1 (3 request at once)                   R1 deInit             R2 deInit (validBitMap change to 0 and ADC is disabled)
      APP ------------------------------------\       /--------------\       /------------\
                                              |       |              |       |            x
                                              v       |              v       |            x
                                              ---------              ---------            xxxxxxxxxxxxxxxxxxxxxxxxxxxx
    ADC ISR                                      R1                      R2                R1 is still in queue, stuck here(interrupt never occurs)
    */


    if(g_adcDataBase.channelConfigValidBitMap != 0)
    {
        ret = ADC_requestQueueRead(&requestIndex);

        // Start next round conversion
        if(ret == 0)
        {
            // there is pending request
            gCurrentRequestIndex = requestIndex;

            ADC_loadConfigAndStartConversion(gCurrentRequestIndex);
        }
        else
        {
            gCurrentRequestIndex = ADC_MAX_LOGIC_CHANNELS;
#ifdef PM_FEATURE_ENABLE
            alarmThmEnableInAdc();
            UNLOCK_SLEEP();
#endif
        }

    }
    else
    {
        ADC_requestQueueInit();
#ifdef PM_FEATURE_ENABLE
        alarmThmEnableInAdc();
        UNLOCK_SLEEP();
#endif
    }

}

void ADC_getDefaultConfig(AdcConfig_t *config)
{
    ASSERT(config);

    config->clockDivider = ADC_DEFAULT_CLOCK_DIVIDER;
    config->channelConfig.aioResDiv = ADC_AIO_RESDIV_BYPASS;
}

int32_t ADC_channelInit(AdcChannel_e channel, AdcUser_t userID, const AdcConfig_t *config, adcCallback_t callback)
{
    uint32_t mask, configValue, requestIndex;

    configValue = 0;

    requestIndex = CHANNEL_ID_TO_INDEX(channel, userID);

    if(requestIndex >= ADC_MAX_LOGIC_CHANNELS)
    {
        return -1;
    }

    mask = SaveAndSetIRQMask();

    // AIO1 conflict check
    if((channel == ADC_CHANNEL_AIO1) && ((g_adcDataBase.channelConfigValidBitMap & (1 << ADC_MAX_LOGIC_CHANNELS)) != 0))
    {
        RestoreIRQMask(mask);
        return -2;
    }

    // First Initialization
    if(g_adcDataBase.channelConfigValidBitMap == 0)
    {
        // enable ADC
        ADC_ENABLE();
        XIC_SetVector(PXIC1_AUXADC_IRQn, ADC_interruptHandler);
        XIC_EnableIRQ(PXIC1_AUXADC_IRQn);
        ADC_requestQueueInit();
    }
    g_adcDataBase.channelConfigValidBitMap |= ( 1 << requestIndex);
    RestoreIRQMask(mask);

    configValue |= ( EIGEN_VAL2FLD(ADC_CFG_WAIT_CTRL, 1) | \
                     EIGEN_VAL2FLD(ADC_CFG_OFFSET_CTRL, 5) | \
                     EIGEN_VAL2FLD(ADC_CFG_SAMPLE_AVG, 0) | \
                     EIGEN_VAL2FLD(ADC_CFG_CLKIN_DIV, config ? config->clockDivider : ADC_DEFAULT_CLOCK_DIVIDER) | \
                     EIGEN_VAL2FLD(ADC_CFG_VREF_BS, 1) | \
                     EIGEN_VAL2FLD(ADC_CFG_VREF_SEL, 4) | \
                     EIGEN_VAL2FLD(ADC_CFG_LDO_SEL, 4) | \
                     EIGEN_VAL2FLD(ADC_CFG_IBIAS_SEL, 1)
                );
    g_adcDataBase.channelDataBase[requestIndex].configRegisters.CFG = configValue;

    configValue = 0;

    switch(channel)
    {
        case ADC_CHANNEL_THERMAL:
            configValue = 1 << (channel + ADC_CHANNEL_ENABLE_BIT_POSITION) | EIGEN_VAL2FLD(ADC_AIOCFG_THM_SEL, 2);
            break;

        case ADC_CHANNEL_VBAT:
            configValue = (1 << (channel + ADC_CHANNEL_ENABLE_BIT_POSITION)) | EIGEN_VAL2FLD(ADC_AIOCFG_VBATSEN_RDIV, config->channelConfig.vbatResDiv);
            break;

        case ADC_CHANNEL_AIO1:
        case ADC_CHANNEL_AIO2:
        case ADC_CHANNEL_AIO3:
        case ADC_CHANNEL_AIO4:

            if(config->channelConfig.aioResDiv == ADC_AIO_RESDIV_BYPASS)
            {
               configValue = 1 << (channel + ADC_CHANNEL_ENABLE_BIT_POSITION + 4);
            }
            else if(config->channelConfig.aioResDiv < ADC_AIO_RESDIV_RATIO_8OVER16)
            {
               configValue = (1 << (channel + ADC_CHANNEL_ENABLE_BIT_POSITION)) | ADC_AIOCFG_RDIV_BYP_Msk | EIGEN_VAL2FLD(ADC_AIOCFG_RDIV, config->channelConfig.aioResDiv);
            }
            else
            {
               configValue = (1 << (channel + ADC_CHANNEL_ENABLE_BIT_POSITION)) | (EIGEN_VAL2FLD(ADC_AIOCFG_RDIV, (config->channelConfig.aioResDiv - ADC_AIO_RESDIV_RATIO_8OVER16)));
            }
            break;
        default:
            break;
    }

    g_adcDataBase.channelDataBase[requestIndex].configRegisters.AIOCFG = configValue;
    g_adcDataBase.channelDataBase[requestIndex].eventCallback = callback;

    return 0;
}

void ADC_channelDeInit(AdcChannel_e channel, AdcUser_t userID)
{
    uint32_t mask = SaveAndSetIRQMask();

    g_adcDataBase.channelConfigValidBitMap &= ~(1 << CHANNEL_ID_TO_INDEX(channel, userID));

    if(g_adcDataBase.channelConfigValidBitMap == 0)
    {
        // diable ADC
        ADC->CTRL = ADC->CTRL & ADC_CTRL_LDO_EN_Msk;
        // disable clock
        ADC_DISABLE();
        XIC_DisableIRQ(PXIC1_AUXADC_IRQn);
    }

    RestoreIRQMask(mask);
}

int32_t ADC_startConversion(AdcChannel_e channel, AdcUser_t userID)
{
    uint32_t mask, requestIndex;
    int32_t ret;

    requestIndex = CHANNEL_ID_TO_INDEX(channel, userID);

    ASSERT(requestIndex < ADC_MAX_LOGIC_CHANNELS);

    mask = SaveAndSetIRQMask();

    // validation check
    if((g_adcDataBase.channelConfigValidBitMap & (1 << requestIndex)) == 0)
    {
        RestoreIRQMask(mask);
        return -2;
    }

    // A conversion is ongoing, pending the request
    if(gCurrentRequestIndex != ADC_MAX_LOGIC_CHANNELS)
    {
        RestoreIRQMask(mask);

        ret = ADC_requestQueueWrite(&requestIndex);

        if(ret != 0)
        {
            // request queue is full
            return ret;
        }
    }
    else
    {
        gCurrentRequestIndex = requestIndex;
        ADC_loadConfigAndStartConversion(gCurrentRequestIndex);
        RestoreIRQMask(mask);

#ifdef PM_FEATURE_ENABLE
        LOCK_SLEEP();
#endif

    }

    return 0;

}

int32_t ADC_enableVrefOutput(void)
{
    uint32_t mask = SaveAndSetIRQMask();

    // AIO1 conflict check
    if((g_adcDataBase.channelConfigValidBitMap & (0x7 << (ADC_CHANNEL_AIO1*3U))) != 0)
    {
        RestoreIRQMask(mask);
        return -2;
    }

    // First Initialization
    if(g_adcDataBase.channelConfigValidBitMap == 0)
    {
        // enable ADC
        ADC_ENABLE();
        XIC_SetVector(PXIC1_AUXADC_IRQn, ADC_interruptHandler);
        XIC_EnableIRQ(PXIC1_AUXADC_IRQn);
        ADC_requestQueueInit();
    }
    ADC->AIOCFG |= ADC_AIOCFG_VREF2AIO1_EN_Msk;
    g_adcDataBase.channelConfigValidBitMap |= ( 1 << ADC_MAX_LOGIC_CHANNELS);

    RestoreIRQMask(mask);

    return 0;
}

void ADC_disableVrefOutput(void)
{
    uint32_t mask = SaveAndSetIRQMask();

    g_adcDataBase.channelConfigValidBitMap &= ~(1 << ADC_MAX_LOGIC_CHANNELS);

    ADC->AIOCFG &= ~ADC_AIOCFG_VREF2AIO1_EN_Msk;

    if(g_adcDataBase.channelConfigValidBitMap == 0)
    {
        // diable ADC
        ADC->CTRL = ADC->CTRL & ADC_CTRL_LDO_EN_Msk;
        // disable clock
        ADC_DISABLE();
        XIC_DisableIRQ(PXIC1_AUXADC_IRQn);
    }

    RestoreIRQMask(mask);

}


