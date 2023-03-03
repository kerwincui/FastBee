/****************************************************************************
 *
 * Copy right:   2019-, Copyrigths of AirM2M Ltd.
 * File name:    clock.c
 * Description:  EC618 clock driver source file
 * History:      Rev1.0   2019-02-20
 *
 ****************************************************************************/

#include "clock.h"
#include <assert.h>
#include <string.h>
#include "Driver_Common.h"
#ifdef PM_FEATURE_ENABLE
#include DEBUG_LOG_HEADER_FILE
#endif

extern bool GPR_clockEnableCheck(ClockId_e id);
extern ClockId_e CLOCK_checkClkID(void);


/** \brief support clock driver full feature or not */
#define ENABLE_CLK_TREE_PARENT

/** \brief definition of clk tree element for clock management */
typedef struct _clk_tree_element
{
    uint32_t    enableCount         : 8;      /**< counter of each clk has been enabled */
    uint32_t    parentId            : 17;     /**< id of this clock's parent clk */
    uint32_t    hasExtraDependency  : 1;      /**< whether or not this clock has extra dependent clock */
    uint32_t    canChangeSrcForcely : 1;      /**< whether or not the source of this clock can be changed in enabled state */
} ClkTreeElement_t;

/** \brief clock tree Array */
static ClkTreeElement_t g_clkTreeArray[] =
{

    [GET_INDEX_FROM_CLOCK_ID(CLK_CC)]         = {1, CLK_MF, 0, 1},
    [GET_INDEX_FROM_CLOCK_ID(CLK_APB_MP)]     = {1, CLK_MF, 0, 1},
    [GET_INDEX_FROM_CLOCK_ID(CLK_APB_XP)]     = {1, CLK_MF, 0, 1},
    [GET_INDEX_FROM_CLOCK_ID(CLK_SMP)]        = {1, INVALID_CLK, 0, 1},
    [GET_INDEX_FROM_CLOCK_ID(CLK_SYSTICK)]    = {1, CLK_32K, 0, 1},


    [GET_INDEX_FROM_CLOCK_ID(FCLK_UART0)]     = {0, CLK_MF_GATED, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FCLK_UART1)]     = {0, CLK_MF_GATED, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FCLK_UART2)]     = {0, CLK_MF_GATED, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(FCLK_SPI0)]      = {0, CLK_MF_GATED, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FCLK_SPI1)]      = {0, CLK_MF_GATED, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FCLK_I2S0)]      = {0, CLK_MF_GATED, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FCLK_I2S1)]      = {0, CLK_MF_GATED, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(FCLK_WDG)]       = {0, CLK_32K_GATED, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER0)]    = {0, CLK_32K_GATED, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER1)]    = {0, CLK_32K_GATED, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER2)]    = {0, CLK_32K_GATED, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER3)]    = {0, CLK_32K_GATED, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER4)]    = {0, CLK_32K_GATED, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER5)]    = {0, CLK_32K_GATED, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FCLK_I2C0)]      = {0, CLK_MF_GATED, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(FCLK_I2C1)]      = {0, CLK_MF_GATED, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FCLK_USIM0)]     = {0, CLK_MF_GATED, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FCLK_USIM1)]     = {0, CLK_MF_GATED, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FCLK_KPC)]       = {0, CLK_32K_GATED, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(CLK_FLASH)]      = {1, CLK_MF, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_PSRAM)]      = {0, CLK_MF, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_MF)]         = {1, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_32K)]        = {1, INVALID_CLK, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(CLK_HF408M)]     = {1, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_HF204M)]     = {1, CLK_HF408M, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_HF102M)]     = {0, CLK_HF204M, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_HF51M)]      = {0, CLK_HF102M, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(CLK_32K_GATED)]  = {1, CLK_32K, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_MF_GATED)]   = {1, CLK_MF, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_CC_MP)]      = {1, CLK_CC, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_CC_AP)]      = {1, CLK_CC, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(CLK_CC_CP)]      = {1, CLK_CC, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_AON)]        = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_SMP_MP)]     = {0, CLK_SMP, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(MFAB_HCLK)]      = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(AFBBR_HCLK)]     = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(MSMB_HCLK)]      = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FLASH_HCLK)]     = {0, INVALID_CLK, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(PSRAM_HCLK)]     = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(ULOG_HCLK)]      = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(UTFC_HCLK)]      = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(ULDP_HCLK)]      = {0, INVALID_CLK, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(USBC_HCLK)]      = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(USBC_PMU_HCLK)]  = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(USBC_REF_CLK)]   = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(USBP_REF_CLK)]   = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(USBC_UTMI_CLK)]  = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_DAP_AP)]     = {1, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_TRACE_AP)]   = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_SYSTICK_AP)] = {0, CLK_SYSTICK, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(CLK_APB_AP)]     = {1, CLK_APB_XP, 1, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_SMP_AP)]     = {1, CLK_SMP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CLK_CLKCAL)]     = {0, CLK_MF, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_SIPC)]      = {0, CLK_APB_MP, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(PCLK_AON)]       = {1, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_CPMU)]      = {1, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_PMDIG)]     = {0, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_RFDIG)]     = {0, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_PAD)]       = {0, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_GPIO)]      = {0, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_FUSE)]      = {1, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_TRNG)]      = {0, CLK_APB_MP, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(PCLK_USBP)]      = {0, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_LPUC)]      = {0, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_UART0)]     = {0, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_UART1)]     = {0, CLK_APB_MP, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(PCLK_UART2)]     = {0, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_SPI0)]      = {0, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_SPI1)]      = {0, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_I2S0)]      = {0, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_I2S1)]      = {0, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_WDG)]       = {0, CLK_APB_AP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_TIMER0)]    = {0, CLK_APB_AP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_TIMER1)]    = {0, CLK_APB_AP, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(PCLK_TIMER2)]    = {0, CLK_APB_AP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_TIMER3)]    = {0, CLK_APB_AP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_TIMER4)]    = {0, CLK_APB_AP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_TIMER5)]    = {0, CLK_APB_AP, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(PCLK_IPC)]       = {1, CLK_APB_AP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_I2C0)]      = {0, CLK_APB_AP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_I2C1)]      = {0, CLK_APB_AP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_USIM0)]     = {0, CLK_APB_AP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_USIM1)]     = {0, CLK_APB_AP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_KPC)]       = {0, CLK_APB_AP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(PCLK_ONEW)]      = {0, CLK_APB_AP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(TOP_PBRG_HCLK)]  = {1, CLK_CC_MP, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(TOP_PBRG_PCLK)]  = {1, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(TOP_GPR_PCLK)]   = {1, CLK_APB_MP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(TRACE_CLK)]      = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(ETM_HCLK)]       = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(ROMTABLE_HCLK)]  = {0, INVALID_CLK, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(TPIU_HCLK)]      = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(CACHE_HCLK)]     = {1, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(FABSUB_HCLK)]    = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(SBU_HCLK)]       = {0, INVALID_CLK, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(PBRG_HCLK)]      = {1, CLK_CC_AP, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(SPIS_HCLK)]      = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(XIC_RMI_HCLK)]   = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(ULOG_RMI_HCLK)]  = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(TMU_RMI_HCLK)]   = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(SCT_RMI_HCLK)]   = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(UTFC_RMI_HCLK)]  = {0, INVALID_CLK, 0, 0},
    [GET_INDEX_FROM_CLOCK_ID(ULDP_RMI_HCLK)]  = {0, INVALID_CLK, 0, 0},

    [GET_INDEX_FROM_CLOCK_ID(SCT_HCLK)]       = {0, INVALID_CLK, 0, 0},

};


PLAT_PA_RAMCODE void CLOCK_Trace(ClockId_e id, bool isEnable, void *func)
{
#ifdef PM_FEATURE_ENABLE
    ClockId_e checkId = CLOCK_checkClkID();
    uint32_t indexFromId = GET_INDEX_FROM_CLOCK_ID(id);

    if(id == checkId)
    {
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, CLOCK_Trace_1, P_WARNING, "Clock Trace, id=0x%x isEnable=%d counter=%d, funcPtr=%x", id, isEnable, g_clkTreeArray[indexFromId].enableCount, func);
    }

    if (g_clkTreeArray[indexFromId].enableCount > 128)
    {
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, CLOCK_Trace_2, P_WARNING, "Clock Trace, id=0x%x counter=%d may overflow, funcPtr=%x", id, g_clkTreeArray[indexFromId].enableCount, func);
    }
#endif
}

void CLOCK_AssertChkBeforeSlp(void)
{
#ifdef PM_FEATURE_ENABLE
    if(CLOCK_checkClkID() == INVALID_CLK)
        return;
    uint32_t indexFromId = GET_INDEX_FROM_CLOCK_ID(CLOCK_checkClkID());
    if(g_clkTreeArray[indexFromId].enableCount != 0)
        EC_ASSERT(0, g_clkTreeArray[indexFromId].enableCount, indexFromId, 0);
#endif

}

PLAT_PA_RAMCODE int32_t CLOCK_clockEnable(ClockId_e id)
{

#if defined(ENABLE_CLK_TREE_PARENT)
    int32_t ret;
#endif

    uint32_t mask, indexFromId = GET_INDEX_FROM_CLOCK_ID(id);

    if(indexFromId > GET_INDEX_FROM_CLOCK_ID(INVALID_CLK))
        return ARM_DRIVER_ERROR_PARAMETER;
    else if(indexFromId == GET_INDEX_FROM_CLOCK_ID(INVALID_CLK))
        return ARM_DRIVER_OK;

    mask = SaveAndSetIRQMask();

    CLOCK_Trace(id, true, __GET_RETURN_ADDRESS());

    if(g_clkTreeArray[indexFromId].enableCount++ == 0)
    {
        GPR_clockEnable(id);
        RestoreIRQMask(mask);

#if defined(ENABLE_CLK_TREE_PARENT)
        if(g_clkTreeArray[indexFromId].hasExtraDependency)
        {
            ret = CLOCK_clockEnable(PBRG_HCLK);
            ASSERT(ret == ARM_DRIVER_OK);
        }

        ret = CLOCK_clockEnable((ClockId_e)g_clkTreeArray[indexFromId].parentId);
        ASSERT(ret == ARM_DRIVER_OK);
#endif
    }
    else
    {
        if(GPR_clockEnableCheck(id) == false)
        {
        #ifdef PM_FEATURE_ENABLE
            ECPLAT_PRINTF(UNILOG_PLA_DRIVER, CLOCK_clockEnable_1, P_WARNING, "Clock Enable Failed, id=0x%x counter=%d", id, g_clkTreeArray[indexFromId].enableCount);
        #endif
            ASSERT(0);
        }

        RestoreIRQMask(mask);
    }

    return ARM_DRIVER_OK;
}

PLAT_PA_RAMCODE void CLOCK_clockDisable(ClockId_e id)
{
    uint32_t mask, indexFromId = GET_INDEX_FROM_CLOCK_ID(id);

    if(indexFromId >= GET_INDEX_FROM_CLOCK_ID(INVALID_CLK))
        return;

    mask = SaveAndSetIRQMask();

    CLOCK_Trace(id, false, __GET_RETURN_ADDRESS());

    if(g_clkTreeArray[indexFromId].enableCount == 0)
    {
        RestoreIRQMask(mask);

#ifdef PM_FEATURE_ENABLE
        ECPLAT_PRINTF(UNILOG_PLA_DRIVER, CLOCK_clockDisable_0, P_WARNING, "Clock Disable check failed, id=0x%x", id);
#endif
        ASSERT(0);

        return;
    }

    if(!(--g_clkTreeArray[indexFromId].enableCount))
    {
        GPR_clockDisable(id);

        RestoreIRQMask(mask);

#if defined(ENABLE_CLK_TREE_PARENT)
        if(g_clkTreeArray[indexFromId].hasExtraDependency)
        {
            CLOCK_clockDisable(PBRG_HCLK);
        }
        CLOCK_clockDisable((ClockId_e)g_clkTreeArray[indexFromId].parentId);
#endif

    }
    else
    {
        RestoreIRQMask(mask);
    }
}

PLAT_PA_RAMCODE void CLOCK_clockReset(ClockId_e id)
{
    uint32_t    mask, indexFromId = GET_INDEX_FROM_CLOCK_ID(id);
    uint8_t     count = 0;
    if(indexFromId >= GET_INDEX_FROM_CLOCK_ID(INVALID_CLK))
        return;

    mask = SaveAndSetIRQMask();

    count = g_clkTreeArray[indexFromId].enableCount;

    g_clkTreeArray[indexFromId].enableCount = 0;

    GPR_clockDisable(id);

    RestoreIRQMask(mask);

    /* here, maybe not right */
#if defined(ENABLE_CLK_TREE_PARENT)
    if(count > 0)
    {
        CLOCK_clockDisable((ClockId_e)g_clkTreeArray[indexFromId].parentId);
    }
#endif

    return;
}

int32_t CLOCK_setClockSrc(ClockId_e id, ClockSelect_e select)
{
    int32_t ret, mask, indexFromId = GET_INDEX_FROM_CLOCK_ID(id);

    if(indexFromId >= GET_INDEX_FROM_CLOCK_ID(INVALID_CLK))
        return ARM_DRIVER_ERROR_PARAMETER;

    mask = SaveAndSetIRQMask();

    if((g_clkTreeArray[indexFromId].enableCount == 0) || (g_clkTreeArray[indexFromId].canChangeSrcForcely == 1))
    {
        ret = GPR_setClockSrc(id, select);
        if(ret == ARM_DRIVER_OK)
        {
            g_clkTreeArray[indexFromId].parentId = (ClockId_e)(GET_PARENTCLOCKID_FROM_CLOCK_SEL_VALUE(select));
        }

        RestoreIRQMask(mask);

        return ret;
    }

    RestoreIRQMask(mask);

    return ARM_DRIVER_ERROR;
}

int32_t CLOCK_setClockDiv(ClockId_e id, uint32_t div)
{
    int32_t mask, indexFromId = GET_INDEX_FROM_CLOCK_ID(id);

    if(indexFromId >= GET_INDEX_FROM_CLOCK_ID(INVALID_CLK))
        return ARM_DRIVER_ERROR_PARAMETER;

    mask = SaveAndSetIRQMask();

    if(g_clkTreeArray[indexFromId].enableCount == 0)
    {
        RestoreIRQMask(mask);
        return GPR_setClockDiv(id, div);
    }

    RestoreIRQMask(mask);

    return ARM_DRIVER_ERROR;

}

uint32_t CLOCK_getClockFreq(ClockId_e id)
{
    return GPR_getClockFreq(id);
}

int32_t CLOCK_setFracDivConfig(FracDivConfig_t * config)
{
    if(config == NULL)
    {
        return ARM_DRIVER_ERROR_PARAMETER;
    }
    else
    {
        if((config->fracDiv0DivRatioInteger == 256) && (config->fracDiv0DivRatioFrac != 0))
        {
            return ARM_DRIVER_ERROR_PARAMETER;
        }

        if((config->fracDiv1DivRatioInteger == 256) && (config->fracDiv1DivRatioFrac != 0))
        {
            return ARM_DRIVER_ERROR_PARAMETER;
        }

        GPR_setFracDivConfig(config);

        return ARM_DRIVER_OK;
    }

}

void CLOCK_bclkEnable(BclkId_e id)
{
    GPR_BclkEnable(id);
}


void CLOCK_fracDivOutCLkEnable(FracDivOutClkId_e id)
{
    GPR_fracDivOutCLkEnable(id);
}

void CLOCK_fracDivOutClkDisable(FracDivOutClkId_e id)
{
    GPR_fracDivOutClkDisable(id);
}

void CLOCK_setFracDivOutClkDiv(FracDivOutClkId_e id, uint8_t div)
{
    GPR_setFracDivOutClkDiv(id, div);
}

void CLOCK_setBclkSrc(BclkId_e id, BclkSrc_e src)
{
    GPR_setBclkSrc(id, src);
}

void CLOCK_setBclkDiv(BclkId_e id, uint8_t div)
{
    GPR_setBclkDiv(id, div);
}

void CLOCK_setMclkSrc(MclkId_e id, MclkSrc_e src)
{
    GPR_setMclkSrc(id, src);
}

void CLOCK_mclkEnable(MclkId_e id)
{
    GPR_mclkEnable(id);
}

void CLOCK_mclkDisable(MclkId_e id)
{
    GPR_mclkDisable(id);
}

void CLOCK_setMclkDiv(MclkId_e id, uint8_t div)
{
    GPR_setMclkDiv(id, div);
}

void CLOCK_updateClockTreeElement(ClockId_e id, ClockId_e parentId, uint8_t enableCount)
{
    int32_t mask, indexFromId = GET_INDEX_FROM_CLOCK_ID(id);

    if(indexFromId >= GET_INDEX_FROM_CLOCK_ID(INVALID_CLK))
        return;

    mask = SaveAndSetIRQMask();

    g_clkTreeArray[indexFromId].parentId = parentId;
    g_clkTreeArray[indexFromId].enableCount = enableCount;

    RestoreIRQMask(mask);
}

