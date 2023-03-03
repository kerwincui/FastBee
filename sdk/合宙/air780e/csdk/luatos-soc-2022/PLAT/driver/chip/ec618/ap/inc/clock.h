/****************************************************************************
 *
 * Copy right:   2019-, Copyrigths of AirM2M Ltd.
 * File name:    clock.h
 * Description:  EC618 clock driver header file
 * History:      Rev1.0   2019-02-20
 *
 ****************************************************************************/

#ifndef _CLOCK_EC618_H
#define _CLOCK_EC618_H

#include "ec618.h"
#include "Driver_Common.h"


/**
  \addtogroup clock_interface_gr
  \{
 */

/*******************************************************************************
 * Definitions
 ******************************************************************************/
#ifndef __CLOCK_DECLARATION_DEFINED__
#define __CLOCK_DECLARATION_DEFINED__

#include "gpr_common.h"

typedef enum
{
    /* clock ID with clock source select start */
    CLK_CC          = CONSTRUCT_CLOCK_ID(CLKEN_REG_INDEX_MAX,              0,  0),
    CLK_APB_MP      = CONSTRUCT_CLOCK_ID(CLKEN_REG_INDEX_MAX,              0,  1),
    CLK_APB_XP      = CONSTRUCT_CLOCK_ID(CLKEN_REG_INDEX_MAX,              0,  2),
    CLK_SMP         = CONSTRUCT_CLOCK_ID(CLKEN_REG_INDEX_MAX,              0,  3),
    CLK_SYSTICK     = CONSTRUCT_CLOCK_ID(CLKEN_REG_INDEX_MAX,              0,  4),

    FCLK_UART0      = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_FCLK_EN_REG_INDEX, 0,  5),
    FCLK_UART1      = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_FCLK_EN_REG_INDEX, 1,  6),
    FCLK_UART2      = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_FCLK_EN_REG_INDEX, 2,  7),
    FCLK_SPI0       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_FCLK_EN_REG_INDEX, 3,  8),
    FCLK_SPI1       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_FCLK_EN_REG_INDEX, 4,  9),
    FCLK_I2S0       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_FCLK_EN_REG_INDEX, 5,  10),
    FCLK_I2S1       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_FCLK_EN_REG_INDEX, 6,  11),

    FCLK_WDG        = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_FCLK_EN_REG_INDEX, 0,  12),
    FCLK_TIMER0     = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_FCLK_EN_REG_INDEX, 1,  13),
    FCLK_TIMER1     = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_FCLK_EN_REG_INDEX, 2,  14),
    FCLK_TIMER2     = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_FCLK_EN_REG_INDEX, 3,  15),
    FCLK_TIMER3     = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_FCLK_EN_REG_INDEX, 4,  16),
    FCLK_TIMER4     = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_FCLK_EN_REG_INDEX, 5,  17),
    FCLK_TIMER5     = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_FCLK_EN_REG_INDEX, 6,  18),
    FCLK_I2C0       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_FCLK_EN_REG_INDEX, 7,  19),
    FCLK_I2C1       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_FCLK_EN_REG_INDEX, 8,  20),
    FCLK_USIM0      = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_FCLK_EN_REG_INDEX, 9,  21),
    FCLK_USIM1      = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_FCLK_EN_REG_INDEX, 10, 22),
    FCLK_KPC        = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_FCLK_EN_REG_INDEX, 11, 23),

    CLK_FLASH       = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   9,  24),
    CLK_PSRAM       = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   10, 25),

    CLK_CLKCAL      = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_AP_CLKEN_REG_INDEX,   5,  26),

    /* clock ID with clock source select end */

    /* root clock */
    CLK_MF          = CONSTRUCT_CLOCK_ID(CLKEN_REG_INDEX_MAX,              0,  27),
    CLK_32K         = CONSTRUCT_CLOCK_ID(CLKEN_REG_INDEX_MAX,              0,  28),
    CLK_HF408M      = CONSTRUCT_CLOCK_ID(CLKEN_REG_INDEX_MAX,              0,  29),

    CLK_HF204M      = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   0,  30),
    CLK_HF102M      = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   1,  31),
    CLK_HF51M       = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   2,  32),
    CLK_32K_GATED   = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   3,  33),
    CLK_MF_GATED    = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   4,  34),
    CLK_CC_MP       = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   5,  35),
    CLK_CC_AP       = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   6,  36),
    CLK_CC_CP       = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   7,  37),
    CLK_AON         = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   8,  38),

    CLK_SMP_MP      = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   11, 39),

    MFAB_HCLK       = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   16, 40),
    AFBBR_HCLK      = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   17, 41),

    MSMB_HCLK       = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   19, 42),
    FLASH_HCLK      = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   20, 43),
    PSRAM_HCLK      = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   21, 44),
    ULOG_HCLK       = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   22, 45),
    UTFC_HCLK       = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   23, 46),
    ULDP_HCLK       = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   24, 47),

    USBC_HCLK       = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   26, 48),
    USBC_PMU_HCLK   = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   27, 49),
    USBC_REF_CLK    = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   28, 50),
    USBP_REF_CLK    = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   29, 51),
    USBC_UTMI_CLK   = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_MP_CLKEN_REG_INDEX,   30, 52),


    CLK_DAP_AP      = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_AP_CLKEN_REG_INDEX,   0,  53),
    CLK_TRACE_AP    = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_AP_CLKEN_REG_INDEX,   1,  54),
    CLK_SYSTICK_AP  = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_AP_CLKEN_REG_INDEX,   2,  55),
    CLK_APB_AP      = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_AP_CLKEN_REG_INDEX,   3,  56),
    CLK_SMP_AP      = CONSTRUCT_CLOCK_ID(APB_GPR_TOP_AP_CLKEN_REG_INDEX,   4,  57),

    PCLK_SIPC       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 1,  58),
    PCLK_AON        = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 2,  59),
    PCLK_CPMU       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 3,  60),
    PCLK_PMDIG      = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 4,  61),
    PCLK_RFDIG      = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 5,  62),
    PCLK_PAD        = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 6,  63),
    PCLK_GPIO       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 7,  64),
    PCLK_FUSE       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 8,  65),
    PCLK_TRNG       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 9,  66),
    PCLK_USBP       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 10, 67),
    PCLK_LPUC       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 11, 68),
    PCLK_UART0      = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 12, 69),
    PCLK_UART1      = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 13, 70),
    PCLK_UART2      = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 14, 71),
    PCLK_SPI0       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 15, 72),
    PCLK_SPI1       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 16, 73),
    PCLK_I2S0       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 17, 74),
    PCLK_I2S1       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_MP_PCLK_EN_REG_INDEX, 18, 75),


    PCLK_WDG        = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_PCLK_EN_REG_INDEX, 0,  76),
    PCLK_TIMER0     = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_PCLK_EN_REG_INDEX, 1,  77),
    PCLK_TIMER1     = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_PCLK_EN_REG_INDEX, 2,  78),
    PCLK_TIMER2     = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_PCLK_EN_REG_INDEX, 3,  79),
    PCLK_TIMER3     = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_PCLK_EN_REG_INDEX, 4,  80),
    PCLK_TIMER4     = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_PCLK_EN_REG_INDEX, 5,  81),
    PCLK_TIMER5     = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_PCLK_EN_REG_INDEX, 6,  82),
    PCLK_IPC        = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_PCLK_EN_REG_INDEX, 7,  83),
    PCLK_I2C0       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_PCLK_EN_REG_INDEX, 8,  84),
    PCLK_I2C1       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_PCLK_EN_REG_INDEX, 9,  85),
    PCLK_USIM0      = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_PCLK_EN_REG_INDEX, 10, 86),
    PCLK_USIM1      = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_PCLK_EN_REG_INDEX, 11, 87),
    PCLK_KPC        = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_PCLK_EN_REG_INDEX, 12, 88),
    PCLK_ONEW       = CONSTRUCT_CLOCK_ID(APB_GPR_APB_AP_PCLK_EN_REG_INDEX, 13, 89),


    TOP_PBRG_HCLK   = CONSTRUCT_CLOCK_ID(RMI_GPR_TOP_CLKEN_REG_INDEX,      0,  90),
    TOP_PBRG_PCLK   = CONSTRUCT_CLOCK_ID(RMI_GPR_TOP_CLKEN_REG_INDEX,      1,  91),
    TOP_GPR_PCLK    = CONSTRUCT_CLOCK_ID(RMI_GPR_TOP_CLKEN_REG_INDEX,      2,  92),

    TRACE_CLK       = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    1,  93),
    ETM_HCLK        = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    2,  94),
    ROMTABLE_HCLK   = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    3,  95),
    TPIU_HCLK       = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    4,  96),
    CACHE_HCLK      = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    5,  97),
    FABSUB_HCLK     = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    6,  98),
    SBU_HCLK        = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    7,  99),
    PBRG_HCLK       = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    8,  100),
    SPIS_HCLK       = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    9,  101),
    XIC_RMI_HCLK    = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    10, 102),
    ULOG_RMI_HCLK   = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    11, 103),
    TMU_RMI_HCLK    = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    12, 104),
    SCT_RMI_HCLK    = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    13, 105),

    UTFC_RMI_HCLK   = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    16, 106),
    ULDP_RMI_HCLK   = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    17, 107),
    SCT_HCLK        = CONSTRUCT_CLOCK_ID(RMI_GPR_XPSYS_CLKEN_REG_INDEX,    18, 108),

    INVALID_CLK     = CONSTRUCT_CLOCK_ID(CLKEN_REG_INDEX_MAX,              0,  109)
} ClockId_e;


/** \brief List of all configurable module's functional clock sources */
typedef enum
{
    // top clk sel

    /** Core clock sourced from 26M */
    CLK_CC_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(CLK_CC), 0, CLK_MF),
    /** Core clock sourced from 204M */
    CLK_CC_SEL_204M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(CLK_CC), 1, CLK_HF204M),
    /** Core clock sourced from 102M */
    CLK_CC_SEL_102M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(CLK_CC), 2, CLK_HF102M),
    /** Core clock sourced from 32K  */
    CLK_CC_SEL_32K  = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(CLK_CC), 3, CLK_32K),


    /** APB MP clock sourced from 26M  */
    CLK_APB_MP_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(CLK_APB_MP), 0, CLK_MF),
    /** APB MP clock sourced from 51M  */
    CLK_APB_MP_SEL_51M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(CLK_APB_MP), 1U, CLK_HF51M),

    /** APB XP clock sourced from 26M  */
    CLK_APB_XP_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(CLK_APB_XP), 0, CLK_MF),
    /** APB XP sourced from 51M  */
    CLK_APB_XP_SEL_51M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(CLK_APB_XP), 1U, CLK_HF51M),

    /** Systick clock sourced from 32K  */
    CLK_SYSTICK_SEL_32K = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(CLK_SYSTICK), 0, CLK_32K),
    /** Systick clock sourced from 26M  */
    CLK_SYSTICK_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(CLK_SYSTICK), 1U, CLK_MF),

    // apb mp func clk sel

    /** UART0 clock sourced from 26M  */
    FCLK_UART0_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_UART0), 0, CLK_MF_GATED),
    /** UART0 clock sourced from 51M  */
    FCLK_UART0_SEL_51M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_UART0), 1U, CLK_HF51M),

    /** UART1 clock sourced from 26M  */
    FCLK_UART1_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_UART1), 0, CLK_MF_GATED),
    /** UART1 clock sourced from 51M  */
    FCLK_UART1_SEL_51M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_UART1), 1U, CLK_HF51M),

    /** UART2 clock sourced from 26M  */
    FCLK_UART2_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_UART2), 0, CLK_MF_GATED),
    /** UART2 clock sourced from 51M  */
    FCLK_UART2_SEL_51M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_UART2), 1U, CLK_HF51M),

    /** SPI0 clock sourced from 26M  */
    FCLK_SPI0_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_SPI0), 0, CLK_MF_GATED),
    /** SPI0 clock sourced from 51M  */
    FCLK_SPI0_SEL_51M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_SPI0), 1U, CLK_HF51M),

    /** SPI1 clock sourced from 26M  */
    FCLK_SPI1_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_SPI1), 0, CLK_MF_GATED),
    /** SPI1 clock sourced from 51M  */
    FCLK_SPI1_SEL_51M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_SPI1), 1U, CLK_HF51M),

    /** I2S0 clock sourced from 26M  */
    FCLK_I2S0_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_I2S0), 0, CLK_MF_GATED),
    /** I2S0 clock sourced from 51M  */
    FCLK_I2S0_SEL_51M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_I2S0), 1U, CLK_HF51M),

    /** I2S1 clock sourced from 26M  */
    FCLK_I2S1_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_I2S1), 0, CLK_MF_GATED),
    /** I2S1 clock sourced from 51M  */
    FCLK_I2S1_SEL_51M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_I2S1), 1U, CLK_HF51M),

    // apb ap func clk sel

    /** WDG clock sourced from 32K  */
    FCLK_WDG_SEL_32K = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_WDG), 0, CLK_32K_GATED),
    /** WDG clock sourced from 26M  */
    FCLK_WDG_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_WDG), 1U, CLK_MF_GATED),

    /** TIMER0 clock sourced from 32K  */
    FCLK_TIMER0_SEL_32K = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER0), 0, CLK_32K_GATED),
    /** TIMER0 clock sourced from 26M  */
    FCLK_TIMER0_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER0), 1U, CLK_MF_GATED),

    /** TIMER1 clock sourced from 32K  */
    FCLK_TIMER1_SEL_32K = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER1), 0, CLK_32K_GATED),
    /** TIMER1 clock sourced from 26M  */
    FCLK_TIMER1_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER1), 1U, CLK_MF_GATED),

    /** TIMER2 clock sourced from 32K  */
    FCLK_TIMER2_SEL_32K = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER2), 0, CLK_32K_GATED),
    /** TIMER2 clock sourced from 26M  */
    FCLK_TIMER2_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER2), 1U, CLK_MF_GATED),

    /** TIMER3 clock sourced from 32K  */
    FCLK_TIMER3_SEL_32K = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER3), 0, CLK_32K_GATED),
    /** TIMER3 clock sourced from 26M  */
    FCLK_TIMER3_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER3), 1U, CLK_MF_GATED),

    /** TIMER4 clock sourced from 32K  */
    FCLK_TIMER4_SEL_32K = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER4), 0, CLK_32K_GATED),
    /** TIMER4 clock sourced from 26M  */
    FCLK_TIMER4_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER4), 1U, CLK_MF_GATED),

    /** TIMER5 clock sourced from 32K  */
    FCLK_TIMER5_SEL_32K = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER5), 0, CLK_32K_GATED),
    /** TIMER5 clock sourced from 26M  */
    FCLK_TIMER5_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_TIMER5), 1U, CLK_MF_GATED),

    /** I2C0 clock sourced from 26M  */
    FCLK_I2C0_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_I2C0), 0, CLK_MF_GATED),
    /** I2C0 clock sourced from 51M  */
    FCLK_I2C0_SEL_51M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_I2C0), 1U, CLK_HF51M),

    /** I2C1 clock sourced from 26M  */
    FCLK_I2C1_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_I2C1), 0, CLK_MF_GATED),
    /** I2C1 clock sourced from 51M  */
    FCLK_I2C1_SEL_51M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_I2C1), 1U, CLK_HF51M),

    /** USIM0 clock sourced from 26M  */
    FCLK_USIM0_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_USIM0), 0, CLK_MF_GATED),
    /** USIM0 clock sourced from 51M  */
    FCLK_USIM0_SEL_51M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_USIM0), 1U, CLK_HF51M),

    /** USIM1 clock sourced from 26M  */
    FCLK_USIM1_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_USIM1), 0, CLK_MF_GATED),
    /** USIM1 clock sourced from 51M  */
    FCLK_USIM1_SEL_51M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_USIM1), 1U, CLK_HF51M),

    /** KPC clock sourced from 26M  */
    FCLK_KPC_SEL_32K = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_KPC), 0, CLK_32K_GATED),
    /** KPC clock sourced from 51M  */
    FCLK_KPC_SEL_26M = MAKE_CLOCK_SEL_VALUE(GET_INDEX_FROM_CLOCK_ID(FCLK_KPC), 1U, CLK_MF_GATED),

} ClockSelect_e;


#endif //__CLOCK_DECLARATION_DEFINED__

/*******************************************************************************
 * API
 ******************************************************************************/

#ifdef __cplusplus
 extern "C" {
#endif


/** \name Clock Configuration */
/* \{ */

/**
  \fn    int32_t CLOCK_clockEnable(ClockId_e id)
  \brief Enable clock for selected module
  \param[in] id          clock item to enable
  \return    ARM_DRIVER_OK if the setting is successful
             ARM_DRIVER_ERROR_PARAMETER on parameter check failure(setting is not available for specified clock id)
 */
int32_t CLOCK_clockEnable(ClockId_e id);

/**
  \fn    void CLOCK_clockReset(ClockId_e id)
  \brief Reset clock for selected module
  \param[in] id          clock item to reset
 */
void CLOCK_clockReset(ClockId_e id);

/**
  \fn    void CLOCK_updateClockTreeElement(ClockId_e id, ClockId_e parentId, uint8_t enableCount)
  \brief Update clock tree node item value, interrnal used only
  \param[in] id          clock item to update
  \param[in] parentId    parent clock id
  \param[in] enableCount new enable count
 */
void CLOCK_updateClockTreeElement(ClockId_e id, ClockId_e parentId, uint8_t enableCount);

/**
  \fn    void CLOCK_clockDisable(ClockId_e id)
  \brief Disable clock for selected module
  \param[in] id          clock item to disable
 */
void CLOCK_clockDisable(ClockId_e id);

/**
  \fn    int32_t CLOCK_setClockSrc(ClockId_e id, ClockSelect_e select)
  \brief Set clock source for selected module
  \param[in] id          clock item to set
  \param[in] select      select one of clock sources \ref ClockSelect_e
  \return    ARM_DRIVER_OK if the setting is successful
             ARM_DRIVER_ERROR_PARAMETER on parameter check failure(setting is not available for specified clock id)
             ARM_DRIVER_ERROR if specific clock has been enabled
 */
int32_t CLOCK_setClockSrc(ClockId_e id, ClockSelect_e select);

/**
  \fn    int32_t CLOCK_setClockDiv(ClockId_e id, uint32 div)
  \brief Set clock divider for selected module
  \param[in] id          clock item to set
  \param[in] div         divider value
  \return    ARM_DRIVER_OK if the setting is successful
             ARM_DRIVER_ERROR_PARAMETER on parameter check failure(setting is not available for specified clock id or div value is set to 0)
             ARM_DRIVER_ERROR if specific clock has been enabled
 */
int32_t CLOCK_setClockDiv(ClockId_e id, uint32_t div);

/**
  \fn    uint32_t CLOCK_getClockFreq(ClockId_e id)
  \brief Get clock frequency for selected module
  \param[in] id    clock item to get
  \return    clock frequency in unit of HZ
 */
uint32_t CLOCK_getClockFreq(ClockId_e id);

/**
  \fn    int32_t CLOCK_setFracDivConfig(FracDivConfig_t * config)
  \brief fracdiv clock config
  \param[in] config    pointer to fracdiv setting
  \return    ARM_DRIVER_OK if the setting is successful
             ARM_DRIVER_ERROR_PARAMETER on parameter check failure
 */
int32_t CLOCK_setFracDivConfig(FracDivConfig_t * config);

/**
  \fn    void CLOCK_fracDivOutCLkEnable(FracDivOutClkId_e id)
  \brief fracdiv out clock enable
  \param[in] id    fracdiv out clock id
 */
void CLOCK_fracDivOutCLkEnable(FracDivOutClkId_e id);

/**
  \fn    void CLOCK_fracDivOutClkDisable(FracDivOutClkId_e id)
  \brief fracdiv out clock disable
  \param[in] id    fracdiv out clock id
 */
void CLOCK_fracDivOutClkDisable(FracDivOutClkId_e id);

/**
  \fn    void CLOCK_setFracDivOutClkDiv(FracDivOutClkId_e id, uint8_t div)
  \brief set fracdiv out clock divider
  \param[in] id    fracdiv out clock id
  \param[in] div   divider ratio to set
 */
void CLOCK_setFracDivOutClkDiv(FracDivOutClkId_e id, uint8_t div);

/**
  \fn    void CLOCK_setBclkSrc(BclkId_e id, BclkSrc_e src)
  \brief select bclk source
  \param[in] id    bclk id
  \param[in] src   clock source to set
 */
void CLOCK_setBclkSrc(BclkId_e id, BclkSrc_e src);

/**
  \fn    void CLOCK_setBclkDiv(BclkId_e id, uint8_t div)
  \brief set bclk divider
  \param[in] id    bclk id
  \param[in] div   divider ratio to set
 */
void CLOCK_setBclkDiv(BclkId_e id, uint8_t div);

/**
  \fn    void CLOCK_bclkEnable(BclkId_e id)
  \brief enable bclk
  \param[in] id    bclk id
 */
void CLOCK_bclkEnable(BclkId_e id);


/**
  \fn    void CLOCK_setMclkSrc(MclkId_e id, MclkSrc_e src)
  \brief select mclk source
  \param[in] id    mclk id
  \param[in] src   clock source to set
 */
void CLOCK_setMclkSrc(MclkId_e id, MclkSrc_e src);

/**
  \fn    void CLOCK_mclkEnable(MclkId_e id)
  \brief mclk enable
  \param[in] id    mclk id
 */
void CLOCK_mclkEnable(MclkId_e id);

/**
  \fn    void CLOCK_mclkDisable(MclkId_e id)
  \brief mclk disable
  \param[in] id    mclk id
 */
void CLOCK_mclkDisable(MclkId_e id);

/**
  \fn    void CLOCK_setMclkDiv(MclkId_e id, uint8_t div)
  \brief set mclk divider
  \param[in] id    mclk id
  \param[in] div   divider ratio to set
 */
void CLOCK_setMclkDiv(MclkId_e id, uint8_t div);
/** \} */

/** \name HAL Driver declaration */
/* \{ */

extern int32_t GPR_setClockSrc(ClockId_e id, ClockSelect_e select);
extern int32_t GPR_setClockDiv(ClockId_e id, uint32_t div);
extern void GPR_clockEnable(ClockId_e id);
extern void GPR_clockDisable(ClockId_e id);
extern uint32_t GPR_getClockFreq(ClockId_e id);

extern void GPR_setFracDivConfig(FracDivConfig_t * config);
extern void GPR_fracDivOutCLkEnable(FracDivOutClkId_e id);
extern void GPR_fracDivOutClkDisable(FracDivOutClkId_e id);
extern void GPR_setFracDivOutClkDiv(FracDivOutClkId_e id, uint8_t div);

extern void GPR_setBclkSrc(BclkId_e id, BclkSrc_e src);
extern void GPR_setBclkDiv(BclkId_e id, uint8_t div);
extern void GPR_BclkEnable(BclkId_e id);


extern void GPR_setMclkSrc(MclkId_e id, MclkSrc_e src);
extern void GPR_mclkEnable(MclkId_e id);
extern void GPR_mclkDisable(MclkId_e id);
extern void GPR_setMclkDiv(MclkId_e id, uint8_t div);

extern void GPR_swReset(ClockResetId_e id);
extern void GPR_swResetModule(const ClockResetVector_t *v);
extern void GPR_initialize(void);
extern void GPR_setApbGprAcg( void );
extern void GPR_lockUpActionCtrl(bool enable);
extern uint32_t GPR_getCPLockUpResetCtrl(void);
extern ApRstSource_e GPR_apGetRstSrc(void);
extern CpRstSource_e GPR_cpGetRstSrc(void);
extern void GPR_cpResetCfgSet(bool wdtRstEn, bool sysRstApb, bool lockupRstEn, bool cpAPmuRst);
extern void GPR_setApbGprAcg( void );
extern void GPR_bootSetting( void );
void CLOCK_AssertChkBeforeSlp(void);

/** \} */


#ifdef __cplusplus
}
#endif

/** \}*/

#endif
